#if !defined INVALID_HOLD_DATA_ID
	#define INVALID_HOLD_DATA_ID (-1)
#endif

#if !defined MAX_HOLD_NAME
	#define MAX_HOLD_NAME (64)
#endif


new HoldableDlgStr[4000];

enum {

	E_HOLD_TYPE_NONE = 0,
	E_HOLD_TYPE_FOOD,
	E_HOLD_TYPE_DRINK,
	E_HOLD_TYPE_SMOKE,
	E_HOLD_TYPE_TOOL,
	E_HOLD_TYPE_MISC
}

enum E_HOLD_TYPE_DATA {

	E_HOLD_TYPE_CONSTANT,
	E_HOLD_TYPE_DESC [ MAX_HOLD_NAME char ]
}

new HoldTypes [ ] [ E_HOLD_TYPE_DATA ] = {

	{ E_HOLD_TYPE_NONE,		!"None" },
	{ E_HOLD_TYPE_FOOD,		!"Food" },
	{ E_HOLD_TYPE_DRINK,	!"Drink" },
	{ E_HOLD_TYPE_SMOKE,	!"Smoke" },
	{ E_HOLD_TYPE_TOOL,		!"Tool" },
	{ E_HOLD_TYPE_MISC,		!"Misc" }
} ;

HoldType_GetDescription(constant, desc[], len=sizeof(desc)) {

	new bool: match ;

	for ( new i, j = sizeof ( HoldTypes ); i < j ; i ++ ) {

		if ( HoldTypes [ i ] [ E_HOLD_TYPE_CONSTANT ] == constant ) {

			strunpack(desc, HoldTypes [ i ] [ E_HOLD_TYPE_DESC ], len);
			match = true ;
		}
	}

	if(!match) {

		format(desc, len, "Invalid" ) ;
	}
}

static enum 
{
	E_HOLD_ANIM_NONE,
	E_HOLD_ANIM_HOLD,
	E_HOLD_ANIM_DRINK,
	E_HOLD_ANIM_GOGGLES,
}

static enum E_HOLD_ANIM_DATA 
{
	E_HOLD_ANIM_TYPE,
	E_HOLD_ANIM_CAT[16],
	E_HOLD_ANIM_NAME[32],
	bool:E_HOLD_ANIM_LOOP,
	bool:E_HOLD_ANIM_FREEZE,
	E_HOLD_ANIM_DURATION,
	E_HOLD_ANIM_GENDER
}

static const HoldAnims[][E_HOLD_ANIM_DATA] = 
{
	{ E_HOLD_ANIM_NONE },
	{ E_HOLD_ANIM_HOLD,	"GANGS", "drnkbr_prtl", false, true, 100, 1 },
	{ E_HOLD_ANIM_HOLD,	"GANGS", "drnkbr_prtl_F", false, true, 100, 2 },
	{ E_HOLD_ANIM_DRINK, "VENDING", "VEND_Drink2_P", false, true, 100 },
	{ E_HOLD_ANIM_GOGGLES, "GOGGLES", "GOGGLES_PUT_ON", false, true, 100 }
};

enum E_HOLD_DATA {
	E_HOLD_TYPE,
	E_HOLD_DESC [ MAX_HOLD_NAME char ],
	E_HOLD_MODELID,
	E_HOLD_BASE_BONE,
	Float: E_HOLD_BASE_POS_X,
	Float: E_HOLD_BASE_POS_Y,
	Float: E_HOLD_BASE_POS_Z,
	Float: E_HOLD_BASE_ROT_X,
	Float: E_HOLD_BASE_ROT_Y,
	Float: E_HOLD_BASE_ROT_Z,
	E_HOLD_ANIM
} ;


