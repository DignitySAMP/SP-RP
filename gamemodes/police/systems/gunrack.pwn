#define MAX_GUNRACK_VEHICLES 400
#define MAX_GUNRACK_WEAPONS 8

static enum E_GUNRACK_WEAPON_DATA
{
    E_GUNRACK_FAC_TYPE,
    E_GUNRACK_WEAPON,
    E_GUNRACK_AMMO,
    E_GUNRACK_TIER,
    bool:E_GUNRACK_SWAT,
    bool:E_GUNRACK_NOTFY,
}

static const GUNRACK_SLOT_NAMES[MAX_GUNRACK_WEAPONS][16] = 
{
    "Shotgun",
    "SMG",
    // "Rifle",
    "SWAT SMG",
    "SWAT SG",
    "SWAT AR",
    "SWAT AR",

    "Equipment",
    "Equipment"
};
static GUNRACK_WEAPONS[MAX_GUNRACK_WEAPONS][E_GUNRACK_WEAPON_DATA] = 
{
    { FACTION_TYPE_POLICE, CUSTOM_SHOTGUN, 25, 3, false, true }, // shotgun
    { FACTION_TYPE_POLICE, CUSTOM_MP5, 60, 2, false, true }, // mp5
    // { 40, 100, 1, false, true }, // m4
    { FACTION_TYPE_POLICE, CUSTOM_MP5, 120, 3, true, true }, // mp5
    { FACTION_TYPE_POLICE, CUSTOM_COMBAT_SHOTGUN, 35, 3, true, true }, // combat shotgun
    { FACTION_TYPE_POLICE, CUSTOM_M4A1, 200, 3, true, true }, // m4
    { FACTION_TYPE_POLICE, CUSTOM_M4A1, 200, 3, true, true }, // m4

    { FACTION_TYPE_EMS, CUSTOM_FIRE_EXTINGUISHER, 2000, 3, false, true }, // Fire ext
    { FACTION_TYPE_EMS, CUSTOM_CHAINSAW, 1, 1, false, true } // Chainsaw
};


static VehicleGunrack[MAX_GUNRACK_VEHICLES][MAX_GUNRACK_WEAPONS];

static IsInGunrackVehicle(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);

    if (IsPlayerInPoliceFaction(playerid, true) && IsGunrackVehicle(vehicleid))
    {
        return vehicleid;
    }

    return 0;
}

static IsGunrackVehicle(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    return (model == 407 && IsFactionTypeVehicle(vehicleid, FACTION_TYPE_EMS)) || ((model == 596 || model == 426 || model == 490 || model == 599 || model == 598 || model == 597) && IsFactionTypeVehicle(vehicleid, FACTION_TYPE_POLICE));
}

Gunrack_Reset(vehicleid)
{
    if (IsGunrackVehicle(vehicleid))
    {
        for (new i = 0; i < MAX_GUNRACK_WEAPONS; i ++)
        {
            VehicleGunrack[vehicleid][i] = GUNRACK_WEAPONS[i][E_GUNRACK_AMMO];
        }
    }

    return true;
}

static GunrackDlgStr[512];
static GunrackStr[144];

