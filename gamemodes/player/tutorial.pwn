
new Text:td_tutorial[3] = Text: INVALID_TEXT_DRAW ;
new PlayerText:ptd_tutorial[MAX_PLAYERS][2] = { PlayerText: INVALID_TEXT_DRAW, ... };


enum E_TUTORIAL_STAGE_DATA
{
	Float:E_TUTORIAL_STAGE_POS[3],
	Float:E_TOTORIAL_STAGE_LOOK[3],
	E_TUTORIAL_STAGE_INTERPOLATE[2],
	E_TUTORIAL_STAGE_TITLE[128],
	E_TUTORIAL_STAGE_LINE_1[256],
	E_TUTORIAL_STAGE_LINE_2[256],
	E_TUTORIAL_STAGE_LINE_3[256]
}

 // fire station
 // police station
//{1886.49, -1748.44, 22.45}, {1883.76, -1752.59, 21.90} // dealership

static const TutorialStage[][E_TUTORIAL_STAGE_DATA] = 
{
	{ {1277.29, -1446.01, 154.44}, {1281.01, -1442.75, 155.19}, {2500, 2500}, "The Introduction: Part 1", "Welcome to ~y~Los Santos~w~, a city tearing itself apart with gang trouble, drugs and corruption.", "Where film stars and millionaires do their best to avoid the dealers and gangbangers.", "It's 1994, and the war for control of the streets rages as fiercely as ever." },
	{ {2330.42, -1748.99, 42.76}, {2331.06, -1748.22, 42.46}, {2500, 2500}, "The Introduction: Part 2", "We pick up where the singleplayer protagonists left off, two years after the events of Carl Johnson.", "The server has existed since 2007, originally as the ~y~\"Streets of Los Santos\" ~w~(SOLS)", "The current owner is Dignity / Hades. Known for Medieval RP, Wild West RP and GTA Chronicles." },

	{ {2199.20, -1470.28, 44.36}, {2200.00, -1469.68, 44.02}, {2500, 2500}, "Street Life: Part 1", "As we're set in the late 90s, classic street gangs are one of the main, recurring themes of the city.", "Most new players looking to join a gang start out by proving themselves as a hoodrat.", "Once the O.G.'s deem you fit you will gain your rag and the perks that come with it." },
	{ {2215.0942, -1403.5071, 45.4201}, {2214.6221, -1402.6250, 45.1550}, {2500, 2500}, "Street Life: Part 2", "Traditionally, the ~g~~h~Families~w~, ~p~~h~Ballas~w~, ~b~~h~~h~~h~Aztecas~w~ and ~y~~h~Vagos~w~ form the beating heart of the streets.", "The dominance of these classic sets is under threat, though, as many new and different factions emerge.", "Which side will you pick?" },
	{ {2340.0908, -1504.1943, 32.9516}, {2339.3796, -1504.8962, 32.7466}, {2500, 2500}, "Street Life: Part 3", "As a hoodrat you must prove yourself.", "Join your gang in brawls, spray graffiti on enemy turfs, host and join parties (BBQ, fight clubs, ...) and more.", "Our server really tries to capture the hood roleplay - moreso than any other server." },
	{ {2453.09, -1981.69, 20.05}, {2452.62, -1980.80, 19.74}, {3000, 3000}, "Hood Life: Part 4", "There will come a day where you must defend your territory with your homies.", "You can stop by ~y~Emmet~w~ to buy melee weapons, and after joining a faction, firearms too.", "Emmet only sells cheap, low quality weapons though so if you need something better, you'll have to look around." },	
	
	{ {2095.66, -1828.36, 23.23}, {2097.52, -1823.73, 22.86}, {2500, 2500}, "Street Dynamics: Part 1", "With plentiful places to eat scattered across town, you'll never go hungry in Los Santos.", "Pass by Pizza Stacks, Burger Shot, Cluckin' Bell or one of the smaller cafes or coffee shops.", "Their different menus will make you feel better!" },
	{ {683.25, -1890.73, 8.98}, {680.04, -1886.92, 8.61}, {2500, 2500}, "Street Dynamics: Part 2", "Careful though, eating too much will make you fat!", "To lose fat, become stronger or learn new moves you can visit a ~y~gym~w~.", "This system is very similar to singleplayer, but won't interrupt your roleplay!" },
	{ {1997.27, -1453.48, 30.67}, {1997.94, -1452.74, 30.42}, {4000, 4000}, "Street Dynamics: Part 3", "We have an intricate injury system with different damage types.", "~r~Leg damage~w~ will make you stumble and unable to jump. ~r~Arm damage~w~ will reduce your weapon skills.", "To heal these injuries you can call for a medic or visit a ~y~hospital~w~." },
	
	{ {2413.3135, -1738.1959, 15.3604}, {2414.1533, -1738.7324, 15.2604}, {2500, 2500}, "Earning Money: Part 1", "Cash is King in Los Santos, and there's plenty of ways to both earn and spend.", "We have a wide selection of ~y~enterable stores~w~ around town where you can buy goods and services.", "Just don't stick around in one for too long.~n~They get robbed. A lot." },
	{ {2753.18, -2476.85, 30.49}, {2755.84, -2472.65, 30.02}, {2500, 2500}, "Earning Money: Part 2", "But while the crime-ridden streets offer up many spoils, that doesn't mean there aren't also legal alternatives.", "The ~y~dockworker job~w~ will have you organize the dock's hangars, going from A to B to C.", "Additionally, the docks also house the ~y~garbage job~w~." },
	{ {-102.60, -1127.87, 12.98}, {-101.60, -1127.79, 12.64}, {2500, 2500}, "Earning Money: Part 3", "For advanced players there is also a ~y~career trucker job~w~.", "Buy a trucker vehicle and use the PDA to route yourself. You must then sell the goods to businesses in San Andreas.", "The more jobs you do, the more you unlock." },

	{ {2119.2134, -1108.8983, 35.1542}, {2119.5752, -1109.8276, 34.9142}, {2500, 2500}, "Getting About: Part 1", "If you really want to fit in with the locals, you'll need a car.", "Hundreds of different cars, motorcycles and bikes are available at the various ~y~dealerships~w~.", "You can find dealerships on the map, or use the GPS system." },
	{ {1868.1677, -1461.7943, 24.0910}, {1867.3104, -1461.2834, 23.8310}, {2500, 2500}, "Getting About: Part 2", "But you'll need a driver's license to legally drive or buy a car of your own.", "You can get a license at here ~y~near the skate park~w~ by filling out the DMV's paperwork.", "Real gangsters drive without a license though!" },
	{ {1962.6599, -1171.1534, 30.5904}, {1963.4125, -1171.8075, 30.4604}, {2500, 2500}, "Getting About: Part 3", "Just like the Mayor, public transport in Los Santos is a running joke.", "There is a bus service however which new players can use to get around.", "Private firms sometimes offer taxi and limousine rides, too." },

	{ {2167.27, -2197.68, 21.29}, {2172.21, -2198.43, 21.14}, {2500, 2500}, "Conclusion", "That concludes this short introduction, but with so much of the city remodelled there's loads to explore!", "Type ~y~/help~w~ for more information.~n~Type ~y~/ask~w~ if you have any questions.", "And for admin assistance, type ~y~/report~w~." },
	{ {1799.9269, -1942.9552, 27.4178}, {1799.1178, -1943.5408, 27.2378}, {0, 0}, "Get Involved", "We are very active on ~p~Discord~w~ and highly recommend you join at ~y~discord.gg/sp-rp~w~", "Our community is welcoming, and our different teams are always looking for talented people to contribute.", "That's all from us, time to write your own story now." }
};

