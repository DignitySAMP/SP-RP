#define MAX_PHONEBOOK_DESC	( 64 )
#define MAX_SAVED_NUMBERS	( 128 )

enum E_PH_BOOK_DATA { 

	E_PHBOOK_SQLID,
	E_PHBOOK_NR,
	E_PHBOOK_DESC [ MAX_PHONEBOOK_DESC ]
} ;

enum {
	PHONEBOOK_INDEX_CALL,
	PHONEBOOK_INDEX_SMS,
	PHONEBOOK_INDEX_EDIT,
	PHONEBOOK_INDEX_REMOVE // add "are you sure" dialog from mmartin
}

new Phonebook [ MAX_PLAYERS ] [MAX_SAVED_NUMBERS] [ E_PH_BOOK_DATA ] ;

Phone_Phonebook_Add ( playerid ) {

	inline phone_phonebook_add(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, listitem
		if ( ! response ) {
			Phone_ViewDialMenu ( playerid ) ;
		}

		if ( response ) {
			new number = strval( inputtext ) ;


			if ( ! CheckInputtextCrash ( playerid, inputtext )) {

				return true ;
			}	

			if ( ! number || strlen ( inputtext ) <= 1 ) {

				SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've entered an invalid number. Please only use digits.") ;
				return true ;
			}

			inline phone_phonebook_add2(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {

				if ( responsex ) {
					#pragma unused pidx, dialogidx, listitemx


					if ( ! CheckInputtextCrash ( playerid, inputtextx )) {

						return true ;
					}		

					SendServerMessage( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", sprintf("Added new contact with name \"%s\" and number %d.", inputtextx, strval(inputtext) )) ;

					new query [ 512 ] ; 

					mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO phonebook(character_id, phone_number, phone_desc) VALUES (%d, %d, '%e' )",
					Character [ playerid ] [ E_CHARACTER_ID ], strval(inputtext), inputtextx ) ;

					mysql_tquery ( mysql, query ) ;

					Phone_ViewPhonebook_SQL ( playerid ) ;
				}

				else Phone_ViewDialMenu ( playerid ) ;
				return true ;
			}

			Dialog_ShowCallback ( playerid, using inline phone_phonebook_add2, DIALOG_STYLE_INPUT, "Add new contact: name", "Enter the name of the contact you wish to add", "Add", "Back" ) ;
		}
		else Phone_ViewDialMenu ( playerid ) ;
	}
	Dialog_ShowCallback ( playerid, using inline phone_phonebook_add, DIALOG_STYLE_INPUT, "Add new contact: number", "Enter the number of the contact you wish to add", "Proceed", "Back" ) ;

	return true ;
}

Phone_ViewPhonebook_SQL ( playerid, view=true ) {
	new query [ 256 + MAX_PHONEBOOK_DESC ]; //, bool: nr_connected [ MAX_SAVED_NUMBERS ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "SELECT * FROM phonebook WHERE character_id = '%d'",
		Character [ playerid ] [ E_CHARACTER_ID ]
	) ; 

	for ( new i; i < MAX_SAVED_NUMBERS ; i ++ ) {

		Phonebook [ playerid ] [ i ] [ E_PHBOOK_SQLID ] = 0 ;
		Phonebook [ playerid ] [ i ] [ E_PHBOOK_NR ] = 0 ;
	}

	inline phone_phbook_sql() {
		if (cache_num_rows()) {
			// max 64 per player
			for (new i = 0, r = cache_num_rows(); i < r; ++i) {
				if ( r >= MAX_SAVED_NUMBERS ) {

					if ( view ) {
						SendClientMessage(playerid, PHONE_COLOUR_BAD, "You tried to fetch more than the max. number of saved numbers. Delete some and try again." ) ;
					}

					return true ;
				}
				cache_get_value_name_int(i, "phonebook_id", Phonebook [ playerid ] [ i ] [ E_PHBOOK_SQLID ]);
				cache_get_value_name_int(i, "phone_number", Phonebook [ playerid ] [ i ] [ E_PHBOOK_NR ]);
				cache_get_value_name( i, "phone_desc", Phonebook [ playerid ] [ i ] [ E_PHBOOK_DESC ]);
			}	

			if(view) {
				Phone_ViewPhonebook (playerid );
			}
		}

		else {

			if ( view ) {
				SendClientMessage(playerid, PHONE_COLOUR_BAD, "You have no saved numbers." ) ;
				return true ;
			}

			return true ;
		}
	}


	MySQL_TQueryInline(mysql, using inline phone_phbook_sql, query, "");

	return true ;
}

