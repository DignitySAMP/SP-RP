#if !defined PAWNRAKNET_INC_
    #include <Pawn.RakNet>
#endif

SetPlayerNameForPlayer(playerid, forplayerid, const name[]) {

    new BitStream:bs = BS_New(), size = strlen(name);

    BS_WriteValue(
        bs, 
        PR_UINT16, playerid, 
        PR_UINT8, size, 
        PR_STRING, name, 
        PR_UINT8, 1
    );

    BS_RPC(bs, forplayerid, 11);
    // PR_SendRPC(bs, forplayerid, 11);
    BS_Delete(bs);
    return 1;
}

// Use .force_color=true if you want to ignore checks for specific player states like aduty
// Set to true as default as it's best the function does it what you want it without any custom parameters
SetPlayerColorForPlayer(playerid, toplayerid, color, bool:force_color=true) {
    new BitStream:bs = BS_New();

    if(!force_color) {
        if(PlayerVar [playerid] [E_PLAYER_ADMIN_DUTY]) {
            color = 0xD5A04EFF;
        } else if(PlayerVar[playerid][E_PLAYER_HELPER_DUTY]) {
            color = 0x38C751FF;
        } else if(IsPlayerMasked(playerid)) {
            color = 0xDEDEDEFF;
        }
    }

    BS_WriteValue(
        bs,
        PR_UINT16, playerid,
        PR_UINT32, color
    );

    BS_RPC(bs, toplayerid, 72);
    // PR_SendRPC(bs, toplayerid, 72);
    BS_Delete(bs);
    return 1;
}


UpdateTabListForOthers(playerid) {
    for(new targetid=GetMaxPlayers()-1; targetid != -1; targetid--) {

        if (!IsPlayerConnected(targetid) || !IsPlayerPlaying(targetid)) continue;
        UpdateTabList(playerid, targetid);
    }
    return true;
}


UpdateTabListForPlayer(playerid) {
    for(new targetid=GetMaxPlayers()-1; targetid != -1; targetid--) {

        if (!IsPlayerConnected(targetid)  || !IsPlayerPlaying(targetid)) continue;
        UpdateTabList(targetid, playerid);
    }

    return true ;
}

UpdateTabList(playerid, forplayerid) {

    new color = (GetPlayerNametagPreference(forplayerid) ? 0xDEDEDEFF : Faction_GetHex(Character[playerid][E_CHARACTER_FACTIONID]));
    
    if (!IsPlayerConnected(forplayerid) || !IsPlayerPlaying(forplayerid)) {
        return true ;
    }

    new title[64];


    // Masked color is no longer set here. It's embedded within SetPlayerColorForPlayer
    if(PlayerVar [playerid] [E_PLAYER_ADMIN_DUTY]) { // check for admin duty

        //color = 0xD5A04EFF;
        format(title, sizeof(title), "[Admin] %s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);

    } else if(PlayerVar[playerid][E_PLAYER_HELPER_DUTY]) { // check for helper duty

        //color = 0x38C751FF;
        format(title, sizeof(title), "[Helper] %s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
        
    }

    //SetPlayerColor(playerid, color);

    // check if the player needs a custom title, else use the default
    // hope this is fine, not sure how else to check if the title was set
    SetPlayerNameForPlayer(playerid, forplayerid, (strlen(title) > 0) ? title : ReturnSettingsName(playerid, forplayerid, .color=false, .masked=false));
    SetPlayerColorForPlayer(playerid, forplayerid, color, .force_color=false); 

    return true ;
}

// Hooks
#include <YSI_Coding\y_hooks>
hook OnPlayerStreamIn(playerid, forplayerid) { 
    UpdateTabList(playerid, forplayerid);
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) { 
    UpdateTabListForPlayer(playerid) ;
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerSpawn(playerid) { 
    
    SetPlayerColor(playerid, 0xDEDEDEFF);
    UpdateTabListForPlayer(playerid) ;
    UpdateTabListForOthers(playerid);
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    SetPlayerColor(playerid, 0x000000FF);

    return 1;
}

CMD:syncnames(playerid) {
    if (!IsPlayerConnected(playerid) || !IsPlayerPlaying(playerid)) return false;
    UpdateTabListForPlayer(playerid);
    SendClientMessage(playerid, COLOR_YELLOW, "Your tablist has been updated.");
    printf("%d %s updated their tablist.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME]);
    return 1;
}
CMD:synctablist(playerid) {
    return cmd_syncnames(playerid);
}


timer UpdateTablist[120000]() { // force update every 120s

    foreach(new playerid: Player) {
        UpdateNametagsTick(playerid);
    }
    return true;

}
UpdateNametagsTick(playerid) {
    for(new targetid=GetMaxPlayers()-1; targetid != -1; targetid--) {
        if (!IsPlayerConnected(targetid) || !IsPlayerPlaying(targetid)) continue;
        UpdateTabList(playerid, targetid);
    }
    return true;
}