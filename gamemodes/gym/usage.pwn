enum {

	E_GYM_ANIM_STAGE_NONE,
	E_GYM_ANIM_STAGE_RUN_WALK,
	E_GYM_ANIM_STAGE_RUN_JOG,
	E_GYM_ANIM_STAGE_RUN_SPRINT,

	E_GYM_ANIM_STAGE_BIKE_STILL,
	E_GYM_ANIM_STAGE_BIKE_SLOW,
	E_GYM_ANIM_STAGE_BIKE_FAST,

	E_GYM_ANIM_STAGE_BENCHP_DOWN,
	E_GYM_ANIM_STAGE_BENCHP_UP_A,
	E_GYM_ANIM_STAGE_BENCHP_UP_B,

	E_GYM_ANIM_STAGE_DUMBB_DOWN,
	E_GYM_ANIM_STAGE_DUMBB_UP_A,
	E_GYM_ANIM_STAGE_DUMBB_UP_B,

}

timer Gym_SyncPosition[250](playerid, type, Float: x, Float: y, Float: z ) {
	if ( !PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) {

		return false ;
	}

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, x, y, z ) ;

	Gym_EnterMachine(playerid, type ) ;
	return true ;
}

Gym_EnterMachine(playerid, type ) {

	HidePlayerInfoMessage(playerid);

	stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;
	if ( !PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) {

		return false ;
	}

	new Float: FIXED_HEIGHT=190.0; // lowers the info box, so 
	// that the  lvl up box can be shown (used to overlap)


	new timer_delay = 1800 ;
	PlayerVar [ playerid ] [ E_PLAYER_GYM_MACHINE_IDLE_TICK ] = gettime();
	PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ] = type ;
	switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ] ) {

		case E_GYM_TYPE_TREADMILL: {
			PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 24.0 ; // 
			ApplyAnimation(playerid, "gymnasium", "gym_tread_geton", 4.1, 0, 0, 0, 1, 1, 1);

			ShowPlayerInfoMessage(playerid, 
				"To begin running, use ~k~~PED_SPRINT~ rapidly. Do not allow your power bar to empty or you will fall off the treadmill.", 
				.height=FIXED_HEIGHT
			);

			PlayerTextDrawSetString(playerid, HUD_GYM_STATS[playerid][0], "power~n~distance");
		}
		case E_GYM_TYPE_BICYCLE: {
			PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 0.0 ;
			ApplyAnimation(playerid, "gymnasium", "gym_bike_geton", 4.1, 0, 0, 0, 1, 1, 1);

			ShowPlayerInfoMessage(playerid, 
				"Use ~k~~PED_SPRINT~ rapidly to begin pedalling the bicycle.", 
				.height=FIXED_HEIGHT
			);
			PlayerTextDrawSetString(playerid, HUD_GYM_STATS[playerid][0], "power~n~distance");
		}		
		case E_GYM_TYPE_BENCHPRESS, E_GYM_TYPE_BENCHPRESS_2: {
			PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 0.0 ;
			ApplyAnimation(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 1, 1);

			ShowPlayerInfoMessage(playerid, 
				"To lift the weight, use ~k~~PED_SPRINT~ rapidly.", 
				.height=FIXED_HEIGHT
			);
			PlayerTextDrawSetString(playerid, HUD_GYM_STATS[playerid][0], "power~n~reps");

			timer_delay = 4500 ;
		}

		case E_GYM_TYPE_DUMBBELLS: {
			PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 0.0 ;
			ApplyAnimation(playerid, "freeweights", "gym_free_pickup", 4.1, 0, 0, 0, 1, 1, 1);
	
			ShowPlayerInfoMessage(playerid, 
				"To lift the dumbbells, use ~k~~PED_SPRINT~ rapidly.", 
				.height=FIXED_HEIGHT
			);
			PlayerTextDrawSetString(playerid, HUD_GYM_STATS[playerid][0], "power~n~reps");

			timer_delay = 2500 ;
		}
	}
 
	//SetPlayerProgressBarValue(playerid, HUD_GYM_BAR [ playerid ], PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ]);

	defer Gym_StartMachineAnim[timer_delay](playerid, type);
	return true ;
}

