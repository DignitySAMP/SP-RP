public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
    GetObjectPos(objectid, oldX, oldY, oldZ);
    GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
    if(!playerobject) //If this is a global object, sync the position for other players
    {
        if(!IsValidObject(objectid)) return 1;
        SetObjectPos(objectid, fX, fY, fZ);
        SetObjectRot(objectid, fRotX, fRotY, fRotZ);
    }

    if(response == EDIT_RESPONSE_FINAL) //Save
    {
        if(Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_HOOPS] == 1) //1-Hoop
        {
            Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][0] = fX;
            Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][1] = fY;
            Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][2] = fZ;
            Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][3] = fRotZ;
            new Float:bX, Float:bY;
            GetXYInFrontOfObject( CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtHoop][0], bX, bY, 2.0);
            CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtBasketball] = CA_CreateObject_SC(2114, bX, bY, fZ-2.0, 0.0, 0.0, 0.0);
            SendClientMessage(playerid, -1, "Hoop is set.");

            new str[128], file[34], courtid = BasketPlayerVars [ playerid ] [ Editor_Court_ID ];
            format(file, sizeof(file), "Courts/%d.ini", courtid);
            dini_Create(file);

            dini_Set(file, "Name", Court[courtid][COURT_NAME]);
            dini_IntSet(file, "Hoops", Court[courtid][COURT_HOOPS]);
            dini_FloatSet(file, "Hoop_1_Pos_0", Court[courtid][COURT_FIRST_HOOP_POS][0]);
            dini_FloatSet(file, "Hoop_1_Pos_1", Court[courtid][COURT_FIRST_HOOP_POS][1]);
            dini_FloatSet(file, "Hoop_1_Pos_2", Court[courtid][COURT_FIRST_HOOP_POS][2]);
            dini_FloatSet(file, "Hoop_1_Pos_3", Court[courtid][COURT_FIRST_HOOP_POS][3]);

            CourtVars[courtid][CourtBasketball_BouncerID] = INVALID_PLAYER_ID;
            CourtVars[courtid][CourtBasketball_State] = STATE_FREE;

            format(str, sizeof(str), "You've completed creating the court \"%s\" (ID: %d)", Court[courtid][COURT_NAME], courtid);
            SendClientMessage(playerid, -1, str);
        }
        else if(Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_HOOPS] == 2) //2-Hoop
        {
            if(BasketPlayerVars[playerid][Editor_Court_Hoop] == 1)
            {
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][0] = fX;
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][1] = fY;
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][2] = fZ;
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_FIRST_HOOP_POS][3] = fRotZ;
                new Float:bX, Float:bY;
                GetXYInFrontOfObject(CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtHoop][0], bX, bY, 2.0);
                CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtBasketball] = CA_CreateObject_SC(2114, bX, bY, fZ-2.0, 0.0, 0.0, 0.0);
                SendClientMessage(playerid, -1, "First hoop is set.");
                BasketPlayerVars[playerid][Editor_Court_Hoop] = 2;
                new Float:pos[3];
                GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                SendClientMessage(playerid, -1, "Please set second hoop now.");
                GetXYInFrontOfPlayer(playerid, pos[0], pos[1], 2.5);
                CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtHoop][1] = CA_CreateObject_SC(946, pos[0], pos[1], pos[2]+1.15, 0.0, 0.0, 0.0);
                EditObject(playerid, CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtHoop][1]);
            }
            else if(BasketPlayerVars[playerid][Editor_Court_Hoop] == 2)
            {
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_SECOND_HOOP_POS][0] = fX;
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_SECOND_HOOP_POS][1] = fY;
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_SECOND_HOOP_POS][2] = fZ;
                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_SECOND_HOOP_POS][3] = fRotZ;
                SendClientMessage(playerid, -1, "Second hoop is also set.");
                BasketPlayerVars[playerid][Editor_Court_Hoop] = 0;

                new str[128], file[34], courtid = BasketPlayerVars [ playerid ] [ Editor_Court_ID ];
                format(file, sizeof(file), "Courts/%d.ini", courtid);
                dini_Create(file);

                dini_Set(file, "Name", Court[courtid][COURT_NAME]);
                dini_IntSet(file, "Hoops", Court[courtid][COURT_HOOPS]);
                dini_FloatSet(file, "Hoop_1_Pos_0", Court[courtid][COURT_FIRST_HOOP_POS][0]);
                dini_FloatSet(file, "Hoop_1_Pos_1", Court[courtid][COURT_FIRST_HOOP_POS][1]);
                dini_FloatSet(file, "Hoop_1_Pos_2", Court[courtid][COURT_FIRST_HOOP_POS][2]);
                dini_FloatSet(file, "Hoop_1_Pos_3", Court[courtid][COURT_FIRST_HOOP_POS][3]);
                dini_FloatSet(file, "Hoop_2_Pos_0", Court[courtid][COURT_SECOND_HOOP_POS][0]);
                dini_FloatSet(file, "Hoop_2_Pos_1", Court[courtid][COURT_SECOND_HOOP_POS][1]);
                dini_FloatSet(file, "Hoop_2_Pos_2", Court[courtid][COURT_SECOND_HOOP_POS][2]);
                dini_FloatSet(file, "Hoop_2_Pos_3", Court[courtid][COURT_SECOND_HOOP_POS][3]);

                CourtVars[courtid][CourtBasketball_BouncerID]  = INVALID_PLAYER_ID;
                CourtVars[courtid][CourtBasketball_State] = STATE_FREE;

                format(str, sizeof(str), "You've completed creating the court \"%s\" (ID: %d)", Court[courtid][COURT_NAME], courtid);
                SendClientMessage(playerid, -1, str);
            }
        }
    }

    if(response == EDIT_RESPONSE_CANCEL) //Cancel
    {
        SOLS_DestroyObject(objectid, "Basketball/OnEditObject CANCEL", false);
        SendClientMessage(playerid, -1, "You've cancelled placing the hoop." ) ;
    }
    return 0;
}

