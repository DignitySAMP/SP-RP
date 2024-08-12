new PlayerText: fuel_player_gui_2[MAX_PLAYERS] [ 22 ] = { PlayerText: INVALID_TEXT_DRAW, ... } ;

Fuel_OnLoadPlayerGui_Extra(playerid ) {


	fuel_player_gui_2[playerid][0] = CreatePlayerTextDraw(playerid, 241.0000, 244.0000, "mdl-30001:can");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][0], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][0], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][0], -75.0000, 100.0000);

	fuel_player_gui_2[playerid][1] = CreatePlayerTextDraw(playerid, 241.0000, 244.0000, "mdl-30001:filler_background");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][1], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][1], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][1], -75.0000, 100.0000);

	fuel_player_gui_2[playerid][2] = CreatePlayerTextDraw(playerid, 241.0000, 313.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][2], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][2], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][2], -75.0000, 15.0000);

	fuel_player_gui_2[playerid][3] = CreatePlayerTextDraw(playerid, 241.0000, 309.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][3], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][3], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][3], -75.0000, 20.0000);

	fuel_player_gui_2[playerid][4] = CreatePlayerTextDraw(playerid, 241.0000, 305.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][4], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][4], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][4], -75.0000, 25.0000);

	fuel_player_gui_2[playerid][5] = CreatePlayerTextDraw(playerid, 241.0000, 301.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][5], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][5], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][5], -75.0000, 30.0000);

	fuel_player_gui_2[playerid][6] = CreatePlayerTextDraw(playerid, 241.0000, 297.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][6], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][6], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][6], -75.0000, 35.0000);

	fuel_player_gui_2[playerid][7] = CreatePlayerTextDraw(playerid, 241.0000, 293.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][7], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][7], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][7], -75.0000, 40.0000);

	fuel_player_gui_2[playerid][8] = CreatePlayerTextDraw(playerid, 241.0000, 289.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][8], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][8], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][8], -75.0000, 45.0000);

	fuel_player_gui_2[playerid][9] = CreatePlayerTextDraw(playerid, 241.0000, 285.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][9], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][9], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][9], -75.0000, 50.0000);

	fuel_player_gui_2[playerid][10] = CreatePlayerTextDraw(playerid, 241.0000, 281.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][10], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][10], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][10], -75.0000, 55.0000);

	fuel_player_gui_2[playerid][11] = CreatePlayerTextDraw(playerid, 241.0000, 277.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][11], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][11], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][11], -75.0000, 60.0000);

	fuel_player_gui_2[playerid][12] = CreatePlayerTextDraw(playerid, 241.0000, 273.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][12], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][12], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][12], -75.0000, 65.0000);

	fuel_player_gui_2[playerid][13] = CreatePlayerTextDraw(playerid, 241.0000, 269.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][13], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][13], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][13], -75.0000, 70.0000);

	fuel_player_gui_2[playerid][14] = CreatePlayerTextDraw(playerid, 241.0000, 265.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][14], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][14], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][14], -75.0000, 75.0000);

	fuel_player_gui_2[playerid][15] = CreatePlayerTextDraw(playerid, 241.0000, 261.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][15], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][15], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][15], -75.0000, 80.0000);

	fuel_player_gui_2[playerid][16] = CreatePlayerTextDraw(playerid, 241.0000, 257.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][16], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][16], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][16], -75.0000, 85.0000);

	fuel_player_gui_2[playerid][17] = CreatePlayerTextDraw(playerid, 241.0000, 253.0000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][17], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][17], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][17], -75.0000, 90.0000);

	fuel_player_gui_2[playerid][18] = CreatePlayerTextDraw(playerid, 241.0000, 249.5000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][18], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][18], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][18], -75.0000, 95.0000);

	fuel_player_gui_2[playerid][19] = CreatePlayerTextDraw(playerid, 241.0000, 245.5000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][19], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][19], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][19], -75.0000, 100.0000);

	fuel_player_gui_2[playerid][20] = CreatePlayerTextDraw(playerid, 241.0000, 316.5000, "mdl-30001:filler_content");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][20], 4);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][20], -1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][20], -75.0000, 10.0000);

	fuel_player_gui_2[playerid][21] = CreatePlayerTextDraw(playerid, 241.0000, 244.0000, "mdl-30001:filler_overlay");
	PlayerTextDrawFont(playerid, fuel_player_gui_2[playerid][21], 4);
	PlayerTextDrawLetterSize(playerid, fuel_player_gui_2[playerid][21], 0.5000, 1.0000);
	PlayerTextDrawColor(playerid, fuel_player_gui_2[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, fuel_player_gui_2[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, fuel_player_gui_2[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, fuel_player_gui_2[playerid][21], 255);
	PlayerTextDrawSetProportional(playerid, fuel_player_gui_2[playerid][21], 1);
	PlayerTextDrawTextSize(playerid, fuel_player_gui_2[playerid][21], -75.0000, 100.0000);
}

Fuel_UpdateExtraFiller(playerid, fuel) {


	PlayerTextDrawHide(playerid, fuel_player_gui_2 [playerid ] [ 21 ] ) ;

	switch ( fuel ) {

		case 11 .. 15: {
			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][20]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][2]);
		}

		case 16 .. 20: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][2] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][3] );
		}

		case 21 .. 25: {
			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][3] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][4] );
		}

		case 26 .. 30: {
			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][4] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][5] );
		}

		case 31 .. 35: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][5]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][6]);
		}

		case 36 .. 40: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][6] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][7] );
		}
		case 41 .. 45: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][7] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][8] );
		}
		case 46 .. 50: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][8] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][9] );
		}
		case 51 .. 55: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][9]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][10]);

		}

		case 56 .. 60: {
			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][10] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][11] );
		}

		case 61 .. 65: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][11] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][12] );
		}

		case 66 .. 70: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][12] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][13] );
		}

		case 71 .. 75: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][13] );
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][14] );
		}

		case 76 .. 80: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][14]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][15]);
		}

		case 81 .. 85: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][15]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][16]);
		}

		case 86 .. 90: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][16]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][17]);
		}

		case 91 .. 95: {

			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][17]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][18]);
		}

		case 96 .. 100: {
			PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][18]);
			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][19]);
		}

		default: {

			for(new i = 1, j = 20; i < j; i ++ ) {

				PlayerTextDrawHide(playerid, fuel_player_gui_2[playerid][i]);
			}

			PlayerTextDrawShow(playerid, fuel_player_gui_2[playerid][20]);
		}
	}


	PlayerTextDrawShow(playerid, fuel_player_gui_2 [playerid ] [ 21 ] ) ;

}

Fuel_OnShowPlayerGui_Extra(playerid ) {



	PlayerTextDrawShow(playerid, fuel_player_gui_2 [playerid ] [ 0 ] ) ;
	PlayerTextDrawShow(playerid, fuel_player_gui_2 [playerid ] [ 1 ] ) ;
	PlayerTextDrawShow(playerid, fuel_player_gui_2 [playerid ] [ 21 ] ) ;

	// The inside content is shown with "Fuel_UpdateExtraFiller"
}

Fuel_OnHidePlayerGui_Extra(playerid) {


	for ( new i, j = 22; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, fuel_player_gui_2 [playerid ] [ i ] ) ;
	}
}

Fuel_OnDestroyPlayerGui_Extra(playerid) {

	for ( new i, j = 22; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, fuel_player_gui_2 [playerid ] [ i ] ) ;
	}
}
