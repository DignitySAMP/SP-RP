#define SMS_MAX_LENGTH 	 	(128)
#define MAX_SENT_SMS	( 128 )
#define MAX_INBOX_SMS	( 128 )
#define MAX_STORED_SMS ( MAX_SENT_SMS + MAX_INBOX_SMS )

enum E_PLAYER_SMS_DATA {

	E_SMS_SQLID,
	E_SMS_CHAR_ID,
	E_SMS_RECEIVER, // char_id
	E_SMS_SENDER, // number

	E_SMS_DATA_TYPE, // inbox / sent
	E_SMS_TEXT[SMS_MAX_LENGTH],
	E_SMS_DATE,
	E_SMS_READ,
} ;

new PhoneSMS [ MAX_PLAYERS ] [ MAX_STORED_SMS ] [ E_PLAYER_SMS_DATA ], player_sms_count [ MAX_PLAYERS ] ;

enum {
	SMS_DATA_TYPE_INBOX,
	SMS_DATA_TYPE_SENT
} ;

CMD:inbox(playerid, params[]) {
	SMS_DisplayInbox_SQL(playerid);
	return true ;
}

SMS_DisplayInbox_SQL(playerid) {

	for ( new i; i < MAX_STORED_SMS ; i ++ ) {

		PhoneSMS [ playerid ] [ i ] [ E_SMS_SQLID ] = 0 ;
	}

	new query [ 256 + SMS_MAX_LENGTH ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "SELECT * FROM sms WHERE sms_character_id = '%d'",
		Character [ playerid ] [ E_CHARACTER_ID ]
	) ; 

	inline phone_inbox_sql() {
		if (cache_num_rows()) {
			// max 64 per player
			for (new i = 0, r = cache_num_rows(); i < r; ++i) {
				if ( r >= MAX_INBOX_SMS ) {

					SendClientMessage(playerid, PHONE_COLOUR_BAD, "Your inbox is full. New incoming messages will not save. Delete old texts to make space." ) ;
				}

				cache_get_value_name_int(i, "sms_id", PhoneSMS [ playerid ] [ i ] [ E_SMS_SQLID ]);
				cache_get_value_name_int(i, "sms_character_id", PhoneSMS [ playerid ] [ i ] [ E_SMS_CHAR_ID ]);
				cache_get_value_name_int(i, "sms_sender", PhoneSMS [ playerid ] [ i ] [ E_SMS_SENDER ]);
				cache_get_value_name_int(i, "sms_receiver_charid", PhoneSMS [ playerid ] [ i ] [ E_SMS_RECEIVER ]);
				cache_get_value_name_int(i, "sms_data_type", PhoneSMS [ playerid ] [ i ] [ E_SMS_DATA_TYPE ]);	
				cache_get_value_name_int(i, "sms_date", PhoneSMS [ playerid ] [ i ] [ E_SMS_DATE ]);		
				cache_get_value_name_int(i, "sms_read", PhoneSMS [ playerid ] [ i ] [ E_SMS_READ ]);	

				cache_get_value_name( i, "sms_text", PhoneSMS [ playerid ] [ i ] [ E_SMS_TEXT ]);
			}	

			SMS_DisplayInbox ( playerid );
		}

		else {

			SendClientMessage(playerid, PHONE_COLOUR_BAD, "You have no text messages in your inbox." ) ;
			return true ;
	
		}
	}

	MySQL_TQueryInline(mysql, using inline phone_inbox_sql, query, "");

	return true ;
}

