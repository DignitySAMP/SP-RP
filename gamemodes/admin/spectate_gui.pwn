new PlayerText:gui_spec_label[MAX_PLAYERS][5] = { PlayerText: INVALID_TEXT_DRAW, ... };

GUI_DestroySpectatorPanel(playerid) {

	for ( new i, j = 5; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, gui_spec_label[playerid] [ i ] ) ;
	}
}

GUI_LoadSpectatorPanel(playerid) {

	gui_spec_label[playerid][0] = CreatePlayerTextDraw(playerid, 320.0000, 300.0000, "(0) Firstname_Lastname (Account)");
	PlayerTextDrawFont(playerid, gui_spec_label[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, gui_spec_label[playerid][0], 0.3499, 1.5000);
	PlayerTextDrawAlignment(playerid, gui_spec_label[playerid][0], 2);
	PlayerTextDrawColor(playerid, gui_spec_label[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, gui_spec_label[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, gui_spec_label[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_spec_label[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, gui_spec_label[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, gui_spec_label[playerid][0], 0.0000, 500.0000);

	gui_spec_label[playerid][1] = CreatePlayerTextDraw(playerid, 320.0000, 319.5000, "~w~Interior ~p~<1> ~w~World ~p~<2> ~w~Coords: ~p~<1234.56 7890.12 3456.78>");
	PlayerTextDrawFont(playerid, gui_spec_label[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, gui_spec_label[playerid][1], 0.2000, 0.8500);
	PlayerTextDrawAlignment(playerid, gui_spec_label[playerid][1], 2);
	PlayerTextDrawColor(playerid, gui_spec_label[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, gui_spec_label[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, gui_spec_label[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_spec_label[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, gui_spec_label[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, gui_spec_label[playerid][1], 0.0000, 500.0000);

	gui_spec_label[playerid][2] = CreatePlayerTextDraw(playerid, 320.0000, 329.5000, "State: ~r~ON FOOT~w~ Health: ~r~100.0 (client: 95)~w~ Armour: ~r~24.0 (client: 24.0)");
	PlayerTextDrawFont(playerid, gui_spec_label[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, gui_spec_label[playerid][2], 0.2000, 0.8500);
	PlayerTextDrawAlignment(playerid, gui_spec_label[playerid][2], 2);
	PlayerTextDrawColor(playerid, gui_spec_label[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, gui_spec_label[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, gui_spec_label[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_spec_label[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, gui_spec_label[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, gui_spec_label[playerid][2], 0.0000, 500.0000);

	gui_spec_label[playerid][3] = CreatePlayerTextDraw(playerid, 320.0000, 339.5000, "Packet Loss:~g~ 17.4'/.~w~ Ping:~g~ 64~w~ Drunk Level: ~g~234~w~ FPS: ~g~75");
	PlayerTextDrawFont(playerid, gui_spec_label[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, gui_spec_label[playerid][3], 0.2000, 0.8500);
	PlayerTextDrawAlignment(playerid, gui_spec_label[playerid][3], 2);
	PlayerTextDrawColor(playerid, gui_spec_label[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, gui_spec_label[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, gui_spec_label[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_spec_label[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, gui_spec_label[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, gui_spec_label[playerid][3], 0.0000, 500.0000);

	gui_spec_label[playerid][4] = CreatePlayerTextDraw(playerid, 320.0000, 349.5000, "Vehicle:~b~ None: ~y~MOD: 0, VID: 0~w~ Vehicle Health:~b~ 1000.0");
	PlayerTextDrawFont(playerid, gui_spec_label[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, gui_spec_label[playerid][4], 0.2000, 0.8500);
	PlayerTextDrawAlignment(playerid, gui_spec_label[playerid][4], 2);
	PlayerTextDrawColor(playerid, gui_spec_label[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, gui_spec_label[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, gui_spec_label[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_spec_label[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, gui_spec_label[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, gui_spec_label[playerid][4], 0.0000, 500.0000);

	return 1;
}

UpdateSpectatorPanel(playerid, targetid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] != targetid ) {

		for ( new i, j = 5; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid, gui_spec_label[playerid] [ i ] ) ;
		}

		SendClientMessage(playerid, COLOR_ERROR, "Hid spectator textdraws." ) ;

		return true ;
	}

	new 
		interiorid = GetPlayerInterior(targetid ), 
		worldid = GetPlayerVirtualWorld(targetid),
		Float: health = GetCharacterHealth ( targetid ),
		Float: armour = GetCharacterArmour ( targetid ),
		Float: packet_loss = NetStats_PacketLossPercent(targetid),
		ping = GetPlayerPing(targetid ),
		drunk_lvl = GetPlayerDrunkLevel(targetid),
		//fps = GetPlayerFPS(targetid) ;
		fps = -1 ;


	new coords[64], Float: x, Float: y, Float: z, Float: a  ;
	GetPlayerPos(targetid, x, y, z );
	GetPlayerFacingAngle(targetid, a);
	format ( coords, sizeof ( coords ), "<%0.2f, %0.2f, %0.2f, %0.2f>", x, y, z, a ) ;

	new pstate [ 32 ] ;
	GetStateName(GetPlayerState(targetid), pstate, sizeof ( pstate ) ) ;

	new vehicleid = GetPlayerVehicleID ( targetid ), 
	vehiclemodel = GetVehicleModel ( vehicleid ), Float: veh_health ;
	GetVehicleHealth(vehicleid, veh_health);
	new vehiclename [ 128 ] ;
	//strcat(vehiclename, ReturnVehicleName ( vehicleid ));
	format(vehiclename, sizeof(vehiclename), "Disabled");

	new Float: clienthealth, Float: clientarmour ;
	GetPlayerHealth(targetid, clienthealth);
	GetPlayerArmour(targetid, clientarmour);

	new td_string [ 512 ] ;
	format ( td_string, sizeof ( td_string), "(%d) %s (%s)", targetid, Character [ targetid ] [ E_CHARACTER_NAME ], Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ] ) ;
	PlayerTextDrawSetString(playerid, gui_spec_label[playerid][0], td_string);

	format ( td_string, sizeof ( td_string), "~w~Interior ~p~<%d> ~w~World ~p~<%d> ~w~Coords: ~p~<%s>", interiorid, worldid, coords );
	PlayerTextDrawSetString(playerid, gui_spec_label[playerid][1], td_string);

	format ( td_string, sizeof ( td_string), "State: ~r~%s~w~ Health: ~r~%0.1f (client: %0.1f)~w~ Armour: ~r~%0.1f (client: %0.1f)", pstate, health, clienthealth, armour, clientarmour );
	PlayerTextDrawSetString(playerid, gui_spec_label[playerid][2], td_string);

	format ( td_string, sizeof ( td_string), "Packet Loss:~g~ %0.2f'/.~w~ Ping:~g~ %d~w~ Drunk Level: ~g~%d~w~ FPS: ~g~%d", packet_loss, ping, drunk_lvl, fps);
	PlayerTextDrawSetString(playerid, gui_spec_label[playerid][3], td_string);

	format ( td_string, sizeof ( td_string), "Vehicle:~b~ %s: ~y~MOD: %d, VID: %d~w~ Vehicle Health:~b~ %0.2f", vehiclename, vehiclemodel, vehicleid, veh_health );
	PlayerTextDrawSetString(playerid, gui_spec_label[playerid][4], td_string);

	return true ;
}

