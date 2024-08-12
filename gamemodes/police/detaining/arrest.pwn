static enum E_HELPDESK_DATA
{
	E_HELPDESK_FACTION,
	E_HELPDESK_FACTYPE,
	E_HELPDESK_ICON,
	E_HELPDESK_NAME[64],
	E_HELPDESK_DESC[128],
	Float:E_HELPDESK_X,
	Float:E_HELPDESK_Y,
	Float:E_HELPDESK_Z,
	E_HELPDESK_INT,
	E_HELPDESK_VW,
	E_HELPDESK_LAST_CALLED
}

static const FacHelpDesk[][E_HELPDESK_DATA] = 
{
	{ 10, -1, 1247, "City Hall", "{8D8DFF}/namechange{DEDEDE}, {8D8DFF}/payfine", 1481.0245,-1766.3807,18.7958, 0, 0},
	{ 10, -1, 1247, "Police Front Desk", "{8D8DFF}/payfine{DEDEDE}, {8D8DFF}/prisoners", -11.4663, -87.5607, 898.5717, 6, -1 } // LSPD
};

Fine_LoadLabel()
{
	new str[256];

	for (new i = 0; i < sizeof(FacHelpDesk); i ++)
	{
		format(str, sizeof(str), "[%s]", FacHelpDesk[i][E_HELPDESK_NAME]);
		if (strlen(FacHelpDesk[i][E_HELPDESK_DESC]))
		{
			strcat(str, "\n");
			strcat(str, FacHelpDesk[i][E_HELPDESK_DESC]);
		} 
		strcat(str, "\n{DEDEDE}Please {3479E3}/ringbell {DEDEDE}for attention.");

		CreateDynamic3DTextLabel(str, 0x3479E3FF, FacHelpDesk[i][E_HELPDESK_X], FacHelpDesk[i][E_HELPDESK_Y], FacHelpDesk[i][E_HELPDESK_Z], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, FacHelpDesk[i][E_HELPDESK_VW], FacHelpDesk[i][E_HELPDESK_INT]); 
		CreateDynamicPickup(FacHelpDesk[i][E_HELPDESK_ICON], 1, FacHelpDesk[i][E_HELPDESK_X], FacHelpDesk[i][E_HELPDESK_Y], FacHelpDesk[i][E_HELPDESK_Z], FacHelpDesk[i][E_HELPDESK_VW], FacHelpDesk[i][E_HELPDESK_INT]);
		printf(" * [HELPDESK] (%d) %s loaded.", i, FacHelpDesk[i][E_HELPDESK_NAME]);
	}
}

IsAtFrontDesk(playerid)
{ 
	for (new i = 0; i < sizeof(FacHelpDesk); i ++)
	{	
		if (IsPlayerInRangeOfPoint(playerid, 5.0, FacHelpDesk[i][E_HELPDESK_X], FacHelpDesk[i][E_HELPDESK_Y], FacHelpDesk[i][E_HELPDESK_Z]))
		{
			return i;
		}
	}

	return -1;
}

IsAtCopFrontDesk(playerid)
{
	new desk = IsAtFrontDesk(playerid);
	return desk == 1;
}

IsAtGovFrontDesk(playerid)
{

	new desk = IsAtFrontDesk(playerid);
	return desk == 0;
}

