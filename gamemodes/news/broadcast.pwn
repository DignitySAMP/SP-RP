#include <YSI_Coding\y_hooks>

enum {
    BROADCAST_STATE_NONE    = 0,
    BROADCAST_STATE_LIVE    = 1,
    BROADCAST_STATE_PAUSED  = 2
};

#define MAX_BROADCAST_TITLE 64
static enum E_PLAYER_NEWS_DATA {
	E_PLAYER_NEWS_BROADCASTING,
    E_PLAYER_NEWS_BROADCAST_TITLE[MAX_BROADCAST_TITLE],
    bool:E_PLAYER_NEWS_LISTENING,
    E_PLAYER_NEWS_LISTENING_TO
}
static PlayerNewsVar [ MAX_PLAYERS ] [ E_PLAYER_NEWS_DATA ] ;

hook OnPlayerConnect(playerid)
{
    PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] = BROADCAST_STATE_NONE;
    PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCAST_TITLE][0] = EOS;
    PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING] = false;

    PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO] = INVALID_PLAYER_ID;
    return 1;
}



CMD:broadcast(playerid, params[]) 
{
    new option[7], title[128], str[200];
    sscanf(params, "s[7] ", option);

    if (!IsPlayerInNewsFaction(playerid, true))
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a news faction." ) ;

    if (strlen(option) > 1)
    {
        if (!strcmp(option, "start", true))
        {
            if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING])
            {
                return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're already doing a live broadcast." ) ;
            }

            if (sscanf(params, "s[7] s[128]", option, title))
            {
                return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/broadcast [start] [broadcast title]" ) ;
            }

            if (strlen(title) <= 0 || strlen(title) >= MAX_BROADCAST_TITLE)
            {
                return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/broadcast [start] [broadcast title]" ) ;
            }

            PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] = BROADCAST_STATE_LIVE;
            format(PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCAST_TITLE], MAX_BROADCAST_TITLE, "%s", title);

            // SendClientMessage(playerid, -1, sprintf("You've started a live news broadcast titled: \"%s\".", title));
            // SendClientMessage(playerid, -1, "You or anyone nearby can now type /live to speak on air.");

            ProxDetectorEx(playerid, 30.0, COLOR_PURPLE, "**", sprintf("starts a live broadcast of \"%s\".", title), .annonated=true);

            format ( str, sizeof ( str ), "[TIP] {36D191}%s went live with {36906b}\"%s\"{36D191} Type {36906b}/broadcasts{36D191} to listen.", ReturnMixedName(playerid), title, playerid) ;
	
            foreach(new targetid: Player) 
            {
                if (IsPlayerPlaying(targetid))
                    ZMsg_SendClientMessage ( targetid, COLOR_SERVER, str);
            }

            PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING] = true;
            PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO] = playerid;


        }
        else if (!strcmp(option, "end", true))
        {
            if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] == BROADCAST_STATE_NONE)
            {
                return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You've not started a live broadcast." ) ;
            }

            PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] = BROADCAST_STATE_NONE;
            //SendClientMessage(playerid, -1, "You've put away your microphone and ended the live news broadcast.");
            ProxDetectorEx(playerid, 30.0, COLOR_PURPLE, "**", sprintf("ends the live broadcast of \"%s\".", PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCAST_TITLE]), .annonated=true);
        }
        else if (!strcmp(option, "mute", true))
        {
            if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] != BROADCAST_STATE_LIVE)
            {
                return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a live broadcast to mute." ) ;
            }

            ProxDetectorEx(playerid, 30.0, COLOR_PURPLE, "**", sprintf("mutes the microphone, pausing the live broadcast."), .annonated=true);

            PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] = BROADCAST_STATE_PAUSED;
            // SendClientMessage(playerid, -1, "You've muted your microphone and are no longer broadcasting live.");
        }
        else if (!strcmp(option, "unmute", true))
        {
            if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] != BROADCAST_STATE_PAUSED)
            {
                return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a muted broadcast to resume." ) ;
            }

            ProxDetectorEx(playerid, 30.0, COLOR_PURPLE, "**", sprintf("unmutes the microphone, resuming the live broadcast."), .annonated=true);

            PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] = BROADCAST_STATE_LIVE;
            // SendClientMessage(playerid, -1, "You've unmuted your microphone and are now broadcasting live again.");
        }
        else
        {
            return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/broadcast [start/mute/unmute/end]" ) ;
        }

        
        //G_ANYONE_BROADCASTING = false;
        foreach(new i: Player) 
        {
            if (PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING] && PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO] != INVALID_PLAYER_ID)
            {
                if (!PlayerNewsVar[PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO]][E_PLAYER_NEWS_BROADCASTING])
                {
                    // Player stopped broadcasting while being listened to by another player
                    format ( str, sizeof ( str ), "[LIVE]{36D191} The live broadcast of {e24f80}\"%s\"{36D191} has finished.", PlayerNewsVar[PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO]][E_PLAYER_NEWS_BROADCAST_TITLE]) ;
                    ZMsg_SendClientMessage ( i, COLOR_SERVER, str);

                    PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO] = INVALID_PLAYER_ID;
                    PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING] = false;   
                }
            }

            if (PlayerNewsVar[i][E_PLAYER_NEWS_BROADCASTING] == BROADCAST_STATE_LIVE)
            {
                //G_ANYONE_BROADCASTING = true;
                break;
            }
        }

        return true;
    }

    return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/broadcast [start/mute/unmute/end]" ) ;
}

