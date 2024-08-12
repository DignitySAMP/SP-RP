#define MAX_SPIKES 10
#define SPIKES_DURATION 7200

#include <YSI_Coding\y_hooks>

static enum E_SPIKE_DATA
{
    bool:E_SPIKE_EXISTS,
    E_SPIKE_OBJECT,
    Float:E_SPIKE_POS[4],
    E_SPIKE_AREAS[3],
    E_SPIKE_BOUNDING,
    E_SPIKE_PLAYER,
    E_SPIKE_TIME,
    E_SPIKE_HITS,
    DynamicText3D:E_SPIKE_LABEL
}

static Spikes[MAX_SPIKES][E_SPIKE_DATA];

CMD:spikes(playerid, params[])
{
    if (!IsPlayerInPoliceFaction(playerid, true)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty as a cop.");

    if (IsPlayerInAnyVehicle(playerid))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't do this while in a car, get out first." );
    }

    new vehicleid = INVALID_VEHICLE_ID;
    vehicleid = GetClosestVehicleEx(playerid, 7.5);

	if (vehicleid == INVALID_VEHICLE_ID) 
    {
		return SendClientMessage(playerid, COLOR_ERROR, "You're not near the trunk of a faction vehicle!");
	}

	if (IsAircraft(vehicleid) || IsABoat(vehicleid) || IsABike(vehicleid) || !IsFactionVehicle(vehicleid, Character[playerid][E_CHARACTER_FACTIONID]))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk or isn't a faction car!");
	}

	new Float: x, Float: y, Float: z ;
	GetPosBehindVehicle ( vehicleid, x, y, z );

	new Float: range = 2.5 ;

	if (!IsPlayerInRangeOfPoint(playerid, range, x, y, z )) 
    {
        return SendClientMessage(playerid, COLOR_ERROR, "You can only do this standing at the trunk (rear) of the vehicle.");
    }

    if (!GetTrunkStatus(vehicleid))
    {
        return SendClientMessage(playerid, COLOR_ERROR, "The vehicle trunk is closed, open it first (/cartrunk).");
    }

    inline SpikeTrunkDlg(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem

        if (response)
        {
            new id = -1;

            for (new i = 0; i < MAX_SPIKES; i ++)
            {
                if (Spikes[i][E_SPIKE_EXISTS]) continue;
                id = i;
            }

            if (id == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("The maximum number of spikes (%d) have already been placed.", MAX_SPIKES)); 
            ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", sprintf("equips a spike strip from the trunk of the %s.", ReturnVehicleName(vehicleid)), false, true);
            PlayerVar[playerid][E_PLAYER_HAS_SPIKES] = true;
            PlayerVar[playerid][E_PLAYER_HAS_SPIKES_AT] = gettime();

            ShowPlayerFooter(playerid, "Press ~y~~k~~GROUP_CONTROL_BWD~ ~w~to deploy the spike strip.");
        }
    }


    Dialog_ShowCallback ( playerid, using inline SpikeTrunkDlg, DIALOG_STYLE_MSGBOX, "Police Spikes", "{FFFFFF}Press {AA3333}OK{FFFFFF} to equip a spike strip.", "OK", "Back" );
    return true;
}

static GetPlayerFrontPos(playerid, &Float:x, &Float:y, &Float:z, Float:distance)
{
    new Float:rot;
    GetPlayerPos(playerid, x, y, z);
    rot = 360 - rot;    // Making the player rotation compatible with pawns sin/cos
    GetPlayerFacingAngle(playerid, rot);

    x += (distance * floatsin(-rot, degrees));
    y += (distance * floatcos(-rot, degrees));
}


#define SPIKE_X 1.0
#define SPIKE_Y 6.5
#define SPIKE_Z 5.0

#define SPIKE_WIDE_X (SPIKE_X * 10.0)
#define SPIKE_WIDE_Y (SPIKE_Y * 2.0)

static const CachedHealthBar[][18] = 
{
    "°°°°",
    "°°°{660000}°",
    "°°{660000}°°",
    "°{660000}°°°",
     "{660000}°°°°"
};

