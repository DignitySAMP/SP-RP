
CMD:tazer(playerid, params[]) {

	return cmd_taser(playerid, params);
}
CMD:taser(playerid, params[]) {
	if ( ! CanPlayerDoGunCMD(playerid) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command when you're inside a vehicle, or are on temporary cooldown." );
	}

	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty in a faction with a taser." ) ;
	}

	if (Character[playerid][E_CHARACTER_FACTIONTIER] > 3)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not a high enough tier of employee to do this.");
	}

	if ( IsPlayerInAnyVehicle(playerid)) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't be in a vehicle and do this command.");
	}

		// Make it so if taser is equipped, and then unequipped, it gives back the deagle
	if ( ! PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] ) {
		//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s has unholstered their tazer.", ReturnPlayerNameData ( playerid ) ) );
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "draws their tazer.", false, true);

		PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] = true ;

		new wep, ammo;
		GetPlayerWeaponData(playerid, 2, wep, ammo);

		PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_WEAPON ] = 0;
		PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_AMMO ] = 0;

		if (wep && ammo > 0)
		{
			PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_WEAPON ] = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ 2 ];
			PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_AMMO ] = ammo;
		}
		GiveCustomWeapon(playerid, CUSTOM_TAZER, 15 ) ;
		SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(CUSTOM_TAZER), 15 ) ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] ) {
		//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s has holstered their tazer.", ReturnPlayerNameData ( playerid ) ) );
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "holsters their tazer.", false, true);

		PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] = false ;

		if (PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_WEAPON ] && PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_AMMO ] > 0)
		{
			GiveCustomWeapon(playerid, PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_WEAPON ], PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_AMMO ] ) ;
			SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_WEAPON ]), PlayerVar [ playerid ] [ E_PLAYER_TAZER_OLD_AMMO ]);
		}
		else
		{
			RemovePlayerCustomWeapon(playerid, 65);
		}

		SetPlayerArmedWeapon(playerid, 0);		
	}


	return true ;
}

Tazer_OnPlayerGiveDamage(playerid, damagedid, weaponid) {

	switch ( weaponid ) {

		case WEAPON_SILENCED: {

			if ( PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] ) {

				if ( ! PlayerVar [ damagedid ] [ E_PLAYER_INJUREDMODE ] ) {

					if ( PlayerVar [ damagedid ] [ E_PLAYER_IS_TAZED ] ) {

						return true ;
					}

					PlayReloadAnimation(playerid, WEAPON_SILENCED ) ; 

					new Float: x, Float: y, Float: z;
					GetPlayerPos(damagedid, x, y, z ) ;

					new Float: dist = GetPlayerDistanceFromPoint(playerid, x, y, z ) ;

					if ( dist > 10.0 ) 
					{
						// too far away
						return true;
					}

					TogglePlayerControllable(damagedid, false);

					ProxDetectorEx ( damagedid, 30.0, COLOR_ACTION, "**", "collapses after being shot with a tazer." );
					SendServerMessage ( damagedid, COLOR_BLUE, "Tazer", "A3A3A3", sprintf("(%d) %s shot you with a tazer, causing you to twitch and collapse.", playerid, ReturnSettingsName ( playerid, damagedid )) ) ;
					ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", sprintf("fires a taser cartridge at %s.", ReturnMixedName ( damagedid )), false, true);

					ShowPlayerSubtitle(damagedid, "You've been ~r~incapacitated~w~ by a police tazer.", 5000);

					SetPlayerDrunkLevel(damagedid, GetPlayerDrunkLevel(damagedid)+3500);

					// 30 seconds taser.
					PlayerVar [ damagedid ] [ E_PLAYER_IS_TAZED_TIME ] = 30 ;
					PlayerVar [ damagedid ] [ E_PLAYER_IS_TAZED ] = true ;
				}
			}
		}
	}





	return true ;
}

Tazer_ResetTick(playerid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ]  ) {
		if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {
			// If injured, just cancel the function and reset tazer state.

			PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED_TIME ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ]  = false ;
			return true ;
		}

		if ( -- PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED_TIME ] <= 0 ) {

			PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED_TIME ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ]  = false ;

			//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s's taser effects have worn off.", ReturnPlayerNameData ( playerid ) ) );
			SendServerMessage ( playerid, COLOR_BLUE, "Tazer", "A3A3A3", "Your incapacity effects have worn off. You should still roleplay being dizzy and weak!");

			TogglePlayerControllable(playerid, true);

			if ( GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_CUFFED ) {
				TRP_ClearAnimations(playerid);
				//SetPlayerDrunkLevel(playerid, 0);
			}
		}

		else if ( PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED_TIME ] ) {

			new vehicleid = GetPlayerVehicleID(playerid);

			if (vehicleid) {
				new modelid = GetVehicleModel(vehicleid);

				TogglePlayerControllable(playerid, false);

				switch (modelid) {
					case 509, 481, 510, 462, 448, 581, 522,
					     461, 521, 523, 463, 586, 468, 471: {
						new Float:vx, Float:vy, Float:vz;
						GetVehicleVelocity(vehicleid, vx, vy, vz);

						JT_RemovePlayerFromVehicle(playerid);

						new Float: x, Float: y, Float: z ;
						GetPlayerPos(playerid, x, y, z);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid, x, y, z + 0.5 ) ;

						if (vx*vx + vy*vy + vz*vz >= 0.4) {
							Injury_ApplyAnim(playerid, "PED", "BIKE_fallR", 0);
						} else {
							Injury_ApplyAnim(playerid, "PED", "BIKE_fall_off", 0);
						}

						defer Tazer_ReAppendAnim[750](playerid);
						return true ;
					}
				}
			}

			ApplyAnimation(playerid,"SWEET", "Sweet_injuredloop", 4.1, 1, 1, 1, 1, 0);
		}
	}

	return true ;
}

timer Tazer_ReAppendAnim[750](playerid) {


	ApplyAnimation(playerid,"SWEET", "Sweet_injuredloop", 4.1, 1, 1, 1, 1, 0);

	return true ;
}

#include <YSI_Coding\y_hooks>

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if (weaponid == WEAPON_SILENCED && IsPlayerConnected(playerid) && PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ])
	{	
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "discharges a tazer.", .annonated=true);
		PlayReloadAnimation(playerid, WEAPON_SILENCED ) ; 

		if (hittype == BULLET_HIT_TYPE_VEHICLE)
		{
			return -1; // stop processing OnPlayerWeaponShot and return 0
			// this completely stops the taser from damaging cars 
		}
	}

	return 1;
}