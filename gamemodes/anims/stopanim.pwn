
CMD:sa(playerid, params[]) {

	return cmd_stopanim(playerid, params);
}
 
CMD:stopanim ( playerid, const params [] ) {

	if ( IsPlayerIncapacitated ( playerid, true ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You don't need to use this command right now." );
	}

	if ( gettime () < PlayerVar [ playerid ] [ E_PLAYER_BRAWL_STOPANIM_ABUSE ] ) {
		SendAdminMessage(sprintf("[!!!] [AdmWarn] %d %s has abused /s(top)a(nim) within 10 seconds of being damaged (anim abuse).", 
			playerid, ReturnMixedName(playerid) )) ;

	    return SendServerMessage( playerid, COLOR_RED, "Anticheat", "DEDEDE", "Don't abuse /s(top)a(nim) in fights." );
	}

	PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ] = 0;

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE ) ;

	if (IsPlayerInAnyVehicle(playerid))
	{
		return ApplyAnimation(playerid, "PED", "CAR_SIT", 4.0, 0, 0, 0, 0, 1, 1);
	}
	else  
	{
		ClearAnimations(playerid, 1);
		ApplyAnimation(playerid, "PED", "IDLE_STANCE", 4.0, 0, 0, 0, 0, 1, 1);
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 0, 0, 0, 1, 1);
		ApplyAnimation(playerid, "PED", "WALK_PLAYER", 4.0, 0, 0, 0, 0, 1, 1);
	}

	if (GetPVarInt(playerid, "CUFFED") == 1)
	{
		// re-cuff anyone that was cuffed
		SOLS_SetPlayerCuffed(playerid, true, false);
		// Police_OnPlayerCuffResponse(playerid, true);
	}

/*
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE ) ;
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0); // Leave animation
	ClearAnimations(playerid);
*/

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, "Used /stopanim");

	return true ;
}

AnimationCheck ( playerid, bool:checkCuffs=false ) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_BRAWL_STOPANIM_ABUSE ] )
	{
		// Stops people doing anims for 5s after being damaged
		if ( gettime () < (PlayerVar [ playerid ] [ E_PLAYER_BRAWL_STOPANIM_ABUSE ] - 5) ) 
		{
			return false;
		}
	}
	 
	if ( IsPlayerIncapacitated ( playerid, !checkCuffs ) ) 
	{
		return false ;
	}

	return true ;
}