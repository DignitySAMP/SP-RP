#include "jobs/trucker/data/header.pwn"
#include "jobs/trucker/func/header.pwn"

Trucker_LoadEntities() {
	//Load Stores

	Trucker_LoadEntities_Stores();
	Trucker_LoadEntities_Wholesaler();

	print(" * [TRUCKER] Loaded trucker map entitites");

	return true ;
}

GetRandomTrailerID(item_id)
{
	new trailerid = 435;
	if(IsBrokenMaterial(item_id))
	{
		trailerid = 450;
	}
	if(IsLiquid(item_id))
	{
		trailerid = 584;
	}
	if(IsFood(item_id)) {
		trailerid=435;
	}
	else {
		trailerid = 591;
	}

	return trailerid;
}

Trucker_RemoveTrailer(playerid, vehicleid, veh_enum_id ) {
	#pragma unused playerid, vehicleid
	
	new trailer = GetVehicleTrailer( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] );
	new saved_trailer = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] ;

	if ( trailer ) {

		// Check the models...
		switch ( GetVehicleModel( trailer ) ) {

			// If the ID is actually a trailer, destroy it!
			case 435, 450, 584, 591: {

				if ( trailer == saved_trailer ) {

					VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] = 0 ;
				}

				SOLS_DestroyVehicle( trailer ) ;
			}
		}

		if ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] ) {
			// Check the models...
			switch ( GetVehicleModel( saved_trailer ) ) {

				// If the ID is actually a trailer, destroy it!
				case 435, 450, 584, 591: {

					SOLS_DestroyVehicle( saved_trailer ) ;
				}
			}
		}

		// Clear the stored variable - we don't need it anymore.
		VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] = 0 ;
	}

	else if ( ! trailer ) {

		// If stored trailer isn't the same as attached trailer...
		if ( saved_trailer != trailer ) {

			if ( !IsValidVehicle(saved_trailer)){

				return true ;
			}

			// Check the models...
			switch ( GetVehicleModel( saved_trailer ) ) {

				// If the ID is actually a trailer, destroy it!
				case 435, 450, 584, 591: {

					SOLS_DestroyVehicle( saved_trailer ) ;
				}
			}

			// Reset the value because it doesn't match anyway (delete beforehand)
			VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] = 0 ;
		}
	}

	return true ;
}

timer Trucker_CancelAnim[700](playerid) {

	ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
	return 1;
}

timer Trucker_PlayerCarryBox[1000](playerid, status ) {

	switch ( status ) {

		case 0: { // attach (500ms)

			new modelid = Trucker_GetCrateModel ( PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] ) ;
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM, modelid, 1, 0.4, 0.6, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0);
		}

		case 1: { // carrybox (500ms)
			ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		}
	}
}

Vehicle_ClearTruckerVariables(veh_enum_id) {

	if ( veh_enum_id == -1 ) {

		return true ;
	}

	for ( new i, j = 64 ; i < j ; i ++ ) 
	{
		VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [i] = -1 ;
		VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [i] = -1 ;

		/*
		if ( IsValidDynamicObject( VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [i] ) ) {

			SOLS_DestroyObject( VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [i], "Trucking/ClearTruckerVariables", true ) ;
			VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [i] = INVALID_OBJECT_ID;
		}
		*/
	}

	/*

	-> Crates still appear on improper vehicles.
	-> Find a way to track which objects are attached to which vehicle 
	(maybe hook SOLS_CreateDynamicObject and make it count, so we have a proper loop value)
	
	for ( new i, j = VAL ; i < j ; i ++ ) {

		if ( Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_ATTACHED_VEHICLE ) == Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) {

		}	
	}*/

	Trucker_RemoveTrailer(-1, -1, veh_enum_id );

	return true ;
}


