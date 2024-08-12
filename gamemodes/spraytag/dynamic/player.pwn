enum E_DYNAMIC_SPRAY_TAG_DATA {


	E_DYN_ST_ID,
	E_DYN_ST_MODEL,
	E_DYN_ST_UNIX, // when to expire

	E_DYN_ST_TEXT[64],
	E_DYN_ST_COLOR,


	E_DYN_ST_OWNER_ID,
	E_DYN_ST_OWNER_CHAR[MAX_PLAYER_NAME],
	E_DYN_ST_OWNER_ACC[MAX_PLAYER_NAME],

	Float: E_DYN_ST_POS_X,
	Float: E_DYN_ST_POS_Y,
	Float: E_DYN_ST_POS_Z,

	Float: E_DYN_ST_ROT_X,
	Float: E_DYN_ST_ROT_Y,
	Float: E_DYN_ST_ROT_Z,

	E_DYN_ST_OBJECTID
} ;

#if !defined MAX_DYN_SPRAY_TAGS
	#define MAX_DYN_SPRAY_TAGS 75
#endif

#if !defined INVALID_DYN_ST_ID
#define INVALID_DYN_ST_ID -1
#endif

new SprayTag_Dynamic [ MAX_DYN_SPRAY_TAGS ] [ E_DYNAMIC_SPRAY_TAG_DATA ] ;

SprayTags_LoadDynamicEntities() {

	for ( new i, j = sizeof ( SprayTag_Dynamic ); i < j ;  i ++ ) {

		SprayTag_Dynamic [ i ] [ E_DYN_ST_ID ] = INVALID_DYN_ST_ID ;
		SprayTag_Dynamic [ i ] [ E_DYN_ST_UNIX ] = -1 ;
	}
}

SprayTag_GetDynamicIndex() {

	for ( new i, j = sizeof ( SprayTag_Dynamic ); i < j ;  i ++ ) {

		if ( SprayTag_Dynamic [ i ] [ E_DYN_ST_ID ] == INVALID_DYN_ST_ID ) {
			return i ;
		}

		else continue ;
	}

	return INVALID_DYN_ST_ID ;
}

SprayTag_IsPlayerNearDynamicTag( playerid ) {

	for ( new i, j = sizeof ( SprayTag_Dynamic ); i < j ; i ++ ) {

		if( Streamer_IsItemVisible( playerid, STREAMER_TYPE_OBJECT, SprayTag_Dynamic [ i ] [ E_DYN_ST_OBJECTID ] ) ) {

	    	if( IsPlayerInRangeOfPoint( playerid, 3.0, SprayTag_Dynamic [ i ] [ E_DYN_ST_POS_X ], SprayTag_Dynamic [ i ] [ E_DYN_ST_POS_Y ], SprayTag_Dynamic [ i ] [ E_DYN_ST_POS_Z ] ) ) {
	    		return i;
	    	}

	    	else continue ;
		}
		
	    else continue ;
	}

	return -1;
}

