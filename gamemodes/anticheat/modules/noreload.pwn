

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//* NoReload

new playerBulletsFired[MAX_PLAYERS]; // this is affected by rapid fire, so it must be global not static
static lastNoReloadDetection[MAX_PLAYERS];
static playerNRLastWeaponFired[MAX_PLAYERS];
static noReloadDetections[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    playerBulletsFired[playerid] = 0;
    lastNoReloadDetection[playerid] = 0;
    noReloadDetections[playerid] = 0;
    playerNRLastWeaponFired[playerid] = 0;
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {

    if(DidPlayerScrollWeapon(playerid)) {
        playerBulletsFired[playerid] = 0;
    }

    new idx = GetPlayerCustomWeapon(playerid) ;

    if (playerNRLastWeaponFired[playerid] != idx) {
        playerBulletsFired[playerid] = 0;
    }

    playerNRLastWeaponFired[playerid] = idx;
    ++playerBulletsFired[playerid];

    if(!IsAntiCheatPaused(playerid)) {

        new clipsize = Weapon_GetClipSize(idx);

        // only melee weapons have a clipsize of 1, no need to check those.
        if (clipsize > 1)
        {
            if (playerBulletsFired[playerid] > clipsize)
            {
                if ((lastNoReloadDetection[playerid] + 2) < gettime())
                    noReloadDetections[playerid] = 0;

                lastNoReloadDetection[playerid] = gettime();
                ++noReloadDetections[playerid];

                // Detection
                if (noReloadDetections[playerid] >= 3)
                    SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s's might be using no reload (clipsize: %d, shots fired: %d).", playerid, ReturnPlayerName(playerid), clipsize, playerBulletsFired[playerid]), COLOR_ANTICHEAT);

                return 0;
            }
        }
    }

    return 1;
}
