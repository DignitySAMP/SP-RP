new bool: PlayerVehicleAlertFading [ MAX_PLAYERS ] ;
new PlayerVehicleAlertHudTick [ MAX_PLAYERS ] ;

ShowVehicleAlert(playerid, const desc[]) {
    if(vehicleTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW) {

    	if (! IsPlayerSpawned(playerid)) {

    		return true ;
    	}

	    if ( PlayerVehicleAlertFading [ playerid ] ) {

	    	return true ;
	    }

	    if ( ! Settings_GetVehicleFadeValue(playerid)  ) {

	    	return true ;
	    }

        if(streetTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW) {
	 		vehicleTextDraw[playerid] = CreatePlayerTextDraw(playerid, 626.0000, 426.0000, desc);
	 	}
	 	else CreatePlayerTextDraw(playerid, 626.0000, 386.0000, desc);
		PlayerTextDrawFont(playerid, vehicleTextDraw[playerid], 2);
		PlayerTextDrawLetterSize(playerid, vehicleTextDraw[playerid], 0.4000, 1.5000);
		PlayerTextDrawAlignment(playerid, vehicleTextDraw[playerid], 3);
		PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4DFF);
		PlayerTextDrawSetShadow(playerid, vehicleTextDraw[playerid], 0);
		PlayerTextDrawSetOutline(playerid, vehicleTextDraw[playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 255);
		PlayerTextDrawSetProportional(playerid, vehicleTextDraw[playerid], 1);
		PlayerTextDrawTextSize(playerid, vehicleTextDraw[playerid], 0.0000, 640.0000);


	    PlayerVehicleAlertFading [ playerid ] = true ;
	    PlayerVehicleAlertHudTick [ playerid ] = 0 ;

	    defer VehicleAlertOpacity_FadeIn(playerid);
	}

    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {


	if ( Settings_GetVehicleFadeValue(playerid)  ) {


		new vehicleid = GetPlayerVehicleID(playerid) ;

		switch ( newstate)  {

			case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER : {

				ShowVehicleAlert(playerid, ReturnVehicleName(vehicleid));
			}

			case PLAYER_STATE_ONFOOT: {
				HideVehicleAlert(playerid);
			}
		}
	}

	#if defined vehalert_OnPlayerStateChange
		return vehalert_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange vehalert_OnPlayerStateChange
#if defined vehalert_OnPlayerStateChange
	forward vehalert_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

timer VehicleAlertOpacity_FadeIn[100](playerid) {

	if ( !Settings_GetVehicleFadeValue(playerid)  ) {
		return true;
	}

	if (! IsPlayerSpawned(playerid)) {

		HideVehicleAlert(playerid);
		return true ;
	}

	if ( PlayerVehicleAlertFading [ playerid ] ) {

		PlayerTextDrawHide(playerid, vehicleTextDraw[playerid]);

		switch ( PlayerVehicleAlertHudTick [ playerid ] ) {

			case 0: {
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D11);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000011);
			}
			case 1:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D22);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000022);
			}
			case 2:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D33);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000033);
			}
			case 3:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D44);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000044);
			}
			case 4:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D55);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000055);
			}
			case 5:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D66);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000066);
			}
			case 6:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D77);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000077);
			}
			case 7:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D88);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000088);
			}
			case 8:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D99);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000099);
			}
			case 9:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4DFF);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x000000FF);
			}
			case 10: {

				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4DFF);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x000000FF);
				PlayerTextDrawShow(playerid, vehicleTextDraw[playerid]);

				// Fade Out
				PlayerVehicleAlertHudTick [ playerid ] = 10 ;
				defer VehicleAlertOpacity_FadeOut[4500](playerid);

				return true ;
			}
		}

		PlayerTextDrawShow(playerid, vehicleTextDraw[playerid]);

		PlayerVehicleAlertHudTick [ playerid ] ++ ;
		defer VehicleAlertOpacity_FadeIn(playerid);
	}

	return true ;
}

timer VehicleAlertOpacity_FadeOut[100](playerid) {
	if ( !Settings_GetVehicleFadeValue(playerid)  ) {
		return true;
	}
	if (! IsPlayerSpawned(playerid)) {

		HideVehicleAlert(playerid);
		return true ;
	}

	if ( PlayerVehicleAlertFading [ playerid ] ) {

		PlayerTextDrawHide(playerid, vehicleTextDraw[playerid]);

		switch ( PlayerVehicleAlertHudTick [ playerid ] ) {

			case 0: {

				PlayerVehicleAlertHudTick [ playerid ] = 0 ;
	    		PlayerVehicleAlertFading [ playerid ] = false ;

				HideVehicleAlert(playerid);

				return true ;
			}

			case 1: {
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D11);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000011);
			}
			case 2:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D22);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000022);
			}
			case 3:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D33);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000033);
			}
			case 4:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D44);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000044);
			}
			case 5:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D55);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000055);
			}
			case 6:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D66);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000066);
			}
			case 7:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D77);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000077);
			}
			case 8:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D88);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000088);
			}
			case 9:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4D99);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x00000099);
			}
			case 10:{
				PlayerTextDrawColor(playerid, vehicleTextDraw[playerid], 0x427D4DFF);
				PlayerTextDrawBackgroundColor(playerid, vehicleTextDraw[playerid], 0x000000FF);
			}
		}

		PlayerTextDrawShow(playerid, vehicleTextDraw[playerid]);
		PlayerVehicleAlertHudTick [ playerid ] -- ;
		defer VehicleAlertOpacity_FadeOut(playerid);
	}

	return true ;
}

HideVehicleAlert(playerid)
{	
	if ( !Settings_GetVehicleFadeValue(playerid)  ) {
		return true;
	}
    if(vehicleTextDraw[playerid] == PlayerText:INVALID_TEXT_DRAW)
        return 1;

    PlayerTextDrawDestroy(playerid, vehicleTextDraw[playerid]);
    vehicleTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;

    return 1;
}

public OnPlayerDisconnect(playerid, reason) {

    if(vehicleTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW){
        vehicleTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
	
	#if defined vehiclealert_OnPlayerDisconnect
		return vehiclealert_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect vehiclealert_OnPlayerDisconnect
#if defined vehiclealert_OnPlayerDisconnect
	forward vehiclealert_OnPlayerDisconnect(playerid, reason);
#endif