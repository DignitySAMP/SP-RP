enum { // dealership types

	DEALERSHIP_TYPE_BUDGET,
	DEALERSHIP_TYPE_MUSCLE,
	DEALERSHIP_TYPE_SPORTS, 
	DEALERSHIP_TYPE_UTILITY,
	DEALERSHIP_TYPE_BIKE,
	DEALERSHIP_TYPE_AIRCRAFT,
	DEALERSHIP_TYPE_BOAT
}

enum DealershipData {

	dealership_type,
	dealership_color,
	dealership_name [ 64 ],
	Float: dealership_pos_x,
	Float: dealership_pos_y,
	Float: dealership_pos_z,
	Float: dealership_spawn_x,
	Float: dealership_spawn_y,
	Float: dealership_spawn_z,
	Float: dealership_spawn_a
}

new Dealerships [ ] [ DealershipData ] = {

	{ DEALERSHIP_TYPE_BUDGET,		0x9ACD32FF, "Budget Dealership", 	2131.9111,-1150.7538,23.6992, 	2130.4536,-1140.5157,24.7611,4.6160 },
	{ DEALERSHIP_TYPE_MUSCLE,		0x3299CDFF, "Muscle Dealership", 	2050.3438,	-1901.6233,		13.5469,	2062.1404, -1919.9038, 13.2026, 178.7713 },
	{ DEALERSHIP_TYPE_SPORTS, 		0xCD3232FF, "Sports Dealership", 	1359.7362,	-1854.9513,		13.5642,	1372.0061, -1888.7764, 13.2654, 359.9878 },
	{ DEALERSHIP_TYPE_UTILITY,		0xCDC032FF, "Utility Dealership", 	2420.2966,	-2089.3452,		13.0078,	2453.4556, -2089.8066, 16.1227, 89.6277  },

	{ DEALERSHIP_TYPE_AIRCRAFT,		0xB1924CFF, "Aircraft Dealership", 	1957.5844, -2183.7864, 13.5469,			1920.3378, -2283.1572, 13.7242, 268.9820 },
	{ DEALERSHIP_TYPE_BIKE,			0x4C6BB1FF, "Bike Dealership", 	2352.9255,-1485.1898,23.5759,				2360.1475,-1474.6100,23.3903,91.5235 },
	{ DEALERSHIP_TYPE_BOAT,			0x4C6BB1FF, "Boat Dealership", 	2370.5146,-2527.9280,13.3321,				2337.9048,-2534.0706,-0.6954,352.6024 }
} ;

enum DealershipCarData {

	dealercar_type,
	dealercar_carmodel,
	dealercar_price,
	dealercar_product
}

