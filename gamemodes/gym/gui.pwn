
new PlayerText:HUD_GYM_STATS[MAX_PLAYERS][2] = { PlayerText: INVALID_TEXT_DRAW, ... };
new PlayerBar: HUD_GYM_BAR[MAX_PLAYERS] = PlayerBar: INVALID_PLAYER_BAR_ID ;

Gym_ShowHUD(playerid) {

	PlayerTextDrawShow(playerid, HUD_GYM_STATS[playerid][0]);
	PlayerTextDrawShow(playerid, HUD_GYM_STATS[playerid][1]);

	ShowPlayerProgressBar(playerid,  HUD_GYM_BAR [ playerid ]);

	SetPlayerProgressBarValue(playerid, HUD_GYM_BAR [ playerid ], PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ]);
}

Gym_HideHUD(playerid) {

	HidePlayerInfoMessage(playerid);

	PlayerTextDrawSetString(playerid,  HUD_GYM_STATS[playerid][0], "power~n~reps");
	PlayerTextDrawHide(playerid, HUD_GYM_STATS[playerid][0]);
	PlayerTextDrawSetString(playerid,  HUD_GYM_STATS[playerid][1], "~n~0");
	PlayerTextDrawHide(playerid, HUD_GYM_STATS[playerid][1]);

	HidePlayerProgressBar(playerid,  HUD_GYM_BAR [ playerid ]);
}

public OnPlayerConnect(playerid) {

	Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], 0, .anim=false); // reset variables!

	HUD_GYM_STATS[playerid][0] = CreatePlayerTextDraw(playerid, 530.0000, 140.0000, "power~n~reps");
	PlayerTextDrawFont(playerid, HUD_GYM_STATS[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, HUD_GYM_STATS[playerid][0], 0.4000, 1.2999);
	PlayerTextDrawAlignment(playerid, HUD_GYM_STATS[playerid][0], 3);
	PlayerTextDrawColor(playerid, HUD_GYM_STATS[playerid][0], -1329275137);
	PlayerTextDrawSetShadow(playerid, HUD_GYM_STATS[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, HUD_GYM_STATS[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, HUD_GYM_STATS[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, HUD_GYM_STATS[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, HUD_GYM_STATS[playerid][0], 0.0000, 0.0000);

	HUD_GYM_STATS[playerid][1] = CreatePlayerTextDraw(playerid, 600.0000, 140.0000, "~n~0");
	PlayerTextDrawFont(playerid, HUD_GYM_STATS[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, HUD_GYM_STATS[playerid][1], 0.4000, 1.2999);
	PlayerTextDrawAlignment(playerid, HUD_GYM_STATS[playerid][1], 3);
	PlayerTextDrawColor(playerid, HUD_GYM_STATS[playerid][1], -1329275137);
	PlayerTextDrawSetShadow(playerid, HUD_GYM_STATS[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, HUD_GYM_STATS[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, HUD_GYM_STATS[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, HUD_GYM_STATS[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, HUD_GYM_STATS[playerid][1], 0.0000, 0.0000);
//<<<<<<< HEAD
//<<<<<<< HEAD
		
	HUD_GYM_BAR [ playerid ] = PlayerBar: INVALID_PLAYER_BAR_ID ;
//=======
	
    HUD_GYM_BAR [ playerid ] = CreatePlayerProgressBar(playerid, 550.00, 143.50, 55.5, 4.0, -1278086145, 100.0);
//>>>>>>> parent of 3b17ac3 (Unglobalizing gym progress bar / extra changes)
//=======

//>>>>>>> parent of b168bbf (Wiping progress bar variables on connect)

	#if defined gym_OnPlayerConnect
		return gym_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect gym_OnPlayerConnect
#if defined gym_OnPlayerConnect
	forward gym_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect( playerid, reason) {
	
	Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], 0, .anim=false); // reset variables!
	
	PlayerTextDrawDestroy(playerid, HUD_GYM_STATS[playerid][0] );
	PlayerTextDrawDestroy(playerid, HUD_GYM_STATS[playerid][1] );
	DestroyPlayerProgressBar(playerid, HUD_GYM_BAR [ playerid ] );

	#if defined gym_OnPlayerDisconnect
		return gym_OnPlayerDisconnect( playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect gym_OnPlayerDisconnect
#if defined gym_OnPlayerDisconnect
	forward gym_OnPlayerDisconnect(playerid, reason);
#endif
