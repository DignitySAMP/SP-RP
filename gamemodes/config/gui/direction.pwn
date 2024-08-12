new PlayerText: gui_direction[MAX_PLAYERS] [ 3 ] = { PlayerText: INVALID_TEXT_DRAW, ... } ;

public OnPlayerConnect(playerid) {
	
	gui_direction [ playerid ] [0] = CreatePlayerTextDraw(playerid, 154.0000, 401.0000, "Idlewood~n~Winona Avenue~n~515, Los Santos");
	PlayerTextDrawFont(playerid, gui_direction [ playerid ] [0], 2);
	PlayerTextDrawLetterSize(playerid, gui_direction [ playerid ] [0], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, gui_direction [ playerid ] [0], 2);
	PlayerTextDrawColor(playerid, gui_direction [ playerid ] [0], -1378294017);
	PlayerTextDrawSetShadow(playerid, gui_direction [ playerid ] [0], 0);
	PlayerTextDrawSetOutline(playerid, gui_direction [ playerid ] [0], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_direction [ playerid ] [0], 255);
	PlayerTextDrawSetProportional(playerid, gui_direction [ playerid ] [0], 1);
	PlayerTextDrawTextSize(playerid, gui_direction [ playerid ] [0], 0.0000, 150.0000);

	gui_direction [ playerid ] [1] = CreatePlayerTextDraw(playerid, 154.0000, 369.0000, "east");
	PlayerTextDrawFont(playerid, gui_direction [ playerid ] [1], 2);
	PlayerTextDrawLetterSize(playerid, gui_direction [ playerid ] [1], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, gui_direction [ playerid ] [1], 2);
	PlayerTextDrawColor(playerid, gui_direction [ playerid ] [1], -1378294017);
	PlayerTextDrawSetShadow(playerid, gui_direction [ playerid ] [1], 0);
	PlayerTextDrawSetOutline(playerid, gui_direction [ playerid ] [1], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_direction [ playerid ] [1], 255);
	PlayerTextDrawSetProportional(playerid, gui_direction [ playerid ] [1], 1);
	PlayerTextDrawTextSize(playerid, gui_direction [ playerid ] [1], 0.0000, 150.0000);

	gui_direction [ playerid ] [2] = CreatePlayerTextDraw(playerid, 154.0000, 378.0000, "~y~E");
	PlayerTextDrawFont(playerid, gui_direction [ playerid ] [2], 1);
	PlayerTextDrawLetterSize(playerid, gui_direction [ playerid ] [2], 0.6000, 2.5000);
	PlayerTextDrawAlignment(playerid, gui_direction [ playerid ] [2], 2);
	PlayerTextDrawColor(playerid, gui_direction [ playerid ] [2], -1);
	PlayerTextDrawSetShadow(playerid, gui_direction [ playerid ] [2], 0);
	PlayerTextDrawSetOutline(playerid, gui_direction [ playerid ] [2], 1);
	PlayerTextDrawBackgroundColor(playerid, gui_direction [ playerid ] [2], 255);
	PlayerTextDrawSetProportional(playerid, gui_direction [ playerid ] [2], 1);
	PlayerTextDrawTextSize(playerid, gui_direction [ playerid ] [2], 0.0000, 150.0000);

	#if defined direction_OnPlayerConnect
		return direction_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect direction_OnPlayerConnect
#if defined direction_OnPlayerConnect
	forward direction_OnPlayerConnect(playerid);
#endif

public OnPlayerStateChange(playerid, newstate, oldstate) {

	if(Settings_GetDirectionValue(playerid)  ) {
		if(newstate == PLAYER_STATE_DRIVER) {
			
			PlayerTextDrawShow(playerid, gui_direction [ playerid ] [ 0 ] );
			PlayerTextDrawShow(playerid, gui_direction [ playerid ] [ 1 ] );
			PlayerTextDrawShow(playerid, gui_direction [ playerid ] [ 2 ] );
		}
		else if(newstate == PLAYER_STATE_ONFOOT) {
			
			PlayerTextDrawHide(playerid, gui_direction [ playerid ] [ 0 ] );
			PlayerTextDrawHide(playerid, gui_direction [ playerid ] [ 1 ] );
			PlayerTextDrawHide(playerid, gui_direction [ playerid ] [ 2 ] );

		}
	}
	
	#if defined dirct_OnPlayerStateChange
		return dirct_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange dirct_OnPlayerStateChange
#if defined dirct_OnPlayerStateChange
	forward dirct_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerDisconnect(playerid, reason) {

	PlayerTextDrawDestroy(playerid, gui_direction [ playerid ] [ 0 ] );
	PlayerTextDrawDestroy(playerid, gui_direction [ playerid ] [ 1 ] );
	PlayerTextDrawDestroy(playerid, gui_direction [ playerid ] [ 2 ] );

	#if defined direction_OnPlayerDisconnect
		return direction_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect direction_OnPlayerDisconnect
#if defined direction_OnPlayerDisconnect
	forward direction_OnPlayerDisconnect(playerid, reason);
#endif

GUI_UpdateDirectionLabels(playerid) {



	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && Settings_GetDirectionValue(playerid)  ) {
		new Float:x, Float: y, Float: z ;
		GetPlayerPos(playerid, x, y, z ) ;

		new address [ 64 ], zone [ 64 ], area [ 12 ], city [ 64 ] ;


		GetPlayerAddress(x, y, address) ;
		GetCoords2DZone(x, y, zone, sizeof ( zone ));
		GetPlayerAreaZone(x, y, area ) ;
		GetCoords2DMainZone(x, y, city, sizeof ( city ) ) ;

		PlayerTextDrawHide(playerid,gui_direction[playerid][0]);

		new string [ 256 ] ;

		format ( string, sizeof ( string ), "%s~n~%s, %s~n~%s", address, zone, area, city ) ;
		PlayerTextDrawSetString(playerid, gui_direction [ playerid ] [0], string);

		PlayerTextDrawShow(playerid,gui_direction[playerid][0]);

		new Float: angle ;

		if ( ! IsPlayerInAnyVehicle(playerid) ) {
			GetPlayerFacingAngle(playerid, angle ) ;
		}

		else {
			GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
		}

		new result = floatround ( angle ) ;

		new index ;

		switch ( result ) {

			case 0 .. 25: 		index = 0 ; 
			case 26 .. 65: 		index = 7 ; 
			case 66 .. 134: 	index = 6 ; 
			case 135 .. 160: 	index = 5 ; 
			case 161 .. 214: 	index = 4 ; 
			case 215 .. 250: 	index = 3 ; 
			case 251 .. 290: 	index = 2 ; 
			case 291 .. 340: 	index = 1 ; 
			case 341 .. 360: 	index = 0 ; 
		}

		new const compass_direction[][] = {
			"N", "NE", "E", "SE", "S", "SW", "W", "NW"
		};

		new const compass_desc[][32] = {
			"north", "north-east", "east", "south-east", "south", "south-west", "west", "north-west"
		};


		PlayerTextDrawHide(playerid, gui_direction[playerid][1]);
		PlayerTextDrawHide(playerid, gui_direction[playerid][2]);

		PlayerTextDrawSetString(playerid,gui_direction [ playerid ] [2], sprintf("~y~%s", compass_direction [ index ] [ 0 ] ));
		PlayerTextDrawSetString(playerid,gui_direction [ playerid ] [1], sprintf("%s", compass_desc [ index ] [ 0 ] ));

		PlayerTextDrawShow(playerid, gui_direction[playerid][1]);
		PlayerTextDrawShow(playerid, gui_direction[playerid][2]);
	}
	return true ;
}