CMD:noooc ( playerid, params [] ) {

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_HIDING_OOC ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_OOC ] = true ;

		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've disabled the OOC chat." ) ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_HIDING_OOC ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_OOC ] = false ;
		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've enabled the OOC chat." ) ;
	}

	return true ;
}

CMD:norc(playerid, params[]) {

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_HIDING_RC ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_RC ] = true ;

		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've disabled the respected chat." ) ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_HIDING_RC ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_RC ] = false ;
		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've enabled the respected chat." ) ;
	}

	return true ;
}

CMD:nofaction(playerid, params[]) {

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_HIDING_FACTION ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_FACTION ] = true ;

		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've disabled faction messages." ) ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_HIDING_FACTION] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_FACTION ] = false ;
		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've enabled faction messages." ) ;
	}

	return true ;
}


CMD:nopager(playerid, params[]) {

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_HIDING_PAGER ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_PAGER ] = true ;

		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've disabled pager messages." ) ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_HIDING_PAGER] ) {

		PlayerVar [ playerid ] [ E_PLAYER_HIDING_PAGER ] = false ;
		SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You've enabled pager messages." ) ;
	}

	return true ;
}
CMD:toghelp(playerid,params[]) {

	return cmd_togglehelp(playerid, params);
}
CMD:tog(playerid,params[]) {

	return cmd_togglehelp(playerid, params);
}
CMD:toggle(playerid,params[]) {

	return cmd_togglehelp(playerid, params);
}
CMD:toghud(playerid,params[]) {

	return cmd_togglehelp(playerid, params);
}
CMD:togglehud(playerid,params[]) {

	return cmd_togglehelp(playerid, params);
}


CMD:togglehelp(playerid, params[]) {


	SendClientMessage(playerid, COLOR_SERVER, "[List of toggle commands]");
	SendClientMessage(playerid, COLOR_GRAD0, "/noooc - hides global OOC chat messages");
	SendClientMessage(playerid, COLOR_GRAD0, "/norc - hides respected chat messages");
	SendClientMessage(playerid, COLOR_GRAD0, "/nofaction - hides faction messages");
	SendClientMessage(playerid, COLOR_GRAD0, "/nopager - hides pager messages");
	SendClientMessage(playerid, COLOR_GRAD0, "/blockpms - blocks private messages");
	SendClientMessage(playerid, COLOR_GRAD0, "/togdc - toggles donator chat.");
	SendClientMessage(playerid, COLOR_GRAD0, "/togstrawman - toggles strawman chat.");
	
	return true ;

}