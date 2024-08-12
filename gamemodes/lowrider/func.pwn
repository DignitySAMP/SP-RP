#include <YSI_Coding\y_hooks>

#define LOWRIDER_TD_X_MAX (575.0)
#define LOWRIDER_TD_X_MIN (270.0)

new PlayerCurrentMoveIndex[MAX_PLAYERS]; // Saves index of new move, used to see if MAX_LOWRIDER_MOVE_TDS cap is reached
new PlayerCurrentMoveCD[MAX_PLAYERS]; // Random cooldown on creation, to add "randomness" to the game
new LowriderCreateCD[MAX_PLAYERS]; // Adds a small cooldown when a new key is spawned to avoid overlap
new LowriderMoveCD[MAX_PLAYERS]; // Adds a small cooldown when a key is being reset to the start to avoid overlap
new LowriderKeyQueue[MAX_PLAYERS]; // Determines the next free key that is getting reset to the start
new Float: LowriderKeyPos[MAX_PLAYERS][MAX_LOWRIDER_MOVE_TDS]; // Remembers the individual positions of the moving keys
new bool: PlayerFinished[MAX_PLAYERS]; // Has the player finished the game? TODO: This has no functionality yet.

hook OnPlayerConnect(playerid) {
    PlayerCurrentMoveIndex[playerid] = 0;
    PlayerCurrentMoveCD[playerid] = 0;
    LowriderCreateCD[playerid] = 0;
    LowriderMoveCD[playerid] = 0;
    LowriderKeyQueue[playerid] = 0;
    for(new m = 0; m < MAX_LOWRIDER_MOVE_TDS; m++)
    {
        LowriderKeyPos[playerid][m] = 575.0;
    }
}



ptask LowriderMinigame[25](playerid) {

    new challenger = Lowrider[playerid][E_LOWRIDER_RIVAL];
    if(ArePlayersBattling(playerid, challenger)) {

        if(PlayerFinished[playerid] && PlayerFinished[challenger]) {
            // Both players have finished their game.
            StopLowriderChallenge(playerid, challenger);
            return 1;
        }

        // Textdraws will be loaded until the max index is reached. We add a randomness effect to the creation.
        if(PlayerCurrentMoveCD[playerid] < gettime() && PlayerCurrentMoveIndex[playerid] < MAX_LOWRIDER_MOVE_TDS) {

            PlayerCurrentMoveCD[playerid] = gettime() + RandomEx(1,2); // Randomness effect: spawn one every other second

            CreateLowriderMovingKey(playerid, PlayerCurrentMoveIndex[playerid], LOWRIDER_TD_X_MAX, "LD_BEAT:down");
            LowriderCreateCD[playerid] = gettime() + 1;
            PlayerCurrentMoveIndex[playerid] ++;
        }

        // Handle the movement of all the keys to the left
        for(new i, j = MAX_LOWRIDER_MOVE_TDS; i < j; i++) {
            if(Lowrider_KeyPTD[playerid][i] != INVALID_PLAYER_TEXT_DRAW) {
                
                LowriderKeyPos[playerid][i] -= 1.04;
                CreateLowriderMovingKey(playerid, i, LowriderKeyPos[playerid][i], "LD_BEAT:down");

                // If all textdraws are created, allow the reset of the queued key back to the start.
                if(PlayerCurrentMoveIndex[playerid] >= MAX_LOWRIDER_MOVE_TDS) {

                    new next_in_line = LowriderKeyQueue[playerid]; // Store the next in line to be reset
                    if(LowriderKeyPos[playerid][next_in_line] < LOWRIDER_TD_X_MIN) {
                        
                        // Make sure to check if the last move / creation has already occured, else there is an overlap
                        if(LowriderMoveCD[playerid] < gettime() && LowriderCreateCD[playerid] < gettime()) {

                            // Send the key back to the start
                            LowriderKeyPos[playerid][next_in_line] = LOWRIDER_TD_X_MAX ;
                            LowriderMoveCD[playerid] = gettime() + 1;

                            // Increment the next key in line to be reset, and check if index goes out of bounds
                            LowriderKeyQueue[playerid]++;
                            if(LowriderKeyQueue[playerid] >= MAX_LOWRIDER_MOVE_TDS) {
                                LowriderKeyQueue[playerid] = 0;
                            }
                        }
                    }
                }
            }
        }
    }
    return 1;
}


