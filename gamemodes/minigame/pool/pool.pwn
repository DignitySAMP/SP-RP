/*
 * Irresistible Gaming (c) 2018
 * Developed by Stev, Lorenc
 * Module: cnr/features/pool.pwn
 * Purpose: pool minigame
 */

/* ** Includes ** */
#include 							"minigame/pool/physics.pwn"

/* ** Definitions ** */
#define POCKET_RADIUS 				( 0.09 ) // original: 0.09
#define POOL_TIMER_SPEED 			( 30 ) // original: 30
#define DEFAULT_AIM 				( 0.38 ) // original: 38
#define CUEBALL_PLACE_SPEED			( 0.01 ) // originally 0.01
#define POOL_ANGLE_UPDATE			( 0.9 ) // 0.9 originally

#define DEFAULT_POOL_STRING 		"Pool Table\n{FFFFFF}Press ENTER To Play"
#define POOL_FEE_RATE 				( 0.02 )

#define MAX_POOL_TABLES 			( 75 )
#define MAX_POOL_BALLS 				( 16 ) // do not modify

/* ** Macros ** */
#define SendPoolMessage(%0,%1)		SendClientMessageFormatted(%0, -1, "{4B8774}[POOL] {E5861A}" # %1)

/* ** Constants (do not modify) ** */
enum E_POOL_BALL_TYPE {
	E_STRIPED,
	E_SOLID,
	E_CUE,
	E_8BALL
};


enum E_POOL_BALL_OFFSET_DATA
{
	E_MODEL_ID, 					E_BALL_NAME[ 9 ],				E_POOL_BALL_TYPE: E_BALL_TYPE,
	Float: E_OFFSET_X, 				Float: E_OFFSET_Y
};

static const
	g_poolBallOffsetData[ MAX_POOL_BALLS ] [ E_POOL_BALL_OFFSET_DATA ] =
	{
		{ 3003, "Cueball", 	E_CUE, 		0.5000, 0.0000 },
		{ 3002, "One",		E_SOLID,	-0.300, 0.0000 },
		{ 3100, "Two",		E_SOLID, 	-0.525, -0.040 },
		{ 3101, "Three",	E_SOLID,	-0.375, 0.0440 },
		{ 3102, "Four",		E_SOLID,	-0.600, 0.0790 },
		{ 3103,	"Five",		E_SOLID,	-0.525, 0.1180 },
		{ 3104,	"Six",		E_SOLID,	-0.600, -0.157 },
		{ 3105, "Seven",	E_SOLID,	-0.450, -0.079 },
		{ 3106,	"Eight",	E_8BALL,	-0.450, 0.0000 },
		{ 2995, "Nine",		E_STRIPED,	-0.375, -0.044 },
		{ 2996, "Ten",		E_STRIPED,	-0.450, 0.0790 },
		{ 2997, "Eleven",	E_STRIPED,	-0.525, -0.118 },
		{ 2998, "Twelve",	E_STRIPED,	-0.600, -0.079 },
		{ 2999, "Thirteen",	E_STRIPED,	-0.600, 0.0000 },
		{ 3000, "Fourteen",	E_STRIPED,	-0.600, 0.1570 },
		{ 3001, "Fiftteen",	E_STRIPED,	-0.525, 0.0400 }
	},
	Float: g_poolPotOffsetData[ ] [ ] =
	{
		{ 0.955, 0.510 }, { 0.955, -0.49 },
		{ 0.005, 0.550 }, { 0.007, -0.535 },
		{ -0.945, 0.513 }, { -0.945, -0.490 }
	},
	g_poolHoleOpposite[ sizeof( g_poolPotOffsetData ) ] = { 5, 4, 3, 2, 1, 0 }
;

/* ** Variables ** */
enum E_POOL_BALL_DATA
{
	E_BALL_PHY_HANDLE[ 16 ],		bool: E_POCKETED[ 16 ]
};

enum E_POOL_TABLE_DATA
{
	E_SQLID,
	Float: E_X,						Float: E_Y, 					Float: E_Z,
	Float: E_ANGLE, 				E_WORLD, 						E_INTERIOR,

	E_TIMER, 						E_BALLS_SCORED, 				E_POOL_BALL_TYPE: E_PLAYER_BALL_TYPE[ MAX_PLAYERS ],
	bool: E_STARTED, 				E_AIMER, 						E_AIMER_OBJECT,
	E_NEXT_SHOOTER,

	E_SHOTS_LEFT,					E_FOULS,						E_PLAYER_8BALL_TARGET[ MAX_PLAYERS ],
	bool: E_EXTRA_SHOT,				bool: E_CUE_POCKETED,

	E_WAGER,						bool: E_READY,					E_CUEBALL_AREA,

	Float: E_POWER,					E_DIRECTION,

	E_TABLE,						DynamicText3D: E_LABEL,			E_SKIN,
	E_WALL [ 4 ]
};

new
	g_poolTableData 				[ MAX_POOL_TABLES ] [ E_POOL_TABLE_DATA ],
	g_poolBallData 					[ MAX_POOL_TABLES ] [ E_POOL_BALL_DATA ],

	p_PoolID 						[ MAX_PLAYERS ] = { -1, ... },

	bool: p_isPlayingPool			[ MAX_PLAYERS char ],
	bool: p_PoolChalking			[ MAX_PLAYERS char ],
	bool: p_PoolCameraBirdsEye		[ MAX_PLAYERS char ],
	p_PoolScore 					[ MAX_PLAYERS ],
	p_PoolHoleGuide 				[ MAX_PLAYERS ] = { -1, ... },
	Float: p_PoolAngle 				[ MAX_PLAYERS ] [ 2 ],

	PlayerBar: g_PoolPowerBar 		[ MAX_PLAYERS ],
	Text: g_PoolTextdraw			= Text: INVALID_TEXT_DRAW,

	Iterator: pooltables 			< MAX_POOL_TABLES >,
	Iterator: poolplayers 			< MAX_POOL_TABLES, MAX_PLAYERS >
;

/* ** Forwards ** */
forward deleteBall 					( poolid, ballid );
forward RestoreWeapon 				( playerid );
forward RestoreCamera 				( playerid );
forward OnPoolUpdate 				( poolid );
//forward PlayPoolSound 				( poolid, soundid );

/* ** Hooks ** */
Pool_OnScriptInit( )
{
	g_PoolTextdraw = TextDrawCreate(553.00000, 108.000000, "POWER");
	TextDrawAlignment(g_PoolTextdraw, 2);
	TextDrawBackgroundColor(g_PoolTextdraw, 255);
	TextDrawFont(g_PoolTextdraw, 2);
	TextDrawLetterSize(g_PoolTextdraw, 0.3, 1.499999);
	TextDrawColor(g_PoolTextdraw, -1);
	TextDrawSetOutline(g_PoolTextdraw, 1);
	TextDrawSetProportional(g_PoolTextdraw, 1);
	TextDrawSetSelectable(g_PoolTextdraw, 0);

	printf( "[POOL TABLES]: %d pool tables have been successfully loaded.", Iter_Count( pooltables ) );
	return 1;
}


