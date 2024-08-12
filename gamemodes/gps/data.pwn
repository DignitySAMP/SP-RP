enum E_GPS_DATA {

	E_GPS_DESC [ 64 ],
	Float: E_GPS_POS_X,
	Float: E_GPS_POS_Y,
	Float: E_GPS_POS_Z,

	E_GPS_JURISDICTION
} ;

new GPS [ ] [ E_GPS_DATA ] = {
	{"Los Santos Police Department", 	1544.9873,-1675.1959,13.5595, true }, // this is the original pershing sq
	{"County General Hospital", 		2036.3203,-1403.9027,16.9238, true },
	{"Department of Motor Vehicles (DMV)", 	SERVER_DMV_X, SERVER_DMV_Y, SERVER_DMV_Z, true }, 
	{"Realty Listings", 				1742.9880, -1456.2135, 13.5225, true }, // for /listings
	{"Advert Agency", 			ADV_POS_X, ADV_POS_Y, ADV_POS_Z, true}, // /advert

	{"Car Scrapyard", 					2269.2249, -2126.1326, 13.2763, true },
	{"Boat Scrapyard", 					2532.5679, -2272.2878, -0.5721, true },
	{"Plane Scrapyard", 				2108.2424, -2437.9275, 13.2744, true },
	
	{"Idlewood Gas Station", 1939.0231, -1773.4575, 13.3828, true},

	{"Ocean Docks - Dockworker Job", 	2753.4329,-2453.7937,13.6432, true },
	{"Ocean Docks - Garbageman Job",	2247.1138,-2672.9709,13.5565, true },

	{"Chop Shop", 						CHOPSHOP_X, CHOPSHOP_Y, CHOPSHOP_Z, true},

	{"Aztecas Gun Dealer",1691.9714,-1972.4589,8.8253, true}, // ec_dealer
	{"Families Gun Dealer",2444.0278,-1965.5500,13.5469, true}, // emmet_families
	{"Vagos Gun Dealer",2611.7861,-1394.2970,34.9903, true}, // emmet_vagos
	{"Ballas Gun Dealer",2168.7156,-1507.5477,23.9246, true}, // ballas_emmet

	{"Budget Dealership", 				2131.9111,-1150.7538,23.6992, true },
	{"Muscle Dealership", 				2050.3438,-1901.6233,13.5469, true },
	{"Sports Dealership", 				1359.7362,-1854.9513,13.5642, true },
	{"Utility Dealership", 				2420.1533,-2089.4521,13.0789, true },
	{"Aircraft Dealership", 			1957.5844,-2183.7864,13.5469, true },
	{"Bike Dealership", 				2352.9255,-1485.1898,23.5759, true },
	{"Boat Dealership", 				2370.5146,-2527.9280,13.3321, true },

	{"Gym: East Los Santos", 			LS_GYM_EXT_X, LS_GYM_EXT_Y, LS_GYM_EXT_Z, true},
	{"Gym: South Los Santos", 			LV_GYM_EXT_X, LV_GYM_EXT_Y, LV_GYM_EXT_Z, true},
	{"Gym: West Los Santos", 			BEACH_GYM_EXT_X, BEACH_GYM_EXT_Y, BEACH_GYM_EXT_Z, true},
	{"Gym: Central Los Santos", 		GANTON_GYM_EXT_X, GANTON_GYM_EXT_Y, GANTON_GYM_EXT_Z, true},

	{"Pay 'N' Spray: Willowfield", 2334.9880, -1991.6436, 13.5587, true},
	{"Pay 'N' Spray: Pershing Square", 1296.8934, -1865.5447, 13.5972, true},
	{"Pay 'N' Spray: Rodeo", 207.11590, -1446.4102, 13.1596, true},
	{"Pay 'N' Spray: Glen Park", 1833.8820, -1398.2865, 13.4297, true}
} ;
 
