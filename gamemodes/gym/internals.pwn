
Gym_StatsUpdate(playerid) {

	/*
		Energy is replenished 2 every 15 minutes
		After 20 exp gain 1 energy is removed
		You gain 1 exp per rep, so you can do 20 reps before you lose energy
	*/

	// Replenishing energy
	if ( Character [ playerid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ] < gettime () ) {

		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] ++ ;

		if ( Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] >= 25 ) {

			Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] = 25 ;
		}

		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ] = gettime () + 900; // 15 minutes
		Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_ENERGY, true);

		Gym_SaveVariables ( playerid ); 
	}


	/*
		Hunger and thirst goes up 1-3 every 30 minutes.
	*/

	// Adding hunger / thirst over time.
	if ( Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ] < gettime () ) {

		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] += 1 + random(2) ;

		if ( Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ]  >= 25 ) {

			Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] = 25 ;
		}

		Gym_SaveVariables ( playerid ); 

		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ] = gettime () + 1800; // 30 minutes
		Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_HUNGER, true);
	}	

	if ( Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ] < gettime () ) {

		Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] += 1 + random(2) ;

		if ( Character [ playerid ] [ E_CHARACTER_GYM_THIRST ]  >= 25 ) {

			Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] = 25 ;
		}


		Gym_SaveVariables ( playerid ); 

		Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ] = gettime () + 1800; // 30 minutes
		Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_THIRST, true);
	}


	/*
		You lose experience in muscle per 60 minutes.
		If muscle exp is below previous, lose muscle.

		Weight is added from eating food.
		Weight is lost from training.

	*/

	if ( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ] < gettime() ) {
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ] = gettime () + 3600; // 60 minutes

		new oldlevel = Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] ;

		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ] -- ; // reduce exp

		if ( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ] < 1 ) { // if exp < 1, reset to 1
			Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] -- ; // lower muscle
			Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ] = Gym_GetRemainingExp( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] ) ;
			
			// make sure to reset muscle properly incase its < 0
			if ( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] <= 0 ) {
				Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] = 0 ;
			}
		}

		Gym_SaveVariables ( playerid ); 

		// If muscle is below the previous level, update for player
		if ( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] < oldlevel ) {
			Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_MUSCLE, false );
		}
	}

}


Gym_PlayerNeedsAlterWeight(playerid) {

	Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ] -- ;

	if ( Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ] <= 0 ) {
		
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] ++ ; // Increase weight after xp hits zero

		// Set experience to the remaining EXP of the weight.
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ] = Gym_GetRemainingExp(Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ]) ; 


		// this prevents hunger from updating weight by large margin (max 1) whilst this is ongoing!
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ] = gettime () + 3600; // 60 minutes

		Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_WEIGHT, true);

		if ( Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] >= 25 ) {

			Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] = 25 ;
		}
	}

	return true ;
}

Gym_ApplyExperience(playerid, stat) {


	if ( Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] <= 1 ) {

		ShowPlayerInfoMessage(playerid, 
			"You have ran out of energy. You can't continue using the gym, wait for it to refill!", 
			.showtime=6500, .height=167.5
		);

		Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], true); // reset variables!
		return true ;
	}

	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_DEVELOPER ) {

		SendClientMessage(playerid, COLOR_YELLOW, sprintf("DEV DEBUG: Exp gain cooldown remaining %d seconds", (PlayerVar [ playerid ] [ E_PLAYER_GYM_DETERRENT ]-gettime())));
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_DETERRENT ] < gettime () ) {

		PlayerVar [ playerid ] [ E_PLAYER_GYM_DETERRENT ] = gettime () + 7 ; // Able to get exp every 7s

		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] -- ;

		switch ( stat ) {

			case E_GYM_STAT_MUSCLE: {
				Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ] ++ ;

				if ( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ] >= Gym_GetRemainingExp (Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] )) {
					Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ] = 0 ;
				
					Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] ++ ;
					Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ] = gettime () + 3600; // 60 minutes
					Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_MUSCLE, true);

					if ( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] >= 25 ) {

						Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] = 25 ;
					}
				}

				SendClientMessage(playerid, COLOR_GRAD0, "You've progressed your muscle level through working out.");
				SendClientMessage(playerid, COLOR_GREEN, 
					sprintf("Total exp: (%d/%d). Current Level: %d (energy left: %d)",
						Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ],  
						Gym_GetRemainingExp (Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] ), 
						Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ], 
						Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] 
				));

			}

			case E_GYM_STAT_WEIGHT: {
				Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ] ++ ;

				if ( Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ] >= Gym_GetRemainingExp (Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] )) {
					Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ] = 0 ;
				
					Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] -- ;
					Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ] = gettime () + 3600; // 60 minutes
					// this prevents hunger from updating weight by large margin (max 1) whilst this is ongoing!
					Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_WEIGHT, false);

					if ( Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] <= 1 ) {

						Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] = 1 ;
					}
				}

				SendClientMessage(playerid, COLOR_GRAD0, "You've decreased your weight (fat) through working out.");
				SendClientMessage(playerid, COLOR_GREEN, 
					sprintf("Total exp: (%d/%d). Current Level: %d (energy left: %d)",
					Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ],  Gym_GetRemainingExp (Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] ), 
					Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ], Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] 
				));
			}
		}
	}

	Gym_SaveVariables(playerid);

	return true ;
}


