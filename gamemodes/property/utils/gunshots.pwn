// This sends a message to the inhabitants inside a property if a gunshot is fired.
#define PROPERTY_GUNSHOT_RANGE  (60)
new weaponShotCooldown[MAX_PLAYERS] ;


#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {

    weaponShotCooldown[playerid] = 0 ;
    return 1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {

    // Before we send any warnings, make sure shooter is connected, has gun perms, and isn't on cooldown
    if(IsPlayerConnected(playerid) && CanPlayerUseGuns(playerid, 8, -1) && weaponShotCooldown[playerid] < gettime()) {

        // Immediately set the cooldown to 3 seconds to reduce server lag/spam.
        weaponShotCooldown[playerid] = gettime() + 5;

        foreach(new near_property: Properties) {
            if(Property[near_property][E_PROPERTY_ID] != INVALID_PROPERTY_ID ) {

                // Check if the shooter is near any properties
                if(IsPlayerInRangeOfPoint(playerid, PROPERTY_GUNSHOT_RANGE, Property[near_property][E_PROPERTY_EXT_X],  Property[near_property][E_PROPERTY_EXT_Y],  Property[near_property][E_PROPERTY_EXT_Z] ) ) {
                    if(GetPlayerVirtualWorld(playerid) ==  Property[near_property][E_PROPERTY_EXT_VW] && GetPlayerInterior(playerid ) ==  Property[near_property][E_PROPERTY_EXT_INT] ) {
                        
                        // Now let's check which players need to be altered
                        foreach(new targetid: Player) {

                            // Is the player even suspected to be in a property?
                            if(IsPlayerPlaying(targetid) && GetPlayerVirtualWorld(targetid) != 0) {
                                
                                // Check if they are in an actual property
                                if(IsPlayerInRangeOfPoint(targetid, 20.0, Property[near_property][E_PROPERTY_INT_X], Property[near_property][E_PROPERTY_INT_Y], Property[near_property][E_PROPERTY_INT_Z])) {
                                    if(GetPlayerInterior(targetid ) == Property[near_property][E_PROPERTY_INT_INT] && GetPlayerVirtualWorld(targetid ) == Property[near_property][E_PROPERTY_ID] ) {

                                        // Only if they are in range of the interior point and the interior and vw match, send them a message.
                                        SendClientMessage(targetid, COLOR_ACTION_LOW, "** A gunshot was heard from outside the property!") ;
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
    }

    return 1;
}