
#if !defined INVALID_FACTION_ID
#define INVALID_FACTION_ID	( -1 )
#endif 

#define MAX_FACTIONS 		( 16 )
#define MAX_FACTION_NAME	( 256)
#define MAX_FACTION_ABBREV 	( 5 )

enum E_FACTION_DATA {

	E_FACTION_ID,

	E_FACTION_NAME [ MAX_FACTION_NAME ],
	E_FACTION_ABBREV	[ MAX_FACTION_ABBREV ],
	E_FACTION_CHAT, // 0: disabled, 1: enabled
	E_FACTION_HEXCOLOR, // chat color

	E_FACTION_TYPE,
	E_FACTION_EXTRA, // drugs, guns
	E_FACTION_PERK_CD,

	E_FACTION_CARSLOTS,
	E_FACTION_PLAYERSLOTS,

	E_FACTION_SPAWN_VISIBLE, // is visible to all players

	Float: E_FACTION_SPAWN_X,
	Float: E_FACTION_SPAWN_Y,
	Float: E_FACTION_SPAWN_Z,
	Float: E_FACTION_SPAWN_A,

	E_FACTION_SPAWN_INT,
	E_FACTION_SPAWN_VW,
	E_FACTION_SPAWN_ICON,

	E_FACTION_BANK,
	E_FACTION_VISIBLE,

	E_FACTION_SPAWN_MAPICON,
	E_FACTION_SPAWN_PICKUP,

	E_FACTION_F_ON,

	DynamicText3D: E_FACTION_SPAWN_LABEL
} ;

new Faction [ MAX_FACTIONS ] [ E_FACTION_DATA ] ;

Faction_GetHex ( faction_sql_id ) {

	new factionid = faction_sql_id ;

	if ( ! factionid ) {

		return 0xDEDEDEFF;
		//return -1 ;
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return 0xDEDEDEFF;
		//return false ;
	}

	return Faction [ faction_enum_id ] [ E_FACTION_HEXCOLOR ] ;
}

Faction_GetName ( faction_sql_id, name[], len = sizeof ( name ) ) {

	new factionid = faction_sql_id ;

	if ( factionid ) {

		new faction_enum_id = Faction_GetEnumID(factionid ); 

		if ( faction_enum_id != INVALID_FACTION_ID ) {

			format ( name, len, "%s", Faction [ faction_enum_id ] [ E_FACTION_NAME ] ) ;
		}

		else format ( name, len, "Civilian" ) ;
	}

	else format ( name, len, "Civilian" ) ;
}

Faction_GetTag(faction_sql_id, color=false) {
	new name[64];

	new faction_enum_id = Faction_GetEnumID(faction_sql_id); 
	if (faction_enum_id != INVALID_FACTION_ID) {
		if(color) {
			format (name, sizeof(name), "{%06x}[%s]%s", (Faction[faction_enum_id][E_FACTION_HEXCOLOR] >>> 8), Faction[faction_enum_id][E_FACTION_ABBREV]);
		}
		else format (name, sizeof(name), "[%s]", Faction[faction_enum_id][E_FACTION_ABBREV]);
	}

	return name;
}

Faction_GetFreeID() {

	for ( new i; i < MAX_FACTIONS; i ++ ) {

		if ( Faction [ i ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

			return i ;		
		}
	}

	return true ;
}

Faction_Create(const name [ MAX_FACTION_NAME ], const abbrev [ MAX_FACTION_ABBREV], type, carslots, playerslots) {

	new factionid = Faction_GetFreeID();

	if ( factionid == INVALID_FACTION_ID ) {

		return print(" * [FACTION] Tried to create new faction but Faction_Create returned -1.");
	}

	Faction [ factionid ] [ E_FACTION_NAME ] [ 0 ] = EOS ;
	strcat(Faction [ factionid ] [ E_FACTION_NAME ], name, MAX_FACTION_NAME ) ;

	Faction [ factionid ] [ E_FACTION_ABBREV ] [ 0 ] = EOS ;
	strcat(Faction [ factionid ] [ E_FACTION_ABBREV ], abbrev, MAX_FACTION_ABBREV ) ;

	Faction [ factionid ] [ E_FACTION_TYPE ] = type ;
	Faction [ factionid ] [ E_FACTION_CARSLOTS ] = carslots ;
	Faction [ factionid ] [ E_FACTION_PLAYERSLOTS ] = playerslots ;

	Faction [ factionid ] [ E_FACTION_HEXCOLOR ] = COLOR_FACTION ;

	Faction [ factionid ] [ E_FACTION_F_ON ] = false ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO factions (faction_name, faction_abbrev, faction_hex, faction_type, faction_carslots, faction_playerslots) VALUES ('%e', '%e', %d, %d, %d, %d)",
		Faction [ factionid ] [ E_FACTION_NAME ], Faction [ factionid ] [ E_FACTION_ABBREV ], Faction [ factionid ] [ E_FACTION_HEXCOLOR ], Faction [ factionid ] [ E_FACTION_TYPE ], Faction [ factionid ] [ E_FACTION_CARSLOTS ], Faction [ factionid ] [ E_FACTION_PLAYERSLOTS ]
	 ) ;

	inline Faction_OnDatabaseInsert() {

		Faction [ factionid ] [ E_FACTION_ID ] = cache_insert_id ();
		printf(" * [FACTION] Created faction (%d) with ID %d.", 
			factionid, Faction [ factionid ] [ E_FACTION_ID ] ) ;
	}

	MySQL_TQueryInline(mysql, using inline Faction_OnDatabaseInsert, query, "");


	return true ;
}

