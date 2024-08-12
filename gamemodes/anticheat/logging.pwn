//------------------------------------------------------------------------------
// MySQL Player Logs viewable/filterable with dialogs ingame
// Written by Sporky (www.github.com/sporkyspork) for SOLS

#include <YSI_Coding\y_hooks>
#include <strlib>

enum E_LOG_TYPES_INFO
{
	E_LOG_TYPES:E_LOG_TYPE,
	E_LOG_TYPE_NAME[16],
	E_LOG_TYPE_COLOR,
	E_LOG_TYPE_LEVEL
}

static const LogType[][E_LOG_TYPES_INFO] =
{
	{ LOG_TYPE_NONE, "All", 0, 3 },
	{ LOG_TYPE_CHAT, "Chat", 0xC5CAE9, 1 },
	{ LOG_TYPE_ACTION, "Action", 0xD1C4E9, 2 },
	{ LOG_TYPE_SCRIPT, "Script", 0xFFCCBC, 1 },
	{ LOG_TYPE_GAME, "Game", 0xFFE0B2, 1 },
	{ LOG_TYPE_DAMAGE, "Damage", 0xFFCDD2, 1 },
	{ LOG_TYPE_OOC, "OOC", 0xFFCDD2, 2 },
	{ LOG_TYPE_PM, "PM", 0xFFE082, 3 },
	{ LOG_TYPE_PHONE, "Phone", 0xC5CAE9, 2 },
	{ LOG_TYPE_PAGER, "Pager", 0xC5CAE9, 2 },
	{ LOG_TYPE_ADMIN, "Admin", 0xF0F4C3, 1 },
	{ LOG_TYPE_RADIO, "Radio", 0xC5CAE9, 2 },
	{ LOG_TYPE_CMD, "CMD", 0, 2 },
	{ LOG_TYPE_DRUGS, "Drugs", 0xF8BBD0, 1 },
	{ LOG_TYPE_ANTICHEAT, "AntiCheat", 0xFFC400, 1 },
	{ LOG_TYPE_JOB, "Job", 0x479043, 2},
	{ LOG_TYPE_STAFFCHAT, "Staff Chat", 0xdd9f83, 2}
};

static Log_ReturnType(E_LOG_TYPES:logtype)
{
	new name[16];
	format(name, 16, LogType[_:logtype][E_LOG_TYPE_NAME]);
	return name;
}

static enum E_LOG_VIEW_INFO
{
	E_LOG_VIEW_ACCOUNT_ID,
	E_LOG_VIEW_ACCOUNT_NAME[32],
	E_LOG_VIEW_ACCOUNT_ADMIN,
	E_LOG_VIEW_CHAR_ID,
	E_LOG_VIEW_CHAR_NAME[32]
}

static PlayerLogView[MAX_PLAYERS][E_LOG_VIEW_INFO];

static enum E_PLAYER_LOG_VAR
{
	E_LOG_PLAYER_LAST_LOG_AT,
	bool:E_LOG_PLAYER_IN_VEHICLE,
	E_LOG_PLAYER_VEHICLE
}

static PlayerLogVar[MAX_PLAYERS][E_PLAYER_LOG_VAR];

//new log_SQL;
#define log_SQL mysql

static LogQueryStr[512];

Hook:Log_OnGameModeInit()
{
	print("\n--------------------------------------");
	print("SOLS MySQL Player Logging System Loaded.");
	print("--------------------------------------\n");
	return 1;
}

static Log_ReturnName(playerid)
{
	// Nice lazy way of getting a player's name.
	// Use it like playerName[MAX_PLAYER_NAME] = PlayerName(playerid)

	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	return name;
}

static Log_ReturnIP(playerid)
{
	// new ip[16];
	// GetPlayerIp(playerid, ip, sizeof(ip));

	new ip[64];
	format(ip, 64, PlayerVar[playerid][E_PLAYER_CONNECTED_IP]);
	return ip;
}

IsPlayerLogAdmin(playerid)
{
	//return IsPlayerAdmin(playerid) || CallRemoteFunction("GetPlayerAdminLevel", "d", playerid) >= 4;
    return GetPlayerAdminLevel(playerid) >= 1;
}

