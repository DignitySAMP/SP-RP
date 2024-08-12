
#include <YSI_Coding\y_hooks>

new prevWeapon[MAX_PLAYERS];
new scrollDelayTick[MAX_PLAYERS];
hook OnPlayerUpdate(playerid) {

    if (scrollDelayTick[playerid] <= gettime()) {
        if(prevWeapon[playerid] != GetPlayerWeapon(playerid)) {
            scrollDelayTick[playerid] = gettime() + 1;
            prevWeapon[playerid] = GetPlayerWeapon(playerid);
        }
    }

    return 1;
}

hook OnPlayerSpawn(playerid) {
    prevWeapon[playerid] = 0;
    scrollDelayTick[playerid] = 0;
}

DidPlayerScrollWeapon(playerid) {
    return scrollDelayTick[playerid] > gettime();
}