Phone_ViewPhonebook (playerid ) {


	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] == 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] = 1 ;
	}


	// Pagination stuff
	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage ;
    new resultcount = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] ) - MAX_ITEMS_ON_PAGE ) ;

    strcat(string, "Phone Number\t Description\n");

    for ( new i = resultcount; i < MAX_SAVED_NUMBERS; i ++ ) {
    	if ( Phonebook [ playerid ] [ i ] [ E_PHBOOK_NR ] == 0 ) {

    		continue ;
    	}

		resultcount ++ ;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] ) {

			format(string, sizeof(string), "%s%d \t %s\n", string, 
				Phonebook [ playerid ] [ i ] [ E_PHBOOK_NR ], 
				Phonebook [ playerid ] [ i ] [ E_PHBOOK_DESC ]); 
        }

     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] ) {

            nextpage = true;
            break;
        }
	}

	new pages = floatround ( resultcount / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline phone_view_phonebook(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

		if ( ! response ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] > 1 ) {

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] -- ;
				return Phone_ViewPhonebook ( playerid ) ;
			}

			else Phone_ViewDialMenu ( playerid ) ;
		}

		if ( response ) {

			if ( listitem >= MAX_ITEMS_ON_PAGE) {

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] ++ ;
				return Phone_ViewPhonebook ( playerid ) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {
				inline phone_phbook_options(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
					#pragma unused pidx, dialogidx, inputtextx

					if ( ! responsex ) {
						Phone_ViewPhonebook ( playerid ) ;
					}

					else if ( responsex ) {

						switch ( listitemx ) {

							case 0: Phonebook_OnActionPerformed ( playerid, selection, PHONEBOOK_INDEX_CALL );
							case 1: Phonebook_OnActionPerformed ( playerid, selection, PHONEBOOK_INDEX_SMS );
							case 2: Phonebook_OnActionPerformed ( playerid, selection, PHONEBOOK_INDEX_EDIT );
							case 3: Phonebook_OnActionPerformed ( playerid, selection, PHONEBOOK_INDEX_REMOVE );
						}
					}

				}

				Dialog_ShowCallback ( playerid, using inline phone_phbook_options, DIALOG_STYLE_LIST, sprintf("Phonebook: Contact #%d", selection), "Call Contact\nSMS Contact\nEdit Contact\nDelete Contact", "Select", "Back" ) ;

 				return true ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ] > 1 ) {
		Dialog_ShowCallback ( playerid, using inline phone_view_phonebook, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Phonebook: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ], pages), string, "Select", "Previous" ) ;
	}

	else Dialog_ShowCallback ( playerid, using inline phone_view_phonebook, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Phonebook: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_PHONE_PHONEBOOK_PAGE ], pages), string, "Select", "Back" ) ;

	return true ;
}

