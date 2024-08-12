enum {

	E_FUEL_TYPE_NONE = 0,
	E_FUEL_TYPE_RON,
	E_FUEL_TYPE_TERROIL,
	E_FUEL_TYPE_GLOBEOIL
} ;

enum {
	E_FUEL_NOZZLE_AMOUNT_LOW, // 50%
	E_FUEL_NOZZLE_AMOUNT_MED, // 75%
	E_FUEL_NOZZLE_AMOUNT_HIGH // 100%
} ;

enum {
	E_FUEL_PUMP_MODEL_NONE,
	E_FUEL_PUMP_MODEL_RON,
	E_FUEL_PUMP_MODEL_TERROIL,
	E_FUEL_PUMP_MODEL_GLOBEOIL,

}


enum E_FUEL_PUMP_DATA {
	E_FUEL_PUMP_ID,
	E_FUEL_PUMP_TYPE,
//	#warning Make it so vehicle models are split in 3 categories that can each use one of these areas. When they use /fuel (or acronyms) GPS sends them to nearest tank.

	E_FUEL_PUMP_MANAGER_ID, // E_FUEL_MANAGER_STATION


	Float: E_FUEL_PUMP_RADIUS, // for area
	Float: E_FUEL_PUMP_POS_X,
	Float: E_FUEL_PUMP_POS_Y,
	Float: E_FUEL_PUMP_POS_Z,

	Float: E_FUEL_PUMP_POS_RX,
	Float: E_FUEL_PUMP_POS_RY,
	Float: E_FUEL_PUMP_POS_RZ,

	E_FUEL_PUMP_POS_INT,
	E_FUEL_PUMP_POS_VW,

	E_FUEL_PUMP_OBJECTID,
	E_FUEL_PUMP_AREAID
} ;

#if !defined MAX_FUEL_STATIONS
	#define MAX_FUEL_STATIONS	64
#endif

#if !defined INVALID_FUEL_STATION_ID
#define INVALID_FUEL_STATION_ID -1
#endif

new FuelPump [ MAX_FUEL_STATIONS ] [ E_FUEL_PUMP_DATA ] ;
new Iterator:FuelPump<MAX_FUEL_STATIONS>;

FuelPump_LoadEntities() {

	for ( new i, j = sizeof ( FuelPump ); i < j ; i ++ ) {
		FuelPump [ i ] [ E_FUEL_PUMP_ID ] = INVALID_FUEL_STATION_ID ;
		FuelPump [ i ] [ E_FUEL_PUMP_OBJECTID ] = INVALID_OBJECT_ID ;	
		FuelPump [i] [ E_FUEL_PUMP_MANAGER_ID ] = INVALID_FUEL_MANAGER_ID ;

	}


	print(" * [FUEL STATION] Loading all FuelPump...");

	inline FuelStation_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) { 
			cache_get_value_name_int(i, "fuelstation_id", FuelPump [ i ] [ E_FUEL_PUMP_ID ]);
			cache_get_value_name_int(i, "fuelstation_type", FuelPump [ i ] [ E_FUEL_PUMP_TYPE ]);

			cache_get_value_name_int(i, "fuelstation_manager_id", FuelPump [ i ] [ E_FUEL_PUMP_MANAGER_ID ]);

			cache_get_value_name_float(i, "fuelstation_radius", FuelPump [ i ] [ E_FUEL_PUMP_RADIUS  ]);
			cache_get_value_name_float(i, "fuelstation_pos_x", FuelPump [ i ] [ E_FUEL_PUMP_POS_X ]);
			cache_get_value_name_float(i, "fuelstation_pos_y", FuelPump [ i ] [ E_FUEL_PUMP_POS_Y ]);
			cache_get_value_name_float(i, "fuelstation_pos_z", FuelPump [ i ] [ E_FUEL_PUMP_POS_Z ]);

			cache_get_value_name_float(i, "fuelstation_pos_rx", FuelPump [ i ] [ E_FUEL_PUMP_POS_RX ]);
			cache_get_value_name_float(i, "fuelstation_pos_ry", FuelPump [ i ] [ E_FUEL_PUMP_POS_RY ]);
			cache_get_value_name_float(i, "fuelstation_pos_rz", FuelPump [ i ] [ E_FUEL_PUMP_POS_RZ ]);

			cache_get_value_name_int(i, "fuelstation_pos_int", FuelPump [ i ] [ E_FUEL_PUMP_POS_INT ]);
			cache_get_value_name_int(i, "fuelstation_pos_vw", FuelPump [ i ] [ E_FUEL_PUMP_POS_VW ]);

			Fuel_SetupVisuals(i);
			Iter_Add(FuelPump, i);
		}

		printf(" * [FUEL STATION] Loaded %d fuel stations.", cache_num_rows());
	}

	MySQL_TQueryInline(mysql, using inline FuelStation_OnDataLoad, "SELECT * FROM fuelstation", "" ) ;

	return true ;
}

