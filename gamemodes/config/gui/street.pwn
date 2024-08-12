new PlayerStreetHudTick [ MAX_PLAYERS ] ;

ShowStreetMessage(playerid, const name[]) 
{
    if (!Settings_GetTrademarkValue(playerid) || !IsPlayerSpawned(playerid) || !IsPlayerPlaying(playerid)) 
	{
		// Don't do this when toggled off/not spawned
	    return 0;
	}

	if (PlayerStreetFading[playerid])
	{
		// Don't do this if already being shown?
		return 0;
	}

	// Reset the TD as appropriate.
	ResetStreetPlayerText(playerid, false);

	// If vehicle hud isn't shown, makes it shown at bottom and not above.
	if (vehicleTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW) streetTextDraw[playerid] = CreatePlayerTextDraw(playerid, 625.5000, 429.5000, name);
	else streetTextDraw[playerid] = CreatePlayerTextDraw(playerid, 622.0000, 390.0000, name);

	PlayerTextDrawFont(playerid, streetTextDraw[playerid], 1);
	PlayerTextDrawLetterSize(playerid, streetTextDraw[playerid], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, streetTextDraw[playerid], 3);
	PlayerTextDrawColor(playerid, streetTextDraw[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, streetTextDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, streetTextDraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 255);
	PlayerTextDrawSetProportional(playerid, streetTextDraw[playerid], 1);
	PlayerTextDrawTextSize(playerid, streetTextDraw[playerid], 500.0000, 500.0000);

	PlayerStreetFading [ playerid ] = true ;
	PlayerStreetHudTick [ playerid ] = 0 ;

	defer UpdateStreetOpacity_FadeIn(playerid);

    return 1;
}

timer UpdateStreetOpacity_FadeIn[100](playerid) 
{
	if (streetTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
	{
		// Don't do this if the TD doesn't exist
		return false;
	}

	if ( PlayerStreetFading [ playerid ] ) {

		PlayerTextDrawHide(playerid, streetTextDraw[playerid]);

		switch ( PlayerStreetHudTick [ playerid ] ) {

			case 0: {
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED711);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000011);
			}
			case 1:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED722);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000022);
			}
			case 2:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED733);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000033);
			}
			case 3:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED744);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000044);
			}
			case 4:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED755);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000055);
			}
			case 5:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED766);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000066);
			}
			case 6:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED777);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000077);
			}
			case 7:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED788);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000088);
			}
			case 8:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED799);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000099);
			}
			case 9:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED7FF);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x000000FF);
			}
			case 10: {

				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED7FF);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x000000FF);
				PlayerTextDrawShow(playerid, streetTextDraw[playerid]);

				// Fade Out
				PlayerStreetHudTick [ playerid ] = 10 ;
				defer UpdateStreetOpacity_FadeOut[4500](playerid);

				return true ;
			}
		}

		PlayerTextDrawShow(playerid, streetTextDraw[playerid]);

		PlayerStreetHudTick [ playerid ] ++ ;
		defer UpdateStreetOpacity_FadeIn(playerid);
	}

	return true ;
}

timer UpdateStreetOpacity_FadeOut[100](playerid) 
{    
	if (streetTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
	{
		// Don't do this if the TD doesn't exist
		return false;
	}

	if ( PlayerStreetFading [ playerid ] ) {

		PlayerTextDrawHide(playerid, streetTextDraw[playerid]);

		switch ( PlayerStreetHudTick [ playerid ] ) {

			case 0: {

				PlayerStreetHudTick [ playerid ] = 0 ;
	    		PlayerStreetFading [ playerid ] = false ;

				HidePlayerStreet(playerid);

				return true ;
			}

			case 1: {
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED711);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000011);
			}
			case 2:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED722);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000022);
			}
			case 3:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED733);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000033);
			}
			case 4:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED744);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000044);
			}
			case 5:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED755);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000055);
			}
			case 6:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED766);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000066);
			}
			case 7:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED777);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000077);
			}
			case 8:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED788);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000088);
			}
			case 9:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED799);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x00000099);
			}
			case 10:{
				PlayerTextDrawColor(playerid, streetTextDraw[playerid], 0xA2CED7FF);
				PlayerTextDrawBackgroundColor(playerid, streetTextDraw[playerid], 0x000000FF);
			}
		}

		PlayerTextDrawShow(playerid, streetTextDraw[playerid]);
		PlayerStreetHudTick [ playerid ] -- ;
		defer UpdateStreetOpacity_FadeOut(playerid);
	}

	return true ;
}

HidePlayerStreet(playerid)
{   
    ResetStreetPlayerText(playerid, false);
	return 1;
}

static streetstr[32], addressid, Float:addrx, Float:addry, Float:addrz;
ptask OnStreetChange[1000](playerid) 
{
	if (!Settings_GetTrademarkValue(playerid) || GetPlayerInterior(playerid) != 0) 
	{
		// Do nothing because it's toggled off
		return 0;
	}

	addressid = GetPlayerAddressID(playerid);

	if (addressid != PlayerStreet[playerid] && addressid != -1) 
	{
		GetPlayerPos(playerid, addrx, addry, addrz);
		GetPlayerAddress(addrx, addry, streetstr);
		ShowStreetMessage(playerid, streetstr);

		PlayerStreet[playerid] = addressid;
	}

	return 1;
}