static BroadcastsDlgStr[1024];

CMD:broadcasts(playerid, params[])
{
    format(BroadcastsDlgStr, sizeof(BroadcastsDlgStr), "Title\tBroadcaster\tStatus\tListeners\n");

    new listeners[MAX_PLAYERS], broadcasts = 0;
    new map[MAX_PLAYERS];

    foreach(new i: Player) 
    {
        if (!PlayerNewsVar[i][E_PLAYER_NEWS_BROADCASTING])
        {
            
            /*if (PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING] && IsPlayerConnected(PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO]))
            {
                listeners[PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO]] ++;
            }*/            
            if (PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING] && IsPlayerConnected(PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO]))
            {
                listeners[PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO]] ++;
            }

        } 
    }

    foreach(new i: Player) 
    {
        if (PlayerNewsVar[i][E_PLAYER_NEWS_BROADCASTING])
        {
            format(BroadcastsDlgStr, sizeof(BroadcastsDlgStr), "%s\t%s\t%s\t%s\t%d\n", BroadcastsDlgStr, PlayerNewsVar[i][E_PLAYER_NEWS_BROADCAST_TITLE], ReturnMixedName(i), GetBroadcastState(PlayerNewsVar[i][E_PLAYER_NEWS_BROADCASTING]), listeners[i]);
            // SendClientMessage(playerid, -1, sprintf("Title: \"%s\", Reporter: %s, Status: %s, Listeners: %d", PlayerNewsVar[i][E_PLAYER_NEWS_BROADCAST_TITLE], ReturnPlayerNameData(i), BroadcastStates[PlayerNewsVar[i][E_PLAYER_NEWS_BROADCASTING]], listeners[i]));
            map[broadcasts] = i;
            broadcasts ++;  
        }
    }

    if (!broadcasts)
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "There are currently no broadcasts." ) ;
    }

    inline BroadcastsDlg(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem

        if (response)
        {
            if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING])
                return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must stop broadcasting first." ) ;

            new broadcasterid = map[listitem];
            if (IsPlayerConnected(broadcasterid) && PlayerNewsVar[broadcasterid][E_PLAYER_NEWS_BROADCASTING])
            {
                PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING] = true;
                PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO] = broadcasterid;
                SendClientMessage(playerid, -1, sprintf("You're now listening to \"%s\" by %s.  Type /tuneout to stop.", PlayerNewsVar[broadcasterid][E_PLAYER_NEWS_BROADCAST_TITLE], ReturnSettingsName(broadcasterid, playerid)));
            }
        }
    }

    Dialog_ShowCallback ( playerid, using inline BroadcastsDlg, DIALOG_STYLE_TABLIST_HEADERS, "Live Broadcasts", BroadcastsDlgStr, "Listen", "Back" );

    return true;
}


CMD:tunein(playerid, params[])
{
    new targetid;

    if (sscanf ( params, "k<player>", targetid )) 
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/tunein [player]" ) ;

    if (!PlayerNewsVar[targetid][E_PLAYER_NEWS_BROADCASTING])
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't broadcasting." ) ;

    if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING])
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must stop broadcasting first." ) ;

    PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING] = true;
    PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO] = targetid;
    SendClientMessage(playerid, -1, sprintf("You're now listening to \"%s\" by %s.", PlayerNewsVar[targetid][E_PLAYER_NEWS_BROADCAST_TITLE], ReturnSettingsName(targetid, playerid)));
    return true;
}

CMD:tuneout(playerid)
{
    if (!PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING])
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You aren't listening to a broadcast." ) ;

    if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING])
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must stop broadcasting first." ) ;

    PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING] = false;
    PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO] = INVALID_PLAYER_ID;
    return true;
}


hook OnPlayerUpdate(playerid)
{
    // quick but bad way of doing this atm
    if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] != BROADCAST_STATE_NONE)
    {
        if (IsPlayerIncapacitated(playerid, false))
        {
            PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] = BROADCAST_STATE_NONE;
            SendClientMessage(playerid, -1, "Your news broadcast was interrupted.");
        }

        if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] == BROADCAST_STATE_LIVE)
        {
            SetPlayerChatBubble(playerid, sprintf("(( Broadcasting \"%s\" [ Type /live to join in. ] ))", PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCAST_TITLE], playerid), COLOR_SERVER, 7.5, 7500);
        }
    }

    return 1;
}