CMD:spike(playerid)
{
    if (!PlayerVar[playerid][E_PLAYER_HAS_SPIKES]) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You do not have a spike strip equipped.");
    if (IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be on foot to deploy spikes.");
    
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerFrontPos(playerid, x, y, z, 6.0);
    GetPlayerFacingAngle(playerid, a);

    new id = CreateSpikes(x, y, z - 1.0, a);
    if (id == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("The maximum number of spikes (%d) have already been placed.", MAX_SPIKES));
    Spikes[id][E_SPIKE_PLAYER] = playerid; 

    ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.0, 0, 0, 0, 0, 0, 1);
    
    GetPlayerFrontPos(playerid, x, y, z, 4.0);
    SetDynamicObjectPos(Spikes[id][E_SPIKE_OBJECT], x, y, z - 0.75);
    MoveDynamicObject(Spikes[id][E_SPIKE_OBJECT], Spikes[id][E_SPIKE_POS][0], Spikes[id][E_SPIKE_POS][1], Spikes[id][E_SPIKE_POS][2], 7.5);
    Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

    ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "throws down a spike strip.", false, true);
    PlayerVar[playerid][E_PLAYER_HAS_SPIKES] = false;


    new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
    new faction_enum_id = Faction_GetEnumID(factionid ); 
    new address[64], zone[64], msg[128];
    GetCoords2DZone(Spikes[id][E_SPIKE_POS][0], Spikes[id][E_SPIKE_POS][1], zone, sizeof(zone));
	GetPlayerAddress(Spikes[id][E_SPIKE_POS][0], Spikes[id][E_SPIKE_POS][1], address);

    // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
    format(msg, sizeof(msg), "Deployed a spike strip at %s, %s.", address, zone);
    AddLogEntry(playerid, LOG_TYPE_SCRIPT, msg);

    format(msg, sizeof(msg), "{ [%s] (%d) %s %s }", Faction[faction_enum_id][E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), msg);
    Faction_SendMessage(factionid, msg, faction_enum_id, false);
    return true;
}

CreateSpikes(Float:x, Float:y, Float:z, Float:a)
{
    new id = -1;
    for (new i = 0; i < MAX_SPIKES; i ++)
    {
        if (Spikes[i][E_SPIKE_EXISTS]) continue;
        id = i;
    }

    if (id >= 0)
    {
        Spikes[id][E_SPIKE_EXISTS] = true;       
        Spikes[id][E_SPIKE_PLAYER] = INVALID_PLAYER_ID;
        Spikes[id][E_SPIKE_TIME] = gettime();
        Spikes[id][E_SPIKE_HITS] = 0;

        Spikes[id][E_SPIKE_POS][0] = x;
        Spikes[id][E_SPIKE_POS][1] = y;
        Spikes[id][E_SPIKE_POS][2] = z;
        Spikes[id][E_SPIKE_POS][3] = a;

        Spikes[id][E_SPIKE_OBJECT] = CreateDynamicObject(2892, x, y, z, 0.0, 0.0, a, -1, -1, -1, 200.0, 200.0, -1, 1); // Priority: 1
        Spikes[id][E_SPIKE_LABEL] = CreateDynamic3DTextLabel("Spike Strip", 0x3479E3FF, x, y, z + 0.5, 10.0, .testlos = true);
        Spikes[id][E_SPIKE_BOUNDING] = CreateDynamicCircle(x, y, 50.0);

        new Float:offset = -2.75;
        for (new i = 0; i < 3; i ++)
        {
            GetDynObjRelativePos(Spikes[id][E_SPIKE_OBJECT], x, y, z, 0.0, offset, 0.0); 
            Spikes[id][E_SPIKE_AREAS][i] = CreateDynamicCircle(x, y, 2.5);
            offset += 2.75;
        }

        UpdateSpikes(id);

        foreach(new i: Player)
        {
            if (IsPlayerInRangeOfPoint(i, 50.0, x, y, z))
            {
                Streamer_Update(i, STREAMER_TYPE_OBJECT);
                if (IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
                {
                    // Makes the spikes work now for players that are close when they spawn
                    PlayerEnterSpikeArea(i, id); 
                }
            }
        }
        
    }

    return id;
}

UpdateSpikes(spikestrip)
{
    if (Spikes[spikestrip][E_SPIKE_EXISTS] && IsValidDynamic3DTextLabel(Spikes[spikestrip][E_SPIKE_LABEL]))
    {
        UpdateDynamic3DTextLabelText(Spikes[spikestrip][E_SPIKE_LABEL], 0xFF0000FF, sprintf("{FF0000}%s\n{DEDEDE}Press {FFFF00}~k~~GROUP_CONTROL_BWD~ {DEDEDE}to pick up.", CachedHealthBar[Spikes[spikestrip][E_SPIKE_HITS]]));
    }
}

PickupSpikes(playerid, spikestrip)
{
    if (!IsPlayerInPoliceFaction(playerid, true)) return ShowPlayerFooter(playerid, "~r~Only cops can pickup spike strips.");
    DestroySpike(spikestrip, true);

    ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "picks up the spike strip.", false, true);
    PlayerVar[playerid][E_PLAYER_HAS_SPIKES] = true;
    PlayerVar[playerid][E_PLAYER_HAS_SPIKES_AT] = gettime();

    ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 0, 0, 0, 1000, 1);

    new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
    new faction_enum_id = Faction_GetEnumID(factionid ); 
    new address[64], zone[64], msg[128];
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    GetCoords2DZone(x, y, zone, sizeof ( zone ));
	GetPlayerAddress(x, y, address);

    // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
    format(msg, sizeof(msg), "Picked up a spike strip at %s, %s.", address, zone);
    AddLogEntry(playerid, LOG_TYPE_SCRIPT, msg);

    format(msg, sizeof(msg), "{ [%s] (%d) %s %s }", Faction[faction_enum_id][E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), msg);
    Faction_SendMessage(factionid, msg, faction_enum_id, false );
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (PlayerVar[playerid][E_PLAYER_HAS_SPIKES] && (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER))
    {
        PlayerVar[playerid][E_PLAYER_HAS_SPIKES] = false;
		SendServerMessage(playerid, COLOR_ERROR, "Spikes", "A3A3A3", "Your spikes were automatically returned to the trunk.");
    }

    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (PRESSED(KEY_CTRL_BACK) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        // Find closest spikestrip
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        new closest = -1;
        new Float:current;
        new Float:last = 5.0; // 5.0 radius for picking up

        for (new i = 0; i < MAX_SPIKES; i ++)
        {
            if (!Spikes[i][E_SPIKE_EXISTS]) continue;
            current = GetDistanceBetweenPoints(x, y, z, Spikes[i][E_SPIKE_POS][0], Spikes[i][E_SPIKE_POS][1], Spikes[i][E_SPIKE_POS][2]);

            if (current < last)
            {
                closest = i;
                last = current;
            }
        }

        if (closest != -1)
        {
            PickupSpikes(playerid, closest);
            return 1;
        }

        if (PlayerVar[playerid][E_PLAYER_HAS_SPIKES])
        {
            cmd_spike(playerid);
            return 1;
        }
    }

    return 1;
}