timer Gym_StartMachineAnim[2000](playerid, type) {
	
	stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;
	if ( !PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) {

		return false ;
	}

	switch ( type) {

		case E_GYM_TYPE_TREADMILL: {


			ApplyAnimation(playerid, "gymnasium", "gym_tread_jog", 4.1, 1, 0, 0, 1, 1, 1);
			PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_RUN_JOG ;
			PlayerPlaySound(playerid, 17800, 0, 0, 0);
		}
		case E_GYM_TYPE_BICYCLE: {
			ApplyAnimation(playerid, "gymnasium", "gym_bike_still", 4.1, 1, 0, 0, 1, 1, 1);	
			PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BIKE_STILL ;
		}

		case E_GYM_TYPE_BENCHPRESS: {
			ApplyAnimation(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1 );
			PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BENCHP_DOWN ;

			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_LS: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LS_GYM_BENCHPRESS_OBJECT, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_BENCHPRESS_OBJECT1, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_SF: { }
				case E_GYM_LOCATION_BEACH: Streamer_SetIntData(STREAMER_TYPE_OBJECT, BEACH_GYM_BENCHPRESS_OBJECT, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_BENCHPRESS_OBJECT1, E_STREAMER_WORLD_ID, 9999);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, -16001, 6, 0.0, 0.0, -0.1); //right hand(6), index(0)
		}

		case E_GYM_TYPE_BENCHPRESS_2: {
			ApplyAnimation(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1 );
			PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BENCHP_DOWN ;

			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_BENCHPRESS_OBJECT2, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_BENCHPRESS_OBJECT2, E_STREAMER_WORLD_ID, 9999);

			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, -16001, 6, 0.0, 0.0, -0.1); //right hand(6), index(0)	
		}

		case E_GYM_TYPE_DUMBBELLS: {
			ApplyAnimation(playerid, "freeweights", "gym_free_down", 4.1, 0, 0, 0, 1, 0, 1 );
			PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_DUMBB_DOWN ;

			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_LS: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LS_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_SF: { }
				case E_GYM_LOCATION_BEACH: Streamer_SetIntData(STREAMER_TYPE_OBJECT, BEACH_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, 9999);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_DUMBBELL_OBJECT1, E_STREAMER_WORLD_ID, 9999);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, -16002, 6); //right hand(6), index(0)	
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, -16003, 5); //right hand(6), index(1)		
		}
		case E_GYM_TYPE_DUMBBELLS_2: {
			ApplyAnimation(playerid, "freeweights", "gym_free_down", 4.1, 0, 0, 0, 1, 0, 1 );
			PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_DUMBB_DOWN ;

			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_DUMBBELL_OBJECT2, E_STREAMER_WORLD_ID, 9999);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, -16002, 6); //right hand(6), index(0)	
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, -16003, 5); //right hand(6), index(1)		
		}
	}

	PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] = repeat Gym_ProgressTick(playerid);
	PlayerGym [ playerid ] [ E_PLAYER_MACHINE_TIME_SPENT ] = gettime () ;

	Gym_ShowHUD(playerid);
	return true ;
}


