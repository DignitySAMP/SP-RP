
forward OnPlayerAttemptRegister(playerid);
public OnPlayerAttemptRegister(playerid) {
    new hash[BCRYPT_HASH_LENGTH], query[768];
    bcrypt_get_hash(hash);
	
	mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO accounts (account_name, account_password) VALUES ('%e', '%e')", TEMP_ReturnPlayerName(playerid), hash ) ; // salt is 0 because im too lazy to remove it from db, but its not needed, just to avoid sql error
	inline OnAccountRegister() {

		// Account preliminaries
		Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] = cache_insert_id ();
		Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] [ 0 ] = EOS ;
		strcat(Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], TEMP_ReturnPlayerName(playerid));

		// Account variables
		PlayerVar [ playerid ] [ player_islogged ] = true ;
		PlayerVar [ playerid ] [ player_isregistered ] = false ;
		Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ] = 1 ; // show gzs by default

		mysql_format(mysql, query, sizeof(query), "UPDATE accounts SET account_setting_gangzones = %d WHERE account_id = %d", Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]) ;
		mysql_tquery(mysql, query);

		SaveRegistrationData(playerid);
		Account_DisplayCharacters(playerid) ;
	}
	MySQL_TQueryInline(mysql, using inline OnAccountRegister, query, "");
}

forward Account_CheckPlayerName(playerid, const name[]) ;
public Account_CheckPlayerName(playerid, const name[]) {
	if ( cache_num_rows() ) {

		//SendClientMessage(playerid, COLOR_ERROR, sprintf("The name \"%s\" already exists. Choose a different one!", name ) ) ;
		Account_CharacterCreation ( playerid, 3 );

		return true ;
	}
	else {

		new query [ 1024 ] ;

		Character [ playerid ] [ E_CHARACTER_NAME ] [ 0 ] = EOS ;
		strcat(Character [ playerid ] [ E_CHARACTER_NAME ], name);
		Character [ playerid ] [ E_CHARACTER_SKINID ] = 264 ;

		Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ] = -1 ;
		Character [ playerid ] [ E_CHARACTER_PROPERTYSPAWN ] = -1 ;
		Character [ playerid ] [ E_CHARACTER_HEALTH ] = 100.0 ;

		mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO characters (player_name, account_id, player_skinid, player_health, player_fat, player_muscle, player_stamina, player_spawnproperty) VALUES ('%e', %d, %d, '100.0', '400.0', '400.0', '400.0', '-1')",
		Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Character [ playerid ] [ E_CHARACTER_SKINID ] ) ;

		Gym_SetupDefaultVariables(playerid);

		inline OnCharacterRegister() {

			Character [ playerid ] [ E_CHARACTER_ID ] = cache_insert_id ();

			/*
			SendClientMessage(playerid, COLOR_BLUE, sprintf("Created character \"%s\" with ID %d.",
				Character [ playerid ] [ E_CHARACTER_NAME ], Character [ playerid ] [ E_CHARACTER_ID ] ) ) ;
			*/

			mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_registerdate = %d WHERE player_id = %d",
				gettime(), Character [ playerid ] [ E_CHARACTER_ID ] ) ;
			mysql_tquery(mysql, query, "", "");

			Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK] = true ;
			Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN] = true ;
			Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] 	= true ;
			Character [ playerid ] [ E_CHARACTER_HUD_TERRITORY] = true ;
			Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND] = true ;
			Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ] = true ;
			Character [ playerid ] [ E_CHARACTER_HUD_CLOCK ] = true ;

			switch ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) {

				// Dignity PMs blocked
				case 1: PlayerVar [ playerid ] [ E_PLAYER_PM_BLOCKED ] = true ;
			}

			mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_hud_territory = 1, player_hud_vehfadein = 1, player_hud_trademark = 1, player_hud_vehicle = 1, player_hud_voicelines = 1, player_hud_minigame = 1, player_hud_clock=1 WHERE player_id = %d",
				Character [ playerid ] [ E_CHARACTER_ID ]) ;
			mysql_tquery(mysql, query);


			Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ] = FIGHT_STYLE_NORMAL ;
			SetPlayerFightingStyle(playerid, Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ]);

			mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_fightstyle = %d WHERE player_id = %d",
				Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ], Character [ playerid ] [ E_CHARACTER_ID ]) ;
			mysql_tquery(mysql, query);
		}

		MySQL_TQueryInline(mysql, using inline OnCharacterRegister, query, "");


		defer Account_DisplayCharacters(playerid) ;

		return true ;
	}
}

Player_NametagChoice(playerid) {
	new string [ 1024 ] ;

	format ( string, sizeof ( string ), 
		"{DEDEDE}Our server was originally created for nostalgia. As time went on\n\
		we have decided to aim for a wider RP public and generalised\n\
		a lot of things.\n\n\
		The original oldschool server led by TheGame (2007-2011) used\n\
		gang tags to display gang affiliation. After many community\n\
		discussions on whether we should implement either FN_LN or tags\n\
		we have decided to add a switch system so everyone can choose\n\
		what they prefer.\n\n\
		If you are a new player who is new to roleplay and wants to try\n\
		the out the server, we encourage you to pick Gang Tags.\n\
		Example: \"{43B941}[GSF]Hades{DEDEDE}\"\n\n\
		If you are an experienced roleplayer who wants a normal roleplaying\n\
		 experience, we encourage you to pick FN_LN.\n\
		 Example: \"{FFFFFF}Addison_Barrington\"{DEDEDE}"
	) ;

	inline NameTagChoiceInfo(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, inputtext, listitem, dialogid, response

		inline NameTagSelect(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
			#pragma unused pidx, inputtextx, responsex, dialogidx

			string [ 0 ] = EOS ;

			switch ( listitemx ) {

				case 0: {					
					mysql_format(mysql, string, sizeof(string), "UPDATE accounts SET account_namestyle = 0 WHERE account_id=%d", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
					SendClientMessage(playerid, COLOR_YELLOW, "You've chosen the Oldschool Gang Tags as your nametag preference. You can change it at any time in /settings.");
					Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] = 0 ;
				}
				case 1: {
					mysql_format(mysql, string, sizeof(string), "UPDATE accounts SET account_namestyle = 1 WHERE account_id=%d", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
					SendClientMessage(playerid, COLOR_YELLOW, "You've chosen Firstname_Listname as your nametag preference. You can change it at any time in /settings");
					Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] = 1 ;
				}
			}

			mysql_tquery(mysql, string);

			//UpdateTabListForPlayers(playerid);
			UpdateTabListForPlayer(playerid);

			// Email collection for new accounts
			if (!strcmp ( Account [ playerid ] [ E_PLAYER_ACCOUNT_EMAIL ], "Undefined", true) ) 
			{
				GetPlayerEmail(playerid);
			}
		}

	   	Dialog_ShowCallback ( playerid, using inline NameTagSelect, DIALOG_STYLE_LIST, "Nametag Preference", "Gang Tags (Default: New Players)\nFirstname Lastname (Experienced)", "Continue" );
	}

   	Dialog_ShowCallback ( playerid, using inline NameTagChoiceInfo, DIALOG_STYLE_MSGBOX, "Nametag Preference", string, "Continue" );

	return true ;
}

SaveRegistrationData(playerid) { // useful to display data on the UCP per month, year, etc
	new year, month, day, hour, minute, second ;
	stamp2datetime(gettime(), year, month, day, hour, minute, second ) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "INSERT INTO registrations (account_id, day, month, year, unix) \
		VALUES (%d, %d, %d, %d, %d)", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], day, month, year, gettime()
	) ;

	mysql_tquery(mysql, query);

}
 