
public OnDynamicObjectMoved(STREAMER_TAG_OBJECT:objectid) {

	new gate_enum_id = Gate_GetEnumIDFromObject(objectid) ;

	if ( gate_enum_id != -1 ) {

		if ( objectid == Gate [ gate_enum_id ] [ E_GATE_OBJECTID ] ) {
			if ( Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {

				SetDynamicObjectPos( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_X ], Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Z ] );
				SOLS_SetObjectRot ( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Z ], "Gate/OnMoveObject OPEN", true) ; 
			}

			else if ( ! Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {

				SetDynamicObjectPos( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ] );
				SOLS_SetObjectRot ( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ], "Gate/OnMoveObject CLOSE", true) ; 
			}
		}
	}
	
	#if defined gate_OnDynamicObjectMoved
		return gate_OnDynamicObjectMoved(STREAMER_TAG_OBJECT:objectid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnDynamicObjectMoved
	#undef OnDynamicObjectMoved
#else
	#define _ALS_OnDynamicObjectMoved
#endif

#define OnDynamicObjectMoved gate_OnDynamicObjectMoved
#if defined gate_OnDynamicObjectMoved
	forward gate_OnDynamicObjectMoved(STREAMER_TAG_OBJECT:objectid);
#endif

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] ) {

		new gate_enum_id = Gate_GetEnumIDFromObject(objectid) ;

		if ( gate_enum_id != -1 ) {

			if ( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ] == objectid ) {

				if ( !Gate [ gate_enum_id ] [ E_GATE_SETUP ] ) { // closed position
					new query [ 1024 ] ; 

					switch ( response ) {

						case EDIT_RESPONSE_CANCEL: {


							if ( Gate [ gate_enum_id ] [ E_GATE_SQLID ] == GATE_SETUP_ID ) {
								Gate [ gate_enum_id ] [ E_GATE_SQLID ] = -1 ;

								SOLS_DestroyObject(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], "Gate/OnEditObject CANCEL", true ) ;
								Gate [ gate_enum_id ] [ E_GATE_OBJECTID ]  = INVALID_OBJECT_ID ;
								PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] = false ;
							}

							else {

								SetDynamicObjectPos(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], 
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ]);

								SOLS_SetObjectRot(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], 
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ], "Gate/EditObject Cancel", true) ; 

								PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] = false ;
							}
						}

						case EDIT_RESPONSE_FINAL : { // save

							if ( Gate [ gate_enum_id ] [ E_GATE_SQLID ] == GATE_SETUP_ID ) {
				
			
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ] = x ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ] = y ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ] = z ;

								Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ] = rx ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ] = ry ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ] = rz ;

								SetDynamicObjectPos(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], x, y, z);
								SOLS_SetObjectRot(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], rx, ry, rz, "Gate/EditObject FINAL (STORE)", true) ; 

								mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO gates (gate_modelid, gate_type, gate_owner, gate_interior, gate_virtualworld, gate_closed_pos_x, gate_closed_pos_y, gate_closed_pos_z, gate_closed_rot_x,  gate_closed_rot_y,  gate_closed_rot_z, gate_open_pos_x, gate_open_pos_y, gate_open_pos_z, gate_open_rot_x,  gate_open_rot_y,  gate_open_rot_z) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%f', '%f','%f', '%f', '%f', '%f', '%f', '%f' )",
									Gate [ gate_enum_id ] [ E_GATE_MODELID ], Gate [ gate_enum_id ] [ E_GATE_TYPE ], Gate [ gate_enum_id ] [ E_GATE_OWNER ], Gate [ gate_enum_id ] [ E_GATE_INTERIOR ], Gate [ gate_enum_id ] [ E_GATE_VIRTUALWORLD ],
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ], 
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ],
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ], 
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ]
								);

								inline Gate_OnDatabaseInsert() {

									Gate [ gate_enum_id ] [ E_GATE_SQLID ] = cache_insert_id ();
									SendClientMessage(playerid, -1, sprintf(" * [GATE] Created new gate with ID %d [Database ID is %d]", 
										gate_enum_id, Gate [ gate_enum_id ] [ E_GATE_SQLID ] )) ;
									AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Created a new gate with SQL ID %d", Gate [ gate_enum_id ] [ E_GATE_SQLID ] ));
								}

								MySQL_TQueryInline(mysql, using inline Gate_OnDatabaseInsert, query, "");
								PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] = false ;
							}

							else {

								Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ] = x ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ] = y ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ] = z ;

								Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ] = rx ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ] = ry ;
								Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ] = rz ;

								SetDynamicObjectPos(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ]);
								SOLS_SetObjectRot(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ], "Gate/OnEditObject FINAL (save)", true) ; 
					
								mysql_format ( mysql, query, sizeof ( query ), "UPDATE gates SET gate_closed_pos_x = '%f', gate_closed_pos_y = '%f', gate_closed_pos_z = '%f', gate_closed_rot_x = '%f',  gate_closed_rot_y = '%f',  gate_closed_rot_z = '%f' WHERE gate_sqlid = %d",
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ], 
									Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ],
									Gate [ gate_enum_id ] [ E_GATE_SQLID]
								);

								mysql_tquery(mysql, query);
							
								SendClientMessage(playerid, -1, "Don't forget to adjust /gateopen!");
								PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] = false ;
								AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Moved gate %d to their position", gate_enum_id ));
							}
						}
					}
				}

				else if ( Gate [ gate_enum_id ] [ E_GATE_SETUP ] ) { // closed position

					switch ( response ) {

						case EDIT_RESPONSE_CANCEL: {

							PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] = false ;
						}

						case EDIT_RESPONSE_FINAL : { // save
							if ( Gate [ gate_enum_id ] [ E_GATE_SQLID ] != GATE_SETUP_ID ) {

								new query [ 512 ] ; 

								Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_X ] = x ;
								Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Y ] = y ;
								Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Z ] = z ;

								Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_X ] = rx ;
								Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Y ] = ry ;
								Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Z ] = rz ;

								SetDynamicObjectPos(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ]);
								SOLS_SetObjectRot(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ], "Gate/OnEditObject [OPEN]: FINAL (save)", true) ; 
					
								mysql_format ( mysql, query, sizeof ( query ), "UPDATE gates SET gate_open_pos_x = '%f', gate_open_pos_y = '%f', gate_open_pos_z = '%f', gate_open_rot_x = '%f',  gate_open_rot_y = '%f',  gate_open_rot_z = '%f' WHERE gate_sqlid = %d",
									Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_X ], Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Z ], 
									Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Z ],
									Gate [ gate_enum_id ] [ E_GATE_SQLID]
								);

								mysql_tquery(mysql, query);
								PlayerVar [ playerid ] [ E_PLAYER_IS_MOVING_GATE ] = false ;

								AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Changed gate %d's open position", gate_enum_id ));
							}
						}
					}
				}
			}
		}
	}
	
	#if defined gate_OnPlayerEditDynamicObject
		return gate_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEditDynamicObject
	#undef OnPlayerEditDynamicObject
#else
	#define _ALS_OnPlayerEditDynamicObject
#endif

#define OnPlayerEditDynamicObject gate_OnPlayerEditDynamicObject
#if defined gate_OnPlayerEditDynamicObject
	forward gate_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
#endif