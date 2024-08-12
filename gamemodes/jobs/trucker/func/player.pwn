CMD:crate(playerid, params[]) {


	SendClientMessage(playerid, COLOR_YELLOW, "[TEMP]: If /crate pickup does not show a dialog, use /cratetext instead.");
	if (PlayerVar[playerid][E_PLAYER_CRATE_COOLDOWN]  >= gettime ()) {
		
		new string[256];

		format(string, sizeof(string), "You need to wait %d seconds before using this command again.", PlayerVar[playerid][E_PLAYER_CRATE_COOLDOWN] - gettime ()) ;

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", string);
	}

	if(! strcmp(params, "pickup", true)) {

		Crate_Pickup(playerid) ;
	}

	else if(! strcmp(params, "putdown", true)) {

		Crate_Putdown(playerid) ;
	}

	else if(! strcmp(params, "list", true)) {
		if(IsPlayerInAnyVehicle(playerid)) {

			new string[3456], line[64], crate_type[10], vehicleid = GetPlayerVehicleID(playerid), count, veh_enum_id = Vehicle_GetEnumID(vehicleid);

			if(vehicleid == INVALID_VEHICLE_ID || veh_enum_id == -1) {
				return SendClientMessage(playerid, COLOR_ERROR, "You're not in any proper vehicle!");
			}

			new modelid = GetVehicleModel(vehicleid), item_id ;

			for(new idx = 0; idx < GetMaxStorageModel(modelid); idx++) {
				if(VehicleVar[veh_enum_id][E_VEHICLE_TRUCKER_ITEM][idx] > -1) {

					item_id = VehicleVar[veh_enum_id][E_VEHICLE_TRUCKER_ITEM][idx] ;

					if(item_id != -1) {
						if(IsLiquid(item_id)) crate_type = "Liquid"; 
						else if(IsBrokenMaterial(item_id)) crate_type = "Material"; 
						else if(IsFood(item_id)) crate_type = "Food"; 
						else crate_type = "Crate Box"; 

						format(line, sizeof(line), "%s (ID: %d)\tContent: {ffff00}%s\n", crate_type, idx, TruckerItem[item_id][E_WHOLESALER_ITEM_NAME]);
					}

					else format(line, sizeof(line), "Unknown (ID: %d)\tContent: {ffff00}Unknown\n", idx) ;

					strcat(string, line);

					count ++ ;
				}
			}

			inline TruckerBootInfo(pid, dialogid, response, listitem, string:inputtext[]) {
			    #pragma unused pid, response, dialogid, listitem, inputtext

				return true ;
			}

			Dialog_ShowCallback(playerid, using inline TruckerBootInfo, DIALOG_STYLE_TABLIST, "Trucker Trunk Storage", string, "OK", "");

			if(! count) {

				return SendClientMessage(playerid, -1, "Nothing found.") ;
			}
		}

		else return SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", "You can only do this command while inside of a vehicle.") ;
	}

	else if(! strcmp(params, "reset", true)) {

		if(PlayerVar[playerid][E_PLAYER_TRUCKER_CARRY_BOX] != -1) {

			ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);

			PlayerVar[playerid][E_PLAYER_TRUCKER_CARRY_BOX] = -1 ;
			PlayerVar[playerid][E_PLAYER_TRUCKER_CARRY_BOX_OBJ] = -1 ;

			new item, item_price, item_name[32] ;

			item = PlayerVar[playerid][E_PLAYER_TRUCKER_CARRY_BOX_ITEM] ;
			TruckerItem_GetName(item, item_name, sizeof(item_name)) ;
			item_price = TruckerItem_GetPrice(item) ;

			PlayerVar[playerid][E_PLAYER_TRUCKER_CARRY_BOX_ITEM] = -1 ;

			new string[128] ;

			format(string, sizeof(string), "You've reset your crate variables. You've been refunded $%s for your %s crate.", IntegerWithDelimiter(item_price), item_name) ; 
			SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", string) ;

			GivePlayerCash(playerid, item_price) ;

			SetPlayerSpecialAction(playerid, 0);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);
		}

		else return SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", "You aren't carrying a crate.") ;
	}

	else return SendClientMessage(playerid, -1, "/crate [pickup/putdown/list/reset] (warning: \"reset\" removes your carry data, without refund)") ;
	return true ;
}

