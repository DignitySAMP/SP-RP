
timer Injury_ApplyBikeAnimation[750](playerid, vehicleid) {
// This re-appends the bike falloff animation.

	new Float:vx, Float:vy, Float:vz;
	GetVehicleVelocity(vehicleid, vx, vy, vz);

	JT_RemovePlayerFromVehicle(playerid);

	if (vx*vx + vy*vy + vz*vz >= 0.4) {
		Injury_ApplyAnim(playerid, "PED", "BIKE_fallR", 0);
	} else {
		Injury_ApplyAnim(playerid, "PED", "BIKE_fall_off", 0);
	}

	return true ;
}

timer Injury_AppendAnimAfterEject[750](playerid) {

	//ApplyAnimation(playerid,"PED", "FLOOR_hit_f", 4.1, 0, 0, 0, 1, 0);
	ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);

	return true ;
}
 
CMD:acceptdeath(playerid) {
	if ( ! PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

		SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", "You're not in injury mode and can't do this command." ) ;
		return true ;
	}

	if (!PlayerVar [ playerid ] [ E_PLAYER_EXECUTE_MSG ])
	{
		if (PlayerVar [ playerid ] [ E_PLAYER_INJURY_MIN_TICK ] > 0)
		{
			SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", sprintf("You must wait %d seconds before doing this.", PlayerVar [ playerid ] [ E_PLAYER_INJURY_MIN_TICK ]) ) ;
			return true;
		}

		if (PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] > 0)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);

			foreach ( new i : Player ) 
			{
				if (i == playerid) continue;
				if (IsPlayerInRangeOfPoint(i, 7.5, x, y, z) && IsPlayerInAnyGovFaction(i, true))
				{
					SendServerMessage( playerid, COLOR_RED, "Injury", "A3A3A3",  "You can't do this while the emergency services are beside you." );
					return SendServerMessage( playerid, COLOR_RED, "Injury", "A3A3A3",  sprintf("Note that you will be automatically respawned in %d seconds if they do not revive you.", PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ]) );
				}
			}
		}
	}
	
	Injury_OnPlayerDeath(playerid) ;
	return true ;
}

timer Injury_TickCountdown[1000](playerid) {
	if ( ! PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

		SetPlayerChatBubble(playerid," ", 0xFFFFFFFF, 7.5, 10000);
		return false ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJURY_MIN_TICK ] > 0 ) 
	{
		// Allow player to accept death
		if ( -- PlayerVar [ playerid ] [ E_PLAYER_INJURY_MIN_TICK ] == 0)
		{
			if (IsPlayerInMetroTraining(playerid))
			{
				SendClientMessage( playerid, COLOR_RED, "You can now type {AA3333}/acceptdeath{ff6347} to respawn back at the facility entrance.");
			}
			else
			{
				SendClientMessage( playerid, COLOR_RED, "You can now type {AA3333}/acceptdeath{ff6347} to respawn if nobody is interacting with you.");
				SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3", "If you respawn, you will not remember what happened or anyone involved.");
			}
		}
	}

	if ( -- PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {

		// Kill player
		
		SetPlayerChatBubble(playerid, "(( THIS PLAYER IS DEAD ))", COLOR_YELLOW, 7.5, 900000);
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
		Weapon_ResetPlayerWeapons(playerid);

		/*
		SendClientMessage(playerid, COLOR_YELLOW, "You are now dead. To continue, use /acceptdeath. You will not remember anything that happened");
		SendClientMessage(playerid, COLOR_YELLOW, "leading up to the event of your death. You may not take revenge against those who killed you.");
		*/

		SendClientMessage(playerid, COLOR_RED, "You passed out and have been transported to recover in hospital.");
		SendServerMessage(playerid, COLOR_INJURY_LIGHT, "Injury", "A3A3A3", "The hospital staff will confiscate any weapons and bill you for the care you receive.");
		SendServerMessage(playerid, COLOR_INJURY_LIGHT, "Injury", "A3A3A3", "You can no longer be revived and will not remember what happened or anyone inolved.");
		cmd_acceptdeath(playerid);

		//ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
	
		return true ;
		//CancelBloodPuddle ( playerid ) ;
	}	

	else {

		/*GameTextForPlayer(playerid, sprintf("~w~~n~~n~~n~~n~~n~~n~Injured: ~r~%d", 
			PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ]), 950, 3 ) ;*/

		if (strlen(PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ]) > 1)
		{
			SetPlayerChatBubble(playerid, sprintf("(( This player has been injured by %s [ /damages %d ] ))", PlayerVar [ playerid ] [ E_PLAYER_INJURY_REASON ], playerid), COLOR_INJURY, 7.5, 1500);
		}
		else
		{
			SetPlayerChatBubble(playerid, sprintf("(( This player is injured [ /damages %d ] ))", playerid), COLOR_INJURY, 7.5, 1500);
		}
		

		defer Injury_TickCountdown(playerid);
	}

	return true ;
}

