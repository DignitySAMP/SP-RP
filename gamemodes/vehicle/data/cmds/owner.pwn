
new bool: HasActiveVehicleOffer[MAX_PLAYERS];

CMD:spawncar(playerid, params[]) {

	return cmd_carspawn(playerid, params);
}

CMD:carspawn(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new saved_id ;

	if ( sscanf ( params, "i", saved_id ) ) {

		//return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/carspawn [saved-id] (taken from /mycars)");
		ShowPlayerCarsToPlayer(playerid, playerid, true);
		return true;
	} 

	new veh_enum_id = Vehicle_GetEnumIDFromSQLID ( saved_id ) ;

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You've passed an invalid vehicle.");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_PLAYER ) {
		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
		}
	}

	else return SendClientMessage(playerid, COLOR_ERROR, "This isn't a player vehicle.");

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle is already spawned.");
	}

	if ( IsValidVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ])) {

		return SendClientMessage(playerid, COLOR_ERROR, sprintf("Error: enum vehicle ID already exists. Use /carfind."));
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = SOLS_CreateVehicle(	Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ],
		Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], -1
	) ;

	Temp_SetVehicleEnumId(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], veh_enum_id);

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] <= 250.0 ) {

		SOLS_SetVehicleHealth ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], 300 ); 
	}

	else SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] );

	SetVehicleNumberPlate(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_LICENSE ] ) ;

	SetEngineStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_ENGINE ]);
	SetDoorStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ]);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] = true ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ]		= true ;
	ChangeVehiclePaintjob(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ] ) ;
	Tune_ApplyComponents(playerid, veh_enum_id );
	Vehicle_ClearRuntimeVariables(veh_enum_id);
	Vehicle_ClearTruckerVariables(veh_enum_id);
	Scanner_Reset(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]);

	cmd_carfind(playerid, sprintf("%d", Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) ;

	UpdateVehicleDamageStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ], 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] );

	
	if ( IsValidDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ) {

		DestroyDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
	}

	SOLS_ResetVehicleSirens(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]);

	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Spawned their %s (VID: %d, SQLID: %d)", ReturnVehicleName(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]), Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ));

	return true ;
}

CMD:carpark(playerid, params[]) {

	return cmd_cardespawn(playerid, params);
}

static CarParkDlgStr[2048];

