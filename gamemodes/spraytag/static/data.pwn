enum tag_information_enum {
	tag_model_id,
	e_st_tag_name[32]
} ;

new tag_information[ ][ tag_information_enum ] = {
	{ 18659 , "Grove St 4 Life" },
	{ 18660 , "Seville B.L.V.D Families" },
	{ -29001 , "Temple Drive Families" },// -29001 in array
	{ 18662 , "Kilo Tray Ballas" },
	{ 18664 , "Temple Drive Ballas" },
	{ 18666 , "Front Yard Ballas" },
	{ 18667 , "Rollin Heights Ballas" }, 
	{ -29000 , "Varrio Los Aztecas" }, //-29000 in array
	{ 18665 , "Los Santos Vagos" },
	{ 18663 , "Los Santos Rifa" }
} ;

enum E_SPRAY_TAG_DATA {

	E_SPRAY_TAG_SQLID,
	E_SPRAY_TAG_TYPE,
	E_SPRAY_TAG_MODELID,

	Float: E_SPRAY_TAG_POS_X,
	Float: E_SPRAY_TAG_POS_Y,
	Float: E_SPRAY_TAG_POS_Z,

	Float: E_SPRAY_TAG_ROT_X,
	Float: E_SPRAY_TAG_ROT_Y,
	Float: E_SPRAY_TAG_ROT_Z,

	E_SPRAY_TAG_OWNER,
	E_SPRAY_TAG_OWNER_ACC [ MAX_PLAYER_NAME ],
	E_SPRAY_TAG_OWNER_CHAR [ MAX_PLAYER_NAME ],

	E_SPRAY_TAG_OBJECT
} ;

#if !defined MAX_SPRAY_TAGS
	#define MAX_SPRAY_TAGS	( 350 )
#endif

#if !defined INVALID_SPRAY_TAG 
	#define INVALID_SPRAY_TAG	-1
#endif

new SprayTag [ MAX_SPRAY_TAGS ] [ E_SPRAY_TAG_DATA ] ;


SprayTags_LoadStaticEntities() {

	for ( new i, j = sizeof ( SprayTag ); i < j ; i ++ ) {

		SprayTag [ i ] [ E_SPRAY_TAG_SQLID ] = INVALID_SPRAY_TAG ;
	}

	print(" * [SPRAYTAGS] Loading all spray tags...");

	inline SprayTag_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "spraytag_sqlid", SprayTag [ i ] [ E_SPRAY_TAG_SQLID ]);
			cache_get_value_name_int(i, "spraytag_type", SprayTag [ i ] [ E_SPRAY_TAG_TYPE ]);

			cache_get_value_name_int(i, "spraytag_modelid", SprayTag [ i ] [ E_SPRAY_TAG_MODELID ]);
			cache_get_value_name_int(i, "spraytag_owner", SprayTag [ i ] [ E_SPRAY_TAG_OWNER ]);

			cache_get_value_name_float(i, "spraytag_pos_x", SprayTag [ i ] [ E_SPRAY_TAG_POS_X ]);
			cache_get_value_name_float(i, "spraytag_pos_y", SprayTag [ i ] [ E_SPRAY_TAG_POS_Y ]);
			cache_get_value_name_float(i, "spraytag_pos_z", SprayTag [ i ] [ E_SPRAY_TAG_POS_Z ]);

			cache_get_value_name_float(i, "spraytag_rot_x", SprayTag [ i ] [ E_SPRAY_TAG_ROT_X ]);
			cache_get_value_name_float(i, "spraytag_rot_y", SprayTag [ i ] [ E_SPRAY_TAG_ROT_Y ]);
			cache_get_value_name_float(i, "spraytag_rot_z", SprayTag [ i ] [ E_SPRAY_TAG_ROT_Z ]);

			cache_get_value_name(i, "spraytag_owner_acc", 	SprayTag [ i ] [ E_SPRAY_TAG_OWNER_ACC ]);
			cache_get_value_name(i, "spraytag_owner_char", SprayTag [ i ] [ E_SPRAY_TAG_OWNER_CHAR ]);

			SprayTag [ i ] [ E_SPRAY_TAG_OBJECT ] = CreateDynamicObject(SprayTag [ i ] [ E_SPRAY_TAG_MODELID ], 

				SprayTag [ i ] [ E_SPRAY_TAG_POS_X ], SprayTag [ i ] [ E_SPRAY_TAG_POS_Y ], SprayTag [ i ] [ E_SPRAY_TAG_POS_Z ], 
				SprayTag [ i ] [ E_SPRAY_TAG_ROT_X ], SprayTag [ i ] [ E_SPRAY_TAG_ROT_Y ], SprayTag [ i ] [ E_SPRAY_TAG_ROT_Z ]
			);
		}

		printf(" * [SPRAYTAGS] Loaded %d spraytags.", cache_num_rows());
	}

	MySQL_TQueryInline(mysql, using inline SprayTag_OnDataLoad, "SELECT * FROM spraytags", "" ) ;

	return true ;
}

