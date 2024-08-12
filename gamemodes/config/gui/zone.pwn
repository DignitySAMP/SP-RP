new PlayerZoneHudTick [ MAX_PLAYERS ] ;

ShowZoneMessage(playerid, const name[], bool:force=false) 
{
	if (!force)
	{
		if (!Settings_GetTrademarkValue(playerid) || !IsPlayerSpawned(playerid) || !IsPlayerPlaying(playerid))
		{
			// Don't show if it's toggled or they're not spawned etc.
			return 0;
		}
	}

	if ( PlayerZoneFading [ playerid ] ) 
	{
		// Don't show if it's already being shown?
	    return 0;
	}

	// Reset it if need be
	ResetZonePlayerText(playerid, false);

	zoneTextDraw[playerid] = CreatePlayerTextDraw(playerid, 623.5000, 400.0000, name);
	PlayerTextDrawFont(playerid, zoneTextDraw[playerid], 0);
	PlayerTextDrawLetterSize(playerid, zoneTextDraw[playerid], 0.7500, 2.5000);
	PlayerTextDrawAlignment(playerid, zoneTextDraw[playerid], 3);
	PlayerTextDrawColor(playerid, zoneTextDraw[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, zoneTextDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, zoneTextDraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 255);
	PlayerTextDrawSetProportional(playerid, zoneTextDraw[playerid], 1);
	PlayerTextDrawTextSize(playerid, zoneTextDraw[playerid], 0.0000, 0.0000);

	PlayerZoneFading [ playerid ] = true ;
	PlayerZoneHudTick [ playerid ] = 0 ;

	defer UpdateZoneOpacity_FadeIn(playerid);
    return 1;
}

timer UpdateZoneOpacity_FadeIn[100](playerid) 
{
   	if (zoneTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
	{
		// Don't do this if the TD doesn't exist
		return false;
	}

	if ( PlayerZoneFading [ playerid ] ) {

		PlayerTextDrawHide(playerid, zoneTextDraw[playerid]);

		switch ( PlayerZoneHudTick [ playerid ] ) {

			case 0: {
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED711);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000011);
			}
			case 1:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED722);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000022);
			}
			case 2:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED733);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000033);
			}
			case 3:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED744);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000044);
			}
			case 4:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED755);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000055);
			}
			case 5:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED766);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000066);
			}
			case 6:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED777);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000077);
			}
			case 7:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED788);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000088);
			}
			case 8:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED799);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000099);
			}
			case 9:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED7FF);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x000000FF);
			}
			case 10: {

				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED7FF);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x000000FF);
				PlayerTextDrawShow(playerid, zoneTextDraw[playerid]);

				// Fade Out
				PlayerZoneHudTick [ playerid ] = 10 ;
				defer UpdateZoneOpacity_FadeOut[4500](playerid);

				return true ;
			}
		}

		PlayerTextDrawShow(playerid, zoneTextDraw[playerid]);

		PlayerZoneHudTick [ playerid ] ++ ;
		defer UpdateZoneOpacity_FadeIn(playerid);
	}

	return true ;
}

timer UpdateZoneOpacity_FadeOut[100](playerid) 
{   
	if (zoneTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
	{
		// Don't do this if the TD doesn't exist
		return false;
	}

	if ( PlayerZoneFading [ playerid ] ) {

		PlayerTextDrawHide(playerid, zoneTextDraw[playerid]);

		switch ( PlayerZoneHudTick [ playerid ] ) {

			case 0: {

				PlayerZoneHudTick [ playerid ] = 0 ;
	    		PlayerZoneFading [ playerid ] = false ;

				HidePlayerZone(playerid);

				return true ;
			}

			case 1: {
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED711);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000011);
			}
			case 2:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED722);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000022);
			}
			case 3:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED733);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000033);
			}
			case 4:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED744);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000044);
			}
			case 5:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED755);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000055);
			}
			case 6:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED766);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000066);
			}
			case 7:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED777);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000077);
			}
			case 8:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED788);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000088);
			}
			case 9:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED799);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x00000099);
			}
			case 10:{
				PlayerTextDrawColor(playerid, zoneTextDraw[playerid], 0xA2CED7FF);
				PlayerTextDrawBackgroundColor(playerid, zoneTextDraw[playerid], 0x000000FF);
			}
		}

		PlayerTextDrawShow(playerid, zoneTextDraw[playerid]);
		PlayerZoneHudTick [ playerid ] -- ;
		defer UpdateZoneOpacity_FadeOut(playerid);
	}

	return true ;
}

HidePlayerZone(playerid)
{   
	ResetZonePlayerText(playerid, false);
    return 1;
}

static zonestr[32], MapZone:zoneid;
ptask OnZoneChange[1000](playerid) 
{
	if (!Settings_GetTrademarkValue(playerid) || GetPlayerInterior(playerid) != 0) 
	{
		// Do nothing because it's toggled off
		return 0;
	}

	zoneid = GetPlayerMapZone2D(playerid);

	if (zoneid != PlayerZone[playerid]) 
	{
		GetMapZoneName(zoneid, zonestr);
		ShowZoneMessage(playerid, zonestr);
	}

	PlayerZone[playerid] = zoneid;
	return 1;
}


stock UpdateZone(playerid, const text[]="", custompos = false, Float: x = 0.0, Float: y = 0.0) 
{
	if (strlen(text) < 1 && GetPlayerInterior(playerid) != 0)
	{
		// Don't update normal game zones if they are inside because it's pointless.
		return true;
	}
	
	HidePlayerZone(playerid);

	new zone_name [ 128 ] ;

	if ( ! custompos ) {
		zone_name [ 0 ] = EOS ;
		GetMapZoneName(GetPlayerMapZone2D ( playerid ), zone_name);
	}

	else if ( custompos ) {
		zone_name [ 0 ] = EOS ;
		GetMapZoneName(GetMapZoneAtPoint2D ( x, y ), zone_name);
	}

	if ( strlen ( text ) > 1 ) {

		zone_name [ 0 ] = EOS ;
		strcat(zone_name, text);
	}

	ShowZoneMessage(playerid, zone_name, true);
	return true;
}