Gym_GetRemainingExp(level) {

	new exp;
	switch ( level ) {

		case 0: exp = 6 ;
		case 1: exp = 12 ;
		case 2: exp = 18 ;
		case 3: exp = 24 ;
		case 4: exp = 30 ;
		case 5: exp = 36 ;
		case 6: exp = 42 ;
		case 7: exp = 48 ;
		case 8: exp = 54 ;
		case 9: exp = 60 ;
		case 10: exp = 66 ;
		case 11: exp = 72 ;
		case 12: exp = 78 ;
		case 13: exp = 84 ;
		case 14: exp = 90 ;
		case 15: exp = 96 ;
		case 16: exp = 102 ;
		case 17: exp = 108 ;
		case 18: exp = 114 ;
		case 19: exp = 120 ;
		case 20: exp = 126 ;
		case 21: exp = 132 ;
		case 22: exp = 138 ;
		case 23: exp = 144 ;
		case 24: exp = 150 ;
		case 25: exp = 156 ;
	}
	return exp;
}

Gym_SetupDefaultVariables(playerid) {

	if ( ! Character [ playerid ] [ E_CHARACTER_GYM_SETUP ] ) {

		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] = 25 ; 
		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ] = gettime () + 900; // 15 minutes
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] = 3 ;
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ]  = gettime () + 3600; // 60 minutes
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] = 1 ;
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ]  = gettime () + 3600; // 60 minutes
		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] = 5 ;
		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ]  = gettime () + 1800; // 30 minutes
		Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] = 5 ;
		Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ]  = gettime () + 1800; // 30 minutes


		// All people default start with normal fightstyle.
		Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ] = FIGHT_STYLE_NORMAL ;
		Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] = 0 ;
		SetPlayerFightingStyle(playerid, Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ] );


		Gym_SaveVariables(playerid);

		if (IsPlayerPlaying(playerid))
		{
			SendClientMessage ( playerid, COLOR_INFO, "Your gym statistics have been altered. Use ~k~~PED_SPRINT~ and ~k~~PED_DUCK~ to open the menu.");
		}
		
			
		Character [ playerid ] [ E_CHARACTER_GYM_SETUP ] = 1 ;

		new query [ 256 ] ;
		mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_gym_setup = 1 WHERE player_id = %d",
			Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, query);
	}
}	

Gym_SaveVariables(playerid) {

	new query [ 1024 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_gym_energy = %d, player_gym_energy_internal = %d, player_gym_weight = %d, player_gym_weight_internal = %d, player_gym_weight_xp=%d WHERE player_id=%d",

		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] ,
		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ] ,
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] ,
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ],
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	);


	mysql_tquery(mysql, query);

	query [ 0 ] = EOS ;
	
	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_gym_muscle = %d, player_gym_muscle_internal = %d, player_gym_muscle_xp=%d, player_gym_hunger = %d, player_gym_hunger_internal = %d WHERE player_id=%d",
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] ,
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ],
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ],
		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ],
		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);
	
	query [ 0 ] = EOS ;
	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_gym_thirst = %d, player_gym_thirst_internal = %d, player_fightstyle = %d, player_fightstyle_tick = %d WHERE player_id=%d",

		Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] ,
		Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ],
		Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ],
		Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] ,
		Character [ playerid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);

	
	SetPlayerFightingStyle(playerid, Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ] );
}
