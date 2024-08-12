public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart) 
{

	if ( PlayerVar [ damagedid ] [ E_PLAYER_ADMIN_DUTY ] ) 
	{
		// Stops on duty admins being tasered etc
		return true;
	}

	if ( PlayerVar [ damagedid ] [ E_PLAYER_INJUREDMODE ] ) {

		// If cooldown has passed...
		if ( ! PlayerVar [ damagedid ] [ E_PLAYER_INJURED_EXECUTE_CD ]  ) {
			PlayerVar [ damagedid ] [ E_PLAYER_INJURY_TICK ] = 0 ;

			new gun_name [ 32 ] ;
			new gunid = GetPlayerCustomWeapon(playerid) ;

			Weapon_GetGunName ( gunid, gun_name, sizeof ( gun_name ) ) ;

			if ( ! PlayerVar [ damagedid ] [ E_PLAYER_EXECUTE_MSG ] ) {

            	SendAdminMessage(sprintf("[EXECUTION] (%d) %s has executed (%d) %s with a (%d) %s.",
            		playerid, ReturnMixedName ( playerid), damagedid, ReturnMixedName ( damagedid ), gunid, gun_name ), COLOR_ANTICHEAT) ;

            	PlayerVar [ damagedid ] [ E_PLAYER_EXECUTE_MSG ] = true ;
            }
		}

		else if (  PlayerVar [ damagedid ] [ E_PLAYER_INJURED_EXECUTE_CD ]  ) {
			// commented to stop spam
			//SendClientMessage(playerid, -1, "This player recently got killed. You can't execute them yet." ) ;
		}

		SetCharacterHealth ( damagedid, 5.0 ) ;
	}

	// Check for player being knifed! Let OnTakeDamage handle the syncing!

	if ( WEAPON_KNIFE == weaponid ) {
		new idx = GetPlayerCustomWeapon(playerid) ;

		if ( idx != -1 || GetPlayerWeapon ( playerid ) == Weapon [ idx ] [ E_WEAPON_GUNID ] ) {

			if ( Weapon [ idx ] [ E_WEAPON_GUNID ] == WEAPON_KNIFE ) {

				KnifeSync_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid) ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] && weaponid == WEAPON_SILENCED ) {
		Tazer_OnPlayerGiveDamage(playerid, damagedid, weaponid ) ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] && weaponid == WEAPON_SHOTGUN  ) {
		Beanbag_OnPlayerGiveDamage(playerid, damagedid, weaponid ) ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_TACKLE_ACTIVE ] && weaponid == WEAPON_UNARMED) 
	{
		Tackle_OnPlayerGiveDamage(playerid, damagedid, weaponid);
	}

	return true ;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) {
	new idx = GetPlayerCustomWeapon(issuerid), string [ 128 ] ;

	if ( issuerid == INVALID_PLAYER_ID ) {

		new Float:HP;
		GetPlayerHealth(playerid, HP);
		
		if(HP < 100.0)
		{
			HP = HP + amount;
			
			SetPlayerHealth(playerid, HP);
			
			if(HP > 100.0) { 
				SetPlayerHealth(playerid, 100.0);
			}

			SetPlayerHealth ( playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;
		}

    	return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_ADMIN_DUTY ] ) {

		SetPlayerHealth ( playerid, 100.0 ) ;
		return true ;
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		new vehmodel = GetVehicleModel(GetPlayerVehicleID(playerid));
		if (vehmodel == 601 || vehmodel == 528 || vehmodel == 432)
		{
			// SWAT VAN, RHINO, or SWAT TRUCK (no damage to players inside)
			new Float:HP;
			GetPlayerHealth(playerid, HP);
			SetPlayerHealth(playerid, HP) ;
			return true ;
		}
	}

	if (!IsPlayerLogged(issuerid) || !IsPlayerPlaying(issuerid))
	{
		format(string, sizeof(string), "[AntiCheat]: Kicked (%d) %s for damaging (%d) %s while not logged in!", issuerid, ReturnMixedName(issuerid), playerid, ReturnMixedName(playerid), weaponid );
	    SendAdminMessage(string, COLOR_ANTICHEAT);
		Kick(issuerid);
		return true;
	}
	
	if ( !CanPlayerUseGuns(issuerid, 8, weaponid) ) {
		if ( weaponid != 0 && weaponid != 49 && weaponid != 41 && weaponid != 50 ) {

			if ( issuerid == INVALID_PLAYER_ID ) {

				return true ;
			}

	        string [ 0 ] = EOS ;
	        format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s damaged (%d) %s with a weapon (%d) while unverified!", issuerid, ReturnMixedName ( issuerid ), playerid, ReturnMixedName(playerid), weaponid ) ;
	    
	        SendAdminMessage(string, COLOR_ANTICHEAT) ;

	        SetCharacterHealth(playerid, GetCharacterHealth ( playerid ));

	        if ( ! PlayerVar [ issuerid ] [ E_PLAYER_AC_MITIGATE_TICK ] ) {
	       	 	PlayerVar [ issuerid ] [ E_PLAYER_AC_MITIGATE_UNIX ] = gettime() + 60 ;
	       	}

			if ( PlayerVar [ issuerid ] [ E_PLAYER_AC_MITIGATE_UNIX ] > gettime() ) {

		        if ( ++ PlayerVar [ issuerid ] [ E_PLAYER_AC_MITIGATE_TICK ] >= 25 ) {

					// Player has tried to do damage using a spoofed gun 25 times within 60 seconds!
		            // Fuck them up!

		            new reason [ 64 ] ;

		            new hours = 99999; // 10 years
		            new secs = hours * 3600 ;
		            new unbants = gettime() + secs;

		            format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s is suspected of weapon hacks. Banning them.", issuerid, ReturnMixedName ( issuerid ) ) ;
		            SendAdminMessage(string, COLOR_ANTICHEAT) ;

		            ProxDetectorEx ( issuerid, 45.0, COLOR_ORANGE, "[Anticheat]:", sprintf("[AntiCheat]: (%d) %s has been banned for suspected weapon hacks.", issuerid, ReturnMixedName ( issuerid )));

		            format ( reason, sizeof ( reason ), "Anticheat Detection: Suspected Weapon Hacks" ) ;
		            SetAdminRecord ( Account [ issuerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_BAN, reason, -1, ReturnDateTime () ) ;
		            
		            mysql_format(mysql, string, sizeof(string), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
		            Account [ issuerid ] [ E_PLAYER_ACCOUNT_ID ], Account [ issuerid ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( issuerid ), "Anticheat", reason, gettime(), unbants);
		            mysql_tquery(mysql, string);

		            format ( string, sizeof ( string ),"banip %s", ReturnIP ( issuerid ));
		            SendRconCommand(string);

		            KickPlayer ( issuerid ) ;      

		            PlayerVar [ issuerid ] [ E_PLAYER_AC_MITIGATE_TICK ] = 0 ; 
		            PlayerVar [ issuerid ] [ E_PLAYER_AC_MITIGATE_UNIX ] = gettime();
		        }
		    }

			return true ;
		}
	}

 	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 	////////////////////////////////////// START ANTICHEAT PATCH AGAINST HACKED WEAPON DAMAGE //////////////////////////////////
 	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	if ( idx == -1 || GetPlayerWeapon ( issuerid ) != Weapon [ idx ] [ E_WEAPON_GUNID ] ) {

        string [ 0 ] = EOS ;
        format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s used a weapon they do NOT HAVE!! Mitigating damage! (SPECTATE!!!)", issuerid, ReturnMixedName ( issuerid )  ) ;
    
        SendAdminMessage(string, COLOR_ANTICHEAT) ;
        SetCharacterHealth(playerid, GetCharacterHealth ( playerid ));

        PlayerVar [ issuerid ] [ E_PLAYER_SPOOFED_GUN_AC_WARNING ] ++ ;

		return true ;
    }

    switch ( weaponid ) {
    	case 42, 49, 50, 51, 53, 54, 255: {

			new Float:HP;
			GetPlayerHealth(playerid, HP);
			
			if(HP < 100.0) {

				HP = HP + amount;
				
				SetPlayerHealth(playerid, HP);
				
				if(HP > 100.0) {
					SetPlayerHealth(playerid, 100.0);
				}

				SetPlayerHealth ( playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;
			}

        	return true ;
    	}
    }

 	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 	////////////////////////////////////// END  ANTICHEAT PATCH AGAINST HACKED WEAPON DAMAGE //////////////////////////////////
 	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

	// This makes it so people can't use /stopanim after being damaged. We do this after the invalid checks to ensure that
	// "hackers" or trolls can't abuse them using spoofed bullshit.
	PlayerVar [ playerid ] [ E_PLAYER_BRAWL_STOPANIM_ABUSE ] = gettime() + 10 ;

	if (PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ]) 
	{
		// NEW: If they get damaged while doing a looping anim, stop the anim for them as /sa is denied
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ClearAnimations(playerid);
        PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ] = 0;
	}
 
	if ( WEAPON_KNIFE == weaponid ) {
		if ( idx != -1 || GetPlayerWeapon ( issuerid ) == Weapon [ idx ] [ E_WEAPON_GUNID ] ) {

			if ( Weapon [ idx ] [ E_WEAPON_GUNID ] == WEAPON_KNIFE ) {
				KnifeSync_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid) ;
			}
		}

		else {
	        string [ 0 ] = EOS ;

	        format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s tried using a knife without actually having one. Spectate them!", issuerid, ReturnMixedName ( issuerid )  ) ;
	        SendAdminMessage(string, COLOR_ANTICHEAT) ;

	        PlayerVar [ issuerid ] [ E_PLAYER_SPOOFED_GUN_AC_WARNING ] ++ ;

          	new Float:x, Float:y, Float:z;

			GetPlayerPos ( issuerid, x, y, z ) ;
			
			PauseAC(playerid, 3);
			SetPlayerPos ( issuerid, x, y, z + 4 ) ;

			PlayerPlaySound ( issuerid, 1190, x, y, z ) ;

			SendClientMessage(playerid, COLOR_RED, "Failed to sync clientside knife with serverside knife. Don't do that again or you will be banned." ) ;
		}
	}

	new Float: fCurrentHealth = GetCharacterHealth ( playerid ) ;
	new Float: fCurrentArmour = GetCharacterArmour ( playerid ) ;

	if (weaponid == WEAPON_SPRAYCAN) amount = 1.0;
	else amount = CalculateWeaponDamage(playerid, issuerid, weaponid, bodypart);

	if (GetPlayerState(issuerid) == PLAYER_STATE_PASSENGER)
	{
		// If they are doing a driveby, lower the damage by 1/3
		amount = amount * 0.66;
	}

	if (amount < (fCurrentArmour + fCurrentHealth) && issuerid != INVALID_PLAYER_ID)
	{
		LogDamageGiven(playerid, issuerid, Float: amount, bodypart );
		// Only log damage if the amount won't kill them.
		// Deaths are recorded separately, and recording the damage instead will cause the death not to be recorded.
	}

	if (weaponid == WEAPON_SPRAYCAN)
	{
		// NEW: Mitigate armor damage with spraycan
		if (fCurrentArmour > 1.0)
		{
			SetCharacterArmour(playerid, fCurrentArmour);
		}

		// NEW: Only allow damage to 50 HP with spraycan
		if ((fCurrentHealth - amount) >= 50)
		{
			SetCharacterHealth(playerid, fCurrentHealth - amount);
		}
		else
		{
			SetCharacterHealth(playerid, fCurrentHealth);
		}

		return true;
	}

	if ( issuerid != INVALID_PLAYER_ID ) {

		if ( PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] != 0 ) {

			PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_DMG ] = true ;
			PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] = 30 ;
		}

		if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

			//SendClientMessage(issuerid, -1, "Passed OnPlayerTakeDamage, resetting health.") ; 
			//SetCharacterHealth(playerid, fCurrentHealth);

			return true ;
		}

		#if defined DEV_BUILD_DISCORD
			Attack_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart );
		#endif

		if ( PlayerVar [ issuerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] && AC_GetPlayerWeapon(issuerid) == WEAPON_SHOTGUN) {
			// Only mitigate damage if they're using the right weapon together with the variable!

			SetCharacterHealth(playerid, fCurrentHealth);

			return true ;
		}

		if ( PlayerVar [ issuerid ] [ E_PLAYER_TASER_EQUIPPED ] ) {
			switch ( weaponid ) {

				case WEAPON_COLT45, WEAPON_SILENCED, WEAPON_DEAGLE: {

					SetCharacterHealth(playerid, fCurrentHealth);

					return true ;
				}
			}
		}

		if ( fCurrentArmour ) 
		{
			new ammo_const = Weapon [ idx ] [ E_WEAPON_AMMO ] ; // New 9mm vs torso armor nerf + SWAT buff

			if (bodypart != BODY_PART_HEAD)
			{
				if (PlayerVar[playerid][E_PLAYER_KEVLAR_MODIFIER] > 0)
				{
					amount = amount * PlayerVar[playerid][E_PLAYER_KEVLAR_MODIFIER];
				}
				else if ( (ammo_const == AMMO_TYPE_A && bodypart == BODY_PART_TORSO) || PlayerVar[playerid][E_PLAYER_SWAT_ACTIVE] )
				{
					/*
					new gun_name [ 32 ], ammo_name [32];
					Weapon_GetGunName ( idx, gun_name, sizeof ( gun_name ) ) ;
					Weapon_GetAmmoName (idx, ammo_name, 32);

					SendClientMessage(playerid, -1, sprintf("Damge from %s reduced by kevlar from %.2f to %.2f (Weapon: %s (%d), Ammo: %s (%d)", ReturnPlayerNameData(issuerid, 0, true), amount, amount * 0.75, gun_name, idx, ammo_name, ammo_const));
					SendClientMessage(issuerid, -1, sprintf("Damge to %s reduced by kevlar from %.2f to %.2f (Weapon: %s (%d), Ammo: %s (%d)", ReturnPlayerNameData(playerid, 0, true), amount, amount * 0.75, gun_name, idx, ammo_name, ammo_const));
					*/
					
					amount = amount * 0.75;
				}
			}

			fCurrentArmour -= amount ;

			if ( fCurrentArmour <= 0.00 ) 
			{
				// Calculate proper health loss now too
				new Float:leftover = 0.0 - fCurrentArmour;

				if (leftover >= 1.0)
				{
					SetCharacterHealth(playerid, fCurrentHealth - leftover);
				}

				fCurrentArmour = 0.0 ;
			}

			SetCharacterArmour ( playerid, fCurrentArmour ) ;
		}

		else {

			fCurrentHealth -= amount ;

			if (issuerid != INVALID_PLAYER_ID) 
			{
				SetPlayerWound ( playerid, weaponid, bodypart, amount, issuerid) ;
			}

			// Player has died.
			if ( fCurrentHealth <= 0.00 ) {

				// Remove all other effects!
				PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ] = false ;
				PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ] = false ;
				PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ] = false ;

				TogglePlayerControllable(playerid, false);
				OnPlayerInjuryMode(playerid, issuerid, DEATHTYPE_WEAPON, weaponid) ;
				SetCharacterHealth(playerid, 25.0);
			}

			// Player still has health left.
			else if ( fCurrentHealth > 0.00 ) {
				SetCharacterHealth ( playerid, fCurrentHealth ) ;

				if ( bodypart == BODY_PART_LEFT_ARM || bodypart == BODY_PART_RIGHT_ARM ) {

					DamageArms ( playerid ) ;
				}

				else if ( bodypart == BODY_PART_LEFT_LEG || bodypart == BODY_PART_RIGHT_LEG) {

					DamageLegs ( playerid ) ;
				}
			}
		}
	}

	return true ;
}