CMD:cardespawn(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if ( ! IsPlayerInAnyVehicle(playerid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle for this to work.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a proper vehicle.");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_PLAYER ) {
		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
		}
	}

	else return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");

	new Float: health ;
	GetVehicleHealth(vehicleid, health ) ;

	Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] = health ;
	
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ] 	= panels ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ] 	= doors ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ] 	= lights ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ] 	= tires ;
	

	new Float: x, Float: y, Float: z, Float: a  ;

	GetVehiclePos(vehicleid, x, y, z );
	GetVehicleZAngle(vehicleid, a ) ;

	new cost = 0;
	/*
	new Float:distance = GetDistanceBetweenPoints(x, y, z, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ]);
	if (distance > 50.0 && Vehicle [ veh_enum_id ] [ E_VEHICLE_PARKED_AT ])
	{
		new ago = gettime() - Vehicle [ veh_enum_id ] [ E_VEHICLE_PARKED_AT ];

		if (ago < 86400) // 24 hours between free cardespawns
		{
			cost = 250 * ((86400 - ago) / 3600); // $250 per hour.
		}
	}
	*/

	inline CarParkDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

		if (response)
		{
			if (cost)
			{
				if (GetPlayerCash(playerid) < cost) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You don't have $%s in cash.", IntegerWithDelimiter(cost)));
				TakePlayerCash(playerid, cost);
			}

			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ] = x ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ] = y ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] = z ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ] = a ;

			Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] = false ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_PARKED_AT ] = gettime();
		
			Vehicle_ClearRuntimeVariables(veh_enum_id);
			Vehicle_ClearTruckerVariables(veh_enum_id);
			Scanner_Reset(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]);

			new ALARM_SLOT = 1 ;
			if ( IsObjectInVehicleSlot(vehicleid, ALARM_SLOT ) ) {
				RemoveObjectFromVehicleSlot ( vehicleid, ALARM_SLOT );
			}

			if ( IsTrailerAttachedToVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {

				SOLS_DestroyVehicle ( GetVehicleTrailer(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]) ) ;
			}

			
			if ( IsValidDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ) {

				DestroyDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
			}

			if ( IsValidVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]  ) ) {

				SOLS_DestroyVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
			}

			new oldvehid = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ];
			new oldmodel = GetVehicleModel(oldvehid);

			Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = -1 ;

			new query [ 512 ] ; 

			mysql_format(mysql, query, sizeof ( query ), "UPDATE vehicles SET vehicle_dmg_panels = %d, vehicle_dmg_doors = %d, vehicle_dmg_lights = %d, vehicle_dmg_tires = %d, vehicle_health = '%f', vehicle_pos_x = '%f', vehicle_pos_y = '%f', vehicle_pos_z = '%f', vehicle_pos_a = '%f' WHERE vehicle_sqlid = %d",
				Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ],
			
				Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], 
				Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], 
				Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] 
			) ;

			mysql_tquery ( mysql, query ) ;

			mysql_format ( mysql, query, sizeof ( query ), "UPDATE vehicles SET vehicle_mileage = %d, vehicle_parked_at = %d WHERE vehicle_sqlid = %d",
				Vehicle [ veh_enum_id ] [ E_VEHICLE_MILEAGE ],  Vehicle [ veh_enum_id ] [ E_VEHICLE_PARKED_AT ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] 
			) ;

			mysql_tquery(mysql, query);

			SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle", "A3A3A3", "You've despawned your vehicle. It's location has been saved.");

			// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
			AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Parked their %s (VID: %d, SQLID: %d)", ReturnVehicleModelName(oldmodel), oldvehid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ));
		}
    }
	
	format(CarParkDlgStr, sizeof(CarParkDlgStr), "{FFFFFF}You are about to {AA3333}park and despawn{FFFFFF} your %s.", ReturnVehicleName(vehicleid));

	strcat(CarParkDlgStr, "\n\n{FFFFFF}Parking the vehicle will:{ADBEE6}");
	strcat(CarParkDlgStr, "\n- Set the vehicle's spawn location to where it is right now.");
	strcat(CarParkDlgStr, "\n- Save the contents, condition and fuel of your vehicle.");
	strcat(CarParkDlgStr, "\n- Despawn your vehicle from the game world until you spawn it again.\n\n");

	if (cost)
	{
		strcat(CarParkDlgStr, "{FFFFFF}You are parking your vehicle at a new location, and have already done so in the last 24 hours.");
		strcat(CarParkDlgStr, sprintf("\n{ADBEE6}To discourage abuse, you will be charged $%s to re-park your vehicle here.\n", IntegerWithDelimiter(cost)));
		strcat(CarParkDlgStr, sprintf("\n{FFFFFF}Press {AA3333}OK{FFFFFF} to park and despawn the vehicle for {AA3333}$%s{FFFFFF}.", IntegerWithDelimiter(cost)));
	}
	else
	{
		strcat(CarParkDlgStr, "{FFFFFF}Press {AA3333}OK{FFFFFF} to park and despawn the vehicle.");
	}
    
    
	strcat(CarParkDlgStr, "\n{ADBEE6}You should not do this during active roleplay or if the vehicle is in use by anyone.");
	Dialog_ShowCallback ( playerid, using inline CarParkDlg, DIALOG_STYLE_MSGBOX, "Vehicle Despawn", CarParkDlgStr, "OK", "Back" );
	return true;
}


CMD:cargive(playerid, params[] ) {

	return cmd_cartransfer(playerid, params);
}

CMD:sellcar(playerid, params[]) return cmd_carsell(playerid, params);
CMD:vsell(playerid, params[]) return cmd_carsell(playerid, params);

