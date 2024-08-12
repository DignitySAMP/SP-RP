enum E_TOLL_DATA {

	Float: E_TOLL_POS_X,
	Float: E_TOLL_POS_Y,
	Float: E_TOLL_POS_Z
} ;

new TollData [ ] [ E_TOLL_DATA ] = {
	{ 604.1678,   	353.1636,   	19.7341 } , // Fallow Bridge (Blueberry/Montgomery to Fort Carson)
	{ -195.8215,   	261.7918,   	12.9276 } , // Martin Bridge (Blueberry to Fort Carson)
	//{ -1535.7122,   -815.1722,   	54.5958 } , // SF Easter Tunnel
	//{ -2909.1362,   -1168.8420,   	14.9872 } , // Angel Pine > SF
	//{ -2909.1362,   -1168.8420,   	10.3860 } , // Angel Pine > SF
	{ 52.6619,   	-1531.6233,   	5.28110 } , // RS Haul
	//{ 1154.3796,   	-828.8936,   	51.1950 } , Dillimore 
	//{ 785.3428,   	-917.4847,   	42.7071 } , // Dillimore 
	//{ 644.3892,   	-910.5915,   	39.6607 } , // Dillimore #2
	//{ 609.9031,   	-1199.3093,   	19.0485 } , // Rodeo Tunnel
	//{ 255.7775,   	-1015.3522,   	56.1830 } , // Richman
	{ 1697.3503,   	436.2901,   	31.7619 } , // The Mako Span (LV Bridge)
	{ 1714.0200,   	424.6679,   	31.7622 } 	 // The Mako Span (LV Bridge)
	//{ 2871.8098,   	-573.1836,   	11.9483 } , // East Beach
	//{ 2891.8960,   	-569.3742,   	11.9096 } , // East Beach
	//{ 2801.8132,   	-524.9775,   	10.8203 } , // East Beach
	//{ 2793.8958,   	-526.5837,   	10.8237 }   // East Beach
} ;


CMD:policetolls(playerid, params[]) {

    if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new string [ 144 ] ;

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	if ( Server [ E_SERVER_TOLLS_LOCKED ] ) {	
		format ( string, sizeof ( string ), "{ [%s] (%d) %s has unlocked ALL tolls }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid ) ) ;
		Server [ E_SERVER_TOLLS_LOCKED ] = false ;
	}

	else if ( ! Server [ E_SERVER_TOLLS_LOCKED ] ) {
		format ( string, sizeof ( string ), "{ [%s] (%d) %s has closed ALL tolls - they will reopen in 15 minutes }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid ) ) ;

		Server [ E_SERVER_TOLLS_LOCKED ] = true ;
	}

	Faction_SendMessage(factionid, string, faction_enum_id, false ) ;

	defer UnlockTolls(factionid, faction_enum_id);

	return true ;
}

CMD:tolls(playerid, params[])
{
	return cmd_policetolls(playerid, params);
}

timer UnlockTolls[900000](factionid, faction_enum_id) {
	if ( Server [ E_SERVER_TOLLS_LOCKED ] ) {
		Server [ E_SERVER_TOLLS_LOCKED ] = false ;


		new string [ 256 ] ;

		format ( string, sizeof ( string ), "{ [%s] The tolls have been automatically UNLOCKED. }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ] ) ;

		Faction_SendMessage(factionid, string, faction_enum_id, false ) ;
	}

	return true ;
}

Toll_LoadEntities() {

	for ( new i, j = sizeof ( TollData ); i < j ; i ++ ) {

		CreateDynamic3DTextLabel("[Toll Booth]\n\n{DEDEDE}Gates shut automatically in 15 seconds.\nTransport tax may be charged.\n\nAvailable Commands: /toll", 
			0xFFC200FF, 
			TollData [ i ] [ E_TOLL_POS_X ], TollData [ i ] [ E_TOLL_POS_Y ], TollData [ i ] [ E_TOLL_POS_Z ],
			35.0,  INVALID_PLAYER_ID,  INVALID_VEHICLE_ID, false, 0, 0, -1) ; 

		CreateDynamicMapIcon(TollData [ i ] [ E_TOLL_POS_X ], TollData [ i ] [ E_TOLL_POS_Y ], TollData [ i ] [ E_TOLL_POS_Z ], 
			5, 0xFFFFFFFF, 0, 0, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL);
	}

	// Train Bridge to LV
	CreateDynamicObject(4519, 2766.85, 323.82, 9.16, 0.00, 0.00, 270.00, -1, -1, -1, 200.0, 200.0);
}