Fuel_OnCreateStation(type, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz, int, vw, Float: radius=5.0) {

	new index = Iter_Free(FuelPump) ;

	FuelPump [ index ] [ E_FUEL_PUMP_TYPE ] = type ;

	FuelPump [ index ] [ E_FUEL_PUMP_MANAGER_ID ] = -1 ;
	
	FuelPump [ index ] [ E_FUEL_PUMP_RADIUS ] = radius ;

	FuelPump [ index ] [ E_FUEL_PUMP_POS_X ] = x ;
	FuelPump [ index ] [ E_FUEL_PUMP_POS_Y ] = y ;
	FuelPump [ index ] [ E_FUEL_PUMP_POS_Z ] = z ;

	FuelPump [ index ] [ E_FUEL_PUMP_POS_RX ] = rx ;
	FuelPump [ index ] [ E_FUEL_PUMP_POS_RY ] = ry ;
	FuelPump [ index ] [ E_FUEL_PUMP_POS_RZ ] = rz ;


	FuelPump [ index ] [ E_FUEL_PUMP_POS_VW ] = vw ;
	FuelPump [ index ] [ E_FUEL_PUMP_POS_INT ] = int ;


	new query [ 1024 ] ;
	mysql_format(mysql, query, sizeof ( query ), 
		"INSERT INTO fuelstation (fuelstation_type, fuelstation_manager_id,\
		fuelstation_radius, fuelstation_pos_x, fuelstation_pos_y, fuelstation_pos_z, fuelstation_pos_rx,\
		fuelstation_pos_ry, fuelstation_pos_rz, fuelstation_pos_int, fuelstation_pos_vw) VALUES \
		(%d, %d, '%f', '%f', '%f', '%f', '%f', '%f', '%f', %d, %d)",

		FuelPump [ index ] [ E_FUEL_PUMP_TYPE ], FuelPump [ index ] [ E_FUEL_PUMP_MANAGER_ID ],
		FuelPump [ index ] [ E_FUEL_PUMP_RADIUS ], FuelPump [ index ] [ E_FUEL_PUMP_POS_X ] , FuelPump [ index ] [ E_FUEL_PUMP_POS_Y ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_Z ] , FuelPump [ index ] [ E_FUEL_PUMP_POS_RX ], FuelPump [ index ] [ E_FUEL_PUMP_POS_RY ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_RZ ], FuelPump [ index ] [ E_FUEL_PUMP_POS_VW ], FuelPump [ index ] [ E_FUEL_PUMP_POS_INT ]
	) ;

	inline FuelStation_OnDBInsert() {

		FuelPump [ index ] [ E_FUEL_PUMP_ID ] = cache_insert_id ();
		printf(" * [Fuel Station] Created fuelstation (%d) with ID %d.", 
			index, FuelPump [ index ] [ E_FUEL_PUMP_ID ] ) ;

		
		Fuel_SetupVisuals(index) ;
		Iter_Add(FuelPump, index);
	}

	MySQL_TQueryInline(mysql, using inline FuelStation_OnDBInsert, query, "");
}