CMD:ringbell(playerid)
{
	new desk = IsAtFrontDesk(playerid);
	if (desk == -1) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only do this at a faction helpdesk.");

	new facid = FacHelpDesk[desk][E_HELPDESK_FACTION];
	new factype = FacHelpDesk[desk][E_HELPDESK_FACTYPE];

	if (FacHelpDesk[desk][E_HELPDESK_LAST_CALLED] && gettime() - FacHelpDesk[desk][E_HELPDESK_LAST_CALLED] < 900)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This reception bell has already been rung recently, try again later." ) ;
	}

	new str[144];
	format(str, sizeof(str), "[%s]: (%d) %s has rung the bell to request help.", FacHelpDesk[desk][E_HELPDESK_NAME], playerid, ReturnMixedName(playerid));
	FacHelpDesk[desk][E_HELPDESK_LAST_CALLED] = gettime();

	foreach(new policeid: Player) 
	{
		if ( Character [ policeid ] [ E_CHARACTER_FACTIONID ] ) 
		{
			new faction_enum_id = Faction_GetEnumID(Character [ policeid ] [ E_CHARACTER_FACTIONID ] ); 

			if ( faction_enum_id != INVALID_FACTION_ID ) 
			{
				if ( Faction [ faction_enum_id ] [ E_FACTION_ID ] == facid || Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == factype )
				{
					SendClientMessage(policeid, COLOR_FACTION, str);
				}
			}
		}
	}

	PlayerPlaySoundEx(playerid, 17802); // Play bell to nearby players from this player's position
	ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", sprintf("rings the %s bell.", FacHelpDesk[desk][E_HELPDESK_NAME]), .annonated=true);
	return true;
}

CMD:prisoners(playerid, params[]) 
{
	if ( !IsAtCopFrontDesk(playerid) && !IsPlayerInPoliceFaction(playerid, true) && GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) 
	{
		return SendServerMessage ( playerid, COLOR_BLUE, "Error", "A3A3A3", "You can only view the list of prisoners at the front desk of a police station." ) ;
	}

	new string [ 128 ] ;

	SendClientMessage(playerid, COLOR_BLUE, "List of prisoners:");

	foreach(new targetid: Player) {

		if ( Character [ targetid ] [ E_CHARACTER_ARREST_TIME ] ) {
			format ( string, sizeof ( string ), "(%d) %s in  for %d seconds.", targetid, ReturnSettingsName ( targetid, playerid ), Character [ targetid ] [ E_CHARACTER_ARREST_TIME ] ) ;
			SendClientMessage(playerid, 0xDEDEDEFF, string);
		}
	}

	return true ;
}

CMD:jailtime(playerid)
{
	if (Character[playerid][E_CHARACTER_ARREST_TIME])
	{
		// New, shows jail time only when they do the command
		GameTextForPlayer(playerid, sprintf("~w~~n~~n~~n~~n~~n~~n~Jail Time: ~r~%d seconds", Character[playerid][E_CHARACTER_ARREST_TIME]), 3000, 3 );
	}
	
	return 1;
}


