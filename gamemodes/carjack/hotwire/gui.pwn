new Text:hotwire_gui[12] = Text: INVALID_PLAYER_ID ;
new PlayerText:hotwire_player_gui[MAX_PLAYERS][10] = { PlayerText: INVALID_TEXT_DRAW, ... }  ;

GUI_LoadHotwireGUI(){

	hotwire_gui[0] = TextDrawCreate(287.0000, 271.0000, "_");
	TextDrawFont(hotwire_gui[0], 1);
	TextDrawLetterSize(hotwire_gui[0], 0.5000, 10.0000);
	TextDrawColor(hotwire_gui[0], -1);
	TextDrawSetShadow(hotwire_gui[0], 0);
	TextDrawSetOutline(hotwire_gui[0], 0);
	TextDrawBackgroundColor(hotwire_gui[0], 255);
	TextDrawSetProportional(hotwire_gui[0], 1);
	TextDrawUseBox(hotwire_gui[0], 1);
	TextDrawBoxColor(hotwire_gui[0], 170);
	TextDrawTextSize(hotwire_gui[0], 360.0000, 0.0000);

	hotwire_gui[1] = TextDrawCreate(291.500, 302.5000, "strip");
	TextDrawFont(hotwire_gui[1], 5);
	TextDrawLetterSize(hotwire_gui[1], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[1], -1);
	TextDrawSetShadow(hotwire_gui[1], 0);
	TextDrawSetOutline(hotwire_gui[1], 0);
	TextDrawBackgroundColor(hotwire_gui[1], 0x00000000);
	TextDrawSetProportional(hotwire_gui[1], 1);
	TextDrawUseBox(hotwire_gui[1], 1);
	TextDrawBoxColor(hotwire_gui[1], 0x00000000);
	TextDrawTextSize(hotwire_gui[1], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[1], 19443);
	TextDrawSetPreviewRot(hotwire_gui[1], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[1], 1);

	hotwire_gui[2] = TextDrawCreate(305.0, 302.5000, "strip");
	TextDrawFont(hotwire_gui[2], 5);
	TextDrawLetterSize(hotwire_gui[2], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[2], -1);
	TextDrawSetShadow(hotwire_gui[2], 0);
	TextDrawSetOutline(hotwire_gui[2], 0);
	TextDrawBackgroundColor(hotwire_gui[2], 0x00000000);
	TextDrawSetProportional(hotwire_gui[2], 1);
	TextDrawUseBox(hotwire_gui[2], 1);
	TextDrawBoxColor(hotwire_gui[2], 0x00000000);
	TextDrawTextSize(hotwire_gui[2], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[2], 19443);
	TextDrawSetPreviewRot(hotwire_gui[2], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[2], 1);


	hotwire_gui[3] = TextDrawCreate(318.5, 302.5000, "strip");
	TextDrawFont(hotwire_gui[3], 5);
	TextDrawLetterSize(hotwire_gui[3], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[3], -1);
	TextDrawSetShadow(hotwire_gui[3], 0);
	TextDrawSetOutline(hotwire_gui[3], 0);
	TextDrawBackgroundColor(hotwire_gui[3], 0x00000000);
	TextDrawSetProportional(hotwire_gui[3], 1);
	TextDrawUseBox(hotwire_gui[3], 1);
	TextDrawBoxColor(hotwire_gui[3], 0x00000000);
	TextDrawTextSize(hotwire_gui[3], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[3], 19443);
	TextDrawSetPreviewRot(hotwire_gui[3], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[3], 1);


	hotwire_gui[4] = TextDrawCreate(332, 302.5000, "strip");
	TextDrawFont(hotwire_gui[4], 5);
	TextDrawLetterSize(hotwire_gui[4], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[4], -1);
	TextDrawSetShadow(hotwire_gui[4], 0);
	TextDrawSetOutline(hotwire_gui[4], 0);
	TextDrawBackgroundColor(hotwire_gui[4], 0x00000000);
	TextDrawSetProportional(hotwire_gui[4], 1);
	TextDrawUseBox(hotwire_gui[4], 1);
	TextDrawBoxColor(hotwire_gui[4], 0x00000000);
	TextDrawTextSize(hotwire_gui[4], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[4], 19443);
	TextDrawSetPreviewRot(hotwire_gui[4], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[4], 1);


	hotwire_gui[5] = TextDrawCreate(345.5, 302.5000, "strip");
	TextDrawFont(hotwire_gui[5], 5);
	TextDrawLetterSize(hotwire_gui[5], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[5], -1);
	TextDrawSetShadow(hotwire_gui[5], 0);
	TextDrawSetOutline(hotwire_gui[5], 0);
	TextDrawBackgroundColor(hotwire_gui[5], 0x00000000);
	TextDrawSetProportional(hotwire_gui[5], 1);
	TextDrawUseBox(hotwire_gui[5], 1);
	TextDrawBoxColor(hotwire_gui[5], 0x00000000);
	TextDrawTextSize(hotwire_gui[5], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[5], 19443);
	TextDrawSetPreviewRot(hotwire_gui[5], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[5], 1);



	hotwire_gui[6] = TextDrawCreate(291.5, 319.5000, "strip");
	TextDrawFont(hotwire_gui[6], 5);
	TextDrawLetterSize(hotwire_gui[6], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[6], -1);
	TextDrawSetShadow(hotwire_gui[6], 0);
	TextDrawSetOutline(hotwire_gui[6], 0);
	TextDrawBackgroundColor(hotwire_gui[6], 0x00000000);
	TextDrawSetProportional(hotwire_gui[6], 1);
	TextDrawUseBox(hotwire_gui[6], 1);
	TextDrawBoxColor(hotwire_gui[6], 0x00000000);
	TextDrawTextSize(hotwire_gui[6], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[6], 19443);
	TextDrawSetPreviewRot(hotwire_gui[6], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[6], 1);

	hotwire_gui[7] = TextDrawCreate(305.0, 319.5000, "strip");
	TextDrawFont(hotwire_gui[7], 5);
	TextDrawLetterSize(hotwire_gui[7], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[7], -1);
	TextDrawSetShadow(hotwire_gui[7], 0);
	TextDrawSetOutline(hotwire_gui[7], 0);
	TextDrawBackgroundColor(hotwire_gui[7], 0x00000000);
	TextDrawSetProportional(hotwire_gui[7], 1);
	TextDrawUseBox(hotwire_gui[7], 1);
	TextDrawBoxColor(hotwire_gui[7], 0x00000000);
	TextDrawTextSize(hotwire_gui[7], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[7], 19443);
	TextDrawSetPreviewRot(hotwire_gui[7], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[7], 1);


	hotwire_gui[8] = TextDrawCreate(318.5, 319.5000, "strip");
	TextDrawFont(hotwire_gui[8], 5);
	TextDrawLetterSize(hotwire_gui[8], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[8], -1);
	TextDrawSetShadow(hotwire_gui[8], 0);
	TextDrawSetOutline(hotwire_gui[8], 0);
	TextDrawBackgroundColor(hotwire_gui[8], 0x00000000);
	TextDrawSetProportional(hotwire_gui[8], 1);
	TextDrawUseBox(hotwire_gui[8], 1);
	TextDrawBoxColor(hotwire_gui[8], 0x00000000);
	TextDrawTextSize(hotwire_gui[8], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[8], 19443);
	TextDrawSetPreviewRot(hotwire_gui[8], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[8], 1);

	hotwire_gui[9] = TextDrawCreate(332, 319.5000, "strip");
	TextDrawFont(hotwire_gui[9], 5);
	TextDrawLetterSize(hotwire_gui[9], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[9], -1);
	TextDrawSetShadow(hotwire_gui[9], 0);
	TextDrawSetOutline(hotwire_gui[9], 0);
	TextDrawBackgroundColor(hotwire_gui[9], 0x00000000);
	TextDrawSetProportional(hotwire_gui[9], 1);
	TextDrawUseBox(hotwire_gui[9], 1);
	TextDrawBoxColor(hotwire_gui[9], 0x00000000);
	TextDrawTextSize(hotwire_gui[9], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[9], 19443);
	TextDrawSetPreviewRot(hotwire_gui[9], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[9], 1);	

	hotwire_gui[10] = TextDrawCreate(345.5, 319.5000, "strip");
	TextDrawFont(hotwire_gui[10], 5);
	TextDrawLetterSize(hotwire_gui[10], 640.0000, 0.5000);
	TextDrawColor(hotwire_gui[10], -1);
	TextDrawSetShadow(hotwire_gui[10], 0);
	TextDrawSetOutline(hotwire_gui[10], 0);
	TextDrawBackgroundColor(hotwire_gui[10], 0x00000000);
	TextDrawSetProportional(hotwire_gui[10], 1);
	TextDrawUseBox(hotwire_gui[10], 1);
	TextDrawBoxColor(hotwire_gui[10], 0x00000000);
	TextDrawTextSize(hotwire_gui[10], 10.0, 10.0);
	TextDrawSetPreviewModel(hotwire_gui[10], 19443);
	TextDrawSetPreviewRot(hotwire_gui[10], 0, 0, 90, 1);
	TextDrawSetSelectable(hotwire_gui[10], 1);

	hotwire_gui[11] = TextDrawCreate(323.5000, 257.5000, "Hotwire Panel");
	TextDrawFont(hotwire_gui[11], 3);
	TextDrawLetterSize(hotwire_gui[11], 0.3000, 1.2999);
	TextDrawAlignment(hotwire_gui[11], 2);
	TextDrawColor(hotwire_gui[11], -1);
	TextDrawSetShadow(hotwire_gui[11], 1);
	TextDrawSetOutline(hotwire_gui[11], 0);
	TextDrawBackgroundColor(hotwire_gui[11], 255);
	TextDrawSetProportional(hotwire_gui[11], 1);
	TextDrawTextSize(hotwire_gui[11], 0.0000, 500.0000);

	return 1;
}

