enum E_PNS_DATA {

	Float: E_PNS_POS_X,
	Float: E_PNS_POS_Y,
	Float: E_PNS_POS_Z
} ;

new E_PNS_LOCATIONS [ ] [ E_PNS_DATA ] = {

	{ 1296.8934, -1865.5447, 13.5972 }, // Pershing Square PNS
	{ 207.11590, -1446.4102, 13.1596 }, // Rodeo PNS
	{ 1833.8820, -1398.2865, 13.4297 },  // Glen Park PNS
	{ 2334.9880, -1991.6436, 13.5587 }  // Willowfield PNS
}, E_PNS_CP [ sizeof ( E_PNS_LOCATIONS ) ] ;


#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {

	for ( new i, j =sizeof ( E_PNS_LOCATIONS ); i < j ; i ++ ) {

		E_PNS_CP [ i ] = CreateDynamicCP(E_PNS_LOCATIONS [ i ] [ E_PNS_POS_X ], E_PNS_LOCATIONS [ i ] [ E_PNS_POS_Y ], E_PNS_LOCATIONS [ i ] [ E_PNS_POS_Z ], 5.0, -1, -1, -1, 10.0 );
		CreateDynamicMapIcon(E_PNS_LOCATIONS [ i ] [ E_PNS_POS_X ], E_PNS_LOCATIONS [ i ] [ E_PNS_POS_Y ], E_PNS_LOCATIONS [ i ] [ E_PNS_POS_Z ], 63, -1);
	}

	foreach(new playerid: Player) {

		TogglePlayerControllable(playerid, true);
	}

	printf("[+] %i Pay'n'Spray locations loaded.", sizeof ( E_PNS_LOCATIONS ));

	return true ;
}

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP:checkpointid) {

	for ( new i, j =sizeof ( E_PNS_LOCATIONS ); i < j ; i ++ ) {

		if ( checkpointid == E_PNS_CP [ i ] ) {

			if ( ! IsPlayerInAnyVehicle(playerid)) {

				GameTextForPlayer(playerid, "~n~~n~~n~~w~You must be in a vehicle to use this service, dummy!", 2000, 4);
				return true ;
			}

			if ( IsPlayerInAnyVehicle(playerid)) {

				if ( GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) {
					PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] = true ;
					TogglePlayerControllable(playerid, false);
					ShowMenuForPlayer(pns_menu, playerid);
				}
			}

			return true ;
		}

		else continue ;
	}

	return 1;
}

hook OnPlayerLeaveDynamicCP(playerid, STREAMER_TAG_CP:checkpointid) {
	
	for ( new i, j =sizeof ( E_PNS_LOCATIONS ); i < j ; i ++ ) {

		if ( checkpointid == E_PNS_CP [ i ] ) {

			PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] = false ;
			TogglePlayerControllable(playerid, true);
			HideMenuForPlayer(pns_menu, playerid);
		}
	}
	return 1;
}

IsPlayerNearPayNSpray(playerid) {

	for(new i = sizeof(E_PNS_LOCATIONS) - 1; i != -1; --i) {
        if(IsPlayerInRangeOfPoint(playerid, 15.0, E_PNS_LOCATIONS [ i ] [ E_PNS_POS_X ], E_PNS_LOCATIONS [ i ] [ E_PNS_POS_Y ], E_PNS_LOCATIONS [ i ] [ E_PNS_POS_Z ])) {

			return true;
		}
	}

	return false ;
}
