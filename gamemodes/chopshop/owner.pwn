ChopShop_LoadEntities() {

	new factionid = Server [ E_SERVER_CHOPSHOP_FACTIONID ] ;
	new faction_name [ 64 ] ;

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		format ( faction_name, sizeof ( faction_name ), "Unowned" ) ;
	}

	else format ( faction_name, sizeof ( faction_name ), "%s", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ] ) ;

	Server [ E_SERVER_CHOPSHOP_LABEL ] = CreateDynamic3DTextLabel(
		sprintf("[%s's Chop Shop]{DEDEDE}\nAvailable Commands: /chopcar, /buylockpick, /chopshopcollect",
		faction_name ), 0x5B381FFF, CHOPSHOP_X, CHOPSHOP_Y, CHOPSHOP_Z, 10.0, .testlos = false 
	) ;	

	UpdateChopShopLabel();

	CreateDynamicMapIcon(CHOPSHOP_X, CHOPSHOP_Y, CHOPSHOP_Z, 37, 0xFFFFFFFF);

	return true ;
}

UpdateChopShopLabel() {

	new string [ 256 ] ;

	new factionid = Server [ E_SERVER_CHOPSHOP_FACTIONID ] ;
	new faction_name [ 64 ] ;

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		format ( faction_name, sizeof ( faction_name ), "Unowned" ) ;
	}

	else format ( faction_name, sizeof ( faction_name ), "%s", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ] ) ;


	format ( string, sizeof ( string ), 
		"[%s's Chop Shop]{DEDEDE}\nAvailable Commands: /chopcar, /buylockpick, /chopshopcollect\n[Money Generated: $%s]",
		faction_name , IntegerWithDelimiter ( Server [ E_SERVER_CHOPSHOP_COLLECT ] ) ) ;

	UpdateDynamic3DTextLabelText(Server [ E_SERVER_CHOPSHOP_LABEL ], 0x5B381FFF, 
		string
	) ;

	return true ;
}

CMD:chopshopfaction(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new factionid ;

	if ( sscanf ( params, "i", factionid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/chopshopfaction [faction-id] (NOT SQL!)");
	}

	if ( Faction [ factionid ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	} 

	Server [ E_SERVER_CHOPSHOP_FACTIONID ] = Faction [ factionid ] [ E_FACTION_ID ];

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE server SET server_chopshop_factionid = %d", Server [ E_SERVER_CHOPSHOP_FACTIONID ] ) ;
	mysql_tquery(mysql, query);

	UpdateChopShopLabel() ;

	Faction_SendMessage(Faction [ factionid ] [ E_FACTION_ID], sprintf("{ [%s] The faction has taken control over the chopshop. }",

		Faction [ factionid ] [ E_FACTION_ABBREV ]
	), factionid, false ) ;

	format ( query, sizeof ( query ), "[!!!] [AdmWarn] %s has given chop-shop control to %s.", 
		ReturnMixedName ( playerid ), Faction [ factionid ] [ E_FACTION_ABBREV ] ) ;
	SendAdminMessage(query) ;
	
	return true ;
}

CMD:chopshopcollect(playerid, params[]) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] != 1 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_ID ] != Server [ E_SERVER_CHOPSHOP_FACTIONID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your faction doesn't own the chop shop.");
	}

	if ( ! IsPlayerInRangeOfPoint(playerid, 5.0, CHOPSHOP_X, CHOPSHOP_Y, CHOPSHOP_Z) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near the chopshop!");
	}

	Faction_AddBankMoney(faction_enum_id, Server [ E_SERVER_CHOPSHOP_COLLECT ] ) ;

	Faction_SendMessage(Faction [ faction_enum_id ] [ E_FACTION_ID], sprintf("{ [%s] %s has collected $%s from the chop-shop (faction bank). }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid ), IntegerWithDelimiter ( Server [ E_SERVER_CHOPSHOP_COLLECT ] )
	), faction_enum_id, false ) ;

	Server [ E_SERVER_CHOPSHOP_COLLECT ]  = 0 ; 

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE server SET server_chopshop_collect = 0" ) ;
	mysql_tquery(mysql, query);

	UpdateChopShopLabel() ;
	
	return true ;
}