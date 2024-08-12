
timer OnPlayerLockpick[400](playerid) {
	new vehicleid = Vehicle_GetClosestEntity(playerid) ;

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		Picklock_CloseGUI(playerid);
		return true;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] != Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) {

		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( IsPlayerIncapacitated(playerid, false)) {

		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( ! GetDoorStatus ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {
		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING ] ) {

		new Float: MIN_LOCKPICK_PRESSURE ;
		switch ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_TIER ] ) {

			case 0: MIN_LOCKPICK_PRESSURE = 15.0 ;
			case 1: MIN_LOCKPICK_PRESSURE = 30.0 ;
			case 2: MIN_LOCKPICK_PRESSURE = 45.0 ;
			case 3: MIN_LOCKPICK_PRESSURE = 60.0 ;
			case 4: MIN_LOCKPICK_PRESSURE = 75.0 ;
		}

		PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] -= frandom(1.0, 5.0 );

		if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] < MIN_LOCKPICK_PRESSURE ) {

			PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] = MIN_LOCKPICK_PRESSURE ;
		}

		new LOCKPICK_PIN_COLOUR ;
		switch ( floatround( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] ) ) {

			case 0 .. 2: 	LOCKPICK_PIN_COLOUR = 0xDEDEDEFF ;
			case 3 .. 5: 	LOCKPICK_PIN_COLOUR = 0xBFBFBFFF ;
			case 6 .. 8: 	LOCKPICK_PIN_COLOUR = 0xBFB9A0FF ;
			case 9 .. 10: 	LOCKPICK_PIN_COLOUR = 0xCFC28BFF ;
			case 11 .. 20: 	LOCKPICK_PIN_COLOUR = 0xD5C862FF ;
			case 21 .. 30: 	LOCKPICK_PIN_COLOUR = 0xC9C041FF ;
			case 31 .. 40: 	LOCKPICK_PIN_COLOUR = 0xC9A441FF ;
			case 41 .. 45: 	LOCKPICK_PIN_COLOUR = 0xC99341FF ;
			case 46 .. 50: 	LOCKPICK_PIN_COLOUR = 0xCB8339FF ;
			case 51 .. 55: 	LOCKPICK_PIN_COLOUR = 0xCC7923FF ;
			case 56 .. 60: 	LOCKPICK_PIN_COLOUR = 0xD05518FF ;
			case 61 .. 65: 	LOCKPICK_PIN_COLOUR = 0xD05518FF ;
			case 66 .. 70: 	LOCKPICK_PIN_COLOUR = 0xAD3A00FF ;
			case 71 .. 75: 	LOCKPICK_PIN_COLOUR = 0xC83E1EFF ;
			case 76 .. 85: 	LOCKPICK_PIN_COLOUR = 0xE02E14FF ;
			case 86 .. 95: 	LOCKPICK_PIN_COLOUR = 0xFA0000FF ;
		}


		PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][11]);
		PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][11], LOCKPICK_PIN_COLOUR );
		PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][11]);

		new Float: lesser, Float: more ;

		lesser = PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] - LOCKPICK_MARGIN; 
		more = PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] + LOCKPICK_MARGIN ; 

		if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] > lesser && PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] < more ) {

			PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][9], 0x3EC037FF) ;
		}

		else {
			PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][9], 0xDEDEDEFF) ;
		}

		PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][9]);
		PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][9]);

		PlayerTextDrawSetString(playerid, lp_gui_player_panel[playerid][9], sprintf("%0.2f", PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] ));

		defer OnPlayerLockpick(playerid);
	}

	return true ;
}