SprayTag_IsPlayerNearStaticTag( playerid ) {

	for ( new i, j = sizeof ( SprayTag ); i < j ; i ++ ) {

		if( Streamer_IsItemVisible( playerid, STREAMER_TYPE_OBJECT, SprayTag [ i ] [ E_SPRAY_TAG_OBJECT ] ) ) {

	    	if( IsPlayerInRangeOfPoint( playerid, 3.0, SprayTag [ i ] [ E_SPRAY_TAG_POS_X ], SprayTag [ i ] [ E_SPRAY_TAG_POS_Y ], SprayTag [ i ] [ E_SPRAY_TAG_POS_Z ] ) ) {
	    		return i;
	    	}

	    	else continue ;
		}
		
	    else continue ;
	}

	return -1;
}

SprayTag_GetNameByModel(modelid, name[], len=sizeof(name)) {

	format ( name, len, "None" ) ;

	for ( new i, j = sizeof ( tag_information ); i < j ; i ++ ) {

		if ( tag_information [ i ] [ tag_model_id ] == modelid ) {

			format ( name, len, "%s", tag_information [ i ] [ e_st_tag_name ] ) ;
		}

		else continue ;
	}
}

SprayTag_FetchStaticID() {
	for ( new i, j = sizeof ( SprayTag ); i < j ; i ++ ) {

		if ( SprayTag [ i ] [ E_SPRAY_TAG_SQLID ] == INVALID_SPRAY_TAG ) {

			return i ;
		}

		else continue ;
	}

	return INVALID_SPRAY_TAG ;
}

CMD:stdelete(playerid, params[]) {

	return cmd_spraytagdelete(playerid, params);
}
CMD:spraytagdelete(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new index ;

	if ( sscanf ( params, "i", index ) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "/s(pray)t(ag)delete [A: id]");
	}

	if ( SprayTag [ index ] [ E_SPRAY_TAG_SQLID ] == INVALID_SPRAY_TAG ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Invalid ID entered! Enter the array ID! (A: XX on label)" ) ;
	}


	if ( IsValidDynamicObject( SprayTag [ index ] [ E_SPRAY_TAG_OBJECT ] )) {

		DestroyDynamicObject( SprayTag [ index ] [ E_SPRAY_TAG_OBJECT ] ) ;
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "DELETE FROM spraytags WHERE spraytag_sqlid = %d", SprayTag [ index ] [ E_SPRAY_TAG_SQLID ]) ;
	mysql_tquery(mysql, query);

	SprayTag [ index ] [ E_SPRAY_TAG_SQLID ] = INVALID_SPRAY_TAG ;

	query [ 0 ] = EOS ;
	format ( query, sizeof ( query ), "[AdmWarn] (%d) %s has deleted static spraytag with array ID %d.", 
		playerid, ReturnMixedName ( playerid ), index ) ;

	SendAdminMessage(query) ;

	return true ;
}

CMD:stcreate(playerid) {

	return cmd_spraytagcreate(playerid);
}

