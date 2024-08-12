new Text:E_GYM_PROGRESS_GUI = Text: INVALID_TEXT_DRAW ;
new PlayerText:E_GYM_PROGRESS_PGUI[MAX_PLAYERS][3] = { PlayerText: INVALID_TEXT_DRAW, ... };

new Text:E_GYM_STATS_GUI[8] = Text: INVALID_TEXT_DRAW ;
new PlayerBar: E_GYM_STATS_GUI_BAR[MAX_PLAYERS][5] = { PlayerBar: INVALID_PLAYER_BAR_ID, ... };
new PlayerText:E_GYM_STATS_LVLS_GUI_BAR[MAX_PLAYERS][5] = { PlayerText: INVALID_PLAYER_BAR_ID, ... };

public OnGameModeInit() {
	
	LoadGymStatsGUI() ;
	LoadGymProgressGUI();

	#if defined gymhud_OnGameModeInit
		return gymhud_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit gymhud_OnGameModeInit
#if defined gymhud_OnGameModeInit
	forward gymhud_OnGameModeInit();
#endif

public OnPlayerConnect(playerid) {
	
	LoadGymProgressPGUI(playerid);
	LoadGymStatsPGUI(playerid);
	LoadGymStatsLvlGUI(playerid);

	#if defined gymhud_OnPlayerConnect
		return gymhud_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect gymhud_OnPlayerConnect
#if defined gymhud_OnPlayerConnect
	forward gymhud_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason) {
	
	DestroyGymProgressPGUI(playerid);
	DestroyGymStatsPGUI(playerid);
	DestroyGymStatsLvlGUI(playerid);

	#if defined gymhud_OnPlayerDisconnect
		return gymhud_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect gymhud_OnPlayerDisconnect
#if defined gymhud_OnPlayerDisconnect
	forward gymhud_OnPlayerDisconnect(playerid, reason);
#endif
LoadGymProgressPGUI(playerid) {
	
	E_GYM_PROGRESS_PGUI[playerid][0] = CreatePlayerTextDraw(playerid, 37.0000, 169.0000, "Muscle");
	PlayerTextDrawFont(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 0.3000, 1.2500);
	PlayerTextDrawAlignment(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 2);
	PlayerTextDrawColor(playerid, E_GYM_PROGRESS_PGUI[playerid][0], -555819265);
	PlayerTextDrawSetShadow(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_PROGRESS_PGUI[playerid][0], 0.0000, 0.0000);

	E_GYM_PROGRESS_PGUI[playerid][1] = CreatePlayerTextDraw(playerid, 56.0000, 171.5000, "mdl-30000:15");
	PlayerTextDrawFont(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, E_GYM_PROGRESS_PGUI[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_PROGRESS_PGUI[playerid][1], 55.0000, 8.0000);

	E_GYM_PROGRESS_PGUI[playerid][2] = CreatePlayerTextDraw(playerid, 115.5000, 171.0000, "+");
	PlayerTextDrawFont(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 2);
	PlayerTextDrawColor(playerid, E_GYM_PROGRESS_PGUI[playerid][2], -555819265);
	PlayerTextDrawSetShadow(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_PROGRESS_PGUI[playerid][2], 1);

	return true ;
}

DestroyGymProgressPGUI(playerid) {
	
	PlayerTextDrawDestroy ( playerid, E_GYM_PROGRESS_PGUI[playerid][0] ) ;
	PlayerTextDrawDestroy ( playerid, E_GYM_PROGRESS_PGUI[playerid][1] ) ;
	PlayerTextDrawDestroy ( playerid, E_GYM_PROGRESS_PGUI[playerid][2] ) ;

	return true ;
}

LoadGymProgressGUI() {
	/*
	E_GYM_PROGRESS_GUI = TextDrawCreate(19.5000, 170.0000, "_");
	TextDrawFont(E_GYM_PROGRESS_GUI, 1);
	TextDrawLetterSize(E_GYM_PROGRESS_GUI, 0.5000, 2.5000);
	TextDrawColor(E_GYM_PROGRESS_GUI, 170);
	TextDrawSetShadow(E_GYM_PROGRESS_GUI, 0);
	TextDrawSetOutline(E_GYM_PROGRESS_GUI, 0);
	TextDrawBackgroundColor(E_GYM_PROGRESS_GUI, 255);
	TextDrawSetProportional(E_GYM_PROGRESS_GUI, 1);
	TextDrawUseBox(E_GYM_PROGRESS_GUI, 1);
	TextDrawBoxColor(E_GYM_PROGRESS_GUI, 170);
	TextDrawTextSize(E_GYM_PROGRESS_GUI, 165.0000, 0.0000);*/
	E_GYM_PROGRESS_GUI = TextDrawCreate(19.5000, 168.0000, "_");
	TextDrawFont(E_GYM_PROGRESS_GUI, 1);
	TextDrawLetterSize(E_GYM_PROGRESS_GUI, 0.5000, 1.7000);
	TextDrawColor(E_GYM_PROGRESS_GUI, 170);
	TextDrawSetShadow(E_GYM_PROGRESS_GUI, 0);
	TextDrawSetOutline(E_GYM_PROGRESS_GUI, 0);
	TextDrawBackgroundColor(E_GYM_PROGRESS_GUI, 255);
	TextDrawSetProportional(E_GYM_PROGRESS_GUI, 1);
	TextDrawUseBox(E_GYM_PROGRESS_GUI, 1);
	TextDrawBoxColor(E_GYM_PROGRESS_GUI, 170);
	TextDrawTextSize(E_GYM_PROGRESS_GUI, 120.0000, 0.0000);	

	return true ;
}

public OnPlayerKeyStateChange ( playerid, newkeys, oldkeys ) {

	if ( (newkeys & KEY_SPRINT) && (newkeys & KEY_CROUCH) && (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ) {

		for ( new i, j = sizeof ( E_GYM_STATS_GUI ); i < j ; i ++ ) {
			TextDrawShowForPlayer ( playerid, E_GYM_STATS_GUI[i] ) ;
		}

		SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] )); // Muscle
		ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ] );
		SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] )); // Weight
		ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ] );
		SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] )); // Hunger
		ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ] );
		SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] )); // Thirst
		ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ] );
		SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] )); // Energy
		SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ], 100);
		SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ], 100);
		SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ], 100);
		SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ], 100);
		SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ], 100);

		ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ] );

		ShowGymStatsLvlGUI(playerid);

		SendClientMessage ( playerid, 0xDEDEDEFF, "Use ESC to hide the hud." ) ;
		SelectTextDraw(playerid, 0x00000000);

		PlayerVar [ playerid ] [ E_PLAYER_GYM_STATS_SHOWN ] = true ;
	}
	
	#if defined gymhud_OnPlayerKeyStateChange
		return gymhud_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange gymhud_OnPlayerKeyStateChange
