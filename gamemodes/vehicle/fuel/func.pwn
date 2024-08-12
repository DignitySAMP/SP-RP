
// This is a tick that's ongoing (see player hooks).
OnPlayerRefuelCar(playerid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] ) {
		if ( IsPlayerInAnyVehicle ( playerid ) && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) {
			new fuelid = Fuel_GetNearestPump(playerid, 10.0);

			if ( fuelid != INVALID_FUEL_STATION_ID ) {

				new vehicleid = GetPlayerVehicleID(playerid);
				new veh_enum_id = Vehicle_GetEnumID ( vehicleid );	

				Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ]  ++ ;
				PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] += 2 ;

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] >= 100 ) {

					Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100 ;
					PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] = false ;
				}

				PlayerTextDrawSetString(playerid, fuel_player_gui[playerid][7], 
					sprintf("~b~%d '/.~n~~g~$%s__", Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] ,
					IntegerWithDelimiter(PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ])
				));
					

				PlayerTextDrawShow(playerid, fuel_player_gui[playerid][7]);
				Fuel_UpdateExtraFiller(playerid, Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ]);
			}
		}
	}

	else if ( !  PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] ) {

		if ( PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] ) {

			if ( IsPlayerInAnyVehicle ( playerid ) && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) {
				new fuelid = Fuel_GetNearestPump(playerid, 10.0);

				if ( fuelid != INVALID_FUEL_STATION_ID ) {
					new station_idx =  FuelStation_LinkSQLIDToEnum( FuelPump [ fuelid ] [ E_FUEL_PUMP_MANAGER_ID ] ), query [ 256 ] ;

					// Subtracting 30% of the total from the full value for end gain.
					new cost_after_taxes = PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] - ( PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] / 100 * 30 );

					// This didn't work because station_idx was previously E_PUMP_MANAGER_ID (sql).
					FuelStation [ station_idx ] [ E_FUEL_STATION_INCOME ] += cost_after_taxes ;

					mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelmanager SET fuelmanager_income = %d WHERE fuelmanager_id = %d",
						FuelStation [ station_idx ] [ E_FUEL_STATION_INCOME ], FuelStation [ station_idx ] [ E_FUEL_STATION_ID ] 
					) ;

					mysql_tquery(mysql, query);
				}
			}
			Fuel_OnHidePlayerGui_Extra(playerid);

			ShowPlayerInfoMessage(playerid, sprintf("You have paid ~g~$%s~w~ for your vehicle's fuel.", 
				IntegerWithDelimiter(PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ])), .height=285.0, .width = 200.0, .showtime = 6000);
			
			TakePlayerCash ( playerid, PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] ) ;
			PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ]  = 0 ;				
		}
	}

}

Fuel_OnPlayerExitCar(playerid) {
	if ( PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] ) {

		if ( IsPlayerInAnyVehicle ( playerid ) && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) {
			new fuelid = Fuel_GetNearestPump(playerid, 10.0);

			if ( fuelid != INVALID_FUEL_STATION_ID ) {
				new station_idx =  FuelStation_LinkSQLIDToEnum( FuelPump [ fuelid ] [ E_FUEL_PUMP_MANAGER_ID ] ), query [ 256 ] ;

				// Subtracting 30% of the total from the full value for end gain.
				new cost_after_taxes = PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] - ( PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] / 100 * 30 );

				// This didn't work because station_idx was previously E_PUMP_MANAGER_ID (sql).
				FuelStation [ station_idx ] [ E_FUEL_STATION_INCOME ] += cost_after_taxes ;

				mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelmanager SET fuelmanager_income = %d WHERE fuelmanager_id = %d",
					FuelStation [ station_idx ] [ E_FUEL_STATION_INCOME ], FuelStation [ station_idx ] [ E_FUEL_STATION_ID ] 
				) ;

				mysql_tquery(mysql, query);
			}
		}

		Fuel_OnHidePlayerGui_Extra(playerid);
		ShowPlayerInfoMessage(playerid, sprintf("You have paid ~g~$%s~w~ for your vehicle's fuel.", 
			IntegerWithDelimiter(PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ])), .height=285.0, .width = 200.0, .showtime = 6000);
		
		TakePlayerCash ( playerid, PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ]  = 0 ;				
	}
}

Fuel_UpdateVehicleFuel(veh_enum_id) {

	new vehicleid = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ;

	if ( ! IsValidVehicle ( vehicleid ) ) {

		return false ;
	}

	if (!IsEngineVehicle(vehicleid)) {
		return false ;
	}

	if ( ! GetEngineStatus(vehicleid) ) {

		return true ;
	}

	new query[256] ;

	// DMV vehicles shouldn't lose fuel.
	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_DMV ) {

		Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100 ;
		return false ;
	}
	
	if ( GetEngineStatus ( vehicleid ) && TRP_GetVehicleSpeed(vehicleid) > 1.0 ) {

		Vehicle [ veh_enum_id ] [ E_VEHICLE_MILEAGE ] ++ ;
		-- Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] ;

		mysql_format(mysql, query, sizeof ( query), "UPDATE vehicles SET vehicle_fuel = %d, vehicle_mileage = %d WHERE vehicle_sqlid = %d",
			Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ], Vehicle [ veh_enum_id ] [ E_VEHICLE_MILEAGE ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] );

		mysql_tquery(mysql, query);
		
		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] <= 1 ) {

	    	SetEngineStatus(vehicleid, false);

	    	foreach(new playerid: Player) {

				if ( IsPlayerInVehicle ( playerid, vehicleid ) && GetVehicleDriver ( vehicleid ) == playerid ) {
					new Float: x, Float: y, Float: z, world = GetVehicleVirtualWorld(vehicleid); 
					ProxDetectorXYZ(x, y, z, 0, world, 30, COLOR_ACTION, sprintf("** The engine shuts off with a loud bang, and the %s comes to a stop.", ReturnVehicleName ( vehicleid )));
					SendServerMessage(playerid, COLOR_BLUE, "Fuel", "A3A3A3", "You've ran out of fuel. Find someone to tow your car to a gas station." ) ;
				}

				else continue ;
			}

			return true ;
		}
	}

	foreach(new playerid: Player) {

		if ( IsPlayerInVehicle ( playerid, vehicleid ) && GetPlayerVehicleSeat(playerid) <= 1 ) {

			ShowVehicleGUI(playerid);
			//Vehicle_OnPlayerUpdateGUI(playerid, vehicleid);
		}

		else continue ;
	}

	return true ;
}