new HoldData [ ] [ E_HOLD_DATA ] = {

	/*
		!! ALWAYS ADD OBJECTS LAST, PEOPLE WILL USE /HOLD EQUIP WHICH TAKES THE ARRAY INDEX, PUTTING STUFF IN THE MIDDLE MESSES THIS UP !!
	*/

	{ E_HOLD_TYPE_NONE,		!"None", 	1337, 	E_ATTACH_BONE_SPINE, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },

	{ E_HOLD_TYPE_FOOD,		!"Burger", 						2880, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Burger Box", 					19811, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Pizza Slice", 				2702, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Cake Slice", 					11742, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Hotdog", 						19346, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Orange", 						19574, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Apple Red", 					19575, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Apple Green", 				19576, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Tomato", 						19577, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Banana", 						19578, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Bread Slice", 				19883, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Smoked Leg", 					19847, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Steak", 						19882, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_FOOD,		!"Fish", 						19630, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },

	{ E_HOLD_TYPE_DRINK,	!"Sprunk Can",					E_VENDING_CAN_ECOLA_SMALL,	E_ATTACH_BONE_HAND_L, 0.075, 0.06, -0.01,	0.0, 0.0, -40.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"E-Cola Can", 					E_VENDING_CAN_SPRUNK_SMALL, E_ATTACH_BONE_HAND_L, 0.075, 0.06, -0.01,	0.0, 0.0, -40.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Wine Glass", 					19818, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Cocktail Glass", 				19819, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Milk Bottle", 				19570, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Coffee Cup", 					19835, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"White Beer Bottle", 			1484, 	E_ATTACH_BONE_HAND_L, 0.14, 0.01, -0.06, 12.39, -143.70, 0.00, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Orange Beer Bottle", 			1543, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Yellow Beer Bottle", 			1544, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Green Beer Bottle", 			1486, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Square Green Bottle", 		1517, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Rectangle Green Bottle", 		1512, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"K-Beer Brown Bottle", 		1950, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"K-Beer Black Bottle", 		1951, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Black Wine Bottle Square", 	1669, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.0,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Red Wine Bottle", 			19822, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Champagne Bottle", 			19824, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Yellow Whiskey Flask", 		19823, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Vodka Bottle", 				19820, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },
	{ E_HOLD_TYPE_DRINK,	!"Vodka Bottle 2", 				19821, 	E_ATTACH_BONE_HAND_L, 0.05, 0.05, 0.10,	0.0, 180.0, 0.0, E_HOLD_ANIM_DRINK },

	{ E_HOLD_TYPE_SMOKE,	!"Cigarette", 					19625, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_SMOKE,	!"Blunt", 						3027, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_SMOKE,	!"Cigar", 						1485, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_SMOKE,	!"Pack: Cancer Sticks", 		19896, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_SMOKE,	!"Pack: C&K Sticks", 			19897, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_SMOKE,	!"Zippo Lighter", 				19998, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },

	{ E_HOLD_TYPE_TOOL,		!"Red Toolbox", 				19921, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Oxygen Cylinder", 			19816, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Camera", 						19623, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Broom", 						19622, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Shovel", 						19626, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Wrench", 						19627, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Wrench II", 					18633, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Sledgehammer", 				19631, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Oilcan", 						19621, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Pan", 						19581, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Sauce Pan", 					19584, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Boil Pan", 					19585, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Cutting Knife", 				19583, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Spatula", 					19586, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"BBQ Briquettes", 				19573, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Bucket", 						19468, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Screwdriver", 				18644, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Hammer", 						18635, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Crowbar", 					18634, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Fishing Rod", 				18632, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Box 'o' Bandages", 			11748, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Bandage", 					11747, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Fork", 						11715, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_TOOL,		!"Knife", 						11716, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },

	{ E_HOLD_TYPE_MISC,		!"Metal Tray", 					19809, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Soap", 						19874, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Skateboard", 					19878, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"TV Remote", 					19920, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Radio", 						19942, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Pistol Clip", 				19995, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Bowl", 						19993, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Toilet Paper", 				19873, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Pager", 						18875, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Log", 						19793, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Suitcase", 					19624, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Gym Bag", 					11745, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Microphone", 					19610, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Plastic Tray", 				19587, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Shopping Basket", 			19582, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Asian Fan", 					19591, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Cereal Box I", 				19561, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Cereal Box II", 				19562, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Love Juice Box II", 			19563, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Love Juice Box I", 			19564, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Ice Cream Box I", 			19565, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Ice Cream Box II", 			19566, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Ice Cream Box III", 			19567, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Ice Cream Box IV", 			19568, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Milk Carton", 				19569, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Pizza Box I", 				19571, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Pizza Box II", 				1582, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Box of Alcohol", 				19572, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Guitar I", 					19317, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Guitar II", 					19318, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Guitar III", 					19319, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Red Flag", 					19306, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"Blue Flag", 					19307, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },
	{ E_HOLD_TYPE_MISC,		!"House Key", 					11746, 	E_ATTACH_BONE_HAND_R, 0.0, 0.0, 0.0,	0.0, 0.0, 0.0 },

	{ E_HOLD_TYPE_MISC, 	!"NV Goggles",					368,	E_ATTACH_BONE_HAND_R, -0.00, 0.11, 0.05,    -83.19, 25.40, 0.00, E_HOLD_ANIM_GOGGLES },
	{ E_HOLD_TYPE_MISC, 	!"IR Goggles",					369,	E_ATTACH_BONE_HAND_R, -0.00, 0.11, 0.05,    -83.19, 25.40, 0.00, E_HOLD_ANIM_GOGGLES }

	/*
		!! ALWAYS ADD OBJECTS LAST, PEOPLE WILL USE /HOLD EQUIP WHICH TAKES THE ARRAY INDEX, PUTTING STUFF IN THE MIDDLE MESSES THIS UP !!
	*/
} ;

stock HoldData_ReturnName(index)
{
	new desc [ MAX_HOLD_NAME ] ;
	strunpack(desc, HoldData [ index ] [ E_HOLD_DESC ]);
	return desc;
}

stock HoldData_GetIndexByName(name[]) {

	new buffer [ MAX_HOLD_NAME ] ;

	for ( new i, j = sizeof ( HoldData ); i < j ; i ++ ) {

		strunpack(buffer, HoldData [ i ] [ E_HOLD_DESC ] ) ;

		if (! strcmp(name, buffer, false) ) {

			return i ; 
		}
	}

	return INVALID_HOLD_DATA_ID ;
}

stock HoldData_GetModelByIndex(index) {

	if(index < 0 || index > sizeof ( HoldData ) ) {

		return INVALID_HOLD_DATA_ID ;
	}

	return HoldData [ index ] [ E_HOLD_MODELID ] ;
}

stock HoldData_GetBoneByIndex(index) {

	if(index < 0 || index > sizeof ( HoldData ) ) {

		return INVALID_HOLD_DATA_ID ;
	}

	return HoldData [ index ] [ E_HOLD_BASE_BONE ] ;
}

stock HoldData_GetTypeByIndex(index) {

	if(index < 0 || index > sizeof ( HoldData ) ) {

		return INVALID_HOLD_DATA_ID ;
	}

	return HoldData [ index ] [ E_HOLD_TYPE ] ;
}

stock HoldData_SetBaseCoords(index, &Float: pos_x, &Float: pos_y, &Float: pos_z, &Float: ros_x, &Float: ros_y, &Float: ros_z ) {

	if(index < 0 || index > sizeof ( HoldData ) ) {

		return INVALID_HOLD_DATA_ID ;
	}

	pos_x =  HoldData [ index ] [ E_HOLD_BASE_POS_X ] ;
	pos_y =  HoldData [ index ] [ E_HOLD_BASE_POS_Y ] ;
	pos_z =  HoldData [ index ] [ E_HOLD_BASE_POS_Z ] ;
	rot_x =  HoldData [ index ] [ E_HOLD_BASE_ROT_X ] ;
	rot_y =  HoldData [ index ] [ E_HOLD_BASE_ROT_Y ] ;
	rot_z =  HoldData [ index ] [ E_HOLD_BASE_ROT_Z ] ;

	return true ;
}

CMD:hold(playerid, const params[]) {

	new option[32], extra[32] ;

	new description [ MAX_HOLD_NAME ] ;

	sscanf ( params, "s[32]s[32]", option, extra ) ;

	if(isnull(option) && isnull(extra)) {
		Hold_DisplayList(playerid) ;
		SendClientMessage(playerid, 0xDEDEDEFF, "To commands associated with the hold system, use {eb7734}\"/hold help\"{DEDEDE}.") ;
	}

	else {
		if(!strcmp(option,"help", true)) {

			SendClientMessage(playerid, 0x297183FF, "[ ___________ Hold Commands  ___________ ]");


			SendClientMessage(playerid, 0xeb7734FF, "/hold \"help\"{DEDEDE} Shows this command");
			ZMsg_SendClientMessage(playerid, 0xeb7734FF, "/hold \"anim\" [\"stop/play/carry\"]{DEDEDE} Stop or play holding/using animations (or carry, for large items)");
			SendClientMessage(playerid, 0xeb7734FF, "/hold \"drop\"{DEDEDE} Removes the attached hold item and resets the animation");
			SendClientMessage(playerid, 0xeb7734FF, "/hold \"equip\" [\"id\"]{DEDEDE} Allows you to \"skip\" the selection dialog and equip a holdable per ID.");
			SendClientMessage(playerid, 0xeb7734FF, "/hold \"bone\"{DEDEDE} Allows you to change the bone of your holdable (for example putting a cigarette in your mouth)");
		}
		else if (!strcmp(option, "anim", true)) 
		{
			new index = GetPlayerHoldIndex(playerid);
			if (index == -1) return SendClientMessage(playerid, COLOR_ERROR, "You're not holding anything.");

			if (!isnull(extra))
			{
				if(!strcmp(extra, "stop", true ) ) 
				{	
					StopPlayerHoldingAnim(playerid);
					return true;
				}
				else if(!strcmp(extra, "play", true ) ) 
				{
					SetPlayerHoldingAnim(playerid, index, true);
					return true;
				}		
				else if(!strcmp(extra, "carry", true ) ) 
				{
					StopPlayerHoldingAnim(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					PlayerVar[playerid][E_PLAYER_HOLDABLES_CARRYING] = true;

					return true ;
				}
			}
			
			SendClientMessage(playerid, COLOR_ERROR, "/hold anim [stop/play/carry]" ) ;
			return true ;
		}
		
		else if(!strcmp(option,"drop", true)) 
		{
			new index = GetPlayerHoldIndex(playerid);
			if (index == -1) return SendClientMessage(playerid, COLOR_ERROR, "You're not holding anything.");

			PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] = false ;
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC ) ;

		 	cmd_stopanim(playerid, params);

			SendClientMessage(playerid, 0xDEDEDEFF, "You have dropped your holding object.") ;

			return true ;
		}
		
		else if(!strcmp(option,"equip", true)) {

			new index = strval(extra ) ;

			if ( isnull(extra) || index <= 0 || index >= sizeof ( HoldData ) ) {

				return SendClientMessage(playerid, COLOR_RED, sprintf("/hold equip [1-%d]", sizeof ( HoldData ) - 1 ) ) ;
			}

			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, HoldData [ index ] [ E_HOLD_MODELID ], HoldData [ index ] [ E_HOLD_BASE_BONE ], 
				HoldData [ index ] [ E_HOLD_BASE_POS_X ], HoldData [ index ] [ E_HOLD_BASE_POS_Y ], HoldData [ index ] [ E_HOLD_BASE_POS_Z ], 
				HoldData [ index ] [ E_HOLD_BASE_ROT_X ], HoldData [ index ] [ E_HOLD_BASE_ROT_Y ], HoldData [ index ] [ E_HOLD_BASE_ROT_Z ]
			);

			description[0]=EOS;
			strunpack(description, HoldData [ index ] [ E_HOLD_DESC ]);

			SendClientMessage(playerid, 0xDEDEDEFF, 
				sprintf("You're holding {eb7734}(%d) %s{DEDEDE}. Move it to your desired location. Use {eb7734}ESC{DEDEDE} to cancel.", index ,description) 
			) ;

			PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INDEX ] = index;
			PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] = true ;
			EditAttachedObject(playerid, E_ATTACH_INDEX_MISC ) ;
			SetPlayerArmedWeapon(playerid, 0);

			return true ;
		}
		else if(!strcmp(option,"bone", true)) 
		{
			new index = GetPlayerHoldIndex(playerid);
			if (index == -1) return SendClientMessage(playerid, COLOR_ERROR, "You're not holding anything.");

			HoldableDlgStr [ 0 ] = EOS ;

	 		inline HoldableDialog_Bones(pid, dialogid, response, listitem, string:inputtext[]) {
	   			#pragma unused pid, dialogid, inputtext, listitem

	 			if (!response) 
				{
					SendClientMessage(playerid, 0xDEDEDEFF, "You've {eb7734}cancelled{DEDEDE} editing the holdable. It has been removed.") ;
					StopPlayerHolding(playerid);
	 			}
	 			else if (response) 
				{
					new bone = listitem + 1 ;

					description[0]=EOS;
					Attach_GetBoneName ( bone, description, sizeof ( description ) ) ;

					SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_MODELID ], bone);
					SendClientMessage(playerid, 0xDEDEDEFF, sprintf(
						"You've set your holdable to the \"%s\" bone. Move it to your desired location. Use {eb7734}ESC{DEDEDE} to cancel.",
						description 
					)) ;

					PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] = true ;

					SetPlayerHoldingAnim(playerid, index);
					EditAttachedObject(playerid, E_ATTACH_INDEX_MISC);
					SetPlayerArmedWeapon(playerid, 0);
	 			}

	 			return true ;
			}   

			HoldableDlgStr[0]=EOS;

			for ( new i = 1, j = E_ATTACH_MAX_BONES ; i <= j ; i ++ ) {

				description[0]=EOS;
				Attach_GetBoneName ( i, description, sizeof ( description ) ) ;
				format ( HoldableDlgStr, sizeof ( HoldableDlgStr ), "%s%s\n", HoldableDlgStr, description ) ;
			}

			Dialog_ShowCallback ( playerid, using inline HoldableDialog_Bones, DIALOG_STYLE_LIST, "Holdables: Choose Bone", HoldableDlgStr, "OK", "Back" );
	  
	  		return true ;
		}
		else if(!strcmp(option,"save", true)) 
		{
			new index = GetPlayerHoldIndex(playerid);
			if (index == -1) return SendClientMessage(playerid, COLOR_ERROR, "You're not holding anything.");

			new str[128];
			format(str, sizeof(str), "%s (%d): %.02f, %.02f, %.02f,	%.02f, %.02f, %.02f", 
				HoldData_ReturnName(index), HoldData [ index ] [ E_HOLD_MODELID ],
				PlayerVar[playerid][E_PLAYER_HOLD_X], PlayerVar[playerid][E_PLAYER_HOLD_Y], PlayerVar[playerid][E_PLAYER_HOLD_Z],
				PlayerVar[playerid][E_PLAYER_HOLD_RX], PlayerVar[playerid][E_PLAYER_HOLD_RY], PlayerVar[playerid][E_PLAYER_HOLD_RZ]
			);

			SendClientMessage(playerid, 0xDEDEDEFF, str);
			printf("%s }, // %s", str, ReturnMixedName(playerid));

			return true ;
		}
	}
    return true ;
}

