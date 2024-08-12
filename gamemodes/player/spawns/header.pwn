

enum E_SPAWN_AREA_DATA {

	E_SPAWN_AREA_DESC[64],
	Float: E_SPAWN_AREA_POS_X,
	Float: E_SPAWN_AREA_POS_Y,
	Float: E_SPAWN_AREA_POS_Z,
	Float: E_SPAWN_AREA_ROT_X,
	Float: E_SPAWN_AREA_ROT_Y,
	Float: E_SPAWN_AREA_ROT_Z,

	E_SPAWN_AREA_DESC_EXTRA[64],
} ;

new SpawnArea [ ] [ E_SPAWN_AREA_DATA ] = {
	// Use !"" then unpack accordingly to save MEMORY!!!!!!!!!!!!!!!!!
	// save memory?  what?  a kilobyte??

	{ "Ganton", 			2247.57227, -1738.33264, 13.71335, 0.00000, 0.00000, -90.36004, "{5FBD4E}[GS]" },
	{ "Grove Street", 		2426.63110, -1665.35754, 13.62497, 0.00000, 0.00000, -88.98010, "{5FBD4E}[GS]" },
	{ "Seville", 			2751.99976, -1896.95374, 11.20789, 0.00000, 0.00000, -90.00000, "{99DB8D}[SBF]" },
	{ "Willowfield", 		2420.00854, -1988.86328, 13.73227, 0.00000, 0.00000, 0.00000, "{99DB8D}[SBF]" },
	{ "LSX Airport",		1739.2998,	-2283.7407,	13.70000, 	0.0, 0.0, 0.0, "{5FBD4E}[NA]" },
//	{ "Santa Maria Beach",  723.08417,  -1680.50989, 10.81768, 0.00000, 0.00000, -90.00005, "{58AD7A}[SMF]" },

	{ "Market",  			1194.07104, -1274.47876, 13.60880, 0.00000, 0.00000, 90.00000,  "{C290C6}[TDB]" },
	{ "Jefferson", 			2249.04028, -1214.59973, 24.18258, 0.00000, 0.00000, 90.00000, "{AC518B}[RHB]" },
	{ "Idlewood", 			2105.63867, -1730.84192, 13.71821, 0.00000, 0.00000, -16.62000, "{C55788}[FYB]" },
	{ "Glen Park", 			1976.04736, -1186.98364, 26.24514, 0.00000, 0.00000, 0.00000, "{B051B6}[KTB]" },
	{ "East Los Santos", 	2465.77881, -1510.32947, 24.19006, 0.00000, 0.00000, -89.34006, "{B051B6}[KTB]" },

	//{ "Unity", 				1815.32397, -1868.84314, 13.73769, 0.00000, 0.00000, -180.17995, "{1FA4DE}[VLA]" },
	{ "El Corona", 			1924.63843, -2058.78638, 13.72614, 0.00000, 0.00000, -89.39995, "{1FA4DE}[VLA]" },
	{ "Los Flores",			2662.57617, -1092.85413, 69.57714, 0.00000, 0.00000, -90.00000, "{D6B21A}[LSV]" },
	{ "Las Colinas", 		2156.53955, -1022.62634, 62.61014, 0.00000, 0.00000, 180.71979, "{D6B21A}[LSV]" },
	{ "Pig Pen", 			2437.00684, -1250.25916, 23.97318, 0.00000, 0.00000, 92.03995, "{D6B21A}[LSV]" }
} ;

#define COLOUR_BUS	0xC0CD82FF

public OnGameModeInit() {

	for(new i, j = sizeof ( SpawnArea ); i < j ; i ++ ) {

		CreateDynamicObject(1257, SpawnArea [ i ] [ E_SPAWN_AREA_POS_X ], SpawnArea [ i ] [ E_SPAWN_AREA_POS_Y ], 
			SpawnArea [ i ] [ E_SPAWN_AREA_POS_Z ], SpawnArea [ i ] [ E_SPAWN_AREA_ROT_X ], SpawnArea [ i ] [ E_SPAWN_AREA_ROT_Y ],
		    SpawnArea [ i ] [ E_SPAWN_AREA_ROT_Z ] 
		);

		CreateDynamic3DTextLabel(sprintf("%s Bus Stop\n{DEDEDE}Use /bus to travel.",SpawnArea [ i ] [ E_SPAWN_AREA_DESC ]), COLOUR_BUS, SpawnArea [ i ] [ E_SPAWN_AREA_POS_X ], 
			SpawnArea [ i ] [ E_SPAWN_AREA_POS_Y ], SpawnArea [ i ] [ E_SPAWN_AREA_POS_Z ], 15.0);
	}

	#if defined skin_OnGameModeInit
		return skin_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit skin_OnGameModeInit
#if defined skin_OnGameModeInit
	forward skin_OnGameModeInit();
#endif

#include "player/spawns/func.pwn"

CMD:bus(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] ) {
		if ( Character [ playerid ] [ E_CHARACTER_HOURS ] >= 48 || Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only use this command if you have less than 48 hours. Faction members can't use it.");
		}
	}

	for ( new i, j = sizeof ( SpawnArea ); i < j ; i ++ ) {

		if ( IsPlayerInRangeOfPoint(playerid, 5, SpawnArea [ i ] [ E_SPAWN_AREA_POS_X ], SpawnArea [ i ] [ E_SPAWN_AREA_POS_Y ], 
			SpawnArea [ i ] [ E_SPAWN_AREA_POS_Z ] ) ) {

			Player_LastSpawnPage [ playerid ] = 1 ;
			SpawnArea_SelectionEx(playerid)  ;
		}

		else continue ;
	}

	return true ;
}

