enum E_PLAYER_GYM_VARS {

	bool: E_PLAYER_USING_GYM,
	E_PLAYER_MACHINE_TIME_SPENT,
	E_PLAYER_GYM_MACHINE_TYPE,
	E_PLAYER_GYM_MACHINE_AREA,
	Float: E_PLAYER_GYM_PROGRESS,
	Timer: E_PLAYER_GYM_PROGRESS_TICK,
	E_GYM_PROGRESS_STATUS,// dist, reps, ...
	E_GYM_ANIM_COOLDOWN// syncs animation rythm
} ;

new PlayerGym [ MAX_PLAYERS ] [ E_PLAYER_GYM_VARS ] ;

enum {

	E_GYM_TYPE_NONE,
	E_GYM_TYPE_TREADMILL = 1,
	E_GYM_TYPE_TREADMILL_2,
	E_GYM_TYPE_BICYCLE,
	E_GYM_TYPE_BICYCLE_2,
	E_GYM_TYPE_BENCHPRESS,
	E_GYM_TYPE_BENCHPRESS_2,
	E_GYM_TYPE_DUMBBELLS,
	E_GYM_TYPE_DUMBBELLS_2,
}

enum {
	E_GYM_LOCATION_NONE = 0,
	E_GYM_LOCATION_LS = 1,
	E_GYM_LOCATION_LV,
	E_GYM_LOCATION_SF,
	E_GYM_LOCATION_BEACH,
	E_GYM_LOCATION_GANTON
} ;

new LS_GYM_DUMBBELL_OBJECT ;
new LS_GYM_BENCHPRESS_OBJECT ;
new LS_GYM_TREADMILL_AREA ;
new LS_GYM_BICYCLE_AREA ;
new LS_GYM_BENCHPRESS_AREA ;
new LS_GYM_DUMBBELL_AREA ;

new BEACH_GYM_BENCHPRESS_OBJECT ;
new BEACH_GYM_DUMBBELL_OBJECT ;
new BEACH_GYM_TREADMILL_AREA ;
new BEACH_GYM_BICYCLE_AREA ;
new BEACH_GYM_BENCHPRESS_AREA ;
new BEACH_GYM_DUMBBELL_AREA ;

new LV_GYM_BENCHPRESS_OBJECT1 ;
new LV_GYM_BENCHPRESS_OBJECT2 ;
new LV_GYM_DUMBBELL_OBJECT ;
new LV_GYM_TREADMILL_AREA ;
new LV_GYM_BICYCLE_AREA ;
new LV_GYM_BENCHPRESS_AREA1 ;
new LV_GYM_BENCHPRESS_AREA2 ;
new LV_GYM_DUMBBELL_AREA ;


new GANTON_GYM_BENCHPRESS_OBJECT1 ;
new GANTON_GYM_BENCHPRESS_OBJECT2 ;
new GANTON_GYM_DUMBBELL_OBJECT1 ;
new GANTON_GYM_DUMBBELL_OBJECT2 ;

new GANTON_GYM_BENCHPRESS_AREA1 ;
new GANTON_GYM_BENCHPRESS_AREA2 ;
new GANTON_GYM_DUMBBELL_AREA1 ;
new GANTON_GYM_DUMBBELL_AREA2 ;
new GANTON_GYM_TREADMILL_AREA1 ;
new GANTON_GYM_TREADMILL_AREA2 ;
new GANTON_GYM_BICYCLE_AREA1 ;
new GANTON_GYM_BICYCLE_AREA2 ;






forward Float: Gym_GetProgressBarValue(level);


#include "gym/gui.pwn"
#include "gym/gyms.pwn"
#include "gym/usage.pwn"
#include "gym/hud.pwn"
#include "gym/stats.pwn"
#include "gym/internals.pwn"