ShowBasketballCommmands(playerid){
    if ( ! PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_BASKET_INFOTD ] ) {

        HideMinigameHelpBox ( playerid ) ;
        UpdateMinigameHelpBox(playerid, "Basketball", "To play, press F near a basketball or have someone pass it. To leave, press F again.~n~~n~To steal, press RMB. To shoot, press LMB. To block, use SHIFT.~n~~n~To pass the ball to someone use RMB and LMB whilst looking at them.~n~~n~To spin the ball use LALT. To do a trick with the ball use LSHIFT." ) ;
        ShowMinigameHelpBox ( playerid ) ;

        PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_BASKET_INFOTD ] = true ;
    }

    else if ( PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_BASKET_INFOTD ] ) {

        HideMinigameHelpBox ( playerid ) ;
        PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_BASKET_INFOTD ] = false ;
    }

    return true ;
}

CMD:basketballhelp(playerid) {
    return ShowBasketballCommmands(playerid);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_SECONDARY_ATTACK)) //Pick up basketball
    {


        new courtid = GetNearestBasketball(playerid);
        if(courtid != -1)
        {
            if ( GetPlayerPing ( playerid ) > 100 ) {

                SendClientMessage(playerid, COLOR_YELLOW, "Due to your high ping (100+), the game may desync. If this occurs please leave the game A.S.A.P. or contact an admin." ) ;
            }

            if(CourtVars[courtid][CourtBasketball_BouncerID] == INVALID_PLAYER_ID && CourtVars[courtid][CourtBasketball_State] == STATE_FREE)
            {
                KillAllTimers(courtid);
                CourtVars[courtid][ShooterAccuracy] = 0;
                //SetPlayerProgressBarValue(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ], float(CourtVars[courtid][ShooterAccuracy]));
                //ShowPlayerProgressBar(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ]);
                //TextDrawShowForPlayer(playerid, TextdrawAccuracy);
                BasketPlayerVars[playerid][PlayerCourtID] = courtid;
                BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_PICKINGUP;
                CourtVars[courtid][CourtBasketball_State] = STATE_BOUNCED;
                CourtVars[courtid][CourtBasketball_BouncerID] = playerid;
                ApplyAnimation(playerid, "bsktball", "bball_pickup", 4.1, 0, 1, 1, 0, 0, 1);
                AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.0, 0.5, -0.85, 0.0, 0.0, 0.0);
                Timer_Bounce[courtid] = SetTimerEx("BounceIt", 600, false, "ii", playerid, courtid);

                if ( ! PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_BASKET_INFO ] ) {

                    PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_BASKET_INFO ] = true ;

                    SendClientMessage(playerid, COLOR_YELLOW, "If you want help about basketball, use /basketballhelp to see the minigame panel.");
                }

                return 0;
            }
        }
        if(BasketPlayerVars[playerid][PlayerCourtID] != -1)
        {
            if(BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING || BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_SPINNING || BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_PICKINGUP) { 
                KillAllTimers(BasketPlayerVars[playerid][PlayerCourtID]); 
                ResetBasketball(BasketPlayerVars[playerid][PlayerCourtID]); 
            }

            HideMinigameHelpBox ( playerid ) ;
            RemovePlayerFromBasketball(playerid);
            ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
        }
    }

    if(BasketPlayerVars[playerid][PlayerCourtID] != -1) //The player is playing in some court
    {
        new courtid = BasketPlayerVars[playerid][PlayerCourtID];

        if(HOLDING(KEY_FIRE)) //Accuracy metre
        {
            if(CourtVars[courtid][CourtBasketball_BouncerID] == playerid && IsPlayerInBasketballArea(playerid, courtid) && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING)
            {
                //Timer_Accuracy[courtid] = SetTimerEx("Accuracy", 250, true, "ii", courtid, playerid);

                CourtVars[courtid][ShooterAccuracy] = random ( 95 ) ;

            }

        }
        else if(RELEASED(KEY_FIRE))
        {
            if(Timer_Accuracy[courtid] != -1)
            {
                KillTimer(Timer_Accuracy[courtid]);
                Timer_Accuracy[courtid] = -1;
            }
        }

        if(newkeys == 132 && oldkeys == 128) // MOUSE1 + MOUSE2
        {
            if(CourtVars[courtid][CourtBasketball_BouncerID] == playerid && CourtVars[courtid][CourtBasketball_State] == STATE_BOUNCED && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING && IsPlayerInBasketballArea(playerid, courtid))
            {
                KillAllTimers(courtid);
                BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_BUSY;
                CourtVars[courtid] [ CourtBasketball_PasserID ] = playerid;
                SetTimerEx("ResetPlayerState", 1000, false, "d", playerid);
                SetTimerEx("HidePlayerHud", 1000, false, "i", playerid);
                new Float:randX, Float:randY, Float:randZ;
                GetPlayerPos(playerid, randX, randY, randZ);
                GetXYInFrontOfPlayer(playerid, randX, randY, 7.5);
                new shitrand = random(2);
                switch (shitrand)
                {
                    case 0: { randY = randY+float(random(1100-1000)+1000)/1000.0; }
                    case 1: { randY = randY-float(random(1100-1000)+1000)/1000.0; }
                }
                shitrand = random(2);
                switch (shitrand)
                {
                    case 0: { randX = randX+float(random(2000-1000)+1000)/1000.0; }
                    case 1: { randX = randX-float(random(2000-1000)+1000)/1000.0; }
                }
                new Float:playa[3]; GetPlayerPos(playerid, playa[0], playa[1], playa[2]);
                new thatdist = GetDistance(playa[0], playa[1], playa[2], randX, randY, Court[courtid][COURT_FIRST_HOOP_POS][2]-2.0);

                CourtVars[courtid] [ CBasketball_PassSlopeDistance ] = thatdist;
                CourtVars[courtid] [ CBasketball_PassSlopeHeight ] = Court[courtid][COURT_FIRST_HOOP_POS][2]-1.5 + (0.5 * float(thatdist));
                SyncBasketball(courtid);
                Timer_Pass[courtid] = SetTimerEx("GoPass", 100, true, "dff", courtid, randX, randY);
                ApplyAnimation(playerid, "bsktball", "bball_react_score", 4.1, 0, 1, 1, 0, 0, 1);
            }
        }
        else if(PRESSED(KEY_FIRE))
        {
            if(BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING && CourtVars[courtid][CourtBasketball_BouncerID] == playerid && CourtVars[courtid][CourtBasketball_State] == STATE_BOUNCED && IsPlayerInBasketballArea(playerid, courtid))
            {
                KillAllTimers(courtid);
                BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_BUSY;
                SetTimerEx("ResetPlayerState", 1000, false, "i", playerid);
                SetTimerEx("HidePlayerHud", 1000, false, "i", playerid);
                SetPlayerFaceBasket(playerid);
                new Float:shot[3];
                GetPlayerPos(playerid, shot[0], shot[1], shot[2]);
                new Float: fDistance = GetPlayerDistanceFromPoint(playerid, Court[courtid][COURT_FIRST_HOOP_POS][0], Court[courtid][COURT_FIRST_HOOP_POS][1], Court[courtid][COURT_FIRST_HOOP_POS][2]);
                CourtVars[courtid] [ IsBeingShot ] = false;
                if(fDistance < 2.5)
                {
                    CourtVars[courtid][CourtBasketball_State] = STATE_SHOT;
                    AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.0, 0.25, 1.0, 0.0, 0.0, 0.0);
                    ApplyAnimation(playerid, "bsktball", "bball_dnk_gli", 4.1, 0, 1, 1, 0, 0, 1);
                    SetTimerEx("DunkWait", 250, false, "i", playerid);
                    Timer_Shoot[courtid] = SetTimerEx("ShootIt", 500, false, "dddd", courtid, floatround(fDistance), playerid, 1);
                }
                else
                {
                    AttachObjectToPlayer(CourtVars[courtid][CourtBasketball], playerid, 0.0, 0.6, 0.4, 0.0, 0.0, 0.0);
                    CourtVars[courtid][CourtBasketball_State] = STATE_SHOT;
                    ApplyAnimation(playerid, "bsktball", "bball_jump_shot", 4.1, 0, 1, 1, 0, 0, 1);
                    Timer_Shoot[courtid] = SetTimerEx("ShootIt", 500, false, "dddd", courtid, floatround(fDistance), playerid, 0);
                }
            }
        }
        else if(HOLDING(KEY_WALK))
        {
            if(GetPlayerSpeed(playerid) == 0.0 && CourtVars[courtid][CourtBasketball_BouncerID] == playerid && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING)
            {
                KillTimer(Timer_Bounce[courtid]);
                SOLS_DestroyObject(CourtVars[courtid][CourtBasketball], "Basketball/KeyStateChange HOLDING WALK", false);
                CourtVars[courtid] [ SpinRot ] = 0.0;
                SetPlayerAttachedObject(playerid, 0, 2114, 6, 0.35, 0.0, 0.0);
                ApplyAnimation(playerid, "bsktball", "BBALL_idle2", 4.1, 0, 1, 1, 0, 0, 1);
                BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_SPINNING;
                Timer_Spin[courtid] = SetTimerEx("SpinIt", 80, true, "dd", playerid, courtid);
                Timer_KillSpin[courtid] = SetTimerEx("KillSpin", 2000, false, "dd", Timer_Spin[courtid], courtid);
            }                   
        }
        else if(HOLDING(128))
        {
            if(CourtVars[courtid][CourtBasketball_BouncerID] != playerid && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_FREE && Timer_Airblock[playerid] == -1)
            {
                BasketPlayerVars [ playerid ] [ PlayerBlocking ] = true;
                ApplyAnimation(playerid, "bsktball", "bball_def_loop", 4.1, 1, 0, 0, 0, 0, 1);
            }
        }
        else if(RELEASED(128))
        {
            if(CourtVars[courtid][CourtBasketball_BouncerID] != playerid && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_FREE && Timer_Airblock[playerid] == -1)
            {
                BasketPlayerVars [ playerid ] [ PlayerBlocking ] = false;
                ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);
            }
        }
        else if(CourtVars[courtid][CourtBasketball_BouncerID] != playerid && HOLDING(KEY_JUMP) && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_FREE)
        {
            if(Timer_Airblock[playerid] == -1)
            {
                ApplyAnimation(playerid, "bsktball", "bball_def_jump_shot", 4.1, 0, 1, 1, 0, 0, 1);
                Timer_Airblock[playerid] = SetTimerEx("TryBlock", 250, true, "dd", playerid, courtid);
                Timer_Endblock[playerid] = SetTimerEx("EndBlock", 700, false, "d", playerid);
            }
        }
        else if(PRESSED(KEY_JUMP))
        {
            if(Timer_Spin[courtid] == -1)
            {
                new Float:pos[3];
                GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                PauseAC(playerid, 3);
                SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            }
            if(GetPlayerSpeed(playerid) == 0.0 && CourtVars[courtid][CourtBasketball_BouncerID] == playerid && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING)
            {
                KillAllTimers(courtid);
                SOLS_DestroyObject(CourtVars[courtid][CourtBasketball], "Basketball/KeyStateChange PRESSED JUMP", false);
                CourtVars[courtid] [ SpinRot ] = 0.7;
                CourtVars[courtid] [ SpinTurn ]= false;
                SetPlayerAttachedObject(playerid, 0, 2114, 4, CourtVars[courtid] [ SpinRot ], 0.0, 0.0, 0.0, 0.0, 0.0);
                ApplyAnimation(playerid, "bsktball", "BBALL_idle", 4.1, 0, 1, 1, 0, 0, 1);
                BasketPlayerVars [ playerid ] [ PlayerState ] = PLAYER_SPINNING;
                Timer_Spin[courtid] = SetTimerEx("SpinItOnBack", 30, true, "dd", playerid, courtid);
            }
        }
    }
    
    #if defined basket_OnPlayerKeyStateChange
        return basket_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange basket_OnPlayerKeyStateChange
