CMD:drugsupplies(playerid, params[]) {

	new weed_string [ 64 ], coke_string [ 64 ], crack_string [ 64 ], meth_string [ 64 ] ;
	new index, weed_count, coke_count, crack_count, meth_count ;

	SendClientMessage(playerid, COLOR_DRUGS, "List of owned drug supplies." ) ;

	for ( new i, j = 3 ; i < j ; i ++ ) {

		if ( Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ i ] ) {
			index = Character [ playerid ] [ E_CHARACTER_WEED_SUPPLIES ] [ i ] ;

			if ( weed_count ) {
				format(weed_string, sizeof ( weed_string ), "%s, (%d) %s", weed_string, i, Weed [ index ] [ E_WEED_NAME ] ) ;
			}
			else format(weed_string, sizeof ( weed_string ), "%s(%d) %s", weed_string, i, Weed [ index ] [ E_WEED_NAME ] ) ;

			weed_count ++ ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ i ] ) {
			index = Character [ playerid ] [ E_CHARACTER_COKE_SUPPLIES ] [ i ] ;

			if ( coke_count ) {
				format(coke_string, sizeof ( coke_string ), "%s, (%d) %s", coke_string, i, Cocaine [ index ] [ E_COKE_NAME ] ) ;
			}
			else format(coke_string, sizeof ( coke_string ), "%s(%d) %s", coke_string, i, Cocaine [ index ] [ E_COKE_NAME ] ) ;
			coke_count ++ ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ i ] ) {
			index = Character [ playerid ] [ E_CHARACTER_CRACK_SUPPLIES ] [ i ] ;

			if ( crack_count ) {
				format(crack_string, sizeof ( crack_string ), "%s, (%d) %s", crack_string, i, Crack [ index ] [ E_CRACK_NAME ] ) ;
			}
			else format(crack_string, sizeof ( crack_string ), "%s(%d) %s", crack_string, i, Crack [ index ] [ E_CRACK_NAME ] ) ;
			crack_count ++ ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ i ] ) {
			index = Character [ playerid ] [ E_CHARACTER_METH_SUPPLIES ] [ i ] ;

			if ( meth_count ) {
				format(meth_string, sizeof ( meth_string ), "%s, (%d) %s", i, meth_string ) ;
			}
			else format(meth_string, sizeof ( meth_string ), "%s(%d) %s", i, meth_string ) ;
			meth_count ++ ;
		}
	}

	if ( ! weed_count ) {
		format ( weed_string, sizeof ( weed_string ), "None" ) ;
	}
	if ( ! coke_count ) {
		format ( coke_string, sizeof ( coke_string ), "None" ) ;
	}
	if ( ! crack_count ) {
		format ( crack_string, sizeof ( crack_string ), "None" ) ;
	}
	if ( ! meth_count ) {
		format ( meth_string, sizeof ( meth_string ), "None" ) ;
	}

	new string [ 512 ] ;

	format ( string, sizeof ( string ), "[WEED SUPPLIES]:{A3A3A3} %s", weed_string ) ;
	SendClientMessage(playerid, 0x539849FF, string ) ;


	format ( string, sizeof ( string ), "[COKE SUPPLIES]:{A3A3A3} %s", coke_string ) ;
	SendClientMessage(playerid, 0xC8D8E3FF, string ) ;

	format ( string, sizeof ( string ), "[CRACK SUPPLIES]:{A3A3A3} %s", crack_string ) ;
	SendClientMessage(playerid, 0xAF7C5BFF, string ) ;

	format ( string, sizeof ( string ), "[METH SUPPLIES]:{A3A3A3} %s", meth_string ) ;
	SendClientMessage(playerid, 0x4198C0FF, string ) ;

	return true ;
}
