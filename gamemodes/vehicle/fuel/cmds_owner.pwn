CMD:createfuelstation(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;

	FuelStation_OnCreateStation(x, y, z, GetPlayerInterior ( playerid ), GetPlayerVirtualWorld ( playerid ) ) ;

	return true ;
}

CMD:neareststation(playerid, params[]) {
	new idx = FuelStation_GetClosestEntity(playerid) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage ( playerid, -1, "You're not near any station.");
	}

	SendClientMessage(playerid, -1, sprintf("Nearest fuel station: %d (sql id)", FuelStation [ idx ] [ E_FUEL_STATION_ID ] ));

	return true ;
}

 
CMD:gotostation(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/gotostation [sql-id]");
	}

	new idx = FuelStation_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid station SQL ID supplied. Can't find linked enumerator index.");
	}


	SOLS_SetPlayerPos(playerid, FuelStation [ idx ] [ E_FUEL_STATION_POS_X ], 
		FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ], FuelStation [ idx ] [ E_FUEL_STATION_POS_Z ] 
	);

	SetPlayerInterior ( playerid, FuelStation [ idx ] [ E_FUEL_STATION_POS_INT ]  );
	SetPlayerVirtualWorld ( playerid, FuelStation [ idx ] [ E_FUEL_STATION_POS_VW ]  );

	SendClientMessage ( playerid, -1, sprintf("You have teleported to fuel station sql ID %d.", sql_id ) ) ;

	return true ;
}


CMD:movestation(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/movestation [sql-id]");
	}

	new idx = FuelStation_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid station SQL ID supplied. Can't find linked enumerator index.");
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;

	SendClientMessage(playerid, COLOR_YELLOW, sprintf("Previous coordinates (/gotopos): x: %f, y: %f, z: %d, int: %d, world: %d",
		
		FuelStation [ idx ] [ E_FUEL_STATION_POS_X ],
		FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ],
		FuelStation [ idx ] [ E_FUEL_STATION_POS_Z ],
		FuelStation [ idx ] [ E_FUEL_STATION_POS_INT ],
		FuelStation [ idx ] [ E_FUEL_STATION_POS_VW ]
	));

	FuelStation [ idx ] [ E_FUEL_STATION_POS_X ] = x ;
	FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ] = y ;
	FuelStation [ idx ] [ E_FUEL_STATION_POS_Z ] = z ;
	FuelStation [ idx ] [ E_FUEL_STATION_POS_INT ] = GetPlayerInterior(playerid);
	FuelStation [ idx ] [ E_FUEL_STATION_POS_VW ] = GetPlayerVirtualWorld(playerid);

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), 
		"UPDATE fuelmanager SET fuelmanager_pos_x = '%f', fuelmanager_pos_y = '%f', fuelmanager_pos_z = '%f',\
		fuelmanager_pos_int = %d, fuelmanager_pos_vw = %d WHERE fuelmanager_id = %d", 
		sql_id 
	) ;

	mysql_tquery(mysql, query);

	SendClientMessage(playerid, COLOR_BLUE, "Fuel station has been moved to your coordinates. The old pumps are still attached." ) ;

	FuelStation_SetupVisuals(idx);
	Streamer_Update(playerid, STREAMER_TYPE_OBJECT ) ;

	return true ;
}


CMD:auctionstation(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/auctionstation [sql-id]");
	}

	new idx = FuelStation_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid station SQL ID supplied. Can't find linked enumerator index.");
	}

	FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] = INVALID_PLAYER_ID ;

	SendClientMessage(playerid, COLOR_RED, sprintf("You've auctioned station (sql id) %d. Player will get refunded next time they log in.", sql_id ));

	foreach(new targetid: Player) {

		if ( Character [ targetid ] [ E_CHARACTER_ID ] == FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] ) {

			SendClientMessage(targetid, COLOR_YELLOW, sprintf("WARNING: One of your fuel stations has been sold by an administrator!"));
			SendClientMessage(targetid, COLOR_RED, "If this was not intended, take a screenshot IMMEDIATELY. To get refunded, relog.");
			SendClientMessage(targetid, COLOR_GRAD0, "The system will automatically refund you a portion of the buy price when you next log in.");
			break ;
		}
	}
	new query [ 256 ] ;

	// Incrementing the original refund price, incase multiple stations get sold.
	Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] += FUEL_STATION_COST ;

	// Setting variable so player gets msg upon logging in & refund
	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_soldfuelstation = %d WHERE player_id = %d",

		Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ],
		FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ]
	);

	mysql_tquery(mysql, query );


	mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelmanager SET fuelmanager_owner = %d WHERE fuelmanager_id = %d", 
		FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ], sql_id 
	) ;

	mysql_tquery(mysql, query);

	return true ;
}

