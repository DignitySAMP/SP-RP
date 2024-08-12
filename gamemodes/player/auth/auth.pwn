
timer LoginWindow[1000](playerid, error_type) {
	SetPlayerInterior ( playerid, 0 );
	SetPlayerVirtualWorld ( playerid, 0 );

	// ELS Spikes / Basketball court. SOLS RPG 2023.
	//SetPlayerCameraPos(playerid, 2274.2747, -1378.9896, 46.2664);
	//SetPlayerCameraLookAt(playerid, 2274.8911, -1379.7729, 45.9514);

	// Banton projects
	SetPlayerCameraPos(playerid, 2187.9468, -1776.5255, 36.8942);
	SetPlayerCameraLookAt(playerid, 2187.4453, -1775.6537, 36.4540);

	PlayerVar[playerid][E_PLAYER_CREATING_CHAR] = false;
	PlayerVar[playerid][E_PLAYER_FIRST_SPAWN] = true;

	inline LoginForm(pid, dialogid, response, listitem, string:inputtext[] ) { 
		#pragma unused pid, dialogid, response, listitem, inputtext

		new query[512];

		if ( ! response ) {

			Kick ( playerid ) ;
		}

		else if ( response  ) {

			if(strlen(inputtext) <= 5) {
				LoginWindow(playerid, AUTH_MSG_WRONG_LENGTH);
				SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Your password may not be less than 5 characters.");
				return true;
			}

			mysql_format ( mysql, query, sizeof ( query ), "SELECT * FROM accounts WHERE account_name = '%e'", TEMP_ReturnPlayerName(playerid) );

			inline AccountCheck() {
				if (cache_num_rows()) {
					cache_get_value_name_int( 0, "account_id", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]);

					cache_get_value_name_int( 0, "account_namestyle", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ]);

					cache_get_value_name( 0, "account_name", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]);
					cache_get_value_name( 0, "account_password", Account [ playerid ] [ E_PLAYER_ACCOUNT_PASSWORD ]);
					//cache_get_value_name( 0, "account_salt", Account [ playerid ] [ E_PLAYER_ACCOUNT_PASSSALT ]);

					cache_get_value_name_int( 0, "account_supporter", Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ]);
					cache_get_value_name_int( 0, "account_stafflevel", Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ]);
					cache_get_value_name_int( 0, "account_contributor", Account [ playerid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ]);
					cache_get_value_name_int( 0, "account_premiumlevel", Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL]);

					cache_get_value_name_int( 0, "account_reports_done", Account [ playerid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ]);
					cache_get_value_name_int( 0, "account_questions_done", Account [ playerid ] [ E_PLAYER_ACCOUNT_QUESTIONS_DONE ]);

					cache_get_value_name_int( 0, "account_gunaccess", Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ]);
					cache_get_value_name_int( 0, "account_gunban", Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNBAN ]);

					cache_get_value_name( 0, "account_forumname", Account [ playerid ] [ E_PLAYER_ACCOUNT_FORUMNAME ]);
					cache_get_value_name( 0, "account_discordname", Account [ playerid ] [ E_PLAYER_ACCOUNT_DISCORDNAME ]);
					cache_get_value_name( 0, "account_email", Account [ playerid ] [ E_PLAYER_ACCOUNT_EMAIL ]);
					
					cache_get_value_name_int( 0, "account_setting_tips", Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ]);
					cache_get_value_name_int( 0, "account_setting_gangzones", Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ]);
					cache_get_value_name_int( 0, "account_setting_blinkers", Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ]);

					cache_get_value_name_int( 0, "account_reward_amount", Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT]);
					cache_get_value_name_int( 0, "account_reward_claimed", Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_CLAIMED]);

					cache_get_value_name( 0, "account_reward_ipaddress", Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_IP ] );

					// Load emmet cooldowns (per account)
					Emmet_LoadPlayerEntities(playerid);

					SetPVarInt(playerid, "Used_logout", false);
					GangZone_ShowForPlayer(playerid);

					// Adding a fix for spec!
					Character [ playerid ] [ E_CHARACTER_MOLE ] = INVALID_PLAYER_ID ;
					PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] = INVALID_PLAYER_ID ;	
					PlayerVar [ playerid ] [ E_PLAYER_LISTEN ] = INVALID_PLAYER_ID ;
					PlayerVar [ playerid ] [ E_PLAYER_CHOSE_CHARACTER ] = false ;
					Character [ playerid ] [ E_CHARACTER_ID ] = -1 ;

					// Do passwords match?
					bcrypt_verify(playerid, "OnPlayerAttemptLogin", inputtext, Account[playerid][E_PLAYER_ACCOUNT_PASSWORD]);
				}
				else
				{
					
					if (Server[E_SERVER_ACCS_DISABLED_UNTIL] && gettime() < Server[E_SERVER_ACCS_DISABLED_UNTIL])
					{
						SendClientMessage(playerid, COLOR_ERROR, "Sorry, new account registration has been temporarily disabled by an administrator.");
						SendClientMessage(playerid, COLOR_GRAD1, "Registrations will automatically reopen soon, so try again later!");
						KickPlayer(playerid);
						return 1;
					}
					bcrypt_hash(playerid, "OnPlayerAttemptRegister", inputtext, BCRYPT_COST);
				}
			}

			MySQL_TQueryInline(mysql, using inline AccountCheck, query, "" ) ;
		}
		return true ;
	}

	new string [ 768 ] ;

	format ( string, sizeof ( string ), "{FFFFFF}Welcome to {297183}%s{DEDEDE}, {FFFFFF}%s!\n\n\
		{DEDEDE}Failure to authenticate three times will result in a {E03232}kick{DEDEDE}.\nYou have a total of {EEC650}three minutes{DEDEDE} to authenticate.\n\n",
		SERVER_NAME, TEMP_ReturnPlayerName(playerid) ) ;

	switch ( error_type ) {

		case AUTH_MSG_DEFAULT: strcat ( string, "In order to proceed, enter a {EEC650}password{DEDEDE} below to authenticate (or register)."); // please enter your password below
		case AUTH_MSG_WRONG_PASS: strcat ( string, "The password you have entered is {E03232}incorrect{DEDEDE}. Please try again."); // the password you entered is incorrect
		case AUTH_MSG_WRONG_LENGTH: strcat ( string, "The password you have entered is {E03232}too short{DEDEDE}. It must be longer than 5 characters."); // the password you entered is incorrect
	}

	// if login attempts != 0, show login attempts
	// add timer here to kick player if no log in after x amount of time

	Dialog_ShowCallback ( playerid, using inline LoginForm, DIALOG_STYLE_PASSWORD, "Welcome to the server - please enter a password below", string, "Proceed", "Cancel" ) ;

	return true ;
}


