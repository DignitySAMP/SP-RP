new TruckerStoragePage [ MAX_PLAYERS ] ;

Crate_Pickup(playerid) {
	if(PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] != -1) return SendClientMessage(playerid, -1, "You're already carrying something!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "You're supposed to be on foot!");


	new wholesaler_id = Wholesaler_GetClosestPoint(playerid);
	if(wholesaler_id != -1) {

		Crate_Pickup_Wholesaler ( playerid, wholesaler_id ) ;
	}
 
	else {  //check for vehicle
	
		new vehicleid = INVALID_VEHICLE_ID;

		if ( ! IsPlayerInAnyVehicle(playerid) ) {
			vehicleid = GetClosestVehicleEx(playerid, 7.5);
		}

		else vehicleid = GetPlayerVehicleID(playerid);



		if ( vehicleid == INVALID_VEHICLE_ID ) {

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

			//Crate_Pickup_Vehicle(playerid, vehicleid ) ;

			ShowVehicleStorageList ( playerid, vehicleid);

			return true ;
		}

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	return true ;
}


Crate_Pickup_Wholesaler(playerid, wholesaler_id) {

	new string[720], line[144], index ;

	strcat(string, "Item Name \t Item Price\n");

	for(new g = 0; g < 5; g++) {

		index = Wholesalers [ wholesaler_id ] [E_WHOLESALERS_INVENTORY ] [ g ] ;

		if( index > 0 ) {

			format(line, sizeof(line), "{bfbfbf}%s\t{ffff99}Price: $%d\n", 
				TruckerItem[index][E_WHOLESALER_ITEM_NAME], 
				TruckerItem[index][E_WHOLESALER_ITEM_PRICE]
			);

			strcat(string, line);
		}
	}

	inline TruckerMenu_Wholesaler(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, response, dialogid, listitem, inputtext

		if(response) {

			new count = 0;

			for(new g = 0; g < 5; g++) {

				if(Wholesalers[wholesaler_id][E_WHOLESALERS_INVENTORY][g] > 0) {

					if(count == listitem) {

						new item = Wholesalers [ wholesaler_id ] [E_WHOLESALERS_INVENTORY ] [ g ] ;
						new fee = TruckerItem [ item ] [ E_WHOLESALER_ITEM_PRICE ] ;

						if ( GetPlayerCash ( playerid ) < fee ) {
							return SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", sprintf("You need at least $%s for this item.", IntegerWithDelimiter ( fee ) ) ) ;
						}

						SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", 
							sprintf("You've bought a crate of %s for $%s. Use /transport to find a buyer.", 
								TruckerItem [ item ] [ E_WHOLESALER_ITEM_NAME ], 
								IntegerWithDelimiter ( fee)
							) ) ;

						TakePlayerCash ( playerid, fee ) ;

						PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = true ;
						
						PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = item ;
						PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = random(13);

						ApplyAnimation(playerid, "carry", "liftup", 4.0, 0, 1, 1, 1, 1, 1);

						defer Trucker_PlayerCarryBox[500](playerid, 0);
						defer Trucker_PlayerCarryBox[700](playerid, 1);

						PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
						PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 
						
						break;
					}

					else count ++;
				}
			}
		}

		return true ;
	}

	Dialog_ShowCallback ( playerid, using inline TruckerMenu_Wholesaler, DIALOG_STYLE_TABLIST_HEADERS, "Buy Goods", string, "Buy", "Cancel" );

	return true ;
}

