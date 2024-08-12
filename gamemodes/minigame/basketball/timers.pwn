forward SpinIt(playerid, courtid);
public SpinIt(playerid, courtid)
{
	CourtVars[courtid] [ SpinRot ] += 50.0;
	SetPlayerAttachedObject(playerid, 0, 2114, 6, 0.35, 0.0, 0.0, CourtVars[courtid] [ SpinRot ], 0.0, 0.0);
	return 1;
}

forward SpinItOnBack(playerid, courtid);
public SpinItOnBack(playerid, courtid)
{
	if(CourtVars[courtid] [ SpinTurn ]== false) //Right Arm
	{
		if(CourtVars[courtid] [ SpinRot ] <= -0.5)
		{	
			CourtVars[courtid] [ SpinRot ] = -0.2;
			CourtVars[courtid] [ SpinTurn ]= true; //Now left
			SetPlayerAttachedObject(playerid, 0, 2114, 13, CourtVars[courtid] [ SpinRot ], 0.1, 0.0, 45.0, 0.0, -CourtVars[courtid] [ SpinRot ]*300.0);
		}
		else
		{
			CourtVars[courtid] [ SpinRot ] -= 0.03;
			SetPlayerAttachedObject(playerid, 0, 2114, 4, CourtVars[courtid] [ SpinRot ], 0.0, -0.2, 45.0, 0.0, CourtVars[courtid] [ SpinRot ]*300.0);
		}
	} 
	else if(CourtVars[courtid] [ SpinTurn ]== true) //Left Arm
	{
		if(CourtVars[courtid] [ SpinRot ] >= 0.60)
		{	
			KillTimer(Timer_Spin[courtid]);
			Timer_Spin[courtid] = -1;
			SyncBasketball(courtid);
			RemovePlayerAttachedObject(CourtVars[courtid][CourtBasketball_BouncerID], 0);
			BasketPlayerVars[CourtVars[courtid][CourtBasketball_BouncerID]][PlayerState] = PLAYER_BOUNCING;
			BounceIt(CourtVars[courtid][CourtBasketball_BouncerID], courtid);
		}
		else
		{
			CourtVars[courtid] [ SpinRot ] += 0.05;
			SetPlayerAttachedObject(playerid, 0, 2114, 13, CourtVars[courtid] [ SpinRot ], 0.1, 0.0, 45.0, 0.0, -CourtVars[courtid] [ SpinRot ]*300.0);
		}	
	}
	return 1;
}

forward KillSpin(timerid, courtid);
public KillSpin(timerid, courtid)
{
	KillTimer(timerid);
	Timer_Spin[courtid] = -1;
	SyncBasketball(courtid);
	RemovePlayerAttachedObject(CourtVars[courtid][CourtBasketball_BouncerID], 0);
	BasketPlayerVars[CourtVars[courtid][CourtBasketball_BouncerID]][PlayerState] = PLAYER_BOUNCING;
	BounceIt(CourtVars[courtid][CourtBasketball_BouncerID], courtid);
	return 1;
}