CMD:carsell(playerid, params[]){

	if (HasActiveVehicleOffer[playerid]){
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You already have sent an active offer to someone.") ;
	}

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");

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

	new targetid, price ;

	if ( sscanf ( params, "k<player>i", targetid, price ) ) {

		SendClientMessage(playerid, COLOR_ERROR, "/carsell [playerid] [price]" ) ;
		return SendClientMessage(playerid, COLOR_ERROR, "INFO: This command SELLS your car. Use /cartransfer if you want to transfer it for free.");
	}

	if(targetid == playerid)
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You can't sell your car to yourself." );

	if ( ! IsPlayerConnected(targetid ) || !IsPlayerNearPlayer(playerid, targetid, 10.0) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Target isn't online.");
	}


	if ( Player_GetOwnedVehicles ( targetid ) >= Player_GetMaxOwnedVehicles ( targetid ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your targetid doesn't have any vehicle ownership slots left." );
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any vehicle ownership slots left. Use /myslots to check." );
	}

	if(price <= 0) 
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't sell your car for $0. Use /cartransfer to transfer it for free instead." );

	if(price > Character[targetid][E_CHARACTER_CASH])
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Your target doesn't have that much cash on hand.");
	

	SendClientMessage(playerid, COLOR_INFO, sprintf("[SELL] {DEDEDE}You have sent %s an offer to buy your %s for {32CD32}$%s{DEDEDE}.", ReturnSettingsName(targetid, playerid), ReturnVehicleName(vehicleid), IntegerWithDelimiter(price)));
	SendClientMessage(targetid, COLOR_INFO, sprintf("[BUY] {DEDEDE}%s has sent you an offer to buy their %s for {32CD32}$%s{DEDEDE}.", ReturnSettingsName(playerid, targetid), ReturnVehicleName(vehicleid), IntegerWithDelimiter(price)));

	HasActiveVehicleOffer[playerid] = true;

	inline CarSellConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) {

			HasActiveVehicleOffer[playerid] = false;

			SendClientMessage(playerid, COLOR_INFO, sprintf("[SELL] {DEDEDE}%s has {db1233}declined{DEDEDE} your offer to buy your %s.", ReturnSettingsName(targetid, playerid), ReturnVehicleName(vehicleid)));
			SendClientMessage(targetid, COLOR_INFO, sprintf("[BUY] {DEDEDE}You have {db1233}declined{DEDEDE} %s's offer to buy their %s.", ReturnSettingsName(playerid, playerid), ReturnVehicleName(vehicleid)));

	    	return false ;
		}

		if ( response ) {

			HasActiveVehicleOffer[playerid] = false;

			Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] = Character [ targetid ] [ E_CHARACTER_ID ] ;

			JT_RemovePlayerFromVehicle(playerid);

			SendClientMessage(playerid, COLOR_INFO, sprintf("[SELL] {DEDEDE}You've sold your %s to (%d) %s for {32CD32}$%s{DEDEDE}.", ReturnVehicleName(vehicleid), targetid, ReturnSettingsName(targetid, playerid), IntegerWithDelimiter(price))) ;
			SendClientMessage(targetid, COLOR_INFO, sprintf("[BUY] {DEDEDE}You've bought (%d) %s's %s for {32CD32}$%s{DEDEDE}.", playerid, ReturnSettingsName (playerid, targetid), ReturnVehicleName(vehicleid), IntegerWithDelimiter(price))) ;

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_owner = %d WHERE vehicle_sqlid = %d", 
				Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) ;

			mysql_tquery(mysql, query );

			TakePlayerCash(targetid, price);
			GivePlayerCash(playerid, price);

			new vehid = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ];
			
			// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for both
			AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Sold their %s to %s (VID: %d, SQLID: %d)", ReturnVehicleName(vehid), ReturnMixedName(targetid), vehid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ));
			AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Bought a %s from %s (VID: %d, SQLID: %d)", ReturnVehicleName(vehid), ReturnMixedName(playerid), vehid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ));

			if(price <= 1000) {
				SendAdminMessage(sprintf("(%d) %s has sold their %s (ID %d) to (%d) %s for a very small price ( < $1000 ).", playerid, ReturnMixedName(playerid), ReturnVehicleName(vehicleid), vehicleid, targetid, ReturnMixedName(targetid)));
			}

			return true ;
		}
	}

	new confirmstring [ 1024 ] ;

	format(confirmstring, sizeof(confirmstring), "{DEDEDE}{ed7f2b}(%d) %s{DEDEDE} is offering to sell you their {ed7f2b}%s{DEDEDE}.\n\n", playerid, ReturnSettingsName(playerid, targetid), ReturnVehicleName(vehicleid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Seller: {DEDEDE}%s\n", confirmstring, ReturnSettingsName(playerid, targetid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Buyer: {DEDEDE}%s\n", confirmstring, ReturnSettingsName(targetid, playerid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Vehicle: {DEDEDE}%s\n", confirmstring, ReturnVehicleName(vehicleid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Price: {32CD32}$%s\n\n", confirmstring, IntegerWithDelimiter(price));
	strcat(confirmstring, "{DEDEDE}Make sure the car details and price are correct.\n");
	strcat(confirmstring, "Press {A3A3A3}Accept {DEDEDE}to confirm the sale.");

	Dialog_ShowCallback ( targetid, using inline CarSellConfirm, DIALOG_STYLE_MSGBOX, "{A3A3A3}CAR PURCHASE CONFIRMATION", confirmstring, "Accept", "Decline" );

	return true;
}

CMD:cartransfer(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");

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

	new targetid, reason[128] ;

	if ( sscanf ( params, "k<player>s[128]", targetid, reason  ) ) {

		SendClientMessage(playerid, COLOR_ERROR, "/cartransfer [playerid] [reason]" ) ;
		return SendClientMessage(playerid, COLOR_ERROR, "INFO: This command TRANSFERS your car. Use /carsell if you want to sell it.");

	}

    if (!IsPlayerConnected(targetid) || !IsPlayerNearPlayer(playerid, targetid, 10.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The specified player is disconnected or not near you.");
    }

	if ( Player_GetOwnedVehicles ( targetid ) >= Player_GetMaxOwnedVehicles ( targetid ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your targetid doesn't have any vehicle ownership slots left." );
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any vehicle ownership slots left. Use /myslots to check." );
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] = Character [ targetid ] [ E_CHARACTER_ID ] ;

	JT_RemovePlayerFromVehicle(playerid);

	SendClientMessage(playerid, -1, sprintf("You've given your vehicle with ID %d to (%d) %s.",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ], targetid, ReturnSettingsName ( targetid, playerid ) )) ;

	SendClientMessage(targetid, -1, sprintf("You've received vehicle ID %d from player (%d) %s.",
		Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ], playerid,  ReturnSettingsName ( playerid, targetid )  )) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_owner = %d WHERE vehicle_sqlid = %d", 
		Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) ;

	mysql_tquery(mysql, query );

	new vehid = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ];
	
	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for both
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Transferred their %s to %s for reason: %s (VID: %d, SQLID: %d)", ReturnVehicleName(vehid), ReturnMixedName(targetid), reason, vehid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ));
	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Received a %s from %s for reason %s (VID: %d, SQLID: %d)", ReturnVehicleName(vehid), ReturnMixedName(playerid), reason, vehid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] ));

	SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s has transferred their car to (%d) %s for reason: %s", playerid, ReturnMixedName(playerid), targetid, ReturnMixedName(targetid), reason));

	return true ;
}