Fuel_SetupVisuals(index) {

	if ( IsValidDynamicObject ( FuelPump [ index ] [ E_FUEL_PUMP_OBJECTID ] ) ) {

		DestroyDynamicObject ( FuelPump [ index ] [ E_FUEL_PUMP_OBJECTID ] ) ;
	}

	FuelPump [ index ] [ E_FUEL_PUMP_OBJECTID ] = CreateDynamicObject ( Fuel_GetModel ( FuelPump [ index ] [ E_FUEL_PUMP_TYPE ] ), 

		FuelPump [ index ] [ E_FUEL_PUMP_POS_X ], FuelPump [ index ] [ E_FUEL_PUMP_POS_Y ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_Z ], FuelPump [ index ] [ E_FUEL_PUMP_POS_RX ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_RY ], FuelPump [ index ] [ E_FUEL_PUMP_POS_RZ ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_VW ], FuelPump [ index ] [ E_FUEL_PUMP_POS_INT ]
	);

	if ( IsValidDynamicArea ( FuelPump [ index ] [ E_FUEL_PUMP_AREAID ] ) ) {

		DestroyDynamicArea( FuelPump [ index ] [ E_FUEL_PUMP_AREAID ] ) ;
	}

	FuelPump [ index ] [ E_FUEL_PUMP_AREAID ] = CreateDynamicCircle(FuelPump [ index ] [ E_FUEL_PUMP_POS_X ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_Y ], FuelPump [ index ] [ E_FUEL_PUMP_RADIUS ], 
		FuelPump [ index ] [ E_FUEL_PUMP_POS_VW ], FuelPump [ index ] [ E_FUEL_PUMP_POS_INT ]
	);
}

Fuel_GetModel(constant) {

	new modelid = FUELSYS_PUMP_1;
	switch ( constant ) {
		case E_FUEL_TYPE_RON:			modelid = FUELSYS_PUMP_2 ;	
		case E_FUEL_TYPE_TERROIL:		modelid = FUELSYS_PUMP_4 ;		
		case E_FUEL_TYPE_GLOBEOIL:		modelid = FUELSYS_PUMP_3 ;	
	}

	return modelid ;
}

Fuel_GetDescription(constant, name[], len=sizeof(name)) {

	switch ( constant ) {
		case E_FUEL_TYPE_NONE:		format ( name, len, "Invalid");
		case E_FUEL_TYPE_RON: {
			switch ( random ( 5 ) ) {

				case 0: 	format ( name, len, "Ron Petroleum~n~~w~Until The Last Drop");
				case 1: 	format ( name, len, "Ron Petroleum~n~~w~Giving You Both Barrels");
				case 2: 	format ( name, len, "Ron Petroleum~n~~w~Don't Pump And Run");
				case 3: 	format ( name, len, "Ron Petroleum~n~~w~Put RON in your tank");
				case 4: 	format ( name, len, "Ron Petroleum~n~~w~Refining Our Nation");
				default:  	format ( name, len, "Ron Petroleum");
			}
		}
		case E_FUEL_TYPE_TERROIL: {
			switch ( random ( 5 ) ) {

				case 0:		format ( name, len, "Terr-oil Gasoline~n~~w~Striking for America");
				case 1:		format ( name, len, "Terr-oil Gasoline~n~~w~Original & Best");
				case 2:		format ( name, len, "Terr-oil Gasoline~n~~w~Global Warming Is Baloney");
				case 3:		format ( name, len, "Terr-oil Gasoline~n~~w~Waging War On Prices");
				case 4:		format ( name, len, "Terr-oil Gasoline~n~~w~Support America - Use Foreign Oil");
				default: format ( name, len, "Terroil Gasoline");
			}
		}
		case E_FUEL_TYPE_GLOBEOIL: {
			switch ( random ( 3 ) ) {

				case 0: 	format ( name, len, "Globeoil Solutions~n~~w~Global Heating And Oil Solutions");
				case 1: 	format ( name, len, "Globeoil Solutions~n~~w~Changing the Climate");
				case 2: 	format ( name, len, "Globeoil Solutions~n~~w~Powering The Future");
				default: format ( name, len, "Globeoil Solutions");
			}
		}
	}
}