static PlayerEnterSpikeArea(playerid, spike)
{
    #pragma unused spike
    // Makes the player eligible for OnPlayerUpdate spikestrip hit checks
    PlayerVar[playerid][E_PLAYER_HIT_SPIKES] = true;
}

hook OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid)
{
    if (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        for (new i = 0; i < MAX_SPIKES; i ++)
        {
            if (Spikes[i][E_SPIKE_BOUNDING] == areaid)
            {
                PlayerEnterSpikeArea(playerid, i);
                break;
            }   
        }
    }

    return 1;
}

static PlayerLeaveSpikeArea(playerid, spike)
{
    #pragma unused spike
    // Makes the player ineligible for OnPlayerUpdate spikestrip hit checks
    PlayerVar[playerid][E_PLAYER_HIT_SPIKES] = false;
}

hook OnPlayerLeaveDynArea(playerid, STREAMER_TAG_AREA:areaid)
{
    if (PlayerVar[playerid][E_PLAYER_HIT_SPIKES])
    {
        for (new i = 0; i < MAX_SPIKES; i ++)
        {
            if (Spikes[i][E_SPIKE_BOUNDING] == areaid)
            {
                PlayerLeaveSpikeArea(playerid, i);
                break;
            }   
        }
    }

    return 1;
}

stock tf_EncodeTireState(rearRight, frontRight, rearLeft, frontLeft) {
    return rearRight | (frontRight << 1) | (rearLeft << 2) | (frontLeft << 3);
}

OnSpikeStripHit(playerid, vehicleid, spikestrip, tire)
{
    #pragma unused playerid
    if (!Spikes[spikestrip][E_SPIKE_EXISTS]) return 0;
    
    new c_panels, c_doors, c_lights, c_tires, tirestatus;
    GetVehicleDamageStatus(vehicleid, c_panels, c_doors, c_lights, c_tires);
    tirestatus = c_tires >> tire & 1;

    if (!tirestatus)
    {
        if (tire == 0) c_tires = tf_EncodeTireState(1, c_tires >> 1 & 1, c_tires >> 2 & 1, c_tires >> 3 & 1);
        else if (tire == 1) c_tires = tf_EncodeTireState(c_tires & 1, 1, c_tires >> 2 & 1, c_tires >> 3 & 1);
        else if (tire == 2) c_tires = tf_EncodeTireState(c_tires & 1, c_tires >> 1 & 1, 1, c_tires >> 3 & 1);
        else if (tire == 3) c_tires = tf_EncodeTireState(c_tires & 1, c_tires >> 1 & 1, c_tires >> 2 & 1, 1);

        UpdateVehicleDamageStatus(vehicleid, c_panels, c_doors, c_lights, c_tires);
        Spikes[spikestrip][E_SPIKE_HITS] ++;
        
        if (Spikes[spikestrip][E_SPIKE_HITS] >= 4)
        {
            // Set it to be destroyed
            DestroySpike(spikestrip);
        }

        UpdateSpikes(spikestrip);
    }

    return 1;   
}

