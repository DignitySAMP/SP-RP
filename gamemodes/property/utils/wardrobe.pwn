//------------------------------------------------------------------------------
// Wardrobes for changing clothes
// Written by Spooky (www.github.com/sporkyspork) for GTAC:RP

#include <YSI_Coding\y_hooks>

enum E_WARDROBE_TYPE
{
    WARDROBE_TYPE_DEFAULT,     // Public access, shows all skins a user owns and can also have skins added to it (in future)
    WARDROBE_TYPE_PROPERTY,    // Public access, but is... potentially manageable by property owner/renter in future (shows skins the user owns like default)
    WARDROBE_TYPE_FACTION,     // Faction access, shows faction skins if on duty or skins a user owns if off duty
    WARDROBE_TYPE_TEMP,        // Public access but any skin the user does not own is given temporarily and not saved
}

static enum E_WARDROBE_TYPE_DATA
{
    E_WARDROBE_TYPE_NAME[16],
    E_WARDROBE_TYPE_DESC[128],
    bool:E_WARDROBE_TYPE_DISABLED
}

static const WardrobeType[E_WARDROBE_TYPE][E_WARDROBE_TYPE_DATA] = 
{
    {"Default", "Public access, shows skins the player owns"},
    {"Property", "Same as default but is linked to a property and can be moved by the property owner"},
    {"Faction", "Faction access, shows faction skins", true},
    {"Temporary", "Public access but players do not keep the skins they choose", true}
};


#define MAX_WARDROBES               1000
#define WARDROBE_LABEL_RADIUS       5.0
#define WARDROBE_USE_RADIUS         2.5
#define WARDROBE_CAPACITY           15
#define WARDROBE_COST               750

static enum E_WARDROBE_DATA
{
    E_WARDROBE_ID,
    E_WARDROBE_TYPE:E_WARDROBE_TYPE_ID,
    E_WARDROBE_OWNER,
    Float:E_WARDROBE_POS[4],
    E_WARDROBE_INT,
    E_WARDROBE_WORLD,
    E_WARDROBE_NAME[32],
    STREAMER_TAG_PICKUP:E_WARDROBE_PICKUP,
    STREAMER_TAG_3D_TEXT_LABEL:E_WARDROBE_LABEL,
    E_WARDROBE_USER
}

static Wardrobe[MAX_WARDROBES][E_WARDROBE_DATA];
static WardrobeClear[E_WARDROBE_DATA];
static WardrobeQueryStr[300];
static WardrobeDlgStr[1024];


static GetWardrobeFreeEnumId()
{
    for (new i = 0; i < MAX_WARDROBES; i ++)
    {
        if (!Wardrobe[i][E_WARDROBE_ID])
        {
            return i;
        }
    }

    return -1;
}

static GetWardrobeEnumId(wardrobe_id)
{
    for (new i = 0; i < MAX_WARDROBES; i ++)
    {
        if (Wardrobe[i][E_WARDROBE_ID] == wardrobe_id)
        {
            return i;
        }
    }

    return -1;
}

static GetClosestWardrobeToPoint(Float:x, Float:y, Float:z, interior, world)
{
    new closest = -1;
    new Float:current;
    new Float:last = WARDROBE_USE_RADIUS;

    for (new i = 0; i < MAX_WARDROBES; i ++)
    {
        if (Wardrobe[i][E_WARDROBE_ID] && Wardrobe[i][E_WARDROBE_INT] == interior && Wardrobe[i][E_WARDROBE_WORLD] == world)
        {
            current = GetPointDistanceToPoint(x, y, z, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2]);

            if (current < last)
            {
                closest = i;
                last = current;
            }
        }
    }

    return closest;
}