SMS_DisplayInbox ( playerid ) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] == 0 ) {

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] = 1 ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] > 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_CHECKED_INBOX ] = true ;
	}

	PlayerTextDrawHide(playerid, ptd_ph_design[playerid][8]);
	PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], 0xDEDEDEFF);
	PlayerTextDrawShow(playerid, ptd_ph_design[playerid][8]);

	for(new i, j = 3; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
	}

	// Pagination stuff
	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage,bool: unread_msg  ;
    new resultcount = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] ) - MAX_ITEMS_ON_PAGE ) ;

    strcat(string, "Number\tDate\tMessage\n");


	new date [ 128 ], year, month, day, hour, minute, second ;


 	for ( new i = resultcount; i < MAX_INBOX_SMS; i ++ ) {
    	if ( PhoneSMS [ playerid ] [ i ] [ E_SMS_SQLID ] == 0 ) {

    		continue ;
    	}

		resultcount ++ ;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] ) {

			stamp2datetime(PhoneSMS [ playerid ] [ i ] [ E_SMS_DATE ], year, month, day, hour, minute, second, 1 ) ;
			format ( date, sizeof ( date ), "%d/%d/%d - %d:%d:%d", day, month, year, hour, minute, second ) ;

			if ( ! PhoneSMS [ playerid ] [ i ] [ E_SMS_READ ] ) {
				unread_msg = true ;
				format(string, sizeof(string), "%s{1F85DE}[UNREAD]{DEDEDE}%d \t %s \t %.26s...\n", string, PhoneSMS [ playerid ] [ i ] [ E_SMS_SENDER ], date, PhoneSMS [ playerid ] [ i ] [ E_SMS_TEXT ][0]); 
       		}
       		else format(string, sizeof(string), "%s%d \t %s \t %.26s...\n", string, PhoneSMS [ playerid ] [ i ] [ E_SMS_SENDER ], date, PhoneSMS [ playerid ] [ i ] [ E_SMS_TEXT ][0]); 

        }

     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] ) {

            nextpage = true;
            break;
        }
	}

	if ( unread_msg ) {

		SendServerMessage( playerid, 0x1F85DEFF, "Phone", "A3A3A3", "You've got unread text messages! Browse to the last page to view them." ) ;
	}

	new pages = floatround ( resultcount / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline phone_view_inbox(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

		if ( ! response ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] > 1 ) {

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] -- ;
				return SMS_DisplayInbox ( playerid ) ;
			}
		}

		if ( response ) {

			if ( listitem >= MAX_ITEMS_ON_PAGE) {

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] ++ ;
				return SMS_DisplayInbox ( playerid ) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {
				inline phone_inbox_options(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
					#pragma unused pidx, dialogidx, inputtextx

					if ( ! responsex ) {
						SMS_DisplayInbox ( playerid ) ;
					}

					else if ( responsex ) {

						switch ( listitemx ) {

							case 0: { 
								SMS_DisplayMessage(playerid, selection );
							} 
							case 1: {
								SendClientMessage(playerid, PHONE_COLOUR_MED, sprintf("[ PRINTING SMS IN SLOT %d ]", selection ) );
								SendClientMessage(playerid, PHONE_COLOUR_MED, sprintf("Text From:{DEDEDE} %d", PhoneSMS [ playerid ] [ selection ] [ E_SMS_SENDER ] ) );
								SendClientMessage(playerid, 0xDEDEDEFF, sprintf("\"%s\"", PhoneSMS [ playerid ] [ selection ] [ E_SMS_TEXT ] ) );
							}

							case 2: {


								SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("Removed message from inbox slot %d", selection ) ) ;

								new query [ 256 ] ;

								mysql_format ( mysql, query, sizeof ( query ), "UPDATE sms SET sms_character_id = %d WHERE sms_id = %d",
									INVALID_PLAYER_ID, PhoneSMS [ playerid ] [ selection ] [ E_SMS_SQLID ] ) ;

								mysql_tquery(mysql, query);

								SMS_DisplayInbox_SQL ( playerid ) ;

								return true ;
							}
						}
					}

				}

				Dialog_ShowCallback ( playerid, using inline phone_inbox_options, DIALOG_STYLE_LIST, sprintf("Inbox: Slot #%d", selection), "Read Message\nPrint Message\nDelete Message", "Select", "Back" ) ;

 				return true ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ] > 1 ) {
		Dialog_ShowCallback ( playerid, using inline phone_view_inbox, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Inbox: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ], pages), string, "Select", "Previous" ) ;
	}

	else Dialog_ShowCallback ( playerid, using inline phone_view_inbox, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Inbox: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_PHONE_INBOX_PAGE ], pages), string, "Select", "Close" ) ;

	return true ;
}

