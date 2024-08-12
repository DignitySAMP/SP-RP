
#define MAX_LOWRIDER_MOVE_TDS (6)

new Text: Lowrider_GameTD[2] = Text: INVALID_TEXT_DRAW;
new PlayerText: Lowrider_KeyPTD[MAX_PLAYERS][MAX_LOWRIDER_MOVE_TDS] = {PlayerText: INVALID_PLAYER_TEXT_DRAW, ...};
new PlayerText:Lowrider_SubmPTD[MAX_PLAYERS][3] = {PlayerText: INVALID_PLAYER_TEXT_DRAW, ...}; // Submission texts... 

#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    
    Lowrider_GameTD[0] = TextDrawCreate(292.000000, 350.000000, "LD_BEAT:cring");
    TextDrawBackgroundColor(Lowrider_GameTD[0], 255);
    TextDrawFont(Lowrider_GameTD[0], 4);
    TextDrawLetterSize(Lowrider_GameTD[0], 0.500000, 1.000000);
    TextDrawColor(Lowrider_GameTD[0], -1);
    TextDrawSetOutline(Lowrider_GameTD[0], 0);
    TextDrawSetProportional(Lowrider_GameTD[0], 1);
    TextDrawSetShadow(Lowrider_GameTD[0], 1);
    TextDrawUseBox(Lowrider_GameTD[0], 1);
    TextDrawBoxColor(Lowrider_GameTD[0], 255);
    TextDrawTextSize(Lowrider_GameTD[0], 64.000000, 64.000000);
    TextDrawSetSelectable(Lowrider_GameTD[0], 0);

    Lowrider_GameTD[1] = TextDrawCreate(292.000000, 350.000000, "LD_BEAT:chit");
    TextDrawBackgroundColor(Lowrider_GameTD[1], 255);
    TextDrawFont(Lowrider_GameTD[1], 4);
    TextDrawLetterSize(Lowrider_GameTD[1], 0.500000, 1.000000);
    TextDrawColor(Lowrider_GameTD[1], -181);
    TextDrawSetOutline(Lowrider_GameTD[1], 0);
    TextDrawSetProportional(Lowrider_GameTD[1], 1);
    TextDrawSetShadow(Lowrider_GameTD[1], 1);
    TextDrawUseBox(Lowrider_GameTD[1], 1);
    TextDrawBoxColor(Lowrider_GameTD[1], 255);
    TextDrawTextSize(Lowrider_GameTD[1], 64.000000, 64.000000);
    TextDrawSetSelectable(Lowrider_GameTD[1], 0);

    return 1;
}

hook OnPlayerConnect(playerid) {
    for(new m = 0; m < MAX_LOWRIDER_MOVE_TDS; m++)
    {
        // Make sure all keys are invalid textdraws.
        Lowrider_KeyPTD[playerid][m] = PlayerText: INVALID_PLAYER_TEXT_DRAW;
    }

    Lowrider_SubmPTD[playerid][0] = CreatePlayerTextDraw(playerid, 519.000000, 135.000000, "_");
    PlayerTextDrawAlignment(playerid, Lowrider_SubmPTD[playerid][0], 3);
    PlayerTextDrawBackgroundColor(playerid, Lowrider_SubmPTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, Lowrider_SubmPTD[playerid][0], 2);
    PlayerTextDrawLetterSize(playerid, Lowrider_SubmPTD[playerid][0], 0.380000, 1.600000);
    PlayerTextDrawColor(playerid, Lowrider_SubmPTD[playerid][0], -1278086145);
    PlayerTextDrawSetOutline(playerid, Lowrider_SubmPTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, Lowrider_SubmPTD[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, Lowrider_SubmPTD[playerid][0], 0);

    Lowrider_SubmPTD[playerid][1] = CreatePlayerTextDraw(playerid, 604.000000, 150.000000, "~n~0");
    PlayerTextDrawAlignment(playerid, Lowrider_SubmPTD[playerid][1], 3);
    PlayerTextDrawBackgroundColor(playerid, Lowrider_SubmPTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, Lowrider_SubmPTD[playerid][1], 2);
    PlayerTextDrawLetterSize(playerid, Lowrider_SubmPTD[playerid][1], 0.380000, 1.600000);
    PlayerTextDrawColor(playerid, Lowrider_SubmPTD[playerid][1], -1278086145);
    PlayerTextDrawSetOutline(playerid, Lowrider_SubmPTD[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, Lowrider_SubmPTD[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, Lowrider_SubmPTD[playerid][1], 0);

    Lowrider_SubmPTD[playerid][2] = CreatePlayerTextDraw(playerid, 320.000000, 60.000000, "~r~bad");
    PlayerTextDrawAlignment(playerid, Lowrider_SubmPTD[playerid][2], 2);
    PlayerTextDrawBackgroundColor(playerid, Lowrider_SubmPTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, Lowrider_SubmPTD[playerid][2], 3);
    PlayerTextDrawLetterSize(playerid, Lowrider_SubmPTD[playerid][2], 1.039999, 3.599998);
    PlayerTextDrawColor(playerid, Lowrider_SubmPTD[playerid][2], -1);
    PlayerTextDrawSetOutline(playerid, Lowrider_SubmPTD[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, Lowrider_SubmPTD[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, Lowrider_SubmPTD[playerid][2], 0);

    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {
    for(new m = 0; m < MAX_LOWRIDER_MOVE_TDS; m++) {
        if(Lowrider_KeyPTD[playerid][m] != INVALID_PLAYER_TEXT_DRAW) {
            PlayerTextDrawDestroy(playerid, Lowrider_KeyPTD[playerid][m]);
            Lowrider_KeyPTD[playerid][m] = PlayerText: INVALID_PLAYER_TEXT_DRAW;
        }
    }

    for(new i = 0; i < 3; i++) {
        if(Lowrider_SubmPTD[playerid][i] != INVALID_PLAYER_TEXT_DRAW) {
            PlayerTextDrawDestroy(playerid, Lowrider_SubmPTD[playerid][i]);
            Lowrider_SubmPTD[playerid][i] = PlayerText: INVALID_PLAYER_TEXT_DRAW;
        }
    }
    return 1;
}

// This is a public so we can cross reference it without messing up module organization.
forward ShowLowriderBattleTDs(playerid, challenger);
public ShowLowriderBattleTDs(playerid, challenger) {

    // Initialise and show for player
    PlayerTextDrawSetString(playerid, Lowrider_SubmPTD[playerid][0], "~n~Player~n~Opposition~n~");
    PlayerTextDrawShow(playerid, Lowrider_SubmPTD[playerid][0]);
    PlayerTextDrawSetString(playerid, Lowrider_SubmPTD[playerid][1], "0~n~0~n~");
    PlayerTextDrawShow(playerid, Lowrider_SubmPTD[playerid][1]);
    TextDrawShowForPlayer(playerid, Lowrider_GameTD[0]);

    // Initialise and show for challenger
    PlayerTextDrawSetString(challenger, Lowrider_SubmPTD[challenger][0], "~n~Player~n~Opposition~n~");
    PlayerTextDrawShow(challenger, Lowrider_SubmPTD[challenger][0]);
    PlayerTextDrawSetString(challenger, Lowrider_SubmPTD[challenger][1], "0~n~0~n~");
    PlayerTextDrawShow(challenger, Lowrider_SubmPTD[challenger][1]);
    TextDrawShowForPlayer(challenger, Lowrider_GameTD[0]);
}