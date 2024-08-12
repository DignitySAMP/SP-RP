// This is taken fron fuckCleo.inc 0.3.5 by Lorenc_. Credits to Cessil, Infamous and [FeK]Drakins, JernejL
new Float: fC_LastDeath[MAX_PLAYERS];
new Float: fC_DeathSpam[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    fC_LastDeath[playerid] = 0;
    fC_DeathSpam[playerid] = 0;
    fC_carSwing_Z[playerid] = 0;
}

hook OnPlayerDeath( playerid, killerid, reason )
{
    new time = gettime( );
    switch( time - fC_LastDeath[playerid]  )
    {
        case 0 .. 3:
        {
            fC_DeathSpam[playerid] ++;
            if( fC_DeathSpam[playerid] >= 3 )
            {
                SendAdminMessage(sprintf("[ANTICHEAT CRITICAL]: (%d) %s might be using fake kill.", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);
                return 1;
            }
        }
        default: fC_DeathSpam[playerid] = 0;
    }
    fC_LastDeath[playerid]  = time;

    return 1;
}