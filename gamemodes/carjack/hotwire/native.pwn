
public OnPlayerClickTextDraw(playerid, Text:clickedid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING ] ) {

		new vehicleid = GetPlayerVehicleID(playerid) ;

		if ( vehicleid == INVALID_VEHICLE_ID ) {
			Hotwire_CloseMenu(playerid);
			return true;
		}

		if ( GetPlayerState(playerid) != PLAYER_STATE_DRIVER ) {
			Hotwire_CloseMenu(playerid);
			return true;
		}

		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

		if ( veh_enum_id == -1 ) {
			Hotwire_CloseMenu(playerid);
			return true ;
		}

		if ( IsPlayerIncapacitated(playerid, false)) {
			Hotwire_CloseMenu(playerid);
			return true ;
		}

		PlayerPlaySound(playerid, 0, 0, 0, 0);

		if ( clickedid == hotwire_gui [ 1 ] ) {

			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ] ) ) ;
									
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 0 ] ;
			
			E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] = hotwire_player_gui[playerid] [ 0 ] ;
			E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] = hotwire_gui [ 1 ] ;

		}
		else if ( clickedid == hotwire_gui [ 2 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ] ) ) ;

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 1 ] ;
			
			E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] = hotwire_player_gui[playerid] [ 1 ] ;
			E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] = hotwire_gui [ 2 ] ;
		}
		else if ( clickedid == hotwire_gui [ 3 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ] ) ) ;
												
			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 2 ] ;
			
			E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] = hotwire_player_gui[playerid] [ 2 ] ;
			E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] = hotwire_gui [ 3 ] ;
		}
		else if ( clickedid == hotwire_gui [ 4 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ] ) ) ;

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 3 ] ;
			
			E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] = hotwire_player_gui[playerid] [ 3 ] ;
			E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] = hotwire_gui [ 4 ] ;
		}
		else if ( clickedid == hotwire_gui [ 5 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ] ) ) ;

			PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_A ] [ 4 ] ;
			
			E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] = hotwire_player_gui[playerid] [ 8 ] ;
			E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] = hotwire_gui [ 5 ] ;
		}

		/* Start of second row */ 
		else if ( clickedid == hotwire_gui [ 6 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ] ) ) ;
			
			if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] == PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 3 ] ) {

				PlayerTextDrawHide(playerid, E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] ) ;
				PlayerTextDrawHide(playerid, hotwire_player_gui[playerid] [ 4 ] ) ;
				TextDrawHideForPlayer(playerid, hotwire_gui [ 6 ] ) ;
				TextDrawHideForPlayer(playerid, E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] ) ;
				-- PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] ;
				return Hotwire_CheckProgress(playerid);
			}

			else PlayerPlaySound(playerid, 41604, 0, 0, 0);

			
		}
		else if ( clickedid == hotwire_gui [ 7 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ] ) ) ;
			
			if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] == PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 0 ] ) {

				PlayerTextDrawHide(playerid, E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] ) ;
				PlayerTextDrawHide(playerid, hotwire_player_gui[playerid] [ 5 ] ) ;
				TextDrawHideForPlayer(playerid, hotwire_gui [ 7 ] ) ;
				TextDrawHideForPlayer(playerid, E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] ) ;
				-- PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] ;
				return Hotwire_CheckProgress(playerid);
			}
			else PlayerPlaySound(playerid, 41604, 0, 0, 0);

			
		}
		else if ( clickedid == hotwire_gui [ 8 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ] ) ) ;
						
			if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] == PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 1 ] ) {

				PlayerTextDrawHide(playerid, E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] ) ;
				PlayerTextDrawHide(playerid, hotwire_player_gui[playerid] [ 6 ] ) ;
				TextDrawHideForPlayer(playerid, hotwire_gui [ 8 ] ) ;
				TextDrawHideForPlayer(playerid, E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] ) ;
				-- PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] ;
				return Hotwire_CheckProgress(playerid);
			}
			else PlayerPlaySound(playerid, 41604, 0, 0, 0);

			
		}
		else if ( clickedid == hotwire_gui [ 9 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ] ) ) ;
						
			if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] == PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 2 ] ) {

				PlayerTextDrawHide(playerid, E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] ) ;
				PlayerTextDrawHide(playerid, hotwire_player_gui[playerid] [ 7 ] ) ;
				TextDrawHideForPlayer(playerid, hotwire_gui [ 9 ] ) ;
				TextDrawHideForPlayer(playerid, E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] ) ;
				-- PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] ;
				return Hotwire_CheckProgress(playerid);
			}
			else PlayerPlaySound(playerid, 41604, 0, 0, 0);

			
		}
		else if ( clickedid == hotwire_gui [ 10 ] ) {
			//SendClientMessage(playerid, Hotwire_GetWireColor ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ]), sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ] ) ) ;
			
			if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] == PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_B ] [ 4 ] ) {

				PlayerTextDrawHide(playerid, E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] ) ;
				PlayerTextDrawHide(playerid, hotwire_player_gui[playerid] [ 9 ] ) ;
				TextDrawHideForPlayer(playerid, hotwire_gui [ 10 ] ) ;
				TextDrawHideForPlayer(playerid, E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] ) ;
				-- PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] ;
				return Hotwire_CheckProgress(playerid);
			}
			else PlayerPlaySound(playerid, 41604, 0, 0, 0);
		}

	}

	#if defined hotwire_OnPlayerClickTextDraw
		return hotwire_OnPlayerClickTextDraw(playerid, Text: clickedid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw hotwire_OnPlayerClickTextDraw
#if defined hotwire_OnPlayerClickTextDraw
	forward hotwire_OnPlayerClickTextDraw(playerid, Text: clickedid);
#endif