
enum E_WEAPON_ATTACH_DATA
{
    Float:Position[6],
    Bone,
    Hidden
}
new WeaponSettings[MAX_PLAYERS][17][E_WEAPON_ATTACH_DATA], WeaponTick[MAX_PLAYERS], EditingWeapon[MAX_PLAYERS];
 
GetWeaponObjectSlot(weaponid)
{
    new objectslot;
 

    switch (weaponid) {

        case 25..29: objectslot = ATTACH_SLOT_GUNS ;
        case 30, 31, 33, 34: objectslot = E_ATTACH_INDEX_MINIGAME;
    }
    return objectslot;
}
 
GetWeaponModel(weaponid) //Will only return the model of wearable weapons (22-38)
{
    new model;
   
    switch(weaponid)
    {
        case 25..29: model = 324 + weaponid;
        case 30: model = 355;
        case 31: model = 356;
        case 32: model = 372;
        case 33, 34: model = 324 + weaponid;
    }
    return model;
}
 
PlayerHasWeapon(playerid, weaponid)
{
    new weapon, ammo;
 
    for (new i; i < 13; i++)
    {
        GetPlayerWeaponData(playerid, i, weapon, ammo);
        if (weapon == weaponid && ammo) return 1;
    }
    return 0;
}
 
IsWeaponWearable(weaponid) {
    return (weaponid >= 22 && weaponid <= 38);
}
 

