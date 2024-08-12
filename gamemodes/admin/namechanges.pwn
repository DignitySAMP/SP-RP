static ncdlgstr[1024];

static enum
{
	NC_TYPE_CHARACTER,
	NC_TYPE_ACCOUNT
}

#define NAMECHANGE_COST	15000

IsValidName(const name[])
{
	new i, len = strlen(name);
	for (i = 0; i < len; i++)
	{
		if (name[i] == '.' || name[i] == ',' || name[i] == ' ' || name[i] == '@' || name[i] == '%' || name[i] == '~' || name[i] == '$' || name[i] == '#')
		{
			return false;
		}
	}
	return true;
}


static PlayerNameChange(playerid, nctype, adminid = INVALID_PLAYER_ID, const error[] = EOS)
{
	inline PlayerNameChangeDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

		if (!response)
		{
			if (adminid != INVALID_PLAYER_ID)
			{
				// it's not optional, punk
				return PlayerNameChange(playerid, nctype, true);
			}

			return cmd_namechange(playerid);
		}

		if (response)
		{
			new cost = NAMECHANGE_COST;
			if (adminid != INVALID_PLAYER_ID) cost = 0;

			if (cost && GetPlayerCash(playerid) < cost)
			{
				return SendServerMessage ( playerid, COLOR_RED, "Error", "DEDEDE", sprintf("You need $%s in cash to do this.", IntegerWithDelimiter(cost)) ) ;
			}

			if (strlen(inputtext) < 3 || strlen(inputtext) >= MAX_PLAYER_NAME)
			{
				return PlayerNameChange(playerid, nctype, adminid, sprintf("Your new name must be between 3 and %d characters.", MAX_PLAYER_NAME));
			}

			if(!IsValidName(inputtext)) {

				return PlayerNameChange(playerid, nctype, adminid, "You may not use weird characters such as . , _ @ or spaces.");
			}

			new name[MAX_PLAYER_NAME], query[256];
			format(name, MAX_PLAYER_NAME, "%s", inputtext);



			if (nctype == NC_TYPE_CHARACTER && !IsRPNameRegex(name)) return PlayerNameChange(playerid, nctype, adminid, sprintf("You must enter a valid roleplay name (Firstname_Lastname), try again.", MAX_PLAYER_NAME));
			PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_COST ]  = cost;

			if (nctype == NC_TYPE_CHARACTER)
			{
				inline CheckIfCharacterExists() 
				{
					if (cache_num_rows()) return PlayerNameChange(playerid, nctype, adminid, "Sorry, this name is already in use by someone else.");

					PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_REQUEST ]  = 1;
					format ( PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_NAME ], MAX_PLAYER_NAME, "%s", name ) ;

					format ( query, sizeof ( query ),"[NAMECHANGE] (%d) %s (%s) has requested a namechange for their CHARACTER to \"%s\".", playerid, Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], Character [ playerid ] [ E_CHARACTER_NAME ], name);
					SendHelperMessage(query, .include_admins = true ) ;

					format ( query, sizeof ( query ),"To accept or deny the namechange, type {59BD93}/processnc %d [accept/deny]", playerid );
					SendHelperMessage(query, .include_admins = true ) ;
				}

				mysql_format ( mysql, query, sizeof ( query ), "SELECT player_name FROM characters WHERE player_name LIKE '%e'", name ) ;
				MySQL_TQueryInline(mysql, using inline CheckIfCharacterExists, query, "");
			}
			else if (nctype == NC_TYPE_ACCOUNT)
			{
				inline CheckIfMasterAccountExists() 
				{
					if (cache_num_rows()) return PlayerNameChange(playerid, nctype, adminid, "Sorry, this name is already in use by someone else.");

					PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_REQUEST ]  = 2;
					format ( PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_NAME ], MAX_PLAYER_NAME, "%s", name ) ;

					format ( query, sizeof ( query ),"[NAMECHANGE] (%d) %s (%s) has requested a namechange for their ACCOUNT to \"%s\".", playerid, Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], Character [ playerid ] [ E_CHARACTER_NAME ], name);
					SendHelperMessage(query, .include_admins = true ) ;
					
					format ( query, sizeof ( query ),"To accept or deny the namechange, type {59BD93}/processnc %d [accept/deny]", playerid );
					SendHelperMessage(query, .include_admins = true ) ;
				}

				mysql_format ( mysql, query, sizeof ( query ), "SELECT account_name FROM accounts WHERE account_name LIKE '%e'", name ) ;
				MySQL_TQueryInline(mysql, using inline CheckIfMasterAccountExists, query, "");
			}
		}
	}

	if (adminid != INVALID_PLAYER_ID)
	{
		if (nctype == NC_TYPE_CHARACTER) format(ncdlgstr, sizeof(ncdlgstr), "{FFFFFF}(%d) %s has requested you to change the name of your {AA3333}player character{FFFFFF}.", adminid, ReturnSettingsName(adminid, playerid, .color=false));
		else if (nctype == NC_TYPE_ACCOUNT) format(ncdlgstr, sizeof(ncdlgstr), "{FFFFFF}(%d) %s has requested you to change the name of your {AA3333}master account{FFFFFF}.", adminid, ReturnSettingsName(adminid, playerid, .color=false));
		format(ncdlgstr, sizeof(ncdlgstr), "%s\n{ADBEE6}Reason: %s", ncdlgstr, PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_REASON]);
		
		if (strlen(error))
		{
			format(ncdlgstr, sizeof(ncdlgstr), "%s\n\n{FF0000}%s", ncdlgstr, error);
		}

		strcat(ncdlgstr, "\n\n{FFFFFF}Please enter a new name and press {AA3333}OK{FFFFFF} to continue.");
		strcat(ncdlgstr, "\n{ADBEE6}You will not be charged any money for this name change.");
		Dialog_ShowCallback ( playerid, using inline PlayerNameChangeDlg, DIALOG_STYLE_INPUT, "Namechange Request", ncdlgstr, "OK" );
	}
	else
	{
		if (nctype == NC_TYPE_CHARACTER) format(ncdlgstr, sizeof(ncdlgstr), "{FFFFFF}You are about to change the name of your {AA3333}player character{FFFFFF}.");
		else if (nctype == NC_TYPE_ACCOUNT) format(ncdlgstr, sizeof(ncdlgstr), "{FFFFFF}You are about to change the name of your {AA3333}master account{FFFFFF}.");

		if (Character[playerid][E_CHARACTER_GUNLICENSE]) strcat(ncdlgstr, "\n\n{D68924}[!!!] {FFFFFF}This character has a gun license. You will lose it if you namechange.");
		
		if (strlen(error))
		{
			format(ncdlgstr, sizeof(ncdlgstr), "%s\n\n{FF0000}%s", ncdlgstr, error);
		}

		strcat(ncdlgstr, "\n\n{FFFFFF}Please enter a new name and press {AA3333}OK{FFFFFF} to continue.");
		format(ncdlgstr, sizeof(ncdlgstr), "%s\n{ADBEE6}You will be charged {AA3333}%s{ADBEE6} for this service.", ncdlgstr, IntegerWithDelimiter(NAMECHANGE_COST));
		
		if (nctype == NC_TYPE_CHARACTER) Dialog_ShowCallback ( playerid, using inline PlayerNameChangeDlg, DIALOG_STYLE_INPUT, "Character Namechange Service", ncdlgstr, "OK", "Back" );
		else Dialog_ShowCallback ( playerid, using inline PlayerNameChangeDlg, DIALOG_STYLE_INPUT, "Account Namechange Service", ncdlgstr, "OK", "Back" );
	}

	return true;
}