stock Hold_DisplayList(playerid) {

	if(!PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INFO ]) {

		return ShowFirstHoldDlg(playerid);
	}

 	if (!CanUseHoldCmd(playerid)) {
        return SendClientMessage(playerid, COLOR_ERROR, "You must have 6 playing hours to use holdables.");
 	}

	HoldableDlgStr [ 0 ] = EOS ;
	new description [ MAX_HOLD_NAME ] ;

	for ( new i, j = sizeof ( HoldTypes ); i < j ; i ++ ) {

		if ( HoldTypes [ i ] [ E_HOLD_TYPE_CONSTANT ] == E_HOLD_TYPE_NONE ) {

			continue ;
		}

		description[0]=EOS;
		HoldType_GetDescription(HoldTypes [ i ] [ E_HOLD_TYPE_CONSTANT ], description) ;
		format ( HoldableDlgStr, sizeof ( HoldableDlgStr), "%s\n%s", HoldableDlgStr, description ) ;
	}

    inline HoldableDialog_Cats(pid, dialogid, response, listitem, string:inputtext[]) {
   		#pragma unused pid, dialogid, inputtext, listitem

        if (response) {
			
        	new type = listitem + 1, index; // listitem +1 cause 0 is skipped
        	new types [ sizeof ( HoldData ) ], count = 0 ;

			for ( new i, j = sizeof ( HoldData ); i < j ; i ++ ) {

				if ( HoldData [ i ] [ E_HOLD_TYPE ] == type ) {

					types [ count ++ ] = i ;
				}
			}

			HoldableDlgStr [ 0 ] = EOS ;

			for ( new i, j = count ; i < j ; i ++ ) {
				index = types [ i ] ;

				description [ 0 ] = EOS ;
				strunpack(description, HoldData [ index ] [ E_HOLD_DESC ]);

				format ( HoldableDlgStr, sizeof ( HoldableDlgStr ), "%s(%d) %s\n",
					HoldableDlgStr, index,  description
				) ;
			}

		    inline HoldableDialog(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
   				#pragma unused pidx, dialogidx, inputtextx, listitemx
 			
		    	if(!responsex) {
		    		Hold_DisplayList(playerid);
		    		return true ;
		    	}

		    	else if ( responsex) {

		    		index = types [ listitemx ] ; // Use index to determine shit!

		    		SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, HoldData [ index ] [ E_HOLD_MODELID ], HoldData [ index ] [ E_HOLD_BASE_BONE ], 
		    			HoldData [ index ] [ E_HOLD_BASE_POS_X ], HoldData [ index ] [ E_HOLD_BASE_POS_Y ], HoldData [ index ] [ E_HOLD_BASE_POS_Z ], 
		    			HoldData [ index ] [ E_HOLD_BASE_ROT_X ], HoldData [ index ] [ E_HOLD_BASE_ROT_Y ], HoldData [ index ] [ E_HOLD_BASE_ROT_Z ]
		    		);

					description [ 0 ] = EOS ;
					strunpack(description, HoldData [ index ] [ E_HOLD_DESC ]);

					SendClientMessage(playerid, 0xDEDEDEFF, 
						sprintf("You're holding {eb7734}(%d) %s{DEDEDE}. Move it to your desired location. Use {eb7734}ESC{DEDEDE} to cancel.", index ,description) 
					) ;

					PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] = true ;
					PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_MODELID ] = HoldData [ index ] [ E_HOLD_MODELID ] ;
					PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INDEX ] = index;

					SetPlayerHoldingAnim(playerid, index);
					EditAttachedObject(playerid, E_ATTACH_INDEX_MISC ) ;
					SetPlayerArmedWeapon(playerid, 0);
		    	}
 			}

		    Dialog_ShowCallback ( playerid, using inline HoldableDialog, DIALOG_STYLE_LIST, "Holdables: Choose Object", HoldableDlgStr, "OK", "Back" );
        }
    }

    Dialog_ShowCallback ( playerid, using inline HoldableDialog_Cats, DIALOG_STYLE_LIST, "Holdables: Choose Category", HoldableDlgStr, "OK", "Back" );

    return true ;
}

