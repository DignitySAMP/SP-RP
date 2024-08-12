#define COLOR_IMPOUND	0x1F85DEFF
#define IMPOUND_FEE 2500

Impound_LoadEntities() {

	// carunimpound_point 1089.1823,	-1740.5542,	13.5054
	// NEW: edited carimpound point: 1070.2982,-1762.1105,13.3904
	// (in the general middle of the lot + bigger range)
	CreateDynamicMapIcon(1070.2982,-1762.1105,13.3904, 37, 0xFFFFFFFF);
	CreateDynamicPickup(1247, 1, 1070.2982,-1762.1105,13.3904);
	CreateDynamic3DTextLabel(sprintf("[Car Impound Lot]{DEDEDE}\nAvailable Commands: /impound, /unimpound\n(Unimpound costs $%s)", IntegerWithDelimiter(IMPOUND_FEE)), COLOR_IMPOUND, 1070.2982,-1762.1105,13.3904, 10.0 );

}

CMD:unimpound(playerid, params[]) {

	if ( !IsPlayerInRangeOfPoint(playerid, 30.0, 1070.2982,-1762.1105,13.3904 ) ) {
		return SendServerMessage ( playerid, COLOR_IMPOUND, "Impound", "A3A3A3", "You must be at the unimpound point! Check for a \"?\" on your minimap." ) ;
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	if ( GetPlayerCash ( playerid ) < IMPOUND_FEE) {

		return SendServerMessage ( playerid, COLOR_IMPOUND, "Impound", "A3A3A3", sprintf("You need at least $%s in order to unimpound your car.", IntegerWithDelimiter(IMPOUND_FEE))) ;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_PLAYER ) {
		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
		}
	}

	if(!Vehicle[veh_enum_id][E_VEHICLE_IMPOUNDED])
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle isn't impounded!");

	TakePlayerCash ( playerid, IMPOUND_FEE ) ;

	Faction_AddBankMoneyPerType(0, IMPOUND_FEE);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ] = 1154.5194 ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ] = -1726.2858 ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] = 13.8784 ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ] = 189.2765 ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_IMPOUNDED] = 0;

	SetVehiclePos(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ]);
	SetVehicleZAngle(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ]);

	SendClientMessage(playerid, COLOR_YELLOW, "You retrieved your vehicle from the lot. Make sure to repark it as soon as possible." ) ;

	new query [ 256 ] ; 

	mysql_format(mysql, query, sizeof ( query ), "UPDATE vehicles SET vehicle_pos_x = '%f', vehicle_pos_y = '%f', vehicle_pos_z = '%f', vehicle_pos_a = '%f', vehicle_impounded = '%d' WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], 
		Vehicle [veh_enum_id] [E_VEHICLE_IMPOUNDED], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] 
	) ;

	mysql_tquery(mysql, query);

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Used /unimpound on a %s (SQL ID: %d)", ReturnVehicleName(vehicleid), Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));

	return true ;
}

CMD:impound(playerid, params[]) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if ( Faction_GetTypeByID(faction_enum_id) != 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a police faction.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_PLAYER ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You can only impound player owned vehicles!");
	}

	if ( !IsPlayerInRangeOfPoint(playerid, 30.0, 1089.1823,	-1740.5542,	13.5054 ) ) {
		return SendClientMessage(playerid, COLOR_ERROR, "You can only do this at the impound lot.");
	}

	new Float: x, Float: y, Float: z, Float: a  ;

	GetVehiclePos(vehicleid, x, y, z );
	GetVehicleZAngle(vehicleid, a ) ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ] = x ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ] = y ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] = z ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ] = a ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_IMPOUNDED] = 1;

	SetDoorStatus ( vehicleid, true );
	SetEngineStatus(vehicleid, false);

	JT_RemovePlayerFromVehicle(playerid);

	new query [ 256 ] ; 

	mysql_format(mysql, query, sizeof ( query ), "UPDATE vehicles SET vehicle_pos_x = '%f', vehicle_pos_y = '%f', vehicle_pos_z = '%f', vehicle_pos_a = '%f', vehicle_impounded = '%d' WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], 
		Vehicle [veh_enum_id] [E_VEHICLE_IMPOUNDED], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] 
	) ;

	mysql_tquery(mysql, query);

	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Used /impound on a %s (SQL ID: %d)", ReturnVehicleName(vehicleid), Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));

	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has impounded a (%d) %s. }",

		Faction_GetAbbreviationByID(faction_enum_id) , 
		playerid, ReturnMixedName ( playerid ), 
		vehicleid, ReturnVehicleName ( vehicleid )
	), faction_enum_id, false ) ;

	SendClientMessage(playerid, COLOR_YELLOW, "You've impounded the vehicle. Turned off the engine and locked it for safety. Good work officer." ) ;

	foreach(new targetid: Player) {

		if ( IsPlayerConnected(targetid) && IsPlayerSpawned ( targetid ) ) {

			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ targetid ] [ E_CHARACTER_ID ] ) {

				SendClientMessage(targetid, COLOR_YELLOW, "Your vehicle has been impounded. To retrieve it, spawn it and do /carfind.");
				SendClientMessage(targetid, COLOR_YELLOW, "Enter the premises, enter your car and make your way to the icon and do /unimpound.");
				SendClientMessage(targetid, COLOR_YELLOW, "Once you are outside the lot, /cardespawn your car at your desired spawn location." ) ;
			}

			else continue ;
		}
	}

	return true ;
}
