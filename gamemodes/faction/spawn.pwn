enum E_FACTION_ICON_DATA {

	E_FAC_ICON_ID,
	E_FAC_ICON_DESC [ 64 ] 
} ;

new FactionMapIcons [ ] [ E_FACTION_ICON_DATA ] = {

	{ 58, "Cyan Ped" },
	{ 59, "Purple Ped" },
	{ 60, "Yellow Ped" },
	{ 61, "Blue Ped" },
	{ 62, "Green Ped" },
	{ 43, "Mafia Red" },
	{ 44, "Mafia Yellow" },
	{ 20, "Red HQ" },
	{ 30, "Blue HQ" },
	{ 23, "Blue Skull" },
	{ 25, "Dice" },
	{ 26, "MC (OG LOC)" }

} ;

CMD:fspawn(playerid, params[]) {
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

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	if ( GetPlayerCash(playerid) < 25000 && GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You need atleast $25,000 in cash to do this.");
	}

	if ( IsValidDynamicMapIcon ( Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] ) ) {
		DestroyDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ]);
	}

	if ( IsValidDynamicPickup(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] ) ) {
		DestroyDynamicPickup(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] ) ;
	}

	if ( IsValidDynamic3DTextLabel(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] ) ) {

		DestroyDynamic3DTextLabel(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] ) ;
	}
	
	new type = Faction [ faction_enum_id ] [ E_FACTION_SPAWN_ICON ] ;

	if ( type == 0 ) {

		type = 19 ;
	}

	new Float: x, Float: y, Float: z, Float: a ;
	GetPlayerPos(playerid, x, y, z );
	GetPlayerFacingAngle(playerid, a);	

	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ] = x ;
	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ] = y ;
	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ] = z ;
	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_A ] = a ;

	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ] = GetPlayerInterior(playerid) ;
	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ] = GetPlayerVirtualWorld(playerid) ;


	new string [ 1024 ] ;

	mysql_format(mysql, string, sizeof ( string ), "UPDATE factions SET faction_spawn_x = '%f', faction_spawn_y = '%f', faction_spawn_z = '%f', faction_spawn_a = '%f', faction_spawn_int = %d, faction_spawn_vw = %d WHERE faction_id = %d",
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ],
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ],
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ],
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_A ],
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ],
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ],
		Faction [ faction_enum_id ] [ E_FACTION_ID ] );

	mysql_tquery(mysql, string );

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has changed the faction's spawn location. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName(playerid)
	), faction_enum_id, false ) ;

	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] = CreateDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], type, 0, 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ] );


	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] = CreateDynamicPickup(1314, 1, Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ]) ;

	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] = CreateDynamic3DTextLabel(sprintf("[%s]\n{DEDEDE}Faction Spawn", Faction [ faction_enum_id ] [ E_FACTION_NAME ]), 0x22333cFF, 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true, 
		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ]);


	if ( GetPlayerAdminLevel(playerid) >= ADMIN_LVL_JUNIOR && PlayerVar [ playerid ] [ E_PLAYER_ADMIN_DUTY ]) {
		SendServerMessage ( playerid, COLOR_ERROR, "Admin", "A3A3A3", "You're on duty as an admin, so you weren't charged for this spawn move." ) ;
	} else {
		TakePlayerCash(playerid, 25000);
	}

	SendAdminMessage ( sprintf("[!!!] [AdmWarn] (%d) %s has changed the %s's spawn location. }",
		playerid, Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName(playerid)
	) ) ;

	return true ;
}

