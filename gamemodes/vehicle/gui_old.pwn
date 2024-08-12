new PlayerText:GUI_SPEEDO_MPH = PlayerText: INVALID_TEXT_DRAW ;
new PlayerText:GUI_FUEL_MPH = PlayerText: INVALID_TEXT_DRAW ;
new PlayerText:GUI_NOS_MPH = PlayerText: INVALID_TEXT_DRAW ;

Vehicle_DestroyPlayerOldGUI(playerid) {

	PlayerTextDrawDestroy(playerid, GUI_SPEEDO_MPH ) ;
	PlayerTextDrawDestroy(playerid, GUI_NOS_MPH ) ;
	PlayerTextDrawDestroy(playerid, GUI_FUEL_MPH ) ;
}

Vehicle_HidePlayerOldGUI(playerid) {

	PlayerTextDrawHide ( playerid, GUI_SPEEDO_MPH ) ;
	PlayerTextDrawHide ( playerid, GUI_NOS_MPH ) ;
	PlayerTextDrawHide ( playerid, GUI_FUEL_MPH ) ;
}

Vehicle_LoadPlayerGUI(playerid) {
	
	GUI_SPEEDO_MPH = CreatePlayerTextDraw(playerid, 540.0000, 315.0000, "mdl-29997:0");
	PlayerTextDrawFont(playerid, GUI_SPEEDO_MPH, 4);
	PlayerTextDrawLetterSize(playerid, GUI_SPEEDO_MPH, 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, GUI_SPEEDO_MPH, -1);
	PlayerTextDrawSetShadow(playerid, GUI_SPEEDO_MPH, 0);
	PlayerTextDrawSetOutline(playerid, GUI_SPEEDO_MPH, 0);
	PlayerTextDrawBackgroundColor(playerid, GUI_SPEEDO_MPH, 255);
	PlayerTextDrawSetProportional(playerid, GUI_SPEEDO_MPH, 1);
	PlayerTextDrawTextSize(playerid, GUI_SPEEDO_MPH, 90.0000, 105.0000);

	GUI_NOS_MPH = CreatePlayerTextDraw(playerid, 612.500, 325.0000, "mdl-29998:0");
	PlayerTextDrawFont(playerid, GUI_NOS_MPH, 4);
	PlayerTextDrawLetterSize(playerid, GUI_NOS_MPH, 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, GUI_NOS_MPH, -1);
	PlayerTextDrawSetShadow(playerid, GUI_NOS_MPH, 0);
	PlayerTextDrawSetOutline(playerid, GUI_NOS_MPH, 0);
	PlayerTextDrawBackgroundColor(playerid, GUI_NOS_MPH, 255);
	PlayerTextDrawSetProportional(playerid, GUI_NOS_MPH, 1);
	PlayerTextDrawTextSize(playerid, GUI_NOS_MPH, 30.0000, 75.0000);

	GUI_FUEL_MPH = CreatePlayerTextDraw(playerid,515.000, 320.00, "mdl-29999:0");
	PlayerTextDrawFont(playerid, GUI_FUEL_MPH, 4);
	PlayerTextDrawLetterSize(playerid, GUI_FUEL_MPH, 90.0000, 105.0000);
	PlayerTextDrawColor(playerid, GUI_FUEL_MPH, -1);
	PlayerTextDrawSetShadow(playerid, GUI_FUEL_MPH, 0);
	PlayerTextDrawSetOutline(playerid, GUI_FUEL_MPH, 0);
	PlayerTextDrawBackgroundColor(playerid, GUI_FUEL_MPH, 255);
	PlayerTextDrawSetProportional(playerid, GUI_FUEL_MPH, 1);
	PlayerTextDrawTextSize(playerid, GUI_FUEL_MPH, 90.0000, 105.0000);


	return true ;
}


Vehicle_HidePlayerGUI(playerid) {

	Vehicle_HidePlayerOldGUI ( playerid );

}

Vehicle_OnPlayerUpdateGUI(playerid, vehicleid) {

	if (!IsEngineVehicle(vehicleid)) {

		PlayerTextDrawHide(playerid, GUI_SPEEDO_MPH ) ;
		return true ;
	}

	if ( Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] ) {

		Vehicle_OnPlayerUpdateNewGUI ( playerid, vehicleid );
		PlayerTextDrawShow(playerid, GUI_SPEEDO_MPH ) ;

	}

	return true ;
}

