#define SCRAPYARD_POS_X 2269.2249
#define SCRAPYARD_POS_Y -2126.1326
#define SCRAPYARD_POS_Z 13.2763

#define SCRAPYARD_BOAT_POS_X 2532.5679
#define SCRAPYARD_BOAT_POS_Y -2272.2878
#define SCRAPYARD_BOAT_POS_Z -0.5721

#define SCRAPYARD_AIR_POS_X 2108.2424
#define SCRAPYARD_AIR_POS_Y -2437.9275
#define SCRAPYARD_AIR_POS_Z 13.2744

#define SCRAPYARD_PICKUP_MODEL 851
#define SCRAPYARD_MAP_ICON	37

ScrapYard_LoadEntities() {

	print(" * [SCRAPYARD] Loaded vehicle scrapyards (land, boat, air).") ;

	CreateDynamic3DTextLabel("[Vehicle Scrap Location]\n{DEDEDE}Available commands: /carscrap",
		COLOR_BLUE, SCRAPYARD_POS_X, SCRAPYARD_POS_Y, SCRAPYARD_POS_Z, 15.0 
	);

	CreateDynamicPickup(SCRAPYARD_PICKUP_MODEL, 1,  SCRAPYARD_POS_X, SCRAPYARD_POS_Y, SCRAPYARD_POS_Z ) ;
	CreateDynamicMapIcon(SCRAPYARD_POS_X, SCRAPYARD_POS_Y, SCRAPYARD_POS_Z, SCRAPYARD_MAP_ICON, 0 );


	CreateDynamic3DTextLabel("[Boat Scrap Location]\n{DEDEDE}Available commands: /carscrap",
		COLOR_BLUE, SCRAPYARD_BOAT_POS_X, SCRAPYARD_BOAT_POS_Y, SCRAPYARD_BOAT_POS_Z, 15.0 
	);

	CreateDynamicPickup(SCRAPYARD_PICKUP_MODEL, 1,  SCRAPYARD_BOAT_POS_X, SCRAPYARD_BOAT_POS_Y, SCRAPYARD_BOAT_POS_Z ) ;
	CreateDynamicMapIcon(SCRAPYARD_BOAT_POS_X, SCRAPYARD_BOAT_POS_Y, SCRAPYARD_BOAT_POS_Z, SCRAPYARD_MAP_ICON, 0 );


	CreateDynamic3DTextLabel("[Airplane Scrap Location]\n{DEDEDE}Available commands: /carscrap",
		COLOR_BLUE, SCRAPYARD_AIR_POS_X, SCRAPYARD_AIR_POS_Y, SCRAPYARD_AIR_POS_Z, 15.0 
	);

	CreateDynamicPickup(SCRAPYARD_PICKUP_MODEL, 1,  SCRAPYARD_AIR_POS_X, SCRAPYARD_AIR_POS_Y, SCRAPYARD_AIR_POS_Z ) ;
	CreateDynamicMapIcon(SCRAPYARD_AIR_POS_X, SCRAPYARD_AIR_POS_Y, SCRAPYARD_AIR_POS_Z, SCRAPYARD_MAP_ICON, 0 );


	return true ;
}

