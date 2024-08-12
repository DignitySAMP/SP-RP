new PlayerText:cardTD[MAX_PLAYERS][12] = { PlayerText: INVALID_TEXT_DRAW, ... };
new PlayerText:fbibadgetd[MAX_PLAYERS][4] = { PlayerText: INVALID_TEXT_DRAW, ... };
new PlayerText:deabadgetd[MAX_PLAYERS][5] = { PlayerText: INVALID_TEXT_DRAW, ... };
new PlayerText:policebadgetd[MAX_PLAYERS][2] = { PlayerText: INVALID_TEXT_DRAW, ... };


License_ShowPlayerGUI(playerid, targetid, type) {
	License_HidePlayerGUI(targetid);


	switch ( type ) {

		case E_LICENSE_TYPE_ID: {
					PlayerTextDrawSetString(targetid, cardTD[targetid][0], "mdl-28992:id-1");
					PlayerTextDrawSetString(targetid, cardTD[targetid][2], "mdl-28992:id-2");		
		}
		case E_LICENSE_TYPE_DRIVER:{
					PlayerTextDrawSetString(targetid, cardTD[targetid][0], "mdl-28992:dr-1");
					PlayerTextDrawSetString(targetid, cardTD[targetid][2], "mdl-28992:dr-2");		
		}
		case E_LICENSE_TYPE_GUN: 		PlayerTextDrawSetString(targetid, cardTD[targetid][0], "mdl-28992:gbg");
	}

	//show first sprite
	PlayerTextDrawShow ( targetid, cardTD[targetid][0] ) ;

	// show model
	PlayerTextDrawSetPreviewModel(targetid, cardTD[targetid][1], Character [ playerid ] [ E_CHARACTER_SKINID ]);
	PlayerTextDrawShow(targetid, cardTD[targetid][1]);

	// show second sprite
	PlayerTextDrawShow( targetid,  cardTD[playerid][2] ) ;

	new firstname[32], lastname[32], gender[2], registerdate[32], ssn[32], age[12], hair[12], eyes[12], hgt[12];
	new year, month, day, hour, minute, second ;

	//SSN
	format(ssn, sizeof(ssn), "I%d", Character [ playerid ] [ E_CHARACTER_ID ] * Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]);

	//lastname
	format(firstname, sizeof ( firstname ), "%s", Character [ playerid ] [ E_CHARACTER_NAME ] ) ;
    strdel ( firstname, strfind(firstname,"_",true), sizeof(firstname));

    for(new i; i<sizeof(firstname);i++){
    	firstname[i] = toupper(firstname[i]);
    }

    //firstname
    format(lastname, sizeof ( lastname ), "%s", Character [ playerid ] [ E_CHARACTER_NAME ] ) ;
    strdel ( lastname, 0, strfind(lastname,"_",true) + 1);

    for(new i; i<sizeof(lastname);i++){
    	lastname[i] = toupper(lastname[i]);
    }

	// use abbr for gender too
	format(gender, sizeof(gender), "%s", ReturnAttributeAbbrStr(playerid, E_ATTRIBUTE_SEX));

	// iss
	stamp2datetime(Character [ playerid ] [ E_CHARACTER_REGISTERDATE ], year, month, day, hour, minute, second, 1 ) ;
	format ( registerdate, sizeof ( registerdate ), "%02d/93", day) ;

	// age
	format(age, sizeof(age), "%d", 1994 - Character[playerid][E_CHARACTER_ATTRIB_AGE]);

	// hair
	format(hair, sizeof(hair), "%s", ReturnAttributeAbbrStr(playerid, E_ATTRIBUTE_HAIR));

	//eyes
	format(eyes, sizeof(eyes), "%s", ReturnAttributeAbbrStr(playerid, E_ATTRIBUTE_EYES));

	//height
	new cm = Character[playerid][E_CHARACTER_ATTRIB_HEIGHT];
    new inches = floatround(cm / 2.54);
    new feet = inches / 12;
   	new leftover = inches % 12;

   	format(hgt, sizeof(hgt), "%d'-%d\"", feet, leftover);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][4], lastname);
	PlayerTextDrawShow(targetid, cardTD[targetid][4]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][3], ssn);
	PlayerTextDrawShow(targetid, cardTD[targetid][3]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][5], firstname);
	PlayerTextDrawShow(targetid, cardTD[targetid][5]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][6], age);
	PlayerTextDrawShow(targetid, cardTD[targetid][6]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][7], gender);
	PlayerTextDrawShow(targetid, cardTD[targetid][7]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][8], hair);
	PlayerTextDrawShow(targetid, cardTD[targetid][8]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][9], eyes);
	PlayerTextDrawShow(targetid, cardTD[targetid][9]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][10], hgt);
	PlayerTextDrawShow(targetid, cardTD[targetid][10]);

	PlayerTextDrawSetString ( targetid, cardTD[targetid][11], registerdate);
	PlayerTextDrawShow(targetid, cardTD[targetid][11]);


	//removing donator and admin badges for now
	/*if(Account[playerid][E_PLAYER_ACCOUNT_CONTRIBUTOR] > 0 ) {
		PlayerTextDrawShow(targetid, cardTD[targetid][8]);
	} else if(Account[playerid][E_PLAYER_ACCOUNT_PREMIUMLEVEL] > 0) {
		PlayerTextDrawShow(targetid, cardTD[targetid][8]);
	}

	if(Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL] > 0){
		PlayerTextDrawShow(targetid, cardTD[targetid][9]);
	}*/

	return true;
}

