static SendPlayerLocalOOC(playerid, text[144], bool:islow=false, bool:insidecar = false)
{
    if ( PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] ) 
	{
    	SendClientMessage(playerid, COLOR_YELLOW, "You can't use local chat while your /logout timer is ticking." ) ;
        return 0 ;
    }

	new string[256];

	if (!insidecar)
	{
		if (islow)
		{
			if (PlayerVar[playerid][E_PLAYER_ADMIN_DUTY])  {
				format(string,sizeof(string), "{A3A3A3} [low]: %s ))", text);
				ProxDetectorEx(playerid, 10.0, 0xA3A3A3FF, sprintf("(( (%d){E8871B}", playerid), string, .autospacing=false); 
			}
			else if (PlayerVar[playerid][E_PLAYER_IS_MASKED]) {

				format(string,sizeof(string), "[low]: %s ))", text);
				ProxDetectorEx(playerid, 10.0, 0xA3A3A3FF, sprintf("(( (%d)", Character[playerid][E_CHARACTER_MASKID]), string, .autospacing=false); 
			}
			else {
				format ( string, sizeof ( string ), "[low]: %s ))", text ) ;
				ProxDetectorEx(playerid, 10.0, 0xA3A3A3FF, "((", string, .showid = true, .autospacing=false); 
			}
		}
		else
		{
			if (PlayerVar[playerid][E_PLAYER_ADMIN_DUTY])  {
				format(string,sizeof(string), "{A3A3A3}: %s ))", text);
				ProxDetectorEx(playerid, 10.0, 0xA3A3A3FF, sprintf("(( (%d){E8871B}", playerid), string, .autospacing=false); 
			}
			else if (PlayerVar[playerid][E_PLAYER_IS_MASKED]) {

				format(string,sizeof(string), ": %s ))", text);
				ProxDetectorEx(playerid, 10.0, 0xA3A3A3FF, sprintf("(( (%d)", Character[playerid][E_CHARACTER_MASKID]), string, .autospacing=false); 
			}
			else {
				format ( string, sizeof ( string ), ": %s ))", text ) ;
				ProxDetectorEx(playerid, 10.0, 0xA3A3A3FF, "((", string, .showid = true, .autospacing=false); 
			}
		}

		AddLogEntry(playerid, LOG_TYPE_OOC, sprintf("(( %s ))", text));
	}
	else
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		foreach(new targetid: Player) 
		{
			if (GetPlayerVehicleID(targetid) == vehicleid)
			{
				if (PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) format ( string, sizeof ( string ), "(( [%s] (%d) %s{A3A3A3}: %s ))", ReturnVehicleName(vehicleid), playerid, ReturnSettingsName(playerid, targetid), text );
				else if (PlayerVar[playerid][E_PLAYER_IS_MASKED]) format ( string, sizeof ( string ), "(( [%s] (%d) %s: %s ))", ReturnVehicleName(vehicleid), Character[playerid][E_CHARACTER_MASKID], ReturnSettingsName(playerid, targetid), text ); 
				else format ( string, sizeof ( string ), "(( [%s] (%d) %s: %s ))", ReturnVehicleName(vehicleid), playerid, ReturnSettingsName(playerid, targetid), text ) ;

				ZMsg_SendClientMessage ( targetid, 0xA3A3A3FF, string);
			}
		}

		AddLogEntry(playerid, LOG_TYPE_OOC, sprintf("(( [CAR] %s ))", text));
	}

	return true ;
}

