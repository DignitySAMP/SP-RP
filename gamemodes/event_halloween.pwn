#if !defined COLOR_HALLOWEEN
	#define COLOR_HALLOWEEN 0xed6a1fFF
#endif

enum E_HALLOWEEN_DATA {

	Float: E_PUMPKIN_POS_X,
	Float: E_PUMPKIN_POS_Y,
	Float: E_PUMPKIN_POS_Z,

	Float: E_PUMPKIN_ROT_X,
	Float: E_PUMPKIN_ROT_Y,
	Float: E_PUMPKIN_ROT_Z
} ;

new HalloweenLocations [ ] [ E_HALLOWEEN_DATA ] = {
	{ 505.1957,			-1547.4327,		22.4561,		0.0000,		0.0000,		0.0000 } ,
	{ 710.3849,			-1358.1573,		26.7050,		0.0000,		0.0000,		0.0000 } ,
	{ 401.6630,			-1625.5214,		34.3324,		0.0000,		0.0000,		0.0000 } ,
	{ 2678.9836,		-1432.1848,		16.0624,		0.0000,		0.0000,		0.0000 } ,
	{ 286.1073,			-1604.7852,		18.0308,		0.0000,		0.0000,		-10.40 } ,
	{ 292.0138,			-1534.9822,		35.9145,		0.0000,		0.0000,		0.0000 } ,
	{ 2872.8029,		-2125.0893,		5.2508,			0.0000,		0.0000,		0.0000 } ,
	{ 2644.2094,		-2072.3874,		26.6257,		0.0000,		0.0000,		0.0000 } ,
	{ 212.6168,			-1495.6540,		24.0932,		0.0000,		0.0000,		-17.19 } ,
	{ 2499.8730,		-1896.3395,		25.3270,		0.0000,		0.0000,		0.0000 } ,
	{ 393.2691,			-1832.7767,		14.7531,		0.0000,		0.0000,		0.0000 } ,
	{ 2349.1748,		-1580.3209,		19.9720,		0.0000,		0.0000,		0.0000 } ,
	{ 2400.4851,		-1560.1466,		27.6568,		0.0000,		0.0000,		0.0000 } ,
	{ 603.2634,			-1766.3968,		19.3802,		0.0000,		0.0000,		0.0000 } ,
	{ 1020.5520,		-2186.0524,		39.2448,		0.0000,		0.0000,		0.0000 } ,
	{ 2254.5051,		-1121.0180,		48.4304,		0.0000,		0.0000,		0.0000 } ,
	{ 1117.7365,		-2036.9901,		78.5658,		0.0000,		0.0000,		0.0000 } ,
	{ 2071.1506,		-1000.2034,		58.5775,		0.0000,		0.0000,		0.0000 } ,
	{ 1786.9838,		-1307.4370,		13.3433,		0.0000,		0.0000,		0.0000 } ,
	{ 1964.3736,		-1527.5643,		22.0310,		0.0000,		0.0000,		0.0000 } ,
	{ 882.6267,			-1559.1271,		21.1435,		0.0000,		0.0000,		0.0000 } ,
	{ 1031.2055,		-1177.6469,		27.0617,		0.0000,		0.0000,		0.0000 } ,
	{ 1489.5352,		-1724.1240,		6.6705,			0.0000,		0.0000,		0.0000 } , // drug point
	{ 1688.5424,		-1969.4218,		8.5502,			0.0000,		0.0000,		0.0000 } ,
	{ 2369.0627,		-2542.0319,		3.3324,			0.0000,		0.0000,		0.0000 } ,
	{ 896.4527,			-1030.2158,		31.8946,		0.0000,		0.0000,		0.0000 } ,
	{ 1595.7640,		-2702.3542,		13.7665,		0.0000,		0.0000,		0.0000 } ,
	{ 1182.9072,		-2227.3745,		39.0032,		0.0000,		0.0000,		0.0000 } ,
	{ 1524.9580,		-1430.7979,		31.2471,		0.0000,		0.0000,		0.0000 } ,
	{ 1083.3010,		-2040.7502,		69.1943,		0.0000,		0.0000,		0.0000 } ,
	{ 1396.7742,		-1893.4616,		13.2190,		0.0000,		0.0000,		0.0000 } ,
	{ 1649.6065,		-1748.8780,		14.3352,		0.0000,		0.0000,		0.0000 } ,
	{ 1492.3951,		-1912.6635,		22.0316,		0.0000,		0.0000,		0.0000 } ,
	{ 1393.1822,		-1577.8819,		14.8034,		0.0000,		0.0000,		0.0000 } ,
	{ 1412.7191,		-1455.2551,		20.1655,		0.0000,		0.0000,		0.0000 } ,
	{ 1515.5551,		-1463.1844,		9.5809,			0.0000,		0.0000,		0.0000 } ,
	{ 2034.6429,		-1359.7163,		24.6317,		0.0000,		0.0000,		0.0000 } ,
	{ 2158.7082,		-1872.5312,		13.2931,		0.0000,		0.0000,		0.0000 } ,
	{ 2153.2619,		-1831.4785,		15.9469,		0.0000,		0.0000,		0.0000 } ,
	{ 2118.4982,		-1499.7736,		10.3986,		0.0000,		0.0000,		0.0000 } ,
	{ 2256.0412,		-1620.4536,		15.4013,		0.0000,		0.0000,		0.0000 } ,
	{ 2743.0764,		-1906.0561,		13.2216,		0.0000,		0.0000,		0.0000 } ,
	{ 2186.2895,		-1021.4117,		74.6823,		0.0000,		0.0000,		0.0000 } ,
	{ 2770.3649,		-1388.7036,		26.7285,		0.0000,		0.0000,		0.0000 } ,
	{ 2654.2429,		-1311.4176,		62.7879,		0.0000,		0.0000,		0.0000 } ,
	{ 2256.6110,		-807.0301,		127.6043,		0.0000,		0.0000,		0.0000 } ,
	{ 1653.5332,		-878.3265,		55.3739,		0.0000,		0.0000,		0.0000 } ,
	{ 1577.3631,		-1420.8996,		23.4380,		0.0000,		0.0000,		0.0000 } ,
	{ 2050.1699,		-952.5391,		47.8931,		0.0000,		0.0000,		5.9999 } ,
	{ 2695.6025,		-1704.6785,		11.6742,		0.0000,		0.0000,		0.0000 } 
} ;

