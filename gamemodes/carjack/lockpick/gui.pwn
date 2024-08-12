new Text:lp_gui_visual = Text: INVALID_TEXT_DRAW ;
new Text:lp_gui_panel[10] = Text: INVALID_TEXT_DRAW ;
new PlayerText:lp_gui_player_panel[MAX_PLAYERS][16] = { PlayerText: INVALID_TEXT_DRAW, ... } ;

GUI_ShowLockpickGUI(playerid) {

	for ( new i, j = sizeof ( lp_gui_panel ); i < j ; i ++ ) {

		TextDrawShowForPlayer(playerid, lp_gui_panel [ i ] ) ;
	}

	TextDrawShowForPlayer(playerid, lp_gui_visual ) ;


	for ( new i, j =16; i < j ; i ++ ) {

		PlayerTextDrawShow(playerid, lp_gui_player_panel[playerid]  [ i ] ) ;
	}

	return true ;
}

GUI_LoadLockpickGUI() {

	lp_gui_visual = TextDrawCreate(262.0000, 240.0000, "lock");
	TextDrawFont(lp_gui_visual, 5);
	TextDrawLetterSize(lp_gui_visual, 0.5000, 1.0000);
	TextDrawColor(lp_gui_visual, -1);
	TextDrawSetShadow(lp_gui_visual, 0);
	TextDrawSetOutline(lp_gui_visual, 0);
	TextDrawBackgroundColor(lp_gui_visual, 0);
	TextDrawSetProportional(lp_gui_visual, 1);
	TextDrawTextSize(lp_gui_visual, 50.0000, 48.0000);
	TextDrawSetPreviewModel(lp_gui_visual, 19804);
	TextDrawSetPreviewRot(lp_gui_visual, 90.0000, 0.0000, 90.0000, 0.3400);

	/*
	lp_gui_visual[1] = TextDrawCreate(142.0000, 98.5000, "lock");
	TextDrawFont(lp_gui_visual[1], 5);
	TextDrawLetterSize(lp_gui_visual[1], 0.5000, 1.0000);
	TextDrawColor(lp_gui_visual[1], -1);
	TextDrawSetShadow(lp_gui_visual[1], 0);
	TextDrawSetOutline(lp_gui_visual[1], 0);
	TextDrawBackgroundColor(lp_gui_visual[1], 0);
	TextDrawSetProportional(lp_gui_visual[1], 1);
	TextDrawTextSize(lp_gui_visual[1], 250.0000, 250.0000);
	TextDrawSetPreviewModel(lp_gui_visual[1], 18644);
	TextDrawSetPreviewRot(lp_gui_visual[1], -30.0000, 10.0000, 0.0000, 1.0000);*/

	lp_gui_panel[0] = TextDrawCreate(260.0000, 300.0000, "_");
	TextDrawFont(lp_gui_panel[0], 1);
	TextDrawLetterSize(lp_gui_panel[0], 0.5000, 1.0000);
	TextDrawColor(lp_gui_panel[0], -1);
	TextDrawSetShadow(lp_gui_panel[0], 0);
	TextDrawSetOutline(lp_gui_panel[0], 0);
	TextDrawBackgroundColor(lp_gui_panel[0], 255);
	TextDrawSetProportional(lp_gui_panel[0], 1);
	TextDrawUseBox(lp_gui_panel[0], 1);
	TextDrawBoxColor(lp_gui_panel[0], 255);
	TextDrawTextSize(lp_gui_panel[0], 425.0000, 0.0000);

	lp_gui_panel[1] = TextDrawCreate(317.0000, 233.5000, "_");
	TextDrawFont(lp_gui_panel[1], 1);
	TextDrawLetterSize(lp_gui_panel[1], 0.5000, 7.5000);
	TextDrawColor(lp_gui_panel[1], -1);
	TextDrawSetShadow(lp_gui_panel[1], 0);
	TextDrawSetOutline(lp_gui_panel[1], 0);
	TextDrawBackgroundColor(lp_gui_panel[1], 255);
	TextDrawSetProportional(lp_gui_panel[1], 1);
	TextDrawUseBox(lp_gui_panel[1], 1);
	TextDrawBoxColor(lp_gui_panel[1], 170);
	TextDrawTextSize(lp_gui_panel[1], 420.0000, 0.0000);

	lp_gui_panel[2] = TextDrawCreate(330.0000, 242.5000, "_");
	TextDrawFont(lp_gui_panel[2], 1);
	TextDrawLetterSize(lp_gui_panel[2], 0.5000, 7.0000);
	TextDrawColor(lp_gui_panel[2], -1);
	TextDrawSetShadow(lp_gui_panel[2], 0);
	TextDrawSetOutline(lp_gui_panel[2], 0);
	TextDrawBackgroundColor(lp_gui_panel[2], 255);
	TextDrawSetProportional(lp_gui_panel[2], 1);
	TextDrawUseBox(lp_gui_panel[2], 1);
	TextDrawBoxColor(lp_gui_panel[2], 255);
	TextDrawTextSize(lp_gui_panel[2], 335.0000, 0.0000);

	lp_gui_panel[3] = TextDrawCreate(320.0000, 308.0000, "_");
	TextDrawFont(lp_gui_panel[3], 1);
	TextDrawLetterSize(lp_gui_panel[3], 0.5000, 0.5000);
	TextDrawColor(lp_gui_panel[3], -1);
	TextDrawSetShadow(lp_gui_panel[3], 0);
	TextDrawSetOutline(lp_gui_panel[3], 0);
	TextDrawBackgroundColor(lp_gui_panel[3], 255);
	TextDrawSetProportional(lp_gui_panel[3], 1);
	TextDrawUseBox(lp_gui_panel[3], 1);
	TextDrawBoxColor(lp_gui_panel[3], 255);
	TextDrawTextSize(lp_gui_panel[3], 335.0000, 0.0000);

	lp_gui_panel[4] = TextDrawCreate(331.5000, 244.0000, "_");
	TextDrawFont(lp_gui_panel[4], 1);
	TextDrawLetterSize(lp_gui_panel[4], 0.5000, 7.0000);
	TextDrawColor(lp_gui_panel[4], -1);
	TextDrawSetShadow(lp_gui_panel[4], 0);
	TextDrawSetOutline(lp_gui_panel[4], 0);
	TextDrawBackgroundColor(lp_gui_panel[4], 255);
	TextDrawSetProportional(lp_gui_panel[4], 1);
	TextDrawUseBox(lp_gui_panel[4], 1);
	TextDrawBoxColor(lp_gui_panel[4], -558331905);
	TextDrawTextSize(lp_gui_panel[4], 333.7000, 0.0000);

	lp_gui_panel[5] = TextDrawCreate(321.5000, 308.0000, "_");
	TextDrawFont(lp_gui_panel[5], 1);
	TextDrawLetterSize(lp_gui_panel[5], 0.5000, 0.3000);
	TextDrawColor(lp_gui_panel[5], -1);
	TextDrawSetShadow(lp_gui_panel[5], 0);
	TextDrawSetOutline(lp_gui_panel[5], 0);
	TextDrawBackgroundColor(lp_gui_panel[5], 255);
	TextDrawSetProportional(lp_gui_panel[5], 1);
	TextDrawUseBox(lp_gui_panel[5], 1);
	TextDrawBoxColor(lp_gui_panel[5], -558331905);
	TextDrawTextSize(lp_gui_panel[5], 333.7000, 0.0000);

	lp_gui_panel[6] = TextDrawCreate(380.0000, 242.5000, "_");
	TextDrawFont(lp_gui_panel[6], 1);
	TextDrawLetterSize(lp_gui_panel[6], 0.5000, 7.0000);
	TextDrawColor(lp_gui_panel[6], -1);
	TextDrawSetShadow(lp_gui_panel[6], 0);
	TextDrawSetOutline(lp_gui_panel[6], 0);
	TextDrawBackgroundColor(lp_gui_panel[6], 255);
	TextDrawSetProportional(lp_gui_panel[6], 1);
	TextDrawUseBox(lp_gui_panel[6], 1);
	TextDrawBoxColor(lp_gui_panel[6], 255);
	TextDrawTextSize(lp_gui_panel[6], 385.0000, 0.0000);

	lp_gui_panel[7] = TextDrawCreate(380.0000, 308.0000, "_");
	TextDrawFont(lp_gui_panel[7], 1);
	TextDrawLetterSize(lp_gui_panel[7], 0.5000, 0.5000);
	TextDrawColor(lp_gui_panel[7], -1);
	TextDrawSetShadow(lp_gui_panel[7], 0);
	TextDrawSetOutline(lp_gui_panel[7], 0);
	TextDrawBackgroundColor(lp_gui_panel[7], 255);
	TextDrawSetProportional(lp_gui_panel[7], 1);
	TextDrawUseBox(lp_gui_panel[7], 1);
	TextDrawBoxColor(lp_gui_panel[7], 255);
	TextDrawTextSize(lp_gui_panel[7], 395.0000, 0.0000);

	lp_gui_panel[8] = TextDrawCreate(381.5000, 244.0000, "_");
	TextDrawFont(lp_gui_panel[8], 1);
	TextDrawLetterSize(lp_gui_panel[8], 0.5000, 7.0000);
	TextDrawColor(lp_gui_panel[8], -1);
	TextDrawSetShadow(lp_gui_panel[8], 0);
	TextDrawSetOutline(lp_gui_panel[8], 0);
	TextDrawBackgroundColor(lp_gui_panel[8], 255);
	TextDrawSetProportional(lp_gui_panel[8], 1);
	TextDrawUseBox(lp_gui_panel[8], 1);
	TextDrawBoxColor(lp_gui_panel[8], -558331905);
	TextDrawTextSize(lp_gui_panel[8], 383.5000, 0.0000);

	lp_gui_panel[9] = TextDrawCreate(381.5000, 308.0000, "_");
	TextDrawFont(lp_gui_panel[9], 1);
	TextDrawLetterSize(lp_gui_panel[9], 0.5000, 0.3000);
	TextDrawColor(lp_gui_panel[9], -1);
	TextDrawSetShadow(lp_gui_panel[9], 0);
	TextDrawSetOutline(lp_gui_panel[9], 0);
	TextDrawBackgroundColor(lp_gui_panel[9], 255);
	TextDrawSetProportional(lp_gui_panel[9], 1);
	TextDrawUseBox(lp_gui_panel[9], 1);
	TextDrawBoxColor(lp_gui_panel[9], -558331905);
	TextDrawTextSize(lp_gui_panel[9], 393.7000, 0.0000);



	return 1;
}