SMS_DisplayMenu(playerid) {
	inline phone_send_sms(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
		#pragma unused pidx, dialogidx, responsex, listitemx, inputtextx

		if ( ! responsex ) {
			Phone_ViewDialMenu ( playerid ) ;
		}

		if ( responsex ) {

			/*if ( Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] == strval(inputtext ) ) {

				return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You can't call yourself, dummy!") ;
			}*/

			if ( strlen ( inputtextx ) <= 1 || strval ( inputtextx) == 0 ) {

				return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've entered an invalid number!") ;
			}

			if ( ! CheckInputtextCrash ( playerid, inputtextx )) {

				return true ;
			}		

			inline phone_send_smstext(pidj, dialogidj, responsej, listitemj, string: inputtextj[]) {
					#pragma unused pidj, dialogidj, responsej, listitemj, inputtextj

				if ( ! responsej ) {
					Phone_ViewPhonebook ( playerid ) ;
				}

				if ( responsej ) {

					if ( strlen ( inputtextj ) > SMS_MAX_LENGTH ) {

						SendServerMessage( playerid, PHONE_COLOUR_MED, "Phone", "A3A3A3", "Your text message can't be longer than 128 characters. It's been cut off!" ) ;
					}

					if ( ! CheckInputtextCrash ( playerid, inputtextj )) {

						return true ;
					}		

					new count ;

					foreach(new target: Player) {

						if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == strval(inputtextx ) ) {

							SMS_SendMessage(target, playerid, inputtextj ) ;
							Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_SMS ) ;
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

			return Dialog_ShowCallback ( playerid, using inline phone_send_smstext, DIALOG_STYLE_INPUT, sprintf("{DEDEDE}Phonebook [{5CC44F}Credit: %d{DEDEDE}]", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]), "Enter your message.", "Proceed", "Back" ) ;
		}
	}

	return Dialog_ShowCallback ( playerid, using inline phone_send_sms, DIALOG_STYLE_INPUT, sprintf("{DEDEDE}Phonebook [{5CC44F}Credit: %d{DEDEDE}]", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]), "Enter the number of the person you want to text.", "Proceed", "Back" ) ;
}

SMS_SendMessage(sms_target, sms_sender, sms_text [] ) {

	new playerid = sms_target ;

	new sender_number = Character [ sms_sender ] [ E_CHARACTER_PHONE_NUMBER ] ;

	player_sms_count [ playerid ] ++ ;
	new index = player_sms_count [ playerid ] ;

	// We set the sms ID to "invalid" right now. MySQL will handle the rest.
	PhoneSMS [ playerid ] [ index ] [ E_SMS_SQLID ] = MAX_INBOX_SMS + 1 ;

	PhoneSMS [ playerid ] [ index ] [ E_SMS_CHAR_ID ] 		= Character [ playerid ] [ E_CHARACTER_ID ] ;
	PhoneSMS [ playerid ] [ index ] [ E_SMS_SENDER ] 		= sender_number ;
	PhoneSMS [ playerid ] [ index ] [ E_SMS_DATA_TYPE ] 	= SMS_DATA_TYPE_INBOX ;
	PhoneSMS [ playerid ] [ index ] [ E_SMS_DATE ] 			= gettime();

	strcat ( PhoneSMS [ playerid ] [ index ] [ E_SMS_TEXT ], sms_text ) ;

	if ( index > MAX_INBOX_SMS ) {

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You have too many inbox messages (128). Your most recent inbox message hasn't been saved." ) ;

		return true ;
	}

	new query [ 512 ] ;
	new sms_text_clear [ 256 ] ;
	mysql_escape_string(sms_text, sms_text_clear ) ;

	mysql_format ( mysql, query, sizeof ( query ), 
		"INSERT INTO sms(sms_character_id, sms_sender, sms_receiver_charid, sms_data_type, sms_text, sms_date, sms_read) VALUES (%d, %d, %d, %d, '%e', %d, 0)", 
		Character [ sms_target ] [ E_CHARACTER_ID ], sender_number, Character [ sms_target ] [ E_CHARACTER_ID ], SMS_DATA_TYPE_INBOX, sms_text_clear, PhoneSMS [ playerid ] [ index ] [ E_SMS_DATE ]
	) ;


	inline SMS_OnDatabaseInsert() {

		PhoneSMS [ playerid ] [ index ] [ E_SMS_SQLID ] = cache_insert_id ();

		query [ 0 ] = EOS ;
		format ( query, sizeof ( query ), "%s sends SMS to %s: %s", ReturnMixedName(playerid), ReturnMixedName(sms_target), sms_text);
		SendAdminListen(playerid, query);
	}

	MySQL_TQueryInline(mysql, using inline SMS_OnDatabaseInsert, query, "");

	return true ;
}

