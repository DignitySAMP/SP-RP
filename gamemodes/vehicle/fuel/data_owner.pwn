#if !defined FUEL_STATION_COST
	#define FUEL_STATION_COST	250000
#endif

#if !defined INVALID_FUEL_MANAGER_ID
#define INVALID_FUEL_MANAGER_ID -1
#endif

enum E_FUEL_MANAGER_STATION {

	E_FUEL_STATION_ID,
	E_FUEL_STATION_OWNERID,
	E_FUEL_STATION_INCOME,

	Float: E_FUEL_STATION_POS_X,
	Float: E_FUEL_STATION_POS_Y,
	Float: E_FUEL_STATION_POS_Z,

	E_FUEL_STATION_POS_INT,
	E_FUEL_STATION_POS_VW,

	E_FUEL_STATION_MAPICON,
	E_FUEL_STATION_PICKUP,
	E_FUEL_STATION_AREAID // prompts to press key to access management menu
}

#if !defined MAX_FUEL_MANAGERS
#define MAX_FUEL_MANAGERS	32
#endif

new FuelStation [ MAX_FUEL_MANAGERS ] [ E_FUEL_MANAGER_STATION ] ;
new Iterator:FuelStation<MAX_FUEL_MANAGERS>;


FuelStation_ViewOwnershipMenu(playerid, enum_id) {

	if ( FuelStation [ enum_id ] [ E_FUEL_STATION_OWNERID ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {
		return true ;
	}

	new query [ 256 ] ;

	inline FuelStation_OwnerMenu(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, response, dialogid, listitem, inputtext

		if ( response ) {
			switch ( listitem ) {

				case 0: { // order fuel

					SendClientMessage ( playerid, COLOR_ERROR, "This feature is coming in a future update.");
					FuelStation_ViewOwnershipMenu(playerid, enum_id ) ;

					return true ;
				}
				case 1: { // collect pump earnings

					ShowPlayerInfoMessage(playerid, sprintf("You have collected ~g~$%s income~w~ from your fuel station.", IntegerWithDelimiter(FuelStation [ enum_id ] [ E_FUEL_STATION_INCOME ])), .height=167.5, .width=180, .showtime = 6000);
					FuelStation_ViewOwnershipMenu(playerid, enum_id ) ;

					GivePlayerCash(playerid, FuelStation [ enum_id ] [ E_FUEL_STATION_INCOME ] ) ;		

					mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelmanager SET fuelmanager_income = 0 WHERE fuelmanager_id = %d", FuelStation [ enum_id ] [ E_FUEL_STATION_ID ] ) ;
					mysql_tquery(mysql, query );

					FuelStation [ enum_id ] [ E_FUEL_STATION_INCOME ] = 0 ;
				}
				case 2: { // sell fuel station
					inline FuelStation_SellConfirm(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
					    #pragma unused pidx, dialogidx, listitemx, inputtextx

						if ( ! responsex ) {

							FuelStation_ViewOwnershipMenu(playerid, enum_id);
					    	return true ;
						}

						if ( responsex ) {
							GivePlayerCash(playerid, FUEL_STATION_COST ) ;

							FuelStation [ enum_id ] [ E_FUEL_STATION_OWNERID ] = INVALID_PLAYER_ID ;

							mysql_format(mysql, query, sizeof ( query ), "UPDATE fuelmanager SET fuelmanager_owner = %d WHERE fuelmanager_id = %d", 
								FuelStation [ enum_id ] [ E_FUEL_STATION_OWNERID ], FuelStation [ enum_id ] [ E_FUEL_STATION_ID ] ) ;
							mysql_tquery(mysql, query );
					
							ShowPlayerInfoMessage(playerid, sprintf("You have sold your fuel station for ~r~$%s.", IntegerWithDelimiter(FUEL_STATION_COST)), .height=167.5, .width=180, .showtime = 6000);

							return true ;
						}
					}

					new confirmstring [ 1024 ] ;

					format ( confirmstring, sizeof ( confirmstring ), 

						"{C23030}READ THIS BEFORE PRESSING CONTINUE.{DEDEDE}\n\n\
						You're about to sell your fuel station and lose ownershipfor {C23030}$%s\n\n\
						{C23030}We will not assist you in getting it back once it has been sold.{DEDEDE}\n\n\
						Only press continue if you're certain."

					, IntegerWithDelimiter ( FUEL_STATION_COST )  ) ;

					Dialog_ShowCallback ( playerid, using inline FuelStation_SellConfirm, DIALOG_STYLE_MSGBOX, "{C23030}ANTI DUMBASS WARNING{DEDEDE}", confirmstring, "{C23030}Continue", "No way" );

				}
			}
		}
	}

	Dialog_ShowCallback ( playerid, using inline FuelStation_OwnerMenu, 
		DIALOG_STYLE_LIST, "Fuel Station Management", 
		"Replenish Pumps / Order Fuel\nCollect Pump Earnings\nSell Fuel Station", 
		"Continue", "Back"
	);

	return true ;
}

FuelStation_LoadEntities() {

	for ( new i, j = sizeof ( FuelStation ); i < j ; i ++ ) {
		FuelStation [ i ] [ E_FUEL_STATION_ID ] = INVALID_FUEL_MANAGER_ID ;
	}

	print(" * [FUEL MANAGER] Loading all fuel management stations...");

	inline FuelStation_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) { 
			cache_get_value_name_int(i, "fuelmanager_id", FuelStation [ i ] [ E_FUEL_STATION_ID ]);
			cache_get_value_name_int(i, "fuelmanager_owner", FuelStation [ i ] [ E_FUEL_STATION_OWNERID ]);
			cache_get_value_name_int(i, "fuelmanager_income", FuelStation [ i ] [ E_FUEL_STATION_INCOME ]);

			cache_get_value_name_float(i, "fuelmanager_pos_x", FuelStation [ i ] [ E_FUEL_STATION_POS_X ]);
			cache_get_value_name_float(i, "fuelmanager_pos_y", FuelStation [ i ] [ E_FUEL_STATION_POS_Y ]);
			cache_get_value_name_float(i, "fuelmanager_pos_z", FuelStation [ i ] [ E_FUEL_STATION_POS_Z ]);

			cache_get_value_name_int(i, "fuelmanager_pos_int", FuelStation [ i ] [ E_FUEL_STATION_POS_INT ]);
			cache_get_value_name_int(i, "fuelmanager_pos_vw", FuelStation [ i ] [ E_FUEL_STATION_POS_VW ]);

			FuelStation_SetupVisuals(i);
			Iter_Add(FuelStation, i);
		}
		printf(" * [FUEL MANAGER] Loaded %d fuel management stations.", cache_num_rows());
	}

	MySQL_TQueryInline(mysql, using inline FuelStation_OnDataLoad, "SELECT * FROM fuelmanager", "" ) ;

	return true ;
}

