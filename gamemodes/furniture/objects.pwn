Furni_ListCategory(playerid) {

	inline Furni_Dialog_ShowCategory(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( response ) {

			Furni_ListSubCategories(playerid, inputtext);
		}
	}

	new szFstring[1024];

	for ( new i, j = sizeof ( furniture_inventory ); i < j ; i ++ ) {

		if( strfind( szFstring, furniture_inventory[ i ][ f_inven_category ], true ) != -1 ) {
			continue;
		}

		format( szFstring, sizeof( szFstring ), "%s%s\n", szFstring, furniture_inventory[ i ][ f_inven_category ] );
	}

	Dialog_ShowCallback ( playerid, using inline Furni_Dialog_ShowCategory, DIALOG_STYLE_LIST, "Categories", szFstring, "Continue", "Close" );

	return true ;
}

Furni_ListSubCategories(playerid, const category[]) {

	inline Furni_Dialog_ShowSubCat(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) Furni_ListCategory(playerid) ;
		else if ( response ) Furni_ObjectPerCategory(playerid, category, inputtext);
	}

	new szFstring[1024];

	for ( new i, j = sizeof ( furniture_inventory ); i < j ; i ++ ) {
		if( !strcmp( furniture_inventory[ i ][ f_inven_category ], category ) ) {

			if( strfind( szFstring, furniture_inventory[ i ][ f_inven_sub_category ], true ) != -1 ) {
				continue;
			}
			
			format( szFstring, sizeof( szFstring ), "%s%s\n", szFstring, furniture_inventory[ i ][ f_inven_sub_category ] );
		}
	}

	Dialog_ShowCallback ( playerid, using inline Furni_Dialog_ShowSubCat, DIALOG_STYLE_LIST, "Sub-categories", szFstring, "Continue", "Back" );
}

Furni_ObjectPerCategory(playerid, const cat[], const sub_cat[]) {

	#pragma unused cat
	ModelBrowser_ClearData(playerid);

	for ( new i, j = sizeof ( furniture_inventory ); i < j ; i ++ ) {
		if( !strcmp( furniture_inventory[ i ][ f_inven_sub_category ], sub_cat ) ) { 

			ModelBrowser_AddData(playerid, furniture_inventory[ i ][ f_inven_model ], furniture_inventory[ i ][ f_inven_name ] ) ;
		}
	}

	ModelBrowser_SetupTiles(playerid, sub_cat, "furni_list");

	return true ;
}

mBrowser:furni_list(playerid, response, row, model, name[]) {

	if ( ! response ) {

		return true ;
	}

	else if ( response ) {


		new string [ 1024 ], index = Furniture_FetchArrayID(model, name) ;

		//format ( string, sizeof ( string ), "FurniList: Selected row %d, having model %d and name %s. [FETCHED %d/%s]",
			//row, model, name, index, furniture_inventory[ index ][ f_inven_name ]
		//) ;

		//SendClientMessage(playerid, -1, string);

		inline Furni_Confirmation(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
		    #pragma unused pidx, dialogidx, listitemx, inputtextx

			if ( responsex ) {

				if ( GetPlayerCash ( playerid ) < furniture_inventory[ index ][ f_inven_price ] ) {
					
					Furni_ListCategory(playerid) ;

					return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", sprintf("You don't have enough money for this item! You need at least $%s.", 
						IntegerWithDelimiter(furniture_inventory[ index ][ f_inven_price ] )
					) );
				}


				SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", sprintf("You've bought the \"%s\" for $%s.", 
					furniture_inventory[ index ][ f_inven_name ], IntegerWithDelimiter(furniture_inventory[ index ][ f_inven_price ] )
				) );
				
				
				if (Furniture_CreateObject(playerid, model))
				{
					TakePlayerCash(playerid, furniture_inventory[ index ][ f_inven_price ]);
				}
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

			furniture_inventory[ index ][ f_inven_name ], IntegerWithDelimiter(furniture_inventory[ index ][ f_inven_price ])) ;


		Dialog_ShowCallback ( playerid, using inline Furni_Confirmation, DIALOG_STYLE_MSGBOX, "Furniture Confirmation", string, "Buy", "Close" );
	}


	return true ;
}

Furniture_FetchArrayID(model, const name[]) {

	for ( new i, j = sizeof ( furniture_inventory ); i < j ; i ++ ) {

		if ( ! strcmp(name, furniture_inventory[ i ][ f_inven_name ], true )) {

			if ( furniture_inventory[ i ][ f_inven_model] == model ) {

				return i ;
			}

			else continue ;
		}
		
		else continue ;
	}

	return -1 ;
}


/*

			new index = found [ listitem ] ;

			if ( index == -1 ) {
				return SendClientMessage ( playerid, -1, "Invalid item found." ) ;
			}

			//format( szFstring, sizeof( szFstring ),"Category: {FFFF00}%s{FFFFFF}\nSub-Category: {FFFF00}%s{FFFFFF}\nItem: {FFFF00}%s{FFFFFF}\nPrice: {33AA33}${FFFF00}%s",
			//	 furniture_inventory[ index ][ f_inven_name ]
			//);

			format( szFstring, sizeof( szFstring ), "Category: %s", furniture_inventory[ index ][ f_inven_category ] ) ;
			SendClientMessage(playerid, -1, szFstring);
			format( szFstring, sizeof( szFstring ), "Sub-Category: %s",  furniture_inventory[ index ][ f_inven_sub_category ] ) ;
			SendClientMessage(playerid, -1, szFstring);

			format( szFstring, sizeof( szFstring ), "Item: %s", furniture_inventory[ index ][ f_inven_name ] ) ;
			SendClientMessage(playerid, -1, szFstring);
*/
