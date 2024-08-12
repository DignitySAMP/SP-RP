// All credits to Jelly23. Suggested by TommyB.
#include <YSI_Coding\y_hooks>
static ATV_Tempo[MAX_PLAYERS], ATV_Carro[MAX_PLAYERS], ATV_RJack[MAX_PLAYERS];

OnPlayerTroll(playerid) {

	new acstr[256];
	format(acstr, sizeof(acstr), "[Anticheat]: (%d) %s might be car warping", playerid, ReturnMixedName(playerid));
	SendAdminMessage(acstr, COLOR_ANTICHEAT);


	if(Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNBAN ]) return false ;
	if(Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ]) return true ;
	if(Character [ playerid ] [ E_CHARACTER_HOURS] > 8) return true ;

	// False positive (detected by using /detain, Exyze, 13/12/21)
	if(GetPVarInt(playerid, "CUFFED") == 1) {

		return true ;
	}

	PlayerVar [ playerid ] [ E_PLAYER_WARP_AC ] ++ ;

	if (PlayerVar [ playerid ] [ E_PLAYER_WARP_AC ] >= 2) {

		SendAdminMessage(sprintf("[ANTICHEAT CRITICAL]: (%d) %s might be car warping. Checking false positive, slapping!", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);

		JT_RemovePlayerFromVehicle(playerid);

		new Float: x, Float: y, Float: z ;
		GetPlayerPos ( playerid, x, y, z ) ;
		SetPlayerPos ( playerid, x, y, z + 4 ) ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_WARP_AC ] >= 3) {

		SendAdminMessage(sprintf("[ANTICHEAT CRITICAL]: (%d) %s might be car warping.", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);

		Kick(playerid);
	}

	return true ;
}

ptask ATV_TrollCheck[1000](playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(GetPlayerVehicleID(playerid) != ATV_Carro[playerid])
        {
            if(gettime() > ATV_Tempo[playerid])
            {
                OnPlayerTroll(playerid);
            }
        }
    }
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
	{
		if(ATV_RJack[playerid])
		{
			OnPlayerTroll(playerid);
		}
	}
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    ATV_Carro[playerid] = vehicleid;
    if(!ispassenger)
    {
        ATV_RJack[playerid] = 1;
    }
    return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(ATV_RJack[playerid] == 1 && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_NONE)
	{
		ATV_RJack[playerid] = 0;
		ATV_Tempo[playerid] = gettime()+3;
	}
    return 1;
}

hook OnUnoccupiedVehicleUpd(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    if(floatround(floatsqroot(vel_x * vel_x + vel_y * vel_y) * 200, floatround_round) > 1100)
	{
		OnPlayerTroll(playerid);
		return 0;
	}
	if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) > 15)
	{
		return 0;
	}
    return 1;
}


stock JT_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
	ATV_Tempo[playerid] = gettime()+3;
	ATV_Carro[playerid] = vehicleid;
	ATV_RJack[playerid] = 0;
	return PutPlayerInVehicle(playerid, vehicleid, seatid);
}

stock JT_RemovePlayerFromVehicle(playerid)
{
	ATV_Tempo[playerid] = gettime()+6;
	ATV_Carro[playerid] = 0;
	ATV_RJack[playerid] = 0;
	return RemovePlayerFromVehicle(playerid);
}

#if defined _ALS_RemovePlayerFromVehicle
#undef RemovePlayerFromVehicle
#else
#define _ALS_RemovePlayerFromVehicle
#endif

#define RemovePlayerFromVehicle JT_RemovePlayerFromVehicle

#if defined _ALS_PutPlayerInVehicle
#undef PutPlayerInVehicle
#else
#define _ALS_PutPlayerInVehicle
#endif

#define PutPlayerInVehicle JT_PutPlayerInVehicle
