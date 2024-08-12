/*
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS 100

#include <foreach>
#include <zcmd>*/

#define mBrowser:%0(%1) \
	forward mbrowser_%0(%1); public mbrowser_%0(%1)

enum E_PLAYER_MODEL_BROWSER_DATA {

	E_PLAYER_BROWSER_MODEL,
	E_PLAYER_BROWSER_NAME [ 64 ],
} ;

#define MAX_BROWSER_DATA 500 

new PlayerModelBrowserData [ MAX_PLAYERS ]  [MAX_BROWSER_DATA ] [ E_PLAYER_MODEL_BROWSER_DATA ] ;

enum E_PLAYER_MODEL_BROWSER_INFO {

	E_PLAYER_BROWSER_PAGE,
	E_PLAYER_BROWSER_TITLE [ 32 ],
	E_PLAYER_BROWSER_FUNC [ 32 ],
	E_PLAYER_BROWSER_CLICKCD,
	bool: E_PLAYER_BROWSER_OPENED
} ;

new PlayerModelBrowser [ MAX_PLAYERS ] [ E_PLAYER_MODEL_BROWSER_INFO ] ;

#if !defined BROWSER_CLICK_COOLDOWN
	#define BROWSER_CLICK_COOLDOWN 0 // seconds wait time when opening menu
#endif

new Text:model_browser_gui[3] = Text: INVALID_TEXT_DRAW ;
new PlayerText:model_browser_pgui[MAX_PLAYERS][32] = { PlayerText: INVALID_TEXT_DRAW, ... } ;

#if !defined MODEL_BROWSER_MAX_TILES
	#define MODEL_BROWSER_MAX_TILES		14
#endif 

ModelBrowser_IsOpen(playerid) {

	return PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_OPENED ];
}

ModelBrowser_ClearData(playerid) {

	for ( new i, j = MAX_BROWSER_DATA ; i < j ; i ++ ) {

		PlayerModelBrowserData [ playerid ] [ i ] [ E_PLAYER_BROWSER_MODEL ] = -1 ;
		PlayerModelBrowserData [ playerid ] [ i ] [ E_PLAYER_BROWSER_NAME ] [ 0 ] = EOS ;
	}

	PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_FUNC ] [ 0 ] = EOS ;
	format ( PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_TITLE ] , 32, " " ); 
	PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] = 0 ;
	PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_OPENED ] = false ;
}

ModelBrowser_AddData(playerid, modelid, const name[] ) {
	//#warning add additional params for the model offsets!

	new found_index = -1 ;

	for ( new i, j = MAX_BROWSER_DATA ; i < j ; i ++ ) {

		if ( PlayerModelBrowserData [ playerid ] [ i ] [ E_PLAYER_BROWSER_MODEL ] == -1 ) {

			found_index = i ;
			break ;
		}

		else continue ;
	}

	if (  found_index == -1 ) {

		SendClientMessage(playerid, -1, "Unable to fetch empty browser_id due to MAX_BROWSER_DATA (500) being taken!" ) ;
	}

	PlayerModelBrowserData [ playerid ] [ found_index ] [ E_PLAYER_BROWSER_MODEL ] = modelid ;
	PlayerModelBrowserData [ playerid ] [ found_index ] [ E_PLAYER_BROWSER_NAME ] [ 0 ] = EOS ;
	strcat(PlayerModelBrowserData [ playerid ] [ found_index ] [ E_PLAYER_BROWSER_NAME ], name);

	/*
		printf("Stored model %d with text \"%s\" in slot %d", PlayerModelBrowserData [ playerid ] [ found_index ] [ E_PLAYER_BROWSER_MODEL ], 
			PlayerModelBrowserData [ playerid ] [ found_index ] [ E_PLAYER_BROWSER_NAME ], found_index ) ;
	*/

	return true ;
}

ModelBrowser_HideTiles(playerid) {

	ModelBrowser_ClearData(playerid) ;

	for ( new i, j = sizeof ( model_browser_gui ); i < j ; i ++ ) {

		TextDrawHideForPlayer(playerid, model_browser_gui [ i ] ) ;
	}
	for ( new i, j = 32; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, model_browser_pgui[playerid] [ i ] ) ;
	}

	CancelSelectTextDraw(playerid);

	return true ;
}

