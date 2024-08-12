// This is taken fron fuckCleo.inc 0.3.5 by Lorenc_. Credits to Cessil, Infamous and [FeK]Drakins, JernejL
#include <YSI_Coding\y_hooks>

new fC_PartSpamCount[MAX_PLAYERS];
new fC_PartTick[MAX_PLAYERS];

hook OnPlayerConnect(playerid) {
    fC_PartSpamCount[playerid] = 0;
    fC_PartTick[playerid] = 0;
}

hook OnVehDamageStatusUpd( vehicleid, playerid )
{
    static fc_tires, fc_lights;
    GetVehicleDamageStatus( vehicleid, fc_lights, fc_tires, fc_lights, fc_tires );
    if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
    {
        if( fc_lights || fc_tires )
            return 1;

        new time = GetTickCount( );
        switch( time - fC_PartTick[playerid]  )
        {
            case 0 .. 500:
            {
                fC_PartSpamCount[playerid]  ++;
                if( fC_PartSpamCount[playerid]  >= 10 )
                {
                    SendAdminMessage(sprintf("[ANTICHEAT CRITICAL]: (%d) %s might be using particle spam.", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);
                    return 1;
                }
            }
            default: fC_PartSpamCount[playerid]  = 0;
        }
        fC_PartTick[playerid]  = time;
    }

    return 1;
}


forward fc_RepairVehicle (vehicleid);
public fc_RepairVehicle( vehicleid ) {
	foreach (new playerid: Player) {
		if( GetPlayerVehicleID( playerid ) == vehicleid )  {
			fC_PartSpamCount[playerid]  = 0;
			fC_PartTick[playerid]       = 0;
		}
	}
    return RepairVehicle( vehicleid );
}
#define RepairVehicle fc_RepairVehicle