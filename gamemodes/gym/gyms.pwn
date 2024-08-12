Gym_CheckGymLocation(playerid) {
	new machine_type = E_GYM_TYPE_NONE ;
	new area_type = E_GYM_LOCATION_NONE ;

	new Float: null, Float: player_z_pos ;
	GetPlayerPos ( playerid, null, null, player_z_pos ) ;

	// Ganton Gym
	if ( IsPlayerInDynamicArea(playerid, LS_GYM_TREADMILL_AREA ) ) {
		machine_type = E_GYM_TYPE_TREADMILL ;
		area_type = E_GYM_LOCATION_LS ;
	}
	else if ( IsPlayerInDynamicArea(playerid, LS_GYM_BICYCLE_AREA ) ) {
		machine_type = E_GYM_TYPE_BICYCLE ;
		area_type = E_GYM_LOCATION_LS ;
	}
	else if ( IsPlayerInDynamicArea(playerid, LS_GYM_BENCHPRESS_AREA ) ) {
		machine_type = E_GYM_TYPE_BENCHPRESS ;
		area_type = E_GYM_LOCATION_LS ;
	}
	else if ( IsPlayerInDynamicArea(playerid, LS_GYM_DUMBBELL_AREA ) ) {
		machine_type = E_GYM_TYPE_DUMBBELLS ;
		area_type = E_GYM_LOCATION_LS ;
	}

	// Beach Gym
	if ( IsPlayerInDynamicArea(playerid, BEACH_GYM_TREADMILL_AREA ) ) {
		machine_type = E_GYM_TYPE_TREADMILL ;
		area_type = E_GYM_LOCATION_BEACH ;
	}
	else if ( IsPlayerInDynamicArea(playerid, BEACH_GYM_BICYCLE_AREA ) ) {
		machine_type = E_GYM_TYPE_BICYCLE ;
		area_type = E_GYM_LOCATION_BEACH ;
	}
	else if ( IsPlayerInDynamicArea(playerid, BEACH_GYM_BENCHPRESS_AREA ) ) {
		machine_type = E_GYM_TYPE_BENCHPRESS ;
		area_type = E_GYM_LOCATION_BEACH ;
	}
	else if ( IsPlayerInDynamicArea(playerid, BEACH_GYM_DUMBBELL_AREA ) ) {
		machine_type = E_GYM_TYPE_DUMBBELLS ;
		area_type = E_GYM_LOCATION_BEACH ;
	}

	else if ( IsPlayerInDynamicArea(playerid, LV_GYM_TREADMILL_AREA	) ) {
		machine_type = E_GYM_TYPE_TREADMILL ;
		area_type = E_GYM_LOCATION_LV ;
	}	
	else if ( IsPlayerInDynamicArea(playerid, LV_GYM_BICYCLE_AREA ) ) {
		machine_type = E_GYM_TYPE_BICYCLE ;
		area_type = E_GYM_LOCATION_LV ;
	}
	else if ( IsPlayerInDynamicArea(playerid, LV_GYM_BENCHPRESS_AREA1 ) ) {
		machine_type = E_GYM_TYPE_BENCHPRESS ;
		area_type = E_GYM_LOCATION_LV ;
	}
	else if ( IsPlayerInDynamicArea(playerid, LV_GYM_BENCHPRESS_AREA2 ) ) {
		machine_type = E_GYM_TYPE_BENCHPRESS_2 ;
		area_type = E_GYM_LOCATION_LV ;
	}	
	else if ( IsPlayerInDynamicArea(playerid, LV_GYM_DUMBBELL_AREA ) ) {
		machine_type = E_GYM_TYPE_DUMBBELLS ;
		area_type = E_GYM_LOCATION_LV ;
	}	


	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_TREADMILL_AREA1 )) {
		if ( player_z_pos  < 15.0 ) {
			machine_type = E_GYM_TYPE_TREADMILL ;
			area_type = E_GYM_LOCATION_GANTON ;
		}

	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_TREADMILL_AREA2 )) {
		if ( player_z_pos  < 15.0 ) {
			machine_type = E_GYM_TYPE_TREADMILL_2 ;
			area_type = E_GYM_LOCATION_GANTON ;
		}

	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_BICYCLE_AREA1 )) {
		if ( player_z_pos  > 15.0 ) {
			machine_type = E_GYM_TYPE_BICYCLE ;
			area_type = E_GYM_LOCATION_GANTON ;
		}	

	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_BICYCLE_AREA2 	)) {
		if ( player_z_pos  > 15.0 ) {
			machine_type = E_GYM_TYPE_BICYCLE_2 ;
			area_type = E_GYM_LOCATION_GANTON ;
		}	

	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_BENCHPRESS_AREA1 )) {
		if ( player_z_pos > 15.0 ) {
			machine_type = E_GYM_TYPE_BENCHPRESS ;
			area_type = E_GYM_LOCATION_GANTON ;
		}
	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_BENCHPRESS_AREA2 )) {
		if ( player_z_pos > 15.0 ) {
			machine_type = E_GYM_TYPE_BENCHPRESS_2 ;
			area_type = E_GYM_LOCATION_GANTON ;
		}
	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_DUMBBELL_AREA1 )) {
		if ( player_z_pos  < 15.0 ) {
			machine_type = E_GYM_TYPE_DUMBBELLS ;
			area_type = E_GYM_LOCATION_GANTON ;
		}
	}
	else if ( IsPlayerInDynamicArea(playerid, GANTON_GYM_DUMBBELL_AREA2)) {
		if ( player_z_pos  < 15.0 ) {
			machine_type = E_GYM_TYPE_DUMBBELLS_2 ;
			area_type = E_GYM_LOCATION_GANTON ;
		}
	}

	if ( machine_type != E_GYM_TYPE_NONE ) {

		Gym_SetupVariables(playerid, machine_type, area_type ) ;
	}
}


