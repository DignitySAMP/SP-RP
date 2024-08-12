

CMD:enter(playerid) {
	if ( IsPlayerIncapacitated(playerid, true) ) {
    
        return true ;
    }

	if (IsPlayerFading(playerid)) return true; // Make them wait first

    if ( ! Gym_Enter(playerid) ) {

		Property_Enter(playerid);
	}
	return true ;
}

CMD:exit(playerid) {
	if ( IsPlayerIncapacitated(playerid, true) ) {
    
        return true ;
    }

	if (IsPlayerFading(playerid)) return true; // Make them wait first

    if ( ! Gym_Exit(playerid) ) {

		Property_Exit(playerid);
	}
	return true ;
}

Property_Enter(playerid) {
	new index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;

	if ( index == INVALID_PROPERTY_ID ) {

		SendClientMessage(playerid, -1, "You're not near a valid property you can enter.");
		return true ;
	}

	if ( !IsPlayerInRangeOfPoint ( playerid, 5.0, Property [ index ] [ E_PROPERTY_EXT_X ], Property [ index ] [ E_PROPERTY_EXT_Y ], Property [ index ] [ E_PROPERTY_EXT_Z ] )) 
	{
		// Forbid exit when not outside
		return true ;
	}

	if ( Property [ index ] [ E_PROPERTY_LOCKED ] ) {

		return SendClientMessage(playerid, -1, "This property is locked.");
	}

	if ( Property [ index ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendClientMessage(playerid, -1, "This business type can't be entered.");
	}

	switch ( Property [ index ] [ E_PROPERTY_BUY_TYPE ] ) {
		case E_BUY_TYPE_DEALERSHIP, E_BUY_TYPE_GASSTATION, E_BUY_TYPE_MODSHOP: {
			return SendClientMessage(playerid, -1, "This business type can't be entered.");
		}
	}

	PlayerVar [ playerid ] [ E_PLAYER_LAST_PROPERTY_ENTERED ] = index ;
	PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = index ;

	if ( Property [ index ] [ E_PROPERTY_FEE ] ) 
	{
		if (  Property [ index ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] || Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ] == Property [ index ] [ E_PROPERTY_ID ] ) 
		{
			SendClientMessage(playerid, COLOR_YELLOW, sprintf("You weren't charged the entrance fee of $%s to enter this property as you own or rent it.",  IntegerWithDelimiter(Property [ index ] [ E_PROPERTY_FEE ] ) ) ) ;
		}
		else
		{

			if ( GetPlayerCash ( playerid ) < Property [ index ] [ E_PROPERTY_FEE ] ) {

				return SendClientMessage(playerid, COLOR_YELLOW, sprintf("You need at least $%s to enter this property.", IntegerWithDelimiter(Property [ index ] [ E_PROPERTY_FEE ] ) ) ) ;
			}

			TakePlayerCash ( playerid, Property [ index ] [ E_PROPERTY_FEE ] ) ;
	//		Property_AddMoneyToTill(playerid, Property [ index ] [ E_PROPERTY_FEE ], .margin=false ) ; 
			SendClientMessage(playerid, COLOR_YELLOW, sprintf("You've been charged the entrance fee of $%s to enter this property.",  IntegerWithDelimiter(Property [ index ] [ E_PROPERTY_FEE ] ) ) ) ;

			new query [ 96 ] ;

			Property [ index ] [ E_PROPERTY_COLLECT ] += Property [ index ] [ E_PROPERTY_FEE ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_collect = %d WHERE property_id = %d", 

				Property [ index ] [ E_PROPERTY_COLLECT ], Property [ index ] [ E_PROPERTY_ID ]
			) ;
		}

	}

	SetPlayerInterior(playerid, Property [ index ] [ E_PROPERTY_INT_INT ]) ;
	SetPlayerVirtualWorld(playerid, Property [ index ] [ E_PROPERTY_ID ]) ;
	//SOLS_SetPlayerPos(playerid, Property [ index ] [ E_PROPERTY_INT_X ], Property [ index ] [ E_PROPERTY_INT_Y ], Property [ index ] [ E_PROPERTY_INT_Z ] + 0.1 );
	SOLS_SetPosWithFade(playerid, Property [ index ] [ E_PROPERTY_INT_X ], Property [ index ] [ E_PROPERTY_INT_Y ], Property [ index ] [ E_PROPERTY_INT_Z ], FormatPropertyName(index));

	if ( Property [ index ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_BIZ ) {
		
		if(strcmp(Property [ index ] [ E_PROPERTY_NAME ], "Undefined", true)) {

			new name_style[64];

			switch(Property [ index ] [ E_PROPERTY_NAME_COLOR ]) {

				case 0: format ( name_style, sizeof ( name_style ), "~w~" ) ;
				case 1: format ( name_style, sizeof ( name_style ), "~r~" ) ;
				case 2: format ( name_style, sizeof ( name_style ), "~g~" ) ;
				case 3: format ( name_style, sizeof ( name_style ), "~b~" ) ;
				case 4: format ( name_style, sizeof ( name_style ), "~y~" ) ;
				case 5: format ( name_style, sizeof ( name_style ), "~p~" ) ;
				case 6: format ( name_style, sizeof ( name_style ), "~l~" ) ;
			}

           	//ShowPlayerSubtitle(playerid, sprintf("Welcome to %s%s", name_style, Property [ index ] [ E_PROPERTY_NAME ]), .showtime = 4000 );
			ShowZoneMessage(playerid, sprintf("%s%s", name_style, Property [ index ] [ E_PROPERTY_NAME ]), true);

		}
	}

	UpdateTabListForPlayer ( playerid );
	UpdateTabListForOthers ( playerid );

	PlayerPlaySound(playerid, 1, 0, 0, 0);

	if ( GetPlayerAdminLevel ( playerid ) > ADMIN_LVL_JUNIOR && PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

		SendClientMessage(playerid, COLOR_YELLOW, 
			sprintf("[ADMIN/ENTER_PROP]: [ID %d] [SQL: %d] [Owner: %d] [Type: %d] [Buy Type: %d]", index, Property [ index ] [ E_PROPERTY_ID ], Property [ index ] [ E_PROPERTY_OWNER ],
			Property [ index ] [ E_PROPERTY_TYPE ], Property [ index ] [ E_PROPERTY_BUY_TYPE ]
	 	) ) ;
	}

	if (  Property [ index ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

		SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "DEDEDE", sprintf("You have $%s waiting for you in your property till. (/propertycollect)", IntegerWithDelimiter ( Property [ index ] [ E_PROPERTY_COLLECT ] ) ) ) ;
	}

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Entered Property %d (SQL: %d)", index, Property [ index ] [ E_PROPERTY_ID ]));

	return true ;
}


Property_Exit(playerid) {
	new index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( index == INVALID_PROPERTY_ID ) {

		SendClientMessage(playerid, -1, "You're not near a valid property you can exit.");
		return true ;
	}

	if ( !IsPlayerInRangeOfPoint ( playerid, 5.0, Property [ index ] [ E_PROPERTY_INT_X ], Property [ index ] [ E_PROPERTY_INT_Y ], Property [ index ] [ E_PROPERTY_INT_Z ] )) 
	{
		// Forbid exit when not inside
		return true ;
	}

	SetPlayerInterior(playerid, Property [ index ] [ E_PROPERTY_EXT_INT ] ) ;
	SetPlayerVirtualWorld(playerid, Property [ index ] [ E_PROPERTY_EXT_VW ] ) ;
	//SOLS_SetPlayerPos(playerid, Property [ index ] [ E_PROPERTY_EXT_X ], Property [ index ] [ E_PROPERTY_EXT_Y ], Property [ index ] [ E_PROPERTY_EXT_Z ] + 0.1);
	SOLS_SetPosWithFade(playerid, Property [ index ] [ E_PROPERTY_EXT_X ], Property [ index ] [ E_PROPERTY_EXT_Y ], Property [ index ] [ E_PROPERTY_EXT_Z ]);

	UpdateTabListForPlayer ( playerid );
	UpdateTabListForOthers ( playerid );
	PlayerVar [ playerid ] [ E_PLAYER_LAST_PROPERTY_ENTERED ] = INVALID_PROPERTY_ID ;
	PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] = INVALID_PROPERTY_ID ;


	if ( GetPlayerAdminLevel ( playerid ) > ADMIN_LVL_JUNIOR && PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

		SendClientMessage(playerid, COLOR_YELLOW, 
			sprintf("[ADMIN/LEAVE_PROP]: [ID %d] [SQL: %d] [Owner: %d] [Type: %d] [Buy Type: %d]", index, Property [ index ] [ E_PROPERTY_ID ], Property [ index ] [ E_PROPERTY_OWNER ],
			Property [ index ] [ E_PROPERTY_TYPE ], Property [ index ] [ E_PROPERTY_BUY_TYPE ]
	 	) ) ;
	}

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Exited Property %d (SQL: %d)", index, Property [ index ] [ E_PROPERTY_ID ]));

	return true ;
}
 