GetStorageOffset(vehicleid, storage, &Float:OffsetX, &Float:OffsetY, &Float:OffsetZ)
{
	new modelid = GetVehicleModel(vehicleid);
	switch(modelid) //increase X to move it to Right, Decrease Y to move it to Back
	{
		case 514, 515, 403: //tanker
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.0; OffsetY = 0.0; OffsetZ = 0.0; }
			}
		}
		case 543: //salder
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.45; OffsetY = -0.9; OffsetZ = 0.1; }
				case 1: { OffsetX = 0.4; OffsetY = -0.9; OffsetZ = 0.1; }
				case 2: { OffsetX = -0.1; OffsetY = -1.8; OffsetZ = 0.1; }
			}
		}
		case 422: //bobcat
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.45; OffsetY = -0.75; OffsetZ = 0.0; }
				case 1: { OffsetX = 0.4; OffsetY = -0.75; OffsetZ = 0.0; }
				case 2: { OffsetX = -0.1; OffsetY = -1.6; OffsetZ = 0.0; }
			}
		}
		case 600: //picador
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.355; OffsetY = -1.0; OffsetZ = 0.1; }
				case 1: { OffsetX = 0.355; OffsetY = -1.0; OffsetZ = 0.1; }
				case 2: { OffsetX = -0.1; OffsetY = -2.0; OffsetZ = 0.1; }
			}
		}
		case 440: //rumpo
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.355; OffsetY = 0.0; OffsetZ = 0.2; }
				case 1: { OffsetX = 0.355; OffsetY = 0.0; OffsetZ = 0.2; }
				case 2: { OffsetX = -0.355; OffsetY = -0.7; OffsetZ = 0.2; }
				case 3: { OffsetX = 0.355; OffsetY = -0.7; OffsetZ = 0.2; }
				case 4: { OffsetX = -0.355; OffsetY = -1.4; OffsetZ = 0.2; }
				case 5: { OffsetX = 0.355; OffsetY = -1.4; OffsetZ = 0.2; }
				case 6: { OffsetX = -0.355; OffsetY = -2.1; OffsetZ = 0.2; }
				case 7: { OffsetX = 0.355; OffsetY = -2.1; OffsetZ = 0.2; }
			}
		}
		case 482: //burrito
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.355; OffsetY = -0.2; OffsetZ = 0.2; }
				case 1: { OffsetX = 0.355; OffsetY = -0.2; OffsetZ = 0.2; }
				case 2: { OffsetX = -0.355; OffsetY = -1.0; OffsetZ = 0.2; }
				case 3: { OffsetX = 0.355; OffsetY = -1.0; OffsetZ = 0.2; }
				case 4: { OffsetX = 0.0; OffsetY = -2.0; OffsetZ = -0.2; }
				case 5: { OffsetX = 0.1; OffsetY = -1.9; OffsetZ = 0.475; } //0.675
			}
		}
		case 499: //benson
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.355; OffsetY = -1.2; OffsetZ = 0.24; }
				case 1: { OffsetX = 0.355; OffsetY = -1.2; OffsetZ = 0.24; }
				case 2: { OffsetX = -0.355; OffsetY = -1.2; OffsetZ = 0.915; }
				case 3: { OffsetX = 0.355; OffsetY = -1.2; OffsetZ = 0.915; }
				case 4: { OffsetX = -0.05; OffsetY = -2.0; OffsetZ = 0.24; }
				case 5: { OffsetX = 0.0; OffsetY = -2.0; OffsetZ = 0.915; }
				case 6: { OffsetX = -0.4; OffsetY = -2.80; OffsetZ = 0.24; }
				case 7: { OffsetX = -0.39; OffsetY = -2.80; OffsetZ = 0.915; }
				case 8: { OffsetX = 0.4; OffsetY = -2.80; OffsetZ = 0.24; }
				case 9: { OffsetX = 0.39; OffsetY = -2.80; OffsetZ = 0.915; }
			}
		}
		case 414: //mule
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.355; OffsetY = -0.6; OffsetZ = 0.24; }
				case 1: { OffsetX = 0.355; OffsetY = -0.6; OffsetZ = 0.24; }
				case 2: { OffsetX = -0.355; OffsetY = -0.6; OffsetZ = 0.915; }
				case 3: { OffsetX = 0.355; OffsetY = -0.6; OffsetZ = 0.915; }
				case 4: { OffsetX = -0.355; OffsetY = -0.6; OffsetZ = 1.6; }
				case 5: { OffsetX = 0.355; OffsetY = -0.6; OffsetZ = 1.6; }
				case 6: { OffsetX = -0.355; OffsetY = -1.4; OffsetZ = 0.24; }
				case 7: { OffsetX = 0.355; OffsetY = -1.4; OffsetZ = 0.24; }
				case 8: { OffsetX = -0.355; OffsetY = -1.4; OffsetZ = 0.915; }
				case 9: { OffsetX = 0.355; OffsetY = -1.4; OffsetZ = 0.915; }
				case 10: { OffsetX = -0.355; OffsetY = -1.4; OffsetZ = 1.6; }
				case 11: { OffsetX = 0.355; OffsetY = -1.4; OffsetZ = 1.6; }
				case 12: { OffsetX = -0.355; OffsetY = -2.0; OffsetZ = 0.24; }
				case 13: { OffsetX = 0.355; OffsetY = -2.0; OffsetZ = 0.24; }
				case 14: { OffsetX = -0.355; OffsetY = -2.0; OffsetZ = 0.915; }
				case 15: { OffsetX = 0.355; OffsetY = -2.0; OffsetZ = 0.915; }
				case 16: { OffsetX = -0.355; OffsetY = -2.0; OffsetZ = 1.6; }
				case 17: { OffsetX = 0.355; OffsetY = -2.0; OffsetZ = 1.6; }
				case 18: { OffsetX = -0.355; OffsetY = -2.6; OffsetZ = 0.24; }
				case 19: { OffsetX = 0.355; OffsetY = -2.6; OffsetZ = 0.24; }
				case 20: { OffsetX = -0.355; OffsetY = -2.6; OffsetZ = 0.915; }
				case 21: { OffsetX = 0.355; OffsetY = -2.6; OffsetZ = 0.915; }
				case 22: { OffsetX = -0.355; OffsetY = -2.6; OffsetZ = 1.6; }
				case 23: { OffsetX = 0.355; OffsetY = -2.6; OffsetZ = 1.6; }
			}
		}
		case 456: //yankee
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.80; OffsetY = -0.6; OffsetZ = 0.35; }
				case 1: { OffsetX = 0.00; OffsetY = -0.6; OffsetZ = 0.35; }
				case 2: { OffsetX = 0.80; OffsetY = -0.6; OffsetZ = 0.35; }

				case 3: { OffsetX = -0.80; OffsetY = -0.6; OffsetZ = 1.025; }
				case 4: { OffsetX = 0.00; OffsetY = -0.6; OffsetZ = 1.025; }
				case 5: { OffsetX = 0.80; OffsetY = -0.6; OffsetZ = 1.025; }

				case 6: { OffsetX = -0.80; OffsetY = -0.6; OffsetZ = 1.7; }
				case 7: { OffsetX = 0.00; OffsetY = -0.6; OffsetZ = 1.7; }
				case 8: { OffsetX = 0.80; OffsetY = -0.6; OffsetZ = 1.7; }


				case 9: { OffsetX = -0.80; OffsetY = -1.3; OffsetZ = 0.35; }
				case 10: { OffsetX = 0.00; OffsetY = -1.3; OffsetZ = 0.35; }
				case 11: { OffsetX = 0.80; OffsetY = -1.3; OffsetZ = 0.35; }

				case 12: { OffsetX = -0.80; OffsetY = -1.3; OffsetZ = 1.025; }
				case 13: { OffsetX = 0.00; OffsetY = -1.3; OffsetZ = 1.025; }
				case 14: { OffsetX = 0.80; OffsetY = -1.3; OffsetZ = 1.025; }

				case 15: { OffsetX = -0.80; OffsetY = -1.3; OffsetZ = 1.7; }
				case 16: { OffsetX = 0.00; OffsetY = -1.3; OffsetZ = 1.7; }
				case 17: { OffsetX = 0.80; OffsetY = -1.3; OffsetZ = 1.7; }


				case 18: { OffsetX = -0.80; OffsetY = -1.9; OffsetZ = 0.35; }
				case 19: { OffsetX = 0.00; OffsetY = -1.9; OffsetZ = 0.35; }
				case 20: { OffsetX = 0.80; OffsetY = -1.9; OffsetZ = 0.35; }

				case 21: { OffsetX = -0.80; OffsetY = -1.9; OffsetZ = 1.025; }
				case 22: { OffsetX = 0.00; OffsetY = -1.9; OffsetZ = 1.025; }
				case 23: { OffsetX = 0.80; OffsetY = -1.9; OffsetZ = 1.025; }

	
				case 24: { OffsetX = -0.80; OffsetY = -1.9; OffsetZ = 1.7; }
				case 25: { OffsetX = 0.00; OffsetY = -1.9; OffsetZ = 1.7; }
				case 26: { OffsetX = 0.80; OffsetY = -1.9; OffsetZ = 1.7; }


				case 27: { OffsetX = -0.80; OffsetY = -2.5; OffsetZ = 0.35; }
				case 28: { OffsetX = 0.00; OffsetY = -2.5; OffsetZ = 0.35; }
				case 29: { OffsetX = 0.80; OffsetY = -2.5; OffsetZ = 0.35; }

				case 30: { OffsetX = -0.80; OffsetY = -2.5; OffsetZ = 1.025; }
				case 31: { OffsetX = 0.00; OffsetY = -2.5; OffsetZ = 1.025; }
				case 32: { OffsetX = 0.80; OffsetY = -2.5; OffsetZ = 1.025; }
			/*
				case 33: { OffsetX = -0.80; OffsetY = -2.5; OffsetZ = 1.7; }
				case 34: { OffsetX = 0.00; OffsetY = -2.5; OffsetZ = 1.7; }
				case 35: { OffsetX = 0.80; OffsetY = -2.5; OffsetZ = 1.7; }


				case 36: { OffsetX = -0.80; OffsetY = -3.1; OffsetZ = 0.35; }
				case 37: { OffsetX = 0.00; OffsetY = -3.1; OffsetZ = 0.35; }
				case 38: { OffsetX = 0.80; OffsetY = -3.1; OffsetZ = 0.35; }

				case 39: { OffsetX = -0.80; OffsetY = -3.1; OffsetZ = 1.025; }
				case 40: { OffsetX = 0.00; OffsetY = -3.1; OffsetZ = 1.025; }
				case 41: { OffsetX = 0.80; OffsetY = -3.1; OffsetZ = 1.025; }

				case 42: { OffsetX = -0.80; OffsetY = -3.1; OffsetZ = 1.7; }
				case 43: { OffsetX = 0.00; OffsetY = -3.1; OffsetZ = 1.7; }
				case 44: { OffsetX = 0.80; OffsetY = -3.1; OffsetZ = 1.7; }


				case 45: { OffsetX = -0.80; OffsetY = -3.7; OffsetZ = 0.35; }
				case 46: { OffsetX = 0.00; OffsetY = -3.7; OffsetZ = 0.35; }
				case 47: { OffsetX = 0.80; OffsetY = -3.7; OffsetZ = 0.35; }

				case 48: { OffsetX = -0.80; OffsetY = -3.7; OffsetZ = 1.025; }
				case 49: { OffsetX = 0.00; OffsetY = -3.7; OffsetZ = 1.025; }
				case 50: { OffsetX = 0.80; OffsetY = -3.7; OffsetZ = 1.025; }

				case 51: { OffsetX = -0.80; OffsetY = -3.7; OffsetZ = 1.7; }
				case 52: { OffsetX = 0.00; OffsetY = -3.7; OffsetZ = 1.7; }
				case 53: { OffsetX = 0.80; OffsetY = -3.7; OffsetZ = 1.7; }*/
			}
		}
		case 455: //flatbed
		{
			switch(storage)
			{
				case 0: { OffsetX = -1.05; OffsetY = 0.0; OffsetZ = 0.4; }
				case 1: { OffsetX = -0.34; OffsetY = 0.0; OffsetZ = 0.4; }
				case 2: { OffsetX = 0.37; OffsetY = 0.0; OffsetZ = 0.4; }
				case 3: { OffsetX = 1.04; OffsetY = 0.0; OffsetZ = 0.4; }

				case 4: { OffsetX = -1.05; OffsetY = -0.8; OffsetZ = 0.4; }
				case 5: { OffsetX = -0.34; OffsetY = -0.8; OffsetZ = 0.4; }
				case 6: { OffsetX = 0.37; OffsetY = -0.8; OffsetZ = 0.4; }
				case 7: { OffsetX = 1.04; OffsetY = -0.8; OffsetZ = 0.4; }

				case 8: { OffsetX = -1.05; OffsetY = -1.6; OffsetZ = 0.4; }
				case 9: { OffsetX = -0.34; OffsetY = -1.6; OffsetZ = 0.4; }
				case 10: { OffsetX = 0.37; OffsetY = -1.6; OffsetZ = 0.4; }
				case 11: { OffsetX = 1.04; OffsetY = -1.6; OffsetZ = 0.4; }

				case 12: { OffsetX = -1.05; OffsetY = -2.4; OffsetZ = 0.4; }
				case 13: { OffsetX = -0.34; OffsetY = -2.4; OffsetZ = 0.4; }
				case 14: { OffsetX = 0.37; OffsetY = -2.4; OffsetZ = 0.4; }
				case 15: { OffsetX = 1.04; OffsetY = -2.4; OffsetZ = 0.4; }

				case 16: { OffsetX = -1.05; OffsetY = -3.2; OffsetZ = 0.4; }
				case 17: { OffsetX = -0.34; OffsetY = -3.2; OffsetZ = 0.4; }
				case 18: { OffsetX = 0.37; OffsetY = -3.2; OffsetZ = 0.4; }
				case 19: { OffsetX = 1.04; OffsetY = -3.2; OffsetZ = 0.4; }

				case 20: { OffsetX = -1.05; OffsetY = -4.0; OffsetZ = 0.4; }
				case 21: { OffsetX = -0.34; OffsetY = -4.0; OffsetZ = 0.4; }
				case 22: { OffsetX = 0.37; OffsetY = -4.0; OffsetZ = 0.4; }
				case 23: { OffsetX = 1.04; OffsetY = -4.0; OffsetZ = 0.4; }

				case 24: { OffsetX = -0.65; OffsetY = -0.8; OffsetZ = 1.075; }
				case 25: { OffsetX = 0.06; OffsetY = -0.8; OffsetZ = 1.075; }
				case 26: { OffsetX = 0.75; OffsetY = -0.8; OffsetZ = 1.075; }

				case 27: { OffsetX = -0.65; OffsetY = -1.6; OffsetZ = 1.075; }
				case 28: { OffsetX = 0.06; OffsetY = -1.6; OffsetZ = 1.075; }
				case 29: { OffsetX = 0.75; OffsetY = -1.6; OffsetZ = 1.075; }

				case 30: { OffsetX = -0.65; OffsetY = -2.4; OffsetZ = 1.075; }
				case 31: { OffsetX = 0.06; OffsetY = -2.4; OffsetZ = 1.075; }
				case 32: { OffsetX = 0.75; OffsetY = -2.4; OffsetZ = 1.075; }

				case 33: { OffsetX = -0.65; OffsetY = -3.2; OffsetZ = 1.075; }
				case 34: { OffsetX = 0.06; OffsetY = -3.2; OffsetZ = 1.075; }
				case 35: { OffsetX = 0.75; OffsetY = -3.2; OffsetZ = 1.075; }

			}
		}
		case 478: //walton
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.45; OffsetY = -0.9; OffsetZ = 0.3; }
				case 1: { OffsetX = 0.4; OffsetY = -1.0; OffsetZ = 0.3; }
				case 2: { OffsetX = -0.45; OffsetY = -1.95; OffsetZ = 0.3; }
				case 3: { OffsetX = 0.42; OffsetY = -1.9; OffsetZ = 0.3; }
			}
		}
		case 554: //yosemite
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.0; OffsetY = -1.1; OffsetZ = 0.1; }
				case 1: { OffsetX = -0.2; OffsetY = -2.0; OffsetZ = 0.1; }
				case 2: { OffsetX = -0.1; OffsetY = -1.4; OffsetZ = 0.8; }
			}
		}
		/*case 404: //perennial
		{
			switch(storage)
			{
				case 0: { OffsetX = -0.355; OffsetY = -1.0; OffsetZ = 0.2; }
				case 1: { OffsetX = 0.355; OffsetY = -1.0; OffsetZ = 0.2; }
				case 2: { OffsetX = -0.1; OffsetY = -2.0; OffsetZ = 0.2; }
			}
		}*/
	}
}

