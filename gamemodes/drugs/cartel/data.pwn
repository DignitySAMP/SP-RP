enum E_CARTEL_NPC_DATA {

	E_CARTEL_DESC [ 32 ],
	E_CARTEL_SUPPLY_TYPE,

	Float: E_CARTEL_POS_X,
	Float: E_CARTEL_POS_Y,
	Float: E_CARTEL_POS_Z
} ;

new Cartel [ ] [ E_CARTEL_NPC_DATA ] = {
	{ "Weed Supply Point", 		E_DRUG_TYPE_WEED, 	1489.1447,	-1720.2032,	8.2365   },
	{ "Cocaine Supply Point", 	E_DRUG_TYPE_COKE, 	-1819.5409,	-149.9225,	9.3984 }, 
	{ "Crack Supply Point", 	E_DRUG_TYPE_CRACK, 	 263.3768,	2896.1157,	10.539 }, 
	{ "Meth Supply Point", 		E_DRUG_TYPE_METH, 	-418.5680,	-1759.7220,	6.2188 } 
} ;

Cartel_LoadEntities() {

	for ( new i, j = sizeof ( Cartel ) ; i < j ; i ++ ) {

		CreateDynamic3DTextLabel(sprintf("[%s]\n{DEDEDE}Available Commands: /buysupplies", Cartel [ i ] [ E_CARTEL_DESC ]), 0xA1724EFF, 
			Cartel [ i ] [ E_CARTEL_POS_X ], Cartel [ i ] [ E_CARTEL_POS_Y ], Cartel [ i ] [ E_CARTEL_POS_Z ], 3.5);
		CreateDynamicPickup(1279, 1, Cartel [ i ] [ E_CARTEL_POS_X ], Cartel [ i ] [ E_CARTEL_POS_Y ], Cartel [ i ] [ E_CARTEL_POS_Z ]); 
		CreateDynamicMapIcon(Cartel [ i ] [ E_CARTEL_POS_X ], Cartel [ i ] [ E_CARTEL_POS_Y ], Cartel [ i ] [ E_CARTEL_POS_Z ], 37, 0xFFFFFFFF);
	}
}

Drugs_LoadEntity_Supplies(playerid) {

   	new query [ 1024 ] ;

    inline DrugLoadSupplies() {
        if (!cache_num_rows()) {

        	mysql_format(mysql, query, sizeof ( query ), "INSERT INTO drugs_player_supplies(drug_supply_characterid, drug_supply_weed_0,\
        	 drug_supply_weed_1, drug_supply_weed_2, drug_supply_coke_0, drug_supply_coke_1, drug_supply_coke_2, drug_supply_crack_0,\
        	  drug_supply_crack_1, drug_supply_crack_2, drug_supply_meth_0, drug_supply_meth_1, drug_supply_meth_2) VALUES (%d, 0, 0, 0,\
        	  0, 0, 0, 0, 0, 0, 0, 0, 0)", Character [ playerid ] [ E_CHARACTER_ID ] 
        	) ;

        	mysql_tquery(mysql, query) ;
        } else {
			cache_get_value_name_int(0, "drug_supply_weed_0", Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ 0 ]);
			cache_get_value_name_int(0, "drug_supply_weed_1", Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ 1 ]);
			cache_get_value_name_int(0, "drug_supply_weed_2", Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ 2 ]);

			cache_get_value_name_int(0, "drug_supply_coke_0", Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ 0 ]);
			cache_get_value_name_int(0, "drug_supply_coke_1", Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ 1 ]);
			cache_get_value_name_int(0, "drug_supply_coke_2", Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ 2 ]);

			cache_get_value_name_int(0, "drug_supply_crack_0", Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ 0 ]);
			cache_get_value_name_int(0, "drug_supply_crack_1", Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ 1 ]);
			cache_get_value_name_int(0, "drug_supply_crack_2", Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ 2 ]);

			cache_get_value_name_int(0, "drug_supply_meth_0", Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ 0 ]);
			cache_get_value_name_int(0, "drug_supply_meth_1", Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ 1 ]);
			cache_get_value_name_int(0, "drug_supply_meth_2", Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ 2 ]);
        }
    }

    mysql_format(mysql, query, sizeof ( query ), "SELECT * FROM drugs_player_supplies WHERE drug_supply_characterid = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
    MySQL_TQueryInline(mysql, using inline DrugLoadSupplies, query, "" ) ;
}

Drugs_SavePlayerSupplies(playerid) {

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_supplies SET drug_supply_weed_0 = %d, drug_supply_weed_1 = %d, drug_supply_weed_2 = %d WHERE drug_supply_characterid = %d",
		Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ 0 ], Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ 1 ], Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ 2 ],
		Character [ playerid ] [ E_CHARACTER_ID ] 
	);

	mysql_tquery(mysql, query);

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_supplies SET drug_supply_coke_0 = %d, drug_supply_coke_1 = %d, drug_supply_coke_2 = %d WHERE drug_supply_characterid = %d",
		Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ 0 ], Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ 1 ], Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ 2 ],
		Character [ playerid ] [ E_CHARACTER_ID ] 
	);

	mysql_tquery(mysql, query);

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_supplies SET drug_supply_crack_0 = %d, drug_supply_crack_1 = %d, drug_supply_crack_2 = %d WHERE drug_supply_characterid = %d",
		Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ 0 ], Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ 1 ], Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ 2 ],	
		Character [ playerid ] [ E_CHARACTER_ID ] 
	);

	mysql_tquery(mysql, query);

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_supplies SET drug_supply_meth_0 = %d, drug_supply_meth_1 = %d, drug_supply_meth_2 = %d WHERE drug_supply_characterid = %d",
		Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ 0 ], Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ 1 ], Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ 2 ],
		Character [ playerid ] [ E_CHARACTER_ID ] 
	);

	mysql_tquery(mysql, query);


	return true ;
}	