GUI_HideHotwireGUI(playerid) {

	for ( new i, j = sizeof ( hotwire_gui ); i < j ; i ++ ) {

		TextDrawHideForPlayer(playerid, hotwire_gui [ i ] ) ;
	}
}

GUI_LoadHotwirePlayerGUI(playerid) {

	hotwire_player_gui[playerid][0] = CreatePlayerTextDraw(playerid, 292.5000, 275.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][0], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][0], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][0], 300.0000, 0.0000);

	hotwire_player_gui[playerid][1] = CreatePlayerTextDraw(playerid, 306.0000, 276.0000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][1], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][1], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][1], 314.0000, 0.0000);

	hotwire_player_gui[playerid][2] = CreatePlayerTextDraw(playerid, 320.0000, 276.0000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][2], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][2], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][2], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][2], 328.0000, 0.0000);

	hotwire_player_gui[playerid][3] = CreatePlayerTextDraw(playerid, 333.5000, 276.0000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][3], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][3], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][3], 341.5000, 0.0000);

	hotwire_player_gui[playerid][4] = CreatePlayerTextDraw(playerid, 292.5000, 327.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][4], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][4], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][4], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][4], 300.0000, 0.0000);

	hotwire_player_gui[playerid][5] = CreatePlayerTextDraw(playerid, 306.0000, 327.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][5], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][5], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][5], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][5], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][5], 314.0000, 0.0000);

	hotwire_player_gui[playerid][6] = CreatePlayerTextDraw(playerid, 320.0000, 327.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][6], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][6], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][6], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][6], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][6], 328.0000, 0.0000);

	hotwire_player_gui[playerid][7] = CreatePlayerTextDraw(playerid, 333.5000, 327.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][7], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][7], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][7], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][7], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][7], 341.5000, 0.0000);

	hotwire_player_gui[playerid][8] = CreatePlayerTextDraw(playerid, 347.0000, 275.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][8], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][8], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][8], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][8], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][8], 355.0000, 0.0000);

	hotwire_player_gui[playerid][9] = CreatePlayerTextDraw(playerid, 347.0000, 327.5000, "_");
	PlayerTextDrawFont(playerid, hotwire_player_gui[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, hotwire_player_gui[playerid][9], 0.5000, 3.0000);
	PlayerTextDrawColor(playerid, hotwire_player_gui[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, hotwire_player_gui[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, hotwire_player_gui[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, hotwire_player_gui[playerid][9], 255);
	PlayerTextDrawSetProportional(playerid, hotwire_player_gui[playerid][9], 1);
	PlayerTextDrawUseBox(playerid, hotwire_player_gui[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, hotwire_player_gui[playerid][9], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, hotwire_player_gui[playerid][9], 355.0000, 0.0000);

	return 1;
}


GUI_DestroyHotwirePlayerGUI(playerid) {

	for ( new i, j = 10; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, hotwire_player_gui[playerid][ i ] ) ;
	}

	PlayerTextDrawDestroy ( playerid, E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] ) ; 
}


GUI_HideHotwirePlayerGUI(playerid) {

	for ( new i, j = 10; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, hotwire_player_gui[playerid][ i ] ) ;
	}
}
