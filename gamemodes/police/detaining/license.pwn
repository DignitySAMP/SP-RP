
CMD:driverwarn(playerid, params[]) {
	
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/licenses [targetid]");
	}

	if ( ! IsPlayerConnected(target ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Target isn't connected.");
	}

 	if (!IsPlayerNearPlayer(playerid, target, 6.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

    new query [ 256 ] ;

    ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("has given %s a warning mark in their license.", 
    	 ReturnMixedName(target)), false, true);

    Character [ target ] [ E_CHARACTER_DRIVER_WARNINGS ] ++ ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_driver_warnings = %d WHERE player_id = %d",
		Character [ target ] [ E_CHARACTER_DRIVER_WARNINGS ],  Character [ target ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

    if (  Character [ target ] [ E_CHARACTER_DRIVER_WARNINGS ] >= 3 ) {

    	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_driver_warnings = 0, player_driverslicense = 0 WHERE player_id = %d",
    	 Character [ target ] [ E_CHARACTER_ID ] ) ;

    	mysql_tquery(mysql, query);

    	Character [ target ] [ E_CHARACTER_DRIVER_WARNINGS ]  = 0 ;
    	Character [ target ] [ E_CHARACTER_DRIVERSLICENSE]  = 0 ;

    	SendClientMessage(target, COLOR_INFO, "Your drivers license has recieved it's third warning. It has been confiscated!" ) ;
    	SendClientMessage(playerid, COLOR_YELLOW, "Your target's drivers license has recieved it's third warning! The license has been REMOVED!" ) ;
    }

	return true ;
}

CMD:takelicense(playerid, params[]) {
	
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new targetid ;
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/takelicense [targetid]");
	}

	if ( ! IsPlayerConnected(targetid ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Target isn't connected.");
	}

 	if (!IsPlayerNearPlayer(playerid, targetid, 3.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

    if ( ! Character [ targetid ] [ E_CHARACTER_DRIVERSLICENSE ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Your target does not have a license, you can't take it away!" ) ;
    }


	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has revoked the driver's license of (%d) %s. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid ), targetid, ReturnMixedName ( targetid )
	), faction_enum_id, false ) ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_driverslicense = 0 WHERE player_id = %d", Character [ targetid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;

	Character [ targetid ] [ E_CHARACTER_DRIVERSLICENSE ] = 0 ;

	ProxDetectorEx ( playerid, 20, COLOR_ACTION, "*", sprintf( "revokes the driver's license of %s.", ReturnMixedName(targetid)) ) ;

	return true ;
}