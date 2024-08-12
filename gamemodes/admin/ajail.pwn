#if !defined ADMIN_JAIL_POS_X 
	#define ADMIN_JAIL_POS_X 1527.4717
#endif

#if !defined ADMIN_JAIL_POS_Y
	#define ADMIN_JAIL_POS_Y 1621.6177
#endif

#if !defined ADMIN_JAIL_POS_Z
	#define ADMIN_JAIL_POS_Z 11.6898
#endif

#if !defined ADMIN_JAIL_POS_INT
	#define ADMIN_JAIL_POS_INT 6
#endif

#include <YSI_Coding\y_hooks>
static ADM_JAIL_AREA;

hook OnGameModeInit() 
{
	CreateDynamicObject(NEW_AJAIL_MODEL, ADMIN_JAIL_POS_X, ADMIN_JAIL_POS_Y, ADMIN_JAIL_POS_Z, 0.0, 0.0, 0.0, -1, ADMIN_JAIL_POS_INT, -1, 500.0, 500.0, .priority=true);
	ADM_JAIL_AREA = CreateDynamicCircle(ADMIN_JAIL_POS_X, ADMIN_JAIL_POS_Y, 10.0);

	return 1;
}

hook OnPlayerLeaveDynArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if (areaid == ADM_JAIL_AREA && Character[playerid][E_CHARACTER_AJAIL_TIME])
	{
		new acstr[144];
		format(acstr, sizeof(acstr), "[AntiCheat]: (%d) %s may have warped out of admin jail.", playerid, ReturnMixedName(playerid));
        SendAdminMessage(acstr);
	}

    return 1;
} 



///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

CMD:gotoajail(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	SetPlayerIntoAdminJail(playerid);
	SendClientMessage(playerid, 0xA3A3A3FF, "You've been teleported to the admin jail.");

	return 1;
}

SetPlayerIntoAdminJail(playerid)
{
	SetPlayerInterior(playerid, ADMIN_JAIL_POS_INT);
	SetPlayerVirtualWorld(playerid, 1000 + playerid);
	SOLS_SetPosWithFade(playerid, ADMIN_JAIL_POS_X, ADMIN_JAIL_POS_Y, ADMIN_JAIL_POS_Z, "Room 101");
}

CMD:ajail(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target, time, reason [ 64 ] ;

	if ( sscanf ( params, "k<player>is[64]", target, time, reason ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/ajail [target] [time (minutes)] [reason]" );
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", "Target isn't connected." ) ;
	}

	if ( time < 5 ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "Can't be less than 5 minutes." );
	}

	if ( strlen ( reason ) > 64 ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "Reason can't be longer than 64 characters." );
	}

	new string [ 256 ] ;
	SetPlayerIntoAdminJail(target);
	Character [ target ] [ E_CHARACTER_AJAIL_TIME ] = time * 60 ;

	format ( Character [ playerid ] [ E_CHARACTER_OAJAIL_REASON ], 256, "%s", reason ) ;
	format ( Character [ playerid ] [ E_CHARACTER_OAJAIL_ADMIN ], MAX_PLAYER_NAME, "%s", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]);

	string [ 0 ] = EOS ;
	mysql_format(mysql, string, sizeof ( string ), "UPDATE characters SET player_oajail_reason = '%e', player_oajail_admin = '%e', player_ajail_time = '%d' WHERE player_id = '%d'", 
		Character [ playerid ] [ E_CHARACTER_OAJAIL_REASON ], Character [ playerid ] [ E_CHARACTER_OAJAIL_ADMIN ], 
		Character [ target ] [ E_CHARACTER_AJAIL_TIME ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, string ) ;

	string [ 0 ] = EOS ;
	format ( string, sizeof ( string ), "[AdmCmd]: %s was admin jailed by %s for %d minutes. Reason: %s.", 
		ReturnMixedName(target), Account[playerid][E_PLAYER_ACCOUNT_NAME], time, reason ) ;

	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("Ajailed for %d minutes by %s for %s", time, Account[playerid][E_PLAYER_ACCOUNT_NAME], reason));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Ajailed %s for %d minutes for %s", ReturnMixedName(target), time, reason));

	Weapon_ResetPlayerWeapons(target);
	SendClientMessage(target, 0xA3A3A3FF, "Your weapons have been confiscated.");
	Weapon_SavePlayerWeapons(target);

	ZMsg_SendClientMessageToAll(COLOR_RED, string);
	DCC_SendAdminPunishmentMessage(string);

	SetAdminRecord ( Account [ target ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], ARECORD_TYPE_AJAIL, reason, time, ReturnDateTime () ) ;
	


	return true ;
}

