Crate_Putdown ( playerid ) {
	if(PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] == -1) return SendClientMessage(playerid, -1, "You're not carrying anything!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "You're supposed to be on foot!");

	//new crate_id = PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ], item_id = CrateBox[crate_id][0] ; 

	new item_id = PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] ;

	if ( item_id == -1 ) {

		return SendClientMessage(playerid, -1, "Something went wrong - you're not wearing a valid item. Use /crate reset and try again." ) ;
	}

	new wholesaler_id = GetNearestWholesalerID(playerid), store_id = GetNearestStoreID(playerid) ;

	if(wholesaler_id > -1) {
		
		if(IsPlayerInRangeOfPoint(playerid, 2.5, Wholesalers[wholesaler_id][E_WHOLESALERS_POS_X], 
			Wholesalers[wholesaler_id][E_WHOLESALERS_POS_Y], Wholesalers[wholesaler_id][E_WHOLESALERS_POS_Z])) {
			Crate_Putdown_Wholesaler ( playerid, wholesaler_id, item_id ) ;
			return true ;
		}
	}

	else if(store_id > -1) {//check for store

		if(IsPlayerInRangeOfPoint(playerid, 1.25, TruckingStores[store_id][E_TRUCK_STORE_POS_X], TruckingStores[store_id][E_TRUCK_STORE_POS_Y], TruckingStores[store_id][E_TRUCK_STORE_POS_Z])) {
			Crate_Putdown_Store ( playerid, store_id, item_id ) ;
			return true ;
		}

	}

	else {

		new vehicleid = INVALID_VEHICLE_ID;

		if ( ! IsPlayerInAnyVehicle(playerid) ) {
			vehicleid = GetClosestVehicleEx(playerid, 7.5);
		}

		else vehicleid = GetPlayerVehicleID(playerid);

		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

		if ( vehicleid == INVALID_VEHICLE_ID || veh_enum_id == -1) {

			return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
		}

		if ( IsABike(vehicleid) ) {

			return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk!");
		}

		new Float: range = 2.5 ;

		new Float: x, Float: y, Float: z ;
		GetPosBehindVehicle ( vehicleid, x, y, z );

		if ( IsVehicleTanker ( vehicleid ) ) {

			range = 7.5 ;
		}

		if ( IsPlayerInRangeOfPoint(playerid, range, x, y, z ) || GetPlayerVehicleID(playerid) == vehicleid ) {

			Crate_Putdown_Vehicle ( playerid, veh_enum_id, item_id ) ;

			return true ;
		}

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}


	return true ;
}

GetAvailableStorageSlot ( veh_enum_id ) {

	new vehicleid = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ;
	new modelid = GetVehicleModel ( vehicleid );

	for ( new i, j = GetMaxStorageModel(modelid); i < j ; i ++ ) {

		if ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ i ] == -1 ) {

			return i ;
		}

		else continue ;
	}

	return -1;
}