SendLogAdminWarning(const msg[], level)
{
	// return CallRemoteFunction("GetPlayerAdminLevel", "s", msg);

	/*
    foreach (new i : Player)
	{
		if (GetPlayerAdminLevel(i) >= 1)
		{
			SendClientMessage(i, -1, msg);
		}
	}
	*/

	new color = RGBA_DARKER(Server [ E_SERVER_ADMIN_HEX ]) ;
	foreach (new playerid: Player) 
	{
		if (!IsPlayerLogged(playerid) || Character[playerid][E_CHARACTER_ID] == -1 || PlayerVar[playerid][E_PLAYER_ADMIN_WARNS_TOGGLED]) 
		{
			continue;
		}

		if (GetPlayerAdminLevel(playerid) >= level)
		{
			ZMsg_SendClientMessage(playerid, color, msg);
		}
	}
}

AddLogEntry(playerid, E_LOG_TYPES:logtype, const text[], bool:force=false)
{
	if (!force && logtype != LOG_TYPE_SCRIPT && logtype != LOG_TYPE_ADMIN && PlayerLogVar[playerid][E_LOG_PLAYER_LAST_LOG_AT] == gettime())
	{
		// Reject more than one log entry per second per player - set force param to true to bypass this
		// Also, LOG_TYPE_SCRIPT and LOG_TYPE_ADMIN are always logged.
		// print("Log was rejected."); // Debug print, dont uncomment
		return;
	}

	// Cooldown here to stop serious log spam
	PlayerLogVar[playerid][E_LOG_PLAYER_LAST_LOG_AT] = gettime();
	new zone = _:GetPlayerMapZone2D(playerid);
	if (zone < 0) zone = 0;

	// Insert the row
	mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "INSERT INTO `player_logs` (log_type, logged_name, log_char_id, logged_playerid, logged_ip, logged_zone, log_entry) VALUES ('%d', '%e', '%d', '%d', '%e', '%d', TRIM('%e'))", _:logtype, Log_ReturnName(playerid), Character[playerid][E_CHARACTER_ID] ? Character[playerid][E_CHARACTER_ID] : 0, playerid, Log_ReturnIP(playerid), zone, text);
	mysql_tquery(log_SQL, LogQueryStr);
	
	// Debug print
	// print(LogQueryStr);
}

/*
AddOfflineLogEntry(charid, charname[], E_LOG_TYPES:logtype, text[])
{ 
	// Insert the row
	mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "INSERT INTO `player_logs` (log_type, logged_name, log_char_id, logged_playerid, logged_ip, logged_zone, log_entry) VALUES ('%d', '%e', '%d', '%d', '%e', '%d', TRIM('%e'))", _:logtype, charname, charid, -1, "", 0, text);
	mysql_tquery(log_SQL, LogQueryStr);
}
*/

/*
AddDamageLogEntry(issuerid, playerid, weaponid, Float:amount, bodypart)
{
	// Insert the row
	mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "INSERT INTO `damage_logs` (issuer_name, player_name, weaponid, amount, bodypart) VALUES ('%e', '%e', '%d', '%f', '%d')", Log_ReturnName(issuerid), Log_ReturnName(playerid), weaponid, amount, bodypart);
	mysql_tquery(log_SQL, LogQueryStr);

	// Debug print
	print(LogQueryStr);
}
*/


#define MAX_PLAYER_LOGS 75
#define MAX_DAMAGE_LOGS 75

/*
ShowDamageLogs(playerid, giveplayerid=-1)
{
	// Build a string to act as an SQL query
	if (IsPlayerConnected(giveplayerid))
	{
	    mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `damage_id`, TIME(damage_time) AS 'time', DATE(damage_time) AS 'date', `issuer_name`,`player_name`,`weaponid`, `amount`, `bodypart` FROM `damage_logs` WHERE `issuer_name` = '%e' OR `player_name` = '%e' ORDER BY `damage_time` DESC LIMIT %d", Log_ReturnName(giveplayerid), Log_ReturnName(giveplayerid), MAX_DAMAGE_LOGS-1);
	}
	else
	{
	    mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `damage_id`, TIME(damage_time) AS 'time', DATE(damage_time) AS 'date', `issuer_name`,`player_name`,`weaponid`, `amount`, `bodypart` FROM `damage_logs` ORDER BY `damage_time` DESC LIMIT %d", MAX_DAMAGE_LOGS-1);
	}
	
	mysql_tquery(log_SQL, LogQueryStr, "OnGetDamageLogs", "dd", playerid, giveplayerid);
	print(LogQueryStr);
	return 1;
}
*/

