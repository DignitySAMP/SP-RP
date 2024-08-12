AbleToLockpickCar(playerid) {

	new vehicleid = Vehicle_GetClosestEntity(playerid) ;

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return false ;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return false ;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return false ;
	}

	if ( GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID ) {

		// Vehicle is occupied!
		return false ;
	}

	switch ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] ) {

		case E_VEHICLE_TYPE_PLAYER: {
			return true ;
		}

		case  E_VEHICLE_TYPE_DEFAULT: {

			return true ;
		}
	}

	return false ;
}


Picklock_ShowGUI(playerid) {
	new vehicleid = Vehicle_GetClosestEntity(playerid) ;

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		Picklock_CloseGUI(playerid);
		return true ;
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

	if ( ! AbleToLockpickCar(playerid)  ) {

		Picklock_CloseGUI(playerid);
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle can't be lockpicked.");
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING ] ) {
		// Set variables
		PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING ]  = true ;

		PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_TIER ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_MARGIN ] = 0.0 ;
		PlayerVar [ playerid ] [ E_PLAYER_LOCKPICK_PRESSURE ] = 0.0 ;

		// Restart all pins
		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][3], 335.5000, 0.0000); // FIRST BOTTOM BACKGROUND
		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][7], 337.0000, 0.0000);// BOTTOM ROW

		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][2], 335.5000, 0.0000); // SECOND BOTTOM BACKGROUND
		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][6], 337.0000, 0.0000);// SECOND ROW

		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][1], 335.5000, 0.0000); // FIRST BOTTOM BACKGROUND
		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][5], 337.0000, 0.0000);// BOTTOM ROW

		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][0], 335.5000, 0.0000); // FIRST BOTTOM BACKGROUND
		PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][4], 337.0000, 0.0000);// BOTTOM ROW

		ShowPlayerSubtitle( playerid, "Lockpicking a car requires patience and skill. You must wedge the lockpick into the lock and unhinge the slots. Carefully, or the ~r~alarm will trigger!", .showtime = 6000 ) ;
		ShowPlayerInfoMessage(playerid, "Use ~k~~CONVERSATION_YES~ to find the sweet spot. Press ~k~~GROUP_CONTROL_BWD~ to wedge it. Failing too often will break your lockpick and ~r~set off the alarm!", .height=167.5, .width=180, .showtime=6000);

		// Show GUI and init stage
		GUI_ShowLockpickGUI(playerid) ;
		Lockpick_ProcessStage(playerid);

		defer OnPlayerLockpick(playerid);
	}

	else SendClientMessage(playerid, COLOR_RED, "Finish your current lockpicking minigame first!" ) ;

	return true ;
}

Picklock_CloseGUI(playerid) {
	PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING ]  = false ;
	PlayerVar [ playerid ] [ E_PLAYER_LOCKPICKING_CAR ] = INVALID_VEHICLE_ID ;

	GUI_HideLockpickGUI(playerid);
	GUI_HideLockpickPlayerGUI(playerid) ;
}

