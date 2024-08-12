CMD:ctsdrug(playerid, params[]) {

	return cmd_cartrunkstoredrug(playerid, params);
}

CMD:cartrunkstoredrug(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid, slot, drug_slot ;

	if ( sscanf ( params, "ii", slot, drug_slot) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/cartrunkstoredrug (/ctsdrug) [slot: (0-9)] [drug-slot: /mydrugs]" ) ;
	}

	if ( slot < 0 || slot > 9 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Trunk slot can't be less than 0 or more than 9.");
	}

	if ( ! IsPlayerInAnyVehicle(playerid) ) {

		vehicleid = Vehicle_GetClosestEntity(playerid, 5.0);

		if ( ! GetTrunkStatus ( vehicleid )) {

			SendServerMessage(playerid, COLOR_BLUE, "Trunk", "DEDEDE", "This trunk is closed!");
			return true ;
		}
	}

	else vehicleid = GetPlayerVehicleID(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if (IsAircraft(vehicleid) || IsABoat(vehicleid) || IsABike(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk!");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );


	new model_type = Vehicle_GetTypeByModel ( Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID ] ) ;
	new sols_type = Vehicle_GetSOLSTypeByModel ( model_type ) ;
	new max_slots = Vehicle_GetMaxSlotsPerType ( sols_type ) ;

	if ( slot > max_slots ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("This vehicle has room for %d slots. Can't be less than 0 or more than %d.", max_slots, max_slots));
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Trunk", "DEDEDE", "There's already some drugs in this slot.");
	}

	new type = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ] ;

	if ( type == E_DRUG_TYPE_NONE ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This slot has no valid drug in it." ) ;
	}

	if ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ] < 0.0 ) {
		
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug amount isn't positive. Your action has been logged." ) ;
	}
	
	new query [ 512 ] ;

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;


	ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", sprintf("has stored a %s with %0.2f of %s in the %s's trunk.", 
	package_name, PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ], drug_name , ReturnVehicleName ( vehicleid )), .annonated=true);

	format ( query, sizeof ( query ), "Stored %s with %0.2f of %s in the %s(sql %d) trunk",
		package_name, PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ], 
		drug_name , ReturnVehicleName ( vehicleid ), Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
	) ;

	AddLogEntry(playerid, LOG_TYPE_DRUGS, query);


	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ] 	 = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ] ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_PARAM ] [ slot ] 	 = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_PARAM ] ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_CONTAINER ] [ slot ] = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_CONTAINER ] ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ slot ] 	 = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ] ;

	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_SQLID ] 		= -1 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ] 		= 0 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_PARAM ] 		= 0 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_CONTAINER ] 	= 0 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ]		= 0.0 ;

	PlayerDrugs_Save(playerid) ;

	query [ 0 ] = EOS ;

	mysql_format(mysql, query, sizeof(query), 
		"UPDATE vehicles SET vehicle_trunk_drugs_type_%d = %d, vehicle_trunk_drugs_param_%d = %d,\
		vehicle_trunk_drugs_cont_%d = %d, vehicle_trunk_drugs_amount_%d = '%f' where vehicle_sqlid = %d", 

			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ],
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_PARAM ] [ slot ],
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_CONTAINER ] [ slot ],
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ slot ], 

			Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]
	);

	mysql_tquery(mysql, query);

	return true ;
}

CMD:cttdrug(playerid, params[]) {

	return cmd_cartrunktakedrug(playerid, params);
}

CMD:cartrunktakedrug(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid, slot ;

	if ( sscanf ( params, "i", slot ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/cartrunktakedrug (/cttdrug) [slot: (0-9)]" ) ;
	}

	if ( slot < 0 || slot > 9 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Trunk slot can't be less than 0 or more than 9.");
	}

	if ( ! IsPlayerInAnyVehicle(playerid) ) {

		vehicleid = Vehicle_GetClosestEntity(playerid, 5.0);

		if ( ! GetTrunkStatus ( vehicleid )) {

			SendServerMessage(playerid, COLOR_BLUE, "Trunk", "DEDEDE", "This trunk is closed!");
			return true ;
		}
	}

	else vehicleid = GetPlayerVehicleID(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if (IsAircraft(vehicleid) || IsABoat(vehicleid) || IsABike(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk!");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Trunk", "DEDEDE", "There's no drugs in this slot.");
	}

	new player_enum_id = PlayerDrugs_GetFreeID(playerid) ;

	if ( player_enum_id == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Failed to collect drugs - you have no free slots left." ) ;
	}

	new query [ 512 ] ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ]  		= Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ];
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ]  		= Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_PARAM ] [ slot ];
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ]  	= Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_CONTAINER ] [ slot ];
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ]  		= Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ slot ];

	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ] = 0 ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_PARAM ] [ slot ] = 0;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_CONTAINER ] [ slot ]  = 0 ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ slot ] = 0.0 ;

	PlayerDrugs_Save(playerid) ;

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

	ProxDetectorEx (playerid, 15.0, COLOR_ACTION, "*", sprintf("has taken a %s with %0.2f of %s from the %s's trunk.", 		package_name, PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], 
		drug_name , ReturnVehicleName ( vehicleid )), .annonated = true ) ;

	format ( query, sizeof ( query ), "Taken %s with %0.2f of %s from the %s(sql %d) trunk",
		package_name, PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], 
		drug_name , ReturnVehicleName ( vehicleid ), Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
	) ;

	AddLogEntry(playerid, LOG_TYPE_DRUGS, query);

	query [ 0 ] = EOS ;

	mysql_format(mysql, query, sizeof(query), 
		"UPDATE vehicles SET vehicle_trunk_drugs_type_%d = %d, vehicle_trunk_drugs_param_%d = %d,\
		vehicle_trunk_drugs_cont_%d = %d, vehicle_trunk_drugs_amount_%d = '%f' where vehicle_sqlid = %d", 

			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ slot ],
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_PARAM ] [ slot ],
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_CONTAINER ] [ slot ],
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT ] [ slot ], 

			Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]
	);

	mysql_tquery(mysql, query);

	return true ;
}