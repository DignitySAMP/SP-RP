
CMD:acceptreport ( playerid, params [] ) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "/acceptreport [targetid]");
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "That player doesn't seem to be connected anymore.");
	}

	if ( ! PlayerVar [ targetid ] [ E_PLAYER_REPORT_PENDING ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "That player doesn't seem to have a pending report.");
	}

	PlayerVar [ targetid ] [ E_PLAYER_REPORT_PENDING ] = false ;
	
	Account [ playerid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ]  ++ ;
	
	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE accounts SET account_reports_done = %d WHERE account_id = %d",
		Account [ playerid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Your report has been accepted by %s. They will contact you shortly.", Account[playerid][E_PLAYER_ACCOUNT_NAME] );
	SendServerMessage ( targetid, COLOR_BLUE, "Reports", "A3A3A3", query);


	if (strlen(PlayerVar[targetid][E_PLAYER_REPORT_REASON]) > 64)
	{
		format ( query, sizeof ( query ), "[REPORT] (%d) %s accepted the report by (%d) %s: \"%.64s...\"", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid), PlayerVar [ targetid ] [ E_PLAYER_REPORT_REASON ] ) ;
	}
	else
	{
		format ( query, sizeof ( query ), "[REPORT] (%d) %s accepted the report by (%d) %s: \"%s\"", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid), PlayerVar [ targetid ] [ E_PLAYER_REPORT_REASON ] ) ;
	}

	SendAdminMessage( query ) ;
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Accepted report by %s: \"%s\"", ReturnMixedName(targetid), PlayerVar [ targetid ] [ E_PLAYER_REPORT_REASON ]));

	return true ;
}

CMD:ar ( playerid, params [] ) {

	return cmd_acceptreport ( playerid, params ) ;
}