FuelStation_OnCreateStation(Float: x, Float: y, Float: z, int, vw) {

	new index = Iter_Free(FuelStation) ;

	FuelStation [ index ] [ E_FUEL_STATION_OWNERID ] = INVALID_PLAYER_ID ;
	FuelStation [ index ] [ E_FUEL_STATION_POS_X ] = x ;
	FuelStation [ index ] [ E_FUEL_STATION_POS_Y ] = y ;
	FuelStation [ index ] [ E_FUEL_STATION_POS_Z ]  = z ;
	FuelStation [ index ] [ E_FUEL_STATION_POS_INT ] = int ;
	FuelStation [ index ] [ E_FUEL_STATION_POS_VW ] = vw ;


	new query [ 1024 ] ;
	mysql_format(mysql, query, sizeof ( query ), 
		"INSERT INTO fuelmanager (fuelmanager_owner, fuelmanager_pos_x,\
		fuelmanager_pos_y, fuelmanager_pos_z, fuelmanager_pos_int, fuelmanager_pos_vw) VALUES\
		(%d, '%f', '%f', '%f', %d, %d)",

		FuelStation [ index ] [ E_FUEL_STATION_OWNERID ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_X ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_Y ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_Z ] ,
		FuelStation [ index ] [ E_FUEL_STATION_POS_INT ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_VW ]
	) ;

	inline FuelStation_OnDBInsert() {

		FuelStation [ index ] [ E_FUEL_STATION_ID ] = cache_insert_id ();
		printf(" * [Fuel Manager] Created Fuel Manager (%d) with ID %d.", 
			index, FuelStation [ index ] [ E_FUEL_STATION_ID ] ) ;

		FuelStation_SetupVisuals(index) ;
		Iter_Add(FuelStation, index);
	}

	MySQL_TQueryInline(mysql, using inline FuelStation_OnDBInsert, query, "");
}

