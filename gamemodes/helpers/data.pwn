
enum { // helper ranks
	HELPER_LVL_NONE,
	HELPER_LVL_TRIAL = 1,
	HELPER_LVL_NORMAL,
	HELPER_LVL_SENIOR
} ;


CMD:omakehelper(playerid, params[]) 
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_MANAGER ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new master_acc[32], rank[32], level = -1, query[128];
	if ( sscanf  (params, "s[32]s[32]", master_acc, rank ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/omakehelper [account name] [none / trial / normal / senior]" );
	}

	if ( strlen ( master_acc ) < 0 || strlen ( master_acc ) > MAX_PLAYER_NAME ) 
	{
		format ( query, sizeof ( query ), "Master account name can't be shorter than 0 or longer than %d.", MAX_PLAYER_NAME ) ;
		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3", query ) ;
	}

	if (!strcmp(rank, "none", true)) level = 0;
	else if (!strcmp(rank, "trial", true)) level = HELPER_LVL_TRIAL;
	else if (!strcmp(rank, "normal", true)) level = HELPER_LVL_NORMAL;
	else if (!strcmp(rank, "senior", true)) level = HELPER_LVL_SENIOR;

	if (level == -1)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/omakehelper [account name] [none / normal / senior]" );
	}

	inline UpdateHelperLevel()
	{
		new affected = cache_affected_rows();
		if (!affected) return SendServerMessage(playerid, COLOR_RED, "Error", "A3A3A3",  "Error: wrong account name or helper level is already that value.");

		if (level == HELPER_LVL_SENIOR) format(query, sizeof(query), "[HelperCmd]: (%d) %s has made %s a senior helper.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], master_acc);
		else if (level == HELPER_LVL_NORMAL) format(query, sizeof(query), "[HelperCmd]: (%d) %s has made %s a helper.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], master_acc);
		else if (level == HELPER_LVL_TRIAL) format(query, sizeof(query), "[HelperCmd]: (%d) %s has made %s a trial helper.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], master_acc);
		else format(query, sizeof(query), "[HelperCmd]: (%d) %s has removed %s from being a helper.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], master_acc);

		SendHelperMessage(query);
		AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Offline set %s helper rank to %d", master_acc, level));
		return true;
	}

	mysql_format(mysql, query, sizeof(query), "UPDATE `accounts` SET `account_supporter` = %d WHERE `account_name` LIKE '%e'", level, master_acc);
	MySQL_TQueryInline(mysql, using inline UpdateHelperLevel, query, "");
	return true ;
}

CMD:makehelper(playerid, params[]) {
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_ADVANCED ) {
		return false ;
	}

	new targetid, rank[32], string [ 256 ] ;

	if ( sscanf  (params, "k<player>s[32]", targetid, rank ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/makehelper [targetid/partOfName] [ remove, trial, helper, senior ]" );
	}

	if(!strcmp(rank, "remove", true)){
		if(!Account[targetid][E_PLAYER_ACCOUNT_SUPPORTER]) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't a helper." );
		} 

		format ( string, sizeof ( string ), "[HelperCmd]: (%d) %s has removed (%d) %s's helper rank.", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid) ) ;
		
		Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] = HELPER_LVL_NONE ;
		PlayerVar [ targetid ] [ E_PLAYER_HELPER_DUTY ] = false;
	}

	else if(!strcmp(rank, "trial", true)){

		format ( string, sizeof ( string ), "[HelperCmd]: (%d) %s has made (%d) %s a trial helper.", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid) ) ;
	
		Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] = HELPER_LVL_TRIAL ;
		PlayerVar [ targetid ] [ E_PLAYER_HELPER_DUTY ] = false;
	}

	else if(!strcmp(rank, "helper", true)){

		format ( string, sizeof ( string ), "[HelperCmd]: (%d) %s has made (%d) %s a helper.", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid) ) ;
	
		Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] = HELPER_LVL_NORMAL ;
		PlayerVar [ targetid ] [ E_PLAYER_HELPER_DUTY ] = false;
	}

	else if(!strcmp(rank, "senior", true)){
		format ( string, sizeof ( string ), "[HelperCmd]: (%d) %s has made (%d) %s to senior helper.", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid) ) ;
	
		Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] = HELPER_LVL_SENIOR ;
		PlayerVar [ targetid ] [ E_PLAYER_HELPER_DUTY ] = false;
	}
	else return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/makehelper [targetid/partOfName] [ remove, trial, helper, senior ]" );

	SendHelperMessage ( string );

	string [ 0 ] = EOS ;

	mysql_format ( mysql, string, sizeof ( string ), "UPDATE accounts SET account_supporter = %d WHERE account_id = %d",
		Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ], Account [ targetid ] [ E_PLAYER_ACCOUNT_ID ] ) ;

	mysql_tquery(mysql, string);

	return true ;
} 

