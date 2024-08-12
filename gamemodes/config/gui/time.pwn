new Text:hud_time = Text: INVALID_TEXT_DRAW ;

public OnGameModeInit() {

	hud_time = TextDrawCreate(578.0000, 20.5000, "00:00");
	TextDrawFont(hud_time, 3);
	TextDrawLetterSize(hud_time, 0.5000, 1.7500);
	TextDrawAlignment(hud_time, 2);
	TextDrawColor(hud_time, -1);
	TextDrawSetShadow(hud_time, 0);
	TextDrawSetOutline(hud_time, 2);
	TextDrawBackgroundColor(hud_time, 255);
	TextDrawSetProportional(hud_time, 1);
	TextDrawTextSize(hud_time, 0.0000, 0.0000);

	#if defined time_OnGameModeInit
		return time_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit time_OnGameModeInit
#if defined time_OnGameModeInit
	forward time_OnGameModeInit();
#endif