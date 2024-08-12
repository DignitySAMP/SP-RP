#define COLOR_DONATOR	0xEDAD0DFF

enum {

	E_PREMIUM_LVL_0,
	E_PREMIUM_LVL_1,
	E_PREMIUM_LVL_2,
	E_PREMIUM_LVL_3,
	E_PREMIUM_LVL_4,
	E_PREMIUM_LVL_5,
	E_PREMIUM_LVL_6,
	E_PREMIUM_LVL_7,
} ;


GetPremiumRank ( premium_lvl, premium_name [ ], len = sizeof ( premium_name ) ) {

	switch ( premium_lvl ) {

		case E_PREMIUM_LVL_0: strunpack(premium_name, "Regular Player", len ) ;
		case E_PREMIUM_LVL_1: strunpack(premium_name, "Early Supporter", len ) ;
		case E_PREMIUM_LVL_2: strunpack(premium_name, "Bronze Donator", len ) ;
		case E_PREMIUM_LVL_3: strunpack(premium_name, "Silver Donator", len ) ;
		case E_PREMIUM_LVL_4: strunpack(premium_name, "Gold Donator", len ) ;
		case E_PREMIUM_LVL_5: strunpack(premium_name, "Sapphire Donator", len ) ;
		case E_PREMIUM_LVL_6: strunpack(premium_name, "Emerald Donator", len ) ;
		case E_PREMIUM_LVL_7: strunpack(premium_name, "Ruby Donator", len ) ;

		default: {
			strunpack(premium_name, "Regular Player", len ) ;
		}
	}

	return true ;
}

stock GetPremiumColour( premium_lvl ) {

	new color ;

	switch ( premium_lvl ) {

		case E_PREMIUM_LVL_0: color = 0xDEDEDEFF ;
		case E_PREMIUM_LVL_1: color = 0x5C98CCFF ;
		case E_PREMIUM_LVL_2: color = 0x715041FF ;
		case E_PREMIUM_LVL_3: color = 0x85B4B4FF ;
		case E_PREMIUM_LVL_4: color = 0xD5B031FF ;
		case E_PREMIUM_LVL_5: color = 0x3156D5FF ;
		case E_PREMIUM_LVL_6: color = 0x31D577FF ;
		case E_PREMIUM_LVL_7: color = 0xD53131FF ;

		default: color = 0xDEDEDEFF ;
	}


	return color ;
}


GetPremiumHex( premium_lvl, hex[], len=sizeof(hex) ) {

	switch ( premium_lvl ) {

		case E_PREMIUM_LVL_1: format ( hex, len, "5C98CC") ;
		case E_PREMIUM_LVL_2: format ( hex, len, "715041") ;
		case E_PREMIUM_LVL_3: format ( hex, len, "85B4B4") ;
		case E_PREMIUM_LVL_4: format ( hex, len, "D5B031") ;
		case E_PREMIUM_LVL_5: format ( hex, len, "3156D5") ;
		case E_PREMIUM_LVL_6: format ( hex, len, "31D577") ;
		case E_PREMIUM_LVL_7: format ( hex, len, "D53131") ;
		default: format ( hex, len, "DEDEDE") ;
	}

	return true ;
}

CMD:donatorchat(playerid, params[]) {

	return cmd_dc(playerid, params) ;
}
 