GPS_ShowServerHotspots(playerid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] == 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] = 1 ;
	}

	// Pagination stuff
	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage ;
    new resultcount = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] ) - MAX_ITEMS_ON_PAGE ) ;


    strcat(string, "Description\tDistance\n");

    new Float: dist ;

    for ( new i = resultcount, j = sizeof ( GPS ); i < j; i ++ ) {

		resultcount ++ ;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] ) {
        	dist = GetPlayerDistanceFromPoint(playerid, GPS [ i ] [ E_GPS_POS_X ], GPS [ i ] [ E_GPS_POS_Y ], GPS [ i ] [ E_GPS_POS_Z ] ) ;

			format(string, sizeof(string), "%s%s\t%0.3f yds\n", string, GPS [ i ] [ E_GPS_DESC ], dist); 
        }

     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] ) {

            nextpage = true;
            break;
        }
	}

	new pages = floatround ( resultcount / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline gps_show_list(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

		if ( ! response ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] > 1 ) {

				PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] -- ;
				return GPS_ShowServerHotspots(playerid) ;
			}

			else return true ;
		}

		if ( response ) {

			if ( listitem >= MAX_ITEMS_ON_PAGE) {

				PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] ++ ;
				return GPS_ShowServerHotspots(playerid) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) 
			{

				/*
				DisablePlayerCheckpoint(playerid);

				GPS_MarkLocation ( playerid, "~r~Point of Interest~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_DEFAULT, GPS [ selection ] [ E_GPS_POS_X ], GPS [ selection ] [ E_GPS_POS_Y ], GPS [ selection ] [ E_GPS_POS_Z ] ) ;

				if ( ! GPS [ selection ] [ E_GPS_JURISDICTION ] ) {
					//InformPlayer ( playerid, E_PLAYER_INFORM_BOX, "The location you want to reach is outside of the city of Los Santos's control!", -1, 1083, 6000, "The LSPD has no power here and the area may be crime contested!" ) ;

					//ShowPlayerSubtitle(playerid, "The LSPD has no power here and the area may be crime contested!", .showtime=6000 ) ;
					ShowPlayerInfoMessage(playerid, "The location you want to reach is outside of government control.", .height=167.5, .width=180, .showtime=6000);

				}
				*/

				GPS_ShowHotspot(playerid, selection, GetPlayerAdminLevel(playerid) > 0);

 				return true ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ] > 1 ) {
		Dialog_ShowCallback ( playerid, using inline gps_show_list, DIALOG_STYLE_TABLIST_HEADERS, sprintf("GPS: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ], pages), string, "Select", "Previous" ) ;
	}

	else Dialog_ShowCallback ( playerid, using inline gps_show_list, DIALOG_STYLE_TABLIST_HEADERS, sprintf("GPS: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_GPSLIST_PAGE ], pages), string, "Select", "Back" ) ;

	//SendClientMessage(playerid, COLOR_YELLOW, "To disable your gps use /nocp." ) ;

	return true ;
}

GPS_ShowHotspot(playerid, selection, bool:options=false)
{
	if (!options)
	{
		DisablePlayerCheckpoint(playerid);
		GPS_MarkLocation(playerid, sprintf("~r~%s~w~ has been marked on your ~r~minimap~w~.", GPS[selection][E_GPS_DESC]), E_GPS_COLOR_DEFAULT, GPS [ selection ] [ E_GPS_POS_X ], GPS [ selection ] [ E_GPS_POS_Y ], GPS [ selection ] [ E_GPS_POS_Z ]);
		SendClientMessage(playerid, COLOR_YELLOW, "To disable your gps marker use /cleargps." );

		if ( ! GPS [ selection ] [ E_GPS_JURISDICTION ] ) 
		{
			ShowPlayerInfoMessage(playerid, "The location you want to reach is outside of government control.", .height=167.5, .width=180, .showtime=5000);
		}

		return true;
	}
	
	inline gps_showhotspot(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, dialogid, inputtext

		if (!response)
		{
			return GPS_ShowServerHotspots(playerid);
		}

		if (listitem == 0)
		{
			// Just do normal gps route
			return GPS_ShowHotspot(playerid, selection, false);
		}
		else
		{
			// Admin teleport
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SOLS_SetPosWithFade(playerid, GPS [ selection ] [ E_GPS_POS_X ], GPS [ selection ] [ E_GPS_POS_Y ], GPS [ selection ] [ E_GPS_POS_Z ]);
			AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("teleported to %s", GPS[selection][E_GPS_DESC]));
		}
	}

	Dialog_ShowCallback ( playerid, using inline gps_showhotspot, DIALOG_STYLE_LIST, sprintf("GPS: %s", GPS[selection][E_GPS_DESC]), "Mark on minimap\nTeleport to (Admin)", "Select", "Back" ) ;
	return true;
}