ModelBrowser_SetupTiles(playerid, const header[], const func[]) {

	for ( new i, j = sizeof ( model_browser_gui ); i < j ; i ++ ) {

		TextDrawShowForPlayer(playerid, model_browser_gui [ i ] ) ;
	}
	for ( new i, j = 32; i < j ; i ++ ) {

		PlayerTextDrawShow(playerid, model_browser_pgui[playerid] [ i ] ) ;
	}

	format ( PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_TITLE ] , 32, "%s", header ) ;
	format ( PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_FUNC ] , 32, "%s", func ) ;

	PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_CLICKCD ] = gettime () + BROWSER_CLICK_COOLDOWN; 
	PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_OPENED ] = true ;
	ModelBrowser_DisplayTiles(playerid );
}

ModelBrowser_DisplayTiles(playerid ) {

	new string [ 16 ], item_count ;

	for ( new i, j = 32; i < j ; i ++ ) {

		PlayerTextDrawHide(playerid, model_browser_pgui[playerid] [ i ] ) ;
	}

	for ( new i, j = MAX_BROWSER_DATA ; i < j ; i ++ ) {

		if ( PlayerModelBrowserData [ playerid ] [ i ] [ E_PLAYER_BROWSER_MODEL ] != -1 ) {
			item_count ++ ;
		}

		else continue ;
	}

	PlayerTextDrawSetString(playerid, model_browser_pgui[playerid][15], PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_TITLE ]); // name
	PlayerTextDrawShow(playerid, model_browser_pgui[playerid][15] ) ; // Setting header string

	format ( string, sizeof ( string ), "page %d", PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] ) ;
	PlayerTextDrawSetString(playerid, model_browser_pgui[playerid][16], string );
	PlayerTextDrawShow(playerid, model_browser_pgui[playerid][16] ) ;	// Setting page string

	new tile_count, item_index = PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] * 15 ;

	new loaded_items_on_page ;

	new item_name [ 64 ], tab_index ;

	for ( new i, j = MODEL_BROWSER_MAX_TILES ; i <= j ; i ++ ) {

		if ( PlayerModelBrowserData [ playerid ] [ item_index + i ] [ E_PLAYER_BROWSER_MODEL ] != -1 ) {

			PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][tile_count], PlayerModelBrowserData [ playerid ] [ item_index + i ] [ E_PLAYER_BROWSER_MODEL ]);
			PlayerTextDrawShow(playerid, model_browser_pgui[playerid][tile_count]);

			// Setting tile string
			format ( item_name, sizeof ( item_name ), "%s", PlayerModelBrowserData [ playerid ] [ item_index + i ] [ E_PLAYER_BROWSER_NAME ] ) ;

			if ( strlen ( item_name ) > 15 ) {

				tab_index = strfind(item_name, " ", false, 10 );

				if ( tab_index == -1 ) {

					strins(item_name, "~n~", 10);
				}

				else strins(item_name, "~n~", tab_index );
			}

			PlayerTextDrawSetString(playerid, model_browser_pgui[playerid][17 + tile_count], item_name ) ;
			PlayerTextDrawShow(playerid, model_browser_pgui[playerid][17 + tile_count]);

			tile_count ++ ;
			loaded_items_on_page ++ ;
		}

		else continue ;
	}

	// Previous button
	if ( ! PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ]  ) {

		TextDrawHideForPlayer(playerid, model_browser_gui[1]);
	}

	else TextDrawShowForPlayer(playerid, model_browser_gui[1]);

	// Next button
	if ( loaded_items_on_page > MODEL_BROWSER_MAX_TILES ) {
		TextDrawShowForPlayer(playerid, model_browser_gui[2]);
	}

	else TextDrawHideForPlayer(playerid, model_browser_gui[2]);

	// Letting player select the goods
	SelectTextDraw(playerid, 0xFFFF32FF);

	return true ;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid) {

	if ( ModelBrowser_IsOpen(playerid) ) {


		if ( clickedid == Text: INVALID_TEXT_DRAW ) {

			new browserid[32] = "mbrowser_";
			strcat(browserid, PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_FUNC ]);
			CallLocalFunction(browserid, "iiiis", playerid, false, -1, -1, "N/A" );

			ModelBrowser_HideTiles(playerid);
		}

		if ( clickedid == model_browser_gui [ 2 ] ) {

			PlayerModelBrowser[ playerid ] [ E_PLAYER_BROWSER_PAGE ] ++ ;
			ModelBrowser_DisplayTiles(playerid ) ;
		}

		if ( clickedid == model_browser_gui [ 1 ] ) {

			PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] -- ;

			if ( PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] < 0 ) {
				PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] = 0 ;
			}

			ModelBrowser_DisplayTiles(playerid ) ;
		}
	}

	#if defined mBrowser_OnPlayerClickTextDraw
		return mBrowser_OnPlayerClickTextDraw(playerid, Text:clickedid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw mBrowser_OnPlayerClickTextDraw
#if defined mBrowser_OnPlayerClickTextDraw
	forward mBrowser_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {

	if ( ModelBrowser_IsOpen(playerid) ) {

		if ( PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_CLICKCD ] >= gettime() ) {
			new warning [ 64 ] ;
			format ( warning, sizeof ( warning ), "Not that fast! Wait %d seconds before using the menu!", PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_CLICKCD ] - gettime() + 1 ) ;
			//SendClientMessage(playerid, -1, warning);
			SendServerMessage ( playerid, COLOR_ERROR, "Model Browser", "DEDEDE", warning ) ;
			SelectTextDraw(playerid, 0xFFFF32FF);
			return true ;
		}

		else {

			new item_index ;
			for ( new i, j = 14; i <= j ; i ++ ) {

				if ( playertextid == model_browser_pgui[playerid][i]  ) {

		 			item_index = PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_PAGE ] * 15 ;
				
					new browserid[32] = "mbrowser_";
					strcat(browserid, PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_FUNC ]);

					if ( strlen(PlayerModelBrowser [ playerid ] [ E_PLAYER_BROWSER_FUNC ]) <= 1 || strlen(PlayerModelBrowserData [ playerid ] [ item_index + i ] [ E_PLAYER_BROWSER_NAME ]) <= 1 ) {

						SendClientMessage(playerid, COLOR_YELLOW, "Error setting up browser. Try again.");
						return false ;
					}


					CallLocalFunction(browserid, "iiiis", 
						playerid, true, i,
						PlayerModelBrowserData [ playerid ] [ item_index + i ] [ E_PLAYER_BROWSER_MODEL ],
						PlayerModelBrowserData [ playerid ] [ item_index + i ] [ E_PLAYER_BROWSER_NAME ]
					);

					ModelBrowser_HideTiles(playerid);
				}
			}
		}
	}

	#if defined mBrowser_OnPlayerClickPlayerTD
		return mBrowser_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif

#define OnPlayerClickPlayerTextDraw mBrowser_OnPlayerClickPlayerTD
#if defined mBrowser_OnPlayerClickPlayerTD
	forward mBrowser_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif

mBrowser_DestroyPlayerDraws(playerid) {
	
	ModelBrowser_ClearData(playerid) ;

	for ( new i, j = sizeof ( model_browser_gui ); i < j ; i ++ ) {

		TextDrawHideForPlayer(playerid, model_browser_gui [ i ] ) ;

	}

	for ( new i, j = 32; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, model_browser_pgui[playerid] [ i ] ) ;
	}

	return true ;
}


mBrowser_LoadStaticDraws() {
	model_browser_gui[0] = TextDrawCreate(155.0000, 150.0000, "_");
	TextDrawFont(model_browser_gui[0], 1);
	TextDrawLetterSize(model_browser_gui[0], 0.5000, 22.5000);
	TextDrawColor(model_browser_gui[0], -1);
	TextDrawSetShadow(model_browser_gui[0], 0);
	TextDrawSetOutline(model_browser_gui[0], 0);
	TextDrawBackgroundColor(model_browser_gui[0], 255);
	TextDrawSetProportional(model_browser_gui[0], 1);
	TextDrawUseBox(model_browser_gui[0], 1);
	TextDrawBoxColor(model_browser_gui[0], 858993578);
	TextDrawTextSize(model_browser_gui[0], 467.5000, 0.0000);

	model_browser_gui[1] = TextDrawCreate(156.0000, 339.0000, "LD_BEAT:left");
	TextDrawFont(model_browser_gui[1], 4);
	TextDrawLetterSize(model_browser_gui[1], 0.2500, 0.9499);
	TextDrawAlignment(model_browser_gui[1], 2);
	TextDrawColor(model_browser_gui[1], -555819265);
	TextDrawSetShadow(model_browser_gui[1], 0);
	TextDrawSetOutline(model_browser_gui[1], 1);
	TextDrawBackgroundColor(model_browser_gui[1], 255);
	TextDrawSetProportional(model_browser_gui[1], 1);
	TextDrawTextSize(model_browser_gui[1], 15.0000, 15.0000);
	TextDrawSetSelectable(model_browser_gui[1], 1);

	model_browser_gui[2] = TextDrawCreate(451.5000, 339.0000, "LD_BEAT:right");
	TextDrawFont(model_browser_gui[2], 4);
	TextDrawLetterSize(model_browser_gui[2], 0.2500, 0.9499);
	TextDrawAlignment(model_browser_gui[2], 2);
	TextDrawColor(model_browser_gui[2], -555819265);
	TextDrawSetShadow(model_browser_gui[2], 0);
	TextDrawSetOutline(model_browser_gui[2], 1);
	TextDrawBackgroundColor(model_browser_gui[2], 255);
	TextDrawSetProportional(model_browser_gui[2], 1);
	TextDrawTextSize(model_browser_gui[2], 15.0000, 15.0000);
	TextDrawSetSelectable(model_browser_gui[2], 1);
}

