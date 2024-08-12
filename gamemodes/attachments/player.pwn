#if !defined MAX_PLAYER_ATTACHMENTS
	#define MAX_PLAYER_ATTACHMENTS	(7)
#endif

enum E_PLAYER_ATTACH_DATA {

	E_PLAYER_ATTACH_MODEL [ MAX_PLAYER_ATTACHMENTS ],
	E_PLAYER_ATTACH_INDEX [ MAX_PLAYER_ATTACHMENTS ],
	E_PLAYER_ATTACH_BONE [ MAX_PLAYER_ATTACHMENTS ],

	Float: E_PLAYER_ATTACH_OFFSET_X [ MAX_PLAYER_ATTACHMENTS ],
	Float: E_PLAYER_ATTACH_OFFSET_Y [ MAX_PLAYER_ATTACHMENTS ],
	Float: E_PLAYER_ATTACH_OFFSET_Z [ MAX_PLAYER_ATTACHMENTS ],

	Float: E_PLAYER_ATTACH_ROT_X [ MAX_PLAYER_ATTACHMENTS ],
	Float: E_PLAYER_ATTACH_ROT_Y [ MAX_PLAYER_ATTACHMENTS ],
	Float: E_PLAYER_ATTACH_ROT_Z [ MAX_PLAYER_ATTACHMENTS ],

	Float: E_PLAYER_ATTACH_SCALE_X [ MAX_PLAYER_ATTACHMENTS ],
	Float: E_PLAYER_ATTACH_SCALE_Y [ MAX_PLAYER_ATTACHMENTS ],
	Float: E_PLAYER_ATTACH_SCALE_Z [ MAX_PLAYER_ATTACHMENTS ],

	E_PLAYER_ATTACH_VISIBLE [ MAX_PLAYER_ATTACHMENTS ]
} ;

new PlayerAttachments [ MAX_PLAYERS ] [ E_PLAYER_ATTACH_DATA ] ;

enum {
	EDIT_TYPE_NONE = 0,
	EDIT_TYPE_NEW,
	EDIT_TYPE_EXISTING
}

timer Attach_LoadDelayedEntities[2500](playerid) {

	Attach_LoadPlayerEntities(playerid) ;

	return true ;
}

// Resetting toys!
Attach_OnPlayerConnect(playerid) {
	new attachment_clear [ E_PLAYER_ATTACH_DATA ] ;
	PlayerAttachments [ playerid ] = attachment_clear ;

	return true ;
}