ShowFirstHoldDlg(playerid)
{
	HoldableDlgStr[0]=EOS;
    format(HoldableDlgStr, sizeof(HoldableDlgStr), "{FFFFFF}Introduction to Holdables:{ADBEE6}\n");

    strcat(HoldableDlgStr, "- Holdables are our unique system on SP:RP for holding small objects and props for roleplay purposes.\n");
    strcat(HoldableDlgStr, "- You can use these to decorate your character for screenshots or hold items that your character would be using.\n");

    strcat(HoldableDlgStr, "\n{FFFFFF}Rules for Holdables:{ADBEE6}\n");
    strcat(HoldableDlgStr, "- Holdables should only be created for proper in-character (IC) purposes.\n");
    strcat(HoldableDlgStr, "- Don't abuse the system to troll, interfere with other scenes, or hold random items.\n");
    strcat(HoldableDlgStr, "- Do not hold items with unrealistic placement, rotation or improper scaling.\n");
    strcat(HoldableDlgStr, "- Holding items should only be done to make things more realistic, not to powergame or stall.\n");
    strcat(HoldableDlgStr, "- Don't hold items that your character does not actually have or could not currently use.\n");
    strcat(HoldableDlgStr, "- Only hold items with agreement from other players involved, and after any roleplay.\n");

    strcat(HoldableDlgStr, "\n{FFFFFF}Examples for Holdables:{ADBEE6}\n");    
    strcat(HoldableDlgStr, "- Holding a cigarette when you roleplay having a smoke\n");
    strcat(HoldableDlgStr, "- Holding a beverage or a bottle of beer when in a club or bar\n");
    strcat(HoldableDlgStr, "- Holding a tool (wrench, screwdriver, ...) when roleplaying mechanic duties\n");
    strcat(HoldableDlgStr, "- Holding a suitcase or gym bag to transport items\n");
    
    strcat(HoldableDlgStr, "\n{FFFFFF}Press {AA3333}OK{FFFFFF} to continue.\n{AA3333}By continuing, you agree to the rules above.");
	strcat(HoldableDlgStr, "\n{FF0000}Note this system is still in development and is not yet feature complete.");

    inline FirstHoldableDlg(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem
        if (response)
        {
            PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INFO ] = 1;
            cmd_hold(playerid, "\1");
        }
    }

    Dialog_ShowCallback ( playerid, using inline FirstHoldableDlg, DIALOG_STYLE_MSGBOX, "Holdables", HoldableDlgStr, "OK", "Back" );

    return true ;
}

