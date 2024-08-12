enum {

	E_HOTWIRE_COLOUR_A = 0x45B141FF, // green
	E_HOTWIRE_COLOUR_B = 0xB17841FF, // orange
	E_HOTWIRE_COLOUR_C = 0xB14141FF, // red
	E_HOTWIRE_COLOUR_D = 0xB14190FF, // purple
	E_HOTWIRE_COLOUR_E = 0x4177B1FF // blue
} ;

enum {

	E_HOTWIRE_WIRE_GREEN = 0,
	E_HOTLINE_WIRE_ORANGE,
	E_HOTLINE_WIRE_RED,
	E_HOTLINE_WIRE_PURPLE,
	E_HOTLINE_WIRE_BLUE
} ;

Hotwire_GetWireColor ( constant ) {

	new color = 0xA3A3A3FF ;

	switch ( constant ) {
		case E_HOTWIRE_WIRE_GREEN:		color = E_HOTWIRE_COLOUR_A  ;
		case E_HOTLINE_WIRE_ORANGE:		color = E_HOTWIRE_COLOUR_B  ;
		case E_HOTLINE_WIRE_RED:		color = E_HOTWIRE_COLOUR_C  ;
		case E_HOTLINE_WIRE_PURPLE:		color = E_HOTWIRE_COLOUR_D  ;
		case E_HOTLINE_WIRE_BLUE:		color = E_HOTWIRE_COLOUR_E  ;
	}

	return color ;
}


Hotwire_SetupForPlayer ( playerid, vehicleid ) {

	if ( vehicleid == INVALID_VEHICLE_ID ) {
		Hotwire_CloseMenu(playerid);
		return true;
	}

	if ( GetPlayerState(playerid) != PLAYER_STATE_DRIVER ) {
		Hotwire_CloseMenu(playerid);
		return true;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {
		Hotwire_CloseMenu(playerid);
		return true ;
	}

	if ( IsPlayerIncapacitated(playerid, false)) {
		Hotwire_CloseMenu(playerid);
		return true ;
	}

	ShowPlayerSubtitle( playerid, "To hotwire the car, connect the same coloured top row wires with the bottom row wires.", .showtime = 6000 ) ;

	Hotwire_RandomizeWires(playerid) ; 

	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 0 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 1 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 2 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 3 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 8 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ] ));


	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 5 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 6 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 7 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 4 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ] ));
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid] [ 9 ], Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ] ));

	for ( new i, j = sizeof (hotwire_gui) ; i < j ; i ++ ) {
			
		TextDrawShowForPlayer(playerid, hotwire_gui [ i ] ) ;
	}

	for ( new i, j = 10 ; i < j ; i ++ ) {
		
		PlayerTextDrawShow(playerid, hotwire_player_gui[playerid] [ i ] ) ;
	}

	PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING_VEHICLEID ] = vehicleid ;
	PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = -1 ;
 	PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING ] = true ;
 	PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] = 5 ;
	SelectTextDraw(playerid, 0xDE1F1FFF ) ;

	return true ;
}

Hotwire_CheckProgress ( playerid ) {
	new vehicleid = GetPlayerVehicleID(playerid) ;

	if ( vehicleid == INVALID_VEHICLE_ID ) {
		Hotwire_CloseMenu(playerid);
		return true;
	}

	if ( GetPlayerState(playerid) != PLAYER_STATE_DRIVER ) {
		Hotwire_CloseMenu(playerid);
		return true;
	}
	

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {
		Hotwire_CloseMenu(playerid);
		return true ;
	}

	if ( IsPlayerIncapacitated(playerid, false)) {
		Hotwire_CloseMenu(playerid);
		return true ;
	}

	PlayerPlaySound(playerid, 6003, 0, 0, 0);
	GameTextForPlayer(playerid, "~g~Wire stripped and connected!", 1500, 3);

	// Player has finished hotwiring.
	if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] <= 0 ) {
		for ( new i, j = sizeof (hotwire_gui) ; i < j ; i ++ ) {
				
			TextDrawHideForPlayer(playerid, hotwire_gui [ i ] ) ;
		}

		CancelSelectTextDraw(playerid);
		SetEngineStatus(PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING_VEHICLEID ], true);   
		ClearAlarmData ( vehicleid ) ;

		PlayerPlaySound(playerid, 182, 0, 0, 0);     

		ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("has hotwired the engine of the %s.", ReturnVehicleName ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING_VEHICLEID ] ) ), .annonated=true ) ;

		ShowPlayerSubtitle( playerid, "You've hotwired the car. You can use it freely or bring it to the chopshop for profit.", .showtime=6000 ) ;

		GameTextForPlayer(playerid, "~g~Vehicle hotwired!", 1500, 3);
	}

	return true ;
}


Hotwire_RandomizeWires(playerid) {

	new integer = random ( 5 ) ;

	switch ( integer ) {

		case 0: {

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ]  = E_HOTWIRE_WIRE_GREEN ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ]  = E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ]  = E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ]  = E_HOTLINE_WIRE_PURPLE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ]  = E_HOTLINE_WIRE_RED ;

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ]  = E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ]  = E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ]  = E_HOTWIRE_WIRE_GREEN ;	
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ]  = E_HOTLINE_WIRE_RED ;		
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ]  = E_HOTLINE_WIRE_PURPLE ;	
		}

		case 1: {

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ]  = E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ]  = E_HOTWIRE_WIRE_GREEN ;	
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ]  = E_HOTLINE_WIRE_RED ;	
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ]  = E_HOTLINE_WIRE_ORANGE ;	
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ]  = E_HOTLINE_WIRE_PURPLE ;	

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ]  = E_HOTLINE_WIRE_PURPLE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ]  = E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ]  = E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ]  = E_HOTWIRE_WIRE_GREEN ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ]  = E_HOTLINE_WIRE_RED ;
		}
		case 2: {

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ]  = E_HOTLINE_WIRE_BLUE ;	
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ]  = E_HOTLINE_WIRE_PURPLE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ]  = E_HOTWIRE_WIRE_GREEN ;	
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ]  = E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ]  = E_HOTLINE_WIRE_RED ;	

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ]  = E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ]  = E_HOTWIRE_WIRE_GREEN ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ]  = E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ]  = E_HOTLINE_WIRE_RED ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ]  = E_HOTLINE_WIRE_PURPLE ;
		}
		case 3: {

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ]  =  E_HOTLINE_WIRE_PURPLE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ]  =  E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ]  =  E_HOTWIRE_WIRE_GREEN ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ]  =  E_HOTLINE_WIRE_RED ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ]  =  E_HOTLINE_WIRE_ORANGE ;

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ]  =  E_HOTLINE_WIRE_RED ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ]  =  E_HOTWIRE_WIRE_GREEN ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ]  =  E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ]  =  E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ]  =  E_HOTLINE_WIRE_PURPLE ;
		}

		case 4: {

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ]  =   E_HOTLINE_WIRE_RED ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ]  =   E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ]  =   E_HOTLINE_WIRE_PURPLE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ]  =   E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ]  =   E_HOTWIRE_WIRE_GREEN ;

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ]  =   E_HOTLINE_WIRE_PURPLE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ]  =   E_HOTLINE_WIRE_ORANGE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ]  =   E_HOTWIRE_WIRE_GREEN ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ]  =   E_HOTLINE_WIRE_BLUE ;
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ]  =   E_HOTLINE_WIRE_RED ;
		}
	}
}