enum E_CHOP_SHOP_DATA {

	Float: E_DROP_OFF_POS_X,
	Float: E_DROP_OFF_POS_Y,
	Float: E_DROP_OFF_POS_Z,

} ;

new DropPoints [ ] [ E_CHOP_SHOP_DATA ] = {
	{ 2125.5151, -1342.3004, 23.6382 },
	{ 2224.5193, -1261.0825, 23.5625 },
	{ 2117.9177, -1058.4052, 25.3066 },
	{ 2024.4091, -1100.9421, 24.3148 },
	{ 1913.4475, -1089.0111, 24.0752 },
	{ 1817.4591, -1117.1014, 23.7299 },
	{ 1784.3959, -1222.4840, 16.5982 },
	{ 1523.3507, -1110.2698, 20.5069 },
	{ 1127.3885, -1005.5975, 29.5185 },
	{ 1048.3751, -992.5479, 38.8064 },
	{ 1048.7445, -923.3370, 42.3083 },
	{ 1064.2291, -890.6124, 42.8588 },
	{ 1099.2725, -867.2343, 42.8565 },
	{ 1028.8740, -891.6213, 41.7875 },
	{ 824.5438, -1004.3866, 27.4139 },
	{ 769.8140, -1092.0115, 23.7504 },
	{ 773.6771, -1122.8696, 23.4857 },
	{ 727.4802, -1158.2297, 16.2107 },
	{ 700.5797, -1198.9908, 14.9585 },
	{ 599.8978, -1349.4907, 13.6831 },
	{ 552.2455, -1359.8223, 14.9964 },
	{ 580.3975, -1441.1848, 14.0231 },
	{ 579.3777, -1478.3948, 14.5061 },
	{ 585.6060, -1532.7233, 14.9541 },
	{ 584.8351, -1570.7427, 15.7942 },
	{ 370.5854, -1883.6053, 1.9092 },
	{ 832.1981, -1854.9491, 8.0063 },
	{ 1087.9325, -1887.3430, 13.1937 },
	{ 1182.8812, -1887.1211, 13.3757 },
	{ 1247.8903, -1879.1766, 13.2005 },
	{ 1296.1804, -1869.0728, 13.2008 },
	{ 1338.9438, -1832.9458, 13.2178 },
	{ 1340.0282, -1775.7258, 13.1742 },
	{ 1358.4022, -1772.4020, 13.1326 },
	{ 1358.4766, -1820.2660, 13.2173 },
	{ 1475.3151, -1842.7295, 13.1979 },
	{ 1548.8678, -1839.0746, 13.2007 },
	{ 2171.2517, -1472.8416, 23.6389 },
	{ 2170.7375, -1419.4861, 23.6368 },
	{ 2334.9385, -1362.7030, 23.7155 },
	{ 2339.9441, -1322.8746, 23.8812 },
	{ 2385.6631, -1454.5032, 23.6582 },
	{ 2700.2698, -1394.0844, 33.8472 },
	{ 2682.7854, -1330.0415, 42.4895 },
	{ 2607.5974, -1351.0304, 34.8474 },
	{ 2601.8193, -1372.3186, 35.0144 },
	{ 2608.1477, -1393.2836, 34.5577 },
	{ 2593.4976, -1412.0411, 27.4238 },
	{ 2549.3740, -1368.8398, 31.2073 },
	{ 2539.5950, -1335.4408, 33.2851 },
	{ 2548.0903, -1302.7444, 39.1140 },
	{ 2536.3652, -1218.1644, 49.1217 },
	{ 2485.5552, -1218.1917, 33.3134 },
	{ 2409.3381, -1206.7102, 28.9584 },
	{ 2392.4868, -1213.9830, 26.6981 },
	{ 2410.6855, -1296.3254, 24.2113 },
	{ 2411.5205, -1341.8396, 24.3258 }
};


