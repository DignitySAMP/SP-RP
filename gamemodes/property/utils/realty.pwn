

#define COLOR_REALTY 0xE62A27FF
#define MAX_REALTY_PAGES 20

/*
	 no idea if this is retarded and there's a simpler way but basically 
	 store the first propertyid of every page so Realty_ShowAvailableProperties can
	 start from it when going back a page.
*/

// apreel fools 2022 

new RealtyPage[MAX_PLAYERS];
new PageFirstProperty[MAX_PLAYERS][MAX_REALTY_PAGES];

Realty_LoadEntities() {

	// realty point 1742.9880,-1456.2135,13.5225
	CreateDynamicMapIcon(1742.9880,-1456.2135,13.5225, 37, 0xFFFFFFFF);
	CreateDynamicPickup(1273, 1, 1742.9880,-1456.2135,13.5225);
	CreateDynamic3DTextLabel("[Raimi Realty]{DEDEDE}\nUse /listings to see properties for sale.", COLOR_REALTY, 1742.9880,-1456.2135,13.5225, 10.0 );

}


CMD:listings(playerid, params[]){

	ResetRealtyPageData(playerid);

	if ( !IsPlayerInRangeOfPoint(playerid, 5.0, 1742.9880,-1456.2135,13.5225 ) ) {
		return SendServerMessage ( playerid, COLOR_REALTY, "Raimi Realty", "A3A3A3", "You must be at the Raimi Realty HQ to use this command. You can find the address in /gps." ) ;
	}

	Realty_ShowAvailableProperties(playerid);
	return true;
}

Realty_ShowAvailableProperties (playerid, startproperty=0) {

	if ( ! RealtyPage [ playerid ] ) {
		RealtyPage [ playerid ] = 1;
	}

	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage, propdlmap[100], resultcount, propertycount = startproperty;

	for ( new idx = propertycount; idx < sizeof ( Property ); idx++ ){

		propertycount++;

		if ( resultcount <= MAX_ITEMS_ON_PAGE ) {

			if ( Property [ idx ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ){
				continue; 
			}

			if ( Property [ idx ] [ E_PROPERTY_OWNER ] != INVALID_PROPERTY_OWNER) {
				continue;
			}

			if ( Property [ idx ] [ E_PROPERTY_PRICE ] <= 0) {
				continue;
			} 

			if(Property[idx][E_PROPERTY_EXT_VW] != 0) {
				continue;
			}

			new Float: x = Property [ idx ] [ E_PROPERTY_EXT_X ], Float: y = Property [ idx ] [ E_PROPERTY_EXT_Y ];
			new address[64], zone[64];

			GetCoords2DZone(x, y, zone, sizeof ( zone ));
			GetPlayerAddress(x, y, address );

			if(!strcmp(address, "Unknown"))
				continue;

			switch(Property [ idx ] [ E_PROPERTY_TYPE ]) {
				case E_PROPERTY_TYPE_BIZ: {
					format(string, sizeof(string), "%s{A3A3A3}(Business) {DEDEDE}%s, %s \t{52B788}$%s\n", string, address, zone, IntegerWithDelimiter(Property [ idx ] [ E_PROPERTY_PRICE ]));
				}

				case E_PROPERTY_TYPE_HOUSE: {
					format(string, sizeof(string), "%s{A3A3A3}(House) {DEDEDE}%s, %s \t{52B788}$%s\n", string, address, zone, IntegerWithDelimiter(Property [ idx ] [ E_PROPERTY_PRICE ]));
				}
				default: {
					format(string, sizeof(string), "%s{A3A3A3}(Property) {DEDEDE}%s, %s \t{52B788}$%s\n", string, address, zone, IntegerWithDelimiter(Property [ idx ] [ E_PROPERTY_PRICE ]));
				}
			}

			propdlmap[resultcount] = idx;
			resultcount++;

			if(resultcount == 1) {
				PageFirstProperty [ playerid ] [ RealtyPage [ playerid ] ] = idx;
			}

		} else continue;

		if ( resultcount >= MAX_ITEMS_ON_PAGE ) {
			nextpage = true;
			break;
		} 

		else continue;
	}

	if(nextpage) {
		strcat(string, "{FFAD3F}Next Page >>" );
	}

	inline RealtyDlg(pid, dialogid, response, listitem, string:inputtext[]) {

		#pragma unused pid, dialogid, inputtext

		if (!response) {

			if(RealtyPage[playerid] > 1) {

				RealtyPage[playerid]-- ;
				return Realty_ShowAvailableProperties(playerid, PageFirstProperty[playerid][RealtyPage[playerid]]) ;

			}

		} 

		else if ( response ) {

			if ( listitem == MAX_ITEMS_ON_PAGE) {

				RealtyPage[playerid]++ ;
				return Realty_ShowAvailableProperties(playerid, propertycount) ;

			} else if (listitem < MAX_ITEMS_ON_PAGE) {

				new chosen = propdlmap[listitem];

				GPS_MarkLocation(playerid, "Your ~b~property~w~ has been marked on your ~b~minimap~w~.", E_GPS_COLOR_SCRIPT, Property[chosen][E_PROPERTY_EXT_X], Property[chosen][E_PROPERTY_EXT_Y], Property[chosen][E_PROPERTY_EXT_Z]) ;
				SendClientMessage(playerid, COLOR_HINT, "[TIP]: {DEDEDE}You can buy the property with /propertybuy.");
			}
		}
	}


	new title[32];
	format(title, sizeof(title), "Real Estate: Page %d", RealtyPage[playerid]);

	if ( RealtyPage [ playerid ] > 1 ) {
   		Dialog_ShowCallback ( playerid, using inline RealtyDlg, DIALOG_STYLE_TABLIST, title, string, "Choose", "Previous" );
   	}
   	else {
   		Dialog_ShowCallback ( playerid, using inline RealtyDlg, DIALOG_STYLE_TABLIST, title, string, "Choose", "Close" );
   	}

	return true;

}


ResetRealtyPageData(playerid) {

	for(new i; i < MAX_REALTY_PAGES; i++){
		PageFirstProperty[playerid][i] = 0;
	}

	RealtyPage[playerid] = 1;
}