#if defined gymhud_OnPlayerKeyStateChange
	forward gymhud_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerClickTextDraw(playerid, Text:clickedid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_STATS_SHOWN ] ) {
		if ( clickedid == Text: INVALID_TEXT_DRAW ) {
			for ( new i, j = sizeof ( E_GYM_STATS_GUI ); i < j ; i ++ ) {
				TextDrawHideForPlayer ( playerid, E_GYM_STATS_GUI[i] ) ;
			}
		
			HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ] );
			HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ] );
			HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ] );
			HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ] );
			HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ] );
		 	HideGymStatsLvlGUI(playerid);
			PlayerVar [ playerid ] [ E_PLAYER_GYM_STATS_SHOWN ]  = false ;
		}
	}

	#if defined gymhud_OnPlayerClickTextDraw
		return gymhud_OnPlayerClickTextDraw(playerid, Text: clickedid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw gymhud_OnPlayerClickTextDraw
#if defined gymhud_OnPlayerClickTextDraw
	forward gymhud_OnPlayerClickTextDraw(playerid, Text: clickedid);
#endif

LoadGymStatsPGUI(playerid) {

  	E_GYM_STATS_GUI_BAR [playerid] [ 0 ] = CreatePlayerProgressBar(playerid, 70.000000, 350.000000, 65.500000, 5.199999, 0xDEDEDEFF, 100.0000, 0);
    E_GYM_STATS_GUI_BAR [playerid] [ 1 ] = CreatePlayerProgressBar(playerid, 70.000000, 361.000000, 65.500000, 5.199999, 0xDEDEDEFF, 100.0000, 0);
    E_GYM_STATS_GUI_BAR [playerid] [ 2 ] = CreatePlayerProgressBar(playerid, 70.000000, 372.000000, 65.500000, 5.199999, 0xDEDEDEFF, 100.0000, 0);
    E_GYM_STATS_GUI_BAR [playerid] [ 3 ] = CreatePlayerProgressBar(playerid, 70.000000, 383.000000, 65.500000, 5.199999, 0xDEDEDEFF, 100.0000, 0);
    E_GYM_STATS_GUI_BAR [playerid] [ 4 ] = CreatePlayerProgressBar(playerid, 70.000000, 394.000000, 65.500000, 5.199999, 0xDEDEDEFF, 100.0000, 0);
}

DestroyGymStatsPGUI(playerid) {

	HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ] );
	DestroyPlayerProgressBar(playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ]);
	E_GYM_STATS_GUI_BAR [playerid] [ 0 ]= PlayerBar: INVALID_PLAYER_BAR_ID ;

	HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ] );
	DestroyPlayerProgressBar(playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ]);
	E_GYM_STATS_GUI_BAR [playerid] [ 1 ]= PlayerBar: INVALID_PLAYER_BAR_ID ;

	HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ] );
	DestroyPlayerProgressBar(playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ]);
	E_GYM_STATS_GUI_BAR [playerid] [ 2 ]= PlayerBar: INVALID_PLAYER_BAR_ID ;

	HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ] );
	DestroyPlayerProgressBar(playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ]);
	E_GYM_STATS_GUI_BAR [playerid] [ 3 ]= PlayerBar: INVALID_PLAYER_BAR_ID ;

	HidePlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ] );
	DestroyPlayerProgressBar(playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ]);
	E_GYM_STATS_GUI_BAR [playerid] [ 4 ]= PlayerBar: INVALID_PLAYER_BAR_ID ;
}