CMD:b(playerid, params[]) {

	new text[144], bool:quiet = Character[playerid][E_CHARACTER_ARREST_TIME] > 0;

	if ( sscanf ( params, "s[144]", text ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/b [text]" ) ;
	}

	SendPlayerLocalOOC(playerid, text, quiet);
	return true;
}

CMD:blow(playerid, params[]) {

	new text[144];

	if ( sscanf ( params, "s[144]", text ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/blow [text]" ) ;
	}

	SendPlayerLocalOOC(playerid, text, true);
	return true ;
}

CMD:bl(playerid, params[])
{
	return cmd_blow(playerid, params);
}

CMD:carb(playerid, params[]) {

	new text[144];

	if ( sscanf ( params, "s[144]", text ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/carb [text]" ) ;
	}

	if (!IsPlayerInAnyVehicle(playerid))
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be in a vehicle to use this chat.");
	}

	SendPlayerLocalOOC(playerid, text, false, .insidecar = true);
	return true ;
}

CMD:cb(playerid, params[])
{
	return cmd_carb(playerid, params);
}

CMD:toggleooc(playerid) {

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_JUNIOR ) {

		return false ;
	}

	new string [ 256 ] ;

	if ( ! Server [ E_SERVER_OOC_ENABLED ] ) {

		AddLogEntry(playerid, LOG_TYPE_SCRIPT, "has enabled OOC chat");
		format ( string, sizeof ( string ), "[!!!] [AdmWarn] %s has enabled OOC chat.", Account [playerid][E_PLAYER_ACCOUNT_NAME]) ;
		Server [ E_SERVER_OOC_ENABLED ] = true ;
	}

	else if ( Server [ E_SERVER_OOC_ENABLED ] ) {

		AddLogEntry(playerid, LOG_TYPE_SCRIPT, "has disabled OOC chat");
		format ( string, sizeof ( string ), "[!!!] [AdmWarn] %s has disabled OOC chat.", Account [playerid][E_PLAYER_ACCOUNT_NAME]) ;
		Server [ E_SERVER_OOC_ENABLED ] = false ;
	}

	SendAdminMessage(string) ;

	return true ;
}

CMD:ooc(playerid, params[]) {

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/ooc [text]" ) ;
	}

	if ( ! Server [ E_SERVER_OOC_ENABLED ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "OOC is currently disabled." ) ;
	}
	
	new string [ 256 ] ;

	foreach(new targetid: Player) {

		format ( string, sizeof ( string ), "(( [GLOBAL] (%d) %s{AAC4E5}: %s ))",  playerid, ReturnSettingsName(playerid, targetid, false, false), text ) ;

		if ( ! PlayerVar [ targetid ] [ E_PLAYER_HIDING_OOC ] ) {
			ZMsg_SendClientMessage ( targetid, COLOR_OOC, string);
		}

		else continue ;
	}
	
	AddLogEntry(playerid, LOG_TYPE_OOC, text);
	SendAdminListen(playerid, string) ;
	return true ;
}

CMD:o(playerid, params[]) {

	return cmd_ooc(playerid, params);
}

CMD:aooc(playerid, params[]) {
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_GENERAL ) {

		return SendServerMessage( playerid, COLOR_RED, "Warning", "A3A3A3",  "You need to be a general administrator + in order to be able to do this!" );
	}

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/aooc [text]" ) ;
	}

	
	new string [ 256 ] ;


	foreach(new targetid: Player) {
		format ( string, sizeof ( string ), "(( [AOOC] (%d) %s: %s ))",  playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], text ) ;
		ZMsg_SendClientMessage ( targetid, COLOR_STAFF, string);
	}

	AddLogEntry(playerid, LOG_TYPE_OOC, text);
	return true ;
}

PMSpamBan(playerid)
{
	new hours = 99999; // 10 years
    new secs = hours * 3600 ;
    new unbants = gettime() + secs;
	new reason [ 64 ], string[300];

	format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s has been banned for PM spamming.", playerid, ReturnMixedName(playerid)) ;
	SendAdminMessage(string, COLOR_ANTICHEAT) ;

	format ( reason, sizeof ( reason ), "Anticheat Detection: PM Spamming" ) ;
	SetAdminRecord ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_BAN, reason, -1, ReturnDateTime () ) ;
	
	mysql_format(mysql, string, sizeof(string), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
	Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( playerid ), "Anticheat", reason, gettime(), unbants);
	mysql_tquery(mysql, string);

	format ( string, sizeof ( string ),"banip %s", ReturnIP ( playerid ));
	SendRconCommand(string);

	Kick(playerid);
}

