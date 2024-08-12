static enum E_ARMORY
{
	E_ARMORY_INDEX,
	E_ARMORY_FAC_TYPE,
	E_ARMORY_NAME[64],
	E_ARMORY_DESC[128],
	Float:E_ARMORY_X,
	Float:E_ARMORY_Y,
	Float:E_ARMORY_Z,
	E_ARMORY_INT,
	E_ARMORY_VW,
	bool:E_ARMORY_HIDDEN
}

#define MAX_ARMORY_WEAPONS 9

static enum
{
	ARMORY_LSPD,
	ARMORY_LSFD,
	ARMORY_SAN,
	ARMORY_SWAT,
	ARMORY_GOV
}

static const Armory[][E_ARMORY] = 
{
	{ ARMORY_LSPD, FACTION_TYPE_POLICE, "Police Locker Room", "{8D8DFF}/duty{DEDEDE}, {8D8DFF}/kevlar{DEDEDE}, {8D8DFF}/armory{DEDEDE}, {8D8DFF}/uniform", -4.3010,-100.2063,898.5717, 6, -1 }, // LSPD
	{ ARMORY_SWAT, FACTION_TYPE_POLICE, "Equipment Area", "{8D8DFF}/kevlar{DEDEDE}, {8D8DFF}/armory{DEDEDE}, {8D8DFF}/uniform", -5.3671,-106.2414,898.5717, 6, -1, false }
};

static enum E_ARMORY_WEAPON
{
	E_ARMORY_WEAPON_FAC_TYPE,
	E_ARMORY_WEAPON_ID,
	E_ARMORY_WEAPON_AMMO,
	E_ARMORY_WEAPON_TIER,
	E_ARMORY_WEAPON_SQUAD,
	bool:E_ARMORY_WEAPON_OFF_DUTY,
	E_ARMORY_WEAPON_ARMORY_INDEX
}

static const ArmoryWeapon[][E_ARMORY_WEAPON] = 
{
	{FACTION_TYPE_POLICE, CUSTOM_POLICE_GLOCK, 42, 3, 0, true},		// PD Deagle
	{FACTION_TYPE_POLICE, CUSTOM_NITESTICK, 1, 4},				// PD Baton
	{FACTION_TYPE_POLICE, CUSTOM_SPRAYCAN, 15000, 4},		// PD Spray
	{FACTION_TYPE_POLICE, CUSTOM_SHOTGUN, 25, 3},			// PD Shotgun
	{FACTION_TYPE_POLICE, CUSTOM_CAMERA, 100, 4},			// PD Camera
	{FACTION_TYPE_POLICE, CUSTOM_COMBAT_SHOTGUN, 25, 3, FACTION_SQUAD_SWAT, false, ARMORY_SWAT},			// PD SWAT Shotgun
	{FACTION_TYPE_POLICE, CUSTOM_MP5, 120, 3, FACTION_SQUAD_SWAT, false, ARMORY_SWAT},			// PD SWAT MP5
	{FACTION_TYPE_POLICE, CUSTOM_M4A1, 200, 3, FACTION_SQUAD_SWAT, false, ARMORY_SWAT},			// PD SWAT M4
	{FACTION_TYPE_POLICE, CUSTOM_SNIPER_RIFLE, 50, 3, FACTION_SQUAD_SWAT, false, ARMORY_SWAT},			// PD SWAT Sniper

	{FACTION_TYPE_EMS, CUSTOM_SPRAYCAN, 15000, 3},			// Spraycan
	{FACTION_TYPE_EMS, CUSTOM_FIRE_EXTINGUISHER, 2000, 3},			// Fire Extinguisher
	{FACTION_TYPE_EMS, CUSTOM_SHOVEL, 1, 3},				// Shovel
	{FACTION_TYPE_EMS, CUSTOM_CHAINSAW, 1, 1},				// Chainsaw

	{FACTION_TYPE_NEWS, CUSTOM_CAMERA, 100, 4},			// Camera

	{FACTION_TYPE_GOV, CUSTOM_POLICE_GLOCK, 42, 3, FACTION_SQUAD_GOV_DAO, true},		// PD Deagle
	{FACTION_TYPE_GOV, CUSTOM_SPRAYCAN, 15000, 3},								// Spray
	{FACTION_TYPE_GOV, CUSTOM_SHOVEL, 1, 4, FACTION_SQUAD_GOV_PW},				// Shovel
	{FACTION_TYPE_GOV, CUSTOM_FIRE_EXTINGUISHER, 2000, 4, FACTION_SQUAD_GOV_PW},			// Fire Extinguisher
	{FACTION_TYPE_GOV, CUSTOM_CAMERA, 100, 4}									// Camera
};