CMD:cratetext(playerid, params[]) {
	new string[256];

	if (PlayerVar[playerid][E_PLAYER_CRATE_COOLDOWN]  >= gettime ()) {
		format(string, sizeof(string), "You need to wait %d seconds before using this command again.", PlayerVar[playerid][E_PLAYER_CRATE_COOLDOWN] - gettime ()) ;
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", string);
	}

	new choice[16], input;

	if(sscanf(params, "s[16]I(-1)", choice, input)) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "/cratetext[list/pickup][optional: index]");
	}

	// Check if the vehicle is valid, and the player is near it.
	new vehicleid = INVALID_VEHICLE_ID;
	if(!IsPlayerInAnyVehicle(playerid)) vehicleid = GetClosestVehicleEx(playerid, 7.5);

	if(vehicleid == INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	if(IsABike(vehicleid)) return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk!");
	if(!GetTrunkStatus(vehicleid) && !IsVehicleTanker(vehicleid)) return SendClientMessage(playerid, -1, "You have to open the boot!");

	new modelid = GetVehicleModel(vehicleid), count = 0, veh_enum_id = Vehicle_GetEnumID ( vehicleid );
	if ( vehicleid == INVALID_VEHICLE_ID || veh_enum_id == -1) {
		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	// Check if a valid choice was selected
	if(!strcmp(choice, "list", true)) {

		SendClientMessage(playerid, COLOR_YELLOW, "Truck Storage List");

		new item_id, crate_type[16];
		for(new idx; idx < GetMaxStorageModel(modelid); idx ++) {
			item_id = VehicleVar[veh_enum_id][E_VEHICLE_TRUCKER_ITEM][idx] ;
			count ++;

			if(item_id != -1) {
				if(IsLiquid(item_id))crate_type = "Liquid"; 
				else if(IsBrokenMaterial(item_id)) crate_type = "Material"; 
				else if(IsFood(item_id)) crate_type = "Food"; 
				else crate_type = "Crate Box"; 

				format(string, sizeof(string), "%s (ID: %d):{ffff00}%s", crate_type, idx, TruckerItem[item_id][E_WHOLESALER_ITEM_NAME]);
				SendClientMessage(playerid, 0xDEDEDEFF, string);
			}
		}

		if(!count) {
			SendClientMessage(playerid, COLOR_ERROR, "Nothing found.");
		}
	}
	else if(!strcmp(choice, "pickup", true)) {
		if(input < 0 || input > 64) {
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You must enter a valid index (0-54): /cratetext pickup [index]");
		}

		if(VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ input ] > -1) {
			new item_id = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ input ];
			PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = true ;
			PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [ input ];
			PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ input ] ;

			VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ input ] = -1 ;
			VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [ input ] = -1 ;

			SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", sprintf("You've picked up a crate of %s from the vehicle. Use /transport to find a buyer.", TruckerItem[item_id] [E_WHOLESALER_ITEM_NAME]) ) ;

			ApplyAnimation(playerid, "carry", "liftup", 4.0, 0, 1, 1, 1, 1, 1);

			defer Trucker_PlayerCarryBox[500](playerid, 0);
			defer Trucker_PlayerCarryBox[700](playerid, 1);

			// If last slot, remove the trailer.
			if ( ! GetAvailableStorageSlot( veh_enum_id ) ) {
				Trucker_RemoveTrailer(playerid, vehicleid, veh_enum_id ) ;
			}

			PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
			PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 
		}

		else return SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", "This slot is empty!" ) ;
	}

	return 1;
}



CMD:trailerreset(playerid) { return cmd_resettrailer(playerid); }

CMD:resettrailer(playerid) {

	if (!IsPlayerInAnyVehicle(playerid)) {
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in a vehicle.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if(!IsVehicleTanker(vehicleid)) {
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in a truck.");
	}

	if(!VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ]) {
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trailer linked to it.");
	}

	Trucker_RemoveTrailer(playerid, vehicleid, veh_enum_id ) ;

	SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", "Your trailer has been removed. A new one will be created in 5 seconds.") ;
	SendClientMessage(playerid, 0xDEDEDEFF, "Make sure you're in a location with enough space!") ;

	defer CreateNewTrailer[5000](playerid, vehicleid, veh_enum_id);
	return true;
}

timer CreateNewTrailer[5000](playerid, vehicleid, veh_enum_id ) {

	if (!IsValidVehicle(vehicleid)) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Something went wrong. Please try again.") ;
	}

	if (!IsPlayerInAnyVehicle(playerid)) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You left the truck! Get back in and try again.") ;
	}

	if (GetPlayerVehicleID(playerid) != vehicleid) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You need to stay in the same truck for the trailer to respawn.") ;
	}

	/*if (!GetAvailableStorageSlot(veh_enum_id)) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Your trailer's empty. Load some crates to spawn a new one.") ;
	}*/

	if(!IsVehicleTanker(vehicleid)) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't attach a trailer to this vehicle!") ;
	}

	new storage = GetAvailableStorageSlot( veh_enum_id );

	new item_id = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ storage ] ;
	new trailer_model = GetRandomTrailerID(item_id) ;

	new Float: x, Float: y, Float: z, Float: a, car_color ;

	GetVehiclePos(vehicleid, x, y, z );
	GetVehicleZAngle(vehicleid, a );
	GetXYBackOfVehicle(vehicleid, x, y, 10.0);

	switch ( trailer_model ) {

		case 591: car_color = random ( 255 ) ; // random color
		default: car_color = 1 ; // white to keep normal textures
	}

	VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ] = SOLS_CreateVehicle(trailer_model, x, y, z, a, car_color, car_color, 0);

	defer DelayAttachTrailerToVehicle[1000](playerid, vehicleid, VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_TRAILER ]) ;

	return true ;
}


timer DelayAttachTrailerToVehicle[1000](playerid, vehicleid, trailerid) {

	if(IsVehicleStreamedIn(trailerid, playerid)) {

		AttachTrailerToVehicle(trailerid, vehicleid) ;
		SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", "A new trailer has been created.") ;

	} else SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", "The trailer couldn't be created. Please try again.") ;

	return true;

}