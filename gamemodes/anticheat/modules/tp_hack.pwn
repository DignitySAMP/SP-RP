
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//* Teleport Hacks

static playerTeleportDelay[MAX_PLAYERS];
static playerInterior[MAX_PLAYERS];
static Float: playerPos[MAX_PLAYERS][3];

static playerTpDetections[MAX_PLAYERS];
static lastPlayerTpDetection[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    playerTeleportDelay[playerid] = 0;
    playerInterior[playerid] = 0;
    playerTpDetections[playerid] = 0;
    lastPlayerTpDetection[playerid] = 0;
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerSpawn(playerid) { 
    GetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]);
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerExitVehicle(playerid, vehicle) {

    GetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]);
    PauseAC(playerid, 3);

    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    GetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]);
    PauseAC(playerid, 3);

    return 1;
}

const PLAYER_SYNC = 207;

IPacket:PLAYER_SYNC(playerid, BitStream:bs) {

    new onFootData[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, onFootData);

    if(IsPlayerSpawned(playerid)) {
        if (!IsAntiCheatPaused(playerid) && !IsAnticheatGloballyPaused(AC_TELEPORT)) {

            if (gettime() > playerTeleportDelay[playerid]){
                    
                new 
                    Float:distance = GetPlayerDistanceFromPoint(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]),
                    Float:limit_distance = 15.0,
                    player_state = GetPlayerState(playerid)
                ;
                
                if (PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ]) distance = 3.0;
                else
                {
                    switch(player_state)
                    {
                        case PLAYER_STATE_ONFOOT: limit_distance = 35.0;
                        case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER: limit_distance = 150.0;
                    }
                }

                // Check surfing offsets
                if((onFootData[PR_surfingOffsets][0] != 0.0) && (onFootData[PR_surfingOffsets][1] != 0.0) && (onFootData[PR_surfingOffsets][2] != 0.0)){
                    limit_distance = 150.0;
                }

                // They're surfing on a bike, so their data cannot be trusted, better to ignore.
                // ps @Hades: onFootData[surfingVehicleId] cannot be found for some reason.
                if(IsABike(GetPlayerSurfingVehicleID(playerid))){
                    return 1;
                }

                if (distance > limit_distance)
                {
                    lastPlayerTpDetection[playerid] = gettime();
                    ++ playerTpDetections[playerid];

                    if (playerTpDetections[playerid] >= 2 && !IsAntiCheatPaused(playerid))
                        SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s has moved over %0.2f meters since their last position. They may be teleporting.", playerid, ReturnPlayerName(playerid), distance, playerTpDetections[playerid]), COLOR_ANTICHEAT);

                }

                GetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]);
                playerTeleportDelay[playerid] = (gettime() + 2);
            }

        } else {
            GetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]); 
        }
    }

    return true;
}

const VEHICLE_SYNC = 200;

IPacket:VEHICLE_SYNC(playerid, BitStream:bs)
{

    new inCarData[PR_InCarSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadInCarSync(bs, inCarData);

    if(IsPlayerSpawned(playerid)) {
        if (!IsAntiCheatPaused(playerid) && !IsAnticheatGloballyPaused(AC_TELEPORT)) {

            if (gettime() > playerTeleportDelay[playerid]){
                    
                // Get distance between old position and actual position
                new Float:distance = GetPointDistanceToPoint(
                    inCarData[PR_position][0], inCarData[PR_position][1], inCarData[PR_position][2],
                    playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]
                );

	            if (distance > 150.0)
			    {
                    lastPlayerTpDetection[playerid] = gettime();
                    ++ playerTpDetections[playerid];

                    if (playerTpDetections[playerid] >= 2 && !IsAntiCheatPaused(playerid))
                        SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s has moved over %0.2f meters since their last position. They may be teleporting.", playerid, ReturnPlayerName(playerid), distance, playerTpDetections[playerid]), COLOR_ANTICHEAT);
                }

                playerPos[playerid][0] = inCarData[PR_position][0];
                playerPos[playerid][1] = inCarData[PR_position][1];
                playerPos[playerid][2] = inCarData[PR_position][2];

                playerTeleportDelay[playerid] = (gettime() + 2);
            }
        } else {
            playerPos[playerid][0] = inCarData[PR_position][0];
            playerPos[playerid][1] = inCarData[PR_position][1];
            playerPos[playerid][2] = inCarData[PR_position][2];
        }
    }

    return true;
}
