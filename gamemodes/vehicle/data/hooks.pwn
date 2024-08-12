 
SOLS_SetVehicleToRespawn(vehicleid, const reason[32], nokick=false) {

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
	new Float:x, Float:y, Float:z;

	Vehicle_ClearTruckerVariables(veh_enum_id);
	Vehicle_ClearRuntimeVariables(veh_enum_id);
	Gunrack_Reset(vehicleid);
	Scanner_Reset(vehicleid);

	if (VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT] && IsValidDynamicObject(VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT]))
	{
		DestroyDynamicObject(VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT]);
		VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT] = 0;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] == vehicleid ) 
	{
		Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] = true;
		SetAllVehicleDoorsOpen(vehicleid, VEHICLE_PARAMS_OFF, veh_enum_id);
		
		SetVehicleZAngle(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ]);

		if (!nokick)
		{
			foreach ( new i : Player ) 
			{
				if (GetPlayerVehicleID(i) == vehicleid)
				{
					// Kick occupants out before respawning the car
					GetPlayerPos(i, x, y, z);
					PauseAC(i, 3);
					SetPlayerPos(i, x, y, z);
					JT_RemovePlayerFromVehicle(i);
				}
			}
		}

		SetVehiclePos (vehicleid, 
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ],
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ],
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ]
		);

		SOLS_RepairVehicle(vehicleid);
		SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
		SetVehicleParamsCarWindows(vehicleid, 1, 1, 1, 1);
		SetVehicleParamsCarDoors(vehicleid, 0, 0, 0, 0);

		SetVehicleZAngle(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ]);

		if(IsObjectInVehicleSlot(vehicleid, 1))
			RemoveObjectFromVehicleSlot(vehicleid, 1);

		new factiontype = GetVehicleFactionType(vehicleid);
		new model = GetVehicleModel(vehicleid);
		if (factiontype == 0 && model == 596 || model == 598 || model == 490) // FACTION_TYPE_POLICE
		{
			// Setting police cars to spawn with front 2 windows down
			SetVehicleParamsCarWindows(vehicleid, 0, 0, 1, 1);
			Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] = false;

			// And trying to stop tunes...
			// nvm...

			/*
			for ( new i, j = MAX_COMPONENTS; i < j ; i ++ ) 
			{
				if ( VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ] == Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ) {
					VehicleComponent [ i ] [ E_COMPONENT_SQL_ID ] = -1 ;
					VehicleComponent [ i ] [ E_COMPONENT_VEH_SQL_ID ] = INVALID_VEHICLE_ID ;
				}

				else continue ;
			}
			*/
		}
	}

	SOLS_ResetVehicleSirens(vehicleid);
	if (strlen(reason) > 1) printf("[vrespawn] vehicle %d was respawned, reason: %s", vehicleid, reason); // to track random respawns
}


SOLS_DestroyVehicle(vehicleid) {

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id != -1 ) {

		Vehicle_ClearTruckerVariables(veh_enum_id);

		if ( IsValidDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] )) {

			DestroyDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
		}
	}

	Temp_ReleaseVehicleEnumId(vehicleid);

//	TotalCarsSpawned -- ;

	SOLS_ResetVehicleSirens(vehicleid);
	return DestroyVehicle(vehicleid);
}