new TutorialSkipCooldown[MAX_PLAYERS];
CMD:tutorial(playerid) {

	if ( Character [ playerid ] [ E_CHARACTER_TUTORIAL ] ) {

		return SendClientMessage(playerid, -1, "You've already done the tutorial!" ) ;
	}

	TutorialSkipCooldown[playerid] = gettime() + 3;

	inline TutorialConfirmation(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, inputtext

		if(!response) {
			
			SendClientMessage(playerid, COLOR_ERROR, "You must make a decision.");
			cmd_tutorial(playerid);
			return 1;
		}
		else if (response) {

			if(TutorialSkipCooldown[playerid] > gettime()) {
				SendClientMessage(playerid, COLOR_ERROR, "You must wait a few seconds before making a decision.");
				cmd_tutorial(playerid);
				return true;
			}
			
			switch ( listitem ) {

				case 0: {
					StartTutorial(playerid); 
				}
				case 1: {
					FinishTutorial(playerid);
				}
			}

			return true ;
		}
	}
	Dialog_ShowCallback ( playerid, using inline TutorialConfirmation, DIALOG_STYLE_LIST, "Tutorial", "Do the tutorial\nSkip the tutorial", "Continue", "Quit");

	return true;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
	TutorialSkipCooldown[playerid] = 0;
	return 1;
}