License_DestroyPlayerGUI(playerid) {

	
	for ( new i, j = 12; i < j ; i ++ ) {

		PlayerTextDrawDestroy ( playerid, cardTD [ playerid ] [ i ] ) ;
	}

}

License_HidePlayerGUI(playerid) {

	for ( new i, j = 12; i < j ; i ++ ) {

		PlayerTextDrawHide ( playerid, cardTD [ playerid ] [ i ] ) ;
	}

}

Badge_ShowPlayerGUI(playerid, targetid, type) {

	Badge_HidePlayerGUI(targetid);
	switch ( type ) {

		case E_BADGE_TYPE_PD: {
			PlayerTextDrawSetString(targetid, policebadgetd[targetid][0], "mdl-28992:pd");
			PlayerTextDrawShow ( targetid, policebadgetd[targetid][0] ) ;

			new badgenumber[16];
			format(badgenumber, sizeof(badgenumber), "%05d", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ]);

			PlayerTextDrawSetString ( targetid, policebadgetd[targetid][1], badgenumber);
			PlayerTextDrawShow(targetid, policebadgetd[targetid][1]);
		}


		case E_BADGE_TYPE_SD: {
			PlayerTextDrawSetString(targetid, policebadgetd[targetid][0], "mdl-28992:sd");
			PlayerTextDrawShow ( targetid, policebadgetd[targetid][0] ) ;

			new badgenumber[16];
			format(badgenumber, sizeof(badgenumber), "%05d", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ]);

			PlayerTextDrawSetString ( targetid, policebadgetd[targetid][1], badgenumber);
			PlayerTextDrawShow(targetid, policebadgetd[targetid][1]);
		}


		case E_BADGE_TYPE_FBI:	{

			PlayerTextDrawSetString(targetid, fbibadgetd[targetid][0], "mdl-28992:fbi-1");
			PlayerTextDrawSetString(targetid, fbibadgetd[targetid][2], "mdl-28992:fbi-2");

			PlayerTextDrawShow ( targetid, fbibadgetd[targetid][0] ) ;

			PlayerTextDrawSetPreviewModel(targetid, fbibadgetd[targetid][1], Character [ playerid ] [ E_CHARACTER_SKINID ]);
			PlayerTextDrawShow(targetid, fbibadgetd[targetid][1]);

			PlayerTextDrawShow ( targetid, fbibadgetd[targetid][2] ) ;

			PlayerTextDrawSetString ( targetid, fbibadgetd[targetid][3], sprintf("%s", ReturnRPName(playerid)));
			PlayerTextDrawShow(targetid, fbibadgetd[targetid][3]);
		}

		case E_BADGE_TYPE_DEA: {

			PlayerTextDrawSetString(targetid, deabadgetd[targetid][0], "mdl-28992:dea-1");
			PlayerTextDrawSetString(targetid, deabadgetd[targetid][2], "mdl-28992:dea-2");

			PlayerTextDrawShow ( targetid, deabadgetd[targetid][0] ) ;

			PlayerTextDrawSetPreviewModel(targetid, deabadgetd[targetid][1], Character [ playerid ] [ E_CHARACTER_SKINID ]);
			PlayerTextDrawShow(targetid, deabadgetd[targetid][1]);

			PlayerTextDrawShow ( targetid, deabadgetd[targetid][2] ) ;

			PlayerTextDrawSetString ( targetid, deabadgetd[targetid][3], sprintf("%s", ReturnRPName(playerid)));
			PlayerTextDrawShow(targetid, deabadgetd[targetid][3]);

			new agentid[16];
			format(agentid, sizeof(agentid), "%05d", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ]);

			PlayerTextDrawSetString ( targetid, deabadgetd[targetid][4], agentid);
			PlayerTextDrawShow(targetid, deabadgetd[targetid][4]);
		}


	}

	return true;
}