CMD:unajail(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target ;

	if ( sscanf ( params, "i", target ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/unajail [target]" );
	}

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "[!!!] [AdmWarn] (%d) %s was released from admin jail by %s.", 
		target, ReturnMixedName(target), Account[playerid][E_PLAYER_ACCOUNT_NAME]) ;
	DCC_SendAdminPunishmentMessage(string);


	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("released %s from admin jail", ReturnMixedName(target)));
	SendClientMessage(playerid, COLOR_YELLOW, sprintf("%s has been released from admin jail.", ReturnMixedName(target)));

	///////////////////////////////////////////////////////

	Character [ target ] [ E_CHARACTER_AJAIL_TIME ] = 0 ;

	SetPlayerPos(target, 1811.0447,-1577.7692,13.5267);
	PauseAC(target, 3);
	SetPlayerFacingAngle(target, 260.1323);

	SetPlayerInterior(target, 0);
	SetPlayerVirtualWorld(target, 0);

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_ajail_time = 0 WHERE player_id = %d", 
		Character [ target ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	SendServerMessage ( target, COLOR_BLUE, "Arrest", "A3A3A3", "You've been released from captivity." ) ;

	return true ;
}

CMD:offlineajail(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new charname [ MAX_PLAYER_NAME ], time, reason [ 64 ] ;

	if ( sscanf ( params, "s[24]is[64]", charname, time, reason ) ) {


		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/offlineajail [firstname_lastname] [minutes] [reason] (/getc)" );
	}


	if ( strlen ( charname ) > MAX_PLAYER_NAME ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Names can't be longer than 24 characters ") ;
	}

	if ( strlen ( reason ) > 64 ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Reason can't be longer than 64 characters!") ;
	}

	if ( time < 10 ) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You can't admin jail someone for less than 10 minutes.") ;
	}

	new old_time = time ;
	time *= 60 ; // i.e. time = 5 * 60 = 5 min

  	new query[300], char_id, acc_id, return_char_name[64], return_acc_name[64];

	foreach(new i: Player) {

		if ( IsPlayerLogged ( i ) && IsPlayerSpawned ( i ) ) {
			if ( ! strcmp(charname, Character [ i ] [ E_CHARACTER_NAME ] ) ) {

				format ( query, sizeof ( query ), "Player seems to be connected as ID %d. Use /ajail instead.", i ) ;
				return SendServerMessage( playerid, COLOR_YELLOW, "Warning", "A3A3A3",  query ) ;
			}
		}
	}

	query[0]=EOS;

	inline ReturnAccountName() {
		if (!cache_num_rows()) {
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Database didn't return any account data. Maybe your mistyped the name.") ;
		}

		cache_get_value_name_int( 0, "player_id", char_id);
		cache_get_value_name_int(0, "account_id", acc_id);
		cache_get_value_name(0, "player_name", return_char_name);
		cache_get_value_name(0, "account_name", return_acc_name);

		mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_oajail_reason = '%e', player_oajail_admin = '%e', player_ajail_time = '%d' WHERE player_id = '%d'", 
			reason, Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], time, char_id ) ;
		mysql_tquery ( mysql, query ) ;

		SetAdminRecord ( acc_id, Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], ARECORD_TYPE_AJAIL, reason, time, ReturnDateTime () ) ;

		format ( query, sizeof ( query ), "[AdmCmd] %s (%s) was offline admin jailed by %s for %d minutes. Reason: %s.", 
			return_char_name, return_acc_name, Account[playerid][E_PLAYER_ACCOUNT_NAME], old_time, reason ) ;


		// AddOfflineLogEntry(char_id, return_char_name, LOG_TYPE_ADMIN, sprintf("Ajailed for %d minutes by %s for %s", old_time, Account[playerid][E_PLAYER_ACCOUNT_NAME], reason));
		AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Ajailed %s (%s) for %d minutes for %s", return_char_name, return_acc_name, old_time, reason));

		ZMsg_SendClientMessageToAll(COLOR_RED, query);
		DCC_SendAdminPunishmentMessage(query);
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `player_id`, `characters`.`account_id`, `player_name`, `account_name` FROM `characters` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `player_name` LIKE '%e'", charname ) ;
	MySQL_TQueryInline(mysql, using inline ReturnAccountName, query, "");

	return true ;
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

