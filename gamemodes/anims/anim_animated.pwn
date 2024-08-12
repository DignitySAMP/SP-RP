
CMD:time ( playerid, params [] ) {
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "PLAYIDLES", "time", 4.1, 0, 0, 0, 0, 0, 1);

	new string [ 128 ] ;
	format ( string, sizeof ( string ), "[Watch]: {DEDEDE}The time is %.0d:%02d on %s %d, 1994.",
		Server [ E_SERVER_TIME_HOURS ], Server [ E_SERVER_TIME_MINUTES ], 
		date_getMonth(Server [ E_SERVER_TIME_MONTHS ]), Server [ E_SERVER_TIME_DAYS ]
	);

	SendClientMessage ( playerid, COLOR_HINT, string ) ;

	return true ;
}


CMD:shit ( playerid, params [] ) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "PED", "cower", 4.1, 0, 0, 0, 1, 0, 1);
    SetPlayerAttachedObject ( playerid, 9, 18722,1, -1.773999, 0.234999,-0.091000, 2.300002, 88.499984, 0.0, 1.0, 1.0, 1.0 ) ;
    
    return true ;
}

CMD:piss(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, 68);
	return 1;
}

CMD:puke(playerid, params[]) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 1, 0, 1);
	defer AnimatedAnim_Puke(playerid);

	return true ;
}

timer AnimatedAnim_Puke[3750](playerid) {

	if ( GetPlayerAnimationIndex(playerid) == 539 ) {
    	SetPlayerAttachedObject ( playerid, E_ATTACH_INDEX_MISC, 18722,E_ATTACH_BONE_HEAD, 0.0, 1.75, 0.0, 90.0, 0.0, 0.0,  1.000000, 1.000000, 1.000000 ) ;
    	defer AnimatedAnim_Clear(playerid);
    }	

    return true ;
}

new PlayerBottleAnimation [ MAX_PLAYERS ] ;
CMD:shakebottle(playerid, params[]) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	SetPlayerAttachedObject ( playerid, E_ATTACH_INDEX_MISC, -29993,E_ATTACH_BONE_HAND_R, 0.051001, 0.037000, -0.000999, -3.499976, 63.500053, -3.400005, 1.000000, 1.000000, 1.258999 ) ;
	SetPlayerAttachedObject ( playerid, E_ATTACH_INDEX_SYSTEM, 18706,E_ATTACH_BONE_HAND_R, -1.334998, -0.005000, -0.679999, -3.499975, 63.500053, -3.400005, 1.000000, 1.000000, 1.258998 ) ;

   	ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.1, 0, 0, 0, 1, 0, 1);


   	PlayerBottleAnimation [ playerid ] = 0 ;
   	defer AnimatedAnim_Bottle[1500](playerid);
   	return true ;
}

timer AnimatedAnim_Bottle[800](playerid) {

   	switch ( GetPlayerAnimationIndex(playerid) ) {

   		case 224: {
			if ( PlayerBottleAnimation [ playerid ] ++ >= 60 ) {

				RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);
				RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);
				return true ;
			}
		}

		default: {
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM);

			return true ;
		}
	}

	defer AnimatedAnim_Bottle(playerid);

	return true ;
}

CMD:exhale(playerid, params[]) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	new type, time;

	if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "/exhale [1-4]");

	if (type < 1 || type > 4)
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "Invalid type specified.");


	switch (type) {
		case 1: ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 		4.1, 0, 0, 0, 1, 0, 1), time = 3500;
		case 2: ApplyAnimation(playerid, "GANGS", "smkcig_prtl_F", 		4.1, 0, 0, 0, 1, 0, 1), time = 3800;
		case 3: ApplyAnimation(playerid, "PED", "pass_Smoke_in_car", 	4.1, 0, 0, 0, 1, 0, 1), time = 2000;
		case 4: ApplyAnimation(playerid, "PED", "smoke_in_car", 		4.1, 0, 0, 0, 1, 0, 1), time = 2000;
	}

	defer AnimatedAnim_Exhale[time](playerid);

	return true ;
}

timer AnimatedAnim_Exhale[3500](playerid) {

	switch ( GetPlayerAnimationIndex(playerid)) {

		case 1245, 609, 610, 1212: {
			SetPlayerAttachedObject ( playerid, E_ATTACH_INDEX_MISC, 18677,E_ATTACH_BONE_HEAD, 0.0, 1.75, 0.0, 90.0, 0.0, 0.0, 1.000000, 1.000000, 1.000000 ) ;
			defer AnimatedAnim_Clear(playerid);
		}
	}

	return true ;
}

timer AnimatedAnim_Clear[3000](playerid) {

	RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);
}

