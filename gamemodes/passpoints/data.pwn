enum E_PASSPOINT_DATA {

	E_PASSPOINT_SQLID,
	E_PASSPOINT_DESC [ 64 ],
	E_PASSPOINT_COLOR,

	E_PASSPOINT_TYPE,
	E_PASSPOINT_FACTION,
	Float: E_PASSPOINT_RADIUS,

	Float: E_PASSPOINT_POS_X,
	Float: E_PASSPOINT_POS_Y,
	Float: E_PASSPOINT_POS_Z,
	Float: E_PASSPOINT_POS_A,

	E_PASSPOINT_WORLD,
	E_PASSPOINT_INTERIOR,

	Float: E_PASSPOINT_LINKED_X,
	Float: E_PASSPOINT_LINKED_Y,
	Float: E_PASSPOINT_LINKED_Z,
	Float: E_PASSPOINT_LINKED_A,

	E_PASSPOINT_LINKED_WORLD,
	E_PASSPOINT_LINKED_INTERIOR,

	DynamicText3D: E_PASSPOINT_LABEL [ 2 ]
};
new Passpoint [ MAX_PASSPOINTS ] [ E_PASSPOINT_DATA ] ;
new Iterator: Passpoints<MAX_PASSPOINTS> ;

CMD:passpointcreate(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float: x, Float: y, Float: z, Float: a;
	GetPlayerPos(playerid, x, y, z) ;
	GetPlayerFacingAngle(playerid, a) ;
	
	new type ;

	if ( sscanf ( params, "i", type ) ) {

		return SendClientMessage(playerid, -1, "/passpointcreate [type] (0: player, 1: vehicle)");
	}

	PassPoint_Create( playerid, type, x, y, z, a - 180.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid) ) ;


	return true ;
}

PassPoint_Create(playerid, type, Float: x, Float: y, Float: z, Float: angle, worldid, interiorid ) {

	new idx = Iter_Free(Passpoints) ;
	if(idx == -1) {
		return SendClientMessage(playerid, COLOR_ERROR, "Maximum number of passpoints reached.");
	}

	Passpoint [ idx ] [ E_PASSPOINT_TYPE ] = type ;
	Passpoint [ idx ] [ E_PASSPOINT_FACTION ] = INVALID_FACTION_ID ;

	format ( Passpoint [ idx ] [ E_PASSPOINT_DESC ], 64, "Unnamed" ) ;
	Passpoint [ idx ] [ E_PASSPOINT_COLOR ] = 0xDEDEDEFF ;
	Passpoint [ idx ] [ E_PASSPOINT_RADIUS ] = 5.0 ;

	Passpoint [ idx ] [ E_PASSPOINT_POS_X ] = x ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_Y ] = y ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_Z ] = z ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_A ] = angle ;

	Passpoint [ idx ] [ E_PASSPOINT_WORLD ] = worldid ;
 	Passpoint [ idx ] [ E_PASSPOINT_INTERIOR ] = interiorid ;
 	Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ] = DynamicText3D: INVALID_3DTEXT_ID ;
 	Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 1 ] = DynamicText3D: INVALID_3DTEXT_ID ;

 	new query [ 512 + 1 ] ;

	mysql_format(mysql, query, sizeof ( query ), 
		"INSERT INTO passpoints( passpoint_desc, passpoint_color, passpoint_type, passpoint_faction, \
		passpoint_pos_x, passpoint_pos_y, passpoint_pos_z, passpoint_pos_a, passpoint_pos_world, passpoint_pos_interior, passpoint_radius) \
		VALUES ('%e', %d, %d, %d, '%f', '%f', '%f', '%f', %d, %d, '5.0')",

		Passpoint [ idx ] [ E_PASSPOINT_DESC ], Passpoint [ idx ] [ E_PASSPOINT_COLOR ], Passpoint [ idx ] [ E_PASSPOINT_TYPE ], 
		Passpoint [ idx ] [ E_PASSPOINT_FACTION ], Passpoint [ idx ] [ E_PASSPOINT_POS_X ], Passpoint [ idx ] [ E_PASSPOINT_POS_Y ],
		Passpoint [ idx ] [ E_PASSPOINT_POS_Z ], Passpoint [ idx ] [ E_PASSPOINT_POS_A ],  Passpoint [ idx ] [ E_PASSPOINT_WORLD ], 
		Passpoint [ idx ] [ E_PASSPOINT_INTERIOR ] 
	) ;

	inline Passpoint_OnDBInsert() {

		Passpoint [ idx ] [ E_PASSPOINT_SQLID ] = cache_insert_id ();
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("Passpoint created with ID %d (DATABASE %d). Don't forget to do /passpointradius!", idx, Passpoint [ idx ] [ E_PASSPOINT_SQLID ] ) ) ;

		PassPoint_SetupLabel(idx);
		Iter_Add(Passpoints, idx);
	}

	MySQL_TQueryInline(mysql, using inline Passpoint_OnDBInsert, query, "");

	return true ;
}