CMD:carscrap(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
    if ( IsABoat ( GetPlayerVehicleID ( playerid ) ) ) {

    	if ( ! IsPlayerInRangeOfPoint(playerid, 2.5, SCRAPYARD_BOAT_POS_X , SCRAPYARD_BOAT_POS_Y , SCRAPYARD_BOAT_POS_Z ) ) {

			GPS_MarkLocation(playerid, "The ~r~boat scrapyard~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_SCRIPT, 
				SCRAPYARD_BOAT_POS_X, SCRAPYARD_BOAT_POS_Y, SCRAPYARD_BOAT_POS_Z ) ;
			return true ;

    	}
    }

    else if ( IsAircraft ( GetPlayerVehicleID ( playerid ) ) ) {
    	if ( ! IsPlayerInRangeOfPoint(playerid, 2.5, SCRAPYARD_AIR_POS_X , SCRAPYARD_AIR_POS_Y , SCRAPYARD_AIR_POS_Z ) ) {

			GPS_MarkLocation(playerid, "The ~r~airplane scrapyard~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_SCRIPT, 
				SCRAPYARD_AIR_POS_X, SCRAPYARD_AIR_POS_Y, SCRAPYARD_AIR_POS_Z ) ;
			return true ;

    	}
    }

    else {
		if ( ! IsPlayerInRangeOfPoint(playerid, 2.5,  SCRAPYARD_POS_X, SCRAPYARD_POS_Y, SCRAPYARD_POS_Z) ) {

			GPS_MarkLocation(playerid, "The ~r~scrapyard~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_SCRIPT, SCRAPYARD_POS_X, SCRAPYARD_POS_Y, SCRAPYARD_POS_Z ) ;
			return true ;
		}

	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (!IsPlayerInAnyVehicle(playerid)) {
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");
	}

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {
		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_PLAYER ) {
			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

				return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
			}
		}

		else {

			return SendClientMessage(playerid, COLOR_ERROR, "Only player owned vehicles can be transfered.");
		}
	}

	static CarScrapStr[1024];

	inline CarScrap_Confirm(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext, listitem, response

		if ( ! response ) {

			return true ;
		}

		else if ( response ) {

			JT_RemovePlayerFromVehicle(playerid);

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof ( query), "DELETE FROM `vehicles` WHERE vehicle_sqlid = %d ", Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] );
			mysql_tquery(mysql, query); 

			Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] = INVALID_VEHICLE_ID ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] = INVALID_PLAYER_ID ;

			if ( IsValidVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ) ) {

				
				SOLS_DestroyVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ) ;
				Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] = INVALID_VEHICLE_ID ;
			}

			new scrap_money ;

			for ( new i, j = sizeof ( DealershipCars ); i < j ; i ++ ) {

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID ] == DealershipCars [ i ] [ dealercar_carmodel ] ) {

					scrap_money = DealershipCars [ i ] [ dealercar_price ] / 2 ;
				}
			}

			if ( scrap_money == 0 ) {

				scrap_money = 150 + random ( 450 ) ;
			}

		 	SendClientMessage(playerid, COLOR_ERROR, sprintf("You've scrapped your vehicle. You've received %s in scrap change.", IntegerWithDelimiter(scrap_money)));

		 	GivePlayerCash ( playerid, scrap_money ) ; 
	
			return true ;
		}
	}

	format(CarScrapStr, sizeof(CarScrapStr), "{EC9424}Warning! {DEDEDE}This is a destructive action!");

	strcat(CarScrapStr, "\n\n{DEDEDE}You are about to scrap and {EC9424}SELL{DEDEDE} your vehicle.");
	strcat(CarScrapStr, "\n{DEDEDE}You will only be refunded a 1/2 of the price you bought it for.");
	strcat(CarScrapStr, "\n{DEDEDE}If you want to sell it to someone, use /carsell.");
	strcat(CarScrapStr, "\n\n{DEDEDE}Are you sure you want to continue?");
	strcat(CarScrapStr, "\n{f1c38a}You will not be refunded if you change your mind.");

	Dialog_ShowCallback ( playerid, using inline CarScrap_Confirm, DIALOG_STYLE_MSGBOX, "{EC9424}SCRAP WARNING{DEDEDE}", CarScrapStr, "Scrap it", "Cancel" );


	return true ;
}

// probably not the best place to put this but if i added it in admin/vehicle.pwn it would not want to work.

CMD:deletecar(playerid, params[]) {

    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL )
        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    new carid;

    if ( sscanf ( params, "i", carid ) ){
        SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/deletecar [vehicleid]") ;
        return SendServerMessage(playerid, COLOR_ERROR, "WARNING", "A3A3A3", "This command permanently deletes the car. Use carefully.");
    }

    if (!IsValidVehicle(carid))
        return SendClientMessage(playerid, COLOR_ERROR, "This is not a valid vehicle ID.");

    new veh_enum_id = Vehicle_GetEnumID ( carid );

    new query [ 256 ] ;

    mysql_format(mysql, query, sizeof ( query), "DELETE FROM `vehicles` WHERE vehicle_sqlid = %d ", Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] );
    mysql_tquery(mysql, query); 

    Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] = INVALID_VEHICLE_ID ;
    Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] = INVALID_PLAYER_ID ;

    if ( IsValidVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ) ) {
                
        SOLS_DestroyVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ) ;
        Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] = INVALID_VEHICLE_ID ;
    }
    
    SendClientMessage(playerid, COLOR_ERROR, sprintf("You've deleted a %s with ID %d.", ReturnVehicleName(carid), carid));
    SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s has deleted a vehicle with ID %d.", playerid, ReturnMixedName(playerid), carid));

    return true ;
}