ShowVehicleStorageList ( playerid, vehicleid) {

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( vehicleid == INVALID_VEHICLE_ID || veh_enum_id == -1) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	new modelid = GetVehicleModel ( vehicleid ) ;

	switch (GetTrunkStatus ( vehicleid )) {

		case false: {
			if ( ! IsVehicleTanker ( vehicleid ) ) {
				return SendClientMessage(playerid, -1, "You have to open the boot!");
			}
		}
	}

	if ( !TruckerStoragePage [ playerid ] ) {
		TruckerStoragePage [ playerid ] = 1 ;
	}

	new MAX_ITEMS_ON_PAGE = 5, string [ 1024 ], bool: nextpage, line [ 128 ], item_id, crate_type [ 64 ] ;
	new resultcount = ( ( MAX_ITEMS_ON_PAGE * TruckerStoragePage [ playerid ] ) - MAX_ITEMS_ON_PAGE ) ;

    for ( new idx = resultcount; idx < GetMaxStorageModel(modelid); idx ++ ) {
    	
        resultcount ++;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * TruckerStoragePage [ playerid ] ) {

 	        //if(VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ idx ] > -1) {

				item_id = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ idx ] ;

				if ( item_id != -1 ) {
					if(IsLiquid(item_id)) { 

						crate_type = "Liquid"; 
					}

					else if(IsBrokenMaterial(item_id)) { 

						crate_type = "Material"; 
					}
					else if(IsFood(item_id)) { 

						crate_type = "Food"; 
					}
					else { 

						crate_type = "Crate"; 
					}

					format(line, sizeof(line), "%s (ID: %d)\t{ffff00}%s\n", crate_type, idx, 
						TruckerItem[item_id][E_WHOLESALER_ITEM_NAME]
					);
				}

				else format ( line, sizeof ( line ), "Empty (ID: %d)\t{ffff00}None\n", idx ) ;

				strcat(string, line);
			//}
        }

        if ( resultcount > MAX_ITEMS_ON_PAGE * TruckerStoragePage [ playerid ] ) {

            nextpage = true ;
            break ;
        }


	    else continue ;
    }

	new pages = floatround ( GetMaxStorageModel(modelid) / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline TruckPickupStorage(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if ( ! response ) {

			if ( TruckerStoragePage [ playerid ] > 1 ) {

				TruckerStoragePage [ playerid ]  -- ;
				return ShowVehicleStorageList ( playerid, vehicleid ) ;
			}
		}

		else if ( response ) {

			if ( listitem == MAX_ITEMS_ON_PAGE) {

				TruckerStoragePage [ playerid ] ++ ;
				return ShowVehicleStorageList ( playerid, vehicleid ) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {

				new selection = ( ( MAX_ITEMS_ON_PAGE * TruckerStoragePage [ playerid ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

				if(VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ selection ] > -1) {

					PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = true ;
					PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_OBJ ] = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [ selection ];
					PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] = VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ selection ] ;

					// Overwriting the old value to new one!
					item_id = PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX_ITEM ] ;


					VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_ITEM ] [ selection ] = -1 ;
					VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_MODEL ] [ selection ] = -1 ;

					/*
					if ( IsValidDynamicObject( VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [ selection ] ) ) {

						SOLS_DestroyObject( VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [ selection ], "Trucking/Crate_Pickup_Vehicle", true ) ;
						VehicleVar [ veh_enum_id ] [ E_VEHICLE_TRUCKER_OBJECT ] [ selection ] = INVALID_OBJECT_ID ;
					}
					*/

					SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", 
						sprintf("You've picked up a crate of %s from the vehicle. Use /transport to find a buyer.", 
							TruckerItem[item_id] [E_WHOLESALER_ITEM_NAME]
					) ) ;

					ApplyAnimation(playerid, "carry", "liftup", 4.0, 0, 1, 1, 1, 1, 1);

					defer Trucker_PlayerCarryBox[500](playerid, 0);
					defer Trucker_PlayerCarryBox[700](playerid, 1);
		
					// If last slot, remove the trailer.
					if ( ! GetAvailableStorageSlot( veh_enum_id ) ) {
						
						Trucker_RemoveTrailer(playerid, vehicleid, veh_enum_id ) ;
					}

					PlayerVar [ playerid ] [ E_PLAYER_CRATE_COOLDOWN ] = gettime () + 1 ;
					PlayerVar [ playerid ] [ E_PLAYER_CRATE_TIME] = gettime (); 

					//break ;
				}

				else {

					SendServerMessage(playerid, COLOUR_JOB, "Trucker", "DEDEDE", 
						"This slot is empty!" ) ;

					//break ;
				}
			}
		}
	}

	new title [ 36 ] ;
	
	format ( title, sizeof ( title ), "Trucking Storage: Page %d of %d", TruckerStoragePage [ playerid ], pages) ;

	if ( TruckerStoragePage [ playerid ] > 1 ) {
   		Dialog_ShowCallback ( playerid, using inline TruckPickupStorage, DIALOG_STYLE_TABLIST, title, string, "View", "Previous" );
   	}
   	else Dialog_ShowCallback ( playerid, using inline TruckPickupStorage, DIALOG_STYLE_TABLIST, title, string, "View", "Close" );
 
   	return true ;
}