timer Gym_ProgressTick[250](playerid) {
	
	if ( !PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) {

		stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;
		return false ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_MACHINE_IDLE_TICK ] < gettime() - 60 ) { // Player has been inactive for 60 seconds, kick them out

		SendClientMessage(playerid, COLOR_ERROR, "You've been kicked from the machine for being inactive for 60 seconds. Cooldown extended." ) ;
		Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], false);
		PlayerVar [ playerid ] [ E_PLAYER_GYM_MACHINE_IDLE_TICK ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_GYM_COOLDOWN ]  = gettime() + 60 ;
		stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;
		return true ;
	}

	PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] -= 4.00 ;

	if ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] <= 0.00) {


		PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 0.00 ;

		switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ] ) {

			case E_GYM_TYPE_TREADMILL: Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], false);
		}
		return true ;
	}

	SetPlayerProgressBarValue(playerid, HUD_GYM_BAR [ playerid ], PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ]);

	switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ] ) {

		case E_GYM_TYPE_TREADMILL,E_GYM_TYPE_TREADMILL_2: {

			switch ( floatround ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] ) ) {

				case 0 .. 20: {

					Gym_ApplyExperience ( playerid, E_GYM_STAT_WEIGHT );

					if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1 ) { 
						PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] += random(2) ;
					}

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_RUN_WALK ) {
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_RUN_WALK ;

						ApplyAnimation(playerid, "gymnasium", "gym_tread_walk", 4.1, 1, 0, 0, 1, 1, 1);	
					}
				}

				case 21 .. 65: { 
					Gym_ApplyExperience ( playerid, E_GYM_STAT_WEIGHT );


					if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1) { 
						PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] += random(4) ;
					}

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_RUN_JOG ) {
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_RUN_JOG ;

						ApplyAnimation(playerid, "gymnasium", "gym_tread_jog", 4.1, 1, 0, 0, 1, 1, 1);	
					}
				}

				case 66 .. 100: {

					Gym_ApplyExperience ( playerid, E_GYM_STAT_WEIGHT );
					if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1) { 
						PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] += random(6) ;
					}

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_RUN_SPRINT ) {
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_RUN_SPRINT ;

						ApplyAnimation(playerid, "gymnasium", "gym_tread_sprint", 4.1, 1, 0, 0, 1, 1, 1);	
					}
				}
			}
		}

		case E_GYM_TYPE_BICYCLE,E_GYM_TYPE_BICYCLE_2: {

			switch ( floatround ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] ) ) {

				case 0 .. 10: {

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_RUN_WALK ) {
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BIKE_STILL ;

						PlayerPlaySound(playerid, 0, 0, 0, 0);
						ApplyAnimation(playerid, "gymnasium", "gym_bike_still", 4.1, 1, 0, 0, 1, 1, 1);	
					}
				}

				case 11 .. 50: {

					Gym_ApplyExperience ( playerid, E_GYM_STAT_WEIGHT );
					if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1) { 
						PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] += random(4) ;
					}

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_RUN_JOG ) {
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BIKE_SLOW ;

						PlayerPlaySound(playerid, 17801, 0, 0, 0);
						ApplyAnimation(playerid, "gymnasium", "gym_bike_slow", 4.1, 1, 0, 0, 1, 1, 1);	
					}
				}

				case 51 .. 100: {
					Gym_ApplyExperience ( playerid, E_GYM_STAT_WEIGHT );
					if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1) { 
						PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] += random(6) ;
					}

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_RUN_SPRINT ) {
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BIKE_FAST ;

						PlayerPlaySound(playerid, 17801, 0, 0, 0);
						ApplyAnimation(playerid, "gymnasium", "gym_bike_faster", 4.1, 1, 0, 0, 1, 1, 1);	
					}					
				}
			}
		}

		case E_GYM_TYPE_BENCHPRESS, E_GYM_TYPE_BENCHPRESS_2: {

			switch ( floatround ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] ) ) {

				case 0 .. 55: {
					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_BENCHP_UP_A ||
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_BENCHP_UP_B ) {

						if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_BENCHP_DOWN ) {

							PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BENCHP_DOWN ;
							ApplyAnimation(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1 );
							PlayerPlaySound(playerid, 17807, 0, 0, 0);
						}
					}
				}

				case 90 .. 100 : {
					Gym_ApplyExperience ( playerid, E_GYM_STAT_MUSCLE );

					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_BENCHP_UP_A ||
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_BENCHP_UP_B ) {

						if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_BENCHP_DOWN ) {

							PlayerPlaySound(playerid, 0, 0, 0, 0);

							switch ( random ( 2 ) ) {
								case 0: {

									PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BENCHP_UP_A ;
									ApplyAnimation(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1 );
								}
								case 1: {

									PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_BENCHP_UP_B ;
									ApplyAnimation(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1 );
								}
							}

							if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1) { 
								PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] ++ ;
							}
						}
					}
				}
			}
		}
		case E_GYM_TYPE_DUMBBELLS,E_GYM_TYPE_DUMBBELLS_2: {

			switch ( floatround ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] ) ) {

				case 0 .. 65: {
					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_DUMBB_UP_A ||
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_DUMBB_UP_B ) {

						if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_DUMBB_DOWN ) {

							PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_DUMBB_DOWN ;
							ApplyAnimation(playerid, "freeweights", "gym_free_down", 4.1, 0, 0, 0, 1, 0, 1 );
							PlayerPlaySound(playerid, 17807, 0, 0, 0);
						}
					}
				}

				case 90 .. 100 : {
					Gym_ApplyExperience ( playerid, E_GYM_STAT_MUSCLE);
					if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_DUMBB_UP_A ||
						PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] != E_GYM_ANIM_STAGE_DUMBB_UP_B ) {

						if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_DUMBB_DOWN ) {

							PlayerPlaySound(playerid, 0, 0, 0, 0);

							switch ( random ( 2 ) ) {
								case 0: {

									PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_DUMBB_UP_A ;
									ApplyAnimation(playerid, "freeweights", "gym_free_a", 4.1, 0, 0, 0, 1, 0, 1 );
								}
								case 1: {

									PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_DUMBB_UP_B ;
									ApplyAnimation(playerid, "freeweights", "gym_free_b", 4.1, 0, 0, 0, 1, 0, 1 );
								}
							}

							if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] > gettime() - 1) { 
								PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] ++ ;
							}
						}
					}
				}
			}
		}

	}

	PlayerTextDrawSetString(playerid, HUD_GYM_STATS[playerid][1], sprintf("~n~%d", PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] ));

	return true ;
}


