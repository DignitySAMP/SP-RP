
#define INVALID_EMMET_ID    (-1)
#define MAX_EMMET_NPCS  (12)

enum E_EMMET_POINTS {

    E_EMMET_SQLID,
    E_EMMET_NAME[32],
    Float:E_EMMET_POS_X,
    Float:E_EMMET_POS_Y,
    Float:E_EMMET_POS_Z,
    Float:E_EMMET_POS_A,
    E_EMMET_SKIN,
    E_EMMET_OWNEDBY,

    //misc
    E_EMMET_ACTOR,
    DynamicText3D: E_EMMET_LABEL
};
new Emmet[MAX_EMMET_NPCS][E_EMMET_POINTS];

enum E_EMMET_FACTION_DATA {

    E_EMMET_FACTION_SQLID,
    E_EMMET_FACTION_FID, // faction_id
    E_EMMET_FACTION_INDEX, // emmet id (assigned, only able to buy from here)
    E_EMMET_COLT45_STOCK,
    E_EMMET_COLT45_UNIX,
    E_EMMET_UZI_STOCK, // stock -1 = not for sale
    E_EMMET_UZI_UNIX,
    E_EMMET_TEC_STOCK,
    E_EMMET_TEC_UNIX,
    E_EMMET_AK47_STOCK,
    E_EMMET_AK47_UNIX,
    E_EMMET_SHOTGUN_STOCK,
    E_EMMET_SHOTGUN_UNIX
};
new EmmetFaction[MAX_FACTIONS][MAX_EMMET_NPCS][E_EMMET_FACTION_DATA];

Emmet_LoadEntities() {

	print(" * [EMMET] Loading all data...");

	for ( new i, j = MAX_EMMET_NPCS; i < j ; i ++ ) {
		Emmet [ i ] [ E_EMMET_SQLID ] = INVALID_EMMET_ID ;
	}

	inline Emmet_OnDataLoad() {
        for ( new i = 0, r = cache_num_rows(); i < r; ++i) {
            cache_get_value_name_int (i, "emmet_sqlid", Emmet [ i ] [ E_EMMET_SQLID ]);
            cache_get_value_name(i, "emmet_name", Emmet [ i ] [ E_EMMET_NAME ]);

            cache_get_value_name_float ( i, "emmet_pos_x", Emmet [ i ] [ E_EMMET_POS_X ]);
            cache_get_value_name_float ( i, "emmet_pos_y", Emmet [ i ] [ E_EMMET_POS_Y ]);
            cache_get_value_name_float ( i, "emmet_pos_z", Emmet [ i ] [ E_EMMET_POS_Z ]);
            cache_get_value_name_float ( i, "emmet_pos_a", Emmet [ i ] [ E_EMMET_POS_A ]);

            cache_get_value_name_int (i, "emmet_skin", Emmet [ i ] [ E_EMMET_SKIN ]);
            cache_get_value_name_int (i, "emmet_ownedby", Emmet [ i ] [ E_EMMET_OWNEDBY ]);
            Emmet_LoadVisuals(i);
        }

        printf(" * [EMMET] Loaded %d NPC gun dealers.", cache_num_rows() ) ;
	}

	MySQL_TQueryInline(mysql, using inline Emmet_OnDataLoad, "SELECT * FROM emmet");

	return true ;
}

