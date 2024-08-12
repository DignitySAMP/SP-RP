static PlayerText:gpTextDrawSub[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

forward SOLS_ShowPlayerSubtitle(playerid, text[], duration);
public SOLS_ShowPlayerSubtitle(playerid, text[], duration)
{
    ShowPlayerSubtitle(playerid, text, duration);
    return 1;
}

ShowPlayerSubtitle(playerid, const text[], showtime = 0, Float: height = 400.5)
{
    if(gpTextDrawSub[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawSetString(playerid, gpTextDrawSub[playerid], text);
        return 1;
    }

    gpTextDrawSub[playerid] = CreatePlayerTextDraw(playerid, 325.666625, height, text);
    PlayerTextDrawLetterSize(playerid, gpTextDrawSub[playerid], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, gpTextDrawSub[playerid], 2);
    PlayerTextDrawColor(playerid, gpTextDrawSub[playerid], 0xe8e8e8ff);
    PlayerTextDrawSetShadow(playerid, gpTextDrawSub[playerid], 2);
    PlayerTextDrawSetOutline(playerid, gpTextDrawSub[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, gpTextDrawSub[playerid], 255);
    PlayerTextDrawFont(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawSetProportional(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawShow(playerid, gpTextDrawSub[playerid]);

    if(showtime > 0) {

       defer HidePlayerSubtitle[showtime](playerid);
    }

    return 1;
}

timer HidePlayerSubtitle[5000](playerid) {

    if(gpTextDrawSub[playerid] == PlayerText:INVALID_TEXT_DRAW)
        return 1;

    PlayerTextDrawDestroy(playerid, gpTextDrawSub[playerid]);
    gpTextDrawSub[playerid] = PlayerText:INVALID_TEXT_DRAW;

    return 1;
}

//------------------------------------------------------------------------------

public OnPlayerDisconnect(playerid, reason)
{
    gpTextDrawSub[playerid] = PlayerText:INVALID_TEXT_DRAW;

    #if defined subtitle_OnPlayerDisconnect
        return subtitle_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect subtitle_OnPlayerDisconnect
#if defined subtitle_OnPlayerDisconnect
    forward subtitle_OnPlayerDisconnect(playerid, reason);
#endif