DestroySpike(spikestrip, bool:pickedup=false)
{
    if (Spikes[spikestrip][E_SPIKE_EXISTS])
    {
        if (IsValidDynamic3DTextLabel(Spikes[spikestrip][E_SPIKE_LABEL])) DestroyDynamic3DTextLabel(Spikes[spikestrip][E_SPIKE_LABEL]);
        if (IsValidDynamicObject(Spikes[spikestrip][E_SPIKE_OBJECT])) DestroyDynamicObject(Spikes[spikestrip][E_SPIKE_OBJECT]);
        if (IsValidDynamicArea(Spikes[spikestrip][E_SPIKE_BOUNDING])) DestroyDynamicArea(Spikes[spikestrip][E_SPIKE_BOUNDING]);

        for (new i = 0; i < 3; i ++)
        {
            if (IsValidDynamicArea(Spikes[spikestrip][E_SPIKE_AREAS][i])) DestroyDynamicArea(Spikes[spikestrip][E_SPIKE_AREAS][i]);
        }

        if (IsPlayerConnected(Spikes[spikestrip][E_SPIKE_PLAYER]))
        {
            if (!pickedup) SendClientMessage(Spikes[spikestrip][E_SPIKE_PLAYER], -1, "Your spikestrip was destroyed.");
        }

        Spikes[spikestrip][E_SPIKE_EXISTS] = false;
    }
}

//hook OnPlayerDisconnect(playerid, reason)
hook SOLS_OnCloseConnection(playerid, reason)
{
    for (new i = 0; i < MAX_SPIKES; i ++)
    {
        if (Spikes[i][E_SPIKE_EXISTS] && Spikes[i][E_SPIKE_PLAYER] == playerid)
        {
            DestroySpike(i);
        }   
    }

    return 1;
}

hook OnPlayerUpdate(playerid)
{
    if (PlayerVar[playerid][E_PLAYER_HIT_SPIKES])
    {
        if (PlayerVar[playerid][E_PLAYER_HIT_SPIKE_AT] && (GetTickCount() - PlayerVar[playerid][E_PLAYER_HIT_SPIKE_AT]) < 100)
        {
            // Stops performance issues by limiting to 100ms between checks
            return 1;
        } 

        new vehicleid = GetPlayerVehicleID(playerid);
        if (!vehicleid || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        {
            PlayerVar[playerid][E_PLAYER_HIT_SPIKES] = false;
            return 1;
        }

        new model = GetVehicleModel(vehicleid);
        new Float:x[5], Float:y[5], Float:z[5];

        GetVehicleModelInfo(model, VEHICLE_MODEL_INFO_WHEELSFRONT, x[0], y[0], z[0]);
        GetVehicleRelativePos(vehicleid, x[1], y[1], z[1], x[0], y[0], z[0]);
        GetVehicleRelativePos(vehicleid, x[2], y[2], z[2], -x[0], y[0], z[0]);

        GetVehicleModelInfo(model, VEHICLE_MODEL_INFO_WHEELSREAR, x[0], y[0], z[0]);
        GetVehicleRelativePos(vehicleid, x[3], y[3], z[3], x[0], y[0], z[0]);
        GetVehicleRelativePos(vehicleid, x[4], y[4], z[4], -x[0], y[0], z[0]);

        for (new s = 0; s < MAX_SPIKES; s ++)
        {
            if (!Spikes[s][E_SPIKE_EXISTS]) continue;
            else if (!IsPlayerInDynamicArea(playerid, Spikes[s][E_SPIKE_BOUNDING])) continue;

            for (new i = 0; i < 3; i ++)
            {
                if (IsPointInDynamicArea(Spikes[s][E_SPIKE_AREAS][i], x[1], y[1], z[1]))
                {
                    OnSpikeStripHit(playerid, vehicleid, s, 1);
                }
                if (IsPointInDynamicArea(Spikes[s][E_SPIKE_AREAS][i], x[2], y[2], z[2]))
                {
                    OnSpikeStripHit(playerid, vehicleid, s, 3);
                }
                if (IsPointInDynamicArea(Spikes[s][E_SPIKE_AREAS][i], x[3], y[3], z[3]))
                {
                    OnSpikeStripHit(playerid, vehicleid, s, 0);
                }
                if (IsPointInDynamicArea(Spikes[s][E_SPIKE_AREAS][i], x[4], y[4], z[4]))
                {
                    OnSpikeStripHit(playerid, vehicleid, s, 2);
                }
            }
        }

        // Set this to current tick count so we only check again 250ms after
        PlayerVar[playerid][E_PLAYER_HIT_SPIKE_AT] = GetTickCount();
    }

    return 1;
}


task Spike_Task[60000]()
{
    for (new i = 0; i < MAX_SPIKES; i ++)
    {
        if (Spikes[i][E_SPIKE_EXISTS] && gettime() - Spikes[i][E_SPIKE_TIME] > SPIKES_DURATION)
        {
            DestroySpike(i);
        }   
    }
}