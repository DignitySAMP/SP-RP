
Phone_ViewDialMenu ( playerid ) {
	inline phone_phbook_menu(pid, dialogid, response, listitem, string: inputtext[]) {
 		#pragma unused pid, dialogid, response, listitem, inputtext

		switch ( listitem ) {

			case 0: { // call number

				if ( response ) {
					inline phone_enter_dial(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
 						#pragma unused pidx, dialogidx, responsex, listitemx, inputtextx

						if ( ! responsex ) {
							Phone_ViewDialMenu ( playerid ) ;
							return true ;
						}

						if ( responsex ) {

							if ( ! CheckInputtextCrash ( playerid, inputtextx )) {

								return true ;
							}		

							new number = strval(inputtextx ) ;

							if ( Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] == number ) {

								return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You can't call yourself, dummy!") ;
							}

							if ( strlen ( inputtextx ) <= 1 || strval ( inputtextx) == 0 ) {

								return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've entered an invalid number!") ;
							}

							switch ( number ) {

								case 911, 666: {

									Phone_OnPlayerCallStaticNumber(playerid, number);
								}
								
								default: {
									new count ;

									foreach(new target: Player) {
										if ( GetPlayerState ( playerid ) == PLAYER_STATE_SPECTATING ) {

											continue ;
										}
										
										if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == number ) {

											Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_CALL ) ;
											count ++ ;
											break ;
										} 
										else continue ;
									}

									if ( ! count ) {
										SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("The number \"%d\" can't be reached.", strval(inputtextx))) ;
										return true ;
									}
								}
							}
						}
					}

					Dialog_ShowCallback ( playerid, using inline phone_enter_dial, DIALOG_STYLE_INPUT, sprintf("{DEDEDE}Phonebook [{5CC44F}Credit: %d{DEDEDE}]", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]), "Enter the number of the person you want to call.", "Proceed", "Back" ) ;
				}
			}


			case 1: {
				if ( response ) {
					SMS_DisplayMenu(playerid) ;	
				}
			}

			case 2: { // add contact
				Phone_Phonebook_Add ( playerid ) ;
			}

			case 3: { // view phonebook

				if ( response ) {
					Phone_ViewPhonebook_SQL ( playerid ) ;
				}
			}
		}
	}
	Dialog_ShowCallback ( playerid, using inline phone_phbook_menu, DIALOG_STYLE_LIST, sprintf("{DEDEDE}Phonebook [{5CC44F}Credit: %d{DEDEDE}]", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]), "Dial Number\nSend Message\nAdd Contact\nPhonebook", "Proceed", "Close" ) ;

	return true ;
}