IsRPNameRegex(const propname[])
{
	static Regex:regex;
	if (!regex) regex = Regex_New("^([A-Z][a-z]+_[A-Z][a-z]{0,2}[A-Z]{0,1}[a-z]*)$");

	return Regex_Check(propname, regex);
}



// if(response[E_DIALOG_RESPONSE_Response]) bcrypt_verify(playerid, "OnPlayerAttemptLogin", response[E_DIALOG_RESPONSE_InputText], Account[playerid][PLAYER_ACCOUNT_PASSWORD]);


forward OnPlayerAttemptLogin(playerid, bool:success);
public OnPlayerAttemptLogin(playerid, bool:success)
{
	if (!success) {

		LoginWindow(playerid, AUTH_MSG_WRONG_PASS);
		PlayerVar [ playerid ] [ player_islogged ] = false ;
		SendClientMessage(playerid, -1, "You have entered the INCORRECT password.");
	}

	else if ( success ) { // player is now logged in

		new query [512];
		mysql_format(mysql, query, sizeof(query), "UPDATE accounts SET account_lastip='%e' WHERE account_id=%d",  ReturnIP(playerid), Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] );
		mysql_tquery(mysql, query);

		PlayerVar [ playerid ] [ player_islogged ] = true ;
		PlayerVar [ playerid ] [ player_isregistered ] = true ;

		BanChecker ( playerid ) ;						
	}
}

Player_SendLoginMessage(playerid) {

	//new query [ 1024 ] ;
	//new buffer [ 1024 ] ;

	new str[256], rank[24], staff[32];

	SendClientMessage(playerid, -1, " " ) ;
	format ( str, sizeof ( str ), "Hey {5CB4E3}%s{FFFFFF}, welcome back to {297183}%s!{FFFFFF}", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], SERVER_NAME );
	SendClientMessage(playerid, -1, str ) ;

	GetPremiumRank ( Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ], rank, 24 ) ;
	GetAdminRankName ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ], staff, 32 ) ;

	SendClientMessage(playerid, -1, sprintf("You're logged in as a {EEC650}%s{FFFFFF}, playing as {5CB4E3}%s (%d)", rank, ReturnMixedName(playerid), Character[playerid][E_CHARACTER_ID]));
	
	if (Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ])
	{
		SendClientMessage(playerid, -1, sprintf("Note that your account has {EEC650}%s{FFFFFF} staff permissions.", staff));
	}

	if (Server [ E_SERVER_MOTD_EDIT_TIME ])
	{
		new year, month, day, hour, minute, second ;
		stamp2datetime(Server [ E_SERVER_MOTD_EDIT_TIME ], year, month, day, hour, minute, second, 1 ) ;
		SendClientMessage(playerid, -1, sprintf("To view the MOTD, type {297183}/viewmotd{DEDEDE} (last updated on {EEC650}%s %d, %d{DEDEDE})", date_getMonth(month), day, year ) ) ;
	}

	if (IsPlayerHelper(playerid))
	{

		new report_count = 0, questions_count = 0;

		foreach(new i: Player) {
			if(PlayerVar [ i ] [ E_PLAYER_REPORT_PENDING ])
				report_count++;
			if(PlayerVar [ i ] [ E_PLAYER_QUESTION_PENDING ])
				questions_count++;
		}

		new string[144];
		
		if (report_count && questions_count)
			format(string, sizeof(string), "There are {ED801A}%d reports{DEDEDE} and {ED801A}%d questions{DEDEDE} pending.", report_count, questions_count);
		else if (report_count)
			format(string, sizeof(string), "There are {ED801A}%d reports{DEDEDE} pending.", report_count);
		else if (questions_count)
			format(string, sizeof(string), "There are {ED801A}%d questions{DEDEDE} pending.", questions_count);
		else
			format(string, sizeof(string), "There are no reports or questions pending."); 

		// Reformat string to only show questions if they're a helper.
		if(IsPlayerHelper(playerid, .allow_admin = false) && questions_count)
		{
			string[0] = EOS;
			format(string, sizeof(string), "There are {ED801A}%d questions{DEDEDE} pending.", questions_count);
		}

		SendServerMessage(playerid, 0xED801AFF, "Staff", "DEDEDE", string);
		SendClientMessage(playerid, 0xDEDEDEFF, "Please handle all reports & questions as soon as possible!" ) ;
			
	}
	
	SendClientMessage(playerid, -1, " " ) ;
	
	return true ;
}
