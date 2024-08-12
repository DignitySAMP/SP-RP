#include <YSI_Coding\y_hooks>
enum e_PLAYER_DATA {
	e_PLAYER_FLAGS:e_bFlags,
	Float:e_fPacket
};

enum e_PLAYER_FLAGS (<<= 1) {
	e_bUpdate = 1,
	e_bPaused
};

enum _:e_PLAYER_TICK_ENUM {
	e_PLAYER_TICK,
	e_PLAYER_LAST_UPDATE,
};
static s_aPlayerInfo[MAX_PLAYERS][e_PLAYER_DATA],
	s_aPlayerTickInfo[MAX_PLAYERS][e_PLAYER_TICK_ENUM] ;

forward OnPlayerPause(playerid);
forward OnPlayerResume(playerid, time);

hook OnPlayerUpdate(playerid)
{
	if(!Callback_GetFlag(playerid, e_bUpdate))
	{
		Callback_SetFlag(playerid, e_bUpdate, true);
	}

	s_aPlayerTickInfo[playerid][e_PLAYER_LAST_UPDATE] = GetConnectedTime(playerid);

	return 1;
}

hook OnGameModeInit()
{
 	SetTimer("Callback_TabCheck", 600, true);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    for(new i = 0; i < e_PLAYER_TICK_ENUM; i ++)
	{
		s_aPlayerTickInfo[playerid][i] = 0;
	}
	
	return 1;
}

forward Callback_TabCheck();
public Callback_TabCheck()
{
	for(new i = 0, l = GetPlayerPoolSize(); i <= l; i ++)
	{
	    switch(GetPlayerState(i))
	    {
	        case PLAYER_STATE_ONFOOT, PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
	        {
				if(Callback_GetFlag(i, e_bUpdate))
				{
					if(Callback_GetFlag(i, e_bPaused))
  					{
						CallLocalFunction("OnPlayerResume", "ii", i, GetConnectedTime(i) - s_aPlayerTickInfo[i][e_PLAYER_TICK]);
					}

		            Callback_SetFlag(i, e_bUpdate, false);
		            Callback_SetFlag(i, e_bPaused, false);
				}

				if(!Callback_GetFlag(i, e_bPaused) && (GetConnectedTime(i) - s_aPlayerTickInfo[i][e_PLAYER_LAST_UPDATE]) >= 4000)
				{
				    CallLocalFunction("OnPlayerPause", "i", i);

					s_aPlayerTickInfo[i][e_PLAYER_TICK] = GetConnectedTime(i);

					Callback_SetFlag(i, e_bPaused, true);
				}
			}
		}
	}
}

stock IsPlayerPaused(playerid)
{
	return Callback_GetFlag(playerid, e_bPaused);
}
stock GetPlayerPausedTime(playerid)
{
	return (GetConnectedTime(playerid) - s_aPlayerTickInfo[playerid][e_PLAYER_TICK]);
}
stock GetConnectedTime(playerid)
{
	return NetStats_GetConnectedTime(playerid);
}


stock static Callback_GetFlag(playerid, e_PLAYER_FLAGS:flag)
{
	return s_aPlayerInfo[playerid][e_bFlags] & flag;
}

stock static Callback_SetFlag(playerid, e_PLAYER_FLAGS:flag, status)
{
	if(status)
		return s_aPlayerInfo[playerid][e_bFlags] |= flag;
	else
	    return s_aPlayerInfo[playerid][e_bFlags] &= ~flag;
}

#if !defined MAX_AFK_TIME
#define MAX_AFK_TIME	( 600 )
#endif

stock AFKCheck_Tick ( playerid ) {

	if ( IsPlayerPaused ( playerid ) ) {
		if ( GetPlayerAdminLevel ( playerid ) ) {

			return true ;
		}

		if ( ++ PlayerVar [ playerid ] [ E_PLAYER_AFK_TIME ] >= MAX_AFK_TIME ) {
			new string [ 512 ], reason [ 36 ]  ;

            format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s has been kicked for afking.", playerid, ReturnPlayerNameData ( playerid )  ) ;

            ProxDetector ( playerid, 45.0, COLOR_ORANGE, string );
            SendAdminMessage(string, COLOR_ANTICHEAT) ;

            format ( reason, sizeof ( reason ), "Anticheat Detection: AFKing" ) ;
            SetAdminRecord ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_KICK, reason, -1, ReturnDateTime () ) ;

            KickPlayer ( playerid ) ;  

            PlayerVar [ playerid ] [ E_PLAYER_AFK_TIME ] = 0 ;
		}
	}

	else if ( ! IsPlayerPaused ( playerid ) ) {

		PlayerVar [ playerid ] [ E_PLAYER_AFK_TIME ] = 0 ;
	}

	return true ;
}

CMD:afklist ( playerid, params [] ) {

	SendClientMessage(playerid, COLOR_BLUE, "List of all AFK players") ;

	foreach(new i: Player) {

		if ( IsPlayerPaused ( i ) && i != INVALID_PLAYER_ID ) {

			SendClientMessage(playerid, COLOR_GRAD0, sprintf("(%d) %s (paused for %d seconds)", i, ReturnSettingsName(i, playerid, false), GetPlayerPausedTime(i) / 1000 ) ) ;
		}

		else continue;
	}

	return true ;
}