CMD:pm(playerid, params[]) 
{
	new userid, text[144];

	if (sscanf(params, "k<unmaskedplayer>s[144]", userid, text)) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/pm [id] [text]" ) ;
	}

	if (!IsPlayerConnected ( userid ) || !IsPlayerLogged(userid) || !IsPlayerPlaying(userid)) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Player isn't connected." ) ;
	}

	if (!IsPlayerPlaying(playerid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must spawn as a character first." ) ;
	}

	if (userid == playerid){

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't PM yourself." ) ;
	}

	if ( IsPlayerPaused ( userid ) ) {
		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The player you are messaging is AFK. Use /afklist." ) ;
	}

	if ( Account [ userid ] [ E_PLAYER_ACCOUNT_ID ] == 7 && !PlayerVar [ playerid ] [ E_PLAYER_ANTIDEV_PM ]) {

		PlayerVar [ playerid ] [ E_PLAYER_ANTIDEV_PM ] = true ;

		SendClientMessage(playerid, COLOR_ERROR, "There is no good reason why you would need to bother Hades. Do one of the few things:");
		SendClientMessage(playerid, COLOR_YELLOW, "If you have a development issue, create a bug ticket at our forums (https://forum.singleplayer-roleplay.com) (do NOT tag). " ) ;
		SendClientMessage(playerid, COLOR_YELLOW, "If you have an issue with a staff member, community change or misc, contact a management team member." ) ;
		SendClientMessage(playerid, COLOR_YELLOW, "If you are writing with the intent of asking ANYTHING related to staff, don't do it. There's better people to contact." ) ;
		SendClientMessage(playerid, COLOR_ERROR, "If you ignore this, you will be punished for it. Severely. Seriously - start following protocol." ) ;

		return true ;
	}

	if ( PlayerVar [ userid ] [ E_PLAYER_PM_BLOCKED ] && ! GetPlayerAdminLevel(playerid) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The person you are trying to message is blocking their private messages." ) ;
	}

	if (PlayerVar[playerid][E_PLAYER_LAST_PM_SENT_AT])
	{
		if (gettime() == PlayerVar[playerid][E_PLAYER_LAST_PM_SENT_AT])
		{
			new isnewb = CanPlayerUseGuns(playerid, 4);
			if (!isnewb)
			{
				format(text, 64, "%s", text);
				SendAdminMessage(sprintf("[AdmWarn] (%d) %s might be PM spamming: %s", playerid, ReturnMixedName(playerid), text));
				PlayerVar[playerid][E_PLAYER_LAST_PM_SENT_AT] = gettime();
				PlayerVar[playerid][E_PLAYER_PM_SPAM_COUNT] ++;

				if (PlayerVar[playerid][E_PLAYER_PM_SPAM_COUNT] >= 3)
				{
					PMSpamBan(playerid);
				}
			}

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Stop spamming and wait before sending another PM." ) ;
		}
	}

	PlayerVar[playerid][E_PLAYER_PM_SPAM_COUNT] = 0;
	PlayerVar[playerid][E_PLAYER_LAST_PM_SENT_AT] = gettime();

	new string [ 384 ] ;

	if (  Account [ userid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] > ADMIN_LVL_NONE && ! PlayerVar [ playerid ] [ E_PLAYER_PM_MOD_WARNING ] &&  !Account [ userid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] ) {

	 	inline PMingAdminResponse(pid, dialogid, response, listitem, string:inputtext[]) {

	        #pragma unused pid, dialogid, listitem, inputtext

	 		if ( response ) {

				GameTextForPlayer(userid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~New message!", 3000, 3);
				PlayerPlaySound(userid, 1085, 0.0, 0.0, 0.0);

				if (PlayerVar[playerid][E_PLAYER_ADMIN_DUTY])
				{
					format ( string, sizeof ( string ), "(( PM from {E9971B}%s (%d):{FFCC22} %s ))", ReturnMixedName(playerid), playerid, text )  ;
					ZMsg_SendClientMessage(userid, 0xFFCC2299, string);

				} else if (PlayerVar[playerid][E_PLAYER_HELPER_DUTY]) {
					format ( string, sizeof ( string ), "(( PM from {38C751}%s (%d):{FFCC22} %s ))", ReturnMixedName(playerid), playerid, text )  ;
					ZMsg_SendClientMessage(userid, 0xFFCC2299, string);
				}
				else
				{
					format ( string, sizeof ( string ), "(( PM from %s (%d):{FFFF22} %s ))", ReturnSettingsName(playerid, userid), playerid, text )  ;
					ZMsg_SendClientMessage(userid, 0xFFCC2299, string);
				}

				if (PlayerVar[userid][E_PLAYER_ADMIN_DUTY])
				{
					format ( string, sizeof ( string ), "(( PM to {E9971B}%s (%d):{FFFF22} %s ))", ReturnMixedName(userid), userid, text )  ;
					ZMsg_SendClientMessage(playerid, 0xFFFF22AA, string ); 

				} else if (PlayerVar[userid][E_PLAYER_HELPER_DUTY]) {
					format ( string, sizeof ( string ), "(( PM to {38C751}%s (%d):{FFFF22} %s ))", ReturnMixedName(userid), userid, text )  ;
					ZMsg_SendClientMessage(playerid, 0xFFFF22AA, string ); 
				}
				else
				{
					format ( string, sizeof ( string ), "(( PM to %s (%d):{FFFF22} %s ))", ReturnSettingsName(userid, playerid), userid, text )  ;
					ZMsg_SendClientMessage(playerid, 0xFFFF22AA, string ); 
				}

				// NEW LOGGING: Log this as a LOG_TYPE_PM for sender (playerid)
				AddLogEntry(playerid, LOG_TYPE_PM, string);
	 		}

	 		else if ( ! response ) {

	 			return true ;
	 		}
    	}

    	format ( string, sizeof ( string ), "{D63C3C}WARNING:{DEDEDE} You're sending a private message to an administrator.\n\n\
			Please make sure your query isn't related to their tasks, since there is /report for that.\n\n\
			If this administrator is helping you or you have something else to talk about, go ahead.\n\n\
			Thanks for understanding." );

		Dialog_ShowCallback(playerid, using inline PMingAdminResponse, DIALOG_STYLE_MSGBOX, "{D63C3C}PRIVATE MESSAGE WARNING:{DEDEDE}", string, "Proceed", "Cancel");

		PlayerVar [ playerid ] [ E_PLAYER_PM_MOD_WARNING ] = true ;

    	return true ;
	}

	else {

		GameTextForPlayer(userid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~New message!", 3000, 3);
		PlayerPlaySound(userid, 1085, 0.0, 0.0, 0.0);

		if (PlayerVar[playerid][E_PLAYER_ADMIN_DUTY])
		{
			format ( string, sizeof ( string ), "(( PM from {E9971B}%s (%d):{FFCC22} %s ))", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, text )  ;
			ZMsg_SendClientMessage(userid, 0xFFCC2299, string);
		}
		else
		{
			format ( string, sizeof ( string ), "(( PM from %s (%d): %s ))", ReturnSettingsName(playerid, userid), playerid, text )  ;
			ZMsg_SendClientMessage(userid, 0xFFCC2299, string);
		}

		if (PlayerVar[userid][E_PLAYER_ADMIN_DUTY])
		{
			format ( string, sizeof ( string ), "(( PM to {E9971B}%s (%d):{FFFF22} %s ))", Account[userid][E_PLAYER_ACCOUNT_NAME], userid, text )  ;
			ZMsg_SendClientMessage(playerid, 0xFFFF22AA, string ); 
		}
		else
		{
			format ( string, sizeof ( string ), "(( PM to %s (%d): %s ))", ReturnSettingsName(userid, playerid), userid, text )  ;
			ZMsg_SendClientMessage(playerid, 0xFFFF22AA, string ); 
		}

		AddLogEntry(playerid, LOG_TYPE_PM, string);
	}

	format ( string, sizeof ( string ), "[PM] %s sends to %s: %s", ReturnMixedName(playerid), ReturnMixedName(userid), text)  ;
	SendAdminListen(playerid, string) ;

	return 1;
}

CMD:blockpms(playerid, params[]) {

	return cmd_blockpm(playerid, params);
}

CMD:blockpm ( playerid, params [] ) {

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_PM_BLOCKED ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_PM_BLOCKED ]  = true ;
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, "disabled their PMs");

		return SendServerMessage ( playerid, COLOR_ERROR, "Info", "A3A3A3", "You are now blocking your private messages!" ) ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_PM_BLOCKED ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_PM_BLOCKED ]  = false ;
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, "enabled their PMs");

		return SendServerMessage ( playerid, COLOR_ERROR, "Info", "A3A3A3", "You have unblocked your private messages!" ) ;
	}

	return true ;
}