GUI_HideLockpickGUI(playerid) {

	for ( new i, j = sizeof ( lp_gui_panel ); i < j ; i ++ ) {

		TextDrawHideForPlayer(playerid, lp_gui_panel [ i ] ) ;
	}

	TextDrawHideForPlayer(playerid, lp_gui_visual) ;

}

GUI_LoadLockpickPlayerGUI(playerid) {

	lp_gui_player_panel[playerid][0] = CreatePlayerTextDraw(playerid, 417.5000, 248.0000, "_"); // FOURTH BOTTOM BACKGROUND
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][0], 0.0000, 0.6499);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][0], 255);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][0], 335.5000, 0.0000);

	lp_gui_player_panel[playerid][1] = CreatePlayerTextDraw(playerid, 417.5000, 261.0000, "_"); // THIRD BOTTOM BACKGROUND
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][1], 0.0000, 0.6499);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][1], 255);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][1], 335.5000, 0.0000);

	lp_gui_player_panel[playerid][2] = CreatePlayerTextDraw(playerid, 417.5000, 274.5000, "_"); // SECOND BOTTOM BACKGROUND
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][2], 0.0000, 0.6499);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][2], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][2], 255);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][2], 335.5000, 0.0000);

	lp_gui_player_panel[playerid][3] = CreatePlayerTextDraw(playerid, 417.5000, 288.0000, "_"); // FIRST BOTTOM BACKGROUND
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][3], 0.0000, 0.6499);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][3], 255);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][3], 335.5000, 0.0000);

	lp_gui_player_panel[playerid][4] = CreatePlayerTextDraw(playerid, 404.5000, 249.5000, "_"); // FOURTH TO BOTTOM
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][4], 0.0000, 0.3000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][4], -558331905);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][4], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][4], -558331905);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][4], 337.000, 0.0000);

	lp_gui_player_panel[playerid][5] = CreatePlayerTextDraw(playerid, 404.5000, 262.5000, "_"); // THIRD TO BOTTOM
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][5], 0.0000, 0.3000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][5], -558331905);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][5], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][5], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][5], -558331905);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][5], 337.000, 0.0000);

	lp_gui_player_panel[playerid][6] = CreatePlayerTextDraw(playerid, 404.5000, 276.0000, "_"); // SECOND TO BOTTOM ROW
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][6], 0.0000, 0.3000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][6], -558331905);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][6], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][6], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][6], -558331905);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][6], 337.000, 0.0000);

	lp_gui_player_panel[playerid][7] = CreatePlayerTextDraw(playerid, 404.5000, 289.5000, "_"); // BOTTOM ROW
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][7], 0.0000, 0.3000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][7], -558331905);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][7], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][7], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][7], -558331905);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][7], 337.000, 0.0000);

	lp_gui_player_panel[playerid][8] = CreatePlayerTextDraw(playerid, 290.0000, 210.0000, "pressure point");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][8], 3);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][8], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][8], 1);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][8], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][8], 1);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][8], 0.0000, 0.0000);

	lp_gui_player_panel[playerid][9] = CreatePlayerTextDraw(playerid, 385.5000, 219.0000, "~r~0.00");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][9], 3);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][9], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][9], 1);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][9], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][9], 1);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][9], 0.0000, 0.0000);

	lp_gui_player_panel[playerid][10] = CreatePlayerTextDraw(playerid, 352.0000, 331.5000, "_");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][10], 3);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][10], 0.5000, -10.5000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][10], 1);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][10], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][10], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][10], 255);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][10], 364.0000, 0.0000);

	lp_gui_player_panel[playerid][11] = CreatePlayerTextDraw(playerid, 353.5000, 329.5000, "_");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][11], 3);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][11], 0.5000, -10.1000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][11], 1);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][11], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][11], 1);
	PlayerTextDrawUseBox(playerid, lp_gui_player_panel[playerid][11], 1);
	PlayerTextDrawBoxColor(playerid, lp_gui_player_panel[playerid][11], -741092353);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][11], 362.5000, 0.0000);

	lp_gui_player_panel[playerid][12] = CreatePlayerTextDraw(playerid, 403.5000, 246.0000, "VVVVV");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][12], 0.1049, 1.0000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][12], -1448498689);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][12], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][12], 1);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][12], 415.0000, 0.0000);

	lp_gui_player_panel[playerid][13] = CreatePlayerTextDraw(playerid, 403.5000, 259.0000, "VVVVV");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][13], 0.1049, 1.0000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][13], -1448498689);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][13], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][13], 1);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][13], 415.0000, 0.0000);

	lp_gui_player_panel[playerid][14] = CreatePlayerTextDraw(playerid, 403.5000, 272.5000, "VVVVV");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][14], 0.1049, 1.0000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][14], -1448498689);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][14], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][14], 1);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][14], 415.0000, 0.0000);

	lp_gui_player_panel[playerid][15] = CreatePlayerTextDraw(playerid, 403.5000, 286.0000, "VVVVV");
	PlayerTextDrawFont(playerid, lp_gui_player_panel[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, lp_gui_player_panel[playerid][15], 0.1049, 1.0000);
	PlayerTextDrawColor(playerid, lp_gui_player_panel[playerid][15], -1448498689);
	PlayerTextDrawSetShadow(playerid, lp_gui_player_panel[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, lp_gui_player_panel[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, lp_gui_player_panel[playerid][15], 255);
	PlayerTextDrawSetProportional(playerid, lp_gui_player_panel[playerid][15], 1);
	PlayerTextDrawTextSize(playerid, lp_gui_player_panel[playerid][15], 415.0000, 0.0000);
	return 1;
}


GUI_DestroyLockpickPlayerGUI(playerid) {

	for ( new i, j =16; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, lp_gui_player_panel[playerid]  [ i ] ) ;
	}

	return true ;
}

GUI_HideLockpickPlayerGUI(playerid) {

	for ( new i, j =16; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, lp_gui_player_panel[playerid]  [ i ] ) ;
	}

	return true ;
}
