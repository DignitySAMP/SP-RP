


#include "minigame/poker/poker.pwn"

// purpose: get unattached player object index
stock Player_GetUnusedAttachIndex( playerid )
{
    for ( new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i ++ )
        if ( ! IsPlayerAttachedObjectSlotUsed( playerid, i ) )
            return i;

    return cellmin;
}

