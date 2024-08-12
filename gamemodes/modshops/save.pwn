#if !defined MODSHOP_FEE
    #define MODSHOP_FEE ( 25 )
#endif

enum E_COMPONENT_DATA {

    E_COMPONENT_SQL_ID,
    E_COMPONENT_VEH_SQL_ID,
    E_COMPONENT_ID,
} ;

#define MAX_COMPONENTS  10 * MAX_VEHICLES
new VehicleComponent [ MAX_COMPONENTS ] [ E_COMPONENT_DATA ] ;

Tune_GetFreeID () {

    for ( new i, j = sizeof ( VehicleComponent ); i < j ; i ++ ) {

        if ( VehicleComponent [ i ] [ E_COMPONENT_SQL_ID ] == -1 ) {

            return i ;
        }

        else continue ;
    }

    return -1 ;
}

Tune_AddVehicleComponent(playerid, vehicleid, componentid) {

    AddVehicleComponent(vehicleid, componentid) ;

    // sideskirts and vents that have left and right side should be applied twice
    switch (componentid) {// https://github.com/Konstantinos-Sk/tune-system/blob/master/MySQL/R40/tune_system.pwn#L123
    
        case 1007, 1027, 1030, 1039, 1040, 1051, 1052, 1062, 1063, 1071, 1072, 1094, 1099, 1101, 1102, 1107, 1120, 1121, 1124, 1137, 1142 .. 1145: {
            AddVehicleComponent(vehicleid, componentid);
        }
    }

    new index = DoesPlayerHaveComponentID ( playerid, vehicleid, componentid ), 
        veh_enum_id = Vehicle_GetEnumID ( vehicleid ) ; 

    if (  veh_enum_id == -1 ) {

        SendClientMessage(playerid, COLOR_ERROR, "Failed to fetch vehicle DB ID. Your modifications aren't saved. Send this to a developer.");
        SendClientMessage(playerid, 0xDEDEDEFF, "Take a picture of your applied modifications to get a refund.");

        return true ;
    }

    new query [ 512 ] ;

    // Does player already have a component of the same type installed?
    if ( index != -1 ) {

        VehicleComponent [ index ] [ E_COMPONENT_ID ] = componentid; 

        mysql_format(mysql, query, sizeof ( query ), "UPDATE vehicle_saved_mods SET vehicle_component_id = %d WHERE vehicle_saved_id = %d",

           VehicleComponent [ index ] [ E_COMPONENT_ID ], VehicleComponent [ index ] [ E_COMPONENT_SQL_ID ] ) ;

        mysql_tquery(mysql, query );

        SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle Components", "A3A3A3", "You already had a modification of this type applied. It has been replaced.");

        return true ;
    }

    // They don't have a similar component installed yet. Let's store a new one:
    else if ( index == -1 ) {

        new comp_enum_id = Tune_GetFreeID ();

        if ( comp_enum_id == -1 ) {
            SendClientMessage(playerid, COLOR_ERROR, "Failed to store component ID in the database (error -1), are all component slots filled?");
            SendClientMessage(playerid, 0xDEDEDEFF, "Send this error to a developer.");

            return true ;
        }

        VehicleComponent [ comp_enum_id ] [ E_COMPONENT_VEH_SQL_ID ] = Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ;
        VehicleComponent [ comp_enum_id ] [ E_COMPONENT_ID ] = componentid ;

        mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO vehicle_saved_mods (vehicle_sql_id, vehicle_component_id) VALUES (%d, %d)",
            VehicleComponent [ comp_enum_id ] [ E_COMPONENT_VEH_SQL_ID ], VehicleComponent [ comp_enum_id ] [ E_COMPONENT_ID ] );

        inline VehMods_OnDatabaseInsert() {

            VehicleComponent [ comp_enum_id ] [ E_COMPONENT_SQL_ID ] = cache_insert_id ();
            printf(" * [VEHICLE MOD] Stored vehicle component ID %d (model %d) for vehicle ID %d.", 
                VehicleComponent [ comp_enum_id ] [ E_COMPONENT_SQL_ID ], VehicleComponent [ comp_enum_id ] [ E_COMPONENT_ID ], 
                VehicleComponent [ comp_enum_id ] [ E_COMPONENT_VEH_SQL_ID ]) ;
        }

        MySQL_TQueryInline(mysql, using inline VehMods_OnDatabaseInsert, query, "");
    }

    return true ;
}


