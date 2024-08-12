
IsPlayerDoingGarbageJob( playerid ) {

	return PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB ] ;
}

IsPlayerInGarbageJobVehicle ( playerid ) {
	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return false ;
	}

	if ( GetVehicleDriver ( vehicleid ) != playerid ) {

		return false ;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_JOB ) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_JOBID ] == E_VEHICLE_JOB_GARBAGEJOB ) {
			return true ;
		}
	}

	return false ;
}
IsGarbageJobVehicle ( vehicleid ) {
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return false ;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_JOB ) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_JOBID ] == E_VEHICLE_JOB_GARBAGEJOB ) {
			return true ;
		}
	}

	return false ;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {


	if ( IsPlayerDoingGarbageJob( playerid ) ) {

		if ( newkeys & KEY_FIRE && IsPlayerInGarbageJobVehicle ( playerid ) ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_INDEX ] != -1 ) {

				ShowPlayerInfoMessage(playerid, "You're already doing a job! Finish it first then start a new one.", .height=167.5, .width=180, .showtime=6000);

			}

			else {

				GarbageJob_FetchNewPoint ( playerid );	
			}
		}

		if ( newkeys & KEY_WALK ) {

			if ( IsPlayerInDynamicArea(playerid, PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ]) ) {

				new index = PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_INDEX ] ;
				new modelid = GetDynamicObjectModel ( garbage_object [ index] ) ;

				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);			
				GarbageJob_SetAttachment ( playerid, modelid ) ;
				PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_CARRYING ] = true ;
				PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_INDEX ] = -1 ;

				if ( IsValidDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) ) {
					DestroyDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] ) ;
					PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_AREA ] = -1 ;
				}

				ShowPlayerInfoMessage(playerid, "You picked up the trash! Bring it to the back of the garbage truck and press ~k~~SNEAK_ABOUT~ to store it.", .height=167.5, .width=180, .showtime=6000);
			}

			else {
				if ( PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_CARRYING ] ) {

					new vehicleid = Vehicle_GetClosestEntity(playerid, 5.0);
					if ( vehicleid == INVALID_VEHICLE_ID ) {
						ShowPlayerInfoMessage(playerid, "You must be on foot near your garbage job vehicle in order to do this!", .height=167.5, .width=180, .showtime=6000);
	
						return true ;	
					}

					if ( ! IsGarbageJobVehicle ( vehicleid ) ) {
						ShowPlayerInfoMessage(playerid, "This vehicle isn't a garbage job vehicle!", .height=167.5, .width=180, .showtime=6000);

						return true ;	
					}

					RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);
					GarbageJob_CalculatePayout(playerid) ;
					PlayerVar [ playerid ] [ E_PLAYER_GARBAGEJOB_CARRYING ] = false ;
				}
			}
		}
	}

	#if defined garbage_OnPlayerKeyStateChange
		return garbage_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange garbage_OnPlayerKeyStateChange
#if defined garbage_OnPlayerKeyStateChange
	forward garbage_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