CanUseHoldCmd(playerid) {
    return CanPlayerUseGuns(playerid, 6, -1);
}


static GetPlayerHoldIndex(playerid)
{
	return PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INDEX ];
}

static bool: IsPlayerHolding(playerid)
{
	return !PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] && PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_MODELID ] > 0;
}

forward SOLS_IsPlayerHolding(playerid);
public SOLS_IsPlayerHolding(playerid)
{
	if (IsPlayerHolding(playerid)) return PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_MODELID ];
	return 0;
}

static SetPlayerHoldingAnim(playerid, holdid, bool:play = true)
{
	new anim_type = HoldData[holdid][E_HOLD_ANIM];

	if (anim_type)
	{
		for (new i = 1; i < sizeof(HoldAnims); i ++)
		{
			if (HoldAnims[i][E_HOLD_ANIM_TYPE] == anim_type && (!HoldAnims[i][E_HOLD_ANIM_GENDER] || HoldAnims[i][E_HOLD_ANIM_GENDER] == Character[playerid][E_CHARACTER_ATTRIB_SEX]))
			{
				PlayerVar[playerid][E_PLAYER_HOLDABLES_ANIM] = i;
				if (play) ApplyPlayerHoldAnim(playerid, 1);

				return true;
			}
		}
	}

	return false;
}

