//------------------------------------------------------------------------------
// Carjack detection script
// Written by Sporky (www.github.com/sporkyspork) for Singleplayer RP (www.stretzofls.com)

#include <YSI_Coding\y_hooks>

static enum E_PLAYER_AC_DATA
{

    E_AC_LAST_VEHICLE,
    E_AC_JACKING_VEHICLE,
    E_AC_JACKING_PLAYER,
    E_AC_JACKED_VEHICLE,
    E_AC_JACKED_PLAYER
}

static PlayerAntiCheatVar[MAX_PLAYERS][E_PLAYER_AC_DATA];
static acstr[256];

hook OnPlayerConnect(playerid)
{

    PlayerAntiCheatVar[playerid][E_AC_LAST_VEHICLE] = INVALID_VEHICLE_ID;
    PlayerAntiCheatVar[playerid][E_AC_JACKING_VEHICLE] = INVALID_VEHICLE_ID;
    PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER] = INVALID_PLAYER_ID;
    PlayerAntiCheatVar[playerid][E_AC_JACKED_VEHICLE] = INVALID_VEHICLE_ID;
    PlayerAntiCheatVar[playerid][E_AC_JACKED_PLAYER] = INVALID_PLAYER_ID;

    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    PlayerAntiCheatVar[playerid][E_AC_JACKING_VEHICLE] = 0;
    PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER] = INVALID_PLAYER_ID;

    if (!ispassenger)
    {
        foreach (new i: Player) 
        {
            if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid)
            {
                // So someone is entering a vehicle that already has a driver...
                PlayerAntiCheatVar[playerid][E_AC_JACKING_VEHICLE] = vehicleid;
                PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER] = i;

                break;
            }
        }
    }

    return 1;
}

hook OnPlayerUpdate(playerid)
{
    // if (GetPlayerAdminLevel(playerid)) return 1;
    new vehicleid = GetPlayerVehicleID(playerid);

    if (vehicleid != PlayerAntiCheatVar[playerid][E_AC_LAST_VEHICLE])
    {
        if (vehicleid && PlayerAntiCheatVar[playerid][E_AC_JACKING_VEHICLE] == vehicleid && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && playerid != PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER])
        {
            format(acstr, sizeof(acstr), "[AntiCheat]: (%d) %s may have just jacked (%d) %s from a %s (VID: %d).", playerid, ReturnMixedName(playerid), PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER], ReturnMixedName(PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER]), ReturnVehicleName(vehicleid), vehicleid);
            SendAdminMessage(acstr, COLOR_ANTICHEAT);

            AddLogEntry(playerid, LOG_TYPE_GAME, sprintf("Jacked %s (%d) from a %s (%d)", PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER], ReturnMixedName(PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER]), ReturnVehicleName(vehicleid), vehicleid));
            AddLogEntry(PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER], LOG_TYPE_GAME, sprintf("Was jacked from a %s (%d) by %s (%d)", ReturnVehicleName(vehicleid), vehicleid, ReturnMixedName(playerid), playerid));
            
            PlayerAntiCheatVar[playerid][E_AC_JACKING_VEHICLE] = 0;
            PlayerAntiCheatVar[playerid][E_AC_JACKING_PLAYER] = INVALID_PLAYER_ID;
        }

        PlayerAntiCheatVar[playerid][E_AC_LAST_VEHICLE] = vehicleid;
    }

    return 1;
}
