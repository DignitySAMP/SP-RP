enum E_INTERIOR_DATA {

	E_PROP_INT_DESC [ 64 ],
	E_PROP_INT_INT,
	Float: E_PROP_INT_POS_X,
	Float: E_PROP_INT_POS_Y,
	Float: E_PROP_INT_POS_Z
}
new InteriorData [ ] [ E_INTERIOR_DATA ] = {
	{ "Los Santos", 0,  1763.67004, -1920.79480, 13.39839 },
	{ "Cj's house",  3,  2496.049804,-1695.238159,1014.742187  },
	{ "Og Loc's house",  3,  513.882507,-11.269994,1001.565307  },
	{ "Ryders house",  2,  2454.717041,-1700.871582,1013.515197  },
	{ "Sweet's house",  1,  2527.654052,-1679.388305,1015.498596  },
	{ "Denise room",  1,  244.411987,305.032989,999.148437  },
	{ "Michelle room",  4,  302.180999,300.722991,999.148437  },	
	{ "Large/2 story/3 bedrooms/clone of House 9", 3,	235.508994,	1189.169897,	1080.339966 },
	{ "Medium/1 story/1 bedroom", 2,	225.756989,	1240.000000,	1082.149902 },
	{ "Small/1 story/1 bedroom", 1,	223.043991,	1289.259888,	1082.199951 },
	{ "VERY Large/2 story/4 bedrooms", 7,	225.630997,	1022.479980,	1084.069946 },
	{ "Small/1 story/2 bedrooms", 15,	295.138977,	1474.469971	,1080.519897, },
	{ "Small/1 story/2 bedrooms", 15,	328.493988,	1480.589966,	1084.449951, },
	{ "Small/1 story/1 bedroom/NO BATHROOM!", 15,	385.803986,	1471.769897,	1080.209961 },
	{ "Hashbury House",	10,	2260.76,	-1210.45,	1049.02	 },
	{ "Red Bed Motel Room",	10,	2262.83,	-1137.71,	1050.63 },
	{ "Verdant Bluffs Safehouse",	8,	2365.42,	-1131.85,	1050.88 },
	{ "Golden Bed Motel Room",	9,	2251.85,	-1138.16,	1050.63 },
	{ "Woozies Apartment",	1,	-2158.72,	641.29,	1052.38 },
	{ "24/7 1",  17,  -25.884498,-185.868988,1003.546875  },
	{ "24/7 2",  10,  6.091179,-29.271898,1003.549438   },
	{ "24/7 3",  18,  -30.946699,-89.609596,1003.546875  },
	{ "24/7 4",  16,  -25.132598,-139.066986,1003.546875  },
	{ "24/7 5",  4,  -27.312299,-29.277599,1003.557250  },
	{ "24/7 6",  6,  -26.691598,-55.714897,1003.546875  },
	{ "Airport ticket desk",  14,  -1827.147338,7.207417,1061.143554  },
	{ "Airport baggage reclaim", 14,  -1861.936889,54.908092,1061.143554 },
	{ "Shamal",  1,  1.808619,32.384357,1199.593750   },
	{ "Andromada",  9,  315.745086,984.969299,1958.919067  },
	{ "Ammunation 1",  1,  286.148986,-40.644397,1001.515625  },
	{ "Ammunation 2",  4,  286.800994,-82.547599,1001.515625  },
	{ "Ammunation 3",  6,  296.919982,-108.071998,1001.515625  },
	{ "Ammunation 4",  7,  314.820983,-141.431991,999.601562  },
	{ "Ammunation 5",  6,  316.524993,-167.706985,999.593750  },
	{ "Ammunation booths",  7,  302.292877,-143.139099,1004.062500  },
	{ "Ammunation range",  7,  298.507934,-141.647048,1004.054748  },
	{ "Blastin fools hallway", 3,  1038.531372,0.111030,1001.284484 },
	{ "Budget inn motel room", 12,  444.646911,508.239044,1001.419494 },
	{ "Jefferson motel",  15,  2215.454833,-1147.475585,1025.796875  },
	{ "Off track betting shop", 3,  833.269775,10.588416,1004.179687 },
	{ "Sex shop",  3,  -103.559165,-24.225606,1000.718750  },
	{ "Meat factory",  1,  963.418762,2108.292480,1011.030273  },
	{ "Zero's RC shop",  6,  -2240.468505,137.060440,1035.414062  },
	{ "Dillimore gas station", 0,  663.836242,-575.605407,16.343263 },
	{ "Catigula's basement",  1,  2169.461181,1618.798339,999.976562  },
	{ "FDC Janitors room",  10,  1889.953369,1017.438293,31.882812  },
	{ "Woozie's office",  1,  -2159.122802,641.517517,1052.381713  },
	{ "Binco",  15,  207.737991,-109.019996,1005.132812  },
	{ "Didier sachs",  14,  204.332992,-166.694992,1000.523437  },
	{ "Prolaps",  3,  207.054992,-138.804992,1003.507812  },
	{ "Suburban",  1,  203.777999,-48.492397,1001.804687  },
	{ "Victim",  5,  226.293991,-7.431529,1002.210937  },
	{ "Zip",   18,  161.391006,-93.159156,1001.804687   },
	{ "Club",   17,  493.390991,-22.722799,1000.679687  },
	{ "Bar",   11,  501.980987,-69.150199,998.757812   },
	{ "Lil' probe inn",  18,  -227.027999,1401.229980,27.765625  },
	{ "Jay's diner",  4,  457.304748,-88.428497,999.554687  },
	{ "Gant bridge diner",  5,  454.973937,-110.104995,1000.077209  },
	{ "Secret valley diner",  6,  435.271331,-80.958938,999.554687  },
	{ "World of coq",  1,  452.489990,-18.179698,1001.132812  },
	{ "Welcome pump",  1,  681.557861,-455.680053,-25.609874  },
	{ "Burger shot",  10,  375.962463,-65.816848,1001.507812  },
	{ "Cluckin' bell",  9,  369.579528,-4.487294,1001.858886  },
	{ "Well stacked pizza",  5,  373.825653,-117.270904,1001.499511  },
	{ "Rusty browns donuts",  17,  381.169189,-188.803024,1000.632812  },
	{ "Katie room",  2,  271.884979,306.631988,999.148437  },
	{ "Helena room",  3,  291.282989,310.031982,999.148437  },
	{ "Barbara room",  5,  322.197998,302.497985,999.148437  },
	{ "Millie room",  6,  346.870025,309.259033,999.155700  },
	{ "Sherman dam",  17,  -959.564392,1848.576782,9.000000  },
	{ "Planning dept.",  3,  384.808624,173.804992,1008.382812  },
	{ "Area 51",  0,  223.431976,1872.400268,13.734375  },
	{ "LS gym",  5,  772.111999,-3.898649,1000.728820  },
	{ "SF gym",  6,  774.213989,-48.924297,1000.585937  },
	{ "LV gym",  7,  773.579956,-77.096694,1000.655029  },
	{ "Madd Doggs mansion",  5,  1267.663208,-781.323242,1091.906250  },
	{ "Crack factory",  2,  2543.462646,-1308.379882,1026.728393  },
	{ "Big spread ranch",  3,  1212.019897,-28.663099,1000.953125  },
	{ "Fanny batters",  6,  761.412963,1440.191650,1102.703125  },
	{ "Strip club",  2,  1204.809936,-11.586799,1000.921875  },
	{ "Strip club private room", 2,  1204.809936,13.897239,1000.921875  },
	{ "Unnamed brothel",  3,  942.171997,-16.542755,1000.929687  },
	{ "Tiger skin brothel",  3,  964.106994,-53.205497,1001.124572  },
	{ "Pleasure domes",  3,  -2640.762939,1406.682006,906.460937  },
	{ "Liberty city outside",  1,  -729.276000,503.086944,1371.971801  },
	{ "Liberty city inside",  1,  -794.806396,497.738037,1376.195312  },
	{ "Gang house",  5,  2350.339843,-1181.649902,1027.976562  },
	{ "Colonel Furhberger's",  8,  2807.619873,-1171.899902,1025.570312  },
	{ "Crack den",  5,  318.564971,1118.209960,1083.882812  },
	{ "Warehouse 1",  1,  1412.639892,-1.787510,1000.924377  },
	{ "Warehouse 2",  18,  1302.519897,-1.787510,1001.028259  },
	{ "Sweets garage",  0,  2522.000000,-1673.383911,14.866223  },
	{ "Lil' probe inn toilet", 18,  -221.059051,1408.984008,27.773437  },
	{ "Unused safe house",  12,  2324.419921,-1145.568359,1050.710083  },
	{ "RC Battlefield",  10,  -975.975708,1060.983032,1345.671875  },
	{ "Barber 1",  2,  411.625976,-21.433298,1001.804687  },
	{ "Barber 2",  3,  418.652984,-82.639793,1001.804687  },
	{ "Barber 3",  12,  412.021972,-52.649898,1001.898437  },
	{ "Tatoo parlour 1",  16,  -204.439987,-26.453998,1002.273437  },
	{ "Tatoo parlour 2",  17,  -204.439987,-8.469599,1002.273437  },
	{ "Tatoo parlour 3",  3,  -204.439987,-43.652496,1002.273437  },
	{ "LS police HQ",  6,  246.783996,63.900199,1003.640625  },
	{ "SF police HQ",  10,  246.375991,109.245994,1003.218750  },
	{ "LV police HQ",  3,  288.745971,169.350997,1007.171875  },
	{ "Car school",  3,  -2029.798339,-106.675910,1035.171875  },
	{ "8-Track",  7,  -1398.065307,-217.028900,1051.115844  },
	{ "Bloodbowl",  15,  -1398.103515,937.631164,1036.479125  },
	{ "Dirt track",  4,  -1444.645507,-664.526000,1053.572998  },
	{ "Kickstart",  14,  -1465.268676,1557.868286,1052.531250  },
	{ "Vice stadium",  1,  -1401.829956,107.051300,1032.273437  },
	{ "SF Garage",  0,  -1790.378295,1436.949829,7.187500  },
	{ "LS Garage",  0,  1643.839843,-1514.819580,13.566620  },
	{ "SF Bomb shop",  0,  -1685.636474,1035.476196,45.210937  },
	{ "Blueberry warehouse",  0,  76.632553,-301.156829,1.578125  },
	{ "LV Warehouse 1",  0,  1059.895996,2081.685791,10.820312  },
	{ "LV Warehouse 2 (hidden part)", 0,  1059.180175,2148.938720,10.820312  },
	{ "Catigula's hidden room", 1,  2131.507812,1600.818481,1008.359375  },
	{ "Bank",   0,  2315.952880,-1.618174,26.742187  },
	{ "Bank (behind desk)",  0,  2319.714843,-14.838361,26.749565  },
	{ "LS Atruim",  18,  1710.433715,-1669.379272,20.225049  },
	{ "Bike School",  3,  1494.325195,1304.942871,1093.289062 },
	{ "B Dup's house",  3,  1527.229980,-11.574499,1002.097106  },
	{ "B Dup's crack pad",  2,  1523.509887,-47.821197,1002.130981  }
} ;