CMD:spoofgymstat(playerid, params[]) {

	new targetid, id, amount ;

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( sscanf  ( params, "k<player>ii", targetid, id, amount ) ) {


		SendClientMessage(playerid, -1, "/spoofgymstat [target] [id] [amount]" ) ;

		SendClientMessage(playerid, COLOR_RED, "Gym Stat IDs:");

		SendClientMessage(playerid, COLOR_YELLOW, "0 [Energy]");
		SendClientMessage(playerid, COLOR_YELLOW, "1 [Energy Internal]");
		SendClientMessage(playerid, COLOR_YELLOW, "2 [Weight] ");
		SendClientMessage(playerid, COLOR_YELLOW, "3 [Weight XP]}");
		SendClientMessage(playerid, COLOR_YELLOW, "4 [Weight Internal]");
		SendClientMessage(playerid, COLOR_YELLOW, "5 [Muscle] ");
		SendClientMessage(playerid, COLOR_YELLOW, "6 [Muscle XP]}");
		SendClientMessage(playerid, COLOR_YELLOW, "7 [Muscle Internal]");
		SendClientMessage(playerid, COLOR_YELLOW, "8 [Hunger]");
		SendClientMessage(playerid, COLOR_YELLOW, "9 [Hunger Internal]");
		SendClientMessage(playerid, COLOR_YELLOW, "10 [Thirst]");
		SendClientMessage(playerid, COLOR_YELLOW, "11 [Thirst Internal]");

		return true ;
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendClientMessage(playerid, -1, "PLAYERID isn't connected." ) ;
	}

	switch(id ) {
		case 0: Character [ targetid ] [ E_CHARACTER_GYM_ENERGY ] = amount ;
		case 1: Character [ targetid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ] = amount ;
		case 2: Character [ targetid ] [ E_CHARACTER_GYM_WEIGHT ] = amount ;
		case 3: Character [ targetid ] [ E_CHARACTER_GYM_WEIGHT_XP ] = amount ;
		case 4: Character [ targetid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ] = amount ;
		case 5: Character [ targetid ] [ E_CHARACTER_GYM_MUSCLE ] = amount ;
		case 6: Character [ targetid ] [ E_CHARACTER_GYM_MUSCLE_XP ] = amount ;
		case 7: Character [ targetid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ] = amount ;
		case 8: Character [ targetid ] [ E_CHARACTER_GYM_HUNGER ] = amount ;
		case 9: Character [ targetid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ] = amount ;
		case 10: Character [ targetid ] [ E_CHARACTER_GYM_THIRST ] = amount ;
		case 11: Character [ targetid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ] = amount ;
	}
	
	SendClientMessage(playerid, COLOR_BLUE, sprintf("You've set target ID %d's gym stat ID %d to %d.", targetid, id, amount ) ) ;
	SendClientMessage(targetid, COLOR_INFO, sprintf("A developer has set your gym stat ID %d to %d", id, amount ) ) ;

	Gym_SaveVariables(targetid);

	return true ;
}


CMD:gymstats(playerid) {


	for ( new i, j = sizeof ( E_GYM_STATS_GUI ); i < j ; i ++ ) {
		TextDrawShowForPlayer ( playerid, E_GYM_STATS_GUI[i] ) ;
	}

	SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ] )); // Muscle
	ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ] );
	SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ] )); // Weight
	ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ] );
	SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] )); // Hunger
	ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ] );
	SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] )); // Thirst
	ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ] );
	SetPlayerProgressBarValue ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ], Gym_GetProgressBarValue( Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] )); // Energy
	SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 0 ], 100);
	SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 1 ], 100);
	SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 2 ], 100);
	SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 3 ], 100);
	SetPlayerProgressBarMaxValue( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ], 100);

	ShowPlayerProgressBar ( playerid, E_GYM_STATS_GUI_BAR [playerid] [ 4 ] );

	ShowGymStatsLvlGUI(playerid);
	SelectTextDraw(playerid, 0x00000000);

	PlayerVar [ playerid ] [ E_PLAYER_GYM_STATS_SHOWN ] = true ;

	SendClientMessage ( playerid, COLOR_INFO, "Gym Printed Information");

	SendClientMessage ( playerid, COLOR_RED, sprintf("[COOLDOWN]{DEDEDE} Energy: %d / 25 ( %d seconds until refresh tick)",
		Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ],
		(Character [ playerid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ] - gettime())
	));

	
	SendClientMessage ( playerid, COLOR_BLUE, sprintf("[STAT]{DEDEDE} Weight: %d / 25 - exp (%d / %d) ( %d seconds until refresh tick)",
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ],
		Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ],
 		Gym_GetRemainingExp(Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ]),
		(Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ] - gettime())
	));

	
	SendClientMessage ( playerid, COLOR_BLUE, sprintf("[STAT]{DEDEDE} Muscle: %d / 25 - exp (%d / %d)  ( %d seconds until refresh tick)",
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ],
		Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ],
		Gym_GetRemainingExp(Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ]),
		(Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ] - gettime())
	));


	SendClientMessage ( playerid, COLOR_GREEN, sprintf("[NEEDS]{DEDEDE} Hunger: %d / 25 ( %d seconds until refresh tick)",
		Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ],
		(Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ] - gettime())
	));

	SendClientMessage ( playerid, COLOR_GREEN, sprintf("[NEEDS]{DEDEDE} Thirst: %d / 25 ( %d seconds until refresh tick)",
		Character [ playerid ] [ E_CHARACTER_GYM_THIRST ],
		(Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ] - gettime())
	));

	SendClientMessage(playerid,COLOR_ORANGE, sprintf("[MISC] Paycheck ticks until fightstyle expires: %d",  Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] ) ) ;


	SendClientMessage ( playerid, 0xDEDEDEFF, "Use ESC to hide the hud." ) ;
	return true ;
}

