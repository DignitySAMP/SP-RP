Character_SpawnPlayer(playerid, listitem ) {

	SOLS_StopAudioStreamForPlayer(playerid);

	new string [ 256 ] ;

	if ( CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_KILLED ] ) {

		if ( gettime () < CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ] ) {

			new date[6];
			stamp2datetime ( CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ] ,date[0], date[1], date[2], date[3], date[4], date[5], 1 );
			format ( string, sizeof ( string ), "This account was killed by a hitman and is locked until {DEDEDE}%02d/%02d/%02d %02d:%02d:%02d", date[2], date[1], date[0], date[3], date[4], date[5]) ;

			SendClientMessage(playerid, COLOR_RED, string ) ;

			defer Account_DisplayCharacters[750](playerid);

			return true ;
		}

		else {
			mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hitman_killed = 0, player_hitman_unlocked = 0 WHERE player_id = %d",
				CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_ID ] 
			);
			
			mysql_tquery(mysql, string);

			CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_KILLED ] = 0 ;
			CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ] = 0 ;
		}
	}

	ClassBrowser_HideTextDraws(playerid);
	Account_LoadCharacterData(playerid, CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_ID ]);

	return true ;
}

Character_ShowCharMenu(playerid ) {

	new count = GetCharacterCount(playerid), dialog_string [ 512 ] ;

	strcat(dialog_string, "ID \tName\n");

	inline CharacterDisplay(pid, dialogid, response, listitem, string:inputtext[] ) { 
		#pragma unused pid, dialogid, response, listitem, inputtext

		if ( ! response ) {

			KickPlayer ( playerid ) ;
			return true ;
		}

		if ( response ) {

			if ( listitem >= count ) {

				if ( count >= MAX_CHARACTERS ) {
					SendClientMessage(playerid, COLOR_ERROR, "You can only have 5 characters. You can't pass this limit.");

					return Character_ShowCharMenu(playerid ) ;
				}

				else if ( count < MAX_CHARACTERS ) {

					ClassBrowser_HideTextDraws(playerid);
					return Account_CharacterCreation ( playerid ) ;
				}
			}

			if ( CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_KILLED ] ) {

				if ( gettime () < CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ] ) {

					new date[6];
					stamp2datetime ( CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ] ,date[0], date[1], date[2], date[3], date[4], date[5], 1 );
					format ( dialog_string, sizeof ( dialog_string ), "This account was killed by a hitman and is locked until {DEDEDE}%02d/%02d/%02d %02d:%02d:%02d", date[2], date[1], date[0], date[3], date[4], date[5]) ;

					SendClientMessage(playerid, COLOR_RED, dialog_string ) ;

					defer Account_DisplayCharacters[750](playerid);

					return true ;
				}

				else {
					mysql_format(mysql, dialog_string, sizeof(dialog_string), "UPDATE characters SET player_hitman_killed = 0, player_hitman_unlocked = 0 WHERE player_id = %d",
						CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_ID ] 
					);
					
					CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_KILLED ] = 0 ;
					CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ] = 0 ;
				}
			}
		
			ClassBrowser_HideTextDraws(playerid) ;

			PlayerClassSelection[playerid][E_PLAYER_CLASS_SEL_IN_MENU ] = false ;
			Account_LoadCharacterData(playerid, CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_ID ]);
			//SendClientMessage(playerid, -1, sprintf("Selected character (%d) %s (listitem %d)", CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_ID ],CharacterBuffer [ playerid ] [ listitem ] [ E_CHAR_BUFFER_ACC_ID ], listitem )) ;
		}
	}

	for ( new i, j = count; i < j ; i ++ ) {
		if ( i >= MAX_CHARACTERS ) {

			SendClientMessage(playerid, -1, sprintf("You have too many characters (%d). Exceeded limit of (%d).",
				i, MAX_CHARACTERS ) );
			continue ;
		}

		else {
			strcat(dialog_string, sprintf("(%d) \t %s\n", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_ID ], CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_NAME ] ));	
		}
	}

	if ( count < MAX_CHARACTERS ) {
		strcat(dialog_string, "[*] Create new character" ) ;
	}


	Dialog_ShowCallback ( playerid, using inline CharacterDisplay, DIALOG_STYLE_TABLIST_HEADERS, "Select a character", dialog_string, "Continue", "Quit" ) ;
	

	return true ;
}