Pool_OnPlayerConnect(playerid) {
	g_PoolPowerBar[ playerid ] = CreatePlayerProgressBar( playerid, 525.00, 125, 62.50, 5.19, -1395920385, 100.0);
	RemoveBuildingForPlayer( playerid, 2964, 510.1016, -84.8359, 997.9375, 9999.9 );
	
	#if defined pool_OnPlayerConnect
		return pool_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect pool_OnPlayerConnect
#if defined pool_OnPlayerConnect
	forward pool_OnPlayerConnect(playerid);
#endif

Pool_OnPlayerUpdate(playerid) {

	if ( IsPlayerPlayingPool( playerid ) && p_PoolID[ playerid ] != -1 )
	{
		new Float: distance_to_table = GetPlayerDistanceFromPoint( playerid, g_poolTableData[ p_PoolID[ playerid ] ] [ E_X ], g_poolTableData[ p_PoolID[ playerid ] ] [ E_Y ], g_poolTableData[ p_PoolID[ playerid ] ] [ E_Z ] );

		if ( distance_to_table >= 25.0 )
		{
			Pool_SendTableMessage( p_PoolID[ playerid ], COLOR_GREY, "(%d) %s has been kicked from the table [Reason: Out Of Range]", playerid, ReturnMixedName(playerid) );
			return Pool_RemovePlayer( playerid ), 1;
		}
	}

	return true ;
}

public OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	new Float: pooltable_distance = 99999.99;
	new poolid = Pool_GetClosestTable( playerid, pooltable_distance );

	if ( poolid != -1 && pooltable_distance < 2.5 )
	{
		if ( g_poolTableData[ poolid ] [ E_STARTED ] )
		{
			// quit table
			if ( HOLDING( KEY_SECONDARY_ATTACK ) && IsPlayerPlayingPool( playerid ) ) {
				if ( PRESSED( KEY_CROUCH ) ) {
					HideMinigameHelpBox ( playerid );
					RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
					Pool_SendTableMessage( poolid, COLOR_GREY, "(%d) %s has left the table", playerid, ReturnMixedName(playerid));
					return Pool_RemovePlayer( playerid );
				} else {
					return GameTextForPlayer( playerid, "~w~and now...~n~~w~ press ~r~~k~~PED_DUCK~~w~ to exit", 3500, 3 ), 1;
				}
			}

			// make pressing key fire annoying
			if ( RELEASED( KEY_FIRE ) && g_poolTableData[ poolid ] [ E_AIMER ] != playerid && ! p_PoolChalking{ playerid } )
			{
				// reset anims of player
				if ( IsPlayerPlayingPool( playerid ) )
				{
					p_PoolChalking{ playerid } = true;

					SetPlayerArmedWeapon( playerid, 0 );
					SetPlayerAttachedObject( playerid, E_ATTACH_INDEX_MINIGAME, 338, 6, 0, 0.07, -0.85, 0, 0, 0 );
					ApplyAnimation( playerid, "POOL", "POOL_ChalkCue", 3.0, 0, 1, 1, 1, 0, 1 );

					//SetTimerEx( "PlayPoolSound", 1400, false, "dd", playerid, 31807 );
					SetTimerEx( "RestoreWeapon", 3500, false, "d", playerid );
				}
				else
				{
					ClearAnimations( playerid );
				}

				// reset ball positions just in-case they hit it
				if ( Pool_AreBallsStopped( poolid ) ) {
					Pool_ResetBallPositions( poolid );
				}
				return 1;
			}

			// begin gameplay stuff
			if ( IsPlayerPlayingPool( playerid ) && p_PoolID[ playerid ] == poolid )
			{
				if ( RELEASED( KEY_JUMP ) )
				{
					if ( g_poolTableData[ poolid ] [ E_AIMER ] == playerid )
					{
						p_PoolCameraBirdsEye{ playerid } = ! p_PoolCameraBirdsEye{ playerid };
						Pool_UpdatePlayerCamera( playerid, poolid );
					}
				}

				if ( RELEASED( KEY_HANDBRAKE ) )
				{
					if ( Pool_AreBallsStopped( poolid ) )
					{
						if ( g_poolTableData[ poolid ] [ E_AIMER ] != playerid )
						{
							if ( g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ] != playerid ) {
								return SendPoolMessage( playerid, "It is not your turn. Please wait." );
							}

							if ( g_poolTableData[ poolid ] [ E_CUE_POCKETED ] ) {
								return SendPoolMessage( playerid, "You can aim the cue as soon as you place the cue ball." );
							}

							if ( ! p_PoolChalking{ playerid } && g_poolTableData[ poolid ] [ E_AIMER ] == -1 )
							{
								new Float:X, Float:Y, Float:Z,
									Float:Xa, Float:Ya, Float:Za,
									Float:x, Float:y;

								GetPlayerPos( playerid, X, Y, Z );

								if ( Z > g_poolTableData[ poolid ] [ E_Z ] + 0.5 ) {
									return SendPoolMessage( playerid, "Lower yourself from the table." );
								}

								new objectid = PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] );
								GetDynamicObjectPos( objectid, Xa, Ya, Za );

								new
									Float: distance_to_ball = GetDistanceFromPointToPoint( X, Y, Xa, Ya );

								//if ( distance_to_ball < 2.0 && Z < 999.5 )
								if ( distance_to_ball < 2.0 )
								{


									new
										Float: poolrot = atan2( Ya - Y, Xa - X ) - 90.0;

									TogglePlayerControllable( playerid, false );

	                            	p_PoolAngle[ playerid ] [ 0 ] = poolrot;
	                            	p_PoolAngle[ playerid ] [ 1 ] = poolrot;

									RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
									Pool_GetXYInFrontOfPos( Xa, Ya, poolrot + 180, x, y, 0.085 );
									g_poolTableData[ poolid ] [ E_AIMER_OBJECT ] = CreateDynamicObject( 3004, x, y, Za, 7.0, 0, poolrot + 180, .worldid = g_poolTableData[ poolid ] [ E_WORLD ] );

									if ( distance_to_ball < 1.20 ) {
										distance_to_ball = 1.20;
									}

					              	Pool_GetXYInFrontOfPos( Xa, Ya, poolrot + 180 - 5.0, X, Y, distance_to_ball ); // offset 5 degrees
									PauseAC(playerid, 3);
					                SetPlayerPos( playerid, X, Y, Z );
	                				SetPlayerFacingAngle( playerid, poolrot );

									if ( distance_to_ball > 1.5 ) {
										ApplyAnimation( playerid, "POOL", "POOL_XLong_Start", 4.1, 0, 1, 1, 1, 1, 1 );
									} else {
										ApplyAnimation( playerid, "POOL", "POOL_Long_Start", 4.1, 0, 1, 1, 1, 1, 1 );
									}

									g_poolTableData[ poolid ] [ E_AIMER ] = playerid;
									g_poolTableData[ poolid ] [ E_POWER ] = 1.0;
									g_poolTableData[ poolid ] [ E_DIRECTION ] = 0;

									Pool_UpdatePlayerCamera( playerid, poolid );
									Pool_UpdateScoreboard( poolid );

									TextDrawShowForPlayer( playerid, g_PoolTextdraw );
									ShowPlayerProgressBar( playerid, g_PoolPowerBar[playerid] );
								}
							}
						}
						else
						{
							TogglePlayerControllable( playerid, true );
							SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, 338, 6 ) ; // normal cue in hand

							ClearAnimations( playerid );
	            			SetCameraBehindPlayer( playerid );
							ApplyAnimation( playerid, "CARRY", "crry_prtial", 4.0, 0, 1, 1, 0, 0 );

							TextDrawHideForPlayer( playerid, g_PoolTextdraw );
							HidePlayerProgressBar( playerid, g_PoolPowerBar[playerid] );

	            			g_poolTableData[ poolid ] [ E_AIMER ] = -1;
	            			SOLS_DestroyObject( g_poolTableData[ poolid ] [ E_AIMER_OBJECT ], "Pool/KeyStateChange KEY_RELEASE handbrake", true);
	            			g_poolTableData[ poolid ] [ E_AIMER_OBJECT ] = -1;
						}
					}
				}

				if ( RELEASED( KEY_FIRE ) )
				{
					if ( g_poolTableData[ poolid ] [ E_AIMER ] == playerid )
					{
						new Float: ball_x, Float: ball_y, Float: ball_z;

						g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] --;

						Pool_UpdateScoreboard( poolid );

						GetDynamicObjectPos( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] ), ball_x, ball_y, ball_z );
						new Float: distance_to_ball = GetPlayerDistanceFromPoint( playerid, ball_x, ball_y, ball_z );

						if ( distance_to_ball > 1.5 ) {
							ApplyAnimation( playerid, "POOL", "POOL_XLong_Shot", 4.1, 0, 1, 1, 0, 0, 1 );
						} else {
							ApplyAnimation( playerid, "POOL", "POOL_Long_Shot", 4.1, 0, 1, 1, 0, 0, 1 );
						}

						new Float: speed = 0.4 + ( g_poolTableData[ poolid ] [ E_POWER ] * 2.0 ) / 100.0;
						PHY_SetHandleVelocity( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ], speed * floatsin( -p_PoolAngle[ playerid ] [ 0 ], degrees ), speed * floatcos( -p_PoolAngle[ playerid ] [ 0 ], degrees ) );

						SetPlayerCameraPos( playerid, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] + 2.0 );
						SetPlayerCameraLookAt( playerid, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] );

						//PlayPoolSound( poolid, 31810 );
						PlayerPlaySound(playerid, 31810, 0.0, 0.0, 0.0);
						g_poolTableData[ poolid ] [ E_AIMER ] = -1;
						SOLS_DestroyObject( g_poolTableData[ poolid ] [ E_AIMER_OBJECT ], "Pool/KeyStateChange KEY_RELEASE fire", true);
						g_poolTableData[ poolid ] [ E_AIMER_OBJECT ] = -1;

						SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, 338, 6 ) ; // normal cue in hand
					}
					else ClearAnimations( playerid );
				}
			}
		}
		else
		{
			if ( PRESSED( KEY_SECONDARY_ATTACK ) )
			{
				if ( IsPlayerPlayingPool( playerid ) && Iter_Contains( poolplayers< poolid >, playerid ) )
				{
					HideMinigameHelpBox ( playerid );
					RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
					Pool_SendTableMessage( poolid, COLOR_GREY, "(%d) %s has left the table", playerid, ReturnMixedName(playerid));
					return Pool_RemovePlayer( playerid );
				}

				new
					pool_player_count = Iter_Count( poolplayers< poolid > );

				if ( pool_player_count >= 2 ) {
					return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "This pool table is currently full." );
				}

				// ensure this player isn't already joined
				if ( ! IsPlayerPlayingPool( playerid ) && ! Iter_Contains( poolplayers< poolid >, playerid ) )
				{
			        if ( GetPlayerPing ( playerid ) > 100 ) {

			            SendClientMessage(playerid, COLOR_YELLOW, "Due to your high ping (100+), the game may desync. If this occurs please leave the game A.S.A.P. or contact an admin." ) ;
			        }

					if ( pool_player_count == 1 && ! g_poolTableData[ poolid ] [ E_READY ] ) {
						return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "This pool table is not ready to play." );
					}

					new
						entry_fee = g_poolTableData[ poolid ] [ E_WAGER ];

					if ( GetPlayerCash( playerid ) < entry_fee && g_poolTableData[ poolid ] [ E_READY ] ) {
						return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You need %s to join this pool table.", IntegerWithDelimiter( entry_fee ) ) );
					}

					// add to table
					Iter_Add( poolplayers< poolid >, playerid );

					// reset variables
					p_isPlayingPool{ playerid } = true;
					p_PoolID[ playerid ] = poolid;

					// deduct cash
					if ( g_poolTableData[ poolid ] [ E_READY ] ) {
						TakePlayerCash( playerid,entry_fee );
					}

					// start the game if there's two players
					if ( pool_player_count + 1 >= 2 )
					{
					    new
					    	random_cuer = Iter_Random( poolplayers< poolid > );

						Pool_SendTableMessage( poolid, COLOR_GREY, "(%d) %s has joined the table (2/2)", playerid, ReturnMixedName(playerid));
					    Pool_QueueNextPlayer( poolid, random_cuer );

					    foreach ( new i : poolplayers< poolid > ) {
							p_PoolScore[ i ] = 0;
							PlayerPlaySound( i, 1085, 0.0, 0.0, 0.0 );

							SetPlayerAttachedObject(i, E_ATTACH_INDEX_MINIGAME, 338, 6 ) ; // normal cue in hand
					    }

						g_poolTableData[ poolid ] [ E_STARTED ] = true;
				    	Pool_UpdateScoreboard( poolid );
						Pool_RespawnBalls( poolid );
					}
					else
					{
						g_poolTableData[ poolid ] [ E_WAGER ] = 0;
						g_poolTableData[ poolid ] [ E_READY ] = false;

						inline E_DIALOG_POOL_WAGER(pid, dialogid, response, listitem, string:inputtext[]) {
		    				#pragma unused pid, dialogid, listitem, inputtext
							
							poolid = p_PoolID[ playerid ];

							if ( poolid == -1 ) {
								return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Unable to identify pool table. Please enter the pool table again." );
							}

							if ( ! CheckInputtextCrash ( playerid, inputtext )) {

								return true ;
							}		

							new wager_amount = strval( inputtext );

							if ( response && wager_amount > 0 )
							{
								if ( wager_amount > GetPlayerCash( playerid ) ) {
									Pool_RemovePlayer( playerid );
									return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You do not have this much money! Get the minimum entry fee and come back!" );
								} else {
									TakePlayerCash( playerid, wager_amount );
									g_poolTableData[ poolid ] [ E_WAGER ] = wager_amount;
									g_poolTableData[ poolid ] [ E_READY ] = true;
									Pool_SendTableMessage( poolid, -1, "(%d) %s has set the pool wager to %s!", playerid, ReturnMixedName(playerid), IntegerWithDelimiter( wager_amount ) );
									UpdateDynamic3DTextLabelText( g_poolTableData[ poolid ] [ E_LABEL ], -1, sprintf( "{A3A3A3}Pool Table\n{6EF83C}Press ENTER To Join (%d) %s\n{F81414}%s Entry", playerid, ReturnMixedName(playerid), IntegerWithDelimiter( wager_amount ) ) );
								}
								return 1;
							}
							else
							{
								g_poolTableData[ poolid ] [ E_WAGER ] = 0;
								g_poolTableData[ poolid ] [ E_READY ] = true;
								Pool_SendTableMessage( poolid, -1, "(%d) %s has set the pool wager to FREE!", playerid, ReturnMixedName(playerid));
								UpdateDynamic3DTextLabelText( g_poolTableData[ poolid ] [ E_LABEL ], -1, sprintf( "{A3A3A3}Pool Table\n{6EF83C}Press ENTER To Join (%d) %s", playerid, ReturnMixedName(playerid) ) );
							}
						}

						Dialog_ShowCallback ( playerid, using inline E_DIALOG_POOL_WAGER, DIALOG_STYLE_INPUT, "{FFFFFF}Pool Wager", "{FFFFFF}Please specify the minimum entry fee for the table:", "Set", "No Fee" );


						SendClientMessage(playerid, -1, "RMB to aim cue. LMB to shoot cue. SHIFT to change camera. F to exit." ) ;
						UpdateDynamic3DTextLabelText( g_poolTableData[ poolid ] [ E_LABEL ], -1, sprintf( "{A3A3A3}Pool Table\n{FF7500}... Waiting for (%d) %s ...", playerid, ReturnMixedName(playerid)) );
						Pool_SendTableMessage( poolid, COLOR_GREY, "-- {FFFFFF} (%d) %s has joined the table (1/2)", playerid, ReturnMixedName(playerid));
					}
					return 1;
				}
			}
		}
	}
	
	#if defined pool_OnPlayerKeyStateChange
		return pool_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange pool_OnPlayerKeyStateChange
#if defined pool_OnPlayerKeyStateChange
	forward pool_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