mBrowser_LoadPlayerDraws(playerid) {
	model_browser_pgui[playerid][0] = CreatePlayerTextDraw(playerid, 156.0000, 152.0000, "1");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][0], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][0], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][0], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][0], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][0], 1336);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][0], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][0], 1);

	model_browser_pgui[playerid][1] = CreatePlayerTextDraw(playerid, 218.5000, 152.0000, "2");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][1], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][1], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][1], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][1], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][1], 1337);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][1], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][1], 1);

	model_browser_pgui[playerid][2] = CreatePlayerTextDraw(playerid, 281.0000, 152.0000, "3");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][2], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][2], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][2], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][2], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][2], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][2], 1338);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][2], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][2], 1);

	model_browser_pgui[playerid][3] = CreatePlayerTextDraw(playerid, 343.5000, 152.0000, "4");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][3], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][3], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][3], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][3], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][3], 1339);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][3], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][3], 1);

	model_browser_pgui[playerid][4] = CreatePlayerTextDraw(playerid, 406.0000, 152.0000, "5");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][4], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][4], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][4], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][4], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][4], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][4], 1340);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][4], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][4], 1);

	model_browser_pgui[playerid][5] = CreatePlayerTextDraw(playerid, 156.0000, 215.0000, "1");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][5], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][5], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][5], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][5], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][5], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][5], 1341);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][5], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][5], 1);

	model_browser_pgui[playerid][6] = CreatePlayerTextDraw(playerid, 218.5000, 215.0000, "2");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][6], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][6], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][6], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][6], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][6], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][6], 1343);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][6], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][6], 1);

	model_browser_pgui[playerid][7] = CreatePlayerTextDraw(playerid, 281.0000, 215.0000, "3");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][7], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][7], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][7], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][7], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][7], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][7], 1345);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][7], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][7], 1);

	model_browser_pgui[playerid][8] = CreatePlayerTextDraw(playerid, 343.5000, 215.0000, "4");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][8], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][8], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][8], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][8], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][8], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][8], 1346);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][8], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][8], 1);

	model_browser_pgui[playerid][9] = CreatePlayerTextDraw(playerid, 406.0000, 215.0000, "5");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][9], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][9], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][9], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][9], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][9], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][9], 1347);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][9], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][9], 1);

	model_browser_pgui[playerid][10] = CreatePlayerTextDraw(playerid, 156.0000, 278.0000, "1");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][10], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][10], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][10], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][10], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][10], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][10], 1348);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][10], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][10], 1);

	model_browser_pgui[playerid][11] = CreatePlayerTextDraw(playerid, 218.5000, 278.0000, "2");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][11], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][11], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][11], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][11], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][11], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][11], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][11], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][11], 1349);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][11], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][11], 1);

	model_browser_pgui[playerid][12] = CreatePlayerTextDraw(playerid, 281.0000, 278.0000, "3");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][12], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][12], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][12], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][12], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][12], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][12], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][12], 1344);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][12], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][12], 1);

	model_browser_pgui[playerid][13] = CreatePlayerTextDraw(playerid, 343.5000, 278.0000, "4");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][13], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][13], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][13], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][13], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][13], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][13], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][13], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][13], 1335);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][13], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][13], 1);

	model_browser_pgui[playerid][14] = CreatePlayerTextDraw(playerid, 406.0000, 278.0000, "5");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][14], 5);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][14], 0.5000, 6.0000);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][14], 2004318122);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][14], 1);
	PlayerTextDrawUseBox(playerid, model_browser_pgui[playerid][14], 1);
	PlayerTextDrawBoxColor(playerid, model_browser_pgui[playerid][14], 0);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][14], 60.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, model_browser_pgui[playerid][14], 1334);
	PlayerTextDrawSetPreviewRot(playerid, model_browser_pgui[playerid][14], 0.0000, 0.0000, 0.0000, 1.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][14], 1);

	model_browser_pgui[playerid][15] = CreatePlayerTextDraw(playerid, 312.0000, 138.5000, "Enter the menu name here");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][15], 3);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][15], 0.3499, 1.1499);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][15], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][15], -555819265);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][15], 1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][15], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][15], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][15], 0.0000, 500.0000);

	model_browser_pgui[playerid][16] = CreatePlayerTextDraw(playerid, 312.0000, 341.0000, "page 132");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][16], 3);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][16], 0.2500, 0.9499);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][16], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][16], -555819265);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][16], 1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][16], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][16], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][16], 0.0000, 500.0000);
	PlayerTextDrawSetSelectable(playerid, model_browser_pgui[playerid][16], 1);

	model_browser_pgui[playerid][17] = CreatePlayerTextDraw(playerid, 185.5000, 195.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][17], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][17], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][17], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][17], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][17], 0.0000, 500.0000);

	model_browser_pgui[playerid][18] = CreatePlayerTextDraw(playerid, 249.0000, 195.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][18], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][18], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][18], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][18], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][18], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][18], 0.0000, 500.0000);

	model_browser_pgui[playerid][19] = CreatePlayerTextDraw(playerid, 311.0000, 195.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][19], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][19], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][19], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][19], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][19], 0.0000, 500.0000);

	model_browser_pgui[playerid][20] = CreatePlayerTextDraw(playerid, 373.0000, 195.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][20], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][20], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][20], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][20], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][20], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][20], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][20], 0.0000, 500.0000);

	model_browser_pgui[playerid][21] = CreatePlayerTextDraw(playerid, 437.0000, 195.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][21], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][21], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][21], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][21], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][21], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][21], 0.0000, 500.0000);

	model_browser_pgui[playerid][22] = CreatePlayerTextDraw(playerid, 185.5000, 258.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][22], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][22], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][22], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][22], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][22], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][22], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][22], 0.0000, 500.0000);

	model_browser_pgui[playerid][23] = CreatePlayerTextDraw(playerid, 249.0000, 258.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][23], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][23], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][23], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][23], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][23], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][23], 0.0000, 500.0000);

	model_browser_pgui[playerid][24] = CreatePlayerTextDraw(playerid, 311.0000, 258.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][24], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][24], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][24], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][24], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][24], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][24], 0.0000, 500.0000);

	model_browser_pgui[playerid][25] = CreatePlayerTextDraw(playerid, 373.0000, 258.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][25], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][25], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][25], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][25], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][25], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][25], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][25], 0.0000, 500.0000);

	model_browser_pgui[playerid][26] = CreatePlayerTextDraw(playerid, 437.0000, 258.5000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][26], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][26], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][26], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][26], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][26], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][26], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][26], 0.0000, 500.0000);

	model_browser_pgui[playerid][27] = CreatePlayerTextDraw(playerid, 185.5000, 321.0000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][27], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][27], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][27], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][27], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][27], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][27], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][27], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][27], 0.0000, 500.0000);

	model_browser_pgui[playerid][28] = CreatePlayerTextDraw(playerid, 249.0000, 321.0000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][28], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][28], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][28], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][28], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][28], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][28], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][28], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][28], 0.0000, 500.0000);

	model_browser_pgui[playerid][29] = CreatePlayerTextDraw(playerid, 311.0000, 321.0000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][29], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][29], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][29], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][29], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][29], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][29], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][29], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][29], 0.0000, 500.0000);

	model_browser_pgui[playerid][30] = CreatePlayerTextDraw(playerid, 373.0000, 321.0000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][30], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][30], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][30], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][30], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][30], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][30], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][30], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][30], 0.0000, 500.0000);

	model_browser_pgui[playerid][31] = CreatePlayerTextDraw(playerid, 437.0000, 321.0000, "Model Name Here ~n~ Double String");
	PlayerTextDrawFont(playerid, model_browser_pgui[playerid][31], 1);
	PlayerTextDrawLetterSize(playerid, model_browser_pgui[playerid][31], 0.1749, 0.7500);
	PlayerTextDrawAlignment(playerid, model_browser_pgui[playerid][31], 2);
	PlayerTextDrawColor(playerid, model_browser_pgui[playerid][31], -1);
	PlayerTextDrawSetShadow(playerid, model_browser_pgui[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, model_browser_pgui[playerid][31], -1);
	PlayerTextDrawBackgroundColor(playerid, model_browser_pgui[playerid][31], 255);
	PlayerTextDrawSetProportional(playerid, model_browser_pgui[playerid][31], 1);
	PlayerTextDrawTextSize(playerid, model_browser_pgui[playerid][31], 0.0000, 500.0000);

	return true ;
}