CMD:live(playerid, params[])
{
    new text[144], color = COLOR_ADV;
    
	if (PlayerNewsVar[playerid][E_PLAYER_NEWS_BROADCASTING] == BROADCAST_STATE_LIVE)
    {
        // This is the reporter.
        if (sscanf ( params, "s[144]", text )) 
		    return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/live [text]" ) ;

        if (strlen(text) < 3)
            return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/live [text]" ) ;

        ProxDetectorLive(playerid, playerid, 15.0, -1, COLOR_ADV, text);
    }
    else
    {
        // Find closest reporter
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        new world = GetPlayerVirtualWorld(playerid);
        new closest = INVALID_PLAYER_ID;
        new Float:current;
        new Float:last = 5.0; // 5.0 radius for /live

        foreach (new i: Player) 
        {
            if (i == playerid) continue;
            if (GetPlayerVirtualWorld(i) != world) continue;
            if (PlayerNewsVar[i][E_PLAYER_NEWS_BROADCASTING] != BROADCAST_STATE_LIVE) continue;

            current = GetPlayerDistanceFromPoint(i, x, y, z);

            if (current < last)
            {
                closest = i;
                last = current;
            }
        }

        if (!IsPlayerConnected(closest))
            return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near any live broadcasters." ) ;

        if (!PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING] || PlayerNewsVar[playerid][E_PLAYER_NEWS_LISTENING_TO] != closest)
        {
            return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be tuned in to this player's broadcast to speak on it." ) ;
        }

        if (sscanf ( params, "s[128]", text )) 
		    return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/live [text]" ) ;

        if (strlen(text) < 3)
            return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/live [text]" ) ;
 
        ProxDetectorLive(playerid, closest, 15.0, -1, COLOR_ADV, text);
    }

    if (strlen(text))
        SetPlayerChatBubble(playerid, sprintf("(live) %s", text), color, 15.0, (strlen(text) * 50) + 2500);

    return true;
}

static ProxDetectorLive(playerid, broadcasterid, Float:range, local_color, remote_color, text[]) 
{
    new Float:distance, Float:remote_distance;
    new color = local_color;
    new Float:senderpos[3];
    new Float:broadcastpos[3];
    new Float:distancescaled;
    new str[512];
    new colorvalue;

    GetPlayerPos(playerid, senderpos[0], senderpos[1], senderpos[2]);
    GetPlayerPos(broadcasterid, broadcastpos[0], broadcastpos[1], broadcastpos[2]);

    remote_distance = GetPlayerDistanceFromPoint(playerid, broadcastpos[0], broadcastpos[1], broadcastpos[2]);

    foreach (new i: Player)
    {
        if (PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING] && PlayerNewsVar[i][E_PLAYER_NEWS_LISTENING_TO] == broadcasterid)
        {
            // Remote chat
            color = remote_color;
            distance = remote_distance;
            format ( str, sizeof ( str ), "[LIVE] %s says: %s", ReturnSettingsName(playerid, i), text ) ;
        }
        else
        {
            // Local chat
            color = local_color;
            distance = GetPlayerDistanceFromPoint(i, senderpos[0], senderpos[1], senderpos[2]);
            format ( str, sizeof ( str ), "%s says [live]: %s", ReturnSettingsName(playerid, i), text ) ;
        }

        new r = ((color >> 24) & 0xFF);
        new g = ((color >> 16) & 0xFF);
        new b = ((color >> 8) & 0xFF);       

        if (distance <= range) // receiving player is within the specified distance
        {
            // get normalized distance to create a fade.
            distancescaled = (distance / range);
            new colormod = floatround(distancescaled * 128.0);

            new cr = r - colormod;
            new cg = g - colormod;
            new cb = b - colormod;
            
            if (r < 0) cr = 0;
            if (g < 0) cg = 0;
            if (b < 0) cb = 0;
            
            colorvalue = ((cr & 0xFF) << 24) + ((cg & 0xFF) << 16) + ((cb & 0xFF) << 8);
            if (playerid == broadcasterid) colorvalue = color;

            ZMsg_SendClientMessage ( i, colorvalue, str);
        }
    }
}

GetBroadcastState(broadcastState) {
    new output[10];
    switch(broadcastState) {
        case BROADCAST_STATE_NONE: format(output, sizeof(output), "None");
        case BROADCAST_STATE_LIVE: format(output, sizeof(output), "Live");
        case BROADCAST_STATE_PAUSED: format(output, sizeof(output), "Paused");
    }
    return output;
}