CMD:denyreport ( playerid, params [] ) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, reason[ 64 ] ;

	if ( sscanf ( params, "k<player>s[64]", targetid, reason ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "/denyreport [targetid] [reason]");
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "That player doesn't seem to be connected anymore.");
	}

	if ( ! PlayerVar [ targetid ] [ E_PLAYER_REPORT_PENDING ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "That player doesn't seem to have a pending report.");
	}

	if ( ! strlen ( reason ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You need to give a reason to deny the report.");
	}

	if ( strlen ( reason ) > 64 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Reason cannot be longer than 64 characters.");
	}

	PlayerVar [ targetid ] [ E_PLAYER_REPORT_PENDING ]  = false ;

	Account [ playerid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ]  ++ ;

	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE accounts SET account_reports_done = %d WHERE account_id = %d",
		Account [ playerid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Your report has been denied by %s, reason: %s.", Account[playerid][E_PLAYER_ACCOUNT_NAME], reason);
	SendServerMessage ( targetid, COLOR_BLUE, "Report", "A3A3A3", query );

	format ( query, sizeof ( query ),"[REPORT] (%d) %s denied the report of (%d) %s, reason: %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid), reason ) ;
	SendAdminMessage( query );

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Denied report by %s, reason: %s", ReturnMixedName(playerid), reason));

	return true ;
}

CMD:dr ( playerid, params [] ) {

	return cmd_denyreport ( playerid, params ) ;
}

CMD:reports ( playerid, params [] ) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new string [ 1024 ], count, reason[128];

	inline DisplayReports(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, response, dialogid, listitem, inputtext

	}

	string[0] = EOS;

	strcat(string,"Reporter\tReported\tReason\tTime\n");

	foreach(new i: Player) {

		if ( PlayerVar [ i ] [ E_PLAYER_REPORT_PENDING ] && IsPlayerConnected(PlayerVar[i][E_PLAYER_REPORT_TARGET]) ) {

			count ++ ;
			if (strlen(PlayerVar [ i ] [ E_PLAYER_REPORT_REASON ]) > 50)
			{
				format(reason, sizeof(reason), "%.50s...", PlayerVar [ i ] [ E_PLAYER_REPORT_REASON ]);
			}
			else
			{
				format(reason, sizeof(reason), "%s", PlayerVar [ i ] [ E_PLAYER_REPORT_REASON ]);
			}

			format ( string, sizeof ( string ), "%s(%d) %s\t(%d) %s\t%s\t%s\n", 
				string, i, ReturnMixedName(i), 
				PlayerVar [ i ] [ E_PLAYER_REPORT_TARGET ], ReturnMixedName(PlayerVar [ i ] [ E_PLAYER_REPORT_TARGET ]),
				reason, GetDuration(gettime() - PlayerVar [ i ] [ E_PLAYER_REPORT_TIME ] )
			);
		}
	}

	if ( count == 0 ) {

		string = "No reports to display." ;
	}

	Dialog_ShowCallback ( playerid, using inline DisplayReports, DIALOG_STYLE_TABLIST_HEADERS, "Reports", string, "Continue");

	return true ;
}

CMD:report ( playerid, params [] ) {

	new string[256], string2[64];

	if (PlayerVar [ playerid ] [ E_PLAYER_REPORT_COOLDOWN ]  >= gettime ()) {

		format ( string, sizeof ( string ), "You need to wait %d seconds before sending another report", PlayerVar [ playerid ] [ E_PLAYER_REPORT_COOLDOWN] - gettime ()) ;

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", string );
	}

	new targetid, reason [ 128 ] ;

	if ( sscanf ( params, "k<player>s[128]", targetid, reason ) ) 
	{
		SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "/report [player] [reason]");
		SendClientMessage(playerid, 0xDEDEDEFF, sprintf("TIP: You can use your own Player ID (%d) for general admin enquiries.", playerid));
		return true;
	}

	if(!IsPlayerConnected(targetid)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "That playerid is not connected.");
	}

	if ( strlen ( reason ) >= 80 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Reports should be brief, no more than 80 characters please.");
	}

	format ( PlayerVar [ playerid ] [ E_PLAYER_REPORT_REASON ] , 100, "%s", reason ) ;
	//printf("%s, %s", reason, PlayerReportReason [ playerid ]) ;

	PlayerVar [ playerid ] [ E_PLAYER_REPORT_TARGET ] = targetid;
	PlayerVar [ playerid ] [ E_PLAYER_REPORT_PENDING ] = true ;
	PlayerVar [ playerid ] [ E_PLAYER_REPORT_COOLDOWN ] = gettime () + 30 ;
	PlayerVar [ playerid ] [ E_PLAYER_REPORT_TIME] = gettime (); 
	PlayerVar [ playerid ] [ E_PLAYER_REPORT_ALERT_TIME] = gettime (); 

	SendServerMessage ( playerid, COLOR_BLUE, "Report", "A3A3A3", "Report successfully sent. Please wait a few minutes before reporting again." ) ;

	if (playerid == targetid) format(string, sizeof (string), "{59BD93}[REPORT]{A3A3A3} (%d) %s reports:{FFFFFF} %s", playerid, ReturnMixedName(playerid), reason);
	else format(string, sizeof (string), "{59BD93}[REPORT]{A3A3A3} (%d) %s reports (%d) %s:{FFFFFF} %s", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid), reason);
	
	format(string2, sizeof(string2), "To accept this report, type {59BD93}/ar %d{DEDEDE}. To disregard, use {59BD93}%d", playerid, playerid);
	
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Reported %s for: %s", ReturnMixedName(targetid), reason));
	if (playerid != targetid) AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("Was reported by %s for: %s", ReturnMixedName(playerid), reason));

	foreach(new i: Player) 
	{
		if ( Character [ i ] [ E_CHARACTER_ID ] == -1 ) 
		{
			continue ;
		}

		if (GetPlayerAdminLevel(i) > ADMIN_LVL_JUNIOR || Account[i][E_PLAYER_ACCOUNT_STAFFLEVEL] >= ADMIN_LVL_JUNIOR) 
		{
			ZMsg_SendClientMessage(i, 0xDEDEDEFF, string);
			SendClientMessage(i, 0xDEDEDEFF, string2);
		}
	}

	return true ;
}