Crate_Putdown_Vehicle(playerid, veh_enum_id, item_id ) {

	new vehicleid = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ;

	if ( ! IsValidVehicle(vehicleid) ) {

		return SendClientMessage(playerid, -1, "You're not near a valid compatible vehicle!");
	}

	new modelid = GetVehicleModel ( vehicleid ) ;

	if( ! IsTruckingVehicle( vehicleid ) ) {

		return SendClientMessage(playerid, -1, "This vehicle is not compatible with the trucking job.");
	}

	new storage = GetAvailableStorageSlot( veh_enum_id );

	if ( storage == -1 ) {

		return SendClientMessage(playerid, -1, "This vehicle has no storage slots left.");
	}


	if ( ! IsVehicleTanker ( vehicleid ) ) {
		switch (GetTrunkStatus ( vehicleid )) {

		    case false: return SendClientMessage(playerid, -1, "You have to open the trunk first if you want to store crates in it! To refund the crate, do /crate putdown at the wholesaler label.");
			case true: {

				new Float: pos_x, Float: pos_y, Float: pos_z ; 
				GetStorageOffset(vehicleid, storage, pos_x, pos_y, pos_z);

				VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ storage ] = item_id ;

				//new crate_model = Trucker_GetCrateModel ( PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] ) ; 
				//VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [storage] = CreateDynamicObject(crate_model, pos_x, pos_y, pos_z -10.0, 0.0, 0.0, 0.0);
				//VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [ storage ] = PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] ;
				//AttachDynamicObjectToVehicle(VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [storage], vehicleid, pos_x, pos_y, pos_z, 0.0, 0.0, 0.0);
			
				SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", sprintf("You've added the %s to the vehicle. Your vehicle has %d slots left.", 
					TruckerItem[item_id][E_WHOLESALER_ITEM_NAME], GetMaxStorageModel ( modelid ) - (storage + 1)
				) ) ;	

				PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = -1 ;
				PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = -1 ;
				PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = -1 ;

				PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
				PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 

				SetPlayerSpecialAction(playerid, 0);
				RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);

				ApplyAnimation(playerid, "carry", "putdwn", 4.0, 0, 1, 1, 1, 1, 1);
				defer Trucker_CancelAnim(playerid);
			}
		}
	}

	else if ( IsVehicleTanker ( vehicleid ) ) {

		new saved_trailer = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ], trailer_model ;

		if ( ! saved_trailer ) {

			trailer_model = GetRandomTrailerID(item_id) ;

			new Float: x, Float: y, Float: z, Float: a, car_color ;

			GetVehiclePos(vehicleid, x, y, z );
			GetVehicleZAngle(vehicleid, a );
			GetXYBackOfVehicle(vehicleid, x, y, 10.0);

			switch ( trailer_model ) {

				case 591: car_color = random ( 255 ) ; // random color
				default: car_color = 1 ; // white to keep normal textures
			}

			VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] = SOLS_CreateVehicle(trailer_model, x, y, z, a, car_color, car_color, 0);
			AttachTrailerToVehicle(VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ], Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
		}

		VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ storage ] = item_id ;
		VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [storage] = INVALID_OBJECT_ID ;
		VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [ storage ] = PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] ;

		SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", sprintf("You've added the %s to the trailer. Your trailer has %d slots left.", 
			TruckerItem[item_id][E_WHOLESALER_ITEM_NAME], GetMaxStorageModel ( modelid ) - (storage + 1)
		) ) ;	

		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = -1 ;

		PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
		PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 

		SetPlayerSpecialAction(playerid, 0);
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);

		ApplyAnimation(playerid, "carry", "putdwn", 4.0, 0, 1, 1, 1, 1, 1);
		defer Trucker_CancelAnim(playerid);
	}

	return true ;
}

Crate_Putdown_Wholesaler(playerid, wholesaler_id, item_id ) {
	//sell back to wholesaler
	if(IsWholesalerAcceptingGood(wholesaler_id, item_id))
	{

		SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", sprintf("You've sold back the %s to the wholesaler for $%s.",
		 	TruckerItem[item_id][E_WHOLESALER_ITEM_NAME], IntegerWithDelimiter ( TruckerItem[item_id][E_WHOLESALER_ITEM_PRICE])
		) ) ;	

		GivePlayerCash ( playerid,TruckerItem[item_id][E_WHOLESALER_ITEM_PRICE] ) ;


		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = -1 ;

		PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
		PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 

		SetPlayerSpecialAction(playerid, 0);
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);

		ApplyAnimation(playerid, "carry", "putdwn", 4.0, 0, 1, 1, 1, 1, 1);
		defer Trucker_CancelAnim(playerid);

		return true ;
	}

	else return SendClientMessage(playerid, -1, "They don't want these goods!");
}


Crate_Putdown_Store ( playerid, store_id, item_id ) {

	new reward = floatround ( TruckerItem[item_id][E_WHOLESALER_ITEM_PRICE] * 3.15, floatround_ceil);

	if(IsStoreAcceptingGood(store_id, item_id))
	{
		//get money reward

		SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", sprintf("You've sold a crate of %s to the %s store for $%s.",
		 	TruckerItem[item_id][E_WHOLESALER_ITEM_NAME], TruckingStores[store_id][E_TRUCK_STORE_DESC], IntegerWithDelimiter ( reward )
		) ) ;	

		GivePlayerCash(playerid, reward ) ;


		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = -1 ;

		PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
		PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 

		SetPlayerSpecialAction(playerid, 0);
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);

		ApplyAnimation(playerid, "carry", "putdwn", 4.0, 0, 1, 1, 1, 1, 1);
		defer Trucker_CancelAnim(playerid);

		return true ;
	}

	else return SendClientMessage(playerid, -1, "They don't want these goods!");
}
