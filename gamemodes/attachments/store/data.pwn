enum E_ATTACH_POINT_DATA {

	E_ATTACH_POINT_ID,
	E_ATTACH_POINT_TYPE,
	E_ATTACH_POINT_LINKEDBIZ,
	
	Float: E_ATTACH_POINT_POS_X,
	Float: E_ATTACH_POINT_POS_Y,
	Float: E_ATTACH_POINT_POS_Z,
	E_ATTACH_POINT_INT,
	E_ATTACH_POINT_VW,

	DynamicText3D: E_ATTACH_POINT_LABEL
} ;

#if !defined MAX_ATTACH_POINTS
	#define MAX_ATTACH_POINTS	250
#endif

#if !defined INVALID_ATTACH_POINT_ID
	#define INVALID_ATTACH_POINT_ID	-1
#endif

new AttachPoint [ MAX_ATTACH_POINTS ] [ E_ATTACH_POINT_DATA ] ;

AttachPoint_AddTypeErrorMsg(playerid) {
	SendClientMessage(playerid, 0xDEDEDEFF, "Available Types:" ) ;
	SendClientMessage(playerid, 0xDEDEDEFF, "[CLOTHING STORE] 0: Facewear SA-MP | 1: Facewear SOLS | 2: Headwear SA-MP | 3: Headwear SOLS" ) ;
	SendClientMessage(playerid, 0xDEDEDEFF, "[CLOTHING STORE] 4: Neckwear SOLS | 5: Miscalleneous | 6: LSPD Restricted" ) ;
	SendClientMessage(playerid, 0xDEDEDEFF, "[JEWELRY STORE] 7: Chains | 8: Watches | 9: Rings | 10: Miscalleneous" ) ;
	SendClientMessage(playerid, 0xDEDEDEFF, "[BARBERSHOP] 11: Hairstyles" ) ;
	SendClientMessage(playerid, 0xDEDEDEFF, "[CLOTHING STORE] 12: SAN Restricted | 13: LSFD Restricted | 14: DEA Restricted" ) ;
	return true ;
}

CMD:addattachpoint(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new type ;

	if ( sscanf ( params, "i", type ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "/addattachpoint [type]" ) ;
		return AttachPoint_AddTypeErrorMsg(playerid);
	}

	if ( type < 0 || type > 14 ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Type can't be less than 0 or more than 13!" ) ;
		return AttachPoint_AddTypeErrorMsg(playerid) ;
	}

	AttachPoint_Create ( playerid, type ) ;

	return true; 
}

CMD:attachpointdelete(playerid, params[] ) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new apid ;

	if ( sscanf  (params, "i", apid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Attach", "DEDEDE", "/attachpointdelete [point-id]" ) ;
	}

	if ( AttachPoint [ apid ] [ E_ATTACH_POINT_ID ] == INVALID_ATTACH_POINT_ID ) {
	
		return SendServerMessage ( playerid, COLOR_ERROR, "Attach", "DEDEDE", "Invalid attach point ID entered!");
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "DELETE FROM attachpoint WHERE attach_point_id = %d", 
		AttachPoint [ apid ] [ E_ATTACH_POINT_ID] 
	) ;

	mysql_tquery(mysql, query);

	if ( IsValidDynamic3DTextLabel ( AttachPoint [ apid ] [ E_ATTACH_POINT_LABEL ] ) ) {
		DestroyDynamic3DTextLabel( AttachPoint [ apid ] [ E_ATTACH_POINT_LABEL ] ) ;
	}

	AttachPoint [ apid ] [ E_ATTACH_POINT_ID]  = INVALID_ATTACH_POINT_ID ;

	return true ;
}