CMD:spraytagcreate(playerid) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ] != -1 ) {
		if ( IsValidDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ) {

			DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ]  ) ;
			PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ]  = -1 ;
		}
	
		new Float: pos_x, Float: pos_y, Float: pos_z ;
		GetPlayerPos(playerid, pos_x, pos_y, pos_z ) ;
		pos_z += 0.75 ;
		GetXYInFrontOfPlayer(playerid, pos_x, pos_y, 1.5);

		PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = CreateDynamicObject(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ], 
			pos_x, pos_y, pos_z, 0, 0, 0);


		PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = true ;
		PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 1 ; // 2 = static tag

		EditDynamicObject(playerid, PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ]);

		SendClientMessage(playerid, -1, "Position the tag to a favourable position then click the discette icon. To cancel, press ESC.");
	}

	else SendClientMessage(playerid, COLOR_ERROR, "You need to select a STATIC spray tag! Use /s(pray)t(ag)choose");
	return true ;
}


SprayTag_OnStaticTagCreate(playerid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz) {
	new index = SprayTag_FetchStaticID() ;

	if ( index == INVALID_SPRAY_TAG ) {

	
		PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = false ;
		DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 0 ;

		return SendClientMessage(playerid, -1, "There was a problem generating a static tag. All slots are used!" ) ;
	}

	SprayTag [ index ] [ E_SPRAY_TAG_MODELID ] = Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ] ;

	SprayTag [ index ] [ E_SPRAY_TAG_POS_X ] = x ;
	SprayTag [ index ] [ E_SPRAY_TAG_POS_Y ] = y ;
	SprayTag [ index ] [ E_SPRAY_TAG_POS_Z ] = z ;

	SprayTag [ index ] [ E_SPRAY_TAG_ROT_X ] = rx ;
	SprayTag [ index ] [ E_SPRAY_TAG_ROT_Y ] = ry ;
	SprayTag [ index ] [ E_SPRAY_TAG_ROT_Z ] = rz ;

	SprayTag [ index ] [ E_SPRAY_TAG_OWNER ] = -1 ;


	new query [ 512 ] ;

	mysql_format ( mysql, query, sizeof ( query ), 
		"INSERT INTO spraytags( spraytag_modelid, spraytag_pos_x, spraytag_pos_y, spraytag_pos_z, \
		spraytag_rot_x, spraytag_rot_y, spraytag_rot_z, spraytag_owner) VALUES (%d, '%f', '%f', '%f', '%f', '%f', '%f', '-1')",
			SprayTag [ index ] [ E_SPRAY_TAG_MODELID ],
			SprayTag [ index ] [ E_SPRAY_TAG_POS_X ],SprayTag [ index ] [ E_SPRAY_TAG_POS_Y ],SprayTag [ index ] [ E_SPRAY_TAG_POS_Z ], 
			SprayTag [ index ] [ E_SPRAY_TAG_ROT_X ], SprayTag [ index ] [ E_SPRAY_TAG_ROT_Y ],  SprayTag [ index ] [ E_SPRAY_TAG_ROT_Z ]
	) ;

	inline StaticTag_OnDBInsert() {

		SprayTag [ index ] [ E_SPRAY_TAG_SQLID ] = cache_insert_id ();

		printf(" * [STATIC SPRAYTAG] Created spray tag (%d) with ID %d.", 
			index, SprayTag [ index ] [ E_SPRAY_TAG_SQLID ] 
		) ;

		SprayTag [ index ] [ E_SPRAY_TAG_OBJECT ] = CreateDynamicObject(SprayTag [ index ] [ E_SPRAY_TAG_MODELID ], 

			SprayTag [ index ] [ E_SPRAY_TAG_POS_X ], SprayTag [ index ] [ E_SPRAY_TAG_POS_Y ], SprayTag [ index ] [ E_SPRAY_TAG_POS_Z ], 
			SprayTag [ index ] [ E_SPRAY_TAG_ROT_X ], SprayTag [ index ] [ E_SPRAY_TAG_ROT_Y ], SprayTag [ index ] [ E_SPRAY_TAG_ROT_Z ]
		);
	}

	MySQL_TQueryInline(mysql, using inline StaticTag_OnDBInsert, query, "");

	PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = false ;
	DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ;
	PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = -1 ;
	PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 0 ;

	return true ;
}