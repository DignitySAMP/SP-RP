
new Float: garbageJobStartPosX[MAX_PLAYERS], Float: garbageJobStartPosY[MAX_PLAYERS], Float: garbageJobStartPosZ[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
	garbageJobStartPosX[playerid] = 0;
	garbageJobStartPosY[playerid] = 0;
	garbageJobStartPosZ[playerid] = 0;

	return 1;
}


enum E_GARBAGE_POINT_DATA {

	Float: E_GARBAGE_POS_X,
	Float: E_GARBAGE_POS_Y,
	Float: E_GARBAGE_POS_Z
} ;

new GarbagePoint [ ] [ E_GARBAGE_POINT_DATA ] = {
	{2499.1399, -1309.5740, 34.9449}, 
	{2504.9185, -1428.9695, 28.6606}, 
	{2558.8032, -1368.7695, 32.5821}, 
	{2763.5620, -1176.8756, 69.4887}, 
	{2535.6404, -942.6977, 83.5571}, 
	{1972.3395, -1739.5676, 13.5629}, 
	{1972.5923, -1629.7810, 13.5537}, 
	{1910.0345, -1873.0114, 13.6282}, 
	{1680.8942, -1848.7842, 13.6152}, 
	{1465.2118, -1845.3528, 13.6315}, 
	{1514.5980, -1847.5392, 13.6330}, 
	{1338.5458, -1768.1509, 13.6248}, 
	{1339.3312, -1840.9078, 13.6348}, 
	{856.8906, -1380.9453, 14.0349}, 
	{2183.6184, -1000.2727, 62.8892}, 
	{2183.5400, -1186.4955, 24.3442}, 
	{2183.4426, -1205.8922, 24.0503}, 
	{2183.5176, -1210.1987, 23.9809}, 
	{2180.0369, -1246.0662, 23.9817}, 
	{2186.5708, -1258.2778, 23.9504}, 
	{2137.2246, -1262.1564, 23.9922}, 
	{1908.4852, -1801.6218, 13.5784}, 
	{1988.5538, -1805.0980, 13.6316}, 
	{2041.4531, -1804.8492, 13.6342}, 
	{2162.9460, -1980.2291, 13.6386}, 
	{2325.4863, -1947.5992, 13.6665}, 
	{2381.6362, -1939.1394, 13.6288}, 
	{2444.6646, -1977.8380, 13.6331}, 
	{2679.2390, -1970.5261, 13.4420}, 
	{2700.3098, -1969.6613, 13.6381}, 
	{2653.1655, -2038.6115, 13.6385}, 
	{2789.1208, -1945.2130, 13.6311}, 
	{2233.5996, -1424.4718, 24.0032}, 
	{2245.1538, -1440.4283, 23.9796}, 
	{2088.7227, -1631.9696, 13.6279}, 
	{2213.0371, -1682.8466, 14.1158}, 
	{2356.6240, -1695.5206, 13.3556}, 
	{2376.9822, -1695.2659, 13.5133}, 
	{2481.7639, -1694.8453, 13.5181}, 
	{2484.7112, -1768.9296, 13.5469}, 
	{2295.3838, -1695.1926, 13.5405}, 
	{2296.3420, -1715.7462, 13.5545}, 
	{2298.1736, -1630.8212, 14.6735}, 
	{2234.8223, -1690.4279, 14.0247}, 
	{2109.4106, -1824.1066, 13.6422}, 
	{2130.9932, -1795.4005, 13.6378}, 
	{2040.8214, -1734.6567, 13.6318}, 
	{2040.1188, -1641.9617, 13.6316}, 
	{1867.4149, -1647.6122, 13.4468}, 
	{1910.0383, -1687.4792, 13.4476}
}, garbage_object [ sizeof ( GarbagePoint )] ;

GarbageJob_SetAttachment(playerid, modelid) {

	switch ( modelid ) {
		case -28100: SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_SYSTEM, modelid, E_ATTACH_BONE_HAND_L,0.272000,0.041000,0.000000,0.000000,-58.600017,0.000000,0.500000,0.500000,0.500000 ) ;
		case -28101: SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_SYSTEM, modelid, E_ATTACH_BONE_HAND_L,0.189999,0.011000,-0.081000,0.000000,-116.200057,0.000000,0.500000,0.500000,0.500000 ) ;
		case -28102: SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_SYSTEM, modelid, E_ATTACH_BONE_HAND_L,0.188000,-0.130999,-0.072000,96.700141,-59.399906,-165.800094,0.811000,0.696000,0.752999 ) ;
		case -28103: SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_SYSTEM, modelid, E_ATTACH_BONE_HAND_L,0.128999,-0.057000,0.024000,-8.000018,-103.500007,94.999992,0.677999,0.685999,0.805000 ) ;
	}

	return true ;
}