Armory_LoadEntities () 
{
	new str[256];

	for (new i = 0; i < sizeof(Armory); i ++)
	{
		if (Armory[i][E_ARMORY_HIDDEN]) continue;
		
		format(str, sizeof(str), "[%s]", Armory[i][E_ARMORY_NAME]);
		
		if (strlen(Armory[i][E_ARMORY_DESC]))
		{
			strcat(str, "\n");
			strcat(str, Armory[i][E_ARMORY_DESC]);
		} 

		CreateDynamic3DTextLabel(str, 0x3479E3FF, Armory[i][E_ARMORY_X], Armory[i][E_ARMORY_Y], Armory[i][E_ARMORY_Z], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, Armory[i][E_ARMORY_VW], Armory[i][E_ARMORY_INT]); 
		CreateDynamicPickup(1275, 1, Armory[i][E_ARMORY_X], Armory[i][E_ARMORY_Y], Armory[i][E_ARMORY_Z], Armory[i][E_ARMORY_VW], Armory[i][E_ARMORY_INT]);
		printf(" * [ARMORY] (%d) %s loaded.", i, Armory[i][E_ARMORY_NAME]);
	}

	CreateDynamicObject(2063, 206.931, 1924.296, 17.550, 0.000, 0.000, 180.0); // Kate_Mercer (2063) // A51
	CreateDynamicObject(14782, 364.268, 192.923, 1008.372, 0.000, 0.000, 90.0); // Kate_Mercer (14782) // Gov
}

IsAtKisok(playerid)
{ 
	new vw = GetPlayerVirtualWorld(playerid);
	new int = GetPlayerInterior(playerid);

	for (new i = 0; i < sizeof(Armory); i ++)
	{	
		if (IsPlayerInRangeOfPoint(playerid, 5.0, Armory[i][E_ARMORY_X], Armory[i][E_ARMORY_Y], Armory[i][E_ARMORY_Z]))
		{
			if (Armory[i][E_ARMORY_INT] != -1 && int != Armory[i][E_ARMORY_INT]) return -1;
			if (Armory[i][E_ARMORY_VW] != -1 && vw != Armory[i][E_ARMORY_VW]) return -1;

			return i;
		}
	}

	return -1;
}

static ArmoryDlgStr[512];

CMD:gotoarmory(playerid)
{
	if (!GetPlayerAdminLevel(playerid)) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not authorized to do this.");
	new str[128], map[20], count;

	inline Kiosk_Selection(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, response, dialogid, listitem, inputtext

		if ( response ) 
		{
			new chosen = map[listitem];

			if (Armory[chosen][E_ARMORY_INT] != -1) SetPlayerInterior(playerid, Armory[chosen][E_ARMORY_INT]);
			if (Armory[chosen][E_ARMORY_VW] != -1) SetPlayerVirtualWorld(playerid, Armory[chosen][E_ARMORY_VW]);
			SOLS_SetPosWithFade(playerid, Armory[chosen][E_ARMORY_X], Armory[chosen][E_ARMORY_Y], Armory[chosen][E_ARMORY_Z]);

			format(str, sizeof(str), "[ADMIN] %s (%d) has teleported to the %s.", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, Armory[chosen][E_ARMORY_NAME]);
			SendAdminMessage(str);

			AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Teleported to the %s kiosk", Armory[chosen][E_ARMORY_NAME]));
		}
	}

	ArmoryDlgStr[0] = EOS;
	for (new i = 0; i < sizeof(Armory); i ++)
	{
		if (Armory[i][E_ARMORY_HIDDEN]) continue;
		format(ArmoryDlgStr, sizeof(ArmoryDlgStr), "%s%s\n", ArmoryDlgStr, Armory[i][E_ARMORY_NAME]);

		map[count] = i;
		count ++;
	}

	Dialog_ShowCallback(playerid, using inline Kiosk_Selection, DIALOG_STYLE_LIST, "Kiosk Teleport", ArmoryDlgStr, "Select", "Close");
	return true;
}

