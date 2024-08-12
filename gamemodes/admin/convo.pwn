CMD:acinvite ( playerid, params [] ) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/acinvite [target]") ;
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The target you selected doesn't seem to be connected. Try again.") ;
	}

	if ( PlayerVar [ target ] [ E_PLAYER_ADMIN_CONVO ]  != -1 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The target seems to already be in a admin conversation. Ask for an admin to remove them.") ;
	}

	PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] = playerid ;
	PlayerVar [ target ] [ E_PLAYER_ADMIN_CONVO ] = playerid ;

	foreach(new i: Player) {
		if ( PlayerVar [ i ] [ E_PLAYER_ADMIN_CONVO ] == PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] ) {

			ZMsg_SendClientMessage ( i, COLOR_ORANGE, sprintf("[AC] (%d) %s has been added to the admin conversation.", target, ReturnMixedName ( target )) ) ;
		}
	}

	SendServerMessage ( target, COLOR_ORANGE, "Admin Convo", "A3A3A3", sprintf("Moderator (%d) %s has invited you to their admin conversation. Use /ac to speak.", playerid,  Account[playerid][E_PLAYER_ACCOUNT_NAME]) ) ;
	SendServerMessage ( playerid, COLOR_ORANGE, "Admin Convo", "A3A3A3",  sprintf("You have invited (%d) %s to your admin convo. Use /ac to speak or /acuninvite to remove them.", target, ReturnMixedName ( target )) ) ;


	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("has been invited to %s's /ac", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("invited %s to their /ac", Account [ target ] [ E_PLAYER_ACCOUNT_NAME ]));

	return true ;
}


CMD:acuninvite ( playerid, params [] ) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/acuninvite [target]") ;
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The target you selected doesn't seem to be connected. Try again.") ;
	}

	if ( PlayerVar [ target ] [ E_PLAYER_ADMIN_CONVO ] == -1 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The target doesn't seem to be in any admin conversation.") ;
	}

	foreach(new i: Player) {
		if ( PlayerVar [ i ] [ E_PLAYER_ADMIN_CONVO ] == PlayerVar [ target ] [ E_PLAYER_ADMIN_CONVO ] ) {

			ZMsg_SendClientMessage ( i, COLOR_ORANGE, sprintf("[AC] (%d) %s has been removed from the admin conversation by moderator (%d) %s.", target, ReturnMixedName ( target ), playerid,  Account[playerid][E_PLAYER_ACCOUNT_NAME] ) ) ;
		}
	}

	PlayerVar [ target ] [ E_PLAYER_ADMIN_CONVO ] = -1 ;

	SendClientMessage ( target, COLOR_YELLOW, sprintf("Moderator (%d) %s has removed you from your current admin conversation.", playerid,  Account[playerid][E_PLAYER_ACCOUNT_NAME]) ) ;
	SendClientMessage ( playerid, COLOR_YELLOW, sprintf("You have removed (%d) %s from their current admin conversation.", target, ReturnMixedName ( target )) ) ;

	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("has been removed from %s's /ac", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("removed %s from their /ac", Account [ target ] [ E_PLAYER_ACCOUNT_NAME ]));

	return true ;
}

CMD:ac(playerid, params [] ) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] == -1 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in an admin conversation.") ;
	}

	new text [ 144 ] ; 

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/ac [text]") ;
	}

	new string [ 256 ] ;

	foreach(new i: Player) {

		if ( IsPlayerLogged ( i ) && IsPlayerPlaying (i)  ) {
			if ( PlayerVar [ i ] [ E_PLAYER_ADMIN_CONVO ] == PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] ) {

				format ( string, sizeof ( string ), "[AC] (%d) %s: %s", playerid, ReturnMixedName ( playerid ), text ) ; 
				ZMsg_SendClientMessage ( i, COLOR_ORANGE, string );

				AddLogEntry(i, LOG_TYPE_ADMIN, sprintf("[ac]: %s", text ) );
				AddLogEntry(i, LOG_TYPE_CHAT, sprintf("[ac]: %s", text ) );
			}

			else continue ;
		}
	}

	return true ;
}