StartTutorial(playerid) {

	for ( new i, j = 2; i < j ; i ++ ) {

		PlayerTextDrawShow(playerid, ptd_tutorial[playerid] [ i ] );
	}

	TextDrawShowForPlayer(playerid, td_tutorial [ 0 ] );

	PlayerTextDrawSetString(playerid, ptd_tutorial[playerid][0], "Setting up tutorial..." ) ;
	PlayerTextDrawSetString(playerid, ptd_tutorial[playerid][1], "Please wait while we set up the tutorial for you." ) ;

	PlayerVar [ playerid ] [ E_PLAYER_IS_DOING_TUTORIAL ] = true ;
	PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] = 0 ;
	PlayerVar[playerid][E_PLAYER_TUTORIAL_LAST_STAGE] = 0;
	PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING] = false;

	TogglePlayerSpectating(playerid, true ) ;

	SetPlayerInterior ( playerid, 0 );
	SetPlayerVirtualWorld(playerid, 0 );

	defer Tutorial_SetupScenario( playerid ) ;

	return true ;
}

FinishTutorial(playerid) {

	PlayerVar [ playerid ] [ E_PLAYER_IS_DOING_TUTORIAL ] = false ;
	PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING] = false;
	PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] = 0 ;
	PlayerVar[playerid][E_PLAYER_TUTORIAL_LAST_STAGE] = 0;

	Character [ playerid ] [ E_CHARACTER_TUTORIAL ] = true ;

	new query[128];
	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_tutorial = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_TUTORIAL ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	CancelSelectTextDraw(playerid);
	SpawnArea_Selection(playerid) ;
}

static TutString[1024];

ShowTutorialStage(playerid, stage)
{
	new postime = TutorialStage[stage][E_TUTORIAL_STAGE_INTERPOLATE][0];


	//new looktime = TutorialStage[stage][E_TUTORIAL_STAGE_INTERPOLATE][1];
	//new last = PlayerVar[playerid][E_PLAYER_TUTORIAL_LAST_STAGE];

	/*
	if (postime && last >= 0) InterpolateCameraPos(playerid, TutorialStage[last][E_TUTORIAL_STAGE_POS][0], TutorialStage[last][E_TUTORIAL_STAGE_POS][1], TutorialStage[last][E_TUTORIAL_STAGE_POS][2], TutorialStage[stage][E_TUTORIAL_STAGE_POS][0], TutorialStage[stage][E_TUTORIAL_STAGE_POS][1], TutorialStage[stage][E_TUTORIAL_STAGE_POS][2], postime);
	else SetPlayerCameraPos(playerid, TutorialStage[stage][E_TUTORIAL_STAGE_POS][0], TutorialStage[stage][E_TUTORIAL_STAGE_POS][1], TutorialStage[stage][E_TUTORIAL_STAGE_POS][2]);

	if (looktime && last >= 0) InterpolateCameraLookAt(playerid, TutorialStage[last][E_TOTORIAL_STAGE_LOOK][0], TutorialStage[last][E_TOTORIAL_STAGE_LOOK][1], TutorialStage[last][E_TOTORIAL_STAGE_LOOK][2], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][0], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][1], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][2], looktime);
	else SetPlayerCameraLookAt(playerid, TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][0], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][1], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][2]);
	*/


	SetPlayerCameraPos(playerid, TutorialStage[stage][E_TUTORIAL_STAGE_POS][0], TutorialStage[stage][E_TUTORIAL_STAGE_POS][1], TutorialStage[stage][E_TUTORIAL_STAGE_POS][2]);
	SetPlayerCameraLookAt(playerid, TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][0], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][1], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][2]);
	Streamer_UpdateEx(playerid, TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][0], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][1], TutorialStage[stage][E_TOTORIAL_STAGE_LOOK][2], 0, 0, STREAMER_TYPE_OBJECT, -1, 0);

	TutString[0] = EOS;
	PlayerTextDrawSetString(playerid, ptd_tutorial[playerid][0], TutorialStage[stage][E_TUTORIAL_STAGE_TITLE]);
	strcat(TutString, TutorialStage[stage][E_TUTORIAL_STAGE_LINE_1]);

	if (strlen(TutorialStage[stage][E_TUTORIAL_STAGE_LINE_2]))
	{
		strcat(TutString, "~n~~n~");
		strcat(TutString, TutorialStage[stage][E_TUTORIAL_STAGE_LINE_2]);
	} 

	if (strlen(TutorialStage[stage][E_TUTORIAL_STAGE_LINE_3]))
	{
		strcat(TutString, "~n~~n~");
		strcat(TutString, TutorialStage[stage][E_TUTORIAL_STAGE_LINE_3]);
	} 

	PlayerTextDrawSetString(playerid, ptd_tutorial[playerid][1], TutString) ;
	// SelectTextDraw(playerid, 0xDEDEDEFF );

	TextDrawHideForPlayer ( playerid, td_tutorial[1] );
	TextDrawHideForPlayer ( playerid, td_tutorial[2] );

	defer Tutorial_CameraMoved[postime](playerid);
	//Tutorial_CameraMoved(playerid);
}