LoadGymStatsGUI() {

	E_GYM_STATS_GUI[0] = TextDrawCreate(10.0000, 334.5000, "_");
	TextDrawFont(E_GYM_STATS_GUI[0], 1);
	TextDrawLetterSize(E_GYM_STATS_GUI[0], 0.5000, 9.7500);
	TextDrawColor(E_GYM_STATS_GUI[0], -1);
	TextDrawSetShadow(E_GYM_STATS_GUI[0], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[0], 0);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[0], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[0], 1);
	TextDrawUseBox(E_GYM_STATS_GUI[0], 1);
	TextDrawBoxColor(E_GYM_STATS_GUI[0], 153);
	TextDrawTextSize(E_GYM_STATS_GUI[0], 140.0000, 0.0000);

	E_GYM_STATS_GUI[1] = TextDrawCreate(18.0000, 316.5000, "Stats");
	TextDrawFont(E_GYM_STATS_GUI[1], 0);
	TextDrawLetterSize(E_GYM_STATS_GUI[1], 0.8999, 2.5000);
	TextDrawColor(E_GYM_STATS_GUI[1], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[1], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[1], 2);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[1], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[1], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[1], 0.0000, 0.0000);

	E_GYM_STATS_GUI[2] = TextDrawCreate(16.0000, 344.5000, "Muscle");
	TextDrawFont(E_GYM_STATS_GUI[2], 1);
	TextDrawLetterSize(E_GYM_STATS_GUI[2], 0.3499, 1.2500);
	TextDrawColor(E_GYM_STATS_GUI[2], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[2], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[2], 0);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[2], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[2], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[2], 0.0000, 0.0000);

	E_GYM_STATS_GUI[3] = TextDrawCreate(16.0000, 356.5000, "Weight");
	TextDrawFont(E_GYM_STATS_GUI[3], 1);
	TextDrawLetterSize(E_GYM_STATS_GUI[3], 0.3499, 1.2500);
	TextDrawColor(E_GYM_STATS_GUI[3], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[3], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[3], 0);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[3], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[3], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[3], 0.0000, 0.0000);

	E_GYM_STATS_GUI[4] = TextDrawCreate(16.0000, 367.5000, "Hunger");
	TextDrawFont(E_GYM_STATS_GUI[4], 1);
	TextDrawLetterSize(E_GYM_STATS_GUI[4], 0.3499, 1.2500);
	TextDrawColor(E_GYM_STATS_GUI[4], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[4], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[4], 0);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[4], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[4], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[4], 0.0000, 0.0000);

	E_GYM_STATS_GUI[5] = TextDrawCreate(16.0000, 378.5000, "Thirst");
	TextDrawFont(E_GYM_STATS_GUI[5], 1);
	TextDrawLetterSize(E_GYM_STATS_GUI[5], 0.3499, 1.2500);
	TextDrawColor(E_GYM_STATS_GUI[5], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[5], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[5], 0);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[5], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[5], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[5], 0.0000, 0.0000);

	E_GYM_STATS_GUI[6] = TextDrawCreate(16.0000, 389.5000, "Energy");
	TextDrawFont(E_GYM_STATS_GUI[6], 1);
	TextDrawLetterSize(E_GYM_STATS_GUI[6], 0.3499, 1.2500);
	TextDrawColor(E_GYM_STATS_GUI[6], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[6], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[6], 0);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[6], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[6], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[6], 0.0000, 0.0000);

	E_GYM_STATS_GUI[7] = TextDrawCreate(132.7000, 404.5000, "Saturday");
	TextDrawFont(E_GYM_STATS_GUI[7], 3);
	TextDrawLetterSize(E_GYM_STATS_GUI[7], 0.3499, 1.2500);
	TextDrawAlignment(E_GYM_STATS_GUI[7], 3);
	TextDrawColor(E_GYM_STATS_GUI[7], 0xDEDEDEFF);
	TextDrawSetShadow(E_GYM_STATS_GUI[7], 0);
	TextDrawSetOutline(E_GYM_STATS_GUI[7], 1);
	TextDrawBackgroundColor(E_GYM_STATS_GUI[7], 255);
	TextDrawSetProportional(E_GYM_STATS_GUI[7], 1);
	TextDrawTextSize(E_GYM_STATS_GUI[7], 0.0000, 0.0000);

	return 1;
}
LoadGymStatsLvlGUI(playerid) {
	E_GYM_STATS_LVLS_GUI_BAR[playerid][0] = CreatePlayerTextDraw(playerid, 100.5000, 348.5000, "1/0");
	PlayerTextDrawFont(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 0.2000, 0.8000);
	PlayerTextDrawAlignment(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 2);
	PlayerTextDrawColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][0], 0.0000, 500.0000);

	E_GYM_STATS_LVLS_GUI_BAR[playerid][1] = CreatePlayerTextDraw(playerid, 100.5000, 359.5000, "1/0");
	PlayerTextDrawFont(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 0.2000, 0.8000);
	PlayerTextDrawAlignment(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 2);
	PlayerTextDrawColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][1], 0.0000, 500.0000);

	E_GYM_STATS_LVLS_GUI_BAR[playerid][2] = CreatePlayerTextDraw(playerid, 100.5000, 370.5000, "1/0");
	PlayerTextDrawFont(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 0.2000, 0.8000);
	PlayerTextDrawAlignment(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 2);
	PlayerTextDrawColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][2], 0.0000, 500.0000);

	E_GYM_STATS_LVLS_GUI_BAR[playerid][3] = CreatePlayerTextDraw(playerid, 100.5000, 382.0000, "1/0");
	PlayerTextDrawFont(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 0.2000, 0.8000);
	PlayerTextDrawAlignment(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 2);
	PlayerTextDrawColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][3], 0.0000, 500.0000);

	E_GYM_STATS_LVLS_GUI_BAR[playerid][4] = CreatePlayerTextDraw(playerid, 100.5000, 393.0000, "1/0");
	PlayerTextDrawFont(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 0.2000, 0.8000);
	PlayerTextDrawAlignment(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 2);
	PlayerTextDrawColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, E_GYM_STATS_LVLS_GUI_BAR[playerid][4], 0.0000, 500.0000);
}

