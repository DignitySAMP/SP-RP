enum E_PLAYER_DRUG_PACKAGING_DATA {

	E_PLAYER_PACKAGE_ZIPLOC_BAG,
	E_PLAYER_PACKAGE_WRAPPED_FOIL,
	E_PLAYER_PACKAGE_PILL_BOTTLE,
	E_PLAYER_PACKAGE_PIZZA_BOX,
	E_PLAYER_PACKAGE_BURGER_CARTON,
	E_PLAYER_PACKAGE_TAKEAWAY_BAG,
	E_PLAYER_PACKAGE_MILK_CARTON,
	E_PLAYER_PACKAGE_PLASTIC_CUP,
	E_PLAYER_PACKAGE_BRICK
} ;

new PlayerDrugContainer[MAX_PLAYERS][E_PLAYER_DRUG_PACKAGING_DATA] ;

Drugs_LoadEntity_Containers(playerid) {

   	new query [ 1024 ] ;

    inline DrugLoadContainers() {
        if (!cache_num_rows()) {
        	mysql_format(mysql, query, sizeof ( query ), "INSERT INTO drugs_player_packages(package_character_id, \
        		package_ziploc_bag, package_wrapped_foil, package_pill_bottle, package_plastic_cup, package_pizza_box, \
        		package_burger_carton, package_milk_carton, package_takeaway_bag, package_brick) VALUES (%d, 0, 0, 0, 0,\
        		0, 0, 0, 0, 0)", Character [ playerid ] [ E_CHARACTER_ID ] 
        	) ;

        	mysql_tquery(mysql, query) ;
        } else {
			cache_get_value_name_int(0, "package_ziploc_bag", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ]);
			cache_get_value_name_int(0, "package_wrapped_foil", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ]);
			cache_get_value_name_int(0, "package_pill_bottle", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ]);
			cache_get_value_name_int(0, "package_plastic_cup", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ]);
			cache_get_value_name_int(0, "package_pizza_box", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ]);
			cache_get_value_name_int(0, "package_burger_carton", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ]);
			cache_get_value_name_int(0, "package_milk_carton", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ]);
			cache_get_value_name_int(0, "package_takeaway_bag", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ]);
			cache_get_value_name_int(0, "package_brick", PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ]);
        }
    }

    mysql_format(mysql, query, sizeof ( query ), "SELECT * FROM drugs_player_packages WHERE package_character_id = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
    MySQL_TQueryInline(mysql, using inline DrugLoadContainers, query, "" ) ;
}

Drugs_SavePlayerContainer ( playerid ) {

	new query [ 1024 ] ;


	mysql_format ( mysql, query, sizeof ( query ), "UPDATE drugs_player_packages SET package_ziploc_bag = %d, \
		package_wrapped_foil = %d, package_pill_bottle = %d, package_plastic_cup = %d, package_pizza_box = %d, \
		package_burger_carton = %d, package_milk_carton = %d, package_takeaway_bag = %d, package_brick = %d \
		WHERE package_character_id = %d",

		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ], 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ], 
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] , PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ], 
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ], 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ], 
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ], 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ], 
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ], 		Character [ playerid ] [ E_CHARACTER_ID ]  
	) ;

	mysql_tquery(mysql, query);

	return true ;	
}

CMD:drugpackages(playerid, params[]) {

	return cmd_drugcontainers(playerid, params);
}

CMD:drugcontainers(playerid, params[]) {

	SendClientMessage(playerid, COLOR_DRUGS, "|______________| Your Containers |______________| ") ;


	SendClientMessage(playerid, 0xDEDEDEFF, sprintf("[ID 0] [Ziploc Bags: %d]{A3A3A3} [ID 1] [Wrapped Foils: %d]{DEDEDE} [ID 2] [Pill Bottles: %d]",
	
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ], 
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ], 
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] 
	) );


	SendClientMessage(playerid, 0xA3A3A3FF, sprintf("[ID 3] [Pizza Boxes: %d]{DEDEDE} [ID 4] [Burger Cartons: %d]{A3A3A3} [ID 5] [Takeaway Bags: %d]",
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ],
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ],
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ]
	) ) ;

	SendClientMessage(playerid, 0xDEDEDEFF, sprintf("[ID 6] [Milk Carton: %d]{A3A3A3} [ID 7] [Plastic Cup: %d]{DEDEDE} [ID 8] [Wrapped Brick: %d]",
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ],
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ],
		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ]
	) ) ;

	return true ;
}

