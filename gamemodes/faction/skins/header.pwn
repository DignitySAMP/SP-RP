enum E_FACTION_SKIN_DATA {

	E_FACTION_SKIN_ID,
	E_FACTION_SKIN_FACTIONID,
	E_FACTION_SKIN_SKINID,
	E_FACTION_SKIN_TIER,
	E_FACTION_SKIN_SQUAD
} ;

#if !defined MAX_FACTION_SKINS
	#define MAX_FACTION_SKINS 75
#endif

#if !defined INVALID_FACTION_SKIN_ID
	#define INVALID_FACTION_SKIN_ID -1
#endif

new FactionSkin [ MAX_FACTIONS ] [ MAX_FACTION_SKINS ] [ E_FACTION_SKIN_DATA ] ;

mBrowser:fskin_list(playerid, response, row, model, name[]) {

	if ( response ) 
	{
		SetPlayerSkinEx(playerid, model);
	}

	return true ;
}

// For using elsewhere
ShowFactionSkinList(playerid, const title[64], const callback[64], squad)
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	ModelBrowser_ClearData(playerid);
	new count = 0, skinid = INVALID_FACTION_SKIN_ID, skinsquad = 0;

	for ( new i, j = MAX_FACTION_SKINS ; i < j ; i ++ ) 
	{
		skinid = FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ];

		if ( skinid != INVALID_FACTION_SKIN_ID && skinid != 0 ) 
		{
			skinsquad = FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SQUAD ];
			
			if (skinsquad && !IsPlayerInFactionSquad(playerid, squad) && Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1)
			{
				// Don't show squad restricted skins
				continue;
			}

			if (squad && squad != skinsquad)
			{
				// Don't show non squad skins
				continue;
			}

			skinid = FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SKINID ];
			ModelBrowser_AddData(playerid, skinid, SOLS_GetCustomSkinName(skinid) ) ;
			count ++;
		}
	}

	ModelBrowser_SetupTiles(playerid, title, callback);
	return true;
}

CMD:fskins(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (!IsPlayerNearArmory(playerid) && !IsPlayerInRangeOfPoint(playerid, 5.0, Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ] ) )
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only do this at your faction spawn or armory!");
	}

	ModelBrowser_ClearData(playerid);
	new skin_name [ 64 ], count = 0, skinid = INVALID_FACTION_SKIN_ID, squad = 0;

	if (!IsPlayerInDutyFaction(playerid) || PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ])
	{
		// faction skins
		for ( new i, j = MAX_FACTION_SKINS ; i < j ; i ++ ) 
		{
			skinid = FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ];

			//printf("Fskin: %d (SQL: %d), (faction: %d)", FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SKINID ], FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ], FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_FACTIONID ]);

			if ( skinid != INVALID_FACTION_SKIN_ID && skinid != 0 ) 
			{
				squad = FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SQUAD ];
				
				if (squad && !IsPlayerInFactionSquad(playerid, squad) && Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1)
				{
					// Don't show squad restricted skins
					continue;
				}

				//printf("Fskin YES: %d (SQL: %d), (faction: %d)", FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SKINID ], FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ], FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_FACTIONID ]);
				skinid = FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SKINID ];
				ModelBrowser_AddData(playerid, skinid, SOLS_GetCustomSkinName(skinid) ) ;
				count ++;
			}
		}

		format(skin_name, 64, "Faction Skins");
	}
	else
	{
		// civ skins
		for ( new i, j = 311 ; i < j ; i ++ ) 
		{
			if ( ! IsValidSkin ( i ) ) {

				continue ;
			}

			switch ( i ) {

				case // story char
				0, 4, 5, 6, 16, 61, 71, 86, 102, 103, 104, 105, 106, 107, 108, 109, 110, 
				114, 115, 116, 149, 155, 163, 164, 167, 173, 174, 175, 205, 208, 264, 265, 266, 267, 268, 269, 
				270, 271, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 
				285, 286, 287, 288, 292, 293, 294, 295, 297, 299, 300, 301, 302, 
				306, 307, 308, 309, 310, 311: {
				continue ;
				}
			}

			if (Character[playerid][E_CHARACTER_ATTRIB_SEX] != E_ATTRIBUTE_SEX_MALE && GetSkinGender(i) == SKIN_GENDER_MALE) continue;
			else if (Character[playerid][E_CHARACTER_ATTRIB_SEX] != E_ATTRIBUTE_SEX_FEMALE && GetSkinGender(i) == SKIN_GENDER_FEMALE) continue;

			GetSkinName(i, skin_name, sizeof ( skin_name ) ) ;
			ModelBrowser_AddData(playerid, i, skin_name ) ;
			count ++;
		}

		format(skin_name, 64, "Civilian Skins (Off Duty)");
	}
	
	if (!count)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "There's no skins to show.");
	}

	ModelBrowser_SetupTiles(playerid, skin_name, "fskin_list" );
	return true ;
}