Vehicle_OnPlayerUpdateNewGUI(playerid, vehicleid) {
	// To be used when a player is IN a vehicle, 
	// So not on OnPlayerEnterVehicle but on StateChange...


	if ( GetVehicleDriver ( vehicleid ) != playerid ) {

		return false ;
	}

	if (!IsEngineVehicle(vehicleid)) {

		PlayerTextDrawHide(playerid, GUI_SPEEDO_MPH ) ;
		return true ;
	}

	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	if ( veh_enum_id == -1 ) {

		return false ;
	}

	new fuel = Vehicle [ veh_enum_id  ] [ E_VEHICLE_FUEL ] ;


	PlayerTextDrawHide(playerid, GUI_FUEL_MPH ) ;

	switch ( fuel ) {

		case 0 .. 15:		PlayerTextDrawSetString ( playerid, GUI_FUEL_MPH, "mdl-29999:5");
		case 16 .. 30 :		PlayerTextDrawSetString ( playerid, GUI_FUEL_MPH, "mdl-29999:4");
		case 31 .. 45 :		PlayerTextDrawSetString ( playerid, GUI_FUEL_MPH, "mdl-29999:3");
		case 46 .. 60 :		PlayerTextDrawSetString ( playerid, GUI_FUEL_MPH, "mdl-29999:2");
		case 61 .. 75 :		PlayerTextDrawSetString ( playerid, GUI_FUEL_MPH, "mdl-29999:1");
		case 76 .. 100 :	PlayerTextDrawSetString ( playerid, GUI_FUEL_MPH, "mdl-29999:0");
	}

	PlayerTextDrawShow(playerid, GUI_FUEL_MPH ) ;


	//if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_NOS ] ) {

	//	Vehicle_UpdateNosGUI(playerid, veh_enum_id) ;
	//	PlayerTextDrawShow ( playerid, GUI_NOS_MPH ) ;
	//}

	/*
	PlayerTextDrawSetString(playerid, gui_veh_ptd[1], sprintf("%s", 

		(PlayerVar [ playerid ] [ player_hasseatbelton ])
    		? ("~p~Seatbelt: ~w~On")
    		: ("~p~Seatbelt: ~w~Off")
	) );

	PlayerTextDrawSetString(playerid, gui_veh_ptd[3], sprintf("%s", 

		(Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ])
    		? ("~p~Windows: ~w~Up")
    		: ("~p~Windows: ~w~Down")
	) );

	PlayerTextDrawSetString(playerid, gui_veh_ptd[4], sprintf("%s", 

		(GetDoorStatus ( vehicleid ))
    		? ("~p~Doors: ~w~Locked")
    		: ("~p~Doors: ~w~Unlocked")
	) );

	PlayerTextDrawSetString(playerid, gui_veh_ptd[2], sprintf("%s", 

		(GetEngineStatus ( vehicleid ))
    		? ("~p~Engine: ~w~On")
    		: ("~p~Engine: ~w~Off")
	) );

	for ( new i, j = sizeof ( gui_veh_ptd ); i < j; i ++ ) {

		PlayerTextDrawShow(playerid, gui_veh_ptd[i]);
	}
	*/


	return true ;
}

timer OnPlayerDrive[750](playerid, vehicleid) {

	if ( IsPlayerInVehicle ( playerid, vehicleid ) ) {

		if (!IsEngineVehicle(vehicleid)) {

			PlayerTextDrawHide(playerid, GUI_SPEEDO_MPH ) ;
			return true ;
		}

		if ( ! GetEngineStatus ( vehicleid ) ) {

			PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:0" ) ;
		}

		else if ( GetEngineStatus(vehicleid) ) {

			switch ( floatround ( TRP_GetVehicleSpeed(vehicleid) ) ) {

				case 0 .. 5: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:0" ) ;
				case 6 .. 15: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:1" ) ;
				case 16 .. 25: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:2" ) ;
				case 26 .. 35: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:3" ) ;
				case 36 .. 45: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:4" ) ;
				case 46 .. 55: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:5" ) ;
				case 56 .. 65: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:6" ) ;
				case 66 .. 75: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:7" ) ;
				case 76 .. 85: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:8" ) ;
				case 86 .. 95: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:9" ) ;
				case 96 .. 500: PlayerTextDrawSetString(playerid, GUI_SPEEDO_MPH, "mdl-29997:10" ) ;
			}

			defer OnPlayerDrive(playerid, vehicleid) ;
		}
	}

	return true ;
}