#if defined basket_OnPlayerKeyStateChange
    forward basket_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerUpdate(playerid)
{
    if(BasketPlayerVars[playerid][PlayerCourtID] != -1)
    {
        new Keys,ud,lr;
        GetPlayerKeys(playerid,Keys,ud,lr);

        if(BasketPlayerVars [ playerid ] [ PlayerBlocking ] == true && Timer_Airblock[playerid] == -1)
        {
            if(lr == KEY_LEFT)
            {
                ApplyAnimation(playerid, "bsktball", "bball_def_stepl", 4.1, 0, 1, 1, 1, 0, 1);
            }

            if(lr == KEY_RIGHT)
            {
                ApplyAnimation(playerid, "bsktball", "bball_def_stepr", 4.1, 0, 1, 1, 1, 0, 1);
            }
        }
        else if(CourtVars[BasketPlayerVars[playerid][PlayerCourtID]][CourtBasketball_BouncerID] == playerid && BasketPlayerVars [ playerid ] [ PlayerState ] == PLAYER_BOUNCING)
        {
            if(ud == KEY_UP)
            {
                BasketPlayerVars[playerid][ThrottleUpdate] ++;
                if(BasketPlayerVars[playerid][ThrottleUpdate]%2 == 0) //Using this until find better
                {
                    ApplyAnimation(playerid, "bsktball", "bball_run", 4.0, 0, 1, 1, 1, 1, 1);
                }
            }
            else if(ud == KEY_DOWN)
            {
                BasketPlayerVars[playerid][ThrottleUpdate] ++;
                if(BasketPlayerVars[playerid][ThrottleUpdate]%2 == 0)
                {
                    ApplyAnimation(playerid, "bsktball", "bball_run", 4.0, 0, 1, 1, 1, 1, 1);
                }
            }
            else if(lr == KEY_LEFT)
            {
                BasketPlayerVars[playerid][ThrottleUpdate] ++;
                if(BasketPlayerVars[playerid][ThrottleUpdate]%2 == 0)
                {
                    ApplyAnimation(playerid, "bsktball", "bball_run", 4.0, 0, 1, 1, 1, 1, 1);
                }
            }
            else if(lr == KEY_RIGHT)
            {
                BasketPlayerVars[playerid][ThrottleUpdate] ++;
                if(BasketPlayerVars[playerid][ThrottleUpdate]%2 == 0)
                {
                    ApplyAnimation(playerid, "bsktball", "bball_run", 4.0, 0, 1, 1, 1, 1, 1);
                }
            }
        }
    }
    
    #if defined basket_OnPlayerUpdate
        return basket_OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate basket_OnPlayerUpdate
#if defined basket_OnPlayerUpdate
    forward basket_OnPlayerUpdate(playerid);
#endif