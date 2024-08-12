#include <YSI_Coding\y_hooks>

// Assuming there will never be more than 750 spawned cars on the server (obviously shit will break if there are)
#define MAX_SERVER_VEHICLES 750
static bool:USE_ENUM_MITIGATION = true;

enum StaticVehicleData 
{
	bool:E_STATIC_VEH_EXISTS,
	E_STATIC_VEH_ENUM_ID
}

new StaticVehicle[MAX_SERVER_VEHICLES][StaticVehicleData];

// Temporary vehicle lag mitigation
Vehicle_GetEnumID(vehicleid) 
{
    if (vehicleid == INVALID_VEHICLE_ID || vehicleid < 1) return -1;

    if (USE_ENUM_MITIGATION)
    {
        return StaticVehicle[vehicleid][E_STATIC_VEH_ENUM_ID];
    }
    else
    {
        return Vehicle_GetEnumID_old(vehicleid);
    }
}

Temp_SetVehicleEnumId(vehicleid, enum_id)
{
    if (USE_ENUM_MITIGATION && vehicleid > 0 && vehicleid < MAX_SERVER_VEHICLES)
    {
        StaticVehicle[vehicleid][E_STATIC_VEH_ENUM_ID] = enum_id;
    }
}

Temp_ReleaseVehicleEnumId(vehicleid)
{
    if (USE_ENUM_MITIGATION && vehicleid > 0 && vehicleid < MAX_SERVER_VEHICLES)
    {
        StaticVehicle[vehicleid][E_STATIC_VEH_ENUM_ID] = -1;
    }
}

hook OnGameModeInit()
{
    for (new i = 0; i < MAX_SERVER_VEHICLES; i ++)
    {
        Temp_ReleaseVehicleEnumId(i);
    }

    return 1;
}

CMD:togvehpatch(playerid)
{
    if (!IsPlayerAdmin(playerid)) return false;
    USE_ENUM_MITIGATION = !USE_ENUM_MITIGATION;

    SendClientMessage(playerid, -1, sprintf("Now using %s", USE_ENUM_MITIGATION ? "static variable" : "mega loop"));
    return true;
}

Vehicle_GetEnumID_old ( vehicleid ) 
{
	//#warning Make a static variable when a vehicle is created and destroyed TotalVehicleCount; (hook CreateVehicle / DestroyVehicle)

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {
	//for ( new i, j = TotalCarsSpawned; i < j; i ++ ) {

		if ( Vehicle [ i ] [ E_VEHICLE_SQLID ] == -1 ) {

			continue ;
		}


		// #warning This gets called over 5 million times within server restart. Reduce this "sizeof" to the amount of vehicles spawned.
		// #warning Uncomment this incase shit hits the roof
		
		if ( ! IsValidVehicle( Vehicle [ i ] [ E_VEHICLE_ID ] ) ) {

			continue ;
		}
		
		if ( Vehicle [ i ] [ E_VEHICLE_ID ] == vehicleid ) {

			return i ;
		}

		else continue ;
	}

	return -1 ;
}