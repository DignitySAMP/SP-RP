CMD:createfuelpump(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new type ;

	if ( sscanf ( params, "i", type ) ) {

		return SendClientMessage(playerid, -1, "/createfuelpump [1: ron, 2: terroil, 3: globe]");
	}

	if ( type <= E_FUEL_TYPE_NONE || type > 3 ) {

		return SendClientMessage(playerid, -1, "Invalid type! Choose one: [1: ron,  2: terroil, 3: globe]");
	}


	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

	x += 2.5 ;
	y += 2.5 ;

	PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELSTATION ] = true ;

	PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] = CreateDynamicObject ( Fuel_GetModel ( type ), x, y, z, 
		0.0, 0.0, 0.0, .worldid =  GetPlayerVirtualWorld ( playerid ), .interiorid = GetPlayerInterior ( playerid )  
	);


	PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_TYPE ] = type ;

	EditDynamicObject ( playerid, PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] ) ;

	return true ;
}

CMD:nearestpump(playerid, params[]) {
	new pump_idx = Fuel_GetNearestPump(playerid) ;

	if ( pump_idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage ( playerid, -1, "You're not near any pump.");
	}

	SendClientMessage(playerid, -1, sprintf("Nearest pump: %d", FuelPump [ pump_idx ] [ E_FUEL_PUMP_ID ] ));

	return true ;
}


CMD:unlinkpump(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new pump_idx, station_idx ;

	if ( sscanf ( params, "i", pump_idx ) ) {

		return SendClientMessage ( playerid, -1, "/unlinkpump [pump_sql_id] (/nearestpump)");
	}

	new pump_enum_id = FuelPump_LinkSQLIDToEnum(pump_idx);

	if ( pump_enum_id == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid pump SQL ID supplied. Can't find linked enumerator index.");
	}

	FuelPump [pump_enum_id] [ E_FUEL_PUMP_MANAGER_ID ] = INVALID_FUEL_MANAGER_ID ;

	SendClientMessage(playerid, -1, sprintf("You have unlinked fuel pump %d. Make sure to relink it or it won't generate revenue.", pump_idx, station_idx ) ) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelstation SET fuelstation_manager_id = %d WHERE fuelstation_id = %d", 
	 	FuelPump [pump_enum_id] [ E_FUEL_PUMP_MANAGER_ID ], FuelPump [pump_enum_id] [ E_FUEL_PUMP_ID ] ) ;
	mysql_tquery(mysql, query);

	return true ;
}

CMD:linkpumptostation(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new pump_idx, station_idx ;

	if ( sscanf ( params, "ii", pump_idx, station_idx ) ) {

		return SendClientMessage ( playerid, -1, "/linkpumptostation [pump_sql_id] [station_sql_id] (/nearestpump, /neareststation)");
	}

	new pump_enum_id = FuelPump_LinkSQLIDToEnum(pump_idx);

	if ( pump_enum_id == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid pump SQL ID supplied. Can't find linked enumerator index.");
	}

	new bool: valid_station_sql_id = false ;

	foreach(new station_enum_id: FuelStation) {

		if ( FuelStation [ station_enum_id ] [ E_FUEL_STATION_ID ] == station_idx ) {

			valid_station_sql_id = true ;
		}

		else continue ;
	}

	if ( ! valid_station_sql_id ) {

		return SendClientMessage(playerid, -1, "Invalid station SQL ID supplied. Can't find linked enumerator index.");
	}

	FuelPump [pump_enum_id] [ E_FUEL_PUMP_MANAGER_ID ] = station_idx ;

	SendClientMessage(playerid, -1, sprintf("You have linked fuel pump %d to fuel station %d.", pump_idx, station_idx ) ) ;
	
	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelstation SET fuelstation_manager_id = %d WHERE fuelstation_id = %d", 
	 	FuelPump [pump_enum_id] [ E_FUEL_PUMP_MANAGER_ID ], FuelPump [pump_enum_id] [ E_FUEL_PUMP_ID ] ) ;
	mysql_tquery(mysql, query);

	return true ;
}