Phonebook_OnActionPerformed(playerid, selection, index=0) {

	new query [ 512 ] ;

	switch ( index ) {

		case PHONEBOOK_INDEX_CALL: {

			new count ;

			foreach(new target: Player) {

				if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ] ) {

					Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_CALL ) ;
					count ++ ;
					break ;
				} 
				else continue ;
			}

			if ( ! count ) {
				SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("The number \"%d\" can't be reached.", Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ])) ;
				return true ;
			}

			SendServerMessage( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", sprintf("You're calling number \"%d\" with description \"%s\".", 
				Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ], Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ] ) ) ;
		}

		case PHONEBOOK_INDEX_SMS: {

			inline phone_send_smstext(pidj, dialogidj, responsej, listitemj, string: inputtextj[]) {
					#pragma unused pidj, dialogidj, responsej, listitemj, inputtextj

				if ( ! responsej ) {
					Phone_ViewPhonebook ( playerid ) ;
				}

				if ( responsej ) {


					if ( ! CheckInputtextCrash ( playerid, inputtextj )) {

						return true ;
					}		

					if ( strlen ( inputtextj ) > SMS_MAX_LENGTH ) {

						SendServerMessage( playerid, PHONE_COLOUR_MED, "Phone", "A3A3A3", "Your text message can't be longer than 128 characters. It's been cut off!" ) ;
					}

					new count ;

					foreach(new target: Player) {

						if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ] ) {

							SMS_SendMessage(target, playerid, inputtextj ) ;
							Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_SMS ) ;
							count ++ ;
							break ;
						} 
						else continue ;
					}

					if ( ! count ) {
						SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("The number \"%d\" can't be reached.",  Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ])) ;
						return true ;
					}
				}
			}

			return Dialog_ShowCallback ( playerid, using inline phone_send_smstext, DIALOG_STYLE_INPUT, sprintf("{DEDEDE}Phonebook [{5CC44F}Credit: %d{DEDEDE}]", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]), "Enter your message.", "Proceed", "Back" ) ;
		}

		case PHONEBOOK_INDEX_EDIT: {
			inline phone_phbook_edit(pid, dialogid, response, listitem, string: inputtext[]) {
				#pragma unused pid, dialogid, inputtext, listitem

				if ( ! response ) {
					Phone_ViewPhonebook (playerid );
					return true ;
				}

				if ( response ) {

					if ( ! CheckInputtextCrash ( playerid, inputtext )) {

						return true ;
					}		

					new number;
					if(sscanf(inputtext, "i", number)) {
						SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've entered an invalid number. Please only use digits.") ;
						return true ;
					}

					SendClientMessage(playerid, -1, sprintf("Changed number to %d (previous: %d)",
						number, Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ]  ) ) ;

					Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ] = number ;

					mysql_format(mysql, query, sizeof ( query ), "UPDATE phonebook SET phone_number = %d WHERE phonebook_id = %d",
						Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ], Phonebook [ playerid ] [ selection ] [ E_PHBOOK_SQLID ] ) ;
				
					mysql_tquery(mysql, query, "", "" ) ;

					inline phone_phbook_edit2(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
						#pragma unused pidx, dialogidx, inputtextx, listitemx

						if ( ! responsex ) {

							Phone_ViewPhonebook (playerid ) ;
							return true ;
						}

						else if ( responsex ) {

							SendClientMessage(playerid, -1, sprintf("Changed desc to %s", inputtextx ) ) ;
							SendClientMessage(playerid, -1, sprintf("Previous: %s", Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ] ) ) ;
						
							Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ] [ 0 ] = EOS ;
							strcat(Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ], inputtextx ) ;

							mysql_format(mysql, query, sizeof ( query ), "UPDATE phonebook SET phone_desc = '%e' WHERE phonebook_id = %d",
								Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ], Phonebook [ playerid ] [ selection ] [ E_PHBOOK_SQLID ] ) ;
				
							mysql_tquery(mysql, query, "", "" ) ;
						}
					}

					Dialog_ShowCallback ( playerid, using inline phone_phbook_edit2, DIALOG_STYLE_INPUT, 
						sprintf("Phonebook: Editing Contact #%d", selection), 
						sprintf("Enter the new description\n(previously \"%s\")", Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ] ), 
					"Select", "Back" ) ;
				}
			}

			Dialog_ShowCallback ( playerid, using inline phone_phbook_edit, DIALOG_STYLE_INPUT, 
				sprintf("Phonebook: Editing Contact #%d", selection), 
				sprintf("Enter the new number (previously %d)", Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ] ), 
			"Select", "Back" ) ;

		}

		case PHONEBOOK_INDEX_REMOVE: {
			inline phone_phbook_del(pid, dialogid, response, listitem, string: inputtext[]) {
				#pragma unused pid, dialogid, inputtext, listitem, response

				if ( ! response ) {

					Phone_ViewPhonebook (playerid ) ;
					return true ;
				}

				if ( response ) {

					SendClientMessage(playerid, COLOR_RED, sprintf("You've deleted contact #%d. Taking you back to your phonebook...", selection));

					mysql_format(mysql, query, sizeof ( query ), "DELETE FROM `phonebook` WHERE phonebook_id = %d", Phonebook [ playerid ] [ selection ] [ E_PHBOOK_SQLID ] ) ;
					mysql_tquery(mysql, query, "", "" ) ;

					Phone_ViewPhonebook_SQL ( playerid );

					return true ;
				}
			}

			Dialog_ShowCallback ( playerid, using inline phone_phbook_del, DIALOG_STYLE_MSGBOX, 
				sprintf("Phonebook: Removing Contact #%d", selection), 
				sprintf("{DEDEDE}Are you sure you wish to delete this number (%d)?\n\nDescription: %s", 
				Phonebook [ playerid ] [ selection ] [ E_PHBOOK_NR ],
				Phonebook [ playerid ] [ selection ] [ E_PHBOOK_DESC ] ), 
			"Yes", "No" ) ;

		}
	}

	return true ;
}

CallRemoteNumberFromPhonebook(playerid, input[]) {

	new count, result ;

	for ( new i ; i < MAX_SAVED_NUMBERS; i ++ ) {
    	if ( Phonebook [ playerid ] [ i ] [ E_PHBOOK_NR ] == 0 ) {

    		continue ;
    	}

		if(strfind(Phonebook [ playerid ] [ i ] [ E_PHBOOK_DESC ], input, true) != -1) {

        	result = Phonebook [ playerid ] [ i ] [ E_PHBOOK_NR ] ;
        	count ++ ;
        }
	}

	if ( count <= 0 ) {

		return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("Tried reaching contact with name \"%s\", but they don't exist.", input)) ;		
	}

	else if ( count > 1 ) {		
		return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("Found multiple contacts with prefix \"%s\", be more specific!", input)) ;		
	}

	// match
	else if ( count == 1 ) {

		count = 0 ;

		foreach(new target: Player) {

			if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == result ) {

				Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_CALL ) ;
				count ++ ;
				break ;
			} 
			else continue ;
		}

		if ( ! count ) {
			SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("The number \"%d\" (searched prefix %s) can't be reached.",result, input)) ;
			return true ;
		}
	}

	return true ;
}