new DealershipCars [ ] [ DealershipCarData ] = {

   	{ DEALERSHIP_TYPE_SPORTS, 429,  1900000 },
    { DEALERSHIP_TYPE_SPORTS, 541,  3250000 },
    { DEALERSHIP_TYPE_SPORTS, 415,  3500000 },
    { DEALERSHIP_TYPE_SPORTS, 480,  2950000 },
    { DEALERSHIP_TYPE_SPORTS, 587,  2000000 },
    { DEALERSHIP_TYPE_SPORTS, 506,  2150000 },
    { DEALERSHIP_TYPE_SPORTS, 451,  2350000 },
    { DEALERSHIP_TYPE_SPORTS, 477,  1950000 },
    { DEALERSHIP_TYPE_SPORTS, 555,  1050000 },
    { DEALERSHIP_TYPE_SPORTS, 496,  1510000 },
    { DEALERSHIP_TYPE_SPORTS, 589,  1850000 },
    { DEALERSHIP_TYPE_SPORTS, 565,  1800000 },
    { DEALERSHIP_TYPE_SPORTS, 559,  1875000 },
    { DEALERSHIP_TYPE_SPORTS, 558,  375000 },
    { DEALERSHIP_TYPE_SPORTS, 562,  1600000 },
    { DEALERSHIP_TYPE_SPORTS, 560,  2050000 },
    { DEALERSHIP_TYPE_SPORTS, 561,  175000 },

    { DEALERSHIP_TYPE_BUDGET, 518,  17000 },
    { DEALERSHIP_TYPE_BUDGET, 527,  9000 },
    { DEALERSHIP_TYPE_BUDGET, 419,  7000 },
    { DEALERSHIP_TYPE_BUDGET, 533,  80000 },
    { DEALERSHIP_TYPE_BUDGET, 526,  8000 },
    { DEALERSHIP_TYPE_BUDGET, 474,  22000 },
    { DEALERSHIP_TYPE_BUDGET, 517,  33500 },
    { DEALERSHIP_TYPE_BUDGET, 410,  5000 },
    { DEALERSHIP_TYPE_BUDGET, 600,  20000 },
    { DEALERSHIP_TYPE_BUDGET, 436,  3000 },
    { DEALERSHIP_TYPE_BUDGET, 439,  85000 },
    { DEALERSHIP_TYPE_BUDGET, 549,  5000 },
    { DEALERSHIP_TYPE_BUDGET, 491,  10000 },
    { DEALERSHIP_TYPE_BUDGET, 445,  45000 }, 
    { DEALERSHIP_TYPE_BUDGET, 507,  50000 },
    { DEALERSHIP_TYPE_BUDGET, 585,  32000 },
    { DEALERSHIP_TYPE_BUDGET, 466,  28000 },
    { DEALERSHIP_TYPE_BUDGET, 492,  33000 },
    { DEALERSHIP_TYPE_BUDGET, 546,  19000 },
    { DEALERSHIP_TYPE_BUDGET, 551,  40000 },
    { DEALERSHIP_TYPE_BUDGET, 516,  21000 },
    { DEALERSHIP_TYPE_BUDGET, 467,  25500 },
    { DEALERSHIP_TYPE_BUDGET, 404,  10000 },
    { DEALERSHIP_TYPE_BUDGET, 426,  50000 },
    { DEALERSHIP_TYPE_BUDGET, 436,  5000 },
    { DEALERSHIP_TYPE_BUDGET, 547,  10000 },
    { DEALERSHIP_TYPE_BUDGET, 479,  23500 },
    { DEALERSHIP_TYPE_BUDGET, 405,  32500 },
    { DEALERSHIP_TYPE_BUDGET, 458,  29000 },
    { DEALERSHIP_TYPE_BUDGET, 580,  100000 }, // Stafford
    { DEALERSHIP_TYPE_BUDGET, 550,  20000 },
    { DEALERSHIP_TYPE_BUDGET, 540,  25000 },
    { DEALERSHIP_TYPE_BUDGET, 421,  60000 }, // Washington
    { DEALERSHIP_TYPE_BUDGET, 529,  20000 },
    { DEALERSHIP_TYPE_BUDGET, 566,  45000 },
    { DEALERSHIP_TYPE_BUDGET, 412,  40000 },
    { DEALERSHIP_TYPE_BUDGET, 534,  25000 },
    { DEALERSHIP_TYPE_BUDGET, 535,  40000 },
    { DEALERSHIP_TYPE_BUDGET, 536,  45000 },
    { DEALERSHIP_TYPE_BUDGET, 567,  36000 },
    { DEALERSHIP_TYPE_BUDGET, 575,  30000 },
    { DEALERSHIP_TYPE_BUDGET, 576,  20000 },
    { DEALERSHIP_TYPE_BUDGET, 418,  13000 }, 
	{ DEALERSHIP_TYPE_BUDGET, 400,  33000 }, // Landstalker
	{ DEALERSHIP_TYPE_BUDGET, 483,  28000 }, // Camper

    { DEALERSHIP_TYPE_UTILITY, 459,  10000 },
    { DEALERSHIP_TYPE_UTILITY, 482,  50000 },
    { DEALERSHIP_TYPE_UTILITY, 413,  25000 },
    { DEALERSHIP_TYPE_UTILITY, 440,  30000 },
    { DEALERSHIP_TYPE_UTILITY, 414,  60000 },
    { DEALERSHIP_TYPE_UTILITY, 499,  60000 },
    { DEALERSHIP_TYPE_UTILITY, 498,  35000 },
    { DEALERSHIP_TYPE_UTILITY, 456,  80000 },
    { DEALERSHIP_TYPE_UTILITY, 478,  8000 },
    { DEALERSHIP_TYPE_UTILITY, 543,  4500 },
    { DEALERSHIP_TYPE_UTILITY, 422,  8000 },
    { DEALERSHIP_TYPE_UTILITY, 600,  10000 },
    { DEALERSHIP_TYPE_UTILITY, 455,  130000 },
    { DEALERSHIP_TYPE_UTILITY, 554,  40000 },

    // Trucking
 	{ DEALERSHIP_TYPE_UTILITY, 403,  200000 },
  	{ DEALERSHIP_TYPE_UTILITY, 514,  230000 },
   	{ DEALERSHIP_TYPE_UTILITY, 515,  300000 },

    { DEALERSHIP_TYPE_MUSCLE, 579,  725000 },
    { DEALERSHIP_TYPE_MUSCLE, 500,  250000 },
    { DEALERSHIP_TYPE_MUSCLE, 489,  185000 },
    { DEALERSHIP_TYPE_MUSCLE, 554,  350000  },
    { DEALERSHIP_TYPE_MUSCLE, 603,  315000 },
    { DEALERSHIP_TYPE_MUSCLE, 402,  1750000 },
    { DEALERSHIP_TYPE_MUSCLE, 475,  350000 },
    { DEALERSHIP_TYPE_MUSCLE, 542,  14500 },
    { DEALERSHIP_TYPE_MUSCLE, 545,  200000 },

	{ DEALERSHIP_TYPE_BIKE, 581,  90000 },	// BF-400
	{ DEALERSHIP_TYPE_BIKE, 509,  900 },	// Bike
	{ DEALERSHIP_TYPE_BIKE, 481,  1250 },	// BMX
	{ DEALERSHIP_TYPE_BIKE, 462,  4750 },	// Faggio
	{ DEALERSHIP_TYPE_BIKE, 521,  175000 },	// FCR
	{ DEALERSHIP_TYPE_BIKE, 463,  40000 },	// Freeway
	{ DEALERSHIP_TYPE_BIKE, 510,  2000 }, 	// Mountain Bike
	{ DEALERSHIP_TYPE_BIKE, 461,  130000 },	// PCJ
	{ DEALERSHIP_TYPE_BIKE, 448,  5000 },	// Pizzaboy
	{ DEALERSHIP_TYPE_BIKE, 468,  57500 },	// Sanchez
	{ DEALERSHIP_TYPE_BIKE, 586,  25000 },	// Wayfarer
	{ DEALERSHIP_TYPE_BIKE, 471,  10000 },	// Quad

	{ DEALERSHIP_TYPE_BOAT, 446, 200000 }, // squallo
	{ DEALERSHIP_TYPE_BOAT, 452, 300000 }, // speeder
	{ DEALERSHIP_TYPE_BOAT, 453, 50000 }, // reefer
	{ DEALERSHIP_TYPE_BOAT, 454, 350000 }, // tropic
	{ DEALERSHIP_TYPE_BOAT, 473, 30000 }, // dinghy
	{ DEALERSHIP_TYPE_BOAT, 484, 450000 }, // marquis
	{ DEALERSHIP_TYPE_BOAT, 493, 450000 }, // jetmax

	{ DEALERSHIP_TYPE_AIRCRAFT, 487, 3850000 },
    { DEALERSHIP_TYPE_AIRCRAFT, 519, 4000000 },
    { DEALERSHIP_TYPE_AIRCRAFT, 511, 4000000 },
    { DEALERSHIP_TYPE_AIRCRAFT, 512, 2750000 },
    { DEALERSHIP_TYPE_AIRCRAFT, 513, 2550000 },
    { DEALERSHIP_TYPE_AIRCRAFT, 553, 5500000 },
    { DEALERSHIP_TYPE_AIRCRAFT, 593, 2750000 },	
    { DEALERSHIP_TYPE_BOAT, 460, 800000 } // skimmer

} ;