timer Tutorial_CameraMoved[1000](playerid)
{
	new stage = PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] ;

	// Previous Button
	if ( stage > 0 ) TextDrawShowForPlayer ( playerid, td_tutorial[1] ) ;
	else TextDrawHideForPlayer ( playerid, td_tutorial[1] );

	// Next Button
	if ( stage + 1 < sizeof(TutorialStage)) TextDrawSetString(td_tutorial[2], "Next" );
	else TextDrawSetString(td_tutorial[2], "~y~Finish" );
	TextDrawShowForPlayer ( playerid, td_tutorial[2] ) ;

	PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING] = false;
	SelectTextDraw(playerid, 0xDEDEDEFF );
}	

timer Tutorial_SetupScenario[1000]( playerid ) {

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_IS_DOING_TUTORIAL ] ) {

		for ( new i, j = 2; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid, ptd_tutorial[playerid] [ i ] );
		}
		for ( new i, j = sizeof ( td_tutorial ); i < j ; i ++ ) {

			TextDrawHideForPlayer(playerid, td_tutorial [ i ] );
		}

		PlayerVar [ playerid ] [ E_PLAYER_IS_DOING_TUTORIAL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] = 0 ;
		PlayerVar[playerid][E_PLAYER_TUTORIAL_LAST_STAGE] = 0;
		PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING] = false;

		CancelSelectTextDraw(playerid);

		if ( GetPlayerState ( playerid ) == PLAYER_STATE_SPECTATING ) {
			SendClientMessage(playerid, COLOR_RED, "Tried to load tutorial whilst you've already done it. Select a spawn point!" ) ;
			Player_DisplaySpawnList(playerid);
		}

		return true ;
	}

	new stage = PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] ;

	if (stage >= sizeof(TutorialStage))
	{
		// Finish tutorial
		for ( new i, j = 2; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid, ptd_tutorial[playerid] [ i ] );
		}
		for ( new i, j = sizeof ( td_tutorial ); i < j ; i ++ ) {

			TextDrawHideForPlayer(playerid, td_tutorial [ i ] );
		}

		FinishTutorial(playerid);
		return true ;
	}

	// Previous Button
	if ( stage > 0 ) TextDrawShowForPlayer ( playerid, td_tutorial[1] ) ;
	else TextDrawHideForPlayer ( playerid, td_tutorial[1] );

	// Next Button
	if ( stage + 1 < sizeof(TutorialStage)) TextDrawSetString(td_tutorial[2], "Next" );
	else TextDrawSetString(td_tutorial[2], "~g~Finish" );
	//TextDrawShowForPlayer ( playerid, td_tutorial[2] ) ;

	ShowTutorialStage(playerid, stage);
	//CancelSelectTextDraw(playerid);

	return true ;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid) {

	if ( PlayerVar[playerid][E_PLAYER_IS_DOING_TUTORIAL] && clickedid != Text:INVALID_TEXT_DRAW ) 
	{
		if ( clickedid == td_tutorial[1] ) // tutorial_back
		{ 
			if (!PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING])
			{
				PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING] = true;
				PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_LAST_STAGE ] = PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ];
				PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] -- ;
				Tutorial_SetupScenario( playerid ) ;
			}
		}		
		else if ( clickedid == td_tutorial[2] ) // tutorial_next
		{
			if (!PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING])
			{
				PlayerVar[playerid][E_PLAYER_TUTORIAL_WAITING] = true;
				PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_LAST_STAGE ] = PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ];
				PlayerVar [ playerid ] [ E_PLAYER_TUTORIAL_STAGE ] ++ ;
				Tutorial_SetupScenario( playerid ) ;
			}
		}
		else
		{
			SelectTextDraw(playerid, 0xDEDEDEFF );
		}
	}

	#if defined tut_OnPlayerClickTextDraw
		return tut_OnPlayerClickTextDraw(playerid, Text: clickedid );
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw tut_OnPlayerClickTextDraw
#if defined tut_OnPlayerClickTextDraw
	forward tut_OnPlayerClickTextDraw(playerid, Text: clickedid );
