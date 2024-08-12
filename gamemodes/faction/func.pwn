MatchPlayerFactionType ( playerid, type ) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return false ;
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return false ;
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_EXTRA ] == type ) {

		return true ;
	}

	return false ;
}

Faction_SendMessage(factionid, const message[], enum_id, split, ping = false, color = 0, bool:nohide = false ) {
// factionid == E_FACTION_ID, not enum ID

	if ( ! color ) {
		color = Faction [ enum_id ] [ E_FACTION_HEXCOLOR ] ;
	}

	foreach(new playerid: Player) {

		if ( Character [ playerid ] [ E_CHARACTER_ID ] == -1 ) {

			continue ;
		}

		if ( ! IsPlayerLogged ( playerid ) ) {

			continue ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_FACTIONID ] <= 0 ) {
			continue ;
		}
		if ( PlayerVar [ playerid ] [ E_PLAYER_HIDING_FACTION ] && !nohide) {

			continue ;
		}

		if ( Character [ playerid ] [ E_CHARACTER_FACTIONID ] == factionid ) 
		{
			if ( split ) ZMsg_SendClientMessage(playerid, color, message);
			else SendClientMessage(playerid, color, message);

			if ( ping ) PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			continue ;
		}

		else continue ;
	}

	return true ;
}

Faction_SendTypeMessage(factiontypeid, message [], split, ping = false, color = 0, bool:nohide = false ) 
{
	foreach(new playerid: Player) 
	{
		if ( Character [ playerid ] [ E_CHARACTER_ID ] == -1 ) continue ;
		else if ( ! IsPlayerLogged ( playerid ) ) continue ;
		else if ( Character [ playerid ] [ E_CHARACTER_FACTIONID ] <= 0 ) continue ;
		else if ( PlayerVar [ playerid ] [ E_PLAYER_HIDING_FACTION ] && !nohide) continue;

		if ( Faction_GetType(Character [ playerid ] [ E_CHARACTER_FACTIONID ]) == factiontypeid ) 
		{
			if ( ! color ) color = Faction [ Faction_GetEnumID(Character [ playerid ] [ E_CHARACTER_FACTIONID ]) ] [ E_FACTION_HEXCOLOR ] ;
			if ( ping ) PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);

			if ( split )  ZMsg_SendClientMessage(playerid, color, message);
			else SendClientMessage(playerid, color, message);
		}
	}

	return true ;
}

Faction_GetEnumID ( factionid ) {
// factionid = E_FACTION_ID 

	for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) {

		if ( Faction [ i ] [ E_FACTION_ID ] == factionid ) {

			return i ;
		}

		else continue ;
	}

	return INVALID_FACTION_ID ;
}

Faction_GetType(faction_enum_id ) {

	if(faction_enum_id < 0 || faction_enum_id >= MAX_FACTIONS || faction_enum_id == -1) {
		return 0;
	}
	return Faction [ faction_enum_id ] [ E_FACTION_TYPE ] ;
}

Faction_GetAbbreviation(input[]) {

	new output [ 256 ] ;

	format ( output, sizeof ( output ), "%0.1s", input [ 0 ] ) ;

	for ( new i, j = strlen ( input ); i < j; i ++ ) {

	    if(input[i] == ' ') {

	    	format ( output, sizeof ( output ), "%s%.01s", output, input [ i + 1 ] ) ;
	    	continue ;
	    }

	    else continue ;
	}

	return output ;
}

// For use in cross-hooks!
Faction_GetTypeByID(enum_id) {

	return Faction [ enum_id ] [ E_FACTION_TYPE ] ;
}

Faction_GetAbbreviationByID(enum_id) {

	new abbreviation  [ 64 ] ;
	format ( abbreviation, sizeof ( abbreviation ), "%s", Faction [ enum_id ] [ E_FACTION_ABBREV ] ) ;

	return abbreviation ;
}
Faction_GetNameByID(enum_id) {

	new name  [ 128 ] ;
	format ( name, sizeof ( name ), "%s", Faction [ enum_id ] [ E_FACTION_NAME ] ) ;

	return name ;
}

Faction_AddBankMoneyPerType(type, amount) {

	for(new factionid, j = sizeof ( Faction ); factionid < j ; factionid ++ ) {

		if ( Faction [ factionid ] [ E_FACTION_TYPE ] == type ) {
			Faction [ factionid ] [ E_FACTION_BANK ] += amount ;

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE factions SET faction_bank = %d WHERE faction_id = %d",

				Faction [ factionid ] [ E_FACTION_BANK ], Faction [ factionid ] [ E_FACTION_ID ]
			);

			mysql_tquery(mysql, query);
		}
	}

	return true ;
}