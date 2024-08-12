enum E_HITMAN_RANK_DATA {

	E_HITMAN_RANK_LEVEL,
	E_HITMAN_RANK_DESC [ 32 ]
}

new HitmanRanks [ ] [ E_HITMAN_RANK_DATA ] = {

	{ 0, "Affiliate" },
	{ 1, "Operative" },
	{ 2, "Substantive" },
	{ 3, "Specialist" },
	{ 4, "Magister" }
} ;



CMD:hitmanrank(playerid, params[]) {

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] != 1 || !IsPlayerLogged ( playerid ) ) {

		return false ;
	}

	new targetid, rank ;

	if ( sscanf ( params, "k<player>i", targetid, rank ) ) {

		return SendClientMessage(playerid, -1, "/hitmansetrank [target] [rank]" ) ;
	}

	if ( ! IsPlayerConnected(targetid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "Target isn't connected. " ) ;
	}

	if ( rank < 0 || rank >= sizeof ( HitmanRanks ) ) {

		return SendClientMessage(playerid, -1, "Rank can't be less than 0 or higher than 4." ) ;
	}

	Character [ playerid ] [ E_CHARACTER_HITMAN_RANK ] = rank ;

	new query [ 128 ] ;

	format ( query, sizeof ( query ), "{[ [HITMAN] %s has been honored with the %s role. ]}", 
		ReturnMixedName(playerid), HitmanRanks [ rank ] [ E_HITMAN_RANK_DESC ] 
	) ;

	SendHitmanMessage ( query ) ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_hitman_rank = %d WHERE player_id = %d",

		Character [ playerid ] [ E_CHARACTER_HITMAN_RANK ], Character [ playerid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);

	return true ;
}

CMD:makehitman(playerid, params[]) {
	
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] != 1 || !IsPlayerLogged ( playerid ) ) {

		return false ;
	}
	

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ){
		return SendClientMessage(playerid, COLOR_YELLOW, "/makehitman [targetid]" ) ;
	}

	if ( ! IsPlayerConnected(targetid)) {

		return SendClientMessage(playerid, COLOR_ERROR, "Target isn't connected. " ) ;
	}



	if ( ! Character [ targetid ] [ E_CHARACTER_HITMAN ] ) {
		Character [ targetid ] [ E_CHARACTER_HITMAN ] = true ;
		Character [ targetid ] [ E_CHARACTER_HITMAN_RANK ] = 0 ;

		SendClientMessage(targetid, COLOUR_HITMAN, "You have joined the hitman agency. /help for useful commands. Do not leak ANY information ICly OR OOCly or you will get banned." ) ;
	
		new string [ 96 ] ;

		format ( string, sizeof ( string ), "{[ [HITMAN] %s has been inducted into the order. ]}", ReturnMixedName(targetid) ) ;
		SendHitmanMessage ( string ) ;
	}

	else {
		Character [ targetid ] [ E_CHARACTER_HITMAN ] = false ;
		Character [ targetid ] [ E_CHARACTER_HITMAN_RANK ] = 0 ;	

		SendClientMessage(targetid, COLOUR_HITMAN, "You have been removed from the hitman agency. Keep your secrets or you will be banned from the server." ) ;

		new string [ 96 ] ;

		format ( string, sizeof ( string ), "{[ [HITMAN] %s has been terminated from the agenda. ]}", ReturnMixedName(targetid) ) ;
		SendHitmanMessage ( string ) ;
	}

	new query [ 96 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_hitman = %d, player_hitman_rank = %d WHERE player_id = %d",

		Character [ targetid ] [ E_CHARACTER_HITMAN ], Character [ targetid ] [ E_CHARACTER_HITMAN_RANK ], Character [ targetid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);

	return true ;
}