CMD:attachpointlink(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new apid, bizid ;

	if ( sscanf  (params, "ii", apid, bizid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Attach", "DEDEDE", "/attachpointlink [point-id] [biz-enum-id]" ) ;
	}

	if ( ! IsValidProperty(bizid)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Attach", "DEDEDE", "Invalid property ID entered!");
	}

	if ( AttachPoint [ apid ] [ E_ATTACH_POINT_ID ] == INVALID_ATTACH_POINT_ID ) {
	
		return SendServerMessage ( playerid, COLOR_ERROR, "Attach", "DEDEDE", "Invalid attach point ID entered!");
	}

	AttachPoint [ apid ] [ E_ATTACH_POINT_LINKEDBIZ] = bizid ; 

	new query [ 256 ], name [ 64 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE attachpoint SET attach_point_linkedbiz = %d WHERE attach_point_id = %d", 
		AttachPoint [ apid ] [ E_ATTACH_POINT_LINKEDBIZ], AttachPoint [ apid ] [ E_ATTACH_POINT_ID] 
	) ;

	mysql_tquery(mysql, query);


	query [ 0 ] = EOS ;

	AttachPoint_GetName(AttachPoint [ apid ] [ E_ATTACH_POINT_TYPE ], name, sizeof ( name ) );
	format ( query, sizeof ( query ), "[%d] [%s] [%d]\n{DEDEDE}Available commands: /buytoys", apid, name, AttachPoint [ apid ] [ E_ATTACH_POINT_LINKEDBIZ ] );

	UpdateDynamic3DTextLabelText( AttachPoint [ apid ] [ E_ATTACH_POINT_LABEL ], COLOR_ATTACH, query );

	return true ;
}

AttachPoint_HandlePayment(playerid, amount) {

	new idx = AttachPoint_GetNearestEntity(playerid);

	if ( idx == INVALID_ATTACH_POINT_ID ) {

		return true ;
	}

	new bizid = AttachPoint [ idx ] [ E_ATTACH_POINT_LINKEDBIZ ];

	if ( IsValidProperty(bizid) ) {

		PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = GetPropertyID(bizid);
		Property_AddMoneyToTill(playerid, amount, false );
	}

	return true ;
}

AttachPoint_GetNearestEntity(playerid) {

	for ( new i, j = sizeof ( AttachPoint ); i < j ; i ++ ) {

		if ( AttachPoint [ i ] [ E_ATTACH_POINT_ID ] != INVALID_ATTACH_POINT_ID ) {

			if ( IsPlayerInRangeOfPoint(playerid, 2.0, AttachPoint [ i ] [ E_ATTACH_POINT_POS_X ], AttachPoint [ i ] [ E_ATTACH_POINT_POS_Y ], AttachPoint [ i ] [ E_ATTACH_POINT_POS_Z ] ) ) {

				return i ;
			}

			else continue ;
		}

		else continue ;
	}

	return INVALID_ATTACH_POINT_ID ;
}

AttachPoint_Create(playerid, type ){

	new idx = AttachPoint_GetFreeID();

	if ( idx == INVALID_ATTACH_POINT_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Can't create attach point - limit reached!" ) ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;

	AttachPoint [ idx ] [ E_ATTACH_POINT_TYPE ] = type ;
	AttachPoint [ idx ] [ E_ATTACH_POINT_LINKEDBIZ ] = -1 ;
	
	AttachPoint [ idx ] [ E_ATTACH_POINT_POS_X ] = x ;
	AttachPoint [ idx ] [ E_ATTACH_POINT_POS_Y ] = y ;
	AttachPoint [ idx ] [ E_ATTACH_POINT_POS_Z ] = z ;
	AttachPoint [ idx ] [ E_ATTACH_POINT_INT ] = GetPlayerInterior(playerid);
	AttachPoint [ idx ] [ E_ATTACH_POINT_VW ] = GetPlayerVirtualWorld(playerid);

	new string [ 256 ], name [ 64 ] ;

	string[0]=EOS;
	mysql_format(mysql, string, sizeof(string), 
		"INSERT INTO attachpoint(attach_point_type, attach_point_linkedbiz, attach_point_pos_x, attach_point_pos_y, attach_point_pos_z, attach_point_int, attach_point_vw)\
	 VALUES (%d, %d, '%f', '%f', '%f', %d, %d)",

		AttachPoint [ idx ] [ E_ATTACH_POINT_TYPE ] ,
		AttachPoint [ idx ] [ E_ATTACH_POINT_LINKEDBIZ ] ,
		AttachPoint [ idx ] [ E_ATTACH_POINT_POS_X ] ,
		AttachPoint [ idx ] [ E_ATTACH_POINT_POS_Y ] ,
		AttachPoint [ idx ] [ E_ATTACH_POINT_POS_Z ],
		AttachPoint [ idx ] [ E_ATTACH_POINT_INT ] ,
		AttachPoint [ idx ] [ E_ATTACH_POINT_VW ]
	);

	inline AttachPoint_OnDBInsert() {

		AttachPoint [ idx ] [ E_ATTACH_POINT_ID ] = cache_insert_id ();
		printf(" * [Attach Point] Created attach point (%d) with ID %d.", 
			idx, AttachPoint [ idx ] [ E_ATTACH_POINT_ID ] ) ;

		if ( IsValidDynamic3DTextLabel(AttachPoint [ idx ] [ E_ATTACH_POINT_LABEL ])) {

			DestroyDynamic3DTextLabel(AttachPoint [ idx ] [ E_ATTACH_POINT_LABEL ]);
		}

		AttachPoint_GetName(type, name, sizeof ( name ) );
		format ( string, sizeof ( string ), "[%d] [%s] [%d]\n{DEDEDE}Available commands: /buytoys", idx, name, AttachPoint [ idx ] [ E_ATTACH_POINT_LINKEDBIZ ] ) ;

		AttachPoint [ idx ] [ E_ATTACH_POINT_LABEL ] = CreateDynamic3DTextLabel(string, COLOR_ATTACH, 

			AttachPoint [ idx ] [ E_ATTACH_POINT_POS_X ], AttachPoint [ idx ] [ E_ATTACH_POINT_POS_Y ], AttachPoint [ idx ] [ E_ATTACH_POINT_POS_Z ],
			7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true, 
			AttachPoint [ idx ] [ E_ATTACH_POINT_VW ], AttachPoint [ idx ] [ E_ATTACH_POINT_INT ]
		);
	}

	MySQL_TQueryInline(mysql, using inline AttachPoint_OnDBInsert, string);

	return true ;
}

AttachPoint_GetName(type, name[], len = sizeof ( name ) ) {

	switch ( type ) {

		// Clothing Store
		case 0: format ( name, len, "Clothing Store: Facewear (SA-MP)" ) ;
		case 1: format ( name, len, "Clothing Store: Facewear (SOLS)" ) ;
		case 2: format ( name, len, "Clothing Store: Headwear (SA-MP)" ) ;
		case 3: format ( name, len, "Clothing Store: Headwear (SOLS)" ) ;
		case 4: format ( name, len, "Clothing Store: Neckwear (SOLS)" ) ;
		case 5: format ( name, len, "Clothing Store: Miscalleneous" ) ;
		case 6: format ( name, len, "Clothing Store: LSPD Restricted" ) ;

		case 7: format ( name, len, "Jewelry Store: Chains" ) ;
		case 8: format ( name, len, "Jewelry Store: Watches" ) ;
		case 9: format ( name, len, "Jewelry Store: Rings" ) ;
		case 10: format ( name, len, "Jewelry Store: Miscalleneous" ) ;

		case 11: format ( name, len, "Barbershop: Hairstyles" ) ;
		case 12: format ( name, len, "Clothing Store: NEWS Restricted" ) ;
		case 13: format ( name, len, "Clothing Store: LSFD Restricted" ) ;
		case 14: format ( name, len, "Clothing Store: DEA Restricted" ) ;
		default: format ( name, len, "Invalid Point Type" ) ;
	}
}

AttachPoint_GetFreeID() {

	for ( new i, j = sizeof ( AttachPoint ); i < j ; i ++ ) {

		if ( AttachPoint [ i ] [ E_ATTACH_POINT_ID ] == INVALID_ATTACH_POINT_ID ) {

			return i ;
		}

		else continue ;
	}

	return -1 ;
}

AttachPoint_LoadEntities() {
	for ( new i, j = sizeof ( AttachPoint ); i < j ; i ++ ) {

		AttachPoint [ i ] [ E_ATTACH_POINT_ID ] = INVALID_ATTACH_POINT_ID ;
	}

	new string[256], name[64];

    inline AttachPointsLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "attach_point_id", AttachPoint [ i ] [ E_ATTACH_POINT_ID ]);
			cache_get_value_name_int(i, "attach_point_type", AttachPoint [ i ] [ E_ATTACH_POINT_TYPE ]);
			cache_get_value_name_int(i, "attach_point_linkedbiz", AttachPoint [ i ] [ E_ATTACH_POINT_LINKEDBIZ ]);
			
			cache_get_value_name_float(i, "attach_point_pos_x", AttachPoint [ i ] [ E_ATTACH_POINT_POS_X ]);
			cache_get_value_name_float(i, "attach_point_pos_y", AttachPoint [ i ] [ E_ATTACH_POINT_POS_Y ]);
			cache_get_value_name_float(i, "attach_point_pos_z", AttachPoint [ i ] [ E_ATTACH_POINT_POS_Z ]);
			cache_get_value_name_int(i, "attach_point_int", AttachPoint [ i ] [ E_ATTACH_POINT_INT ]);
			cache_get_value_name_int(i, "attach_point_vw", AttachPoint [ i ] [ E_ATTACH_POINT_VW ]);


			AttachPoint_GetName(AttachPoint [ i ] [ E_ATTACH_POINT_TYPE ], name, sizeof ( name ) );
			format ( string, sizeof ( string ), "[%d] [%s] [%d]\n{DEDEDE}Available commands: /buytoys", i, name, AttachPoint [ i ] [ E_ATTACH_POINT_LINKEDBIZ ] );

			AttachPoint [ i ] [ E_ATTACH_POINT_LABEL ] = CreateDynamic3DTextLabel(string, COLOR_ATTACH, 

				AttachPoint [ i ] [ E_ATTACH_POINT_POS_X ], AttachPoint [ i ] [ E_ATTACH_POINT_POS_Y ], AttachPoint [ i ] [ E_ATTACH_POINT_POS_Z ],
				7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true, 
				AttachPoint [ i ] [ E_ATTACH_POINT_VW ], AttachPoint [ i ] [ E_ATTACH_POINT_INT ]
			);
		}

		printf(" * [ATTACH POINTS] Loaded %d attach points.", cache_num_rows() ) ;
    }

    MySQL_TQueryInline(mysql, using inline AttachPointsLoad, "SELECT * FROM attachpoint");
}