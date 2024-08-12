
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//* RapidFire

// Need to fire guns normally in-game and see the difference in the terminal. Lower / increase these values accordingly.
// { on foot time, passenger time }

new const gMinWeaponFiringTime[][2] = {
    { 0, 0 },      // Fist (no firing time)
    { 0, 0 },      // Brass Knuckle (no firing time)
    { 0, 0 },      // Golf Club (no firing time)
    { 0, 0 },      // Nitestick (no firing time)
    { 0, 0 },      // Knife (no firing time)
    { 0, 0 },      // Bat (no firing time)
    { 0, 0 },      // Shovel (no firing time)
    { 0, 0 },      // Poolstick (no firing time)
    { 0, 0 },      // K atana (no firing time)
    { 0, 0 },      // Chainsaw (no firing time)
    { 0, 0 },      // Cane (no firing time)
    { 0, 0 },      // Spray Can (no firing time)
    { 250, 150 },  // Colt 45
    { 340, 150 },  // Silenced Colt
    { 450, 450 },  // Deagle
    { 60, 100 },   // Uzi
    { 60, 140 },   // Tec-9
    { 70, 140 },   // MP5
    { 80, 140 },   // AK-47
    { 80, 140 },   // M4
    { 800, 800 },  // Shotgun
    { 200, 150 },  // SPAS-12
    { 115, 115 },  // Sawn-off
    { 900, 800 },  // Rifle
    { 900, 800 },   // Sniper
    { 0, 0 },      // Camera (no firing time)
    { 340, 150 },  // Tazer??
    { 0, 0 },      // Camera (no firing time)
    { 250, 250 },  // Colt 45
    { 450, 450 }  // Deagle
};

static playerLastWeaponFired[MAX_PLAYERS];
static playerLastShotTick[MAX_PLAYERS];

static lastRapidFireDetection[MAX_PLAYERS];
static rapidFireDetections[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    playerLastWeaponFired[playerid] = 0;
    playerLastShotTick[playerid] = 0;
    lastRapidFireDetection[playerid] = 0;
    rapidFireDetections[playerid] = 0;
    return 1;
}


#include <YSI_Coding\y_hooks>
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
    
    if(!IsAntiCheatPaused(playerid)) {

        new idx = GetPlayerCustomWeapon(playerid) ;

        if (playerLastWeaponFired[playerid] != idx)
            playerLastShotTick[playerid] = 0;

        playerLastWeaponFired[playerid] = idx;

        if (Weapon[idx][E_WEAPON_TYPE] != E_GUN_SEL_MELEE && Weapon[idx][E_WEAPON_TYPE] != E_GUN_SEL_NONE)
        {
            new diff = GetTickDiff(GetTickCount(), playerLastShotTick[playerid]);

            // For fine tuning
            //SendClientMessage(playerid, -1, sprintf("Minimum time for this weapon (%d): %d", Weapon[idx][E_WEAPON_GUNID], minimumTime[playerid]));
            //printf("Shot difference for %d: %d (min time for weapon is %d (%d))", idx, diff, gMinWeaponFiringTime[idx][0], gMinWeaponFiringTime[idx][1]);
                
            if (GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
            {
                if (diff < gMinWeaponFiringTime[idx][1])
                {
                    if ((lastRapidFireDetection[playerid] + 2) < gettime())
                        rapidFireDetections[playerid] = 0;
                        
                    lastRapidFireDetection[playerid] = gettime();
                    ++rapidFireDetections[playerid];

                    if (rapidFireDetections[playerid] >= 10)
                        SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s's might be using rapidfire [passenger].", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);

                    return 0;
                }
            }
            else
            {
                if (diff < gMinWeaponFiringTime[idx][0])
                {
                    if ((lastRapidFireDetection[playerid] + 2) < gettime())
                        rapidFireDetections[playerid] = 0;
                        
                    lastRapidFireDetection[playerid] = gettime();
                    ++rapidFireDetections[playerid];

                    if (rapidFireDetections[playerid] >= 7)
                        SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s's might be using rapidfire.", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);

                    return 0;
                }
            }
        }

        playerLastShotTick[playerid] = GetTickCount();
    }

    return true;
}

// Tick difference
static GetTickDiff(newtick, oldtick)
{
	if (oldtick < 0 && newtick >= 0) {
		return newtick - oldtick;
	} else if (oldtick >= 0 && newtick < 0 || oldtick > newtick) {
		return (cellmax - oldtick + 1) - (cellmin - newtick);
	}
	return newtick - oldtick;
}

#if !defined IsNaN
    #define IsNaN(%0) ((%0) != (%0))
#endif

//#tryinclude <Pawn.RakNet>

const AIM_SYNC = 203;

IPacket:AIM_SYNC(playerid, BitStream:bs)
{
    new aimData[PR_AimSync];
    
    BS_IgnoreBits(bs, 8); // ignore packetid (byte)
    BS_ReadAimSync(bs, aimData);

    if (IsNaN(aimData[PR_aimZ]))
    {
        aimData[PR_aimZ] = 0.0;

        BS_SetWriteOffset(bs, 8);
        BS_WriteAimSync(bs, aimData); // rewrite
    }

    if (aimData[PR_weaponState] == WEAPONSTATE_RELOADING || aimData[PR_weaponState] == WEAPONSTATE_NO_BULLETS)
		playerBulletsFired[playerid] = 0;

    return 1;
}