ShowPlayerLogs(playerid, charid, E_LOG_TYPES:logtype, bool:nowarn=false)
{
	new level = LogType[_:logtype][E_LOG_TYPE_LEVEL];

	if (!charid)
	{
		// This is no specific character (e.g. just shows the 50 most recent logs)
		if (logtype == LOG_TYPE_NONE)
	    {
			mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `log_id`, TIME(log_time) AS 'time', DATE(log_time) AS 'date', `log_type`, `log_char_id`, `logged_name`,`logged_playerid`,`logged_ip`, `logged_zone`, `log_entry` FROM `player_logs` ORDER BY `log_time` DESC LIMIT %d", MAX_PLAYER_LOGS-1);
		}
		else
		{
			mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `log_id`, TIME(log_time) AS 'time', DATE(log_time) AS 'date', `log_type`, `log_char_id`, `logged_name`,`logged_playerid`,`logged_ip`, `logged_zone`, `log_entry` FROM `player_logs` WHERE `log_type` = '%d' ORDER BY `log_time` DESC LIMIT %d", _:logtype, MAX_PLAYER_LOGS-1);
		}

		mysql_tquery(log_SQL, LogQueryStr, "OnGetPlayerLogs", "ddd", playerid, charid, _:logtype);
		// print(LogQueryStr);

		if (!nowarn) SendLogAdminWarning(sprintf("[AdmWarn] (Level %d) %s (%d) checked all recent player logs [%s].", level, ReturnMixedName(playerid), playerid, Log_ReturnType(logtype)), level);
	}
	else
	{
		// This is a specific character (so shows the last 50 logs of just that character)
		
		inline PlayerLog_OnGetChar() 
		{
			if (cache_num_rows()) 
			{
				cache_get_value_name(0, "account_name", PlayerLogView[playerid][E_LOG_VIEW_ACCOUNT_NAME]);
				cache_get_value_name(0, "player_name", PlayerLogView[playerid][E_LOG_VIEW_CHAR_NAME]);
				cache_get_value_name_int(0, "player_id", PlayerLogView[playerid][E_LOG_VIEW_CHAR_ID]);
				cache_get_value_name_int(0, "account_id", PlayerLogView[playerid][E_LOG_VIEW_ACCOUNT_ID]);
				cache_get_value_name_int(0, "account_stafflevel", PlayerLogView[playerid][E_LOG_VIEW_ACCOUNT_ADMIN]);

				if (PlayerLogView[playerid][E_LOG_VIEW_ACCOUNT_ADMIN] >= GetPlayerAdminLevel(playerid) && Character[playerid][E_CHARACTER_ID] != PlayerLogView[playerid][E_LOG_VIEW_CHAR_ID])
				{
					return SendClientMessage(playerid, -1, "ERROR: You're not authorized to view this player's logs.");
				}

				if (logtype == LOG_TYPE_NONE)
				{
					mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `log_id`, TIME(log_time) AS 'time', DATE(log_time) AS 'date', `log_type`, `log_char_id`, `logged_name`,`logged_playerid`,`logged_ip`, `logged_zone`, `log_entry` FROM `player_logs` WHERE `log_char_id` = '%d' ORDER BY `log_time` DESC LIMIT %d", charid, MAX_PLAYER_LOGS-1);
				}
				else
				{
					mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `log_id`, TIME(log_time) AS 'time', DATE(log_time) AS 'date', `log_type`, `log_char_id`, `logged_name`,`logged_playerid`,`logged_ip`, `logged_zone`, `log_entry` FROM `player_logs` WHERE `log_char_id` = '%d' AND `log_type` = '%d' ORDER BY `log_time` DESC LIMIT %d", charid, _:logtype, MAX_PLAYER_LOGS-1);
				}

				mysql_tquery(log_SQL, LogQueryStr, "OnGetPlayerLogs", "ddd", playerid, charid, _:logtype);
				// print(LogQueryStr);

				if (!nowarn) SendLogAdminWarning(sprintf("[AdmWarn] (Level %d) %s (%d) checked logs [%s] for %s.", level, ReturnMixedName(playerid), playerid, Log_ReturnType(logtype), PlayerLogView[playerid][E_LOG_VIEW_CHAR_NAME]), level);
			}
		}

		mysql_format(log_SQL, LogQueryStr, sizeof(LogQueryStr), "SELECT `characters`.`player_id`, `characters`.`player_name`, `accounts`.`account_id`, `accounts`.`account_name`, `accounts`.`account_stafflevel` FROM `characters` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `characters`.`player_id` = %d", charid);
		MySQL_TQueryInline(log_SQL, using inline PlayerLog_OnGetChar, LogQueryStr);
		// print(LogQueryStr);
	}

	
	return 1;
}