Drugs_GetSupplySlot ( playerid, type ) {

	new MAX_SUPPLY_SLOTS = 3 ;

	switch ( type ) {
		case E_DRUG_TYPE_WEED : {

			for ( new i, j = MAX_SUPPLY_SLOTS ; i < j ; i ++ ) {

				if ( ! Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ i ] ) {
					return i ;
				}

				else continue ;
			}
		}
		case E_DRUG_TYPE_COKE :  {

			for ( new i, j = MAX_SUPPLY_SLOTS ; i < j ; i ++ ) {

				if ( ! Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ i ] ) {
					return i ;
				}

				else continue ;
			}
		}
		case E_DRUG_TYPE_CRACK : {

			for ( new i, j = MAX_SUPPLY_SLOTS ; i < j ; i ++ ) {

				if ( ! Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ i ] ) {
					return i ;
				}

				else continue ;
			}
		}
		case E_DRUG_TYPE_METH :	 {

			for ( new i, j = MAX_SUPPLY_SLOTS ; i < j ; i ++ ) {

				if ( ! Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ i ] ) {
					return i ;
				}

				else continue ;
			}
		}
	}

	return INVALID_DRUG_ID ;
}
Drug_RemoveSupplyFromPlayer ( playerid, type, param ) {
 
	new MAX_SUPPLY_SLOTS = 3 ;

	switch ( type ) {
		case E_DRUG_TYPE_WEED: {
			for ( new i, j = MAX_SUPPLY_SLOTS; i < j ; i ++ ) {

				if ( Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ i ] == param ) {
					Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ i ] = 0 ;
					break ;
				}

				else continue ;
			}
		}
		case E_DRUG_TYPE_COKE: {
			for ( new i, j = MAX_SUPPLY_SLOTS; i < j ; i ++ ) {

				if ( Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ i ] == param ) {
					Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ i ] = 0 ;
					break ;
				}

				else continue ;
			}
		}
		case E_DRUG_TYPE_CRACK: {
			for ( new i, j = MAX_SUPPLY_SLOTS; i < j ; i ++ ) {

				if ( Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ i ] == param ) {
					Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ i ] = 0 ;
					break ;
				}

				else continue ;
			}
		}
		case E_DRUG_TYPE_METH: {
			for ( new i, j = MAX_SUPPLY_SLOTS; i < j ; i ++ ) {

				if ( Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ i ] == param ) {
					Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ i ] = 0 ;
					break ;
				}

				else continue ;
			}
		}
	}

	Drugs_SavePlayerSupplies(playerid);

	return true ;
}

Drugs_AddSupplyToPlayer(playerid, type, param, fee ) {

	new free_slot = Drugs_GetSupplySlot ( playerid , type) ;

	if ( free_slot == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "You don't have a free slot left for this supply type!" ) ;
	}

	if ( GetPlayerCash ( playerid ) < fee ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You need at least $%s to buy this supply.", IntegerWithDelimiter(fee)) ) ;
	}

	TakePlayerCash ( playerid, fee ) ;

	new drug_name [ 64 ] ;

	switch ( type ) {
		case E_DRUG_TYPE_WEED : {
			Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ free_slot ] = param ;
			format ( drug_name, sizeof ( drug_name), "%s", Weed [ param ] [ E_WEED_NAME ] ) ;
		}

		case E_DRUG_TYPE_COKE :  {
			Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ free_slot ] = param ;
			format ( drug_name, sizeof ( drug_name), "%s", Cocaine [ param ] [ E_COKE_NAME ] ) ;
		}

		case E_DRUG_TYPE_CRACK : {
			Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ free_slot ] = param ;
			format ( drug_name, sizeof ( drug_name), "%s", Crack [ param ] [ E_CRACK_NAME ] ) ;
		}

		case E_DRUG_TYPE_METH :	 {
			Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ free_slot ] = param ;
			//format ( drug_name, sizeof ( drug_name), "%s", Meth [ param ] [ E_METH_NAME ] ) ;
		}
	}

	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", 
		sprintf("You've bought a %s supply, it's been stored in slot %d of that respective drug type.",
		drug_name, free_slot 
	) ) ;

	Drugs_SavePlayerSupplies(playerid) ;
	UpdateFactionPerkCD(playerid);

	return true ;
}

Cartel_GetClosestEntity ( playerid, Float: dist = 2.5 ) {

	for ( new i, j = sizeof ( Cartel ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, dist, Cartel [ i ] [ E_CARTEL_POS_X ], Cartel [ i ] [ E_CARTEL_POS_Y ], Cartel [ i ] [ E_CARTEL_POS_Z ] ) ) {

			return i ;
		}

		else continue ;
	}

	return INVALID_DRUG_ID ;
}