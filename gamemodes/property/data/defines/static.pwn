enum E_STATIC_BUY_POSITIONS {

	Float: E_BUY_POS_X,
	Float: E_BUY_POS_Y,
	Float: E_BUY_POS_Z,
	E_BUY_TYPE,
	E_BUY_MAPICON,
	E_BUY_PICKUP_MODEL
} ;

new BuyPoint [ ] [ E_STATIC_BUY_POSITIONS ] = {

	{ 2414.4395, 	-1504.0961, 	23.9969, E_BUY_TYPE_FOOD_CLUCKINBELL, 	true }, // els cluckinbell
	{ 1034.7678,	-1348.2057,		13.7301, E_BUY_TYPE_FOOD_DONUTS, 		true }, // market donuts
	{ 2106.4382,	-1797.7552,		13.5729, E_BUY_TYPE_FOOD_PIZZASTACK, 	true },  // Idlewood pizzastack
	{ 2393.3416, 	-1905.6464, 	13.5541, E_BUY_TYPE_FOOD_CLUCKINBELL, 	true }, // Willowfield cluck
	{ 1924.2190,	-1771.4872,		13.5781, E_BUY_TYPE_GENERAL, 			true }, // enex_idle_buy
	{ 2427.9097,	-1744.8375,		13.6750, E_BUY_TYPE_GENERAL, 			true }, // enex_buypoint_ganton
	{ 2239.7866,	-1157.2561,		25.8594, 999, 							true}, // jeff motel

	{ 2108.5146, 	-1813.3501, 	13.3932, E_BUY_TYPE_FOOD_PIZZA_DT, 	false },  // idle pizza (Drivethru)
	{ 2409.3032,	-1487.8939,		23.4782, E_BUY_TYPE_FOOD_CLUCKINBELL_DT, 	false }, // cluck_drivethru_els
	{ 2377.5679,	-1909.2240,		13.0324, E_BUY_TYPE_FOOD_CLUCKINBELL_DT, 	false }, // cluck_drivethru_willowfield

	{ 1859.7758,	-1671.1080,		13.3731, E_BUY_TYPE_FOOD_BURGERSHOT, false},
	{ 1901.3927,	-1701.4585,		13.4799, E_BUY_TYPE_MUSIC, true }
} ;

Property_SetupBuyPoints() {


	new label [ 256 ], icon ;

	for(new i, j = sizeof ( BuyPoint ); i < j ; i ++ ) {

		switch ( BuyPoint [ i ] [ E_BUY_TYPE ] ) {

			case E_BUY_TYPE_GENERAL: {

				format(label, sizeof(label), "[General Store]{DEDEDE}\nAvailable Commands: /buy");
				icon = 17 ;
			}
			
			case E_BUY_TYPE_LIQUOR: {

				format(label, sizeof(label), "[Liquor Store]{DEDEDE}\nAvailable Commands: /buy");
				icon = 49 ;
			}			
			case E_BUY_TYPE_JEWELRY: {

				format(label, sizeof(label), "[Jewelry Store]{DEDEDE}\nAvailable Commands: None\nView the Attach Points to access this shop.");
				icon = 33 ;
			}

			case E_BUY_TYPE_CLOTHING: {

				format(label, sizeof(label), "[Clothing Store]{DEDEDE}\nAvailable Commands: /buy");
				icon = 45 ;
			}		
				
			case E_BUY_TYPE_ELECTRONIC: {

				format(label, sizeof(label), "[Electronic Store]{DEDEDE}\nAvailable Commands: /buy");
				icon = 35 ;
			}
	
			case E_BUY_TYPE_RESTAURANT: {
				format(label, sizeof(label), "[Restaurant]{DEDEDE}\nAvailable Commands: /buy");
				icon = 50 ;	
			}

			case E_BUY_TYPE_FOOD_CLUCKINBELL: {

				format(label, sizeof(label), "[Cluckin' Bell]{DEDEDE}\nAvailable Commands: /buy");
				icon = 14 ;
			}

			case E_BUY_TYPE_FOOD_CLUCKINBELL_DT: {
				format(label, sizeof(label), "[Cluckin' Bell Drive-thru]{DEDEDE}\nAvailable Commands: /buy");
				icon = 14 ;
			}

			case E_BUY_TYPE_FOOD_PIZZASTACK: {

				format(label, sizeof(label), "[Pizza Stack]{DEDEDE}\nAvailable Commands: /buy");
				icon = 29 ;
			}
			case E_BUY_TYPE_FOOD_PIZZA_DT: {
				format(label, sizeof(label), "[Pizza Stack Drive-thru]{DEDEDE}\nAvailable Commands: /buy");
				icon = 29 ;
			}


			case E_BUY_TYPE_FOOD_BURGERSHOT: {

				format(label, sizeof(label), "[Burger Shot]{DEDEDE}\nAvailable Commands: /buy");
				icon = 10 ;
			}
			case E_BUY_TYPE_FOOD_DONUTS: {

				format(label, sizeof(label), "[Coffee Shop]{DEDEDE}\nAvailable Commands: /buy");
				icon = 16 ;
			}

			case E_BUY_TYPE_BARBERSHOP: {


				format(label, sizeof(label), "[Barbershop]{DEDEDE}\nAvailable Commands: None\nView the Attach Points to access this shop.");
				icon = 7 ;
			}

			case E_BUY_TYPE_AMMUNATION: {

				format(label, sizeof(label), "[Ammu-Nation]{DEDEDE}\nAvailable Commands: /buy");
				icon = 6 ;
			}

			case E_BUY_TYPE_HARDWARE: {

				format(label, sizeof(label), "[Hardware Store]{DEDEDE}\nAvailable Commands: /buy");
				icon = 11 ;
			}

			case E_BUY_TYPE_MUSIC: {

				format(label, sizeof(label), "[Music Shop]{DEDEDE}\nAvailable Commands: /buy");
				icon = 48 ;
			}

			case 999: {
				
				format(label, sizeof(label), "[Jefferson Motel]{DEDEDE}\nAvailable Commands: None");
				icon = 37 ;
			}

			default: {

				format(label, sizeof(label), "[Undefined]{DEDEDE}\nAvailable Commands: none");
			}
		}

		CreateDynamic3DTextLabel(label, COLOR_PROPERTY, 
			BuyPoint [ i ] [ E_BUY_POS_X ], BuyPoint [ i ] [ E_BUY_POS_Y ], BuyPoint [ i ] [ E_BUY_POS_Z ], 
			10.0, .testlos = 1
		) ;

		if ( BuyPoint [ i ] [ E_BUY_MAPICON ] ) {
			CreateDynamicMapIcon(BuyPoint [ i ] [ E_BUY_POS_X ], BuyPoint [ i ] [ E_BUY_POS_Y ], BuyPoint [ i ] [ E_BUY_POS_Z ], icon, 0xFFFFFFFF, -1, -1, -1, 20.0 ) ;
		}

		//new pickup_model = PropertyType_GetPickup(BuyPoint [ i ] [ E_BUY_TYPE ]);
		new pickup_model = BuyPoint [ i ] [ E_BUY_PICKUP_MODEL ];
		if (pickup_model)
		{
			CreateDynamicPickup(pickup_model, 1, BuyPoint [ i ] [ E_BUY_POS_X ], BuyPoint [ i ] [ E_BUY_POS_Y ], BuyPoint [ i ] [ E_BUY_POS_Z ], .streamdistance = 50.0);
		}

		
	}

	return true ;
}


