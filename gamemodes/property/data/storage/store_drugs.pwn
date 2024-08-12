
CMD:proptakedrug(playerid, params[]) {

	return cmd_propertytakedrug(playerid, params);
}
CMD:propertytakedrug(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be inside your property, near the door.");
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && !PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own this property.");
	}

	new slot ;

	if ( sscanf ( params, "i", slot ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertytakedrug [slot: 0-9]");
	}

	if ( slot < 0 || slot > 9 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Slot can't be less than 0 or higher than 9.");
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ] == 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This slot is empty and has no drugs to take.");
	}

	new player_enum_id = PlayerDrugs_GetFreeID(playerid) ;

	if ( player_enum_id == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Failed to collect drugs - you have no free slots left." ) ;
	}

	new query [ 512 ] ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ]  		= Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ];
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ]  		= Property [ property_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ slot ];
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ]  	= Property [ property_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ slot ];
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ]  		= Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ slot ];

	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ] = 0 ;
	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ slot ] = 0;
	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ slot ]  = 0 ;
	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ slot ] = 0.0 ;

	PlayerDrugs_Save(playerid) ;

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

	format ( query, sizeof ( query ), "has taken a %s with %0.2f of %s from their property.",
		package_name, PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], 
		drug_name
	) ;

	ProxDetectorEx(playerid,15.0, COLOR_ACTION, "*", query) ;

	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Taken %s with %0.2fgr of %s from property %d",
		package_name, PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], drug_name, 
		Property [ property_enum_id ] [ E_PROPERTY_ID ] )
	);

	query [ 0 ] = EOS ;

	mysql_format(mysql, query, sizeof(query), 
		"UPDATE properties SET property_drugs_type_%d = %d, property_drugs_param_%d = %d,\
		property_drugs_container_%d = %d, property_drugs_amount_%d = '%f' where property_id = %d", 

			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ],
			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ slot ],
			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ slot ],
			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ slot ], 

			Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	return true ;
}
CMD:propstoredrug(playerid, params[]) {

	return cmd_propertystoredrug(playerid, params);
}

CMD:propertystoredrug(playerid, params[]) {
	
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be inside your property, near the door.");
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && !PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own this property.");
	}

	new slot, drug_slot ;

	if ( sscanf ( params, "ii", slot, drug_slot ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertystoredrug [slot: (0-9)] [drug-slot: /mydrugs]");
	}

	if ( slot < 0 || slot > 9 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Slot can't be less than 0 or higher than 9.");
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "There's already some drugs in this slot.");
	}

	new type = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ] ;

	if ( type == E_DRUG_TYPE_NONE ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This slot has no valid drug in it." ) ;
	}

	if ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ] < 0.0 ) {
		
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug amount isn't positive. Your action has been logged." ) ;
	}
	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ] 	 = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ] ;
	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ slot ] 	 = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_PARAM ] ;
	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ slot ] = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_CONTAINER ] ;
	Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ slot ] 	 = PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ] ;

	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_SQLID ] 		= -1 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_TYPE ] 		= 0 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_PARAM ] 		= 0 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_CONTAINER ] 	= 0 ;
	PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ]		= 0.0 ;

	PlayerDrugs_Save(playerid) ;

	new query [ 512 ] ;

	format ( query, sizeof ( query ), "has stored a %s with %0.2f of %s in their property.", 
		package_name, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ slot ], 
		drug_name
	) ;

	ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", query ) ;

	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Stores %s with %0.2fgr of %s in property %d",
		package_name, PlayerDrugs [ playerid ] [ drug_slot ] [ E_PLAYER_DRUG_AMOUNT ], drug_name, 
		Property [ property_enum_id ] [ E_PROPERTY_ID ] )
	);

	query [ 0 ] = EOS ;

	mysql_format(mysql, query, sizeof(query), 
		"UPDATE properties SET property_drugs_type_%d = %d, property_drugs_param_%d = %d,\
		property_drugs_container_%d = %d, property_drugs_amount_%d = '%f' where property_id = %d", 

			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ slot ],
			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ slot ],
			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ slot ],
			slot, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ slot ], 

			Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	return true ;
}