static GetClosestWardrobeToPlayer(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    return GetClosestWardrobeToPoint(x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
}

static GetPropertyWardrobe(property_id)
{
    for (new i = 0; i < MAX_WARDROBES; i ++)
    {
        if (Wardrobe[i][E_WARDROBE_ID] && Wardrobe[i][E_WARDROBE_TYPE_ID] == WARDROBE_TYPE_PROPERTY && Wardrobe[i][E_WARDROBE_OWNER] == property_id)
        {
            return i;
        }
    }

    return -1;
}

static bool:IsWardrobeAdmin(playerid)
{
    return GetPlayerAdminLevel(playerid) >= ADMIN_LVL_GENERAL;
}

forward OnLoadWardrobe(wardrobe_id, existing_index);
public OnLoadWardrobe(wardrobe_id, existing_index)
{ 
    new enum_id, buffer[E_WARDROBE_DATA];
    for (new i = 0, r = cache_num_rows(); i < r; ++i)
    {
        cache_get_value_name_int(i, "wardrobe_id", buffer[E_WARDROBE_ID]);
        cache_get_value_name_int(i, "wardrobe_int", buffer[E_WARDROBE_INT]);
        cache_get_value_name_int(i, "wardrobe_world", buffer[E_WARDROBE_WORLD]);
        cache_get_value_name_int(i, "wardrobe_owner", buffer[E_WARDROBE_OWNER]);
        cache_get_value_name_int(i, "wardrobe_type", _:buffer[E_WARDROBE_TYPE_ID]);
        cache_get_value_name_float(i, "wardrobe_pos_x", buffer[E_WARDROBE_POS][0]);
        cache_get_value_name_float(i, "wardrobe_pos_y", buffer[E_WARDROBE_POS][1]);
        cache_get_value_name_float(i, "wardrobe_pos_z", buffer[E_WARDROBE_POS][2]);
        cache_get_value_name_float(i, "wardrobe_pos_a", buffer[E_WARDROBE_POS][3]);

        cache_get_value_name(i, "wardrobe_name", buffer[E_WARDROBE_NAME]);

        if (wardrobe_id == -1) enum_id = i;
        else if (existing_index != -1) enum_id = existing_index;
        else enum_id = GetWardrobeFreeEnumId();

        if (enum_id == -1)
        {
            print("[error] Reached max Wardrobes.");
            break;
        }
        
        if (Wardrobe[enum_id][E_WARDROBE_ID])
        {
            DestroyWardrobe(enum_id);
        }

        Wardrobe[enum_id] = buffer;
        CreateWardrobe(enum_id);
    }

    if (wardrobe_id != -1) printf("[wardrobe] Loaded Wardrobe ID %d", wardrobe_id);
    else printf("[wardrobe] Loaded %d Wardrobes", cache_num_rows());

    return 1;
}

static LoadAllWardrobes()
{
    mysql_format(mysql, WardrobeQueryStr, sizeof ( WardrobeQueryStr ), "SELECT * FROM `wardrobes` LIMIT %d", MAX_WARDROBES);
	mysql_tquery(mysql, WardrobeQueryStr, "OnLoadWardrobe", "dd", -1, -1);
    print(WardrobeQueryStr);
}

static LoadWardrobe(wardrobe_id, existing_index = -1)
{
    mysql_format(mysql, WardrobeQueryStr, sizeof ( WardrobeQueryStr ), "SELECT * FROM `wardrobes` WHERE `wardrobe_id` = %d LIMIT 1", wardrobe_id);
	mysql_tquery(mysql, WardrobeQueryStr, "OnLoadWardrobe", "dd", wardrobe_id, existing_index);
}

static CreateWardrobe(i)
{
    Wardrobe[i][E_WARDROBE_PICKUP] = CreateDynamicPickup(1275, 1, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2], Wardrobe[i][E_WARDROBE_WORLD], Wardrobe[i][E_WARDROBE_INT]);

    new title[32] = "Wardrobe";
    if (strlen(Wardrobe[i][E_WARDROBE_NAME]) && strcmp(Wardrobe[i][E_WARDROBE_NAME], "NULL"))
    { 
        format(title, 32, "%s", Wardrobe[i][E_WARDROBE_NAME]);
    }
    
    Wardrobe[i][E_WARDROBE_LABEL] = CreateDynamic3DTextLabel(sprintf("[%s]{DEDEDE}\nType {c4a656}/wardrobe {DEDEDE}to change clothes.", title), 0x3479E3FF, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2], WARDROBE_LABEL_RADIUS, .testlos = 1, .worldid = Wardrobe[i][E_WARDROBE_WORLD], .interiorid = Wardrobe[i][E_WARDROBE_INT]); 
    //printf("[wardrobe] Created Wardrobe with ID %d", Wardrobe[i][E_WARDROBE_ID]);
}

static DestroyWardrobe(i)
{
    printf("[wardrobe] Destroyed Wardrobe with ID %d", Wardrobe[i][E_WARDROBE_ID]);

    if (IsValidDynamicPickup(Wardrobe[i][E_WARDROBE_PICKUP])) 
        DestroyDynamicPickup(Wardrobe[i][E_WARDROBE_PICKUP]);

    if (IsValidDynamic3DTextLabel(Wardrobe[i][E_WARDROBE_LABEL])) 
        DestroyDynamic3DTextLabel(Wardrobe[i][E_WARDROBE_LABEL]);

    Wardrobe[i] = WardrobeClear;
    Wardrobe[i][E_WARDROBE_PICKUP] = -1;
    Wardrobe[i][E_WARDROBE_LABEL] = DynamicText3D: INVALID_3DTEXT_ID;
    Wardrobe[i][E_WARDROBE_USER] = INVALID_PLAYER_ID;
}

/*
static DestroyAllWardrobes()
{
    new count = 0;

    for (new i = 0; i < MAX_WARDROBES; i ++)
    {
        if (Wardrobe[i][E_WARDROBE_ID])
        {
            DestroyWardrobe(i);
            count ++;
        }
    }

    printf("[wardrobe] Destroyed %d Wardrobes", count);
}
*/