Faction_SetupCars()
{
	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) 
	{
		if ( IsValidVehicle ( Vehicle [ i ] [ E_VEHICLE_ID ] ) ) 
		{
			if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION ) 
			{
				Gunrack_Reset(Vehicle[i][E_VEHICLE_ID]);
				SOLS_ResetVehicleSirens(Vehicle[i][E_VEHICLE_ID]);
			}
		}
	}									
}

Faction_LoadEntities() {

	for ( new i, j = sizeof ( Faction ); i < j; i ++ ) {

		Faction [ i ] [ E_FACTION_ID ] = INVALID_FACTION_ID ;
	}

	print(" * [FACTION] Loading all factions...");

	inline Faction_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "faction_id", Faction [ i ] [ E_FACTION_ID ]);
			cache_get_value_name_int(i, "faction_chat", Faction [ i ] [ E_FACTION_CHAT ]);

			//printf("Fac: Loading faction enum ID %d, SQL ID %d", i, Faction [ i ] [ E_FACTION_ID ]);

			cache_get_value_name_int(i, "faction_type", Faction [ i ] [ E_FACTION_TYPE ]);
			cache_get_value_name_int(i, "faction_extra", Faction [ i ] [ E_FACTION_EXTRA ]);

			cache_get_value_name_int(i, "faction_carslots", Faction [ i ] [ E_FACTION_CARSLOTS ]);
			cache_get_value_name_int(i, "faction_playerslots", Faction [ i ] [ E_FACTION_PLAYERSLOTS ]);

			cache_get_value_name ( i, "faction_name", Faction [ i ] [ E_FACTION_NAME ]);
			cache_get_value_name ( i, "faction_abbrev", Faction [ i ] [ E_FACTION_ABBREV ]);
		
			cache_get_value_name_int(i, "faction_spawnvisible", Faction [ i ] [ E_FACTION_SPAWN_VISIBLE ]);

			cache_get_value_name_float(i, "faction_spawn_x", Faction [ i ] [ E_FACTION_SPAWN_X ]);
			cache_get_value_name_float(i, "faction_spawn_y", Faction [ i ] [ E_FACTION_SPAWN_Y ]);
			cache_get_value_name_float(i, "faction_spawn_z", Faction [ i ] [ E_FACTION_SPAWN_Z ]);
			cache_get_value_name_float(i, "faction_spawn_a", Faction [ i ] [ E_FACTION_SPAWN_A ]);

			cache_get_value_name_int(i, "faction_type", Faction [ i ] [ E_FACTION_TYPE ]);
			cache_get_value_name_int(i, "faction_extra", Faction [ i ] [ E_FACTION_EXTRA ]);
			cache_get_value_name_int(i, "faction_perk_cd", Faction [ i ] [ E_FACTION_PERK_CD ]);

			cache_get_value_name_int(i, "faction_hex", Faction [ i ] [ E_FACTION_HEXCOLOR ]);

			if ( ! Faction [ i ] [ E_FACTION_HEXCOLOR ] ) {

				Faction [ i ] [ E_FACTION_HEXCOLOR ] = COLOR_FACTION ;
			}

			cache_get_value_name_int(i, "faction_spawn_int", Faction [ i ] [ E_FACTION_SPAWN_INT ]);
			cache_get_value_name_int(i, "faction_spawn_vw", Faction [ i ] [ E_FACTION_SPAWN_VW ]);

			cache_get_value_name_int(i, "faction_f_on", Faction [ i ] [ E_FACTION_F_ON ]);

			if ( IsValidDynamicMapIcon ( Faction [ i ] [ E_FACTION_SPAWN_MAPICON ] ) ) {
				DestroyDynamicMapIcon(Faction [ i ] [ E_FACTION_SPAWN_MAPICON ]);
			}

			if ( IsValidDynamicPickup(Faction [ i ] [ E_FACTION_SPAWN_PICKUP ] ) ) {
				DestroyDynamicPickup(Faction [ i ] [ E_FACTION_SPAWN_PICKUP ] ) ;
			}

			if ( IsValidDynamic3DTextLabel(Faction [ i ] [ E_FACTION_SPAWN_LABEL ] ) ) {

				DestroyDynamic3DTextLabel(Faction [ i ] [ E_FACTION_SPAWN_LABEL ] ) ;
			}

			if ( Faction [ i ] [ E_FACTION_SPAWN_VISIBLE ] ) {
				new type = Faction [ i ] [ E_FACTION_SPAWN_ICON ] ;

				if ( type == 0 ) {

					type = 19 ;
				}

				Faction [ i ] [ E_FACTION_SPAWN_MAPICON ] = CreateDynamicMapIcon(Faction [ i ] [ E_FACTION_SPAWN_X ], 
					Faction [ i ] [ E_FACTION_SPAWN_Y ], Faction [ i ] [ E_FACTION_SPAWN_Z ], type, 0, 
					Faction [ i ] [ E_FACTION_SPAWN_VW ], Faction [ i ] [ E_FACTION_SPAWN_INT ] );


				Faction [ i ] [ E_FACTION_SPAWN_PICKUP ] = CreateDynamicPickup(1314, 1, Faction [ i ] [ E_FACTION_SPAWN_X ], 
					Faction [ i ] [ E_FACTION_SPAWN_Y ], Faction [ i ] [ E_FACTION_SPAWN_Z ], 
					Faction [ i ] [ E_FACTION_SPAWN_VW ], Faction [ i ] [ E_FACTION_SPAWN_INT ]) ;

				Faction [ i ] [ E_FACTION_SPAWN_LABEL ] = CreateDynamic3DTextLabel(sprintf("[%s]\n{DEDEDE}Faction Spawn", Faction [ i ] [ E_FACTION_NAME ]), 0x22333cFF, 
					Faction [ i ] [ E_FACTION_SPAWN_X ], Faction [ i ] [ E_FACTION_SPAWN_Y ], 
					Faction [ i ] [ E_FACTION_SPAWN_Z ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true, 
					Faction [ i ] [ E_FACTION_SPAWN_VW ], Faction [ i ] [ E_FACTION_SPAWN_INT ]);
			}

			//FactionSkin_LoadEntities(i); // old way
			
			LoadFactionEmmetData(i);
		}

		printf(" * [FACTIONS] Loaded %d factions.", cache_num_rows() ) ;

		print(" * [FACTIONS] Now loading all faction skins...") ;
		FactionSkin_LoadEntitiesNew(); // new way
		Faction_SetupCars();
	}

	MySQL_TQueryInline(mysql, using inline Faction_OnDataLoad, "SELECT * FROM factions", "" ) ;

	return true ;
}