DestroyGymStatsLvlGUI(playerid) {

	for ( new i, j = 5; i < j ; i ++ ) {

		PlayerTextDrawDestroy ( playerid, E_GYM_STATS_LVLS_GUI_BAR  [ playerid ] [ i ] ) ;
	}
}

ShowGymStatsLvlGUI(playerid) {

	PlayerTextDrawSetString ( playerid, E_GYM_STATS_LVLS_GUI_BAR [ playerid ] [ 0 ], sprintf("%d (%d/%d)", Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ], Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ], Gym_GetRemainingExp(Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ]))); // muscle
	PlayerTextDrawSetString ( playerid, E_GYM_STATS_LVLS_GUI_BAR [ playerid ] [ 1 ], sprintf("%d (%d/%d)", Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ], Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ], Gym_GetRemainingExp(Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ]))); // weight
	PlayerTextDrawSetString ( playerid, E_GYM_STATS_LVLS_GUI_BAR [ playerid ] [ 2 ], sprintf("%d", Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] )); // hunger
	PlayerTextDrawSetString ( playerid, E_GYM_STATS_LVLS_GUI_BAR [ playerid ] [ 3 ], sprintf("%d", Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] )); // thirst
	PlayerTextDrawSetString ( playerid, E_GYM_STATS_LVLS_GUI_BAR [ playerid ] [ 4 ], sprintf("%d", Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] )); // energy

	for ( new i, j = 5; i < j ; i ++ ) {

		PlayerTextDrawShow ( playerid, E_GYM_STATS_LVLS_GUI_BAR  [ playerid ] [ i ] ) ;
	}

	// This shows the default GTA SA hud when opening gym stats.
	new address [ 32 ], Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

	if ( IsPlayerInAnyVehicle ( playerid ) ) {
		ShowVehicleAlert(playerid, ReturnVehicleName(GetPlayerVehicleID(playerid)));
	}

	GetPlayerAddress(x, y, address) ;
	ShowStreetMessage(playerid, address);

	address [ 0 ] = EOS  ;
	GetMapZoneName(PlayerZone [ playerid ], address);
	ShowZoneMessage(playerid, address);
}
HideGymStatsLvlGUI(playerid) {

	for ( new i, j = 5; i < j ; i ++ ) {

		PlayerTextDrawHide ( playerid, E_GYM_STATS_LVLS_GUI_BAR  [ playerid ] [ i ] ) ;
	}
}