LogDamageGiven(playerid, killerid, Float: amount, bodypart ) {
 
	new gun_name [ 32 ], gun_reason [32], gunid = GetPlayerCustomWeapon(killerid) ;

	Weapon_GetGunName ( gunid, gun_name, sizeof ( gun_name ) ) ;
	Weapon_GetGunReason ( gunid, gun_reason, sizeof ( gun_reason ) ) ;

	AddLogEntry(playerid, LOG_TYPE_DAMAGE, sprintf("Was damaged by %s (%d) with %s (%0.3f damage at %s)", 
		ReturnMixedName(killerid), killerid, gun_reason, amount, GetBodyPartName ( bodypart ) ));
	AddLogEntry(killerid, LOG_TYPE_DAMAGE, sprintf("Damaged %s (%d) with %s (%0.3f damage %s)", 
		ReturnMixedName(playerid), playerid, gun_reason, amount, GetBodyPartName ( bodypart )));
		
}

OnPlayerInjuryMode(playerid, killerid, deathtype, weaponid) 
{
	if ( ! PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) 
	{
		// If doing looping animation, reset state!
		if(PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ]) {
	        PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ] = 0;
		}

		// If player is in basketball, pool, poker, ... remove them!
		Minigame_ResetVariables(playerid);
		//RemovePlayerFromGym(playerid, GetPlayerGymID(playerid), 2);

		new gun_name [ 32 ], gun_reason [32] ;
		new gunid = GetPlayerCustomWeapon(killerid) ;

		if (deathtype == DEATHTYPE_CUSTOM)
		{
			SendAdminMessage(sprintf("[INJURED] (%d) %s admin-killed (%d) %s with \"%s\".", killerid, ReturnMixedName(killerid), playerid, ReturnMixedName(playerid), PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ]), COLOR_ANTICHEAT);
			SendClientMessage( playerid, COLOR_RED, sprintf("You've been injured by %s", PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ]) );
		}
		else
		{
			Weapon_GetGunName ( gunid, gun_name, sizeof ( gun_name ) ) ;
			Weapon_GetGunReason ( gunid, gun_reason, sizeof ( gun_reason ) ) ;
			format(PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ], 64, "%s", gun_reason);
			SendAdminMessage(sprintf("[INJURED] (%d) %s has injured (%d) %s with a (%d) %s.", killerid, ReturnMixedName(killerid), playerid, ReturnMixedName(playerid), gunid, gun_name), COLOR_ANTICHEAT);
			SendClientMessage( playerid, COLOR_RED, sprintf("You've been injured with %s by %s (%d)", gun_reason, ReturnSettingsName(killerid, playerid), killerid) );
		}
		
		Phone_ForceHidePhone(playerid) ; // hides textdraws on death

		PlayerVar [ playerid ] [ E_PLAYER_INJURED_EXECUTE_CD ] = true ;
		PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] = true ;

		// SetPlayerChatBubble(playerid, sprintf("(( THIS PLAYER IS INJURED [ /showinjuries %d ] ))", playerid), COLOR_INJURY, 7.5, 80000);		

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = true ;

		new INJURY_MODE_MIN_TIME = 120; 	// they must stay in injury mode for at least 2 minutes
		new INJURY_MODE_MAX_TIME = 300;		// after 5 minutes (default), they automatically /acceptdeath

		switch ( weaponid ) 
		{
			case 2 .. 15:		INJURY_MODE_MAX_TIME = 450 ; // auto bleed to death after 7.5 mins from melee
			case 22, 23, 24: 	INJURY_MODE_MAX_TIME = 360 ; // auto bleed to death after 6 mins from pistols
			case 25, 26, 27: 	INJURY_MODE_MAX_TIME = 300 ; // auto bleed to death after 5 mins from shotgun
			case 28, 32: 		INJURY_MODE_MAX_TIME = 300 ; // auto bleed to death after 5 mins from tec/uzi etc
			case 29, 30, 31: 	INJURY_MODE_MAX_TIME = 240 ; // auto bleed to death after 4 mins from m4 etc
			case 33, 34 : 		INJURY_MODE_MAX_TIME = 180 ; // auto bleed to death after 3 mins from sniper
		}

		if (IsPlayerInMetroTraining(playerid))
		{
			// Fast respawn for cops that die in their training facility
			INJURY_MODE_MIN_TIME = 10;
			INJURY_MODE_MAX_TIME = 30;
		}

		PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] = INJURY_MODE_MAX_TIME ;
		PlayerVar [ playerid ] [ E_PLAYER_INJURY_MIN_TICK ] = INJURY_MODE_MIN_TIME ;
		
		SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3", sprintf("After %d seconds, you will be allowed to 'accept death' if nobody is interacting with you.", INJURY_MODE_MIN_TIME) );
		SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3", sprintf("If you do not, you will automatically pass out and be respawned after %d seconds.", INJURY_MODE_MAX_TIME) );

		//CancelBloodPuddle ( playerid ) ;
		defer Injury_TickCountdown(playerid);

		if ( playerid != killerid )
		{
			SendClientMessage(killerid, COLOR_RED, sprintf("You injured %s (%d) with %s.", ReturnSettingsName(playerid, killerid), playerid, PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ] ));
		}

		// Resetting all other incapable variables so their reset timer isn't called!!
		PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ]  = false ;
		PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED_TIME ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] = 0 ;

		// NEW LOGGING: Log this as a LOG_TYPE_DAMAGE for both
		AddLogEntry(playerid, LOG_TYPE_DAMAGE, sprintf("Was injured by %s (%d) with %s", ReturnMixedName(killerid ), killerid, PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ]));
		AddLogEntry(killerid, LOG_TYPE_DAMAGE, sprintf("Injured %s (%d) with %s", ReturnMixedName(playerid), playerid, PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ]));
		
		TogglePlayerControllable(playerid, false);
		defer Injury_ApplyDeathAnimation(playerid, deathtype == DEATHTYPE_KNIFED);
		defer Injury_RemoveExecuteCD(playerid);
	}

	return true ;
}