CMD:arrest(playerid, params[] ) {
   
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	new targetid, time ;
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	if ( sscanf ( params, "k<player>i", targetid, time ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/arrest [targetid] [time (in minutes)]" ) ;
		return true ;
	}

	if (!IsPlayerConnected(targetid)) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your target isn't connected." ) ;
	if (!IsPlayerNearPlayer(playerid, targetid, 10.0))  return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near this player." ) ;
		
	if (!PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] || GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL)
	{
		if (!IsPlayerInPoliceFaction(playerid, true))
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
		}

		if (Character[playerid][E_CHARACTER_FACTIONTIER] > 3)
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not a high enough tier of employee to do this.");
		}

		if ( time < 10 ) return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "You can't arrest someone for less than 10 minutes." ) ;
		else if ( time > 180 ) return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "You can't arrest someone for more than 3 hours (180 minutes)." ) ;

		if ( targetid == playerid ) 
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't arrest yourself." ) ;
		}
	}

	new Float: x, Float: y, Float: z ; 
	GetPlayerPos ( targetid, x, y, z ) ;

	Character [ targetid ] [ E_CHARACTER_ARREST_TIME ] = time * 60 ;

	Character [ targetid ] [ E_CHARACTER_ARREST_X ] = x ;
	Character [ targetid ] [ E_CHARACTER_ARREST_Y ] = y ;
	Character [ targetid ] [ E_CHARACTER_ARREST_Z ] = z ;

	Character [ targetid ] [ E_CHARACTER_ARREST_VW ] = GetPlayerVirtualWorld(targetid) ;
	Character [ targetid ] [ E_CHARACTER_ARREST_INT ] = GetPlayerInterior(targetid) ;

	Weapon_ResetPlayerWeapons(targetid);
	SendServerMessage(targetid, COLOR_FACTION, "Arrest", "A3A3A3", sprintf("You have been imprisoned for %d minutes by %s %s (%d).", time, Character[playerid][E_CHARACTER_FACTIONRANK], ReturnRPName(playerid), playerid));
	//SendClientMessage(targetid, 0xA3A3A3FF, "Your weapons have been confiscated.");
	
	Weapon_SavePlayerWeapons(targetid);

	new query [ 1024 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_arrest_x = '%f', player_arrest_y = '%f', player_arrest_z = '%f',\
		player_arrest_vw = %d, player_arrest_int = %d, player_arrest_time = %d  WHERE player_id = %d",

		Character [ targetid ] [ E_CHARACTER_ARREST_X ], Character [ targetid ] [ E_CHARACTER_ARREST_Y ], 
		Character [ targetid ] [ E_CHARACTER_ARREST_Z ], Character [ targetid ] [ E_CHARACTER_ARREST_VW ], 
		Character [ targetid ] [ E_CHARACTER_ARREST_INT ], Character [ targetid ] [ E_CHARACTER_ARREST_TIME ],
		 Character [ targetid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);

	// Do the auto ticket revokation

	new days = 259200; // 3 days to seconds // if you change this, change it in crimes/searchdata too
	mysql_format(mysql, query, sizeof(query), "UPDATE `criminalfines` SET `fine_status` = 2, `fine_revoker` = 'The System' WHERE `fine_status` = 0 AND `fine_player_name` LIKE '%e' AND DATE_ADD(`fine_date`, INTERVAL %d second) < CURRENT_TIMESTAMP", Character[targetid][E_CHARACTER_NAME], days);

	inline Ticket_OnAutoRevoke() 
	{
		new affected = cache_affected_rows();
		if (affected)
		{
			SendClientMessage(targetid, 0xA3A3A3FF, sprintf("The %d ticket(s) that you failed to pay in time were automatically revoked.", affected));
			SendClientMessage(playerid, 0xA3A3A3FF, sprintf("The %d ticket(s) that they failed to pay in time were automatically revoked.", affected));
		} 
	}

	MySQL_TQueryInline(mysql, using inline Ticket_OnAutoRevoke, query, "");

	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has arrested (%d) %s for %d minutes (%d seconds). }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], 
		playerid, ReturnMixedName ( playerid ), 
		targetid, ReturnMixedName ( targetid ), 
		time, time * 60
	), faction_enum_id, false ) ;

	for( new i, j = sizeof ( Faction ); i < j ; i ++ ) {

		if ( Faction [ i ] [ E_FACTION_TYPE ] == 0 ) {

			Faction_AddBankMoney(i, 2500 ) ;
		}

		else continue ;
	}

	SendClientMessage(targetid, 0xA3A3A3FF, "Type \"/jailtime\" to see how long you have left in jail.");
	//SendClientMessage ( playerid, COLOR_YELLOW, "Don't forget to /setarrestpos to update their cell spawn location!");

	return true ;
}