static AddWardrobe(playerid, E_WARDROBE_TYPE:type, owner)
{
    new Float:x, Float:y, Float:z, Float:a, int, world;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    int = GetPlayerInterior(playerid);
    world = GetPlayerVirtualWorld(playerid);

    a = a - 180.0;

    inline WardrobeAdded() 
	{
        new inserted_id = cache_insert_id();
        if (inserted_id)
        {
            if (IsWardrobeAdmin(playerid)) SendClientMessage(playerid, -1, sprintf("You created a new Wardrobe with ID %d at your position.", inserted_id));
            else SendServerMessage(playerid, COLOR_PROPERTY, "Wardrobe", "A3A3A3", "You've created a Wardrobe for the Property at your current position.");
            
            LoadWardrobe(inserted_id);
            printf("[wardrobe] Inserted new Wardrobe with ID %d", inserted_id);
        }
    }

    mysql_format(mysql, WardrobeQueryStr, sizeof(WardrobeQueryStr), "INSERT INTO `wardrobes` (`wardrobe_type`, `wardrobe_owner`, `wardrobe_pos_x`, `wardrobe_pos_y`, `wardrobe_pos_z`, `wardrobe_pos_a`, `wardrobe_world`, `wardrobe_int`) VALUES (%d, %d, %f, %f, %f, %f, %d, %d)", 
        _:type, owner, x, y, z, a, world, int);

    MySQL_TQueryInline(mysql, using inline WardrobeAdded, WardrobeQueryStr);
}

static DeleteWardrobe(playerid, i)
{
    new wardrobe_id = Wardrobe[i][E_WARDROBE_ID];

    inline OnDeleteWardrobe() 
	{
        new affected = cache_affected_rows();
        if (affected)
        {
            if (IsWardrobeAdmin(playerid)) SendClientMessage(playerid, -1, sprintf("You deleted the Wardrobe with ID %d.", wardrobe_id));
            else SendServerMessage(playerid, COLOR_PROPERTY, "Wardrobe", "A3A3A3", "You've deleted the Wardrobe for this Property.");
           
            DestroyWardrobe(i);
            printf("[wardrobe] Deleted the Wardrobe with ID %d", wardrobe_id);
        }
    }

    mysql_format(mysql, WardrobeQueryStr, sizeof ( WardrobeQueryStr ), "DELETE FROM `wardrobes` WHERE `wardrobe_id` = %d", wardrobe_id);
	MySQL_TQueryInline(mysql, using inline OnDeleteWardrobe, WardrobeQueryStr, "");
    print(WardrobeQueryStr);
}

static MoveWardrobe(playerid, i)
{
    new Float:x, Float:y, Float:z, Float:a, int, world;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    int = GetPlayerInterior(playerid);
    world = GetPlayerVirtualWorld(playerid);

    new wardrobe_id = Wardrobe[i][E_WARDROBE_ID];

    a = a - 180.0;

    inline WardrobeMoved() 
	{
        new affected = cache_affected_rows();
        if (affected)
        {
            if (IsWardrobeAdmin(playerid)) SendClientMessage(playerid, -1, sprintf("You moved the Wardrobe with ID %d to your position.", wardrobe_id));
            else SendServerMessage(playerid, COLOR_PROPERTY, "Wardrobe", "A3A3A3", "You've moved the Wardrobe for this Property to your current position.");
            
            LoadWardrobe(wardrobe_id, i);

            printf("[wardrobe] Moved Wardrobe %d to %f, %f, %f, %f (%d, %d)", wardrobe_id, x, y, z, a, int, world);
        }
    }

    mysql_format(mysql, WardrobeQueryStr, sizeof(WardrobeQueryStr), "UPDATE `wardrobes` SET `wardrobe_pos_x` = %f, `wardrobe_pos_y` = %f, `wardrobe_pos_z` = %f, `wardrobe_pos_a` = %f, `wardrobe_world` = %d, `wardrobe_int` = %d WHERE `wardrobe_id` = %d", x, y, z, a, world, int, wardrobe_id);
    MySQL_TQueryInline(mysql, using inline WardrobeMoved, WardrobeQueryStr, "");
    print(WardrobeQueryStr);
}