forward OnWeaponsLoaded(playerid);
public OnWeaponsLoaded(playerid)
{
    new rows, fields, weaponid, index ;
    cache_get_data ( rows, fields, mysql ) ;

    if ( rows ) {
        for (new i; i < rows; i++)
        {

            weaponid = cache_get_field_int(i, "WeaponID" );
            index = weaponid - 22;
           
            WeaponSettings[playerid][index][Position][0] = cache_get_field_float (i, "PosX" );
            WeaponSettings[playerid][index][Position][1] = cache_get_field_float (i, "PosY" );
            WeaponSettings[playerid][index][Position][2] = cache_get_field_float (i, "PosZ" );
           
            WeaponSettings[playerid][index][Position][3] = cache_get_field_float (i, "RotX" );
            WeaponSettings[playerid][index][Position][4] = cache_get_field_float (i, "RotY" );
            WeaponSettings[playerid][index][Position][5] = cache_get_field_float (i, "RotZ" );
           
            WeaponSettings[playerid][index][Bone] = cache_get_field_int(i, "Bone" );
            WeaponSettings[playerid][index][Hidden] = cache_get_field_int(i, "Hidden" );
        }
    }
}
public OnPlayerUpdate(playerid)
{

    if (NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
    {
        new weaponid, ammo, objectslot, count, index;
 
        for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
        {
            GetPlayerWeaponData(playerid, i, weaponid, ammo);
            index = weaponid - 22;
           
            if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
            {
                objectslot = GetWeaponObjectSlot(weaponid);
 
                if (GetPlayerWeapon(playerid) != weaponid)
                    SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
 
                else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
            }
        }
        for (new i; i <= 5; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
        {
            count = 0;
 
            for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
                count++;
 
            if (!count) RemovePlayerAttachedObject(playerid, i);
        }
        WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
    }

    
    #if defined visgun_OnPlayerUpdate
        return visgun_OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate visgun_OnPlayerUpdate
#if defined visgun_OnPlayerUpdate
    forward visgun_OnPlayerUpdate(playerid);
#endif


Init_LoadPlayerGunAttachments(playerid) {
    new string[96] ;
    for (new i; i < 17; i++)
    {
        WeaponSettings[playerid][i][Position][0] = -0.116;
        WeaponSettings[playerid][i][Position][1] = 0.189;
        WeaponSettings[playerid][i][Position][2] = 0.088;
        WeaponSettings[playerid][i][Position][3] = 0.0;
        WeaponSettings[playerid][i][Position][4] = 44.5;
        WeaponSettings[playerid][i][Position][5] = 0.0;
        WeaponSettings[playerid][i][Bone] = 1;
        WeaponSettings[playerid][i][Hidden] = false;
    }
    WeaponTick[playerid] = 0;
    EditingWeapon[playerid] = 0;
   
    mysql_format(mysql, string, sizeof(string), "SELECT * FROM player_weapons_attach WHERE CharID = '%e'", Character [ playerid ] [ E_CHARACTER_ID]);
    mysql_tquery(mysql, string, "OnWeaponsLoaded", "d", playerid);
}
 
public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    new weaponid = EditingWeapon[playerid];
 
    if (weaponid)
    {
        if (response)
        {
            new enum_index = weaponid - 22, weaponname[18], name[MAX_PLAYER_NAME], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
            GetPlayerName(playerid, name, MAX_PLAYER_NAME);
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            format(string, sizeof(string), "You have successfully adjusted the position of your %s.", weaponname);
            SendServerMessage ( playerid, COLOR_GD, "Weapon Attach", "A3A3A3", string ) ;

            mysql_format(mysql, string, sizeof(string), "INSERT INTO player_weapons_attach (CharID, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES (%d, %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", Character [ playerid ] [ E_CHARACTER_ID ], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(mysql, string);
        }
        EditingWeapon[playerid] = 0;
    }

    #if defined visgun_OnPlayerEditAttachdObj
        return visgun_OnPlayerEditAttachdObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerEditAttachedObject
    #undef OnPlayerEditAttachedObject
#else
    #define _ALS_OnPlayerEditAttachedObject
#endif

#define OnPlayerEditAttachedObject visgun_OnPlayerEditAttachdObj
#if defined visgun_OnPlayerEditAttachdObj
    forward visgun_OnPlayerEditAttachdObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
#endif
 
CMD:gunattach(playerid, params[]) {

    new weaponid = GetPlayerWeapon(playerid);

    if (!weaponid) {
        return SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3", "You are not holding a weapon.");
    }

    if (!IsWeaponWearable(weaponid)){
        return SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3","This weapon cannot be edited.");
    }

    if (isnull(params)){
        return SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3"," /gunattach [adjust/bone]");
    }

    if (!strcmp(params, "adjust", true))
    {
        if (EditingWeapon[playerid])
            return SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3", "You are already editing a weapon.");

        if (WeaponSettings[playerid][weaponid - 22][Hidden])
            return SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3", "You cannot adjust a hidden weapon.");

        new index = weaponid - 22;
           
        SetPlayerArmedWeapon(playerid, 0);
       
        SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
        EditAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
       
        EditingWeapon[playerid] = weaponid;
    }
    else if (!strcmp(params, "bone", true))
    {
        if (EditingWeapon[playerid]) {
            return SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3", "You are already editing a weapon.");
        }

        inline VISGUN_CHANGE_BONE(pid, dialogid, response, listitem, string:inputtext[]) {
            #pragma unused pid, response, dialogid, listitem, inputtext
            if (response)
            {
                new gunid = EditingWeapon[playerid], weaponname[18], name[MAX_PLAYER_NAME], string[150];
     
                GetWeaponName(gunid, weaponname, sizeof(weaponname));
                GetPlayerName(playerid, name, MAX_PLAYER_NAME);
               
                WeaponSettings[playerid][gunid - 22][Bone] = listitem + 1;
     
                format(string, sizeof(string), "You have successfully changed the bone of your %s.", weaponname);       
                SendServerMessage ( playerid, COLOR_GD, "Weapon Attach", "A3A3A3", string ) ;
               
                mysql_format(mysql, string, sizeof(string), "INSERT INTO player_weapons_attach (CharID, WeaponID, Bone) VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE Bone = VALUES(Bone)", Character [ playerid ] [ E_CHARACTER_ID ], weaponid, listitem + 1);
                mysql_tquery(mysql, string);
            }
            EditingWeapon[playerid] = 0;
            return 1;
        }

        Dialog_ShowCallback ( playerid, using inline VISGUN_CHANGE_BONE, DIALOG_STYLE_TABLIST_HEADERS,"Bone", "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft shoulder\nRight shoulder\nNeck\nJaw", "Choose", "Cancel");

        EditingWeapon[playerid] = weaponid;
    }
    else SendServerMessage ( playerid, COLOR_ERROR, "Weapon Attach", "A3A3A3", "You have specified an invalid option.");
    return 1;
}