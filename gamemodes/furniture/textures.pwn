static TextureStr[2048];

Furniture_TextureMenu ( playerid, objectid, extra_id ) {

	new index = Furniture_FetchArrayFromExtra(extra_id, objectid);

	if ( index == INVALID_FURNI_SAVED_ID ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "Couldn't fetch linked object." ) ;
	}

	new texture_id ;

	new texture_name [ 128 ] ;
	TextureStr[0] = EOS;

	for ( new i, j = MAX_FURNI_TEXTURES; i < j ; i ++ ) {

		texture_id = Furniture [ index ] [ E_FURNI_TEXTURE_INDEX ] [ i ] ;
		Texture_FetchName(texture_id, texture_name ) ;

		if ( texture_id != -1 ) {

			format ( TextureStr, sizeof ( TextureStr ), "%s[slot %d]: Texture Name: (%d) %s\n", TextureStr, i, texture_id, texture_name ) ; 
		}

		else format ( TextureStr, sizeof ( TextureStr ), "%s[slot %d]: Texture Name: None\n", TextureStr, i ) ; 
	}

	inline Furni_TXD_Menu(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) {
			Furniture_ViewMenu(playerid, objectid, extra_id ) ;
		}

		if ( response ) {

			Texture_TextureSlotManage(playerid, listitem, objectid, extra_id ) ;
		}
	}

	Dialog_ShowCallback ( playerid, using inline Furni_TXD_Menu, DIALOG_STYLE_LIST, "Texture List", TextureStr, "Continue", "Back" );

	return true ;
}

Texture_ListCategory(playerid, slot, extra_id, object) {
	inline Texture_ShowCategory(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( response ) {

			Texture_ListTexturesPerCategory(playerid, inputtext, slot, extra_id, object);
		}
	}

	TextureStr[0] = EOS;

	for ( new i, j = sizeof ( material_information ); i < j ; i ++ ) {

		if( strfind( TextureStr, material_information[ i ][ mat_info_category ], true ) != -1 ) {
			continue;
		}

		format( TextureStr, sizeof( TextureStr ), "%s%s\n", TextureStr, material_information[ i ][ mat_info_category ] );
	}

	Dialog_ShowCallback ( playerid, using inline Texture_ShowCategory, DIALOG_STYLE_LIST, "Texture Categories", TextureStr, "Continue", "Close" );

	return true ;
}

Texture_ListTexturesPerCategory(playerid, const category[], slot, extra_id, objectid) {

	new index = Furniture_FetchArrayFromExtra(extra_id, objectid), furni_name[64];

	if ( index == INVALID_FURNI_SAVED_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "Couldn't fetch linked object." ) ;
	}

	new id = Furniture_FetchIDFromModel(Furniture [ index ] [ E_FURNI_MODEL ] ) ;

	if ( id == -1 ) {

		format ( furni_name, sizeof ( furni_name ), "Invalid" ) ;
	}

	else Furniture_FetchName(id, furni_name ) ;


	new texture_name[64], found[sizeof ( material_information )], count;

	inline Texture_ViewList(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext


		if ( ! response ) {
			Texture_ListCategory(playerid, slot, extra_id, objectid) ;
		}
		if ( response ) {

			new response_index = found [ listitem ] ;

			TextureStr [ 0 ] = EOS ;

			Texture_FetchName(response_index, texture_name);

			format ( TextureStr, sizeof ( TextureStr ), "Changed texture slot %d of your %s to texture ID %d (%s).",
				slot, furni_name, response_index, texture_name );

			SendServerMessage ( playerid, COLOR_FURNITURE, "Furniture", "DEDEDE", TextureStr);

			Furniture [ index ] [ E_FURNI_TEXTURE_INDEX ] [ slot ] = response_index ;

			SetDynamicObjectMaterial(Furniture [ index ] [ E_FURNI_OBJECTID ], slot, 
				material_information [ response_index ] [ mat_info_model_id ], 
				material_information [ response_index ] [ mat_info_txd_name ], 
				material_information [ response_index ] [ mat_info_txt_name ]
			);


			TextureStr [ 0 ] = EOS ;

			mysql_format(mysql, TextureStr, sizeof(TextureStr), "UPDATE furniture SET furniture_txd_%d = %d WHERE furniture_sqlid = %d", 
				slot, response_index, Furniture [ index ] [ E_FURNI_SQL_ID ]
			) ;

			mysql_tquery(mysql, TextureStr);

			Furniture_TextureMenu ( playerid, objectid, extra_id ) ;
		}
	}

	TextureStr[0] = EOS;

	for ( new i, j = sizeof ( material_information ); i < j ; i ++ ) {
		if( !strcmp( material_information[ i ][ mat_info_category ], category ) ) { 

			// material_information[ i ][ mat_info_name ] 
			format ( TextureStr, sizeof ( TextureStr ), "%s(%d) %s\n", TextureStr, i, material_information[ i ][ mat_info_name ]  ) ;
			found [ count ++ ] = i ;
		}
	}


	Dialog_ShowCallback ( playerid, using inline Texture_ViewList, DIALOG_STYLE_LIST, "Texture Categories", TextureStr, "Continue", "Back" );

	return true ;
}


Texture_TextureSlotManage(playerid, slot, objectid, extra_id ) {

	new index = Furniture_FetchArrayFromExtra(extra_id, objectid), furni_name[64], query [ 128 ];

	if ( index == INVALID_FURNI_SAVED_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "Couldn't fetch linked object." ) ;
	}

	new id = Furniture_FetchIDFromModel(Furniture [ index ] [ E_FURNI_MODEL ] ) ;

	if ( id == -1 ) {

		format ( furni_name, sizeof ( furni_name ), "Invalid" ) ;
	}

	else Furniture_FetchName(id, furni_name ) ;


	inline Furni_TXD_Manage(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( response ) {

			switch ( listitem ) {

				case 0: { // modify

					Texture_ListCategory(playerid, slot, extra_id, objectid) ;
				}

				case 1: { // remove

					new texture_name [ 64 ] ;
					Texture_FetchName(Furniture [ index ] [ E_FURNI_TEXTURE_INDEX ] [ slot ] ,texture_name ) ;


					format ( query, sizeof ( query ), "Removed texture (%s) from slot %d from your %s.",
						texture_name, slot, furni_name ) ;
					
					SendServerMessage ( playerid, COLOR_FURNITURE, "Furniture", "DEDEDE", query);

					Furniture [ index ] [ E_FURNI_TEXTURE_INDEX ] [ slot ] = -1 ;
					SavedFurni_ResetObjectTextures ( playerid, index ) ;

					query [ 0 ] = EOS ;

					mysql_format(mysql, query, sizeof(query), "UPDATE furniture SET furniture_txd_%d = -1 WHERE furniture_sqlid = %d",
						slot, Furniture [ index ] [ E_FURNI_SQL_ID ]
					);

					mysql_tquery(mysql, query);

					Furniture_TextureMenu ( playerid, objectid, extra_id );
				}
			}
		}
	}

	Dialog_ShowCallback ( playerid, using inline Furni_TXD_Manage, DIALOG_STYLE_LIST, "Texture Management", "Modify Texture\nRemove Texture", "Continue", "Close" );

	return true; 
}