SprayTag_OnDynamicTagCreate(playerid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz) {
	new index = SprayTag_GetDynamicIndex () ;

	if ( index == INVALID_DYN_ST_ID ) {

		PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = false ;
		DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 0 ;

		return SendClientMessage(playerid, -1, "There was a problem generating a dynamic tag. All slots are used!" ) ;
	}


	Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_CD ] = gettime() + 300 ; // 5 min

	new string [ 128 ] ;
	mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_spraytag_dyn_cd = %d WHERE player_id=%d", 
			Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_CD ],  Character [ playerid ] [ E_CHARACTER_ID]
	);

	mysql_tquery(mysql, string);

	SprayTag_Dynamic [ index ] [ E_DYN_ST_ID ] = index ;

	SprayTag_Dynamic [ index ] [ E_DYN_ST_MODEL ] = Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ] ;
	SprayTag_Dynamic [ index ] [ E_DYN_ST_UNIX ] = gettime() + ( 120 * 60 ); // 120 minutes

	if ( SprayTag_Dynamic [ index ] [ E_DYN_ST_MODEL ] == 19482 ) {

		new font_color = PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ] ;

		if ( ! font_color ) {
			// chosen when spraying their text using [[COLOR_HERE]]! /stcolors show the syntax!

			font_color = 0xDEDEDEFF ;
		}

		font_color = RGBAtoARGB(font_color);

		format ( SprayTag_Dynamic [ index ] [ E_DYN_ST_TEXT ], 64, "%s", 	Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ] ) ;
		SprayTag_Dynamic [ index ] [ E_DYN_ST_COLOR ] = 					font_color ;
	}

	// Setting spraytag owner data.
	SprayTag_Dynamic [ index ] [ E_DYN_ST_OWNER_ID ] = Character [ playerid ] [ E_CHARACTER_ID ] ;
	format( SprayTag_Dynamic [ index ] [ E_DYN_ST_OWNER_ACC ], 24,"%s", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]);
	format( SprayTag_Dynamic [ index ] [ E_DYN_ST_OWNER_CHAR ], 24,"%s", Character [ playerid ] [ E_CHARACTER_NAME ] );

	SprayTag_Dynamic [ index ] [ E_DYN_ST_POS_X ] = x ;
	SprayTag_Dynamic [ index ] [ E_DYN_ST_POS_Y ] = y ;
	SprayTag_Dynamic [ index ] [ E_DYN_ST_POS_Z ] = z ;

	SprayTag_Dynamic [ index ] [ E_DYN_ST_ROT_X ] = rx ;
	SprayTag_Dynamic [ index ] [ E_DYN_ST_ROT_Y ] = ry ;
	SprayTag_Dynamic [ index ] [ E_DYN_ST_ROT_Z ] = rz ;

	SprayTag_Dynamic [ index ] [ E_DYN_ST_OBJECTID ]  = CreateDynamicObject(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ], 
		SprayTag_Dynamic [ index ] [ E_DYN_ST_POS_X ], SprayTag_Dynamic [ index ] [ E_DYN_ST_POS_Y ], SprayTag_Dynamic [ index ] [ E_DYN_ST_POS_Z ],
		SprayTag_Dynamic [ index ] [ E_DYN_ST_ROT_X ], SprayTag_Dynamic [ index ] [ E_DYN_ST_ROT_Y ], SprayTag_Dynamic [ index ] [ E_DYN_ST_ROT_Z ]
	);


	switch ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ] ) {

		case 19482: { // Customtext
			new font_color = PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ] ;

			if ( ! font_color ) {
				// chosen when spraying their text using [[COLOR_HERE]]! /stcolors show the syntax!

				font_color = 0xDEDEDEFF ;
			}

			font_color = RGBAtoARGB(font_color);
			
			SetDynamicObjectMaterialText( SprayTag_Dynamic [ index ] [ E_DYN_ST_OBJECTID ], 0, 
				st_FormatMessage(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ]), 
				OBJECT_MATERIAL_SIZE_512x256, 
				"Arial", .fontsize = 40, .bold = 1, 
				.fontcolor = font_color,
				.textalignment = OBJECT_MATERIAL_TEXT_ALIGN_CENTER 
			);

		}
	}

	// Clearing edit variables
	PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = false ;
	DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ;
	PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = -1 ;
	PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 0 ;

	return true ;
}


task SprayTag_ClearDynSprayTags[1000]() {

	new string [ 256 ] ;

	for ( new i, j = sizeof ( SprayTag_Dynamic ); i < j ; i ++ ) {

		if ( SprayTag_Dynamic [ i ] [ E_DYN_ST_ID ] == INVALID_DYN_ST_ID ) {

			continue ;
		}

		if ( IsValidDynamicObject( SprayTag_Dynamic [ i ] [ E_DYN_ST_OBJECTID ] ) ) {

			if ( SprayTag_Dynamic [ i ] [ E_DYN_ST_UNIX ] != -1 && gettime() > SprayTag_Dynamic [ i ] [ E_DYN_ST_UNIX ] ) {

				SprayTag_Dynamic [ i ] [ E_DYN_ST_ID ] = INVALID_DYN_ST_ID ;

				format ( string, sizeof ( string ), "* The custom spray tag with id %d has been dissipated.", i ) ;
				//ProxDetectorObject (SprayTag_Dynamic [  i ] [ E_DYN_ST_OBJECTID ], 15.0, COLOR_ACTION, string ) ;
				ProxDetectorXYZ( SprayTag_Dynamic [ i ] [ E_DYN_ST_POS_X ], SprayTag_Dynamic [ i ] [ E_DYN_ST_POS_Y ], SprayTag_Dynamic [ i ] [ E_DYN_ST_POS_Z ], 0, 0, 15.0, COLOR_ACTION, string ) ;

				DestroyDynamicObject(SprayTag_Dynamic [ i ] [ E_DYN_ST_OBJECTID ]);

				SprayTag_Dynamic [ i ] [ E_DYN_ST_UNIX ] = -1 ;
			}
		}

		else continue ;
	}
}