static StopPlayerHoldingAnim(playerid)
{
	if (PlayerVar[playerid][E_PLAYER_HOLDABLES_ANIM] || PlayerVar[playerid][E_PLAYER_HOLDABLES_CARRYING])
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

		if (IsPlayerInAnyVehicle(playerid))
		{
			ApplyAnimation(playerid, "PED", "CAR_SIT", 4.0, 0, 0, 0, 0, 1, 1);
		}
		else  
		{
			ClearAnimations(playerid, 1);
			ApplyAnimation(playerid, "PED", "IDLE_STANCE", 4.0, 0, 0, 0, 0, 1, 1);
			ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 0, 0, 0, 1, 1);
			ApplyAnimation(playerid, "PED", "WALK_PLAYER", 4.0, 0, 0, 0, 0, 1, 1);
		}
	}

	PlayerVar[playerid][E_PLAYER_HOLDABLES_ANIM] = 0;
	PlayerVar[playerid][E_PLAYER_HOLDABLES_CARRYING] = false;

	return true;
}

static ApplyPlayerHoldAnim(playerid, forcesync)
{
	new holdid = GetPlayerHoldIndex(playerid);
	new animid = PlayerVar[playerid][E_PLAYER_HOLDABLES_ANIM];

	if (holdid <= 0 || animid <= 0) return false;
	ApplyAnimation(playerid, HoldAnims[animid][E_HOLD_ANIM_CAT], HoldAnims[animid][E_HOLD_ANIM_NAME], 4.1, HoldAnims[animid][E_HOLD_ANIM_LOOP], 0, 0, HoldAnims[animid][E_HOLD_ANIM_FREEZE], HoldAnims[animid][E_HOLD_ANIM_DURATION], forcesync);

	return true;
}

