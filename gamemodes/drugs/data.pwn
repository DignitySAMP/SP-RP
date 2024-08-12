
#if !defined INVALID_DRUG_ID
	#define INVALID_DRUG_ID	(-1 )
#endif

enum {

	E_DRUG_TYPE_NONE = 0,
	E_DRUG_TYPE_WEED,
	E_DRUG_TYPE_COKE,
	E_DRUG_TYPE_CRACK,
	E_DRUG_TYPE_METH
} ;

enum {

	E_DRUG_STAGE_NONE = 0,
	E_DRUG_STAGE_START,
	E_DRUG_STAGE_TICKS,
	E_DRUG_STAGE_FINISH
} ;

enum E_DRUG_DATA {

	E_DRUG_SQLID,
	E_DRUG_TYPE, // type of drug
	E_DRUG_PARAM, // sub-type
	E_DRUG_STAGE,
	E_DRUG_TICKS,

	Float: E_DRUG_POS_X,
	Float: E_DRUG_POS_Y,
	Float: E_DRUG_POS_Z,

	Float: E_DRUG_ROT_X,
	Float: E_DRUG_ROT_Y,
	Float: E_DRUG_ROT_Z,

	E_DRUG_WORLDID,
	E_DRUG_INTERIOR,

	// These are universally used to determine growth rates!
	E_DRUG_GROWTH_PARAM_INT,
	Float: E_DRUG_GROWTH_PARAM_FLOAT_I,
	Float: E_DRUG_GROWTH_PARAM_FLOAT_II,
	Float: E_DRUG_GROWTH_PARAM_FLOAT_III,

	E_DRUG_OBJECT,
	E_DRUG_OBJECT_EXTRA, // only used for pots ( model 2203 )
	DynamicText3D: E_DRUG_LABEL
} ;

#if !defined MAX_DRUGS 
	#define MAX_DRUGS 500
#endif

new Drugs [ MAX_DRUGS ] [ E_DRUG_DATA ] ;


Drugs_GetFreeID() {

	for ( new i, j = sizeof ( Drugs ); i < j ; i ++ ) {

		if ( Drugs [ i ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

			return i ;
		}
	}

	return INVALID_DRUG_ID ;
}

Float: Drugs_GetPlayerDistFromPoint(playerid, drugid) {

	new Float: distance = 99999.99;
	for ( new i, j = sizeof ( Drugs ); i < j; i ++ ) {

		if ( Drugs [ i ] [ E_DRUG_SQLID ] == Drugs [ drugid ] [ E_DRUG_SQLID ] ) {

			if ( GetPlayerInterior(playerid) == Drugs [ i ] [ E_DRUG_INTERIOR ] && GetPlayerVirtualWorld(playerid) == Drugs [ i ] [ E_DRUG_WORLDID ] ) {

				distance = GetPlayerDistanceFromPoint(playerid, Drugs [ i ] [ E_DRUG_POS_X ], Drugs [ i ] [ E_DRUG_POS_Y ], Drugs [ i ] [ E_DRUG_POS_Z ] ) ;
			}

			else continue ;
		}

		else continue ;
	}

	return distance ;
}

Drugs_GetClosestEntity(playerid, Float: dist = 2.5) {

	for ( new i, j = sizeof ( Drugs ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, dist, Drugs [ i ] [ E_DRUG_POS_X ], Drugs [ i ] [ E_DRUG_POS_Y ], Drugs [ i ] [ E_DRUG_POS_Z ] ) ) {

			if ( GetPlayerInterior(playerid) == Drugs [ i ] [ E_DRUG_INTERIOR ] && GetPlayerVirtualWorld(playerid) == Drugs [ i ] [ E_DRUG_WORLDID ] ) {
				return i ;
			}

			else continue ;

		}

		else continue ;
	}

	return INVALID_DRUG_ID ;
}

Drugs_LoadEntity() {

	print(" * [DRUG STATIONS] Loading all drug entities") ;

    inline DrugLoadStations() {
		for ( new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "drug_sqlid", Drugs [ i ] [ E_DRUG_SQLID ]);
			cache_get_value_name_int(i, "drug_type", Drugs [ i ] [ E_DRUG_TYPE ]);
			cache_get_value_name_int(i, "drug_param", Drugs [ i ] [ E_DRUG_PARAM ]);
			cache_get_value_name_int(i, "drug_stage", Drugs [ i ] [ E_DRUG_STAGE ]);
			cache_get_value_name_int(i, "drug_ticks", Drugs [ i ] [ E_DRUG_TICKS ]);

			cache_get_value_name_float(i, "drug_pos_x", Drugs [ i ] [ E_DRUG_POS_X ]);
			cache_get_value_name_float(i, "drug_pos_y", Drugs [ i ] [ E_DRUG_POS_Y ]);
			cache_get_value_name_float(i, "drug_pos_z", Drugs [ i ] [ E_DRUG_POS_Z ]);

			cache_get_value_name_float(i, "drug_rot_x", Drugs [ i ] [ E_DRUG_ROT_X ]);
			cache_get_value_name_float(i, "drug_rot_y", Drugs [ i ] [ E_DRUG_ROT_Y ]);
			cache_get_value_name_float(i, "drug_rot_z", Drugs [ i ] [ E_DRUG_ROT_Z ]);

			cache_get_value_name_int(i, "drug_world", Drugs [ i ] [ E_DRUG_WORLDID ]);
			cache_get_value_name_int(i, "drug_interior", Drugs [ i ] [ E_DRUG_INTERIOR ]);

			cache_get_value_name_int(i, "drug_growth_param_int", Drugs [ i ] [ E_DRUG_GROWTH_PARAM_INT ]);
			cache_get_value_name_float(i, "drug_growth_param_float_i", Drugs [ i ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ]);
			cache_get_value_name_float(i, "drug_growth_param_float_ii", Drugs [ i ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ]);
			cache_get_value_name_float(i, "drug_growth_param_float_iii", Drugs [ i ] [ E_DRUG_GROWTH_PARAM_FLOAT_III ]);

			Drugs_UpdateObject ( i ) ;
		}

		printf(" * [DRUG STATIONS] Loaded %d drug stations.", cache_num_rows());
    }

    MySQL_TQueryInline(mysql, using inline DrugLoadStations, "SELECT * FROM drugs_player_stations");
}