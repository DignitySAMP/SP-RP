
enum
{
	ITEM_NONE,
	ITEM_MEAT = 1,
	ITEM_PORK,
	ITEM_CHICKEN,
	ITEM_TURKEY,
	ITEM_MILK,
	ITEM_EGG,
	ITEM_CORN,
	ITEM_WHEAT,
	ITEM_POTATO,
	ITEM_CARROT,
	ITEM_LEMON,
	ITEM_APPLE,
	ITEM_FIG,
	ITEM_COCAO,
	ITEM_SALT,
	ITEM_SUGAR,
	ITEM_FRYING_OIL,
	ITEM_WATER,
	ITEM_COAL,
	ITEM_IRON,
	ITEM_ROCK,
	ITEM_PLASTIC,
	ITEM_SAND,
	ITEM_CONCRETE,
	ITEM_SOAP,
	ITEM_GAS,
	ITEM_COTTON,
	ITEM_LOG,
	ITEM_SILK,
	ITEM_STRING,
	ITEM_PAPER,
	ITEM_PAINT,
	ITEM_SAPLING,
	ITEM_ACETONE,
	ITEM_ETHANOL,
	ITEM_CAR_ENGINE,
	ITEM_MOTOR_OIL,
	ITEM_TYRE
}

enum E_WHOLESALER_ITEM_DATA {

	E_WHOLESALER_ITEM_CONST,
	E_WHOLESALER_ITEM_NAME [ 64 ],
	E_WHOLESALER_ITEM_PRICE
} ;

new TruckerItem [ ] [ E_WHOLESALER_ITEM_DATA ] = {

	{ ITEM_NONE,	 	"None",			0 },

	// Meat
	{ ITEM_MEAT,	 	"Meat",			75 },
	{ ITEM_PORK,	 	"Pork",			75 },
	{ ITEM_CHICKEN,	 	"Chicken",		75 },
	{ ITEM_TURKEY,	 	"Turkey",		75 },
	{ ITEM_MILK,	 	"Milk",			75 },
	{ ITEM_EGG,		 	"Egg",			60 },
	{ ITEM_CORN,	 	"Corn",			60 },
	{ ITEM_WHEAT,		"Wheat",		60 },
	{ ITEM_POTATO,	 	"Potato",		65 },
	{ ITEM_CARROT,	 	"Carrot",		65 },
	{ ITEM_LEMON,	 	"Lemon",		65 },
	{ ITEM_APPLE,	 	"Apple",		65 },
	{ ITEM_FIG,		 	"Fig",			80 },
	{ ITEM_COCAO,		"Cocao",		80 },
	{ ITEM_SALT,		"Salt",			80 },
	{ ITEM_SUGAR,		"Sugar",		80 },
	{ ITEM_FRYING_OIL, 	"Frying Oil",	70 },
	{ ITEM_WATER,		"Water",		70 },
	{ ITEM_COAL,		"Coal",			85 },
	{ ITEM_IRON,		"Iron",			85 },
	{ ITEM_ROCK,		"Rock",			85 },
	{ ITEM_PLASTIC,		"Plastic",		90 },
	{ ITEM_SAND,		"Sand",			80 },
	{ ITEM_CONCRETE,	"Concrete",		80 },
	{ ITEM_SOAP,		"Soap",			85 },
	{ ITEM_GAS,		 	"Gas",			100 },
	{ ITEM_COTTON,	 	"Cotton",		95 },
	{ ITEM_LOG,		 	"Log",			75 },
	{ ITEM_SILK,		"Silk",			100 },
	{ ITEM_STRING,		"String",		95 },
	{ ITEM_PAPER,		"Paper",		25 },
	{ ITEM_PAINT,		"Paint",		125 },
	{ ITEM_SAPLING,	 	"Sapling",		100 },
	{ ITEM_ACETONE,	 	"Acetone",		125 },
	{ ITEM_ETHANOL,	 	"Ethanol",		125 },
	{ ITEM_CAR_ENGINE, 	"Car Engine",	135 },
	{ ITEM_MOTOR_OIL,	"Motor Oil",	135 },
	{ ITEM_TYRE,		"Tyre",			130 }
} ;

TruckerItem_GetName(item, name[], len=sizeof(name)) {

	new bool: found = false ;

	for ( new i, j = sizeof ( TruckerItem ); i < j ; i ++ ) {

		if ( TruckerItem [ i ] [ E_WHOLESALER_ITEM_CONST ] == item ) {

			found = true ;
			format ( name, len, "%s", TruckerItem [ i ] [ E_WHOLESALER_ITEM_NAME ] );
		}

		else continue ;
	}

	if ( ! found ) {

		format ( name, len, "Invalid");	
	}
}

TruckerItem_GetPrice(item) {

	if ( item < 0 || item > sizeof ( TruckerItem ) ) {

		return -1 ;
	}

	for ( new i, j = sizeof ( TruckerItem ); i < j ; i ++ ) {

		if ( TruckerItem [ i ] [ E_WHOLESALER_ITEM_CONST ] == item ) {

			return TruckerItem [ i ] [ E_WHOLESALER_ITEM_PRICE ] ;
		}

		else continue ;
	}

	return -1 ;
}