FuelStation_RefundPlayer(playerid) {

	if ( Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] ) {

		SendClientMessage(playerid, -1, " " ) ;
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("WARNING:{DEDEDE} One or more of your owned FUEL STATIONS was sold whilst you were offline. You have been refunded $%s.",
			IntegerWithDelimiter ( Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] ) ) ) ;
		SendClientMessage(playerid, COLOR_RED, "If you think this was a mistake, post a refund requests with the property ID. ");
		SendClientMessage(playerid, -1, " " ) ;
		
		GivePlayerCash ( playerid, Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] ) ;
		Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] = 0 ;

		new query [ 256 ] ;

		mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_soldfuelstation = 0 WHERE player_id = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, query);
	}

	return true ;
}

CMD:deletestation(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sql_id ;

	if ( sscanf ( params, "i", sql_id ) ) {

		return SendClientMessage(playerid, -1, "/deletestation [sql-id]");
	}

	new idx = FuelStation_LinkSQLIDToEnum(sql_id) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage(playerid, -1, "Invalid station SQL ID supplied. Can't find linked enumerator index.");
	}

	if ( FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] != INVALID_PLAYER_ID ) {
		return SendClientMessage(playerid, -1, "This station is owned by a player. Use /auctionstation first.");
	}


	if ( IsValidDynamicMapIcon ( FuelStation [ idx ] [ E_FUEL_STATION_MAPICON ] ) ) {
		DestroyDynamicMapIcon(FuelStation [ idx ] [ E_FUEL_STATION_MAPICON ]);
	}

	FuelStation [ idx ] [ E_FUEL_STATION_MAPICON ] = INVALID_STREAMER_ID ;

	if ( IsValidDynamicPickup ( FuelStation [ idx ] [ E_FUEL_STATION_PICKUP ] ) ) {
		DestroyDynamicPickup( FuelStation [ idx ] [ E_FUEL_STATION_PICKUP ] ) ;
	}

	FuelStation [ idx ] [ E_FUEL_STATION_PICKUP ] = INVALID_STREAMER_ID ;

	if ( IsValidDynamicArea( FuelStation [ idx ] [ E_FUEL_STATION_AREAID ] ) ) {

		DestroyDynamicArea( FuelStation [ idx ] [ E_FUEL_STATION_AREAID ] ) ;
	}

	FuelStation [ idx ] [ E_FUEL_STATION_AREAID ] = INVALID_STREAMER_ID ;
	FuelStation [ idx ] [ E_FUEL_STATION_ID ] = INVALID_FUEL_MANAGER_ID ;

	Iter_Remove(FuelStation, idx);

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ),  "DELETE FROM fuelmanager WHERE fuelmanager_id = %d", sql_id ) ;
	mysql_tquery(mysql, query);

	SendClientMessage(playerid, -1, sprintf("You've removed fuel station SQL ID %d", sql_id ) ) ;

	return true ;
}


CMD:stationinfo(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx = FuelStation_GetClosestEntity(playerid) ;

	if ( idx == INVALID_FUEL_MANAGER_ID ) {

		return SendClientMessage ( playerid, -1, "You're not near any station.");
	}

	SendClientMessage(playerid, COLOR_BLUE, sprintf("[Fuelstation information (sql id %d)]:", FuelStation [ idx ] [ E_FUEL_STATION_ID ] ));
	SendClientMessage(playerid, COLOR_GRAD0, sprintf("Pending Income{DEDEDE}: $%s", IntegerWithDelimiter(FuelStation [ idx ] [ E_FUEL_STATION_INCOME ])));
	SendClientMessage(playerid, COLOR_GRAD1, sprintf("Owned by (character ID){DEDEDE}: %d", FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] ));

	return true ;
}

CMD:myfuelstations(playerid, params[]) {
	SendClientMessage(playerid, COLOR_BLUE, "[List of owned fuel stations]:");


	new address [ 64 ], zone [ 64 ], area [ 64 ], city [ 64 ] ;

	foreach(new idx: FuelStation ) {

		if ( FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

			GetPlayerAddress(FuelStation [ idx ] [ E_FUEL_STATION_POS_X ] , FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ], address) ;
			GetCoords2DZone(FuelStation [ idx ] [ E_FUEL_STATION_POS_X ] , FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ], zone, sizeof ( zone ));
			GetPlayerAreaZone(FuelStation [ idx ] [ E_FUEL_STATION_POS_X ] , FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ], area ) ;
			GetCoords2DMainZone(FuelStation [ idx ] [ E_FUEL_STATION_POS_X ] , FuelStation [ idx ] [ E_FUEL_STATION_POS_Y ], city, sizeof ( city ) ) ;

			SendClientMessage(playerid, COLOR_BLUE, 
				sprintf("[SQL ID %d] [amount of pumps %d] [pending income: $%s] [Location: %s, %s, %s, %s]", 
					FuelStation [ idx ] [ E_FUEL_STATION_ID], 
					FuelStation_GetLinkedPumpCount(idx ), 
					IntegerWithDelimiter(FuelStation [ idx ] [ E_FUEL_STATION_INCOME ]),
					address, zone, area, city
				)
			);

		}

		else continue ;
	}
	// shows the location and how many pumps, pending income, ...

	return true ;
}