IsTruckingVehicle(vehicleid) {

	if ( GetMaxStorageModel ( GetVehicleModel ( vehicleid ) ) ) {

		return true ;
	}

	return false;
}

IsVehicleTanker(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 514 || GetVehicleModel(vehicleid) == 515 || GetVehicleModel ( vehicleid ) == 403 ) return 1;
	return 0;
}


GetMaxStorageModel(modelid)
{
	new max_s = 0;
	switch(modelid)
	{
		case 403: // linerunner
		{
			max_s = 54 ;
		}
		case 514: //tanker
		{
			max_s = 54;
		}
		case 515: // roadtrain
		{
			max_s = 54;
		}
		case 543: //salder
		{
			max_s = 3;
		}
		case 422: //bobcat
		{
			max_s = 3;
		}
		case 600: //picador
		{
			max_s = 3;
		}
		case 440: //rumpo
		{
			max_s = 8;
		}
		case 482: //burrito
		{
			max_s = 6;
		}
		case 499: //benson
		{
			max_s = 10;
		}
		case 414: //mule
		{
			max_s = 24;
		}
		case 456: //yankee
		{
			max_s = 32;
		}
		case 455: //flatbed
		{
			max_s = 36;
		}
		case 478: //walton
		{
			max_s = 4;
		}
		case 554: //yosemite
		{
			max_s = 3;
		}
		default:
		{
			max_s = 0;
		}
	}
	return max_s;
}


