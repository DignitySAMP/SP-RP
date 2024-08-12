
CMD:givemoney ( playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_MANAGER) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, amount ;

	if ( sscanf ( params, "k<player>i", targetid, amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/givemoney [playerid] [amount of money]");
	}

	if ( ! IsPlayerConnected( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected." ) ;
	}

	GivePlayerCash ( targetid, amount ) ;


	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("[Admin] Received $%s from %s (%d)", IntegerWithDelimiter(amount), ReturnMixedName(playerid), true));
	
	SendClientMessage(playerid, COLOR_INFO, sprintf("You have refunded (%d) %s $%s.", targetid, ReturnSettingsName(targetid, playerid), IntegerWithDelimiter ( amount ) ) ) ;
	SendClientMessage(targetid, COLOR_ERROR, sprintf("You have been refunded $%s by (%d) %s.", IntegerWithDelimiter(amount), playerid, ReturnSettingsName(playerid, targetid))) ;

	return true ;
}
CMD:takemoney ( playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_MANAGER) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, amount ;

	if ( sscanf ( params, "k<player>i", targetid, amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/takemoney [playerid] [amount of money]");
	}

	if ( ! IsPlayerConnected( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected." ) ;
	}

	TakePlayerCash ( targetid, amount ) ;

	SendClientMessage(playerid, COLOR_INFO, sprintf("You have fined (%d) %s $%s.", targetid, ReturnSettingsName(targetid, playerid), IntegerWithDelimiter ( amount ) ) ) ;
	SendClientMessage(targetid, COLOR_ERROR, sprintf("You have been fined $%s by (%d) %s.", IntegerWithDelimiter(amount), playerid, ReturnSettingsName(playerid, targetid))) ;
	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("[Admin] Fined $%s by %s (%d)", IntegerWithDelimiter(amount), ReturnMixedName(playerid), true));

	return true ;
}