CMD:fspawnicon(playerid, params[]) {

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

	new string [ 1024 ] ;

	strcat(string, "Icon ID \t Icon Description\n") ;

	inline FactionMapIconList(pid, dialogid, response, listitem, string:inputtext[] ) { 
		#pragma unused pid, dialogid, response, listitem, inputtext

		if ( response ) {

			Faction_SendMessage(factionid, sprintf("{ [%s] %s has changed into faction's map icon to (%d) %s. }",

				Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName(playerid), FactionMapIcons [ listitem ] [ E_FAC_ICON_ID], FactionMapIcons [ listitem ] [ E_FAC_ICON_DESC ]
			), faction_enum_id, false ) ;


			Faction [ faction_enum_id ] [ E_FACTION_SPAWN_ICON ] = FactionMapIcons [ listitem ] [ E_FAC_ICON_ID] ;


			if ( IsValidDynamicMapIcon ( Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] ) ) {
				DestroyDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ]);
			}

			Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] = CreateDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], FactionMapIcons [ listitem ] [ E_FAC_ICON_ID] , 0, 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ]
			);


			string [ 0 ] = EOS ;

			mysql_format(mysql, string, sizeof ( string ), "UPDATE factions SET faction_spawn_icon = %d WHERE faction_id = %d",
				FactionMapIcons [ listitem ] [ E_FAC_ICON_ID], Faction [ faction_enum_id ] [ E_FACTION_ID ] );

			mysql_tquery(mysql, string );
		}

	}

	for ( new i, j = sizeof ( FactionMapIcons ); i < j ; i ++ ) {

		format ( string, sizeof ( string ), "%s%d \t %s\n", string, FactionMapIcons [ i ] [ E_FAC_ICON_ID], FactionMapIcons [ i ] [ E_FAC_ICON_DESC ]) ;
	}


	Dialog_ShowCallback ( playerid, using inline FactionMapIconList, DIALOG_STYLE_TABLIST_HEADERS, "Map Icon Selection", string, "Select", "Cancel" ) ;


	return true ;
}

CMD:fspawntog(playerid, params[]) {
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

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VISIBLE ] = ! Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VISIBLE ] ;

	switch ( Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VISIBLE ] ) {

		case true: {


			Faction_SendMessage(factionid, sprintf("{ [%s] %s has made the faction spawn public. }",

				Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid )
			), faction_enum_id, false ) ;


			if ( IsValidDynamicMapIcon ( Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] ) ) {
				DestroyDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ]);
			}

			if ( IsValidDynamicPickup(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] ) ) {
				DestroyDynamicPickup(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] ) ;
			}

			if ( IsValidDynamic3DTextLabel(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] ) ) {

				DestroyDynamic3DTextLabel(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] ) ;
			}

			new type = Faction [ faction_enum_id ] [ E_FACTION_SPAWN_ICON ] ;

			if ( type == 0 ) {

				type = 19 ;
			}

			Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] = CreateDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], type, 0, 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ] );


			Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] = CreateDynamicPickup(1314, 1, Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ]) ;

			Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] = CreateDynamic3DTextLabel(sprintf("[%s]\n{DEDEDE}Faction Spawn", Faction [ faction_enum_id ] [ E_FACTION_NAME ]), 0x22333cFF, 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_X ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Y ], 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_Z ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true, 
				Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VW ], Faction [ faction_enum_id ] [ E_FACTION_SPAWN_INT ]);
		}

		case false: {

			Faction_SendMessage(factionid, sprintf("{ [%s] %s has hidden the faction spawn. }",

				Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid )
			), faction_enum_id, false ) ;

			if ( IsValidDynamicMapIcon ( Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ] ) ) {
				DestroyDynamicMapIcon(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_MAPICON ]);
			}

			if ( IsValidDynamicPickup(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] ) ) {
				DestroyDynamicPickup(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_PICKUP ] ) ;
			}

			if ( IsValidDynamic3DTextLabel(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] ) ) {

				DestroyDynamic3DTextLabel(Faction [ faction_enum_id ] [ E_FACTION_SPAWN_LABEL ] ) ;
			}
		}
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE factions SET faction_spawnvisible=%d WHERE faction_id = %d",

		Faction [ faction_enum_id ] [ E_FACTION_SPAWN_VISIBLE ], Faction [ faction_enum_id ] [ E_FACTION_ID ] );

	mysql_tquery(mysql, query );
	
	return true ;
}