Drugs_DoesPlayerHaveContainer ( playerid, container ) {

	switch ( container ) {

		case E_DRUG_PACKAGE_ZIPLOC_BAG: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ] ) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ] ;
			}
		}	
		case E_DRUG_PACKAGE_WRAPPED_FOIL: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ] ) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ] ;
			}
		}	
		case E_DRUG_PACKAGE_PILL_BOTTLE: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] ) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] ;
			}
		}	
		case E_DRUG_PACKAGE_PIZZA_BOX:  { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ]) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ] ;
			}
		}	
		case E_DRUG_PACKAGE_BURGER_CARTON: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ] ) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ] ;
			}
		}
		case E_DRUG_PACKAGE_TAKEAWAY_BAG: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ] ) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ] ;
			}
		}
		case E_DRUG_PACKAGE_MILK_CARTON: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ]	) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ] ;
			}
		}
		case E_DRUG_PACKAGE_PLASTIC_CUP: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ] 	) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ] ;
			}
		}
		case E_DRUG_PACKAGE_BRICK :	 { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ] ) {

				return PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ] ;
			}
		}	
	}

	return false ;
}

Drugs_DecreasePlayerContainer ( playerid, container ) {

	switch ( container ) {

		case E_DRUG_PACKAGE_ZIPLOC_BAG: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ] ) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ] -- ;
			}

			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ] = 0;
		}

		case E_DRUG_PACKAGE_WRAPPED_FOIL: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ] ) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ] = 0 ;
		}

		case E_DRUG_PACKAGE_PILL_BOTTLE: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] ) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] = 0 ;
		}

		case E_DRUG_PACKAGE_PIZZA_BOX:  { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ]) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ] = 0 ;
		}

		case E_DRUG_PACKAGE_BURGER_CARTON: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ] ) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ] = 0 ;
		}
		case E_DRUG_PACKAGE_TAKEAWAY_BAG: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ] ) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ] = 0 ;
		}
		case E_DRUG_PACKAGE_MILK_CARTON: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ]	) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ] = 0 ;
		}
		case E_DRUG_PACKAGE_PLASTIC_CUP: { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ] 	) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ] = 0 ;
		}
		case E_DRUG_PACKAGE_BRICK :	 { 

			if ( PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ] ) {

				PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ] -- ;
			}
			else PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ] = 0 ;
		}
	}

	Drugs_SavePlayerContainer ( playerid ) ;

	return false ;
}


Drugs_IncreasePlayerContainer ( playerid, container ) {

	switch ( container ) {

		case E_DRUG_PACKAGE_ZIPLOC_BAG: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_ZIPLOC_BAG ] ++ ;
		case E_DRUG_PACKAGE_WRAPPED_FOIL: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_WRAPPED_FOIL ] ++ ;
		case E_DRUG_PACKAGE_PILL_BOTTLE: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PILL_BOTTLE ] ++ ;
		case E_DRUG_PACKAGE_PIZZA_BOX:  	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PIZZA_BOX ] ++ ;
		case E_DRUG_PACKAGE_BURGER_CARTON: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BURGER_CARTON ] ++ ;
		case E_DRUG_PACKAGE_TAKEAWAY_BAG: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_TAKEAWAY_BAG ] ++ ;
		case E_DRUG_PACKAGE_MILK_CARTON: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_MILK_CARTON ] ++ ;
		case E_DRUG_PACKAGE_PLASTIC_CUP: 	PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_PLASTIC_CUP ] ++ ;
		case E_DRUG_PACKAGE_BRICK :	 		PlayerDrugContainer [ playerid ] [ E_PLAYER_PACKAGE_BRICK ] ++ ;
	}

	Drugs_SavePlayerContainer ( playerid ) ;

	return false ;
}