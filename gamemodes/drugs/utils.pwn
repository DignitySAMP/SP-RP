Drugs_OnFinishTicks ( enum_id ) {
	switch ( Drugs [ enum_id ] [ E_DRUG_TYPE ] ) {
		case E_DRUG_TYPE_WEED: Weed_FinalizeGrowth( enum_id );
		case E_DRUG_TYPE_COKE: Coke_FinalizeGrowth(enum_id);
		case E_DRUG_TYPE_CRACK: Crack_FinalizeGrowth ( enum_id ) ;
		//case E_DRUG_TYPE_METH: return true ;
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_ticks = %d, drug_stage = %d WHERE drug_sqlid = %d", 

		Drugs [ enum_id ] [ E_DRUG_TICKS ], Drugs [ enum_id ] [ E_DRUG_STAGE ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	return true ;
}


Drugs_UpdateObject ( enum_id ) {

	if ( Drugs [ enum_id ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

		return false ;
	}

	new type = Drugs [ enum_id ] [ E_DRUG_TYPE ] ;

	switch ( type ) {

		case E_DRUG_TYPE_NONE, E_DRUG_TYPE_METH : return true ;
		case E_DRUG_TYPE_WEED : Weed_SetupPlantVisuals ( enum_id ) ;
		case E_DRUG_TYPE_COKE : Coke_SetupPlantVisuals ( enum_id ) ;
		case E_DRUG_TYPE_CRACK : Crack_SetupPlantVisuals ( enum_id ) ;
		//case E_DRUG_TYPE_METH : return true;
	}
	/*
		case E_DRUG_TYPE_METH : {

			new Float: hydrogen_chloride = 2.95;
			new Float: caustic_soda = 1.37;
			new Float: muriatic_acid = 1.64 ;

			new Float: total_haul = (hydrogen_chloride * caustic_soda ) / muriatic_acid ;

			format ( drug_label, sizeof ( drug_label ), "{[ Crystal Ruby Meth ]} [ %d ]\nHydrogen Chloride: %0.3fmL\nCaustic Soda: %0.3fmL\nMuriatic Acid: %0.3fmL\nExpected Haul: %0.3fgr\n",
				enum_id, hydrogen_chloride, caustic_soda, muriatic_acid, total_haul
			 ) ;
		
			drug_modelid = 19816 ;
			label_colour = 0x5ECFBFff ;
		}
	}
*/

	return true ;
}

Drugs_GetParamName(type, param, name[], len = sizeof ( name ) ) {

	if ( param > 0 || param < 4 ) {

		switch ( type ) {
			case E_DRUG_TYPE_NONE : format ( name, len, "Invalid" ) ;
			case E_DRUG_TYPE_WEED : format ( name, len, "%s", Weed [ param ] [ E_WEED_NAME ] ) ;
			case E_DRUG_TYPE_COKE : format ( name, len, "%s", Cocaine [ param ] [ E_COKE_NAME ] ) ;
			case E_DRUG_TYPE_CRACK : format ( name,len, "%s", Crack [ param ] [ E_CRACK_NAME ] ) ;
			case E_DRUG_TYPE_METH : format ( name, len, "_" ) ;
		}
	}

	else format ( name, len, "Invalid" ) ;
}

Drugs_GetTypeName(type, name[], len = sizeof ( name ) ) {

	switch ( type ) {
		case E_DRUG_TYPE_NONE : format ( name, len, "Invalid" ) ;
		case E_DRUG_TYPE_WEED : format ( name, len, "Marihuana") ;
		case E_DRUG_TYPE_COKE :  format ( name, len, "Cocaine") ;
		case E_DRUG_TYPE_CRACK :  format ( name, len, "Crack") ;
		case E_DRUG_TYPE_METH : format ( name, len, "Methemphetamine" ) ;
	}
}

Drugs_CollectAnimation ( playerid, enum_id ) {

	switch ( Drugs [ enum_id ] [ E_DRUG_TYPE ] ) {
		case E_DRUG_TYPE_WEED : ApplyAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
		case E_DRUG_TYPE_COKE : ApplyAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
		case E_DRUG_TYPE_CRACK : {

			if ( Drugs [ enum_id ] [ E_DRUG_POS_Z ] >= 0.5 ) {
				ApplyAnim(playerid, "BD_FIRE", "wash_up", 4.0, 0, 0, 0, 0, 0, 1);
			}

			else ApplyAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
		}
		case E_DRUG_TYPE_METH : ApplyAnim(playerid, "BD_FIRE", "wash_up", 4.0, 0, 0, 0, 0, 0, 1);
	}
}

Drugs_OnPlantCollect ( playerid, enum_id, container, Float: amount ) {

	if ( Drugs [ enum_id ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("The plant you're trying to collect is invalid!" ) ) ;
	}

	if ( Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] < amount ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("The drug you're trying to collect from only has %0.2fgr.", Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] ) ) ;
	}

	new player_enum_id = PlayerDrugs_GetFreeID(playerid) ;

	if ( player_enum_id == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Failed to collect drugs - you have no free slots left." ) ;
	}

	new type = Drugs [ enum_id ] [ E_DRUG_TYPE ] ;
	new param = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;

	new name [ 32 ], query [ 128 ] ;

	switch ( type ) {

		case E_DRUG_TYPE_NONE : format ( name, sizeof ( name ), "Invalid" ) ;
		case E_DRUG_TYPE_WEED : format ( name, sizeof ( name ), "%s", Weed [ param ] [ E_WEED_NAME ] ) ;
		case E_DRUG_TYPE_COKE : format ( name, sizeof ( name ), "%s", Cocaine [ param ] [ E_COKE_NAME ] ) ; 
		case E_DRUG_TYPE_CRACK : format ( name, sizeof ( name ), "%s", Crack [ param ] [ E_CRACK_NAME ] ) ;
		case E_DRUG_TYPE_METH : format ( name, sizeof ( name ), "Meth" ) ;
	}

	// Player Data
	Drugs_CollectAnimation ( playerid, enum_id ) ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ] = type ;
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ] = param ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ] = container ;
	Drugs_DecreasePlayerContainer ( playerid, container ) ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ] = amount ;
	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] -= amount ;

	PlayerDrugs_Save(playerid) ;

	new package_name [ 32 ] ;
	Drugs_GetPackageName ( container, package_name ) ;

	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You've collected %0.2fgr of %s and stored it in a %s. (/mydrugs)", 
		PlayerDrugs [playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], name, package_name ) ) ;

	Drugs_UpdateObject ( enum_id ) ;

	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Collected %0.2fgr of %s in %s from station %d", PlayerDrugs [playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], name, package_name, Drugs [ enum_id ] [ E_DRUG_SQLID ]));

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_float_ii = '%f' WHERE drug_sqlid = %d", 

		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	// Drug  Data
	if ( Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] <= 0.01 ) {

		SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You've finished collecting the last haul from your %s drug.", name ) ) ;

		mysql_format(mysql, query, sizeof ( query ), "DELETE FROM `drugs_player_stations` WHERE drug_sqlid = %d",
		 	Drugs [ enum_id ] [ E_DRUG_SQLID ]
		) ;

		mysql_tquery(mysql, query);

		Drugs [ enum_id ] [ E_DRUG_SQLID ] = -1 ;
		Drugs [ enum_id ] [ E_DRUG_TYPE ] = 0 ;
		Drugs [ enum_id ] [ E_DRUG_PARAM ] = 0 ;
		Drugs [ enum_id ] [ E_DRUG_STAGE ] = 0 ; 
		Drugs [ enum_id ] [ E_DRUG_TICKS ] = -1 ;

		Drugs [ enum_id ] [ E_DRUG_POS_X ] = 0 ;
		Drugs [ enum_id ] [ E_DRUG_POS_Y ] = 0 ;
		Drugs [ enum_id ] [ E_DRUG_POS_Z ] = 0 ;

		Drugs [ enum_id ] [ E_DRUG_WORLDID ] = 0 ;
		Drugs [ enum_id ] [ E_DRUG_INTERIOR ] = 0 ;

		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT  ] = 0 ;
		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ] = 0.0 ;
		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] = 0.0; 
		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_III ] = 0.0 ;

		if ( IsValidDynamicObject( Drugs [ enum_id ] [ E_DRUG_OBJECT ] ) ) {

			SOLS_DestroyObject(Drugs [ enum_id ] [ E_DRUG_OBJECT ], "Drugs/OnPlantCollect (Object)", true ) ;
		}

		Drugs [ enum_id ] [ E_DRUG_OBJECT ] = -1 ;

		if ( IsValidDynamicObject( Drugs [ enum_id ] [ E_DRUG_OBJECT_EXTRA ] ) ) {

			SOLS_DestroyObject( Drugs [ enum_id ] [ E_DRUG_OBJECT_EXTRA ], "Drugs/OnPlantCollect (Extra)", true ) ;
		}

		Drugs [ enum_id ] [ E_DRUG_OBJECT_EXTRA ] = -1 ;

		if ( IsValidDynamic3DTextLabel( Drugs [ enum_id ] [ E_DRUG_LABEL ] ) ) {

			DestroyDynamic3DTextLabel( Drugs [ enum_id ] [ E_DRUG_LABEL ] ) ;
		}

		Drugs [ enum_id ] [ E_DRUG_LABEL ] = DynamicText3D: -1 ;
	}

	return true ;
}

