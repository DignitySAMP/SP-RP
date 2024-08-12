CMD:boomboxclaim(playerid, params[]) {

	new index ;

	if ( sscanf ( params, "i", index ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/boomboxlisten [boombox-id]" ) ;
	}

	new boombox_id = Boombox_GetNearestEntity(playerid);

	if ( boombox_id != index ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near this boombox." ) ;
	}

	if ( Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] != INVALID_PLAYER_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "This boombox isn't unclaimed!" ) ;
	}

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "[%d] [%s's Boombox]{DEDEDE}\nAvailable Commands: /boombox, /setstation, /boomboxlisten", boombox_id, ReturnMixedName(playerid)) ; 
	UpdateDynamic3DTextLabelText( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ], 0x866D40FF, string );

	Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] = Character [ playerid ] [ E_CHARACTER_ID ] ;

	SendServerMessage ( playerid, COLOR_INFO, "Boombox", "DEDEDE", sprintf("You've claimed boombox %d You can now manage it.",
		boombox_id,
		Boombox [ boombox_id ] [ E_BOOMBOX_STATION ]
	) ) ;

	return true ;
}


CMD:bbclaim(playerid, params[]) {

	return cmd_boomboxclaim(playerid, params);
}


Boombox_OnOwnerDisconnect(playerid) {

	new boombox_id_found = INVALID_BOOMBOX_ID, string [ 256 ] ;

	for ( new i, j = sizeof ( Boombox ); i < j ; i ++ ) {

		if ( Boombox [ i ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

			if ( Boombox [ i ] [ E_BOOMBOX_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				format ( string, sizeof ( string ), "** The owner of boombox ID %d has disconnect. If it's not reclaimed in 5 minutes, it will disappear. /boomboxclaim %d.", i, i ) ;

				new Float: x, Float: y, Float: z ;
				GetPlayerPos(playerid, x, y, z ) ;

				ProxDetectorXYZ(x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), 15.0, COLOR_ACTION, string ) ;

				boombox_id_found = i ;
			}	

			else continue ;
		}

		else continue ;
	}

	if ( boombox_id_found != INVALID_BOOMBOX_ID ) {

		Boombox [ boombox_id_found ] [ E_BOOMBOX_OWNER ] = INVALID_PLAYER_ID ;

		string [ 0 ] = EOS ;
		format ( string, sizeof ( string ), "[%d] [Unclaimed Boombox]{DEDEDE}\nAvailable Commands: {DE431F}/boomboxclaim, {DEDEDE}/boombox, /setstation, /boomboxlisten", boombox_id_found  ) ; 

		UpdateDynamic3DTextLabelText( Boombox [ boombox_id_found ] [ E_BOOMBOX_LABEL ], COLOR_RED, string );

		defer Boombox_CheckForReclaim(boombox_id_found);
	}

	return true; 
}

timer Boombox_CheckForReclaim[300000](boombox_id) {

	if ( Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] != INVALID_PLAYER_ID ) {

		return true ;
	}

	else if ( Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] == INVALID_PLAYER_ID ) {
		new string [ 256 ] ;

		format ( string, sizeof ( string ), "** Boombox %d has been removed as the owner has quit and it has not been reclaimed.", boombox_id ) ;
		ProxDetectorXYZ(Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_INT ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_VW ], 15.0, COLOR_ACTION, string ) ;

 		new veh_enum_id, vehicleid ;

		foreach(new targetid: Player) {
			if ( IsPlayerInAnyDynamicArea ( targetid ) ) {

				if ( Boombox [ boombox_id ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

					if ( IsPlayerInDynamicArea(targetid, Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ) {

						if ( PlayerVar [ targetid ] [ E_PLAYER_LISTENING_BOOMBOX ] == boombox_id ) {

							if ( IsPlayerInAnyVehicle(targetid) ) {	
									
								vehicleid = GetPlayerVehicleID ( targetid );
								veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

								if ( strlen ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] ) < 3 ) {

									SOLS_StopAudioStreamForPlayer(targetid);
								}

								else continue ;
							}

							else SOLS_StopAudioStreamForPlayer(targetid);
						}
					}
					else continue ;
				}

				else continue ;
			}
		}

		Boombox [ boombox_id ] [ E_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;

		if ( IsValidDynamicObject ( Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] ) ) {
			DestroyDynamicObject ( Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] ) ;
			Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] = INVALID_OBJECT_ID ;
		}
		
		if ( IsValidDynamic3DTextLabel ( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] ) ) {

			DestroyDynamic3DTextLabel ( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] ) ;
			Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] = DynamicText3D: INVALID_3DTEXT_ID ;
		}		
		if ( IsValidDynamicArea ( Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ) {

			DestroyDynamicArea ( Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ;
			Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] = -1 ;
		}
	}

	return true ;
}