
enum
{
	E_TRUCK_STORE_RSHAUL,
	E_TRUCK_STORE_ACCELSMART,
	E_TRUCK_STORE_VICINITA,
	E_TRUCK_STORE_TRENTON,
	E_TRUCK_STORE_FLEXRISE,
	E_TRUCK_STORE_EDYO,
	E_TRUCK_STORE_RODEO,
	E_TRUCK_STORE_CUSINIA,
	E_TRUCK_STORE_SYNARD,
	E_TRUCK_STORE_KAKAGAWA,
	E_TRUCK_STORE_SUMO,
	E_TRUCK_STORE_COLLABV,
	E_TRUCK_STORE_SPROUT,
	E_TRUCK_STORE_ROBADA,
	E_TRUCK_STORE_CB_FC,
	E_TRUCK_STORE_MOONTRADE,
	E_TRUCK_STORE_BURGERSHOT_LS,
	E_TRUCK_STORE_DF_BAKERY,
	E_TRUCK_STORE_BIG_JOE
}

enum E_TRUCKING_STORE_DATA 
{
	E_TRUCK_STORE_CONSTANT,
	E_TRUCK_STORE_DESC[32],
	E_TRUCK_STORE_ICON,
	E_TRUCK_STORE_MODEL,

	Float: E_TRUCK_STORE_POS_X,
	Float: E_TRUCK_STORE_POS_Y,
	Float: E_TRUCK_STORE_POS_Z,

	E_TRUCK_STORE_ITEM[7]
}