static SetPlayerHolding(playerid, holdid, boneid, Float:x = 0.0, Float:y = 0.0, Float:z = 0.0, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0, Float:sx = 1.0, Float:sy = 1.0, Float:sz = 1.0)
{
	new modelid = HoldData[holdid][E_HOLD_MODELID];

	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] = false ;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_MODELID ] = modelid ;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_ANIM ] = 0;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INDEX ] = holdid;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_CARRYING ] = false;

	PlayerVar [ playerid ] [ E_PLAYER_HOLD_X ] = x;
	PlayerVar [ playerid ] [ E_PLAYER_HOLD_Y ] = y;
	PlayerVar [ playerid ] [ E_PLAYER_HOLD_Z ] = z;

	PlayerVar [ playerid ] [ E_PLAYER_HOLD_RX ] = rx;
	PlayerVar [ playerid ] [ E_PLAYER_HOLD_RY ] = ry;
	PlayerVar [ playerid ] [ E_PLAYER_HOLD_RZ ] = rz;

	SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, modelid, boneid, x, y, z, rx, ry, rz, sx, sy, sz);
	// ShowPlayerFooter(playerid, sprintf("You're now holding (%d) %s.~n~~w~Press~y~ ~k~~VEHICLE_ENTER_EXIT~ ~w~to stop.", holdid, HoldData_ReturnName(holdid)));
	ShowPlayerFooter(playerid, "Press~y~ ~k~~VEHICLE_ENTER_EXIT~ ~w~to stop holding.");
	SetPlayerArmedWeapon(playerid, 0);

	return true;
}

