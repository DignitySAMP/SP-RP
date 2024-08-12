enum
{
	E_WS_CONST_EASTBOARD_FARM,
	E_WS_CONST_FLINT_FARM,
	E_WS_CONST_STEVENS_FARM,
	E_WS_CONST_SOLARIN,
	E_WS_CONST_PINE_JEANS,
	E_WS_CONST_FALLEN_TREE,
	E_WS_CONST_APW,
	E_WS_CONST_GOODWEEK,
	E_WS_CONST_HQUARRY,
	E_WS_CONST_APJ,
	E_WS_CONST_AVERY_CON,
	E_WS_CONST_HILLTOP,
	E_WS_CONST_BIOENGI,
	E_WS_CONST_WSTONE_FARM,
	E_WS_CONST_LEAFY,
	E_WS_CONST_PANOP,
	E_WS_CONST_GP_OIL,
	E_WS_CONST_PLAINE
}


enum E_WHOLE_SALERS_DATA
{
	E_WHOLESALERS_CONST,
	E_WHOLESALERS_DESC[32],
	E_WHOLESALERS_ICON,
	E_WHOLESALERS_MODEL,
	Float:E_WHOLESALERS_POS_X,
	Float:E_WHOLESALERS_POS_Y,
	Float:E_WHOLESALERS_POS_Z,
	E_WHOLESALERS_INVENTORY[5]
}

new Wholesalers[][E_WHOLE_SALERS_DATA] = {

	{ E_WS_CONST_EASTBOARD_FARM, 	"EasterBoard Farm",			51, 19626,	-86.0049, 2.6024, 3.1172,			{ITEM_MEAT,			ITEM_CHICKEN,		ITEM_MILK,		ITEM_EGG,	ITEM_WHEAT}		},
	{ E_WS_CONST_FLINT_FARM,		"Flint Farm",				51, 19626,	-1060.5466, -1205.4701, 129.2188,	{ITEM_CORN,			ITEM_POTATO,		ITEM_LEMON,		ITEM_APPLE,	ITEM_FIG}		},
	{ E_WS_CONST_STEVENS_FARM,		"Stevens Farm",				51, 19626,	-382.2487, -1438.9296, 25.7266,		{ITEM_COTTON,		ITEM_SILK,			ITEM_SALT,		ITEM_SUGAR,	ITEM_WATER}		},
	{ E_WS_CONST_SOLARIN, 			"Solarin Industries",		51, 1558,	790.2123, -605.0410, 16.0768,		{ITEM_SOAP,			ITEM_PAINT,			ITEM_FRYING_OIL}							},
	{ E_WS_CONST_PINE_JEANS, 		"Pine Jeans Wholesale",		51, 2384,	-2109.1245, -2281.1162, 30.6319,	{ITEM_COTTON,		ITEM_SILK},														},
	{ E_WS_CONST_FALLEN_TREE,		"Fallen Tree Co.",			51, 2060,	-516.1326, -539.9604, 25.5234,		{ITEM_IRON,			ITEM_ROCK,			ITEM_PLASTIC,	ITEM_SAND,	ITEM_CONCRETE} 	},
	{ E_WS_CONST_APW,				"Angel Pine Sawmill",		51, 19793,	-1971.7515, -2431.1162, 30.6250,	{ITEM_SAPLING,		ITEM_LOG,			ITEM_PAPER}									},
	{ E_WS_CONST_GOODWEEK,			"Goodweek Auto Tech.",		51, 1096,	2836.3967, 954.0068, 10.7500,     	{ITEM_CAR_ENGINE,	ITEM_MOTOR_OIL,		ITEM_TYRE}									},
	{ E_WS_CONST_HQUARRY,			"Hunter Quarry",			11, 337,	819.8788, 857.7254, 12.0469,		{ITEM_COAL, 		ITEM_ROCK, 			ITEM_SAND, 		ITEM_CONCRETE}				},
	{ E_WS_CONST_APJ,				"Angel Pine Junkyard",		51, 1327,	-1896.4722, -1676.7620, 23.0156,	{ITEM_IRON,			ITEM_PLASTIC},													},
	{ E_WS_CONST_AVERY_CON,			"Avery Construction",		51, 19904,	303.7226, -242.6337, 1.5781,		{ITEM_IRON,			ITEM_ROCK,			ITEM_PLASTIC,	ITEM_SAND,	ITEM_CONCRETE} 	},
	{ E_WS_CONST_HILLTOP,			"Hilltop Farm",				51, 19626,	1059.6060, -345.4454, 73.9922,		{ITEM_COCAO,		ITEM_CARROT},													},
	{ E_WS_CONST_BIOENGI, 			"Bio Engineering",			51, 1241,	1351.4584, 348.6518, 20.4107,		{ITEM_ACETONE,		ITEM_ETHANOL}													},
	{ E_WS_CONST_WSTONE_FARM,		"Whetstone Farm",			51, 19626,	-1448.0990, -1522.8875, 101.7578, 	{ITEM_CORN,			ITEM_WHEAT,			ITEM_POTATO,	ITEM_CARROT}				},
	{ E_WS_CONST_LEAFY,				"Leafy Strings",			51, 1271,	-1095.7229, -1627.3754, 76.3672,	{ITEM_STRING,		ITEM_SILK},														},
	{ E_WS_CONST_PANOP,				"The Panopticon",			51, 19793,	-546.1591, -192.9910, 78.4063,		{ITEM_SAPLING,		ITEM_LOG,			ITEM_PAPER}									},
	{ E_WS_CONST_GP_OIL,			"Green Palms Oil",			51, 1650,	262.5852, 1459.9071, 10.5859,		{ITEM_GAS,			ITEM_MOTOR_OIL},												},
	{ E_WS_CONST_PLAINE,			"Plaine Food Co.",			51,	2803,	967.1489, 2159.9172, 10.8203,		{ITEM_MEAT,			ITEM_PORK,			ITEM_CHICKEN,	ITEM_TURKEY}				}
};

