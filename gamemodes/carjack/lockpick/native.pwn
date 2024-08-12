CMD:lockpick(playerid, params[]) {
	new vehicleid = Vehicle_GetClosestEntity(playerid);

	if ( vehicleid != INVALID_VEHICLE_ID ) {
		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

		if ( veh_enum_id != -1 ) {

			if ( ! AbleToLockpickCar(playerid)  ) {

				Picklock_CloseGUI(playerid);
				return SendClientMessage(playerid, COLOR_ERROR, "This vehicle can't be lockpicked (non player vehicle, vehicle has driver, ...).");
			}

			if ( GetDoorStatus ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) { // locked

				if (  Character [ playerid ] [ E_CHARACTER_LOCKPICK ] ) {

					PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]  ;
					Picklock_ShowGUI(playerid) ;
				}

				else {
					if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_INFO_CD2 ] < gettime () ) {

						ShowPlayerSubtitle( playerid, "You don't have a lockpick! Buy one at the chopshop.", .showtime = 4000 ) ;

						PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_INFO_CD2 ] = gettime() + 5 ; // cd on info msg to avoid spam
					}

				}
			}

		}
	}				
	else {	
		ShowPlayerSubtitle( playerid, "~r~You're not near a car!", .showtime = 4000 ) ;
	}

	return true ;
}


CMD:smashwindow(playerid, params[]) 
{
	return SendClientMessage(playerid, COLOR_ERROR, "Smashing car windows is now disabled, use a /lockpick instead.");
	/*
	new vehicleid = Vehicle_GetClosestEntity(playerid);

	if ( vehicleid != INVALID_VEHICLE_ID ) {
		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

		if ( veh_enum_id != -1 ) {

			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				Picklock_CloseGUI(playerid);
	    		return SendClientMessage(playerid, COLOR_ERROR, "Why would you lockpick your own car?");
			}

			if ( GetDoorStatus ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) { // locked

				if ( ! AbleToLockpickCar(playerid)  ) {

					Picklock_CloseGUI(playerid);
					return SendClientMessage(playerid, COLOR_ERROR, "This vehicle can't be lockpicked.");
				}

				StartVehicleAlarm(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]);
				SetDoorStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], false );

				ProxDetectorNameTag(playerid, 25.0, COLOR_ACTION, sprintf("smashes the window of the %s.", ReturnVehicleName(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ])), "", 1,  .customcolor=false, .invert_action=false ) ;
				PlayerPlaySound(playerid, 34606, 0, 0, 0);					

				if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_INFO_CD3 ] < gettime () ) {			
					ShowPlayerSubtitle( playerid, "You've smashed the window! The alarm is set off, the police will be coming!", .showtime = 6000 ) ;

			    	PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_INFO_CD3 ] = gettime() + 5 ; // cd on info msg to avoid spam
				}

			    new driver, passenger, backleft, backright;
			    GetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), driver, passenger, backleft, backright);
				SetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), 0, passenger, backleft, backright);
			}
		}
	}

	return true ;*/
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {


	if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING ] ) {

		new query [ 128 ] ;

		if ( newkeys & KEY_YES ) { // increase pressure

			PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] += frandom(1.0, 5.0 );

			PlayerTextDrawSetString(playerid, lp_gui_player_panel[playerid][9], sprintf("%0.2f", PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] ));


			if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] >= 102.5 ) {
				Character [ playerid ] [ E_CHARACTER_LOCKPICK ] -- ;
				GameTextForPlayer(playerid, "~r~Lockpick broke under pressure!", 3500, 3);
				PlayerPlaySound(playerid, 34605, 0, 0, 0);
				
				if ( IsValidVehicle( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] ) ) {
					StartVehicleAlarm(PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] ) ;
				}
				Picklock_CloseGUI(playerid) ;

				if ( Character [ playerid ] [ E_CHARACTER_LOCKPICK ] <= 0 ) {

					Character [ playerid ] [ E_CHARACTER_LOCKPICK ] = 0 ;
				}

				mysql_format(mysql, query, sizeof ( query), "UPDATE characters SET player_lockpicks = %d WHERE player_id = %d", 
					Character [ playerid ] [ E_CHARACTER_LOCKPICK ], Character [ playerid ] [ E_CHARACTER_ID ]
				) ;

				mysql_tquery(mysql, query);
			}
		}

		if ( newkeys & KEY_CTRL_BACK ) { // push pin

			new Float: lesser, Float: more ;

			lesser = PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] - LOCKPICK_MARGIN; 
			more = PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] + LOCKPICK_MARGIN ; 


			if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] > lesser && PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] < more ) {

				GameTextForPlayer(playerid, "~g~Hit!", 1500, 3);

				PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_TIER ] ++ ;
				Lockpick_ProcessStage(playerid);
			}

			else {

				GameTextForPlayer(playerid, "~r~Miss!", 1500, 3);

				GameTextForPlayer(playerid, "~r~Lockpick has been broken due to failed attempts!", 3500, 3);				
				PlayerPlaySound(playerid, 34605, 0, 0, 0);

				Picklock_CloseGUI(playerid) ;				

				if ( IsValidVehicle( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] ) ) {
					StartVehicleAlarm(PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] ) ;
				}
				Character [ playerid ] [ E_CHARACTER_LOCKPICK ] -- ;
				// Ran out of lockpicks, reset to 0 to avoid -1!

				if ( Character [ playerid ] [ E_CHARACTER_LOCKPICK ] <= 0 ) {

					Character [ playerid ] [ E_CHARACTER_LOCKPICK ] = 0 ;
				}

				mysql_format(mysql, query, sizeof ( query), "UPDATE characters SET player_lockpicks = %d WHERE player_id = %d", 
					Character [ playerid ] [ E_CHARACTER_LOCKPICK ], Character [ playerid ] [ E_CHARACTER_ID ]
				) ;

				mysql_tquery(mysql, query);
			}

		}
	}
	
	#if defined lockpick_OnPlayerKeyStateChange
		return lockpick_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange lockpick_OnPlayerKeyStateChange
#if defined lockpick_OnPlayerKeyStateChange
	forward lockpick_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