timer Injury_RemoveExecuteCD[15000](playerid) {

	PlayerVar [ playerid ] [ E_PLAYER_INJURED_EXECUTE_CD ] = false ;
}

timer Injury_ApplyDeathAnimation[500](playerid, knifed) {
	new vehicleid = GetPlayerVehicleID(playerid);

	if (vehicleid) {
		new modelid = GetVehicleModel(vehicleid);
		new seat = GetPlayerVehicleSeat(playerid);

		switch (modelid) {
			case 509, 481, 510, 462, 448, 581, 522,
			     461, 521, 523, 463, 586, 468, 471: {
				new Float:vx, Float:vy, Float:vz;
				GetVehicleVelocity(vehicleid, vx, vy, vz);

				JT_RemovePlayerFromVehicle(playerid);

				if (vx*vx + vy*vy + vz*vz >= 0.4) {
					Injury_ApplyAnim(playerid, "PED", "BIKE_fallR", 0);
				} else {
					Injury_ApplyAnim(playerid, "PED", "BIKE_fall_off", 0);
				}

				defer Injury_ApplyBikeAnimation[750](playerid, vehicleid);
			}

			default: {
				if (seat & 1) {
					Injury_ApplyAnim(playerid, "PED", "CAR_dead_LHS");
				} else {
					Injury_ApplyAnim(playerid, "PED", "CAR_dead_RHS");
				}
			}
		}
	} 

	else {

		//Injury_ApplyAnim(playerid, "PED", "FLOOR_hit_f", true);
		if ( knifed ) {

			Injury_ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Damage", _, 5200);
		}

		else ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
	}
}

