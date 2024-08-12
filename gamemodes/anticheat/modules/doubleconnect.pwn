CheckDoubleConnection(playerid) {

	if ( ! IsPlayerConnected ( playerid ) ) {

		return true ;
	}

	foreach(new i: Player) {

		if ( ! strcmp ( ReturnPlayerName ( playerid ), Account [ i ] [ E_PLAYER_ACCOUNT_NAME ], true) && IsPlayerLogged ( i ) ) {

			SendAdminMessage ( sprintf("%s tried to connect onto (%d) %s's master account.", ReturnIP ( playerid ), i, ReturnMixedName(playerid) )) ;
			SendClientMessage ( playerid, COLOR_YELLOW, "Someone is already connected on this master account. Try again later or contact a moderator on Discord." ) ;
			KickPlayer ( playerid ) ;
		}

		if ( ! strcmp (ReturnIP ( playerid ), ReturnIP ( i ), true ) && IsPlayerLogged (i) ) {
			SendAdminMessage ( sprintf("(ID %d) is connecting with IP %s. It is already in use by (%d) %s (%s).", 
				playerid, ReturnIP ( playerid ), i, ReturnMixedName ( i ), ReturnIP ( i )) ) ;
			continue ;
		}

		else continue ;
	}
	return true ;
}