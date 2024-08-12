#include "hunger/food/header.pwn"
#include "hunger/vending/header.pwn"


Gym_AppendPlayerNeeds(playerid, stat, modifier = 1) {
	// This function is used to decrease hunger and thirst after consumption.
	// After a player eats, their internals are reset to 30 min to avoid the script sanctioning them x seconds after eating!

	if ( modifier < 0 ) {

		modifier = 1 ;
	}

	modifier += random (2 ) ; // randomized between 1-3

	switch ( stat ) {
		case E_GYM_STAT_HUNGER: {
			
			Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] -= modifier ;

			if ( Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] <= 1 ) {
				Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] = 1 ;
			}

			switch(random(2)) {

				case 1: {
					Gym_PlayerNeedsAlterWeight(playerid) ;
					Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_HUNGER, false);
				}
			}

			Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ] = gettime () + 1800; // 30 minutes
		}
		case E_GYM_STAT_THIRST: {
			Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] -= modifier ;

			if ( Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] <= 1 ) {
				Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] = 1 ;
			}

			switch(random(2)) {

				case 1: {
					Gym_PlayerNeedsAlterWeight(playerid) ;
					Gym_DisplayStatsUpdate(playerid, E_GYM_STAT_THIRST, false);
				}
			}

			Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ] = gettime () + 1800; // 30 minutes
		}
	}

	
	Gym_SaveVariables(playerid);

	return true ;
}