Float: CalculateWeaponDamage(playerid, issuerid, weaponid, bodypart) {
	#pragma unused bodypart

	new Float: x, Float: y, Float: z ;

	GetPlayerPos ( playerid, x, y, z ) ;
	new Float: distance = GetPlayerDistanceFromPoint(issuerid, x, y, z ) ;

	new Float: damage = SP_GetWeaponDamageFromDistance(weaponid, distance) ;
	new custom_gun = GetPlayerCustomWeapon(issuerid) ;

	new Float: ammo_damage = Weapon_GetAmmoDamage ( custom_gun );

	// Giving extra damage to the new PD deagle.
	if ( custom_gun == 67 ) ammo_damage = 9.0;		// should make it about 34 damage per shot
	else if (custom_gun == 64) ammo_damage = 0.0;	// Nerfing emmet's colt

	new Float: final_damage = damage ;
	final_damage += ammo_damage ;

	if ( weaponid == 41 ) {

		// No additionals for spray-can.
		final_damage = damage ;
	}

	// Giving extra damage to melee weapons if the user is high on coke
	if ( weaponid >= 0 && weaponid != 9 && weaponid < 15 ) {

		if (  Character [ issuerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] ) {

			switch ( Character [ issuerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] ) {

				case E_DRUG_TYPE_COKE: {
					final_damage += Cocaine [ Character [ issuerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] ] [ E_COKE_EXTRA_DAMAGE ] ;
				}
			}
		}

		Gym_ApplyFightstyleDamage(playerid, issuerid, final_damage);
	}

	/*
	new gun_name[32];
	Weapon_GetGunName(custom_gun, gun_name, 32);

	SendClientMessage(issuerid, -1, sprintf("Hit %s with a %s (%d) (Base: %.2f, Ammo: %.2f, Final: %.2f", ReturnPlayerNameData(playerid, 0, true), gun_name, custom_gun, damage, ammo_damage, final_damage));
	SendClientMessage(playerid, -1, sprintf("Hit by %s with a %s (%d) (Base: %.2f, Ammo: %.2f, Final: %.2f", ReturnPlayerNameData(issuerid, 0, true), gun_name, custom_gun, damage, ammo_damage, final_damage));
	//printf("% hit %s with a %s (%d) (Base: %.2f, Ammo: %.2f, Final: %.2f)", );
	*/

	// idx returned -1, so weapon is invalid!
	if ( custom_gun == -1 ) {
		
		final_damage = 0.0 ;
	}

	return final_damage ;
}