static RenameWardrobe(playerid, i)
{
    new wardrobe_id = Wardrobe[i][E_WARDROBE_ID];

    WardrobeDlgStr[0] = EOS;
    strcat(WardrobeDlgStr, "{FFFFFF}You are changing the display name of the Wardrobe.");
    strcat(WardrobeDlgStr, "\n{FFFFFF}Enter a new name below and press {AA3333}OK{FFFFFF} to continue.");

    inline DlgWardrobeRename(pid, dialogid, response, listitem, string: inputtext[]) 
    {
 		#pragma unused pid, dialogid, response, listitem, inputtext

        if (response)
        {
            if (strlen(inputtext) <= 3 || strlen (inputtext) > 28) 
            {
                return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "The name of the Wardrobe can't be less than 3 or more than 28 characters.");
            }

            if (!IsValidPropertyName(inputtext))
            {
                return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Keep it simple, your Wardrobe name can't contain special characters.");
            }

            format(Wardrobe[i][E_WARDROBE_NAME], 32, "%s", inputtext);

            inline WardrobeRenamed() 
            {
                new affected = cache_affected_rows();
                if (affected)
                {
                    if (IsWardrobeAdmin(playerid)) SendClientMessage(playerid, -1, sprintf("You set the name of Wardrobe %d to \"%s\".", wardrobe_id, Wardrobe[i][E_WARDROBE_NAME]));
                    else SendServerMessage(playerid, COLOR_PROPERTY, "Wardrobe", "A3A3A3", sprintf("You've changed the name of the Wardrobe to \"%s\".", Wardrobe[i][E_WARDROBE_NAME]));
                    
                    LoadWardrobe(wardrobe_id, i);

                    printf("[wardrobe] Renamed Wardrobe %d to \"%s\"", wardrobe_id, Wardrobe[i][E_WARDROBE_NAME]);
                }
            }

            mysql_format(mysql, WardrobeQueryStr, sizeof(WardrobeQueryStr), "UPDATE `wardrobes` SET `wardrobe_name` = '%e' WHERE `wardrobe_id` = %d", Wardrobe[i][E_WARDROBE_NAME], wardrobe_id);
            MySQL_TQueryInline(mysql, using inline WardrobeRenamed, WardrobeQueryStr, "");
        }

        return true;
    }

    Dialog_ShowCallback(playerid, using inline DlgWardrobeRename, DIALOG_STYLE_INPUT, "Rename Wardrobe", WardrobeDlgStr, "OK", "Back");
    return true;
}

static TeleportToWardrobe(playerid, i)
{
    new wardrobe_id = Wardrobe[i][E_WARDROBE_ID];
    SetPlayerInterior(playerid, Wardrobe[i][E_WARDROBE_INT]);
    SetPlayerVirtualWorld(playerid, Wardrobe[i][E_WARDROBE_WORLD]);
    PauseAC(playerid, 3);
    SetPlayerPos(playerid, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2]);
    SetPlayerFacingAngle(playerid, Wardrobe[i][E_WARDROBE_POS][3]);

    SendClientMessage(playerid, -1, sprintf("You teleported to Wardrobe %d.", wardrobe_id));
    return true;
}

static Player_EnterWardrobe(playerid, i)
{
	new count, name[64];
    new Float:x, Float:y, Float:z;
        
    ModelBrowser_ClearData(playerid);

    // Add custom player skins
    foreach(new idx: CustomSkins) {
        if(CustomSkin[idx][E_CUSTOM_SKIN_CHARACTERID] == Character[playerid][E_CHARACTER_ID] && CustomSkin[idx][E_CUSTOM_SKIN_ACTIVE]) {
            format(name, 64, "%d", CustomSkin[idx][E_CUSTOM_SKIN_ID]);
            ModelBrowser_AddData(playerid, CustomSkin[idx][E_CUSTOM_SKIN_ID], name);
            count ++;
        }
    }
  
    // Add purchased skins from shops
    inline GetOwnedSkins() 
	{
        new skinid;
        for (new j = 0, r = cache_num_rows(); j < r; ++j)
        {   
            cache_get_value_name_int(j, "player_wardrobe_skin_id", skinid);
            format(name, 64, "%03d", skinid);
			ModelBrowser_AddData(playerid, skinid, name);
            count ++;
        }

        if (!count)
        {
            return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any clothes to change into.");
        } 

        new title[32] = "Wardrobe";
        if (strlen(Wardrobe[i][E_WARDROBE_NAME]) && strcmp(Wardrobe[i][E_WARDROBE_NAME], "NULL"))
        { 
            format(title, 32, "%s", Wardrobe[i][E_WARDROBE_NAME]);
        }

        PauseAC(playerid, 3);
        SetPlayerPos(playerid, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2]);
        SetPlayerFacingAngle(playerid, Wardrobe[i][E_WARDROBE_POS][3] - 90.0);

        GetPointInFront3D(Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2], 0.0, Wardrobe[i][E_WARDROBE_POS][3], 1.75, x, y, z);

        SetPlayerCameraPos(playerid, x, y, z);
        SetPlayerCameraLookAt(playerid, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2], CAMERA_MOVE);

        Streamer_ToggleItem(playerid, STREAMER_TYPE_PICKUP, Wardrobe[i][E_WARDROBE_PICKUP], 0);
        Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, Wardrobe[i][E_WARDROBE_LABEL], 0);

        if (strlen(Wardrobe[i][E_WARDROBE_NAME]) && strcmp(Wardrobe[i][E_WARDROBE_NAME], "NULL"))
        {
            ShowZoneMessage(playerid, Wardrobe[i][E_WARDROBE_NAME], true);
        }
        else
        {
            ShowZoneMessage(playerid, "Wardrobe", true);
        }
        
        //native ApplyAnimation(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0);
        ApplyAnimation(playerid, "CLOTHES", "CLO_Pose_Loop", 2.0, 1, 0, 0, 0, 0, 1);

        PlayerVar[playerid][E_PLAYER_USING_WARDROBE] = true;
        PlayerVar[playerid][E_PLAYER_CURRENT_WARDROBE] = i;

        ModelBrowser_SetupTiles(playerid, sprintf("%s (%d/%d)", title, count, WARDROBE_CAPACITY), "wardrobe_list");
    }

    mysql_format(mysql, WardrobeQueryStr, sizeof(WardrobeQueryStr), "SELECT * FROM `player_wardrobes` WHERE `player_wardrobe_char_id` = %d ORDER BY `player_wardrobe_skin_lastused` DESC LIMIT %d", Character[playerid][E_CHARACTER_ID], WARDROBE_CAPACITY - count);
    MySQL_TQueryInline(mysql, using inline GetOwnedSkins, WardrobeQueryStr, "");

    return 1;
}