static ShowPoliceGunrack(playerid, vehicleid, bool:swat=false)
{
    format(GunrackDlgStr, sizeof(GunrackDlgStr), "Slot\tWeapon\tAmmo\n");
    new gun_name[64];
    new slots[MAX_GUNRACK_WEAPONS];
    new index = 0;
    new ftype = GetVehicleFactionType(vehicleid);

    for (new i = 0; i < MAX_GUNRACK_WEAPONS; i ++)
    {
        if ((swat && !GUNRACK_WEAPONS[i][E_GUNRACK_SWAT]) || (!swat && GUNRACK_WEAPONS[i][E_GUNRACK_SWAT])) continue;
        else if (GUNRACK_WEAPONS[i][E_GUNRACK_FAC_TYPE] != ftype) continue;

        if (VehicleGunrack[vehicleid][i])
        {
            new weapon = GUNRACK_WEAPONS[i][E_GUNRACK_WEAPON];
            Weapon_GetGunName ( weapon, gun_name, sizeof(gun_name ) ) ;
            format(GunrackDlgStr, sizeof(GunrackDlgStr), "%s%s\t%s\t%d\n", GunrackDlgStr, GUNRACK_SLOT_NAMES[i], gun_name, VehicleGunrack[vehicleid][i]);
        }
        else
        {
            format(GunrackDlgStr, sizeof(GunrackDlgStr), "%s%s\t%s\t%d\n", GunrackDlgStr, GUNRACK_SLOT_NAMES[i], "Empty", 0);
        }

        slots[index] = i;
        index ++;
    }

    if (!index)
    {
        return false;
    }

    inline GunrackListDlg(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem
      
        if (response && vehicleid && IsGunrackVehicle(vehicleid) && (IsPlayerInPoliceFaction(pid, true) || IsPlayerInMedicFaction(pid, true)))
        {
            new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
            new faction_enum_id = Faction_GetEnumID(factionid ); 
            new slot = slots[listitem];
            new weapon_idx = GUNRACK_WEAPONS[slot][E_GUNRACK_WEAPON];
            
            if (VehicleGunrack[vehicleid][slot])
            {
                // take

                if (GUNRACK_WEAPONS[slot][E_GUNRACK_TIER] < Character [playerid][E_CHARACTER_FACTIONTIER])
                {
                    SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to take this." );
                }
                else if (GUNRACK_WEAPONS[slot][E_GUNRACK_SWAT] && !PlayerVar[playerid][E_PLAYER_SWAT_ACTIVE])
                {
                    SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must turn out into your SWAT gear first." );
                }
                else
                {
                    new ammo = VehicleGunrack[vehicleid][slot];
                    Weapon_GetGunName ( weapon_idx, gun_name, sizeof  (gun_name ) ) ;
                    
                    GiveCustomWeapon ( playerid, weapon_idx, ammo ); 
                    VehicleGunrack[vehicleid][slot] = 0;

                    if (slot == 1 && GetPlayerVehicleSeat(playerid) == 0)
                    {
                        SetPlayerArmedWeapon(playerid, 0); // disallow smg driveby as driver
                    }

                    if (GUNRACK_WEAPONS[slot][E_GUNRACK_SWAT]) format(GunrackStr, sizeof(GunrackStr), "(%d) %s has taken a %s from the trunk of a %s (%d)", playerid, ReturnMixedName(playerid), gun_name, ReturnVehicleName(vehicleid), vehicleid);
                    else if (GetVehicleModel(vehicleid) == 407) format(GunrackStr, sizeof(GunrackStr), "(%d) %s has taken a %s from a %s (%d)", playerid, ReturnMixedName(playerid), gun_name, ReturnVehicleName(vehicleid), vehicleid);
                    else format(GunrackStr, sizeof(GunrackStr), "(%d) %s has taken a %s from the gunrack of a %s (%d)", playerid, ReturnMixedName(playerid), gun_name, ReturnVehicleName(vehicleid), vehicleid);

                    // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
				    AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Took a %s from the /gunrack of vehicle %d", gun_name, vehicleid));

                    if (GUNRACK_WEAPONS[slot][E_GUNRACK_NOTFY])
                    { 
                        format(GunrackStr, sizeof(GunrackStr), "{ [%s] %s }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], GunrackStr);
                        Faction_SendMessage(factionid, GunrackStr, faction_enum_id, false );
                    }

                    if (GUNRACK_WEAPONS[slot][E_GUNRACK_SWAT]) ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("equips a %s from the trunk of the %s.", gun_name, ReturnVehicleName(vehicleid)), .showid = false);
                    else if (GetVehicleModel(vehicleid) == 407) ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("takes a %s from the %s.", gun_name, ReturnVehicleName(vehicleid)), .showid = false);
                    else ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("equips a %s from the gunrack of the %s.", gun_name, ReturnVehicleName(vehicleid)), .showid = false);
                }
            }
            else
            {
                // put back
                new gunid, ammo, idx, put = 0;

                for( new i, j = 12 ; i < j ; i ++ ) 
                {
                    idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;
                    GetPlayerWeaponData(playerid, i, gunid, ammo ) ;

                    if ( idx != 0 && idx == weapon_idx && ammo > 0)
                    {
                        Weapon_GetGunName ( weapon_idx, gun_name, sizeof  (gun_name ) ) ;
                        RemovePlayerCustomWeapon(playerid, idx);
                        SetPlayerArmedWeapon(playerid, 0);

                        if (IsPlayerInAnyVehicle(playerid))
                        {
                            PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] = idx; // stop anti cheat moaning
                        }

                        if (GUNRACK_WEAPONS[slot][E_GUNRACK_SWAT]) format(GunrackStr, sizeof(GunrackStr), "(%d) %s has put back a %s into the trunk of a %s (%d)", playerid, ReturnMixedName(playerid), gun_name, ReturnVehicleName(vehicleid), vehicleid);
                        else if (GetVehicleModel(vehicleid) == 407) format(GunrackStr, sizeof(GunrackStr), "(%d) %s has put back a %s into a %s (%d)", playerid, ReturnMixedName(playerid), gun_name, ReturnVehicleName(vehicleid), vehicleid);
                        else format(GunrackStr, sizeof(GunrackStr), "(%d) %s has put back a %s into the gunrack of a %s (%d)", playerid, ReturnMixedName(playerid), gun_name, ReturnVehicleName(vehicleid), vehicleid);

                        // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
				        AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Put back a %s to the /gunrack of vehicle %d", gun_name, vehicleid));

                        if (GUNRACK_WEAPONS[slot][E_GUNRACK_NOTFY])
                        { 
                            format(GunrackStr, sizeof(GunrackStr), "{ [%s] %s }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], GunrackStr);
                            Faction_SendMessage(factionid, GunrackStr, faction_enum_id, false );
                        }

                        VehicleGunrack[vehicleid][slot] = ammo;
                        put = 1;

                        if (GUNRACK_WEAPONS[slot][E_GUNRACK_SWAT]) ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("puts back a %s into the trunk of the %s.", gun_name, ReturnVehicleName(vehicleid)), .showid = false);
                        else if (GetVehicleModel(vehicleid) == 407) ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("puts back a %s into the %s.", gun_name, ReturnVehicleName(vehicleid)), .showid = false);
                        else ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("puts back a %s into the gunrack of the %s.", gun_name, ReturnVehicleName(vehicleid)), .showid = false);

                        break;
                    }
	            } 

                if (put == 0)
                {
                    SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a weapon to put back in this slot." );
                }              
            }
        }
    }

    Dialog_ShowCallback ( playerid, using inline GunrackListDlg, DIALOG_STYLE_TABLIST_HEADERS, ReturnVehicleName(vehicleid), GunrackDlgStr, "Get/Put", "Back" );
    return true;
}