IsPlayerCriticallyWounded(playerid)
{
	// New smarter critical injury calcuation:
	new headshot_count, Float:headshot_dmg;
	headshot_count = Wounds_GetWoundCount(playerid, BODY_PART_HEAD);
	Wounds_GetWoundDamage(playerid, BODY_PART_HEAD, headshot_dmg);
	#pragma unused headshot_count

	new torso_count, Float:torso_dmg;
	torso_count = Wounds_GetWoundCount(playerid, BODY_PART_TORSO) + Wounds_GetWoundCount(playerid, BODY_PART_GROIN);
	Wounds_GetWoundDamage(playerid, BODY_PART_TORSO, torso_dmg);
	#pragma unused torso_count

	/*
	new Float:groin_dmg;
	Wounds_GetWoundDamage(playerid, BODY_PART_GROIN, groin_dmg);
	torso_dmg += groin_dmg;*/

	//SendClientMessage(playerid, -1, sprintf("Head count: %d, damage: %0.1f", headshot_count, headshot_dmg));
	//SendClientMessage(playerid, -1, sprintf("Torso count: %d, damage: %0.1f", torso_count, torso_dmg));

	return PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 || headshot_dmg > INJURY_CRITICAL_DMG_HEAD || torso_dmg > INJURY_CRITICAL_DMG_TORSO;
}