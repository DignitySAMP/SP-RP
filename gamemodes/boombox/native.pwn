public OnPlayerStateChange(playerid, newstate, oldstate) {
	

	if ( newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER ) {

		if ( IsPlayerInAnyVehicle(playerid) ) {
			
			SOLS_StopAudioStreamForPlayer(playerid);
			

			new vehicleid = GetPlayerVehicleID ( playerid );
			new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

			if ( strlen ( VehicleVar [veh_enum_id ] [ E_VEHICLE_STATION ] ) >= 3  ) {
				SOLS_PlayAudioStreamForPlayer(playerid, VehicleVar [veh_enum_id ] [ E_VEHICLE_STATION ] ) ;
			}

			else {

				Boombox_SyncForPlayer(playerid);
			}
		}
	}

	else if ( newstate == PLAYER_STATE_ONFOOT ) {

		SOLS_StopAudioStreamForPlayer(playerid);
		Boombox_SyncForPlayer(playerid);

	}

	#if defined boombox_OnPlayerStateChange
		return boombox_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange boombox_OnPlayerStateChange
#if defined boombox_OnPlayerStateChange
	forward boombox_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	

	if ( objectid == PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) {
		if ( IsValidDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ) {

			switch ( response ) {
				case  EDIT_RESPONSE_CANCEL : {

					DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = -1 ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACE_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = INVALID_OBJECT_ID ;
				}

				case EDIT_RESPONSE_FINAL : {

					new bool: found = false ;
					for ( new i, j = sizeof ( Boombox ) ; i < j ; i ++ ) {

						if ( Boombox [ i ] [ E_BOOMBOX_AREAID ] != INVALID_BOOMBOX_ID ) {
							
							if ( IsPointInDynamicArea(Boombox [ i ] [ E_BOOMBOX_AREAID ], x, y, z ) ) {

								SendClientMessage(playerid, COLOR_RED, "This boombox is too close to an existing boombox! Move it further away!" ) ;
								found = true ;
								break ;
							}
							
							else continue ;
						}

						else continue ;
					}

					if ( found ) {
						DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = -1 ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACE_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = INVALID_OBJECT_ID ;

						return false ;
					}

					new boombox_id = PlayerVar [ playerid ] [ E_PLAYER_PLACE_BOOMBOX_ID ] ;

					if ( boombox_id == INVALID_BOOMBOX_ID ) {

						DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = INVALID_OBJECT_ID ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = -1 ;
						PlayerVar [ playerid ] [ E_PLAYER_PLACE_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;
					}

					Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ] = x ;
					Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ] = y ;
					Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ] = z ;

					Boombox [ boombox_id ] [ E_BOOMBOX_ROT_X ] = rx ;
					Boombox [ boombox_id ] [ E_BOOMBOX_ROT_Y ] = ry ;
					Boombox [ boombox_id ] [ E_BOOMBOX_ROT_Z ] = rz ;

					DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = INVALID_OBJECT_ID ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = -1 ;
					PlayerVar [ playerid ] [ E_PLAYER_PLACE_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;

					Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] = CreateDynamicObject(

						Boombox [ boombox_id ] [ E_BOOMBOX_MODELID ] ,

						Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ],
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ],
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ],

						Boombox [ boombox_id ] [ E_BOOMBOX_ROT_X ],
						Boombox [ boombox_id ] [ E_BOOMBOX_ROT_Y ],
						Boombox [ boombox_id ] [ E_BOOMBOX_ROT_Z ],

						Boombox [ boombox_id ] [ E_BOOMBOX_POS_INT ],
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_VW ]
					);

					Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] = CreateDynamic3DTextLabel(sprintf("[%d] [%s's Boombox]{DEDEDE}\nAvailable Commands: /boombox, /setstation, /boomboxlisten", boombox_id, ReturnMixedName(playerid)), 0x866D40FF, 

						Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ],
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ],
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ],
						5.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID, false, 
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_VW ], 
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_INT ]
					);

					Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] = CreateDynamicCircle(
						Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ],
						BOOMBOX_RADIUS, Boombox [ boombox_id ] [ E_BOOMBOX_POS_VW ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_INT ]
					);
				}

				case EDIT_RESPONSE_UPDATE : {

					SetDynamicObjectPos(PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ], x, y, z ) ;
					SetDynamicObjectRot(PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ], rx, ry, rz ) ;
				}
			}
		}
	}

	#if defined boombox_OnPlayerEditDynObj
		return boombox_OnPlayerEditDynObj(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEditDynamicObject
	#undef OnPlayerEditDynamicObject
#else
	#define _ALS_OnPlayerEditDynamicObject
#endif

#define OnPlayerEditDynamicObject boombox_OnPlayerEditDynObj
#if defined boombox_OnPlayerEditDynObj
	forward boombox_OnPlayerEditDynObj(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
#endif

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {
	
	if ( ! IsPlayerInAnyVehicle(playerid)) {
		for ( new i, j = sizeof ( Boombox ); i < j ; i ++ ) {

			if ( Boombox [ i ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

				if ( Boombox [ i ] [ E_BOOMBOX_AREAID ] == areaid ) {

					if ( strlen ( Boombox [ i ] [ E_BOOMBOX_STATION ] ) >= 3  ) {

						SOLS_PlayAudioStreamForPlayer(playerid, Boombox [ i ] [ E_BOOMBOX_STATION ], 
							Boombox [ i ] [ E_BOOMBOX_POS_X ], Boombox [ i ] [ E_BOOMBOX_POS_Y ], 
							Boombox [ i ] [ E_BOOMBOX_POS_Z ], BOOMBOX_RADIUS, true 
						) ; 
					}

				}

				else continue ;
			}

			else continue ;
		}
	}

	#if defined boombox_OnPlayerEnterDynArea
		return boombox_OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif

#define OnPlayerEnterDynamicArea boombox_OnPlayerEnterDynArea
#if defined boombox_OnPlayerEnterDynArea
	forward boombox_OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid);
#endif


public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid) {

	if ( ! IsPlayerInAnyVehicle(playerid)) {
		for ( new i, j = sizeof ( Boombox ); i < j ; i ++ ) {

			if ( Boombox [ i ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

				if ( Boombox [ i ] [ E_BOOMBOX_AREAID ] == areaid ) {

					PlayerVar [ playerid ] [ E_PLAYER_LISTENING_BOOMBOX ] = INVALID_BOOMBOX_ID ;
					SOLS_StopAudioStreamForPlayer(playerid); // Stop the audio stream
				}

				else continue ;
			}

			else continue ;
		}
	}

	#if defined boombox_OnPlayerLeaveDynArea
		return boombox_OnPlayerLeaveDynArea(playerid, STREAMER_TAG_AREA:areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif

#define OnPlayerLeaveDynamicArea boombox_OnPlayerLeaveDynArea
#if defined boombox_OnPlayerLeaveDynArea
	forward boombox_OnPlayerLeaveDynArea(playerid, STREAMER_TAG_AREA:areaid);
#endif
