stock GetXYRightOfPlayer(playerid, &Float:X, &Float:Y, Float:distance)
{
    new Float:Angle;
    GetPlayerFacingAngle(playerid, Angle); Angle -= 90.0;
    X += floatmul(floatsin(-Angle, degrees), distance);
    Y += floatmul(floatcos(-Angle, degrees), distance);
}

stock GetNearestHoop(playerid)
{
    new courtid = -1;

    for(new c = 0; c < MAX_COURTS; c++)
    {
        if(IsValidObject(CourtVars[c][CourtHoop][0]))
        {
            new Float:pos[3];
            GetObjectPos(CourtVars[c][CourtHoop][0], pos[0], pos[1], pos[2]);
            if(IsPlayerInRangeOfPoint(playerid, 1.5, pos[0], pos[1], pos[2]))
            {
                courtid = c;
                break;
            }
        }
    }
    return courtid;
}

stock IsPlayerInBasketballArea(playerid, courtid)	//The older version was a rectangle detection but it has been replaced with a bubble because we are no longer using hard-coded coords, nor these coords are defined/stored.
{                                               	//I plan to change it back in the future
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && IsPlayerInRangeOfPoint(playerid, 25.0, Court[courtid][COURT_FIRST_HOOP_POS][0], Court[courtid][COURT_FIRST_HOOP_POS][1], Court[courtid][COURT_FIRST_HOOP_POS][2])) return 1;
	else return 0;
}

stock GetNearestBasketball(playerid)
{
	new courtid = -1;

	for(new c = 0; c < MAX_COURTS; c++)
	{
	    if(IsValidObject(CourtVars[c][CourtBasketball]))
	    {
	        new Float:pos[3];
	        GetObjectPos(CourtVars[c][CourtBasketball], pos[0], pos[1], pos[2]);
	        if(IsPlayerInRangeOfPoint(playerid, 1.5, pos[0], pos[1], pos[2]))
	        {
	        	courtid = c;
	        	break;
	        }
	    }
	}
	return courtid;
}

stock SetPlayerFaceBasket(playerid)
{
    new
        Float: pX = Court[BasketPlayerVars[playerid][PlayerCourtID]][COURT_FIRST_HOOP_POS][0],
        Float: pY = Court[BasketPlayerVars[playerid][PlayerCourtID]][COURT_FIRST_HOOP_POS][1],
        Float: gX,
        Float: gY,
        Float: gZ
    ;
    if(GetPlayerPos(playerid, gX, gY, gZ))
	{
        pX = -atan2((gX - pX), (gY - pY));
        return SetPlayerFacingAngle(playerid, (pX + 180.0));
    }
    return false;
}

stock RemovePlayerFromBasketball(playerid)
{
    if(BasketPlayerVars[playerid][PlayerCourtID] != -1) //Remove player if he's really playing
    {
        RemovePlayerAttachedObject(playerid, 0);
   		BasketPlayerVars [ playerid ] [ PlayerBlocking ] = false;
   		BasketPlayerVars[playerid][PlayerCourtID] = -1;
   		//HidePlayerProgressBar(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ]);
		//TextDrawHideForPlayer(playerid, TextdrawAccuracy);
    }
    return 1;
}