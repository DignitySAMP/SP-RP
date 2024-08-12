/*
 *  Disable class selection by Emmet_
 *  Creation date: 05/13/2015 @ 4:38 AM
 * OP with info:  https://forum.sa-mp.com/showthread.php?t=574072
*/

public OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid, true);
	

	//SetTimerEx("OnPlayerFullyConnected", 250, false, "i", playerid);
	defer OnPlayerFullyConnected[250](playerid);
	
	#if defined CS_OnPlayerRequestClass
		return CS_OnPlayerRequestClass(playerid, classid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerRequestClass
	#undef OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif

#define OnPlayerRequestClass CS_OnPlayerRequestClass
#if defined CS_OnPlayerRequestClass
	forward CS_OnPlayerRequestClass(playerid, classid);
#endif

// 2022 edit by Spooky to stop OnPlayerSpawn being called twice by this. 2024 edit by Dignity you are a dumb fuck
stock CS_SpawnPlayer(playerid) 
{
	if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) 
	{
	    TogglePlayerSpectating(playerid, false); // Force spawns
	}
	else
	{
		SpawnPlayer(playerid);
	}
	
	SetPlayerChatBubble(playerid," ", 0xFFFFFFFF, 7.5, 10000);
}

#if defined _ALS_SpawnPlayer
	#undef SpawnPlayer
#else
	#define _ALS_SpawnPlayer
#endif

#define SpawnPlayer CS_SpawnPlayer