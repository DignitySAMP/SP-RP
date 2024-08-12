enum {

	BOOMBOX_MODEL_BLACK = 2102,
	BOOMBOX_MODEL_GREY = 2103,
	BOOMBOX_MODEL_RED = 2226
}

#include "boombox/data.pwn"
#include "boombox/channels.pwn"
#include "boombox/native.pwn"
#include "boombox/claim.pwn"


CMD:boomboxremove(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new boombox_id = Boombox_GetNearestEntity(playerid);

	new vehicleid, veh_enum_id ;

	if (boombox_id != INVALID_BOOMBOX_ID ) {

		ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", sprintf("has admin removed a boombox.", ReturnMixedName ( playerid ) ) );
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, "admin removed a boombox.");

		foreach(new targetid: Player) {
			if ( IsPlayerInAnyDynamicArea ( targetid ) ) {

				if ( Boombox [ boombox_id ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

					if ( IsPlayerInDynamicArea(targetid, Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ) {


						if ( PlayerVar [ targetid ] [ E_PLAYER_LISTENING_BOOMBOX ] == boombox_id ) {

							if ( IsPlayerInAnyVehicle(playerid) ) {			
								vehicleid = GetPlayerVehicleID ( playerid );
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


		if ( IsValidDynamicObject ( Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] ) ) {
			DestroyDynamicObject ( Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] ) ;
			Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] = INVALID_OBJECT_ID ;
		}
		
		if ( IsValidDynamic3DTextLabel ( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] ) ) {

			DestroyDynamic3DTextLabel ( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] ) ;
			Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] =  DynamicText3D: INVALID_3DTEXT_ID ;
		}		
		if ( IsValidDynamicArea ( Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ) {

			DestroyDynamicArea ( Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ;
			Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] = -1 ;
		}
		Boombox [ boombox_id ] [ E_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;
	}

	return true ;
}

CMD:boombox(playerid, params[]) {
	
	new boombox_id = Boombox_GetNearestEntity(playerid);

	if ( boombox_id != INVALID_BOOMBOX_ID ) {

		if ( Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

			ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", sprintf("has picked up their boombox.", ReturnMixedName ( playerid ) ), .annonated=true);
			AddLogEntry(playerid, LOG_TYPE_SCRIPT, "has picked up their boombox.");


	 		new veh_enum_id, vehicleid ;

			foreach(new targetid: Player) {
				if ( IsPlayerInAnyDynamicArea ( targetid ) ) {


					if ( Boombox [ boombox_id ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

						if ( IsPlayerInDynamicArea(targetid, Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ) {

							if ( PlayerVar [ targetid ] [ E_PLAYER_LISTENING_BOOMBOX ] == boombox_id ) {
								if ( IsPlayerInAnyVehicle(playerid) ) {		
									
									vehicleid = GetPlayerVehicleID ( playerid );
									veh_enum_id = Vehicle_GetEnumID(vehicleid) ;


									if ( strlen ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] ) < 3 ) {

										SOLS_StopAudioStreamForPlayer(targetid);
									}

									else continue ;
								}

								else SOLS_StopAudioStreamForPlayer(targetid);
							}
							else continue ;	
						}
						else continue ;	
					}
					else continue ;

				}
			}

			PlayerVar [ playerid ] [ player_hasboombox ] = Boombox [ boombox_id ] [ E_BOOMBOX_TYPE ] ;
			Boombox [ boombox_id ] [ E_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;

			if ( IsValidDynamicObject ( Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] ) ) {
				DestroyDynamicObject ( Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] ) ;
				Boombox [ boombox_id ] [ E_BOOMBOX_OBJECTID ] = INVALID_OBJECT_ID ;
			}
			
			if ( IsValidDynamic3DTextLabel ( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] ) ) {

				DestroyDynamic3DTextLabel ( Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] ) ;
				Boombox [ boombox_id ] [ E_BOOMBOX_LABEL ] =  DynamicText3D: INVALID_3DTEXT_ID ;
			}		
			if ( IsValidDynamicArea ( Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ) {

				DestroyDynamicArea ( Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] ) ;
				Boombox [ boombox_id ] [ E_BOOMBOX_AREAID ] = -1 ;
			}
		}
	}

	else if ( boombox_id == INVALID_BOOMBOX_ID ) {

		new modelid ; 

		new type = PlayerVar [ playerid ] [ player_hasboombox ] ;
		switch ( type ) {

			case 1: modelid = BOOMBOX_MODEL_RED ;
			case 2: modelid = BOOMBOX_MODEL_GREY ;
			case 3: modelid = BOOMBOX_MODEL_BLACK ;
			default: {

				//return SendClientMessage(playerid, COLOR_ERROR, "Invalid type passed! Use /boombox to see available types.");
				return SendClientMessage(playerid, COLOR_ERROR, "You don't have a boombox! Buy one from a Music Store!");
			}
		}

		new Float: x, Float: y, Float: z ;
		GetPlayerPos(playerid, x, y, z ) ;
		GetXYInFrontOfPlayer ( playerid, x, y, 5.0 ) ; 

		Boombox_CreateEntity(playerid, modelid, PlayerVar [ playerid ] [ player_hasboombox ], x, y, z ) ;
	}

	return true ;
}