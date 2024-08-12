
CMD:respawnallcars(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	defer Vehicle_CarRespawnTick[15000]();
	SendClientMessageToAll(COLOR_INFO, "(( AdminMsg )) ALL unoccupied vehicles respawning in 15 seconds. Sit in driver seat to keep yours!");

	return true ;
}

timer Vehicle_CarRespawnTick[15000]() {

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {

		if ( ! IsValidVehicle(Vehicle [ i ] [ E_VEHICLE_ID ] ) ) {

			continue ;
		}

		if ( GetVehicleDriver ( Vehicle [ i ] [ E_VEHICLE_ID ] ) == INVALID_PLAYER_ID ) {


			//Vehicle_ClearTruckerVariables(i);

			if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_PLAYER ) {

				new Float: health ;
				GetVehicleHealth(Vehicle [ i ] [ E_VEHICLE_ID ], health ) ;

				Vehicle [ i ] [ E_VEHICLE_HEALTH ] = health ;
				new panels, doors, lights, tires;
				GetVehicleDamageStatus(Vehicle [ i ] [ E_VEHICLE_ID ], panels, doors, lights, tires);

				Vehicle [ i ] [ E_VEHICLE_DMG_PANELS ] 	= panels ;
				Vehicle [ i ] [ E_VEHICLE_DMG_DOORS ] 	= doors ;
				Vehicle [ i ] [ E_VEHICLE_DMG_LIGHTS ] 	= lights ;
				Vehicle [ i ] [ E_VEHICLE_DMG_TIRES ] 	= tires ;

				Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] = false ;
			 
				if ( IsValidVehicle( Vehicle [ i ] [ E_VEHICLE_ID ]  ) ) {

					SOLS_DestroyVehicle( Vehicle [ i ] [ E_VEHICLE_ID ] ) ;
				}

				Vehicle [ i ] [ E_VEHICLE_ID ] = -1 ;
			}

			else {

				SOLS_SetVehicleToRespawn ( Vehicle [ i ] [ E_VEHICLE_ID ], "respawnallcars" ) ; 
				Vehicle [ i ] [ E_VEHICLE_FUEL ] = 100 ;
			}
		}

		else continue ;

	}

	SendClientMessageToAll(COLOR_INFO, "(( AdminMsg )) All unoccupied vehicles respawned by an admin." ) ;
}

CMD:respawnrentals(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	defer Vehicle_RentalRespawnTick[15000]();

	SendClientMessageToAll(COLOR_INFO, "(( AdminMsg )) Public / Rentable vehicles respawning in 15 seconds. Sit in driver seat to keep yours!");

	return true ;
}

CMD:respawnjobcars(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	defer Vehicle_JobCarRespawnTick[15000]();

	SendClientMessageToAll(COLOR_INFO, "(( AdminMsg )) Job vehicles respawning in 15 seconds. Sit in driver seat to keep yours!");

	return true ;
}

timer Vehicle_JobCarRespawnTick[15000]() {

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {

		if ( ! IsValidVehicle(Vehicle [ i ] [ E_VEHICLE_ID ] ) ) {

			continue ;
		}

		if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_JOB ) {

			if ( GetVehicleDriver ( Vehicle [ i ] [ E_VEHICLE_ID ]  ) == INVALID_PLAYER_ID ) {

				Vehicle_ClearTruckerVariables(i);

				Vehicle [i] [ E_VEHICLE_OWNER ] = INVALID_PLAYER_ID ;
				SOLS_SetVehicleToRespawn ( Vehicle [ i ] [ E_VEHICLE_ID ], "respawnjobvehicles"  ) ; 

				Vehicle [ i ] [ E_VEHICLE_FUEL ] = 100 ;
			}

			else continue ;
		}

		else continue ;
	}

	SendClientMessageToAll(COLOR_INFO, "(( AdminMsg )) Job vehicles vehicles respawned by an admin." ) ;
}


timer Vehicle_RentalRespawnTick[15000]() {

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {

		if ( ! IsValidVehicle(Vehicle [ i ] [ E_VEHICLE_ID ] ) ) {

			continue ;
		}

		if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_RENTAL || Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_DMV ) {

			if ( GetVehicleDriver ( Vehicle [ i ] [ E_VEHICLE_ID ]  ) == INVALID_PLAYER_ID ) {

				Vehicle_ClearTruckerVariables(i);

				Vehicle [i] [ E_VEHICLE_OWNER ] = INVALID_PLAYER_ID ;
				SOLS_SetVehicleToRespawn ( Vehicle [ i ] [ E_VEHICLE_ID ], "respawnrentals"  ) ; 

				Vehicle [ i ] [ E_VEHICLE_FUEL ] = 100 ;
			}

			else continue ;
		}

		else continue ;
	}

	SendClientMessageToAll(COLOR_INFO, "(( AdminMsg )) Public / Rentable vehicles respawned by an admin." ) ;
}
