
CMD:lastonline(playerid, params[]) {

	new name [ MAX_PLAYER_NAME ] ;

	if ( sscanf ( params, "s[24]", name ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/lastonline [character]: use /getc to find characters linked to MA");
	}

	if ( strlen ( name ) > MAX_PLAYER_NAME ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Names can't be longer than 24 characters");
	}


	new query [ 96 ] ;
	inline ReturnAccountLastLogin() {
		if (!cache_num_rows()) {
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Database didn't return any data. Did you type the name correctly?");
		}

		new returned_date, date[6];
		cache_get_value_name_int(0, "player_logindate", returned_date);

		if (!returned_date) { 
			return SendClientMessage ( playerid, COLOR_RED, "Date cannot be calculated (timestamp is 0)" ) ;
		}

		stamp2datetime ( returned_date, date[0], date[1], date[2], date[3], date[4], date[5], 1 ) ;

		format ( query, sizeof ( query ), "{D19932}%s{FFFFFF} was last online at %02d/%02d/%d - %02d:%02d:%02d.", name, date[2], date[1], date[0], date[3], date[4], date[5]  ) ;
		return SendClientMessage ( playerid, COLOR_GRAD1, query ) ; 
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT player_logindate FROM characters WHERE player_name = '%e'", name ) ;
	MySQL_TQueryInline(mysql, using inline ReturnAccountLastLogin, query, "");

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Checked for %s's last login date.", name));

	return true ;
}

CMD:getcharid(playerid, params[]) {

	new name [ MAX_PLAYER_NAME ] ;

	if ( sscanf ( params, "s[24]", name ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/getcharid [name]");
	}

	if ( strlen ( name ) > MAX_PLAYER_NAME ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Names can't be longer than 24 characters");
	}

	new query [ 256 ] ;
	inline ReturnCharid() {

		new charname[32], charid, accname[32];
		if (!cache_num_rows()) 
		{
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Database didn't return any data. Did you type the name correctly?");
		}

		for(new i = 0, r = cache_num_rows(); i < r; ++i)
		{
			cache_get_value_name_int(i, "player_id", charid);
			cache_get_value_name(i, "player_name", charname);
			cache_get_value_name(i, "account_name", accname);
			SendClientMessage ( playerid, COLOR_GRAD1, sprintf("Character: %s (ID: %d, Account: %s)", charname, charid, accname) ) ; 
		}
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `characters`.`player_id`, `characters`.`player_name`, `accounts`.`account_name` FROM `characters` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `player_name` LIKE '%e'", name ) ;
	MySQL_TQueryInline(mysql, using inline ReturnCharid, query, "");

	return true ;
}

CMD:gcid(playerid, params[])
{
	return cmd_getcharid(playerid, params);
}

CMD:getcharname(playerid, params[]) {

	new charid;

	if ( sscanf ( params, "d", charid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/getcharname [character id]");
	}

	new query [ 256 ] ;
	inline ReturnCharName() {
		if(!cache_num_rows()) 
		{
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Database didn't return any data. Did you type the ID correctly?");
		}

		new charname[32], accname[32];
		for(new i = 0, r = cache_num_rows(); i < r; ++i)
		{
			cache_get_value_name(i, "player_name", charname);
			cache_get_value_name(i, "account_name", accname);
			SendClientMessage ( playerid, COLOR_GRAD1, sprintf("Character: %s (ID: %d, Account: %s)", charname, charid, accname) ) ; 
		}
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `characters`.`player_id`, `characters`.`player_name`, `accounts`.`account_name` FROM `characters` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`player_id` WHERE `player_id` = '%d'", charid ) ;
	MySQL_TQueryInline(mysql, using inline ReturnCharName, query, "");

	return true ;
}

CMD:gcn(playerid, params[])
{
	return cmd_getcharname(playerid, params);
}

CMD:getmasteraccount ( playerid, params [] ) {


	new name [ MAX_PLAYER_NAME ] ;

	if ( sscanf ( params, "s[24]", name ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/getma(steraccount) [character name]");
	}

	if ( strlen ( name ) > MAX_PLAYER_NAME ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Names can't be longer than 24 characters.");
	}

	if (!GetPlayerAdminLevel(playerid))
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to use this command.");
	}

	new query [ 128 ] ;

	inline ReturnAccountID() {
		if (!cache_num_rows()) {
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Database didn't return any account data. Maybe you mistyped the name" )  ;
		}


		new returned_id;
		cache_get_value_name_int(0, "account_id", returned_id);

		inline ReturnAccountName() {
			if(!cache_num_rows()) {
				return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Account ID exists but couldn't fetch name (no rows). Contact a dev." )  ;
			}
			else {
				new returned_name [ MAX_PLAYER_NAME ];
				cache_get_value_name(0, "account_name", returned_name);

				format ( query, sizeof ( query ), "%s's{FFFFFF} master account is {D19932}(%d) %s{FFFFFF}", name, returned_id, returned_name ) ;
				return SendClientMessage ( playerid, 0xD19932FF, query ) ; 
			}
		}

		mysql_format ( mysql, query, sizeof ( query ), "SELECT account_name FROM accounts WHERE account_id = %d", returned_id ) ;
		MySQL_TQueryInline(mysql, using inline ReturnAccountName, query, "");
		
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT account_id FROM characters WHERE player_name = '%e'", name ) ;
	MySQL_TQueryInline(mysql, using inline ReturnAccountID, query, "");

	return true ;
}

CMD:getma ( playerid, params [ ] ) {
	return cmd_getmasteraccount ( playerid, params ) ;
}

CMD:getcharacters ( playerid, params [] ) {

	new name [ MAX_PLAYER_NAME ] ;

	if ( sscanf ( params, "s[24]", name ) ) {
	
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/getc(haracters) [master_name]");
	}

	if (!GetPlayerAdminLevel(playerid))
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to use this command.");
	}

	if ( strlen ( name ) > MAX_PLAYER_NAME ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Names can't be longer than 24 characters.");
	}

	new query [ 128 ] ;

	inline ReturnMasterID() {
		if(!cache_num_rows())
		{
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Database didn't return any account data. Maybe you mistyped the name" )  ;
		}

		new returned_id, returned_name[32], level;
		cache_get_value_name_int(0, "account_id", returned_id);
		cache_get_value_name(0, "account_name", returned_name);

		inline ReturnCharacters() 
		{
			if(!cache_num_rows())
			{
				return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Account ID exists but couldn't fetch name (no rows). Contact a dev." )  ;
			}	

			SendClientMessage(playerid, 0xDEDEDEFF, sprintf("Found %d characters for account (%d) %s:", cache_num_rows(), returned_id, returned_name) ) ;

			for(new i = 0, r = cache_num_rows(); i < r; ++i)
			{
				cache_get_value_name_int(i, "player_id", returned_id);
				cache_get_value_name_int(i, "player_level", level);
				cache_get_value_name(i, "player_name", returned_name);

				SendClientMessage(playerid, 0xD19932FF, sprintf("(%d) %s (Level: %d)", returned_id, returned_name, level) ) ;
			}
		}

		mysql_format ( mysql, query, sizeof ( query ), "SELECT player_id, player_name, player_level FROM characters WHERE account_id = %d", returned_id ) ;
		MySQL_TQueryInline(mysql, using inline ReturnCharacters, query, "");	
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT account_id, account_name FROM accounts WHERE account_name LIKE '%e'", name ) ;
	MySQL_TQueryInline(mysql, using inline ReturnMasterID, query, "");	

	return true ;
}

CMD:getc ( playerid, params [] ) {
	return cmd_getcharacters ( playerid, params ) ;
}