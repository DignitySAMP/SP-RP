public OnPlayerConnect(playerid) {

	if ( playerid > MAX_PLAYERS ) {

		Kick ( playerid ) ;
		return true ;
	}
 
	EnablePlayerCameraTarget(playerid, 1);

	//PreloadAnimLib(playerid, "PED");
	//PreloadAnimLib(playerid, "SHOP");

	RemoveBuildingForPlayer( playerid, 1490, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1524, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1525, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1526, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1527, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1528, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1529, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1530, 0.0, 0.0, 0.0, 100000.0 );
	RemoveBuildingForPlayer( playerid, 1531, 0.0, 0.0, 0.0, 100000.0 );

	Map_RemoveBuildings(playerid) ; 

	#if defined config_OnPlayerConnect
		return config_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect config_OnPlayerConnect
#if defined config_OnPlayerConnect
	forward config_OnPlayerConnect(playerid);
#endif


public OnPlayerCommandReceived(playerid, cmdtext[]) {
	//printf("OnPlayerCommandReceived: pid: %d, cmd: %s", playerid, cmdtext); // to find the cause of the crashes
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_JUNIOR ) {
		if (! IsPlayerSpawned ( playerid ) || !IsPlayerLogged(playerid)) {

			if (GetPVarType(playerid, "FlyMode"))
			{
				// allows players in /noclip to do commands
			}
			else
			{
				SendClientMessage(playerid, COLOR_ERROR, "You must be spawned before you can do a command.");
				return 0 ;
			}
		}
	}

	return 1 ;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success) 
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_MANAGER) // Stops lower admins seeing cmds of high admins
	{
		foreach (new i: Player) 
		{
			if (!IsPlayerLogged(i) || Account[i][E_PLAYER_ACCOUNT_STAFFLEVEL] <= 0) continue;

			if (PlayerVar[i][E_PLAYER_IS_SPECTATING] == playerid) 
			{
				SendClientMessage(i, 0xDEDEDEFF, sprintf("[SPEC]: (%d) %s tried command (performed): %s", playerid, ReturnMixedName(playerid), cmdtext));
			}
		}
	}
	
	if (!success) 
	{
		SendClientMessage(playerid, COLOR_OOC, "The command you entered does not exist. Use /help to see a list of available commands.");
	}

	return true ;
}

