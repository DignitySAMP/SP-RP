new PlayerText:ptd_ph_design[MAX_PLAYERS][13] = { PlayerText: INVALID_TEXT_DRAW, ... } ;
new PlayerText: ptd_ph_popup[MAX_PLAYERS][3] = { PlayerText: INVALID_TEXT_DRAW, ... } ;

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    
	Phone_LoadPlayerDraws ( playerid ); 
    return 1;
}

hook OnPlayerDisconnect(playerid) {
	Phone_DestroyPlayedDraws(playerid) ;
    return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid) {

	if(playertextid == PlayerText:INVALID_TEXT_DRAW) {

		SendServerMessage ( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", "Use /pc to (re-)display mouse pointer." ) ;
	}

	if ( playertextid == ptd_ph_design[playerid][12] ) { 

		if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] ) {

			ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "*", "turns off their phone", .annonated=true);

			PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] = false ;

			for ( new i = 5, j = 13; i < j ; i ++ ) {

				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][i]);
			}

			for ( new i, j = 3; i < j ; i ++ ) {

				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
			}


			PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ 12 ] ) ;
		}

		else if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ]  ) {

			ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "*", "turns their phone back on", .annonated=true);

			PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] = true ;
			PlayerVar [ playerid ] [ player_phonecalling ] = INVALID_PLAYER_ID ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
			PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
			
			for ( new i = 5, j = 13; i < j ; i ++ ) {

				PlayerTextDrawShow(playerid, ptd_ph_design[playerid][i]);
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] ) {
		if ( playertextid == ptd_ph_design[playerid][1] ) { // Pickup

			if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] != 0 ) {
				PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = true ;
			}

			else if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] == 0 ) {

				if ( PlayerVar [ playerid ] [ player_phonecalling ] == INVALID_PLAYER_ID ) {

					Phone_ViewDialMenu ( playerid ) ;
				}

				else SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You're already in a call with someone." ) ;
			}

			else SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Make sure to cancel the alert in your phone before continuing." ) ;

			return true ;
		}
		if ( playertextid == ptd_ph_design[playerid][2] ) { // hangup

			if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] ) {

				SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've hung up. Your recipient hasn't received your message!" ) ;
			}

			PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

			if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] <= 0  && PlayerVar [ playerid ] [ player_phonecalling ] == INVALID_PLAYER_ID ) {
				for(new i, j = 3; i < j ; i ++ ) {

					PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
				}
			}

			else {

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = true ;
			}
		}

		if ( playertextid == ptd_ph_design[playerid][8] ) {
			SMS_DisplayInbox_SQL(playerid);
			//SendClientMessage(playerid, -1, "View inbox / sent messages");
		}
		if ( playertextid == ptd_ph_design[playerid][9] ) {
			if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_MISSED_CALL_NR ] ) {

				return SendClientMessage(playerid, -1, "Nobody has called you during this session.");
			}
			else SendClientMessage(playerid, -1, sprintf("Last call to you done by %d", PlayerVar [ playerid ] [ E_PLAYER_PHONE_MISSED_CALL_NR ] ) ) ;
		}

		if ( playertextid == ptd_ph_design[playerid][11] ) {

			Phone_ShowSettings(playerid);
		}
	}

    return 1;
}

Phone_HideCallTextDraws(playerid) {

	for(new i, j = 3; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
	}

}

Phone_DestroyPlayedDraws(playerid) {
	for ( new i, j = 13; i < j; i ++ ) {
		PlayerTextDrawDestroy ( playerid, ptd_ph_design[playerid] [ i ] );
	}
	
	for ( new i, j = 3; i < j; i ++ ) {
		PlayerTextDrawDestroy ( playerid, ptd_ph_popup[playerid] [ i ] );
	}

	return true ;
}