stock Pool_RemovePlayer( playerid )
{
	new
		poolid = p_PoolID[ playerid ];

	// reset player variables
	p_isPlayingPool{ playerid } = false;
	p_PoolScore[ playerid ] = 0;
	p_PoolID[ playerid ] = -1;

	if (p_PoolHoleGuide[ playerid ] != -1)
	{
		SOLS_DestroyObject( p_PoolHoleGuide[ playerid ], "Pool/RemovePlayer Pool Hole Guide", true);
		p_PoolHoleGuide[ playerid ] = -1;
	}
	
	RestoreCamera( playerid );
	HideMinigameHelpBox ( playerid );
	RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);

	// check if the player is even in the table
	if ( poolid != -1 && Iter_Contains( poolplayers< poolid >, playerid ) )
	{
		// remove them from the table
		Iter_Remove( poolplayers< poolid >, playerid );

		// forfeit player
		if ( g_poolTableData[ poolid ] [ E_STARTED ] )
		{
			// ... if there's only 1 guy in the table might as well declare him winner
			if ( Iter_Count( poolplayers< poolid > ) )
			{
				new
					replacement_winner = Iter_First( poolplayers< poolid > );

				Pool_OnPlayerWin( poolid, replacement_winner );
			}
			return Pool_EndGame( poolid );
		}
		else
		{
			// no players and is a ready table, then refund
			if ( ! Iter_Count( poolplayers< poolid > ) && g_poolTableData[ poolid ] [ E_READY ] )
			{
				GivePlayerCash( playerid, g_poolTableData[ poolid ] [ E_WAGER ] );
				g_poolTableData[ poolid ] [ E_READY ] = false;
				g_poolTableData[ poolid ] [ E_WAGER ] = 0;
			}
			UpdateDynamic3DTextLabelText( g_poolTableData[ poolid ] [ E_LABEL ], COLOR_GREY, DEFAULT_POOL_STRING );
		}
	}
	return 1;
}


Pool_LoadEntities() {
	inline Pool_OnDataLoad() {
		new Float: pos_x, Float: pos_y, Float: pos_z, Float: pos_a ;
		new color, int, vw, sql_id ;

		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "pool_sqlid", sql_id);
			cache_get_value_name_float(i, "pool_pos_x", pos_x);
			cache_get_value_name_float(i, "pool_pos_y", pos_y);
			cache_get_value_name_float(i, "pool_pos_z", pos_z);
			cache_get_value_name_float(i, "pool_pos_angle", pos_a);

			cache_get_value_name_int(i, "pool_pos_int", int);
			cache_get_value_name_int(i, "pool_pos_world", vw);

			cache_get_value_name_int(i, "pool_color", color);

			CreatePoolTable(INVALID_PLAYER_ID, 
				pos_x, pos_y, pos_z, pos_a, color, int, vw, sql_id
			) ;
		}

		printf(" * [POOL TABLES] Loaded %d pool tables.", cache_num_rows() ) ;
	}

	MySQL_TQueryInline(mysql, using inline Pool_OnDataLoad, "SELECT * FROM pool", "" ) ;

}

stock CreatePoolTable(playerid = INVALID_PLAYER_ID, Float: X, Float: Y, Float: Z, Float: A = 0.0, skin, interior = 0, world = 0, sqlid = 0 )
{
	if ( A != 0 && A != 90.0 && A != 180.0 && A != 270.0 && A != 360.0 ) {
		if ( playerid != INVALID_PLAYER_ID ) {
			return SendClientMessage(playerid, -1,  "[POOL] [ERROR] Pool tables must be positioned at either 0, 90, 180, 270 and 360 degrees." ), 1;
		}

		else {
			print("[POOL] [ERROR] Pool tables must be positioned at either 0, 90, 180, 270 and 360 degrees.");
		}
	}

	new
		poolid = Iter_Free( pooltables );

	if ( poolid != ITER_NONE )
	{
		new
			Float: x_vertex[ 4 ], Float: y_vertex[ 4 ];

		Iter_Add( pooltables, poolid );

		if ( sqlid ) {

			g_poolTableData[poolid] [ E_SQLID ] = sqlid ;
		}

		g_poolTableData[ poolid ] [ E_X ] = X;
		g_poolTableData[ poolid ] [ E_Y ] = Y;
		g_poolTableData[ poolid ] [ E_Z ] = Z;
		g_poolTableData[ poolid ] [ E_ANGLE ] = A;

		g_poolTableData[ poolid ] [ E_INTERIOR ] = interior;
		g_poolTableData[ poolid ] [ E_WORLD ] = world;
		g_poolTableData[ poolid ] [ E_SKIN] = skin ;

		g_poolTableData[ poolid ] [ E_TABLE ] = CreateDynamicObject( 2964, X, Y, Z - 1.0, 0.0, 0.0, A, .interiorid = interior, .worldid = world, .priority = 9999 );
		g_poolTableData[ poolid ] [ E_LABEL ] = CreateDynamic3DTextLabel( DEFAULT_POOL_STRING, COLOR_GREY, X, Y, Z, 10.0, .interiorid = interior, .worldid = world, .priority = 9999 );

		Pool_UpdateTableSkin ( g_poolTableData[ poolid ] [ E_TABLE ], skin ) ;

		Pool_RotateXY( -0.964, -0.51, A, x_vertex[ 0 ], y_vertex[ 0 ] );
		Pool_RotateXY( -0.964, 0.533, A, x_vertex[ 1 ], y_vertex[ 1 ] );
		Pool_RotateXY( 0.976, -0.51, A, x_vertex[ 2 ], y_vertex[ 2 ] );
		Pool_RotateXY( 0.976, 0.533, A, x_vertex[ 3 ], y_vertex[ 3 ] );

		g_poolTableData[ poolid ] [ E_WALL ] [ 0 ] = PHY_CreateWall( x_vertex[ 0 ] + X, y_vertex[ 0 ] + Y, x_vertex[ 1 ] + X, y_vertex[ 1 ] + Y );
		g_poolTableData[ poolid ] [ E_WALL ] [ 1 ] = PHY_CreateWall( x_vertex[ 1 ] + X, y_vertex[ 1 ] + Y, x_vertex[ 3 ] + X, y_vertex[ 3 ] + Y );
		g_poolTableData[ poolid ] [ E_WALL ] [ 2 ] = PHY_CreateWall( x_vertex[ 2 ] + X, y_vertex[ 2 ] + Y, x_vertex[ 3 ] + X, y_vertex[ 3 ] + Y );
		g_poolTableData[ poolid ] [ E_WALL ] [ 3 ] = PHY_CreateWall( x_vertex[ 0 ] + X, y_vertex[ 0 ] + Y, x_vertex[ 2 ] + X, y_vertex[ 2 ] + Y );

		// set wall worlds
		for ( new i = 0; i < 4; i ++ ) {
			PHY_SetWallWorld( g_poolTableData[ poolid ] [ E_WALL ] [ i ], world );
		}

		// create boundary for replacing the cueball
		new Float: vertices[ 4 ];

		Pool_RotateXY( 0.94, 0.48, g_poolTableData[ poolid ] [ E_ANGLE ], vertices[ 0 ], vertices[ 1 ] );
		Pool_RotateXY( -0.94, -0.48, g_poolTableData[ poolid ] [ E_ANGLE ], vertices[ 2 ], vertices[ 3 ] );

		vertices[ 0 ] += g_poolTableData[ poolid ] [ E_X ], vertices[ 2 ] += g_poolTableData[ poolid ] [ E_X ];
		vertices[ 1 ] += g_poolTableData[ poolid ] [ E_Y ], vertices[ 3 ] += g_poolTableData[ poolid ] [ E_Y ];

		g_poolTableData[ poolid ] [ E_CUEBALL_AREA ] = CreateDynamicRectangle( vertices[ 2 ], vertices[ 3 ], vertices[ 0 ], vertices[ 1 ], .interiorid = interior, .worldid = world );


		// reset pool handles
		for ( new i = 0; i < sizeof( g_poolBallOffsetData ); i ++ ) {
			g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] = ITER_NONE;
		}

		#if defined POOL_DEBUG
			ReloadPotTestLabel( 0, poolid );
			/*new Float: middle_x;
			new Float: middle_y;
			CreateDynamicObject( 18643, x_vertex[0] + X, y_vertex[0] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[1] + X, y_vertex[1] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			middle_x = ((x_vertex[0] + X) + (x_vertex[1] + X)) / (2.0);
			middle_y = ((y_vertex[0] + Y) + (y_vertex[1] + Y)) / (2.0);
			CreateDynamicObject( 18643, middle_x, middle_y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[1] + X, y_vertex[1] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[3] + X, y_vertex[3] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			middle_x = ((x_vertex[1] + X) + (x_vertex[3] + X)) / (2.0);
			middle_y = ((y_vertex[1] + Y) + (y_vertex[3] + Y)) / (2.0);
			CreateDynamicObject( 18643, middle_x, middle_y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, ((x_vertex[1] + X) + middle_x) / 2.0, ((y_vertex[1] + Y) + middle_y) / 2.0, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[2] + X, y_vertex[2] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[3] + X, y_vertex[3] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			middle_x = ((x_vertex[2] + X) + (x_vertex[3] + X)) / (2.0);
			middle_y = ((y_vertex[2] + Y) + (y_vertex[3] + Y)) / (2.0);
			CreateDynamicObject( 18643, middle_x, middle_y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[0] + X, y_vertex[0] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, x_vertex[2] + X, y_vertex[2] + Y, Z - 1.0, 0.0, -90.0, 0.0 );
			middle_x = ((x_vertex[0] + X) + (x_vertex[2] + X)) / (2.0);
			middle_y = ((y_vertex[0] + Y) + (y_vertex[2] + Y)) / (2.0);
			CreateDynamicObject( 18643, middle_x, middle_y, Z - 1.0, 0.0, -90.0, 0.0 );
			CreateDynamicObject( 18643, ((x_vertex[0] + X) + middle_x) / 2.0, ((y_vertex[2] + Y) + middle_y) / 2.0, Z - 1.0, 0.0, -90.0, 0.0 );*/
		#endif
	}
	return poolid;
}

stock Pool_GetClosestTable( playerid, &Float: dis = 99999.99 )
{
	new pooltable = -1;
	new player_world = GetPlayerVirtualWorld( playerid );

	foreach ( new i : pooltables ) if ( g_poolTableData[ i ] [ E_WORLD ] == player_world )
	{
    	new
    		Float: dis2 = GetPlayerDistanceFromPoint( playerid, g_poolTableData[ i ] [ E_X ], g_poolTableData[ i ] [ E_Y ], g_poolTableData[ i ] [ E_Z ] );

    	if ( dis2 < dis && dis2 != -1.00 )
    	{
    	    dis = dis2;
    	    pooltable = i;
		}
	}
	return pooltable;
}

stock Pool_RespawnBalls( poolid )
{
	if ( g_poolTableData[ poolid ] [ E_AIMER ] != -1 )
	{
		TogglePlayerControllable(g_poolTableData[ poolid ] [ E_AIMER ], 1);
		//ClearAnimations(g_poolTableData[ poolid ] [ E_AIMER ]);

		//ApplyAnimation(g_poolTableData[ poolid ] [ E_AIMER ], "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
        SetCameraBehindPlayer( g_poolTableData[ poolid ] [ E_AIMER ] );
        SOLS_DestroyObject( g_poolTableData[ poolid ] [ E_AIMER_OBJECT ], "Pool/RespawnBalls Aimer", true);
        g_poolTableData[ poolid ] [ E_AIMER_OBJECT ] = -1;

        //TextDrawHideForPlayer(g_poolTableData[ poolid ] [ E_AIMER ], gPoolTD);
        //HidePlayerProgressBar(g_poolTableData[ poolid ] [ E_AIMER ], g_PoolPowerBar[g_poolTableData[ poolid ] [ E_AIMER ]]);
		g_poolTableData[ poolid ] [ E_AIMER ] = -1;
	}

	new
		Float: offset_x,
		Float: offset_y;

	for ( new i = 0; i < sizeof( g_poolBallOffsetData ); i ++ )
	{
		// get offset according to angle of table
		Pool_RotateXY( g_poolBallOffsetData[ i ] [ E_OFFSET_X ], g_poolBallOffsetData[ i ] [ E_OFFSET_Y ], g_poolTableData[ poolid ] [ E_ANGLE ], offset_x, offset_y );

		// reset balls
		if ( PHY_IsHandleValid( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ) ) {
			PHY_DeleteHandle( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] );
			SOLS_DestroyObject( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ), "Pool/RespawnBalls Loop(indiv. ball)", true);
			g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] = ITER_NONE;
		}

		// create pool balls on table
		new objectid = CreateDynamicObject(
			g_poolBallOffsetData[ i ] [ E_MODEL_ID ],
			g_poolTableData[ poolid ] [ E_X ] + offset_x,
			g_poolTableData[ poolid ] [ E_Y ] + offset_y,
			g_poolTableData[ poolid ] [ E_Z ] - 0.045,
			0.0, 0.0, 0.0,
			.worldid = g_poolTableData[ poolid ] [ E_WORLD ],
			.priority = 999
		);

		// initialize physics on each ball
		Pool_InitBalls( poolid, objectid, i );
	}

	KillTimer( g_poolTableData[ poolid ] [ E_TIMER ] );
	g_poolTableData[ poolid ] [ E_TIMER ] = SetTimerEx( "OnPoolUpdate", POOL_TIMER_SPEED, true, "d", poolid );
	g_poolTableData[ poolid ] [ E_BALLS_SCORED ] = 0;
}