Gym_Enter(playerid) {

	if ( IsPlayerInRangeOfPoint ( playerid, 5.0, LS_GYM_EXT_X, LS_GYM_EXT_Y, LS_GYM_EXT_Z ) ) {
		SOLS_SetPlayerPos ( playerid, 772.111999,-3.898649,1000.728820  ); //
		SetPlayerInterior(playerid, 5);
		SetPlayerVirtualWorld(playerid, 1000);
		return true ;
	}

	else if ( IsPlayerInRangeOfPoint ( playerid, 5.0, LV_GYM_EXT_X, LV_GYM_EXT_Y, LV_GYM_EXT_Z ) ) {

		SOLS_SetPlayerPos(playerid, 773.8752,-78.4129,1000.6622 ) ;
		SetPlayerInterior(playerid, 7);
		SetPlayerVirtualWorld(playerid, 1001);
		return true ;
	}

	else if ( IsPlayerInRangeOfPoint ( playerid, 5.0, SF_GYM_EXT_X, SF_GYM_EXT_Y, SF_GYM_EXT_Z  ) ) {

		
		SendClientMessage ( playerid, COLOR_RED, "This gym is temporarily closed.") ; 
		return true ;
	}

	else if ( IsPlayerInRangeOfPoint ( playerid, 5.0, BEACH_GYM_EXT_X, BEACH_GYM_EXT_Y, BEACH_GYM_EXT_Z ) ) {

		SendClientMessage ( playerid, COLOR_RED, "This gym is can not be entered (enex).") ; 
		return true ;
	}

	else if ( IsPlayerInRangeOfPoint ( playerid, 5.0,GANTON_GYM_EXT_X, GANTON_GYM_EXT_Y, GANTON_GYM_EXT_Z ) ) {

		SendClientMessage ( playerid, COLOR_RED, "This gym is can not be entered (enex).") ; 
		return true ;
	}

	return false ;
}


Gym_Exit(playerid) {

	
	if ( GetPlayerInterior ( playerid ) == 5 && 
		IsPlayerInRangeOfPoint ( playerid, 5.0, 772.111999,-3.898649,1000.728820 ) && 
		GetPlayerVirtualWorld ( playerid) == 1000) {
		SOLS_SetPlayerPos ( playerid,  LS_GYM_EXT_X, LS_GYM_EXT_Y, LS_GYM_EXT_Z  ); 
		SetPlayerInterior ( playerid, 0);
		SetPlayerVirtualWorld ( playerid, 0 );
	}

	else if ( GetPlayerInterior ( playerid ) == 7 && 
		IsPlayerInRangeOfPoint ( playerid, 5.0, 773.8752,-78.4129,1000.6622 ) &&
		GetPlayerVirtualWorld ( playerid) == 1001 ) {

		SOLS_SetPlayerPos(playerid, LV_GYM_EXT_X, LV_GYM_EXT_Y, LV_GYM_EXT_Z ) ;
		SetPlayerInterior ( playerid, 0);
		SetPlayerVirtualWorld ( playerid, 0 );
	}

	return false ;
}


