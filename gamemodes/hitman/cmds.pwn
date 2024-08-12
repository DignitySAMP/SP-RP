CMD:earplug(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }


	if ( ! IsPlayerHitman ( playerid ) ) {

		return false ;
	}

	new input [ 144 ] ;

	if ( sscanf ( params, "s[144]", input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/e(ar)p(lug) [text]");
	}

	if ( strlen ( input ) > sizeof ( input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("Your text can't be longer than %d characters.", sizeof ( input )));
	}

	new string [ 170 ] ;

	format ( string, sizeof ( string ), "** [Earplug] %s transmits: %s",

		ReturnMixedName ( playerid ), input
	);

	SendHitmanMessage ( string ) ;

	SendAdminListen(playerid, string);

	return true ;
}

CMD:ep(playerid, params[]) {

	return cmd_earplug(playerid, params);
}