PassPoint_SetupLabel(idx) {

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "[%d] [%s]\n{DEDEDE}Available commands: /pass", idx, Passpoint [ idx ] [ E_PASSPOINT_DESC ] ) ;

	if ( IsValidDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ] ) ) {

		DestroyDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ] ) ;
		Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ]  = DynamicText3D: INVALID_3DTEXT_ID ;
	}

	Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ] = CreateDynamic3DTextLabel(string, Passpoint [ idx ] [ E_PASSPOINT_COLOR ], 
		Passpoint [ idx ] [ E_PASSPOINT_POS_X ], Passpoint [ idx ] [ E_PASSPOINT_POS_Y ], Passpoint [ idx ] [ E_PASSPOINT_POS_Z ],
		Passpoint [ idx ] [ E_PASSPOINT_RADIUS ],  INVALID_PLAYER_ID,  INVALID_VEHICLE_ID, true, Passpoint [ idx ] [ E_PASSPOINT_WORLD ], Passpoint [ idx ] [ E_PASSPOINT_INTERIOR ]
	);

	if ( IsValidDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ]  [ 1 ]) ) {

		DestroyDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 1 ] ) ;
		Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 1 ]  = DynamicText3D: INVALID_3DTEXT_ID ;
	}

	Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 1 ] = CreateDynamic3DTextLabel(string, Passpoint [ idx ] [ E_PASSPOINT_COLOR ], 
		Passpoint [ idx ] [ E_PASSPOINT_LINKED_X ], Passpoint [ idx ] [ E_PASSPOINT_LINKED_Y ], Passpoint [ idx ] [ E_PASSPOINT_LINKED_Z ],
		Passpoint [ idx ] [ E_PASSPOINT_RADIUS ],  INVALID_PLAYER_ID,  INVALID_VEHICLE_ID, true, Passpoint [ idx ] [ E_PASSPOINT_LINKED_WORLD ], 
		Passpoint [ idx ] [ E_PASSPOINT_LINKED_INTERIOR ]
	);

}

#include <YSI_Coding\y_hooks>
hook OnStartSQL() {

	foreach(new i: Passpoints) {

		Passpoint [ i ] [ E_PASSPOINT_SQLID ] = INVALID_PASSPOINT_ID ;
	}

	inline PassPoint_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) { 
			cache_get_value_name_int(i, "passpoint_sqlid", Passpoint [ i ] [ E_PASSPOINT_SQLID ]);

			cache_get_value_name( i, "passpoint_desc", Passpoint [ i ] [ E_PASSPOINT_DESC ]);
			cache_get_value_name_int(i, "passpoint_color", Passpoint [ i ] [ E_PASSPOINT_COLOR ]);

			cache_get_value_name_int(i, "passpoint_type", Passpoint [ i ] [ E_PASSPOINT_TYPE ]);
			cache_get_value_name_int(i, "passpoint_faction", Passpoint [ i ] [ E_PASSPOINT_FACTION ]);

			cache_get_value_name_float(i, "passpoint_radius", Passpoint [ i ] [ E_PASSPOINT_RADIUS ]);

			cache_get_value_name_float(i, "passpoint_pos_x", Passpoint [ i ] [ E_PASSPOINT_POS_X ]);
			cache_get_value_name_float(i, "passpoint_pos_y", Passpoint [ i ] [ E_PASSPOINT_POS_Y ]);
			cache_get_value_name_float(i, "passpoint_pos_z", Passpoint [ i ] [ E_PASSPOINT_POS_Z ]);
			cache_get_value_name_float(i, "passpoint_pos_a", Passpoint [ i ] [ E_PASSPOINT_POS_A ]);

			cache_get_value_name_int(i, "passpoint_pos_world", Passpoint [ i ] [ E_PASSPOINT_WORLD ]);
			cache_get_value_name_int(i, "passpoint_pos_interior", Passpoint [ i ] [ E_PASSPOINT_INTERIOR ]);

			cache_get_value_name_float(i, "passpoint_linked_x", Passpoint [ i ] [ E_PASSPOINT_LINKED_X ]);
			cache_get_value_name_float(i, "passpoint_linked_y", Passpoint [ i ] [ E_PASSPOINT_LINKED_Y ]);
			cache_get_value_name_float(i, "passpoint_linked_z", Passpoint [ i ] [ E_PASSPOINT_LINKED_Z ]);
			cache_get_value_name_float(i, "passpoint_linked_a", Passpoint [ i ] [ E_PASSPOINT_LINKED_A ]);

			cache_get_value_name_int(i, "passpoint_linked_world", Passpoint [ i ] [ E_PASSPOINT_LINKED_WORLD ]);
			cache_get_value_name_int(i, "passpoint_linked_interior", Passpoint [ i ] [ E_PASSPOINT_LINKED_INTERIOR ]);

			PassPoint_SetupLabel(i);
			Iter_Add(Passpoints, i);
		}

		printf(" [+] %i Pass Points loaded.", cache_num_rows());
	}

	MySQL_TQueryInline(mysql, using inline PassPoint_OnDataLoad, "SELECT * FROM passpoints", "" ) ;

	return true ;
}