Property_GetClosestEntity( playerid, type, Float: radius = PROPERTY_NEAREST_DIST )  {

	new Float: dis = 99999.99, Float: dis2, index = INVALID_PROPERTY_ID ;

	if(type == PROPERTY_NEAR_ENTER) { // Checking for EXTERIOR point!
		
		foreach(new x: Properties) {

			if ( Property [ x ] [ E_PROPERTY_ID ] != INVALID_PROPERTY_ID ) {

				dis2 = GetPlayerDistanceFromPoint(playerid, 
					Property [ x ] [ E_PROPERTY_EXT_X ], 
					Property [ x ] [ E_PROPERTY_EXT_Y ], 
					Property [ x ] [ E_PROPERTY_EXT_Z ]
				);

				if(dis2 < dis && GetPlayerInterior ( playerid ) == Property [ x ] [ E_PROPERTY_EXT_INT ] 
					&& GetPlayerVirtualWorld ( playerid ) == Property [ x ] [ E_PROPERTY_EXT_VW ] ) {

					dis = dis2;
					index = x;
				}
			}
		}

		if ( dis <= radius ) {

			return index;
		}

		else return INVALID_PROPERTY_ID ;
	}
 
	else if(type == PROPERTY_NEAR_EXIT) { // Checking for INTERIOR point!

		foreach(new x: Properties) {

			if ( Property [ x ] [ E_PROPERTY_ID ] != INVALID_PROPERTY_ID ) {

				dis2 = GetPlayerDistanceFromPoint(playerid, 
					Property [ x ] [ E_PROPERTY_INT_X ], 
					Property [ x ] [ E_PROPERTY_INT_Y ], 
					Property [ x ] [ E_PROPERTY_INT_Z ]
				);

				if(dis2 < dis && GetPlayerInterior ( playerid ) == Property [ x ] [ E_PROPERTY_INT_INT ] 
					&& GetPlayerVirtualWorld ( playerid ) == Property [ x ] [ E_PROPERTY_ID ] ) {

					dis = dis2;
					index = x;
				}
			}
		}

		if ( dis <= radius ) {

			return index;
		}

		else return INVALID_PROPERTY_ID ;
		
	} else if (type == PROPERTY_NEAR_ANYWHERE) {

		index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER, radius ) ;

		if ( index == INVALID_PROPERTY_ID ) {
			index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT, radius ) ;
		}

		return index;

	}

	return INVALID_PROPERTY_ID ;
}

Property_GetInside( playerid, Float: radius = 100.0 )  {

	new Float: dis = 99999.99, Float: dis2, index = INVALID_PROPERTY_ID ;

	// Checking for INTERIOR point!
	foreach(new x: Properties) {

		if ( Property [ x ] [ E_PROPERTY_ID ] != INVALID_PROPERTY_ID ) {

			dis2 = GetPlayerDistanceFromPoint(playerid, 
				Property [ x ] [ E_PROPERTY_INT_X ], 
				Property [ x ] [ E_PROPERTY_INT_Y ], 
				Property [ x ] [ E_PROPERTY_INT_Z ]
			);

			if(dis2 < dis && GetPlayerInterior ( playerid ) == Property [ x ] [ E_PROPERTY_INT_INT ] 
				&& GetPlayerVirtualWorld ( playerid ) == Property [ x ] [ E_PROPERTY_ID ] ) {

	            dis = dis2;
	            index = x;
			}
		}
	}

	if ( dis <= radius ) {

		return index;
	}

	return INVALID_PROPERTY_ID ;
}