CMD:dc(playerid, params[]) {

	if ( GetPlayerAdminLevel(playerid) == 0 ) {
		if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ] == E_PREMIUM_LVL_0 ) {
			return SendClientMessage ( playerid, COLOR_ERROR, "You're not a donator! Considering supporting? View "SHORT_URL_DONATIONS"!");
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_DONATOR ] ) {
		return SendClientMessage ( playerid, COLOR_ERROR, "You have toggled this chat. To reenable it, use /togd(onator)c(hat).");
	}
	if ( ! Server [ E_SERVER_DC_ENABLED ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Donator Chat is currently disabled." ) ;
	}
	
	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		SendClientMessage(playerid, COLOR_ERROR, "/d(onator)c(hat) [text]" ) ;
		SendClientMessage(playerid, COLOR_YELLOW, "To toggle, use /togd(onator)c(hat).");

		return true ;
	}

	if ( strlen ( text ) < 0 || strlen ( text ) > 144 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Text can't be less than 0 characters or more than 144 characters." ) ;
	}

	new string [ 256 ], hex [ 12 ], rank [ 64 ] ;

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ] > E_PREMIUM_LVL_0 && GetPlayerAdminLevel(playerid) == 0) {
		GetPremiumHex( Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ], hex, sizeof ( hex ) ) ;
		GetPremiumRank( Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ], rank, sizeof ( rank ) ) ;
		format ( string, sizeof ( string ), "(( [$] (%d) {%s}%s{DABB6E} %s{EDAD0D}: %s ))",  playerid, hex, rank, ReturnMixedName(playerid), text ) ;
	}

	else if ( GetPlayerAdminLevel(playerid) != 0 ) {
		format ( string, sizeof ( string ), "(( [$] (%d) {666666}Admin{DABB6E} %s{EDAD0D}: %s ))",  playerid, ReturnMixedName(playerid), text ) ;
	}

	SendDonatorMessage(string);

	string[0]=EOS;
	format(string, sizeof(string), "[DONATOR CHAT] %s: %s", ReturnMixedName(playerid), text );
	AddLogEntry(playerid, LOG_TYPE_OOC, string);

	return true ;
}

// player
CMD:togdonatorchat(playerid, params[]) {

	if ( GetPlayerAdminLevel(playerid) == 0 ) {
		if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ] == E_PREMIUM_LVL_0 ) {
			return SendClientMessage ( playerid, COLOR_ERROR, "You're not a donator! Considering supporting? View "SHORT_URL_DONATIONS"!");
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_DONATOR ] ) {

		SendClientMessage ( playerid, COLOR_DONATOR, "You've enabled the donator chat. To use it, use /d(onator)c(hat)." ) ;
		PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_DONATOR ] = false ;
	}
	else if ( !PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_DONATOR ] ) {

		SendClientMessage ( playerid, COLOR_DONATOR, "You've hidden the donator chat. You won't be able to see donator messages anymore." ) ;
		PlayerVar [ playerid ] [ E_PLAYER_TOGGLE_DONATOR ] = true ;
	}


	return true ;
}
CMD:togdc(playerid, params[]) {

	return cmd_togdonatorchat(playerid, params) ;
}
// admin
CMD:nodonatorchat(playerid, params[]) {

	return cmd_nodc(playerid, params) ;
}
CMD:nodc(playerid, params[]) {

	if ( GetPlayerAdminLevel(playerid) < 4 ) {

		return false ;
	}

	new string [ 256 ] ;

	if ( ! Server [ E_SERVER_DC_ENABLED ] ) {

		format ( string, sizeof ( string ), "[!!!] [AdmWarn] %s has enabled Donator Chat.", ReturnMixedName ( playerid )) ;
		Server [ E_SERVER_DC_ENABLED ] = true ;
	}

	else if ( Server [ E_SERVER_DC_ENABLED ] ) {

		format ( string, sizeof ( string ), "[!!!] [AdmWarn] %s has disabled Donator Chat.", ReturnMixedName ( playerid )) ;
		Server [ E_SERVER_DC_ENABLED ] = false ;
	}

	SendAdminMessage(string) ;

	format ( string, sizeof ( string), "(( [$] Administrator %s has toggled the donator chat. ))", ReturnMixedName ( playerid ) ) ;
	SendDonatorMessage(string); 

	return true ;
}

SendDonatorMessage(const text[]) {

	foreach(new donatorid: Player) {

		if ( ! IsPlayerLogged ( donatorid ) ) {

			continue ;
		}

		if ( PlayerVar [ donatorid ] [ E_PLAYER_TOGGLE_DONATOR ] ) {
			continue ;
		}

		if ( Account [ donatorid ] [ E_PLAYER_ACCOUNT_PREMIUMLEVEL ] > E_PREMIUM_LVL_0 || Account [ donatorid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] > 0  ) {

			ZMsg_SendClientMessage(donatorid, COLOR_DONATOR, text);
		}
	}
} 