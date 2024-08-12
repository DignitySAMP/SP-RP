new Text: E_GUI_DATE_TIME = Text: INVALID_TEXT_DRAW ;

GUI_UpdateDateTimeLabel(playerid) {

	if ( ! IsPlayerSpawned ( playerid ) ) {

		return true ;
	}
	
	new string [ 256 ] ;
	//10:43 AM, Monday~n~1st of January 1996

	new minutes[5], hours[5], tod [ 5 ] ;

	if ( Server [ E_SERVER_TIME_MINUTES ] < 10 ) {

		format ( minutes, sizeof ( minutes ), "0%d", Server [ E_SERVER_TIME_MINUTES ] ) ;
	}

	else format ( minutes, sizeof ( minutes ), "%d", Server [ E_SERVER_TIME_MINUTES ] ) ;

	if ( Server [ E_SERVER_TIME_HOURS ] < 10 ) {

		format ( hours, sizeof ( hours ), "0%d", Server [ E_SERVER_TIME_HOURS ] ) ;
	}

	else format ( hours, sizeof ( hours ), "%d", Server [ E_SERVER_TIME_HOURS ] ) ;

	if ( Server [ E_SERVER_TIME_HOURS ] < 13 ) {

		format ( tod, sizeof ( tod ), "AM" ) ;
	}

	else format ( tod, sizeof ( tod ), "PM" ) ;

	new day [ 32 ], months [ 32 ], ordinal [ 5 ] ;

	format ( ordinal, sizeof ( ordinal ), "%s", date_dayOrdinal ( Server[ E_SERVER_TIME_DAYS ] ) ) ;
	format ( day, sizeof ( day ), "%s", date_dayName ( Server[ E_SERVER_TIME_DAYS ], Server[ E_SERVER_TIME_MONTHS ], 1996 ) ) ;
	UpdateGymStatsDay();
	format ( months, sizeof ( months ), "%s", date_getMonth ( Server[ E_SERVER_TIME_MONTHS ] ) ) ;

	format ( string, sizeof ( string ), "%s:%s %s, %s~n~%d%s of %s %d", hours, minutes, tod, day, Server[ E_SERVER_TIME_DAYS ], ordinal, months, 1996 ) ;

	TextDrawHideForPlayer(playerid, E_GUI_DATE_TIME ) ;
	TextDrawSetString(E_GUI_DATE_TIME, string );
	TextDrawShowForPlayer(playerid, E_GUI_DATE_TIME ) ;

	return true ;
}

LoadDateTimeGUI() {

	E_GUI_DATE_TIME = TextDrawCreate(69.5000, 424.5000, "00:00 AM, Sunday~n~1st of January 1996");
	TextDrawFont(E_GUI_DATE_TIME, 1);
	TextDrawLetterSize(E_GUI_DATE_TIME, 0.2500, 1.0000);
	TextDrawAlignment(E_GUI_DATE_TIME, 2);
	TextDrawColor(E_GUI_DATE_TIME, -1);
	TextDrawSetShadow(E_GUI_DATE_TIME, 0);
	TextDrawSetOutline(E_GUI_DATE_TIME, 1);
	TextDrawBackgroundColor(E_GUI_DATE_TIME, 255);
	TextDrawSetProportional(E_GUI_DATE_TIME, 1);
	TextDrawTextSize(E_GUI_DATE_TIME, 0.0000, 500.0000);
	
}