Trucker_GetCrateModel(index) {

	new modelid ;

	switch ( index ) {

		case 0: modelid = -28001;
		case 1: modelid = -28002;
		case 2: modelid = -28003;
		case 3: modelid = -28004;
		case 4: modelid = -28005;
		case 5: modelid = -28006;
		case 6: modelid = -28007;
		case 7: modelid = -28008;
		case 8: modelid = -28009;
		case 9: modelid = -28010;
		case 10: modelid = -28011;
		case 11: modelid = -28012;
		case 12: modelid = -28013;
		case 13: modelid = -28014;

		default: {
			modelid = -28000 ;
		}
	}

	return modelid ;
}

IsLiquid(item)
{
	if(item == ITEM_GAS || item == ITEM_FRYING_OIL || item == ITEM_WATER || item == ITEM_PAINT || item == ITEM_ACETONE || item == ITEM_ETHANOL || item == ITEM_MOTOR_OIL) return 1;
	else return 0;
}

stock IsFood(item)
{
	if(item == ITEM_MEAT || item == ITEM_PORK || item == ITEM_CHICKEN || item == ITEM_PORK || item == ITEM_MILK || item == ITEM_EGG) return 1;
	else return 0;
}

IsBrokenMaterial(item)
{
	if(item == ITEM_COAL || item == ITEM_ROCK || item == ITEM_SAND) return 1;
	else return 0;
}


GetXYBackOfVehicle(const vehicleid, &Float:x, &Float:y, const Float:distance)
{
	new Float:a;
	GetVehiclePos(vehicleid, x, y, a);
	GetVehicleZAngle(vehicleid, a);
	x -= (distance * floatsin(-a, degrees));
	y -= (distance * floatcos(-a, degrees));
}