Phone_LoadPlayerDraws(playerid) {

	ptd_ph_design[playerid][12] = CreatePlayerTextDraw(playerid, 127.0000, 355.0000, "mdl-29995:sidebutton");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][12], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][12], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][12], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][12], 8.0000, 32.0000);
	PlayerTextDrawSetSelectable(playerid, ptd_ph_design[playerid][12], true);


	ptd_ph_design[playerid][0] = CreatePlayerTextDraw(playerid, 129.5000, 328.0000, "mdl-29995:phone_blue");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][0], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][0], 80.0000, 125.0000);

	ptd_ph_design[playerid][1] = CreatePlayerTextDraw(playerid, 134.0000, 420.5000, "mdl-29995:mb_answer_left");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][1], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][1], 20.0000, 25.0000);
	PlayerTextDrawSetSelectable(playerid, ptd_ph_design[playerid][1], true);

	ptd_ph_design[playerid][2] = CreatePlayerTextDraw(playerid, 184.0000, 420.0000, "mdl-29995:mb_decline_right");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][2], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][2], 20.0000, 25.0000);
	PlayerTextDrawSetSelectable(playerid, ptd_ph_design[playerid][2], true);

	ptd_ph_design[playerid][3] = CreatePlayerTextDraw(playerid, 152.0000, 425.0000, "mdl-29995:mb_arrow_up");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][3], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][3], 24.0000, 25.0000);

	ptd_ph_design[playerid][4] = CreatePlayerTextDraw(playerid, 163.5000, 425.0000, "mdl-29995:mb_arrow_down");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][4], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][4], 24.0000, 25.0000);

	ptd_ph_design[playerid][5] = CreatePlayerTextDraw(playerid, 129.5000, 328.0000, "mdl-29995:bg_3");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][5], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][5], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][5], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][5], 80.0000, 125.0000);

	ptd_ph_design[playerid][6] = CreatePlayerTextDraw(playerid, 129.0000, 328.0000, "mdl-29995:screen_border");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][6], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][6], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][6], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][6], 80.0000, 125.0000);

	ptd_ph_design[playerid][7] = CreatePlayerTextDraw(playerid, 177.5000, 345.0000, "mdl-29995:battery_orange");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][7], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][7], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][7], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][7], 32.0000, 32.0000);

	ptd_ph_design[playerid][8] = CreatePlayerTextDraw(playerid, 150.0000, 357.5000, "mdl-29994:phone_message");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][8], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][8], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][8], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][8], 12.0000, 8.0000);
	PlayerTextDrawSetSelectable(playerid, ptd_ph_design[playerid][8], true);

	ptd_ph_design[playerid][9] = CreatePlayerTextDraw(playerid, 135.5000, 356.5000, "mdl-29994:phone_bell");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][9], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][9], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][9], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][9], 15.0000, 10.0000);
	PlayerTextDrawSetSelectable(playerid, ptd_ph_design[playerid][9], true);

	ptd_ph_design[playerid][10] = CreatePlayerTextDraw(playerid, 169.5000, 368.5000, "10:00");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][10], 0.3000, 1.0000);
	PlayerTextDrawAlignment(playerid, ptd_ph_design[playerid][10], 2);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][10], 1);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][10], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][10], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][10], 0.0000, 0.0000);

	ptd_ph_design[playerid][11] = CreatePlayerTextDraw(playerid, 191.0000, 412.0000, "mdl-29995:config");
	PlayerTextDrawFont(playerid, ptd_ph_design[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, ptd_ph_design[playerid][11], 0.0000, 0.0000);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_design[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_design[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_design[playerid][11], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_design[playerid][11], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_design[playerid][11], 10.0000, 10.0000);
	PlayerTextDrawSetSelectable(playerid, ptd_ph_design[playerid][11], true);


	////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////

	ptd_ph_popup[playerid][0] = CreatePlayerTextDraw(playerid, 202.5000, 384.0000, "_");
	PlayerTextDrawFont(playerid, ptd_ph_popup[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, ptd_ph_popup[playerid][0], 0.5000, 2.5000);
	PlayerTextDrawColor(playerid, ptd_ph_popup[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_popup[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_popup[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_popup[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_popup[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, ptd_ph_popup[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, ptd_ph_popup[playerid][0], -1549556822);
	PlayerTextDrawTextSize(playerid, ptd_ph_popup[playerid][0], 136.0000, 0.0000);

	ptd_ph_popup[playerid][1] = CreatePlayerTextDraw(playerid, 169.5000, 383.5000, "Incoming Call...");
	PlayerTextDrawFont(playerid, ptd_ph_popup[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, ptd_ph_popup[playerid][1], 0.1500, 0.8000);
	PlayerTextDrawAlignment(playerid, ptd_ph_popup[playerid][1], 2);
	PlayerTextDrawColor(playerid, ptd_ph_popup[playerid][1], -2686721);
	PlayerTextDrawSetShadow(playerid, ptd_ph_popup[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_popup[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_popup[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_popup[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_popup[playerid][1], 136.0000, 500.0000);

	ptd_ph_popup[playerid][2] = CreatePlayerTextDraw(playerid, 169.5000, 397.0000, "UnDEFINED");
	PlayerTextDrawFont(playerid, ptd_ph_popup[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, ptd_ph_popup[playerid][2], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, ptd_ph_popup[playerid][2], 2);
	PlayerTextDrawColor(playerid, ptd_ph_popup[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, ptd_ph_popup[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, ptd_ph_popup[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, ptd_ph_popup[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, ptd_ph_popup[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, ptd_ph_popup[playerid][2], 136.0000, 500.0000);

	return true ;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////// EXTRA FUNCS FOR FUNCTIONALITY ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Phone_ForceHidePhone(playerid) {

	for (new i, j = 13; i < j ; i ++ ) {
		PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ i ] ) ;
	}

	for (new i, j = 3; i < j ; i ++ ) {
		PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ i ] ) ;
	}

	CancelSelectTextDraw(playerid) ;
	RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM ) ;

	PlayerVar [ playerid ] [ player_viewphone ] = false ;

	return true ;
}