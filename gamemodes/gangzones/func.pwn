
GangZone_GetColour(factionid) {

	switch ( factionid ) {

		case -1: {
			
			return 0xFFFFFF00 ;
		}
		case 0: {
			
			return 0x999999AA ;
		}

		default: {

			// Get faction hex here !

			new faction_enum_id = Faction_GetEnumID ( factionid ) ;

			if ( faction_enum_id == -1 ) {

				return 0x999999AA ;
			}

			new color = Faction [ faction_enum_id ] [ E_FACTION_HEXCOLOR ] ;
			new final_color = (((color) & 0xFFFFFF00) | ((99) & 0xFF)) ;

			return final_color ;
		}
	}

	return 0xFFFFFF00 ;
}


GangZone_ShowForPlayer(playerid) {

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ] ) {
		for(new i, j = sizeof ( GangZone ); i < j ; i ++ ) {
			GangZoneShowForPlayer(playerid, GangZone [ i ] [ E_GANGZONE_ZONEID ], GangZone_GetColour(GangZone [ i ] [ E_GANGZONE_FACTION ])) ;
		
			if ( GangZone [ i ] [ E_GANGZONE_CONTESTED ] ) {

				GangZoneFlashForPlayer(playerid, GangZone [ i ] [ E_GANGZONE_ZONEID ], 0xBA2920AA ) ;
			}
		}
	}

	else {
		GangZone_HideForPlayer(playerid) ;
	}

	return true ;
}
GangZone_HideForPlayer(playerid) {

	for(new i, j = sizeof ( GangZone ); i < j ; i ++ ) {
	
		if ( GangZone [ i ] [ E_GANGZONE_CONTESTED ] ) {

			GangZoneStopFlashForPlayer(playerid, GangZone [ i ] [ E_GANGZONE_ZONEID ]) ;
		}
		
		GangZoneHideForPlayer(playerid, GangZone [ i ] [ E_GANGZONE_ZONEID ]) ;
	}


	return true ;
}