CMD:viewlinkedpumps(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/viewlinkedpumps [sql-id] (pumps linked to station)");
	}

	new idx = FuelPump_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid station SQL ID supplied. Can't find linked enumerator index.");
	}

	SendClientMessage(playerid, COLOR_ORANGE, sprintf("Fuel pumps linked to fuelstation SQL ID %d.", sql_id ) );

	foreach(new stations:FuelPump) {

		if ( FuelPump [ stations ] [ E_FUEL_PUMP_MANAGER_ID ] == sql_id) {

			SendClientMessage(playerid, COLOR_YELLOW, sprintf("SQL ID %d", FuelPump [ stations ] [ E_FUEL_PUMP_ID ]));
			continue ;
		}
	}

	return true ;
}

CMD:gotopump(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/gotopump [sql-id]");
	}

	new idx = FuelPump_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid pump SQL ID supplied. Can't find linked enumerator index.");
	}


	SOLS_SetPlayerPos(playerid, FuelPump [ idx ] [ E_FUEL_PUMP_POS_X ], 
		FuelPump [ idx ] [ E_FUEL_PUMP_POS_Y ], FuelPump [ idx ] [ E_FUEL_PUMP_POS_Z ] 
	);

	SetPlayerInterior ( playerid, FuelPump [ idx ] [ E_FUEL_PUMP_POS_INT ]  );
	SetPlayerVirtualWorld ( playerid, FuelPump [ idx ] [ E_FUEL_PUMP_POS_VW ]  );

	SendClientMessage ( playerid, -1, sprintf("You have teleported to fuel pump sql ID %d.", sql_id ) ) ;


	return true ;
}

CMD:movepump(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/gotopump [sql-id]");
	}

	new idx = FuelPump_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid pump SQL ID supplied. Can't find linked enumerator index.");
	}

	PlayerVar [ playerid ] [ E_PLAYER_EDITING_FUELSTATION ] = true ;
	PlayerVar [ playerid ] [ E_PLAYER_EDITING_FUELSTATION_ID ] = idx ;


	EditDynamicObject( playerid, FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ] ) ;
	SendClientMessage ( playerid, -1, sprintf("You're editing fuel pump with SQL ID %d. To revert changes press ESC.", sql_id ) ) ;

	return true ;
}


CMD:deletepump(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/deletepump [sql-id]");
	}

	new idx = FuelPump_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid pump SQL ID supplied. Can't find linked enumerator index.");
	}

	if ( IsValidDynamicObject ( FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ] ) ) {

		DestroyDynamicObject ( FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ] ) ;
	}

	FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ] = INVALID_OBJECT_ID ;

	if ( IsValidDynamicArea ( FuelPump [ idx ] [ E_FUEL_PUMP_AREAID ] ) ) {

		DestroyDynamicArea( FuelPump [ idx ] [ E_FUEL_PUMP_AREAID ] ) ;
	} 

	FuelPump [ idx ] [ E_FUEL_PUMP_AREAID ] = INVALID_STREAMER_ID ;
	FuelPump [ idx ] [ E_FUEL_PUMP_ID ] = INVALID_FUEL_STATION_ID ;
	FuelPump [ idx ] [ E_FUEL_PUMP_MANAGER_ID ] = INVALID_FUEL_MANAGER_ID ;

	Iter_Remove(FuelPump, idx);

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ),  "DELETE FROM fuelstation WHERE fuelstation_id = %d", sql_id ) ;
	mysql_tquery(mysql, query);

	SendClientMessage(playerid, -1, sprintf("You've removed fuel pump SQL ID %d", sql_id ) ) ;

	return true ;
}

CMD:unlinkedpumps(playerid) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	SendClientMessage(playerid, COLOR_BLUE, "[List of unlinked fuel pumps]:");

	new name [ 64 ] ;

	foreach(new idx: FuelPump ) {

		if ( !FuelPump [ idx ] [ E_FUEL_PUMP_MANAGER_ID ] || FuelPump [ idx ] [ E_FUEL_PUMP_MANAGER_ID ] == INVALID_FUEL_MANAGER_ID ) {

			Fuel_GetName( FuelPump [ idx ] [ E_FUEL_PUMP_TYPE ], name, sizeof ( name ) ) ;
			SendClientMessage(playerid, COLOR_BLUE, sprintf("Fuel Pump SQL ID %d, type %s", FuelPump [ idx ] [ E_FUEL_PUMP_ID ], name ));
		}

		else continue ;
	}

	return true ;
}