GarbageJob_LoadEntities() {

	new modelid, Float: fixed_z ;

	for ( new i, j =sizeof ( GarbagePoint ); i < j ; i ++ ) {


		switch ( random ( 4 ) ) {

			case 0: modelid = -28100 ;
			case 1: modelid = -28101 ;
			case 2: modelid = -28102 ;
			case 3: modelid = -28103 ;
		}

		//CA_FindZ_For2DCoord(GarbagePoint [ i ] [ E_GARBAGE_POS_X ], GarbagePoint [ i ] [ E_GARBAGE_POS_Y ], fixed_z );

		fixed_z = GarbagePoint [ i ] [ E_GARBAGE_POS_Z ] - 0.75;
		garbage_object [ i ] = CreateDynamicObject(modelid, GarbagePoint [ i ] [ E_GARBAGE_POS_X ], GarbagePoint [ i ] [ E_GARBAGE_POS_Y ], fixed_z, 0.0, 0.0, 0.0);
		CreateDynamic3DTextLabel("[Garbage Job]\n{DEDEDE}LALT to pick up", 0xDEDEDEFF, GarbagePoint [ i ] [ E_GARBAGE_POS_X ], GarbagePoint [ i ] [ E_GARBAGE_POS_Y ], fixed_z, 7.5, .testlos = false );
	}
}

GarbageJob_FetchNewPoint ( playerid ) {

	new point = random ( sizeof ( GarbagePoint ) ) ;

	new address[ 64 ],Float: x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;
	GetPlayerAddress(GarbagePoint [ point ] [ E_GARBAGE_POS_X ], GarbagePoint [ point ] [ E_GARBAGE_POS_Y ], address) ;

	// Store start point.
	garbageJobStartPosX[playerid] = x;
	garbageJobStartPosY[playerid] = y;
	garbageJobStartPosZ[playerid] = z;

	GPS_MarkLocation(playerid, sprintf("Collect the ~g~trash bags~w~ at %s.", address), E_GPS_COLOR_JOB,GarbagePoint [ point ] [ E_GARBAGE_POS_X ], GarbagePoint [ point ] [ E_GARBAGE_POS_Y ], GarbagePoint [ point ] [ E_GARBAGE_POS_Z ] ) ;

	ShowPlayerInfoMessage(playerid, "Drive to the ~g~checkpoint~w~ on your map and collect the trash bags.", .height=167.5, .width=180, .showtime=6000);


	if ( IsValidDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) ) {
		DestroyDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] = -1 ;
	}

	if ( point == PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_OLD_INDEX ] ) {

		if ( (point + 1) >= sizeof ( GarbagePoint ) ) {

			point -= 1 ;
		}

		else point += 1 ;
	}

	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] = CreateDynamicCircle(GarbagePoint [ point ] [ E_GARBAGE_POS_X ], GarbagePoint [ point ] [ E_GARBAGE_POS_Y ], 3.0, -1, -1, playerid ) ;
	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_INDEX ] = point ;

	return true ;
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid ) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB ] ) {
	
		if ( areaid == PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) {

			ShowPlayerInfoMessage(playerid, "Approach the ~g~garbage bag~w~ and press ~k~~SNEAK_ABOUT~ to pick it up.", .height=167.5, .width=180, .showtime=6000);

		}
	}

	#if defined garbage_OnPlayerEnterDynArea
		return garbage_OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid );
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif

#define OnPlayerEnterDynamicArea garbage_OnPlayerEnterDynArea
#if defined garbage_OnPlayerEnterDynArea
	forward garbage_OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid );
#endif

GarbageJob_CalculatePayout(playerid) {

	new payout = 75 ;
	new Float: distance = GetPlayerDistanceFromPoint(playerid, garbageJobStartPosX[playerid], garbageJobStartPosY[playerid], garbageJobStartPosZ[playerid]) ;

	if(distance > 100.0) {
		payout = 100;
		payout += random(75);

		if(distance >= 250.0 && distance < 800.0) {
			payout = 200;
			payout += random(100);
		}
		else if(distance >= 800.0) {
			payout = 200;
			payout += random(200);
		}
	}

	GameTextForPlayer(playerid, sprintf("~y~Job complete~n~~w~$%s~n~~w~Respect +", IntegerWithDelimiter(payout ), IntegerWithDelimiter ( payout )), 3500, 6);
	GivePlayerCash ( playerid, payout ) ;				


	AddLogEntry(playerid, LOG_TYPE_JOB, sprintf(" earned %i from garbagejob.", payout ));
	ShowPlayerInfoMessage(playerid, "To continue working, press ~k~~SNEAK_ABOUT~ ~y~inside your job car~w~. To stop, press ~k~~TOGGLE_SUBMISSIONS~.", .height=167.5, .width=180, .showtime=6000);

	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_OLD_INDEX ] = PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_INDEX ] ;

	PlayerVar[playerid][E_PLAYER_GARBAGEJOB_COUNT] = 0;
	PlayerVar[playerid][E_PLAYER_GARBAGEJOB_TIMEOUT] = 0;

	return true ;
}

GarbageJob_CancelData(playerid) {

	// Stopped doing job !
	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB ] = false ;

	if ( IsValidDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) ) {
		DestroyDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] = -1 ;
	}

	if ( IsValidVehicle( PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_VEHICLE ] )  ) {

		new veh_enum_id = Vehicle_GetEnumID(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_VEHICLE ]) ;
		SetEngineStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], false );
		SetDoorStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], false );
	}

	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_VEHICLE ] = INVALID_VEHICLE_ID ;
	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_INDEX ] = -1 ;
	PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_CARRYING ] = false ;
	RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);
	cmd_nocp(playerid);
}