CMD:armory(playerid) 
{
	new f = GetPlayerFactionType(playerid);
	if (f == -1) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction.");

	new k = IsAtKisok(playerid);
	if (k == -1) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near any faction kiosk.");
	else if (Armory[k][E_ARMORY_FAC_TYPE] != f) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't use this kiosk.");

	if (GetPlayerFactionSuspension(playerid))
	{
		new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ];
		if (factionid)
		{
			new faction_enum_id = Faction_GetEnumID(factionid); 
			Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s tried to use the armory while suspended. }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName(playerid)), faction_enum_id, false );
			SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't access this because you're currently suspended from the faction.");
		}

		return true;
	}

	new gun_name[32];
	new count, map[MAX_ARMORY_WEAPONS];

	inline Armory_Selection(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, response, dialogid, listitem, inputtext

		if ( response ) 
		{
			new index = map[listitem];

			if (ArmoryWeapon[index][E_ARMORY_WEAPON_TIER] && (Character[playerid][E_CHARACTER_FACTIONTIER] > ArmoryWeapon[index][E_ARMORY_WEAPON_TIER]))
			{
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not a high enough tier of employee to take this.");
			}

			if (ArmoryWeapon[index][E_ARMORY_WEAPON_SQUAD] && 
				(Character[playerid][E_CHARACTER_FACTION_SQUAD] != ArmoryWeapon[index][E_ARMORY_WEAPON_SQUAD] &&
				Character[playerid][E_CHARACTER_FACTION_SQUAD2] != ArmoryWeapon[index][E_ARMORY_WEAPON_SQUAD] &&
				Character[playerid][E_CHARACTER_FACTION_SQUAD3] != ArmoryWeapon[index][E_ARMORY_WEAPON_SQUAD])
			)
			{
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in the necessary faction squad or division to take this.");
			}

			if (!ArmoryWeapon[index][E_ARMORY_WEAPON_OFF_DUTY] && !PlayerVar[playerid][E_PLAYER_FACTION_DUTY])
			{
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be on duty to take this.");
			}

			if (ArmoryWeapon[index][E_ARMORY_WEAPON_ARMORY_INDEX] && ArmoryWeapon[index][E_ARMORY_WEAPON_ARMORY_INDEX] != Armory[k][E_ARMORY_INDEX])
			{
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You are not at the correct armory for this.");
			}

			Weapon_GetGunName ( ArmoryWeapon[index][E_ARMORY_WEAPON_ID], gun_name, sizeof(gun_name) ) ;				
			GiveCustomWeapon ( playerid, ArmoryWeapon[index][E_ARMORY_WEAPON_ID], ArmoryWeapon[index][E_ARMORY_WEAPON_AMMO] ); 

			new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
			new faction_enum_id = Faction_GetEnumID(factionid ); 

			Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has taken a %s from the armory. }",
				Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName (playerid), gun_name), faction_enum_id, false ) ;

		}
	}

	format(ArmoryDlgStr, sizeof(ArmoryDlgStr), "Weapon\tTier Limit") ;
	for (new i = 0; i < sizeof(ArmoryWeapon); i ++)
	{
		if (ArmoryWeapon[i][E_ARMORY_WEAPON_FAC_TYPE] != f) continue;
		if (ArmoryWeapon[i][E_ARMORY_WEAPON_ARMORY_INDEX] && ArmoryWeapon[i][E_ARMORY_WEAPON_ARMORY_INDEX] != Armory[k][E_ARMORY_INDEX]) continue;

		Weapon_GetGunName(ArmoryWeapon[i][E_ARMORY_WEAPON_ID], gun_name, sizeof(gun_name));
		format(ArmoryDlgStr, sizeof(ArmoryDlgStr), "%s\n%s\tTier %d", ArmoryDlgStr, gun_name, ArmoryWeapon[i][E_ARMORY_WEAPON_TIER]);

		map[count] = i;
		count ++;
	}

	Dialog_ShowCallback(playerid, using inline Armory_Selection, DIALOG_STYLE_TABLIST_HEADERS, Armory[k][E_ARMORY_NAME], ArmoryDlgStr, "Take", "Close");
	return true ;
}