timer Injury_FinalizeRespawn[7500](playerid) {


	PlayerVar [ playerid ] [ E_PLAYER_EXECUTE_MSG ] = false ;

	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, true);

	if (PlayerVar [ playerid ] [ E_PLAYER_IS_MASKED ])
	{
		PlayerVar [ playerid ] [ E_PLAYER_IS_MASKED ] = false;
		ToggleMask(playerid, false);
	}

	SetPlayerChatBubble(playerid, " ", -1, 7.5, 1000);

	if ( Character [ playerid ] [ E_CHARACTER_ARREST_TIME ] ) {

		SetCameraBehindPlayer(playerid);

		// New: preload the arrest position with streamer_update
		SetPlayerVirtualWorld ( playerid, Character [ playerid ] [ E_CHARACTER_ARREST_VW ] );
		SetPlayerInterior(playerid, Character [ playerid ] [ E_CHARACTER_ARREST_INT ] );
		//Streamer_UpdateEx(playerid, Character [ playerid ] [ E_CHARACTER_ARREST_X ], Character [ playerid ] [ E_CHARACTER_ARREST_Y ], Character [ playerid ] [ E_CHARACTER_ARREST_Z ], Character [ playerid ] [ E_CHARACTER_ARREST_VW ], Character [ playerid ] [ E_CHARACTER_ARREST_INT ], STREAMER_TYPE_OBJECT, 1000, 1);
		
		SOLS_SetPlayerPos ( playerid, Character [ playerid ] [ E_CHARACTER_ARREST_X ], Character [ playerid ] [ E_CHARACTER_ARREST_Y ], Character [ playerid ] [ E_CHARACTER_ARREST_Z ] );
		SetPlayerHealth(playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;

		SendServerMessage ( playerid, COLOR_BLUE, "Arrest", "A3A3A3", "You've been teleported back to your cell." ) ;
		Weapon_ResetPlayerWeapons(playerid);
		SendClientMessage(playerid, 0xA3A3A3FF, "Your weapons have been confiscated.");
		Weapon_SavePlayerWeapons(playerid);
	}

	
	if(Character[playerid][E_CHARACTER_AJAIL_TIME] > 0) {
		
		SetCameraBehindPlayer(playerid);
		SetPlayerIntoAdminJail(playerid);
		SetPlayerHealth(playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;

		SendClientMessage(playerid, 0xA3A3A3FF, "You were teleported back to admin jail.");
		Weapon_ResetPlayerWeapons(playerid);
		SendClientMessage(playerid, 0xA3A3A3FF, "Your weapons have been confiscated.");
		Weapon_SavePlayerWeapons(playerid);
		return true;
	}

	return true ;
}
Injury_OnPlayerDeath(playerid) 
{
	if (IsPlayerInMetroTraining(playerid))
	{
		PauseAC(playerid, 3);
		SetPlayerPos(playerid, 1932.4357,-2301.5842,13.6028);
		SetPlayerVirtualWorld(playerid, 6003);
		SetPlayerInterior(playerid, 7);
		SetCharacterHealth(playerid, 100.0);
		TogglePlayerControllable(playerid, true);
		SetCameraBehindPlayer(playerid);
		Injury_RemoveData(playerid) ;
		Injury_FinalizeRespawn(playerid);

		SendClientMessage(playerid, 0xA3A3A3FF, "You were respawned back at the training center.");
		return true;
	}

	SetPlayerCameraPos(playerid, 2001.6575, -1451.1865, 28.0661);
	SetPlayerCameraLookAt(playerid, 2002.2876, -1450.4061, 27.8411);

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, 2009.9967, -1437.8395, 13.5547 ) ;
	SetPlayerFacingAngle(playerid, 131.1139);

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);

	TogglePlayerControllable(playerid, false);
	SetCharacterHealth(playerid, 75.0);

	SetPlayerChatBubble(playerid,"(( This player recently died and respawned ))", COLOR_BLUE, 7.5, 10000);

	defer Injury_FinalizeRespawn[7500](playerid) ;

	/* FUCK YOU FUCK YOU FUCK YOU FUCK YOU
	// Restore spraycan / camera
	if(DoesPlayerHaveWeapon(playerid, WEAPON_CAMERA)) {
		SetPlayerArmedWeapon(playerid, WEAPON_CAMERA);
		InjuryRestoreCamera[playerid] = GetPlayerAmmo(playerid);
	}

	if(DoesPlayerHaveWeapon(playerid, WEAPON_SPRAYCAN)) {
		SetPlayerArmedWeapon(playerid, WEAPON_SPRAYCAN);
		InjuryRestoreSpraycan[playerid] = GetPlayerAmmo(playerid);
	}*/

	// If a player dies due to an explosion, don't confiscate their shit.
	if( ! PlayerVar [ playerid ] [ E_PLAYER_ONPLAYERDEATH ] ) {

		// Now clear it.
		Weapon_ResetPlayerWeapons(playerid);
		SendClientMessage(playerid, 0xA3A3A3FF, "Your weapons have been confiscated by the hospital staff.");
		Weapon_SavePlayerWeapons(playerid);

		// Also bill them for the fine american healthcare they receive - max once every 30 mins
		if (!PlayerVar[playerid][E_PLAYER_LAST_HOSPITAL_BILL_AT] || gettime() - PlayerVar[playerid][E_PLAYER_LAST_HOSPITAL_BILL_AT] > 1800)
		{
			new worth = Character[playerid][E_CHARACTER_BANKCASH] + Character[playerid][E_CHARACTER_CASH];
			new cost = 250;

			if (worth > 250)
			{
				// Hospital bill is 1% of a player's net worth, min 250, max 2.5k.
				cost = (worth / 100) * 1;
				if (cost < 250) cost = 250;
				else if (cost > 2500) cost = 2500;

				// + A small random amount
				cost += (random(100) + 1);
			}
			
			if (IsPlayerInAnyGovFaction(playerid))
			{
				SendClientMessage(playerid, 0xA3A3A3FF, sprintf("Your hospital bill of $%s was paid by your government health insurance.", IntegerWithDelimiter(cost)));
			}
			else if (worth < 250)
			{
				SendClientMessage(playerid, 0xA3A3A3FF, sprintf("Your hospital bill of $%s was paid by the government as you couldn't afford it.", IntegerWithDelimiter(cost)));
			}
			else
			{
				TakePlayerCash(playerid, cost);
				PlayerVar[playerid][E_PLAYER_LAST_HOSPITAL_BILL_AT] = gettime();
				SendClientMessage(playerid, 0xA3A3A3FF, sprintf("You were billed $%s by the hospital for your medical care.", IntegerWithDelimiter(cost)));
			}
		}
	}

	// They died clientwise - let's refund their shit.
	else {

		new idx  ;

		for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
			idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

			if ( idx != -1 || idx != 0 ) {

				GivePlayerWeapon(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ; // hard setting ammo
			}

			PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = 0 ;
		}
	}

	Injury_RemoveData(playerid) ;

	return true ;
}


Injury_RemoveData(playerid) {

	TogglePlayerControllable(playerid, true);
	Injury_RemoveVariables(playerid);

    Weapon_SetSkillLevel(playerid, 999);

	SetPlayerChatBubble(playerid," ", COLOR_INJURY, 7.5, 1000);
	ApplyAnimation(playerid,"PED", "getup_front", 4.1, 0, 0, 0, 0, 0, true);

	SetCharacterHealth(playerid, 100);
	//CancelBloodPuddle ( playerid ) ;

	ResetPlayerWounds ( playerid );
	SOLS_SetPlayerCuffed(playerid, false);
	return true ;
}

Injury_RemoveData_Player(playerid) {

	TogglePlayerControllable(playerid, true);

	PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] = false ;
	PlayerVar [ playerid ] [ E_PLAYER_INJURED_LAST_VEH ] = 0 ;
	PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] = 60 ;

    Weapon_SetSkillLevel(playerid, 999);

	SetPlayerChatBubble(playerid," ", COLOR_INJURY, 7.5, 1000);
	ApplyAnimation(playerid,"PED", "getup_front", 4.1, 0, 0, 0, 0, 0, true);

	SetCharacterHealth(playerid, 50);

	return true ;
}