FuelStation_SetupVisuals(index) {

	if ( IsValidDynamicMapIcon ( FuelStation [ index ] [ E_FUEL_STATION_MAPICON ] ) ) {
		DestroyDynamicMapIcon(FuelStation [ index ] [ E_FUEL_STATION_MAPICON ]);
	}

	FuelStation [ index ] [ E_FUEL_STATION_MAPICON ] = CreateDynamicMapIcon(FuelStation [ index ] [ E_FUEL_STATION_POS_X ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_Y ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_Z ], 53, 0, 
		FuelStation [ index ] [ E_FUEL_STATION_POS_VW ], FuelStation [ index ] [ E_FUEL_STATION_POS_INT ] 
	);

	if ( IsValidDynamicPickup ( FuelStation [ index ] [ E_FUEL_STATION_PICKUP ] ) ) {
		DestroyDynamicPickup( FuelStation [ index ] [ E_FUEL_STATION_PICKUP ] ) ;
	}

	FuelStation [ index ] [ E_FUEL_STATION_PICKUP ]  = CreateDynamicPickup(1210, 1, 
		FuelStation [ index ] [ E_FUEL_STATION_POS_X ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_Y ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_Z ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_VW ],
		FuelStation [ index ] [ E_FUEL_STATION_POS_INT ]
	);

	if ( IsValidDynamicArea( FuelStation [ index ] [ E_FUEL_STATION_AREAID ] ) ) {

		DestroyDynamicArea( FuelStation [ index ] [ E_FUEL_STATION_AREAID ] ) ;
	}

	FuelStation [ index ] [ E_FUEL_STATION_AREAID ] = CreateDynamicCircle(FuelStation [ index ] [ E_FUEL_STATION_POS_X ], 
		FuelStation [ index ] [ E_FUEL_STATION_POS_Y ], 2.5, FuelStation [ index ] [ E_FUEL_STATION_POS_VW ], 
		FuelStation [ index ] [ E_FUEL_STATION_POS_INT ]
	);

}


