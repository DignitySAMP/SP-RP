enum E_FACTION_SQUAD
{
	E_FACTION_SQUAD_ID,
	E_FACTION_SQUAD_FACTION_TYPE,
	E_FACTION_SQUAD_NAME[24]
}

static const Squads[][E_FACTION_SQUAD] = 
{
    {FACTION_SQUAD_NONE, -1, "None"},
    {FACTION_SQUAD_CRASH, FACTION_TYPE_POLICE, "Detective"},
    {FACTION_SQUAD_SWAT, FACTION_TYPE_POLICE, "METRO"},
    {FACTION_SQUAD_TRAFF, FACTION_TYPE_POLICE, "Traffic"}
};

IsPlayerInFactionSquad(playerid, squad, factiontype = -1, bool:onduty=false)
{
	if (factiontype != -1)
	{
		if (!IsPlayerInFactionType(playerid, factiontype, onduty)) return 0;
	}

	return Character [ playerid ] [ E_CHARACTER_FACTIONID ] && Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD ] == squad;
}

CMD:setsquad(playerid, params[]) 
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}
	
	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1 ) 
	{
		// 1 : owner, 2: command, 3 : member
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this (only tier 1).");
	}

    new userid = INVALID_PLAYER_ID, option = -1, helpstr[128], squad = -1, slot = -1;
	sscanf ( params, "k<player>ii", userid, option, slot );

    format(helpstr, sizeof(helpstr), "Available Squads: ");
    new index = 0;

    for (new i = 0; i < sizeof(Squads); i ++)
    {
        if (Squads[i][E_FACTION_SQUAD_FACTION_TYPE] != -1 && GetPlayerFactionType(playerid) != Squads[i][E_FACTION_SQUAD_FACTION_TYPE]) continue;
        else if (index) strcat(helpstr, ", ");

        format(helpstr, sizeof(helpstr), "%s%d: %s", helpstr, Squads[i][E_FACTION_SQUAD_ID], Squads[i][E_FACTION_SQUAD_NAME]);

        index ++;
        
        if (option >= 0 && option == Squads[i][E_FACTION_SQUAD_ID])
        {
            squad = i;
            break;
        }
    }

    if (index < 1)
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Your faction doesn't have any squads.");
    }

    if (squad == -1 || slot < 0 || slot > 2)
    {
        SendClientMessage(playerid, 0xDEDEDEFF, helpstr);
        SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setsquad [player] [squad] [slot (0-2)]" );
        return true;
    }

    if (!IsPlayerConnected(userid) || !IsPlayerPlaying(userid) || !IsPlayerInFaction(userid, factionid))
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid player or this player isn't in your faction.");
    }

    switch(slot) {
        case 0: Character[userid][E_CHARACTER_FACTION_SQUAD] = Squads[squad][E_FACTION_SQUAD_ID];
        case 1: Character[userid][E_CHARACTER_FACTION_SQUAD2] = Squads[squad][E_FACTION_SQUAD_ID];
        case 2: Character[userid][E_CHARACTER_FACTION_SQUAD3] = Squads[squad][E_FACTION_SQUAD_ID];
    }

    new query[128];
    mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_factionsquad = %d, player_factionsquad2 = %d, player_factionsquad3 = %d WHERE player_id = %d", 
        Character[userid][E_CHARACTER_FACTION_SQUAD], Character[userid][E_CHARACTER_FACTION_SQUAD2], Character[userid][E_CHARACTER_FACTION_SQUAD3], 
        Character[userid][E_CHARACTER_ID]);

	mysql_tquery(mysql, query);

    Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s set squad %i of (%d) %s to \"%s\" }",
		Faction[faction_enum_id][ E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), slot, userid, ReturnMixedName(userid), Squads[squad][E_FACTION_SQUAD_NAME]
	), faction_enum_id, false ) ;
	
	return true ;
}