static Player_ExitWardrobe(playerid, bool:nicely=false, bool:anim=false)
{
    new i = PlayerVar[playerid][E_PLAYER_CURRENT_WARDROBE];

    if (i != -1)
    {
        Streamer_ToggleItem(playerid, STREAMER_TYPE_PICKUP, Wardrobe[i][E_WARDROBE_PICKUP], 1);
        Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, Wardrobe[i][E_WARDROBE_LABEL], 1);

        if (nicely)
        {
            PauseAC(playerid, 3);
            SetPlayerFacingAngle(playerid, Wardrobe[i][E_WARDROBE_POS][2]);
            SetPlayerPos(playerid, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2]);
        }

        if (anim)
        {
            ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 0, 0, 0, 0, 1);
        }
    }
    
    SetCameraBehindPlayer(playerid);
    if (!anim) ClearAnimations(playerid);

    PlayerVar[playerid][E_PLAYER_USING_WARDROBE] = false;
    PlayerVar[playerid][E_PLAYER_CURRENT_WARDROBE] = -1;

    return 1;
}

// ----------------------------------------------------------------------------------------------------------------------------------------

hook OnPlayerUpdate(playerid)
{
    if (PlayerVar[playerid][E_PLAYER_USING_WARDROBE])
    {
        new i = PlayerVar[playerid][E_PLAYER_CURRENT_WARDROBE];
        if (!IsPlayerInRangeOfPoint(playerid, 3.0, Wardrobe[i][E_WARDROBE_POS][0], Wardrobe[i][E_WARDROBE_POS][1], Wardrobe[i][E_WARDROBE_POS][2]))
        {
            Player_ExitWardrobe(playerid);
        }
    }

    return 1;
}

hook OnStartSQL()
{
    LoadAllWardrobes();
    return 1;
}

mBrowser:wardrobe_list(playerid, response, row, model, name[]) 
{
    new i = PlayerVar[playerid][E_PLAYER_CURRENT_WARDROBE];
    if (i == -1 || !PlayerVar[playerid][E_PLAYER_USING_WARDROBE] || !response)
    {
        Player_ExitWardrobe(playerid);
        return true;
    } 

	if (response) 
	{
        // Set the chosen skin
        SetPlayerSkin(playerid, model);
        if (Wardrobe[i][E_WARDROBE_TYPE_ID] != WARDROBE_TYPE_TEMP)
        {
            // Save the chosen skin
            SetPlayerSkinEx(playerid, model);
        }

        ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 0, 0, 0, 0, 1);
        //SendClientMessage(playerid, COLOR_BLUE, sprintf("You've changed into Skin ID %d.", model));
        ShowPlayerFooter(playerid, sprintf("You've changed into ~y~Skin %d~w~.", model), 3000);
        Player_ExitWardrobe(playerid, false, true);
	}
    
	return true ;
}

// ----------------------------------------------------------------------------------------------------------------------------------------

CMD:wardrobe(playerid)
{
    new i = GetClosestWardrobeToPlayer(playerid);
    if (i == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not at a Wardrobe.");

    if (PlayerVar[playerid][E_PLAYER_USING_WARDROBE])
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're already using a wardrobe.");
    }

    foreach (new targetid: Player) 
	{
        if (IsPlayerPlaying(targetid) && PlayerVar[targetid][E_PLAYER_USING_WARDROBE] && PlayerVar[playerid][E_PLAYER_CURRENT_WARDROBE] == i)
        {
            return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Someone else is using this wardrobe just now.");
        }
	}

    // TODO: Access Checks, etc.
    Player_EnterWardrobe(playerid, i);
    return true;
}


