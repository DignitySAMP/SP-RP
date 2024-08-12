#include <YSI_Coding\y_hooks>
GPS_OnPlayerDisconnect ( playerid ) {
	// Needed for logout

	if ( IsValidDynamicArea( PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] ) ) {

		DestroyDynamicArea( PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] = -1 ;
	}

	return true ;
}

hook OnPlayerDisconnect(playerid, reason) {
	GPS_OnPlayerDisconnect(playerid);
	return true;
}

hook OnPlayerEnterDynArea(playerid, STREAMER_TAG_AREA:areaid) {

	if ( areaid == PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] ) 
	{
		ShowPlayerSubtitle(playerid, "You have reached your destination.", .showtime = 6000 );

		ChopShop_VerifyPointLocation(playerid);
		// NewspaperJob_EnterCP(playerid);

		//ForcePlayerEndLastRoute(playerid) ;
		RemovePlayerMapIcon(playerid, 0);
		DestroyDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ]);
		PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] = -1 ;
	}
	
	return 1;
}

GPS_MarkLocation(playerid, const string[], color, Float: x, Float: y, Float: z ) {

	RemovePlayerMapIcon(playerid, 0);
	SetPlayerMapIcon(playerid, 0, x, y, z, 0, color, MAPICON_GLOBAL ) ;

	if (IsValidDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ]))
	{
		DestroyDynamicArea(PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ]);
	}
	
	PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] = CreateDynamicCircle(x, y, 5.0, -1, -1, playerid);
	//GPS_SetPlayerCheckpoint(playerid, x, y, z) ;

	if (strlen(string)) ShowPlayerSubtitle(playerid, string, .showtime = 6000 ) ;
}

GPS_ClearCheckpoint(playerid)
{
	//ForcePlayerEndLastRoute(playerid) ;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);

	if ( IsValidDynamicArea( PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] ) ) {

		DestroyDynamicArea( PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_GPS_AREA ] = -1 ;
	}

	RemovePlayerMapIcon(playerid, 0);
}