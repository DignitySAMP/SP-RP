/*
	Use AVG from MySQL to get the average play time of a player using /playtime.
*/

enum SESSION_DATA {

	E_SESSION_ID,
	E_SESSION_TIME,
	E_SESSION_IDLE
} ;

new Session [ MAX_PLAYERS ] [ SESSION_DATA ] ;

ptask SessionHandler[60000](playerid) 
{
	if (IsPlayerLogged (playerid)) 
	{
		Session [ playerid ] [ E_SESSION_TIME ] ++ ;

		if ( IsPlayerPaused ( playerid )) 
		{
			Session [ playerid ] [ E_SESSION_IDLE ] ++ ;
		}

		return SaveSessionData ( playerid ) ;
	}

	return true ;
}

static sessionquery[256];

SaveSessionData ( playerid ) {

	if (!IsPlayerLogged(playerid)) {

		return true ;
	}

	if ( ! Session [ playerid ] [ E_SESSION_ID ] && Character [ playerid ] [ E_CHARACTER_ID ] > 0 ) 
	{
		inline OnSessionDataReceived() {
		
			Session [ playerid ] [ E_SESSION_ID ] = cache_insert_id() ;
			printf(" [SESSION] Created session table for (%d) %s with table ID %d.", playerid, ReturnMixedName ( playerid ), Session [ playerid ] [ E_SESSION_ID ] ) ;
		}

		mysql_format ( mysql, sessionquery, sizeof ( sessionquery ), "INSERT INTO sessions (e_session_acc, e_session_char, e_session_web, e_session_time, e_session_idle, e_session_ip, e_session_unix_store) VALUES (%d, %d, %d, %d, %d, '%s', %d)", 
		Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Character [ playerid ] [ E_CHARACTER_ID ], 0, Session [ playerid ] [ E_SESSION_TIME ], Session [ playerid ] [ E_SESSION_IDLE ], ReturnIP(playerid),  gettime() ) ;
		//print(sessionquery);
		MySQL_TQueryInline(mysql, using inline OnSessionDataReceived, sessionquery);
	}

	else if ( Session [ playerid ] [ E_SESSION_ID ] ) {

		mysql_format ( mysql, sessionquery, sizeof ( sessionquery ), "UPDATE sessions SET e_session_time = %d, e_session_idle = %d, e_session_unix_last = %d WHERE e_session_acc = %d AND e_session_id = %d", 
			Session [ playerid ] [ E_SESSION_TIME ], Session [ playerid ] [ E_SESSION_IDLE ], gettime(), Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Session [ playerid ] [ E_SESSION_ID ] ) ;
		//print(sessionquery);
		mysql_tquery ( mysql, sessionquery );
	}

	return false ;
}