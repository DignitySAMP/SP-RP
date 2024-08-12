
CMD:confiscate(playerid, params[]) {

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {
		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "/confiscate [targetid]");
	}
    
	if ( ! IsPlayerConnected(targetid ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Target isn't connected.");
	}
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		if ( ! IsPlayerInPoliceFaction(playerid, true)) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a police faction.");
		}	

	 	if (!IsPlayerNearPlayer(playerid, targetid, 3.0)) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
	    }
	}

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
	    ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("confiscates any drugs from %s.", 
	    	ReturnMixedName(targetid)));
	}

	for ( new i, j = MAX_PLAYER_DRUGS; i < j ; i ++ ) {

		PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_SQLID ] 		= -1 ;
		PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_TYPE ] 		= 0 ;
		PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_PARAM ] 		= 0 ;
		PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_CONTAINER ] 	= 0 ;
		PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_AMOUNT ]		= 0.0 ;
	}

	PlayerDrugs_Save(targetid);

	new query [ 128 ] ;
	format ( query, sizeof ( query ), "[!] CONFISCATE: (%d) %s has confiscated (%d) %s's drugs / weapon packages.", 
		playerid, ReturnMixedName ( playerid ), targetid, ReturnMixedName ( targetid )) ;

	SendAdminMessage(query) ;

	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Used /confiscate on %s (%d)", ReturnMixedName(targetid), targetid));

	return true ;
}

CMD:disarm(playerid, params[]) {

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {
		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "/disarm [targetid]");
	}
    
	if ( ! IsPlayerConnected(targetid ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Target isn't connected.");
	}

	if ( IsPlayerInAnyVehicle(targetid)) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Your target has to leave the vehicle they are in before you can disarm them." ) ;
    }

	
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		if ( ! IsPlayerInPoliceFaction(playerid, true)) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a police faction.");
		}	

	 	if (!IsPlayerNearPlayer(playerid, targetid, 3.0)) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
	    }
	}

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
	    ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("has disarmed %s.", 
	    	ReturnMixedName(targetid)));
	}

	ResetPlayerWeapons(targetid) ;
	Weapon_ResetPlayerWeapons(targetid) ;

	new query [ 384 ] ;

	format ( query, sizeof ( query ), "[!] DISARM: (%d) %s has disarmed (%d) %s.", 
		playerid, ReturnMixedName ( playerid ), targetid, ReturnMixedName ( targetid )) ;

	SendAdminMessage(query) ;


	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Used /disarm on %s (%d)", ReturnMixedName(targetid), targetid));

	return true ;
}
