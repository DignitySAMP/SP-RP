CMD:cargojob(playerid, params[]) {

	if ( PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] != INVALID_DOCKWORKER_TASK_ID ) {

		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  "You're already on a task! Finish it first. If you wish to stop, use /cargostop." );
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  "You must be inside a dockworker's forklift." );
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_JOB ) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_JOBID ] == E_VEHICLE_JOB_DOCKWORKER ) {

			if ( ! GetEngineStatus ( vehicleid ) ) {
			  	SetEngineStatus(vehicleid, true);
				defer OnPlayerDrive(playerid, vehicleid) ;
			}

			PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] = random ( sizeof ( Dockworker_Store ) ) ;
			PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ] = random ( sizeof ( Dockworker_Collect ) ) ;

			new store_index = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ], collect_index  = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ];

			new material [ 32 ] ;

			material [ 0 ] = EOS ;

			switch ( collect_index ) {

				case 0: strcat(material, "bottles of Malt Liquor" ) ;
				case 1: strcat(material, "newly sown clothing" ) ; 
				case 2: strcat(material, "freshly cut planks" ) ; 
			}

			SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("Next task: fetch some %s from the %s and store it in the %s.",
				material, Dockworker_Collect [ collect_index ] [ E_DOCK_COLLECT_DESC ], 	Dockworker_Store [ store_index ] [ E_DOCK_STORE_DESC ]
			) );
			SendClientMessage(playerid, 0xDEDEDEFF, "To stop doing this job, use /cargostop. You will be paid once you deliver the cargo." ) ;

			AddLogEntry(playerid, LOG_TYPE_JOB, "started the dockworker job");

			return true ;
		}
	}
	SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  "You need to be inside a dockworker's forklift to be able to do this job." );
	return true ;
}

CMD:cargostop(playerid, const params[]) {
	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  "You must be inside a dockworker's forklift." );
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_JOB ) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_JOBID ] == E_VEHICLE_JOB_DOCKWORKER ) {

			Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100 ;
			JT_RemovePlayerFromVehicle( playerid ) ;
			
		    SetEngineStatus(vehicleid, false);
			SOLS_SetVehicleToRespawn(vehicleid, "/cargostop");
		}
	}

	PlayerJobVars [ playerid ] [ E_DOCK_JOB_TASK_STREAK ] 		= 0 ;
	PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] 	= INVALID_DOCKWORKER_TASK_ID ;
	PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ] = INVALID_DOCKWORKER_TASK_ID ;
	PlayerJobVars [ playerid ] [ E_DOCK_JOB_CURRENT_CARGO ] 	= INVALID_DOCKWORKER_TASK_ID ;

	SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE", "All dockworker job variables reset." );
	AddLogEntry(playerid, LOG_TYPE_JOB, "quit the dockworker job");

	return true ;
}

CMD:cargocollect(playerid, params[]) {
	new index = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ] ;
	new store_index = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ], 
	collect_index  = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ];

	if ( PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ] == INVALID_DOCKWORKER_TASK_ID ) {

		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  "You're not doing a cargo collect task. Go inside a forklift and do /cargojob." );
	}

	if ( PlayerJobVars [ playerid ] [ E_DOCK_JOB_CURRENT_CARGO ]  != INVALID_DOCKWORKER_TASK_ID ) {

		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("You already have cargo! Go finish it! Deliver your goods to the %s.", Dockworker_Store [ store_index ] [ E_DOCK_STORE_DESC ] ) );
	}


	if ( IsPlayerInRangeOfPoint(playerid, 5.0, Dockworker_Collect [ index ] [ E_DOCK_COLLECT_POS_X ], Dockworker_Collect [ index ] [ E_DOCK_COLLECT_POS_Y ], Dockworker_Collect [ index ] [ E_DOCK_COLLECT_POS_Z ] ) ) {

		PlayerJobVars [ playerid ] [ E_DOCK_JOB_CURRENT_CARGO ] = index ;
		SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("You've picked up the cargo! Head to the %s to deliver it.", Dockworker_Store [ store_index ] [ E_DOCK_STORE_DESC ] ) );
		AddLogEntry(playerid, LOG_TYPE_JOB, sprintf("picked up dockworker cargo for %s.", Dockworker_Store [ store_index ] [ E_DOCK_STORE_DESC ] ));
	}

	else return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("You're not at the right collection point! Go to the %s.", Dockworker_Collect [ collect_index ] [ E_DOCK_COLLECT_DESC ] ) );

	return true ;
}

CMD:cargostore(playerid, params[]) {

	new index = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] ;

	new store_index = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ], 
	collect_index  = PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ];


	if ( PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] == INVALID_DOCKWORKER_TASK_ID ) {

		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  "You're not doing a cargo store task. Go inside a forklift and do /cargojob." );
	}

	if ( collect_index != PlayerJobVars [ playerid ] [ E_DOCK_JOB_CURRENT_CARGO ] ) {
		return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("You don't have the right cargo! You need to get cargo from the %s.", Dockworker_Collect [ collect_index ] [ E_DOCK_COLLECT_DESC ] ));
	}

	if ( IsPlayerInRangeOfPoint(playerid, 5.0, Dockworker_Store [ index ] [ E_DOCK_STORE_POS_X ], Dockworker_Store [ index ] [ E_DOCK_STORE_POS_Y ], Dockworker_Store [ index ] [ E_DOCK_STORE_POS_Z ] ) ) {


		PlayerJobVars [ playerid ] [ E_DOCK_JOB_TASK_STREAK ] ++ ;
		new payout = Dockworker_CalculatePayout(playerid, collect_index, store_index); 

		AddLogEntry(playerid, LOG_TYPE_JOB, sprintf("earned %i from dockworker.", payout ));
		SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("You've delivered the goods! Payout: $%s. Streak: %d.", 
		IntegerWithDelimiter ( payout ),
		PlayerJobVars [ playerid ] [ E_DOCK_JOB_TASK_STREAK ] ) );
	
		GivePlayerCash ( playerid, payout ) ;

		PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ] = INVALID_DOCKWORKER_TASK_ID ;
		PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] = INVALID_DOCKWORKER_TASK_ID ;
		PlayerJobVars [ playerid ] [ E_DOCK_JOB_CURRENT_CARGO ] = INVALID_DOCKWORKER_TASK_ID ;

		cmd_cargojob(playerid, params);
	}

	else return SendServerMessage( playerid, COLOR_JOB, "Dockworker Job", "DEDEDE",  sprintf("You're not at the right store point! Go to the %s.", Dockworker_Store [ store_index ] [ E_DOCK_STORE_DESC ] ) );


	return true ;
}

Dockworker_CalculatePayout(playerid, collect, store) {

	new base_payout = 50 ;

	// job = collect index
	switch ( collect ) {
		case 0: base_payout += 25 ;
		case 1: base_payout += 50 ;
		case 2: base_payout += 100 ;
	}

	switch ( store ) {

		case 0: base_payout += 50 ;
		case 1: base_payout += 75 ;
		case 2: base_payout += 100 ;
	}

	new streakAmount = PlayerJobVars [ playerid ] [ E_DOCK_JOB_TASK_STREAK ] / 2;
	if(streakAmount > 250) {
		streakAmount = 250;
	}
	base_payout += streakAmount ;
	return base_payout ;
}