CMD:factiongoto(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action)goto [id]");
	}

	if ( Faction [ id ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	}

	SOLS_SetPlayerPos(playerid, Faction [ id ] [ E_FACTION_SPAWN_X ], Faction [ id ] [ E_FACTION_SPAWN_Y ], Faction [ id ] [ E_FACTION_SPAWN_Z ]);
	SetPlayerInterior(playerid, Faction [ id ] [ E_FACTION_SPAWN_INT ]);
	SetPlayerVirtualWorld(playerid, Faction [ id ] [ E_FACTION_SPAWN_VW ]);

	new string [ 128 ] ;
	format(string, sizeof(string), "teleported to (%d) %s faction spawn.", id, Faction [ id ] [ E_FACTION_NAME ]);
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	format(string, sizeof(string), "[ADMIN] %s (%d) has %s", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, string);
	SendAdminMessage(string);

	return true ;
}

CMD:fchatban(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/fchatban [id]");
	}

	if ( Faction [ id ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	}

	if ( Faction [ id ] [ E_FACTION_F_ON ] ) {
		Faction [ id ] [ E_FACTION_F_ON ] = 0 ;
		SendAdminMessage ( sprintf("[!!!] [AdmWarn] %s has disabled %s's (%d) faction chat.", ReturnMixedName(playerid), Faction_GetAbbreviationByID(id), id ));
	}
	else if ( ! Faction [ id ] [ E_FACTION_F_ON ] ) {
		Faction [ id ] [ E_FACTION_F_ON ] = 1 ;
		SendAdminMessage ( sprintf("[!!!] [AdmWarn] %s has enabled %s's (%d) faction chat.", ReturnMixedName(playerid), Faction_GetAbbreviationByID(id), id ));
	}

	new query[256];
	mysql_format(mysql, query, sizeof(query), "UPDATE factions SET faction_f_on = %d WHERE faction_id = %d", Faction[id][E_FACTION_F_ON], Faction[id][E_FACTION_ID]);
	mysql_tquery(mysql, query);

	return true;
}


CMD:fgoto(playerid, params[]) {

	return cmd_factiongoto(playerid, params);
}

CMD:factionname(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, name [ MAX_FACTION_NAME ] ;

	if ( sscanf ( params, "is[256]", id, name ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action)name [id] [name]");
	}

	if ( Faction [ id ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	}

	if ( strlen ( name ) < 4 || strlen ( name ) > MAX_FACTION_NAME ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("Name can't be less than 4 characters or more than %d.",
			MAX_FACTION_NAME ));
	}

	Faction [ id ] [ E_FACTION_NAME ] [ 0 ] = EOS ;
	strcat(Faction [ id ] [ E_FACTION_NAME ], name ) ;

	Faction [ id ] [ E_FACTION_ABBREV ] [ 0 ] = EOS ;
	strcat(Faction [ id ] [ E_FACTION_ABBREV ], Faction_GetAbbreviation ( Faction [ id ] [ E_FACTION_NAME ] )) ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE factions SET faction_name = '%e', faction_abbrev = '%e' WHERE faction_id = %d",
		Faction [ id ] [ E_FACTION_NAME ], Faction [ id ] [ E_FACTION_ABBREV ], Faction [ id ] [ E_FACTION_ID] ) ;
	mysql_tquery ( mysql, query ) ;


	SendClientMessage(playerid, COLOR_INFO, sprintf("Changed faction ID %d (%d)'s name to \"%s\". [%s]",
		id, Faction [ id ] [ E_FACTION_ID], Faction [ id ] [ E_FACTION_NAME ],
		Faction [ id ] [ E_FACTION_ABBREV ] )) ;

	return true ;
}

CMD:fname(playerid, params[]) {

	return cmd_factionname(playerid, params);
}


CMD:factioncreate(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new type ;

	if ( sscanf ( params, "i", type ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action)create [type]") ;
		SendClientMessage(playerid, COLOR_GRAD0, "Types: 0: Police, 1: Criminal, 2: Legal, 3: EMS, 4: News, 5: Trucker (temp), 6: GOV" ) ;

		return true ;
	}

	Faction_Create ("Unused", "ABBR", type, 5, 5 );


	SendClientMessage(playerid, COLOR_INFO, sprintf("Created faction \"Unused\" with type %d. Use /factions to get it's ID.", 
		type ) ) ;

	SendClientMessage(playerid, COLOR_INFO, "You can set it's name using /f(action)name. For more info use /f(action)help." ) ;

	return true ;
}

CMD:fcreate(playerid, params[]) {

	return cmd_factioncreate(playerid, params);
}

CMD:fhex(playerid, params[]) {

	return cmd_factionhex(playerid, params);
}
CMD:factionhex(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, hex ;

	if ( sscanf ( params, "ih", id, hex ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action)hex [id] [hex]");
	}

	if ( Faction [ id ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	}

	Faction [ id ] [ E_FACTION_HEXCOLOR ] = hex ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE factions SET faction_hex = '%d' WHERE faction_id = %d",
		Faction [ id ] [ E_FACTION_HEXCOLOR ], Faction [ id ] [ E_FACTION_ID] ) ;
	mysql_tquery ( mysql, query ) ;


	SendClientMessage(playerid, COLOR_INFO, sprintf("Changed faction ID %d (%d)'s hex to \"%d\".",
		id, Faction [ id ] [ E_FACTION_ID], Faction [ id ] [ E_FACTION_HEXCOLOR ] )) ;

	foreach(new target: Player) {

		if ( Faction [ id ] [ E_FACTION_ID ] == Character [ target ] [ E_CHARACTER_FACTIONID ] ) {

			//Player_UpdateNameTag(target );
			UpdateTabListForOthers ( target ) ;
		}
	}
	
	return true ;
}
CMD:fvisible(playerid, params[]) {

	return cmd_factionvisible(playerid, params);
}
CMD:factionvisible(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action)visible [id]");
	}

	if ( Faction [ id ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	}

	if ( ! Faction [ id ] [ E_FACTION_VISIBLE ] ) {

		Faction [ id ] [ E_FACTION_VISIBLE ]  = 1 ;
	}
	else if ( Faction [ id ] [ E_FACTION_VISIBLE ] ) {

		Faction [ id ] [ E_FACTION_VISIBLE ]  = 0 ;
	}

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE factions SET faction_visible = '%d' WHERE faction_id = %d",
		Faction [ id ] [ E_FACTION_VISIBLE ], Faction [ id ] [ E_FACTION_ID] ) ;
	mysql_tquery ( mysql, query ) ;

	SendClientMessage(playerid, COLOR_INFO, sprintf("Changed faction ID %d (%d)'s visibility to \"%d\".",
		id, Faction [ id ] [ E_FACTION_ID], Faction [ id ] [ E_FACTION_VISIBLE ] )) ;

	
	return true ;
}