CMD:forcenamechange ( playerid, params [] ) 
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, option[10], reason[64];

	if ( sscanf ( params, "rs[10]s[64]", targetid, option, reason ) ) {

		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "DEDEDE", "/force(ame)c(hange) [player id] [character/account] [reason]" ) ;
	}

	if ( PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_REQUEST ] )
	{
		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "DEDEDE", "This player already has a pending namechange." ) ;
	}

	format(PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_REASON], 100, "%s", reason);
	new string [ 128 ] ;

	if ( ! strcmp ( option, "character", true ) )
	{
		format ( string, sizeof ( string ), "[ADMIN] (%d) %s forced (%d) %s to change character name: %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid), reason);
		SendAdminMessage ( string );
		PlayerNameChange(targetid, NC_TYPE_CHARACTER, playerid);
	} 
	else if ( ! strcmp ( option, "account", true ))
	{
		format ( string, sizeof ( string ), "[ADMIN] (%d) %s forced (%d) %s to change account name: %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid), reason);
		SendAdminMessage ( string );
		PlayerNameChange(targetid, NC_TYPE_ACCOUNT, playerid);
		
	}

	return true;
}

CMD:forcenc(playerid, params[])
{
	return cmd_forcenamechange(playerid, params);
}

CMD:namechange ( playerid ) 
{
	if ( PlayerVar [ playerid ] [ E_PLAYER_NAMECHANGE_REQUEST ] != 0 ) 
	{
		return SendServerMessage ( playerid, COLOR_RED, "Error", "DEDEDE", "You've already requested a namechange." ) ;
	}

	if (!IsAtGovFrontDesk(playerid))
	{
		return SendServerMessage ( playerid, COLOR_RED, "Error", "DEDEDE", "You must be at the counter inside City Hall to do this." ) ;
	}

	// Show new namechange menu.
	inline NcTyleDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

		if (response)
		{
			if (listitem == NC_TYPE_CHARACTER) PlayerNameChange(playerid, NC_TYPE_CHARACTER);
			else if (listitem == NC_TYPE_ACCOUNT) PlayerNameChange(playerid, NC_TYPE_ACCOUNT);
		}
	}

	Dialog_ShowCallback ( playerid, using inline NcTyleDlg, DIALOG_STYLE_LIST, "Select an option", "Change Player Character Name\nChange Master Account Name", "Select", "Back" );
	return true;
}

