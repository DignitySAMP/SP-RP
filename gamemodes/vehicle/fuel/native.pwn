hook OnPlayerEditDynObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float: rx, Float: ry, Float:rz) {
	
	if ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELSTATION ] ) {

		if ( IsValidDynamicObject(PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ]) ) {

			if ( objectid == PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] ) {

				new Float: obj_x, Float: obj_y, Float: obj_z ;
				GetDynamicObjectPos ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ], obj_x, obj_y, obj_z ) ;
				if ( GetPlayerDistanceFromPoint(playerid, x, y, z ) > 7.5 ) {

					PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELSTATION ] = false ;

					DestroyDynamicObject ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] ) ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] = INVALID_OBJECT_ID ;

					PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_TYPE ] = 0 ;

					SendClientMessage ( playerid, -1, "You're too far away from the placeholder object. Resetting state...");
				}

				switch ( response ) {
					case EDIT_RESPONSE_CANCEL  : {

						PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELSTATION ] = false ;

						DestroyDynamicObject ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] ) ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] = INVALID_OBJECT_ID ;

						PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_TYPE ] = 0 ;

						SendClientMessage ( playerid, -1, "You've cancelled the creation of a new pump.");
					}

					case EDIT_RESPONSE_FINAL   : {


						Fuel_OnCreateStation(PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_TYPE ], x, y, z, rx, ry, rz, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

						SendClientMessage(playerid, -1, "Created fuel station at designated location.");

						PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELSTATION ] = false ;

						DestroyDynamicObject ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] ) ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ] = INVALID_OBJECT_ID ;

						PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_TYPE ] = 0 ;

					}

					case EDIT_RESPONSE_UPDATE  : {

						SetDynamicObjectPos ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ], x, y, z ) ;
						SetDynamicObjectRot ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ], rx, ry, rz ) ;
					}
				}
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_EDITING_FUELSTATION ] ) {

		new idx = PlayerVar [ playerid ] [ E_PLAYER_EDITING_FUELSTATION_ID ] ;

		if ( IsValidDynamicObject( FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ] ) ) {

			if ( FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ] == objectid ) {

				new Float: obj_x, Float: obj_y, Float: obj_z ;
				GetDynamicObjectPos ( PlayerVar [ playerid ] [ E_PLAYER_PLACING_FUELST_OBJID ], obj_x, obj_y, obj_z ) ;
				if ( GetPlayerDistanceFromPoint(playerid, x, y, z ) > 7.5 ) {

					PlayerVar [ playerid ] [ E_PLAYER_EDITING_FUELSTATION ] = false ;

					SetDynamicObjectPos(FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ],
						 FuelPump [ idx ] [ E_FUEL_PUMP_POS_X ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_Y ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_Z ]);

					SetDynamicObjectRot(FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ],
						 FuelPump [ idx ] [ E_FUEL_PUMP_POS_RX ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_RY ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_RZ ]);

					SendClientMessage ( playerid, -1, "You're too far away from the placeholder object. Resetting state...");
				}

				switch ( response ) {
					case EDIT_RESPONSE_CANCEL  : {

						SetDynamicObjectPos(FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ],
							 FuelPump [ idx ] [ E_FUEL_PUMP_POS_X ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_Y ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_Z ]);

						SetDynamicObjectRot(FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ],
							 FuelPump [ idx ] [ E_FUEL_PUMP_POS_RX ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_RY ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_RZ ]);

						SendClientMessage ( playerid, -1, sprintf("You've cancelled the editing of pump SQL ID %d.", FuelPump [ idx ] [ E_FUEL_PUMP_ID ] ));
					}

					case EDIT_RESPONSE_FINAL   : {

						SendClientMessage(playerid, -1, sprintf("You have moved fuel station SQL ID %d.", FuelPump [ idx ] [ E_FUEL_PUMP_ID ]));

						PlayerVar [ playerid ] [ E_PLAYER_EDITING_FUELSTATION ] = false ;

						FuelPump [ idx ] [ E_FUEL_PUMP_POS_X ] = x;
						FuelPump [ idx ] [ E_FUEL_PUMP_POS_Y ] = y ;
						FuelPump [ idx ] [ E_FUEL_PUMP_POS_Z ] = z ;
						FuelPump [ idx ] [ E_FUEL_PUMP_POS_RX ] = rx ;
						FuelPump [ idx ] [ E_FUEL_PUMP_POS_RY ] = ry ;
						FuelPump [ idx ] [ E_FUEL_PUMP_POS_RZ ] = rz ;

						SetDynamicObjectPos(FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ],
							FuelPump [ idx ] [ E_FUEL_PUMP_POS_X ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_Y ],  
							FuelPump [ idx ] [ E_FUEL_PUMP_POS_Z ]
						);

						SetDynamicObjectRot(FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ],
							FuelPump [ idx ] [ E_FUEL_PUMP_POS_RX ],  FuelPump [ idx ] [ E_FUEL_PUMP_POS_RY ],  
							FuelPump [ idx ] [ E_FUEL_PUMP_POS_RZ ]
						);

						new query [ 512 ] ;

						mysql_format(mysql, query, sizeof(query), "UPDATE fuelstation SET fuelstation_pos_x = '%f', fuelstation_pos_y = '%f', fuelstation_pos_z = '%f'\
							fuelstation_pos_rx = '%f', fuelstation_pos_ry = '%f', fuelstation_pos_rz = '%f' WHERE fuelstation_id = %d ", 
								FuelPump [ idx ] [ E_FUEL_PUMP_POS_X ],
								FuelPump [ idx ] [ E_FUEL_PUMP_POS_Y ],
								FuelPump [ idx ] [ E_FUEL_PUMP_POS_Z ],
								FuelPump [ idx ] [ E_FUEL_PUMP_POS_RX ],
								FuelPump [ idx ] [ E_FUEL_PUMP_POS_RY ],
								FuelPump [ idx ] [ E_FUEL_PUMP_POS_RZ ],
								FuelPump [ idx ] [ E_FUEL_PUMP_ID ]
						) ;

						mysql_tquery(mysql, query);
					}

					case EDIT_RESPONSE_UPDATE  : {

						SetDynamicObjectPos ( FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ], x, y, z ) ;
						SetDynamicObjectRot ( FuelPump [ idx ] [ E_FUEL_PUMP_OBJECTID ], rx, ry, rz ) ;
					}
				}
			}
		}

	}
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

	foreach(new fuelid: FuelPump) {

		if ( FuelPump [ fuelid ] [ E_FUEL_PUMP_AREAID ] == areaid ) {

			if ( IsPlayerInAnyVehicle ( playerid ) && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) {
				Fuel_ShowPlayerGUI(playerid, FuelPump [ fuelid ] [ E_FUEL_PUMP_TYPE ] ) ;
				PlayerVar [ playerid ] [ E_PLAYER_NEAR_FUELSTATION ] = true ;
				PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] = false  ;
				//SendClientMessage ( playerid, -1, sprintf("DEV: Entering radius of FuelPump ID %d", fuelid ) ) ;
			}
		}
	}

	#if defined fuelst_OnPlayerEnterDynamicArea
		return fuelst_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif

#define OnPlayerEnterDynamicArea fuelst_OnPlayerEnterDynamicArea
#if defined fuelst_OnPlayerEnterDynamicArea
	forward fuelst_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid);
#endif

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

	foreach(new fuelid: FuelPump) {

		if ( FuelPump [ fuelid ] [ E_FUEL_PUMP_AREAID ] == areaid ) {
			Fuel_HidePlayerGUI(playerid);
			PlayerVar [ playerid ] [ E_PLAYER_NEAR_FUELSTATION ] = false ;
			PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] = false  ;
			PlayerVar [ playerid ] [ E_PLAYER_FUEL_COST ] = 0 ;
			//SendClientMessage ( playerid, -1, sprintf("DEV: Leaving radius of FuelPump ID %d", fuelid ) ) ;
		}
	}
	
	#if defined fuelst_OnPlayerLeaveDynamicArea
		return fuelst_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif

#define OnPlayerLeaveDynamicArea fuelst_OnPlayerLeaveDynamicArea
#if defined fuelst_OnPlayerLeaveDynamicArea
	forward fuelst_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid);
#endif


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	
	if ( IsPlayerInAnyVehicle ( playerid ) && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) {
		if ( newkeys & KEY_FIRE ) { // KEY_FIRE == KEY_WALK in vehicles (4)

			if ( PlayerVar [ playerid ] [ E_PLAYER_NEAR_FUELSTATION ] ) {

				new fuelid = Fuel_GetNearestPump(playerid, 10.0);
				new vehicleid = GetPlayerVehicleID(playerid);
				new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

				if ( GetEngineStatus(vehicleid) ) {

					return SendClientMessage(playerid, COLOR_ERROR, "Turn your vehicle off before attempting to refuel!");
				}

				if ( fuelid != INVALID_FUEL_STATION_ID ) {

					if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] >= 100 ) {

						Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100 ;
						ShowPlayerInfoMessage(playerid, "Your vehicle is already full of fuel (100 '/.). It's pointless to fill it up further.", 
						 	.height=285.0, .width = 200.0, .showtime = 6000
						);
			
						return true ;
					} 

					if ( ! PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] ) {
						PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] = true ;

						PlayerTextDrawHide ( playerid, fuel_player_gui[playerid][2] );
						PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][3] );

						PlayerTextDrawHide(playerid, fuel_player_gui[playerid][4] ) ;
						PlayerTextDrawHide(playerid, fuel_player_gui[playerid][5] ) ;
						PlayerTextDrawHide(playerid, fuel_player_gui[playerid][6] ) ;

						PlayerTextDrawSetString(playerid, fuel_player_gui[playerid][7], sprintf("%d '/.~n~~g~$0__", Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] ));
						PlayerTextDrawShow(playerid, fuel_player_gui[playerid][7]); // fuel amount

						OnPlayerRefuelCar(playerid);

						Fuel_OnShowPlayerGui_Extra(playerid );
					}

					else if ( PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] ) {
						PlayerVar [ playerid ] [ E_PLAYER_USING_NOZZLE ] = false ;

						PlayerTextDrawShow ( playerid, fuel_player_gui[playerid][2] );
						PlayerTextDrawHide ( playerid, fuel_player_gui[playerid][3] );

						PlayerTextDrawShow(playerid, fuel_player_gui[playerid][4] ) ;
						PlayerTextDrawShow(playerid, fuel_player_gui[playerid][5] ) ;
						PlayerTextDrawShow(playerid, fuel_player_gui[playerid][6] ) ;

						PlayerTextDrawHide(playerid, fuel_player_gui[playerid][7]); // fuel amount

						Fuel_OnHidePlayerGui_Extra(playerid);
					}
				}
			}
		}
	}


	#if defined fuels_OnPlayerKeyStateChange
		return fuels_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange fuels_OnPlayerKeyStateChange
#if defined fuels_OnPlayerKeyStateChange
	forward fuels_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


public OnPlayerConnect(playerid) {
	
	Fuel_OnLoadPlayerGUI(playerid);


	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1778.4531, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1774.3125, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1771.3438, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1767.2891, 14.1406, 0.25);



	#if defined fuel_OnPlayerConnect
		return fuel_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect fuel_OnPlayerConnect
#if defined fuel_OnPlayerConnect
	forward fuel_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason) {
	
	Fuel_DestroyPlayerGUI(playerid);

	#if defined fuel_OnPlayerDisconnect
		return fuel_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect fuel_OnPlayerDisconnect
#if defined fuel_OnPlayerDisconnect
	forward fuel_OnPlayerDisconnect(playerid, reason);
#endif
