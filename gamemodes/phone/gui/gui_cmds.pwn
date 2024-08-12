
CMD:phone(playerid) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You don't have a phone! Head to an electronics store to buy one!" ) ;

		return true ;
	}

	PlayerVar [ playerid ] [ player_viewphone ] = ! PlayerVar [ playerid ] [ player_viewphone ] ;

	if ( PlayerVar [ playerid ] [ player_viewphone ] ) {

		Phone_FixBuggedBackground(playerid); // Temp mitigation for previous issue

		new background = Character [ playerid ] [ E_CHARACTER_PHONE_BACKGROUND ] ;
		new colour = Character [ playerid ] [ E_CHARACTER_PHONE_COLOUR ]  ;

		if ( colour >= sizeof ( Phone_Colours ) ) {

			colour = sizeof ( Phone_Colours ) - 1 ;
		}

		PlayerTextDrawSetString(playerid, ptd_ph_design[playerid][5], Phone_Backgrounds [ background ] [ E_PH_DATA_TXD ]);
		PlayerTextDrawSetString(playerid, ptd_ph_design[playerid][0], Phone_Colours [ colour ] [ E_PH_DATA_TXD ]);

		// Stop helmets being removed
		new vehicleid = GetPlayerVehicleID(playerid);
		if (!PlayerVar[playerid][player_hasseatbelton] || !vehicleid || !IsABike(vehicleid))
		{
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM, Phone_Colours [ colour ] [ E_PH_DATA_MODEL ], E_ATTACH_BONE_HAND_R, 0.1,0.0,-0.02,95.0,-180.0,0.0,1.0,1.0,1.0);
		}
		

		for ( new i, j = 13; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ i ] ) ;
		}

		if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] ) {
			for ( new i = 0, j = 5; i < j ; i ++ ) {

				PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ i ] ) ;
			}

			PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ 12 ] ) ;
		}

		else if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] ) {

			for ( new i, j = 13; i < j ; i ++ ) {

				PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ i ] ) ;
			}	

		}

		ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "*", "takes out their cellphone.", .annonated=true);
		SendServerMessage ( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", "Use /pc to (re-)display mouse pointer." ) ;
	}

	else {

		for (new i, j = 13; i < j ; i ++ ) {
			PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ i ] ) ;
		}

		for (new i, j = 3; i < j ; i ++ ) {
			PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ i ] ) ;
		}

		CancelSelectTextDraw(playerid) ;

		// Stop helmets being taken
		new vehicleid = GetPlayerVehicleID(playerid);
		if (!PlayerVar[playerid][player_hasseatbelton] || !vehicleid || !IsABike(vehicleid))
		{
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM ) ;
		}

		ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "*", "puts away their cellphone.", .annonated=true);
	}

	return true ;
}

CMD:ph(playerid) return cmd_phone(playerid);

CMD:pc(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	SelectTextDraw(playerid, PHONE_COLOUR_OK);
	return true ;
}


CMD:phoneanim(playerid) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	//ApplyAnimation(playerid,"PED", "phone_out", 4.1, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid,"PED", "phone_in", 4.1, 0, 0, 0, 1, 1);
	defer Phone_FinalizeCallAnimation(playerid);
	return true ;
}

CMD:phanim(playerid) return cmd_phoneanim(playerid);

timer Phone_FinalizeCallAnimation[1250](playerid) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	ApplyAnimation(playerid,"PED", "phone_talk", 4.1, true, 0, 0, 1, 1);

	return true ;
}

