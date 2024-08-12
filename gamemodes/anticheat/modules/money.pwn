
GetPlayerCash ( playerid ) {

	return Character [ playerid ] [ E_CHARACTER_CASH ] ;
}

SetPlayerCash(playerid, amount) {

	Character [ playerid ] [ E_CHARACTER_CASH ] = amount ;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, Character [ playerid ] [ E_CHARACTER_CASH ] ) ;

	return true ;
}

GivePlayerCash ( playerid, amount ) {

	if ( amount < 0 ) {

		return false ;
	}

	Character [ playerid ] [ E_CHARACTER_CASH ] += amount ;

	new query [ 96 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_cash = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_CASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;

	ResetPlayerMoney ( playerid ) ;
	GivePlayerMoney ( playerid, Character [ playerid ] [ E_CHARACTER_CASH ] ) ;

	return Character [ playerid ] [ E_CHARACTER_CASH ] ;
}

TakePlayerCash ( playerid, amount ) {

	if ( amount < 0 ) {

		return false ;
	}

	Character [ playerid ] [ E_CHARACTER_CASH ] -= amount ;

	new query [ 96 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_cash = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_CASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;

	ResetPlayerMoney ( playerid ) ;
	GivePlayerMoney ( playerid, Character [ playerid ] [ E_CHARACTER_CASH ] ) ;

	return Character [ playerid ] [ E_CHARACTER_CASH ] ; 
}

TakePlayerBankCash ( playerid, amount ) {

	if ( amount < 0 ) {

		return false ;
	}

	Character [ playerid ] [ E_CHARACTER_BANKCASH ] -= amount ;

	new query [ 96 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_bankcash = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_BANKCASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;

	return Character [ playerid ] [ E_CHARACTER_BANKCASH ] ; 
}