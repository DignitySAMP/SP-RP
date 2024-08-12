new Text:g_VehicleSpeedoV2[3] = Text: INVALID_TEXT_DRAW ;
new PlayerText:p_VehicleSpeedoV2[MAX_PLAYERS][2] = { PlayerText: INVALID_TEXT_DRAW, ... } ;
new PlayerBar:p_VehicleSpeedoBarV2[MAX_PLAYERS] = PlayerBar: INVALID_PLAYER_BAR_ID ;

public OnGameModeInit() {

	g_VehicleSpeedoV2[0] = TextDrawCreate(499.0000, 101.0000, "MPH");
	TextDrawFont(g_VehicleSpeedoV2[0], 2);
	TextDrawLetterSize(g_VehicleSpeedoV2[0], 0.3000, 1.0000);
	TextDrawColor(g_VehicleSpeedoV2[0], -1613958913);
	TextDrawSetShadow(g_VehicleSpeedoV2[0], 0);
	TextDrawSetOutline(g_VehicleSpeedoV2[0], 1);
	TextDrawBackgroundColor(g_VehicleSpeedoV2[0], 255);
	TextDrawSetProportional(g_VehicleSpeedoV2[0], 1);
	TextDrawTextSize(g_VehicleSpeedoV2[0], 0.0000, 0.0000);

	g_VehicleSpeedoV2[1] = TextDrawCreate(499.0000, 111.0000, "Fuel");
	TextDrawFont(g_VehicleSpeedoV2[1], 2);
	TextDrawLetterSize(g_VehicleSpeedoV2[1], 0.3000, 1.0000);
	TextDrawColor(g_VehicleSpeedoV2[1], -1613958913);
	TextDrawSetShadow(g_VehicleSpeedoV2[1], 0);
	TextDrawSetOutline(g_VehicleSpeedoV2[1], 1);
	TextDrawBackgroundColor(g_VehicleSpeedoV2[1], 255);
	TextDrawSetProportional(g_VehicleSpeedoV2[1], 1);
	TextDrawTextSize(g_VehicleSpeedoV2[1], 0.0000, 0.0000);

	g_VehicleSpeedoV2[2] = TextDrawCreate(499.0000, 121.0000, "Miles");
	TextDrawFont(g_VehicleSpeedoV2[2], 2);
	TextDrawLetterSize(g_VehicleSpeedoV2[2], 0.3000, 1.0000);
	TextDrawColor(g_VehicleSpeedoV2[2], -1613958913);
	TextDrawSetShadow(g_VehicleSpeedoV2[2], 0);
	TextDrawSetOutline(g_VehicleSpeedoV2[2], 1);
	TextDrawBackgroundColor(g_VehicleSpeedoV2[2], 255);
	TextDrawSetProportional(g_VehicleSpeedoV2[2], 1);
	TextDrawTextSize(g_VehicleSpeedoV2[2], 0.0000, 0.0000);

	#if defined vehGUI_OnGameModeInit
		return vehGUI_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit vehGUI_OnGameModeInit
#if defined vehGUI_OnGameModeInit
	forward vehGUI_OnGameModeInit();
#endif

public OnPlayerConnect(playerid) {

	p_VehicleSpeedoV2[playerid][0] = CreatePlayerTextDraw(playerid, 609.0000, 101.0000, "0");
	PlayerTextDrawFont(playerid, p_VehicleSpeedoV2[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, p_VehicleSpeedoV2[playerid][0], 0.3000, 1.0000);
	PlayerTextDrawAlignment(playerid, p_VehicleSpeedoV2[playerid][0], 3);
	PlayerTextDrawColor(playerid, p_VehicleSpeedoV2[playerid][0], -1613958913);
	PlayerTextDrawSetShadow(playerid, p_VehicleSpeedoV2[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, p_VehicleSpeedoV2[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, p_VehicleSpeedoV2[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, p_VehicleSpeedoV2[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, p_VehicleSpeedoV2[playerid][0], 0.0000, 0.0000);

	p_VehicleSpeedoV2[playerid][1] = CreatePlayerTextDraw(playerid, 609.0000, 121.0000, "0");
	PlayerTextDrawFont(playerid, p_VehicleSpeedoV2[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, p_VehicleSpeedoV2[playerid][1], 0.3000, 1.0000);
	PlayerTextDrawAlignment(playerid, p_VehicleSpeedoV2[playerid][1], 3);
	PlayerTextDrawColor(playerid, p_VehicleSpeedoV2[playerid][1], -1613958913);
	PlayerTextDrawSetShadow(playerid, p_VehicleSpeedoV2[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, p_VehicleSpeedoV2[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, p_VehicleSpeedoV2[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, p_VehicleSpeedoV2[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, p_VehicleSpeedoV2[playerid][1], 0.0000, 0.0000);

//<<<<<<< HEAD
//<<<<<<< HEAD
	p_VehicleSpeedoBarV2 [ playerid ] = PlayerBar: INVALID_PLAYER_BAR_ID ;
	
//=======
    p_VehicleSpeedoBarV2[playerid] = CreatePlayerProgressBar(playerid, 564.000000, 114.000000, 47.500000, 3.699999, -1429936641, 100.0000, 0);

//>>>>>>> parent of 3b17ac3 (Unglobalizing gym progress bar / extra changes)
//=======
//>>>>>>> parent of b168bbf (Wiping progress bar variables on connect)
	#if defined vehGUI_OnPlayerConnect
		return vehGUI_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect vehGUI_OnPlayerConnect
#if defined vehGUI_OnPlayerConnect
	forward vehGUI_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason) {
	

	PlayerTextDrawDestroy ( playerid, p_VehicleSpeedoV2[playerid][0] );
	PlayerTextDrawDestroy ( playerid, p_VehicleSpeedoV2[playerid][1] );

	DestroyPlayerProgressBar(playerid,  p_VehicleSpeedoBarV2[playerid]);

	#if defined vehGUI_OnPlayerDisconnect
		return vehGUI_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect vehGUI_OnPlayerDisconnect
#if defined vehGUI_OnPlayerDisconnect
	forward vehGUI_OnPlayerDisconnect(playerid, reason);
#endif

ShowVehicleGUI(playerid) {
	if ( ! Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] ) {

		return true ;
	}

	new vehicleid = GetPlayerVehicleID(playerid);

	if ( IsPlayerInVehicle ( playerid, vehicleid ) ) {

		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
		TextDrawShowForPlayer ( playerid, g_VehicleSpeedoV2[0] ) ;
		TextDrawShowForPlayer ( playerid, g_VehicleSpeedoV2[1] ) ;
		TextDrawShowForPlayer ( playerid, g_VehicleSpeedoV2[2] ) ;

		PlayerTextDrawSetString(playerid, p_VehicleSpeedoV2 [ playerid ] [ 0 ], sprintf("%d", TRP_GetVehicleSpeed(vehicleid)));
		PlayerTextDrawSetString(playerid, p_VehicleSpeedoV2 [ playerid ] [ 0 ], sprintf("%d", Vehicle [ veh_enum_id ] [ E_VEHICLE_MILEAGE ] ));
		SetPlayerProgressBarValue ( playerid, p_VehicleSpeedoBarV2[playerid], float(Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL])) ;

		PlayerTextDrawShow(playerid, p_VehicleSpeedoV2[playerid][0] );
		PlayerTextDrawShow(playerid, p_VehicleSpeedoV2[playerid][1] );
		ShowPlayerProgressBar(playerid, p_VehicleSpeedoBarV2[playerid]  );
	}

	return true ;
}
HideVehicleGUI(playerid) {

	TextDrawHideForPlayer ( playerid, g_VehicleSpeedoV2[0] ) ;
	TextDrawHideForPlayer ( playerid, g_VehicleSpeedoV2[1] ) ;
	TextDrawHideForPlayer ( playerid, g_VehicleSpeedoV2[2] ) ;

	PlayerTextDrawHide(playerid, p_VehicleSpeedoV2[playerid][0] );
	PlayerTextDrawHide(playerid, p_VehicleSpeedoV2[playerid][1] );
	HidePlayerProgressBar(playerid, p_VehicleSpeedoBarV2[playerid]  );

	return true ;
}

static passenger, speedstr[16], mileagestr[16], Float:fuel;
timer OnPlayerDrive[750](playerid, vehicleid) {

	if ( IsPlayerInVehicle ( playerid, vehicleid ) ) {

		if (!IsEngineVehicle(vehicleid)) {
			HideVehicleGUI(playerid);
			return true ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] ) {

			new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
			format(speedstr, sizeof(speedstr), "%d", TRP_GetVehicleSpeed(vehicleid));
			format(mileagestr, sizeof(mileagestr), "%d", Vehicle [ veh_enum_id ] [ E_VEHICLE_MILEAGE ]);
			fuel = float(Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL]);

			PlayerTextDrawSetString(playerid, p_VehicleSpeedoV2 [ playerid ] [ 0 ], speedstr);
			PlayerTextDrawSetString(playerid, p_VehicleSpeedoV2 [ playerid ] [ 1 ], mileagestr);
			SetPlayerProgressBarValue ( playerid, p_VehicleSpeedoBarV2[playerid], fuel ) ;

			// Sporky:  New:  Frontseat passenger too (acessing cached variable to get the passenger instead of looping all players)
			passenger = Vehicle[veh_enum_id][E_VEHICLE_PASSENGER];
			if (GetPlayerVehicleID(passenger) == vehicleid)
			{
				PlayerTextDrawSetString(passenger, p_VehicleSpeedoV2 [ passenger ] [ 0 ], speedstr);
				PlayerTextDrawSetString(passenger, p_VehicleSpeedoV2 [ passenger ] [ 1 ], mileagestr);
				SetPlayerProgressBarValue(passenger, p_VehicleSpeedoBarV2[passenger], fuel ) ;
			}
		}
		
		defer OnPlayerDrive(playerid, vehicleid) ;
	}

	return true ;
}