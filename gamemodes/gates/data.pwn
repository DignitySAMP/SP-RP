enum E_GATE_DATA {

	E_GATE_SQLID,
	E_GATE_STATE,

	E_GATE_TYPE,
	E_GATE_OWNER,

	Float: E_GATE_SPEED,
	Float: E_GATE_RADIUS,
	E_GATE_SETUP,
	// 0 = closed pos
	// 1 = open pos

	E_GATE_OBJECTID,
	E_GATE_INTERIOR,
	E_GATE_VIRTUALWORLD,

	E_GATE_MODELID,
	E_GATE_TOLL,
	E_GATE_AUTOCLOSE,

	E_GATE_TEXTUREID [ 16 ],

	Float: E_GATE_CLOSED_POS_X,
	Float: E_GATE_CLOSED_POS_Y,
	Float: E_GATE_CLOSED_POS_Z,

	Float: E_GATE_CLOSED_ROT_X,
	Float: E_GATE_CLOSED_ROT_Y,
	Float: E_GATE_CLOSED_ROT_Z,

	Float: E_GATE_OPEN_POS_X,
	Float: E_GATE_OPEN_POS_Y,
	Float: E_GATE_OPEN_POS_Z,

	Float: E_GATE_OPEN_ROT_X,
	Float: E_GATE_OPEN_ROT_Y,
	Float: E_GATE_OPEN_ROT_Z
} ;

#if !defined MAX_GATES 
	#define MAX_GATES 	500
#endif

#if !defined INVALID_GATE_ID
	#define INVALID_GATE_ID -1
#endif

#if !defined GATE_SETUP_ID // id assigned to gates that are being mapped.
	#define GATE_SETUP_ID MAX_GATES + 1 // don 't forget to reset xd
#endif

enum {
	E_GATE_TYPE_INVALID = 0,
	E_GATE_TYPE_PUBLIC, // operatable by anyone
	E_GATE_TYPE_PLAYER, // only usable by assigned character_id
	E_GATE_TYPE_PROPERTY, // only usable by owner of property
	E_GATE_TYPE_FACTION // only usable by faction members
} ;

new Gate [ MAX_GATES ] [ E_GATE_DATA ] ;

new Gate_Texture_TXD [ MAX_GATES ] [ 16 ] [ 64 ] ;
new Gate_Texture_Name [ MAX_GATES ] [ 16 ] [ 64 ] ;

Gate_GetType(enum_id) {

	new gatetype [ 32 ] ;

	if ( Gate [ enum_id ] [ E_GATE_SQLID ] == INVALID_GATE_ID ) {

		strcat(gatetype, "Undefined" ) ;
	}

	else {

		switch ( Gate [ enum_id ] [ E_GATE_TYPE ] ) {

			case E_GATE_TYPE_INVALID: strcat(gatetype, "INVALID" ) ;
			case E_GATE_TYPE_PUBLIC: strcat(gatetype, "PUBLIC: FREE TO USE" ) ;
			case E_GATE_TYPE_PLAYER: strcat(gatetype, "PLAYER-OWNED" ) ;
			case E_GATE_TYPE_PROPERTY: strcat(gatetype, "PROPERTY-LINKED" ) ;
			case E_GATE_TYPE_FACTION : strcat(gatetype, "FACTION-OWNED" ) ;
		}
	}

	return gatetype ;
}

Gate_GetClosestEntity(playerid) {

	for ( new i, j = sizeof ( Gate ); i < j ; i ++ ) {

		if ( Gate [ i ] [ E_GATE_SQLID ] == INVALID_GATE_ID ) {

			continue ;
		}

		if ( IsPlayerInRangeOfPoint(playerid, Gate [ i ] [ E_GATE_RADIUS ], Gate [ i ] [ E_GATE_CLOSED_POS_X ], Gate [ i ] [ E_GATE_CLOSED_POS_Y ], Gate [ i ] [ E_GATE_CLOSED_POS_Z ] ) ) {

			return i ;
		}
	}

	return INVALID_GATE_ID ;
}

Gate_GetEnumIDFromObject(objectid) {

	for(new i, j = sizeof ( Gate ); i < j ; i ++ ) {

		if ( Gate [ i ] [ E_GATE_OBJECTID ] == objectid ) {

			return i ;
		}
	}

	return INVALID_GATE_ID ;
}

Gate_GetFreeID() {

	for(new i, j = sizeof ( Gate ); i < j ; i ++ ) {

		if ( Gate [ i ] [ E_GATE_SQLID ] == INVALID_GATE_ID ) {

			return i ;
		}
	}

	return INVALID_GATE_ID ;
}

