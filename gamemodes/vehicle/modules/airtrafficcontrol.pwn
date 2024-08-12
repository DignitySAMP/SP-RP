CMD:viewairspace(playerid) {

 	if( ! IsPlayerInPoliceFaction(playerid)) {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be a police officer in order to view this information!" ) ;
    }

    DisplayAircraftsInUse(playerid) ;
	return true ;
}

DisplayAircraftsInUse(playerid) {

	new  veh_enum_id ;

	SendClientMessage(playerid, COLOR_BLUE, "[Aircrafts Occupying Airspace ]") ;

	foreach(new targetid: Player) {

		if ( IsAircraft(GetPlayerVehicleID ( targetid ) ) ) {

			veh_enum_id = Vehicle_GetEnumID(GetPlayerVehicleID ( targetid )) ;

			if ( veh_enum_id != -1 ) {
				SendClientMessage(playerid, 0xDEDEDEFF, sprintf("%s | %s", ReturnVehicleName ( GetPlayerVehicleID ( targetid ) ), Vehicle [ veh_enum_id ] [ E_VEHICLE_LICENSE ] ) ) ;

				continue ;
			}

			else SendClientMessage(playerid, 0xDEDEDEFF, sprintf("%s | Unknown", ReturnVehicleName ( GetPlayerVehicleID ( targetid ) ) ) ) ;

			continue ;
		} 

		else continue ;
	}

	return true ;
}

CMD:atc(playerid, params[]) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {
		
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't speak. Use /acceptdeath to continue.");
		return 0 ;
	}

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

 	if( ! IsPlayerInPoliceFaction(playerid, true) && ! IsPlayerInMedicFaction(playerid, true)) {

		if ( ! IsAircraft(GetPlayerVehicleID ( playerid ) ) ) {

	    	return SendServerMessage ( playerid, COLOR_ERROR, "Insufficient Access", "A3A3A3", "You must be in an airplane in order to be able to do this!" ) ;
		}
	}

	new text [ 128 ], string[144] ;

	if ( sscanf ( params, "s[128]", text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/atc [text]" ) ;
	}

    // ProxDetectorNameTag(playerid, 35.0, 0xDEDEDEFF, text, " says (radio):", 0, true, false ) ;

	foreach(new targetid: Player) 
	{
	 	if( IsPlayerInPoliceFaction(targetid, true) || IsPlayerInMedicFaction(targetid, true) || IsAircraft(GetPlayerVehicleID ( targetid ) ) ) 
		{
			format ( string, sizeof ( string ), "[ATC] %s transmits: %s", ReturnSettingsName(playerid, targetid), text) ;
			ZMsg_SendClientMessage(targetid, 0x6F67A6FF, string);
		}
	}

	return true ;
}