#define INVALID_DEALERSHIP_ID	-1

stock DealerShip_GetModelPrice(modelid) {

    for ( new i, j = sizeof (DealershipCars ) ; i < j ; i ++ ) {

        if ( DealershipCars [ i ] [ dealercar_carmodel ] == modelid ) {

            return DealershipCars [ i ] [ dealercar_price ] ;
        }
    }

    return 7500 ;
}

CMD:gotodealer(playerid, params[]) {

    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

	new dealerid ;

	if ( sscanf ( params, "i", dealerid ) ) {

		SendClientMessage(playerid, COLOR_GRAD0, "/gotodealer [dealerid]");
		SendClientMessage(playerid, COLOR_INFO, "0: budget, 1: muscle, 2: sports, 3: utility, 4: aircraft, 5: bike, 6: boat");

		return true ;
	}

	if ( dealerid < 0 || dealerid >= sizeof ( Dealerships ) ) {

		SendClientMessage(playerid, COLOR_ERROR, sprintf("This ID isn't valid. Only ID 0 to %d.", sizeof ( Dealerships ) ) ) ;
	}

	PauseAC(playerid, 3);
	SetPlayerPos ( playerid, Dealerships [ dealerid ] [ dealership_pos_x ], Dealerships [ dealerid ] [ dealership_pos_y ], Dealerships [ dealerid ] [ dealership_pos_z ] ) ;
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	return true ;
}