Gate_LoadEntities() {

	for(new i, j = sizeof ( Gate ); i < j ; i ++ ) {

		Gate [ i ] [ E_GATE_SQLID ] = INVALID_GATE_ID ;
	}

	print(" * [GATE] Loading all gates...");

	inline Gate_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_int (i, "gate_sqlid", Gate [ i ] [ E_GATE_SQLID ]);

			cache_get_value_int (i, "gate_type", Gate [ i ] [ E_GATE_TYPE ]);
			cache_get_value_int (i, "gate_owner", Gate [ i ] [ E_GATE_OWNER ]);

			cache_get_value_int (i, "gate_interior", Gate [ i ] [ E_GATE_INTERIOR ]);
			cache_get_value_int (i, "gate_virtualworld", Gate [ i ] [ E_GATE_VIRTUALWORLD ]);

			cache_get_value_int (i, "gate_modelid", Gate [ i ] [ E_GATE_MODELID ]);
			cache_get_value_int (i, "gate_toll", Gate [ i ] [ E_GATE_TOLL ]);
			cache_get_value_int (i, "gate_autoclose", Gate [ i ] [ E_GATE_AUTOCLOSE ]);

			cache_get_value_float(i, "gate_speed", Gate [ i ] [ E_GATE_SPEED ]);
			cache_get_value_float(i, "gate_radius", Gate [ i ] [ E_GATE_RADIUS ]);

			cache_get_value_float( i, "gate_closed_pos_x", Gate [ i ] [ E_GATE_CLOSED_POS_X ]);
			cache_get_value_float( i, "gate_closed_pos_y", Gate [ i ] [ E_GATE_CLOSED_POS_Y ]);
			cache_get_value_float( i, "gate_closed_pos_z", Gate [ i ] [ E_GATE_CLOSED_POS_Z ]);

			cache_get_value_float( i, "gate_closed_rot_x", Gate [ i ] [ E_GATE_CLOSED_ROT_X ]);
			cache_get_value_float( i, "gate_closed_rot_y", Gate [ i ] [ E_GATE_CLOSED_ROT_Y ]);
			cache_get_value_float( i, "gate_closed_rot_z", Gate [ i ] [ E_GATE_CLOSED_ROT_Z ]);

			cache_get_value_float( i, "gate_open_pos_x", Gate [ i ] [ E_GATE_OPEN_POS_X ]);
			cache_get_value_float( i, "gate_open_pos_y", Gate [ i ] [ E_GATE_OPEN_POS_Y ]);
			cache_get_value_float( i, "gate_open_pos_z", Gate [ i ] [ E_GATE_OPEN_POS_Z ]);

			cache_get_value_float( i, "gate_open_rot_x", Gate [ i ] [ E_GATE_OPEN_ROT_X ]);
			cache_get_value_float( i, "gate_open_rot_y", Gate [ i ] [ E_GATE_OPEN_ROT_Y ]);
			cache_get_value_float( i, "gate_open_rot_z", Gate [ i ] [ E_GATE_OPEN_ROT_Z ]);


			if ( IsValidDynamicObject ( Gate [ i ] [ E_GATE_OBJECTID ])) {

				SOLS_DestroyObject( Gate [ i ] [ E_GATE_OBJECTID ], "Gate/LoadEntities", true ) ;
			}

			Gate [ i ] [ E_GATE_OBJECTID ] = CreateDynamicObject(Gate [ i ] [ E_GATE_MODELID ], 
				Gate [ i ] [ E_GATE_CLOSED_POS_X ], Gate [ i ] [ E_GATE_CLOSED_POS_Y ], Gate [ i ] [ E_GATE_CLOSED_POS_Z ], 
				Gate [ i ] [ E_GATE_CLOSED_ROT_X ], Gate [ i ] [ E_GATE_CLOSED_ROT_Y ], Gate [ i ] [ E_GATE_CLOSED_ROT_Z ],
				Gate [ i ] [ E_GATE_VIRTUALWORLD ], Gate [ i ] [ E_GATE_INTERIOR ] );
		


			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, Gate [ i ] [ E_GATE_OBJECTID ], E_STREAMER_STREAM_DISTANCE, 500 );
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, Gate [ i ] [ E_GATE_OBJECTID ], E_STREAMER_DRAW_DISTANCE, 500 );
			
			for ( new x, j = 16; x < j ; x ++ ) {

				cache_get_value_name_int (i, sprintf("gate_textureid%d", x), Gate [ i ] [ E_GATE_TEXTUREID ] [ x  ]);
				cache_get_value_name ( i, sprintf("gate_texturetxd%d", x), Gate_Texture_TXD [ i ] [ x ]);
				cache_get_value_name ( i, sprintf("gate_texturename%d", x), Gate_Texture_Name [ i ] [ x ]);

				if ( Gate [ i ] [ E_GATE_TEXTUREID ] [ x ] ) {

					SetDynamicObjectMaterial(Gate [ i ] [ E_GATE_OBJECTID ], x, Gate [ i ] [ E_GATE_TEXTUREID ] [ x  ], Gate_Texture_TXD [ i ] [ x ], Gate_Texture_Name [ i ] [ x ]);
				}
			}
		}

		printf(" * [GATE] Loaded %d gates.", cache_num_rows());
	}

	MySQL_TQueryInline(mysql, using inline Gate_OnDataLoad, "SELECT * FROM gates", "" ) ;


	return true ;
}