
//#include "player/data.pwn"
#include "player/auth/header.pwn"
#include "player/spawns/header.pwn"
#include "donator/player.pwn"
#include "player/settings.pwn"
#include "player/session.pwn"
#include "player/tutorial.pwn"

#include "player/reward.pwn"
#include "player/logout.pwn"

#include "player/help.pwn"
#include "player/attributes.pwn"



// Skips class selection.
timer OnPlayerFullyConnected[250](playerid) {

	if ( ! IsPlayerConnected ( playerid ) ) {

		return true ;
	}

	// Check if people are connecting on same MA or using same IP...
	CheckDoubleConnection(playerid);

	// Check if player is ban evading
	BanEvaderCheck(playerid);


	// Force spawn NPCs

	OnLoadPlayerTextdraws(playerid);
	TextDrawHideForPlayer(playerid, gBlindfoldTD); 

	PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] = INVALID_PLAYER_ID ;
	PlayerVar [ playerid ] [ E_PLAYER_LISTEN ] = INVALID_PLAYER_ID ;
	Character [ playerid ] [ E_CHARACTER_MOLE ] = INVALID_PLAYER_ID ;
	PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] = -1 ;
	PlayerVar [ playerid ] [ E_PLAYER_LISTENING_BOOMBOX ] = -1 ; //invalid boombox
	PlayerVar [ playerid ] [ E_PLAYER_CHOSE_CHARACTER ] = false ;
	PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_DONATOR ] = false ;
	PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_STRAWMAN ] = false ;

	format(PlayerVar[playerid][E_PLAYER_CONNECTED_IP], 64, "%s", ReturnIP(playerid));

	Furniture_SetPlayerVariables(playerid);
	Dockworker_SetPlayerVariables ( playerid ) ;

	if (strlen(Server [ E_SERVER_SONG_URL ]))
	{
		SOLS_PlayAudioStreamForPlayer(playerid, Server [ E_SERVER_SONG_URL ]);
	}


	defer LoginWindow[1000](playerid, AUTH_MSG_DEFAULT);

	return true ;
}

CMD:setintrosong(playerid, params[])
{
	if (GetPlayerAdminLevel(playerid) < 5)
	{
		return SendServerMessage( playerid, COLOR_RED, "Error", "DEDEDE", "You don't have access to this command.");
	}

	new songurl[128];

	if (sscanf(params, "s[128]", songurl) || strlen(songurl) < 10)
	{
		return SendServerMessage( playerid, COLOR_RED, "Usage", "DEDEDE", "/setintrosong [url]");
	}
	    
	format(Server [ E_SERVER_SONG_URL ], 128, "%s", songurl);
	SendAdminMessage(sprintf("[AdmWarn] %s (%d) set intro URL: %s", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, Server [ E_SERVER_SONG_URL ]));

	new query [ 256 ] ;
	mysql_format(mysql, query, sizeof ( query ), "UPDATE `server` SET `server_song_url` = '%e'", Server [ E_SERVER_SONG_URL ]);
	mysql_tquery(mysql, query);

	return true;
}


