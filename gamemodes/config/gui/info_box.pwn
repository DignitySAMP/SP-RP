static PlayerText:gplTextDraw[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

ShowPlayerInfoMessage(playerid, const message[], showtime = 0, Float: height=250.0, Float: width=172.0)
{
    if(gplTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawSetString(playerid, gplTextDraw[playerid], message);
        return 1;
    }

    gplTextDraw[playerid] = CreatePlayerTextDraw(playerid, 20.000000, height, message);
    PlayerTextDrawBackgroundColor(playerid, gplTextDraw[playerid], -256);
    PlayerTextDrawFont(playerid, gplTextDraw[playerid], 1);
    PlayerTextDrawLetterSize(playerid, gplTextDraw[playerid], 0.380000, 1.5700000);
    PlayerTextDrawColor(playerid, gplTextDraw[playerid], -858993409);
    PlayerTextDrawSetOutline(playerid, gplTextDraw[playerid], 1);
    PlayerTextDrawSetProportional(playerid, gplTextDraw[playerid], 1);
    PlayerTextDrawUseBox(playerid, gplTextDraw[playerid], 1);
    PlayerTextDrawBoxColor(playerid, gplTextDraw[playerid], 0x000000AA);
    PlayerTextDrawTextSize(playerid, gplTextDraw[playerid], width, -3.000000);
    PlayerTextDrawShow(playerid, gplTextDraw[playerid]);
    if(showtime > 0) {

       defer HidePlayerInfoMessage[showtime](playerid);
    }
    return 1;
}

timer HidePlayerInfoMessage[5000](playerid)
{
    if(gplTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
        return 1;

    PlayerTextDrawDestroy(playerid, gplTextDraw[playerid]);
    gplTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;

    return 1;
}

public OnPlayerDisconnect(playerid, reason) {

    if(gplTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW)
        gplTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    
    #if defined infobox_OnPlayerDisconnect
        return infobox_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect infobox_OnPlayerDisconnect
#if defined infobox_OnPlayerDisconnect
    forward infobox_OnPlayerDisconnect(playerid, reason);
#endif