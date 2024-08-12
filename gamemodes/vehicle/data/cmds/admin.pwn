

CMD:carcreate(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new model, type, owner ;

	if ( sscanf ( params, "iii", model, type, owner ) ) {

		SendClientMessage(playerid, -1, "/carcreate [model] [type] [owner]") ;

		//SendClientMessage(playerid, COLOR_YELLOW, "Set settings with /cartype and /carowner!!!!");
		SendClientMessage(playerid, 0x1871E8FF, "Types{DEDEDE}: [-1: Unusable by anyone] {A3A3A3}[0: Default (no lock, no engine, usable by anyone] {DEDEDE}[1: Rental]" ) ;
		SendClientMessage(playerid, 0xA3A3A3FF, "[3: Player (make sure to set owner as char id)]{A3A3A3} [4: Faction (set owner as faction id]" ) ;
		SendClientMessage(playerid, 0xE88F18FF, "Owner{DEDEDE}: Use '-1' if not applicable. Use faction id is type is faction, use CHARACTER ID if type is player." ) ;
		return true ;
	}

	

	new Float: x, Float: y, Float: z , Float: a ;
	GetPlayerPos(playerid, x, y, z ) ;
	GetPlayerFacingAngle(playerid, a);

	Vehicle_CreateEntity_Spawn ( playerid, model, type, owner, x, y, z, a, random(255),  random(255), false, E_VEHICLE_JOB_NONE ) ;

	SendClientMessage(playerid, COLOR_INFO, "Use /cartype to change type. Use /carowner to change owner. Use /carsavesiren to add/remove siren." ) ;
	SendClientMessage(playerid, COLOR_INFO, "Use /carjob to set the vehicle as a job car. Use /caradminpark to park it after everything." ) ;

	return true ;
}

CMD:cartype(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( ! IsPlayerInAnyVehicle(playerid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle for this to work.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	new type ;

	if ( sscanf ( params, "i", type ) ) {

		SendClientMessage(playerid, COLOR_RED, "/cartype [type]");
		SendClientMessage(playerid, 0x1871E8FF, "Types{DEDEDE}: [-1: Unusable by anyone] {A3A3A3}[0: Default (no lock, no engine, usable by anyone] {DEDEDE}[1: Rental]" ) ;
		SendClientMessage(playerid, 0xA3A3A3FF, "[2: DMV (deprecated)]{DEDEDE} [3: Player (make sure to set owner as char id)]{A3A3A3} [4: Faction (set owner as faction id]" ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, "[5: Job]{A3A3A3}{DEDEDE}" ) ;

		return true ;
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] = type ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_type = %d WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "[CAR/MAN] %s (%d) has set vehicle ID %d (a: %d)'s type to %d.", 
		Account [playerid][E_PLAYER_ACCOUNT_NAME], playerid,  Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ], veh_enum_id, type );
	SendAdminMessage ( query ) ;

	return true ;
}

CMD:carjob(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( ! IsPlayerInAnyVehicle(playerid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle for this to work.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	new type ;

	if ( sscanf ( params, "i", type ) ) {

		SendClientMessage(playerid, COLOR_RED, "/carjob [type] | WARNING: Will set type to job and owner to INVALID!");
		SendClientMessage(playerid, 0x1871E8FF, "Types{DEDEDE}: 0(none), 1(dockworker), 2(garbagejob)"  ) ;

		return true ;
	}

	if ( type < 0 || type > 2 ) {
		SendClientMessage(playerid, 0x1871E8FF, "Types{DEDEDE}: 0(none), 1(dockworker), 2(garbagejob)"  ) ;

		return true ;	
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] = E_VEHICLE_TYPE_JOB ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_JOBID ] = type ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_type = %d, vehicle_jobid = %d WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ], Vehicle [ veh_enum_id ] [ E_VEHICLE_JOBID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "[CAR/MAN] %s (%d) has set vehicle ID %d (a: %d)'s job to %d(type to %d).", 
		Account [playerid][E_PLAYER_ACCOUNT_NAME], playerid,  Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ], veh_enum_id, type, Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] );
	SendAdminMessage ( query ) ;

	return true ;
}

