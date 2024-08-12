enum {
	PHONE_ALERT_SMS,
	PHONE_ALERT_CALL
} ;


timer Phone_FlashAlert[500](playerid, type, index, fromplayerid) {

	if ( type == PHONE_ALERT_SMS ) {

		if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_CHECKED_INBOX ] ) {
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_CHECKED_INBOX ] = false ;

			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = false ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
			PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

			PlayerTextDrawHide(playerid, ptd_ph_design[playerid][8]);
			PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], 0xDEDEDEFF);
			PlayerTextDrawShow(playerid, ptd_ph_design[playerid][8]);

			for(new i, j = 3; i < j ; i ++ ) {

				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
			}

			return true ;
		} 
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ]) {

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
		cmd_phanim(playerid);

		switch ( type ) {
			case PHONE_ALERT_SMS: SendClientMessage(playerid, -1, "To view your messages, click the envelope icon.");
			case PHONE_ALERT_CALL: {

				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ 1 ]);
				PlayerTextDrawColor(playerid, ptd_ph_popup[playerid] [ 1 ], PHONE_COLOUR_OK);
				PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 1 ], "Call connected with");

				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ 2 ]);
				PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 2 ], sprintf("%d", Character [ fromplayerid ] [ E_CHARACTER_PHONE_NUMBER ] ) ) ;


				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][9]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], PHONE_COLOUR_OK);

 				if ( PlayerVar [ playerid ] [ player_viewphone ] ) {
					PlayerTextDrawShow(playerid, ptd_ph_popup[playerid] [ 1 ]);
					PlayerTextDrawShow(playerid, ptd_ph_popup[playerid] [ 2 ]);
					PlayerTextDrawShow(playerid, ptd_ph_design[playerid][9]);
				}

				SendClientMessage(playerid, -1, "You have picked up.");
				SendClientMessage(fromplayerid, -1, "They have picked up.");

				///////////


				PlayerTextDrawHide(fromplayerid, ptd_ph_popup[playerid] [ 1 ]);
				PlayerTextDrawColor(fromplayerid, ptd_ph_popup[playerid] [ 1 ], PHONE_COLOUR_OK);
				PlayerTextDrawSetString(fromplayerid, ptd_ph_popup[playerid] [ 1 ], "Call connected with");

				PlayerTextDrawHide(fromplayerid, ptd_ph_popup[playerid] [ 2 ]);
				PlayerTextDrawSetString(fromplayerid, ptd_ph_popup[playerid] [ 2 ], sprintf("%d", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) ) ;

				PlayerTextDrawHide(fromplayerid, ptd_ph_design[playerid][9]);
				PlayerTextDrawColor(fromplayerid, ptd_ph_design[playerid][9], PHONE_COLOUR_OK);

 				if ( PlayerVar [ fromplayerid ] [ player_viewphone ] ) {
					PlayerTextDrawShow(fromplayerid, ptd_ph_popup[playerid] [ 1 ]);
					PlayerTextDrawShow(fromplayerid, ptd_ph_popup[playerid] [ 2 ]);
					PlayerTextDrawShow(fromplayerid, ptd_ph_design[playerid][9]);	
				}

				PlayerVar [ playerid ] [ player_phonecalling ] = fromplayerid ;
				PlayerVar [ fromplayerid ] [ player_phonecalling ] = playerid ;

				cmd_phanim(fromplayerid);

				defer Phone_ConnectPlayer(playerid, fromplayerid) ;
			}
		}

		return true ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] || !IsPlayerConnected(playerid) ) {

		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You can't reach the recipient." ) ;

		PlayerVar [ playerid ] [ player_phonecalling ] = INVALID_PLAYER_ID ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;


		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

		switch ( type ) {
			case PHONE_ALERT_SMS: {

				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][8]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], PHONE_COLOUR_MED);
				PlayerTextDrawShow(playerid, ptd_ph_design[playerid][8]);

				SendServerMessage( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", "You've muted your phone." ) ;
			}
			case PHONE_ALERT_CALL: {
				
				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][9]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], PHONE_COLOUR_MED);
				PlayerTextDrawShow(playerid, ptd_ph_design[playerid][9]);

				SendServerMessage( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", "You've declined the call." ) ;
				SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Your recipient has declined the call." ) ;
			}
		}

		for(new i, j = 3; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
		}

		return true ;
	}

	if ( ! IsPlayerConnected(fromplayerid) ) {

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The line went dead." ) ;

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

		switch ( type ) {

			case PHONE_ALERT_SMS: {
				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][8]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], PHONE_COLOUR_MED);
				PlayerTextDrawShow(playerid, ptd_ph_design[playerid][8]);
			}

			case PHONE_ALERT_CALL: {
				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ 1 ]);
				PlayerTextDrawColor(playerid, ptd_ph_popup[playerid] [ 1 ], PHONE_COLOUR_BAD);
				PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 1 ], "Missed Call From");
				PlayerTextDrawShow(playerid, ptd_ph_popup[playerid] [ 1 ]);

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_MISSED_CALL_NR ] = Character [ fromplayerid ] [ E_CHARACTER_PHONE_NUMBER ] ;

				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][9]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], PHONE_COLOUR_BAD);
				PlayerTextDrawShow(playerid, ptd_ph_design[playerid][9]);
			}
		}

		return true ;
	}

	if ( -- PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] <= 0 ) {

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

		switch ( type ) {


			case PHONE_ALERT_SMS: {

				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][8]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], PHONE_COLOUR_MED);

 				if ( PlayerVar [ playerid ] [ player_viewphone ] ) {
					PlayerTextDrawShow(playerid, ptd_ph_design[playerid][8]);
				}
			}

			case PHONE_ALERT_CALL: {

				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ 1 ]);
				PlayerTextDrawColor(playerid, ptd_ph_popup[playerid] [ 1 ], PHONE_COLOUR_BAD);
				PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 1 ], "Missed Call From");

				if ( PlayerVar [ playerid ] [ player_viewphone ] ) {
					PlayerTextDrawShow(playerid, ptd_ph_popup[playerid] [ 1 ]);
				}

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_MISSED_CALL_NR ] = Character [ fromplayerid ] [ E_CHARACTER_PHONE_NUMBER ] ;

				for(new i, j = 3; i < j ; i ++ ) {

					PlayerTextDrawHide(fromplayerid, ptd_ph_popup[playerid][i]);
				}

				SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The number you tried to call didn't pick up in time." ) ;

				PlayerTextDrawHide(fromplayerid, ptd_ph_design[playerid][9]);
				PlayerTextDrawColor(fromplayerid, ptd_ph_design[playerid][9], 0xDEDEDEFF);

 				if ( PlayerVar [ fromplayerid ] [ player_viewphone ] ) {
					PlayerTextDrawShow(fromplayerid, ptd_ph_design[playerid][9]);
				}


				PlayerTextDrawHide(playerid, ptd_ph_design[playerid][9]);
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], PHONE_COLOUR_BAD);

				if ( PlayerVar [ playerid ] [ player_viewphone ] ) {
					PlayerTextDrawShow(playerid, ptd_ph_design[playerid][9]);
				}
			}
		}

		return true ;
	}

	switch ( type ) {

		case PHONE_ALERT_SMS: {

			PlayerTextDrawHide(playerid, ptd_ph_design[playerid][8]);
			switch ( index ) {
				case 0: PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], 0xFFFFFFFF);
				case 1: PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], PHONE_COLOUR_MED);
			}
			PlayerTextDrawShow(playerid, ptd_ph_design[playerid][8]);
		}
		case PHONE_ALERT_CALL: {
			PlayerTextDrawHide(playerid, ptd_ph_design[playerid][9]);
			switch ( index ) {
				case 0: PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], 0xFFFFFFFF);
				case 1: PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], PHONE_COLOUR_MED);
			}
			PlayerTextDrawShow(playerid, ptd_ph_design[playerid][9]);
		}
	}

	switch ( type ) {

		case PHONE_ALERT_SMS: {

			PlayerPlaySound(playerid, 40405, 0.0, 0.0, 0.0);
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		}

		case PHONE_ALERT_CALL: {

			if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] ++ >= 4 ) {

				PlayerPlaySound(playerid, 20600, 0.0, 0.0, 0.0);

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
			}


			if ( PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] ++ >= 4 ) {

				//SendClientMessage(fromplayerid, -1, "Playing dial tone."); // reenable for debug!!!
				PlayerPlaySound(fromplayerid, 3600 , 0.0, 0.0, 0.0);

				PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
			}

		}
	}

	if ( index ++ >= 1) {


		index = 0 ;
	}

	defer Phone_FlashAlert(playerid, type, index, fromplayerid ) ;

	return true ;
}