static MyCarsDlgStr[4096];

static ShowPlayerCarsToPlayer(playerid, showplayerid, bool:forspawn = false, bool:forfind = false, bool:fortow=false)
{
	new cardlgmap[100];
	new count = 0;

	if (forspawn || forfind || fortow)
	{	
		format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "ID\tModel\tColors\tLocation\n");
	}
	else
	{
		format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "ID\tSpawned\tModel\tLocation\n");
	}
	

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) 
	{
		if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_PLAYER ) 
		{
			continue;
		}

		if ( Vehicle [ i ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) 
		{
			continue;
		}

		new Float: x = Vehicle [ i ] [ E_VEHICLE_POS_X ], Float: y = Vehicle [ i ] [ E_VEHICLE_POS_Y ], Float: z = Vehicle [ i ] [ E_VEHICLE_POS_Z ];
		new address[64], zone[64];

		new color1 = Vehicle [ i ] [ E_VEHICLE_COLOR_A ];
		new color2 = Vehicle [ i ] [ E_VEHICLE_COLOR_B ];

		if (forspawn)
		{
			if ( Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] ) 
			{
				continue;
			}

			GetCoords2DZone(x, y, zone, sizeof ( zone ));
			GetPlayerAddress(x, y, address );
			format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s#%04d\t%s\t{%s}[%03d]{%s}[%03d]\t%s, %s\n", MyCarsDlgStr, Vehicle [ i ] [ E_VEHICLE_SQLID ], ReturnVehicleModelName(Vehicle [ i ] [ E_VEHICLE_MODELID ]), VehicleColoursTableRGBA[color1 % 256], color1, VehicleColoursTableRGBA[color2 % 256], color2, address, zone);
		}
		else if (forfind || fortow)
		{
			if ( !Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] ) 
			{
				continue;
			}

			new vehicleid =  Vehicle [ i ] [ E_VEHICLE_ID ];
			GetVehiclePos ( vehicleid, x, y, z ) ;
			GetCoords2DZone(x, y, zone, sizeof ( zone ));
			GetPlayerAddress(x, y, address );
			format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s#%04d\t%s\t{%s}[%03d]{%s}[%03d]\t%s, %s\n", MyCarsDlgStr, Vehicle [ i ] [ E_VEHICLE_SQLID ], ReturnVehicleName(vehicleid), VehicleColoursTableRGBA[color1 % 256], color1, VehicleColoursTableRGBA[color2 % 256], color2, address, zone);
		}
		else
		{
			if ( Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] ) 
			{
				new vehicleid =  Vehicle [ i ] [ E_VEHICLE_ID ];
				GetVehiclePos ( vehicleid, x, y, z ) ;
				GetCoords2DZone(x, y, zone, sizeof ( zone ));
				GetPlayerAddress(x, y, address );
				format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s#%04d\t{00FF00}Vehicle ID: %d\t%s\t%s, %s\n", MyCarsDlgStr, Vehicle [ i ] [ E_VEHICLE_SQLID ], vehicleid, ReturnVehicleName(vehicleid), address, zone);
			}
			else
			{
				GetCoords2DZone(x, y, zone, sizeof ( zone ));
				GetPlayerAddress(x, y, address );
				format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s#%04d\t{ABABAB}Despawned\t%s\t%s, %s\n", MyCarsDlgStr, Vehicle [ i ] [ E_VEHICLE_SQLID ], ReturnVehicleModelName(Vehicle [ i ] [ E_VEHICLE_MODELID ]), address, zone);
			}
		}

		cardlgmap[count] = i;
		count ++;
	}

	if (!count)
	{
		if (forspawn) SendClientMessage(showplayerid, COLOR_VEHICLE, "There are no despawned cars to spawn.");
		else if (forfind) SendClientMessage(showplayerid, COLOR_VEHICLE, "There are no spawned cars to find.");
		else if (fortow) SendClientMessage(showplayerid, COLOR_VEHICLE, "There are no spawned cars to tow.");
		else if (playerid == showplayerid) SendClientMessage(showplayerid, COLOR_VEHICLE, "You don't own any cars.");
		else SendClientMessage(showplayerid, COLOR_VEHICLE, "This player doesn't own any cars.");
		return true;
	}

	inline MyCarsDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused dialogid, inputtext

		if ( response ) 
		{
			new chosen = cardlgmap[listitem];

			if (forspawn)
			{
				cmd_carspawn(pid, sprintf("%d", Vehicle [ chosen ] [ E_VEHICLE_SQLID ]));
			}
			else if (forfind)
			{
				cmd_carfind(pid, sprintf("%d", Vehicle [ chosen ] [ E_VEHICLE_ID ]));
			}
			else if (fortow)
			{
				cmd_cartow(pid, sprintf("%d", Vehicle [ chosen ] [ E_VEHICLE_ID ]));
			}
			else
			{
				ShowPlayerCarToPlayer(playerid, chosen, pid);
			}
		}
	}

	Dialog_ShowCallback ( showplayerid, using inline MyCarsDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s vehicles owned by %s (%d)", forspawn ? "Despawned" : "All", ReturnSettingsName(playerid, showplayerid), playerid), MyCarsDlgStr, forspawn ? "Spawn" : "Select", "Back" );
	return true;
}

