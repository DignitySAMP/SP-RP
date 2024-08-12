#include <YSI_Coding\y_hooks>
hook OnPlayerUpdate(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new Float:vHealth, vehicleid = GetPlayerVehicleID(playerid);
		GetVehicleHealth(vehicleid, vHealth);

		if(vHealth == 1000)
		{
			SOLS_SetVehicleHealth(vehicleid, 999);
			if ( IsPlayerNearPayNSpray(playerid) ) {
				CallRemoteFunction("OnVehicleRespray", "iiii", playerid, vehicleid, -1, -1);
				return 1;
			}

			else {
				new acstr[256];
				if ( GetVehicleDriver(vehicleid) == INVALID_PLAYER_ID ) {
					format(acstr, sizeof(acstr), "[Anticheat]: Vehicle %i has 1000 health (max is 999). [NO DRIVER]", vehicleid);
				}
				else {
					format(acstr, sizeof(acstr), "[Anticheat]: Vehicle %i has 1000 health (max is 999). [(%i) %s]", vehicleid, GetVehicleDriver(vehicleid), ReturnMixedName(GetVehicleDriver(vehicleid)));
				}
				SendAdminMessage(acstr, COLOR_ANTICHEAT);
			}
		}
	}
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid) {

   	if ( !IsPlayerNearPayNSpray(playerid) ) {
		new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

		if ( veh_enum_id == -1 ) {

			return true ;
		}


	    new Float: health ;
	   	GetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], health);

	   	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] > health + 1 ) {

		    new panels, doors, lights, tires;
		    GetVehicleDamageStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], panels, doors, lights, tires);

		   	if ( health <= 300 ) {

		   		health = 300 ;
		   	}

		    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ]    = panels ;
		    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ]     = doors ;
		    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ]    = lights ;
		    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ]     = tires ;

		    SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], health);
		    Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] = health ;
		}
	}

    return 1;
}



public OnVehicleRespray(playerid, vehicleid, color1, color2) {

	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] <= 250.0 ) {

		SOLS_SetVehicleHealth ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], 300 ); 
	}

	else SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] );

	UpdateVehicleDamageStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] );

	//SendClientMessage(playerid, COLOR_YELLOW, "Normal use of the pay and spray is prohibited! Your vehicle damage / health has been restored!" ) ;

	return true ;
}