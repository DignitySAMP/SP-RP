CMD:givedrugs(playerid, params[]) {

	return cmd_drugpass(playerid, params);
}
CMD:passdrugs(playerid, params[]) {

	return cmd_drugpass(playerid, params);
}

CMD:passdrug(playerid, params[]) {

	return cmd_drugpass(playerid, params);
}

CMD:drugpass(playerid, params[]) {

	new targetid, slot ;

	if ( sscanf ( params, "k<player>i", targetid, slot ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugpass [targetid] [slot]" ) ;
	}

	if ( ! IsPlayerConnected(targetid) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Target isn't connected." ) ;
	}	
	
	if (  PlayerVar [ targetid ] [ E_PLAYER_IS_SPECTATING ] == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if ( !IsPlayerNearPlayer(playerid, targetid, 5.0 ) ) {

	    return SendServerMessage( playerid, COLOR_DRUGS, "Drugs", "A3A3A3",  "You're not near your target." );
	}

	new target_enum_id = PlayerDrugs_GetFreeID(targetid) ;

	if ( target_enum_id == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Your target has no free drug slots left!" ) ;
	}

	new type = PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] ;

	if ( type == E_DRUG_TYPE_NONE ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This slot has no valid drug in it." ) ;
	}

	if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] < 0.0 ) {
		
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug amount isn't positive. Your action has been logged." ) ;
	}

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

	ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "*", sprintf("has given %s a %s with %0.2f of %s.", 
		ReturnMixedName ( targetid ), 
		package_name, PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ], 
		drug_name 
	), .annonated=true);

	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Passed %s a %s with %0.2f of %s.",
	 	ReturnMixedName ( targetid ), 
		package_name, PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ], 
		drug_name ) 
	) ;

	PlayerDrugs [ targetid ] [ target_enum_id ] [ E_PLAYER_DRUG_SQLID ] 	= PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_SQLID ] ;
	PlayerDrugs [ targetid ] [ target_enum_id ] [ E_PLAYER_DRUG_TYPE ] 		= PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] ;
	PlayerDrugs [ targetid ] [ target_enum_id ] [ E_PLAYER_DRUG_PARAM ] 	= PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ] ;
	PlayerDrugs [ targetid ] [ target_enum_id ] [ E_PLAYER_DRUG_CONTAINER ] = PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_CONTAINER ] ;
	PlayerDrugs [ targetid ] [ target_enum_id ] [ E_PLAYER_DRUG_AMOUNT ] 	= PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] ;

	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_SQLID ] 		= -1 ;
	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] 		= 0 ;
	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ] 		= 0 ;
	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_CONTAINER ] 	= 0 ;
	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ]		= 0.0 ;

	PlayerDrugs_Save(playerid) ;
	PlayerDrugs_Save(targetid) ;

	return true ;
}

CMD:drugsplit(playerid, params[]) {


	new slot, container, Float: amount ;

	if ( sscanf  (params, "iif", slot, container, amount ) ){
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugsplit [slot] [container] [amount]" ) ;
	}

	new type = PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] ;
	new param = PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ] ;

	if ( type == E_DRUG_TYPE_NONE ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This slot has no valid drug in it." ) ;
	}

	if ( container < 0 || container > sizeof ( DrugPackages ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Container can't be less than 0 or higher than %d", sizeof ( DrugPackages ) ) ) ;
	}

	if ( amount < 0.0 ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug amount isn't positive. Your action has been logged." ) ;
	}
	
	if ( Drugs_GetPackageMaxWeight ( container ) < amount ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Your container can only hold %0.2fgr!", Drugs_GetPackageMaxWeight ( container ) ) ) ;
	}

	if ( ! Drugs_DoesPlayerHaveContainer ( playerid, container ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "You don't have this container!" ) ;
	}

	if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] < amount ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You don't have that much of this drug - you only have %0.2f.", PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] ) ) ;
	}


	if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] < 0.0 ) {
		
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug amount isn't positive. Your action has been logged." ) ;
	}

	new player_enum_id = PlayerDrugs_GetFreeID(playerid) ;

	if ( player_enum_id == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Failed to collect drugs - you have no free slots left." ) ;
	}

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( container, package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

	ApplyAnim(playerid, "BD_FIRE", "wash_up", 4.0, 0, 0, 0, 0, 0, 1);

	ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", sprintf("has split their %s drug into %.02fgr put into a %s.", 
		drug_name, amount, package_name
	), .annonated=true);
	

	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Split their %s into %0.2fgr put into a %s.", drug_name, amount, package_name ) ) ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ] = type ;
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ] = param ;
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ] = container ;
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ] = amount ;

	Drugs_DecreasePlayerContainer ( playerid, container ) ;

	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] -= amount ;

	/*if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] <= 0.01 || 
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] == 0.00 ||
		amount == PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ]) {*/
	if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] <= 0.01 || 
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] == 0.00 ) {
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] = E_DRUG_TYPE_NONE ;
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ] = 0 ;

		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_CONTAINER ] = 0 ;
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] = 0.0 ;
	}

	PlayerDrugs_Save(playerid) ;
	return true ;
}