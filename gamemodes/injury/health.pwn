SetCharacterHealth(playerid, Float: amount ) {

	Character [ playerid ] [ E_CHARACTER_HEALTH ] = amount ;

	if ( Character [ playerid ] [ E_CHARACTER_HEALTH ] <= 0 ) {

		Character [ playerid ] [ E_CHARACTER_HEALTH ] = 15.0 ;
	}

	if ( Character [ playerid ] [ E_CHARACTER_HEALTH ] >= 100 ) {

		Character [ playerid ] [ E_CHARACTER_HEALTH ] = 100 ;
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_health = %0.3f WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_HEALTH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	SetPlayerHealth(playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;

	SetACHealth(playerid, amount);

	return true ;
}

Float: GetCharacterHealth ( playerid ) {

	return Character [ playerid ] [ E_CHARACTER_HEALTH ] ;
}

SetCharacterArmour ( playerid, Float: amount ) {

	Character [ playerid ] [ E_CHARACTER_ARMOUR ] = amount ;

	if ( Character [ playerid ] [ E_CHARACTER_ARMOUR ] <= 0 ) {
		RemovePlayerAttachedObject(playerid, 9);

		Character [ playerid ] [ E_CHARACTER_ARMOUR ] = 0.0; 
	}

	if ( Character [ playerid ] [ E_CHARACTER_ARMOUR ] >= 100 ) {

		Character [ playerid ] [ E_CHARACTER_ARMOUR ] = 100.0 ;
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_armour = %0.3f WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_ARMOUR ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	SetPlayerArmour ( playerid, Character [ playerid ] [ E_CHARACTER_ARMOUR ] ) ;

	return true ;
}

Float: GetCharacterArmour ( playerid ) {

	return Character [ playerid ] [ E_CHARACTER_ARMOUR ] ;
}
