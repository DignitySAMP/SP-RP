
#define PANIC_TYPE_PANIC	0
#define PANIC_TYPE_BACKUP	1

static ActivatePanicButton(playerid, panictype, factionid)
{
	if (IsPlayerIncapacitated(playerid, false)) return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." );
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerInMedicFaction(playerid, true)) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty as a cop or medic.");
	if (IsPlayerInMedicFaction(playerid) && panictype != PANIC_TYPE_PANIC) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This system isn't available for you.");

	new string[144], string2[144];
	new address [ 64 ], zone [ 64 ], Float: x, Float: y, Float: z  ;
	GetPlayerPos ( playerid, x, y, z ) ;
	
	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_PROPERTY ] = 0;

	if (GetPlayerVirtualWorld(playerid) > 0)
	{
		// They are probably in a property, so use the exterior of that if they are
		new property = Property_GetInside(playerid);
		if (property != INVALID_PROPERTY_ID)
		{
			x = Property [ property ] [ E_PROPERTY_EXT_X ]; 
			y = Property [ property ] [ E_PROPERTY_EXT_Y ]; 
			z = Property [ property ] [ E_PROPERTY_EXT_Z ];
			PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_PROPERTY ] = property;
		}
	}

	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 0 ] = x;
	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 1 ] = y;
	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 2 ] = z;
	//PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_INT ] = GetPlayerInterior(playerid);
	//PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_VW ] = GetPlayerVirtualWorld(playerid);
	

	GetCoords2DZone(x, y, zone, sizeof ( zone ));
	GetPlayerAddress(x, y, address );

	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_USED ] = true ;
	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_TICKS ] = 600 ;

	// new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID(factionid );
	new color = Faction[faction_enum_id][E_FACTION_HEXCOLOR];

	new senderfactionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new senderfac_enum_id = Faction_GetEnumID(senderfactionid);

	if (panictype == PANIC_TYPE_PANIC) color = 0xE86C00FF;

	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_COLOR ] = color;

	new descr[10];
	format(descr, sizeof(descr), "%s", Faction[senderfac_enum_id][E_FACTION_ABBREV]);

	switch (panictype)
	{
		case PANIC_TYPE_PANIC:
		{
			format ( string, sizeof ( string ), "{[ [%s] %s activated their panic button!  Location: %s, %s ]}", descr, ReturnMixedName(playerid), address, zone);
			format ( string2, sizeof ( string2 ), "{[ To set up your GPS to the location type {FF5252}\"/p(anic)r(esponse) %d\"{E86C00} ]}", playerid ) ; 

			for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) 
			{
				if (Faction[i][E_FACTION_ID] == senderfactionid || Faction_GetType(i) == FACTION_TYPE_POLICE) 
				{
					Faction_SendMessage(Faction[i][E_FACTION_ID], string, i, true, true, color, true);
					Faction_SendMessage(Faction[i][E_FACTION_ID], string2, i, true, true, color, true);
				}
			}
		}
		case PANIC_TYPE_BACKUP:
		{
			if (factionid == senderfactionid)
			{
				format ( string, sizeof ( string ), "{[ [%s] %s is requesting backup.  Location: %s, %s ]}", descr, ReturnMixedName(playerid), address, zone);
				Faction_SendMessage(factionid, string, faction_enum_id, true, true, color, true);
			}
			else
			{
				format ( string, sizeof ( string ), "{[ [%s] %s requested %s assistance at: %s, %s ]}", descr, ReturnMixedName(playerid), Faction[faction_enum_id][E_FACTION_ABBREV], address, zone);
				Faction_SendMessage(senderfactionid, string, senderfac_enum_id, true, true, Faction[faction_enum_id][E_FACTION_HEXCOLOR], true);
				Faction_SendMessage(factionid, string, faction_enum_id, true, true, color, true);
			}

			format ( string, sizeof ( string ), "{[ To set up your GPS to the location type \"/b(ackup)r(esponse) %d\" ]}", playerid ) ; 
			Faction_SendMessage(factionid, string, faction_enum_id, true, true, color, true);
		}
	}

	//ProxDetector(playerid, 15.0, COLOR_PURPLE, sprintf("** %s presses a button on their radio.", ReturnPlayerNameData(playerid, 0, true) )) ;
	ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "*", "presses a button on their radio.", false, true);

	return true;
}

CMD:panic(playerid, params[]) 
{
	return ActivatePanicButton(playerid, PANIC_TYPE_PANIC, Character[playerid][E_CHARACTER_FACTIONID]);
}

CMD:panicbutton(playerid, params[]) {

	return cmd_panic(playerid, params);
}

CMD:pb(playerid, params[]) {

	return cmd_panic(playerid, params);
}

