new MaxSeats[212] = {
4,2,2,2,4,4,1,2,2,4,2,2,2,4,2,2,4,2,4,2,4,4,2,2,2,1,4,4,4,2,1,9,1,2,2,1,2,9,4,2,
4,1,2,2,2,4,1,2,1,6,1,2,1,1,1,2,2,2,4,4,2,2,2,2,2,2,4,4,2,2,4,2,1,1,2,2,1,2,2,4,
2,1,4,3,1,1,1,4,2,2,4,2,4,1,2,2,2,4,4,2,2,2,2,2,2,2,2,4,2,1,1,2,1,1,2,2,4,2,2,1,
1,2,2,2,2,2,2,2,2,4,1,1,1,2,2,2,2,0,0,1,4,2,2,2,2,2,4,4,2,2,4,4,2,1,2,2,2,2,2,2,
4,4,2,2,1,2,4,4,1,0,0,1,1,2,1,2,2,2,2,4,4,2,4,1,1,4,2,2,2,2,6,1,2,2,2,1,4,4,4,2,
2,2,2,2,4,2,1,1,1,4,1,1
};

stock GetMaxSeats(vehicleid)
{
    return MaxSeats[(GetVehicleModel(vehicleid) - 400)];
}

CMD:detain(playerid, params[]) 
{
	new giveplayerid, vehicleid;
	if (!IsPlayerInPoliceFaction(playerid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not on duty in a faction that can do this.");
	if (sscanf(params, "k<player>i", giveplayerid, vehicleid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Usage: /detain [player] [vehicleid: use /dl]");
	if (playerid == giveplayerid) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You cannot detain yourself.");
	if (!IsPlayerConnected(giveplayerid)) SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Invalid player.");
	if (GetPVarInt(giveplayerid, "CUFFED") != 1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This player is not cuffed.");
	if (!IsValidVehicle(vehicleid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Invalid vehicle.");
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(giveplayerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, x , y, z)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You're too far away from this player.");
	GetVehiclePos(vehicleid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, x , y, z)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You're too far away from this vehicle.");

	new max_seats = GetMaxSeats(vehicleid);
	new seats[9] = { INVALID_PLAYER_ID, ... };
	new seat = 2;

	if (max_seats > 2)
	{
		foreach(new i: Player)
		{
			if (!IsPlayerConnected(i) || GetPlayerVehicleID(i) != vehicleid) continue;
			seats[GetPlayerVehicleSeat(i)] = i;
		}

		for (new i = 2; i < sizeof(seats); i ++)
		{
			if (!IsPlayerConnected(seats[i]))
			{
				seat = i;
				break;
			}
		}
	}

	if (seat >= max_seats || max_seats <= 2) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This vehicle doesn't have enough free seats.");

	JT_PutPlayerInVehicle(giveplayerid, vehicleid, seat);
	SetPVarInt(giveplayerid, "CUFFREQUEST", 0);
	SetPVarInt(giveplayerid, "CUFFED", 1);
	SetPlayerSpecialAction(giveplayerid, 24);
	
	new skin = GetPlayerSkin(giveplayerid);
	SetPlayerAttachedObject(giveplayerid, E_ATTACH_INDEX_SYSTEM, 19418, 6, CuffCoords[skin][0], CuffCoords[skin][1], CuffCoords[skin][2], CuffCoords[skin][3], CuffCoords[skin][4], CuffCoords[skin][5], CuffCoords[skin][6], CuffCoords[skin][7], CuffCoords[skin][8]);
	return true;
}