new PlayerPumpkinsFound [ MAX_PLAYERS ] [ sizeof ( HalloweenLocations ) ]  ;

IsPlayerNearPumpkin(playerid) {
	for ( new i, j = sizeof ( HalloweenLocations ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, 7.5, HalloweenLocations [ i ] [ E_PUMPKIN_POS_X ], HalloweenLocations [ i ] [ E_PUMPKIN_POS_Y ], HalloweenLocations [ i ] [ E_PUMPKIN_POS_Z ] ) ) {

			return true ;
		}
	}

	return false ;
}

GetNearestPumpkin(playerid) {
	for ( new i, j = sizeof ( HalloweenLocations ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, 7.5, HalloweenLocations [ i ] [ E_PUMPKIN_POS_X ], HalloweenLocations [ i ] [ E_PUMPKIN_POS_Y ], HalloweenLocations [ i ] [ E_PUMPKIN_POS_Z ] ) ) {

			return i ;
		}
	}

	return -1 ;
}

CMD:halloween(playerid, params[]) {

	if ( ! IsPlayerNearPumpkin(playerid) ) {

		return SendServerMessage(playerid, COLOR_HALLOWEEN, "Halloween", "DEDEDE", "You're not near an pumpkin." ) ;
	}

	new pumpkinid = GetNearestPumpkin(playerid) ;

	if ( Halloween_DoesPlayerHavePumpkin(playerid, pumpkinid) ) {

		return SendServerMessage(playerid, COLOR_HALLOWEEN, "Halloween", "DEDEDE", "You already found this pumpkin, dummy!" ) ;
	}
	new reward = 250 ;

	Halloween_StoreForPlayer(playerid, pumpkinid ) ;
	
	new string [ 64 ] ;

	format ( string, sizeof ( string ), "You've found pumpkin ID %d - you've been awarded $%s!", pumpkinid, IntegerWithDelimiter ( reward ));
	SendServerMessage(playerid, COLOR_HALLOWEEN, "Halloween", "DEDEDE", string ) ;

	GivePlayerCash(playerid, reward ) ;

	return true ;
}