CMD:carowner(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( ! IsPlayerInAnyVehicle(playerid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle for this to work.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	new owner ;

	if ( sscanf ( params, "i", owner ) ) {

		SendClientMessage(playerid, COLOR_RED, "/carowner [owner]");
		SendClientMessage(playerid, 0xE88F18FF, "Owner{DEDEDE}: Use '-1' if not applicable. Use faction id is type is faction, use CHARACTER ID if type is player." ) ;

		return true ;
	}


	Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] = owner ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_owner = %d WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "[CAR/MAN] %s (%d) has set vehicle ID %d (a: %d)'s owner to %d.", 
		Account [playerid][E_PLAYER_ACCOUNT_NAME], playerid,  Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ], veh_enum_id, owner );
	SendAdminMessage ( query ) ;

	return true ;
}
CMD:carsavesiren(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( ! IsPlayerInAnyVehicle(playerid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle for this to work.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_FACTION ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only add sirens on faction vehicles!");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_SIREN ] ) {

		SendServerMessage ( playerid, COLOR_BLUE, "Siren", "A3A3A3", "You've removed a saved siren from this vehicle.");
		Vehicle [ veh_enum_id ] [ E_VEHICLE_SIREN ] = false ;
	}

	if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_SIREN ] ) {

		SendServerMessage ( playerid, COLOR_BLUE, "Siren", "A3A3A3", "You've added a saved siren to this vehicle.");
		Vehicle [ veh_enum_id ] [ E_VEHICLE_SIREN ] = true ;
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_siren = %d WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_SIREN ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) ;

	mysql_tquery(mysql, query);

	SOLS_DestroyVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = SOLS_CreateVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], 0, Vehicle [ veh_enum_id ] [ E_VEHICLE_SIREN ]) ;

	Temp_SetVehicleEnumId(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], veh_enum_id);
	SetVehicleNumberPlate(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_LICENSE ] ) ;

	return true ;
}

CMD:caradminpark(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	if ( ! IsPlayerInAnyVehicle(playerid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle for this to work.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}


	new Float: health ;
	GetVehicleHealth(vehicleid, health ) ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] = health ;
	
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ] 	= panels ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ] 	= doors ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ] 	= lights ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] 	= tires ;
	

	new Float: x, Float: y, Float: z, Float: a  ;

	GetVehiclePos(vehicleid, x, y, z );
	GetVehicleZAngle(vehicleid, a ) ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ] = x ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ] = y ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] = z ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ] = a ;

 	new ALARM_SLOT = 1 ;
	if ( IsObjectInVehicleSlot(vehicleid, ALARM_SLOT ) ) {
		RemoveObjectFromVehicleSlot ( vehicleid, ALARM_SLOT );
	}
	if ( IsValidVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]  ) ) {

		SOLS_DestroyVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = -1 ;

	new query [ 512 ] ; 

	mysql_format(mysql, query, sizeof ( query ), "UPDATE vehicles SET vehicle_dmg_panels = %d, vehicle_dmg_doors = %d, vehicle_dmg_lights = %d, vehicle_dmg_tires = %d, vehicle_health = '%f', vehicle_pos_x = '%f', vehicle_pos_y = '%f', vehicle_pos_z = '%f', vehicle_pos_a = '%f' WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ],
	
		Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] 
	) ;

	mysql_tquery ( mysql, query ) ;

	SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle", "A3A3A3", "You've changed the location of this vehicle to your current position.");

	Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = SOLS_CreateVehicle(	Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ],
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], -1
	) ;

	Temp_SetVehicleEnumId(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], veh_enum_id);

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] <= 250.0 ) {

		SOLS_SetVehicleHealth ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], 300 ); 
	}

	else SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] );

	SetVehicleNumberPlate(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_LICENSE ] ) ;

	SetEngineStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_ENGINE ]);
	SetDoorStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ]);

	ChangeVehiclePaintjob(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ] ) ;
	Tune_ApplyComponents(playerid, veh_enum_id );

	UpdateVehicleDamageStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] );


	Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] = true ;

	return true ;
}

CMD:caradmincolor(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new color_a, color_b ;

	if ( sscanf ( params, "ii", color_a, color_b ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/caradmincolor [color-a] [color-b] (/carcolorlist)");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	ChangeVehicleColorEx(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], color_a, color_b);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ] = color_a ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] = color_b ;

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_color_a = %d, vehicle_color_b = %d  WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]) ;

	mysql_tquery(mysql, query);


	format ( query, sizeof ( query ), "[CAR/MAN] %s (%d) has set vehicle ID %d (a: %d)'s color to A:%d B:%d", 
		Account [playerid][E_PLAYER_ACCOUNT_NAME], playerid,  Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ], veh_enum_id, color_a, color_b );
	SendAdminMessage ( query ) ;

	return true ;
}