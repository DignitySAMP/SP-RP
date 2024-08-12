CMD:fw ( playerid, params [] ) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float:amount;

	if ( sscanf ( params, "F(2.0)", amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/fw [amount] (negative to go backwards, default is 2.0)") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;
	GetXYInFrontOfPlayer(playerid, x, y, amount);

	PauseAC(playerid, 3);
	SetPlayerPos ( playerid, x, y, z ) ;

	AddLogEntry(playerid, LOG_TYPE_ADMIN, "warped themselves forward (/fw)" );

	return true ;
}

CMD:up ( playerid, params [] ) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float:amount;

	if ( sscanf ( params, "F(2.0)", amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/up [amount] (negative to go down, default is 2.0)") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;
	PauseAC(playerid, 3);
	SetPlayerPos ( playerid, x, y, z + amount ) ;

	AddLogEntry(playerid, LOG_TYPE_ADMIN, "warped themselves up (/up)" );
	return true ;
}

CMD:dn ( playerid, params [] ) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float:amount;

	if ( sscanf ( params, "F(2.0)", amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/dn [amount] (negative to go up, default is 2.0)") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;
	PauseAC(playerid, 3);
	SetPlayerPos ( playerid, x, y, z - amount ) ;
	
	AddLogEntry(playerid, LOG_TYPE_ADMIN, "warped themselves down (/dn)" );

	return true ;
}

CMD:tp(playerid, params[]) {
	return cmd_goto(playerid, params);
}

CMD:goto(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/goto [targetid]") ;
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Player isn't connected.") ;
	}

	if (GetPlayerState(targetid) == PLAYER_STATE_SPECTATING && Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] >= ADMIN_LVL_JUNIOR)
	{
		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "This admin is spectating someone, you can't teleport to them." );
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( targetid, x, y, z ) ;

	new int = GetPlayerInterior(targetid );
	new vw = GetPlayerVirtualWorld(targetid ) ;

	if ( IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) {

		SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z ) ;
		SetPlayerInterior ( playerid, int ) ;
		SetPlayerVirtualWorld(playerid, vw ) ;

		foreach(new passenger: Player) {

			if ( GetPlayerVehicleID(passenger) == GetPlayerVehicleID ( playerid ) ) {

				SetPlayerInterior ( passenger, int ) ;
				SetPlayerVirtualWorld(passenger, vw ) ;	
			}
		}

		LinkVehicleToInterior(GetPlayerVehicleID(playerid), int ) ;
	}

	else {

		SetPlayerInterior ( playerid, int ) ;
		SetPlayerVirtualWorld ( playerid, vw ) ;
		SOLS_SetPlayerPos ( playerid, x, y, z, false ) ;
	}

	new string [ 96 ] ;

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("teleported to %s", ReturnMixedName(targetid)));
	AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("teleported to by %s", ReturnMixedName(playerid)));

	format ( string, sizeof ( string ),"You teleported to %s .", ReturnMixedName(targetid));
	SendClientMessage(playerid, COLOR_YELLOW, string ) ;

	format ( string, sizeof ( string ),"Administrator %s has teleported to you.",  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] );
	SendClientMessage(targetid, COLOR_YELLOW, string ) ;

	return true ;
}

CMD:bring(playerid, params[]) {

	return cmd_gethere(playerid, params);
}
CMD:gethere(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/gethere [targetid]") ;
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Player isn't connected.") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

	new int = GetPlayerInterior(playerid );
	new vw = GetPlayerVirtualWorld(playerid ) ;

	if ( IsPlayerInAnyVehicle(targetid) && GetPlayerState(targetid) == PLAYER_STATE_DRIVER ) {

		// pause the ac for any passengers aswell as they will be tp'ed
		foreach(new passenger: Player) {
			if ( GetPlayerVehicleID(passenger) == GetPlayerVehicleID ( targetid ) ) {
				PauseAC(passenger, 5);
			}
		}
		
		SetVehiclePos(GetPlayerVehicleID(targetid), x, y, z ) ;
		SetPlayerInterior ( targetid, int ) ;
		SetPlayerVirtualWorld(targetid, vw ) ;

		foreach(new passenger: Player) {

			if ( GetPlayerVehicleID(passenger) == GetPlayerVehicleID ( targetid ) ) {
				SetPlayerInterior ( passenger, int ) ;
				SetPlayerVirtualWorld(passenger, vw ) ;	
			}
		}

		LinkVehicleToInterior(GetPlayerVehicleID(targetid), int ) ;
	}

	else 
	{
		SetPlayerInterior ( targetid, int ) ;
		SetPlayerVirtualWorld ( targetid, vw ) ;
		SOLS_SetPlayerPos ( targetid, x, y, z ) ;
	}

	new string [ 96 ] ;


	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("teleported %s", ReturnMixedName(targetid)));
	AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("teleported by %s", ReturnMixedName(playerid)));

	format ( string, sizeof ( string ),"Administrator %s has teleported you to their location.",  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]);
	SendClientMessage(targetid, COLOR_YELLOW,string ) ;
	format ( string, sizeof ( string ),"Teleported %s to your location.",  ReturnMixedName(targetid));
	SendClientMessage(playerid, COLOR_YELLOW,string ) ;

	Minigame_ResetVariables(targetid);

	return true ;
}

CMD:freeze(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/freeze [targetid]");
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected.");
	}


	TogglePlayerControllable(targetid, false);

	new query [ 96 ] ;

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("frozen %s", ReturnMixedName(targetid)));
	AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("frozen by %s", ReturnMixedName(playerid)));

	format ( query, sizeof ( query ),"You've been frozen by administrator %s.",  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]);
	SendClientMessage(targetid, COLOR_YELLOW,query ) ;
	format ( query, sizeof ( query ),"You froze %s.",  ReturnMixedName(targetid));
	SendClientMessage(playerid, COLOR_YELLOW,query ) ;

	return true ;
}
CMD:unfreeze(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/unfreeze [targetid]");
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected.");
	}


	TogglePlayerControllable(targetid, true);

	new query [ 96 ] ;

	
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("unfroze %s", ReturnMixedName(targetid)));
	AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("unfrozen by %s", ReturnMixedName(playerid)));
	
	format ( query, sizeof ( query ),"You've been unfrozen by administrator %s.",  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]);
	SendClientMessage(targetid, COLOR_YELLOW, query ) ;
	format ( query, sizeof ( query ),"You unfroze %s.",  ReturnMixedName(targetid));
	SendClientMessage(playerid, COLOR_YELLOW,query ) ;

	return true ;
}