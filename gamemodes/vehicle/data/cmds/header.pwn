#include "vehicle/data/cmds/owner.pwn"
#include "vehicle/data/cmds/default.pwn"
#include "vehicle/data/cmds/admin.pwn"
#include "vehicle/data/cmds/storage.pwn"


CMD:carlock(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid = Vehicle_GetClosestEntity(playerid, .radius = 5.0);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any proper vehicle! (couldn't fetch ID)");
	}

	if ( GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Uh Oh!", "A3A3A3", "This vehicle does not have a door lock!" ) ;
    }

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
		switch ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ]) {

			case E_VEHICLE_TYPE_PLAYER: {
				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && !HasCarDuplicateKey(playerid, veh_enum_id)) {

					return SendClientMessage(playerid, COLOR_ERROR, "You do not have the keys to this vehicle!");
				}
			}

			case E_VEHICLE_TYPE_FACTION: {

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {

					return SendClientMessage(playerid, COLOR_ERROR, "You do not have the keys to this vehicle!");
				}
			}
		}	
	}

	PlayerPlaySound(playerid, 24600, 0, 0, 0);
	if (GetDoorStatus ( vehicleid ) ) {
   
		ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("unlocks the %s.", ReturnVehicleName ( vehicleid )), .annonated=true);
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ] = false ;
		SetDoorStatus ( vehicleid, false );
	}

	else if (!GetDoorStatus ( vehicleid ) ) {
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ] = true ;
		ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("locks the %s.", ReturnVehicleName ( vehicleid )), .annonated=true);
		SetDoorStatus ( vehicleid, true );
	}


	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_doors = %d WHERE vehicle_sqlid = %d",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
	);

	mysql_tquery(mysql, query);
	/*
	if ( GetVehicleDriver ( vehicleid ) == playerid ) {
		Vehicle_OnPlayerUpdateGUI(playerid, vehicleid);
	}
	*/
	ClearAlarmData ( vehicleid ) ;
	
	return true ;
}

  
CMD:engine(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

    if ( PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Finish refueling your vehicle before trying to turn on the engine!");
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any proper vehicle! (couldn't fetch ID)");
	}
	if (!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {
		switch ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ]) {

			case E_VEHICLE_TYPE_PLAYER: {
				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && !HasCarDuplicateKey(playerid, veh_enum_id)) {

					return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
				}
			}

			case E_VEHICLE_TYPE_FACTION: {

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {

					return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
				}
			}

			case E_VEHICLE_TYPE_RENTAL : {
				/*
				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

					return SendClientMessage(playerid, COLOR_ERROR, "You have not rented this vehicle!");
				}*/

				if ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_RENTEDBY ] != playerid ) {

					return SendClientMessage(playerid, COLOR_ERROR, "You have not rented this vehicle!");
				}
			}

			case E_VEHICLE_TYPE_DMV: {

				return SendClientMessage(playerid, COLOR_ERROR, "This is a DMV vehicle. You need to use /taketest!");
			}
			case E_VEHICLE_TYPE_JOB: {

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {

					return SendClientMessage(playerid, COLOR_ERROR, "You must do the right command or keystroke to turn this engine on!");
				}
			}
		}	
	}

	else {

		SendClientMessage(playerid, COLOR_YELLOW, "You're using your admin powers to start this vehicle.");
	}

	if (Vehicle [ veh_enum_id ] [E_VEHICLE_IMPOUNDED] && GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL){
		return SendClientMessage(playerid, COLOR_ERROR, "You cannot start the engine of this vehicle as it's impounded. Use /unimpound to pay the fee.");
	}

	if (Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] <= 1) {
	    return SendClientMessage(playerid, COLOR_ERROR, "The fuel tank is empty.");
	}

	if (ReturnVehicleHealth(vehicleid) <= 300) {
		if ( ! IsAircraft ( vehicleid ) ) {
	    	return SendClientMessage(playerid, COLOR_ERROR, "This vehicle is totalled and can't be started.");
	    }

	    else {

	    	SendClientMessage(playerid, COLOR_YELLOW, "Your vehicle is in very bad condition (engine damage). Get it fixed before it blows up!");
	    }
	}

	switch (GetEngineStatus(vehicleid))
	{
	    case false:
	    {

	        SetEngineStatus(vehicleid, true);
			defer OnPlayerDrive(playerid, vehicleid) ;
			ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("twists the key, turning the engine of the %s on.", ReturnVehicleName ( vehicleid )), .annonated=true);
	    }
		case true:
		{
		    SetEngineStatus(vehicleid, false);
			ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("twists the key, turning the engine of the %s off.", ReturnVehicleName ( vehicleid )), .annonated=true);
		}
	}

	SOLS_UpdateVehiclePermSirens(vehicleid);
	ClearAlarmData ( vehicleid ) ;
	//Vehicle_OnPlayerUpdateGUI(playerid, vehicleid) ;
	ShowVehicleGUI(playerid);
	return 1;
}