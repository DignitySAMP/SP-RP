

CMD:pay ( playerid, params [] ) {
	
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new targetid, amount ;

	if ( sscanf ( params, "k<player>i", targetid, amount ) ) {
				
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/pay [player] [amount]" ) ;
	}

	if ( targetid == INVALID_PLAYER_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Your target seems to be invalid (not connected)." ) ;
	}

	if (  PlayerVar [ targetid ] [ E_PLAYER_IS_SPECTATING ] == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if ( targetid == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Why would you pay yourself?" ) ;	
	}

 	if (!IsPlayerNearPlayer(playerid, targetid, 6.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if ( amount < 1 || amount > GetPlayerCash ( playerid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You don't have that much money." ) ;
	}

	if(GetPlayerCharacterLevel(playerid) < 2)
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You cannot use this command yet (only for lvl 2+)." ) ;

	TakePlayerCash ( playerid, amount ) ;
	GivePlayerCash ( targetid, amount ) ;


	ProxDetectorEx(playerid, 20, COLOR_ACTION, "**", sprintf("has paid $%s to %s.", IntegerWithDelimiter(amount), ReturnMixedName(targetid)));
	SendClientMessage(targetid, 0x3E7C17FF, sprintf("You have received $%s from %s.", IntegerWithDelimiter(amount), ReturnSettingsName(playerid, targetid)));
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Paid $%s to %s (%d)", IntegerWithDelimiter(amount), ReturnMixedName(targetid), true));
	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Received $%s from %s (%d)", IntegerWithDelimiter(amount), ReturnMixedName(playerid), true));


	return true ;
}


CMD:paya(playerid, params[]) {

	return cmd_payanim(playerid, params);
}

CMD:payanim ( playerid, params [] ) {
	
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new targetid, amount ;

	if ( sscanf ( params, "k<player>i", targetid, amount ) ) {
				
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/payanim [player] [amount]" ) ;
	}

	if ( targetid == INVALID_PLAYER_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Your target seems to be invalid (not connected)." ) ;
	}

	if (  PlayerVar [ targetid ] [ E_PLAYER_IS_SPECTATING ] == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if ( targetid == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Why would you pay yourself?" ) ;	
	}

 	if (!IsPlayerNearPlayer(playerid, targetid, 6.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if ( amount < 1 || amount > GetPlayerCash ( playerid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You don't have that much money." ) ;
	}

    // Only do anim if they're close to the player to avoid abuse

    if ( !IsPlayerInAnyVehicle(playerid) || !IsPlayerInAnyVehicle(targetid)) {
	    if ( IsPlayerNearPlayer ( playerid, targetid, 2.0 )) {
			SetPlayerToFacePlayer(targetid, playerid);
			SetPlayerToFacePlayer(playerid, targetid);

			ApplyAnimation(targetid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
			ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
		}
	}

	if(GetPlayerCharacterLevel(playerid) < 2)
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You cannot use this command yet (only for lvl 2+)." ) ;


	TakePlayerCash ( playerid, amount ) ;
	GivePlayerCash ( targetid, amount ) ;

	ProxDetectorEx(playerid, 20, COLOR_ACTION, "**", sprintf("has paid $%s to %s.", IntegerWithDelimiter(amount), ReturnMixedName(playerid)));
	SendClientMessage(targetid, 0x3E7C17FF, sprintf("You have received $%s from %s.", IntegerWithDelimiter(amount), ReturnSettingsName(playerid, targetid)));
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Paid $%s to %s (%d)", IntegerWithDelimiter(amount), ReturnMixedName(targetid), true));
	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Received $%s from %s (%d)", IntegerWithDelimiter(amount), ReturnMixedName(playerid), true));
	
	return true ;
}