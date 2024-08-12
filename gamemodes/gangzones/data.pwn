enum E_GANGZONE_DATA {

	E_GANGZONE_SQLID,

	Float: E_GANGZONE_MIN_X,
	Float: E_GANGZONE_MIN_Y,

	Float: E_GANGZONE_MAX_X,
	Float: E_GANGZONE_MAX_Y,
	
	E_GANGZONE_FACTION,
	E_GANGZONE_CONTESTED,

	E_GANGZONE_ZONEID,
	E_GANGZONE_AREAID
} ;

#if !defined MAX_GANG_ZONES
	#define MAX_GANG_ZONES 1024 // samp default
#endif

#if !defined INVALID_GANGZONE_ID
	#define INVALID_GANGZONE_ID 	-1
#endif

new GangZone [ MAX_GANG_ZONES ] [ E_GANGZONE_DATA ] ;

GangZone_LoadEntities() {

	for ( new i, j = sizeof ( GangZone ); i < j ; i ++ ) {

		GangZone [ i ] [ E_GANGZONE_SQLID ] = INVALID_GANGZONE_ID ;
	}

	print(" * [GANGZONE] Loading all gangzones...");

	inline GangZone_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "gz_sqlid", GangZone [ i ] [ E_GANGZONE_SQLID ]);

			cache_get_value_name_float(i, "gz_min_x", GangZone [ i ] [ E_GANGZONE_MIN_X ]);
			cache_get_value_name_float(i, "gz_min_y", GangZone [ i ] [ E_GANGZONE_MIN_Y ]);
			cache_get_value_name_float(i, "gz_max_x", GangZone [ i ] [ E_GANGZONE_MAX_X ]);
			cache_get_value_name_float(i, "gz_max_y", GangZone [ i ] [ E_GANGZONE_MAX_Y ]);
			
			cache_get_value_name_int(i, "gz_faction", GangZone [ i ] [ E_GANGZONE_FACTION ]);
			cache_get_value_name_int(i, "gz_contested", GangZone [ i ] [ E_GANGZONE_CONTESTED ]);

			SOLS_GangZoneCreate( GangZone [ i ] [ E_GANGZONE_ZONEID ], GangZone [ i ] [ E_GANGZONE_AREAID ],

				GangZone [ i ] [ E_GANGZONE_MIN_X ],
				GangZone [ i ] [ E_GANGZONE_MIN_Y ],
				GangZone [ i ] [ E_GANGZONE_MAX_X ],
				GangZone [ i ] [ E_GANGZONE_MAX_Y ]
			);

			GangZoneShowForAll(GangZone [ i ] [ E_GANGZONE_ZONEID ], GangZone_GetColour(GangZone [ i ] [ E_GANGZONE_FACTION ])) ;
		

			if ( GangZone [ i ] [ E_GANGZONE_CONTESTED ] ) {

				GangZoneFlashForAll(GangZone [ i ] [ E_GANGZONE_ZONEID ], 0xBA2920AA ) ;
			}
		}

		printf(" * [GANGZONE] Loaded %d gangzones.", cache_num_rows()) ;
	}

	MySQL_TQueryInline(mysql, using inline GangZone_OnDataLoad, "SELECT * FROM gangzones", "" ) ;

	return true ;
}

SOLS_GangZoneCreate( &gz_id, &area_id, Float: minx, Float: miny, Float: maxx, Float: maxy ) {

	gz_id = GangZoneCreate(
		minx, miny, maxx, maxy
	);

	area_id = CreateDynamicRectangle(minx, miny, maxx, maxy);
}

GetPlayerGangZone(playerid) {
    new Float:X1, Float:Y1, Float:Z1;
    GetPlayerPos(playerid, X1, Y1, Z1);

	for ( new i, j = sizeof ( GangZone ); i < j ; i ++ ) {


    	if(X1 > GangZone [ i ] [ E_GANGZONE_MIN_X ] && X1 < GangZone [ i ] [ E_GANGZONE_MAX_X ] && 
    		Y1 > GangZone [ i ] [ E_GANGZONE_MIN_Y ] && Y1 < GangZone [ i ] [ E_GANGZONE_MAX_Y ]) {

    		return i ;
    	}	
	}

	return INVALID_GANG_ZONE ;
}

bool: GangZone_IsPlayerInArea(playerid, index) {

	if ( IsPlayerInDynamicArea(playerid, GangZone [ index ] [ E_GANGZONE_AREAID ] ) ) {

		return true ;
	}

	return false ;
}
