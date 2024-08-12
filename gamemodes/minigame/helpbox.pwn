
new PlayerText: minigame_helpbox_ptd[MAX_PLAYERS] [ 2 ] = { PlayerText: INVALID_TEXT_DRAW, ... } ;

UpdateMinigameHelpBox(playerid, const title[], const text[], show = 0 ) {

	PlayerTextDrawSetString(playerid, minigame_helpbox_ptd[playerid][0], text ) ;
	PlayerTextDrawSetString(playerid, minigame_helpbox_ptd[playerid][1], title ) ;

	if ( show ) {
		ShowMinigameHelpBox ( playerid ) ;
	}

	return true ;
}

ShowMinigameHelpBox ( playerid ) {

	if ( Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ]  ) {

		for ( new i, j = 2 ; i < j ; i ++ ) {

			PlayerTextDrawShow(playerid, minigame_helpbox_ptd[playerid] [ i ] ) ;
		}

		if ( ! PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_MSG_CD ]  ) {
			PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_MSG_CD ] = true ;
			SendClientMessage(playerid, COLOR_YELLOW, "To hide the minigame HUD temporarily, use /minigamehide.");
		}
	}

	else {
		HideMinigameHelpBox ( playerid ) ;
		if ( PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_MSG_CD_2 ] ) {
			SendClientMessage(playerid, COLOR_YELLOW, "You have the minigame HUD turned off! To enable it, use /settings. Some minigames require the HUD!");
			PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_MSG_CD_2 ] = true ;
		}

	}
}

HideMinigameHelpBox ( playerid ) {

	for ( new i, j = 2 ; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, minigame_helpbox_ptd[playerid] [ i ] ) ;
	}
}

CMD:minigamehide(playerid, params[]) {

	HideMinigameHelpBox ( playerid ) ;
	return true ;
}

LoadMinigameHelpBox(playerid) {

	minigame_helpbox_ptd[playerid][0] = CreatePlayerTextDraw(playerid, 500.0000, 164.5000, "text");
	PlayerTextDrawFont(playerid, minigame_helpbox_ptd[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, minigame_helpbox_ptd[playerid][0], 0.2500, 1.1499);
	PlayerTextDrawColor(playerid, minigame_helpbox_ptd[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, minigame_helpbox_ptd[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, minigame_helpbox_ptd[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, minigame_helpbox_ptd[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, minigame_helpbox_ptd[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, minigame_helpbox_ptd[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, minigame_helpbox_ptd[playerid][0], 170);
	PlayerTextDrawTextSize(playerid, minigame_helpbox_ptd[playerid][0], 605.0000, 0.0000);

	minigame_helpbox_ptd[playerid][1] = CreatePlayerTextDraw(playerid, 551.0000, 151.0000, "title");
	PlayerTextDrawFont(playerid, minigame_helpbox_ptd[playerid][1], 0);
	PlayerTextDrawLetterSize(playerid, minigame_helpbox_ptd[playerid][1], 0.4499, 1.2999);
	PlayerTextDrawAlignment(playerid, minigame_helpbox_ptd[playerid][1], 2);
	PlayerTextDrawColor(playerid, minigame_helpbox_ptd[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, minigame_helpbox_ptd[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, minigame_helpbox_ptd[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, minigame_helpbox_ptd[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, minigame_helpbox_ptd[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, minigame_helpbox_ptd[playerid][1], 0.0000, 150.0000);
}


DestroyMinigameHelpBox ( playerid ) {

	for ( new i, j = 2 ; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, minigame_helpbox_ptd[playerid] [ i ] ) ;
	}
}