Halloween_DoesPlayerHavePumpkin(playerid, pumpkinid) {
	new bool: found = false ;

	for ( new i, j = sizeof ( HalloweenLocations ); i < j ; i ++ ) {

		// Prevent duplicate entries in our database.
		if ( PlayerPumpkinsFound [ playerid ] [ i ] == pumpkinid ) {

			found = true ;
			break ;
		}

		else continue ;
	}

	return found ;
}

Halloween_LoadEntities() {

	new string [ 64 ] ;
	for ( new i, j = sizeof ( HalloweenLocations ); i < j ; i ++ ) {


		CreateDynamicObject(19320, HalloweenLocations [ i ] [ E_PUMPKIN_POS_X ], HalloweenLocations [ i ] [ E_PUMPKIN_POS_Y ], 
			HalloweenLocations [ i ] [ E_PUMPKIN_POS_Z ], HalloweenLocations [ i ] [ E_PUMPKIN_ROT_X ], HalloweenLocations [ i ] [ E_PUMPKIN_ROT_Y ], 
			HalloweenLocations [ i ] [ E_PUMPKIN_ROT_Z ], 0, 0, -1, 150.0, 150.0 
		);

		format ( string, sizeof ( string ), "[%d] Pumpkin\n{DEDEDE}Available commands: /halloween", i ) ;
		CreateDynamic3DTextLabel(string, COLOR_HALLOWEEN, HalloweenLocations [ i ] [ E_PUMPKIN_POS_X ], HalloweenLocations [ i ] [ E_PUMPKIN_POS_Y ], 
			HalloweenLocations [ i ] [ E_PUMPKIN_POS_Z ], 3.0,  INVALID_PLAYER_ID,  INVALID_VEHICLE_ID, false, 0, 0, -1 ) ;
	}
}

Halloween_StoreForPlayer(playerid, pumpkinid) {

	new query [ 384 ], index_found = -1 ;

	for ( new i, j = sizeof ( HalloweenLocations ); i < j ; i ++ ) {

		// Prevent duplicate entries in our database.
		if ( PlayerPumpkinsFound [ playerid ] [ i ] == pumpkinid ) {

			index_found = -1 ;
			break ;
		}

		// Found an empty ID, let's save it so we can store it
		if ( PlayerPumpkinsFound [ playerid ] [ i ] == -1 ) {

			index_found = i ;
			break ;
		}

		else continue ;
	}

	if ( index_found != -1 ) {

		PlayerPumpkinsFound [ playerid ] [ index_found ] = pumpkinid ;

		mysql_format(mysql, query, sizeof(query), "INSERT INTO event_halloween (account_id, pumpkin_id) VALUES (%d, %d)", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], pumpkinid ) ;
		mysql_tquery(mysql, query);
	}

	return true ;
}

Halloween_LoadPlayerEntities(playerid) {

	SendClientMessage(playerid, 0xDC6F22FF, "Happy Holidays!{FFFFFF} It's the annual {DC6F22}Halloween {222222}Holiday {666666}Event{FFFFFF}. Find pumpkins around the map for a reward.");

	for ( new i, j = sizeof ( HalloweenLocations ) ; i < j ; i ++ ) {
		PlayerPumpkinsFound [ playerid ] [ i ] = -1 ;
	}

	inline HalloweenPlayerData() {

		new rows, fields, count ;
		cache_get_data ( rows, fields, mysql ) ;

		if ( rows ) {

			for ( new i, j = rows ; i < j ; i ++ ) {

				PlayerPumpkinsFound [ playerid ] [ count ++ ] = cache_get_field_content_int ( i, "pumpkin_id", mysql ) ;
			}
		}
	}

	new query [ 256 ] ;
	mysql_format ( mysql, query, sizeof ( query ), "SELECT pumpkin_id FROM event_halloween WHERE account_id = '%d'", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
	MySQL_TQueryInline(mysql, using inline HalloweenPlayerData, query, "");

	return true ;
}