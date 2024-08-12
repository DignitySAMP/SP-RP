enum E_RPRF_DATA {

	E_RPRF_DESC [ 64 ],
	Float: E_RPRF_POS_X,
	Float: E_RPRF_POS_Y,
	Float: E_RPRF_POS_Z,
	E_RPRF_TYPE,
	E_RPRF_FACTION_TYPE,
	bool:E_RPRF_HIDDEN
} ;


enum { // RPRF_TYPES

	E_RPRF_TYPE_NONE = -1,
	E_RPRF_TYPE_DOCKWORKER = 1,
	E_RPRF_TYPE_AIRPORT,
	E_RPRF_TYPE_BOAT,
	E_RPRF_TYPE_FACTION,
} ;

new RPRF_Points [ ] [ E_RPRF_DATA ] = {

	{ "Dockworker", 	2754.1755,	-2453.8972,	13.2357, E_RPRF_TYPE_DOCKWORKER },
	{ "Police Garage",  1585.4764,  -1677.7506, 5.8970, E_RPRF_TYPE_FACTION, FACTION_TYPE_POLICE },
	{ "Sheriff Garage", 621.9651,-610.7361,17.2305, E_RPRF_TYPE_FACTION, FACTION_TYPE_POLICE, true },
	{ "Boat", 			738.1812,	-1500.9093,	1.0, E_RPRF_TYPE_BOAT },
	{ "Mexico", 		16146.9854,	-16078.6563, 1.9103, E_RPRF_TYPE_NONE },
	{ "LSX Helipad", 	1765.6055,-2282.6074,26.7960, 	E_RPRF_TYPE_AIRPORT },
	{ "LSX Aviation", 	2114.5063,-2427.4653,13.5469, 	E_RPRF_TYPE_AIRPORT },
	{ "Engine Bay",		1816.0443,-1431.0503,13.6016,	E_RPRF_TYPE_FACTION, FACTION_TYPE_EMS, true }
};

RPRF_LoadEntities() {

	for ( new i, j = sizeof ( RPRF_Points ); i < j ; i ++ ) 
	{
		if (RPRF_Points[i][E_RPRF_HIDDEN])
		{
			// Smaller draw distance
			CreateDynamicPickup(1370, 1,  RPRF_Points [ i ] [ E_RPRF_POS_X ], RPRF_Points [ i ] [ E_RPRF_POS_Y ], RPRF_Points [ i ] [ E_RPRF_POS_Z ], -1, -1, -1, 7.5);
			CreateDynamic3DTextLabel(sprintf("[%s]\n{DEDEDE}Available commands: /rprf", RPRF_Points[i][E_RPRF_DESC]), 
				COLOR_FACTION, RPRF_Points [ i ] [ E_RPRF_POS_X ], RPRF_Points [ i ] [ E_RPRF_POS_Y ], RPRF_Points [ i ] [ E_RPRF_POS_Z ], 7.5, .testlos = true);
		}
		else
		{
			CreateDynamicPickup(1370, 1,  RPRF_Points [ i ] [ E_RPRF_POS_X ], RPRF_Points [ i ] [ E_RPRF_POS_Y ], RPRF_Points [ i ] [ E_RPRF_POS_Z ], -1, -1, -1, 50.0);
			CreateDynamic3DTextLabel(sprintf("[%s]\n{DEDEDE}Available commands: /rprf", RPRF_Points[i][E_RPRF_DESC]), 
				COLOR_FACTION, RPRF_Points [ i ] [ E_RPRF_POS_X ], RPRF_Points [ i ] [ E_RPRF_POS_Y ], RPRF_Points [ i ] [ E_RPRF_POS_Z ], 10.0, .testlos = true);
		}
	}
}

CMD:rprf(playerid, params[]) {
	new near_rprf = -1 ;

	for ( new i, j = sizeof ( RPRF_Points ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, 15.0, RPRF_Points [ i ] [ E_RPRF_POS_X ], 
			RPRF_Points [ i ] [ E_RPRF_POS_Y ], RPRF_Points [ i ] [ E_RPRF_POS_Z ] ) ) {

			near_rprf = i ;
		}

		else continue ;
	}

	if ( near_rprf != -1) {

		new vehicleid = GetPlayerVehicleID(playerid) ;

		if ( ! IsPlayerInAnyVehicle(playerid) || ! vehicleid ) {
			return SendServerMessage(playerid, COLOR_ERROR, "Repair & Refuel", "DEDEDE", "You're not in a vehicle!" ) ;
		}

		if ( IsPlayerIncapacitated(playerid, false) ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
		}

		new type = RPRF_Points [ near_rprf ] [ E_RPRF_TYPE ] ;
		new ftype = RPRF_Points [ near_rprf ] [ E_RPRF_FACTION_TYPE ] ;

		if ( type != -1 ) 
		{
			switch ( type ) 
			{
				case E_RPRF_TYPE_BOAT: 
				{
					if ( ! IsABoat ( vehicleid ) ) 
					{
						return SendServerMessage(playerid, COLOR_ERROR, "Repair & Refuel", "DEDEDE", "You're not in the right vehicle type - only boats!" ) ;
					}
				}
				case E_RPRF_TYPE_DOCKWORKER: 
				{
					if ( GetVehicleModel ( vehicleid ) != 530 ) 
					{
						return SendServerMessage(playerid, COLOR_ERROR, "Repair & Refuel", "DEDEDE", "You're not in the right vehicle type - only dockworker vehicles!" ) ;
					}
				}
				case E_RPRF_TYPE_AIRPORT: 
				{
					if ( ! IsAircraft(vehicleid) )
					{
				    	return SendServerMessage ( playerid, COLOR_ERROR, "Repair & Refuel", "A3A3A3", "You're not in the right vehicle type - only aircraft!" ) ;
					}
				}
				case E_RPRF_TYPE_FACTION: 
				{
					if (!IsPlayerInFactionType(playerid, ftype)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in the correct faction type to use this.");
					if (!IsFactionTypeVehicle(vehicleid, ftype)) return SendServerMessage(playerid, COLOR_ERROR, "Repair & Refuel", "DEDEDE", "You can only repair faction vehicles here.");
				}
			}

			
			SOLS_RepairVehicle(vehicleid) ;

	        new query [ 128 ] ;

			new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;
	        Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100 ;

	        mysql_format(mysql, query, sizeof ( query), "UPDATE vehicles SET vehicle_fuel = %d WHERE vehicle_sqlid = %d",
	            Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] );

	        mysql_tquery(mysql, query);

			ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", "has repaired and refueled their vehicle.", .annonated=true);
		}
	}

	return true ;
}