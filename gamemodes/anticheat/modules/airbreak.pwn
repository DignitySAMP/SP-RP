
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//* Anti airbreak

#include <Pawn.RakNet>

static Float:internalABPosX[MAX_PLAYERS], Float:internalABPosY[MAX_PLAYERS], Float:internalABPosZ[MAX_PLAYERS], internalABLastCall[MAX_PLAYERS];
static Float:internalVehABPosX[MAX_PLAYERS], Float:internalVehABPosY[MAX_PLAYERS], Float:internalVehABPosZ[MAX_PLAYERS], internalVehABLastCall[MAX_PLAYERS];
static Float:internalPassABPosX[MAX_PLAYERS], Float:internalPassABPosY[MAX_PLAYERS], Float:internalPassABPosZ[MAX_PLAYERS], internalPassABLastCall[MAX_PLAYERS];


#include <YSI_Coding\y_hooks>
hook OnPlayerDisconnect(playerid, reason)
{
    internalABPosX[playerid] = 0.0;
    internalABPosY[playerid] = 0.0;
    internalABPosZ[playerid] = 0.0;
    internalABLastCall[playerid] = 0;

    
    internalVehABPosX[playerid] = 0.0;
    internalVehABPosY[playerid] = 0.0;
    internalVehABPosZ[playerid] = 0.0;
    internalVehABLastCall[playerid] = 0;
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnIncomingPacket(playerid, packetid, BitStream:bs)
{
    if(!IsAntiCheatPaused(playerid) && !IsAnticheatGloballyPaused(AC_AIRBREAK)) {
        if (packetid == 207) // player sync
        {
            new onFootData[PR_OnFootSync];
            BS_IgnoreBits(bs, 8);
            BS_ReadOnFootSync(bs, onFootData);

            new Float:player_speed;
            player_speed = floatsqroot(floatpower(floatabs(onFootData[PR_velocity][0]), 2.0) +
            floatpower(floatabs(onFootData[PR_velocity][1]), 2.0) +
            floatpower(floatabs(onFootData[PR_velocity][2]), 2.0)) * 179.28625; // Thanks to whoever made this

            if(player_speed < 27.0)
            {
                if(internalABPosX[playerid] != 0.0)
                {
                    // Only show if player isnt carsurfing
                    if((onFootData[PR_surfingOffsets][0] == 0.0) && (onFootData[PR_surfingOffsets][1] == 0.0) && (onFootData[PR_surfingOffsets][2] == 0.0)) // Hey there, having problems? Add some immunity to the player after setting his position here :)
                    {
                        if(onFootData[PR_position][0] > internalABPosX[playerid] + 1.3 || onFootData[PR_position][1] > internalABPosY[playerid] + 1.3 || onFootData[PR_position][2] > internalABPosZ[playerid] + 1.3
                        || onFootData[PR_position][0] < internalABPosX[playerid] - 1.3 || onFootData[PR_position][1] < internalABPosY[playerid] - 1.3
                        || onFootData[PR_position][2] < internalABPosZ[playerid] - 1.3)
                        {
                            if((gettime() - internalABLastCall[playerid]) < 2 && internalABLastCall[playerid] != 0) {
                                SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s might be airbreaking [onfoot].", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);
                            }

                            internalABLastCall[playerid] = gettime();
                        }
                    }
                }
            }

            internalABPosX[playerid] = onFootData[PR_position][0];
            internalABPosY[playerid] = onFootData[PR_position][1];
            internalABPosZ[playerid] = onFootData[PR_position][2];
        }

        if(packetid == 200)// vehicle sync
        {
            new vehicleData[PR_InCarSync];
            BS_IgnoreBits(bs, 8);
            BS_ReadInCarSync(bs, vehicleData);

            new Float:player_speed;
            player_speed = floatsqroot(floatpower(floatabs(vehicleData[PR_velocity][0]), 2.0) +
            floatpower(floatabs(vehicleData[PR_velocity][1]), 2.0) +
            floatpower(floatabs(vehicleData[PR_velocity][2]), 2.0)) * 179.28625; // Thanks to whoever made this

            if(player_speed < 27.0)
            {
                if(internalVehABPosX[playerid] != 0.0)
                {

                    if(vehicleData[PR_position][0] > internalVehABPosX[playerid] + 1.3 || vehicleData[PR_position][1] > internalVehABPosY[playerid] + 1.3 || vehicleData[PR_position][2] > internalVehABPosZ[playerid] + 1.3
                    || vehicleData[PR_position][0] < internalVehABPosX[playerid] - 1.3 || vehicleData[PR_position][1] < internalVehABPosY[playerid] - 1.3
                    || vehicleData[PR_position][2] < internalVehABPosZ[playerid] - 1.3)
                    {
                        if((gettime() - internalVehABLastCall[playerid]) < 2 && internalVehABLastCall[playerid] != 0) {
                            SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s might be airbreaking [vehicle].", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);
                        }

                        internalVehABLastCall[playerid] = gettime();
                    }

                }
            }

            internalVehABPosX[playerid] = vehicleData[PR_position][0];
            internalVehABPosY[playerid] = vehicleData[PR_position][1];
            internalVehABPosZ[playerid] = vehicleData[PR_position][2];
        }

        if(packetid == 211)// passenger sync
        {
            new passengerData[PR_PassengerSync];
            BS_IgnoreBits(bs, 8);
            BS_ReadPassengerSync(bs, passengerData);

            new Float: x, Float:y, Float:z;
            GetVehicleVelocity(passengerData[PR_vehicleId], x,y,z);

            new Float:player_speed  = floatsqroot(floatpower(floatabs(x), 2.0) + floatpower(floatabs(y), 2.0) + floatpower(floatabs(z), 2.0)) * 179.28625; // Thanks to whoever made this

            // Skip if the driver is paused, as this triggers false positives.
            new driverid = GetVehicleDriver(passengerData[PR_vehicleId]);
            if(driverid != INVALID_PLAYER_ID && IsPlayerPaused(driverid)) {
                return 1;
            }

            if(player_speed < 27.0)
            {
                if(internalPassABPosX[playerid] != 0.0)
                {

                    if(passengerData[PR_position][0] > internalPassABPosX[playerid] + 1.3 || passengerData[PR_position][1] > internalPassABPosY[playerid] + 1.3 || passengerData[PR_position][2] > internalPassABPosZ[playerid] + 1.3
                    || passengerData[PR_position][0] < internalPassABPosX[playerid] - 1.3 || passengerData[PR_position][1] < internalPassABPosY[playerid] - 1.3
                    || passengerData[PR_position][2] < internalPassABPosZ[playerid] - 1.3)
                    {
                        if((gettime() - internalPassABLastCall[playerid]) < 2 && internalPassABLastCall[playerid] != 0) {
                            SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s might be airbreaking [passenger].", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);
                        }

                        internalPassABLastCall[playerid] = gettime();
                    }

                }
            }

            internalPassABPosX[playerid] = passengerData[PR_position][0];
            internalPassABPosY[playerid] = passengerData[PR_position][1];
            internalPassABPosZ[playerid] = passengerData[PR_position][2];
        }
    }
   
    return 1;
}

hook SetPlayerPos(playerid, Float:x, Float:y, Float:z) {
    internalABPosX[playerid] = x;
    internalABPosY[playerid] = y;
    internalABPosZ[playerid] = z;

    SetPlayerPos(playerid, x, y, z);
    return 1;
}

hook SetVehiclePos(vehicleid, Float:x, Float:y, Float:z) {
    foreach(new playerid: Player) {
        if(GetPlayerVehicleID(playerid) == vehicleid) {
            internalVehABPosX[playerid] = x;
            internalVehABPosY[playerid] = y;
            internalVehABPosZ[playerid] = z;
        }
    }

    SetVehiclePos(vehicleid, x, y, z);
    return 1;
}