CMD:helperchat(playerid, params[]) {
	if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] ) {
		if ( ! IsPlayerHelper ( playerid ) ) {

			return SendServerMessage ( playerid, COLOUR_HELPER, "Helper", "A3A3A3", "You need to be a helper in order to be able to do this!" ) ;
		}
	}
	
	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/h(elper)c(hat) [text]" ) ;
		return true ;
	}
	

	new string [ 512 ] ;


	if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] ) {
		format ( string, sizeof ( string ), "{[ [HELPER CHAT] %s (%d): %s ]}", ReturnMixedName ( playerid ), playerid, text ) ;
	}

	else {
		new rank_name [ 32 ];
		GetContributorRankName ( Account [ playerid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ], rank_name, 32 );
		format ( string, sizeof ( string ), "{[ [HELPER CHAT] {%s} %s (%d): %s ]}", rank_name, ReturnMixedName ( playerid ), playerid, text ) ;
	}

	SendHelperMessage(string, Server [ E_SERVER_HELPER_HEX ], true, .chat=true) ;

	AddLogEntry(playerid, LOG_TYPE_STAFFCHAT, text);

	return true ;
}

CMD:togglehc(playerid) { return cmd_togglehelper(playerid); }
CMD:toghelper(playerid) { return cmd_togglehelper(playerid); }
CMD:toghc(playerid) { return cmd_togglehelper(playerid); }

CMD:togglehelper(playerid) {

	if ( ! IsPlayerHelper ( playerid ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "Sorry, only helpers can use this command. Use /togadmin instead.") ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CHATS_TOGGLED ] ) {
		PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CHATS_TOGGLED ] = false ;
		SendClientMessage ( playerid, COLOR_BLUE, "You've enabled helper chats.") ;
	}

	else {
		PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CHATS_TOGGLED ] = true ;
		SendClientMessage ( playerid, COLOR_BLUE, "You've disabled helper chats.") ;
	}

	return true ;
}

CMD:hc(playerid, params[]) {
	return cmd_helperchat(playerid, params);
}
