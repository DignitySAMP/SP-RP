#define VEH_FUEL_TICK	( 300000 )

#include "vehicle/data/header.pwn"
#include "vehicle/modules/header.pwn"
#include "vehicle/fuel/header.pwn"

#include "vehicle/gui.pwn"
#include "vehicle/blinker.pwn"

#include "vehicle/slots.pwn"
#include "vehicle/hooked.pwn"

task VehicleConstantTick[60000]() {

	for ( new veh_enum_id, j = sizeof ( Vehicle ); veh_enum_id < j ; veh_enum_id ++ ) {

		Rental_CheckForExpiration(veh_enum_id) ;
		Fuel_UpdateVehicleFuel ( veh_enum_id ) ;
		EnsureJobVehicleRespawns(veh_enum_id) ;
	}
}

EnsureJobVehicleRespawns(veh_enum_id) {
	// This only respawns forklifts and garbagetrucks.
	if(Vehicle[veh_enum_id][E_VEHICLE_ID] == INVALID_VEHICLE_ID) {
		return 0;
	}
	
	if(Vehicle[veh_enum_id][E_VEHICLE_MODELID] == 408 || Vehicle[veh_enum_id][E_VEHICLE_MODELID] == 530) {

		if(VehicleVar[veh_enum_id][E_VEHICLE_LAST_USED] != 0 && VehicleVar[veh_enum_id][E_VEHICLE_LAST_USED] < gettime()) {
			
			new vehicleid = Vehicle[veh_enum_id][E_VEHICLE_ID];
			if(IsVehicleOccupied(vehicleid)) {
				VehicleVar[veh_enum_id][E_VEHICLE_LAST_USED]=0; // reset counter
				return 0;
			}

			VehicleVar[veh_enum_id][E_VEHICLE_LAST_USED] = 0;
			SOLS_SetVehicleToRespawn(vehicleid, "unoccupied job respawn" ) ;
		}
	}
	return 1;
}

public OnGameModeInit() {

	for ( new i, j = sizeof ( Vehicle ); i < j ; i ++ ) {

		Vehicle [ i ] [ E_VEHICLE_ID ] = INVALID_VEHICLE_ID ;
	}

	DMV_Init() ;

	ManualVehicleEngineAndLights() ;
	EnableVehicleFriendlyFire();

	EnableStuntBonusForAll(false);

	#if defined veh_OnGameModeInit
		return veh_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit veh_OnGameModeInit
#if defined veh_OnGameModeInit
	forward veh_OnGameModeInit();
#endif