static ShowPlayerCarToPlayer(playerid, carid, showplayerid)
{
	new i = carid;
	
	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "Saved\tID: #%04d", Vehicle [ i ] [ E_VEHICLE_SQLID ]);

	if (Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ])
	{
		format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nSpawned\t{00FF00}VID: %03d", MyCarsDlgStr, Vehicle [ i ] [ E_VEHICLE_ID ]);
	}
	else
	{
		format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nSpawned\t%s", MyCarsDlgStr, "{FF0000}No");
	}

	new color1 = Vehicle [ i ] [ E_VEHICLE_COLOR_A ];
	new color2 = Vehicle [ i ] [ E_VEHICLE_COLOR_B ];

	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nOwner\t%s", MyCarsDlgStr, ReturnSettingsName(playerid, showplayerid));
	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nModel\t%s", MyCarsDlgStr, ReturnVehicleModelName(Vehicle [ i ] [ E_VEHICLE_MODELID ]));
	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nColors\t{%s}[%03d]{%s}[%03d]", MyCarsDlgStr, VehicleColoursTableRGBA[color1 % 256], color1, VehicleColoursTableRGBA[color2 % 256], color2);
	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nPlate\t%s", MyCarsDlgStr, Vehicle [ i ] [ E_VEHICLE_LICENSE ]);

	new occupied = Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] && GetVehicleDriver (Vehicle [ i ] [ E_VEHICLE_ID ] ) != INVALID_PLAYER_ID ;

	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nOccupied\t%s", MyCarsDlgStr, occupied ? "{00FF00}Yes" : "No");


	new weapons = 0;

	for (new x = 0; x < 10; x ++)
	{
		if (Vehicle [ i ] [ E_VEHICLE_TRUNK_WEP ] [ x ] && Vehicle [ i ] [ E_VEHICLE_TRUNK_AMMO ] [ x ])
		{
			weapons ++;
		}
	}

	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nWeapons\t%d", MyCarsDlgStr, weapons);

	new Float:drugs;

	for (new x = 0; x < 10; x ++)
	{
		if (Vehicle [ i ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ x ] > 0)
		{
			drugs += Vehicle [ i ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ x ];
		}
	}

	format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s\nDrugs\t%0.1fg", MyCarsDlgStr, drugs);

	inline MyCarDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused dialogid, inputtext, listitem

		if ( !response ) 
		{
			ShowPlayerCarsToPlayer(playerid, pid);
			return true;
		}

		ShowPlayerCarOptionsToPlayer(playerid, carid, pid);

	}

	Dialog_ShowCallback ( showplayerid, using inline MyCarDlg, DIALOG_STYLE_TABLIST, sprintf("%s (ID: #%04d, %s)", ReturnVehicleModelName(Vehicle [ i ] [ E_VEHICLE_MODELID ]), Vehicle [ i ] [ E_VEHICLE_SQLID ], ReturnSettingsName(playerid, showplayerid)), MyCarsDlgStr, "Options", "Back" );
	return true;

}