Gym_ProgressHandler(playerid) {
	if ( PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ]) {

		switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ] ) {

			case E_GYM_TYPE_BENCHPRESS, E_GYM_TYPE_BENCHPRESS_2, E_GYM_TYPE_DUMBBELLS,E_GYM_TYPE_DUMBBELLS_2: {

				if ( PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_BENCHP_DOWN ||
					PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] == E_GYM_ANIM_STAGE_DUMBB_DOWN  ) {

					PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] += 5.50 ;
					PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] = gettime() ; // adding 1 second margin to check
					PlayerVar [ playerid ] [ E_PLAYER_GYM_MACHINE_IDLE_TICK ] = gettime();


					if ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] >= 100.0 ) {

						PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 100.0 ;
					}
					SetPlayerProgressBarValue(playerid, HUD_GYM_BAR [ playerid ], PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ]);
				}
			}

			case E_GYM_TYPE_TREADMILL, E_GYM_TYPE_BICYCLE: {
				PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] += 5.50 ;
				PlayerVar [ playerid ] [ E_PLAYER_GYM_LAST_ACTION_DONE ] = gettime() ; // adding 1 second margin to check
				PlayerVar [ playerid ] [ E_PLAYER_GYM_MACHINE_IDLE_TICK ] = gettime();

				if ( PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] >= 100.0 ) {

					PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 100.0 ;
				}
				SetPlayerProgressBarValue(playerid, HUD_GYM_BAR [ playerid ], PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ]);
			}
		}
	}
}