public OnPlayerConnect(playerid) {
	
	StartConnection(playerid) ;

	#if defined data_OnPlayerConnect
		return data_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect data_OnPlayerConnect
#if defined data_OnPlayerConnect
	forward data_OnPlayerConnect(playerid);
#endif


public OnPlayerDisconnect(playerid, reason) {

	CloseConnection(playerid, reason);
		
	#if defined config_OnPlayerDisconnect
		return config_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect config_OnPlayerDisconnect
#if defined config_OnPlayerDisconnect
	forward config_OnPlayerDisconnect(playerid, reason);
#endif


/*
CMD:spawn(playerid, params[]) {

	if ( ! IsPlayerSpawned ( playerid ) ) {

		if ( GetPlayerState(playerid ) == PLAYER_STATE_SPECTATING ) {
			Player_DisplaySpawnList(playerid);
		}

		else return SendClientMessage(playerid, COLOR_RED, "You must be spectating to be able to use this command.");
	}

	else return SendClientMessage(playerid, COLOR_RED, "You can't be spawned if you want to use this command.");

	return true ;
}
*/
CMD:login(playerid, params[]) {

	if ( ! PlayerVar [ playerid ] [ player_islogged ] ) {
		LoginWindow(playerid, AUTH_MSG_DEFAULT );
		return true ;
	}

	else return SendClientMessage(playerid, COLOR_ERROR, "Can only be used when not logged in.");
}

CMD:aka(playerid, params[]) {

	return cmd_id(playerid, params);
}
CMD:id(playerid, params []) 
{
	new count = 1, str[128];

    if ( IsNumeric ( params ) ) 
	{
		new id = strval(params);
		SendClientMessage(playerid, COLOR_BLUE, sprintf("[Search results for ID %d]", id));

		if (id > MAX_PLAYERS)
		{
			// Presumably this is a masked ID, so return a special case for it
			foreach(new i : Player) 
			{

				if (PlayerVar[i][E_PLAYER_IS_MASKED] && Character[i][E_CHARACTER_MASKID] == id)
				{
					format(str, sizeof(str), "%d. Stranger (ID: %d). This player is masked, details about them are unavailable.", count, Character[i][E_CHARACTER_MASKID]);
					SendClientMessage(playerid, 0xDEDEDEFF, str);
					count ++;
				}
			}

			return true;
		}

		// Otherwise just return regular player info, even if they are masked (which will prevent MG as you won't be able to check if someone's masked or not)
    	if (id < 0 || !IsPlayerConnected(id) || !IsPlayerLogged(id) || PlayerVar [ id ] [ E_PLAYER_ADMIN_HIDDEN ] && PlayerVar [ id ] [ E_PLAYER_ADMIN_DUTY ])
		{
    		return SendClientMessage(playerid, COLOR_ERROR, "Player doesn't seem to exist.");
    	}

		if(PlayerVar[id][E_PLAYER_IS_MASKED]) {
			format(str, sizeof(str), "%d. Stranger (ID: %d). This player is masked, details about them are unavailable.", count, id);
		}
		else format(str, sizeof(str), "%d. %s (ID: %d) (Account: %s | Level: %d | Hours: %d)", count, Character[id][E_CHARACTER_NAME], id, Account[id][E_PLAYER_ACCOUNT_NAME], Character[id][E_CHARACTER_LEVEL], Character[id][E_CHARACTER_HOURS]);

		SendClientMessage(playerid, 0xDEDEDEFF, str);
	}
	else
	{
		if (strlen(params) < 3) 
		{
    		return SendClientMessage(playerid, COLOR_ERROR, "/id [name] - enter at least 3 characters.");
	    }

		SendClientMessage(playerid, COLOR_BLUE, sprintf("[Search results for '%s']", params));

		foreach(new i: Player )
		{

			if ( PlayerVar [ i ] [ E_PLAYER_ADMIN_HIDDEN ] && PlayerVar [ i ] [ E_PLAYER_ADMIN_DUTY ])
				continue; 

			if (strfind ( Account [ i ] [ E_PLAYER_ACCOUNT_NAME ], params, true ) != -1 || strfind (Character[i][E_CHARACTER_NAME], params, true ) != -1 ) 
			{
				format(str, sizeof(str), "%d. %s (ID: %d) (Account: %s | Level: %d | Hours: %d)", count, Character[i][E_CHARACTER_NAME], i, Account[i][E_PLAYER_ACCOUNT_NAME], Character[i][E_CHARACTER_LEVEL], Character[i][E_CHARACTER_HOURS]);
				SendClientMessage(playerid, 0xDEDEDEFF, str);
				count ++;
			}
		}

		if (count == 1)
		{
			return SendClientMessage(playerid, COLOR_RED, "Player doesn't seem to exist.");
		}
	}

	return true ;
}


GetPlayerNametagPreference(playerid) {

	return Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] ;
}


forward IsPlayerIncapacitated(playerid, bool:excludeCuffs);
public IsPlayerIncapacitated(playerid, bool:excludeCuffs) {
	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ||  PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ] || PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ] ||
		! IsPlayerSpawned ( playerid ) || PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ] || PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] != -1) {
		return true ;
	}
	
	// New by Sporks: option to exclude just being cuffed from this check
	if (!excludeCuffs && (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || GetPVarInt(playerid, "CUFFED") == 1))
	{
	    return true;
	}

	if ( IsPlayerInMinigame(playerid) ) {

		return true ;
	}

	if (  PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0  ) {
		
		return true ;
	}


	return false ;
}