static enum E_MYCAR_OPTIONS
{
	E_MYCAR_OPTION_SPAWN,
	E_MYCAR_OPTION_FIND,
	E_MYCAR_OPTION_TOW,
	E_MYCAR_OPTION_GOTO,
	E_MYCAR_OPTION_GET
}

static enum E_MYCAR_DLG_DATA
{
	E_DLG_TEXT[16],
	E_MYCAR_OPTIONS:E_DLG_OPTION,
	bool:E_DLG_OPTION_ADMIN
}

static const MyCarOptionsDlgData[][E_MYCAR_DLG_DATA] = 
{
	{ "Spawn", E_MYCAR_OPTION_SPAWN },
	{ "Find", E_MYCAR_OPTION_FIND },
	{ "Tow", E_MYCAR_OPTION_TOW },
	{ "Goto (Admin)", E_MYCAR_OPTION_GOTO, true },
	{ "Bring (Admin)", E_MYCAR_OPTION_GET, true }
};

static ShowPlayerCarOptionsToPlayer(playerid, carid, showplayerid)
{
	MyCarsDlgStr[0] = EOS;

	for (new i = 0; i < sizeof(MyCarOptionsDlgData); i ++)
	{
		if (MyCarOptionsDlgData[i][E_DLG_OPTION_ADMIN] && !IsPlayerHelper(playerid) && GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR) continue;
		format(MyCarsDlgStr, sizeof(MyCarsDlgStr), "%s%s\n", MyCarsDlgStr, MyCarOptionsDlgData[i][E_DLG_TEXT]);
	}

	inline MyCarOptionsDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused dialogid, inputtext

		if ( !response ) 
		{
			ShowPlayerCarToPlayer(playerid, carid, showplayerid);
			return true;
		}

		switch (listitem)
		{
			case E_MYCAR_OPTION_SPAWN: 
			{
				// spawn
				cmd_carspawn(pid, sprintf("%d", Vehicle [ carid ] [ E_VEHICLE_SQLID ]));
			}
			case E_MYCAR_OPTION_FIND:
			{
				// find
				cmd_carfind(pid, sprintf("%d", Vehicle [ carid ] [ E_VEHICLE_ID ]));
			}
			case E_MYCAR_OPTION_TOW:
			{
				cmd_cartow(pid, sprintf("%d", Vehicle [ carid ] [ E_VEHICLE_ID ]));
				// tow
			}
			case E_MYCAR_OPTION_GET:
			{
				cmd_getcar(pid, sprintf("%d", Vehicle [ carid ] [ E_VEHICLE_ID ]));
				// get
			}
			case E_MYCAR_OPTION_GOTO:
			{
				cmd_gotocar(pid, sprintf("%d", Vehicle [ carid ] [ E_VEHICLE_ID ]));
				// goto
			}
		}
	}

	Dialog_ShowCallback ( showplayerid, using inline MyCarOptionsDlg, DIALOG_STYLE_LIST, sprintf("%s (ID: #%04d, %s)", ReturnVehicleModelName(Vehicle [ carid ] [ E_VEHICLE_MODELID ]), Vehicle [ carid ] [ E_VEHICLE_SQLID ], ReturnSettingsName(playerid, showplayerid)), MyCarsDlgStr, "Select", "Back" );
	return true;
}