CMD:gunrack(playerid)
{
    new vehicleid = IsInGunrackVehicle(playerid);
    if (!vehicleid) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty or in a vehicle with a gunrack." ) ;
    ShowPoliceGunrack(playerid, vehicleid);
    return true;
}

mBrowser:swat_turnout(playerid, response, row, model, name[]) {

	if ( response ) 
	{
        new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
        new faction_enum_id = Faction_GetEnumID(factionid); 

        // Set the chosen skin but DONT save it
		SetPlayerSkin(playerid, model);
        ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "turns out into their SWAT gear.", false, true);
        PlayerVar[playerid][E_PLAYER_SWAT_ACTIVE] = true;

        new vehicleid = PlayerVar[playerid][E_PLAYER_SWAT_VEHICLE];
        format(GunrackStr, sizeof(GunrackStr), "(%d) %s has turned out into SWAT at a %s (%d)", playerid, ReturnMixedName(playerid), ReturnVehicleName(vehicleid), vehicleid);
        format(GunrackStr, sizeof(GunrackStr), "{ [%s] %s }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], GunrackStr);
        Faction_SendMessage(factionid, GunrackStr, faction_enum_id, false );

        // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
        AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Activated SWAT Mode at Vehicle ID %d", vehicleid));
    }

	return true ;
}

