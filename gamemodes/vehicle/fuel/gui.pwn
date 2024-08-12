new PlayerText:fuel_player_gui[MAX_PLAYERS][10] = { PlayerText: INVALID_TEXT_DRAW, ... };

Fuel_ShowPlayerGUI(playerid, type) {
	Fuel_HidePlayerGUI(playerid);


	PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][0] ) ;

	// Changing fuel background
	switch ( type ) {

		case E_FUEL_TYPE_NONE:		PlayerTextDrawSetString(playerid, fuel_player_gui[playerid][1], "0");	
		case E_FUEL_TYPE_RON:		PlayerTextDrawSetString(playerid, fuel_player_gui[playerid][1], "mdl-29992:texture4041");	
		case E_FUEL_TYPE_GLOBEOIL:	PlayerTextDrawSetString(playerid, fuel_player_gui[playerid][1], "mdl-29992:texture4043");
		case E_FUEL_TYPE_TERROIL:	PlayerTextDrawSetString(playerid, fuel_player_gui[playerid][1], "mdl-29992:texture4042");
	}

	PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][1] ) ;

	new description [ 80 ] ;
	Fuel_GetDescription(type, description);

	// Setting name per gas station type! (GetDescription)
	PlayerTextDrawSetString ( playerid, fuel_player_gui[playerid][8], description);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][8], Fuel_GetHexColor(type));
	PlayerTextDrawShow(playerid, fuel_player_gui[playerid][8]);

	// Default nozzle (stuck on textdraw)
	PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][2] ) ;

	// Prices! Adjust per type.
	PlayerTextDrawSetString(playerid,  fuel_player_gui[playerid][4], sprintf("$%d", Fuel_GetFuelPrice ( type, E_FUEL_NOZZLE_AMOUNT_LOW )));
	PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][4] ) ;
	PlayerTextDrawSetString(playerid,  fuel_player_gui[playerid][5], sprintf("$%d", Fuel_GetFuelPrice ( type, E_FUEL_NOZZLE_AMOUNT_MED )));
	PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][5] ) ;
	PlayerTextDrawSetString(playerid,  fuel_player_gui[playerid][6], sprintf("$%d", Fuel_GetFuelPrice ( type, E_FUEL_NOZZLE_AMOUNT_HIGH )));
	PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][6] ) ;


	PlayerTextDrawShow(playerid, fuel_player_gui[playerid][9]);
}

Fuel_DestroyPlayerGUI(playerid) {

	
	for ( new i, j = 10; i < j ; i ++ ) {

		PlayerTextDrawDestroy ( playerid, fuel_player_gui [ playerid ] [ i ] ) ;
	}

	Fuel_OnDestroyPlayerGui_Extra(playerid) ;
}
Fuel_HidePlayerGUI(playerid) {

	for ( new i, j = 10; i < j ; i ++ ) {

		PlayerTextDrawHide ( playerid, fuel_player_gui [ playerid ] [ i ] ) ;
	}
	Fuel_OnHidePlayerGui_Extra(playerid);
}

Fuel_OnLoadPlayerGUI(playerid) {

	if ( ! IsPlayerConnected ( playerid ) ) {

		return true ;
	}

	fuel_player_gui[playerid][0] = CreatePlayerTextDraw(playerid, 200.0000, 100.0000, "_");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][0], 0.5000, 29.2000);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, fuel_player_gui[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, fuel_player_gui[playerid][0], 255);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][0], 450.0000, 0.0000);

	fuel_player_gui[playerid][1] = CreatePlayerTextDraw(playerid, 200.0000, 100.0000, "mdl-29992:texture4041");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][1], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][1], 250.0000, 300.0000);

	fuel_player_gui[playerid][2] = CreatePlayerTextDraw(playerid, 395.0000, 214.0000, "mdl-29992:nozzle");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][2], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][2], 17.5000, 130.0000);

	fuel_player_gui[playerid][3] = CreatePlayerTextDraw(playerid, 228.0000, 187.0000, "mdl-29992:nozzle_out");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][3], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][3], 200.0000, 80.0000);

	fuel_player_gui[playerid][4] = CreatePlayerTextDraw(playerid, 335.0000, 227.5000, "$0");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][4], 0.2000, 1.00);
	PlayerTextDrawAlignment(playerid, fuel_player_gui[playerid][4], 2);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][4], 0.0000, 0.0000);

	fuel_player_gui[playerid][5] = CreatePlayerTextDraw(playerid, 357.0000, 227.5000, "$0");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][5], 0.2000, 1.00);
	PlayerTextDrawAlignment(playerid, fuel_player_gui[playerid][5], 2);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][5], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][5], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][5], 0.0000, 0.0000);

	fuel_player_gui[playerid][6] = CreatePlayerTextDraw(playerid, 380.0000, 227.5000, "$0");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][6], 0.2000, 1.00);
	PlayerTextDrawAlignment(playerid, fuel_player_gui[playerid][6], 2);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][6], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][6], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][6], 0.0000, 0.0000);

	fuel_player_gui[playerid][7] = CreatePlayerTextDraw(playerid, 228.5000, 321.5000, "0'/.~n~~g~$0__");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][7], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, fuel_player_gui[playerid][7], 2);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][7], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][7], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][7], 0.0000, 500.0000);

	fuel_player_gui[playerid][8] = CreatePlayerTextDraw(playerid, 328.5000, 101.5000, "RON PETROL AND OIL");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][8], 0.3000, 1.2500);
	PlayerTextDrawAlignment(playerid, fuel_player_gui[playerid][8], 2);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][8], -8433409);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][8], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][8], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][8], 0.0000, 500.0000);


	fuel_player_gui[playerid][9] = CreatePlayerTextDraw(playerid, 328.5000, 351.5000, "Use ~r~~k~~VEHICLE_FIREWEAPON~ ~w~to use the pump nozzle");
	PlayerTextDrawFont(playerid, fuel_player_gui[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui[playerid][9], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, fuel_player_gui[playerid][9], 2);
	PlayerTextDrawColor(playerid, fuel_player_gui[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui[playerid][9], 1);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui[playerid][9], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui[playerid][9], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui[playerid][9], 0.0000, 500.0000);

	Fuel_OnLoadPlayerGui_Extra(playerid ) ;

	return 1;
}