forward GoPass(courtid, Float:randX, Float:randY);
public GoPass(courtid, Float:randX, Float:randY)
{
	if(CourtVars[courtid] [ CBasketball_PassSlopeDistance ] > 0.0)
 	{
		new Float:ObjectRot[3];
 	    GetObjectRot(CourtVars[courtid][CourtBasketball], ObjectRot[0], ObjectRot[1], ObjectRot[2]);
		MoveObject(CourtVars[courtid][CourtBasketball], randX, randY, CourtVars[courtid] [ CBasketball_PassSlopeHeight ], 14.0, ObjectRot[0], ObjectRot[1], ObjectRot[2]);
		CourtVars[courtid] [ CBasketball_PassSlopeDistance ] -= 1.0;
		CourtVars[courtid] [ CBasketball_PassSlopeHeight ] -= 0.62;

		new Float:catcher[3];
		GetObjectPos(CourtVars[courtid][CourtBasketball], catcher[0], catcher[1], catcher[2]);

		
		new targetid;
		foreach(new p: Player)
		{
		    if(IsPlayerConnected(p) && IsPlayerInBasketballArea(p, courtid) && CourtVars[courtid] [ CourtBasketball_PasserID ] != p && BasketPlayerVars[p][PlayerState] == PLAYER_FREE && IsPlayerInRangeOfPoint(p, 2.5, catcher[0], catcher[1], catcher[2]))
		    {
				targetid = CourtVars[courtid] [ CourtBasketball_PasserID ];
       			SetPlayerChatBubble(targetid, "> passes the basketball", COLOR_ACTION, 7.5, 4000) ;
       			SendClientMessage(targetid, COLOR_ACTION, sprintf("> * %s passes the basketball to %s.", ReturnSettingsName(targetid, targetid), ReturnSettingsName(p, targetid) )) ;

                HideMinigameHelpBox ( p ) ;
                UpdateMinigameHelpBox(p, "Basketball", "To play, press F near a basketball or have someone pass it. To leave, press F again.~n~~n~To steal, press RMB. To shoot, press LMB. To block, use SHIFT.~n~~n~To spin the ball use LALT. To do a trick with the ball use LSHIFT." ) ;
                ShowMinigameHelpBox ( p ) ;

		        KillTimer(Timer_Pass[courtid]);
		        BasketPlayerVars[p][PlayerBlocking] = false;
		        ApplyAnimation(p, "bsktball", "bball_jump_cancel", 4.1, 0, 1, 1, 0, 0, 1);
		        CourtVars[courtid][CourtBasketball_State] = STATE_BOUNCED;
		        BasketPlayerVars[p][PlayerState] = PLAYER_BOUNCING;
		        CourtVars[courtid][CourtBasketball_BouncerID] = p;
		        BasketPlayerVars[p][PlayerCourtID] = courtid;
    			BounceIt(p, courtid);
    			CourtVars[courtid][ShooterAccuracy] = 0;
    			//SetPlayerProgressBarValue(p, BasketPlayerVars[p][PlayerAccuracyBar], float(CourtVars[courtid][ShooterAccuracy]));
    			//ShowPlayerProgressBar(p, BasketPlayerVars[p][PlayerAccuracyBar]);
				//TextDrawShowForPlayer(p, TextdrawAccuracy);
    			break;
		    }
		}
	}
	else
	{
		KillTimer(Timer_Pass[courtid]);
	    CourtVars[courtid][CourtBasketball_State] = STATE_SKIMMED;
	    CourtVars[courtid][CourtBasketball_Skims] = -1;
	    SetObjectFaceDirection(courtid, CourtVars[courtid][CourtBasketball], randX, randY);
		Timer_Skim[courtid] = SetTimerEx("FailSkimIt", 50, false, "dfff", courtid, randX, randY, Court[courtid][COURT_FIRST_HOOP_POS][2]);
	}
	return 1;
}

forward FailSkimIt(courtid, Float:X, Float:Y, Float:Z);
public FailSkimIt(courtid, Float:X, Float:Y, Float:Z)
{
    new Float:Rot[3], Float:pointer[3];
    CourtVars[courtid][BounceRotationY] -= 23.0;
    if(CourtVars[courtid][CourtBasketball_Skims] == -1)
    {
        CourtVars[courtid][CourtBasketball_Skims] = 3;
        Timer_Skim[courtid] = SetTimerEx("FailSkimIt", 160, true, "dfff", courtid, X, Y, Z);
    }
	else if(CourtVars[courtid][CourtBasketball_Skims] == 3)
	{
        GetObjectPos(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], pointer[2]);
		GetXYInFrontOfObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], 1.0);
	    GetObjectRot(CourtVars[courtid][CourtBasketball], Rot[0], Rot[1], Rot[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], Z-1.0, 5.0, CourtVars[courtid][BounceRotationY], Rot[1], Rot[2]);
 		CourtVars[courtid][CourtBasketball_Skims] --;
 	}
 	else if(CourtVars[courtid][CourtBasketball_Skims] == 2)
	{
	    GetObjectPos(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], pointer[2]);
		GetXYInFrontOfObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], 1.0);
	    GetObjectRot(CourtVars[courtid][CourtBasketball], Rot[0], Rot[1], Rot[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], Z-2.0, 4.5, CourtVars[courtid][BounceRotationY], Rot[1], Rot[2]);
 		CourtVars[courtid][CourtBasketball_Skims] --;
 		SoundBall(courtid);
 	}
 	else if(CourtVars[courtid][CourtBasketball_Skims] == 1)
	{
	    GetObjectPos(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], pointer[2]);
		GetXYInFrontOfObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], 1.0);
	    GetObjectRot(CourtVars[courtid][CourtBasketball], Rot[0], Rot[1], Rot[2]);
	    MoveObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], Z-1.5, 4.0, CourtVars[courtid][BounceRotationY], Rot[1], Rot[2]);
 		CourtVars[courtid][CourtBasketball_Skims] --;
 	}
	else if(CourtVars[courtid][CourtBasketball_Skims] == 0)
	{
	    GetObjectPos(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], pointer[2]);
		GetXYInFrontOfObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], 1.0);
	    GetObjectRot(CourtVars[courtid][CourtBasketball], Rot[0], Rot[1], Rot[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pointer[0], pointer[1], Z-2.0, 3.5, CourtVars[courtid][BounceRotationY], Rot[1], Rot[2]);
 		SoundBall(courtid);
		KillTimer(Timer_Skim[courtid]);
		Timer_Skim[courtid] = -1;
		CourtVars[courtid] [ CourtBasketball_PasserID ] = INVALID_PLAYER_ID;
		CourtVars[courtid][CourtBasketball_BouncerID] = INVALID_PLAYER_ID;
		CourtVars[courtid][CourtBasketball_State] = STATE_FREE;
 	}
	return 1;
}