CMD:helpers(playerid, params[]) {

	new count  , string[128], rank_name[32], rank_color[16];

	SendClientMessage(playerid, COLOR_HELPER, "__________________ Online Helpers __________________") ;

	foreach(new targetid: Player) {

		if (IsPlayerHelper ( targetid ) && !Account [ targetid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] && !Account [targetid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {

			count ++ ;

			rank_name [ 0 ] = EOS ;
			GetHelperRankName( Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ], rank_name, 32 ) ;
			GetHelperRankColor(Account [ targetid ] [ E_PLAYER_ACCOUNT_SUPPORTER ], rank_color, 16) ;

			if ( ! PlayerVar [ targetid ] [ E_PLAYER_HELPER_DUTY ] ) {
				format ( string, sizeof ( string ), "» %s%s{DEDEDE} | %s (ID: %d) | Answers: %d",
				rank_color, rank_name, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid, Account [ targetid ] [ E_PLAYER_ACCOUNT_QUESTIONS_DONE ]  );
				SendClientMessage(playerid, 0xa6a492FF,string );
				
			}

			else if ( PlayerVar [ targetid ] [ E_PLAYER_HELPER_DUTY ] ) {
				format ( string, sizeof ( string ), "» %s%s{DEDEDE} | %s (ID: %d) | Answers: %d",
				rank_color, rank_name, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid, Account [ targetid ] [ E_PLAYER_ACCOUNT_QUESTIONS_DONE ]  );
				SendClientMessage(playerid, 0x54acd2FF, string);
			}

			else continue ;
		}
	} 


	if ( ! count ) 
	{
		foreach(new targetid: Player) {

			if (Account [targetid][E_PLAYER_ACCOUNT_STAFFLEVEL] > 0 && !Account [ targetid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ]) 
			{
				format ( string, sizeof ( string ), "» {72B065}Admin{DEDEDE} | %s (ID: %d) | Answers: %d",
				Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid, Account [ targetid ] [ E_PLAYER_ACCOUNT_QUESTIONS_DONE ]  );
				SendClientMessage(playerid, COLOR_HELPER,string );

				count ++ ;
			}
		} 
	}

	if( !count ) {
		SendClientMessage(playerid, COLOR_GRAD0, "None");
	}

	SendClientMessage(playerid, COLOR_GRAD1, "Consult an inquiry with our helper team first, before reaching out to other staff. " ) ;
	SendClientMessage(playerid, COLOR_GRAD1, "To view a list of admins, use /admins." ) ;

	return true ;
}


GetHelperRankName(rank, rank_name[], len = sizeof ( rank_name ) ) {

	rank_name [ 0 ] = EOS ;

	switch ( rank ) {

		case 1:		strcat ( rank_name, "Trial Helper", len ) ;
		case 2:		strcat ( rank_name, "Helper", len ) ;
		case 3: 	strcat ( rank_name, "Senior Helper", len);
		default: strcat ( rank_name, "Regular", len ) ;
	}
}

GetHelperRankColor(rank, rank_color[], len = sizeof ( rank_color ) ) {

	rank_color [ 0 ] = EOS ;

	switch ( rank ) {

		case 1:		strcat ( rank_color, "{9FE6A0}", len ) ;
		case 2:		strcat ( rank_color, "{87db88}", len ) ;
		case 3:		strcat ( rank_color, "{72B065}", len ) ;
		default: strcat ( rank_color, "{FFFFF}", len ) ;
	}
}