static enum E_LOG_ENTRY_INFO
{
	E_LOG_ENTRY_LOG_ID,
	E_LOG_ENTRY_DATE[11],
	E_LOG_ENTRY_TIME[9],
	E_LOG_TYPES:E_LOG_ENTRY_TYPE,
	E_LOG_ENTRY_CHAR_ID,
	E_LOG_ENTRY_LOGGED_NAME[32],
	E_LOG_ENTRY_LOGGED_ID,
	E_LOG_ENTRY_LOGGED_IP[64],
	E_LOG_ENTRY_ZONE,
	E_LOG_ENTRY_ENTRY[128],
}

static LogEntry[MAX_PLAYER_LOGS][E_LOG_ENTRY_INFO];

static LogEntryDlgStr[4096];
static LogEntryStr[256];

forward OnGetPlayerLogs(playerid, charid, E_LOG_TYPES:logtype);
public OnGetPlayerLogs(playerid, charid, E_LOG_TYPES:logtype)
{
    if(cache_num_rows() == 0) return SendClientMessage(playerid, -1, sprintf("ERROR: No logs were found for this %s (%d).", charid ? "this character" : "this search", charid));

	format(LogEntryDlgStr, sizeof(LogEntryDlgStr), "%s", "Time\tName\tType\tAction");

    new infoString[128], entryString[84];
    //new loggedname[32];
    
    for (new i = 0, r = cache_num_rows(); i < r; ++i)
	{
	    cache_get_value_name_int(i, "log_id", LogEntry[i][E_LOG_ENTRY_LOG_ID]);
	    cache_get_value_name(i, "date", LogEntry[i][E_LOG_ENTRY_DATE]);
	    cache_get_value_name(i, "time", LogEntry[i][E_LOG_ENTRY_TIME]);
		cache_get_value_name(i, "logged_name", LogEntry[i][E_LOG_ENTRY_LOGGED_NAME]);
	    cache_get_value_name(i, "logged_ip", LogEntry[i][E_LOG_ENTRY_LOGGED_IP]);
	    cache_get_value_name(i, "log_entry", LogEntry[i][E_LOG_ENTRY_ENTRY]);
		cache_get_value_name(i, "log_entry", entryString);
		cache_get_value_name_int(i, "logged_zone", LogEntry[i][E_LOG_ENTRY_ZONE]);
	    cache_get_value_name_int(i, "log_type", _:LogEntry[i][E_LOG_ENTRY_TYPE]);
		cache_get_value_name_int(i, "logged_playerid", LogEntry[i][E_LOG_ENTRY_LOGGED_ID]);
		cache_get_value_name_int(i, "log_char_id", LogEntry[i][E_LOG_ENTRY_CHAR_ID]);

		if (strlen(entryString) > 80)
		{
			format(entryString, sizeof(entryString), "%.80s...", entryString);
		}
		
		if (!logtype && LogType[_:LogEntry[i][E_LOG_ENTRY_TYPE]][E_LOG_TYPE_COLOR])
		{
			format(infoString, sizeof(infoString), "\n{%06x}%s\t{%06x}%s\t{%06x}%s\t{%06x}%s", LogType[_:LogEntry[i][E_LOG_ENTRY_TYPE]][E_LOG_TYPE_COLOR], LogEntry[i][E_LOG_ENTRY_TIME], LogType[_:LogEntry[i][E_LOG_ENTRY_TYPE]][E_LOG_TYPE_COLOR], LogEntry[i][E_LOG_ENTRY_LOGGED_NAME], LogType[_:LogEntry[i][E_LOG_ENTRY_TYPE]][E_LOG_TYPE_COLOR], Log_ReturnType(LogEntry[i][E_LOG_ENTRY_TYPE]), LogType[_:LogEntry[i][E_LOG_ENTRY_TYPE]][E_LOG_TYPE_COLOR], entryString);
		}
		else
		{
    		format(infoString, sizeof(infoString), "\n%s\t%s\t%s\t%s", LogEntry[i][E_LOG_ENTRY_TIME], LogEntry[i][E_LOG_ENTRY_LOGGED_NAME], Log_ReturnType(LogEntry[i][E_LOG_ENTRY_TYPE]), entryString);
		}
		
		strcat(LogEntryDlgStr, infoString);
	}
	
	// cache_get_field_content(0, "logged_name", loggedname);

	inline PlayerLogDlg(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem
        if (response)
	    {
		    new title[50];
		    format(title, sizeof(title), "Viewing Entry #%d (%s)", LogEntry[listitem][E_LOG_ENTRY_LOG_ID], LogEntry[listitem][E_LOG_ENTRY_LOGGED_NAME]);

			new infoLine[100], zone[32];

			format(LogEntryDlgStr, sizeof(LogEntryDlgStr), "{0099FF}Log Date: {ADBEE6}%s\n", LogEntry[listitem][E_LOG_ENTRY_DATE]);

		    format(infoLine, sizeof(infoLine), "{0099FF}Log Time: {ADBEE6}%s\n", LogEntry[listitem][E_LOG_ENTRY_TIME]);
		    strcat(LogEntryDlgStr, infoLine);
		    format(infoLine, sizeof(infoLine), "{0099FF}Log Type: {ADBEE6}%s (%d)\n", Log_ReturnType(LogEntry[listitem][E_LOG_ENTRY_TYPE]), _:LogEntry[listitem][E_LOG_ENTRY_TYPE]);
		    strcat(LogEntryDlgStr, infoLine);
			format(infoLine, sizeof(infoLine), "{0099FF}Character ID: {ADBEE6}%d\n", LogEntry[listitem][E_LOG_ENTRY_CHAR_ID]);
		    strcat(LogEntryDlgStr, infoLine);
		    format(infoLine, sizeof(infoLine), "{0099FF}Logged Name: {ADBEE6}%s (ID: %d)\n", LogEntry[listitem][E_LOG_ENTRY_LOGGED_NAME], LogEntry[listitem][E_LOG_ENTRY_LOGGED_ID]);
		    strcat(LogEntryDlgStr, infoLine);
		    format(infoLine, sizeof(infoLine), "{0099FF}Logged IP: {ADBEE6}%s\n", LogEntry[listitem][E_LOG_ENTRY_LOGGED_IP]);
		    strcat(LogEntryDlgStr, infoLine);

			GetMapZoneName(MapZone:LogEntry[listitem][E_LOG_ENTRY_ZONE], zone);
			format(infoLine, sizeof(infoLine), "{0099FF}Logged Location: {ADBEE6}%s\n", zone);
		    strcat(LogEntryDlgStr, infoLine);

		    format(infoLine, sizeof(infoLine), "\n{FFFFFF}%s", LogEntry[listitem][E_LOG_ENTRY_ENTRY]);
		    strcat(LogEntryDlgStr, infoLine);

			inline PlayerLogDlgInfo(pid2, dialogid2, response2, listitem2, string:inputtext2[]) 
			{
				#pragma unused pid2, dialogid2, inputtext2, listitem2
				if (response2) ShowPlayerLogs(pid2, charid, logtype, true);
			}

			Dialog_ShowCallback ( pid, using inline PlayerLogDlgInfo, DIALOG_STYLE_MSGBOX, title, LogEntryDlgStr, "Back", "Close");
	    }
    }

	if (charid)
	{
		Dialog_ShowCallback ( playerid, using inline PlayerLogDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Latest logs of %s (%s) (Max %d)", PlayerLogView[playerid][E_LOG_VIEW_CHAR_NAME], Log_ReturnType(logtype), MAX_PLAYER_LOGS), LogEntryDlgStr, "Select", "Close");
	}
	else
	{
		Dialog_ShowCallback ( playerid, using inline PlayerLogDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Most recent logs (%s) (Max %d)", Log_ReturnType(logtype), MAX_PLAYER_LOGS), LogEntryDlgStr, "Select", "Close");
	}
	
	//SendLogAdminWarning(LogEntryStr);
	return 1;
}

hook OnPlayerText(playerid, text[])
{
	if (IsPlayerLogged(playerid))
	{
		AddLogEntry(playerid, LOG_TYPE_CHAT, text);
	}
 	
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    return 1;
}

/*
enum eDamageInfo
{
	dmgId,
	dmgDate[11],
	dmgTime[9],
	dmgWeaponId,
	Float:dmgAmount,
	dmgVictimName[MAX_PLAYER_NAME],
	dmgAttackerName[MAX_PLAYER_NAME],
	dmgBodypart
}

new DamageInfo[MAX_DAMAGE_LOGS][eDamageInfo];

forward OnGetDamageLogs(playerid, giveplayerid);
public OnGetDamageLogs(playerid, giveplayerid)
{
	printf("OnGetDamageLogs %d, %d", playerid, giveplayerid);
    if(cache_num_rows() == 0) return SendClientMessage(playerid, -1, "There are no damage logs to show.");
	
	format(plogdialog, sizeof(plogdialog), "%s", "Time\tIssuer\tVictim\tWeapon");

    new
        infoString[128],
        weaponName[24] = "None";

    for (new i = 0; i < cache_num_rows(); i++)
	{
	    DamageInfo[i][dmgId] = cache_get_field_content_int(i, "damage_id");
	    cache_get_field_content(i, "date", DamageInfo[i][dmgDate]);
	    cache_get_field_content(i, "time", DamageInfo[i][dmgTime]);
	    DamageInfo[i][dmgWeaponId] = cache_get_field_content_int(i, "weaponid");
     	DamageInfo[i][dmgBodypart] = cache_get_field_content_int(i, "bodypart");
	    DamageInfo[i][dmgAmount] = cache_get_field_content_float(i, "amount");
	    cache_get_field_content(i, "player_name", DamageInfo[i][dmgVictimName]);
	    cache_get_field_content(i, "issuer_name", DamageInfo[i][dmgAttackerName]);
	    //amount = cache_get_field_content_float(i, "amount");
	    
	    if (DamageInfo[i][dmgWeaponId] != 0) GetWeaponName(DamageInfo[i][dmgWeaponId], weaponName, sizeof (weaponName));
    	format(infoString, sizeof(infoString), "\n%s\t%s\t%s\t%s", DamageInfo[i][dmgTime], DamageInfo[i][dmgAttackerName], DamageInfo[i][dmgVictimName], weaponName);
    	strcat(plogdialog, infoString);
	}

	ShowPlayerDialog(playerid, DLG_DMGLOGS, DIALOG_STYLE_TABLIST_HEADERS, "Recent Damage Log", plogdialog, "Select", "Close");
	
	if (IsPlayerConnected(giveplayerid))
	{
		format(adminmsg, sizeof(adminmsg), "[ADMIN] %s used /damagelog on %s.", Log_ReturnName(playerid), Log_ReturnName(giveplayerid));
		SendLogAdminWarning(adminmsg);
	}

	return 1;
}

CMD:damagelog(playerid, params[])
{
    if (!IsPlayerLogAdmin(playerid)) return 0;

    new giveplayerid;
	if (sscanf(params, "r", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /damagelog [player id/name]");
	
	ShowDamageLogs(playerid, giveplayerid);
	return 1;
}

CMD:dlog(playerid, params[]) return cmd_damagelog(playerid, params);

CMD:damagelogs(playerid)
{
    if (!IsPlayerLogAdmin(playerid)) return 0;
	ShowDamageLogs(playerid);
	return 1;
}

CMD:dlogs(playerid) return cmd_damagelogs(playerid);

*/

CMD:playerlogs(playerid, params[])
{
    if (!IsPlayerLogAdmin(playerid)) return 0;

    new logtypestr[10], logtypeindex = -1;
	sscanf(params, "s[10] ", logtypestr);

	if (strlen(logtypestr))
	{
		for (new i = 0; i < sizeof(LogType); i ++)
		{
			if (!strcmp(LogType[i][E_LOG_TYPE_NAME], logtypestr, true))
			{
				logtypeindex = _:LogType[i][E_LOG_TYPE];
				break;
			}
		}
	}

	if (logtypeindex == -1 || GetPlayerAdminLevel(playerid) < LogType[logtypeindex][E_LOG_TYPE_LEVEL])
	{
		SendClientMessage(playerid, -1, "USAGE: /playerlogs [log type]");
		format(LogEntryStr, sizeof(LogEntryStr), "> ");

		new count = 0;
		new logtypes[sizeof(LogType)];

		for (new i = 0; i < sizeof(LogType); i ++)
		{
			if (GetPlayerAdminLevel(playerid) < LogType[i][E_LOG_TYPE_LEVEL]) continue;

			logtypes[count] = i;
			count ++;
		}

		for (new i = 0; i < count; i ++)
		{
			format(LogEntryStr, sizeof(LogEntryStr), "%s%s (A%d)", LogEntryStr, LogType[logtypes[i]][E_LOG_TYPE_NAME], LogType[logtypes[i]][E_LOG_TYPE_LEVEL]);
			if (i + 1 < count) strcat(LogEntryStr, ", ");
		}

		ZMsg_SendClientMessage(playerid, -1, LogEntryStr);

		return 1;
	}

	//SELECT `log_id`, TIME(log_time) AS 'time', DATE(log_time) AS 'date', `log_type`, `log_char_id`, `characters`.`player_name`, `accounts`.`account_name`, `accounts`.`account_stafflevel`, `logged_name`,`logged_playerid`, `logged_ip`, `logged_zone`, `log_entry` FROM `player_logs` JOIN `characters` ON `characters`.`player_id` = `log_char_id` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `log_char_id` = '1' AND `log_type` = '1' ORDER BY `log_time` DESC LIMIT 49

	ShowPlayerLogs(playerid, 0, E_LOG_TYPES:logtypeindex);
	return 1;
}

CMD:plogs(playerid, params[]) return cmd_playerlogs(playerid, params);

CMD:playerlog(playerid, params[])
{
    if (!IsPlayerLogAdmin(playerid)) return 0;

    new giveplayerid, logtypestr[10], logtypeindex = -1;
	sscanf(params, "k<player>s[10] ", giveplayerid, logtypestr);
	
	if (!IsPlayerConnected(giveplayerid) || !Character[giveplayerid][E_CHARACTER_ID])
	{
		return SendClientMessage(playerid, -1, "ERROR: This player isn't connected.");
	}		

	if (strlen(logtypestr))
	{
		for (new i = 0; i < sizeof(LogType); i ++)
		{
			if (!strcmp(LogType[i][E_LOG_TYPE_NAME], logtypestr, true))
			{
				logtypeindex = _:LogType[i][E_LOG_TYPE];
				break;
			}
		}
	}

	if (logtypeindex == -1 || GetPlayerAdminLevel(playerid) < LogType[logtypeindex][E_LOG_TYPE_LEVEL])
	{
		SendClientMessage(playerid, -1, "USAGE: /playerlog [player] [log type]");
		format(LogEntryStr, sizeof(LogEntryStr), "> ");

		new count = 0;
		new logtypes[sizeof(LogType)];

		for (new i = 0; i < sizeof(LogType); i ++)
		{
			if (GetPlayerAdminLevel(playerid) < LogType[i][E_LOG_TYPE_LEVEL]) continue;

			logtypes[count] = i;
			count ++;
		}

		for (new i = 0; i < count; i ++)
		{
			format(LogEntryStr, sizeof(LogEntryStr), "%s%s (A%d)", LogEntryStr, LogType[logtypes[i]][E_LOG_TYPE_NAME], LogType[logtypes[i]][E_LOG_TYPE_LEVEL]);
			if (i + 1 < count) strcat(LogEntryStr, ", ");
		}

		ZMsg_SendClientMessage(playerid, -1, LogEntryStr);

		return 1;
	}

	if (GetPlayerAdminLevel(playerid) <= GetPlayerAdminLevel(giveplayerid) && playerid != giveplayerid)
	{
		return SendClientMessage(playerid, -1, "ERROR: You're not authorized to view this player's logs.");
	}

	//SELECT `log_id`, TIME(log_time) AS 'time', DATE(log_time) AS 'date', `log_type`, `log_char_id`, `characters`.`player_name`, `accounts`.`account_name`, `accounts`.`account_stafflevel`, `logged_name`,`logged_playerid`, `logged_ip`, `logged_zone`, `log_entry` FROM `player_logs` JOIN `characters` ON `characters`.`player_id` = `log_char_id` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `log_char_id` = '1' AND `log_type` = '1' ORDER BY `log_time` DESC LIMIT 49

	ShowPlayerLogs(playerid, Character[giveplayerid][E_CHARACTER_ID], E_LOG_TYPES:logtypeindex);
	return 1;
}

CMD:plog(playerid, params[]) return cmd_playerlog(playerid, params);

CMD:offlineplayerlog(playerid, params[])
{
    if (!IsPlayerLogAdmin(playerid)) return 0;

    new giveplayerid, logtypestr[10], logtypeindex = -1;
	sscanf(params, "ds[10] ", giveplayerid, logtypestr);
	
	if (strlen(logtypestr))
	{
		for (new i = 0; i < sizeof(LogType); i ++)
		{
			if (!strcmp(LogType[i][E_LOG_TYPE_NAME], logtypestr, true))
			{
				logtypeindex = _:LogType[i][E_LOG_TYPE];
				break;
			}
		}
	}
	else
	{
		logtypeindex = _:LOG_TYPE_NONE;
	}

	if (logtypeindex == -1 || GetPlayerAdminLevel(playerid) < LogType[logtypeindex][E_LOG_TYPE_LEVEL] || giveplayerid <= 0)
	{
		SendClientMessage(playerid, -1, "USAGE: /offlineplayerlog [character id] [log type]");
		format(LogEntryStr, sizeof(LogEntryStr), "> ");

		new count = 0;
		new logtypes[sizeof(LogType)];

		for (new i = 0; i < sizeof(LogType); i ++)
		{
			if (GetPlayerAdminLevel(playerid) < LogType[i][E_LOG_TYPE_LEVEL]) continue;

			logtypes[count] = i;
			count ++;
		}

		for (new i = 0; i < count; i ++)
		{
			format(LogEntryStr, sizeof(LogEntryStr), "%s%s (A%d)", LogEntryStr, LogType[logtypes[i]][E_LOG_TYPE_NAME], LogType[logtypes[i]][E_LOG_TYPE_LEVEL]);
			if (i + 1 < count) strcat(LogEntryStr, ", ");
		}

		ZMsg_SendClientMessage(playerid, -1, LogEntryStr);
		SendClientMessage(playerid, -1, "Hint: Use /gcid to get the character ID by name.");

		return 1;
	}

	ShowPlayerLogs(playerid, giveplayerid, E_LOG_TYPES:logtypeindex);
	return 1;
}

CMD:oplog(playerid, params[]) return cmd_offlineplayerlog(playerid, params);


hook OnPlayerCmdPerformed(playerid, cmdtext[], success) 
{
	if (success && IsPlayerLogged(playerid))
	{
		AddLogEntry(playerid, LOG_TYPE_CMD, cmdtext);
	}

	return true ;
}

hook OnPlayerConnect(playerid)
{
	new log_clear[E_PLAYER_LOG_VAR];
	PlayerLogVar[playerid] = log_clear;
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (newstate == PLAYER_STATE_DRIVER)
	{
		// NEW LOGGING: Log this as a LOG_TYPE_GAME for sender (playerid)
		PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE] = GetPlayerVehicleID(playerid);

		if (IsValidVehicle(PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]))
		{
			PlayerLogVar[playerid][E_LOG_PLAYER_IN_VEHICLE] = true;
			AddLogEntry(playerid, LOG_TYPE_GAME, sprintf("Entered a %s (%d) as the driver.", ReturnVehicleName(PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]), PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]));
		}
	}
	else if (newstate == PLAYER_STATE_PASSENGER)
	{
		// NEW LOGGING: Log this as a LOG_TYPE_GAME for sender (playerid)
		PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE] = GetPlayerVehicleID(playerid);

		if (IsValidVehicle(PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]))
		{
			PlayerLogVar[playerid][E_LOG_PLAYER_IN_VEHICLE] = true;
			AddLogEntry(playerid, LOG_TYPE_GAME, sprintf("Entered a %s (%d) as a passenger.", ReturnVehicleName(PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]), PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]));
		}
	}
	else if (newstate == PLAYER_STATE_ONFOOT && PlayerLogVar[playerid][E_LOG_PLAYER_IN_VEHICLE])
	{
		// NEW LOGGING: Log this as a LOG_TYPE_GAME for sender (playerid)
		if (IsValidVehicle(PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]))
		{
			AddLogEntry(playerid, LOG_TYPE_GAME, sprintf("Exited a %s (%d).", ReturnVehicleName(PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]), PlayerLogVar[playerid][E_LOG_PLAYER_VEHICLE]));
		}
		else
		{
			AddLogEntry(playerid, LOG_TYPE_GAME, "Exited a vehicle");
		}

		PlayerLogVar[playerid][E_LOG_PLAYER_IN_VEHICLE] = false;
	}
	else if (newstate == PLAYER_STATE_SPECTATING)
	{
		if (!GetPlayerAdminLevel(playerid) && IsPlayerLogged(playerid))
		{
			AddLogEntry(playerid, LOG_TYPE_GAME, "Entered into spectate mode");
		}
	}


	return 1;
}

// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
//AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Used /unimpound on a %s (SQL ID: %d)", ReturnVehicleName(vehicleid), Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));