stock Pool_InitBalls( poolid, objectid, ballid )
{
	new handleid = PHY_InitObject( objectid, 3003, _, _, PHY_MODE_2D );

	PHY_SetHandleWorld( handleid, g_poolTableData[ poolid ] [ E_WORLD ] );
	PHY_SetHandleFriction( handleid, 0.08 ); // 0.10
	PHY_SetHandleAirResistance( handleid, 0.2 );
	PHY_RollObject( handleid );

	g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ ballid ] = handleid;
	g_poolBallData[ poolid ] [ E_POCKETED ] [ ballid ] = false;
}

stock Pool_RotateXY( Float: xi, Float: yi, Float: angle, &Float: xf, &Float: yf )
{
    xf = xi * floatcos( angle, degrees ) - yi * floatsin( angle, degrees );
    yf = xi * floatsin( angle, degrees ) + yi * floatcos( angle, degrees );
    return 1;
}

stock Pool_AreBallsStopped( poolid )
{
	new
		balls_not_moving = 0;

	for ( new i = 0; i < 16; i ++ )
	{
		new
			ball_handle = g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ];

		if ( ! PHY_IsHandleValid( ball_handle ) || g_poolBallData[ poolid ] [ E_POCKETED ] [ i ] || ! PHY_IsHandleMoving( ball_handle ) ) {
			balls_not_moving ++;
		}
	}
	return balls_not_moving >= 16;
}

stock Pool_GetXYInFrontOfPos( Float: xx, Float: yy, Float: a, &Float: x2, &Float: y2, Float: distance )
{
    x2 = xx + ( distance * floatsin( -a, degrees ) );
    y2 = yy + ( distance * floatcos( -a, degrees ) );
}

stock Pool_IsBallInHole( poolid, objectid )
{
	new
		Float: hole_x, Float: hole_y;

	for ( new i = 0; i < sizeof( g_poolPotOffsetData ); i ++ )
	{
		// rotate offsets according to table
		Pool_RotateXY( g_poolPotOffsetData[ i ] [ 0 ], g_poolPotOffsetData[ i ] [ 1 ], g_poolTableData[ poolid ] [ E_ANGLE ], hole_x, hole_y );

		// check if it is at the pocket
		if ( Pool_IsObjectAtPos( objectid, g_poolTableData[ poolid ] [ E_X ] + hole_x , g_poolTableData[ poolid ] [ E_Y ] + hole_y, g_poolTableData[ poolid ] [ E_Z ], POCKET_RADIUS ) ) {
			return i;
		}
	}
    return -1;
}

stock Pool_UpdateScoreboard( poolid, close = 0 )
{
	#pragma unused close

	new first_player = Iter_First( poolplayers< poolid > );
	new second_player = Iter_Last( poolplayers< poolid > );

	new szBigString[ 256 ];
	
	foreach ( new playerid : poolplayers< poolid > )
	{
		new
			is_playing = playerid == first_player ? first_player : ( playerid == second_player ? second_player : -1 );

		if ( g_poolTableData[ poolid ] [ E_BALLS_SCORED ] && is_playing != -1 ) {
			format(
				szBigString, sizeof( szBigString ), "You are %s. ",
				g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ is_playing ] == E_STRIPED ? ( "striped" ) : ( "solid" )
			);
		} else {
			szBigString = "";
		}

		format( szBigString, sizeof( szBigString ),
			"%sIt's %s's turn.~n~~n~~r~~h~~h~%s Score:~w~ %d~n~~b~~h~~h~%s Score:~w~ %d",
			szBigString, ReturnMixedName( g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ] ),
			ReturnMixedName( first_player ), p_PoolScore[ first_player ],
			ReturnMixedName( second_player ), p_PoolScore[ second_player ]
		);

		UpdateMinigameHelpBox(playerid, "Pool: 8-ball", szBigString, .show = true ) ;

	}

	UpdateDynamic3DTextLabelText( g_poolTableData[ poolid ] [ E_LABEL ], -1, "" );
}

stock Pool_EndGame( poolid )
{
	// hide scoreboard in 5 seconds
	Pool_UpdateScoreboard( poolid, 5000 );

	// unset pool variables
	foreach ( new i : poolplayers< poolid > )
	{
		SOLS_DestroyObject( p_PoolHoleGuide[ i ], "Pool/EndGame Pool Hole Guide", true);
		p_PoolHoleGuide[ i ] = -1;
		p_isPlayingPool{ i } = false;
		p_PoolScore[ i ] = -1;
		p_PoolID[ i ] = -1;
		RestoreCamera( i );
		HideMinigameHelpBox ( i );
		RemovePlayerAttachedObject(i, E_ATTACH_INDEX_MINIGAME);
	}

	Iter_Clear( poolplayers< poolid > );

	g_poolTableData[ poolid ] [ E_STARTED ] = false;
	g_poolTableData[ poolid ] [ E_AIMER ] = -1;
	g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] = 0;
	g_poolTableData[ poolid ] [ E_FOULS ] = 0;
	g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] = false;
	g_poolTableData[ poolid ] [ E_READY ] = false;
	g_poolTableData[ poolid ] [ E_WAGER ] = 0;
	g_poolTableData[ poolid ] [ E_CUE_POCKETED ] = false;

	KillTimer( g_poolTableData[ poolid ] [ E_TIMER ] );
    SOLS_DestroyObject( g_poolTableData[ poolid ] [ E_AIMER_OBJECT ], "Pool/EndGame Aimer Object", true);
    g_poolTableData[ poolid ] [ E_AIMER_OBJECT ] = -1;

	for ( new i = 0; i < 16; i ++ ) if ( PHY_IsHandleValid( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ) ) {
		PHY_DeleteHandle( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] );
		SOLS_DestroyObject( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ), "Pool/EndGame Indiv. Balls", true);
		g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] = ITER_NONE;
	}

	UpdateDynamic3DTextLabelText( g_poolTableData[ poolid ] [ E_LABEL ], COLOR_GREY, DEFAULT_POOL_STRING );
	return 1;
}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range) {
	a1 -= a2;
	return (a1 < range) && (a1 > -range);
}

stock Pool_IsObjectAtPos( objectid, Float: x, Float: y, Float: z, Float: radius )
{
    new
    	Float: object_x, Float: object_y, Float: object_z;

    GetDynamicObjectPos( objectid, object_x, object_y, object_z );

    new
    	Float: distance = GetDistanceBetweenPoints( object_x, object_y, object_z, x, y, z );

    return distance < radius;
}

/*
public PlayPoolSound( poolid, soundid ) {
	foreach ( new playerid : poolplayers< poolid > ) {
		PlayerPlaySound( playerid, soundid, 0.0, 0.0, 0.0 );
	}
	return 1;
}*/

public OnPoolUpdate( poolid )
{
	if ( ! g_poolTableData[ poolid ] [ E_STARTED ] ) {
		return 1;
	}

	if ( ! Iter_Count( poolplayers< poolid > ) ) {
		Pool_EndGame( poolid );
		return 1;
	}

	new Float: Xa, Float: Ya, Float: Za;
	new Float: X, Float: Y, Float: Z;
	new keys, ud, lr;

	if ( g_poolTableData[ poolid ] [ E_CUE_POCKETED ] )
	{
		new playerid = g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ];
		new cueball_handle = g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ];

		if ( PHY_IsHandleValid( cueball_handle ) )
		{
			new cueball_object = PHY_GetHandleObject( cueball_handle );

			GetPlayerKeys( playerid, keys, ud, lr );
			GetDynamicObjectPos( cueball_object, X, Y, Z );

			if ( ud == KEY_UP ) Y += CUEBALL_PLACE_SPEED;
			else if ( ud == KEY_DOWN ) Y -= CUEBALL_PLACE_SPEED;

			if ( lr == KEY_LEFT ) X -= CUEBALL_PLACE_SPEED;
			else if ( lr == KEY_RIGHT ) X += CUEBALL_PLACE_SPEED;

			// set position only if it is within boundaries
			if ( IsPointInDynamicArea( g_poolTableData[ poolid ] [ E_CUEBALL_AREA ], X, Y, 0.0 ) ) {
				SetDynamicObjectPos( cueball_object, X, Y, Z );
			}

			// click to set
			if ( keys & KEY_FIRE )
			{
				// check if we are placing the pool ball near another pool ball
				for ( new i = 1; i < MAX_POOL_BALLS; i ++ ) if ( PHY_IsHandleValid( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ) ) {
					GetDynamicObjectPos( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ), Xa, Ya, Za );
					if ( GetDistanceFromPointToPoint( X, Y, Xa, Ya ) < 0.085 ) {
						return GameTextForPlayer( playerid, "~n~~n~~n~~r~~h~Ball too close to other!", 500, 3 );
					}
				}

				// check if ball is close to hole
				new
					Float: hole_x, Float: hole_y;

				for ( new i = 0; i < sizeof( g_poolPotOffsetData ); i ++ )
				{
					// rotate offsets according to table
					Pool_RotateXY( g_poolPotOffsetData[ i ] [ 0 ], g_poolPotOffsetData[ i ] [ 1 ], g_poolTableData[ poolid ] [ E_ANGLE ], hole_x, hole_y );

					// check if it is at the pocket
					if ( Pool_IsObjectAtPos( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] ), g_poolTableData[ poolid ] [ E_X ] + hole_x , g_poolTableData[ poolid ] [ E_Y ] + hole_y, g_poolTableData[ poolid ] [ E_Z ], POCKET_RADIUS ) ) {
						return GameTextForPlayer( playerid, "~n~~n~~n~~r~~h~Ball too close to hole!", 500, 3 );
					}
				}

				// reset state
				SetCameraBehindPlayer( playerid );
				TogglePlayerControllable( playerid, true );
				g_poolTableData[ poolid ] [ E_CUE_POCKETED ] = false;
				ApplyAnimation( playerid, "CARRY", "crry_prtial", 4.0, 0, 1, 1, 0, 0 );
				Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has placed the cueball!", ReturnMixedName(playerid));
			}
		}
	}
	else if ( g_poolTableData[ poolid ] [ E_AIMER ] != -1 )
	{
		new
			playerid = g_poolTableData[ poolid ] [ E_AIMER ];

		GetPlayerKeys( playerid, keys, ud, lr );

		if ( ! ( keys & KEY_FIRE ) )
		{
			if ( lr )
			{
				new Float: x, Float: y, Float: newrot, Float: dist;

				GetPlayerPos(playerid, X, Y ,Z);
				GetDynamicObjectPos( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] ), Xa, Ya, Za);
				newrot = p_PoolAngle[ playerid ] [ 0 ] + ( lr > 0 ? POOL_ANGLE_UPDATE : -POOL_ANGLE_UPDATE );
				dist = GetDistanceBetweenPoints( X, Y, 0.0, Xa, Ya, 0.0 );

				// keep the head out of the point of view
				if ( dist < 1.20 ) {
					dist = 1.20;
				}

				if ( AngleInRangeOfAngle( p_PoolAngle[ playerid ] [ 1 ], newrot, 30.0 ) )
	            {
	                p_PoolAngle[ playerid ] [ 0 ] = newrot;
	                Pool_UpdatePlayerCamera( playerid, poolid );

	                Pool_GetXYInFrontOfPos( Xa, Ya, newrot + 180, x, y, 0.085 );
	                SetDynamicObjectPos( g_poolTableData[ poolid ] [ E_AIMER_OBJECT ], x, y, Za );
	              	SOLS_SetObjectRot( g_poolTableData[ poolid ] [ E_AIMER_OBJECT ], 7.0, 0, p_PoolAngle[ playerid ] [ 0 ] + 180, "Pool/OnPoolUpdate - Aimer Object", true);
	              	Pool_GetXYInFrontOfPos( Xa, Ya, newrot + 180 - 5.0, x, y, dist ); // offset 5 degrees
					PauseAC(playerid, 3);
	                SetPlayerPos( playerid, x, y, Z );
	                SetPlayerFacingAngle( playerid, newrot );
	            }
			}
		}
		else
		{
			if ( g_poolTableData[ poolid ] [ E_DIRECTION ] ) {
		        g_poolTableData[ poolid ] [ E_POWER ] -= 2.0;
		    } else {
			    g_poolTableData[ poolid ] [ E_POWER ] += 2.0;
			}

			if ( g_poolTableData[ poolid ] [ E_POWER ] <= 0 ) {
			    g_poolTableData[ poolid ] [ E_DIRECTION ] = 0;
			    g_poolTableData[ poolid ] [ E_POWER ] = 2.0;
			}
			else if ( g_poolTableData[ poolid ] [ E_POWER ] > 100.0 ) {
			    g_poolTableData[ poolid ] [ E_DIRECTION ] = 1;
			    g_poolTableData[ poolid ] [ E_POWER ] = 99.0;
			}

			new Float: max_value = 67.0 ;// originally 67.0
			SetPlayerProgressBarMaxValue( playerid, g_PoolPowerBar[ playerid ], max_value ); 
			SetPlayerProgressBarValue( playerid, g_PoolPowerBar[ playerid ], ( ( max_value * g_poolTableData[ poolid ] [ E_POWER ] ) / 100.0 ) );
			ShowPlayerProgressBar( playerid, g_PoolPowerBar[ playerid ] );
			TextDrawShowForPlayer( playerid, g_PoolTextdraw );
		}
	}

	new
		current_player = g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ];

	if ( ( ! g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] || g_poolTableData[ poolid ] [ E_FOULS ] || g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] ) && Pool_AreBallsStopped( poolid ) ) {
		Pool_QueueNextPlayer( poolid, current_player );
		SetTimerEx( "RestoreCamera", 800, 0, "d", current_player );
	}
	return 1;
}

public RestoreCamera( playerid )
{
	TextDrawHideForPlayer( playerid, g_PoolTextdraw );
	HidePlayerProgressBar( playerid, g_PoolPowerBar[ playerid ] );
	TogglePlayerControllable( playerid, 1 );
	ApplyAnimation( playerid, "CARRY", "crry_prtial", 4.0, 0, 1, 1, 0, 0 );
	return SetCameraBehindPlayer( playerid );
}

public deleteBall( poolid, ballid )
{
	if ( g_poolBallData[ poolid ] [ E_POCKETED ] [ ballid ] && PHY_IsHandleValid( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ ballid ] ) )
	{
		PHY_DeleteHandle( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ ballid ] );
		SOLS_DestroyObject( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ ballid ] ), "Pool/deleteBall", true);
		g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ ballid ] = ITER_NONE;
	}
	return 1;
}

public RestoreWeapon( playerid )
{
	RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME);
	p_PoolChalking{ playerid } = false;
	SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, 338, 6 ) ; // normal cue in hand
	ClearAnimations( playerid );
	return 1;
}

stock GetPoolBallIndexFromModel( modelid ) {
	for ( new i = 0; i < sizeof( g_poolBallOffsetData ); i ++ ) if ( g_poolBallOffsetData[ i ] [ E_MODEL_ID ] == modelid ) {
		return i;
	}
	return -1;
}

/** * Physics Callbacks * **/
public PHY_OnObjectCollideWithObject( handleid_a, handleid_b )
{
	foreach ( new poolid : pooltables ) if ( g_poolTableData[ poolid ] [ E_STARTED ] )
	{
		for ( new i = 0; i < 16; i ++ )
		{
			new
				table_ball_handle = g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ];

			if ( PHY_IsHandleValid( table_ball_handle ) && PHY_GetHandleObject( handleid_a ) == PHY_GetHandleObject( table_ball_handle ) )
			{
		        //PlayPoolSound( poolid, 31800 + random( 3 ) );
		        return 1;
			}
		}
	}
	return 1;
}

public PHY_OnObjectCollideWithWall( handleid, wallid )
{
	foreach ( new poolid : pooltables ) if ( g_poolTableData[ poolid ] [ E_STARTED ] )
	{
		for ( new i = 0; i < 16; i ++ )
		{
			new
				table_ball_handle = g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ];

			if ( PHY_IsHandleValid( table_ball_handle ) && PHY_GetHandleObject( handleid ) == PHY_GetHandleObject( table_ball_handle ) )
			{
		        //PlayPoolSound( poolid, 31808 );
		        return 1;
			}
		}
	}
	return 1;
}

public PHY_OnObjectUpdate( handleid )
{
	new objectid = PHY_GetHandleObject( handleid );

	if ( ! IsValidDynamicObject( objectid ) ) {
		return 1;
	}

	new poolball_index = GetPoolBallIndexFromModel( Streamer_GetIntData( STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID ) );

	if ( poolball_index == -1 ) {
		return 1;
	}

	foreach ( new poolid : pooltables ) if ( g_poolTableData[ poolid ] [ E_STARTED ] )
	{
		new poolball_handle = g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ poolball_index ];

		if ( ! PHY_IsHandleValid( poolball_handle ) ) {
			return 1;
		}

		if ( objectid == PHY_GetHandleObject( poolball_handle ) && ! g_poolBallData[ poolid ] [ E_POCKETED ] [ poolball_index ] && PHY_IsHandleMoving( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ poolball_index ] ) )
		{
			new
				holeid = Pool_IsBallInHole( poolid, objectid );

			if ( holeid != -1 )
			{
				new first_player = Iter_First( poolplayers< poolid > );
				new second_player = Iter_Last( poolplayers< poolid > );
				new current_player = g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ];
				new opposite_player = current_player != first_player ? first_player : second_player;

				// printf ("first_player %d, second_player %d, current_player = %d", first_player, second_player, current_player);

				// check if first ball was pocketed to figure winner
				if ( g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] == E_STRIPED || g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] == E_SOLID )
				{
					if ( ++ g_poolTableData[ poolid ] [ E_BALLS_SCORED ] == 1 )
					{
						// assign first player a type after first one is hit
						g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ current_player ] = g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ];

						// assign second player
						if ( current_player == first_player ) {
							g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ second_player ] = g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ first_player ] == E_STRIPED ? E_SOLID : E_STRIPED;
						} else if ( current_player == second_player ) {
							g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ first_player ] = g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ second_player ] == E_STRIPED ? E_SOLID : E_STRIPED;
						}

						// alert players in table
						foreach ( new playerid : poolplayers< poolid > ) {
							cmd_cmc( playerid );
	    					SendClientMessageFormatted( playerid, -1, "(%d) %s is now playing as %s", first_player, ReturnMixedName(first_player), g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ first_player ] == E_STRIPED ? ( "Striped" ) : ( "Solid" ) );
	    					SendClientMessageFormatted( playerid, -1, "(%d) %s is playing as %s", second_player, ReturnMixedName(second_player), g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ second_player ] == E_STRIPED ? ( "Striped" ) : ( "Solid" ) );
	    				}
	    			}
				}

				new Float: hole_x, Float: hole_y;

				// check what was pocketed
				if ( g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] == E_CUE )
				{
	    			GameTextForPlayer( current_player, "~n~~n~~n~~r~wrong ball", 3000, 3);
					Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has pocketed the cue ball, %s will set it!", ReturnMixedName(current_player), ReturnMixedName(opposite_player) );

					// penalty for that
					g_poolTableData[ poolid ] [ E_FOULS ] ++;
					g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] = 0;
					g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] = false;
					g_poolTableData[ poolid ] [ E_CUE_POCKETED ] = true;
				}
				else if ( g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] == E_8BALL )
				{
					g_poolTableData[ poolid ] [ E_BALLS_SCORED ] ++;

					// restore player camera
					RestoreCamera( current_player );

					// check if valid shot
					if ( p_PoolScore[ current_player ] < 7 )
					{
						p_PoolScore[ opposite_player ] ++;
						Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has accidentally pocketed the 8-Ball... %s wins!", ReturnMixedName(current_player), ReturnMixedName(opposite_player) );
						Pool_OnPlayerWin( poolid, opposite_player );
					}
					else if ( g_poolTableData[ poolid ] [ E_PLAYER_8BALL_TARGET ] [ current_player ] != holeid )
					{
						p_PoolScore[ opposite_player ] ++;
						Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has put the 8-Ball in the wrong pocket... %s wins!", ReturnMixedName(current_player), ReturnMixedName(opposite_player) );
						Pool_OnPlayerWin( poolid, opposite_player );
					}
					else
					{
						p_PoolScore[ current_player ] ++;
						Pool_OnPlayerWin( poolid, current_player );
					}
					return Pool_EndGame( poolid );
				}
				else
				{
					// check if player pocketed their own ball type or btfo
					if ( g_poolTableData[ poolid ] [ E_BALLS_SCORED ] > 1 && g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ current_player ] != g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] )
					{
	    				p_PoolScore[ opposite_player ] += 1;
	    				GameTextForPlayer( current_player, "~n~~n~~n~~r~wrong ball", 3000, 3);
	    				Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has wrongly pocketed %s %s, instead of %s.", ReturnMixedName(current_player), g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] == E_STRIPED ? ( "Striped" ) : ( "Solid" ), g_poolBallOffsetData[ poolball_index ] [ E_BALL_NAME ], g_poolTableData[ poolid ] [ E_PLAYER_BALL_TYPE ] [ current_player ] == E_STRIPED ? ( "Striped" ) : ( "Solid" ) );

						// penalty for that
						g_poolTableData[ poolid ] [ E_FOULS ] ++;
						g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] = 0;
						g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] = false;
					}
					else
					{
	    				p_PoolScore[ current_player ] ++;
	    				GameTextForPlayer( current_player, "~n~~n~~n~~g~+1 score", 3000, 3);
	    				Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has pocketed a %s %s.", ReturnMixedName(current_player), g_poolBallOffsetData[ poolball_index ] [ E_BALL_TYPE ] == E_STRIPED ? ( "Striped" ) : ( "Solid" ), g_poolBallOffsetData[ poolball_index ] [ E_BALL_NAME ] );

						// extra shot for scoring one's own
						g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] = g_poolTableData[ poolid ] [ E_FOULS ] > 0 ? 0 : 1;
						g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] = true;
					}

					// mark final target hole
					if ( ( p_PoolScore[ first_player ] == 7 && p_PoolHoleGuide[ first_player ] == -1 ) || ( p_PoolScore[ second_player ] == 7 && p_PoolHoleGuide[ second_player ] == -1 ) )
					{
						foreach ( new player_being_marked : poolplayers< poolid > ) if ( p_PoolScore[ player_being_marked ] == 7 && p_PoolHoleGuide[ player_being_marked ] == -1 )
						{
							new
								opposite_holeid = g_poolHoleOpposite[ holeid ];

							Pool_RotateXY( g_poolPotOffsetData[ opposite_holeid ] [ 0 ], g_poolPotOffsetData[ opposite_holeid ] [ 1 ], g_poolTableData[ poolid ] [ E_ANGLE ], hole_x, hole_y );
							p_PoolHoleGuide[ player_being_marked ] = CreateDynamicObject( 18643, g_poolTableData[ poolid ] [ E_X ] + hole_x, g_poolTableData[ poolid ] [ E_Y ] + hole_y, g_poolTableData[ poolid ] [ E_Z ] - 0.5, 0.0, -90.0, 0.0, .playerid = player_being_marked );
							g_poolTableData[ poolid ] [ E_PLAYER_8BALL_TARGET ] [ player_being_marked ] = opposite_holeid;
							SendPoolMessage( player_being_marked, "You are now required to put the 8-Ball in the designated pocket." );
							Streamer_Update( player_being_marked );
						}
					}
				}

				// rotate hole offsets according to table
				Pool_RotateXY( g_poolPotOffsetData[ holeid ] [ 0 ], g_poolPotOffsetData[ holeid ] [ 1 ], g_poolTableData[ poolid ] [ E_ANGLE ], hole_x, hole_y );

				// move object into the pocket
				new move_speed = MoveDynamicObject( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ poolball_index ] ), g_poolTableData[ poolid ] [ E_X ] + hole_x, g_poolTableData[ poolid ] [ E_Y ] + hole_y, g_poolTableData[ poolid ] [ E_Z ] - 0.5, 1.0);

				// mark ball as pocketed
				g_poolBallData[ poolid ] [ E_POCKETED ] [ poolball_index ] = true;

				// delete it anyway
				SetTimerEx( "deleteBall", move_speed + 100, false, "dd", poolid, poolball_index );

				// update scoreboard
				Pool_UpdateScoreboard( poolid );
				PlayerPlaySound( current_player, 31803, 0.0, 0.0, 0.0 );
			}
			return 1;
		}
	}
	return 1;
}

stock Pool_OnPlayerWin( poolid, winning_player )
{
	if ( ! IsPlayerConnected( winning_player ) && ! IsPlayerNPC( winning_player ) )
		return 0;

	new
		win_amount = floatround( float( g_poolTableData[ poolid ] [ E_WAGER ] ) * ( 1 - POOL_FEE_RATE ) * 2.0 );

	// restore camera
	RestoreCamera( winning_player );
	GivePlayerCash( winning_player, win_amount );

	// winning player
	Pool_SendTableMessage( poolid, -1, "{9FCF30}****************************************************************************************");
	Pool_SendTableMessage( poolid, -1, "{9FCF30}Player {FF8000}%s {9FCF30}has won the game!", ReturnMixedName( winning_player ) );
	Pool_SendTableMessage( poolid, -1, "{9FCF30}Prize: {377CC8}%s | -%0.0f%s percent fee", IntegerWithDelimiter( win_amount ), win_amount > 0 ? POOL_FEE_RATE * 100.0 : 0.0, "%%");
	Pool_SendTableMessage( poolid, -1, "{9FCF30}****************************************************************************************");
	return 1;
}

stock Pool_QueueNextPlayer( poolid, current_player )
{
	if ( g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] && g_poolTableData[ poolid ] [ E_FOULS ] < 1 )
	{
		g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] = false;
		Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** %s has an extra shot remaining!", ReturnMixedName( current_player ) );
	}
	else
	{
		new first_player = Iter_First( poolplayers< poolid > );
		new second_player = Iter_Last( poolplayers< poolid > );

		g_poolTableData[ poolid ] [ E_FOULS ] = 0;
		g_poolTableData[ poolid ] [ E_SHOTS_LEFT ] = 1;
		g_poolTableData[ poolid ] [ E_EXTRA_SHOT ] = false;
	    g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ] = current_player == first_player ? second_player : first_player;

		// reset ball positions just incase
		Pool_SendTableMessage( poolid, -1, "{2DD9A9} ** It's now %s's turn to play!", ReturnMixedName( g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ] ) );
	}

	// respawn the cue ball if it has been pocketed
	Pool_RespawnCueBall( poolid );

	// update turn
	Pool_UpdateScoreboard( poolid );
	Pool_ResetBallPositions( poolid );
}

stock Pool_SendTableMessage( poolid, colour, const format[ ], va_args<> ) // Conversion to foreach 14 stuffed the define, not sure how...
{
    static
		out[ 144 ];

    va_format( out, sizeof( out ), format, va_start<3> );

	foreach ( new i : poolplayers< poolid > ) {
		SendClientMessage( i, colour, out );
	}
	return 1;
}

stock Pool_RespawnCueBall( poolid )
{
    if ( g_poolBallData[ poolid ] [ E_POCKETED ] [ 0 ] )
	{
		new
			Float: x, Float: y;

		Pool_RotateXY( 0.5, 0.0, g_poolTableData[ poolid ] [ E_ANGLE ], x, y );

		// make sure object dont exist
		if ( PHY_IsHandleValid( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] ) ) {
			PHY_DeleteHandle( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] );
	        SOLS_DestroyObject( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] ), "Pool/RespawnCueBall", true);
		}

        // recreate cueball
		new cueball_object = CreateDynamicObject( 3003, g_poolTableData[ poolid ] [ E_X ] + x, g_poolTableData[ poolid ] [ E_Y ] + y, g_poolTableData[ poolid ] [ E_Z ] - 0.045, 0.0, 0.0, 0.0, .worldid = g_poolTableData[ poolid ] [ E_WORLD ], .priority = 999 );
        Pool_InitBalls( poolid, cueball_object, 0 );

		// set next player camera
		new next_shooter = g_poolTableData[ poolid ] [ E_NEXT_SHOOTER ];
		SetPlayerCameraPos( next_shooter, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] + 2.0 );
		SetPlayerCameraLookAt( next_shooter, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] );
		ApplyAnimation( next_shooter, "POOL", "POOL_Idle_Stance", 3.0, 0, 1, 1, 0, 0, 1 );
		TogglePlayerControllable( next_shooter, false );
	}
}

stock Pool_ResetBallPositions( poolid, begining_ball = 0, last_ball = MAX_POOL_BALLS )
{
	static Float: last_x, Float: last_y, Float: last_z;
	static Float: last_rx, Float: last_ry, Float: last_rz;

	for ( new i = begining_ball; i < last_ball; i ++ ) if ( ! g_poolBallData[ poolid ] [ E_POCKETED ] [ i ] )
	{
		new
			ball_handle = g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ];

		if ( ! PHY_IsHandleValid( ball_handle ) )
			continue;

		new
			ball_object = PHY_GetHandleObject( ball_handle );

		if ( ! IsValidDynamicObject( ball_object ) )
			continue;

		new
			modelid = Streamer_GetIntData( STREAMER_TYPE_OBJECT, ball_object, E_STREAMER_MODEL_ID );  //FIX

		// get current position
		GetDynamicObjectPos( ball_object, last_x, last_y, last_z );
		GetDynamicObjectRot( ball_object, last_rx, last_ry, last_rz );

		// destroy object
		if ( PHY_IsHandleValid( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] ) ) {
			PHY_DeleteHandle( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] );
			SOLS_DestroyObject( ball_object, "Pool/ResetBallPositions", true);
		}

		// create pool balls on table
		new object = CreateDynamicObject( modelid, last_x, last_y, last_z, last_rx, last_ry, last_rz, .worldid = g_poolTableData[ poolid ] [ E_WORLD ], .priority = 999 );

		// initialize physics on each ball
		Pool_InitBalls( poolid, object, i );
	}

	// show objects
	foreach ( new playerid : poolplayers< poolid > ) {
		Streamer_Update( playerid, STREAMER_TYPE_OBJECT );
	}
}

public OnPlayerShootDynamicObject( playerid, weaponid, objectid, Float: x, Float: y, Float: z )
{
	// check if a player shot a pool ball and restore it
	new
		poolball_index = GetPoolBallIndexFromModel( Streamer_GetIntData( STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID ) );

	if ( poolball_index != -1 ) {
		foreach ( new poolid : pooltables ) if ( g_poolTableData[ poolid ] [ E_STARTED ] && ( g_poolBallData[ poolid ] [ E_POCKETED ] [ poolball_index ] || ! PHY_IsHandleMoving( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ poolball_index ] ) ) ) {
			Pool_ResetBallPositions( poolid, poolball_index, poolball_index + 1 );
			break;
		}
		return 0; // desync the shot
	}
	
	#if defined pool_OnPlayerShootDynObject
		return pool_OnPlayerShootDynObject(playerid, weaponid, STREAMER_TAG_OBJECT:objectid, Float:x, Float:y, Float:z);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerShootDynamicObject
	#undef OnPlayerShootDynamicObject
#else
	#define _ALS_OnPlayerShootDynamicObject
#endif

#define OnPlayerShootDynamicObject pool_OnPlayerShootDynObject
#if defined pool_OnPlayerShootDynObject
	forward pool_OnPlayerShootDynObject(playerid, weaponid, STREAMER_TAG_OBJECT:objectid, Float:x, Float:y, Float:z);
#endif

Pool_UpdateTableSkin(objectid, skinid) {

	switch ( skinid ) {

		case 1: {

			SetDynamicObjectMaterial(objectid, 0, 18028, "cj_bar2", "CJ_nastybar_D3", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 18028, "cj_bar2", "GB_nastybar01", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
		}
		case 2: {

			SetDynamicObjectMaterial(objectid, 0, 5408, "tempstuff_lae", "examball1_LAe", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18028, "cj_bar2", "GB_nastybar04", 0xFFFFFFFF);
		}
		case 3: {

			SetDynamicObjectMaterial(objectid, 0, 15041, "bigsfsave", "ah_greencarp", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 1, 2589, "ab_ab", "ab_sheetSteel", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14651, "ab_trukstpd", "Bow_bar_pool_table", 0xFF515459);
			SetDynamicObjectMaterial(objectid, 4, 3922, "bistro", "Marble", 0xFFFFFFFF);
		}
		case 4: {

			SetDynamicObjectMaterial(objectid, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 12992, "ce_oldbridge", "Gen_Scrap_Wheel_Rim", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18028, "cj_bar2", "CJ_nastybar_D3", 0xFFFFFFFF);
		}
		case 5: {

			SetDynamicObjectMaterial(objectid, 0, 18901, "matclothes", "bandanaelec", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14815, "whore_main", "WH_carpet3", 0xFFFFFFFF);
		}
		case 6: {

			SetDynamicObjectMaterial(objectid, 0, 15041, "bigsfsave", "ah_greencarp", 0xFF2A77A1);
			SetDynamicObjectMaterial(objectid, 1, 2589, "ab_ab", "ab_sheetSteel", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 5461, "glenpark6d_lae", "shutter01LA", 0xFFFFFFFF);
		}
		case 7: {

			SetDynamicObjectMaterial(objectid, 0, 11100, "bendytunnel_sfse", "Bow_sub_walltiles", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 18064, "ab_sfammuunits", "gun_blackbox", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 8488, "flamingo1", "casinolights4_128", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
		}
		case 8: {

			SetDynamicObjectMaterial(objectid, 0, 14387, "dr_gsnew", "mp_cloth_subwall", 0xFF5E7072);
			SetDynamicObjectMaterial(objectid, 3, 3077, "blkbrdx", "nf_blackbrd", 0xFF3F3E45);
			SetDynamicObjectMaterial(objectid, 4, 2423, "cj_ff_counters", "CJ_Laminate1", 0xFF96918C);
		}
		case 9: {

			SetDynamicObjectMaterial(objectid, 0, 7094, "vgnretail5", "vegasclub01_128", 0xFFFFFFFF);
		}
		case 10: {

			SetDynamicObjectMaterial(objectid, 0, 15054, "savesfmid", "AH_blackmar", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18901, "matclothes", "bandblack", 0xFFFFFFFF);
		}
		case 11: {

			SetDynamicObjectMaterial(objectid, 0, 15041, "bigsfsave", "ah_greencarp", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14651, "ab_trukstpd", "Bow_bar_pool_table", 0xFF767B7C);
			SetDynamicObjectMaterial(objectid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0xFFFFFFFF);
		}
		case 12: {

			SetDynamicObjectMaterial(objectid, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 12992, "ce_oldbridge", "Gen_Scrap_Wheel_Rim", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 10377, "cityhall_sfs", "ws_copart1", 0xFFFFFFFF);
		}
		case 13: {

			SetDynamicObjectMaterial(objectid, 0, 14666, "genintintsex", "CJ_BLUE_DOOR", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14666, "genintintsex", "CJ_BLUE_DOOR", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18901, "matclothes", "bandanaelec", 0xFFFFFFFF);
		}
		case 14: {

			SetDynamicObjectMaterial(objectid, 0, 2127, "cj_kitchen", "CJ_RED", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
		}
		case 15: {

			SetDynamicObjectMaterial(objectid, 0, 14666, "genintintsex", "backdoor_128", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14666, "genintintsex", "backdoor_128", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 2577, "cj_sex", "CJ_videos", 0xFFFFFFFF);
		}
		case 16: {

			SetDynamicObjectMaterial(objectid, 0, 3077, "blkbrdx", "nf_blackbrd", 0xFF96918C);
			SetDynamicObjectMaterial(objectid, 1, 1717, "cj_tv", "CJ_STEEL", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 1717, "cj_tv", "CJ_STEEL", 0xFF252527);
			SetDynamicObjectMaterial(objectid, 3, 14651, "ab_trukstpd", "Bow_bar_pool_table", 0xFF221918);
			SetDynamicObjectMaterial(objectid, 4, 3077, "blkbrdx", "nf_blackbrd", 0xFF96918C);
		}
		case 17: {

			SetDynamicObjectMaterial(objectid, 0, 14738, "whorebar", "AH_blueceiling", 0xFF9CA1A3);
			SetDynamicObjectMaterial(objectid, 3, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18901, "matclothes", "bandanaskull", 0xFFFFFFFF);
		}
		case 18: {

			SetDynamicObjectMaterial(objectid, 0, 15054, "savesfmid", "cspornmag", 0xFF9CA1A3);
			SetDynamicObjectMaterial(objectid, 2, 2577, "cj_sex", "gun_dildo3", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3629, "arprtxxref_las", "dirtywhite", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 2577, "cj_sex", "gun_dildo3", 0xFFFFFFFF);
		}
		case 19: {

			SetDynamicObjectMaterial(objectid, 0, 2047, "cj_ammo_posters", "cj_flag2", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 1355, "break_s_bins", "CJ_WOOD_DARK", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 642, "canopy", "wood02", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 1407, "break_f_w", "CJ_SLATEDWOOD", 0xFFFFFFFF);
		}
		case 20: {

			SetDynamicObjectMaterial(objectid, 0, 7094, "vgnretail5", "vegasclub02_128", 0xFFBDBEC6);
			SetDynamicObjectMaterial(objectid, 4, 7094, "vgnretail5", "vegasclub01_128", 0xFFBDBEC6);
		}
		case 21: {

			SetDynamicObjectMaterial(objectid, 0, 15054, "savesfmid", "cspornmag", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 1, 2589, "ab_ab", "ab_sheetSteel", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 2423, "cj_ff_counters", "CJ_Laminate1", 0xFF162248);
			SetDynamicObjectMaterial(objectid, 4, 7300, "vgsn_billboard", "homies_1_128", 0xFFFFFFFF);
		}
		case 22: {

			SetDynamicObjectMaterial(objectid, 0, 14777, "int_casinoint3", "GB_midbar05", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14815, "whore_main", "WH_carpet3", 0xFFFFFFFF);
		}
		case 23: {

			SetDynamicObjectMaterial(objectid, 0, 18008, "intclothesa", "CJ_VIC_1", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 18008, "intclothesa", "shop_shelf11", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 18008, "intclothesa", "CJ_VICT_DOOR2", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18008, "intclothesa", "shop_shelf11", 0xFFFFFFFF);
		}
		case 24: {

			SetDynamicObjectMaterial(objectid, 0, 14737, "whorewallstuff", "Pict1", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14815, "whore_main", "WH_carpet3", 0xFFFFFFFF);
		}
		case 25: {

			SetDynamicObjectMaterial(objectid, 0, 14738, "whorebar", "AH_whoredoor", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 2423, "cj_ff_counters", "CJ_Laminate1", 0xFF221918);
			SetDynamicObjectMaterial(objectid, 3, 2423, "cj_ff_counters", "CJ_Laminate1", 0xFF221918);
			SetDynamicObjectMaterial(objectid, 4, 4833, "airprtrunway_las", "homies_1", 0xFFFFFFFF);
		}
		case 26: {

			SetDynamicObjectMaterial(objectid, 0, 14739, "whorebits", "AH_cheapbarpan", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14815, "whore_main", "WH_carpet3", 0xFFFFFFFF);
		}
		case 27: {

			SetDynamicObjectMaterial(objectid, 0, 14832, "lee_stripclub", "cl_floornew_256", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3922, "bistro", "Marble", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14815, "whore_main", "WH_carpet3", 0xFFFFFFFF);
		}
		case 28: {

			SetDynamicObjectMaterial(objectid, 0, 1355, "break_s_bins", "CJ_RED_LEATHER", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 18835, "mickytextures", "red032", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 18752, "volcano", "lavalake", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 16640, "a51", "sl_metalwalk", 0xFFFFFFFF);
		}
		case 29: {

			SetDynamicObjectMaterial(objectid, 0, 14534, "ab_wooziea", "ab_wuziMirror", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 7978, "vgssairport", "newall16white", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14534, "ab_wooziea", "ab_tileDiamond", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14560, "triad_bar", "triad_decor1", 0xFFFFFFFF);
		}
		case 30: {

			SetDynamicObjectMaterial(objectid, 0, 14623, "mafcasmain", "ab_MarbleDiamond", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14415, "carter_block_2", "mp_gs_woodpanel", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14415, "carter_block_2", "mp_gs_woodpanel", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 3922, "bistro", "Marble2", 0xFF9F9D94);
		}
		case 31: {

			SetDynamicObjectMaterial(objectid, 0, 7073, "vgnfremntsgn", "candysign1_256", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 10377, "cityhall_sfs", "ws_concretenew_step", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 2988, "kcomp_gx", "kmwood_gate", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 2988, "kcomp_gx", "kmwood_gate", 0xFFFFFFFF);
		}
		case 32: {
			SetDynamicObjectMaterial(objectid, 0, 3906, "libertyhi5", "newall9d_16c128", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 1716, "cj_seating", "CJ_SHINYWOOD", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 2988, "kcomp_gx", "kmwood_gate", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14702, "masmall3int2", "HS3_wall6", 0xFFFFFFFF);
		}
		case 33: {

			SetDynamicObjectMaterial(objectid, 0, 6357, "sunstrans_law2", "dogbill01", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 3241, "conhooses", "des_woodfence1", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 18996, "mattextures", "bluefoil", 0xFF5E7072);
		}
		case 34: {

			SetDynamicObjectMaterial(objectid, 0, 18901, "matclothes", "bandanared", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14651, "ab_trukstpd", "Bow_bar_pool_table", 0xFF767B7C);
			SetDynamicObjectMaterial(objectid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0xFFFFFFFF);
		}
		case 35: {
			SetDynamicObjectMaterial(objectid, 0, 14443, "ganghoos", "AH_filthtiles2", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14623, "mafcasmain", "marble_wall", 0xFFFFFFFF);
		}
		case 36: {

			SetDynamicObjectMaterial(objectid, 0, 14812, "lee_studhall", "GoldDisk4", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14651, "ab_trukstpd", "Bow_bar_tabletop_wood", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 14651, "ab_trukstpd", "Bow_bar_tabletop_wood", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14608, "triad_big", "buddha_gold", 0xFFFFFFFF);
		}

		default: {
			SetDynamicObjectMaterial(objectid, 0, 2964, "k_pool", "pool_table_cloth", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 1, 3116, "kei_wnchx", "trilby04", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 2, 14651, "ab_trukstpd", "Bow_bar_metal_cabinet", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 3, 2964, "k_pool", "blue_pool_table", 0xFFFFFFFF);
			SetDynamicObjectMaterial(objectid, 4, 14651, "ab_trukstpd", "Bow_bar_tabletop_wood", 0xFFFFFFFF);
		}
	}
}

stock Pool_UpdatePlayerCamera( playerid, poolid )
{
	new
		Float: Xa, Float: Ya, Float: Za;

	GetDynamicObjectPos( PHY_GetHandleObject( g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ 0 ] ), Xa, Ya, Za );

	if ( ! p_PoolCameraBirdsEye{ playerid } )
	{
	    new
	    	Float: x = Xa, Float: y = Ya;

	    x += ( 0.675 * floatsin( -p_PoolAngle[ playerid ] [ 0 ] + 180.0, degrees ) );
	    y += ( 0.675 * floatcos( -p_PoolAngle[ playerid ] [ 0 ] + 180.0, degrees ) );

		SetPlayerCameraPos( playerid, x, y, g_poolTableData[ poolid ] [ E_Z ] + DEFAULT_AIM );
		SetPlayerCameraLookAt( playerid, Xa, Ya, Za + 0.170 );
	}
	else
	{
		SetPlayerCameraPos( playerid, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] + 2.0 );
		SetPlayerCameraLookAt( playerid, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] );
	}
}

stock IsPlayerPlayingPool( playerid ) {
	return p_isPlayingPool{ playerid };
}

/* ** Commands ** */
CMD:poolendgame(playerid)
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new iPool = Pool_GetClosestTable( playerid );

	if ( iPool == -1 )
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You must be near a pool table to use this command." );

	Pool_EndGame( iPool );

	SendClientMessage(playerid, -1, "{FF0770}[ADMIN]{FFFFFF} You have force ended the pool game!");
	return 1;
}

CMD:poolgoto(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new poolid ;

	if ( sscanf ( params, "i", poolid ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "/poolgoto [poolid]") ;
	}

	if ( poolid > MAX_POOL_TABLES ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", sprintf("The ID you entered exceeds the maximum limit of %d tables.", MAX_POOL_TABLES ) ) ;
	}

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, g_poolTableData[ poolid ] [ E_X ], g_poolTableData[ poolid ] [ E_Y ], g_poolTableData[ poolid ] [ E_Z ] );

	SetPlayerInterior(playerid, g_poolTableData[ poolid ] [ E_INTERIOR ] ) ;
	SetPlayerVirtualWorld(playerid, g_poolTableData[ poolid ] [ E_WORLD ] ) ;

	SendClientMessage(playerid, -1, sprintf("{FF0770}[ADMIN]{FFFFFF} Teleported to pool SQL ID %d (id %d).", g_poolTableData[ poolid ] [ E_SQLID ], poolid ) );

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT ) ;

	return true ;
}

CMD:poolcolor(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new skin ;

	if ( sscanf ( params, "i", skin ) ) {

		return SendClientMessage(playerid, -1, "/poolcolor [skinid (0-36)]" ) ;
	}

	new poolid = Pool_GetClosestTable( playerid );

	if ( poolid == -1 ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You must be near a pool table to use this command." );
	}

	Pool_UpdateTableSkin ( g_poolTableData[ poolid ] [ E_TABLE ], skin ) ;

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE pool SET pool_color = %d WHERE pool_sqlid = %d",
	skin,  g_poolTableData[ poolid ] [ E_SQLID ] ) ;

	mysql_tquery(mysql, query);

	SendClientMessage(playerid, -1, sprintf("{FF0770}[ADMIN]{FFFFFF} Changed color of pool SQL ID %d to %d.", g_poolTableData[ poolid ] [ E_SQLID ], skin ) );

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT ) ;

	return true ;
}

CMD:pooldelete(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new poolid = Pool_GetClosestTable( playerid );

	if ( poolid == -1 ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You must be near a pool table to use this command." );
	}


 	Pool_EndGame( poolid ) ;

	new query [ 512 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "DELETE FROM pool WHERE pool_sqlid = %d", g_poolTableData[ poolid ] [ E_SQLID ] ) ;
	mysql_tquery(mysql, query);

	SendClientMessage(playerid, -1, sprintf("{FF0770}[ADMIN]{FFFFFF} You have deleted pool SQL ID %d", g_poolTableData[ poolid ] [ E_SQLID ] ) );

	g_poolTableData[poolid] [ E_SQLID ] = -1 ;

 	if ( IsValidDynamicObject( g_poolTableData[ poolid ] [ E_TABLE ] ) ) {

 		SOLS_DestroyObject(g_poolTableData[ poolid ] [ E_TABLE ], "Pool/PoolDelete", true);
 	}

 	if ( IsValidDynamic3DTextLabel( g_poolTableData[ poolid ] [ E_LABEL ] )) {

 		DestroyDynamic3DTextLabel( g_poolTableData[ poolid ] [ E_LABEL ] ) ;
 	}

	for ( new i = 0; i < 4; i ++ ) {
		PHY_DestroyWall(g_poolTableData[ poolid ] [ E_WALL ] [ i ]) ;
	}

	if ( IsValidDynamicArea( g_poolTableData[ poolid ] [ E_CUEBALL_AREA ] ) ) {
		DestroyDynamicArea( g_poolTableData[ poolid ] [ E_CUEBALL_AREA ] ) ;
	}

	g_poolTableData[ poolid ] [ E_X ] = -1.0;
	g_poolTableData[ poolid ] [ E_Y ] = -1.0;
	g_poolTableData[ poolid ] [ E_Z ] = -1.0;
	g_poolTableData[ poolid ] [ E_ANGLE ] = 0.0;
	g_poolTableData[ poolid ] [ E_INTERIOR ] = 9999 ;
	g_poolTableData[ poolid ] [ E_WORLD ] = 9999 ;

	// reset pool handles
	for ( new i = 0; i < sizeof( g_poolBallOffsetData ); i ++ ) {
		g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] = ITER_NONE;
	}

	Iter_Remove(pooltables, poolid ) ;	
	Streamer_Update(playerid, STREAMER_TYPE_OBJECT ) ;

	return true ;
}

CMD:poolmove(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float: A ;

	if ( sscanf ( params, "f", A ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "/poolmove [angle: 0, 90, 180, 270, 360]" );
	}

	if ( A != 0 && A != 90.0 && A != 180.0 && A != 270.0 && A != 360.0 ) {

		return SendClientMessage(playerid, -1,  "[POOL] [ERROR] Pool tables must be positioned at either 0, 90, 180, 270 and 360 degrees." ), 1;
	}

	new poolid = Pool_GetClosestTable( playerid );

	if ( poolid == -1 ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You must be near a pool table to use this command." );
	}

	new Float: X, Float: Y, Float: Z ;
	GetPlayerPos(playerid, X, Y, Z ) ;

	new interior = GetPlayerInterior ( playerid ) ;
	new world = GetPlayerVirtualWorld ( playerid ) ;

 	Pool_EndGame( poolid ) ;

 	if ( IsValidDynamicObject( g_poolTableData[ poolid ] [ E_TABLE ] ) ) {

 		SOLS_DestroyObject(g_poolTableData[ poolid ] [ E_TABLE ], "Pool/PoolMove", true);
 		g_poolTableData[ poolid ] [ E_TABLE ] = INVALID_OBJECT_ID ;
 	}

 	if ( IsValidDynamic3DTextLabel( g_poolTableData[ poolid ] [ E_LABEL ] )) {

 		DestroyDynamic3DTextLabel( g_poolTableData[ poolid ] [ E_LABEL ] ) ;
 		g_poolTableData[ poolid ] [ E_LABEL ] = DynamicText3D: INVALID_3DTEXT_ID ;
 	}

	new Float: x_vertex[ 4 ], Float: y_vertex[ 4 ];

	g_poolTableData[ poolid ] [ E_X ] = X;
	g_poolTableData[ poolid ] [ E_Y ] = Y;
	g_poolTableData[ poolid ] [ E_Z ] = Z;
	g_poolTableData[ poolid ] [ E_ANGLE ] = A;

	g_poolTableData[ poolid ] [ E_INTERIOR ] = interior;
	g_poolTableData[ poolid ] [ E_WORLD ] = world;

	g_poolTableData[ poolid ] [ E_TABLE ] = CreateDynamicObject( 2964, X, Y, Z - 1.0, 0.0, 0.0, A, .interiorid = interior, .worldid = world, .priority = 9999 );
	g_poolTableData[ poolid ] [ E_LABEL ] = CreateDynamic3DTextLabel( DEFAULT_POOL_STRING, COLOR_GREY, X, Y, Z, 10.0, .interiorid = interior, .worldid = world, .priority = 9999 );

	Pool_UpdateTableSkin ( g_poolTableData[ poolid ] [ E_TABLE ], g_poolTableData[ poolid ] [ E_SKIN ] ) ;

	Pool_RotateXY( -0.964, -0.51, A, x_vertex[ 0 ], y_vertex[ 0 ] );
	Pool_RotateXY( -0.964, 0.533, A, x_vertex[ 1 ], y_vertex[ 1 ] );
	Pool_RotateXY( 0.976, -0.51, A, x_vertex[ 2 ], y_vertex[ 2 ] );
	Pool_RotateXY( 0.976, 0.533, A, x_vertex[ 3 ], y_vertex[ 3 ] );

	for ( new i = 0; i < 4; i ++ ) {
		PHY_DestroyWall(g_poolTableData[ poolid ] [ E_WALL ] [ i ]) ;
	}

	g_poolTableData[ poolid ] [ E_WALL ] [ 0 ] = PHY_CreateWall( x_vertex[ 0 ] + X, y_vertex[ 0 ] + Y, x_vertex[ 1 ] + X, y_vertex[ 1 ] + Y );
	g_poolTableData[ poolid ] [ E_WALL ] [ 1 ] = PHY_CreateWall( x_vertex[ 1 ] + X, y_vertex[ 1 ] + Y, x_vertex[ 3 ] + X, y_vertex[ 3 ] + Y );
	g_poolTableData[ poolid ] [ E_WALL ] [ 2 ] = PHY_CreateWall( x_vertex[ 2 ] + X, y_vertex[ 2 ] + Y, x_vertex[ 3 ] + X, y_vertex[ 3 ] + Y );
	g_poolTableData[ poolid ] [ E_WALL ] [ 3 ] = PHY_CreateWall( x_vertex[ 0 ] + X, y_vertex[ 0 ] + Y, x_vertex[ 2 ] + X, y_vertex[ 2 ] + Y );

	// set wall worlds
	for ( new i = 0; i < 4; i ++ ) {
		PHY_SetWallWorld( g_poolTableData[ poolid ] [ E_WALL ] [ i ], world );
	}

	// create boundary for replacing the cueball
	new Float: vertices[ 4 ];

	Pool_RotateXY( 0.94, 0.48, g_poolTableData[ poolid ] [ E_ANGLE ], vertices[ 0 ], vertices[ 1 ] );
	Pool_RotateXY( -0.94, -0.48, g_poolTableData[ poolid ] [ E_ANGLE ], vertices[ 2 ], vertices[ 3 ] );

	vertices[ 0 ] += g_poolTableData[ poolid ] [ E_X ], vertices[ 2 ] += g_poolTableData[ poolid ] [ E_X ];
	vertices[ 1 ] += g_poolTableData[ poolid ] [ E_Y ], vertices[ 3 ] += g_poolTableData[ poolid ] [ E_Y ];

	g_poolTableData[ poolid ] [ E_CUEBALL_AREA ] = CreateDynamicRectangle( vertices[ 2 ], vertices[ 3 ], vertices[ 0 ], vertices[ 1 ], .interiorid = interior, .worldid = world );


	// reset pool handles
	for ( new i = 0; i < sizeof( g_poolBallOffsetData ); i ++ ) {
		g_poolBallData[ poolid ] [ E_BALL_PHY_HANDLE ] [ i ] = ITER_NONE;
	}


	new query [ 512 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE pool SET pool_pos_x = %0.3f, pool_pos_y = %0.3f, pool_pos_z = %0.3f, pool_pos_angle = %0.3f, pool_pos_int = %d, pool_pos_world = %d WHERE pool_sqlid = %d",
	X, Y, Z, A, interior, world, g_poolTableData[ poolid ] [ E_SQLID ] ) ;

	mysql_tquery(mysql, query);

	SendClientMessage(playerid, -1, sprintf("{FF0770}[ADMIN]{FFFFFF} Changed location of pool SQL ID %d to your current location.", g_poolTableData[ poolid ] [ E_SQLID ] ) );

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT ) ;

	return true ;
}

CMD:poolcreate(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new
		Float: x, Float: y, Float: z, Float: angle;


	if ( sscanf ( params, "f", angle ) ) {

		SendClientMessage(playerid, COLOR_YELLOW, "WARNING: Creates pool table right under you!" ) ;
		return SendClientMessage(playerid, -1, "/poolcreate [angle: must be 0, 90, 270, or 360 degrees]" ) ;
	}

	if ( GetPlayerPos( playerid, x, y, z ) ) {
		new query [ 512 ] ;

		mysql_format(mysql, query, sizeof ( query ),
			"INSERT INTO pool( pool_pos_x, pool_pos_y, pool_pos_z, pool_pos_angle, pool_pos_int, pool_pos_world, pool_color) VALUES ('%f', '%f', '%f','%f', %d, %d, %d)",
			x, y, z, angle, GetPlayerInterior( playerid ), GetPlayerVirtualWorld( playerid ) , 0
		);

		inline Pool_OnDatabaseInsert() {

			new sqlid = cache_insert_id () ;

			CreatePoolTable(playerid, x, y, z, angle, 0, GetPlayerInterior( playerid ), GetPlayerVirtualWorld( playerid ), sqlid);
			SendClientMessage(playerid, -1, sprintf("{FF0770}[ADMIN]{FFFFFF} You have created a pool table with SQL ID %d.", sqlid ) );
		}

		MySQL_TQueryInline(mysql, using inline Pool_OnDatabaseInsert, query, "");
	}

	return 1;
}

CMD:spoofpool(playerid)
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_MANAGER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new
		iPool = Pool_GetClosestTable( playerid );

	if ( iPool == -1 )
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You are not near a pool table." );

	if ( ! IsPlayerPlayingPool( playerid ))
	{
		p_isPlayingPool { playerid } = true;
		p_PoolID[ playerid ]		 = iPool;

		PlayerPlaySound( playerid, 1085, 0.0, 0.0, 0.0 );
		SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME, 338, 6 ) ; // normal cue in hand

		p_PoolScore[ playerid ] = 0;

		if ( ! g_poolTableData[ iPool ] [ E_STARTED ] )
		{
			g_poolTableData[ iPool ] [ E_STARTED ] = true;

			Iter_Clear( poolplayers< iPool > );
			Iter_Add( poolplayers< iPool >, playerid );
			Iter_Add( poolplayers< iPool >, playerid );

			UpdateDynamic3DTextLabelText(g_poolTableData[ iPool ] [ E_LABEL ], -1, sprintf( "{FFDC2E}%s is currently playing a test game.", ReturnMixedName( playerid )) );

			Pool_RespawnBalls( iPool );
		}
	}
	else
	{
		Pool_EndGame( iPool );
	}
	return 1;
}