GetClosestPasspoint(playerid) {

	new Float: MAX_RANGE = 5.0;

    new point_id = -1, Float:dis = 99999.99, Float:dis2, Float: dis3, type ;

    foreach(new i: Passpoints) {

    	if ( Passpoint [ i ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {

    		continue ;
    	}

        dis2 = GetPlayerDistanceFromPoint(playerid, Passpoint [ i ] [ E_PASSPOINT_POS_X ], Passpoint [ i ] [ E_PASSPOINT_POS_Y ], Passpoint [ i ] [ E_PASSPOINT_POS_Z ] );
        if(dis2 < dis &&  GetPlayerInterior(playerid) == Passpoint [ i ] [ E_PASSPOINT_INTERIOR ] && GetPlayerVirtualWorld(playerid) == Passpoint [ i ] [ E_PASSPOINT_WORLD ] && dis2 < Passpoint[i][E_PASSPOINT_RADIUS])
        {
            dis = dis2;
            point_id = i;
            type = 0 ;
        }
    }

   	foreach(new i: Passpoints) {

    	if ( Passpoint [ i ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {

    		continue ;
    	}

        dis3 = GetPlayerDistanceFromPoint(playerid, Passpoint [ i ] [ E_PASSPOINT_LINKED_X ], Passpoint [ i ] [ E_PASSPOINT_LINKED_Y ], Passpoint [ i ] [ E_PASSPOINT_LINKED_Z ] );
        if(dis3 < dis &&  GetPlayerInterior(playerid) == Passpoint [ i ] [ E_PASSPOINT_LINKED_INTERIOR ] && GetPlayerVirtualWorld(playerid) == Passpoint [ i ] [ E_PASSPOINT_LINKED_WORLD ] && dis3 < Passpoint[i][E_PASSPOINT_RADIUS])
        {
            dis = dis3;
            point_id = i;
            type = 1 ;
        }
    }


	if ( dis <= MAX_RANGE ) {

		if ( Passpoint [ point_id ] [ E_PASSPOINT_FACTION ] > 0 ) {
			if ( Passpoint [ point_id ] [ E_PASSPOINT_FACTION ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
				return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You don't have access to this pass point (faction restricted)." ) ;
			}
		}

	    switch ( type ) {

	    	case 0: { // near original point
	    		switch (  Passpoint [ point_id ] [ E_PASSPOINT_TYPE  ] ) {

					case 0: {
						if ( IsPlayerInAnyVehicle(playerid) ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You can only pass through this passpoint on foot." ) ;
						}

						SetPlayerVirtualWorld(playerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_WORLD ] ) ;
						SetPlayerInterior(playerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_INTERIOR ]);
						SOLS_SetPosWithFade(playerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_X ], Passpoint [ point_id ] [ E_PASSPOINT_LINKED_Y ], Passpoint [ point_id ] [ E_PASSPOINT_LINKED_Z ]) ;
						SetPlayerFacingAngle(playerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_A ]);

						AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Entered Passpoint %d \"%s\" (SQL: %d)", point_id, Passpoint [ point_id ] [ E_PASSPOINT_DESC ], Passpoint [ point_id ] [ E_PASSPOINT_SQLID ]));
					}

					case 1: {
						if ( ! IsPlayerInAnyVehicle(playerid) ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You can only pass through this passpoint with a vehicle." ) ;
						}

						if ( GetPlayerVehicleSeat(playerid) != 0 ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You must be the driver of a vehicle in order to use this." ) ;
						}

						new vehicleid = GetPlayerVehicleID(playerid);

						if ( vehicleid == 0 ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You're not in a vehicle!" ) ;
						}

						SOLS_SetVehiclePos(playerid, vehicleid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_X ], Passpoint [ point_id ] [ E_PASSPOINT_LINKED_Y ], Passpoint [ point_id ] [ E_PASSPOINT_LINKED_Z ] ) ;
						
						SetVehicleVirtualWorld(vehicleid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_WORLD ] ) ;
						LinkVehicleToInterior(vehicleid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_INTERIOR ] ) ;

						foreach(new forplayerid: Player) {

							if ( GetPlayerVehicleID(forplayerid) == vehicleid ) {

								SetPlayerVirtualWorld(forplayerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_WORLD ] ) ;
								SetPlayerInterior(forplayerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_INTERIOR ]);
							}
						}

						SetPlayerVirtualWorld(playerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_WORLD ] ) ;
						SetPlayerInterior(playerid, Passpoint [ point_id ] [ E_PASSPOINT_LINKED_INTERIOR ]);
					}
				}
	    	}

	    	case 1: { // near linked point

				switch (  Passpoint [ point_id ] [ E_PASSPOINT_TYPE  ] ) {

					case 0: {
						if ( IsPlayerInAnyVehicle(playerid) ) return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You can only pass through this passpoint on foot." ) ;

						SetPlayerVirtualWorld(playerid, Passpoint [ point_id ] [ E_PASSPOINT_WORLD ] ) ;
						SetPlayerInterior(playerid, Passpoint [ point_id ] [ E_PASSPOINT_INTERIOR ]);
						SOLS_SetPosWithFade(playerid, Passpoint [ point_id ] [ E_PASSPOINT_POS_X ], Passpoint [ point_id ] [ E_PASSPOINT_POS_Y ], Passpoint [ point_id ] [ E_PASSPOINT_POS_Z ]) ;
						SetPlayerFacingAngle(playerid, Passpoint [ point_id ] [ E_PASSPOINT_POS_A ]);

						AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Exited Passpoint %d \"%s\" (SQL: %d)", point_id, Passpoint [ point_id ] [ E_PASSPOINT_DESC ], Passpoint [ point_id ] [ E_PASSPOINT_SQLID ]));
					}

					case 1: {
						if ( ! IsPlayerInAnyVehicle(playerid) ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You can only pass through this passpoint with a vehicle." ) ;
						}

						if ( GetPlayerVehicleSeat(playerid) != 0 ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You must be the driver of a vehicle in order to use this." ) ;
						}

						new vehicleid = GetPlayerVehicleID(playerid);

						if ( vehicleid == 0 ) {

							return SendServerMessage ( playerid, COLOR_INFO, "Passpoint", "A3A3A3", "You're not in a vehicle!" ) ;
						}

						SOLS_SetVehiclePos(playerid, vehicleid, Passpoint [ point_id ] [ E_PASSPOINT_POS_X ], Passpoint [ point_id ] [ E_PASSPOINT_POS_Y ], Passpoint [ point_id ] [ E_PASSPOINT_POS_Z ] ) ;
						
						SetVehicleVirtualWorld(vehicleid, Passpoint [ point_id ] [ E_PASSPOINT_WORLD ] ) ;
						LinkVehicleToInterior(vehicleid, Passpoint [ point_id ] [ E_PASSPOINT_INTERIOR ] ) ;

						foreach(new forplayerid: Player) {

							if ( GetPlayerVehicleID(forplayerid) == vehicleid ) {

								SetPlayerVirtualWorld(forplayerid, Passpoint [ point_id ] [ E_PASSPOINT_WORLD ] ) ;
								SetPlayerInterior(forplayerid, Passpoint [ point_id ] [ E_PASSPOINT_INTERIOR ]);
							}
						}
						
						SetPlayerVirtualWorld(playerid, Passpoint [ point_id ] [ E_PASSPOINT_WORLD ] ) ;
						SetPlayerInterior(playerid, Passpoint [ point_id ] [ E_PASSPOINT_INTERIOR ]);
					}
				}
	    	}
	    }

    	return point_id ;
    }

    return INVALID_PASSPOINT_ID ;
}