LoadFactionEmmetData(faction_enum_id) {

    for(new i; i < MAX_FACTIONS; i ++) {
		EmmetFaction[i][faction_enum_id][E_EMMET_FACTION_SQLID] = INVALID_EMMET_ID ;
	}

	inline EmmetFaction_OnDataLoad() {
        for ( new i = 0, r = cache_num_rows(); i < r; ++i) {
            cache_get_value_name_int(i, "emmet_faction_sqlid", EmmetFaction[faction_enum_id][i][E_EMMET_FACTION_SQLID]);
            cache_get_value_name_int(i, "emmet_faction_fid", EmmetFaction[faction_enum_id][i][E_EMMET_FACTION_FID]);
            cache_get_value_name_int(i, "emmet_faction_index", EmmetFaction[faction_enum_id][i][E_EMMET_FACTION_INDEX]);

            cache_get_value_name_int(i, "emmet_colt45_stock", EmmetFaction[faction_enum_id][i][E_EMMET_COLT45_STOCK]);
            cache_get_value_name_int(i, "emmet_colt45_unix", EmmetFaction[faction_enum_id][i][E_EMMET_COLT45_UNIX]);

            cache_get_value_name_int(i, "emmet_uzi_stock", EmmetFaction[faction_enum_id][i][E_EMMET_UZI_STOCK]);
            cache_get_value_name_int(i, "emmet_uzi_unix", EmmetFaction[faction_enum_id][i][E_EMMET_UZI_UNIX]);

            cache_get_value_name_int(i, "emmet_tec_stock", EmmetFaction[faction_enum_id][i][E_EMMET_TEC_STOCK]);
            cache_get_value_name_int(i, "emmet_tec_unix", EmmetFaction[faction_enum_id][i][E_EMMET_TEC_UNIX]);

            cache_get_value_name_int(i, "emmet_ak47_stock", EmmetFaction[faction_enum_id][i][E_EMMET_AK47_STOCK]);
            cache_get_value_name_int(i, "emmet_ak47_unix", EmmetFaction[faction_enum_id][i][E_EMMET_AK47_UNIX]);

            cache_get_value_name_int(i, "emmet_shotgun_stock", EmmetFaction[faction_enum_id][i][E_EMMET_SHOTGUN_STOCK]);
            cache_get_value_name_int(i, "emmet_shotgun_unix", EmmetFaction[faction_enum_id][i][E_EMMET_SHOTGUN_UNIX]);
        }

		//printf(" * [EMMET FACTIONS] Loaded %d gun dealers' data for %s", rows, Faction[faction_enum_id][E_FACTION_ABBREV] ) ;
	}

	MySQL_TQueryInline(mysql, using inline EmmetFaction_OnDataLoad, "SELECT * FROM emmet_factions WHERE emmet_faction_fid = %i", Faction[faction_enum_id][E_FACTION_ID]);
}
Emmet_Create(playerid, name[], skin) {
    new index = Emmet_GetFreeID();

	if ( index == INVALID_EMMET_ID ) {
		return SendClientMessage(playerid, COLOR_ERROR, "Can't create attach point - limit reached!" ) ;
	}
    if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0) {
        return SendClientMessage(playerid, COLOR_ERROR, "You can only do this in interior or virtual world 0.");
    }

    new Float: x, Float: y, Float: z, Float: a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    format(Emmet [ index ] [ E_EMMET_NAME ], 32, "%s", name);
    Emmet [ index ] [ E_EMMET_POS_X ] = x;
    Emmet [ index ] [ E_EMMET_POS_Y ] = y;
    Emmet [ index ] [ E_EMMET_POS_Z ] = z;
    Emmet [ index ] [ E_EMMET_POS_A ] = a;
    Emmet [ index ] [ E_EMMET_SKIN ] = skin;
    Emmet [ index ] [ E_EMMET_OWNEDBY ] = -1;

    new query [ 512 ] ;
	mysql_format ( mysql, query, sizeof ( query ), 
		"INSERT INTO `emmet`(`emmet_name`, `emmet_pos_x`, `emmet_pos_y`, `emmet_pos_z`, `emmet_pos_a`, `emmet_skin`, `emmet_ownedby`) VALUES ('%e', '%f', '%f', '%f', '%f', %d, %d)",
	    Emmet [ index ] [ E_EMMET_NAME ],
	    Emmet [ index ] [ E_EMMET_POS_X ], Emmet [ index ] [ E_EMMET_POS_Y ], Emmet [ index ] [ E_EMMET_POS_Z ], Emmet [ index ] [ E_EMMET_POS_A ],
	    Emmet [ index ] [ E_EMMET_SKIN ] , Emmet [ index ] [ E_EMMET_OWNEDBY ]
	) ;

	inline Emmet_OnDBInsert() {
	    Emmet [ index ] [ E_EMMET_SQLID ] = cache_insert_id ();
		printf(" * [EMMET] Created new Emmet dealer (%d) with ID %d.", index,  Emmet [ index ] [ E_EMMET_SQLID ]) ;
        SendClientMessage(playerid, COLOR_YELLOW, "Created an NPC gun dealer at your location. Make sure to /emmetassign to give factions access!");
        Emmet_LoadVisuals(index);
        Emmet_SetupFactionTables(index);
	}
	MySQL_TQueryInline(mysql, using inline Emmet_OnDBInsert, query, "");

    return index;
}

Emmet_SetupFactionTables(index) {
    // default values for stock/unix are -1 (all locked by default, need to be enabled by admins)
    new query [ 512 ] ;
    for(new i; i < MAX_FACTIONS; i ++) {
        
        EmmetFaction[i][index][E_EMMET_FACTION_SQLID] = -1;
        EmmetFaction[i][index][E_EMMET_FACTION_FID] = -1;
        EmmetFaction[i][index][E_EMMET_FACTION_INDEX] = -1;
        EmmetFaction[i][index][E_EMMET_COLT45_STOCK] = -1;
        EmmetFaction[i][index][E_EMMET_COLT45_UNIX] = -1;
        EmmetFaction[i][index][E_EMMET_UZI_STOCK] = -1;
        EmmetFaction[i][index][E_EMMET_UZI_UNIX] = -1;
        EmmetFaction[i][index][E_EMMET_TEC_STOCK] = -1;
        EmmetFaction[i][index][E_EMMET_TEC_UNIX] = -1;
        EmmetFaction[i][index][E_EMMET_AK47_STOCK] = -1;
        EmmetFaction[i][index][E_EMMET_AK47_UNIX] = -1;
        EmmetFaction[i][index][E_EMMET_SHOTGUN_STOCK] = -1;
        EmmetFaction[i][index][E_EMMET_SHOTGUN_UNIX] = -1;
        mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO `emmet_factions`( `emmet_faction_fid`, `emmet_faction_index`) VALUES (%d, %d)", i, Emmet [ index ] [ E_EMMET_SQLID ]) ;
        mysql_tquery(mysql, query);      
    }
}