Lockpick_ProcessStage(playerid) {

	new vehicleid = Vehicle_GetClosestEntity(playerid) ;

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		Picklock_CloseGUI(playerid);
		return true;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] != Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) {

		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( IsPlayerIncapacitated(playerid, false)) {

		Picklock_CloseGUI(playerid);
		return true ;
	}

	if ( ! GetDoorStatus ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {
		Picklock_CloseGUI(playerid);
		return true ;
	}
	
	
	if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING ]  ) {

		new Float: MIN_LOCKPICK_PRESSURE ;
		PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] = frandom ( 15.0, 95.0 ) ; // 1: 30.0
		switch ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_TIER ] ) {

			case 0: MIN_LOCKPICK_PRESSURE = 15.0 ;
			case 1: MIN_LOCKPICK_PRESSURE = 30.0 ;
			case 2: MIN_LOCKPICK_PRESSURE = 45.0 ;
			case 3: MIN_LOCKPICK_PRESSURE = 60.0 ;
			case 4: MIN_LOCKPICK_PRESSURE = 75.0 ;
		}

		if ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] < MIN_LOCKPICK_PRESSURE ) {
			PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] = frandom ( MIN_LOCKPICK_PRESSURE, 95.0 ) ; // 1: 30.0
		}
 
		if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_DEVELOPER ) {

			SendClientMessage(playerid, -1, sprintf("DEV: tier(%d) | margin(%f)",PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_TIER ], PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] ) ) ;
		}
		
		switch ( PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_TIER ] ) {

			case 0: {

				PlayerTextDrawSetString(playerid, lp_gui_player_panel[playerid][9], "~r~15.00");

				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][10], 0.5000, -4.4000);
				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][11], 0.5000, -4.0000);
			}

			case 1: {

				PlayerTextDrawSetString(playerid, lp_gui_player_panel[playerid][9], "~r~30.00");

				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][10], 0.5000, -5.8500);
				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][11], 0.5000, -5.4500);


				PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][3]);
				PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][7]);
				PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][3], 363.5000, 0.0000); // FIRST BOTTOM BACKGROUND
				PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][7], 364.0000, 0.0000);// BOTTOM ROW
				PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][3]);
				PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][7]);
			}

			case 2: {
				PlayerTextDrawSetString(playerid, lp_gui_player_panel[playerid][9], "~r~45.00");

				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][10], 0.5000, -7.4000);
				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][11], 0.5000, -7.0000);

				PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][2]);
				PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][6]);
				PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][2], 363.5000, 0.0000); // SECOND BOTTOM BACKGROUND
				PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][6], 364.0000, 0.0000);// SECOND ROW
				PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][2]);
				PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][6]);
			}

			case 3: {
				PlayerTextDrawSetString(playerid, lp_gui_player_panel[playerid][9], "~r~60.00");

				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][10], 0.5000, -8.6500);
				PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][11], 0.5000, -8.2500);

				PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][1]);
				PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid][5]);
				PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][1], 363.5000, 0.0000); // FIRST BOTTOM BACKGROUND
				PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][5], 364.0000, 0.0000);// BOTTOM ROW
				PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][1]);
				PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][5]);

			}
			case 4: {

				GameTextForPlayer(playerid, "~g~Lock successfully picked!", 1500, 3);

				SetDoorStatus (  PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ], false ) ;
				Picklock_CloseGUI(playerid) ;

				ShowPlayerSubtitle( playerid, "You've picked the lock! There is no alarm, now all you need to do is hotwire the car...", .showtime = 6000 ) ;


				ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("has broken into the %s.", ReturnVehicleName ( vehicleid ) ), .annonated=true ) ;

				AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Lockpicked a %s (VID: %d, SQL ID: %d)", ReturnVehicleName(vehicleid), vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));

				Character [ playerid ] [ E_CHARACTER_LOCKPICK ] -- ;
				// Ran out of lockpicks, reset to 0 to avoid -1!

				if ( Character [ playerid ] [ E_CHARACTER_LOCKPICK ] <= 0 ) {

					Character [ playerid ] [ E_CHARACTER_LOCKPICK ] = 0 ;
				}

				new query [ 128 ] ;
				mysql_format(mysql, query, sizeof ( query), "UPDATE characters SET player_lockpicks = %d WHERE player_id = %d", 
					Character [ playerid ] [ E_CHARACTER_LOCKPICK ], Character [ playerid ] [ E_CHARACTER_ID ]
				) ;

				mysql_tquery(mysql, query);
				return true ;
			}
		}

		PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][10] ) ;
		PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid][11] ) ;
	}

	return true ;
}