CMD:re(playerid, params[]){

	return cmd_report(playerid,params);
}

Report_PlayerTick(playerid)
{
	if ( PlayerVar [ playerid ] [ E_PLAYER_REPORT_PENDING ] && gettime() - PlayerVar [ playerid ] [ E_PLAYER_REPORT_ALERT_TIME] > 300)
	{
		new str[144], targetid = PlayerVar[playerid][E_PLAYER_REPORT_TARGET];

		if (!IsPlayerConnected(targetid))
		{
			// If the report target isn't connected, don't bother.
			return false;
		}

		if (targetid == playerid)
		{
			if (strlen(PlayerVar[playerid][E_PLAYER_REPORT_REASON]) > 50)
			{
				format(str, sizeof(str), "[REPORT]{DEDEDE} (%d) %s reported %s:{DEDEDE} \"%.50s...\"", playerid, ReturnMixedName(playerid), GetDuration(gettime() - PlayerVar [ playerid ] [ E_PLAYER_REPORT_TIME ] ), PlayerVar [ playerid ] [ E_PLAYER_REPORT_REASON ]);
			}
			else
			{
				format(str, sizeof(str), "[REPORT]{DEDEDE} (%d) %s reported %s:{DEDEDE} \"%s\"", playerid, ReturnMixedName(playerid), GetDuration(gettime() - PlayerVar [ playerid ] [ E_PLAYER_REPORT_TIME ] ), PlayerVar [ playerid ] [ E_PLAYER_REPORT_REASON ]);
			}
		}
		else
		{
			if (strlen(PlayerVar[playerid][E_PLAYER_REPORT_REASON]) > 30)
			{
				format(str, sizeof(str), "[REPORT]{DEDEDE} (%d) %s reported (%d) %s %s:{DEDEDE} \"%.30s...\"", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid), GetDuration(gettime() - PlayerVar [ playerid ] [ E_PLAYER_REPORT_TIME ] ), PlayerVar [ playerid ] [ E_PLAYER_REPORT_REASON ]);
			}
			else
			{
				format(str, sizeof(str), "[REPORT]{DEDEDE} (%d) %s reported (%d) %s %s:{DEDEDE} \"%s\"", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid), GetDuration(gettime() - PlayerVar [ playerid ] [ E_PLAYER_REPORT_TIME ] ), PlayerVar [ playerid ] [ E_PLAYER_REPORT_REASON ]);
			}
		}

		foreach(new i: Player) 
		{
			if ( Character [ i ] [ E_CHARACTER_ID ] == -1 ) 
			{
				continue ;
			}

			if (GetPlayerAdminLevel(i) > ADMIN_LVL_JUNIOR || Account[i][E_PLAYER_ACCOUNT_STAFFLEVEL] >= ADMIN_LVL_JUNIOR) 
			{
				ZMsg_SendClientMessage(i, 0x59BD93FF, str);
			}
		}

		PlayerVar [ playerid ] [ E_PLAYER_REPORT_ALERT_TIME ] = gettime();
	}

	return true;
}

#include <YSI_Coding\y_hooks>

hook SOLS_OnCloseConnection(playerid, reason)
{
	foreach(new i: Player) 
	{
		if (PlayerVar[i][E_PLAYER_REPORT_TARGET] == playerid)
		{
			// Apparently these were never reset...?
			PlayerVar[i][E_PLAYER_REPORT_TARGET] = INVALID_PLAYER_ID;
		}
	}

	PlayerVar[playerid][E_PLAYER_REPORT_PENDING] = false;
    return 1;
}