Attach_LoadPlayerEntities(playerid) {

	for ( new i; i < MAX_PLAYER_ATTACHMENTS; i ++ ) {

		PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ i ] = 0 ;
	}

	new query [ 256 ] ;

	inline PlayerAttach_OnDataLoad() {
		if(!cache_num_rows()) {
			mysql_format(mysql, query, sizeof(query), "INSERT INTO player_attachments(player_attach_charid) VALUES (%d)", Character [ playerid ] [ E_CHARACTER_ID ]);
			mysql_tquery(mysql, query);
			return true;
		}

		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			for ( new x = 0; x < MAX_PLAYER_ATTACHMENTS; x ++ ) {
				cache_get_value_name_int (i, sprintf("player_attach_model_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ x ]);
				cache_get_value_name_int (i, sprintf("player_attach_index_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ x ]);
				cache_get_value_name_int (i, sprintf("player_attach_bone_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ x ]);

				cache_get_value_name_float (i, sprintf("player_attach_offset_x_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ x ]);
				cache_get_value_name_float (i, sprintf("player_attach_offset_y_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ x ]);
				cache_get_value_name_float (i, sprintf("player_attach_offset_z_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ x ]);

				cache_get_value_name_float (i, sprintf("player_attach_rot_x_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ x ]);
				cache_get_value_name_float (i, sprintf("player_attach_rot_y_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ x ]);
				cache_get_value_name_float (i, sprintf("player_attach_rot_z_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ x ]);

				cache_get_value_name_float (i, sprintf("player_attach_scale_x_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ x ]);
				cache_get_value_name_float (i, sprintf("player_attach_scale_y_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ x ]);
				cache_get_value_name_float (i, sprintf("player_attach_scale_z_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ x ]);

				cache_get_value_name_int (i, sprintf("player_attach_visible_%d", x ), PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ x ]);
			
				if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ x ] ) {
					SOLS_SetPlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ x ], 

						PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ x ] ,
						PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ x ],	
						PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ x ], 
						.save = false
					);
				}
			}
		}
	}

	mysql_format(mysql, query, sizeof(query), "SELECT * FROM player_attachments WHERE player_attach_charid = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	MySQL_TQueryInline(mysql, using inline PlayerAttach_OnDataLoad, query, "" ) ;
	return true;
}

SOLS_SetPlayerAttachedObject(playerid, index, modelid, bone,  Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0, save = false ) {

	switch ( index ) {

		case E_ATTACH_INDEX_TOY_1, E_ATTACH_INDEX_TOY_2, E_ATTACH_INDEX_TOY_3, 
			E_ATTACH_INDEX_TOY_4, E_ATTACH_INDEX_TOY_5, E_ATTACH_INDEX_TOY_6, 
			E_ATTACH_INDEX_TOY_7: {

			if ( modelid != 0 ) {

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ] 		= modelid ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ index ] 		= index ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ index ] 		= bone ;

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ index ] 	= fOffsetX ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ index ] 	= fOffsetY ; 
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ index ] 	= fOffsetZ ;

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ index ] 		= fRotX ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ index ] 		= fRotY ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ index ] 		= fRotZ ;

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] 	= fScaleX ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] 	= fScaleY ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ] 	= fScaleZ ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ index ] 	= true ;
			}

			if ( save ) {

				new query [ 1024 ] ;

				mysql_format(mysql, query, sizeof(query), "UPDATE player_attachments SET \
					player_attach_model_%d = %d,  player_attach_index_%d = %d, player_attach_bone_%d = %d,\
					player_attach_offset_x_%d = '%f', player_attach_offset_y_%d = '%f', player_attach_offset_z_%d = '%f',\
					player_attach_rot_x_%d = '%f', player_attach_rot_y_%d = '%f', player_attach_rot_z_%d = '%f',\
					player_attach_scale_x_%d = '%f', player_attach_scale_y_%d = '%f', player_attach_scale_z_%d = '%f',\
					player_attach_visible_%d = %d WHERE player_attach_charid = %d",
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ index ],
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ index ],
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ index ],
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ] ,
						index, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ index ],
						Character [ playerid ] [ E_CHARACTER_ID ]
				);

				mysql_tquery(mysql, query);

			}
		}
	}

	SetPlayerAttachedObject(playerid, index, modelid, bone, 
		fOffsetX, fOffsetY, fOffsetZ,
	 	fRotX, fRotY, fRotZ, 
	 	fScaleX, fScaleY, fScaleZ, 
	 	materialcolor1, materialcolor2 
	) ;

	return true ;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float: fOffsetY, Float: fOffsetZ, Float: fRotX, Float: fRotY, Float: fRotZ, Float: fScaleX, Float: fScaleY, Float: fScaleZ )  
{
	if ( ! PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] ) {

		if ( index > MAX_PLAYER_ATTACHMENTS ) {

			CancelEdit(playerid);
			return SendServerMessage(playerid, COLOR_RED, "Error", "A3A3A3", 
				sprintf("Tried editing an attached object that isn't in your saved data. Cancelling edit. (modelid=%d",
					modelid ));
		}

		if ( PlayerVar [ playerid ] [ E_PLAYER_ATTACH_EDIT_TYPE ] ) {
			if(response) {

				new type = Attach_GetType(PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ] ) ;

				new string [ 256 ], name [ 64 ] ;

				Attach_GetName(type, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ], name, sizeof ( name ) ) ;
				

				switch ( PlayerVar [ playerid ] [ E_PLAYER_ATTACH_EDIT_TYPE ] ) {

					case EDIT_TYPE_NEW: {
						inline AttachBuyConfirm(pid, dialogid, responsex, listitem, string:inputtext[]) {
							#pragma unused pid, dialogid, inputtext, listitem

							if ( responsex ) {

								if ( GetPlayerCash ( playerid ) < Attach_DetermineCost ( type ) ) {

									PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ] = 0 ;
									PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ index ] = 0 ;
									PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ index ] = 0 ;

									RemovePlayerAttachedObject(playerid, index);

									return SendServerMessage ( playerid, COLOR_ERROR, "Attach", "DEDEDE", sprintf("You need at least $%s for this toy! You don't have enough.", IntegerWithDelimiter(  Attach_DetermineCost ( type )) ) ) ;
								}

								TakePlayerCash ( playerid, Attach_DetermineCost ( type ) ) ;
								AttachPoint_HandlePayment(playerid, Attach_DetermineCost ( type ) ) ;

								SOLS_SetPlayerAttachedObject(playerid, index, modelid, boneid, 
									fOffsetX, fOffsetY, fOffsetZ,
									fRotX, fRotY, fRotZ,
									fScaleX, fScaleY, fScaleZ, 
									.save = true 
								) ;

								format ( string, sizeof ( string ), "You've purchased a \"%s\" attachment for $%s.", name, IntegerWithDelimiter(  Attach_DetermineCost ( type )) ) ;
								SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string ) ;
							}

							else if ( ! responsex ) {

								PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ] = 0 ;
								PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ index ] = 0 ;
								PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ index ] = 0 ;

								RemovePlayerAttachedObject(playerid, index);

								format ( string, sizeof ( string ), "You've cancelled your purchase of a \"%s\" attachment.", name ) ;
								SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string ) ;
							}
						}

						format ( string, sizeof ( string ), "{DEDEDE}Confirm your purchase:\n\nYou're buying a \"{4DA5F1}%s{DEDEDE}\" for ${4DA5F1}%s{DEDEDE}.\n\nPress \"Proceed\" to purchase.\nPress \"Cancel\" to close.", name, IntegerWithDelimiter( Attach_DetermineCost ( type ) ) ) ;
						Dialog_ShowCallback ( playerid, using inline AttachBuyConfirm, DIALOG_STYLE_MSGBOX, "Attachments: Confirm Purchase", string, "Proceed", "Cancel" );
					}

					case EDIT_TYPE_EXISTING: {

						SOLS_SetPlayerAttachedObject(playerid, index, modelid, boneid, 
							fOffsetX, fOffsetY, fOffsetZ,
							fRotX, fRotY, fRotZ,
							fScaleX, fScaleY, fScaleZ, 
							.save = true 
						) ;	

						SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", "You've saved your attachment. It's position, rotation and scale has been saved." ) ;	
					}
				}
			}

			else if ( ! response ) {
				switch ( PlayerVar [ playerid ] [ E_PLAYER_ATTACH_EDIT_TYPE ] ) {

					case EDIT_TYPE_NEW: {
						// Don't charge or save.
						PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ index ] = 0 ;
						PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ index ] = 0 ;
						PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ index ] = 0 ;

						RemovePlayerAttachedObject(playerid, index);

						SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", "Toy purchase cancelled." ) ;
					}

					case EDIT_TYPE_EXISTING: {
						SOLS_SetPlayerAttachedObject(playerid, index, modelid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE] [ index ], 

							PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ index ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ index ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ index ] ,
							PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ index ],	
							PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ], 
							.save = false
						);

						SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", "Cancelled the new coordinates." ) ;
					}
				}
			}
	  	}
	}

	#if defined att_OnPlayerEditAttachedObject
		return att_OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float: fOffsetY, Float: fOffsetZ, Float: fRotX, Float: fRotY, Float: fRotZ, Float: fScaleX, Float: fScaleY, Float: fScaleZ ) ;
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEditAttachedObject
	#undef OnPlayerEditAttachedObject
#else
	#define _ALS_OnPlayerEditAttachedObject
#endif

#define OnPlayerEditAttachedObject att_OnPlayerEditAttachedObject
#if defined att_OnPlayerEditAttachedObject
	forward att_OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float: fOffsetY, Float: fOffsetZ, Float: fRotX, Float: fRotY, Float: fRotZ, Float: fScaleX, Float: fScaleY, Float: fScaleZ ) ;
#endif