public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {
	
	foreach(new i: FuelStation ) {

		if ( areaid == FuelStation [ i ] [ E_FUEL_STATION_AREAID ] ) {

			if ( FuelStation [ i ] [ E_FUEL_STATION_OWNERID ] != INVALID_PLAYER_ID ) {
				if ( FuelStation [ i ] [ E_FUEL_STATION_OWNERID ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {
					ShowPlayerInfoMessage(playerid, "Press ~k~~GROUP_CONTROL_BWD~ to access the fuel station menu.", .height=167.5, .width=180);
				}

				else if ( FuelStation [ i ] [ E_FUEL_STATION_OWNERID ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {
					ShowPlayerInfoMessage(playerid, "This fuel station is owned by someone else.", .height=167.5, .width=180);
				}
			}

			else {

				ShowPlayerInfoMessage(playerid, sprintf("This fuel station is for sale for $%s. To buy it, press ~k~~CONVERSATION_YES~.", IntegerWithDelimiter(FUEL_STATION_COST)), .height=167.5, .width=180);
			}

			break ;
		}
	}

	#if defined fuelman_OnPlayerEnterDynArea
		return fuelman_OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif

#define OnPlayerEnterDynamicArea fuelman_OnPlayerEnterDynArea
#if defined fuelman_OnPlayerEnterDynArea
	forward fuelman_OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid);
#endif

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

	foreach(new i: FuelStation ) {

		if ( areaid == FuelStation [ i ] [ E_FUEL_STATION_AREAID ] ) {

			HidePlayerInfoMessage(playerid);
		}
	}
	#if defined fuelman_OnPlayerLeaveDynArea
		return fuelman_OnPlayerLeaveDynArea(playerid, STREAMER_TAG_AREA:areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif

#define OnPlayerLeaveDynamicArea fuelman_OnPlayerLeaveDynArea
#if defined fuelman_OnPlayerLeaveDynArea
	forward fuelman_OnPlayerLeaveDynArea(playerid, STREAMER_TAG_AREA:areaid);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	
	new idx = FuelStation_GetClosestEntity(playerid);

	if ( idx != INVALID_FUEL_MANAGER_ID ) {

		if ( FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {
			// Access management menu
			if ( newkeys & KEY_CTRL_BACK ) {

				FuelStation_ViewOwnershipMenu(playerid, idx);
			}	
		}

		// Buy fuel manager (send confirmation dialog)
		else if ( FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] == INVALID_PLAYER_ID ) {
		
			if ( newkeys & KEY_YES ) {

				inline CharityConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
				    #pragma unused pid, dialogid, listitem, inputtext

					if ( ! response ) {

				    	return false ;
					}

					if ( response ) {

						if ( GetPlayerCash ( playerid ) < FUEL_STATION_COST ) {
							ShowPlayerInfoMessage(playerid, sprintf("You don't have enough money to buy the fuel station. You need at least $%s.", IntegerWithDelimiter(FUEL_STATION_COST)), .height=167.5, .width=180, .showtime = 6000);

							return true ;	
						}

						TakePlayerCash(playerid, FUEL_STATION_COST ) ;

						FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ] = Character [ playerid ] [ E_CHARACTER_ID ] ;

						new query [ 256 ] ;

						mysql_format(mysql, query , sizeof ( query ), "UPDATE fuelmanager SET fuelmanager_owner = %d WHERE fuelmanager_id = %d",
							FuelStation [ idx ] [ E_FUEL_STATION_OWNERID ], FuelStation [ idx ] [ E_FUEL_STATION_ID ]
						);

						mysql_tquery(mysql , query);
							
						ShowPlayerInfoMessage(playerid, sprintf("You have bought this fuel station for $%s. To manage it, press ~k~~GROUP_CONTROL_BWD~.", IntegerWithDelimiter(FUEL_STATION_COST)), .height=167.5, .width=180, .showtime = 6000);
						SendClientMessage(playerid, COLOR_YELLOW, "To see your owned fuel stations, use /myfuelstations.");

						return true ;
					}
				}

				new string [ 512 ] ;

				format ( string, sizeof ( string ), "Are you sure you want to buy this fuel station for $%s?\n\
					\n\
					It currently has %d fuel pumps linked to it. You will generate 30'/. of all income generated.",

					IntegerWithDelimiter(FUEL_STATION_COST),
					FuelStation_GetLinkedPumpCount(idx)
				 ) ;

				Dialog_ShowCallback ( playerid, using inline CharityConfirm, DIALOG_STYLE_MSGBOX, "{C23030}ANTI DUMBASS WARNING{DEDEDE}", 
					string, "{C23030}Continue", "No way" );

			}
		}
	}

	#if defined fuelman_OnPlayerKSC
		return fuelman_OnPlayerKSC(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange fuelman_OnPlayerKSC
#if defined fuelman_OnPlayerKSC
	forward fuelman_OnPlayerKSC(playerid, newkeys, oldkeys);
#endif


FuelStation_GetClosestEntity( playerid, Float: radius = 5.0)  {

	new Float: dis = 99999.99, Float: dis2, index = INVALID_FUEL_MANAGER_ID ;

	foreach(new x: FuelStation ) {

		if ( FuelStation [ x ] [ E_FUEL_STATION_ID ] != INVALID_FUEL_MANAGER_ID ) {

			dis2 = GetPlayerDistanceFromPoint(playerid, 
				FuelStation [ x ] [ E_FUEL_STATION_POS_X ], 
				FuelStation [ x ] [ E_FUEL_STATION_POS_Y ], 
				FuelStation [ x ] [ E_FUEL_STATION_POS_Z ]
			);

			if(dis2 < dis && GetPlayerInterior ( playerid ) == FuelStation [ x ] [ E_FUEL_STATION_POS_INT ] 
				&& GetPlayerVirtualWorld ( playerid ) == FuelStation [ x ] [ E_FUEL_STATION_POS_VW ] ) {

	            dis = dis2;
	            index = x;
			}
		}
	}

	if ( dis <= radius ) {

		return index;
	}

	else index = INVALID_FUEL_MANAGER_ID ;

	return index ;
}


FuelStation_LinkSQLIDToEnum(sql_id) {

	foreach(new fuelid: FuelStation) {

		if ( FuelStation [ fuelid ] [ E_FUEL_STATION_ID ] == sql_id ) {
			return fuelid ;
		}

		else continue ;
	}

	return INVALID_FUEL_MANAGER_ID ;
}