// ----------------------------------------------------------------------------------------------------------------------------------------

CMD:checkwardrobe(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_id, enum_id;
    sscanf(params, "D(0)", wardrobe_id);

    if (wardrobe_id) enum_id = GetWardrobeEnumId(wardrobe_id);
    else enum_id = GetClosestWardrobeToPlayer(playerid);

    if (!wardrobe_id && enum_id == -1) return SendClientMessage(playerid, -1, "/checkwardrobe [wardrobe id]");
    if (enum_id == -1) return SendClientMessage(playerid, -1, "Invalid Wardrobe ID");

    wardrobe_id = Wardrobe[enum_id][E_WARDROBE_ID];

    format(WardrobeQueryStr, sizeof(WardrobeQueryStr), "%s\t%d", "ID", wardrobe_id);
    format(WardrobeQueryStr, sizeof(WardrobeQueryStr), "%s\n%s\t%s", WardrobeQueryStr, "Type", WardrobeType[Wardrobe[enum_id][E_WARDROBE_TYPE_ID]][E_WARDROBE_TYPE_NAME]);
    format(WardrobeQueryStr, sizeof(WardrobeQueryStr), "%s\n%s\t%d", WardrobeQueryStr, "Owner", Wardrobe[enum_id][E_WARDROBE_OWNER]);

    inline DlgWardrobeCheck(pid, dialogid, response, listitem, string: inputtext[]) 
    {
 		#pragma unused pid, dialogid, response, listitem, inputtext
        return true;
    }

    Dialog_ShowCallback(playerid, using inline DlgWardrobeCheck, DIALOG_STYLE_TABLIST, sprintf("Wardrobe %d", wardrobe_id), WardrobeQueryStr, "OK");
    return true;
}

CMD:wardrobecheck(playerid, params[]) return cmd_checkwardrobe(playerid, params);


CMD:gotowardrobe(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_id, enum_id;
    if (sscanf(params, "d", wardrobe_id))
    {
        return SendClientMessage(playerid, -1, "/gotowardrobe [wardrobe id]");
    }

    enum_id = GetWardrobeEnumId(wardrobe_id);
    if (enum_id == -1) return SendClientMessage(playerid, -1, "Invalid Wardrobe ID");

    TeleportToWardrobe(playerid, enum_id);
    return true;
}

CMD:wardrobegoto(playerid, params[]) return cmd_gotowardrobe(playerid, params);

CMD:movewardrobe(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_id, enum_id;
    if (sscanf(params, "d", wardrobe_id))
    {
        return SendClientMessage(playerid, -1, "/movewardrobe [wardrobe id]");
    }

    enum_id = GetWardrobeEnumId(wardrobe_id);
    if (enum_id == -1) return SendClientMessage(playerid, -1, "Invalid Wardrobe ID");

    MoveWardrobe(playerid, enum_id);
    return true;
}

CMD:wardrobemove(playerid, params[]) return cmd_movewardrobe(playerid, params);

CMD:wardrobetype(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_type = -1, enum_id;
    sscanf(params, "d", wardrobe_type);

    new wardrobe_id = GetClosestWardrobeToPlayer(playerid);
    if (wardrobe_id == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not at a Wardrobe.");
    
    if (wardrobe_type < 0 || E_WARDROBE_TYPE:wardrobe_type > E_WARDROBE_TYPE)
    {
        SendClientMessage(playerid, -1, "Wardrobe Types:");

        for (new i = 0; E_WARDROBE_TYPE:i < E_WARDROBE_TYPE; i ++)
        {
            SendClientMessage(playerid, -1, sprintf("%d | %s (%s)", i, WardrobeType[E_WARDROBE_TYPE:i][E_WARDROBE_TYPE_NAME], WardrobeType[E_WARDROBE_TYPE:i][E_WARDROBE_TYPE_DESC]));
        }

        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/wardrobetype [wardrobe type]");
    }

    if (WardrobeType[E_WARDROBE_TYPE:wardrobe_type][E_WARDROBE_TYPE_DISABLED])
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This wardrobe type is disabled (not scripted yet).");  
    }

    wardrobe_id = Wardrobe[enum_id][E_WARDROBE_ID];
    Wardrobe[enum_id][E_WARDROBE_TYPE_ID] = E_WARDROBE_TYPE:wardrobe_type;

    inline WardrobeChanged() 
	{
        new affected = cache_affected_rows();
        if (affected)
        {
            SendClientMessage(playerid, -1, sprintf("You set the type of Wardrobe ID %d to %d.", wardrobe_id, wardrobe_type));
            //DestroyWardrobe(enum_id);

            printf("[wardrobe] Updated the type of Wardrobe with ID %d to %d", wardrobe_id, wardrobe_type);
        }
    }

    mysql_format(mysql, WardrobeQueryStr, sizeof(WardrobeQueryStr), "UPDATE `wardrobes` SET `wardrobe_type` = %d WHERE `wardrobe_id` = %d", wardrobe_id, wardrobe_type);
    MySQL_TQueryInline(mysql, using inline WardrobeChanged, WardrobeQueryStr, "");
    print(WardrobeQueryStr);

    return true;
}