CMD:fextra(playerid, params[]) {

	return cmd_factionextra(playerid, params);
}

CMD:factionextra(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, type ;

	if ( sscanf ( params, "ii", id, type ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action)extra [id] [type]");
		SendClientMessage(playerid, COLOR_YELLOW, "Types: (0: None) (1: Guns) (2: Weed) (3: Crack) (4: Cocaine)" ) ;
		SendClientMessage(playerid, COLOR_BLUE, "For chopshop use /chopshopfaction (advanced+)");
		return true ;
	}

	if ( type < 0 || type > 5 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Type can't be less than 0 or more than 5.");
	}

	if ( Faction [ id ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction does not exist.");	
	}

	Faction [ id ] [ E_FACTION_EXTRA ] = type ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE factions SET faction_extra = '%d' WHERE faction_id = %d",
		Faction [ id ] [ E_FACTION_EXTRA ], Faction [ id ] [ E_FACTION_ID] ) ;
	mysql_tquery ( mysql, query ) ;

	new faction_extra [ ] [ ] = {
		"None", "Gun Factory", "Weed Production", "Crack Production", "Cocaine Production", "Meth Production"
	} ;

	SendClientMessage(playerid, COLOR_INFO, sprintf("Changed faction ID %d (%d)'s extra to \"%s\".",
		id, Faction [ id ] [ E_FACTION_ID], faction_extra [ Faction [ id ] [ E_FACTION_EXTRA ] ] [ 0 ]  )) ;

	Faction_SendMessage(Faction [ id ] [ E_FACTION_ID], sprintf("{ [%s] %s has changed faction extra to \"%s\". }",

		Faction [ id ] [ E_FACTION_ABBREV ], ReturnMixedName(playerid), faction_extra [ Faction [ id ] [ E_FACTION_EXTRA ] ] [ 0 ]
	), id, false ) ;


	return true ;
}

