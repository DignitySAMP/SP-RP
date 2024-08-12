enum E_FURNI_INT_DATA {

	E_FURNI_INT_NAME [ 32 ],
	E_FURNI_INT_MODEL,
	E_FURNI_INT_PRICE,

	Float: E_FURNI_INT_POS_X,
	Float: E_FURNI_INT_POS_Y,
	Float: E_FURNI_INT_POS_Z,

	Float: E_FURNI_INT_ROT_X,
	Float: E_FURNI_INT_ROT_Y,
	Float: E_FURNI_INT_ROT_Z,

	Float: E_FURNI_INT_STREAM,

	Float: E_FURNI_INT_SPAWN_X,
	Float: E_FURNI_INT_SPAWN_Y,
	Float: E_FURNI_INT_SPAWN_Z,

} ;

new Furni_Int_Data [ ] [ E_FURNI_INT_DATA ] = {
	{ "Small Gang House", 		14755, 20000, 1524.5791, 1833.2634, 11.1146, 0.0000, 0.0000, 0.0000, 500.000, 1524.4226,	1841.3611,	10.8646 },  //shite
	{ "Small Gang House", 		14756, 20000, 1527.4769, 1786.6901, 11.8759, 0.0000, 0.0000, 0.0000, 500.000, 1527.3984,	1786.7694,	10.8760 },  //shitlobby
	{ "Medium Class", 			14748, 25000, 1528.7452, 1730.8735, 11.9947, 0.0000, 0.0000, 0.0000, 500.000, 1533.1925,	1729.2656,	10.9947 },  //sfhsm1
	{ "High Class", 			14750, 50000, 1527.8865, 1677.2276, 16.4783, 0.0000, 0.0000, 0.0000, 500.000, 1524.5710,	1668.7960,	10.9784 },  //sfhsm2
	{ "High Class",				14754, 50000, 1527.6467, 1607.5728, 13.8631, 0.0000, 0.0000, 0.0000, 500.000, 1524.8972,	1599.2794,	10.9246 },  //bigsanfranhoose
	{ "Mansion", 				14758, 75000, 1523.9210, 1531.2282, 11.7736, 0.0000, 0.0000, 0.0000, 500.000, 1524.7351,	1531.7849,	10.8986 },  //sfmansion1
	{ "Medium Class", 			14714, 30000, 1528.4666, 1478.0262, 11.8633, 0.0000, 0.0000, 0.0000, 500.000, 1528.4618,	1470.8018,	11.0586 },  //int2Hoose08
	{ "Gang House", 			14700, 20000, 1531.7141, 1416.2420, 11.5333, 0.0000, 0.0000, 0.0000, 500.000, 1531.6112,	1413.0697,	11.0333 },  //int2smSf01_int01
	{ "Gang House",				14710, 20000, 1532.1088, 1352.4091, 11.6967, 0.0000, 0.0000, 0.0000, 500.000, 1540.6665,	1349.1313,	11.1811 },  //int2vgshM3
	{ "Gang House",				14711, 15000, 1528.6457, 1294.2663, 11.7737, 0.0000, 0.0000, 0.0000, 500.000, 1536.8236,	1301.6982,	11.1797 },  //int2vgshM2
	{ "Mid-Class",				14701, 25000, 1478.0563, 1292.7031, 12.0346, 0.0000, 0.0000, 0.0000, 500.000, 1477.8120,	1283.3396,	10.9643 },  //int2Hoose2
	{ "Mid-Class",				14703, 30000, 1292.3673, 1613.0753, 23.2403, 0.0000, 0.0000, 0.0000, 500.000, 1294.9858,	1600.0999,	19.9435 },  //int2Hoose09
	{ "Mid-Class",				14713, 20000, 1321.9716, 1537.7598, 16.3832, 0.0000, 0.0000, 0.0000, 500.000, 1327.1268, 1535.8970, 15.0185 },  //int2Hoose16
	{ "Low-Class",				14718, 15000, 1273.6708, 1484.0253, 9.96640, 0.0000, 0.0000, 0.0000, 500.000, 1276.7336,	1480.1682,	10.9742 }, //int2lasmone04
	{ "Low-Class",				14717, 15000, 1344.8605, 1479.6268, 11.7077, 0.0000, 0.0000, 0.0000, 500.000, 1347.1544,	1473.7076,	10.9734 },  //int2lasmtwo02
	{ "Low-Class Gang Hideout",	14712, 15000, 1287.1535, 1393.0308, 11.4479, 0.0000, 0.0000, 0.0000, 500.000, 1290.1034,	1386.4287,	10.8776 },  //int2Hoose11
	{ "Mid-Class",				14702, 30000, 1354.7094, 1378.0447, 14.1962, 0.0000, 0.0000, 0.0000, 500.000, 1357.3925,	1365.7292,	10.8994 }, //int2lamid01
	{ "Empty Warehouse",		14795, 75000, 1428.8718, 1461.9045, 15.3178, 0.0000, 0.0000, 0.0000, 500.000, 1455.4773,	1486.7498,	11.0413 } //genint3_smashtv
} ;

