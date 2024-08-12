CMD:buytoys(playerid, params[]) {

	new idx = AttachPoint_GetNearestEntity(playerid) ;

	if ( idx == INVALID_ATTACH_POINT_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near an attach or buytoys point." ) ;
	}

	if (AttachPoint [ idx ] [ E_ATTACH_POINT_TYPE ] == 13 && !IsPlayerInMedicFaction(playerid))
	{
		// horrible hardcoded fix to stop people buying lsfd toys since their attach point isnt behind a door
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You don't have access to this armory." ) ;
	}

	ModelBrowser_ClearData(playerid);


	new title [ 64 ] ;

	switch ( AttachPoint [ idx ] [ E_ATTACH_POINT_TYPE ] ) {

		case 0: { // "Clothing Store: Facewear (SA-MP)" ) ;

			format ( title, sizeof ( title ), "Facewear (SA-MP)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Face_SAMP ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_Face_SAMP [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_Face_SAMP [ i ] [ E_ATTACH_NAME ] ) ;
			}

		}
		
		case 1: { // "Clothing Store: Facewear (SOLS)" ) ;
			format ( title, sizeof ( title ), "Facewear (SOLS)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Face_SOLS ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_Face_SOLS [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_Face_SOLS [ i ] [ E_ATTACH_NAME ] ) ;
			}
		}
		
		case 2: { // "Clothing Store: Headwear (SA-MP)" ) ;

			format ( title, sizeof ( title ), "Headwear (SA-MP)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Head_SAMP ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_Head_SAMP [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_Head_SAMP [ i ] [ E_ATTACH_NAME ] ) ;
			}		
		}
		
		case 3: { // "Clothing Store: Headwear (SOLS)" ) ;
			format ( title, sizeof ( title ), "Headwear (SOLS)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Head_SOLS ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_Head_SOLS [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_Head_SOLS [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}
		
		case 4: { // "Clothing Store: Neckwear (SOLS)" ) ;

			format ( title, sizeof ( title ), "Neckwear (SOLS)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Neck_SOLS ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_Neck_SOLS [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_Neck_SOLS [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}
		
		case 5: { // "Clothing Store: Miscalleneous" ) ;

			format ( title, sizeof ( title ), "Miscalleneous" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_MISC_SAMP ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_MISC_SAMP [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_MISC_SAMP [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}
		
		case 6: { // "Clothing Store: LSPD Restricted" ) ;

			format ( title, sizeof ( title ), "LS-PD Restricted" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_LSPD ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_LSPD [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_LSPD [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}

		case 7:{  // "Jewelry Store: Chains" ) ;
			format ( title, sizeof ( title ), "Chains" ) ;

			for ( new i, j = sizeof ( AttachStore_Jewelry_Chains ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Jewelry_Chains [ i ] [ E_ATTACH_MODEL ], AttachStore_Jewelry_Chains [ i ] [ E_ATTACH_NAME ] ) ;
			}			
		}
		case 8: { // "Jewelry Store: Watches" ) ;
			format ( title, sizeof ( title ), "Watches" ) ;

			for ( new i, j = sizeof ( AttachStore_Jewelry_Watches ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Jewelry_Watches [ i ] [ E_ATTACH_MODEL ], AttachStore_Jewelry_Watches [ i ] [ E_ATTACH_NAME ] ) ;
			}			
		}
		case 9: { // "Jewelry Store: Rings" ) ;
			format ( title, sizeof ( title ), "Rings" ) ;
	
			for ( new i, j = sizeof ( AttachStore_Jewelry_Rings ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Jewelry_Rings [ i ] [ E_ATTACH_MODEL ], AttachStore_Jewelry_Rings [ i ] [ E_ATTACH_NAME ] ) ;
			}		
		}
		case 10: { //  "Jewelry Store: Miscalleneous" ) ;
			format ( title, sizeof ( title ), "Miscalleneous" ) ;
			
			for ( new i, j = sizeof ( AttachStore_Jewelry_Extra ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Jewelry_Extra [ i ] [ E_ATTACH_MODEL ], AttachStore_Jewelry_Extra [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}

		case 11: {	//  "Barbershop: Hairstyles" ) ;
			format ( title, sizeof ( title ), "Hairstyles" ) ;
			
			for ( new i, j = sizeof ( AttachStore_Barber ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Barber [ i ] [ E_ATTACH_MODEL ], AttachStore_Barber [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}

		case 12: { // "Clothing Store: NEWS Restricted" ) ;

			format ( title, sizeof ( title ), "NEWS Restricted" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_NEWS ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_NEWS [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_NEWS [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}

		case 13: { // "Clothing Store: LSFD Restricted" ) ;

			format ( title, sizeof ( title ), "LSFD Restricted" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_EMS ); i < j ; i ++ ) {

				ModelBrowser_AddData(playerid, AttachStore_Clothing_EMS [ i ] [ E_ATTACH_MODEL ], AttachStore_Clothing_EMS [ i ] [ E_ATTACH_NAME ] ) ;
			}	
		}
	}


	ModelBrowser_SetupTiles(playerid, title, "Menu_BuyToy");

	return true ;
}

mBrowser:Menu_BuyToy(playerid, response, row, model, name[]) {

	if ( response ) {

		new string [ 256 ] ;

		format ( string, sizeof ( string ), "BuyToy: Selected row %d, having model %d and name %s. Type: %d.",
			row, model, name, Attach_GetType(model)
		) ;

		SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string);

		new a_name[64], bone [ 64 ], type ;

		inline PlayerToyList_Use(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
			#pragma unused pidx, dialogidx, inputtextx
			if ( responsex ) {

				type = Attach_GetType(PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitemx ]);
				Attach_GetName(type, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitemx ], a_name, sizeof ( a_name ) ) ;

				format ( string, sizeof ( string ), "You will be replacing your \"%s\" in slot %d.", a_name, listitemx ) ;
				SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string);

				Attach_ShowBoneList ( playerid, model, listitemx, true ) ;
			}
		}

		format ( string, sizeof ( string ), "Slot \t Name \t Bone\n" ) ;

		for ( new i, j = MAX_PLAYER_ATTACHMENTS; i < j ; i ++ ) {

			type = Attach_GetType(PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ i ]);

			Attach_GetBoneName ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ i ], bone, sizeof ( bone ) ) ;
			Attach_GetName(type, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ i ], a_name, sizeof ( a_name ) ) ;
			
			format ( string, sizeof ( string ), "%s%d \t %s \t %s\n", string, i, a_name, bone ) ;

		}

		Dialog_ShowCallback ( playerid, using inline PlayerToyList_Use, DIALOG_STYLE_TABLIST_HEADERS, "Attachments: Owned", string, "Select", "Close" );

	}

	return true ;
}