public OnGameModeInit() {

	// Put this shit in an array... (cleanup)

	CreateDynamicPickup(2916, 1, LS_GYM_EXT_X, LS_GYM_EXT_Y, LS_GYM_EXT_Z ) ;
	CreateDynamicMapIcon(LS_GYM_EXT_X, LS_GYM_EXT_Y, LS_GYM_EXT_Z, 54, 0, -1, -1, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL );
	CreateDynamicPickup(2916, 1, SF_GYM_EXT_X, SF_GYM_EXT_Y, SF_GYM_EXT_Z ) ;
	CreateDynamicMapIcon(SF_GYM_EXT_X, SF_GYM_EXT_Y, SF_GYM_EXT_Z, 54, 0, -1, -1, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL );
	CreateDynamicPickup(2916, 1, LV_GYM_EXT_X, LV_GYM_EXT_Y, LV_GYM_EXT_Z ) ;
	CreateDynamicMapIcon(LV_GYM_EXT_X, LV_GYM_EXT_Y, LV_GYM_EXT_Z, 54, 0, -1, -1, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL );
	CreateDynamicPickup(2916, 1, BEACH_GYM_EXT_X, BEACH_GYM_EXT_Y, BEACH_GYM_EXT_Z ) ;
	CreateDynamicMapIcon(BEACH_GYM_EXT_X, BEACH_GYM_EXT_Y, BEACH_GYM_EXT_Z, 54, 0, -1, -1, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL );
	CreateDynamicPickup(2916, 1, GANTON_GYM_EXT_X, GANTON_GYM_EXT_Y, GANTON_GYM_EXT_Z ) ;
	CreateDynamicMapIcon(GANTON_GYM_EXT_X, GANTON_GYM_EXT_Y, GANTON_GYM_EXT_Z, 54, 0, -1, -1, -1, STREAMER_MAP_ICON_SD, MAPICON_GLOBAL );


	CreateDynamicPickup(19555, 1, 2246.5261,	-1695.0239,	13.5370000); // gantongym_fightstylepoint
	CreateDynamicPickup(19555, 1, 766.1618,		-76.0280,	1000.65630); // pacedo_fightstylepoint
	CreateDynamicPickup(19555, 1, 766.5807,		11.0302,	1000.70600); // elsgym/lsgym_fightstylepoint
	CreateDynamicPickup(19555, 1, 669.2167,		-1867.1255,	5.45370000); // beachgym_fightstylepoint



	LS_GYM_DUMBBELL_OBJECT 		= CreateDynamicObject(-16000, 773.62579, 5.57042, 999.89630,   0.00000, 0.00000, 90.00000); //
	LS_GYM_BENCHPRESS_OBJECT 	= CreateDynamicObject(-16001, 774.43781, 0.98000, 1000.65912,   0.00000, 90.00000, 90.00000); //

	BEACH_GYM_DUMBBELL_OBJECT 	= CreateDynamicObject(-16000, 654.2920, -1869.3593, 4.6692,   0.00000, 0.00000, 90.00000); //
	BEACH_GYM_BENCHPRESS_OBJECT = CreateDynamicObject(-16001, 653.4856, -1863.5558, 5.4281,   0.00000, 90.00000, 00.00000); //
	CreateDynamicObject(2627, 659.8901, -1869.5952, 4.5136,   0.00000, 0.00000, 90.00000); // beach treadmill


	LV_GYM_BENCHPRESS_OBJECT1 	= CreateDynamicObject(-16001, 768.09235, -59.05302, 1000.63019,   0, 90, 0.00000);
	LV_GYM_BENCHPRESS_OBJECT2 	= CreateDynamicObject(-16001, 764.41504, -59.18844, 1000.63019,   0, 90, 0.00000);
	LV_GYM_DUMBBELL_OBJECT 		= CreateDynamicObject(-16000, 759.3714, -60.1260, 999.8945,   0.00000, 0.00000, 0.00000);

	// Ganton Gym
	LS_GYM_TREADMILL_AREA 		= CreateDynamicCircle(773.5667,-2.3813, 2.0, 1000, 5);
	LS_GYM_BICYCLE_AREA 		= CreateDynamicCircle(772.5696,9.4636, 2.0, 1000, 5);
	LS_GYM_BENCHPRESS_AREA 		= CreateDynamicCircle(773.9410, 1.4534, 2.0, 1000, 5 ) ;
	LS_GYM_DUMBBELL_AREA 		= CreateDynamicCircle(772.0784, 5.3704, 2.0, 1000, 5);

	// Beach Gym
	BEACH_GYM_TREADMILL_AREA 	= CreateDynamicCircle(661.3871, -1869.5911, 2.0, 0, 0);
	BEACH_GYM_BICYCLE_AREA 		= CreateDynamicCircle(659.8035,-1863.9368, 2.0, 0, 0);
	BEACH_GYM_BENCHPRESS_AREA 	= CreateDynamicCircle(653.9518,-1865.0546, 2.0, 0, 0) ;
	BEACH_GYM_DUMBBELL_AREA 	= CreateDynamicCircle(653.0922,-1869.6189, 2.0, 0, 0);

	// LV Gym
	LV_GYM_TREADMILL_AREA		= CreateDynamicCircle(758.3740,-64.0881, 2.0, 1001, 7);
	LV_GYM_BICYCLE_AREA 		= CreateDynamicCircle(775.0065,-69.1643, 2.00, 1001, 7);
	LV_GYM_BENCHPRESS_AREA1 	= CreateDynamicCircle(768.5493,-60.4839, 2.00, 1001, 7);
	LV_GYM_BENCHPRESS_AREA2 	= CreateDynamicCircle(764.8604,-60.5585, 2.00, 1001, 7);
	LV_GYM_DUMBBELL_AREA 		= CreateDynamicCircle(759.0900,-59.2300, 2.00, 1001, 7);


	// Ganton Gym Enex
 
	new tmp_object ;

	CreateDynamicObject(2627, 2234.3332, -1701.8092, 12.5411, 0.0000, 0.0000, -90.0000); //gym_treadmill
	GANTON_GYM_TREADMILL_AREA1 = CreateDynamicCircle(2233.0776,-1701.8483, 2.00); // treadmill_pos

	CreateDynamicObject(2627, 2234.3332, -1707.8918, 12.5411, 0.0000, 0.0000, -90.0000); //gym_treadmill
	GANTON_GYM_TREADMILL_AREA2 = CreateDynamicCircle(2233.0139,-1707.9719, 2.00); // treadmill_pos

	CreateDynamicObject(2632, 2245.6940, -1697.6549, 12.5759, 0.0000, 0.0000, 90.0000); //gym_mat02
	GANTON_GYM_DUMBBELL_OBJECT1  = CreateDynamicObject(-16000, 2245.88037, -1696.80859, 12.69661,   0.00000, 0.00000, 0.00000);
	GANTON_GYM_DUMBBELL_AREA1 = CreateDynamicCircle(2245.6873,-1697.5076, 2.00); // dumbbell_pos_1
	/*
		SetPlayerCameraPos(playerid, 2245.7271, -1696.2778, 13.1448);
		SetPlayerCameraLookAt(playerid, 2245.7480, -1697.2764, 13.0998);
	*/


	CreateDynamicObject(2631, 2240.2099, -1697.5985, 12.5598, 0.0000, 0.0000, 9090.0000); //gym_mat1
	GANTON_GYM_DUMBBELL_OBJECT2  = CreateDynamicObject(-16000, 2240.36670, -1696.75159, 12.69661,   0.00000, 0.00000, 0.00000);
	GANTON_GYM_DUMBBELL_AREA2 = CreateDynamicCircle(2240.1960,-1697.2085, 2.00); // dumbbell_pos_2
	/*
	SetPlayerCameraPos(playerid, 2240.2578, -1695.3706, 13.4130);
	SetPlayerCameraLookAt(playerid, 2240.2791, -1696.3680, 13.3080);
	*/

	CreateDynamicObject(2630, 2230.8879, -1716.4868, 16.2176, 0.0000, 0.0000, 90.0000); //gym_bike
	GANTON_GYM_BICYCLE_AREA1 = CreateDynamicCircle(2231.0933,-1715.5614, 2.00); // bicycle_pos

	CreateDynamicObject(2630, 2230.8879, -1710.3543, 16.2176, 0.0000, 0.0000, 90.0000); //gym_bike
	GANTON_GYM_BICYCLE_AREA2 = CreateDynamicCircle(2231.0823,-1709.5383, 2.00); // bicycle_pos

	CreateDynamicObject(2629, 2243.3928, -1695.0087, 16.2113, 0.0000, 0.0000, 0.0000); //gym_bench1
	GANTON_GYM_BENCHPRESS_OBJECT1 = CreateDynamicObject(-16001, 2242.95752, -1694.49951, 17.19414,   0.00000, 90.00000, 0.00000); // barbell
	GANTON_GYM_BENCHPRESS_AREA1 = CreateDynamicCircle(2243.4297,-1696.2043, 2.00); // benchpress_pos
	/*
		SetPlayerCameraPos(playerid, 2243.4622, -1699.1917, 17.7198);
	SetPlayerCameraLookAt(playerid, 2243.4363, -1698.1942, 17.6048);
	*/

	CreateDynamicObject(2629, 2235.1215, -1695.0087, 16.2113, 0.0000, 0.0000, 0.0000); //gym_bench1
	GANTON_GYM_BENCHPRESS_OBJECT2 = CreateDynamicObject(-16001, 2234.66187, -1694.43762, 17.19414,   0.00000, 90.00000, 0.00000); // barbell
	GANTON_GYM_BENCHPRESS_AREA2 = CreateDynamicCircle(2235.1099,-1695.9762, 2.00); // benchpress_pos
	/*
	SetPlayerCameraPos(playerid, 2235.1323, -1699.0880, 17.7198);
	SetPlayerCameraLookAt(playerid, 2235.1318, -1698.0901, 17.5848);
	*/ 

	// Additional Ganton Gym Unusables
	CreateDynamicObject(2628, 2231.0354, -1718.8311, 16.2466, 0.0000, 0.0000, 9090.0000);
	CreateDynamicObject(2628, 2231.0354, -1706.4597, 16.2466, 0.0000, 0.0000, 9090.0000);
	tmp_object = CreateDynamicObject(2627, 2230.8762, -1704.0424, 16.2139, 0.0000, 0.0000, -90.0000); //gym_treadmill
	SetDynamicObjectMaterial(tmp_object, 0, 17003, "countrys", "rustc256128", 0xFFFFFFFF);
	tmp_object = CreateDynamicObject(2627, 2230.8762, -1712.7232, 16.2139, 0.0000, 0.0000, -90.0000); //gym_treadmill
	SetDynamicObjectMaterial(tmp_object, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0xFFFFFFFF);
	tmp_object = CreateDynamicObject(2630, 2234.2241, -1710.1652, 12.5480, 0.0000, 0.0000, 90.0000); //gym_bike
	SetDynamicObjectMaterial(tmp_object, 0, 17003, "countrys", "rustc256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmp_object, 2, 11395, "corvinsign_sfse", "rustb256128", 0xFFFFFFFF);
	tmp_object = CreateDynamicObject(2630, 2234.2241, -1704.1634, 12.5480, 0.0000, 0.0000, 90.0000); //gym_bike
	SetDynamicObjectMaterial(tmp_object, 0, 17003, "countrys", "rustc256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmp_object, 2, 11395, "corvinsign_sfse", "rustb256128", 0xFFFFFFFF);
	tmp_object= CreateDynamicObject(2630, 2240.6340, -1698.2130, 16.2380, 0.0000, 0.0000, 0.0000); //gym_bike
	SetDynamicObjectMaterial(tmp_object, 0, 17003, "countrys", "rustc256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmp_object, 2, 11395, "corvinsign_sfse", "rustb256128", 0xFFFFFFFF);
	tmp_object = CreateDynamicObject(2630, 2245.4787, -1698.2130, 16.2380, 0.0000, 0.0000, 0.0000); //gym_bike
	SetDynamicObjectMaterial(tmp_object, 0, 17003, "countrys", "rustc256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmp_object, 2, 11395, "corvinsign_sfse", "rustb256128", 0xFFFFFFFF);


	#if defined gym_OnGameModeInit
		return gym_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit gym_OnGameModeInit
#if defined gym_OnGameModeInit
	forward gym_OnGameModeInit();
#endif

Gym_IsPlayerInGym(playerid) {

/*
E_GYM_LOCATION_SF
*/

	// Ganton Gym
	if ( GetPlayerInterior(playerid) == 5 ) {

		if ( IsPlayerInRangeOfPoint(playerid, 25.0, 765.7281, 4.9549, 1000.2514)) {

			return E_GYM_LOCATION_LS ;
		}	
	}
	// Beach Gym
	if ( GetPlayerInterior(playerid) == 0 || GetPlayerVirtualWorld(playerid) == 0 ) {
		if ( IsPlayerInRangeOfPoint(playerid, 15.0, 656.7802, -1866.5012, 5.1775)) {

			return E_GYM_LOCATION_BEACH ;
		}
	}
	// LV Gym
	if ( GetPlayerInterior(playerid) == 7 ) {
		if ( IsPlayerInRangeOfPoint(playerid, 20.0, 766.7129, -68.6140, 1001.1830)) {
			return E_GYM_LOCATION_LV ;
		}
	}

	if ( GetPlayerVirtualWorld ( playerid ) == 0 && GetPlayerInterior ( playerid ) == 0  ) {

		if ( IsPlayerInRangeOfPoint ( playerid, 15.0, 2239.3887,-1706.4517,13.5336 ) ) { 

			return E_GYM_LOCATION_GANTON ;
		}
	}
	return E_GYM_LOCATION_NONE ;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	
	if ( Gym_IsPlayerInGym(playerid) ) {

		if ( newkeys & KEY_SECONDARY_ATTACK ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_GYM_COOLDOWN ] > gettime() ) {

				ShowPlayerInfoMessage(playerid, "You've left a machine recently! Don't try to re-use it so quickly.", .height=285.0, .width = 200.0);
			}

			if ( Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ] <= 1 ) {
				ShowPlayerInfoMessage(playerid, 
					"You don't have enough energy to be partaking in the gym now. Wait for it to come back!", 
					.showtime=6500, .height=167.5
				);

				Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], 0, .anim=false); // reset variables!
				return false ;
			}

			if ( Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ] >= 20 ) {
				ShowPlayerInfoMessage(playerid, 
					"You are too hungry to be visiting the gym. Go grab a bite to eat to replenish your hunger first!", 
					.showtime=6500, .height=167.5
				);

				Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], 0, .anim=false); // reset variables!
				return false ;	
			}
			if ( Character [ playerid ] [ E_CHARACTER_GYM_THIRST ] >= 20 ) {
				ShowPlayerInfoMessage(playerid, 
					"You are too thirsty to be visiting the gym. Go grab some soda to drink to replenish your thirst first!", 
					.showtime=6500, .height=167.5
				);

				Gym_ExitMachine(playerid, PlayerGym [ playerid ] [ E_PLAYER_GYM_MACHINE_TYPE ], 0, .anim=false); // reset variables!
				return false ;	
			}

			Gym_CheckGymLocation(playerid) ;
		}

		if ( newkeys & KEY_SPRINT ) {
			Gym_ProgressHandler(playerid) ;
		}
	}
	
	#if defined gym_OnPlayerKeyStateChange
		return gym_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange gym_OnPlayerKeyStateChange