CMD:processnamechange ( playerid, params [] ) {

	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR && Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] < 2) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, option[7], reason[64] ;

	if ( sscanf ( params, "k<player>s[7]S[64](0)", targetid, option, reason ) ) {

		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "DEDEDE", "/processn(ame)c(hange) [playerid] [accept/deny] [reason (if denied)]" ) ;
	}

	if ( ! PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_REQUEST ] ) {

		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "DEDEDE", "This player hasn't requested a namechange." ) ;
	}

	new query [ 200 ];

	if ( ! strcmp ( option, "accept", true ) ) {

		if ( PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_COST ] && GetPlayerCash ( targetid ) < PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_COST ] ) {

			SendServerMessage ( playerid, COLOR_RED, "Syntax", "DEDEDE", "Target player doesn't have enough cash! Needs $15,000.");
			return SendServerMessage( targetid, COLOR_RED, "Error", "A3A3A3",  "You need at least $15,000 in order to namechange.");
		}

		TakePlayerCash ( targetid, PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_COST ] ) ;

		new type = PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_REQUEST ] ;

		format ( query, sizeof ( query ),"You've accepted %s (%d)'s namechange.",ReturnSettingsName(targetid, playerid, .color=false), targetid )  ;
		SendServerMessage ( playerid, COLOR_RED, "Syntax", "DEDEDE", query);

		switch ( type ) {

			case 1: 
			{
				// char
				format ( Character [ targetid ] [ E_CHARACTER_NAME ], MAX_PLAYER_NAME, "%s",PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ] ) ;

				//Player_UpdateNameTag(targetid);
 				UpdateTabListForOthers ( targetid ) ;

				format ( query, sizeof ( query ),"Your character namechange request was accepted by (%d) %s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME] ) ; 
				SendServerMessage ( targetid, COLOR_RED, "Namechange", "DEDEDE", query);

				if ( Character [ targetid ] [ E_CHARACTER_GUNLICENSE ] ) {
					Character [ targetid ] [ E_CHARACTER_GUNLICENSE ] = 0;

					format ( query, sizeof ( query ),"You have lost you gun license due to the namechange.") ; 
					SendServerMessage ( targetid, COLOR_RED, "Namechange", "DEDEDE", query);

					mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_gunlicense = %d WHERE player_id = %d", Character [ targetid ] [ E_CHARACTER_GUNLICENSE ], Character [ targetid ] [ E_CHARACTER_ID ] ) ;
					mysql_tquery ( mysql, query ) ;
				}

				mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_name = '%e' WHERE player_id = %d", PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ], Character [ targetid ] [ E_CHARACTER_ID ] ) ;
				mysql_tquery ( mysql, query ) ;

				AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("namechanged CHARACTER to \"%s\"", PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ]));
			}

			case 2: 
			{ 
				// MA
				format ( Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], MAX_PLAYER_NAME, "%s",PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ] ) ;
				//Player_UpdateNameTag(targetid);
				UpdateTabListForOthers ( targetid ) ;

				format ( query, sizeof ( query ),"Your account namechange request was accepted by (%d) %s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME] ) ; 
				SendServerMessage ( targetid, COLOR_RED, "Namechange", "DEDEDE", query);
				SendClientMessage(targetid, COLOR_RED, "You must use this new name to login with next time.");

				mysql_format ( mysql, query, sizeof ( query ), "UPDATE accounts SET account_name = '%e' WHERE account_id = %d", PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ], Account [ targetid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
				mysql_tquery ( mysql, query ) ;

				AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("namechanged ACCOUNT to \"%s\"", PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ]));

			}
		}

		PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_REQUEST ] = 0;
		PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ] = EOS;

		format ( query, sizeof ( query ),"[NAMECHANGE] (%d) %s has ACCEPTED (%d) %s's namechange request.", 
			playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME],targetid, Account[targetid][E_PLAYER_ACCOUNT_NAME] );
		SendAdminMessage(query ) ;
	}

	else if ( ! strcmp ( option, "deny" ) ) {

		if ( ! strlen ( reason ) ) {
			format ( query, sizeof ( query ),"%s has denied your namechange request: No reason specified.", Account[playerid][E_PLAYER_ACCOUNT_NAME] ) ;
			SendServerMessage ( targetid, COLOR_RED, "Namechange", "DEDEDE", query );

			format ( query, sizeof ( query ),"You've denied %s's namechange request: No reason specified.", ReturnMixedName(targetid)  );
			SendServerMessage ( playerid, COLOR_RED, "Namechange", "DEDEDE", query);
		}
		else {
			format ( query, sizeof ( query ),"%s has denied your namechange request: %s.", Account[playerid][E_PLAYER_ACCOUNT_NAME], reason ) ; 
			SendServerMessage ( targetid, COLOR_RED, "Namechange", "DEDEDE",query);

			format ( query, sizeof ( query ),"You've denied %s's namechange request: %s.", ReturnMixedName(targetid), reason  ) ;
			SendServerMessage ( playerid, COLOR_RED, "Namechange", "DEDEDE", query );
		}

		PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_REQUEST ] = 0;
		PlayerVar [ targetid ] [ E_PLAYER_NAMECHANGE_NAME ] = EOS;

		format ( query, sizeof ( query ),"[NAMECHANGE] (%d) %s has DENIED (%d) %s's namechange request.", 
			playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME],targetid, ReturnMixedName(targetid) );
		SendAdminMessage(query ) ;
	}

	return true ;
}