Furniture_LoadBlankInteriors() {

	for ( new i, j = sizeof ( Furni_Int_Data ) ; i < j ; i ++ ) {

		CreateDynamicObject(
			Furni_Int_Data [ i ] [ E_FURNI_INT_MODEL ], 

			Furni_Int_Data [ i ] [ E_FURNI_INT_POS_X ],
			Furni_Int_Data [ i ] [ E_FURNI_INT_POS_Y ],
			Furni_Int_Data [ i ] [ E_FURNI_INT_POS_Z ],

			Furni_Int_Data [ i ] [ E_FURNI_INT_ROT_X ],
			Furni_Int_Data [ i ] [ E_FURNI_INT_ROT_Y ],
			Furni_Int_Data [ i ] [ E_FURNI_INT_ROT_Z ],

			-1, i + 1, -1, 
			Furni_Int_Data [ i ] [ E_FURNI_INT_STREAM ] 
		);

	}
}

CMD:intfurni(playerid) {

	new index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT) ;

	if ( index == INVALID_PROPERTY_ID ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You must be inside your property, near the door." );
		return true ;
	}
	
	if ( Property [ index ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "Only the property owner can do this." );
	}

	if ( Property [ index ] [ E_PROPERTY_FURNI_LIMIT ] ) {

		SendServerMessage ( playerid, COLOR_YELLOW, "Furniture", "DEDEDE", "You still have some furniture left! You can not transfer your interior when you have furniture spawned." );
		SendClientMessage(playerid, 0xDEDEDEFF, "Use /furniwipe to remove all of your furniture at once (it will get refunded).");

		return true ;
	}

	SendClientMessage(playerid, COLOR_YELLOW, "WARNING:{DEDEDE} If there are people left in your interior they will be STUCK!" ) ;
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: {DEDEDE}To view screenshots of the interiors in the menu, navigate to our forums via Server Insights > Interior Upgrade List.");

	if ( IsPlayerInRangeOfPoint ( playerid, 5.0, Property [ index ] [ E_PROPERTY_INT_X ], Property [ index ] [ E_PROPERTY_INT_Y ], Property [ index ] [ E_PROPERTY_INT_Z ] )) {

		new string [ 1024 ] ;
		inline ViewBlankInteriors(pid, dialogid, response, listitem, string:inputtext[]) {
		    #pragma unused pid, response, dialogid, listitem, inputtext

			if ( response ) {


				inline Interior_ReplConfirm(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
				    #pragma unused pidx, dialogidx, listitemx, inputtextx

					if ( responsex ) {

						if ( GetPlayerCash ( playerid ) < Furni_Int_Data [ listitem ] [ E_FURNI_INT_PRICE ] ) {
							
							return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", sprintf("You don't have enough money for this interior! You need at least $%s.", 
								IntegerWithDelimiter(Furni_Int_Data [ listitem ] [ E_FURNI_INT_PRICE ] )
							) );
						}


						SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", sprintf("You've bought the \"%s\" for $%s. Your property interior has been updated.", 
							Furni_Int_Data [ listitem ] [ E_FURNI_INT_NAME ], IntegerWithDelimiter(Furni_Int_Data [ listitem ] [ E_FURNI_INT_PRICE ] )
						) );
						
						TakePlayerCash ( playerid, Furni_Int_Data [ listitem ] [ E_FURNI_INT_PRICE ] ) ;

						Property [ index ] [ E_PROPERTY_INT_X ] = Furni_Int_Data [ listitem ] [ E_FURNI_INT_SPAWN_X ] ;
						Property [ index ] [ E_PROPERTY_INT_Y ] = Furni_Int_Data [ listitem ] [ E_FURNI_INT_SPAWN_Y ] ;
						Property [ index ] [ E_PROPERTY_INT_Z ] = Furni_Int_Data [ listitem ] [ E_FURNI_INT_SPAWN_Z ] ;
						Property [ index ] [ E_PROPERTY_INT_INT ] = listitem + 1 ;

						string [ 0 ] = EOS ;

						mysql_format(mysql, string, sizeof ( string ), "UPDATE properties SET property_int_x = %0.3f, property_int_y = %0.3f, property_int_z = %0.3f, property_int_int = %d WHERE property_id = %d",
							Property [ index ] [ E_PROPERTY_INT_X ],
							Property [ index ] [ E_PROPERTY_INT_Y ],
							Property [ index ] [ E_PROPERTY_INT_Z ],
							Property [ index ] [ E_PROPERTY_INT_INT ],
							Property [ index ] [ E_PROPERTY_ID ]
						);

						mysql_tquery(mysql, string);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid, Furni_Int_Data [ listitem ] [ E_FURNI_INT_SPAWN_X ], Furni_Int_Data [ listitem ] [ E_FURNI_INT_SPAWN_Y ], Furni_Int_Data [ listitem ] [ E_FURNI_INT_SPAWN_Z ] ) ;
						SetPlayerInterior(playerid, listitem + 1 ) ;

						SetPlayerVirtualWorld(playerid, Property [ index ] [ E_PROPERTY_ID] ) ;
					}
				}

				string [ 0 ] = EOS ;

				format ( string, sizeof ( string ), 
					"{AB78B1}Warning!{DEDEDE} Furniture costs money!\n\n\
					Are you sure you want to buy the following item:\n\n\
					\"{AB78B1}%s{DEDEDE}\"\n\n\
					for the price of ${AB78B1}%s{DEDEDE}? If you destroy it later\n\
					you will get a portion of your money back.\n\n\
					To proceed, click \"Buy\". To cancel click \"Close\".",

					Furni_Int_Data [ listitem ] [ E_FURNI_INT_NAME ], IntegerWithDelimiter(Furni_Int_Data [ listitem ] [ E_FURNI_INT_PRICE ])) ;


				Dialog_ShowCallback ( playerid, using inline Interior_ReplConfirm, DIALOG_STYLE_MSGBOX, "Furniture Confirmation", string, "Buy", "Close" );

			}
		}

		format(string, sizeof(string), "ID \t Name \t Price\n" );

		for ( new i, j = sizeof ( Furni_Int_Data ); i < j ; i ++ ) {

			format ( string, sizeof ( string ), "%s\t(%d)\t%s\t%s\n", string, i, Furni_Int_Data [ i ] [ E_FURNI_INT_NAME ], IntegerWithDelimiter(Furni_Int_Data [ i ] [ E_FURNI_INT_PRICE ]) ) ;
		}

		Dialog_ShowCallback ( playerid, using inline ViewBlankInteriors, DIALOG_STYLE_TABLIST_HEADERS, "Blank Interiors", string, "Purchase", "Cancel");
	}

	return true ;
}