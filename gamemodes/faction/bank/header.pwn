CMD:factionbank(playerid, params[]) {
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 2 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	SendServerMessage ( playerid, COLOR_BLUE, "Faction Funds", "A3A3A3", sprintf("Faction has $%s in it's bank.", 
		IntegerWithDelimiter(Faction_GetBankMoney ( faction_enum_id ) ) ) );
	
	return true ;
}

Faction_AddBankMoney(factionid, amount) {

	Faction [ factionid ] [ E_FACTION_BANK ] += amount ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE factions SET faction_bank = %d WHERE faction_id = %d",

		Faction [ factionid ] [ E_FACTION_BANK ], Faction [ factionid ] [ E_FACTION_ID ]
	);

	mysql_tquery(mysql, query);

	return true ;
}

stock Faction_TakeBankMoney(factionid, amount) {
	
	if ( Faction [ factionid ] [ E_FACTION_BANK ] < amount ) {

		return false ;
	}

	Faction [ factionid ] [ E_FACTION_BANK ] -= amount ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE factions SET faction_bank = %d WHERE faction_id = %d",

		Faction [ factionid ] [ E_FACTION_BANK ], Faction [ factionid ] [ E_FACTION_ID ]
	);

	mysql_tquery(mysql, query);

	return true ;
}

Faction_GetBankMoney(factionid) {

	return Faction [ factionid ] [ E_FACTION_BANK ] ;
}