Emmet_TriggerAnims(index) {

    switch(random(4)) {
        case 0: ApplyDynamicActorAnimation(Emmet[index][E_EMMET_ACTOR], "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 0);
        case 1: ApplyDynamicActorAnimation(Emmet[index][E_EMMET_ACTOR], "DEALER", "DEALER_IDLE_01", 4.1, 0, 1, 1, 1, 0);
        case 2: ApplyDynamicActorAnimation(Emmet[index][E_EMMET_ACTOR], "DEALER", "DEALER_IDLE_02", 4.1, 0, 1, 1, 1, 0);
        case 3: ApplyDynamicActorAnimation(Emmet[index][E_EMMET_ACTOR], "DEALER", "DEALER_IDLE_03", 4.1, 0, 1, 1, 1, 0);
    }
}

Emmet_LoadVisuals(index) {

    if(IsValidDynamicActor(Emmet[index][E_EMMET_ACTOR])) {
        DestroyDynamicActor(Emmet[index][E_EMMET_ACTOR]);
        Emmet[index][E_EMMET_ACTOR] = INVALID_STREAMER_ID;
    }

    Emmet[index][E_EMMET_ACTOR] = CreateDynamicActor(Emmet[index][E_EMMET_SKIN], Emmet [ index ] [ E_EMMET_POS_X ], Emmet [ index ] [ E_EMMET_POS_Y ], Emmet [ index ] [ E_EMMET_POS_Z ], Emmet [ index ] [ E_EMMET_POS_A ], true, 250, 0, 0, -1);
    Emmet_TriggerAnims(index);
    
    new Float: temp_a = Emmet [ index ] [ E_EMMET_POS_A ], Float: temp_x = Emmet [ index ] [ E_EMMET_POS_X ], Float: temp_y = Emmet [ index ] [ E_EMMET_POS_Y ];
    GetXYInFrontOfPoint(temp_a, temp_x, temp_y, 1.25);

    if(IsValidDynamic3DTextLabel(Emmet[index][E_EMMET_LABEL])) {
        DestroyDynamic3DTextLabel(Emmet[index][E_EMMET_LABEL]);
        Emmet[index][E_EMMET_LABEL] = DynamicText3D:INVALID_STREAMER_ID;
    }
    Emmet[index][E_EMMET_LABEL] = CreateDynamic3DTextLabel(sprintf("[%s]{DEDEDE}\nAvailable Commands: /buygun", Emmet[index][E_EMMET_NAME]), COLOR_EMMET, temp_x, temp_y, Emmet [ index ] [ E_EMMET_POS_Z ], 3.5, .testlos = false);
}

Emmet_GetFreeID() {

	for ( new i, j = MAX_EMMET_NPCS; i < j ; i ++ ) {
		if ( Emmet [ i ] [ E_EMMET_SQLID ] == INVALID_EMMET_ID ) {
			return i ;
		}

		else continue ;
	}
    return INVALID_EMMET_ID;
}

Emmet_GetClosestEntity(playerid, Float: radius = 2.0) {
    new Float: dis = 99999.99, Float: dis2, index = INVALID_EMMET_ID ;

	for ( new x, y = MAX_EMMET_NPCS; x < y; x ++ ) {

		if ( Emmet [ x ] [ E_EMMET_SQLID ] != INVALID_EMMET_ID ) {
			dis2 = GetPlayerDistanceFromPoint(playerid, Emmet [ x ] [ E_EMMET_POS_X ], Emmet [ x ] [ E_EMMET_POS_Y ], Emmet [ x ] [ E_EMMET_POS_Z ]);

			if(dis2 < dis) {
	            dis = dis2;
	            index = x;
			}
		}
	}

	if ( dis <= radius ) return index;
	else index = INVALID_EMMET_ID ;

	return index ;
}


task OnEmmetRefills[5000]() {
    new query[256];
    for(new i; i < MAX_FACTIONS; i ++) {
        for(new j; j < MAX_EMMET_NPCS; j ++) {

            if(EmmetFaction[i][j][E_EMMET_COLT45_STOCK] != -1) {
                if(EmmetFaction[i][j][E_EMMET_COLT45_STOCK] < CalculateEmmetRefillCap(WEAPON_COLT45)) {
                    if(EmmetFaction[i][j][E_EMMET_COLT45_UNIX] < gettime()) {
                        EmmetFaction[i][j][E_EMMET_COLT45_STOCK] ++;
                        EmmetFaction[i][j][E_EMMET_COLT45_UNIX] = CalculateEmmetRefillUnix(WEAPON_COLT45);
                        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_colt45_stock = %i, emmet_colt45_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
                        EmmetFaction[i][j][E_EMMET_COLT45_STOCK], EmmetFaction[i][j][E_EMMET_COLT45_UNIX], Emmet[j][E_EMMET_SQLID], Faction[i][E_FACTION_ID]);
                        mysql_tquery(mysql, query);
                    }
                }
            }
            if(EmmetFaction[i][j][E_EMMET_UZI_STOCK] != -1) {
                if(EmmetFaction[i][j][E_EMMET_UZI_STOCK] < CalculateEmmetRefillCap(WEAPON_UZI)) {
                    if(EmmetFaction[i][j][E_EMMET_UZI_UNIX] < gettime()) {
                        EmmetFaction[i][j][E_EMMET_UZI_STOCK] ++;
                        EmmetFaction[i][j][E_EMMET_UZI_UNIX] = CalculateEmmetRefillUnix(WEAPON_UZI);
                        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_uzi_stock = %i, emmet_uzi_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
                        EmmetFaction[i][j][E_EMMET_UZI_STOCK], EmmetFaction[i][j][E_EMMET_UZI_UNIX], Emmet[j][E_EMMET_SQLID], Faction[i][E_FACTION_ID]);
                        mysql_tquery(mysql, query);
                    }
                }
            }
            if(EmmetFaction[i][j][E_EMMET_TEC_STOCK] != -1) {
                if(EmmetFaction[i][j][E_EMMET_TEC_STOCK] < CalculateEmmetRefillCap(WEAPON_TEC9)) {
                    if(EmmetFaction[i][j][E_EMMET_TEC_UNIX] < gettime()) {
                        EmmetFaction[i][j][E_EMMET_TEC_STOCK] ++;
                        EmmetFaction[i][j][E_EMMET_TEC_UNIX] = CalculateEmmetRefillUnix(WEAPON_TEC9);
                        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_tec_stock = %i, emmet_tec_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
                        EmmetFaction[i][j][E_EMMET_TEC_STOCK], EmmetFaction[i][j][E_EMMET_TEC_UNIX], Emmet[j][E_EMMET_SQLID], Faction[i][E_FACTION_ID]);
                        mysql_tquery(mysql, query);

                    }
                }
            }

            if(EmmetFaction[i][j][E_EMMET_AK47_STOCK] != -1) {
                if(EmmetFaction[i][j][E_EMMET_AK47_STOCK] < CalculateEmmetRefillCap(WEAPON_AK47)) {
                    if(EmmetFaction[i][j][E_EMMET_AK47_UNIX] < gettime()) {
                        EmmetFaction[i][j][E_EMMET_AK47_STOCK] ++;
                        EmmetFaction[i][j][E_EMMET_AK47_UNIX] = CalculateEmmetRefillUnix(WEAPON_AK47);
                        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_ak47_stock = %i, emmet_ak47_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
                        EmmetFaction[i][j][E_EMMET_AK47_STOCK], EmmetFaction[i][j][E_EMMET_AK47_UNIX], Emmet[j][E_EMMET_SQLID], Faction[i][E_FACTION_ID]);
                        mysql_tquery(mysql, query);
                    }
                }
            }            
            if(EmmetFaction[i][j][E_EMMET_SHOTGUN_STOCK] != -1) {
                if(EmmetFaction[i][j][E_EMMET_SHOTGUN_STOCK] < CalculateEmmetRefillCap(WEAPON_SHOTGUN)) {
                    if(EmmetFaction[i][j][E_EMMET_SHOTGUN_UNIX] < gettime()) {
                        EmmetFaction[i][j][E_EMMET_SHOTGUN_STOCK] ++;
                        EmmetFaction[i][j][E_EMMET_SHOTGUN_UNIX] = CalculateEmmetRefillUnix(WEAPON_SHOTGUN);
                        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_shotgun_stock = %i, emmet_shotgun_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
                        EmmetFaction[i][j][E_EMMET_SHOTGUN_STOCK], EmmetFaction[i][j][E_EMMET_SHOTGUN_UNIX], Emmet[j][E_EMMET_SQLID], Faction[i][E_FACTION_ID]);
                        mysql_tquery(mysql, query);
                    }
                }
            }
        }
    }
}