Tune_ApplyComponents(playerid, vehicle_enum_id ) {
    SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle Components", "A3A3A3", "Your vehicle's components have been loaded.");

    for ( new i, j = sizeof ( VehicleComponent ); i < j ; i ++ ) {

        if ( VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ] == Vehicle [ vehicle_enum_id ] [ E_VEHICLE_SQLID ] ) {

            AddVehicleComponent(Vehicle [ vehicle_enum_id ] [ E_VEHICLE_ID], VehicleComponent [ i ] [ E_COMPONENT_ID ] ) ;
        }
    } 

    return true ;
}

Tune_LoadEntities() {

    for ( new i, j = sizeof ( VehicleComponent ); i < j ; i ++ ) {

        VehicleComponent [ i ] [ E_COMPONENT_SQL_ID ] = -1 ;
    }

    print(" * [COMPONENTS] Loading all vehicle components...");

    inline VehicleMod_OnDataLoad() {
        for (new i = 0, r = cache_num_rows(); i < r; ++i) {
            cache_get_value_name_int(i, "vehicle_saved_id", VehicleComponent [ i ] [ E_COMPONENT_SQL_ID ]);
            cache_get_value_name_int(i, "vehicle_sql_id", VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ]);
            cache_get_value_name_int(i, "vehicle_component_id", VehicleComponent [ i ] [ E_COMPONENT_ID ]);
        }

        printf(" * [COMPONENTS] Loaded %d vehicle components.", cache_num_rows());
    }

    MySQL_TQueryInline(mysql, using inline VehicleMod_OnDataLoad, "SELECT * FROM vehicle_saved_mods", "" ) ;

    return true ;
}

DoesPlayerHaveComponentID(playerid, vehicleid, newcomponentid ) {

	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Failed to fetch vehicle enum ID. Component saving cancelled.");
	}

	for ( new i, j = MAX_COMPONENTS; i < j ; i ++ ) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] == VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ] ) {


            if (SOLS_GetComponentType( VehicleComponent [ i ] [ E_COMPONENT_ID ] ) == SOLS_GetComponentType( newcomponentid ) ) {
            //if (! strcmp(Tune_GetComponentPart ( VehicleComponent [ i ] [ E_COMPONENT_ID ] ), Tune_GetComponentPart ( newcomponentid ), true ) ) {
				// Player's vehicle already has this part installed... let's overwrite it.

				// We make it return the enum ID so we can
				// access the SQL ID and replace the enum ID.
				return i ;
			}

			else continue ;
		}

		else continue ;
	}

	return -1 ;
}

CMD:removemods(playerid, params[]) {

 	new vehicleid = GetPlayerVehicleID(playerid);
    new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

    if ( veh_enum_id == -1 ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The vehicle you're in is invalid. (returned -1)"); 
    }

    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) 
    {
        if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

            return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
        }
    }

    for ( new i, j = MAX_COMPONENTS; i < j ; i ++ ) {

    	if ( VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ] == Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ) {
    		VehicleComponent [ i ] [ E_COMPONENT_SQL_ID ] = -1 ;
    		VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ] = INVALID_VEHICLE_ID ;
    	}

    	else continue ;
    }
    new query [ 256 ] ;
    mysql_format(mysql, query, sizeof(query), "DELETE FROM vehicle_saved_mods WHERE vehicle_sql_id = %d", Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]);
    mysql_tquery(mysql, query);

    new Float: x, Float: y, Float:z, Float: a ;
    GetPlayerPos(playerid, x, y, z) ;
	GetPlayerFacingAngle(playerid, a);

    new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ] 	= panels ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ] 	= doors ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ] 	= lights ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] 	= tires ;

	SOLS_DestroyVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
 
	Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = SOLS_CreateVehicle(	Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID], 
		x, y, z, a, Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], -1
	) ;

    Temp_SetVehicleEnumId(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], veh_enum_id);

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] <= 250.0 ) {

		SOLS_SetVehicleHealth ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], 300 ); 
	}

	else SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] );

	SetVehicleNumberPlate(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_LICENSE ] ) ;

	SetEngineStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_ENGINE ]);
	SetDoorStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ]);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] = true ;
	ChangeVehiclePaintjob(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ] ) ;

	UpdateVehicleDamageStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] );

	JT_PutPlayerInVehicle(playerid, Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], 0);

    return true ;
}