public OnGameModeInit() {

	for ( new i, j = sizeof ( Dealerships ); i < j; i ++ ) {

		CreateDynamic3DTextLabel(sprintf("%s\n{DEDEDE}Commands: /dealership", Dealerships [ i ] [ dealership_name ] ), Dealerships [ i ] [ dealership_color ], 
			Dealerships [ i ] [ dealership_pos_x ], Dealerships [ i ] [ dealership_pos_y ], Dealerships [ i ] [ dealership_pos_z ],
			15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1 );

		CreateDynamicPickup(1581, 1, Dealerships [ i ] [ dealership_pos_x ], Dealerships [ i ] [ dealership_pos_y ], Dealerships [ i ] [ dealership_pos_z ] );
		CreateDynamicMapIcon(Dealerships [ i ] [ dealership_pos_x ], Dealerships [ i ] [ dealership_pos_y ], Dealerships [ i ] [ dealership_pos_z ], 55, 0, -1, -1, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL );
	}
	
	#if defined dealer_OnGameModeInit
		return dealer_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit dealer_OnGameModeInit
#if defined dealer_OnGameModeInit
	forward dealer_OnGameModeInit();
#endif


CMD:togds(playerid, params[]){

	if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_MANAGER)
		return false;

	if ( !Server [ E_SERVER_IS_DS_OFF ] ){

		Server [ E_SERVER_IS_DS_OFF ] = true;
		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You have closed all server dealerships." );

		return true;
		
	} else if ( Server [ E_SERVER_IS_DS_OFF ]) {

		Server [ E_SERVER_IS_DS_OFF ] = false;
		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You have opened all server dealerships." );

		return true;
	}

	return true;
}

CMD:dealership(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	new dealerid = Dealership_GetClosestEntity(playerid);

	if ( dealerid == INVALID_DEALERSHIP_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Error{A3A3A3}: You're not at a dealership!");
	}

	if( Server [ E_SERVER_IS_DS_OFF ] )
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Dealerships are currently unavailable." );

	if ( Player_GetOwnedVehicles ( playerid ) >= Player_GetMaxOwnedVehicles ( playerid ) ) {
		SendServerMessage ( playerid, COLOR_YELLOW, "Error", "A3A3A3", "You don't have any vehicle ownership slots left. Use /myslots to check." );
		SendClientMessage ( playerid, COLOR_ERROR, "You won't be able to buy anything in this store until you get more slots.");
	}

    new dealer_name [ 128 ], slot_hex[12],slots ;
	ModelBrowser_ClearData(playerid);

	for ( new i, j = sizeof ( DealershipCars ); i < j; i ++ ) {

    	if ( DealershipCars [ i ] [ dealercar_type ] == Dealerships [ dealerid ] [ dealership_type] ) {


    		if ( Dealerships [ dealerid ] [ dealership_type]  == DEALERSHIP_TYPE_UTILITY ) {
    		 	slots = GetMaxStorageModel(DealershipCars [ i ] [ dealercar_carmodel ]) ;


    			if ( ! slots ) {

    				format ( slot_hex, sizeof ( slot_hex ), "~r~" ) ;
    			}

    			else format ( slot_hex, sizeof ( slot_hex ), "~g~" ) ;

				format ( dealer_name, sizeof ( dealer_name ), "%s ($%s) %s~w~%d slots", 
					ReturnVehicleModelName (  DealershipCars [ i ] [ dealercar_carmodel ] ),  
					IntegerWithDelimiter( DealershipCars [ i ] [ dealercar_price ] ), slot_hex, slots
				) ;
    		}

    		else {
				format ( dealer_name, sizeof ( dealer_name ), "%s ($%s)", 
					ReturnVehicleModelName (  DealershipCars [ i ] [ dealercar_carmodel ] ),  
					IntegerWithDelimiter( DealershipCars [ i ] [ dealercar_price ] )
				) ;
			}

			ModelBrowser_AddData(playerid, DealershipCars [ i ] [ dealercar_carmodel ], dealer_name ) ;
		}
	}

	ModelBrowser_SetupTiles(playerid, "Dealership", "dealer_list" );

    return true ;
}