CMD:respawnplayer(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < 1 && Account[playerid][E_PLAYER_ACCOUNT_SUPPORTER] < 2 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new targetid;
	if ( sscanf ( params, "k<player>", targetid ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/respawnplayer [player]");
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerLogged(playerid)) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't connected.");
	//Spawn_Newbie(targetid);

	Player_DisplaySpawnList(targetid, true);
	new string [ 128 ] ;

	format(string, sizeof(string), "showed the spawn selection options to (%d) %s", targetid, ReturnMixedName(targetid));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	format ( string, sizeof ( string ), "(%d) %s has shown you the spawn selection screen.", playerid, ReturnMixedName(playerid)) ;
	SendClientMessage(targetid, -1, string );

	return true;
}

CMD:rpl(playerid, params[])
{
	return cmd_respawnplayer(playerid, params);
}

SpawnArea_SelectionEx(playerid) {

	new MAX_ITEMS_ON_PAGE = 10, string [ 512 ], bool: nextpage ;

    new pages = floatround ( sizeof ( SpawnArea ) / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1, 
    	resultcount = ( ( MAX_ITEMS_ON_PAGE * Player_LastSpawnPage [ playerid ] ) - MAX_ITEMS_ON_PAGE ) ;

    strcat(string, "Area Name\n");

    for ( new i = resultcount; i < sizeof(SpawnArea); i ++ ) {

		resultcount ++ ;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * Player_LastSpawnPage [ playerid ] ) {

			//format(string, sizeof(string), "%s\t%s{dedede}%s\n", string, SpawnArea [ i ] [ E_SPAWN_AREA_DESC_EXTRA ], SpawnArea [ i ] [ E_SPAWN_AREA_DESC ]); 
 			format(string, sizeof(string), "%s\t%s\n", string, SpawnArea [ i ] [ E_SPAWN_AREA_DESC ]); 
        }

     	if ( resultcount > MAX_ITEMS_ON_PAGE * Player_LastSpawnPage [ playerid ] ) {

            nextpage = true;
            break;
        }
	}

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline CenterList(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if ( ! response ) {

			if ( Player_LastSpawnPage [ playerid ] > 1 ) {

				Player_LastSpawnPage [ playerid ] -- ;
				return SpawnArea_SelectionEx(playerid) ;
			}
		}

		else if ( response ) {

			if ( listitem == MAX_ITEMS_ON_PAGE) {

				Player_LastSpawnPage [ playerid ] ++ ;
				return SpawnArea_SelectionEx ( playerid ) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {

				new selection = ( ( MAX_ITEMS_ON_PAGE * Player_LastSpawnPage [ playerid ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

 				PlayerPlaySound ( playerid, 1085, 0.0, 0.0, 0.0 ) ;

 				string[0]=EOS;
				format ( string, sizeof ( string ), "has taken the bus to %s. ", SpawnArea [ selection ] [ E_SPAWN_AREA_DESC ] ) ;
				ProxDetectorEx(playerid,15.0, COLOR_ACTION, "*", string, .showid = false);

 				//SendClientMessage(playerid, -1, sprintf("You've spawning in %s - %s territory!", SpawnArea [ selection ] [ E_SPAWN_AREA_DESC ], SpawnArea [ selection ] [ E_SPAWN_AREA_DESC_EXTRA ] ) ) ;
				//SendClientMessage(playerid, -1, sprintf("You've spawned in %s.", SpawnArea [ selection ] [ E_SPAWN_AREA_DESC ] ) ) ;
				//SetPlayerPos(playerid, SpawnArea [ selection ] [ E_SPAWN_AREA_POS_X ], SpawnArea [ selection ] [ E_SPAWN_AREA_POS_Y ], SpawnArea [ selection ] [ E_SPAWN_AREA_POS_Z ] );
				
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SOLS_SetPosWithFade(playerid, SpawnArea [ selection ] [ E_SPAWN_AREA_POS_X ], SpawnArea [ selection ] [ E_SPAWN_AREA_POS_Y ], SpawnArea [ selection ] [ E_SPAWN_AREA_POS_Z ]);
 				SetCameraBehindPlayer(playerid);
				PlayerVar[playerid][E_PLAYER_SPAWNED_CHARACTER] = true;

 				return true ;
			}
		}
	}
	if ( Player_LastSpawnPage [ playerid ] > 1 ) {
   		Dialog_ShowCallback ( playerid, using inline CenterList, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Bus Stop: Page %d of %d", Player_LastSpawnPage [ playerid ], pages), string, "Travel", "Previous" );
   	}

	else Dialog_ShowCallback ( playerid, using inline CenterList, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Bus Stop: Page %d of %d", Player_LastSpawnPage [ playerid ], pages), string, "Travel", "Close" );

    return true ;
}