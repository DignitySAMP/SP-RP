//------------------------------------------------------------------------------
// Car warp detection
// Written by Sporky (www.github.com/sporkyspork) for Singleplayer RP (www.stretzofls.com)

#include <YSI_Coding\y_hooks>


static LastEnteredVehicle[MAX_PLAYERS];

forward AC_PutPlayerInVehicle(playerid, vehicleid, seatid);
public AC_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
    // printf("put player: %d in vehicle: %d, seat: %d", playerid, vehicleid, seatid); // debug print
    LastEnteredVehicle[playerid] = vehicleid;
    PutPlayerInVehicle(playerid, vehicleid, seatid);
    return 1;
}
 
#if defined _ALS_PutPlayerInVehicle
  #undef PutPlayerInVehicle
#else
    #define _ALS_PutPlayerInVehicle
#endif

#define PutPlayerInVehicle AC_PutPlayerInVehicle

hook OnPlayerConnect(playerid)
{
    LastEnteredVehicle[playerid] = INVALID_VEHICLE_ID;


    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    LastEnteredVehicle[playerid] = vehicleid;
  
    return 1;
}

static acstr[256];
hook OnPlayerUpdate(playerid)
{
    // if (GetPlayerAdminLevel(playerid)) return 1;
    new vehicleid = GetPlayerVehicleID(playerid);

    if (vehicleid && vehicleid != LastEnteredVehicle[playerid])
    {
        // If they enter a car without OnPlayerEnterVehicle, allow it but send a warning.
        LastEnteredVehicle[playerid] = vehicleid;
        format(acstr, sizeof(acstr), "[AntiCheat]: (%d) %s may have warped into vehicle: %d).", playerid, ReturnMixedName(playerid), vehicleid);
        SendAdminMessage(acstr, COLOR_ANTICHEAT);

        PlayerVar [ playerid ] [ E_PLAYER_WARP_AC_2 ] ++ ;

        if ( PlayerVar [ playerid ] [ E_PLAYER_WARP_AC_2 ] > 2 ) {

            format(acstr, sizeof(acstr), "[Anticheat]: (%d) %s warped over 3 times in a short span of time. Kicking them.", playerid, ReturnMixedName(playerid));
            SendAdminMessage(acstr);

            Kick(playerid);
        }
    }

    return 1;
}