new TruckingStores[][E_TRUCKING_STORE_DATA] = {

	{E_TRUCK_STORE_RSHAUL,			"RS Haul",						51, 18961,	-62.7620, -1121.7162, 1.2171,		{ITEM_IRON,		ITEM_ROCK,		ITEM_PLASTIC,	ITEM_SAND,			ITEM_CONCRETE}, 										},
	{E_TRUCK_STORE_ACCELSMART,		"Accelsmart Industries",		51, 19468,	1630.0909, -1903.8269, 13.0679,		{ITEM_IRON,		ITEM_ROCK,		ITEM_PLASTIC,	ITEM_SAND,			ITEM_CONCRETE}, 										},
	{E_TRUCK_STORE_VICINITA,		"Vicinita Co.",					51, 19874,	2281.3252, -2364.8457, 13.5469,		{ITEM_SOAP,		ITEM_GAS,		ITEM_COTTON, 	ITEM_STRING,		ITEM_SILK,		ITEM_LOG,			ITEM_PAPER},		},
	{E_TRUCK_STORE_TRENTON,			"Trenton Group",				51, 19921,	2549.6692, -2220.2488, 13.5469,		{ITEM_SOAP,		ITEM_GAS,		ITEM_COTTON, 	ITEM_STRING,		ITEM_SILK,		ITEM_LOG,			ITEM_PAPER},		},
	{E_TRUCK_STORE_FLEXRISE,		"Flexrise Ltd.",				51, 19160,	2197.0466, -2663.2871, 13.5469,		{ITEM_IRON,		ITEM_PLASTIC,	ITEM_LOG},																					},
	{E_TRUCK_STORE_EDYO,			"Edyo Catering",				51, 19809,	1702.8152, -1470.5417, 13.5469,		{ITEM_MEAT,		ITEM_PORK,		ITEM_MILK,		ITEM_WATER,			ITEM_SALT,		ITEM_FRYING_OIL,	ITEM_SUGAR},		},
	{E_TRUCK_STORE_RODEO,			"The Rodeo Food",				51, 19809,	573.1382, -1570.9061, 16.1817,		{ITEM_TURKEY,	ITEM_EGG,		ITEM_CORN,		ITEM_WATER,			ITEM_SALT,		ITEM_FRYING_OIL,	ITEM_SUGAR},		},
	{E_TRUCK_STORE_CUSINIA,			"Cusinia",						51, 19809,	1921.1139,-1864.0914,13.5606,		{ITEM_CHICKEN,	ITEM_LEMON,		ITEM_CARROT,	ITEM_APPLE,			ITEM_FIG,		ITEM_COCAO,			ITEM_FRYING_OIL},	},
	{E_TRUCK_STORE_SYNARD,			"Synard",						51, 19573,	2045.6320,-2153.5459,13.1897,		{ITEM_LOG, 		ITEM_COAL}, 																								},
	{E_TRUCK_STORE_KAKAGAWA,		"Kakagawa",						51, 2316,	1430.2325, 1085.4319, 10.8203,		{ITEM_IRON, 	ITEM_PLASTIC, 	ITEM_PAPER},																				},
	{E_TRUCK_STORE_SUMO,			"Sumo",							51, 18875,	1374.9071, 1020.0590, 10.8203,		{ITEM_IRON, 	ITEM_PLASTIC, 	ITEM_PAPER},																				},
	{E_TRUCK_STORE_COLLABV,			"Collab Venture",				51, 1558,	1058.3145, 1280.7065, 10.8203,		{ITEM_PAINT,	ITEM_WATER},																								},
	{E_TRUCK_STORE_SPROUT,			"Sproutganic",					51, 2241,	1418.7830, 221.9432, 19.5618,		{ITEM_SAPLING,	ITEM_WATER},																								},
	{E_TRUCK_STORE_ROBADA,			"Robada Drugs",					51, 1241,	-552.8614, 2593.8972, 53.9348,		{ITEM_ACETONE,	ITEM_ETHANOL},																								},
	{E_TRUCK_STORE_CB_FC,			"Cluckin' Bell (Fort Carson)",	14, 2768,	172.2382, 1177.0332, 14.7578,		{ITEM_CHICKEN,	ITEM_POTATO,	ITEM_EGG,		ITEM_WATER,			ITEM_SALT,		ITEM_FRYING_OIL,	ITEM_SUGAR},		},
	{E_TRUCK_STORE_MOONTRADE,		"Moontrade Inc.",				51,	2901,	577.4213, 1223.4944, 11.7113,		{ITEM_WHEAT,	ITEM_CORN},																									},
	{E_TRUCK_STORE_BURGERSHOT_LS,	"Burger Shot (LS)",				10,	2703,	793.3480, -1625.5189, 13.3828,		{ITEM_MEAT,		ITEM_CHICKEN,	ITEM_POTATO,	ITEM_FRYING_OIL,	ITEM_SALT, 		ITEM_WATER},							},
	{E_TRUCK_STORE_DF_BAKERY,		"D. Flour Bakery",				51, 19579,	-1812.5109,-135.3622,6.1240,		{ITEM_WHEAT,	ITEM_SALT,		ITEM_SUGAR,		ITEM_COCAO,			ITEM_MILK,		ITEM_EGG,			ITEM_FRYING_OIL},	},
	{E_TRUCK_STORE_BIG_JOE,			"Big Joe Auto Service",			51, 1096,	2516.4941, -2428.0964, 13.6198,		{ITEM_TYRE,		ITEM_MOTOR_OIL,	ITEM_CAR_ENGINE},																			}
};

Trucker_LoadEntities_Stores() {

	new text_long [ 512 ] ;

	for ( new s, j = sizeof ( TruckingStores ); s < j ; s ++ ) {

		CreateDynamicMapIcon(TruckingStores[s][E_TRUCK_STORE_POS_X], TruckingStores[s][E_TRUCK_STORE_POS_Y], TruckingStores[s][E_TRUCK_STORE_POS_Z], TruckingStores[s][E_TRUCK_STORE_ICON], 0);
	    CreateDynamicPickup(TruckingStores[s][E_TRUCK_STORE_MODEL], 1, TruckingStores[s][E_TRUCK_STORE_POS_X], TruckingStores[s][E_TRUCK_STORE_POS_Y], TruckingStores[s][E_TRUCK_STORE_POS_Z]);
	   
	    format ( text_long, sizeof ( text_long ), "[%d] [%s]\n{DEDEDE}Available Commands: /crate putdown\n\n[Buys the following]\n%s", s, TruckingStores[s][E_TRUCK_STORE_DESC], TruckingStore_GetItems ( s, .formatted=true, .buyprice=true) ) ;
	    CreateDynamic3DTextLabel(text_long, 0x1FB7DEFF, TruckingStores[s][E_TRUCK_STORE_POS_X], TruckingStores[s][E_TRUCK_STORE_POS_Y], TruckingStores[s][E_TRUCK_STORE_POS_Z], 10.0);
	
	}
}