CMD:checkcars(playerid, params[]) {

	if (!IsPlayerHelper(playerid))
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/checkcars [player]");

	if (!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, -1, "Target isn't connected.");

	ShowPlayerCarsToPlayer(targetid, playerid);

	new string[100];
	format(string, sizeof(string), "used /checkcars on (%d) %s", targetid, ReturnMixedName(targetid));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
	{
		format (string, sizeof ( string ), "[AdminCmd]: (%d) %s %s", playerid, ReturnMixedName(playerid), string);
		SendAdminMessage(string);
	}

	return true ;
}

CMD:mycars(playerid, params[]) {

	ShowPlayerCarsToPlayer(playerid, playerid);

	/*

	SendClientMessage(playerid, COLOR_VEHICLE, "My cars:");

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {

		if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_PLAYER ) {

			continue ;
		}
		if ( Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] ) {
			if ( Vehicle [ i ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				

				if ( GetVehicleDriver (Vehicle [ i ] [ E_VEHICLE_ID ] ) == INVALID_PLAYER_ID ) {
					SendClientMessage(playerid, COLOR_INFO, sprintf("[Spawned] [%s] [VEHICLE ID: %d] [SAVED ID: %d] [UNOCCUPIED]",
						ReturnVehicleName ( Vehicle [ i ] [ E_VEHICLE_ID ] ), Vehicle [ i ] [ E_VEHICLE_ID ],  Vehicle [ i ] [ E_VEHICLE_SQLID ] ));
				}

				else SendClientMessage(playerid, COLOR_ERROR, sprintf("[Spawned] [%s] [VEHICLE ID: %d] [SAVED ID: %d] [OCCUPIED]",
						ReturnVehicleName ( Vehicle [ i ] [ E_VEHICLE_ID ] ), Vehicle [ i ] [ E_VEHICLE_ID ], Vehicle [ i ] [ E_VEHICLE_SQLID ]));
			}
		}

		else if ( ! Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] ) {
			if ( Vehicle [ i ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				SendClientMessage(playerid, COLOR_VEHICLE, sprintf("[Despawned] [SAVED ID: %d] [%s]", Vehicle [ i ] [ E_VEHICLE_SQLID ], ReturnVehicleModelName ( Vehicle [ i ] [ E_VEHICLE_MODELID ] ) ));
			}
		}
	}


	SendClientMessage(playerid, COLOR_YELLOW, "To find any of your cars use /carfind.");
	*/

	return true ;
}


CMD:carfind(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	new vehicleid;

	if ( sscanf ( params, "i", vehicleid ) ) 
	{
		ShowPlayerCarsToPlayer(playerid, playerid, false, true);
		return true;
		//return SendClientMessage(playerid, COLOR_ERROR, "/carfind [vehicle id]");
	}

	new veh_enum_id = Vehicle_GetEnumID (vehicleid);

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "The passed ID isn't valid. Vehicle may not be set up.");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

		if ( GetVehicleDriver ( vehicleid ) != INVALID_PLAYER_ID ) {

			return SendClientMessage(playerid, COLOR_ERROR, "This vehicle is occupied and can't be traced!");
		}

		new Float: x, Float: y, Float: z ;
		GetVehiclePos ( vehicleid, x, y, z ) ;



		GPS_MarkLocation(playerid, "Your ~b~vehicle~w~ has been marked on your ~b~minimap~w~.", E_GPS_COLOR_SCRIPT, x, y, z ) ;

	}

	else return SendClientMessage(playerid, COLOR_ERROR, "You don't own this car!");

	return true ;
}


