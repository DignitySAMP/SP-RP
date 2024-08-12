
#include "jobs/garbage/data.pwn"
#include "jobs/garbage/native.pwn"

CMD:garbagejob(playerid, params[]) {

	if ( IsPlayerDoingGarbageJob( playerid ) ) {
		SendClientMessage(playerid, COLOR_ERROR, "You've cancelled the garbagejob.");
		GarbageJob_CancelData(playerid);
		AddLogEntry(playerid, LOG_TYPE_JOB, "quit the garbagejob");
		return 1;
	}

	if (PlayerVar[playerid][E_PLAYER_GARBAGEJOB_TIMEOUT] > gettime())
		return SendServerMessage( playerid, COLOR_JOB, "Garbage Job", "DEDEDE",  "You've been timed out from this job due to abuse. Try again later." );

	if (PlayerVar [playerid][E_PLAYER_GARBAGEJOB_COUNT] >= 3) {
		
		PlayerVar[playerid][E_PLAYER_GARBAGEJOB_COUNT] = 0;
		PlayerVar[playerid][E_PLAYER_GARBAGEJOB_TIMEOUT] = gettime() + 300;

		return SendServerMessage( playerid, COLOR_JOB, "Garbage Job", "DEDEDE",  "You've been timed out from this job due to abuse. Try again later." );
	}

	if ( IsPlayerInGarbageJobVehicle ( playerid ) ) {
		
		AddLogEntry(playerid, LOG_TYPE_JOB, "started the garbagejob");
		new veh_enum_id = Vehicle_GetEnumID(GetPlayerVehicleID(playerid)) ;

		PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB ] = true ;
		PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_VEHICLE ] = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ;
		SetEngineStatus( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], true );

		PlayerVar[playerid][E_PLAYER_GARBAGEJOB_COUNT]++;

		GarbageJob_FetchNewPoint ( playerid );	
	}

	else return SendServerMessage( playerid, COLOR_JOB, "Garbage Job", "DEDEDE",  "You must be inside a garbage job Trashmaster." );

	return 1;
}

Garbage_CheckVehicleRange(playerid) {

	if ( ! IsPlayerInAnyVehicle(playerid) && IsValidVehicle ( PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_VEHICLE ] ) ) {
		new vehicleid = Vehicle_GetClosestEntity(playerid, 50.0);
		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

		if ( veh_enum_id != -1 ) {

			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] == PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_VEHICLE ] ) {

				return true ;
			}
		}

		GameTextForPlayer(playerid, "~r~Mission Failed~n~~w~You're too far away from the garbage car.", 5000, 6);
		GarbageJob_CancelData(playerid) ;
	}

	return true ;
}

