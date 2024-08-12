SpectateTick(playerid, targetid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] == INVALID_PLAYER_ID ) {

		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] != targetid ) {

		return true ;
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) {

		if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_JUNIOR ) {

			return true ;
		}

		if ( targetid == INVALID_PLAYER_ID ) {

			return true ;
		}

		UpdateSpectatorPanel(playerid, targetid) ;

		if ( GetPlayerInterior ( playerid ) != GetPlayerInterior ( targetid ) ) {

			SetPlayerInterior ( playerid, GetPlayerInterior ( targetid ) ) ;
		}
		
		if ( GetPlayerVirtualWorld ( playerid ) != GetPlayerVirtualWorld ( targetid ) ) {

			SetPlayerVirtualWorld ( playerid, GetPlayerVirtualWorld ( targetid ) ) ;
		}

		if ( IsPlayerInAnyVehicle(targetid)) {
			if ( PlayerVar [ playerid ] [ E_PLAYER_SPEC_VEH ] != GetPlayerVehicleID(targetid) ) {

				PlayerVar [ playerid ] [ E_PLAYER_SPEC_VEH ] = GetPlayerVehicleID(targetid) ;
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
				PlayerVar [ playerid ] [ E_PLAYER_SPEC_RESYNC ] = false ;
			}
		}

		else {
			if ( ! PlayerVar [ playerid ] [ E_PLAYER_SPEC_RESYNC ] ) {
				PlayerSpectatePlayer(playerid, targetid);
				PlayerVar [ playerid ] [ E_PLAYER_SPEC_VEH ] = INVALID_VEHICLE_ID ;
				PlayerVar [ playerid ] [ E_PLAYER_SPEC_RESYNC ] = true ;
			}
		}


		//if ( ++ PlayerVar [ playerid ] [ E_PLAYER_SPEC_TAG_RESYNC ] >= 30 ) {
    	//	UpdateTabListForPlayer ( playerid );
    	//	PlayerVar [ playerid ] [ E_PLAYER_SPEC_TAG_RESYNC ] = 0 ;
    	//}
	}

	else {

 		PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);

	    PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] = INVALID_PLAYER_ID ;
	  	PlayerVar [ playerid ] [ E_PLAYER_SPEC_RESYNC ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_SPEC_VEH ] = INVALID_VEHICLE_ID ;

	 	TogglePlayerSpectating(playerid, false);

	 	Spectate_RefundAdminGuns(playerid);

		for ( new i, j = 5; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid,  gui_spec_label [ playerid ] [ i ] ) ;
		}

		SetPlayerInterior ( playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_INT ] ) ;
	    SetPlayerVirtualWorld( playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_VW ] ) ;
	    SOLS_SetPosWithFade ( playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_X ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Y ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Z ] ) ;

		return SendServerMessage( playerid, COLOR_RED, "Warning", "A3A3A3",  "You are no longer in spectator mode for some reason (target might have quit), resetting your state." );
	}

	return true ;
}


CMD:spectate(playerid, params[]) {
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage( playerid, COLOR_RED, "Warning", "A3A3A3",  "You need to be an administrator in order to be able to do this!" );
	}


	if (!isnull(params) && !strcmp(params, "off", true))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING || PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] == INVALID_PLAYER_ID) {
			return SendServerMessage( playerid, COLOR_RED, "Warning", "A3A3A3",  "You are not spectating any player." );
	    }

	    PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);

	    PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] = INVALID_PLAYER_ID ;
	  	PlayerVar [ playerid ] [ E_PLAYER_SPEC_RESYNC ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_SPEC_VEH ] = INVALID_VEHICLE_ID ;

	 	TogglePlayerSpectating(playerid, false);

	 	Spectate_RefundAdminGuns(playerid);

		for ( new i, j = 5; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid,  gui_spec_label [ playerid ] [ i ] ) ;
		}

		SetPlayerInterior ( playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_INT ] ) ;
	    SetPlayerVirtualWorld( playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_VW ] ) ;
	    //SOLS_SetPlayerPos ( playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_X ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Y ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Z ], false ) ;
		//Streamer_UpdateEx(playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_X ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Y ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Z ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_VW ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_INT ], STREAMER_TYPE_OBJECT, 1000, 1);
		
		SOLS_SetPosWithFade(playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_X ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Y ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Z ]);
		// Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

		return SendServerMessage( playerid, COLOR_RED, "Warning", "A3A3A3",  "You are no longer in spectator mode." );
	}

	new userid;

	if (sscanf(params, "k<player>", userid)) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/spectate [playerid/name] - Type \"/spectate off\" to stop spectating." );
	}

	if (!IsPlayerConnected(userid)) {

		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You have specified an invalid player." );
	}

	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) {

		GetPlayerPos(playerid, PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_X ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Y ], PlayerVar [ playerid ] [ E_PLAYER_SPEC_POS_Z ]);

		PlayerVar [ playerid ] [ E_PLAYER_SPEC_INT ] = GetPlayerInterior(playerid);
		PlayerVar [ playerid ] [ E_PLAYER_SPEC_VW ] = GetPlayerVirtualWorld(playerid);

		for ( new i, j = 5; i < j ; i ++ ) {

			PlayerTextDrawShow(playerid, gui_spec_label [ playerid ] [ i ] ) ;
		}

		Spectate_SaveAdminGuns(playerid) ;
	}

	SetPlayerInterior(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));

	TogglePlayerSpectating(playerid, 1);
	PlayerSpectatePlayer(playerid, userid);

	PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] = userid ;

	new string [ 256 ] ;
	format ( string, sizeof ( string ), "{[ %d %s spectates %d %s ]}", playerid,  Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], userid, ReturnMixedName(userid) ) ;
	SendManagerMessage(string) ;

	if ( Player_GetNoteCount(userid) )
		return SendServerMessage ( playerid, COLOR_SECURITY, "Notes", "A3A3A3",  sprintf("This player has %d active admin notes. (/notes %d)", Player_GetNoteCount(userid), userid));

	return 1;
}
CMD:spec ( playerid, params [] ) {

	return cmd_spectate ( playerid, params ) ;
}

