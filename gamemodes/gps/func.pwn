CMD:gps(playerid, params[]) {

	PropertyGPS_ShowList(playerid) ;

	return true ;
}

PropertyGPS_ShowSelected(playerid, index, constant, bool:options=false)
{
	if (!options)
	{
		DisablePlayerCheckpoint(playerid);
		GPS_MarkLocation(playerid, "~r~Property~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_DEFAULT,  Property [ index ] [ E_PROPERTY_EXT_X ], Property [ index ] [ E_PROPERTY_EXT_Y ], Property [ index ] [ E_PROPERTY_EXT_Z ] ) ;
		PlayerPlaySound ( playerid, 1085, 0.0, 0.0, 0.0 ) ;
		return true;
	}
	
	inline GPS_ShowProperty(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, dialogid, inputtext

		if (!response)
		{
			return PropertyGPS_AllocateProperty(playerid, constant);
		}

		if (listitem == 0)
		{
			// Just do normal gps route
			return PropertyGPS_ShowSelected(playerid, index, constant, false);
		}
		else if (listitem == 1)
		{
			// Admin teleport
			return cmd_propertygoto(playerid, sprintf("%d", index));
		}
	}

	Dialog_ShowCallback(playerid, using inline GPS_ShowProperty, DIALOG_STYLE_LIST, "Property GPS Options", "Mark on minimap\nTeleport to (Admin)", "Select", "Back" );
	return true;
}

PropertyGPS_ShowEnex(playerid, index, constant, bool:options=false)
{
	if (!options)
	{
		DisablePlayerCheckpoint(playerid);
		GPS_MarkLocation(playerid, "~r~EnEx Property~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_DEFAULT,  BuyPoint [ index ] [ E_BUY_POS_X ], BuyPoint [ index ] [ E_BUY_POS_Y ], BuyPoint [ index ] [ E_BUY_POS_Z ] ) ;
		PlayerPlaySound ( playerid, 1085, 0.0, 0.0, 0.0 ) ;
		return true;
	}
	
	inline GPS_ShowEnex(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, dialogid, inputtext

		if (!response)
		{
			return PropertyGPS_AllocateEnex(playerid, constant);
		}

		if (listitem == 0)
		{
			// Just do normal gps route
			return PropertyGPS_ShowEnex(playerid, index, constant, false);
		}
		else if (listitem == 1)
		{
			// Admin teleport
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SOLS_SetPosWithFade(playerid, BuyPoint [ index ] [ E_BUY_POS_X ], BuyPoint [ index ] [ E_BUY_POS_Y ], BuyPoint [ index ] [ E_BUY_POS_Z ]);
			AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("teleported to EnEx Property at %.02f, %.02f, %.02f", index, BuyPoint [ index ] [ E_BUY_POS_X ], BuyPoint [ index ] [ E_BUY_POS_Y ], BuyPoint [ index ] [ E_BUY_POS_Z ]));
			return true;
		}
	}

	Dialog_ShowCallback(playerid, using inline GPS_ShowEnex, DIALOG_STYLE_LIST, "EnEx Property GPS Options", "Mark on minimap\nTeleport to (Admin)", "Select", "Back" );
	return true;
}

PropertyGPS_ShowList(playerid) {
	new string [ 512 ], constant ;

	inline GPS_PropertyType(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
		#pragma unused pidx, dialogidx, inputtextx
 

		if ( responsex ) {

			if ( listitemx == 0 ) {

				return GPS_ShowServerHotspots(playerid) ;
			}

			else {

				inline GPS_Property(pid, dialogid, response, listitem, string:inputtext[]) {
					#pragma unused pid, dialogid, inputtext

					if ( ! response ) {

						return PropertyGPS_ShowList(playerid)  ;
					}

					else if ( response ) {

						switch ( listitemx) {
							case 1: {
								constant = PropertyTypeData [ listitem ] [ E_PROPERTY_TYPE_CONST ] ;
								PropertyGPS_AllocateProperty(playerid, constant);
							}

							case 2: {
								constant = PropertyTypeData [ listitem ] [ E_PROPERTY_TYPE_CONST ] ;
								PropertyGPS_AllocateEnex(playerid, constant);
							}
						}
					}
				}

				for ( new i, j = sizeof ( PropertyTypeData ); i < j ; i ++ ) {

					strcat(string, sprintf("%s\n", PropertyTypeData [ i ] [ E_PROPERTY_TYPE_NAME ] ) ) ;
				}

				Dialog_ShowCallback ( playerid, using inline GPS_Property, DIALOG_STYLE_LIST, "Property Types", string, "Select", "Close" );
			}
		}
	}

	Dialog_ShowCallback ( playerid, using inline GPS_PropertyType, DIALOG_STYLE_LIST, "Property Types", "Points of Interest\nBrowse All Properties By Type\nBrowse All EnEx By Type", "Select", "Back" );

	return true ;
}

PropertyGPS_AllocateProperty (playerid, constant) {

	new string [ 512 ] ;

	format ( string, sizeof ( string ), "Address \t Type \t Distance\n" ) ;

    new address[ 64 ], type [ 64 ], Float: distance, index ;

    const store_array_propid = 0, store_array_float = 1 ;

    new Float: store_array [ 100 ] [ 2 ],  store_count = 0;

    for ( new i, j =sizeof ( store_array ) ; i < j ; i ++ ) {

    	store_array [ i ] [ store_array_propid ] = -1 ;
    }

    foreach(new i: Properties) {
    	if ( Property [ i ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID || Property [ i ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_HOUSE || Property [ i ] [ E_PROPERTY_BUY_TYPE ] == E_BUY_TYPE_NONE ) {

			continue ;
		} 

		if ( Property [ i ] [ E_PROPERTY_BUY_TYPE ] == constant ) {

			store_array [ store_count ] [ store_array_propid ] = i ;				
			store_array [ store_count ] [ store_array_float ] = GetPlayerDistanceFromPoint(playerid, Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], Property [ i ] [ E_PROPERTY_EXT_Z ] )  ;

			store_count ++ ; 
		}
    }

    if ( ! store_count ) {

    	SendClientMessage(playerid, -1, "There are no stores with this type!" ) ;
    	return PropertyGPS_ShowList(playerid) ;
    }

    quickSort(store_array, 0, store_count - 1 ) ;

    new count, max_stores = 10 ;

	for ( new i, j = sizeof ( store_array ); i < j; i ++ ) {

		if ( ++ count <= max_stores ) {

			// making sure our array is sufficient with data
	    	if ( store_array [ i ] [ store_array_propid ] != -1 ) {

				index = floatround(store_array [ i ]  [ store_array_propid ], floatround_ceil) ;

				GetPlayerAddress(Property [ index ] [ E_PROPERTY_EXT_X ], Property [ index ] [ E_PROPERTY_EXT_Y ], address) ;
				PropertyType_GetName ( constant, type, sizeof ( type ) ) ;

				distance = GetPlayerDistanceFromPoint(playerid, Property [ index ] [ E_PROPERTY_EXT_X ], Property [ index ] [ E_PROPERTY_EXT_Y ], Property [ index ] [ E_PROPERTY_EXT_Z ] ) ;

				format(string, sizeof(string), "%s%s \t %s \t %0.2f yds away\n", string, address, type, distance); 				
		    }
		}

		else break ;
	}

	inline PropertyGPS_Findings(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext


		if ( ! response ) {
    		return PropertyGPS_ShowList(playerid) ;
		}

		else if ( response ) {

			index = floatround(store_array [ listitem ] [ store_array_propid ], floatround_ceil)  ;

			PropertyGPS_ShowSelected(playerid, index, constant, GetPlayerAdminLevel(playerid) > 1);

			return true ;
		}
	}

	address[0]=EOS;
	PropertyType_GetName ( constant, type, sizeof ( type ) ) ;
	format ( address, sizeof ( address), "Property Finder: %d nearest %s Stores",max_stores, type ) ;

	Dialog_ShowCallback ( playerid, using inline PropertyGPS_Findings, DIALOG_STYLE_TABLIST_HEADERS, address, string, "Select", "Close" );
 

    return true ;
}


PropertyGPS_AllocateEnex (playerid, constant) {

	new string [ 1024 ] ;

	format ( string, sizeof ( string ), "Address \t Type \t Distance\n" ) ;

    new address[ 64 ], type [ 64 ], Float: distance ;

    const store_array_propid = 0 ;
    const store_array_float = 1 ;

    new Float: store_array [ sizeof ( BuyPoint ) ] [ 2 ],  store_count = 0;

    for ( new i, j =sizeof ( store_array ) ; i < j ; i ++ ) {

    	store_array [ i ] [ store_array_propid ] = -1 ;
    }

    for ( new i, j = sizeof ( BuyPoint ); i < j ; i ++ ) {

		if ( BuyPoint [ i ] [ E_BUY_TYPE ] == constant ) {

			store_array [ store_count ] [ store_array_propid ] = i ;				
			store_array [ store_count ] [ store_array_float ] = GetPlayerDistanceFromPoint(playerid, BuyPoint [ i ] [ E_BUY_POS_X ], BuyPoint [ i ] [ E_BUY_POS_Y ], BuyPoint [ i ] [ E_BUY_POS_Z ] )  ;

			store_count ++ ; 
		}
    }

    if ( ! store_count ) {

    	SendClientMessage(playerid, -1, "There are no stores with this type!" ) ;
    	return PropertyGPS_ShowList(playerid) ;
    }

    quickSort(store_array, 0, store_count - 1 ) ;

    new count ;

	for ( new i, j = sizeof ( store_array ), index; i < j; i ++ ) {

		if ( ++ count <= 10 ) {

			// making sure our array is sufficient with data
	    	if ( store_array [ i ] [ store_array_propid ] != -1 ) {

				index = floatround(store_array [ i ]  [ store_array_propid ], floatround_ceil) ;

				GetPlayerAddress(BuyPoint [ index ] [ E_BUY_POS_X ], BuyPoint [ index ] [ E_BUY_POS_Y ], address) ;
				PropertyType_GetName ( constant, type, sizeof ( type ) ) ;

				distance = GetPlayerDistanceFromPoint(playerid, BuyPoint [ index ] [ E_BUY_POS_X ], BuyPoint [ index ] [ E_BUY_POS_Y ], BuyPoint [ index ] [ E_BUY_POS_Z ] ) ;

				format(string, sizeof(string), "%s%s \t %s \t %0.2f yds away\n", string, address, type, distance); 
		    }
		}

		else break ;
	}

	inline PropertyGPS_Findings(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if ( ! response ) {
    		return PropertyGPS_ShowList(playerid) ;
		}

		else if ( response ) {

			new index = floatround(store_array [ listitem ] [ store_array_propid ], floatround_ceil)  ;
			PropertyGPS_ShowEnex(playerid, index, constant, GetPlayerAdminLevel(playerid) > 0);

			return true ;
		}
	}

	address[0]=EOS;

	PropertyType_GetName ( constant, type, sizeof ( type ) ) ;
	format ( address, sizeof ( address), "Property EnEx Finder: 10 nearest %s Stores", type ) ;

	Dialog_ShowCallback ( playerid, using inline PropertyGPS_Findings, DIALOG_STYLE_TABLIST_HEADERS, address, string, "Select", "Close" );
 
    return true ;
}
