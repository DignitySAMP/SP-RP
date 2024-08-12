CMD:tackle ( playerid, params [] ) 
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovCop(playerid, true)) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a faction that can do this.");
	}

	if ( IsPlayerIncapacitated(playerid, false) || PlayerVar [ playerid ] [ E_PLAYER_HAS_TACKLED ]) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if (PlayerVar[playerid][E_PLAYER_TACKLE_ACTIVE])
	{
		SendClientMessage(playerid, COLOR_INFO, "You've disabled tackle mode.");
		PlayerVar[playerid][E_PLAYER_TACKLE_ACTIVE] = false;
	}
	else
	{
		SendClientMessage(playerid, COLOR_INFO, "You've enabled tackle mode - hit a moving player to tackle them.");
		PlayerVar[playerid][E_PLAYER_TACKLE_ACTIVE] = true;
	}

	return true ;
}

timer TackleAnimFix[1000](playerid) {
	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {
    
   	 	return true ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ] ) {

		return true ;
	}

	return ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 4.1, 0, true, true, true, 0, 1);  
}

timer TackleUnfreeze[15000](playerid) {
	if (  PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {
    
   	 	return true ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ] ) {

		return true ;
	}

	// SendServerMessage( playerid, COLOR_BLUE, "Tackle", "A3A3A3",  "You've woken up from the tackle. You still feel a little dizzy, so take it easy." );
	// SetPlayerDrunkLevel(playerid, 1500);

	TogglePlayerControllable ( playerid, true ) ;
	PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ] = false ;

	return ApplyAnimation(playerid, "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1); 
}

timer TackleModeDisable[2500](playerid) 
{
	PlayerVar[playerid][E_PLAYER_TACKLE_ACTIVE] = false;
	return SendClientMessage(playerid, COLOR_INFO, "Tackle mode was automatically disabled.");
}

Tackle_OnPlayerGiveDamage(playerid, damagedid, weaponid)
{
	#pragma unused weaponid

	new animindex = GetPlayerAnimationIndex(damagedid);
	if (!animindex || GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || GetPlayerState(damagedid) != PLAYER_STATE_ONFOOT || PlayerVar[damagedid][E_PLAYER_IS_TACKLED])
	{
		// Invalid tackle
		return 0;
	}

	/*
	new animlib[32];
	new animname[32];
	GetAnimationName(GetPlayerAnimationIndex(damagedid),animlib,32,animname,32);

	if (animindex < 1276 && animindex > 1280 && strfind(animname, "run_", true) == -1 && strfind(animname, "sprint_", true) == -1)
	{
		// Also invalid tackle
		ShowPlayerSubtitle(playerid, "You can only tackle running players!", 3000);
		return 0;
	}
	*/

	ProxDetectorEx ( playerid, 30.0, COLOR_ACTION, "**", sprintf("has tackled %s.", ReturnMixedName ( damagedid ) )) ;
	SendServerMessage( damagedid, COLOR_BLUE, "Tackle", "A3A3A3",  sprintf("You've been tackled to the ground by (%d) %s.", playerid, ReturnSettingsName ( playerid, damagedid ) ));

	ShowPlayerSubtitle(playerid, sprintf("~y~You tackled %s!",  ReturnSettingsName(damagedid, playerid)), 5000);
	ShowPlayerSubtitle(damagedid, "~r~You were tackled!", 5000);

	TogglePlayerControllable(damagedid, false);
	//ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.1, false, true, true, false, 0, 1);
	ApplyAnimation(damagedid, "PED", "KO_shot_front", 4.1, false, true, true, true, 0, 1);
	SetPlayerDrunkLevel(damagedid, GetPlayerDrunkLevel(damagedid) + 2000);

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Tackled (%d) %s", damagedid, ReturnMixedName(damagedid)));
	AddLogEntry(damagedid, LOG_TYPE_SCRIPT, sprintf("Was tackled by (%d) %s", playerid, ReturnMixedName(playerid)));

	defer TackleUnfreeze(damagedid);
	defer TackleAnimFix(damagedid);
	defer TackleModeDisable(playerid);

	PlayerVar[damagedid][E_PLAYER_IS_TACKLED] = true ;
	return 1;
}