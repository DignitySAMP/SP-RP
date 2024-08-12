enum E_RECOLOR_DATA {

	E_RESPRAY_DESC [ 64 ],
	Float: E_RESPRAY_POS_X,
	Float: E_RESPRAY_POS_Y,
	Float: E_RESPRAY_POS_Z
} ;

new Respray_Points [ ] [ E_RECOLOR_DATA ] = {


	{ "LSX Aviation", 	2121.9326,-2434.3867,13.5469 },
	{ "Shipyard",		733.1964,-1511.2540, 1.0089 },
	{ "LSX Helipad",  765.4569, -2289.7361, 26.7960}
};

Respray_LoadEntities() {

	for ( new i, j = sizeof ( Respray_Points ); i < j ; i ++ ) {

		CreateDynamic3DTextLabel(sprintf("[%s Respray]\n{DEDEDE}Available commands: /respray, /carcolorlist", Respray_Points [ i ] [ E_RESPRAY_DESC]), 
			COLOR_FACTION, Respray_Points [ i ] [ E_RESPRAY_POS_X ], Respray_Points [ i ] [ E_RESPRAY_POS_Y ], Respray_Points [ i ] [ E_RESPRAY_POS_Z ], 
			7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, .testlos = false 
		);


		CreateDynamicPickup(365, 1,  Respray_Points [ i ] [ E_RESPRAY_POS_X ], Respray_Points [ i ] [ E_RESPRAY_POS_Y ], Respray_Points [ i ] [ E_RESPRAY_POS_Z ]);
	}
}

CMD:respray(playerid, params[]) {
	new near_respray = -1 ;

	for ( new i, j = sizeof ( Respray_Points ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, 15.0, Respray_Points [ i ] [ E_RESPRAY_POS_X ], 
			Respray_Points [ i ] [ E_RESPRAY_POS_Y ], Respray_Points [ i ] [ E_RESPRAY_POS_Z ] ) ) {

			near_respray = i ;
		}

		else continue ;
	}

	if ( near_respray != -1) {

	    new vehicleid = GetPlayerVehicleID ( playerid );
	    new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	    if ( veh_enum_id == -1 ) {

	        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be in a valid vehicle in order to do this." ) ;
	        return true ;
	    }

	    if ( GetPlayerState ( playerid ) != PLAYER_STATE_DRIVER ) {

	        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be the driver of a vehicle in order to do this." ) ;
	        return true ;
	    }

	    new color_a, color_b ;

	    if ( sscanf ( params, "ii", color_a, color_b ) ) {
	        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "/respray [color-a] [color-b] (/carcolorlist)" ) ;
	        return true ;
	    }

	    if (color_a < 0 || color_a >= 256 || color_b < 0 || color_b >= 256)
	    {
	        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "/respray [color-a] [color-b] (/carcolorlist)" ) ;
	        return true;
	    }

	    if ( GetPlayerCash(playerid) < 100 ) {

	        GameTextForPlayer(playerid, "~n~~n~~n~~w~No more freebies!~n~You need at least $100!", 2000, 4);
	        return true ;
	    }
	    GameTextForPlayer(playerid, "~w~Resprayed Vehicle For $100!", 2000, 3);
	    TakePlayerCash ( playerid, 100 ) ;

	    Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ] = color_a ;
	    Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] = color_b ;

	    ChangeVehicleColorEx( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ,  Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] ) ;

	    PlayerPlaySound(playerid, 1134, 0, 0, 0);

	    new query [ 256 ] ;
	    mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_color_a = %d, vehicle_color_b = %d WHERE vehicle_sqlid = %d",
	        Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
	    );

	    mysql_tquery(mysql, query);
	}

	return true ;
}