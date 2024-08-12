
Player_GetOwnedVehicles ( playerid ) {

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

Player_GetMaxOwnedVehicles(playerid) {

	new max_vehicles = 2 ;
	
	if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 500 ) max_vehicles = 5;
	else if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 300 ) max_vehicles = 4;
	else if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 150 ) max_vehicles = 3;

	return max_vehicles ;
}