SMS_DisplayMessage(playerid, selection ) {

	new string [ 512 ] ;

	//new sms_text [ 128 ] = " This is a buffer to display text messages inside this dialog. Text will be cut off properly to keep it readable and compact." ;
	new sms_buffer [256];
	new sms_sender = PhoneSMS [ playerid ] [ selection ] [ E_SMS_SENDER ] ;

	strcat(sms_buffer, PhoneSMS [ playerid ] [ selection ] [ E_SMS_TEXT ] ) ;
 
	for(new i,j = strlen ( sms_buffer ), bool: index_set[3], space_index; i < j ; i ++ ) {

		if ( i >= 40 && ! index_set [ 0 ] ) {

			space_index = strfind(sms_buffer, " ", true, i ) ;

			strins(sms_buffer, "...\n", space_index ) ;
			index_set [ 0 ] = true ;
		}

		if ( i >= 87 && ! index_set [ 1 ] ) {

			space_index = strfind(sms_buffer, " ", true, i ) ;

			strins(sms_buffer, " ...\n", space_index ) ;
			index_set [ 1 ] = true ;
		}

		if (i >= 134 && ! index_set [ 2 ]) {

			space_index = strfind(sms_buffer, " ", true, i ) ;

			strins(sms_buffer, " ...\n", space_index ) ;
			index_set [ 2 ] = true ;
		}
	}

	new date [ 128 ], year, month, day, hour, minute, second ;
	stamp2datetime(PhoneSMS [ playerid ] [ selection ] [ E_SMS_DATE ], year, month, day, hour, minute, second, 1 ) ;
	format ( date, sizeof ( date ), "%d/%d/%d - %d:%d:%d", day, month, year, hour, minute, second ) ;

	format(string, sizeof(string), "{DEC61F}SMS From:{DEDEDE} %d\n{DEC61F}Date Sent:{DEDEDE} %s\n\n%s",
		sms_sender, date, sms_buffer
		
	) ;

	inline phone_enter_dial(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
		#pragma unused pidx, dialogidx, responsex, listitemx, inputtextx

		SMS_DisplayInbox_SQL(playerid) ;
		return true ;
	}

	Dialog_ShowCallback ( playerid, using inline phone_enter_dial, DIALOG_STYLE_MSGBOX, sprintf("Text Message From {DEC61F}%d", sms_sender), string, "Back" ) ;


	PhoneSMS [ playerid ] [ selection ] [ E_SMS_READ ] = true ;

	string[0]=EOS;
	mysql_format(mysql, string, sizeof ( string ), "UPDATE sms SET sms_read = 1 WHERE sms_id = %d",
	PhoneSMS [ playerid ] [ selection ] [ E_SMS_SQLID ] ) ;
	mysql_tquery(mysql, string);

	return true ;
}
