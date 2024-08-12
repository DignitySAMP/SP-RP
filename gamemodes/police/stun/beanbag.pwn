CMD:beanbag(playerid, params[]) {
    
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] && AC_GetPlayerWeapon ( playerid ) != WEAPON_SHOTGUN ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must have a duty issued shotgun equipped.");
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ]) {

		//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s has switched to non lethal bullets.", ReturnPlayerNameData ( playerid ) ) );
		//SendServerMessage ( playerid, COLOR_BLUE, "Beanbag", "A3A3A3", "You've switched to NON-LETHAL bullets.");
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", "loads their shotgun with beanbag rounds.", false, true);

		PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] = true ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] ) {

		//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s has switched to lethal bullets.", ReturnPlayerNameData ( playerid ) ) );
		//SendServerMessage ( playerid, COLOR_BLUE, "Beanbag", "A3A3A3", "You've switched to LETHAL bullets.");
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", "loads their shotgun with live ammunition.", false, true);

		PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] = false ;
	}

	return true ;
}

Beanbag_OnPlayerGiveDamage(playerid, damagedid, weaponid ) {

	if ( weaponid != WEAPON_SHOTGUN ) {

		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ] ) {

		if ( ! PlayerVar [ damagedid ] [ E_PLAYER_INJUREDMODE ] ) {


			if ( PlayerVar [ damagedid ] [ E_PLAYER_IS_BEANBAGGED ] ) {

				return true ;
			}

			PlayReloadAnimation(playerid, WEAPON_SHOTGUN ) ;

			new Float: x, Float: y, Float: z, hit_chance = random ( 100 ) ;

			GetPlayerPos(damagedid, x, y, z ) ;

			new Float: dist = GetPlayerDistanceFromPoint(playerid, x, y, z ) ;

			if ( dist > 12.5 || hit_chance <= dist ) 
			{
				// too far / random failed
				return true;
			}

			TogglePlayerControllable(damagedid, false);

			//SendClientMessage(damagedid, -1, "You've been hit by a non lethal bullet (beanbag).");
			SetPlayerDrunkLevel(damagedid, GetPlayerDrunkLevel(damagedid)+1000);

			// 10 seconds beanbag.
			PlayerVar [ damagedid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] = 10 ;
			PlayerVar [ damagedid ] [ E_PLAYER_IS_BEANBAGGED ] = true ;

			// SendServerMessage ( playerid, COLOR_BLUE, "Beanbag", "A3A3A3", sprintf("You've beanbagged (%d) %s. They will be unable to move for 15 seconds.", damagedid, ReturnPlayerNameData(damagedid, 0, true ) ) ) ;

			ProxDetectorEx(damagedid, 30.0, COLOR_ACTION, "**", "falls to the ground after being hit by a beanbag round.", false, true);

			SendServerMessage ( damagedid, COLOR_BLUE, "Beanbag", "A3A3A3", sprintf("(%d) %s hit you with a non-lethal rubber bullet, causing you to fall down in pain.", playerid, ReturnSettingsName ( playerid, damagedid )) ) ;
			ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", sprintf("fires a beanbag round at %s.", ReturnMixedName ( damagedid )), false, true);

			ShowPlayerSubtitle(damagedid, "You've been ~r~knocked down~w~ by a beanbag shotgun.", 5000);
		}
	}

	return true ;
}

Beanbag_ResetTick(playerid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ]  ) {
		if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {
			// If injured, just cancel the function and reset beanbag state.

			PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ]  = false ;
			return true ;
		}

		if ( -- PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] <= 0 ) {

			PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ]  = false ;

			SendServerMessage ( playerid, COLOR_BLUE, "Beanbag", "A3A3A3", "Your incapacity effects have worn off. You should still roleplay being in pain!");
			//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s's beanbag effects have worn off.", ReturnPlayerNameData ( playerid ) ) );

			TogglePlayerControllable(playerid, true);

			if ( GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_CUFFED ) {
				TRP_ClearAnimations(playerid);
				//SetPlayerDrunkLevel(playerid, 0);
			}
		}

		else if ( PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] ) {

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

						SetPlayerPos(playerid, x, y, z + 0.5 ) ;

						if (vx*vx + vy*vy + vz*vz >= 0.4) {
							Injury_ApplyAnim(playerid, "PED", "BIKE_fallR", 0);
						} else {
							Injury_ApplyAnim(playerid, "PED", "BIKE_fall_off", 0);
						}

						defer Beanbag_ReAppendAnim[750](playerid);
						return true ;
					}
				}
			}

			ApplyAnimation(playerid,"SWEET", "Sweet_injuredloop", 4.1, 1, 1, 1, 1, 0);
		}
	}

	return true ;
}

timer Beanbag_ReAppendAnim[750](playerid) {


	ApplyAnimation(playerid,"SWEET", "Sweet_injuredloop", 4.1, 1, 1, 1, 1, 0);

	return true ;
}

#include <YSI_Coding\y_hooks>

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if (weaponid == WEAPON_SHOTGUN && IsPlayerConnected(playerid) && PlayerVar [ playerid ] [ E_PLAYER_BEANBAG_EQUIPPED ])
	{	

		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", "fires a beanbag round.", false, true);

		if (hittype == BULLET_HIT_TYPE_VEHICLE)
		{
			return -1; // stop processing OnPlayerWeaponShot and return 0
			// this completely stops the beanbag from damaging cars
		}
	}

	return 1;
}