Badge_DestroyPlayerGUI(playerid) {

	
	for ( new i, j = 5; i < j ; i ++ ) {

		PlayerTextDrawDestroy ( playerid, deabadgetd [ playerid ] [ i ] ) ;

	}

	for ( new i, j = 4; i < j ; i ++ ) {

		PlayerTextDrawDestroy ( playerid, fbibadgetd [ playerid ] [ i ] ) ;
	}

	for ( new i, j = 2; i < j ; i ++ ) {

		PlayerTextDrawDestroy ( playerid, policebadgetd [ playerid ] [ i ] ) ;
	}

}

Badge_HidePlayerGUI(playerid) {

	for ( new i, j = 5; i < j ; i ++ ) {

		PlayerTextDrawHide ( playerid, deabadgetd [ playerid ] [ i ] ) ;
	}

	for ( new i, j = 4; i < j ; i ++ ) {

		PlayerTextDrawHide ( playerid, fbibadgetd [ playerid ] [ i ] ) ;
	}

	for ( new i, j = 2; i < j ; i ++ ) {

		PlayerTextDrawHide ( playerid, policebadgetd [ playerid ] [ i ] ) ;
	}


}

License_OnLoadPlayerGUI(playerid) {

	if ( ! IsPlayerConnected ( playerid ) ) {

		return true ;
	}

	cardTD[playerid][0] = CreatePlayerTextDraw(playerid, 452.0000, 306.5000, "mdl-2001:dr-1");
	PlayerTextDrawFont(playerid, cardTD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][0], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, cardTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][0], 160.0000, 85.0000);

	cardTD[playerid][1] = CreatePlayerTextDraw(playerid, 429.0000, 335.5000, "New TextDraw");
	PlayerTextDrawFont(playerid, cardTD[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][1], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, cardTD[playerid][1], -85207041);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][1], 100.0000, 75.0000);
	PlayerTextDrawSetPreviewModel(playerid, cardTD[playerid][1], 284);
	PlayerTextDrawSetPreviewRot(playerid, cardTD[playerid][1], 0.0000, 0.0000, 0.0000, 1.0000);

	cardTD[playerid][2] = CreatePlayerTextDraw(playerid, 452.0000, 382.5000, "mdl-2001:dr-2");
	PlayerTextDrawFont(playerid, cardTD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][2], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, cardTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][2], 160.0000, 35.0000);

	cardTD[playerid][3] = CreatePlayerTextDraw(playerid, 509.0000, 334.0000, "I241942");
	PlayerTextDrawFont(playerid, cardTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][3], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][3], -1962934017);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][3], 0.0000, 0.0000);

	cardTD[playerid][4] = CreatePlayerTextDraw(playerid, 509.0000, 349.0000, "UNKNOWN");
	PlayerTextDrawFont(playerid, cardTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][4], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][4], 0.0000, 0.0000);

	cardTD[playerid][5] = CreatePlayerTextDraw(playerid, 509.0000, 363.5000, "PERSON");
	PlayerTextDrawFont(playerid, cardTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][5], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][5], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][5], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][5], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][5], 0.0000, 0.0000);

	cardTD[playerid][6] = CreatePlayerTextDraw(playerid, 513.0000, 378.5000, "1971");
	PlayerTextDrawFont(playerid, cardTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][6], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][6], -1962934017);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][6], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][6], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][6], 0.0000, 0.0000);

	cardTD[playerid][7] = CreatePlayerTextDraw(playerid, 511.0000, 387.0000, "M");
	PlayerTextDrawFont(playerid, cardTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][7], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][7], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][7], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][7], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][7], 0.0000, 0.0000);

	cardTD[playerid][8] = CreatePlayerTextDraw(playerid, 548.5000, 387.0000, "BLK");
	PlayerTextDrawFont(playerid, cardTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][8], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][8], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][8], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][8], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][8], 0.0000, 0.0000);

	cardTD[playerid][9] = CreatePlayerTextDraw(playerid, 588.5000, 387.0000, "BLU");
	PlayerTextDrawFont(playerid, cardTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][9], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][9], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][9], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][9], 0.0000, 0.0000);

	cardTD[playerid][10] = CreatePlayerTextDraw(playerid, 511.0000, 394.0000, "5'-11''");
	PlayerTextDrawFont(playerid, cardTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][10], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][10], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][10], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][10], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][10], 0.0000, 0.0000);

	cardTD[playerid][11] = CreatePlayerTextDraw(playerid, 545.5000, 394.0000, "04/1996");
	PlayerTextDrawFont(playerid, cardTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, cardTD[playerid][11], 0.2100, 0.8000);
	PlayerTextDrawColor(playerid, cardTD[playerid][11], 255);
	PlayerTextDrawSetShadow(playerid, cardTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, cardTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, cardTD[playerid][11], 255);
	PlayerTextDrawSetProportional(playerid, cardTD[playerid][11], 1);
	PlayerTextDrawTextSize(playerid, cardTD[playerid][11], 0.0000, 0.0000);


	fbibadgetd[playerid][0] = CreatePlayerTextDraw(playerid, 426.5000, 300.0000, "mdl-28992:fbi-1");
	PlayerTextDrawFont(playerid, fbibadgetd[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, fbibadgetd[playerid][0], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fbibadgetd[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, fbibadgetd[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, fbibadgetd[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, fbibadgetd[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, fbibadgetd[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, fbibadgetd[playerid][0], 200.0000, 85.0000);

	fbibadgetd[playerid][1] = CreatePlayerTextDraw(playerid, 526.0000, 349.0000, "model");
	PlayerTextDrawFont(playerid, fbibadgetd[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, fbibadgetd[playerid][1], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fbibadgetd[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, fbibadgetd[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, fbibadgetd[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, fbibadgetd[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, fbibadgetd[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, fbibadgetd[playerid][1], 100.0000, 80.0000);
	PlayerTextDrawSetPreviewModel(playerid, fbibadgetd[playerid][1], 281);
	PlayerTextDrawSetPreviewRot(playerid, fbibadgetd[playerid][1], 0.0000, 0.0000, 0.0000, 1.0000);

	fbibadgetd[playerid][2] = CreatePlayerTextDraw(playerid, 426.5000, 384.5000, "mdl-28992:fbi-2");
	PlayerTextDrawFont(playerid, fbibadgetd[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, fbibadgetd[playerid][2], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fbibadgetd[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, fbibadgetd[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, fbibadgetd[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, fbibadgetd[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, fbibadgetd[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, fbibadgetd[playerid][2], 200.0000, 49.5000);

	fbibadgetd[playerid][3] = CreatePlayerTextDraw(playerid, 555.0000, 401.0000, "UNKNOWN PERSON");
	PlayerTextDrawFont(playerid, fbibadgetd[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, fbibadgetd[playerid][3], 0.1599, 0.4999);
	PlayerTextDrawAlignment(playerid, fbibadgetd[playerid][3], 2);
	PlayerTextDrawColor(playerid, fbibadgetd[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, fbibadgetd[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, fbibadgetd[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, fbibadgetd[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, fbibadgetd[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, fbibadgetd[playerid][3], 599.5000, 67.0000);

	deabadgetd[playerid][0] = CreatePlayerTextDraw(playerid, 426.5000, 300.0000, "mdl-28992:dea-1");
	PlayerTextDrawFont(playerid, deabadgetd[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, deabadgetd[playerid][0], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, deabadgetd[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, deabadgetd[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, deabadgetd[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, deabadgetd[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, deabadgetd[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, deabadgetd[playerid][0], 200.0000, 85.0000);

	deabadgetd[playerid][1] = CreatePlayerTextDraw(playerid, 526.0000, 349.0000, "model");
	PlayerTextDrawFont(playerid, deabadgetd[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, deabadgetd[playerid][1], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, deabadgetd[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, deabadgetd[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, deabadgetd[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, deabadgetd[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, deabadgetd[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, deabadgetd[playerid][1], 100.0000, 80.0000);
	PlayerTextDrawSetPreviewModel(playerid, deabadgetd[playerid][1], 281);
	PlayerTextDrawSetPreviewRot(playerid, deabadgetd[playerid][1], 0.0000, 0.0000, 0.0000, 1.0000);

	deabadgetd[playerid][2] = CreatePlayerTextDraw(playerid, 426.5000, 384.5000, "mdl-28992:dea-2");
	PlayerTextDrawFont(playerid, deabadgetd[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, deabadgetd[playerid][2], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, deabadgetd[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, deabadgetd[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, deabadgetd[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, deabadgetd[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, deabadgetd[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, deabadgetd[playerid][2], 200.0000, 49.5000);

	deabadgetd[playerid][3] = CreatePlayerTextDraw(playerid, 498.0000, 374.0000, "UNKNOWN PERSON");
	PlayerTextDrawFont(playerid, deabadgetd[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, deabadgetd[playerid][3], 0.1199, 0.4999);
	PlayerTextDrawColor(playerid, deabadgetd[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, deabadgetd[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, deabadgetd[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, deabadgetd[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, deabadgetd[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, deabadgetd[playerid][3], 590.5000, 67.0000);

	deabadgetd[playerid][4] = CreatePlayerTextDraw(playerid, 498.0000, 385.5000, "12345678");
	PlayerTextDrawFont(playerid, deabadgetd[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, deabadgetd[playerid][4], 0.1199, 0.4999);
	PlayerTextDrawColor(playerid, deabadgetd[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, deabadgetd[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, deabadgetd[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, deabadgetd[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, deabadgetd[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, deabadgetd[playerid][4], 590.5000, 67.0000);

	policebadgetd[playerid][0] = CreatePlayerTextDraw(playerid, 520.0000, 295.5000, "mdl-28992:pd");
	PlayerTextDrawFont(playerid, policebadgetd[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, policebadgetd[playerid][0], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, policebadgetd[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, policebadgetd[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, policebadgetd[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, policebadgetd[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, policebadgetd[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, policebadgetd[playerid][0], 92.5000, 140.5000);

	policebadgetd[playerid][1] = CreatePlayerTextDraw(playerid, 565.5000, 408.5000, "0000");
	PlayerTextDrawFont(playerid, policebadgetd[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, policebadgetd[playerid][1], 0.1600, 1.1000);
	PlayerTextDrawAlignment(playerid, policebadgetd[playerid][1], 2);
	PlayerTextDrawColor(playerid, policebadgetd[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, policebadgetd[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, policebadgetd[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, policebadgetd[playerid][1], 2147472639);
	PlayerTextDrawSetProportional(playerid, policebadgetd[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, policebadgetd[playerid][1], 580.0000, 25.0000);

	return 1;
}