CMD:duty(playerid) 
{
	if (!IsPlayerInDutyFaction(playerid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction that can go on or off duty.");
	}

	new vehicleid = INVALID_VEHICLE_ID;

	if (!IsPlayerNearArmory(playerid))
	{
		if (PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ])
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only go off duty at a faction armory.");
		}

		vehicleid = GetClosestVehicleEx(playerid, 7.5);

		if (vehicleid == INVALID_VEHICLE_ID || !IsFactionVehicle(vehicleid, Character[playerid][E_CHARACTER_FACTIONID]))
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not at a faction armory or vehicle.");
		}
	}

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID(factionid ); 
	new string [ 144 ] ;
	new suspension = GetPlayerFactionSuspension(playerid);
	new f = GetPlayerFactionType(playerid);

	if ( PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ]  ) 
	{
		// Go off duty
		PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ] = false ;

		if ( GetCharacterArmour ( playerid ) != 0 ) {

			SetCharacterArmour ( playerid, 0 );
		}

		if (IsPlayerInPoliceFaction(playerid))
		{
			// DEA/Police get EVERYTHING taken (as they can take an off duty handgun and might have other guns)
			Weapon_ResetPlayerWeapons(playerid);
		}
		else
		{
			// Other factions only get armory weapons taken
			for (new i = 0; i < sizeof(ArmoryWeapon); i ++)
			{
				if (ArmoryWeapon[i][E_ARMORY_WEAPON_FAC_TYPE] != f) continue;
				RemovePlayerCustomWeapon(playerid, ArmoryWeapon[i][E_ARMORY_WEAPON_ID]);
			}
		}

		// Also make sure any tazer is removed
		if (PlayerVar[playerid][E_PLAYER_TASER_EQUIPPED])
		{
			RemovePlayerCustomWeapon(playerid, 65);
			PlayerVar[playerid][E_PLAYER_TASER_EQUIPPED] = false;
		}		

		format ( string, sizeof ( string ), "has gone off duty" ) ;
	}
	else if ( ! PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ]  ) 
	{ 
		// Go on duty
		if (suspension && factionid && faction_enum_id)
		{
			Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s tried to go on duty while suspended. }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName(playerid)), faction_enum_id, false );
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't do this because you're currently suspended from the faction.");
		}

		PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ] = true ;

		if (vehicleid != INVALID_VEHICLE_ID)
		{	
			format ( string, sizeof ( string ), "has gone on duty at a \"%s\" (%d)", ReturnVehicleName(vehicleid), vehicleid ) ;
		}
		else
		{
			format ( string, sizeof ( string ), "has gone on duty" ) ;
		}
		
	}

	CallLocalFunction("SOLS_OnDutyStateChange", "d", playerid);

	SetCharacterHealth ( playerid, 100 );
	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s %s. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid), string
	), faction_enum_id, false ) ;

	return true ;
}

CMD:kevlar(playerid, params[]) 
{
    if (!IsPlayerInPoliceFaction(playerid, true) 
		&& !IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_DAO, FACTION_TYPE_GOV, true)
	)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a faction that has kevlar.");
	}

	if (!IsPlayerNearArmory(playerid)) 
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not at the locker room.");

	if (Character[playerid][E_CHARACTER_FACTIONTIER] > 3)
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not a high enough tier of employee to do this.");
	
	SetCharacterHealth(playerid, 100);
	SetCharacterArmour(playerid, 100);

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID(factionid ); 

	Faction_SendMessage(Character [ playerid ] [ E_CHARACTER_FACTIONID ], sprintf("{ [%s] %s has taken kevlar from the armory. }",

	Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName(playerid)), faction_enum_id, false ) ;

	return true ;
}

IsPlayerNearArmory(playerid) 
{
	new f = GetPlayerFactionType(playerid);
	if (f == -1) return false;

	new k = IsAtKisok(playerid);
	if (k == -1) return false;

	return (Armory[k][E_ARMORY_FAC_TYPE] == f);
}


forward SOLS_OnDutyStateChange(playerid);
public SOLS_OnDutyStateChange(playerid)
{
	// Hook this
	printf("SOLS_OnDutyStateChange: %d", playerid);
	return 1;
}


CMD:kev(playerid, params[]) {

	return cmd_kevlar(playerid, params);
}

stock Armory_GetGunPrice(weapon) {
	new gun_cost ;

	switch ( weapon ) {
		case 1 .. 8: 	gun_cost = 25 ;
		case 9:	 		gun_cost = 50 ;
		case 10 .. 15: 	gun_cost = 20 ;
		case 16 .. 18: 	gun_cost = 125 ;
		case 22 .. 23: 	gun_cost = 150 ;
		case 24: 		gun_cost = 250 ;
		case 25: 		gun_cost = 300 ;
		case 26: 		gun_cost = 325 ;
		case 27: 		gun_cost = 350 ;
		case 28: 		gun_cost = 250 ;
		case 29:		gun_cost = 275 ;
		case 30: 		gun_cost = 500 ;
		case 31: 		gun_cost = 750 ;
		case 32: 		gun_cost = 225 ;
		case 33: 		gun_cost = 800 ;
		case 34: 		gun_cost = 1000 ;
		default: {
			gun_cost = 25 ;
		}
	}

	return gun_cost ;
}