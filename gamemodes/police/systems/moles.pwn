SendMoleMessage(fromplayerid, text[]) {

	new string [ 384 ] ;

	format ( string, sizeof ( string ), "[MOLE]: %s", text ) ;

	foreach(new playerid: Player) {

		if ( Character [ playerid ] [ E_CHARACTER_MOLE ] == 0 ) {

			continue ;
		}

		if ( ! IsPlayerLogged ( playerid ) || !IsPlayerSpawned ( playerid )) {

			continue ;
		}

		if (!IsPlayerInPoliceFaction ( playerid ) ) {

			continue ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_MOLE ] == Character [ fromplayerid ] [ E_CHARACTER_ID ] ) {

			if ( IsPlayerLogged ( playerid ) || IsPlayerSpawned  ( playerid ) ) {

				ZMsg_SendClientMessage(playerid, COLOR_MOLE, string);
			}
		}

		else continue ;
	}

	SendAdminListen ( fromplayerid, string ) ;

	return true ;
}

SendAdminListen(fromplayerid, text[]) {

	new string [ 384 ] ;

	format ( string, sizeof ( string ), "[LISTEN]: %s", text ) ;

	foreach(new playerid: Player) {

		if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
			continue ;
		}

		if ( ! IsPlayerLogged ( playerid ) || !IsPlayerSpawned ( playerid )) {

			continue ;
		}

		if ( PlayerVar [ playerid ] [ E_PLAYER_LISTEN ] == fromplayerid ) {

			ZMsg_SendClientMessage(playerid, COLOR_MOLE, string);
		}

		else continue ;
	}

	return true ;
}

public OnPlayerDisconnect(playerid, reason) {
	
	new string [ 256 ] ;

	foreach(new moleid: Player) {

		if ( Character [ moleid ] [ E_CHARACTER_MOLE ] <= 0 ) {

			continue ;
		}

		if ( ! IsPlayerLogged ( moleid ) || !IsPlayerSpawned ( moleid )) {

			continue ;
		}

		if (!IsPlayerInPoliceFaction ( moleid ) ) {

			continue ;
		}

		if ( Character [ moleid ] [ E_CHARACTER_MOLE ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			continue ;
		}

		if ( Character [ moleid ] [ E_CHARACTER_MOLE ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

			format ( string, sizeof ( string ), "The mole you planted on %s has gone dead... (( disconnected ))", Character [ playerid ] [ E_CHARACTER_NAME ] ) ;
			SendClientMessage(moleid, COLOR_MOLE, string );
		}

		else continue ;
	}

	#if defined mole_OnPlayerDisconnect
		return mole_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect mole_OnPlayerDisconnect
#if defined mole_OnPlayerDisconnect
	forward mole_OnPlayerDisconnect(playerid, reason);
#endif


CMD:mole(playerid, params[] ) {


	if( ! IsPlayerInPoliceFaction(playerid) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a police faction.");
	}

	else if ( IsPlayerInPoliceFaction(playerid) ) {

		if ( Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD ] < 1 || Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD2 ] < 1  || Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD3 ] < 1 ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your squad does not support this! (Need to be a detective or S.W.A.T.)");
		}
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/mole [targetid]");
	}

	if ( ! IsPlayerConnected(targetid)) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected.");
	}

	if ( !IsPlayerNearPlayer(playerid, targetid, 5.0 ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not near your target." );
	}

	Character [ playerid ] [ E_CHARACTER_MOLE ] = Character [ targetid ] [ E_CHARACTER_ID ] ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_mole = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_MOLE ], Character [ playerid ] [ E_CHARACTER_ID ]) ;

	mysql_tquery(mysql, query);

	query [ 0 ] = EOS ;

	format ( query, sizeof ( query ), "You've planted a mole on %s. The mole will stay after you log out. To remove it use /killmole.", ReturnSettingsName(targetid, playerid)) ;
	SendServerMessage ( playerid, COLOR_MOLE, "Mole", "DEDEDE", query );

	return true ;
}

CMD:killmole(playerid, params[]) {

	if( ! IsPlayerInPoliceFaction(playerid) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a police faction.");
	}

	if ( Character [ playerid ] [ E_CHARACTER_MOLE ] > 0 ) {

		new query [ 256 ] ;

		Character [ playerid ] [ E_CHARACTER_MOLE ] = 0 ;

		mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_mole = 0 WHERE player_id = %d",
			Character [ playerid ] [ E_CHARACTER_ID ]) ;

		mysql_tquery(mysql, query);

		SendServerMessage ( playerid, COLOR_MOLE, "Mole", "DEDEDE", "You've smashed your mole!" );
	}

	return true ;
}

CMD:listen(playerid, params[] ) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/listen [targetid]");
	}

	if ( ! IsPlayerConnected(targetid)) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected.");
	}

	PlayerVar [ playerid ] [ E_PLAYER_LISTEN ] = targetid ;

	new query [ 256 ] ;

	format ( query, sizeof ( query ), "You're now listening to %s. To turn off use /listenoff.", ReturnSettingsName(targetid, playerid) ) ;
	SendServerMessage ( playerid, COLOR_MOLE, "Listen", "DEDEDE", query );

	return true ;
}

CMD:listenoff(playerid, params[] ) {

	PlayerVar [ playerid ] [ E_PLAYER_LISTEN ] = INVALID_PLAYER_ID ;

	SendServerMessage ( playerid, COLOR_MOLE, "Listen", "DEDEDE", "Turned off listen." );

	return true ;
}

CMD:checkmole(playerid, params[]) {

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/checkmole [targetid]");
	}

	if ( targetid == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "You can't do this on yourself.");
	}

	if ( !IsPlayerNearPlayer(playerid, targetid, 5.0 ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not near this player." );
	}

	new string [ 256 ], bool: found ;


	foreach(new moleid: Player) {

		if ( Character [ moleid ] [ E_CHARACTER_MOLE ] == Character [ targetid ] [ E_CHARACTER_ID ] ) {

			found = true ;

			ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("finds a mole on %s's person and smashes it.", ReturnMixedName(targetid)), .annonated=true);

			Character [ moleid ] [ E_CHARACTER_MOLE ] = INVALID_PLAYER_ID ;

			format ( string, sizeof ( string ), "The mole you planted on %s has gone dead...", ReturnSettingsName(targetid, moleid) ) ;
			SendClientMessage(moleid, COLOR_MOLE, string );

			string[0]=EOS;
			mysql_format(mysql, string, sizeof ( string ), "UPDATE characters SET player_mole = 0 WHERE player_id = %d",
				Character [ moleid ] [ E_CHARACTER_ID ]) ;

			mysql_tquery(mysql, string);

			break ;
		}

		else continue ;
	}

	if ( ! found ) {

		string [ 0 ] = EOS ;
		format ( string, sizeof ( string ), "You check %s for moles but find nothing.", Character [ targetid ] [ E_CHARACTER_NAME ] ) ;
		SendServerMessage ( playerid, COLOR_MOLE, "Listen", "DEDEDE", string );
	}


	return true ;
}