static StopPlayerHolding(playerid)
{
	if (IsPlayerHolding(playerid))
	{
		CallRemoteFunction("SOLS_OnPlayerStopHolding", "d", playerid);
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);
		StopPlayerHoldingAnim(playerid);
	}

	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ] = false;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_MODELID ] = -1;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_INDEX ] = -1;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_ANIM ] = 0;
	PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_CARRYING ] = false;
	
	return true ;
}

CMD:drophold(playerid)
{
	if (IsPlayerHolding(playerid))
	{
		StopPlayerHolding(playerid);
		SendClientMessage(playerid, 0xDEDEDEFF, "You have dropped your holding object.") ;
	}

	return true;
}

#include <YSI_Coding\y_hooks>

hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if (!PlayerVar [ playerid ] [ E_PLAYER_HOLDABLES_EDITING ]) return 1; // do nothing basically

	if (response) 
	{
		SetPlayerHolding(playerid, GetPlayerHoldIndex(playerid), boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
		//SendClientMessage(playerid, 0xDEDEDEFF, "To change animation, use {eb7734}/hold anim [base, hold, carry]{DEDEDE}. To drop, use {eb7734}/hold drop{DEDEDE}.") ;
	}
	else
	{
		StopPlayerHolding(playerid);
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC);
	}

	SetPlayerArmedWeapon(playerid, 0);

	return -2; // stop processing this callback immediately and return 1 (prevents other callbacks receiving this)
}

hook OnPlayerStreamIn(playerid, forplayerid)
{
	new hold_index = GetPlayerHoldIndex(playerid);
	if (hold_index && IsPlayerHolding(playerid) && PlayerVar[playerid][E_PLAYER_HOLDABLES_ANIM])
	{
		ApplyPlayerHoldAnim(playerid, 2);
	}

    return 1;
}

hook OnPlayerUpdate(playerid)
{
	if (IsPlayerHolding(playerid) && GetPlayerWeapon(playerid) != 0)
	{
		StopPlayerHolding(playerid);
	}

	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (IsPlayerHolding(playerid) && (PRESSED(KEY_FIRE) || PRESSED(KEY_CROUCH) || PRESSED(KEY_SECONDARY_ATTACK)))
	{
		StopPlayerHolding(playerid);
	}

	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (IsPlayerHolding(playerid) && newstate != PLAYER_STATE_ONFOOT)
	{
		StopPlayerHolding(playerid);
	}

	return 1;
}