Gym_SetupVariables(playerid, machine_type, area) {
	if ( PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) {

		Gym_ExitMachine(playerid, machine_type, true);
	}

	else if ( !PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] ) { 

		new bool: machine_used = false ;

		foreach(new gym_user: Player) {

			if ( IsPlayerSpawned ( gym_user) && IsPlayerLogged ( gym_user ) ) {

				if ( PlayerGym [ gym_user ] [ E_PLAYER_USING_GYM ] ) {

					if ( PlayerGym [ gym_user ] [ E_PLAYER_GYM_MACHINE_AREA ] == area ) {

						if ( PlayerGym [ gym_user ] [ E_PLAYER_GYM_MACHINE_TYPE ] == machine_type ) {
							machine_used = true ;
						}

						else continue ;
					}

					else continue ;
				}

				else continue ;
			}
			else continue ;

		}

		if ( machine_used ) {
			return SendClientMessage ( playerid, COLOR_ERROR, "This machine is already being used. Try again later!");
		}

		switch ( machine_type ) {

			case E_GYM_TYPE_TREADMILL : {

				switch ( area ) {
					case E_GYM_LOCATION_LS: {

						SetPlayerCameraPos(playerid, 774.5929, -4.9924, 1001.2608);
						SetPlayerCameraLookAt(playerid, 774.1505, -4.0972, 1001.0863);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  773.5308, -1.0291, 1000.6784 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_TREADMILL, 773.5308, -1.0291, 1000.6784 );
						SetPlayerFacingAngle(playerid, 180);
					}
					case E_GYM_LOCATION_BEACH: {

						SetPlayerCameraPos(playerid, 657.0516, -1871.5090, 5.3537);
						SetPlayerCameraLookAt(playerid, 657.9062, -1870.9904, 5.3740);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  661.3871, -1869.5911, 5.1775 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_TREADMILL, 661.3871, -1869.5911, 5.1775 );
						SetPlayerFacingAngle(playerid, 90);
					}
					case E_GYM_LOCATION_LV: {

						SetPlayerCameraPos(playerid, 760.1442, -68.4077, 1001.1166);
						SetPlayerCameraLookAt(playerid, 759.6499, -67.5399, 1000.9022);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  758.3740,-64.0881,1000.6528 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_TREADMILL, 758.3740,-64.0881,1000.6528 );
						SetPlayerFacingAngle(playerid, 180);
					}

					case E_GYM_LOCATION_GANTON: {
						SetPlayerCameraPos(playerid, 2237.1746, -1699.8431, 13.7200);
						SetPlayerCameraLookAt(playerid, 2236.3677, -1700.4302, 13.5849);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2233.0776,-1701.8483, 13.5314 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_TREADMILL, 2233.0776,-1701.8483, 13.5314 );
						SetPlayerFacingAngle(playerid, 270);

					}
				}
			}
			case E_GYM_TYPE_TREADMILL_2 : {

				switch ( area ) {
					case E_GYM_LOCATION_GANTON: {
						SetPlayerCameraPos(playerid, 2236.9224, -1705.9122, 13.6947);
						SetPlayerCameraLookAt(playerid, 2236.1030, -1706.4817, 13.5897);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,2233.0139,-1707.9719, 13.5314 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_TREADMILL,2233.0139,-1707.9719,13.5314 );
						SetPlayerFacingAngle(playerid, 270);

					}
				}
			}

			case E_GYM_TYPE_BICYCLE: {				
				switch ( area ) {
					case E_GYM_LOCATION_LS: {
	
						SetPlayerCameraPos(playerid, 770.4507, 6.9657, 1000.5566);
						SetPlayerCameraLookAt(playerid, 770.9837, 7.8102, 1000.5074);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  772.7556,8.8882,1000.7065 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BICYCLE, 772.7556,8.8882,1000.7065 );
						SetPlayerFacingAngle(playerid, 90);

					}
					case E_GYM_LOCATION_BEACH: {

						SetPlayerCameraPos(playerid, 660.9541, -1866.1726, 5.0874);
						SetPlayerCameraLookAt(playerid, 660.3044, -1865.4131, 5.0777);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  659.8035,-1863.9368,5.4609 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BICYCLE, 659.8035,-1863.9368,5.4609 );
						SetPlayerFacingAngle(playerid, 180);

					}
					case E_GYM_LOCATION_LV: {

						SetPlayerCameraPos(playerid, 772.2688, -70.4746, 1000.9003);
						SetPlayerCameraLookAt(playerid, 773.0762, -69.8866, 1000.8307);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  775.0065,-69.1643,1000.6543 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BICYCLE, 775.0065,-69.1643,1000.6543 );
						SetPlayerFacingAngle(playerid, 90);

					}

					case E_GYM_LOCATION_GANTON: {
						SetPlayerCameraPos(playerid, 2232.3936, -1714.2671, 17.0415);
						SetPlayerCameraLookAt(playerid, 2231.7683, -1715.0449, 16.9565);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2230.6382,-1715.9635,17.1952 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BICYCLE, 2230.6382,-1715.9635,17.1952 );
						SetPlayerFacingAngle(playerid, 270);
					}
				}
			}

			case E_GYM_TYPE_BICYCLE_2: {				
				switch ( area ) {

					case E_GYM_LOCATION_GANTON: {
						SetPlayerCameraPos(playerid, 2233.0757, -1707.3693, 17.3238);
						SetPlayerCameraLookAt(playerid, 2232.4329, -1708.1332, 17.1738);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2230.6792,-1709.8289,17.1952 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BICYCLE, 2230.6792,-1709.8289,17.1952 );
						SetPlayerFacingAngle(playerid, 270);
					}
				}
			}

			case E_GYM_TYPE_BENCHPRESS: {				
				switch ( area ) {
					case E_GYM_LOCATION_LS: {

						SetPlayerCameraPos(playerid, 771.5958, 1.5447, 1001.8984);
						SetPlayerCameraLookAt(playerid, 772.5945, 1.5482, 1001.2219);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  772.8870,1.4399,1000.7209 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BENCHPRESS, 772.8870,1.4399,1000.7209 );
						SetPlayerFacingAngle(playerid, 270);

					}
					case E_GYM_LOCATION_BEACH: {

						SetPlayerCameraPos(playerid, 653.9464, -1866.5159, 5.6205);
						SetPlayerCameraLookAt(playerid, 653.9478, -1865.5164, 5.3958);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid, 653.9518,-1865.0546,5.4609 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BENCHPRESS, 653.9518,-1865.0546,5.4609 );
						SetPlayerFacingAngle(playerid, 0);

					}
					case E_GYM_LOCATION_LV: {

						SetPlayerCameraPos(playerid, 768.6609, -62.7516, 1001.4009);
						SetPlayerCameraLookAt(playerid, 768.6497, -61.7529, 1001.1161);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  768.5549,-60.4980,1000.6563 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BENCHPRESS, 768.5549,-60.4980,1000.6563 );		
						SetPlayerFacingAngle(playerid, 0);	

					}
					case E_GYM_LOCATION_GANTON: {

						SetPlayerCameraPos(playerid, 2243.4622, -1699.1917, 17.7198);
						SetPlayerCameraLookAt(playerid, 2243.4363, -1698.1942, 17.6048);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2243.4382,-1695.8607,17.1952 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BENCHPRESS, 2243.4382,-1695.8607,17.1952 );		
						SetPlayerFacingAngle(playerid, 0);	
					}
				}
			}
			case E_GYM_TYPE_BENCHPRESS_2: {
				switch ( area ) {
					case E_GYM_LOCATION_LV: {

						SetPlayerCameraPos(playerid, 764.9158, -62.7597, 1001.4009);
						SetPlayerCameraLookAt(playerid, 764.8985, -61.7611, 1001.1011);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  764.8727,-60.8967,1000.6563 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BENCHPRESS_2, 764.8727,-60.8967,1000.6563 );
						SetPlayerFacingAngle(playerid, 0);
					}
					case E_GYM_LOCATION_GANTON: {

						SetPlayerCameraPos(playerid, 2235.1323, -1699.0880, 17.7198);
						SetPlayerCameraLookAt(playerid, 2235.1318, -1698.0901, 17.5848);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2235.2026,-1695.9164,17.1952 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_BENCHPRESS_2, 2235.2026,-1695.9164,17.1952 );
						SetPlayerFacingAngle(playerid, 0);
					}
				}
			}

			case E_GYM_TYPE_DUMBBELLS: {				
				switch ( area ) {
					case E_GYM_LOCATION_LS: {

						SetPlayerCameraPos(playerid, 775.8257, 5.3062, 1001.4611);
						SetPlayerCameraLookAt(playerid, 774.8271, 5.3044, 1001.0967);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  772.0784, 5.3704, 1000.3983 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_DUMBBELLS, 772.0784, 5.3704, 1000.3983 );
						SetPlayerFacingAngle(playerid, 270);

					}

					case E_GYM_LOCATION_BEACH: {
						SetPlayerCameraPos(playerid, 657.1807, -1869.5812, 5.5981);
						SetPlayerCameraLookAt(playerid, 656.1824, -1869.5773, 5.4134);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid, 653.0922,-1869.6189,5.5537 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_DUMBBELLS, 653.0922,-1869.6189,5.5537 );
						SetPlayerFacingAngle(playerid, 270);
					}

					case E_GYM_LOCATION_LV: {

						SetPlayerCameraPos(playerid, 759.0587, -64.3321, 1001.3001);
						SetPlayerCameraLookAt(playerid, 759.0669, -63.3333, 1001.0203);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid, 759.0900,-59.2300,1000.7802 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_DUMBBELLS, 759.0900,-59.2300,1000.7802 );
						SetPlayerFacingAngle(playerid, 180);


					}
					case E_GYM_LOCATION_SF: { }

					case E_GYM_LOCATION_GANTON: {
						SetPlayerCameraPos(playerid, 2245.6282, -1693.1572, 14.0885);
						SetPlayerCameraLookAt(playerid, 2245.6372, -1694.1558, 13.9835);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2245.6873,-1697.5076,13.6296 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_DUMBBELLS, 2245.6873,-1697.5076,13.6296 );
						SetPlayerFacingAngle(playerid, 0);
					}
				}
			}

			case E_GYM_TYPE_DUMBBELLS_2: {				
				switch ( area ) {
					case E_GYM_LOCATION_GANTON: {

						SetPlayerCameraPos(playerid, 2240.1909, -1693.8199, 13.8885);
						SetPlayerCameraLookAt(playerid, 2240.1841, -1694.8188, 13.7685);

						PauseAC(playerid, 3);
						SetPlayerPos(playerid,  2240.1960,-1697.2085,13.6135 + 5);
						defer Gym_SyncPosition(playerid, E_GYM_TYPE_DUMBBELLS_2, 2240.1960,-1697.2085,13.6135 );
						SetPlayerFacingAngle(playerid, 0);
					}
				}
			}
		}

		PlayerGym [ playerid ] [ E_PLAYER_USING_GYM ] = true ;
		PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_AREA ] = area ;

		TogglePlayerControllable(playerid, false);
	}

	return true ;
}