Fuel_GetName(constant, name[], len=sizeof(name)) {

	switch ( constant ) {
		case E_FUEL_TYPE_NONE:		format ( name, len, "Invalid");
		case E_FUEL_TYPE_RON: 		format ( name, len, "Ron Petroleum");
		case E_FUEL_TYPE_TERROIL: 	format ( name, len, "Terroil Gasoline");
		case E_FUEL_TYPE_GLOBEOIL: 	format ( name, len, "Globeoil Solutions");
	}
}

Fuel_GetHexColor(constant) {

	new color ;
	switch ( constant ) {
		case E_FUEL_TYPE_NONE:		color = 0xDEDEDEFF ;
		case E_FUEL_TYPE_RON:		color = 0xFF7500FF ;
		case E_FUEL_TYPE_TERROIL:	color = 0x88BB6FFF ;
		case E_FUEL_TYPE_GLOBEOIL:	color = 0xA51414FF ;
	}
	return color ;
}


Fuel_GetFuelPrice(constant, stage) {
	new amount ;

	switch ( stage ) {
		case E_FUEL_NOZZLE_AMOUNT_LOW: {
			switch ( constant ) {

				case E_FUEL_TYPE_NONE: 					amount = 0 ;
				case E_FUEL_TYPE_RON: 					amount = 50 ;
				case E_FUEL_TYPE_TERROIL: 				amount = 100 ;
				case E_FUEL_TYPE_GLOBEOIL: 				amount = 150 ;
			}
		}
		case E_FUEL_NOZZLE_AMOUNT_MED: {
			switch ( constant ) {

				case E_FUEL_TYPE_NONE: 					amount = 0 ;
				case E_FUEL_TYPE_RON: 					amount = 100 ;
				case E_FUEL_TYPE_TERROIL: 				amount = 150 ;
				case E_FUEL_TYPE_GLOBEOIL: 				amount = 200 ;
			}
		}
		case E_FUEL_NOZZLE_AMOUNT_HIGH: {
			switch ( constant ) {

				case E_FUEL_TYPE_NONE: 					amount = 0 ;
				case E_FUEL_TYPE_RON: 					amount = 150 ;
				case E_FUEL_TYPE_TERROIL: 				amount = 200 ;
				case E_FUEL_TYPE_GLOBEOIL: 				amount = 250 ;
			}
		}
	}

	return amount ;
}

Fuel_GetNearestPump(playerid, Float: range=5.0) {

	new Float: dis = 99999.99, Float: dis2, index = -1 ;

	foreach(new x: FuelPump) {

		if ( FuelPump [ x ] [ E_FUEL_PUMP_ID ] != INVALID_FUEL_STATION_ID ) {

			dis2 = GetPlayerDistanceFromPoint(playerid, 
				FuelPump [ x ] [ E_FUEL_PUMP_POS_X ], 
				FuelPump [ x ] [ E_FUEL_PUMP_POS_Y ], 
				FuelPump [ x ] [ E_FUEL_PUMP_POS_Z ]
			);

			if(dis2 < dis && GetPlayerInterior ( playerid ) == FuelPump [ x ] [ E_FUEL_PUMP_POS_INT ]
				&& GetPlayerVirtualWorld ( playerid ) == FuelPump [ x ] [ E_FUEL_PUMP_POS_VW ] ) {

	            dis = dis2;
	            index = x;
			}
		}
	}

	if ( dis <= range ) {

		return index;
	}

	return -1 ;
}


FuelStation_GetLinkedPumpCount(index) {
	new count = 0 ;

	foreach(new fuelid: FuelPump) {

		if ( FuelPump [ fuelid ] [ E_FUEL_PUMP_MANAGER_ID ] == FuelStation [ index ] [ E_FUEL_STATION_ID ] ) {

			count ++ ;
		}

		else continue ;
	}

	return count ;
}

FuelPump_LinkSQLIDToEnum(sql_id) {

	foreach(new fuelid: FuelPump) {

		if ( FuelPump [ fuelid ] [ E_FUEL_PUMP_ID ] == sql_id ) {
			return fuelid ;
		}

		else continue ;
	}

	return INVALID_FUEL_STATION_ID ;
}