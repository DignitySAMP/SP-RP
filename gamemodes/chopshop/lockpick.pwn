static lpcost = 500;

CMD:buylockpick(playerid, params[]) {

	if ( ! IsPlayerInRangeOfPoint(playerid, 5.0, CHOPSHOP_X, CHOPSHOP_Y, CHOPSHOP_Z ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near the chopshop!");
	}

	if ( Character [ playerid ] [ E_CHARACTER_LOCKPICK ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You already have some lockpicks, use them up first!");
	}

	new query [ 256 ] ;
	inline LockpickConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( response ) 
		{
			if (GetPlayerCash(playerid) < lpcost) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You don't have $%s in cash.", IntegerWithDelimiter(lpcost)));
			TakePlayerCash(playerid, lpcost);
			
			Character [ playerid ] [ E_CHARACTER_LOCKPICK ] = 3 ;
			SendServerMessage ( playerid, COLOR_BLUE, "Info", "A3A3A3", "You've bought three lockpicks (3 attempts before losing it)!");

			query[0]=EOS;
			mysql_format(mysql, query, sizeof ( query), "UPDATE characters SET player_lockpicks = %d WHERE player_id = %d", Character [ playerid ] [ E_CHARACTER_LOCKPICK ], Character [ playerid ] [ E_CHARACTER_ID ]);
			mysql_tquery(mysql, query);
		}
	}


	format ( query, sizeof ( query ), 

		"{C23030}READ THIS BEFORE PRESSING OK.{DEDEDE}\n\n\
		A pack of three lockpicks costs $%s. Once paid, you can not get the money back!\n\n\
		Only press OK if you're certain."

	, IntegerWithDelimiter(lpcost)) ;

	Dialog_ShowCallback ( playerid, using inline LockpickConfirm, DIALOG_STYLE_MSGBOX, "Confirmation", query, "OK", "Back" );


	return true ;
}