CMD:cartow(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid ;

	if ( sscanf ( params, "i", vehicleid ) ) {

		ShowPlayerCarsToPlayer(playerid, playerid, false, false, true);
		return true;
		//return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/cartow [vehicle-id]");
	} 

	new veh_enum_id = Vehicle_GetEnumID (vehicleid);

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "The passed ID isn't valid. Vehicle may not be set up.");
	}

	if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle is not spawned.");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_PLAYER ) 
	{
		return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
	}

	new bool:admin = false;

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) 
	{
		if (!IsPlayerHelper(playerid) && GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		{
			return SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");
		}
		
		admin = true;
	}

	

	if ( ! IsValidVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ])) {

		Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] = false ;
		return SendClientMessage(playerid, COLOR_ERROR, sprintf("Seems like your vehicle ID isn't spawned. Use /carspawn."));
	}

	new Float: x, Float: y, Float: z, Float: vhp, Float: distance ;
	GetVehiclePos(vehicleid, x, y, z );
	GetVehicleHealth(vehicleid, vhp);
	distance = GetDistanceBetweenPoints(x, y, z, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ]);

	new cost = 250; // base tow price
	
	cost += floatround(distance);
	if (cost > 2500) cost = 2500;

	cost += (100 - Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ]) * 3;
	cost += floatround((1000.0 - vhp) * 2.50);

	if (admin) cost = 0;
	SetPVarInt(playerid, "TOWCOST", cost);

	inline CarTowDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, dialogid, inputtext, listitem

		if ( response ) 
		{
			if (cost)
			{
				if (GetPlayerCash(playerid) < cost) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You don't have $%s in cash.", IntegerWithDelimiter(cost)));
				// TakePlayerCash(playerid, cost); // do this in CarTow_Tick
			}

			if ( IsValidDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] )) {

				DestroyDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
			}


			PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] = 15 ;

			Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] = CreateDynamic3DTextLabel(
				sprintf("[THIS VEHICLE IS BEING TOWED]\n{DEDEDE}[%d seconds left]", 
					PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] ), COLOR_BLUE, 
					0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], false 
			);

			SendServerMessage ( playerid, COLOR_BLUE, "Cartow", "DEDEDE", sprintf("Your vehicle will be towed in %d seconds.", PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] )) ; 
			defer CarTow_Tick(playerid, veh_enum_id ) ;

			/*
			-> Add label to car counting down
			-> Player var counting down
			--> If player dcs, cancel timer
			--> If someone enters car, cancel timer*/
		}
	}


	format(CarParkDlgStr, sizeof(CarParkDlgStr), "{FFFFFF}You are about to {AA3333}tow and respawn{FFFFFF} your %s.", ReturnVehicleName(vehicleid));

	strcat(CarParkDlgStr, "\n\n{FFFFFF}Towing the vehicle will:{ADBEE6}");
	strcat(CarParkDlgStr, "\n- Return the vehicle to its saved spawn location at a rate of $1.00 per meter.");
	strcat(CarParkDlgStr, "\n- Repair the vehicle at a premium fee of $2.50 per 1 point of damage.");
	strcat(CarParkDlgStr, "\n- Refuel the vehicle at a premium fee of $3.00 per 1 galon of fuel.");
	
	strcat(CarParkDlgStr, sprintf("\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to tow the vehicle for {AA3333}$%s{FFFFFF}.", IntegerWithDelimiter(cost)));
	strcat(CarParkDlgStr, "\n{ADBEE6}You should not do this during active roleplay or if the vehicle is in use by anyone.");

	if (admin)
	{
		strcat(CarParkDlgStr, "\n\n{FF0000}This is not your vehicle, you are using your admin powers to do this.");
	}

	Dialog_ShowCallback ( playerid, using inline CarTowDlg, DIALOG_STYLE_MSGBOX, "Vehicle Tow Service", CarParkDlgStr, "OK", "Back" );
	return true ;
}

timer CarTow_Tick[1000](playerid, veh_enum_id) {

	if (! IsPlayerConnected(playerid) ) {

		if ( IsValidDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] )) {

			DestroyDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
		}

		PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] = 0 ;

		return true ;
	}

	if ( IsVehicleOccupied ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {

		if ( IsValidDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] )) {

			DestroyDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
		}

		PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] = 0 ;

		return SendServerMessage ( playerid, COLOR_ERROR, "Uh Oh!", "DEDEDE", "Someone's in your vehicle! Car tow cancelled." ) ; 
	}

	if ( -- PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] <= 0 ) {

		if ( IsValidDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] )) {

			DestroyDynamic3DTextLabel(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
		}

		/*
		SetVehiclePos(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ],
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] ) ;
		*/

		SOLS_SetVehicleToRespawn(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], "/cartow");
		Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100;

		new cost = GetPVarInt(playerid, "TOWCOST");
		if (cost)
		{
			TakePlayerCash(playerid, cost);
		}

		SendServerMessage ( playerid, COLOR_BLUE, "Tow", "DEDEDE", sprintf("Your %s has been towed to its spawn location for $%s. Use /carfind to find it.", ReturnVehicleName(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]), IntegerWithDelimiter(cost))) ; 

		return true ;
	}

	UpdateDynamic3DTextLabelText(Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ], 
		COLOR_BLUE, sprintf("[THIS VEHICLE IS BEING TOWED]\n{DEDEDE}[%d seconds left]", 
			PlayerVar [ playerid ] [ E_PLAYER_CAR_TOW_TICK ] 
		)
	);

	defer CarTow_Tick(playerid, veh_enum_id ) ; 

	return true ;
}