SWATActivate(playerid, vehicleid)
{
    new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
    new faction_enum_id = Faction_GetEnumID(factionid); 

    if (PlayerVar[playerid][E_PLAYER_SWAT_ACTIVE])
    {
        PlayerVar[playerid][E_PLAYER_SWAT_ACTIVE] = false;

        format(GunrackStr, sizeof(GunrackStr), "(%d) %s has turned back in from SWAT at a %s (%d)", playerid, ReturnMixedName(playerid), ReturnVehicleName(vehicleid), vehicleid);
        format(GunrackStr, sizeof(GunrackStr), "{ [%s] %s }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], GunrackStr);
        Faction_SendMessage(factionid, GunrackStr, faction_enum_id, false );

        ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "turns back in from their SWAT gear.", false, true);

        // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
        AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Deactivated SWAT Mode at Vehicle ID %d", vehicleid));
        SOLS_SetPlayerSkin(playerid); // Set their old skin back

        // Take SWAT Weapons and Replenish the gunrack
        new gunid, gunslot, ammo, idx, weapon_idx, gun_name[64];

        for (new slot = 0; slot < MAX_GUNRACK_WEAPONS; slot ++)
        {
            if (!GUNRACK_WEAPONS[slot][E_GUNRACK_SWAT]) continue;

            weapon_idx = GUNRACK_WEAPONS[slot][E_GUNRACK_WEAPON];
            gunslot = GetCustomWeaponSlot(weapon_idx);

            idx = PlayerVar[playerid][E_PLAYER_WEAPON_EQUIPPED][gunslot];
            GetPlayerWeaponData(playerid, gunslot, gunid, ammo);

            if (idx != 0 && idx == weapon_idx && ammo > 0)
            {
                PlayerVar[playerid][E_PLAYER_WEAPON_EQUIPPED][gunslot] = 0;
                VehicleGunrack[vehicleid][slot] = ammo;

                Weapon_GetGunName ( weapon_idx, gun_name, sizeof  (gun_name ) ) ;
                SendClientMessage(playerid, COLOR_POLICE, sprintf("Your %s with %d ammo was automatically put back into the %s.", gun_name, ammo, ReturnVehicleName(vehicleid)));
            }
        }

        Anticheat_SaveApprovedGuns(playerid);
        ResetPlayerWeapons(playerid);
        Anticheat_RefundApprovedGuns(playerid);
        SetPlayerArmedWeapon(playerid, 0); 
    }
    else
    {
        PlayerVar[playerid][E_PLAYER_SWAT_VEHICLE] = vehicleid;
        ShowFactionSkinList(playerid, "SWAT Turnout", "swat_turnout", FACTION_SQUAD_SWAT);
    }
}