CMD:uniform(playerid, params[]) {

	return cmd_fskins(playerid, params);
}

CMD:factionskinadd(playerid, params[]) {

	return cmd_fskinadd(playerid, params);
}

CMD:fskinadd(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}
  
	new skinid, tier, squad;

	if ( sscanf ( params, "iiI(0)", skinid, tier, squad ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/fskinadd [skin] [tier] [squad (0)]");
	}

	FactionSkin_Create(playerid, faction_enum_id, skinid, tier, squad);

	return true ;
}


FactionSkin_GetFreeID(factionid) {

	for ( new i; i < MAX_FACTION_SKINS; i ++ ) {

		if ( FactionSkin [ factionid ] [ i ] [ E_FACTION_SKIN_ID ] == INVALID_FACTION_SKIN_ID ) {

			return i ;		
		}
	}

	return INVALID_FACTION_SKIN_ID ;
}
 
FactionSkin_Create(playerid, factionid, skinid, tier, squad) {
	// factionid = enum id

	new index = FactionSkin_GetFreeID ( factionid ) ; 

	if ( index == INVALID_FACTION_SKIN_ID ) {

		SendClientMessage(playerid, COLOR_ERROR, "Invalid faction skin index passed. Are you sure there are free slots?");
		return printf(" * [FACTION SKIN] Tried to create add new skin for faction ID %d but FactionSkin_Create returned -1.", factionid);
	}

	SendClientMessage(playerid, 0xA3A3A3FF, "Inserting faction skin. Wait for blue confirmation message. If it doesn't show up, contact Dignity.");

	FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_FACTIONID ] = Faction [ factionid ] [ E_FACTION_ID ] ;
	FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_SKINID ] = skinid ;
	FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_TIER ] = tier ;
	FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_SQUAD ] = squad ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO faction_skins (faction_skin_factionid, faction_skin_skinid, faction_skin_tier, faction_skin_squad) VALUES (%d, %d, %d, %d)",
		FactionSkin [ factionid ]  [ index ] [ E_FACTION_SKIN_FACTIONID ], FactionSkin [ factionid ]  [ index ] [ E_FACTION_SKIN_SKINID ], FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_TIER ], FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_SQUAD]
	 ) ;

	inline fSkin_OnDatabaseInsert() {

		FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_ID ] = cache_insert_id ();
		SendClientMessage(playerid, COLOR_BLUE, sprintf("Inserted skin id %d (slot %d) for faction ID %d successfully.", 
			FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_SKINID ], index,
			FactionSkin [ factionid ] [ index ] [ E_FACTION_SKIN_FACTIONID ] ) );
		//printf(" * [FACTION] Created faction (%d) with ID %d.",  factionid, Faction [ factionid ] [ E_FACTION_ID ] ) ;
	}

	MySQL_TQueryInline(mysql, using inline fSkin_OnDatabaseInsert, query, "");


	return true ;
}


