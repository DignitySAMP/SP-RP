enum E_LOWRIDER_MINIGAME {
    E_LOWRIDER_RIVAL,
    bool: E_LOWRIDER_OFFER,
    bool: E_LOWRIDER_ACTIVE,
    E_LOWRIDER_SCORE,
}

new Lowrider[MAX_PLAYERS][E_LOWRIDER_MINIGAME];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    
    Lowrider[playerid][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;
    Lowrider[playerid][E_LOWRIDER_OFFER] = false;
    Lowrider[playerid][E_LOWRIDER_ACTIVE] = false;

    Lowrider[playerid][E_LOWRIDER_SCORE] = 0;
}

hook OnPlayerDisconnect(playerid) {
    if(GetLowriderOpponent(playerid) != INVALID_PLAYER_ID) {
        
        StopLowriderChallenge(playerid, GetLowriderOpponent(playerid));
    }
    return 1;
}


// This function will start the lowrider challenge between two players. The moment E_LOWRIDER_ACTIVE is true, the timer will tick for them.
StartLowriderChallenge(playerid, challenger) {
    if(ArePlayersBattling(playerid, challenger)) {

        ShowLowriderBattleTDs(playerid, challenger);

		PlayerPlaySound(playerid, 180, 0.0, 0.0, 0.0);
		PlayerPlaySound(challenger, 180, 0.0, 0.0, 0.0);

        // This will start the timer for the players. Call it last once everything else is set up.
        Lowrider[challenger][E_LOWRIDER_ACTIVE] = true;
        Lowrider[playerid][E_LOWRIDER_ACTIVE] = true;

    }
    return 1;
}

// This handles the clean up for the challenge: resetting variables and removing textdraws for both players.
StopLowriderChallenge(playerid, challenger) {


}



/////////////////////////////////////////////////////
////////////// Other helper functions: //////////////
/////////////////////////////////////////////////////

GetLowriderOpponent(playerid) {
    return Lowrider[playerid][E_LOWRIDER_RIVAL];
}

GetLowriderOpponentScore(playerid) {
    if(GetLowriderOpponent(playerid) == INVALID_PLAYER_ID) return 0;
    return Lowrider[GetLowriderOpponent(playerid)][E_LOWRIDER_SCORE];
}

GetLowriderStatus(playerid) {
    return Lowrider[playerid][E_LOWRIDER_ACTIVE];
}

ArePlayersBattling(playerid, challenger) {
    if(!IsPlayerConnected(challenger)) return false;
    return ((GetLowriderStatus(playerid) && GetLowriderOpponent(playerid) == challenger) && (GetLowriderStatus(challenger) && GetLowriderOpponent(challenger) == playerid));
}