CMD:swat(playerid)
{
    if (IsPlayerIncapacitated(playerid, false))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

    /*
    if (IsPlayerInSheriffFaction(playerid))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This feature is only available to the LSPD currently." );
    }
    */

    if (!IsPlayerInPoliceFaction(playerid))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You are not in a police faction." );
    }

    if (IsPlayerInPoliceFaction(playerid) && !PlayerVar[playerid][E_PLAYER_FACTION_DUTY])
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You are not on-duty." );
    }

    if (!IsPlayerInFactionSquad(playerid, FACTION_SQUAD_SWAT) && Character[playerid][E_CHARACTER_FACTIONTIER] > 1)
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to use this." );
    }

    if (IsPlayerInAnyVehicle(playerid))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't do this while in a car, get out first." );
    }

    new vehicleid = INVALID_VEHICLE_ID;
    vehicleid = GetClosestVehicleEx(playerid, 7.5);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

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

    inline SwatTrunkDlg(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem

        if (response)
        {
            if (listitem == 0)
            {
                // Active/Deactivate
                SWATActivate(playerid, vehicleid);
            }
            else if (listitem == 1)
            {
                // Weapons
                ShowPoliceGunrack(playerid, vehicleid, true);
            }
            else if (listitem == 2)
            {
                // Equipment
                SendClientMessage(playerid, -1, "Coming soon, maybe...");
            }
        }
    }

    if (!PlayerVar[playerid][E_PLAYER_SWAT_ACTIVE])
    {
        Dialog_ShowCallback ( playerid, using inline SwatTrunkDlg, DIALOG_STYLE_LIST, "Special Weapons & Tactics", "{C8E6C9}Activate\nWeapons\nEquipment", "Select", "Close" );
    }
    else
    {
        Dialog_ShowCallback ( playerid, using inline SwatTrunkDlg, DIALOG_STYLE_LIST, "Special Weapons & Tactics", "{FFCDD2}Deactivate\nWeapons\nEquipment", "Select", "Close" );
    }
    
    return true;
}


mBrowser:fire_turnout(playerid, response, row, model, name[]) {

	if ( response ) 
	{
        //new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
        //new faction_enum_id = Faction_GetEnumID(factionid); 
        new vehicleid = PlayerVar[playerid][E_PLAYER_SWAT_VEHICLE];

        // Set the chosen skin but DONT save it
		SetPlayerSkin(playerid, model);
        ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", sprintf("changes their uniform at the %s.", ReturnVehicleName(vehicleid)), false, true);
        
        //format(GunrackStr, sizeof(GunrackStr), "(%d) %s has turned out into SWAT at a %s (%d)", playerid, ReturnPlayerNameData(playerid, 0, true), ReturnVehicleName(vehicleid), vehicleid);
        //format(GunrackStr, sizeof(GunrackStr), "{ [%s] %s }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], GunrackStr);
        // Faction_SendMessage(factionid, GunrackStr, faction_enum_id, false );

        // NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
        //AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Activated SWAT Mode at Vehicle ID %d", vehicleid));
    }

	return true ;
}

CMD:firetruck(playerid)
{
    if (IsPlayerIncapacitated(playerid, false))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

    if (!IsPlayerInMedicFaction(playerid, true))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You are not on duty as a firefighter." );
    }

    if (IsPlayerInAnyVehicle(playerid))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't do this while in the vehicle, get out first." );
    }

    new vehicleid = INVALID_VEHICLE_ID;
    vehicleid = GetClosestVehicleEx(playerid, 7.5);

	if ( vehicleid == INVALID_VEHICLE_ID || !IsFactionVehicle(vehicleid, Character[playerid][E_CHARACTER_FACTIONID]) || GetVehicleModel(vehicleid) != 407) 
    {
		return SendClientMessage(playerid, COLOR_ERROR, "You're not near a fire truck!");
	}

    inline FireTrunkDlg(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem

        if (response)
        {
            if (listitem == 0)
            {
                // Change Uniform
                PlayerVar[playerid][E_PLAYER_SWAT_VEHICLE] = vehicleid;
                ShowFactionSkinList(playerid, "Fire Truck Uniforms", "fire_turnout", 0);
            }
            else if (listitem == 1)
            {
                // Weapons
                ShowPoliceGunrack(playerid, vehicleid);
            }
        }
    }

    Dialog_ShowCallback(playerid, using inline FireTrunkDlg, DIALOG_STYLE_LIST, "Fire Truck", "Uniforms\nEquipment", "Select", "Close");
    return true;
}