CMD:processnc ( playerid, params [] ) return cmd_processnamechange ( playerid, params ) ;

CMD:namechanges ( playerid, params [] ) {

	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR && Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] < 2) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new string [ 512 ], buffer[65], count = 0 ;

	strcat ( string, "Name\tType\tNew Name\n" );

	inline DisplayNamechangeRequests(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, response, dialogid, listitem, inputtext

	}

	foreach ( new i : Player ) {

		if (PlayerVar [ i ] [ E_PLAYER_NAMECHANGE_REQUEST ]) {

			format ( buffer, sizeof ( buffer ), "%s \t %s \t %s\n", ReturnMixedName(i), (PlayerVar [ i ] [ E_PLAYER_NAMECHANGE_REQUEST ] == 1) ? ("Character") : ("Master Account"), PlayerVar [ i ] [ E_PLAYER_NAMECHANGE_NAME ] ) ;
			strcat ( string, buffer ) ;
			
			count ++;
		}
		else continue;
	}

	if ( ! count ) {

		return SendServerMessage ( playerid, COLOR_YELLOW, "Namechanges", "DEDEDE", "There are no current namechange requests." ) ;
	}

	Dialog_ShowCallback ( playerid, using inline DisplayNamechangeRequests, DIALOG_STYLE_TABLIST_HEADERS, "Namechange Requests", string, "Continue");

	return true ;
}