CreateLowriderMovingKey(playerid, index, Float: x_pos, const key[]) {
    // This function handles the "moving" of the textdraw by recreating it.
    // TIP: "key" can be used to define a different key combo.

    LowriderKeyPos[playerid][index] = x_pos; // Remember the position of the key for subtraction in the task
    //LowriderKeyType[playerid][index] = GetKeyConstant(key); // Remember which key is assigned, to be used in OPKSC

    if(Lowrider_KeyPTD[playerid][index] != INVALID_PLAYER_TEXT_DRAW) {
        PlayerTextDrawDestroy(playerid, Lowrider_KeyPTD[playerid][index]);
    }
    Lowrider_KeyPTD[playerid][index] = CreatePlayerTextDraw(playerid, x_pos, 367.000000, key);
    PlayerTextDrawBackgroundColor(playerid, Lowrider_KeyPTD[playerid][index], 255);
    PlayerTextDrawFont(playerid, Lowrider_KeyPTD[playerid][index], 4);
    PlayerTextDrawLetterSize(playerid, Lowrider_KeyPTD[playerid][index], 0.500000, 1.000000);
    PlayerTextDrawColor(playerid, Lowrider_KeyPTD[playerid][index], -1);
    PlayerTextDrawSetOutline(playerid, Lowrider_KeyPTD[playerid][index], 0);
    PlayerTextDrawSetProportional(playerid, Lowrider_KeyPTD[playerid][index], 1);
    PlayerTextDrawSetShadow(playerid, Lowrider_KeyPTD[playerid][index], 1);
    PlayerTextDrawUseBox(playerid, Lowrider_KeyPTD[playerid][index], 1);
    PlayerTextDrawBoxColor(playerid, Lowrider_KeyPTD[playerid][index], 255);
    PlayerTextDrawTextSize(playerid, Lowrider_KeyPTD[playerid][index], 32.000000, 32.000000);
    PlayerTextDrawSetSelectable(playerid, Lowrider_KeyPTD[playerid][index], 0);
    PlayerTextDrawShow(playerid, Lowrider_KeyPTD[playerid][index]);
}







/*
TODO: If you need to test the minigame, uncomment the following:
new force_tds;
CMD:testdrag(playerid) {
    force_tds = 1;
    SendClientMessage(playerid, -1, "You have started the test timer.");
    return 1;
}

ptask LowriderMinigameEx[25](playerid) {

    if(force_tds) {

        // We only load the textdraws until the max index is reached.
        if(PlayerCurrentMoveCD[playerid] < gettime() && PlayerCurrentMoveIndex[playerid] < MAX_LOWRIDER_MOVE_TDS) {

            PlayerCurrentMoveCD[playerid] = gettime() + RandomEx(1,2);

            CreateLowriderMovingKey(playerid, PlayerCurrentMoveIndex[playerid], LOWRIDER_TD_X_MAX, "LD_BEAT:down");
            LowriderCreateCD[playerid] = gettime() + 1;
            PlayerCurrentMoveIndex[playerid] ++;
        }

        // Shift the textdraws that are already created to the left.
        for(new i, j = MAX_LOWRIDER_MOVE_TDS; i < j; i++) {
            if(Lowrider_KeyPTD[playerid][i] != INVALID_PLAYER_TEXT_DRAW) {
                
                LowriderKeyPos[playerid][i] -= 1.04;
                CreateLowriderMovingKey(playerid, i, LowriderKeyPos[playerid][i], "LD_BEAT:down");

                if(PlayerCurrentMoveIndex[playerid] >= MAX_LOWRIDER_MOVE_TDS) {

                    new next_in_line = LowriderKeyQueue[playerid];
                    if(LowriderKeyPos[playerid][next_in_line] < LOWRIDER_TD_X_MIN) {
                        
                        if(LowriderMoveCD[playerid] < gettime() && LowriderCreateCD[playerid] < gettime()) {

                            LowriderKeyPos[playerid][next_in_line] = LOWRIDER_TD_X_MAX ;
                            LowriderMoveCD[playerid] = gettime() + 1;

                            LowriderKeyQueue[playerid]++;
                            if(LowriderKeyQueue[playerid] >= MAX_LOWRIDER_MOVE_TDS) {
                                LowriderKeyQueue[playerid] = 0;
                            }
                        }
                    }
                }
            }
        }
    }
    return 1;
}*/