ChopShop_CalculateRandomPoint(playerid, vehicleid) {

	
	// Cooldown of 10 minutes
	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	new index = random ( sizeof ( DropPoints ) ) ;
	GPS_MarkLocation(playerid, "~g~Dropoff point~w~ has been marked on your ~g~minimap.", E_GPS_COLOR_JOB, DropPoints [ index ] [ E_DROP_OFF_POS_X ], DropPoints [ index ] [ E_DROP_OFF_POS_Y ] , DropPoints [ index ] [ E_DROP_OFF_POS_Z ] ) ;
	
	ShowPlayerInfoMessage(playerid, "Drive to the hide point and ditch the car! Your money will be waiting for you...", .height=167.5, .width=180, .showtime=6000);


	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ] = Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ;
	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_DROPPOINT ] = index ;

	new payout = GetVehicleModel(vehicleid) * 2 ;

	new Float: health ;
	GetVehicleHealth(vehicleid, health ) ;

	payout += floatround ( health );

	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_PAYOUT ] = payout ;

	// Fuck the car up
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	UpdateVehicleDamageStatus(vehicleid, 12345, 12345, 12345, 2);

	new Float: sync_health = health / 3 ;

	if ( sync_health <= 400.0 ) {

		sync_health = 400 ;
	}

	SOLS_SetVehicleHealth ( vehicleid, sync_health ) ;

	new chopshop_owner_cut = payout / 12 ;
	Server [ E_SERVER_CHOPSHOP_COLLECT ] += chopshop_owner_cut ; 

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE server SET server_chopshop_collect = %d", Server [ E_SERVER_CHOPSHOP_COLLECT ] ) ;
	mysql_tquery(mysql, query);

	return true ;
}

ChopShop_VerifyPointLocation(playerid, skip_range = false) {

	new vehicleid = GetPlayerVehicleID(playerid) ;
	new index = PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_DROPPOINT ] ;
	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	if ( veh_enum_id == -1 ) {

		return true ;
	}

	if ( index == -1 ) {

		return true ;
	}
	if ( ! IsPlayerInRangeOfPoint(playerid, 15.0, DropPoints [ index ] [ E_DROP_OFF_POS_X ], DropPoints [ index ] [ E_DROP_OFF_POS_Y ], DropPoints [ index ] [ E_DROP_OFF_POS_Z ] ) ) {
		if ( ! skip_range ) {
			return true ;
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ] == Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) {

		GivePlayerCash ( playerid, PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_PAYOUT ] ) ;

		ShowPlayerInfoMessage(playerid, "You've hidden the vehicle. You've lit it on fire to destroy evidence. Leave the area!", .height=167.5, .width=180, .showtime=6000);

		GameTextForPlayer(playerid, sprintf("~y~Job complete~n~~w~$%s~n~~w~Fear +", IntegerWithDelimiter( PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_PAYOUT ] )), 7500, 6);
		
		//GivePlayerFearAndRespect(playerid);
		//PlayerPlaySound(playerid, 183, 0, 0, 0);

 		PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_PAYOUT ] = 0 ;
	 	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ] = INVALID_VEHICLE_ID ;
		PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_DROPPOINT ] = -1 ;	
		cmd_nocp(playerid);

		defer Chopshop_ExplodeVehicle(vehicleid);
	}

	else {
		GameTextForPlayer(playerid, "~r~Mission Failed~n~~w~You brought the wrong car..", 5000, 6);

		ShowPlayerInfoMessage(playerid, "This isn't the right car! Are you trying to cheat the underworld? Get lost, fool!", .height=167.5, .width=180, .showtime=6000);

	 	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_PAYOUT ] = 0 ;
	 	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ] = INVALID_VEHICLE_ID ;
		PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_DROPPOINT ] = -1 ;	
		cmd_nocp(playerid);

	}
	
	return true ;
}

timer Chopshop_ExplodeVehicle[2500](vehicleid) {

	SOLS_SetVehicleCanExplode(vehicleid, true);
	SetVehicleHealth(vehicleid, 50 ) ;
}