Gym_ExitMachine(playerid, type, key=false, anim=true) {
	
	stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;

	if ( !PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) {

		return false ;
	}

	PlayerVar [ playerid ] [ E_PLAYER_GYM_COOLDOWN ] = gettime() + 5 ;


	TogglePlayerControllable(playerid, true);

	SetCameraBehindPlayer(playerid);
	defer HidePlayerInfoMessage[5000](playerid);
	Gym_HideHUD(playerid);

	if ( anim ) {
		switch ( type) {

			case E_GYM_TYPE_TREADMILL,E_GYM_TYPE_TREADMILL_2: {
				if ( key ) {
					ApplyAnimation(playerid, "gymnasium", "gym_tread_getoff", 4.1, 0, 0, 0, 0, 0, 1 );
				}

				else {

					ApplyAnimation(playerid, "gymnasium", "gym_tread_falloff", 4.1, 0, 0, 0, 0, 0, 1 );
				}

				PlayerPlaySound(playerid, 0, 0, 0, 0);
			}

			case E_GYM_TYPE_BICYCLE,E_GYM_TYPE_BICYCLE_2: {

				ApplyAnimation(playerid, "gymnasium", "gym_bike_getoff", 4.1, 0, 0, 0, 0, 0, 1 );
				PlayerPlaySound(playerid, 0, 0, 0, 0);
			}

			case E_GYM_TYPE_BENCHPRESS,E_GYM_TYPE_BENCHPRESS_2: {
				ApplyAnimation(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1 );
				defer Gym_SyncExitAnim[1500](playerid, type);
			}
			case E_GYM_TYPE_DUMBBELLS,E_GYM_TYPE_DUMBBELLS_2: {
				ApplyAnimation(playerid, "freeweights", "gym_free_putdown", 4.1, 0, 0, 0, 0, 0, 1 );
				defer Gym_SyncExitAnim[1200](playerid, type);
			}
		}
	}

	else if (! anim ) {

		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);

		cmd_stopanim(playerid, "");
	}

	PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS ] = 0.0 ;
	PlayerGym [ playerid ] [ E_GYM_PROGRESS_STATUS ] = 0 ;


	switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ] ) {


		case E_GYM_TYPE_BENCHPRESS: {	
			switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] ) {

				case E_GYM_LOCATION_LS: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LS_GYM_BENCHPRESS_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_BEACH: Streamer_SetIntData(STREAMER_TYPE_OBJECT, BEACH_GYM_BENCHPRESS_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_BENCHPRESS_OBJECT1, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_BENCHPRESS_OBJECT1, E_STREAMER_WORLD_ID, -1);
			}
		}

		case E_GYM_TYPE_BENCHPRESS_2: {	
			switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] ) {

				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_BENCHPRESS_OBJECT2, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_BENCHPRESS_OBJECT2, E_STREAMER_WORLD_ID, -1);
			}
		}

		case E_GYM_TYPE_DUMBBELLS: {		

			switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] ) {
				case E_GYM_LOCATION_LS: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LS_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_BEACH: Streamer_SetIntData(STREAMER_TYPE_OBJECT, BEACH_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_DUMBBELL_OBJECT1, E_STREAMER_WORLD_ID, -1);
			}
		}


		case E_GYM_TYPE_DUMBBELLS_2: {		

			switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] ) {
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_DUMBBELL_OBJECT2, E_STREAMER_WORLD_ID, -1);
			}
		}
	}

	PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ]  = E_GYM_TYPE_NONE ;
	PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] = -1 ;
	PlayerGym [ playerid ] [ E_GYM_ANIM_COOLDOWN ] = E_GYM_ANIM_STAGE_NONE ;

	Gym_SaveVariables(playerid);
	PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] = false ;
	stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;

	return true ;
}

timer Gym_SyncExitAnim[1500](playerid, type) {

	//#warning The timer in PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] does not "stop". Make it a defer timer.
	// This was caused by the "timerfix" plugin. Do not use it - incompatible with our current version of Y_TIMERS.

	stop PlayerGym [ playerid ] [ E_PLAYER_GYM_PROGRESS_TICK ] ;
	switch ( type ) {
		case E_GYM_TYPE_BENCHPRESS: {
			PlayerPlaySound(playerid, 17807, 0, 0, 0);

			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_LS: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LS_GYM_BENCHPRESS_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_BENCHPRESS_OBJECT1, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_SF: { }
				case E_GYM_LOCATION_BEACH: Streamer_SetIntData(STREAMER_TYPE_OBJECT, BEACH_GYM_BENCHPRESS_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_BENCHPRESS_OBJECT1, E_STREAMER_WORLD_ID, -1);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
		}

		case E_GYM_TYPE_BENCHPRESS_2: {
			PlayerPlaySound(playerid, 17807, 0, 0, 0);

			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_BENCHPRESS_OBJECT2, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_BENCHPRESS_OBJECT2, E_STREAMER_WORLD_ID, -1);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);	
		}

		case E_GYM_TYPE_DUMBBELLS: {

			PlayerPlaySound(playerid, 17807, 0, 0, 0);
			switch ( Gym_IsPlayerInGym(playerid) ) {

				case E_GYM_LOCATION_LS: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LS_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_LV: Streamer_SetIntData(STREAMER_TYPE_OBJECT, LV_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_SF: { }
				case E_GYM_LOCATION_BEACH: Streamer_SetIntData(STREAMER_TYPE_OBJECT, BEACH_GYM_DUMBBELL_OBJECT, E_STREAMER_WORLD_ID, -1);
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_DUMBBELL_OBJECT1, E_STREAMER_WORLD_ID, -1);
			}
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);

		}

		case E_GYM_TYPE_DUMBBELLS_2: {		

			PlayerPlaySound(playerid, 17807, 0, 0, 0);
			switch ( PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] ) {
				case E_GYM_LOCATION_GANTON: Streamer_SetIntData(STREAMER_TYPE_OBJECT, GANTON_GYM_DUMBBELL_OBJECT2, E_STREAMER_WORLD_ID, -1);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);
		}
	}
	return true ;
}