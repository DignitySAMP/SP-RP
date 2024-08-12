
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//* Rudimentary health hack detection

// add this, block the invalid version, sobeit, bypass, give warnings for rest
// https://github.com/edgyaf/samp-ac-black-diamond

static Float: internalACHealth[MAX_PLAYERS];
static bool: playerDamaged[MAX_PLAYERS];
static playerDamagedByWeapon[MAX_PLAYERS];
static playerHealthHackFlags[MAX_PLAYERS];
static playerLastTookDamage[MAX_PLAYERS];


#include <YSI_Coding\y_hooks>

hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart) {
    if(!IsAntiCheatPaused(playerid) && !IsAnticheatGloballyPaused(AC_HEALTH)) {

        playerLastTookDamage[damagedid] = gettime();

        new Float: fixedAmount = CalculateWeaponDamage(damagedid, playerid, weaponid, bodypart);
        if (weaponid == WEAPON_SPRAYCAN) fixedAmount = 1.0;

        if(playerid != damagedid) {
            internalACHealth[damagedid] -= fixedAmount;
            playerDamaged[damagedid] = true;
            playerDamagedByWeapon[damagedid] = weaponid;
        }
    }
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {

    internalACHealth[playerid] = 100.0;
    playerDamaged[playerid] = false;
    playerDamagedByWeapon[playerid] = 0;
    playerHealthHackFlags[playerid] = 0;
    playerLastTookDamage[playerid] = 0;

    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerUpdate(playerid) {
    if(!IsAntiCheatPaused(playerid) && !IsAnticheatGloballyPaused(AC_HEALTH)) {

        new Float: client_health;
        GetPlayerHealth(playerid, client_health);

        if (IsPlayerPlaying(playerid)) {
            if(playerHealthHackFlags[playerid] >= 3) {

                new string[256];
                
                // Player has more than 100 health clientside, something is up!
                if (client_health > 100.0) {

                    if(playerHealthHackFlags[playerid] > 5 && playerHealthHackFlags[playerid] % 10 == 0) 
                        format(string, sizeof(string), "[ANTICHEAT CRITICAL]: (%d) %s has over 100 health (healthhack) (%d detections).", playerid, ReturnPlayerName(playerid), playerHealthHackFlags[playerid]);
                    else  format(string, sizeof(string), "[ANTICHEAT CRITICAL]: (%d) %s has over 100 health (healthhack).", playerid, ReturnPlayerName(playerid));  

                } else {

                    if(playerHealthHackFlags[playerid] > 5 && playerHealthHackFlags[playerid] % 10 == 0) 
                        format(string, sizeof(string), "[ANTICHEAT]: (%d) %s might be using health hacks. (%d detections)", playerid, ReturnPlayerName(playerid), playerHealthHackFlags[playerid]);
                    else format(string, sizeof(string), "[ANTICHEAT]: (%d) %s might be using health hacks.", playerid, ReturnPlayerName(playerid));

                    playerDamaged[playerid] = false;
                }

                SendAdminMessage(string, COLOR_ANTICHEAT);

                // Player hasn't taken any damage in the last 10 seconds, reset the flag
                if (playerLastTookDamage[playerid] + 10 < gettime()) 
                    playerHealthHackFlags[playerid] = 0;

            }

            if (client_health > 100.0)
                playerHealthHackFlags[playerid]++;

            if(playerDamaged[playerid] && client_health > internalACHealth[playerid] + 5.0) {
                playerHealthHackFlags[playerid]++;
                playerDamaged[playerid] = false;
            }
        }
    }

    return 1;
}


forward SetACHealth(playerid, Float: amount);
public SetACHealth(playerid, Float: amount) {
    // adjust health incase setcharacterhealth is called, integrate these two once this works
    internalACHealth[playerid] = amount;
    return 1;
}