FactionSkin_LoadEntitiesNew() {

	new loops = 0;

	for ( new f; f < MAX_FACTIONS; f ++ ) {

		for ( new i; i < MAX_FACTION_SKINS ; i ++ ) {

			FactionSkin [f] [ i ] [ E_FACTION_SKIN_ID ] = INVALID_FACTION_SKIN_ID ;
			loops++;
		}

		loops++;
	}

	inline FactionSkin_OnDataLoad() 
	{
		//printf("COUNT of skins for all facs: %d", cache_num_rows());
		new dbid, skinid, factionid, tier, squad;

		new index[MAX_FACTIONS];
		for (new i = 0, r = cache_num_rows(); i < r; ++i)
		{ 
			cache_get_value_name_int(i, "faction_skin_id", dbid );
			cache_get_value_name_int(i, "faction_skin_factionid", factionid );
			cache_get_value_name_int(i, "faction_skin_skinid", skinid );
			cache_get_value_name_int(i, "faction_skin_tier", tier );
			cache_get_value_name_int(i, "faction_skin_squad", squad );

			for ( new f; f < MAX_FACTIONS; f ++ ) 
			{
				if (factionid == Faction[f][E_FACTION_ID])
				{
					FactionSkin [ f ] [ index[f] ] [ E_FACTION_SKIN_ID ] 		= dbid;
					FactionSkin [ f ] [ index[f] ] [ E_FACTION_SKIN_FACTIONID ] 	= factionid;
					FactionSkin [ f ] [ index[f] ] [ E_FACTION_SKIN_SKINID ] 	= skinid;
					FactionSkin [ f ] [ index[f] ] [ E_FACTION_SKIN_TIER ] 		= tier;
					FactionSkin [ f ] [ index[f] ] [ E_FACTION_SKIN_SQUAD ] = squad;
					index[f] ++;
				}

				loops++;
			}
			loops++;
		}

		//printf("The %d loops only took: %d ms", loops, GetTickCount() - tickc);
	}

	MySQL_TQueryInline(mysql, using inline FactionSkin_OnDataLoad, "SELECT * FROM faction_skins", "" ) ;

	return true ;
}


static tickkk;

FactionSkin_LoadEntities(faction_enum_id) {

	printf("FactionSkin_LoadEntities: %d (SQL: %d)", faction_enum_id, Faction[faction_enum_id][E_FACTION_ID]);
	
	if (!tickkk) tickkk = GetTickCount();

	for ( new i; i < MAX_FACTION_SKINS ; i ++ ) {

		FactionSkin [faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ] = INVALID_FACTION_SKIN_ID ;
	}

	inline FactionSkin_OnDataLoad(forfactionid) {

		new rows, fields ;
		cache_get_data ( rows, fields, mysql ) ;

		//printf("COUNT of skins for Fac SQL %d is: %d", forfactionid, rows);

		if ( rows ) {

			for ( new i; i < rows; i ++ ) { 
				if ( rows >= MAX_FACTION_SKINS ) {

					continue ;
				}
				
				FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ] 		= cache_get_field_int (i, "faction_skin_id");
				FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_FACTIONID ] 	= cache_get_field_int (i, "faction_skin_factionid");
				FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SKINID ] 	= cache_get_field_int (i, "faction_skin_skinid");
				FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_TIER ] 		= cache_get_field_int (i, "faction_skin_tier");
				FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SQUAD ] 		= cache_get_field_int (i, "faction_skin_squad");

				//printf("Fskin ADD: %d (SQL: %d), (faction: %d)", FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_SKINID ], FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_ID ], FactionSkin [ faction_enum_id ] [ i ] [ E_FACTION_SKIN_FACTIONID ]);
			}
		}

		if (forfactionid == 29)
		{
			printf("The old way took: %d ms", GetTickCount() - tickkk);
		}
	}

	new query [ 256 ] ;
	mysql_format(mysql, query, sizeof ( query ), "SELECT * FROM faction_skins WHERE faction_skin_factionid = %d", Faction [ faction_enum_id ] [ E_FACTION_ID ] ) ;
	print(query);
	MySQL_TQueryInline(mysql, query, using inline FactionSkin_OnDataLoad) ;



	return true ;
}