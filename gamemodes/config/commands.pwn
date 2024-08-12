CMD:kane(playerid) {

	SendClientMessage(playerid, -1, "warm it up kane!");
	return true ;
}

CMD:credits(playerid) {

	SendClientMessage(playerid, COLOR_ORANGE, "A list of all noteworthy contributors to our community" ) ;

	SendClientMessage(playerid, COLOR_BLUE, "[Development Help]:" ) ;
	SendClientMessage(playerid, COLOR_ORANGE, "GTA-C:{DEDEDE} Some of the temporary mapping the server uses, as well as providing the codebase." ) ;
	SendClientMessage(playerid, COLOR_ORANGE, "PatrickGTR, Matz, DenNorske, Kubi and Patryk:{DEDEDE} Open sourcing code that the server uses." ) ;

	SendClientMessage(playerid, COLOR_BLUE, "[Community Help]:" ) ;
	SendClientMessage(playerid, COLOR_ORANGE, "iChiwi, Shibesuki, Icarus, Brickz:{DEDEDE} Intensive server testing alongside the tester team." ) ;
	SendClientMessage(playerid, COLOR_ORANGE, "Goldencandy610 and Manzi:{DEDEDE} Helping us largely reassemble the community in full." ) ;

	SendClientMessage(playerid, COLOR_BLUE, "[Conclusion]:" ) ;
	SendClientMessage(playerid, COLOR_ORANGE, "The Community{DEDEDE} for making this server possible and sticking by the staff team through sweat and frustration." ) ;

	return true ;
}



CMD:clearmychat(playerid) 
{
	for (new i, j = 10; i < j; i ++ ) 
	{
		SendClientMessage(playerid, -1, " " );
	}

	return true;
}

CMD:cmc(playerid) return cmd_clearmychat(playerid);
CMD:clearchat(playerid) return cmd_clearmychat(playerid);
CMD:chatclear(playerid) return cmd_clearmychat(playerid);

CMD:servertime ( playerid, params [] ) {

	new string [ 128 ] ;

	format ( string, sizeof ( string ), "The current OOC [[VPS/SERVER HOST]] date/time is %s(GMT +1)", ReturnDateTime () ) ;
	SendClientMessage ( playerid, 0xDEDEDEFF, string ) ;

	string[0] = EOS ;
	format ( string, sizeof ( string ), "The current IC [[roleplay universe]] date/time is %.02d/%.02d/1994 %.0d:%.02d",
		Server [ E_SERVER_TIME_DAYS ], Server [ E_SERVER_TIME_MONTHS ],
		Server [ E_SERVER_TIME_HOURS ], Server [ E_SERVER_TIME_MINUTES ]

	);
	SendClientMessage ( playerid, 0xDEDEDEFF, string ) ;


	return true ;
}

CMD:viewmotd(playerid) {

	SendClientMessage(playerid, 0xD1B68DFF, "===={DBB275}===={D5A04E}===={DE921F}===={DEDEDE} [{C87900} MOTD {DEDEDE} ] {DE921F}===={D5A04E}===={DBB275}===={D1B68D}====" ) ;

	if ( strlen ( Server [ E_SERVER_MOTD_STRING_1 ] ) > 1) {
		SendClientMessage(playerid, -1, Server [ E_SERVER_MOTD_STRING_1 ] );
	}

	if ( strlen ( Server [ E_SERVER_MOTD_STRING_2 ] ) > 1) {
		SendClientMessage(playerid, -1, Server [ E_SERVER_MOTD_STRING_2 ] );
	}

	if ( strlen ( Server [ E_SERVER_MOTD_STRING_3 ] ) > 1) {
		SendClientMessage(playerid, -1, Server [ E_SERVER_MOTD_STRING_3 ] );
	}

	SendClientMessage(playerid, 0xD1B68DFF, "===={DBB275}===={D5A04E}===={DE921F}===={C87900}========{DE921F}===={D5A04E}===={DBB275}===={D1B68D}====" ) ;

	SendClientMessage(playerid, 0xDEDEDEAA, sprintf("Last updated by %s.", Server [ E_SERVER_MOTD_EDITOR ] ) ) ;

	return true ;
}
