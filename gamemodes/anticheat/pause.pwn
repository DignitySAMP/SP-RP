
// Helpe
new bool: PausedAnticheat[MAX_PLAYERS];
new PausedAnticheatTime[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    PausedAnticheat[playerid] = false;
    PausedAnticheatTime[playerid] = 0;
    return 1;
}

forward PauseAC(playerid, timeInSeconds);
public PauseAC(playerid, timeInSeconds) {
    PausedAnticheat[playerid] = true;
    PausedAnticheatTime[playerid] = gettime() + timeInSeconds;
    return 1;
}

IsAntiCheatPaused(playerid) {
    if (PausedAnticheat[playerid] && PausedAnticheatTime[playerid] > gettime()) {
        return true;
    }
    if(PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] || Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] > ADMIN_LVL_NONE || IsPlayerPaused(playerid)) {
        return true;
    }
    return false;
}

IsAnticheatGloballyPaused(setting) {
    if (!setting) {
        return true;
    }
    return false;
}
