
Player_GetOwnedVehicles ( playerid ) {
	#warning this should be cached
	if(playerid == INVALID_PLAYER_ID) return -1;

	new count = 0 ;

	for ( new i, j = sizeof ( Vehicle ); i < j ; i ++ ) {

		if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_PLAYER ) {
			if ( Vehicle [ i ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				count ++ ;
			}

			else continue ;
		}
	}

	return count ;
}

Player_GetPidFromOwnerid(ownerid) {
	foreach(new playerid: Player) {
		if(Character[playerid][E_CHARACTER_ID] == ownerid) {
			return playerid;
		}
	}
	return INVALID_PLAYER_ID;
}

Player_GetMaxOwnedVehicles(playerid) {

	new max_vehicles = 2 ;
	
	if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 500 ) max_vehicles = 5;
	else if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 300 ) max_vehicles = 4;
	else if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 150 ) max_vehicles = 3;

	return max_vehicles ;
}