#endif

TutorialGUI_DestroyPlayer(playerid) {

	for ( new i, j = sizeof ( td_tutorial ); i < j ; i ++ ) {

		TextDrawHideForPlayer(playerid, td_tutorial [ i ] ) ;
	}

	for ( new i, j = 2; i < j ; i ++ ) {

		PlayerTextDrawDestroy(playerid, ptd_tutorial[playerid] [ i ] ) ;
	}

	return true ;
}

TutorialGUI_CreatePlayer(playerid) {

	ptd_tutorial[playerid][0] = CreatePlayerTextDraw(playerid, 194.0000, 285.0000, "title");
	PlayerTextDrawFont(playerid, ptd_tutorial[playerid][0], 0);
	PlayerTextDrawLetterSize(playerid, ptd_tutorial[playerid][0], 0.5000, 1.7500);
	PlayerTextDrawColor(playerid, ptd_tutorial[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, ptd_tutorial[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, ptd_tutorial[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, ptd_tutorial[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, ptd_tutorial[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, ptd_tutorial[playerid][0], 500.0000, 0.0000);

	ptd_tutorial[playerid][1] = CreatePlayerTextDraw(playerid, 207.0000, 305.0000, "text");
	PlayerTextDrawFont(playerid, ptd_tutorial[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, ptd_tutorial[playerid][1], 0.2500, 1.0000);
	PlayerTextDrawColor(playerid, ptd_tutorial[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, ptd_tutorial[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, ptd_tutorial[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, ptd_tutorial[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, ptd_tutorial[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, ptd_tutorial[playerid][1], 450.0000, 0.0000);
}

TutorialGUI_CreateStatic() {

	td_tutorial[0] = TextDrawCreate(200.0000, 297.5000, "_");
	TextDrawFont(td_tutorial[0], 1);
	TextDrawLetterSize(td_tutorial[0], 0.2500, 10.0000);
	TextDrawColor(td_tutorial[0], -1);
	TextDrawSetShadow(td_tutorial[0], 0);
	TextDrawSetOutline(td_tutorial[0], 0);
	TextDrawBackgroundColor(td_tutorial[0], 255);
	TextDrawSetProportional(td_tutorial[0], 1);
	TextDrawUseBox(td_tutorial[0], 1);
	TextDrawBoxColor(td_tutorial[0], 170);
	TextDrawTextSize(td_tutorial[0], 450.0000, 0.0000);

	td_tutorial[1] = TextDrawCreate(213.5000, 377.5000, "Back");
	TextDrawFont(td_tutorial[1], 3);
	TextDrawLetterSize(td_tutorial[1], 0.2500, 1.0000);
	TextDrawAlignment(td_tutorial[1], 2);
	TextDrawColor(td_tutorial[1], -1);
	TextDrawSetShadow(td_tutorial[1], 0);
	TextDrawSetOutline(td_tutorial[1], 1);
	TextDrawBackgroundColor(td_tutorial[1], 255);
	TextDrawSetProportional(td_tutorial[1], 1);
	TextDrawUseBox(td_tutorial[1], 1);
	TextDrawBoxColor(td_tutorial[1], 170);
	TextDrawTextSize(td_tutorial[1], 25.0000, 25.0000);
	TextDrawSetSelectable(td_tutorial[1], true);

	td_tutorial[2] = TextDrawCreate(436.5000, 377.5000, "Next");
	TextDrawFont(td_tutorial[2], 3);
	TextDrawLetterSize(td_tutorial[2], 0.2500, 1.0000);
	TextDrawAlignment(td_tutorial[2], 2);
	TextDrawColor(td_tutorial[2], -1);
	TextDrawSetShadow(td_tutorial[2], 0);
	TextDrawSetOutline(td_tutorial[2], 1);
	TextDrawBackgroundColor(td_tutorial[2], 255);
	TextDrawSetProportional(td_tutorial[2], 1);
	TextDrawUseBox(td_tutorial[2], 1);
	TextDrawBoxColor(td_tutorial[2], 170);
	TextDrawTextSize(td_tutorial[2], 25.0000, 25.0000);
	TextDrawSetSelectable(td_tutorial[2], true);
}

