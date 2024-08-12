CMD:kick(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR && Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] < 3 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target, reason [ 64 ] ;

	if ( sscanf ( params, "k<player>s[64]", target, reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/kick [target] [reason]") ;
	}


	if ( strlen ( reason ) > sizeof ( reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Reason can't be longer than 64 characters.") ;
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", "Selected player doesn't exist, they might be offline.");
	}

	SetAdminRecord ( Account [ target ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], ARECORD_TYPE_KICK, reason, 0, ReturnDateTime () ) ;

	new query [ 256 ] ;

	format ( query, sizeof ( query ), "[AdmCmd]: %s was kicked by %s. Reason: %s", ReturnMixedName(target), Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
	ZMsg_SendClientMessageToAll(COLOR_RED, query);
	DCC_SendAdminPunishmentMessage(query);

	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("Was kicked by %s, reason: %s", ReturnMixedName(playerid), reason));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Kicked %s, reason: %s", ReturnMixedName(target), reason));

	KickPlayer(target);
	return true ;
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////


CMD:offlineban(playerid, params[]) {
	// master-acc
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new master_acc[MAX_PLAYER_NAME], hours, reason [ 64 ], query [ 256 ] ;

	if ( sscanf ( params, "s[24]is[64]", master_acc, hours, reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/offlineban [account name] [hours (0=perm)] [reason]") ;
	}

	if ( strlen ( master_acc ) < 0 || strlen ( master_acc ) > MAX_PLAYER_NAME ) {

		format ( query, sizeof ( query ), "Master account name can't be shorter than 0 or longer than %d.", MAX_PLAYER_NAME ) ;
		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3", query ) ;
	}

	if ( hours > 720 ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You can't temp ban someone for longer than 720 hours (4 weeks). For perm bans use 0.") ;
	}

	if ( strlen ( reason ) > sizeof ( reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Reason can't be longer than 64 characters.") ;
	}

	if(hours == 0) {
		hours = 99999;
	}

	query[0]=EOS;

	inline ReturnAccountName() {
		if (!cache_num_rows()) {
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Database didn't return any account data. Maybe your mistyped the name" )  ;
		}

		else {

		   	new secs = hours * 3600, unbants, acc_id ;
		    unbants = gettime() + secs;

		 	cache_get_value_name_int(0, "account_id", acc_id);

			new ip_address[32];
			cache_get_value_name ( 0, "account_lastip", ip_address);

			SendRconCommand(sprintf("banip %s", ip_address));

			SetAdminRecord ( acc_id, Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], ARECORD_TYPE_BAN, reason, hours, ReturnDateTime () ) ;

			mysql_escape_string(reason, reason, 64);

		    mysql_format(mysql, query, sizeof(query), "INSERT INTO bans (account_id, account_name, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', %d, %d)",
			acc_id, master_acc, Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], reason, gettime(), unbants);

			mysql_tquery(mysql, query);

			if (hours == 99999)
			{
				format ( query, sizeof ( query ), "[AdmCmd]: %s was offline-banned by %s. Reason: %s.", master_acc, Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
			}
			else
			{
				format ( query, sizeof ( query ), "[AdmCmd]: %s was offline-banned for %d hours by %s. Reason: %s.", master_acc, hours, Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
			}
			
			ZMsg_SendClientMessageToAll(COLOR_RED, query);
			DCC_SendAdminPunishmentMessage(query);

			AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Offline banned %s, reason: %s", master_acc, reason));
		}
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT account_id, account_lastip FROM accounts WHERE account_name = '%e'", master_acc ) ;
	MySQL_TQueryInline(mysql, using inline ReturnAccountName, query, "");


	return true ;
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

CMD:ban(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target, hours, reason [ 64 ] ;

	if ( sscanf ( params, "k<player>is[64]", target, hours, reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/ban [target] [hours (0=perm)] [reason]") ;
	}

	if ( hours > 720 ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You can't temp ban someone for longer than 720 hours (4 weeks). For perm bans use 0.") ;
	}

	if ( strlen ( reason ) > sizeof ( reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Reason can't be longer than 64 characters.") ;
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", "Selected player doesn't exist, they might be offline.");
	}

	if ( GetPlayerAdminLevel ( target ) >= GetPlayerAdminLevel ( playerid ) ) 
	{
		new str[144] ;
		format ( str, sizeof ( str ), "[!!!] [AdmWarn] (%d) %s attempted to ban (%d) %s.", playerid,  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], target,  Account [ target ] [ E_PLAYER_ACCOUNT_NAME ] ) ;
		SendAdminMessage(str) ;

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You can't ban admins of equal or higher rank.") ;
	}

	if(hours == 0) {
		hours = 99999;
	}

    new secs = hours * 3600 ;
    new unbants = gettime() + secs;

  	new query[256] ;

	if (hours == 99999)
	{
		format ( query, sizeof ( query ), "[AdmCmd]: %s was banned by %s. Reason: %s.", ReturnMixedName(target), Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
	}
	else
	{
		format ( query, sizeof ( query ), "[AdmCmd]: %s was banned for %d hours by %s. Reason: %s.", ReturnMixedName(target), hours, Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
	}
	
	ZMsg_SendClientMessageToAll(COLOR_RED, query);
	DCC_SendAdminPunishmentMessage(query);

	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("Was banned by %s, reason: %s", ReturnMixedName(playerid), reason));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Banned %s, reason: %s", ReturnMixedName(target), reason));

	mysql_escape_string(reason, reason, 64);
    mysql_format(mysql, query, sizeof(query), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
		Account [ target ] [ E_PLAYER_ACCOUNT_ID ], Account [ target ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( target ), ReturnMixedName(playerid), reason, gettime(), unbants);

	mysql_tquery(mysql, query);

	SetAdminRecord ( Account [ target ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], ARECORD_TYPE_BAN, reason, hours, ReturnDateTime () ) ;
	
	format ( query, sizeof ( query ), "banip %s", ReturnIP ( target ) ) ; 

	SendRconCommand(query);
	KickPlayer ( target ) ;

	return true ;	
}


CMD:silentban(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target, hours, reason [ 64 ] ;

	if ( sscanf ( params, "k<player>is[64]", target, hours, reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/silentban [target] [hours (0=perm)] [reason]") ;
	}

	if ( hours > 720 ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You can't temp ban someone for longer than 720 hours (4 weeks). For perm bans use 0.") ;
	}

	if ( strlen ( reason ) > sizeof ( reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Reason can't be longer than 64 characters.") ;
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", "Selected player doesn't exist, they might be offline.");
	}

	if ( GetPlayerAdminLevel ( target ) >= GetPlayerAdminLevel ( playerid ) ) 
	{
		new str[144] ;
		format ( str, sizeof ( str ), "[!!!] [AdmWarn] (%d) %s attempted to ban (%d) %s.", playerid,  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], target,  Account [ target ] [ E_PLAYER_ACCOUNT_NAME ] ) ;
		SendAdminMessage(str) ;

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You can't ban admins of equal or higher rank.") ;
	}

	if(hours == 0) {
		hours = 99999;
	}

    new secs = hours * 3600 ;
    new unbants = gettime() + secs;

  	new query[256] ;

	if (hours == 99999)
	{
		format ( query, sizeof ( query ), "[AdmCmd]: %s was silent-banned by %s. Reason: %s.", ReturnMixedName(target), Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
	}
	else
	{
		format ( query, sizeof ( query ), "[AdmCmd]: %s was silent-banned for %d hours by %s. Reason: %s.", ReturnMixedName(target), hours, Account[playerid][E_PLAYER_ACCOUNT_NAME], reason );
	}
	
	SendAdminMessage(query);
	DCC_SendAdminPunishmentMessage(query);

	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("Was silent banned by %s, reason: %s", ReturnMixedName(playerid), reason));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Silent banned %s, reason: %s", ReturnMixedName(target), reason));

	mysql_escape_string(reason, reason, 64);
    mysql_format(mysql, query, sizeof(query), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
		Account [ target ] [ E_PLAYER_ACCOUNT_ID ], Account [ target ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( target ), ReturnMixedName(playerid), reason, gettime(), unbants);

	mysql_tquery(mysql, query);

	SetAdminRecord ( Account [ target ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], ARECORD_TYPE_BAN, reason, hours, ReturnDateTime () ) ;
	
	format ( query, sizeof ( query ), "banip %s", ReturnIP ( target ) ) ; 

	SendRconCommand(query);
	KickPlayer ( target ) ;

	return true ;	
}



CMD:unban(playerid, params[] ) {
	// master-acc
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new master_acc [ MAX_PLAYER_NAME ], query[256] ;

	if ( sscanf ( params, "s[24]", master_acc) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/unban [master-account-name]") ;
	}

	if ( strlen ( master_acc ) < 0 || strlen( master_acc ) > MAX_PLAYER_NAME ) {

		format ( query, sizeof ( query ), "Master account name can't be shorter than 0 or longer than %s.", MAX_PLAYER_NAME  ) ;
		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3", query )  ;
	}

	inline ReturnAccountName() {
		if(!cache_num_rows()) {
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Database didn't return any account data. Maybe your mistyped the name" )  ;
		}

		else {
			new acc_id, last_ip[16] ;
			cache_get_value_name_int(0, "account_id", acc_id);
			cache_get_value_name(0, "account_lastip", last_ip);

			inline CheckUnban() {
				if(!cache_num_rows()) {
					format ( query, sizeof ( query ),"(%d) %s doesn't seem to be banned. Did you type the name correctly?", acc_id, master_acc );
					return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  query ) ;
				}
				else {
				    mysql_format ( mysql, query, sizeof ( query), "DELETE FROM bans WHERE account_id = %d", acc_id ) ;
					mysql_tquery(mysql, query);

					format ( query, sizeof ( query ), "[AdmWarn] %s has unbanned \"%s\"", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], master_acc ) ;
					DCC_SendAdminPunishmentMessage(query);
					UnbanIPAddr(last_ip);

					AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Unbanned %s", master_acc));
					SendClientMessage(playerid, COLOR_YELLOW, sprintf("%s has been unbanned", master_acc)) ;
				}
			}

			mysql_format ( mysql, query, sizeof ( query ), "SELECT * FROM bans WHERE account_id = %d", acc_id ) ;
			MySQL_TQueryInline(mysql, using inline CheckUnban, query, "");
		}
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT account_id, account_lastip FROM accounts WHERE account_name = '%e'", master_acc ) ;
	MySQL_TQueryInline(mysql, using inline ReturnAccountName, query, "");

	return true ;
}


///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

CMD:banip(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new ip [ 16 ], hours, reason[64], query[256] ;

	if ( sscanf ( params, "s[16]is[64]", ip, hours, reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/banip [ip address (including dots)] [hours] [reason]") ;
	}

	foreach(new targetid: Player ) {

		if ( ! strcmp(ip, ReturnIP(targetid), true ) ) {

			// User is online...
			format ( query, sizeof ( query ),"User seems to be connected as ID %d. Use /ban instead.", targetid  ) ;
			return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3", query ) ;
		}	
	}

	if ( hours > 720 ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You can't temp ban someone for longer than 720 hours (4 weeks). For perm bans use 0.") ;
	}

	if ( strlen ( reason ) > sizeof ( reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Reason can't be longer than 64 characters.") ;
	}

	if(hours == 0) {
		hours = 99999;
	}

    new secs = hours * 3600 ;
    new unbants = gettime() + secs;
    
	mysql_escape_string(reason, reason, 64);
    mysql_format(mysql, query, sizeof(query), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
		-1, "Unknown", ip,  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], reason, gettime(), unbants);

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "[AdmWarn] %s has banned IP %s for %d hours. Reason: %s.",  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ip, hours, reason ) ;
	DCC_SendAdminPunishmentMessage(query);

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Banned IP %s - %d hrs - %s", ip, hours, reason));

	format ( query, sizeof ( query ), "banip %s", ip ) ; 
	SendRconCommand(query ) ;

	return true ;
}

UnbanIPAddr(ip[16])
{
	new string [ 128 ] ;
	format ( string, sizeof ( string ), "unbanip %s", ip ) ; 
	SendRconCommand(string ) ;
}

CMD:unbanip ( playerid, params [] ) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new ip [  16 ];
	new string [ 128 ] ;

	if ( sscanf ( params, "s[16]", ip ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/unbanip [ip]") ;
	}

	UnbanIPAddr(ip);
	format ( string, sizeof ( string ), "[AdmWarn] %s has unbanned IP %s.",  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ip ) ;
	DCC_SendAdminPunishmentMessage(string);

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Unbanned IP %s", ip ));

	return true ;
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
BanChecker ( playerid ) {
	new query[512];
	inline BanHandler() {
		if (!cache_num_rows()) {
			Account_DisplayCharacters(playerid);
			return true ;
		} else {
			new unbantimestamp, admin [ MAX_PLAYER_NAME ], reason [ 64 ], date [ 6 ]  ;
			for( new i, r = cache_num_rows(); i < r; ++i) {
				cache_get_value_name(i, "ban_admin", admin);
				cache_get_value_name(i, "ban_reason", reason);

			 	cache_get_value_name_int( i, "unban_time", unbantimestamp);
			}

			//if ( unbantimestamp > gettime () )  {

			query [ 0 ] = EOS ;

			stamp2datetime ( unbantimestamp,date[0], date[1], date[2], date[3], date[4], date[5], 1 );

			SendClientMessage(playerid, COLOR_RED, "" ) ;
			SendClientMessage(playerid, COLOR_RED, "This account has been temporarily suspended due to a breach of our rules." ) ;
			SendClientMessage(playerid, COLOR_RED, "" ) ;

			format ( query, sizeof ( query ), "You got banned by admin %s for %s.", admin, reason) ;
			SendClientMessage(playerid, COLOR_RED, query );

			format ( query, sizeof ( query ), "You will be unbanned at {DEDEDE}%02d/%02d/%02d %02d:%02d:%02d", date[2], date[1], date[0], date[3], date[4], date[5]) ;
			SendClientMessage(playerid, COLOR_RED, query );
			SendClientMessage(playerid, COLOR_RED, "" ) ;
			SendClientMessage(playerid, COLOR_RED, "Please do not try to evade this ban, as it is only temporary and ban evading results in a permanent ban." ) ;

			format ( query, sizeof ( query ), "If you do not agree with this ban, please appeal the ban on our forums. {DEDEDE}(%s)", SERVER_WEBSITE ) ;
			SendClientMessage(playerid, COLOR_RED,query ) ;
			
			SendClientMessage(playerid, COLOR_RED, "" ) ;

			format ( query, sizeof ( query ), "banip %s", ReturnIP ( playerid ) ) ; 
			SendRconCommand(query ) ;

	    	return KickPlayer ( playerid ) ;
			//}
		}
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT unban_time, ban_admin, ban_reason FROM bans WHERE account_id = '%d'", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
	MySQL_TQueryInline(mysql, using inline BanHandler, query, "" ) ;

	return false ;
}