// Every second
AdminJail_Tick(playerid) {

	if ( Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ] ) {

		if ( -- Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ] <= 0 ) {
			Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ] = 0 ;

			SetPlayerPos(playerid, 1811.0447,-1577.7692,13.5267);
			PauseAC(playerid, 3);
			SetPlayerFacingAngle(playerid, 260.1323);

			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);

			SendServerMessage ( playerid, COLOR_RED, "Admin", "A3A3A3", "You've been released from admin jail." ) ;
		}

		/*
		if ( ! IsPlayerInRangeOfPoint(playerid, 7.5, ADMIN_JAIL_POS_X, ADMIN_JAIL_POS_Y, ADMIN_JAIL_POS_Z) ) {

			SetPlayerPos(playerid, ADMIN_JAIL_POS_X, ADMIN_JAIL_POS_Y, ADMIN_JAIL_POS_Z ) ;
		}
		*/

		new string [ 64 ] ;

		format ( string, sizeof ( string ), "~w~~n~~n~~n~~n~~n~~n~Admin Jail: ~r~%s", GetCountdown(gettime(), gettime() + Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ]) ) ;
		GameTextForPlayer(playerid, string, 950, 3 ) ;

		new query [ 256 ] ;

		mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_ajail_time = %d WHERE player_id = %d", 
			Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, query);
	}

	return true ;
}


Spawn_AdminJail(playerid, bool:isrespawn) 
{
	#pragma unused isrespawn
	SetSpawnInfo(playerid, 0, 264, 
		ADMIN_JAIL_POS_X, ADMIN_JAIL_POS_Y, ADMIN_JAIL_POS_Z, 0.0, 0, 0, 0, 0, 0, 0);

	CS_SpawnPlayer(playerid) ;

	SetCameraBehindPlayer(playerid);

	SetPlayerIntoAdminJail(playerid);
	SendServerMessage ( playerid, COLOR_YELLOW, "Admin Jail", "A3A3A3", "You've been returned to admin jail to serve your time." ) ;

	Weapon_ResetPlayerWeapons(playerid);
	SendClientMessage(playerid, 0xA3A3A3FF, "Your weapons have been confiscated.");
	Weapon_SavePlayerWeapons(playerid);	

	new string [ 144 ] ;
	format ( string, sizeof ( string ), "You were admin jailed for \"%s\" by %s.",

		Character [ playerid ] [ E_CHARACTER_OAJAIL_REASON ],
		Character [ playerid ] [ E_CHARACTER_OAJAIL_ADMIN ]	
	) ;

	SendServerMessage ( playerid, COLOR_RED, "Admin Jail", "A3A3A3", string ) ;

	// Must call this
	// Spawn_Common(playerid, isrespawn);
}