mBrowser:dealer_list(playerid, response, row, model, name[]) {

	if ( ! response ) {

		return true ;
	}

	else if ( response ) {
		new dealerid = Dealership_GetClosestEntity(playerid);

		if ( dealerid == INVALID_DEALERSHIP_ID ) {

			return SendClientMessage(playerid, COLOR_ERROR, "Error{A3A3A3}: You're not at a dealership!");
		}



		new enumid ;

        for ( new i, j = sizeof ( DealershipCars ); i < j; i ++ ) {

        	if ( DealershipCars [ i ] [ dealercar_carmodel ] == model ) {

        		enumid = i ;
        		break ;
        	}

        	else continue ;
        }

		if ( GetPlayerCash ( playerid ) < DealershipCars [ enumid ] [ dealercar_price ] ) {

			return SendClientMessage(playerid, COLOR_RED, "You don't have enough money for this vehicle!");
		}

		if ( Player_GetOwnedVehicles ( playerid ) >= Player_GetMaxOwnedVehicles ( playerid ) ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any vehicle ownership slots left. Use /myslots to check." );
		}

		TakePlayerCash(playerid, DealershipCars [ enumid ] [ dealercar_price ] );

		Vehicle_CreateEntity ( playerid, model, E_VEHICLE_TYPE_PLAYER, Character [ playerid ] [ E_CHARACTER_ID ],  Dealerships[dealerid][dealership_spawn_x], Dealerships[dealerid][dealership_spawn_y], Dealerships[dealerid][dealership_spawn_z], Dealerships[dealerid][dealership_spawn_a], random (255), random (255) ) ;

		SendClientMessage(playerid, COLOR_VEHICLE, sprintf("You bought a (%d) %s, price: $%d. For help, use /carhelp.", 
			DealershipCars [ enumid ] [ dealercar_carmodel ], ReturnVehicleModelName (  DealershipCars [ enumid ] [ dealercar_carmodel ] ),  DealershipCars [ enumid ] [ dealercar_price ])) ;

		// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for both
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Bought a %s for $%d", ReturnVehicleModelName (  DealershipCars [ enumid ] [ dealercar_carmodel ]), DealershipCars [ enumid ] [ dealercar_price ]));

	}

	return true ;
}


Dealership_GetClosestEntity(playerid) {
	for ( new i, j = sizeof ( Dealerships ); i < j; i ++ ) {

		if ( IsPlayerInRangeOfPoint ( playerid, 2.5, Dealerships [ i ] [ dealership_pos_x ], 
			Dealerships [ i ] [ dealership_pos_y ], Dealerships [ i ] [ dealership_pos_z ] ) ) {

			return i ; 
		}

		else continue ;
	}

	return INVALID_DEALERSHIP_ID ;
}

stock Dealership_GetType(dealerid) {

	if ( dealerid < 0 || dealerid > sizeof ( Dealerships ) ) {

		return -1 ;
	}

	return Dealerships [ dealerid ] [ dealership_type ] ; 
}