CMD:backup(playerid, params[]) 
{
	new sendfactionstr[5];

    sscanf(params, "s[5]", sendfactionstr); 

	if (!strlen(sendfactionstr))
	{
		// Send like normal.
		ActivatePanicButton(playerid, PANIC_TYPE_BACKUP, Character[playerid][E_CHARACTER_FACTIONID]);
		return true;
	}

	// Find out what specific faction they want
	new fac_enumid = -1;
	for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) 
	{
		if (strlen(Faction[i][E_FACTION_ABBREV]) && !strcmp(Faction[i][E_FACTION_ABBREV], sendfactionstr, true)) 
		{
			fac_enumid = i;
			break;
		}
	}

	if (fac_enumid >= 0 && fac_enumid < sizeof(Faction) && fac_enumid != INVALID_FACTION_ID)
	{
		if (Faction_GetType(fac_enumid) == FACTION_TYPE_POLICE || Faction_GetType(fac_enumid) == FACTION_TYPE_EMS)
		{
			ActivatePanicButton(playerid, PANIC_TYPE_BACKUP, Faction[fac_enumid][E_FACTION_ID]);
			return true;
		}
	}

	// Otherwise show the syntax
	SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/b(ac)k(up) [(faction)]" ) ;

	new helpstr[128];
	format(helpstr, sizeof(helpstr), "Available Factions: ");
	new index = 0;

	for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) 
	{
		if (Faction[i][E_FACTION_ID] != INVALID_FACTION_ID && (Faction_GetType(i) == FACTION_TYPE_POLICE || Faction_GetType(i) == FACTION_TYPE_EMS))
		{
			if (index) strcat(helpstr, ", ");
			format(helpstr, sizeof(helpstr), "%s\"%s\"", helpstr, Faction[i][E_FACTION_ABBREV]);
			index ++;
		}
	}

	SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", helpstr ) ;

	return true;
}

CMD:bk(playerid, params[]) {

	return cmd_backup(playerid, params);
}

CMD:panicresponse(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerInMedicFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

    new targetid ;

    if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/p(anic)r(esponse) [playerid/name]" ) ;
    }

    if ( ! IsPlayerConnected ( targetid ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Invalid player entered." ) ;
    }

	if (! PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_USED ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "The player you entered doesn't have an active panic button request." ) ;
    }

	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_ACCEPTED ] = true;
	PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_TARGET ] = targetid;

	// No need to do anything further as the rest is handled by the timer.
	ShowPlayerSubtitle(playerid, sprintf("~b~%s ~w~is now marked.", ReturnSettingsName(targetid, playerid)), 4000 ) ;

	// Instead of using the GPS system, just setting the map icon now.
	/*
	RemovePlayerMapIcon(playerid, 0);
	SetPlayerMapIcon(playerid, 0, PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 0 ], PlayerVar[ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 1 ], PlayerVar[ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 2 ], 0, E_GPS_COLOR_SCRIPT, MAPICON_GLOBAL );
	ShowPlayerSubtitle(playerid, sprintf("~b~%s ~w~is now ~b~marked~w~.", ReturnPlayerNameData(targetid, 0, true)), 4000 ) ;
	*/

	//ForcePlayerEndLastRoute(playerid) ;
	//DisablePlayerCheckpoint(playerid);
    //GPS_MarkLocation ( playerid, sprintf("~b~%s ~w~is now ~b~marked~w~.", ReturnPlayerNameData(targetid)), E_GPS_COLOR_SCRIPT, x, y, z ) ;

    // SendClientMessage(playerid, COLOR_INFO, "Signal for panic button marked! Head there with a code 0 response (sirens+lights)!");

	return true ;
}

CMD:pr(playerid, params[]) {

	return cmd_panicresponse(playerid, params) ;
}

CMD:br(playerid, params[]) {

	return cmd_panicresponse(playerid, params) ;
}

CMD:cancelpanic(playerid, params[]) 
{
	if (IsPlayerIncapacitated(playerid, false)) return SendServerMessage (playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this.");
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	if ( ! factionid ) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	new faction_enum_id = Faction_GetEnumID(factionid); 
	if ( faction_enum_id == INVALID_FACTION_ID ) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	// if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] != 0 ) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a police faction.");
	
	new targetid = INVALID_PLAYER_ID;
	if (sscanf(params, "k<player>", targetid))
	{
		targetid = playerid;
	}

	if (!IsPlayerConnected(targetid)) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't connected." );

	if (playerid != targetid)
	{
		if (Character[targetid][E_CHARACTER_FACTIONID] != factionid) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't in your faction." );
		if (!PlayerVar[targetid][E_PLAYER_PANIC_BUTTON_USED]) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player doesn't have an active panic button." );
		if (Character[ playerid ] [ E_CHARACTER_FACTIONTIER ] >= 3) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be a higher tier to cancel another player's panic." );
	}
	else
	{
		if (!PlayerVar[playerid][E_PLAYER_PANIC_BUTTON_USED]) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have an active backup request." );
	}

	PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_ACCEPTED ] = false;
	PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_TARGET ] = INVALID_PLAYER_ID;
	PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_TICKS ] = 0 ;

	if (playerid == targetid)
	{
		Faction_SendMessage(factionid, sprintf("{[ [%s/HQ] %s cancelled their backup request (use /clearcp to hide marker). ]}", Faction[faction_enum_id][E_FACTION_ABBREV], ReturnMixedName(playerid)), faction_enum_id, false);
	}
	else
	{
		Faction_SendMessage(factionid, sprintf("{[ [%s/HQ] %s cancelled the backup request of %s (use /clearcp to hide marker). ]}", Faction[faction_enum_id][E_FACTION_ABBREV], ReturnMixedName(playerid), ReturnMixedName(targetid)), faction_enum_id, false);
	}

	return true ;
}

CMD:pbc(playerid, params[]) { return cmd_cancelpanic(playerid, params); }
CMD:cpanic(playerid, params[]) { return cmd_cancelpanic(playerid, params); }
CMD:cbk(playerid, params[]) { return cmd_cancelpanic(playerid, params); }
CMD:bkc(playerid, params[]) { return cmd_cancelpanic(playerid, params); }
CMD:cancelbackup(playerid, params[]) { return cmd_cancelpanic(playerid, params); }
CMD:cancelbk(playerid, params[]) { return cmd_cancelpanic(playerid, params); }