CMD:wardrobeowner(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_owner = -1, enum_id;
    sscanf(params, "d", wardrobe_owner);

    new i = GetClosestWardrobeToPlayer(playerid);
    if (i == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not at a Wardrobe.");

    if (wardrobe_owner < 0) return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/wardrobeowner [Owner SQL ID]");
    
    new wardrobe_id = Wardrobe[enum_id][E_WARDROBE_ID];
    Wardrobe[enum_id][E_WARDROBE_OWNER] = wardrobe_owner;

    inline WardrobeChanged() 
	{
        new affected = cache_affected_rows();
        if (affected)
        {
            SendClientMessage(playerid, -1, sprintf("You set the owner of Wardrobe ID %d to %d.", wardrobe_id, wardrobe_owner));
            //DestroyWardrobe(enum_id);

            printf("[wardrobe] Updated the owner of Wardrobe with ID %d to %d", wardrobe_id, wardrobe_owner);
        }
    }

    mysql_format(mysql, WardrobeQueryStr, sizeof(WardrobeQueryStr), "UPDATE `wardrobes` SET `wardrobe_owner` = %d WHERE `wardrobe_id` = %d", wardrobe_id, wardrobe_owner);
    MySQL_TQueryInline(mysql, using inline WardrobeChanged, WardrobeQueryStr, "");
    print(WardrobeQueryStr);

    return true;
}

CMD:addwardrobe(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_type = -1, wardrobe_owner;
    sscanf(params, "dD(0)", wardrobe_type, wardrobe_owner);

    if (wardrobe_type < 0 || E_WARDROBE_TYPE:wardrobe_type > E_WARDROBE_TYPE)
    {
        SendClientMessage(playerid, -1, "Wardrobe Types:");

        for (new i = 0; E_WARDROBE_TYPE:i < E_WARDROBE_TYPE; i ++)
        {
            SendClientMessage(playerid, -1, sprintf("%d | %s (%s)", i, WardrobeType[E_WARDROBE_TYPE:i][E_WARDROBE_TYPE_NAME], WardrobeType[E_WARDROBE_TYPE:i][E_WARDROBE_TYPE_DESC]));
        }

        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/addwardrobe [wardrobe type]");
    }

    if (WardrobeType[E_WARDROBE_TYPE:wardrobe_type][E_WARDROBE_TYPE_DISABLED])
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This wardrobe type is disabled (not scripted yet).");  
    }

    if (!wardrobe_owner && (E_WARDROBE_TYPE:wardrobe_type == WARDROBE_TYPE_PROPERTY || E_WARDROBE_TYPE:wardrobe_type == WARDROBE_TYPE_FACTION)) return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/addwardrobe [wardrobe type] [owner id] (SQL ID of the faction or property)");
    else if (wardrobe_owner < 0) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid Owner ID.");  

    AddWardrobe(playerid, E_WARDROBE_TYPE:wardrobe_type, wardrobe_owner);
    return true;
}

CMD:wardrobeadd(playerid, params[]) return cmd_addwardrobe(playerid, params);
CMD:wardrobecreate(playerid, params[]) return cmd_addwardrobe(playerid, params);
CMD:createwardrobe(playerid, params[]) return cmd_addwardrobe(playerid, params);

CMD:deletewardrobe(playerid, params[])
{
    if (!IsWardrobeAdmin(playerid))
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

    new wardrobe_id, enum_id;
    sscanf(params, "D(0)", wardrobe_id);

    if (wardrobe_id) enum_id = GetWardrobeEnumId(wardrobe_id);
    else enum_id = GetClosestWardrobeToPlayer(playerid);

    if (!wardrobe_id && enum_id == -1) return SendClientMessage(playerid, -1, "/deletewardrobe [wardrobe id]");
    if (enum_id == -1) return SendClientMessage(playerid, -1, "Invalid Wardrobe ID");

    DeleteWardrobe(playerid, enum_id);
    return true;
}

CMD:wardrobedel(playerid, params[]) return cmd_deletewardrobe(playerid, params);
CMD:wardrobedelete(playerid, params[]) return cmd_deletewardrobe(playerid, params);
CMD:wardrobedestroy(playerid, params[]) return cmd_deletewardrobe(playerid, params);

// ---------------------------------------------------------------------------------------------------------------------

