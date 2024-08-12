stock SoundBall(courtid)
{
    new Float:lel[3], rand = random(3);

    if(CourtVars[courtid][CourtBasketball_State] == STATE_BOUNCED)
    {
        GetPlayerPos(CourtVars[courtid][CourtBasketball_BouncerID], lel[0], lel[1], lel[2]);
    }
    else
    {
        GetObjectPos(CourtVars[courtid][CourtBasketball], lel[0], lel[1], lel[2]);
    }
    foreach( new p: Player)
    {
        if(IsPlayerInRangeOfPoint(p, 30.0, Court[courtid][COURT_FIRST_HOOP_POS][0], Court[courtid][COURT_FIRST_HOOP_POS][1], Court[courtid][COURT_FIRST_HOOP_POS][2]))
        {
            switch(rand)
            {
                case 0: { PlayerPlaySound(p, 4600, lel[0], lel[1], lel[2]); }
                case 1: { PlayerPlaySound(p, 4601, lel[0], lel[1], lel[2]); }
                case 2: { PlayerPlaySound(p, 4602, lel[0], lel[1], lel[2]); }
            }
        }
    }
    return 1;
}

stock SyncBasketball(courtid, Float:height = 0.0)
{
    new Float:pos[6];
    if(CourtVars[courtid][CourtBasketball_BouncerID] != INVALID_PLAYER_ID || CourtVars[courtid][CourtBasketball_PasserID] != INVALID_PLAYER_ID)
    {
        GetObjectRot(CourtVars[courtid][CourtBasketball], pos[3], pos[4], pos[5]);
        GetPlayerPos(CourtVars[courtid][CourtBasketball_BouncerID], pos[0], pos[1], pos[2]);
        SOLS_DestroyObject(CourtVars[courtid][CourtBasketball], "Basketball/SyncBasketball BOUNCER", false);
        CourtVars[courtid][CourtBasketball] = CA_CreateObject_SC(2114, pos[0], pos[1], pos[2]+height, pos[3], pos[4], pos[5]);
    }
    else
    {
        GetObjectPos(CourtVars[courtid][CourtBasketball], pos[0], pos[1], pos[2]);
        GetObjectRot(CourtVars[courtid][CourtBasketball], pos[3], pos[4], pos[5]);
        SOLS_DestroyObject(CourtVars[courtid][CourtBasketball], "Basketball/SyncBasketball INVALIDBOUNCER", false);
        CourtVars[courtid][CourtBasketball] = CA_CreateObject_SC(2114, pos[0], pos[1], pos[2]+height, pos[3], pos[4], pos[5]);
    } 
    return 1;
}

stock GetDistance( Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2 )
{
    return floatround( floatsqroot( ( (( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) + ( ( z1 - z2 ) * ( z1 - z2 ) ) ) ) ) ;
}

stock SetObjectFaceDirection(courtid, objectid, Float:DirectionX, Float:DirectionY)
{
    new
        Float: pX = DirectionX,
        Float: pY = DirectionY,
        Float: gX,
        Float: gY,
        Float: gZ
    ;
    if(GetObjectPos(objectid, gX, gY, gZ))
	{
        pX = -atan2((gX - pX), (gY - pY));
        return SetObjectRot(objectid, 0.0, CourtVars[courtid][BounceRotationY], (pX + 180.0));
    }
    return false;
}
/*
stock GetXYRightOfPoint(&Float:a, &Float:X, &Float:Y, Float:distance)
{
    a -= 90.0;
    X += floatmul(floatsin(-a, degrees), distance);
    Y += floatmul(floatcos(-a, degrees), distance);
}

stock GetXYLeftOfPoint(&Float:a, &Float:X, &Float:Y, Float:distance)
{
    a -= 270.0;
    X += floatmul(floatsin(-a, degrees), distance);
    Y += floatmul(floatcos(-a, degrees), distance);
}

stock GetXYBackOfPoint(&Float:a, &Float:x, &Float:y, const Float:distance)
{
    x -= (distance * floatsin(-a, degrees));
    y -= (distance * floatcos(-a, degrees));
}


stock GetXYInFrontOfPoint(&Float:a, &Float:x2, &Float:y2, Float:distance)
{
    x2 += (distance * floatsin(-a, degrees));
    y2 += (distance * floatcos(-a, degrees));
}*/

stock GetXYInFrontOfObject(objectid, &Float:x2, &Float:y2, Float:distance)
{
    new Float:rx, Float:ry, Float:a;
    GetObjectPos(objectid, x2, y2, a);
    GetObjectRot(objectid, rx, ry, a);
    x2 += (distance * floatsin(-a, degrees));
    y2 += (distance * floatcos(-a, degrees));
}

stock KillAllTimers(courtid)
{
    if ( courtid == -1 ) {

        printf("Tried to reset timers for court but returned %d.", courtid ) ;
        return true ;
    }

    KillTimer(Timer_Bounce[courtid]); Timer_Bounce[courtid] = -1;
    KillTimer(Timer_BounceDelayedStart[courtid]); Timer_BounceDelayedStart[courtid] = -1;
    KillTimer(Timer_BounceRunDelayedStart[courtid]); Timer_BounceRunDelayedStart[courtid] = -1;
    KillTimer(Timer_BounceRunBack[courtid]); Timer_BounceRunBack[courtid] = -1;
    KillTimer(Timer_BounceBack[courtid]); Timer_BounceBack[courtid] = -1;
    //KillTimer(Timer_Accuracy[courtid]); Timer_Accuracy[courtid] = -1;
    KillTimer(Timer_Shoot[courtid]); Timer_Shoot[courtid] = -1;
    KillTimer(Timer_Fail[courtid]); Timer_Fail[courtid] = -1;
    KillTimer(Timer_Skim[courtid]); Timer_Skim[courtid] = -1;
    KillTimer(Timer_Pass[courtid]); Timer_Pass[courtid] = -1;
    KillTimer(Timer_Airblock[courtid]); Timer_Airblock[courtid] = -1;
    KillTimer(Timer_Endblock[courtid]); Timer_Endblock[courtid] = -1;
    KillTimer(Timer_StayBounce[courtid]); Timer_StayBounce[courtid] = -1;
    KillTimer(Timer_StayBounceBack[courtid]); Timer_StayBounceBack[courtid] = -1;
    KillTimer(Timer_RunBounce[courtid]); Timer_RunBounce[courtid] = -1;
    KillTimer(Timer_RunBounceBack[courtid]); Timer_RunBounceBack[courtid] = -1;
    KillTimer(Timer_Spin[courtid]); Timer_Spin[courtid] = -1;
    KillTimer(Timer_KillSpin[courtid]); Timer_KillSpin[courtid] = -1;
    return 1;
}