forward ShootIt(courtid, dist, playerid, IsDunk);
public ShootIt(courtid, dist, playerid, IsDunk)
{
    new Float:target[3];
	if(CourtVars[courtid] [ IsBeingShot ] == false)
	{
		SyncBasketball(courtid, 1.0);
		CourtVars[courtid][CourtBasketball_BouncerID] = INVALID_PLAYER_ID;
	    CourtVars[courtid] [ IsBeingShot ] = true;
	    Timer_Shoot[courtid] = SetTimerEx("ShootIt", 50, true, "dddd", courtid, dist, playerid, IsDunk);
	    CourtVars[courtid][CourtBasketball_SlopeDistance] = dist;
	    CourtVars[courtid][CourtBasketball_SlopeHeight] = (Court[courtid][COURT_FIRST_HOOP_POS][2]+2.0) + (0.5 * float(dist));
   		KillTimer(Timer_Accuracy[courtid]);
   		Timer_Accuracy[courtid] = -1;
	}
	else if(CourtVars[courtid][CourtBasketball_SlopeHeight] > Court[courtid][COURT_FIRST_HOOP_POS][2]+0.5)
 	{
 	    target[0] = Court[courtid][COURT_FIRST_HOOP_POS][0];
 	    target[1] = Court[courtid][COURT_FIRST_HOOP_POS][1];
 	    target[2] = Court[courtid][COURT_FIRST_HOOP_POS][3];

 	    CourtVars[courtid][BounceRotationY] += 2.0;
		CourtVars[courtid][BounceRotationZ] += 6.0;

 	    GetXYInFrontOfPoint(target[2], target[0], target[1], 0.51); // These fix ball's alignment to the hoop
 	    GetXYRightOfPoint(target[2], target[0], target[1], 0.06);

		MoveObject(CourtVars[courtid][CourtBasketball], target[0], target[1], CourtVars[courtid][CourtBasketball_SlopeHeight], 11.0, 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
		CourtVars[courtid][CourtBasketball_SlopeDistance] --;
		CourtVars[courtid][CourtBasketball_SlopeHeight] -= 0.5;
	}
	else
	{
	    CourtVars[courtid] [ IsBeingShot ] = false;
	    KillTimer(Timer_Shoot[courtid]);
	    Timer_Shoot[courtid] = -1;

	    if ( CourtVars[courtid][ShooterAccuracy] >= 100 ) {
	    	CourtVars[courtid][ShooterAccuracy] = 95 ;
	    }

		if(IsDunk == 1) { CourtVars[courtid][ShooterAccuracy] = 95; }
		new bool:randoms[100];
	    for(new r = 0; r < sizeof(randoms); r++)
	    {
	        randoms[r] = false;
	    }
		new chance = CourtVars[courtid][ShooterAccuracy] - dist*2;
		if(chance <= 0) { chance = 1; }
		else if(chance >= 100 ) { chance = 95; }
		for(new c = 0; c < chance; c++)
		{
		    randoms[c] = true;
  		}
		new pick = random(100);
     	//printf("Distance: %d | Accuracy: %d | Chance: %d | Pick: %d", dist, CourtVars[courtid][ShooterAccuracy], chance, pick);

		if(randoms[pick] == false)
	    {
	    	//Fail
	    	//new randomiser = random(3), Float:Rot[3], Float:randX, Float:randY, Float:FrontDistance = float(random(5-3)+3);

	    	new Float:Rot[3], Float:randX, Float:randY, Float:FrontDistance = 1.5 ;
	    	GetObjectRot(CourtVars[courtid][CourtHoop][0], Rot[0], Rot[1], Rot[2]);
			GetXYInFrontOfObject(CourtVars[courtid][CourtHoop][0], randX, randY, FrontDistance);
			//switch(randomiser)
			//{
	    	//	case 1: { GetXYRightOfPoint(Rot[2], randX, randY, float(random(3000-100)+100)/1000.0); }
	    	//	case 2: { GetXYLeftOfPoint(Rot[2], randX, randY, float(random(3000-100)+100)/1000.0); }
 			//}
			new slope_dist = GetDistance(Court[courtid][COURT_FIRST_HOOP_POS][0], Court[courtid][COURT_FIRST_HOOP_POS][1], Court[courtid][COURT_FIRST_HOOP_POS][2], randX, randY, Court[courtid][COURT_FIRST_HOOP_POS][2]);

		    CourtVars[courtid][CBasketball_FailSlopeDistance] = slope_dist;
		    CourtVars[courtid][CBasketball_FailSlopeHeight] = Court[courtid][COURT_FIRST_HOOP_POS][2] + (0.5 * float(slope_dist));
		    SetObjectFaceDirection(courtid, CourtVars[courtid][CourtBasketball], randX, randY);

       		SetPlayerChatBubble(playerid,  sprintf("> shoots the basketball over %0.2f yards and MISSES.", float ( dist ) ), COLOR_ACTION, 7.5, 4000) ;
   			SendClientMessage(playerid, COLOR_ACTION,  sprintf("> shoots the basketball over %0.2f yards and MISSES.", float ( dist ) ) ) ;

			CourtVars[courtid][IsBeingFailed] = true;
			if(dist < 5.0) { Timer_Fail[courtid] = SetTimerEx("GoFail", 10, false, "dfff", courtid, randX, randY, dist); }              //These values are bad and need to be fixed
			else { Timer_Fail[courtid] = SetTimerEx("GoFail", floatround(dist * 9.0), false, "dfff", courtid, randX, randY, dist); }	//More it takes time, we need more delay to start skimming it
	    }
	    else
	    {
		    //Sucess
		    CourtVars[courtid][CourtBasketball_State] = STATE_SKIMMED;

		    target[0] = Court[courtid][COURT_FIRST_HOOP_POS][0];
	 	    target[1] = Court[courtid][COURT_FIRST_HOOP_POS][1];
	 	    target[2] = Court[courtid][COURT_FIRST_HOOP_POS][3];

	 	    GetXYInFrontOfPoint(target[2], target[0], target[1], 0.51); // These fix ball's alignment to the hoop
	 	    GetXYRightOfPoint(target[2], target[0], target[1], 0.06);

	 	    new Float:oRot[3];
	 	    GetObjectRot(CourtVars[courtid][CourtBasketball], oRot[0], oRot[1], oRot[2]);
		    MoveObject(CourtVars[courtid][CourtBasketball], target[0], target[1], Court[courtid][COURT_FIRST_HOOP_POS][2]-2.0, 8.0, oRot[0], oRot[1], oRot[2]);

		    Timer_Skim[courtid] = -1;
		    if(dist < 5) { SetTimerEx("SkimIt", 400, false, "i", courtid); }
			else if(dist < 10) { SetTimerEx("SkimIt", 460, false, "i", courtid); }
			else if(dist < 15) { SetTimerEx("SkimIt", 580, false, "i", courtid); }
			else { SetTimerEx("SkimIt", floatround(dist * 55.0), false, "i", courtid); } //More it takes time, we need more delay to start skimming it

			foreach(new p: Player)
	  		{
	  		    if(IsPlayerConnected(p) && IsPlayerInBasketballArea(p, courtid))
	  		    {
		  		    PlayerPlaySound(p, 4604, Court[courtid][COURT_FIRST_HOOP_POS][0], Court[courtid][COURT_FIRST_HOOP_POS][1], Court[courtid][COURT_FIRST_HOOP_POS][2]);
	  		    }
			}

			if ( IsDunk ) {
				SetPlayerChatBubble(playerid, "> dunks the basketball.", COLOR_ACTION, 7.5, 4000) ;
   				SendClientMessage(playerid, COLOR_ACTION, sprintf("> * %s dunks the basketball.", ReturnSettingsName(playerid, playerid))) ;
			}

			else if (! IsDunk ) {
   				SendClientMessage(playerid, COLOR_ACTION,  sprintf("> shoots the basketball over %0.2f yards and SCORES.", float ( dist ) )) ;
				SetPlayerChatBubble(playerid,  sprintf("> shoots the basketball over %0.2f yards and SCORES.", float ( dist ) ), COLOR_ACTION, 7.5, 4000) ;
			}
		}
	}
	return 1;
}

forward SkimIt(courtid);
public SkimIt(courtid)
{
    new Float:pos[3];

    CourtVars[courtid][BounceRotationY] += 2.0;
	CourtVars[courtid][BounceRotationZ] += 6.0;

    if(Timer_Skim[courtid] == -1)
	{
	    CourtVars[courtid][CourtBasketball_Skims] = 3;
    	Timer_Skim[courtid] = SetTimerEx("SkimIt", 150, true, "i", courtid);
	}
	if(CourtVars[courtid][CourtBasketball_Skims] == 3)
	{
		GetObjectPos(CourtVars[courtid][CourtBasketball], pos[0], pos[1], pos[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pos[0], pos[1], Court[courtid][COURT_FIRST_HOOP_POS][2]+1.0, 4.5, 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
 		CourtVars[courtid][CourtBasketball_Skims]--;
 	}
 	else if(CourtVars[courtid][CourtBasketball_Skims] == 2)
	{
	    GetObjectPos(CourtVars[courtid][CourtBasketball], pos[0], pos[1], pos[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pos[0], pos[1], Court[courtid][COURT_FIRST_HOOP_POS][2]-2.0, 4.0, 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
 		CourtVars[courtid][CourtBasketball_Skims]--;
 		SoundBall(courtid);
 	}
 	else if(CourtVars[courtid][CourtBasketball_Skims] == 1)
	{
	    GetObjectPos(CourtVars[courtid][CourtBasketball], pos[0], pos[1], pos[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pos[0], pos[1], Court[courtid][COURT_FIRST_HOOP_POS][2]+0.5, 3.5, 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
 		CourtVars[courtid][CourtBasketball_Skims]--;
 	}
 	else if(CourtVars[courtid][CourtBasketball_Skims] == 0)
	{
	    GetObjectPos(CourtVars[courtid][CourtBasketball], pos[0], pos[1], pos[2]);
 		MoveObject(CourtVars[courtid][CourtBasketball], pos[0], pos[1], Court[courtid][COURT_FIRST_HOOP_POS][2]-2.0, 3.0, 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
 		SoundBall(courtid);
		KillTimer(Timer_Skim[courtid]);
		Timer_Skim[courtid] = -1;
		CourtVars[courtid][CourtBasketball_State] = STATE_FREE;
 	}
	return 1;
}

forward GoFail(courtid, Float:randX, Float:randY, Float:dist);
public GoFail(courtid, Float:randX, Float:randY, Float:dist)
{
	if(CourtVars[courtid][IsBeingFailed] == true)
	{
	    CourtVars[courtid][IsBeingFailed] = false;
	    Timer_Fail[courtid] = SetTimerEx("GoFail", 40, true, "dfff", courtid, randX, randY, dist);
	}
	else {
		if(CourtVars[courtid][CBasketball_FailSlopeHeight] > Court[courtid][COURT_FIRST_HOOP_POS][2]-2.1)
	 	{
	 		CourtVars[courtid][BounceRotationY] -= 23.0;
	 	    new Float:ObjectRot[3];
	 	    GetObjectRot(CourtVars[courtid][CourtBasketball], ObjectRot[0], ObjectRot[1], ObjectRot[2]);

			MoveObject(CourtVars[courtid][CourtBasketball], randX, randY, CourtVars[courtid][CBasketball_FailSlopeHeight], 7.0, CourtVars[courtid][BounceRotationY], ObjectRot[1], ObjectRot[2]);

			CourtVars[courtid][CBasketball_FailSlopeDistance] --;
			CourtVars[courtid][CBasketball_FailSlopeHeight] -= 0.5;
		}
		else
		{
			KillTimer(Timer_Fail[courtid]);
		    CourtVars[courtid][CourtBasketball_State] = STATE_SKIMMED;
		    foreach(new p: Player)
			{
			    if(IsPlayerConnected(p) && IsPlayerInBasketballArea(p, courtid))
			    {
			        PlayerPlaySound(p, 4603, Court[courtid][COURT_FIRST_HOOP_POS][0], Court[courtid][COURT_FIRST_HOOP_POS][1], Court[courtid][COURT_FIRST_HOOP_POS][2]);
	      		}
			}
	        CourtVars[courtid][CourtBasketball_Skims] = -1;
			SetTimerEx("FailSkimIt", 120, false, "dfff", courtid, randX, randY, Court[courtid][COURT_FIRST_HOOP_POS][2]);
		}
	}
	return 1;
}

forward ResetPlayerState(playerid);
public ResetPlayerState(playerid)
{
    BasketPlayerVars [ playerid ] [ PlayerState ] = STATE_FREE;
    return 1;
}

forward ResetPlayerImmunity(playerid);
public ResetPlayerImmunity(playerid)
{
    BasketPlayerVars [ playerid ] [ PlayerImmunity ] = false;
    return 1;
}

forward DunkWait(playerid);
public DunkWait(playerid)
{
    ApplyAnimation(playerid, "bsktball", "bball_dnk", 4.1, 0, 1, 1, 0, 0, 1);
    SetTimerEx("DunkDown", 500, false, "i", playerid);
	return 1;
}

forward DunkDown(playerid);
public DunkDown(playerid)
{
    ApplyAnimation(playerid, "bsktball", "bball_dnk_lnd", 4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}

forward HidePlayerHud(playerid);
public HidePlayerHud(playerid)
{
    //HidePlayerProgressBar(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ]);
	//TextDrawHideForPlayer(playerid, TextdrawAccuracy);
	return 1;
}
/*
forward Accuracy(courtid, playerid);
public Accuracy(courtid, playerid)
{
	if(CourtVars[courtid][ShooterAccuracyTurn] == false)
	{
	    CourtVars[courtid][ShooterAccuracy] += 10;
	}
	else
	{
	    CourtVars[courtid][ShooterAccuracy] -= 10;
	}

	if(CourtVars[courtid][ShooterAccuracy] > 100)
	{
	    CourtVars[courtid][ShooterAccuracy] = 90;
	    CourtVars[courtid][ShooterAccuracyTurn] = true;
	}
	else if(CourtVars[courtid][ShooterAccuracy] < 0)
	{
	    CourtVars[courtid][ShooterAccuracy] = 10;
	    CourtVars[courtid][ShooterAccuracyTurn] = false;
	}

	//SetPlayerProgressBarValue(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ], float(CourtVars[courtid][ShooterAccuracy]));

	return 1;
}
*/
forward ResetBasketball(courtid);
public ResetBasketball(courtid)
{
    CourtVars[courtid][CourtBasketball_State] = STATE_FREE;
	CourtVars[courtid][CourtBasketball_BouncerID] = INVALID_PLAYER_ID;
	SOLS_DestroyObject(CourtVars[courtid][CourtBasketball], "Basketball/ResetBasketball", false);
	new Float:bX, Float:bY;
	GetXYInFrontOfObject(CourtVars[courtid][CourtHoop][0], bX, bY, 2.0);
    CourtVars[courtid][CourtBasketball] = CA_CreateObject_SC(2114, bX, bY, Court[courtid][COURT_FIRST_HOOP_POS][2]-2.0, 0.0, 0.0, 0.0);
    return 1;
}

forward BounceIt(playerid, courtid);
public BounceIt(playerid, courtid)
{
	if(IsPlayerInBasketballArea(playerid, courtid) && CourtVars[courtid][CourtBasketball_BouncerID] == playerid)
	{
		if(BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_PICKINGUP) { 
			BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_BOUNCING; 
		}

		new Float:pz[4];
		GetPlayerPos(playerid, pz[0], pz[1], pz[2]);
		GetXYRightOfPlayer(playerid, pz[0], pz[1], 0.4);
		GetPlayerFacingAngle(playerid, pz[3]);

		new Float:caught[3], bool:catching = false;
	 	GetPlayerPos(playerid, caught[0], caught[1], caught[2]);

		foreach(new p: Player)
		{
		    if(IsPlayerConnected(p) && IsPlayerInBasketballArea(p, courtid) && p != playerid && BasketPlayerVars[p][PlayerBlocking] == true && BasketPlayerVars [ playerid ] [ PlayerImmunity ] == false && IsPlayerInRangeOfPoint(p, 1.5, caught[0], caught[1], caught[2]))
		    {

       			if ( PlayerVar [ p ] [ E_PLAYER_MINIGAME_BASKET_CD ] > gettime() ) {
       				
       				SendClientMessage(p, COLOR_YELLOW, sprintf("You are on steal cooldown! Try again in %d seconds.",  PlayerVar [ p ] [ E_PLAYER_MINIGAME_BASKET_CD ] - gettime() )) ;
       				continue ;
       			}

        		SetPlayerChatBubble(p, "steals the ball.", COLOR_ACTION, 7.5, 4000) ;
       			SendClientMessage(p, COLOR_ACTION, sprintf("> * %s steals the ball from %s.", ReturnSettingsName(p, playerid), ReturnSettingsName(playerid, p))) ;

       			// Add cooldown!
       			PlayerVar [ p ] [ E_PLAYER_MINIGAME_BASKET_CD ] = gettime () + 3 ;

		        catching = true;
		        ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
		        //HidePlayerProgressBar(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ]);
				//TextDrawHideForPlayer(playerid, TextdrawAccuracy);
				BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_BUSY;
				SetTimerEx("ResetPlayerState", 1000, false, "i", playerid);
				BasketPlayerVars[p][PlayerBlocking] = false;
				BasketPlayerVars[p][PlayerImmunity] = true;
				SetTimerEx("ResetPlayerImmunity", 2000, false, "i", p);
				KillTimer(Timer_Bounce[courtid]);
				Timer_Bounce[courtid] = -1;
				KillTimer(Timer_BounceBack[courtid]);
				Timer_BounceBack[courtid] = -1;
				CourtVars[courtid][CourtBasketball_BouncerID] = p;
				BasketPlayerVars[p][PlayerCourtID] = courtid;
	   			CourtVars[courtid][CourtBasketball_State] = STATE_BOUNCED;
	   			BasketPlayerVars[p][PlayerState] = PLAYER_BOUNCING;
				BounceIt(p, courtid);
				ApplyAnimation(p, "bsktball", "bball_jump_cancel", 4.1, 0, 1, 1, 0, 0, 1);
				CourtVars[courtid][ShooterAccuracy] = 0;
				//SetPlayerProgressBarValue(p, BasketPlayerVars[p][PlayerAccuracyBar], float(CourtVars[courtid][ShooterAccuracy]));
				//ShowPlayerProgressBar(p, BasketPlayerVars[p][PlayerAccuracyBar]);
				//TextDrawShowForPlayer(p, TextdrawAccuracy);
				break;
		    }
		}

	    if(catching == false)
	    {
			if(GetPlayerSpeed(playerid) < 2.0)
			{	
				ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
			    ApplyAnimation(playerid, "bsktball", "bball_idleloop", 4.1,0,0,0,1,1);
				Timer_Bounce[courtid] = SetTimerEx("BounceIt", 650, false, "ii", playerid, courtid);
				CourtVars[courtid][BounceHeight] = -0.1;
				AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.4, 0.3, -0.1, 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
				Timer_StayBounce[courtid] = SetTimerEx("StayBounce", 140, false, "ii", playerid, courtid);
			}
			else
			{
			    Timer_Bounce[courtid] = SetTimerEx("BounceIt", 400, false, "ii", playerid, courtid);
				CourtVars[courtid][BounceHeight] = -0.1;
				AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.4, 0.3, -0.1, 0.0, 0.0, 0.0);
				Timer_RunBounce[courtid] = SetTimerEx("RunBounce", 40, false, "ii", playerid, courtid);
			}
		}
	}
	else
	{
	    KillAllTimers(courtid);
        ResetBasketball(courtid);
        BasketPlayerVars[playerid][PlayerCourtID] = -1;
	}
	return 1;
}

forward RunBounce(playerid, courtid);
public RunBounce(playerid, courtid)
{
	CourtVars[courtid][BounceRotationY] += 2.0;
	CourtVars[courtid][BounceRotationZ] += 6.0;
	CourtVars[courtid][BounceHeight] -= 0.075; if(CourtVars[courtid][BounceHeight] < -0.85) { CourtVars[courtid][BounceHeight] = -0.85; }
	AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.4, 0.3, CourtVars[courtid][BounceHeight], 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
	if(CourtVars[courtid][BounceHeight] == -0.85)
	{
		KillTimer(Timer_StayBounce[courtid]);
		Timer_RunBounceBack[courtid] = SetTimerEx("StayBounceBack", 15, false, "ii", playerid, courtid);

	}
	else
	{
		Timer_RunBounce[courtid] = SetTimerEx("StayBounce", 15, false, "ii", playerid, courtid);
	}
	return 1;
}

forward RunBounceBack(playerid, courtid);
public RunBounceBack(playerid, courtid)
{
	CourtVars[courtid][BounceRotationY] += 2.0;
	CourtVars[courtid][BounceRotationZ] += 6.0;
	CourtVars[courtid][BounceHeight] += 0.05625; if(CourtVars[courtid][BounceHeight] > -0.1) { CourtVars[courtid][BounceHeight] = -0.1; }
	AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.4, 0.3, CourtVars[courtid][BounceHeight], 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
	if(CourtVars[courtid][BounceHeight] >= -0.1)
	{
		KillTimer(Timer_RunBounceBack[courtid]);
	}
	else
	{
		Timer_RunBounceBack[courtid] = SetTimerEx("StayBounceBack", 15, false, "ii", playerid, courtid);
	}
	return 1;
}

forward StayBounce(playerid, courtid);
public StayBounce(playerid, courtid)
{ 
	CourtVars[courtid][BounceRotationY] += 2.0;
	CourtVars[courtid][BounceRotationZ] += 6.0;
	CourtVars[courtid][BounceHeight] -= 0.05625000140625; if(CourtVars[courtid][BounceHeight] < -0.85) { CourtVars[courtid][BounceHeight] = -0.85; }
	AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.4, 0.3, CourtVars[courtid][BounceHeight], 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
	if(CourtVars[courtid][BounceHeight] == -0.85)
	{
		SoundBall(courtid);
		KillTimer(Timer_StayBounce[courtid]);
		Timer_StayBounceBack[courtid] = SetTimerEx("StayBounceBack", 15, false, "ii", playerid, courtid);
	}
	else
	{
		Timer_StayBounce[courtid] = SetTimerEx("StayBounce", 15, false, "ii", playerid, courtid);
	}
	return 1;
}

forward StayBounceBack(playerid, courtid);
public StayBounceBack(playerid, courtid)
{
	CourtVars[courtid][BounceRotationY] += 2.0;
	CourtVars[courtid][BounceRotationZ] += 6.0;
	CourtVars[courtid][BounceHeight] += 0.0432692307692308; if(CourtVars[courtid][BounceHeight] > -0.1) { CourtVars[courtid][BounceHeight] = -0.1; }
	AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.4, 0.3, CourtVars[courtid][BounceHeight], 0.0, CourtVars[courtid][BounceRotationY], CourtVars[courtid][BounceRotationZ]);
	if(CourtVars[courtid][BounceHeight] >= -0.1)
	{
		KillTimer(Timer_StayBounceBack[courtid]);
	}
	else
	{
		Timer_StayBounceBack[courtid] = SetTimerEx("StayBounceBack", 15, false, "ii", playerid, courtid);
	}
	return 1;
}

forward TryBlock(playerid, courtid);
public TryBlock(playerid, courtid)
{
    new Float:pos[3];
    GetObjectPos(CourtVars[courtid][CourtBasketball], pos[0], pos[1], pos[2]);
    if(IsPlayerInRangeOfPoint(playerid, 1.0, pos[0], pos[1], pos[2]-1.5) && CourtVars[courtid][CourtBasketball_State] == STATE_SHOT)
    {
        KillTimer(Timer_Airblock[playerid]);
        Timer_Airblock[playerid] = -1;
        KillTimer(Timer_Endblock[playerid]);
        Timer_Endblock[playerid] = -1;
        KillTimer(Timer_Shoot[courtid]);
        Timer_Shoot[courtid] = -1;

        SetPlayerChatBubble(playerid,"> blocks the ball from hitting the hoop.", COLOR_ACTION, 7.5, 4000) ;
		SendClientMessage(playerid, COLOR_ACTION,"> blocks the ball from hitting the hoop." ) ;


        ApplyAnimation(CourtVars[courtid][CourtBasketball_BouncerID], "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
        BasketPlayerVars [ playerid ] [ PlayerBlocking ] = false;
        CourtVars[courtid][CourtBasketball_BouncerID] = playerid;
        BasketPlayerVars[playerid][PlayerCourtID] = courtid;
        CourtVars[courtid][CourtBasketball_State] = STATE_BOUNCED;
        BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_BOUNCING;
        CourtVars[courtid][ShooterAccuracy] = 0;
        BounceIt(playerid, courtid);


        ApplyAnimation(playerid, "bsktball", "bball_jump_cancel", 4.1, 0, 1, 1, 0, 0, 1);
        //SetPlayerProgressBarValue(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ], float(CourtVars[courtid][ShooterAccuracy]));
        //ShowPlayerProgressBar(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ]);
        //TextDrawShowForPlayer(playerid, TextdrawAccuracy);
    }
    return 1;
}

forward EndBlock(playerid);
public EndBlock(playerid)
{
    KillTimer(Timer_Airblock[playerid]);
    Timer_Airblock[playerid] = -1;
    Timer_Endblock[playerid] = -1;
    return 1;
}