#if defined gym_OnPlayerKeyStateChange
	forward gym_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerEnterDynamicArea(playerid, areaid) {

	new Float: null, Float: player_z_pos ;
	GetPlayerPos ( playerid, null, null, player_z_pos ) ;

	if ( areaid == LS_GYM_TREADMILL_AREA ||  areaid == BEACH_GYM_TREADMILL_AREA || areaid == LV_GYM_TREADMILL_AREA ) {
		ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Treadmill", .height=285.0, .width = 200.0);
	}
	
	if ( areaid == LS_GYM_BICYCLE_AREA ||  areaid == BEACH_GYM_BICYCLE_AREA || areaid == LV_GYM_BICYCLE_AREA ){

		ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Bicycle", .height=285.0, .width = 200.0);
	}


	if ( areaid == GANTON_GYM_TREADMILL_AREA1 || areaid == GANTON_GYM_TREADMILL_AREA2 ) {

		if ( player_z_pos < 15.0 ) {

			ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Treadmill", .height=285.0, .width = 200.0);
		}
 	}

	if ( areaid == GANTON_GYM_BICYCLE_AREA1 || areaid == GANTON_GYM_BICYCLE_AREA2 ) {
		if ( player_z_pos > 15.0 ) {

			ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Bicycle", .height=285.0, .width = 200.0);
		}
	}

	if ( areaid == LS_GYM_BENCHPRESS_AREA ||  areaid == BEACH_GYM_BENCHPRESS_AREA || areaid == LV_GYM_BENCHPRESS_AREA1){
		ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Benchpress", .height=285.0, .width = 200.0);
	}

	if ( areaid == LV_GYM_BENCHPRESS_AREA2 || areaid == GANTON_GYM_BENCHPRESS_AREA1 || areaid == GANTON_GYM_BENCHPRESS_AREA2) { 
		if ( player_z_pos > 15.0 ) {
			ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Benchpress", .height=285.0, .width = 200.0);
		}
	}

	if ( areaid == LS_GYM_DUMBBELL_AREA ||  areaid == BEACH_GYM_DUMBBELL_AREA || areaid == LV_GYM_DUMBBELL_AREA ) {

		ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Dumbbells", .height=285.0, .width = 200.0);

	} 

	if ( areaid == GANTON_GYM_DUMBBELL_AREA1 || areaid == GANTON_GYM_DUMBBELL_AREA2) {

		if ( player_z_pos < 15.0 ) {
			ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Use Dumbbells", .height=285.0, .width = 200.0);
		}
	}

	#if defined gym_OnPlayerEnterDynamicArea
		return gym_OnPlayerEnterDynamicArea(playerid, areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif

#define OnPlayerEnterDynamicArea gym_OnPlayerEnterDynamicArea
#if defined gym_OnPlayerEnterDynamicArea
	forward gym_OnPlayerEnterDynamicArea(playerid, areaid);
#endif

public OnPlayerLeaveDynamicArea(playerid, areaid) {

	if ( areaid == LS_GYM_TREADMILL_AREA 	|| areaid == LS_GYM_BICYCLE_AREA  || 
		areaid == LS_GYM_BENCHPRESS_AREA 	|| areaid == LS_GYM_DUMBBELL_AREA ||
		areaid == BEACH_GYM_TREADMILL_AREA 	|| areaid == BEACH_GYM_BICYCLE_AREA  || 
		areaid == BEACH_GYM_BENCHPRESS_AREA || areaid == BEACH_GYM_DUMBBELL_AREA ||
		areaid == LV_GYM_TREADMILL_AREA 	|| areaid == LV_GYM_BICYCLE_AREA || 
		areaid == LV_GYM_BENCHPRESS_AREA1 	|| areaid == LV_GYM_BENCHPRESS_AREA2 || 
		areaid == LV_GYM_DUMBBELL_AREA 		|| areaid == GANTON_GYM_TREADMILL_AREA1 || 
		areaid == GANTON_GYM_TREADMILL_AREA2 || areaid == GANTON_GYM_BICYCLE_AREA1 || 
		areaid == GANTON_GYM_BICYCLE_AREA2 	|| areaid == GANTON_GYM_BENCHPRESS_AREA1 || 
		areaid == GANTON_GYM_BENCHPRESS_AREA2 || areaid == GANTON_GYM_DUMBBELL_AREA1 || 
		areaid == GANTON_GYM_DUMBBELL_AREA2
		) {

		HidePlayerInfoMessage(playerid);
	}	

	#if defined gym_OnPlayerLeaveDynamicArea
		return gym_OnPlayerLeaveDynamicArea(playerid, areaid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif

#define OnPlayerLeaveDynamicArea gym_OnPlayerLeaveDynamicArea
#if defined gym_OnPlayerLeaveDynamicArea
	forward gym_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif