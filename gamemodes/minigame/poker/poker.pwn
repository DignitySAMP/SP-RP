/******************************************************************************************

                                            TPoker

    Texas Hold'em Poker Implementation

    Copyright (C) 2018 ThreeKingz (Freddy Borja)

	https://github.com/ThreeKingz

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

*******************************************************************************************/


/* ** Error checking ** */
//#if !defined __irresistible_servervars
//    #error "You need server variables enabled to track betting."
//#endif

forward bool: FoldPlayer(handle, playerid);

/*
	native calculate_hand_worth(const hands[], count = sizeof(hands));

	* hands[]: an array containing the cards to analyze (between 1 to 7 cards)
	* count: the number of cards to analyze (between 1 to 7 cards)
*/

native calculate_hand_worth(const hands[], count = sizeof(hands));



#define T_SendWarning(%0)      		(printf(" * [TPoker]: " %0))

/******************************************************************************************
	Utils
*******************************************************************************************/
stock SetPlayerChatBubbleEx(playerid, color, Float:drawdistance, expiretime, const format[], va_args<>)
{
	return SetPlayerChatBubble(playerid, va_return(format, va_start<5>), color, drawdistance, expiretime);
}
stock UpdateDynamic3DTextLabelTextEx(STREAMER_TAG_3D_TEXT_LABEL id, color, const format[], va_args<>)
{
	return UpdateDynamic3DTextLabelText(id, color, va_return(format, va_start<3>));
}



/******************************************************************************************
										Constants
*******************************************************************************************/

//Limits
#define T_MAX_POKER_TABLES													100
#define T_MAX_CHAIRS_PER_TABLE												7
#define T_CHAIR_MODEL 														2120
#define T_MAX_CHIPS_PER_CHAIR												4
#define T_MAX_WAIT_TIME														20 //20 seconds to make a choice
#define T_START_DELAY														5 //5 seconds
#define T_SAVE_PLAYER_POS 													true
//Max number the chips can express 10^(MAX_CHIP_DIGITS) - 1
#define MAX_CHIP_DIGITS														7
#define T_TABLE_TICK_INTERVAL												500 //(in ms) half a second
#define T_POT_FEE_RATE 														0.02


//Layout and design
#define T_Z_OFFSET 															0.442852
#define T_CHAIR_RANGE														1.250000
#define T_Z_CAMERA_OFFSET													3.0
#define T_CHIP_OFFSET														0.13
//Length and width of cards
#define T_CARD_X_SIZE														23.0 // 21.000000
#define T_CARD_Y_SIZE														31.0 // 29.000000


#define T_TWO_CARD_DISTANCE													23.904725 //Distance between the two cards each player receives
#define T_CARDS_RADIAL_DISTANCE												144.00000 //Distance from the first card to the center of the table
#define T_SCREEN_CENTER_X 													320.00000
#define T_SCREEN_CENTER_Y 													215.00000
#define T_CHIPS_DISTANCE 													0.6582
#define T_RADIUS															0.971977
#define T_BET_LABEL_COLOR													0x0080FFFF
//Radial distance required to enter a table
#define T_JOIN_TABLE_RANGE													2.5



/*Textdraw constants*/

#define MAIN_POT 															0
#define CALL 																0
#define RAISE 																1
#define FOLD 																2


#define SendPokerMessage(%0,%1) \
	SendClientMessageFormatted(%0, -1, "{4B8774}[POKER] {E5861A}"%1)


/******************************************************************************************
	Enums and arrays
*******************************************************************************************/

/* Iterators */

new Iterator:IT_Tables<T_MAX_POKER_TABLES>;
new Iterator:IT_TableCardSet[T_MAX_POKER_TABLES]<52>; //Card sample space

new Iterator:IT_PlayersTable<T_MAX_POKER_TABLES, MAX_PLAYERS>; //Current players in the table (might not be playing but just looking the rest of the players play)
new Iterator:IT_PlayersInGame<T_MAX_POKER_TABLES, MAX_PLAYERS>; //Current players in the table playing
new Iterator:IT_PlayersAllIn<T_MAX_POKER_TABLES, MAX_PLAYERS>;

//Syntax: It_SidepotMembers[_IT[idx_table][idx_chair_slot]]
new Iterator:It_SidepotMembers[T_MAX_POKER_TABLES * T_MAX_CHAIRS_PER_TABLE]<MAX_PLAYERS>;
new Iterator:IT_Sidepots[T_MAX_POKER_TABLES]<T_MAX_CHAIRS_PER_TABLE>;
#define _IT[%0][%1]            %0*T_MAX_CHAIRS_PER_TABLE+%1
#define IsValidTable(%0)		((0 <= %0 < T_MAX_POKER_TABLES) && Iter_Contains(IT_Tables, %0))






enum E_TABLE_STATES
{
	STATE_IDLE,
	STATE_BEGIN, //Game has started
}

//Rankings: from lowest to highest
new const HAND_RANKS[][] =
{
	{"Undefined"}, //will never occur
	{"High Card"},
	{"Pair"},
	{"Two Pair"},
	{"Three of a Kind"},
	{"Straight"},
	{"Flush"},
	{"Full House"},
	{"Four of a Kind"},
	{"Straight Flush"},
	{"Royal Flush"}
};
enum E_CARD_SUITS
{
	SUIT_SPADES,
	SUIT_HEARTS,
	SUIT_CLUBS,
	SUIT_DIAMONDS
};

enum E_CARD_DATA
{
	E_CARD_TEXTDRAW[48],
	E_CARD_NAME[48],
	E_CARD_SUITS:E_CARD_SUIT,
	E_CARD_RANK
};


new const CardData[ 52 ] [E_CARD_DATA] = {

	//Spades
    {"LD_CARD:cd2s", 		"Two of Spades", 		SUIT_SPADES,		0},
    {"LD_CARD:cd3s", 		"Three of Spades", 		SUIT_SPADES,		1},
    {"LD_CARD:cd4s", 		"Four of Spades", 		SUIT_SPADES,		2},
    {"LD_CARD:cd5s", 		"Five of Spades", 		SUIT_SPADES,		3},
    {"LD_CARD:cd6s", 		"Six of Spades", 		SUIT_SPADES,		4},
    {"LD_CARD:cd7s", 		"Seven of Spades", 		SUIT_SPADES,		5},
    {"LD_CARD:cd8s", 		"Eight of Spades", 		SUIT_SPADES,		6},
    {"LD_CARD:cd9s", 		"Nine of Spades", 		SUIT_SPADES,		7},
    {"LD_CARD:cd10s",		"Ten of Spades",		SUIT_SPADES,		8},
    {"LD_CARD:cd11s",		"Jack of Spades", 		SUIT_SPADES,		9},
    {"LD_CARD:cd12s",		"Queen of Spades", 		SUIT_SPADES,		10},
    {"LD_CARD:cd13s", 		"King of Spades", 		SUIT_SPADES,		11},
    {"LD_CARD:cd1s", 		"Ace of Spades", 		SUIT_SPADES,		12},

	//Hearts
    {"LD_CARD:cd2h", 		"Two of Hearts", 		SUIT_HEARTS,		0},
    {"LD_CARD:cd3h", 		"Three of Hearts", 		SUIT_HEARTS,		1},
    {"LD_CARD:cd4h", 		"Four of Hearts", 		SUIT_HEARTS,		2},
    {"LD_CARD:cd5h", 		"Five of Hearts", 		SUIT_HEARTS,		3},
    {"LD_CARD:cd6h", 		"Six of Hearts", 		SUIT_HEARTS,		4},
    {"LD_CARD:cd7h", 		"Seven of Hearts", 		SUIT_HEARTS,		5},
    {"LD_CARD:cd8h", 		"Eight of Hearts", 		SUIT_HEARTS,		6},
    {"LD_CARD:cd9h", 		"Nine of Hearts", 		SUIT_HEARTS,		7},
    {"LD_CARD:cd10h",		"Ten of Hearts",		SUIT_HEARTS,		8},
    {"LD_CARD:cd11h",		"Jack of Hearts", 		SUIT_HEARTS,		9},
    {"LD_CARD:cd12h",		"Queen of Hearts", 		SUIT_HEARTS,		10},
    {"LD_CARD:cd13h",		"King of Hearts", 		SUIT_HEARTS,		11},
    {"LD_CARD:cd1h", 		"Ace of Hearts", 		SUIT_HEARTS,		12},

	//Clubs
    {"LD_CARD:cd2c", 		"Two of Clubs", 		SUIT_CLUBS, 		0},
    {"LD_CARD:cd3c", 		"Three of Clubs", 		SUIT_CLUBS, 		1},
    {"LD_CARD:cd4c", 		"Four of Clubs", 		SUIT_CLUBS, 		2},
    {"LD_CARD:cd5c", 		"Five of Clubs", 		SUIT_CLUBS, 		3},
    {"LD_CARD:cd6c", 		"Six of Clubs", 		SUIT_CLUBS, 		4},
    {"LD_CARD:cd7c", 		"Seven of Clubs", 		SUIT_CLUBS, 		5},
    {"LD_CARD:cd8c", 		"Eight of Clubs", 		SUIT_CLUBS, 		6},
    {"LD_CARD:cd9c", 		"Nine of Clubs", 		SUIT_CLUBS, 		7},
    {"LD_CARD:cd10c",		"Ten of Clubs",			SUIT_CLUBS, 		8},
    {"LD_CARD:cd11c",		"Jack of Clubs", 		SUIT_CLUBS, 		9},
    {"LD_CARD:cd12c",		"Queen of Clubs", 		SUIT_CLUBS, 		10},
    {"LD_CARD:cd13c",		"King of Clubs", 		SUIT_CLUBS, 		11},
    {"LD_CARD:cd1c", 		"Ace of Clubs", 		SUIT_CLUBS, 		12},

    //Diamonds
    {"LD_CARD:cd2d", 		"Two of Diamonds", 		SUIT_DIAMONDS, 		0},
    {"LD_CARD:cd3d", 		"Three of Diamonds", 	SUIT_DIAMONDS, 		1},
    {"LD_CARD:cd4d", 		"Four of Diamonds", 	SUIT_DIAMONDS, 		2},
    {"LD_CARD:cd5d", 		"Five of Diamonds", 	SUIT_DIAMONDS, 		3},
    {"LD_CARD:cd6d", 		"Six of Diamonds", 		SUIT_DIAMONDS, 		4},
    {"LD_CARD:cd7d", 		"Seven of Diamonds", 	SUIT_DIAMONDS, 		5},
    {"LD_CARD:cd8d", 		"Eight of Diamonds", 	SUIT_DIAMONDS, 		6},
    {"LD_CARD:cd9d", 		"Nine of Diamonds", 	SUIT_DIAMONDS, 		7},
    {"LD_CARD:cd10d",		"Ten of Diamonds", 		SUIT_DIAMONDS, 		8},
    {"LD_CARD:cd11d",		"Jack of Diamonds", 	SUIT_DIAMONDS, 		9},
    {"LD_CARD:cd12d",		"Queen of Diamonds", 	SUIT_DIAMONDS, 		10},
    {"LD_CARD:cd13d",		"King of Diamonds", 	SUIT_DIAMONDS, 		11},
    {"LD_CARD:cd1d", 		"Ace of Diamonds", 		SUIT_DIAMONDS, 		12}
};


//Card rank = (array index % 13) | Card native index = 4 * rank + suit
#define GetCardNativeIndex(%0) 			((4*((%0) % 13))+_:CardData[(%0)][E_CARD_SUIT])


new const TableRotCorrections[][] =
{
	{-1, -1, -1, -1, -1, -1},//0seats
	{-1, -1, -1, -1, -1, -1},//1 seat
	{ 1,  0, -1, -1, -1, -1},//2 seats
	{ 1,  0,  2, -1, -1, -1},//3 seats
	{ 1,  0,  3,  2, -1, -1},//4 seats
	{ 1,  0,  4,  3,  2, -1},//5 seats
	{ 1,  0,  5,  4,  3,  2} //6 seats
};


new const colors[MAX_CHIP_DIGITS] =
{
	0xFF0080C0,//1
	0xFF008000,//10
	0xFF324A4E,//100
	0xFF7C4303,//1,000
	0xFF63720E,//10,000
	0xFFE2C241,//100,000
	0xFFE4603F//1,000,000
	//0xFFCD270A, //100,000,000
	//0xFFFF2424, //1,000,000,000
	//0xFFFF2424, //10,000,000,000

};

new const chip_text[MAX_CHIP_DIGITS][8] =
{
	{"$1"},
	{"$10"},
	{"$100"},
	{"$1K"},
	{"$10K"},
	{"$100K"},
	{"$1M"}
	//{"$10M"},
	//{"$100M"},
	//{"$1,000M"}
};
/*============*/

enum E_TABLE_ROUNDS
{
	ROUND_PRE_FLOP, //no community cards displayed yet
	ROUND_FLOP,
	ROUND_TURN, //4th com card is shown
	ROUND_RIVER //5th community card is shown
};

enum e_TABLE
{
	E_TABLE_SQL_ID,
	E_TABLE_BUY_IN,
	E_TABLE_SMALL_BLIND,
	E_TABLE_BIG_BLIND,
	E_TABLE_LAST_TO_RAISE,
	E_TABLE_LAST_TO_RAISE_SEAT,
	E_TABLE_CURRENT_TURN,
	E_TABLE_LAST_BET,
	E_TABLE_STATES:E_TABLE_CURRENT_STATE,
	E_TABLE_PLAYER_DEALER_ID,
	E_TABLE_PLAYER_BIG_BLIND_ID,
	E_TABLE_PLAYER_SMALL_BLIND_ID,
	bool:E_TABLE_CHECK_FIRST,
	E_TABLE_FIRST_TURN,
	//============SIDEPOTS===================
	E_TABLE_POT_CHIPS[T_MAX_CHAIRS_PER_TABLE],

	//=======================================
	bool: E_TABLE_TIMER_STARTED,
	E_TABLE_OBJECT_IDS[2], //Two objects (models 2111 and 2189)
	Float:E_TABLE_POS_X,
	Float:E_TABLE_POS_Y,
	Float:E_TABLE_POS_Z,
	E_TABLE_ROUNDS: E_TABLE_CURRENT_ROUND,
	E_TABLE_DEALER_SEAT,
	E_TABLE_TOTAL_SEATS,
	E_TABLE_TIMER_ID,
	bool: E_TABLE_LOADING_GAME,
	bool: E_TABLE_STING_NEW_GAME,
	E_TABLE_COM_CARDS_VALUES[5],
	DynamicText3D:E_TABLE_POT_LABEL,
	E_TABLE_VIRTUAL_WORLD,
	E_TABLE_INTERIOR,

	DynamicText3D:E_TABLE_BET_LABELS[T_MAX_CHAIRS_PER_TABLE],
	E_TABLE_CHAIR_OBJECT_IDS[T_MAX_CHAIRS_PER_TABLE],
	bool:E_TABLE_IS_SEAT_TAKEN[T_MAX_CHAIRS_PER_TABLE],
	E_TABLE_CHAIR_PLAYER_ID[T_MAX_CHAIRS_PER_TABLE],
	Float:E_TABLE_SEAT_POS_X[T_MAX_CHAIRS_PER_TABLE],
	Float:E_TABLE_SEAT_POS_Y[T_MAX_CHAIRS_PER_TABLE],
	Float:E_TABLE_SEAT_POS_Z[T_MAX_CHAIRS_PER_TABLE],

	E_TABLE_CHIPS[MAX_CHIP_DIGITS],
	E_TABLE_CHIPS_LABEL[MAX_CHIP_DIGITS]
};


new TableData[T_MAX_POKER_TABLES + 1][e_TABLE];
new TableChips[T_MAX_POKER_TABLES + 1][T_MAX_CHAIRS_PER_TABLE][MAX_CHIP_DIGITS];
new TableChipsLabel[T_MAX_POKER_TABLES + 1][T_MAX_CHAIRS_PER_TABLE][MAX_CHIP_DIGITS];

#define SetTableFirstTurn(%0,%1)		TableData[(%0)][E_TABLE_FIRST_TURN]=%1
#define GetTableFirstTurn(%0)			(TableData[(%0)][E_TABLE_FIRST_TURN])
#define GetPlayerSeat(%0)				(PlayerPokerData[(%0)][E_PLAYER_CURRENT_CHAIR_SLOT])
enum E_RAISE_CHOICES
{
	E_RAISE_BET,
	E_RAISE_RAISE,
	E_RAISE_ALL_IN
};

enum e_PLAYER
{
	bool: E_PLAYER_IS_PLAYING,
	E_PLAYER_CURRENT_HANDLE,
	E_PLAYER_CURRENT_BET,
	E_PLAYER_CARD_VALUES[2],
	E_PLAYER_TOTAL_CHIPS,
	bool: E_PLAYER_CLICKED_TXT,
	E_PLAYER_TIMER_ID,
	bool:E_PLAYER_TIMER_STARTED,
	bool:E_PLAYER_FOLDED,
	//Textdraws
	E_RAISE_CHOICES: E_PLAYER_RCHOICE,
	PlayerText: E_PLAYER_COMMUNITY_CARDS_TXT[5] = PlayerText: INVALID_TEXT_DRAW, //5 cards
	PlayerText: E_PLAYER_CARDS_TXT_1[T_MAX_CHAIRS_PER_TABLE] = PlayerText: INVALID_TEXT_DRAW,
	PlayerText: E_PLAYER_CARDS_TXT_2[T_MAX_CHAIRS_PER_TABLE] = PlayerText: INVALID_TEXT_DRAW,
	PlayerText: E_PLAYER_CHOICES_TXT[5] = PlayerText: INVALID_TEXT_DRAW,
	DynamicText3D:E_PLAYER_3D_LABEL,
	/*******/
	E_PLAYER_CURRENT_CHAIR_SLOT,
	E_PLAYER_CHAIR_ATTACH_INDEX_ID
};

new PlayerPokerData[MAX_PLAYERS + 1][e_PLAYER];

CMD:pokercam(playerid, params[]) {

	if(GetPVarInt(playerid, "t_is_in_table")) {
		
		new handle = PlayerPokerData [ playerid ] [ E_PLAYER_CURRENT_HANDLE ] ;

		SetPlayerCameraPos(playerid, TableData[handle][E_TABLE_POS_X], TableData[handle][E_TABLE_POS_Y], TableData[handle][E_TABLE_POS_Z]+T_Z_CAMERA_OFFSET);
		SetPlayerCameraLookAt(playerid, TableData[handle][E_TABLE_POS_X], TableData[handle][E_TABLE_POS_Y], TableData[handle][E_TABLE_POS_Z]);
	}
	return true ;
}

stock SetPlayerClickedTxt(playerid, bool:choice)
{
	PlayerPokerData[playerid][E_PLAYER_CLICKED_TXT] = choice;
	return 1;
}
#define GetPlayerClickedTxt(%0)		(PlayerPokerData[(%0)][E_PLAYER_CLICKED_TXT])

forward Poker_StartGame(handle, dealer);

stock SetLastToRaise(handle, playerid)
{
	if(!IsValidTable(handle))
	{
		return 0;
	}
	if(!Iter_Contains(IT_PlayersInGame<handle>, playerid))
	{
		T_SendWarning("[SetLastToRaise] playerid %d is not playing in table ID %d", playerid, handle);
		return 0;
	}
	TableData[handle][E_TABLE_LAST_TO_RAISE] = playerid;
	TableData[handle][E_TABLE_LAST_TO_RAISE_SEAT] = GetPlayerSeat(playerid);
	return 1;
}

stock ResetLabel(handle)
{
	if(!IsValidTable(handle)) return 0;
	new const buy_in = TableData[handle][E_TABLE_BUY_IN];
	new const small_blind = TableData[handle][E_TABLE_SMALL_BLIND];
	UpdateDynamic3DTextLabelTextEx(TableData[handle][E_TABLE_POT_LABEL], COLOR_GREY,
		"Press ENTER To Play Poker\n{FFFFFF}%s Minimum\n%s / %s Blinds", IntegerWithDelimiter(buy_in), IntegerWithDelimiter(small_blind), IntegerWithDelimiter(small_blind * 2));
	return 1;
}

stock GetClosestTableForPlayer(playerid)
{
	new const Float:infinity = Float:0x7F800000;
	new Float:tmpdist = infinity;
	new Float:Pos[3];
	new handle = ITER_NONE;
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	foreach(new i: IT_Tables)
	{
		new const Float:dist = VectorSize(Pos[0]-TableData[i][E_TABLE_POS_X], Pos[1]-TableData[i][E_TABLE_POS_Y], Pos[2]-TableData[i][E_TABLE_POS_Z]);
		if(dist < tmpdist)
		{
			tmpdist = dist;
			handle = i;
		}
	}
	return handle;
}

stock bool:IsPlayerInRangeOfTable(playerid, handle, Float:range)
{
	if(!IsValidTable(handle)) return false;
	if(IsPlayerInRangeOfPoint(playerid, range, TableData[handle][E_TABLE_POS_X], TableData[handle][E_TABLE_POS_Y], TableData[handle][E_TABLE_POS_Z])) return true;
	return false;
}


/******************************************************************************************
	Actual functions
*******************************************************************************************/

Init_LoadPokerTables() {

	inline Load_PokerTables() {

		new rows,fields;
		cache_get_data(rows,fields,mysql);

		if(rows) {

			for(new i=0; i<rows; i++) {

				new id,buy_in,small_blind,Float:x,Float:y,Float:z,seats,vworld,interior;

				id = cache_get_field_content_int(i,"poker_table_id");
				buy_in = cache_get_field_content_int(i,"poker_table_buy_in");
				small_blind = cache_get_field_content_int(i,"poker_table_small_blind");
				x = cache_get_field_content_float(i,"poker_table_x_pos");
				y = cache_get_field_content_float(i,"poker_table_y_pos");
				z = cache_get_field_content_float(i,"poker_table_z_pos");
				seats = cache_get_field_content_int(i,"poker_table_seats");
				vworld = cache_get_field_content_int(i,"poker_table_vw");
				interior = cache_get_field_content_int(i,"poker_table_interior");

				CreatePokerTable(id,buy_in,small_blind,x,y,z,seats,vworld,interior);
			}

			printf("[POKER] %d poker tables loaded.",rows);
		}
	}
	MySQL_TQueryInline(mysql,"SELECT * FROM poker",using inline Load_PokerTables,"");
	return true;
}

stock CreatePokerTable(id,buy_in, small_blind, Float: X, Float: Y, Float: Z, seats, vworld, interior, db = 0)
{
	new handle = Iter_Free(IT_Tables);

	if(handle == ITER_NONE)
	{
        static overflow;
        printf("[POKER ERROR] Reached limit of %d blackjack tables, increase to %d to fix.", T_MAX_POKER_TABLES, T_MAX_POKER_TABLES + ( ++ overflow ) );
		return ITER_NONE;
	}
	if(seats >= T_MAX_CHAIRS_PER_TABLE)
	{
		T_SendWarning("Max number of chairs per table has been reached. Increase T_MAX_CHAIRS_PER_TABLE.");
		return ITER_NONE;
	}
	if(buy_in <= small_blind || buy_in <= 2 * small_blind)
	{
		T_SendWarning("Buy in cannot be less than the small blind or big blind.");
		return ITER_NONE;
	}
	//TableData[T_MAX_POKER_TABLES] (dummy array)
	memcpy(TableData[handle], TableData[T_MAX_POKER_TABLES], 0, sizeof(TableData[]) * 4, sizeof(TableData[]));

	if ( id != -1 ) {
		TableData[handle][E_TABLE_SQL_ID] = id;
	}

	TableData[handle][E_TABLE_BUY_IN] = buy_in;
	TableData[handle][E_TABLE_SMALL_BLIND] = small_blind;
	TableData[handle][E_TABLE_BIG_BLIND] = small_blind * 2;
	TableData[handle][E_TABLE_TOTAL_SEATS] = seats;
	TableData[handle][E_TABLE_VIRTUAL_WORLD] = vworld;
	TableData[handle][E_TABLE_INTERIOR] = interior;

	/* Positions */
	TableData[handle][E_TABLE_POS_X] = X;
	TableData[handle][E_TABLE_POS_Y] = Y;
	TableData[handle][E_TABLE_POS_Z] = Z;

	/* Objects */

	//Table
	TableData[handle][E_TABLE_OBJECT_IDS][0] = CreateDynamicObject(2189, X, Y, Z + T_Z_OFFSET - 0.01, 0.0, 0.0, 0.0, vworld, interior, .priority = 9999);
	TableData[handle][E_TABLE_OBJECT_IDS][1] = CreateDynamicObject(2111, X, Y, Z-0.01, 0.0, 0.0, 0.0, vworld, interior, .priority = 9999);

	//Textures
	if(buy_in >= 150000) SetDynamicObjectMaterial(TableData[handle][E_TABLE_OBJECT_IDS][0], 0, 2189, "poker_tbl", "roulette_6_256", -52310);
	else if (buy_in >= 100000) SetDynamicObjectMaterial(TableData[handle][E_TABLE_OBJECT_IDS][0], 0, 2189, "poker_tbl", "roulette_6_256", -16737793);
	else if (buy_in >= 50000) SetDynamicObjectMaterial(TableData[handle][E_TABLE_OBJECT_IDS][0], 0, 2189, "poker_tbl", "roulette_6_256", -65485);
	else if (buy_in >= 25000) SetDynamicObjectMaterial(TableData[handle][E_TABLE_OBJECT_IDS][0], 0, 2189, "poker_tbl", "roulette_6_256", 0xC6AB57FF);

	//Chairs
	TableData[handle][E_TABLE_POT_LABEL] = CreateDynamic3DTextLabel("-", -1, X+T_CHIP_OFFSET, Y+T_CHIP_OFFSET, Z+0.5, 10.0, .worldid = vworld, .interiorid = interior);

	new Float:angle_step = floatdiv(360.0, float(seats));
	for(new i = 0; i < seats; i++)
	{
		new const Float:unit_posx = floatcos(float(i) * angle_step, degrees);
		new const Float:unit_posy = floatsin(float(i) * angle_step, degrees);
		new const Float:o_posx = unit_posx * T_CHAIR_RANGE + X;
		new const Float:o_posy = unit_posy * T_CHAIR_RANGE + Y;
		new const Float:c_posz = Z + 0.36;
		TableData[handle][E_TABLE_CHAIR_OBJECT_IDS][i] = CreateDynamicObject(T_CHAIR_MODEL, o_posx, o_posy, Z + 0.25, 0.0, 0.0, angle_step * float(i), vworld, interior, .priority = 9999);
		TableData[handle][E_TABLE_SEAT_POS_X][i] = o_posx;
		TableData[handle][E_TABLE_SEAT_POS_Y][i] = o_posy;
		TableData[handle][E_TABLE_SEAT_POS_Z][i] = Z;
		//Currently invisible
		TableData[handle][E_TABLE_BET_LABELS][i] = CreateDynamic3DTextLabel("$9", T_BET_LABEL_COLOR & ~0xFF,  0.65 * floatcos(float(i) * angle_step, degrees) + X, 0.65 * floatsin(float(i) * angle_step, degrees) + Y,  c_posz, 3.0 , .worldid = vworld, .interiorid = interior);

		CreateChips(handle, i);
	}
	new const Float: or_z = Z + 0.284; //No chips are visible
	new Float: a_s = floatdiv(360.0, float(MAX_CHIP_DIGITS));
	//center chips
	for(new j = 0; j < MAX_CHIP_DIGITS; j++)
	{
		new Float:rad = 0.11;
		new rand = random(20);
		new Float:px = rad * floatcos(float(j) * a_s, degrees) + X + T_CHIP_OFFSET;
		new Float:py = rad * floatsin(float(j) * a_s, degrees) + Y + T_CHIP_OFFSET;
		TableData[handle][E_TABLE_CHIPS][j] = CreateDynamicObject(1902, px, py, or_z + float(rand) * 0.008, 0.0, 0.0, 0.0, vworld, interior, .priority = 9999);
		SetDynamicObjectMaterialText(TableData[handle][E_TABLE_CHIPS][j], 0, " ", .backcolor = colors[j]);
		TableData[handle][E_TABLE_CHIPS_LABEL][j] = CreateDynamicObject(1905, px, py, or_z + float(rand) * 0.008 + 0.1 + 0.025, 0.0, 0.0, 0.0, vworld, interior, .priority = 9999);
		SetDynamicObjectMaterialText(TableData[handle][E_TABLE_CHIPS_LABEL][j],
		0, chip_text[j], 50, "Arial", 44, 1, colors[j], -1, 1 );
	}
	TableData[handle][E_TABLE_CURRENT_STATE] = STATE_IDLE;
	Iter_Clear(IT_TableCardSet[handle]);

	for(new i = 0; i < 52; i++)
		Iter_Add(IT_TableCardSet[handle], i);

	/* Sidepots */
	Iter_Clear(IT_Sidepots[handle]);

	for(new i = 0; i < T_MAX_CHAIRS_PER_TABLE; i++)
	{
		TableData[handle][E_TABLE_POT_CHIPS][i] = 0;
		Iter_Clear(It_SidepotMembers[_IT[handle][i]]);
	}
	/*=================================================*/
	Iter_Add(IT_Tables, handle);
	ResetLabel(handle);
	ResetChips(handle);

	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 35.0, X, Y, Z))
		{
			Streamer_Update(i);
		}
	}

	if(db) {
		
		new query[256];
		mysql_format(mysql,query,sizeof(query),"INSERT INTO poker (poker_table_buy_in,poker_table_small_blind,poker_table_x_pos,poker_table_y_pos,poker_table_z_pos,poker_table_seats,poker_table_vw,poker_table_interior) VALUES (%d,%d,%f,%f,%f,%d,%d,%d)",\
			buy_in,small_blind,X,Y,Z,seats,vworld,interior);
		inline Poker_OnDBInsert() {

			TableData[handle][E_TABLE_SQL_ID] = cache_insert_id ();
		}

		MySQL_TQueryInline(mysql, using inline Poker_OnDBInsert, query, "");

	}
	return handle;
}


stock SetPotChipsValue(handle, value)
{
	new
		dec_pos = 0,
		Float: base_z = TableData[handle][E_TABLE_POS_Z] + 0.284
	;
	for(new j = 0; j < MAX_CHIP_DIGITS; j++)
	{
		new Float:c_x, Float:c_y, Float:c_z;
		new objectid = TableData[handle][E_TABLE_CHIPS][j];
		GetDynamicObjectPos(objectid, c_x, c_y, c_z);
		SetDynamicObjectPos(objectid, c_x, c_y, base_z);
		SetDynamicObjectPos(TableData[handle][E_TABLE_CHIPS_LABEL][j], c_x, c_y, base_z + 0.12);
	}
	for(new val = value; val != 0; val /= 10)
	{
		if(dec_pos >= MAX_CHIP_DIGITS) break;
		new const digit = val % 10;
		if(!digit)
		{
			dec_pos++;
			continue;
		}
		new Float:c_x, Float:c_y, Float:c_z;
		//Chip object
		new objectid = TableData[handle][E_TABLE_CHIPS][dec_pos];
		GetDynamicObjectPos(objectid, c_x, c_y, c_z);
		SetDynamicObjectPos(objectid, c_x, c_y, base_z + 0.016 * (float(digit)));
		//Chip label:
		SetDynamicObjectPos(TableData[handle][E_TABLE_CHIPS_LABEL][dec_pos], c_x, c_y, 0.125 + base_z + 0.016 * (float(digit)));
		dec_pos++;
	}
	return 1;
}

stock CreateChips(handle, i)
{
	new Float:angle_step = floatdiv(360.0, float(TableData[handle][E_TABLE_TOTAL_SEATS]));
	new const Float:c_posz = TableData[handle][E_TABLE_POS_Z] + 0.36;

	new const Float: or_x = 0.70 * floatcos(float(i) * angle_step, degrees) + TableData[handle][E_TABLE_POS_X];
	new const Float: or_y = 0.70 * floatsin(float(i) * angle_step, degrees) + TableData[handle][E_TABLE_POS_Y];
	new const Float: or_z = c_posz - 0.076;

	new Float: a_s = floatdiv(360.0, float(MAX_CHIP_DIGITS));

	for(new j = 0; j < MAX_CHIP_DIGITS; j++)
	{
		new Float:rad = 0.11;
		new rand = random(20);
		TableChips[handle][i][j] = CreateDynamicObject(1902, rad * floatcos(float(j) * a_s, degrees) + or_x , rad * floatsin(float(j)* a_s, degrees) + or_y, or_z + float(rand) * 0.008, 0.0, 0.0, 0.0, TableData[handle][E_TABLE_VIRTUAL_WORLD], TableData[handle][E_TABLE_INTERIOR], .priority = 9999);
		SetDynamicObjectMaterialText(TableChips[handle][i][j], 0, " ", .backcolor = colors[j]);
		TableChipsLabel[handle][i][j] = CreateDynamicObject(1905, rad * floatcos(float(j) * a_s, degrees) + or_x , rad * floatsin(float(j)* a_s, degrees) + or_y, or_z + float(rand) * 0.008 + 0.1 + 0.025, 0.0, 0.0, 0.0, TableData[handle][E_TABLE_VIRTUAL_WORLD], TableData[handle][E_TABLE_INTERIOR], .priority = 9999);
		SetDynamicObjectMaterialText(TableChipsLabel[handle][i][j], 0, chip_text[j], 50, "Arial", 44, 1, colors[j], -1, 1 );
	}

	// update users within premise
	foreach(new playerid: Player) if(IsPlayerInRangeOfPoint(playerid, 35.0, TableData[handle][E_TABLE_POS_X], TableData[handle][E_TABLE_POS_Y], TableData[handle][E_TABLE_POS_Z])) {
		Streamer_Update(playerid);
	}
	return 1;
}

stock ResetChips(handle)
{
	new
		Float: base_z = TableData[handle][E_TABLE_POS_Z] + 0.284
	;
	new seats = TableData[handle][E_TABLE_TOTAL_SEATS];
	for(new i = 0; i < seats; i++) {
		for(new j = 0; j < MAX_CHIP_DIGITS; j++) {
			SOLS_DestroyObject(TableChips[handle][i][j], "Poker/ResetChips", true, .warn=false), TableChips[handle][i][j] = -1;
			SOLS_DestroyObject(TableChipsLabel[handle][i][j], "Poker/ResetChips", true, .warn=false), TableChipsLabel[handle][i][j] = -1;
		}
	}
	/*for(new i = 0; i < seats; i++)
	{
		for(new j = 0; j < MAX_CHIP_DIGITS; j++)
		{
			new rand = random(20);
			new Float:c_x, Float:c_y, Float:c_z;
			new objectid = TableChips[handle][i][j];
			GetDynamicObjectPos(objectid, c_x, c_y, c_z);
			SetDynamicObjectPos(objectid, c_x, c_y, (float(rand) * 0.008) + base_z);
			SetDynamicObjectPos(TableChipsLabel[handle][i][j], c_x, c_y, (float(rand) * 0.008) + base_z + 0.125);
		}
	}*/
	for(new j = 0; j < MAX_CHIP_DIGITS; j++)
	{
		new rand = random(20);
		new Float:c_x, Float:c_y, Float:c_z;
		new objectid = TableData[handle][E_TABLE_CHIPS][j];
		GetDynamicObjectPos(objectid, c_x, c_y, c_z);
		SetDynamicObjectPos(objectid, c_x, c_y, (float(rand) * 0.008) + base_z);
		SetDynamicObjectPos(TableData[handle][E_TABLE_CHIPS_LABEL][j], c_x, c_y, (float(rand) * 0.008) + base_z + 0.125);
	}
	return 1;
}
stock SetChipsValue(handle, seat, value)
{
	new
		dec_pos = 0,
		Float: base_z = TableData[handle][E_TABLE_POS_Z] + 0.284
	;
	if (!IsValidDynamicObject(TableChips[handle][seat][0])) CreateChips(handle, seat);
	for(new j = 0; j < MAX_CHIP_DIGITS; j++)
	{
		new Float:c_x, Float:c_y, Float:c_z;
		new objectid = TableChips[handle][seat][j];
		GetDynamicObjectPos(objectid, c_x, c_y, c_z);
		SetDynamicObjectPos(objectid, c_x, c_y, base_z);
		SetDynamicObjectPos(TableChipsLabel[handle][seat][j], c_x, c_y, base_z + 0.12);
	}
	for(new val = value; val != 0; val /= 10)
	{
		if(dec_pos >= MAX_CHIP_DIGITS) break;
		new const digit = val % 10;
		if(!digit)
		{
			dec_pos++;
			continue;
		}
		new Float:c_x, Float:c_y, Float:c_z;
		//Chip object
		new objectid = TableChips[handle][seat][dec_pos];
		GetDynamicObjectPos(objectid, c_x, c_y, c_z);
		SetDynamicObjectPos(objectid, c_x, c_y, base_z + 0.016 * (float(digit)));
		//Chip label:
		SetDynamicObjectPos(TableChipsLabel[handle][seat][dec_pos], c_x, c_y, 0.125 + base_z + 0.016 * (float(digit)));
		dec_pos++;
	}
	return 1;
}

stock DestroyPokertable( handle)
{
	if(!Iter_Contains(IT_Tables, handle)) return 0;

	if(Iter_Count(IT_PlayersTable<handle>))
	{
		foreach(new i: Player)
		{
			if(Iter_Contains(IT_PlayersTable<handle>, i))
			{
				KickPlayerFromTable(i);
			}
		}
	}


	new query[128];
	mysql_format(mysql,query,sizeof(query),"DELETE FROM poker WHERE poker_table_id = %d", TableData[handle][E_TABLE_SQL_ID] ) ;
	mysql_tquery(mysql,query);

	TableData[handle][E_TABLE_SQL_ID] = -1 ;

	TableData[handle][E_TABLE_BUY_IN] = 0;
	TableData[handle][E_TABLE_SMALL_BLIND] = 0;
	TableData[handle][E_TABLE_BIG_BLIND] = 0;

	SOLS_DestroyObject(TableData[handle][E_TABLE_OBJECT_IDS][0], "Poker/DestroyPokerTable", true, .warn=false);
	TableData[handle][E_TABLE_OBJECT_IDS][0] = INVALID_OBJECT_ID;

	SOLS_DestroyObject(TableData[handle][E_TABLE_OBJECT_IDS][1], "Poker/DestroyPokerTable", true, .warn=false);
	TableData[handle][E_TABLE_OBJECT_IDS][1] = INVALID_OBJECT_ID;

	KillTimer(TableData[handle][E_TABLE_TIMER_ID]);
	TableData[handle][E_TABLE_TIMER_ID] = 0;

	DestroyDynamic3DTextLabel(TableData[handle][E_TABLE_POT_LABEL]);
	for(new i = 0; i < TableData[handle][E_TABLE_TOTAL_SEATS]; i++)
	{
		SOLS_DestroyObject(TableData[handle][E_TABLE_CHAIR_OBJECT_IDS][i], "Poker/ResetPokerTable Chairs", true, .warn=false);
		TableData[handle][E_TABLE_CHAIR_OBJECT_IDS][i] = INVALID_OBJECT_ID;
		TableData[handle][E_TABLE_SEAT_POS_X][i] = 0.0;
		TableData[handle][E_TABLE_SEAT_POS_Y][i] = 0.0;
		TableData[handle][E_TABLE_SEAT_POS_Z][i] = 0.0;
		for(new j = 0; j < MAX_CHIP_DIGITS; j++)
		{
			SOLS_DestroyObject(TableChips[handle][i][j], "Poker/ResetPokerTable Chairs", true, .warn=false), TableChips[handle][i][j] = -1;
			SOLS_DestroyObject(TableChipsLabel[handle][i][j], "Poker/ResetPokerTable Chairs", true, .warn=false), TableChipsLabel[handle][i][j] = -1;
		}
	}
	for(new j = 0; j < MAX_CHIP_DIGITS; j++)
	{
		SOLS_DestroyObject(TableData[handle][E_TABLE_CHIPS][j], "Poker/ResetChips Chips", true, .warn=false);
		SOLS_DestroyObject(TableData[handle][E_TABLE_CHIPS_LABEL][j], "Poker/ResetChips Label", true, .warn=false);
	}
	TableData[handle][E_TABLE_TOTAL_SEATS] = 0;
	Iter_Remove(IT_Tables, handle);
	Iter_Clear(IT_TableCardSet[handle]);
	Iter_Clear(IT_PlayersInGame<handle>);
	Iter_Clear(IT_PlayersTable<handle>);
	return 1;
}



stock KickPlayerFromTable(playerid)
{
	if(!GetPVarInt(playerid, "t_is_in_table")) return 0;
	new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
	if(!Iter_Contains(IT_PlayersTable<handle>, playerid)) return 0;
	new slot = PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT];
	new attach_index = PlayerPokerData[playerid][E_PLAYER_CHAIR_ATTACH_INDEX_ID];
	RemovePlayerAttachedObject(playerid, attach_index);
	ClearAnimations(playerid, 1);
	TogglePlayerControllable(playerid, true);
	new const Float:angle_step = floatdiv(360.0, TableData[handle][E_TABLE_TOTAL_SEATS]);
	//Create the chair object again:
	TableData[handle][E_TABLE_CHAIR_OBJECT_IDS][slot] = CreateDynamicObject(T_CHAIR_MODEL, TableData[handle][E_TABLE_SEAT_POS_X][slot], TableData[handle][E_TABLE_SEAT_POS_Y][slot], TableData[handle][E_TABLE_SEAT_POS_Z][slot], 0.0, 0.0, angle_step * float(slot), TableData[handle][E_TABLE_VIRTUAL_WORLD], TableData[handle][E_TABLE_INTERIOR], .priority = 9999);
	Internal_RemoveChairSlot(handle, slot);
	Iter_Remove(IT_PlayersTable<handle>, playerid);
	if(Iter_Contains(IT_PlayersInGame<handle>, playerid)) Iter_Remove(IT_PlayersInGame<handle>, playerid);
	PauseAC(playerid, 3);
	SetPlayerPos(playerid, TableData[handle][E_TABLE_SEAT_POS_X][slot], TableData[handle][E_TABLE_SEAT_POS_Y][slot], TableData[handle][E_TABLE_SEAT_POS_Z][slot]);
	SetCameraBehindPlayer(playerid);

	// remove player chips
	for(new j = 0; j < MAX_CHIP_DIGITS; j++) {
		SOLS_DestroyObject(TableChips[handle][slot][j], "Poker/KickPlayerFromTable/RemoveChips", true, .warn=false), TableChips[handle][slot][j] = -1;
		SOLS_DestroyObject(TableChipsLabel[handle][slot][j], "Poker/KickPlayerFromTable/RemoveChips", true, .warn=false), TableChipsLabel[handle][slot][j] = -1;
	}

	// hide textdraws
	for(new i = 0; i < TableData[handle][E_TABLE_TOTAL_SEATS]; i++)
	{
		PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i]);
		PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i]);
		PlayerTextDrawDestroy(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i]);
		PlayerTextDrawDestroy(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i]);
	}
	for(new i = 0; i < 5; i++){
		PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i]);
		PlayerTextDrawDestroy(playerid, PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i]);
	}

	for(new i = 0; i < 3; i++){
		PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][i]);
		PlayerTextDrawDestroy(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][i]);
	}

	HideMinigameHelpBox ( playerid );

	DestroyDynamic3DTextLabel(PlayerPokerData[playerid][E_PLAYER_3D_LABEL]);

	UpdateDynamic3DTextLabelText(TableData[handle][E_TABLE_BET_LABELS][slot], 0, " ");

	GivePlayerCash(playerid, PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]);


	if(PlayerPokerData[playerid][E_PLAYER_TIMER_STARTED])
	{
		KillTimer(PlayerPokerData[playerid][E_PLAYER_TIMER_ID]);
	}
	memcpy(PlayerPokerData[playerid], PlayerPokerData[MAX_PLAYERS], 0, sizeof(PlayerPokerData[]) * 4, sizeof(PlayerPokerData[]));
	#if T_SAVE_PLAYER_POS == true
	PauseAC(playerid, 3);
	SetPlayerPos(playerid, GetPVarFloat(playerid, "t_temp_posX"), GetPVarFloat(playerid, "t_temp_posY"), GetPVarFloat(playerid, "t_temp_posZ"));
	SetPlayerFacingAngle(playerid, GetPVarFloat(playerid, "t_temp_angle"));
	#endif
	SetPVarInt(playerid, "t_is_in_table", 0);
	new Float:X, Float:Y, Float:Z;
	X = TableData[handle][E_TABLE_POS_X];
	Y = TableData[handle][E_TABLE_POS_Y];
	Z = TableData[handle][E_TABLE_POS_Z];
	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 35.0, X, Y, Z))
		{
			Streamer_Update(i);
		}
	}
	if(!Iter_Count(IT_PlayersTable<handle>))
	{
		ResetLabel(handle);
		ResetChips(handle);
	}
	return 1;
}

stock Player_CreateTextdraws(playerid)
{
	new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
	new Float:px;
	new Float:py;
	new Float:t_angle = 0.0;

	new const seats = TableData[handle][E_TABLE_TOTAL_SEATS];
	switch(seats)
	{
		case 2: t_angle = 120.0;
		case 3: t_angle = 180.0;
		case 4: t_angle = 210.0;
		case 5: t_angle = 240.0;
		case 6: t_angle = 240.0;
	}
	//Hole cards
	new const Float:angle_step = floatdiv(360.0, float(seats));
	for(new i = 0; i < TableData[handle][E_TABLE_TOTAL_SEATS]; i++)
	{
		px = (T_CARDS_RADIAL_DISTANCE * floatcos(float(i) * angle_step + t_angle, degrees)) + T_SCREEN_CENTER_X;
		py = (T_CARDS_RADIAL_DISTANCE * floatsin(float(i) * angle_step + t_angle, degrees)) + T_SCREEN_CENTER_Y + 25.0;

		PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i] = CreatePlayerTextDraw(playerid, px, py, "LD_POKE:cdback");
		PlayerTextDrawTextSize(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i], T_CARD_X_SIZE, T_CARD_Y_SIZE);
		PlayerTextDrawAlignment(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i], 2);
		PlayerTextDrawFont(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i], 4);


		PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i] = CreatePlayerTextDraw(playerid, px + T_TWO_CARD_DISTANCE, py, "LD_POKE:cdback");
		PlayerTextDrawTextSize(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i], T_CARD_X_SIZE, T_CARD_Y_SIZE);
		PlayerTextDrawAlignment(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i], 2);
		PlayerTextDrawFont(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i], 4);
	}
	//Community cards
	for(new i = 0; i < 5; i++)
	{
		px = i * T_TWO_CARD_DISTANCE + T_SCREEN_CENTER_X - 58.0;
		py = T_SCREEN_CENTER_Y + 10.0;
		PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i] = CreatePlayerTextDraw(playerid, px, py, "LD_POKE:cdback");
		PlayerTextDrawTextSize(playerid, PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i], T_CARD_X_SIZE, T_CARD_Y_SIZE);
		PlayerTextDrawAlignment(playerid, PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i], 2);
		PlayerTextDrawFont(playerid, PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i], 4);
	}

	//Buttons
	PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL] = CreatePlayerTextDraw(playerid, 290.0000, 274.0000, "Call");
	PlayerTextDrawFont(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 1);
	PlayerTextDrawLetterSize(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 2);
	PlayerTextDrawColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], -780181761);
	PlayerTextDrawSetShadow(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 0);
	PlayerTextDrawSetOutline(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 255);
	PlayerTextDrawSetProportional(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 286331306);
	PlayerTextDrawTextSize(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 25.0000, 25.0000);
	//PlayerTextDrawSetSelectable(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], 1);

	PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE] = CreatePlayerTextDraw(playerid, 320.0000, 274.0000, "Raise");
	PlayerTextDrawFont(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 1);
	PlayerTextDrawLetterSize(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 2);
	PlayerTextDrawColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], -780181761);
	PlayerTextDrawSetShadow(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 0);
	PlayerTextDrawSetOutline(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 255);
	PlayerTextDrawSetProportional(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 286331306);
	PlayerTextDrawTextSize(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 25.0000, 25.0000);
	PlayerTextDrawSetSelectable(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], 1);

	PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD] = CreatePlayerTextDraw(playerid, 350.0000, 274.0000, "Fold");
	PlayerTextDrawFont(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 1);
	PlayerTextDrawLetterSize(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 0.2500, 1.0000);
	PlayerTextDrawAlignment(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 2);
	PlayerTextDrawColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], -780181761);
	PlayerTextDrawSetShadow(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 0);
	PlayerTextDrawSetOutline(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 255);
	PlayerTextDrawSetProportional(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 286331306);
	PlayerTextDrawTextSize(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 25.0000, 25.0000);
	PlayerTextDrawSetSelectable(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD], 1);

	return 1;
}


Poker_OnPlayerConnect(playerid) {

	for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i)) continue;
        RemovePlayerAttachedObject(playerid, i);
    }
	
	return true ;
}

stock AddPlayerToTable(playerid, handle)
{
	if(!Iter_Contains(IT_Tables, handle)) return 0;
	if(GetPVarInt(playerid, "t_is_in_table")) return 0;
	new slot = Internal_GetFreeChairSlot(handle);
	if(slot == ITER_NONE)
	{
		SendPokerMessage(playerid, "There aren't currently any unnocupied seats in this table at the moment. You cannot enter it.");
		return 0;
	}

	if( GetPlayerCash ( playerid ) < TableData[handle][E_TABLE_BUY_IN]) return SendPokerMessage(playerid, "You don't have enough money to access this table. Buy In: %s", IntegerWithDelimiter(TableData[handle][E_TABLE_BUY_IN]));

	new index = Player_GetUnusedAttachIndex(playerid);
	if(index == cellmin)
	{
		SendPokerMessage(playerid, "You cannot access this table in this moment.");
		return 0;
	}
	//Reset player data
	memcpy(PlayerPokerData[playerid], PlayerPokerData[MAX_PLAYERS], 0, sizeof(PlayerPokerData[]) * 4, sizeof(PlayerPokerData[]));


	//Information to set the player's position, angle, etc..
	new Float:Pos[3];
	Pos[0] = TableData[handle][E_TABLE_SEAT_POS_X][slot];
	Pos[1] = TableData[handle][E_TABLE_SEAT_POS_Y][slot];
	Pos[2] = TableData[handle][E_TABLE_SEAT_POS_Z][slot];
	//new const Float:angle_step = floatdiv(360.0, float(TableData[handle][E_TABLE_TOTAL_SEATS]));
	//new Float:facing_angle = (TableData[handle][E_TABLE_TOTAL_SEATS] == 2)  ? (270 - angle_step * float(slot + 1)) : angle_step * float(slot + 1);
	new Float:facing_angle = atan2(TableData[handle][E_TABLE_POS_Y] - Pos[1], TableData[handle][E_TABLE_POS_X] - Pos[0]) - 90.0;


	// Forcefully syncing player.
	new Float: x, Float: y, Float: z ;

	TogglePlayerControllable(playerid, false);
	GetDynamicObjectPos ( TableData[handle][E_TABLE_CHAIR_OBJECT_IDS][slot], x, y, z ) ;
	SOLS_DestroyObject(TableData[handle][E_TABLE_CHAIR_OBJECT_IDS][slot], "Poker/AddPlayerToTable/Chair", true, .warn=false);

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, x, y, z - 5 );
	SetPlayerFacingAngle(playerid, facing_angle);

	defer Poker_ForceSyncPlayer(playerid, x, y, z, facing_angle ) ;

	SetPlayerAttachedObject(playerid, index, T_CHAIR_MODEL, 7, 0.061999, -0.046, 0.095999, 90.6, -171.8, -10.5, 1.0, 1.0, 1.0);
	SetPlayerCameraPos(playerid, TableData[handle][E_TABLE_POS_X], TableData[handle][E_TABLE_POS_Y], TableData[handle][E_TABLE_POS_Z]+T_Z_CAMERA_OFFSET);
	SetPlayerCameraLookAt(playerid, TableData[handle][E_TABLE_POS_X], TableData[handle][E_TABLE_POS_Y], TableData[handle][E_TABLE_POS_Z]);
	ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 1, 1, 0, 0, 1);

	new tstr[64];
	format(tstr, sizeof(tstr), "%s\n* waiting next game *", ReturnPlayerName(playerid));
	PlayerPokerData[playerid][E_PLAYER_3D_LABEL] = CreateDynamic3DTextLabel(tstr, 0x808080FF, Pos[0], Pos[1], Pos[2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1,  5.0);

	//Information that will be used later
	PlayerPokerData[playerid][E_PLAYER_CHAIR_ATTACH_INDEX_ID] = index;
	PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT] = slot;

	PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE] = handle;
	Player_CreateTextdraws(playerid);
	//Iterators
	Internal_AddChairSlot(handle, slot);
	Iter_Add(IT_PlayersTable<handle>, playerid);
	TableData[handle][E_TABLE_CHAIR_PLAYER_ID][slot] = playerid;
	TakePlayerCash(playerid, TableData[handle][E_TABLE_BUY_IN]);
	PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS] = TableData[handle][E_TABLE_BUY_IN];
	SendPokerMessage(playerid, "You've been charged %s as a result of joining in the table.", IntegerWithDelimiter(TableData[handle][E_TABLE_BUY_IN]));
	//Allow players to join a table where a game has already started but there are empty seats remaining (these players will be able to play once the current match finishes)
	if(TableData[handle][E_TABLE_CURRENT_STATE] != STATE_BEGIN)
	{
		if(Iter_Count(IT_PlayersTable<handle>) == 2 && !TableData[handle][E_TABLE_LOADING_GAME]) //Minimum two seats
		{
			if(!TableData[handle][E_TABLE_STING_NEW_GAME])
			{
				SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}There are currently two players in the table.");
				SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Any players interested in being part of this game have "#T_START_DELAY" seconds to join the table.");
				SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}The game will begin in "#T_START_DELAY" seconds...");
				Iter_Clear(IT_PlayersInGame<handle>);
				TableData[handle][E_TABLE_LOADING_GAME] = true;
				SetTimerEx("Poker_StartGame", T_START_DELAY * 1000, false, "ii", handle, INVALID_PLAYER_ID);
			}
		}
	}
	else
	{
		SendPokerMessage(playerid, "You have entered this poker table but the game has already begun.");
		SendPokerMessage(playerid, "You must wait until this match is finished to play!");
		SendTableMessage(handle, "{25728B}- - Player %s has joined the table... - -", ReturnPlayerName(playerid));
	}

	SendClientMessage(playerid, COLOR_BLUE, "[POKER WARNING]{DEDEDE} This script is {F4C100}EXPERIMENTAL{DEDEDE}! Bugs will be found!");

	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 35.0, Pos[0], Pos[1], Pos[2]))
		{
			Streamer_Update(i);
		}
	}

	#if T_SAVE_PLAYER_POS == true

	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	SetPVarFloat(playerid, "t_temp_posX", Pos[0]);
	SetPVarFloat(playerid, "t_temp_posY", Pos[1]);
	SetPVarFloat(playerid, "t_temp_posZ", Pos[2]);
	GetPlayerFacingAngle(playerid, Pos[0]);
	SetPVarFloat(playerid, "t_temp_angle", Pos[0]);
	#endif

	SetPVarInt(playerid, "t_is_in_table", 1);
	return 1;
}

timer Poker_ForceSyncPlayer[750](playerid, Float: x, Float: y, Float: z, Float: angle ) {

	PauseAC(playerid, 3);
	SetPlayerPos ( playerid, x, y, z ) ;
	SetPlayerFacingAngle(playerid, angle ) ;
	ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 1, 1, 0, 0, 1);
}

stock SendTableMessage(handle, const format[], va_args<>)
{
	new sstr[164];
	va_format(sstr, sizeof (sstr), format, va_start<2>);
	//strins(sstr, "{cc8e35}-|- {739e82} ", 0);
	foreach(new playerid: IT_PlayersTable<handle>)
	{
		SendClientMessage(playerid, -1, sstr);
		// printf( "[poker_%d] %s", handle, sstr);
	}
	return 1;
}

public Poker_StartGame(handle, dealer)
{
	TableData[handle][E_TABLE_STING_NEW_GAME] = false;
	if(Iter_Count(IT_PlayersTable<handle>) < 2)
	{
		TableData[handle][E_TABLE_LOADING_GAME] = false;
		return 0;
	}
	foreach(new i: Player)
	{
		if(!Iter_Contains(IT_PlayersTable<handle>, i)) continue;
		if(!PlayerPokerData[i][E_PLAYER_TOTAL_CHIPS])
		{
			SendPokerMessage(i, "You don't have any chips left.");
			SendPokerMessage(i, "You may join the table again and pay the buy-in fee to play once again!");
			SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been kicked out of the table. [Reason: Ran out of chips]", ReturnPlayerName(i));
			KickPlayerFromTable(i);
			Dialog_Hide(i);
		}
	}

	if(Iter_Count(IT_PlayersTable<handle>) < 2)
	{
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}There aren't enough players to start a game");
		TableData[handle][E_TABLE_LOADING_GAME] = false;
		return 0;
	}
	for (new i = 0; i < 5; i ++) {
		TableData[handle][E_TABLE_COM_CARDS_VALUES][i] = ITER_NONE;
	}
	TableData[handle][E_TABLE_LOADING_GAME] = true;
	//Add these two players to (currently playing iterator)
	Iter_Clear(IT_PlayersInGame<handle>);
	Iter_Clear(IT_PlayersAllIn<handle>);
	foreach(new i: IT_PlayersTable<handle>)
	{
		Iter_Add(IT_PlayersInGame<handle>, i);
		PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
		PlayerPokerData[i][E_PLAYER_IS_PLAYING] = true;
		ApplyAnimation(i, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 1, 1, 0, 0, 1);

	}
	TableData[handle][E_TABLE_CURRENT_STATE] = STATE_BEGIN; //Will prevent players from leaving the table

	foreach(new playerid: IT_PlayersInGame<handle>)
	{
		for(new i = 0; i < TableData[handle][E_TABLE_TOTAL_SEATS]; i++)
		{
			PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i], "LD_POKE:cdback");
			PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i], "LD_POKE:cdback");
			PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i]);
			PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i]);
		}
		for(new i = 0; i < 5; i++){
			PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_COMMUNITY_CARDS_TXT][i]);
		}
		for(new i = 0; i < 3; i++){
			PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][i]);
		}

		HideMinigameHelpBox ( playerid );
	}

	TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT] = 0;

	dealer = GetTurnAfterDealer(handle);
	//Select BB, SB in terms of a random dealer
	dealer = (dealer == INVALID_PLAYER_ID) ? Iter_Random(IT_PlayersInGame<handle>) : dealer;

	new count = Iter_Count(IT_PlayersInGame<handle>);
	if(count < 2)
	{
		return -1;
	}
	else if(count == 2)
	{
		TableData[handle][E_TABLE_PLAYER_DEALER_ID] = dealer;
		TableData[handle][E_TABLE_DEALER_SEAT] = PlayerPokerData[dealer][E_PLAYER_CURRENT_CHAIR_SLOT];
		TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID] = dealer;
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been chosen to be the dealer and big blind in this first stage of the game!", ReturnPlayerName(dealer));
		UpdateDynamic3DTextLabelTextEx(PlayerPokerData[dealer][E_PLAYER_3D_LABEL], -1, "{7AC72E}%s\n{FD4102}Big Blind + Dealer", ReturnPlayerName(dealer));

		//small blind..
		new next_turn = GetTurnAfterPlayer(handle, dealer);
		UpdateDynamic3DTextLabelTextEx(PlayerPokerData[next_turn][E_PLAYER_3D_LABEL], -1, "{7AC72E}%s\n{FD4102}Small Blind", ReturnPlayerName(next_turn));
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been chosen to be the small blind in this first stage of the game!", ReturnPlayerName(next_turn));
		TableData[handle][E_TABLE_PLAYER_SMALL_BLIND_ID] = next_turn;


	}
	else
	{

		//Dealer
		UpdateDynamic3DTextLabelTextEx(PlayerPokerData[dealer][E_PLAYER_3D_LABEL], -1, "{7AC72E}%s\n{FD4102}Dealer", ReturnPlayerName(dealer));
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been chosen to be the dealer in this first stage of the game!", ReturnPlayerName(dealer));
		TableData[handle][E_TABLE_PLAYER_DEALER_ID] = dealer;
		TableData[handle][E_TABLE_DEALER_SEAT] = PlayerPokerData[dealer][E_PLAYER_CURRENT_CHAIR_SLOT];

		//Big blind
		new next_player = GetTurnAfterPlayer(handle, dealer);
		UpdateDynamic3DTextLabelTextEx(PlayerPokerData[next_player][E_PLAYER_3D_LABEL], -1, "{7AC72E}%s\n{FD4102}Small Blind", ReturnPlayerName(next_player));
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been chosen to be the Small Blind in this first stage of the game!", ReturnPlayerName(next_player));
		TableData[handle][E_TABLE_PLAYER_SMALL_BLIND_ID] = next_player;

		//Small blind
		next_player = GetTurnAfterPlayer(handle, next_player);
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been chosen to be the Big Blind in this first stage of the game!", ReturnPlayerName(next_player));
		UpdateDynamic3DTextLabelTextEx(PlayerPokerData[next_player][E_PLAYER_3D_LABEL], -1, "{7AC72E}%s\n{FD4102}Big Blind", ReturnPlayerName(next_player));
		TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID] = next_player;
	}

	new string [ 512 ] ;

	foreach(new playerid: IT_PlayersInGame<handle>) //loop through the players already in the table
	{
		if(playerid != TableData[handle][E_TABLE_PLAYER_DEALER_ID] && playerid != TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID] && playerid != TableData[handle][E_TABLE_PLAYER_SMALL_BLIND_ID])
		{
			UpdateDynamic3DTextLabelTextEx(PlayerPokerData[playerid][E_PLAYER_3D_LABEL], 0x7AC72EFF, "%s", ReturnPlayerName(playerid));
		}

		//#warning POKER: Add minigame box update here! (see UpdateInfoTextdrawsForPlayer)

		format ( string, sizeof ( string ), "~g~Chips:_~w~%s~n~~y~Pot:_~w~%s~n~~r~Last_bet:_~w~%s~n~~r~Your_bet:_~w~%s",
			IntegerWithDelimiter(PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]),
			IntegerWithDelimiter(TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT]),
			IntegerWithDelimiter(TableData[handle][E_TABLE_LAST_BET]),
			IntegerWithDelimiter(PlayerPokerData[playerid][E_PLAYER_CURRENT_BET])
		) ;

		UpdateMinigameHelpBox(playerid, "Texas Hold'em Poker", string, .show = true  ) ;

		Streamer_Update(playerid);
	}

	SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Dealer is shuffling the pack of cards. Cards will be handed out in two seconds...!");
	//If everything executes without stop, it wouldn't look that nice for me, so a timer comes handy..
	SetTimerEx("Poker_DealCards", 2000, false, "i", handle);
	return 1;
}

forward Poker_SyncPosition(handle, Float: pos_x, Float: pos_y, Float: pos_z ) ;
public Poker_SyncPosition(handle,  Float: pos_x, Float: pos_y, Float: pos_z )  {

	foreach(new playerid: IT_PlayersTable<handle>) //loop through the players already in the table
	{
		if(Iter_Contains(IT_PlayersInGame<handle>, playerid))
		{
			PauseAC(playerid, 3);
			SetPlayerPos(playerid, pos_x, pos_y, pos_z );
			SendClientMessage(playerid, -1, "Tried syncing your position." ) ;
		}
	}
	return true ;
}

forward Poker_KickPlayers(handle);
public Poker_KickPlayers(handle)
{
	foreach(new i: Player)
	{
		if(!Iter_Contains(IT_PlayersTable<handle>, i)) continue;
		if(!PlayerPokerData[i][E_PLAYER_TOTAL_CHIPS])
		{
			if( GetPlayerCash ( i ) < TableData[handle][E_TABLE_BUY_IN])
			{
				SendPokerMessage(i, "You don't have any chips left.");
				SendPokerMessage(i, "You may join the table again and pay the buy-in fee to play once again!");
				SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Player %s has been kicked out of the table. [Reason: Ran out of chips]", ReturnPlayerName(i));
				KickPlayerFromTable(i);
			}
			else
			{
				inline Poker_DialogBuyIn(pid, dialogid, response, listitem, string:inputtext[]) {
					#pragma unused pid, dialogid, inputtext, listitem

					new handle_ex = PlayerPokerData[i][E_PLAYER_CURRENT_HANDLE];
					if(!IsValidTable(handle_ex)) return 1;
					if(!Iter_Contains(IT_PlayersTable<handle_ex>, i)) return 1;
					if(response)
					{
						TakePlayerCash(i, TableData[handle_ex][E_TABLE_BUY_IN]);
						PlayerPokerData[i][E_PLAYER_TOTAL_CHIPS] = TableData[handle_ex][E_TABLE_BUY_IN];
						SendTableMessage(handle_ex, "{C0C0C0}-- {FFFFFF}Player %s has paid the buy-in fee of %s chips to keep playing.", ReturnPlayerName(i), IntegerWithDelimiter(TableData[handle_ex][E_TABLE_BUY_IN]));
					}
					else
					{
						SendTableMessage(handle_ex, "{C0C0C0}-- {FFFFFF}Player %s has been kicked out of the table. [Reason: Failure to pay the buy-in fee]", ReturnPlayerName(i));
						KickPlayerFromTable(i);
					}
				}

   				Dialog_ShowCallback ( i, using inline Poker_DialogBuyIn, DIALOG_STYLE_MSGBOX, "Buy_In", "{FFFFFF}You've ran out of chips. Do you want to pay the buy-in fee again to continue playing?", "Yes", "No" );
			}
		}
	}
	//Iter_Clear(IT_PlayersInGame<handle>);
	return 1;
}

stock StartNewPokerGame(handle, time)
{
	for (new i = 0; i < 5; i ++) {
		TableData[handle][E_TABLE_COM_CARDS_VALUES][i] = ITER_NONE;
	}

	foreach(new i: IT_PlayersInGame<handle>) {
		HidePlayerChoices(i);
	}

	//This will allow players to leave before the new game begins.
	TableData[handle][E_TABLE_CURRENT_STATE] = STATE_IDLE;
	TableData[handle][E_TABLE_STING_NEW_GAME] = true;

	TableData[handle][E_TABLE_FIRST_TURN] = INVALID_PLAYER_ID;
	TableData[handle][E_TABLE_CHECK_FIRST]  = false;
	TableData[handle][E_TABLE_CURRENT_TURN] = INVALID_PLAYER_ID;
	TableData[handle][E_TABLE_LOADING_GAME] = false;
	ResetLabel(handle);

	Iter_Clear(IT_TableCardSet[handle]);

	for(new i = 0; i < 52; i++)
		Iter_Add(IT_TableCardSet[handle], i);

	//Never change this order
	Iter_Clear(IT_PlayersAllIn<handle>);
	Iter_Clear(IT_Sidepots[handle]);

	SetTimerEx("Poker_KickPlayers", 1000 * (time - 5), false, "i", handle);

	for(new i = 0; i < T_MAX_CHAIRS_PER_TABLE; i++)
	{
		TableData[handle][E_TABLE_POT_CHIPS][i] = 0;
		Iter_Clear(It_SidepotMembers[_IT[handle][i]]);
	}
	Iter_Clear(IT_PlayersInGame<handle>);

	if(Iter_Count(IT_PlayersTable<handle>) >= 2)
	{
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}Starting a new game in %d seconds...", time);
		SetTimerEx("Poker_StartGame", 1000 * time, false, "ii", handle, INVALID_PLAYER_ID);
	}
	else
	{
		SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}There are not enough players to start a new game!");
	}
	return 1;
}

stock GetTurnAfterSeat(handle, seat)
{
	seat -= 1;
	new target = INVALID_PLAYER_ID;
	for(new i = 0, j = TableData[handle][E_TABLE_TOTAL_SEATS]; i < j; i++)
	{
		if(seat < 0) seat = TableData[handle][E_TABLE_TOTAL_SEATS] - 1;
		target = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][seat];
		if(Iter_Contains(IT_PlayersInGame<handle>, target) && !Iter_Contains(IT_PlayersAllIn<handle>, target))
		{
			break;
		}
		seat--;
	}
	if(seat < 0 || seat >= T_MAX_CHAIRS_PER_TABLE) return INVALID_PLAYER_ID;
	return target;
}

stock GetTurnAfterDealer(handle)
{
	new seat = TableData[handle][E_TABLE_DEALER_SEAT];
	new target = GetTurnAfterSeat(handle, seat);
	if(target == INVALID_PLAYER_ID)
	{
		printf("Something went wrong while executing GetTurnAfterPlayer");
		return -1;
	}
	return target;
}


stock GetTurnAfterPlayer(handle, playerid)
{
	/*Finds the ID of the player to the left of 'playerid', skips players not currently playing or empty seats.
		The number of iterations it performs is the number of seats in between both players
		Worst case would be the number of seats O(n), n = number of seats, O(1) would be the best case (players next to each other)
	*/
	new slot = PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT] - 1;
	if(slot < 0) slot = TableData[handle][E_TABLE_TOTAL_SEATS] - 1;
	for(new i = 0, j = TableData[handle][E_TABLE_TOTAL_SEATS]; i < j; i++)
	{
		if(slot < 0) slot = TableData[handle][E_TABLE_TOTAL_SEATS] - 1;
		new const target = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][slot];
		if(Iter_Contains(IT_PlayersInGame<handle>, target) && !Iter_Contains(IT_PlayersAllIn<handle>, target))
		{
			break;
		}
		slot--;
	}
	if(slot < 0 || slot >= T_MAX_CHAIRS_PER_TABLE) return INVALID_PLAYER_ID;
	new target = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][slot];
	if(!Iter_Contains(IT_PlayersInGame<handle>, target)) return INVALID_PLAYER_ID;
	new next_player = INVALID_PLAYER_ID;
	next_player = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][slot];
	return next_player;
}
stock GetTurnAfterPlayerEx(handle, playerid)
{
	/*Finds the ID of the player to the left of 'playerid', skips players not currently playing or empty seats.
		The number of iterations it performs is the number of seats in between both players
		Worst case would be the number of seats O(n), n = number of seats, O(1) would be the best case (players next to each other)
	*/
	new slot = PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT] - 1;
	if(slot < 0) slot = TableData[handle][E_TABLE_TOTAL_SEATS] - 1;
	for(new i = 0, j = TableData[handle][E_TABLE_TOTAL_SEATS]; i < j; i++)
	{
		if(slot < 0) slot = TableData[handle][E_TABLE_TOTAL_SEATS] - 1;
		new const target = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][slot];
		if(Iter_Contains(IT_PlayersInGame<handle>, target))
		{
			break;
		}
		slot--;
	}
	new next_player = INVALID_PLAYER_ID;
	next_player = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][slot];
	return next_player;
}
stock Internal_GetFreeChairSlot(handle)
{
	//This goes in reverse (left)
	new seats = TableData[handle][E_TABLE_TOTAL_SEATS];
	for(new i = seats; i--; )
	{
		if(!TableData[handle][E_TABLE_IS_SEAT_TAKEN][i])
		{
			return i;
		}
	}
	return ITER_NONE;
}
stock Internal_AddChairSlot(handle, slot)
{
	TableData[handle][E_TABLE_IS_SEAT_TAKEN][slot] = true;
	return 1;
}
stock Internal_RemoveChairSlot(handle, slot)
{
	TableData[handle][E_TABLE_IS_SEAT_TAKEN][slot] = false;
	return 1;
}

stock RemoveChipsFromPlayer( forplayer, amount)
{
	PlayerPokerData[forplayer][E_PLAYER_TOTAL_CHIPS] -= amount;
	return 1;
}

stock AbortGame(handle)
{
	if(TableData[handle][E_TABLE_CURRENT_STATE] != STATE_BEGIN) return 0;
	//Could have used Iter_SafeRemove, prefer not to
	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
		if(Iter_Contains(IT_PlayersTable<handle>, playerid))
		{
			KickPlayerFromTable(playerid);
		}
		CancelSelectTextDraw(playerid);
	}

	for(new i = 0; i < 5; i++)
	{
		TableData[handle][E_TABLE_COM_CARDS_VALUES][i] = ITER_NONE;
	}
	//This will allow players to leave before the new game begins.
	TableData[handle][E_TABLE_CURRENT_STATE] = STATE_IDLE;
	TableData[handle][E_TABLE_STING_NEW_GAME] = false;

	TableData[handle][E_TABLE_FIRST_TURN] = INVALID_PLAYER_ID;
	TableData[handle][E_TABLE_CHECK_FIRST]  = false;
	TableData[handle][E_TABLE_LOADING_GAME] = false;
	ResetLabel(handle);
	Iter_Clear(IT_TableCardSet[handle]);
	//Never change this order
	Iter_Clear(IT_PlayersAllIn<handle>);
	Iter_Clear(IT_Sidepots[handle]);

	for(new i = 0; i < T_MAX_CHAIRS_PER_TABLE; i++)
	{
		TableData[handle][E_TABLE_POT_CHIPS][i] = 0;
		Iter_Clear(It_SidepotMembers[_IT[handle][i]]);
	}

	for(new i = 0; i < 52; i++)
		Iter_Add(IT_TableCardSet[handle], i);

	TableData[handle][E_TABLE_CURRENT_STATE] = STATE_IDLE;
	return 1;
}

forward Poker_DealCards(handle);
public Poker_DealCards(handle)
{
	foreach(new playerid: IT_PlayersTable<handle>) //loop through the players already in the table
	{
		if(Iter_Contains(IT_PlayersInGame<handle>, playerid))
		{
			new seat = TableRotCorrections[TableData[PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE]][E_TABLE_TOTAL_SEATS]][ PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT]];
			new card1 = Iter_Random(IT_TableCardSet[handle]);
			Iter_Remove(IT_TableCardSet[handle], card1);


			new card2 = Iter_Random(IT_TableCardSet[handle]);
			Iter_Remove(IT_TableCardSet[handle], card2);

			PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][seat], CardData[card1][E_CARD_TEXTDRAW]);
			PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][seat], CardData[card2][E_CARD_TEXTDRAW]);
			PlayerPokerData[playerid][E_PLAYER_CARD_VALUES][0] = card1;
			PlayerPokerData[playerid][E_PLAYER_CARD_VALUES][1] = card2;

			foreach(new p: IT_PlayersInGame<handle>)
			{
				seat = TableRotCorrections[TableData[PlayerPokerData[p][E_PLAYER_CURRENT_HANDLE]][E_TABLE_TOTAL_SEATS]][ PlayerPokerData[p][E_PLAYER_CURRENT_CHAIR_SLOT]];
				PlayerTextDrawShow(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][seat]);
				PlayerTextDrawShow(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][seat]);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0 );
			}

			PlayerPokerData[playerid][E_PLAYER_CURRENT_BET] = 0;
		}
		else
		{
			for(new i = 0; i < TableData[handle][E_TABLE_TOTAL_SEATS]; i++)
			{
				PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i], "LD_POKE:cdback");
				PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i], "LD_POKE:cdback");
				PlayerTextDrawShow(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_1][i]);
				PlayerTextDrawShow(playerid, PlayerPokerData[playerid][E_PLAYER_CARDS_TXT_2][i]);
			}
		}

	}
	//Set variables

	TableData[handle][E_TABLE_CURRENT_ROUND] = ROUND_PRE_FLOP;




	new big_blind = TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID];
	new small_blind = TableData[handle][E_TABLE_PLAYER_SMALL_BLIND_ID];

	new bool: b_big_blind = (PlayerPokerData[big_blind][E_PLAYER_TOTAL_CHIPS] > TableData[handle][E_TABLE_BIG_BLIND]);
	new bool: b_small_blind = (PlayerPokerData[small_blind][E_PLAYER_TOTAL_CHIPS] > TableData[handle][E_TABLE_SMALL_BLIND]);
	if(b_big_blind && b_small_blind)
	{
		PlayerPokerData[big_blind][E_PLAYER_CURRENT_BET] = TableData[handle][E_TABLE_BIG_BLIND];
		PlayerPokerData[small_blind][E_PLAYER_CURRENT_BET] = TableData[handle][E_TABLE_SMALL_BLIND];
		SendTableMessage(handle, "{2DD9A9} * * %s posts a small blind of %s.. * *", ReturnPlayerName(TableData[handle][E_TABLE_PLAYER_SMALL_BLIND_ID]), IntegerWithDelimiter(TableData[handle][E_TABLE_SMALL_BLIND]));
		SendTableMessage(handle, "{2DD9A9}  * * %s posts a big blind of %s.. * *", ReturnPlayerName(TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID]), IntegerWithDelimiter(TableData[handle][E_TABLE_BIG_BLIND]));
		new next_turn = GetTurnAfterPlayer(handle, TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID]);
		TableData[handle][E_TABLE_LAST_BET] = TableData[handle][E_TABLE_BIG_BLIND];
		SetLastToRaise(handle, next_turn);
		RemoveChipsFromPlayer( big_blind, TableData[handle][E_TABLE_BIG_BLIND]);
		RemoveChipsFromPlayer( small_blind, TableData[handle][E_TABLE_SMALL_BLIND]);
		TableData[handle][E_TABLE_FIRST_TURN] = next_turn;
		TableData[handle][E_TABLE_CHECK_FIRST] = true;
		SendTurnMessage(handle, next_turn);

		UpdateTable(handle);
	}
	else
	{
		new next_turn = GetTurnAfterPlayer(handle, TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID]);
		SetLastToRaise(handle, next_turn);
		if(!b_small_blind)
		{

			ForcePlayerAllIn(small_blind, handle, false);
		}
		else
		{
			SendTableMessage(handle, "{2DD9A9} * * %s posts a small blind of %s.. * *", ReturnPlayerName(TableData[handle][E_TABLE_PLAYER_SMALL_BLIND_ID]), IntegerWithDelimiter(TableData[handle][E_TABLE_SMALL_BLIND]));
			RemoveChipsFromPlayer( small_blind, TableData[handle][E_TABLE_SMALL_BLIND]);
			PlayerPokerData[small_blind][E_PLAYER_CURRENT_BET] = TableData[handle][E_TABLE_SMALL_BLIND];
		}

		if(!b_big_blind)
		{
			TableData[handle][E_TABLE_LAST_TO_RAISE] = big_blind;
			TableData[handle][E_TABLE_LAST_BET] = PlayerPokerData[big_blind][E_PLAYER_TOTAL_CHIPS];
			ForcePlayerAllIn(big_blind, handle, false);

			if(!b_small_blind && GetTurnAfterPlayerEx(handle, next_turn) == small_blind)
			{
				SetLastToRaise(handle, small_blind);
			}
		}
		else
		{

			SendTableMessage(handle, "{2DD9A9}  * * %s posts a big blind of %s.. * *", ReturnPlayerName(TableData[handle][E_TABLE_PLAYER_BIG_BLIND_ID]), IntegerWithDelimiter(TableData[handle][E_TABLE_BIG_BLIND]));
			RemoveChipsFromPlayer( big_blind, TableData[handle][E_TABLE_BIG_BLIND]);
			PlayerPokerData[big_blind][E_PLAYER_CURRENT_BET] = TableData[handle][E_TABLE_BIG_BLIND];
			TableData[handle][E_TABLE_LAST_BET] = TableData[handle][E_TABLE_BIG_BLIND];
		}

		if(Iter_Contains(IT_PlayersAllIn<handle>, next_turn))
		{
			CheckPotAndNextTurn(next_turn, handle);
		}
		else
		{
			SendTurnMessage(handle, next_turn);
		}
		UpdateTable(handle);

	}

	return 1;
}



static stock UpdateTable(handle)
{
	new string [ 512 ] ;

	foreach(new playerid: IT_PlayersInGame<handle>)
	{
		//#warning POKER: Add minigame box update here! (see UpdateInfoTextdrawsForPlayer)
		format ( string, sizeof ( string ), "~g~Chips:_~w~%s~n~~y~Pot:_~w~%s~n~~r~Last_bet:_~w~%s~n~~r~Your_bet:_~w~%s",
			IntegerWithDelimiter(PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]),
			IntegerWithDelimiter(TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT]),
			IntegerWithDelimiter(TableData[handle][E_TABLE_LAST_BET]),
			IntegerWithDelimiter(PlayerPokerData[playerid][E_PLAYER_CURRENT_BET])
		) ;

		UpdateMinigameHelpBox(playerid, "Texas Hold'em Poker", string, .show = true ) ;

		new const seat = PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT];
		string[0]=EOS;
		format(string, sizeof(string), "{34c5db}Chips: {db8d34}%s\n{db3a34}Last bet: {db8d34}%s", IntegerWithDelimiter(PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]), IntegerWithDelimiter(PlayerPokerData[playerid][E_PLAYER_CURRENT_BET]));
		UpdateDynamic3DTextLabelText(TableData[handle][E_TABLE_BET_LABELS][seat], T_BET_LABEL_COLOR, string);
		SetChipsValue(handle, PlayerPokerData[playerid][E_PLAYER_CURRENT_CHAIR_SLOT], PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]);

	}
	new tmp[10];
	string[0]=EOS;
	format(string, sizeof(string), "{59cdff}Main Pot: {ff9059}%s\n", IntegerWithDelimiter(TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT]));
	SetPotChipsValue(handle, TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT]);
	if(Iter_Count(IT_Sidepots[handle] > 1))
	{
		strcat(string, "{008000}Side Pot:\n{008080}");
		foreach(new i: IT_Sidepots[handle])
		{
			if(i == MAIN_POT) continue;
			format(tmp, sizeof(tmp), "%s\n", IntegerWithDelimiter(TableData[handle][E_TABLE_POT_CHIPS][i]));
			strcat(string, tmp);
		}
	}
	string[strlen(string)-1] = EOS;
	UpdateDynamic3DTextLabelText(TableData[handle][E_TABLE_POT_LABEL], T_BET_LABEL_COLOR, string);

	return 1;
}
static stock ShowChoicesToPlayer(playerid)
{
	new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
	//Call or check
	if(TableData[handle][E_TABLE_LAST_BET] == PlayerPokerData[playerid][E_PLAYER_CURRENT_BET]) //check
	{
		PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], "Check");
	}
	else //call
	{
		PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], "Call");
	}

	//Bet, raise or all in
	if(TableData[handle][E_TABLE_LAST_BET] == 0)
	{
		PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], "Bet");
		PlayerPokerData[playerid][E_PLAYER_RCHOICE] = E_RAISE_BET;
	}
	else if(PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS] > TableData[handle][E_TABLE_LAST_BET] + PlayerPokerData[playerid][E_PLAYER_CURRENT_BET])
	{
		PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], "Raise");
		PlayerPokerData[playerid][E_PLAYER_RCHOICE] = E_RAISE_RAISE;
	}
	else //player doesn't have enough money, only option is to go all in
	{
		PlayerTextDrawSetString(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE], "All In");
		PlayerPokerData[playerid][E_PLAYER_RCHOICE] = E_RAISE_ALL_IN;
	}

	if(PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS] + PlayerPokerData[playerid][E_PLAYER_CURRENT_BET] <= TableData[handle][E_TABLE_LAST_BET])
	{
		//all in and fold are the only options available
		PlayerTextDrawSetSelectable(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], false);
		PlayerTextDrawColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], COLOR_RED);
	}
	else
	{
		PlayerTextDrawSetSelectable(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], true);
		PlayerTextDrawColor(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL], -1);
	}
	for(new i = 0; i < 3; i++)
	{
		PlayerTextDrawShow(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][i]);
	}


	SelectTextDraw(playerid, 0x00FF00FF);
	return 1;
}

static stock HidePlayerChoices(playerid)
{
	for(new i = 0; i < 3; i++)
	{
		PlayerTextDrawHide(playerid, PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][i]);
	}
    CancelSelectTextDraw(playerid);
	return 1;
}

static stock SendTurnMessage(handle, playerid)
{
	SetPlayerClickedTxt(playerid, false);
	SendTableMessage(handle, "{008080}It's %s{008080}'s turn...", ReturnPlayerName(playerid));
	SendPokerMessage(playerid, "It's your turn. You have "#T_MAX_WAIT_TIME" seconds to make a decision.");
	TableData[handle][E_TABLE_CURRENT_TURN] = playerid;
	PlayerPokerData[playerid][E_PLAYER_TIMER_STARTED] = true;
	PlayerPokerData[playerid][E_PLAYER_TIMER_ID] = SetTimerEx("Timer_FoldPlayer", T_MAX_WAIT_TIME * 1000, false, "ii", handle, playerid);
	ShowChoicesToPlayer(playerid);
	return 1;
}

stock KillPlayerTurnTimer(playerid, bool: callback = false)
{
	new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
	if(!IsValidTable(handle))
	{
		//T_SendWarning("[KillPlayerTurnTimer] Invalid handle passed (%d) for playerid: %d", handle, playerid);
		return 0;
	}
	if(!Iter_Contains(IT_PlayersInGame<handle>, playerid))
	{
		//T_SendWarning("[KillPlayerTurnTimer] Invalid playerid passed: %d, handle: %d, player is not in the game.", playerid, handle);
		return 0;
	}
	if(!PlayerPokerData[playerid][E_PLAYER_TIMER_STARTED]) return 0;

	PlayerPokerData[playerid][E_PLAYER_TIMER_STARTED] = false;
	if(!callback)
		KillTimer(PlayerPokerData[playerid][E_PLAYER_TIMER_ID]);

	return 1;
}
forward Timer_FoldPlayer(handle, playerid);
public Timer_FoldPlayer(handle, playerid)
{
	if(TableData[handle][E_TABLE_CURRENT_TURN] == playerid && PlayerPokerData[playerid][E_PLAYER_TIMER_STARTED])
	{
		TableData[handle][E_TABLE_CURRENT_TURN] = INVALID_PLAYER_ID;
		HidePlayerChoices(playerid);
		Dialog_Hide(playerid);
		KillPlayerTurnTimer(playerid, true);
		if(!FoldPlayer(handle, playerid))
			CheckPotAndNextTurn(playerid, handle);
	}
	return 1;
}
/*

	GetTurnAfterPlayer(handle, playerid); //Returns the playerid of the next turn (skips players that have gone all in)
	GetTurnAfterPlayerEx(handle, playerid); //Returns the playerid of the next turn (does not skip players that went all in)
*/

forward CheckRounds(handle, bool: start_showdown);
public CheckRounds(handle, bool: start_showdown)
{
	new next_turn = INVALID_PLAYER_ID;
	//we can proceed to another round
	switch(TableData[handle][E_TABLE_CURRENT_ROUND])
	{
		case ROUND_PRE_FLOP:
		{
			//Display 3 cards now
			TableData[handle][E_TABLE_CURRENT_ROUND] = ROUND_FLOP;
			for(new i = 0; i < 3; i++)
			{
				new card = Iter_Random(IT_TableCardSet[handle]);
				Iter_Remove(IT_TableCardSet[handle], card);
				TableData[handle][E_TABLE_COM_CARDS_VALUES][i] = card;
				foreach(new k:  IT_PlayersTable<handle>)
				{
					//for(new j = 0; j < 15; j++) SendTableMessage(k, " ");

					PlayerTextDrawSetString(k, PlayerPokerData[k][E_PLAYER_COMMUNITY_CARDS_TXT][i], CardData[card][E_CARD_TEXTDRAW]);
					PlayerTextDrawShow(k, PlayerPokerData[k][E_PLAYER_COMMUNITY_CARDS_TXT][i]);
					PlayerPokerData[k][E_PLAYER_CURRENT_BET] = 0;
					PlayerPlaySound(k, 1145, 0.0, 0.0, 0.0 );
				}
			}

			SendTableMessage(handle, "{D07035} {[ The Flop ]}");
			TableData[handle][E_TABLE_LAST_BET] = 0;

			if(start_showdown)
			{
				SetTimerEx("CheckRounds", 2000, false, "ib", handle, true);
			}
			else
			{
				//Player next to the dealer
				next_turn = GetTurnAfterDealer(handle);
				SetLastToRaise(handle, next_turn);
				//player next to the dealer is the next turn
				SendTurnMessage(handle, next_turn);
			}



		}
		case ROUND_FLOP:
		{
			//Display 1 card
			TableData[handle][E_TABLE_CURRENT_ROUND] = ROUND_TURN;
			new card = Iter_Random(IT_TableCardSet[handle]);
			Iter_Remove(IT_TableCardSet[handle], card);
			TableData[handle][E_TABLE_COM_CARDS_VALUES][3] = card;
			foreach(new k:  IT_PlayersTable<handle>)
			{
				//for(new j = 0; j < 15; j++) SendTableMessage(k, " ");

				PlayerPokerData[k][E_PLAYER_CURRENT_BET] = 0;
				PlayerTextDrawSetString(k, PlayerPokerData[k][E_PLAYER_COMMUNITY_CARDS_TXT][3], CardData[card][E_CARD_TEXTDRAW]);
				PlayerTextDrawShow(k, PlayerPokerData[k][E_PLAYER_COMMUNITY_CARDS_TXT][3]);
				PlayerPlaySound(k, 1145, 0.0, 0.0, 0.0 );
			}
			TableData[handle][E_TABLE_LAST_BET] = 0;

			SendTableMessage(handle, "{D07035} {[ The Turn ]}");


			if(start_showdown)
			{
				SetTimerEx("CheckRounds", 2000, false, "ib", handle, true);
			}
			else
			{
				//Player next to the dealer
				next_turn = GetTurnAfterDealer(handle);
				SetLastToRaise(handle, next_turn);
				//player next to the dealer is the next turn
				SendTurnMessage(handle, next_turn);
			}

		}
		case ROUND_TURN:
		{
			//Display 1 more card
			TableData[handle][E_TABLE_CURRENT_ROUND] = ROUND_RIVER;
			new card = Iter_Random(IT_TableCardSet[handle]);
			Iter_Remove(IT_TableCardSet[handle], card);
			TableData[handle][E_TABLE_COM_CARDS_VALUES][4] = card;
			foreach(new k:  IT_PlayersTable<handle>)
			{
				//for(new j = 0; j < 15; j++) SendTableMessage(k, " ");
				PlayerPokerData[k][E_PLAYER_CURRENT_BET] = 0;
				PlayerTextDrawSetString(k, PlayerPokerData[k][E_PLAYER_COMMUNITY_CARDS_TXT][4], CardData[card][E_CARD_TEXTDRAW]);
				PlayerTextDrawShow(k, PlayerPokerData[k][E_PLAYER_COMMUNITY_CARDS_TXT][4]);
				PlayerPlaySound(k, 1145, 0.0, 0.0, 0.0 );
			}
			TableData[handle][E_TABLE_LAST_BET] = 0;

			SendTableMessage(handle, "{D07035} {[ The River ]} ");
			//SendTableMessage(handle, "{C0C0C0}-- {FFFFFF}%s, %s, %s", CardData[TableData[handle][T_COM_CARDS_VALUES][0]][E_CARD_NAME], CardData[TableData[handle][T_COM_CARDS_VALUES][1]][E_CARD_NAME], CardData[TableData[handle][T_COM_CARDS_VALUES][2]][E_CARD_NAME]);
			if(start_showdown)
			{
				SetTimerEx("CheckRounds", 2000, false, "ib", handle, false);
			}
			else
			{
				//Player next to the dealer
				next_turn = GetTurnAfterDealer(handle);
				SetLastToRaise(handle, next_turn);
				//player next to the dealer is the next turn
				SendTurnMessage(handle, next_turn);
			}
		}
		case ROUND_RIVER:
		{
			CheckShowdown(handle);
			//Start a new game
			StartNewPokerGame(handle, 8);

			//Show down
		}
	}
	return 1;
}

stock CheckShowdown(handle)
{
	SendTableMessage(handle, "{F25B13} {[ Showdown ]}");

	foreach(new p: IT_PlayersTable<handle>) //loop through the players already in the table
	{
		foreach(new k: IT_PlayersInGame<handle>) //loop through the players already in the table
		{
			new seat = TableRotCorrections[TableData[PlayerPokerData[k][E_PLAYER_CURRENT_HANDLE]][E_TABLE_TOTAL_SEATS]][ PlayerPokerData[k][E_PLAYER_CURRENT_CHAIR_SLOT]];
			new card1 = PlayerPokerData[k][E_PLAYER_CARD_VALUES][0];
			new card2 = PlayerPokerData[k][E_PLAYER_CARD_VALUES][1];

			PlayerTextDrawSetString(p, PlayerPokerData[p][E_PLAYER_CARDS_TXT_1][seat], CardData[card1][E_CARD_TEXTDRAW]);
			PlayerTextDrawSetString(p, PlayerPokerData[p][E_PLAYER_CARDS_TXT_2][seat], CardData[card2][E_CARD_TEXTDRAW]);
		}
	}
	if(!Iter_Contains(IT_Sidepots[handle], MAIN_POT))
	{
		Iter_Add(IT_Sidepots[handle], MAIN_POT);
		foreach(new k: IT_PlayersInGame<handle>) //loop through the players already in the table
		{
			Iter_Add(It_SidepotMembers[_IT[handle][MAIN_POT]], k);
		}
	}
	foreach(new pot_id: IT_Sidepots[handle])
	{
		new highest_rank = -0x7FFFFFFF;
		new PlayerRanks[MAX_PLAYERS];
		new high_id = INVALID_PLAYER_ID;
		foreach(new p: It_SidepotMembers[_IT[handle][pot_id]])
		{
			if(!Iter_Contains(IT_PlayersInGame<handle>, p)) continue;
			new card[7];
			card[0] = GetCardNativeIndex(PlayerPokerData[p][E_PLAYER_CARD_VALUES][0]);
			card[1] = GetCardNativeIndex(PlayerPokerData[p][E_PLAYER_CARD_VALUES][1]);
			card[2] = GetCardNativeIndex(TableData[handle][E_TABLE_COM_CARDS_VALUES][0]);
			card[3] = GetCardNativeIndex(TableData[handle][E_TABLE_COM_CARDS_VALUES][1]);
			card[4] = GetCardNativeIndex(TableData[handle][E_TABLE_COM_CARDS_VALUES][2]);
			card[5] = GetCardNativeIndex(TableData[handle][E_TABLE_COM_CARDS_VALUES][3]);
			card[6] = GetCardNativeIndex(TableData[handle][E_TABLE_COM_CARDS_VALUES][4]);

			PlayerRanks[p] = calculate_hand_worth(card, 7);

			if(PlayerRanks[p] > highest_rank)
			{
				highest_rank = PlayerRanks[p];
				high_id = p;
			}
		}
		new count = 0;
		foreach(new p: It_SidepotMembers[_IT[handle][pot_id]])
		{
			if(!Iter_Contains(IT_PlayersInGame<handle>, p)) continue;
			if(PlayerRanks[p] == highest_rank)
			{
				count++;
			}
		}
		if(count == 1)
		{
			foreach(new p: It_SidepotMembers[_IT[handle][pot_id]])
			{
				if(!Iter_Contains(IT_PlayersInGame<handle>, p)) continue;
				if(p == high_id) continue;
				ApplyAnimation(p, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 0, 1, 1, 1, 0, 1);
			}
			new w_chips = floatround(float(TableData[handle][E_TABLE_POT_CHIPS][pot_id]) * (1.0 - T_POT_FEE_RATE));
			//new fee_earned = floatround((float(TableData[handle][E_TABLE_POT_CHIPS][pot_id]) / 1000.0) * T_POT_FEE_RATE);
			//UpdateServerVariable( "poker_fees", 0, GetGVarFloat( "poker_fees" ) + fee_earned, "", GLOBAL_VARTYPE_FLOAT );
          	//StockMarket_UpdateEarnings( E_STOCK_CASINO, fee_earned, 0.25 );
			//GivePlayerCasinoRewardsPoints(high_id, fee_earned, .house_edge = 100.0);
			SendTableMessage(handle, "{9FCF30}****************************************************************************************");
			SendTableMessage(handle, "{9FCF30}Player {FF8000}%s {9FCF30}has won with a {377CC8}%s", ReturnPlayerName(high_id), HAND_RANKS[highest_rank >> 12]);
			SendTableMessage(handle, "{9FCF30}Prize: {377CC8}%s | -%0.0f%s percent fee.", IntegerWithDelimiter(w_chips), T_POT_FEE_RATE * 100.0, "%%");
			SendTableMessage(handle, "{9FCF30}****************************************************************************************");
			if (strmatch(HAND_RANKS[highest_rank >> 12], "Royal Flush")) printf("****\nRoyal Flush Player %s\n****\n", ReturnPlayerName(high_id));
			PlayerPokerData[high_id][E_PLAYER_TOTAL_CHIPS] += w_chips;
		}
		else
		{
			SendTableMessage(handle, "{9FCF30}****************************************************************************************");
			SendTableMessage(handle, "{9FCF30}Draw! These players have won with a {377CC8}%s:", HAND_RANKS[highest_rank >> 12]);
			new w_chips = floatround(float(TableData[handle][E_TABLE_POT_CHIPS][pot_id]) * (1.0 - T_POT_FEE_RATE));
			//new fee_earned = floatround((float(TableData[handle][E_TABLE_POT_CHIPS][pot_id]) / 1000.0) * T_POT_FEE_RATE);
			//UpdateServerVariable( "poker_fees", 0, GetGVarFloat( "poker_fees" ) + fee_earned, "", GLOBAL_VARTYPE_FLOAT );
          	//StockMarket_UpdateEarnings( E_STOCK_CASINO, fee_earned, 0.25 );
			new amount = w_chips / count;
			//new excess = TableData[handle][E_TABLE_POT_CHIPS][pot_id] % count
			foreach(new p: It_SidepotMembers[_IT[handle][pot_id]])
			{
				if(!Iter_Contains(IT_PlayersInGame<handle>, p)) continue;
				if(PlayerRanks[p] == highest_rank)
				{
					//GivePlayerCasinoRewardsPoints(p, floatround(float(fee_earned) / float(count)), .house_edge = 100.0);
					SendTableMessage(handle, "{9FCF30}%s", ReturnPlayerName(p));
					PlayerPokerData[p][E_PLAYER_TOTAL_CHIPS] += amount;
				}
				else
				{
					ApplyAnimation(p, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 0, 1, 1, 1, 0, 1);
				}
			}
			SendTableMessage(handle, "{9FCF30}Each receives 1/%d of the total pot available. | -%0.0f%s percent fee", count, T_POT_FEE_RATE * 100.0, "%%");
			SendTableMessage(handle, "{9FCF30}****************************************************************************************");
		}
		UpdateTable(handle);
	}
	return 1;
}
stock CheckPotAndNextTurn(playerid, handle)
{
	if(GetPVarInt(playerid, "t_Clicked"))
	{
		SetPVarInt(playerid, "t_Clicked", 0);
	}
	new next_turn = INVALID_PLAYER_ID;
	HidePlayerChoices(playerid);
	new bool: is_cycle_complete = false;

	next_turn = GetTurnAfterPlayer(handle, playerid);
	new last_to_raise = TableData[handle][E_TABLE_LAST_TO_RAISE];


	if(next_turn == INVALID_PLAYER_ID){
		is_cycle_complete = true;
	}

	if(!is_cycle_complete)
	{
		if(next_turn == last_to_raise || next_turn == playerid)
		{
			is_cycle_complete = true;
		}
		else
		{
			//further checking
			if(Iter_Count(IT_PlayersAllIn<handle>))
			{
				new next_player = INVALID_PLAYER_ID;
				new last_player = playerid;
				for(new i = 0; i < Iter_Count(IT_PlayersInGame<handle>); i++)
				{
					next_player = GetTurnAfterPlayerEx(handle, last_player);
					if(!Iter_Contains(IT_PlayersAllIn<handle>, next_player)) break;
					if(next_player == last_to_raise)
					{
						is_cycle_complete = true;
						break;
					}
					last_player = next_player;
				}
			}

		}

		if(!is_cycle_complete)
		{
			if(!Iter_Contains(IT_PlayersInGame<handle>, last_to_raise))
			{
				new const total_seats = TableData[handle][E_TABLE_TOTAL_SEATS];
				new slot = GetPlayerSeat(playerid) - 1;
				if(slot < 0) slot = total_seats - 1;
				new next_slot = ITER_NONE;
				for(new i = 0; i < total_seats; i++)
				{
					if(slot < 0) slot = total_seats - 1;
					next_slot = slot;
					new player = TableData[handle][E_TABLE_CHAIR_PLAYER_ID][next_slot];
					if(Iter_Contains(IT_PlayersInGame<handle>, player)) break;

					if(next_slot == TableData[handle][E_TABLE_LAST_TO_RAISE_SEAT])
					{
						is_cycle_complete = true;
						break;
					}
					slot--;
				}
			}

		}
	}

	/*if(TableData[handle][E_TABLE_FIRST_TURN] == playerid && TableData[handle][E_TABLE_CHECK_FIRST] && PlayerPokerData[playerid][E_PLAYER_FOLDED])
	{
		new turn = GetTurnAfterPlayer(handle, playerid);
		SetLastToRaise(handle, turn);
		is_cycle_complete = false;
		TableData[handle][E_TABLE_FIRST_TURN] = INVALID_PLAYER_ID;
		TableData[handle][E_TABLE_CHECK_FIRST] = false;
	}*/

	PlayerPokerData[playerid][E_PLAYER_FOLDED] = false;
	if(is_cycle_complete)
	{
		if(Iter_Count(IT_PlayersAllIn<handle>))
		{
			/*==================================================================================================
				Main pot and sidepot creation
			==================================================================================================*/

			for(new i = 0; i < Iter_Count(IT_PlayersInGame<handle>); i++)
			{
				new p_count = 0;
				new min_bet = cellmax;
				foreach(new player: IT_PlayersInGame<handle>)
				{
					new const player_bet = PlayerPokerData[player][E_PLAYER_CURRENT_BET];
					if(!player_bet) continue;
					if(player_bet < min_bet)
					{
						min_bet = player_bet;
					}
					p_count++;
				}
				if(!p_count || p_count == 1)
				{
					break;
				}
				else //greater than two players
				{
					new pot_id = Iter_Free(IT_Sidepots[handle]);
					TableData[handle][E_TABLE_POT_CHIPS][pot_id] += min_bet * p_count;
					foreach(new player: IT_PlayersInGame<handle>)
					{
						if(!PlayerPokerData[player][E_PLAYER_CURRENT_BET]) continue;
						PlayerPokerData[player][E_PLAYER_CURRENT_BET] -= min_bet;
						Iter_Add(It_SidepotMembers[_IT[handle][pot_id]], player);
					}
					Iter_Add(IT_Sidepots[handle], pot_id);
				}
			}
			//Return any excess
			foreach(new player: IT_PlayersInGame<handle>)
			{
				if(!PlayerPokerData[player][E_PLAYER_CURRENT_BET]) continue;
				PlayerPokerData[player][E_PLAYER_TOTAL_CHIPS] += PlayerPokerData[player][E_PLAYER_CURRENT_BET];
			}
		}
		else
		{
			foreach(new player: IT_PlayersInGame<handle>)
			{
				TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT] += PlayerPokerData[player][E_PLAYER_CURRENT_BET];
			}
			UpdateTable(handle);
		}

		new const all_in = Iter_Count(IT_PlayersAllIn<handle>);
		new const current_players = Iter_Count(IT_PlayersInGame<handle>);
		if(all_in == current_players || all_in == current_players - 1)
		{
			CheckRounds(handle, true);
		}
		else
		{
			CheckRounds(handle, false);
		}
	}
	else
	{
		SendTurnMessage(handle, next_turn);
	}
	UpdateTable(handle);
	return 1;
}

stock bool: FoldPlayer(handle, playerid)
{
	ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 0, 1, 1, 1, 0, 1);
	PlayerPokerData[playerid][E_PLAYER_FOLDED] = true;
	KillPlayerTurnTimer(playerid);
	SendTableMessage(handle, "{2DD9A9}  * * %s folds.. * *", ReturnPlayerName(playerid));
	SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{D6230A}** FOLDS ** ");

	PlayerPokerData[playerid][E_PLAYER_IS_PLAYING] = false;
	TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT] += PlayerPokerData[playerid][E_PLAYER_CURRENT_BET];
	HidePlayerChoices(playerid);
	Iter_Remove(IT_PlayersInGame<handle>, playerid);
	new count = Iter_Count(IT_PlayersInGame<handle>);
	if(count == 1)
	{
		Iter_Remove(IT_PlayersInGame<handle>, playerid);
		new winner = Iter_First(IT_PlayersInGame<handle>);
		HidePlayerChoices(winner);
		SendTableMessage(handle, "{9FCF30}****************************************************************************************");
		SendTableMessage(handle, "{9FCF30}Player {FF8000}%s {9FCF30}has won the game!", ReturnPlayerName(winner));
		new w_chips = floatround(float(TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT]) * (1.0 - T_POT_FEE_RATE));
		//new fee_earned = floatround((float(TableData[handle][E_TABLE_POT_CHIPS][MAIN_POT]) / 1000.0) * T_POT_FEE_RATE);
		//UpdateServerVariable( "poker_fees", 0, GetGVarFloat( "poker_fees" ) + fee_earned, "", GLOBAL_VARTYPE_FLOAT );
		//GivePlayerCasinoRewardsPoints(winner, fee_earned, .house_edge = 100.0);
		SendTableMessage(handle, "{9FCF30}Prize: {377CC8}%s | -%0.0f%s percent fee", IntegerWithDelimiter(w_chips), T_POT_FEE_RATE * 100.0, "%%");
		SendTableMessage(handle, "{9FCF30}****************************************************************************************");
		PlayerPokerData[winner][E_PLAYER_TOTAL_CHIPS]  += w_chips;
		PlayerPokerData[winner][E_PLAYER_TOTAL_CHIPS]  += PlayerPokerData[winner][E_PLAYER_CURRENT_BET];
		UpdateTable(handle);
		StartNewPokerGame(handle, 8);
		TableData[handle][E_TABLE_CURRENT_TURN] = INVALID_PLAYER_ID;
		return true;
	}
	else if(!count)
	{
		Iter_Remove(IT_PlayersInGame<handle>, playerid);
		//Might happen if all the players disconnect
		AbortGame(handle);
		return true;
	}
	else if(TableData[handle][E_TABLE_CURRENT_TURN] == playerid)
	{
		KillTimer(PlayerPokerData[playerid][E_PLAYER_TIMER_ID]);
		PlayerPokerData[playerid][E_PLAYER_TIMER_STARTED] = false;
		return false;
	}
	else
	{
		return false;
	}
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(PlayerPokerData[playerid][E_PLAYER_IS_PLAYING])
	{

		if(GetPlayerClickedTxt(playerid)) return 1;
		new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
		if(TableData[handle][E_TABLE_CURRENT_TURN] != playerid) {
			HidePlayerChoices(playerid);
			return 1;
		}
		if(playertextid == PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][FOLD])
		{
			//Fold
			SetPlayerClickedTxt(playerid, true);
			if(!FoldPlayer(handle, playerid))
				CheckPotAndNextTurn(playerid, handle);
		}
		else if(playertextid ==  PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][CALL])
		{
			//Call or check
			if(TableData[handle][E_TABLE_LAST_BET] == PlayerPokerData[playerid][E_PLAYER_CURRENT_BET]) //check
			{
				SetPlayerClickedTxt(playerid, true);
				KillPlayerTurnTimer(playerid);
				SendTableMessage(handle, "{2DD9A9}  * * %s checks .. * *", ReturnPlayerName(playerid));
				SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{22B1BD}** CHECKS ** ");
			}
			else //call
			{
				new dif = TableData[handle][E_TABLE_LAST_BET] - PlayerPokerData[playerid][E_PLAYER_CURRENT_BET];
				if(PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS] >= dif)
				{
					KillPlayerTurnTimer(playerid);
					SendTableMessage(handle, "{2DD9A9}  * * %s calls %s .. * *", ReturnPlayerName(playerid), IntegerWithDelimiter(dif));
					SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{22B1BD}** CALLS %s ** ", IntegerWithDelimiter(dif));
					RemoveChipsFromPlayer( playerid, dif);
					PlayerPokerData[playerid][E_PLAYER_CURRENT_BET] = TableData[handle][E_TABLE_LAST_BET];
					SetPlayerClickedTxt(playerid, true);
				}
				else
				{
					SendPokerMessage(playerid, "ERROR: You can't call as you don't have enough chips. You have two possible options: going all in or folding.");
					return 1;
				}

			}
			CheckPotAndNextTurn(playerid, handle);
		}
		else if(playertextid ==  PlayerPokerData[playerid][E_PLAYER_CHOICES_TXT][RAISE])
		{
			switch(PlayerPokerData[playerid][E_PLAYER_RCHOICE])
			{
				case E_RAISE_BET:
				{
					SendPokerMessage(playerid, "Please enter an amount to bet, the total amount of chips you current have is: %d", PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]);
					ShowPlayerRaiseDialog(playerid);
					HidePlayerChoices(playerid);
				}
				case E_RAISE_RAISE:
				{
					SendPokerMessage(playerid, "Please enter an amount to raise, the total amount of chips you current have is: %d", PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]);
					HidePlayerChoices(playerid);
					ShowPlayerRaiseDialog(playerid);
				}
				case E_RAISE_ALL_IN:
				{
					ForcePlayerAllIn(playerid, handle);
					SetPlayerClickedTxt(playerid, true);
				}
			}
		}
	}

	#if defined poker_OnPlayerClickPlayerTD
		return poker_OnPlayerClickPlayerTD(playerid, playertextid);
	#else
		return 1;
	#endif
}