Interior_ListNatives (playerid ) {


	if ( PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] <= 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] = 1 ;
	}


	// Pagination stuff
	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage ;
    new resultcount = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] ) - MAX_ITEMS_ON_PAGE ) ;

    strcat(string, "Interior ID\t Description\n");

    for ( new i = resultcount; i < sizeof (  InteriorData ); i ++ ) {

		resultcount ++ ;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] ) {

			format(string, sizeof(string), "%s%d \t %s\n", string, 
				i,
				InteriorData [ i ] [ E_PROP_INT_DESC ] ); 
        }

     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] ) {

            nextpage = true;
            break;
        }
	}

	new pages = floatround ( resultcount / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline interior_list_data(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

		if ( ! response ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] > 1 ) {

				PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] -- ;
				return Interior_ListNatives (playerid ) ;
			}
		}

		if ( response ) {

			if ( listitem >= MAX_ITEMS_ON_PAGE) {

				PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] ++ ;
				return Interior_ListNatives (playerid ) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {

				SetPlayerInterior(playerid, InteriorData [ selection ] [ E_PROP_INT_INT ] ) ;
				PauseAC(playerid, 3);
				SetPlayerPos(playerid, InteriorData [ selection ] [ E_PROP_INT_POS_X ], InteriorData [ selection ] [ E_PROP_INT_POS_Y ], InteriorData [ selection ] [ E_PROP_INT_POS_Z ] ) ;

				SendClientMessage(playerid, -1, sprintf("You've teleported to \"%s\".",
					InteriorData [ selection ] [ E_PROP_INT_DESC ] ) ) ;

 				return true ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ] > 1 ) {
		Dialog_ShowCallback ( playerid, using inline interior_list_data, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Property Interior List: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ], pages), string, "Select", "Previous" ) ;
	}

	else Dialog_ShowCallback ( playerid, using inline interior_list_data, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Property Interior List: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_INT_LIST_PAGE ], pages), string, "Select", "Back" ) ;

	return true ;
}