CMD:setarrestpos(playerid, params[] ) {
    
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>i", targetid ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setarrestpos [targetid]" ) ;
		return true ;
	}


	if ( targetid == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't arrest yourself." ) ;
	}

	if ( ! IsPlayerConnected(targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your target isn't connected." ) ;
	}

	new Float: x, Float: y, Float: z ; 
	GetPlayerPos ( targetid, x, y, z ) ;

	Character [ targetid ] [ E_CHARACTER_ARREST_X ] = x ;
	Character [ targetid ] [ E_CHARACTER_ARREST_Y ] = y ;
	Character [ targetid ] [ E_CHARACTER_ARREST_Z ] = z ;

	Character [ targetid ] [ E_CHARACTER_ARREST_VW ] = GetPlayerVirtualWorld(targetid) ;
	Character [ targetid ] [ E_CHARACTER_ARREST_INT ] = GetPlayerInterior(targetid) ;

	new query [ 1024 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_arrest_x = '%f', player_arrest_y = '%f', player_arrest_z = '%f',\
		player_arrest_vw = %d, player_arrest_int = %d WHERE player_id = %d",

		Character [ targetid ] [ E_CHARACTER_ARREST_X ], Character [ targetid ] [ E_CHARACTER_ARREST_Y ], 
		Character [ targetid ] [ E_CHARACTER_ARREST_Z ], Character [ targetid ] [ E_CHARACTER_ARREST_VW ], 
		Character [ targetid ] [ E_CHARACTER_ARREST_INT ],
		Character [ targetid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);

	SendClientMessage(playerid, COLOR_BLUE, sprintf("You've updated the arrest spawn location of (%d) %s.", targetid, ReturnSettingsName(targetid, playerid)));
	SendClientMessage(targetid, COLOR_ERROR, sprintf("Officer (%d) %s has updated your arrest spawn location.", playerid, ReturnSettingsName(playerid, targetid)));

	return true ;
}

Arrest_Tick(playerid) {

	if ( Character [ playerid ] [ E_CHARACTER_ARREST_TIME ]) {

		if ( -- Character [ playerid ] [ E_CHARACTER_ARREST_TIME ] <= 0 ) {

			Character [ playerid ] [ E_CHARACTER_ARREST_TIME ] = 0 ;

			SOLS_SetPlayerPos(playerid, 1811.0447,-1577.7692,13.5267);
			SetPlayerFacingAngle(playerid, 260.1323);

			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_arrest_time = 0 WHERE player_id = %d", 
				Character [ playerid ] [ E_CHARACTER_ID ] ) ;

			mysql_tquery(mysql, query);

			SendServerMessage ( playerid, COLOR_BLUE, "Arrest", "A3A3A3", "You've been released from captivity." ) ;
		}
		/*
		else {

			GameTextForPlayer(playerid, sprintf("~w~~n~~n~~n~~n~~n~~n~Jail Time: ~r~%d", Character [ playerid ] [ E_CHARACTER_ARREST_TIME ]), 950, 3 ) ;
		}
		*/
	}
}

Spawn_ArrestJail(playerid, bool:isrespawn)
{
	#pragma unused isrespawn
	SetSpawnInfo(playerid, 0, 264, 
		Character [ playerid ] [ E_CHARACTER_ARREST_X ], Character [ playerid ] [ E_CHARACTER_ARREST_Y ], 
		Character [ playerid ] [ E_CHARACTER_ARREST_Z ], 0.0, 0, 0, 0, 0, 0, 0);

	CS_SpawnPlayer(playerid) ;
	SetCameraBehindPlayer(playerid);

	SetPlayerVirtualWorld ( playerid, Character [ playerid ] [ E_CHARACTER_ARREST_VW ] );
	SetPlayerInterior(playerid, Character [ playerid ] [ E_CHARACTER_ARREST_INT ] );
	SetPlayerHealth(playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;

	// SOLS_SetPlayerPos ( playerid, Character [ playerid ] [ E_CHARACTER_ARREST_X ], Character [ playerid ] [ E_CHARACTER_ARREST_Y ], Character [ playerid ] [ E_CHARACTER_ARREST_Z ] );
	SOLS_SetPosWithFade(playerid, Character [ playerid ] [ E_CHARACTER_ARREST_X ], Character [ playerid ] [ E_CHARACTER_ARREST_Y ], Character [ playerid ] [ E_CHARACTER_ARREST_Z ]);

	SendServerMessage ( playerid, COLOR_BLUE, "Arrest", "A3A3A3", "You've been returned back to your cell." );
	// Weapon_ResetPlayerWeapons(playerid);
	
	//SendClientMessage(playerid, 0xA3A3A3FF, "Your weapons have been confiscated.");
	Weapon_SavePlayerWeapons(playerid);
	Attach_LoadPlayerEntities(playerid);

	SendClientMessage(playerid, 0xA3A3A3FF, "Type \"/jailtime\" to see how long you have left in jail.");

	// Very important to call this so that the event is fired, and common spawn variables are set
	// Spawn_Common(playerid, isrespawn);
	return true;
}