#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw poker_OnPlayerClickPlayerTD

#if defined poker_OnPlayerClickPlayerTD
	forward poker_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif

stock ForcePlayerAllIn(playerid, handle, bool:checkpot = true)
{
	ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Idle_Loop", 4.1, 1, 1, 1, 0, 0, 1);
	KillPlayerTurnTimer(playerid);
	Iter_Add(IT_PlayersAllIn<handle>, playerid);
	new raise = PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS] + PlayerPokerData[playerid][E_PLAYER_CURRENT_BET];
	PlayerPokerData[playerid][E_PLAYER_CURRENT_BET] = raise;
	SendTableMessage(handle, "{2DD9A9}  * * %s goes all in with %s .. * *", ReturnPlayerName(playerid), IntegerWithDelimiter(raise));
	SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{9512CD}** ALL IN with %s ** ", IntegerWithDelimiter(raise));
	PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS] = 0;
	if(checkpot)
		CheckPotAndNextTurn(playerid, handle);
	return 1;
}

stock ShowPlayerRaiseDialog(playerid)
{
	inline Poker_DialogRaise(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext, listitem

		if ( ! response ) {

			new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
			if(!IsValidTable(handle)) return 1;
			if(TableData[handle][E_TABLE_CURRENT_TURN] == playerid)
			{
				SetPlayerClickedTxt(playerid, false);
				ShowChoicesToPlayer(playerid);
			}
			else
			{
				Dialog_Hide(playerid);

			}
		}

		if ( response ) {

			new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
			if(!IsValidTable(handle)) return 0;
			if(!Iter_Contains(IT_PlayersTable<handle>, playerid)) return 1;
			if(TableData[handle][E_TABLE_CURRENT_STATE] != STATE_BEGIN)
			{
				SendPokerMessage(playerid, "There isn't any active game at the moment.");
				return 0;
			}
			if(!Iter_Contains(IT_PlayersInGame<handle>, playerid))
			{
				return 0;
			}
			new raise = 0;
			if(sscanf(inputtext, "d", raise))
			{
				SendPokerMessage(playerid, "Input must be numeric.");
				ShowPlayerRaiseDialog(playerid);
				return 1;
			}
			if(raise < 0)
			{
				SendPokerMessage(playerid, "Input must be greater than 0.");
				ShowPlayerRaiseDialog(playerid);
				return 1;
			}
			else if(raise > PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS])
			{
				SendPokerMessage(playerid, "You don't have that many chips available.");
				ShowPlayerRaiseDialog(playerid);
				return 1;
			}
			else if(raise <= TableData[handle][E_TABLE_LAST_BET])
			{
				SendPokerMessage(playerid, "Value must be greater than the last bet: %s", IntegerWithDelimiter(TableData[handle][E_TABLE_LAST_BET]));
				ShowPlayerRaiseDialog(playerid);
				return 1;
			}
			else if(raise == PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS])
			{
				ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Idle_Loop", 4.1, 1, 1, 1, 0, 0, 1);
				KillPlayerTurnTimer(playerid);
				//all in - not mandatory
				SendTableMessage(handle, "{2DD9A9}  * * %s goes all in with %s .. * *", ReturnPlayerName(playerid), IntegerWithDelimiter(raise));
				SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{9512CD}** ALL IN with %s ** ", IntegerWithDelimiter(raise));
				Iter_Add(IT_PlayersAllIn<handle>, playerid);
				RemoveChipsFromPlayer( playerid, raise);
				SetLastToRaise(handle, playerid);

				PlayerPokerData[playerid][E_PLAYER_CURRENT_BET] += raise;
				TableData[handle][E_TABLE_LAST_BET] = PlayerPokerData[playerid][E_PLAYER_CURRENT_BET];
				CheckPotAndNextTurn(playerid, handle);
			}
			else
			{
				KillPlayerTurnTimer(playerid);
				new dif = raise - PlayerPokerData[playerid][E_PLAYER_CURRENT_BET];
				TableData[handle][E_TABLE_LAST_BET] = raise;
				SetLastToRaise(handle, playerid);
				PlayerPokerData[playerid][E_PLAYER_CURRENT_BET] = raise;
				RemoveChipsFromPlayer( playerid, dif);
				if(PlayerPokerData[playerid][E_PLAYER_RCHOICE] == E_RAISE_BET)
				{
					SendTableMessage(handle, "{2DD9A9}  * * %s bets %s .. * *", ReturnPlayerName(playerid), IntegerWithDelimiter(raise));
					SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{31CA15}** BETS %s ** ", IntegerWithDelimiter(raise));
				}
				else
				{
					SendTableMessage(handle, "{2DD9A9}  * * %s raises to %s .. * *", ReturnPlayerName(playerid), IntegerWithDelimiter(raise));
					SetPlayerChatBubbleEx(playerid, -1, 30.0, 2000, "{31CA15}** RAISES to %s ** ", IntegerWithDelimiter(raise));
				}
				CheckPotAndNextTurn(playerid, handle);
			}
		}
		else
		{
			new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
			if(!IsValidTable(handle)) return 1;
			if(TableData[handle][E_TABLE_CURRENT_TURN] == playerid)
			{
				SetPlayerClickedTxt(playerid, false);
				ShowChoicesToPlayer(playerid);
			}
			else
			{
				Dialog_Hide(playerid);

			}
		}
	}

   	Dialog_ShowCallback ( playerid, using inline Poker_DialogRaise, DIALOG_STYLE_INPUT, "{FF8000}Input", sprintf("{FFFFFF}Please input the desired amount of chips: \n{FFFFFF}You may type {FF8000}%d {FFFFFF} if you want to go All In\n",  PlayerPokerData[playerid][E_PLAYER_TOTAL_CHIPS]), "Submit", "Cancel" );

   	return true ;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	if(PRESSED(KEY_SECONDARY_ATTACK)) {
		
		new handle = GetClosestTableForPlayer(playerid);
		if(handle != ITER_NONE)
		{
			if(TableData[handle][E_TABLE_VIRTUAL_WORLD] == GetPlayerVirtualWorld(playerid) && TableData[handle][E_TABLE_INTERIOR] == GetPlayerInterior(playerid))
			{
				if(!Iter_Contains(IT_PlayersTable<handle>, playerid))
				{
					if(IsPlayerInRangeOfTable(playerid, handle, T_JOIN_TABLE_RANGE))
					{
						AddPlayerToTable(playerid, handle);
					}
				}
				else
				{
					if((Iter_Contains(IT_PlayersInGame<handle>, playerid) && TableData[handle][E_TABLE_CURRENT_STATE] == STATE_BEGIN)
					|| TableData[T_MAX_POKER_TABLES][E_TABLE_LOADING_GAME])
					{
						SendPokerMessage(playerid, "You cannot exit this table as there's currently an active match under process.");
						return 0;
					}
					KickPlayerFromTable(playerid);
				}
			}
		}
	}
	
	#if defined poker_OnPlayerKeyStateChange
		return poker_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange poker_OnPlayerKeyStateChange
#if defined poker_OnPlayerKeyStateChange
	forward poker_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


stock Player_CheckPokerGame(playerid, const reason[])
{
	if(GetPVarInt(playerid, "t_is_in_table"))
    {
        new handle = PlayerPokerData[playerid][E_PLAYER_CURRENT_HANDLE];
        if(Iter_Contains(IT_PlayersInGame<handle>, playerid)) {
            if(!FoldPlayer(handle, playerid)) {
                CheckPotAndNextTurn(playerid, handle);
            }
        }

        SendTableMessage(handle, "Player %s has been kicked out from the table [REASON: %s].", ReturnPlayerName(playerid), reason);
        KickPlayerFromTable(playerid);
    }
    return 1;
}

public OnGameModeExit()
{
	for(new i = 0; i < T_MAX_POKER_TABLES; i++)
	{
		if(!Iter_Contains(IT_Tables, i)) continue;
		DestroyPokertable(i);
		memcpy(TableData[i], TableData[T_MAX_POKER_TABLES], 0, sizeof(TableData[]) * 4, sizeof(TableData[]));
	}

	
	#if defined poker_OnGameModeExit
		return poker_OnGameModeExit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif

#define OnGameModeExit poker_OnGameModeExit
#if defined poker_OnGameModeExit
	forward poker_OnGameModeExit();
#endif

Poker_OnModeInit()
{
	//Setting values to dummy arrays

	//Player data:
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_CURRENT_HANDLE] = ITER_NONE;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_CURRENT_CHAIR_SLOT] = ITER_NONE;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_CHAIR_ATTACH_INDEX_ID] = ITER_NONE;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_IS_PLAYING] = false;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_TIMER_STARTED] = false;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_CARD_VALUES][0] = ITER_NONE;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_CARD_VALUES][1] = ITER_NONE;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_CURRENT_BET] = 0;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_TOTAL_CHIPS] = 0;
	PlayerPokerData[MAX_PLAYERS][E_PLAYER_FOLDED] = false;

	TableData[T_MAX_POKER_TABLES][E_TABLE_STING_NEW_GAME] = false;
	//Table data
    TableData[T_MAX_POKER_TABLES][E_TABLE_TOTAL_SEATS] = 0;
    TableData[T_MAX_POKER_TABLES][E_TABLE_LOADING_GAME] = false;
    TableData[T_MAX_POKER_TABLES][E_TABLE_CHECK_FIRST] = false;
    TableData[T_MAX_POKER_TABLES][E_TABLE_FIRST_TURN] = INVALID_PLAYER_ID;
	TableData[T_MAX_POKER_TABLES][E_TABLE_CURRENT_STATE] = STATE_IDLE;
	TableData[T_MAX_POKER_TABLES][E_TABLE_BUY_IN] = 0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_SMALL_BLIND] = 0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_VIRTUAL_WORLD] = 0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_INTERIOR] = 0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_BIG_BLIND] = 0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_POS_X] = 0.0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_POS_Y] = 0.0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_POS_Z] = 0.0;

	TableData[T_MAX_POKER_TABLES][E_TABLE_OBJECT_IDS][0] = 0;
	TableData[T_MAX_POKER_TABLES][E_TABLE_OBJECT_IDS][1] = 0;
	for(new i = 0; i < T_MAX_CHAIRS_PER_TABLE; i++)
	{
		TableData[T_MAX_POKER_TABLES][E_TABLE_CHAIR_OBJECT_IDS][i] = INVALID_OBJECT_ID;
		TableData[T_MAX_POKER_TABLES][E_TABLE_IS_SEAT_TAKEN][i] = false;
		TableData[T_MAX_POKER_TABLES][E_TABLE_CHAIR_PLAYER_ID][i] = INVALID_PLAYER_ID;
		TableData[T_MAX_POKER_TABLES][E_TABLE_SEAT_POS_X][i] = 0.0;
		TableData[T_MAX_POKER_TABLES][E_TABLE_SEAT_POS_Y][i] = 0.0;
		TableData[T_MAX_POKER_TABLES][E_TABLE_SEAT_POS_Z][i] = 0.0;
		TableChips[T_MAX_POKER_TABLES][i][0] = 0;
		TableChips[T_MAX_POKER_TABLES][i][1] = 0;
		TableChips[T_MAX_POKER_TABLES][i][2] = 0;
		TableChips[T_MAX_POKER_TABLES][i][3] = 0;
	}

	// server variables
	//AddServerVariable( "poker_fees", "0.0", GLOBAL_VARTYPE_FLOAT );

	T_SendWarning("TPoker by ThreeKingz (Edited for WWRP by Dignity) has been succesfully loaded!");
	Init_LoadPokerTables();
	return 1;
}

/******************************************************************************************
	Commands
*******************************************************************************************/

CMD:pokercreate(playerid, params[])
{

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new seats, small_blind, buy_in;
	if(sscanf(params, "ddd", seats, small_blind, buy_in))
	{
		SendServerMessage(playerid, COLOR_POKER, "Poker", "DEDEDE", "/pokercreate [number of seats] [small blind] [buy in]");
		SendServerMessage(playerid, COLOR_POKER, "Poker", "DEDEDE","Creating a table will save in the database but deleting one will only delete it until next restart, please keep this in mind.");
		return 1;
	}
	//Assumes the player is on a flat surface <Pos[2]-0.6>
	new Float:Pos[3];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	new table = CreatePokerTable(-1, buy_in, small_blind, Pos[0], Pos[1], Pos[2]-0.6, seats, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid),1);
	SendPokerMessage(playerid, "You have created table ID: %d | Small blind: %s | Big blind: %s | Buy In: %s | Seats: %d", table, IntegerWithDelimiter(small_blind), IntegerWithDelimiter(small_blind*2), IntegerWithDelimiter(buy_in), seats);
	return 1;
}

CMD:pokernear(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new handle = GetClosestTableForPlayer(playerid);
	if(handle != ITER_NONE) {
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("NEAREST POKER TABLE: SQL ID %d - HANDLE ID %d (use handle for cmds)",

			TableData[handle][E_TABLE_SQL_ID], handle )) ;
	}

	else return SendClientMessage(playerid, COLOR_RED, "Not near poker table." ) ;
	return true ;	
}

CMD:pokerdelete(playerid, params[])
{

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new ptable = 0;
	if(sscanf(params, "d", ptable))
	{
		SendClientMessage(playerid, 0x3E969FFF, "/pokerdelete [pokertable ID]");
		return 1;
	}
	if(!IsValidTable(ptable))
	{
		SendClientMessage(playerid, 0x3E969FFF, "Invalid pokertable ID");
		return 1;
	}
	SendPokerMessage(playerid,  "You have deleted poker table ID: %d", ptable);
	DestroyPokertable(ptable);
	return 1;
}

CMD:pokerendgame(playerid, params[])
{

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new ptable;
	if(sscanf(params, "d", ptable))
	{
		SendPokerMessage(playerid, "/pokerendgame [table ID]");
		SendPokerMessage(playerid, "Will abort a game if started, ejecting all the players out of the table.");
		return 1;
	}
	if(!IsValidTable(ptable))
	{
		SendClientMessage(playerid, 0x3E969FFF, "Invalid pokertable ID");
		return 1;
	}
	if(AbortGame(ptable))
	{
		SendPokerMessage(playerid, "You have successfully aborted the game on table ID: %d", ptable);
	}
	else
	{
		SendPokerMessage(playerid, "No game has started in this table yet.");
	}
	return 1;
}