static Property_CreateWardrobe(playerid, prop_enum_id)
{
    // Firstly check there's not already a wardrobe
    new wardrobe = GetPropertyWardrobe(Property[prop_enum_id][E_PROPERTY_ID]);
    if (wardrobe != -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This property already has a wardrobe created.");

    // If there isn't, then make one
    WardrobeDlgStr[0] = EOS;
    strcat(WardrobeDlgStr, "{FFFFFF}You are about to create a Wardrobe in your Property.");
    strcat(WardrobeDlgStr, sprintf("\n{ADBEE6}Wardrobes have a capacity of %d clothes and allow you to change between them.", WARDROBE_CAPACITY));

    strcat(WardrobeDlgStr, "\n\n{FFFFFF}Purchasing a Wardrobe will:");
    strcat(WardrobeDlgStr, "\n{ADBEE6}- Let you access any and all custom donated skins on your Character.");
    strcat(WardrobeDlgStr, sprintf("\n{ADBEE6}- Let you access up to %d other skins purchased from clothes shops.", WARDROBE_CAPACITY));
    strcat(WardrobeDlgStr, "\n{ADBEE6}- Allow any guests to your Property to change their own clothes.");
    strcat(WardrobeDlgStr, sprintf("\n{ADBEE6}- Cost you a one-time fee of $%s to setup.", IntegerWithDelimiter(WARDROBE_COST)));

    strcat(WardrobeDlgStr, sprintf("\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to buy a Wardrobe for {AA3333}$%s{FFFFFF}.", IntegerWithDelimiter(WARDROBE_COST)));
    strcat(WardrobeDlgStr, "\n{ADBEE6}You may have to purchase some clothes again before they appear in the Wardrobe.");

    inline DlgWardrobeCreate(pid, dialogid, response, listitem, string: inputtext[]) 
    {
 		#pragma unused pid, dialogid, response, listitem, inputtext

        if (response)
        {
            if (GetPlayerCash(playerid) < WARDROBE_COST)
            {
                return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have enough money.");
            }

            TakePlayerCash(playerid, WARDROBE_COST);
            AddWardrobe(playerid, WARDROBE_TYPE_PROPERTY, Property[prop_enum_id][E_PROPERTY_ID]);
        }

        return true;
    }

    Dialog_ShowCallback(playerid, using inline DlgWardrobeCreate, DIALOG_STYLE_MSGBOX, "Do you want to purchase a Wardrobe?", WardrobeDlgStr, "OK", "Back");
    return true;
}

static Property_DeleteWardrobe(playerid, prop_enum_id)
{
    // Firstly check that there is already a wardrobe
    new wardrobe = GetPropertyWardrobe(Property[prop_enum_id][E_PROPERTY_ID]);
    if (wardrobe == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This property does not have a wardrobe to delete.");

    // And if there is, delete it.
    DeleteWardrobe(playerid, wardrobe);
    return true;
}

static Property_MoveWardrobe(playerid, prop_enum_id)
{
    // Firstly check that there is already a wardrobe
    new wardrobe = GetPropertyWardrobe(Property[prop_enum_id][E_PROPERTY_ID]);
    if (wardrobe == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This property does not have a wardrobe to move.");

    // And if there is, move it.
    MoveWardrobe(playerid, wardrobe);
    return true;
}

static Property_RenameWardrobe(playerid, prop_enum_id)
{
    // Firstly check that there is already a wardrobe
    new wardrobe = GetPropertyWardrobe(Property[prop_enum_id][E_PROPERTY_ID]);
    if (wardrobe == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This property does not have a wardrobe to move.");

    // And if there is, rename it.
    RenameWardrobe(playerid, wardrobe);
    return true;
}

CMD:propertywardrobe(playerid, params[])
{
    new prop_enum_id = Property_GetInside(playerid);
    if (prop_enum_id == INVALID_PROPERTY_ID) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not inside a property.");

    if (!IsWardrobeAdmin(playerid))
    {
        if (!SOLS_IsPropertyOwner(playerid, prop_enum_id))
        {
            return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Only the property owner can do this.");
        }
    }

    new option[16];
    sscanf(params, "s[16]", option);

    if (strlen(option))
    {
        if (!strcmp(option, "create", true))
        {
            // Create new
            return Property_CreateWardrobe(playerid, prop_enum_id);
        }
        else if (!strcmp(option, "delete", true))
        {
            // Delete existing
            return Property_DeleteWardrobe(playerid, prop_enum_id);
        }
        else if (!strcmp(option, "move", true))
        {
            // Move existing
            return Property_MoveWardrobe(playerid, prop_enum_id);
        }
        else if (!strcmp(option, "rename", true))
        {
            // Rename existing
            return Property_RenameWardrobe(playerid, prop_enum_id);
        }
    }

    return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertywardrobe [create | delete | move | rename ]");
}

CMD:propwardrobe(playerid, params[]) return cmd_propertywardrobe(playerid, params);