Trucker_LoadEntities_Wholesaler() {

	new text_long [ 512 ] ;

	for(new w, j = sizeof ( Wholesalers ); w < j; w++) {	

		format(text_long, sizeof(text_long), "[%d] [%s]\n{DEDEDE}Available Commands: /crate [pickup/putdown]\n\n[Offers the following]:\n%s", w, Wholesalers[w][E_WHOLESALERS_DESC], Wholesaler_GetItems(w, .formatted=true));	
		CreateDynamicMapIcon(Wholesalers[w][E_WHOLESALERS_POS_X], Wholesalers[w][E_WHOLESALERS_POS_Y], Wholesalers[w][E_WHOLESALERS_POS_Z], Wholesalers[w][E_WHOLESALERS_ICON], 0);
	   	CreateDynamicPickup(Wholesalers[w][E_WHOLESALERS_MODEL], 1, Wholesalers[w][E_WHOLESALERS_POS_X], Wholesalers[w][E_WHOLESALERS_POS_Y], Wholesalers[w][E_WHOLESALERS_POS_Z]);
	   	CreateDynamic3DTextLabel(text_long, 0xDE921FFF, Wholesalers[w][E_WHOLESALERS_POS_X], Wholesalers[w][E_WHOLESALERS_POS_Y], Wholesalers[w][E_WHOLESALERS_POS_Z], 10.0);
	}
}

Wholesaler_GetClosestPoint(playerid) {

	for(new w, j = sizeof ( Wholesalers ); w < j; w++) {	


		if ( IsPlayerInRangeOfPoint(playerid, 3.5, Wholesalers[w][E_WHOLESALERS_POS_X], Wholesalers[w][E_WHOLESALERS_POS_Y], Wholesalers[w][E_WHOLESALERS_POS_Z] ) ) {

			return w ;
		}

		else continue ;
	}

	return -1 ;
}

Wholesaler_GetItems(index, formatted=false) {
	new string[512], item_index, item_name [ 64 ] ;

	for(new i = 0; i < 5; i++) {

		if(Wholesalers[index][E_WHOLESALERS_INVENTORY][i] > 0) {

			item_index = Wholesalers[index][E_WHOLESALERS_INVENTORY][i] ;

			TruckerItem_GetName ( item_index, item_name, sizeof ( item_name ) ) ;
			
			if ( formatted ) {
				format(item_name, sizeof(item_name), "{97D270}%s{DEDEDE} [$%s]\n", item_name, IntegerWithDelimiter ( TruckerItem_GetPrice(item_index) ));
			}

			else format(item_name, sizeof(item_name), "[%s: $%s]", item_name, IntegerWithDelimiter ( TruckerItem_GetPrice(item_index) ));

			strcat(string, item_name);
			item_name[0] = EOS; // Clearing after storing so we don't overlap the old data.
		}
	}
    return string;
}

GetGoodsFromWholesaler(id)
{
	new string[128], part[16], bool:do_no_harm = false;
	for(new p = 0; p < 5; p++)
	{
		if(Wholesalers[id][E_WHOLESALERS_INVENTORY][p] > 0)
		{
			format(part, sizeof(part), "%s, ", TruckerItem[Wholesalers[id][E_WHOLESALERS_INVENTORY][p]][E_WHOLESALER_ITEM_NAME]);
			strcat(string, part);
			if(p == 4)
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


CMD:gotowholesaler(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new index, string [ 128 ];

	if ( sscanf ( params, "i", index ) ) {

		return SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", "/gotowholesaler [index]" ) ;
	}


	if ( index < 0 || index >= sizeof ( Wholesalers ) ) {

		format ( string, sizeof ( string ), "Index can't be less than 0 or more than %d.", sizeof ( Wholesalers ) - 1 ) ;
		return SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", string ) ;
	}

	format ( string, sizeof ( string ), "You've teleported to \"%s\". It sells the following items:", Wholesalers [ index ] [ E_WHOLESALERS_DESC ] ) ;
	SendServerMessage(playerid, COLOR_JOB, "Trucker", "DEDEDE", string ) ;

	SendClientMessage ( playerid, 0xDEDEDEFF, Wholesaler_GetItems(index, .formatted=false) ) ;

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, Wholesalers[index][E_WHOLESALERS_POS_X], Wholesalers[index][E_WHOLESALERS_POS_Y], Wholesalers[index][E_WHOLESALERS_POS_Z]);

	return true ;
}


IsWholesalerAcceptingGood(wholesalerid, goodid)
{
	new bool:response = false;
	for(new inv = 0; inv < 5; inv++)
	{
		if(Wholesalers[wholesalerid][E_WHOLESALERS_INVENTORY][inv] == goodid)
		{
			response = true;
			break;
		}
	}
	return response;
}


GetNearestWholesalerID(playerid)
{
	new ID = -1;
	for(new w = 0; w < sizeof(Wholesalers); w++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, Wholesalers[w][E_WHOLESALERS_POS_X], Wholesalers[w][E_WHOLESALERS_POS_Y], Wholesalers[w][E_WHOLESALERS_POS_Z]))
		{
			ID = w;
			break;
		}
	}
	return ID;
}