TruckingStore_GetItems(index, formatted=false, buyprice=false) {
	new string[512], item_index, item_name [ 64 ] ;

	for(new i = 0; i < 5; i++) {

		if(TruckingStores[index][E_TRUCK_STORE_ITEM][i] > 0) {

			item_index = TruckingStores[index][E_TRUCK_STORE_ITEM][i] ;

			TruckerItem_GetName ( item_index, item_name, sizeof ( item_name ) ) ;
			
			if ( formatted ) {
				format(item_name, sizeof(item_name), "{DEC61F}%s{DEDEDE} [$%s]\n", item_name, IntegerWithDelimiter ( TruckerItem_GetPrice(item_index) ));
			}

			else {
				if ( ! buyprice ) {
					format(item_name, sizeof(item_name), "[%s: $%s]", item_name, IntegerWithDelimiter ( TruckerItem_GetPrice(item_index) ));
				}

				else {
					new reward = floatround ( TruckerItem_GetPrice(item_index) * 1.5, floatround_ceil);
					format(item_name, sizeof(item_name), "[%s: $%s]", item_name, IntegerWithDelimiter ( reward ));
				}
			}

			strcat(string, item_name);
			item_name[0] = EOS; // Clearing after storing so we don't overlap the old data.
		}
	}
    return string;
}


CMD:gotostore(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new index, string [ 128 ];

	if ( sscanf ( params, "i", index ) ) {

		return SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", "/gotostore [index]" ) ;
	}


	if ( index < 0 || index >= sizeof ( TruckingStores ) ) {

		format ( string, sizeof ( string ), "Index can't be less than 0 or more than %d.", sizeof ( TruckingStores ) - 1) ;
		return SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", string ) ;
	}

	format ( string, sizeof ( string ), "You've teleported to \"%s\". It wants the following items:", TruckingStores [ index ] [ E_TRUCK_STORE_DESC ] ) ;
	SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", string ) ;

	SendClientMessage ( playerid, 0xDEDEDEFF, TruckingStore_GetItems(index, .formatted=false) ) ;
	PauseAC(playerid, 3);
	SetPlayerPos(playerid, TruckingStores[index][E_TRUCK_STORE_POS_X], TruckingStores[index][E_TRUCK_STORE_POS_Y], TruckingStores[index][E_TRUCK_STORE_POS_Z]);

	return true ;
}

GetNearestStoreID(playerid)
{
	new ID = -1;
	for(new w = 0; w < sizeof(TruckingStores); w++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, TruckingStores[w][E_TRUCK_STORE_POS_X], TruckingStores[w][E_TRUCK_STORE_POS_Y], TruckingStores[w][E_TRUCK_STORE_POS_Z ]))
		{
			ID = w;
			break;
		}
	}
	return ID;
}

IsStoreAcceptingGood(storeid, goodid)
{
	new bool:response = false;
	for(new inv = 0; inv < 7; inv++)
	{
		if(TruckingStores[storeid][E_TRUCK_STORE_ITEM][inv] == goodid)
		{
			response = true;
			break;
		}
	}
	return response;
}


GetGoodsFromStores(id)
{
	new string[128], part[16], bool:do_no_harm = false;
	for(new p = 0; p < 7; p++)
	{
		if(TruckingStores[id][E_TRUCK_STORE_ITEM][p] > 0)
		{
			format(part, sizeof(part), "%s, ", TruckerItem[TruckingStores[id][E_TRUCK_STORE_ITEM][p]][E_WHOLESALER_ITEM_NAME ]);
			strcat(string, part);
			if(p == 6)
			{
				strdel(string, strlen(string)-2, strlen(string));
			}
		}
		else if(do_no_harm == false)
		{		
			do_no_harm = true;
			strdel(string, strlen(string)-2, strlen(string));
		}
	}
	return string;
}
