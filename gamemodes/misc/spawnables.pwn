//------------------------------------------------------------------------------
// Spawnables (roadblocks, props, stretchers, etc) and police tape.
// Written by Sporky (www.github.com/sporkyspork) for Redwood RP (www.rw-rp.net)

static SpawnerDlgStr[4000];

static SpawnObject_InfrontOfPlayer(playerid, model, Float:zoffset = 0.0, Float:rzoffset = 0.0, Float:drawdistance = 100.0)
{
    new Float:x,Float:y,Float:z;
    new Float:facing;
    new Float:distance;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, facing);

    distance = 1.75;

    x += (distance * floatsin(-facing, degrees));
    y += (distance * floatcos(-facing, degrees));

    facing += rzoffset;
    if (facing > 360.0) facing -= 360.0;

    return CreateDynamicObject(model, x, y, z + zoffset, 0.0, 0.0, facing, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, drawdistance, drawdistance, -1, -1); // Priority: -1
}

new pSpawnerObject[MAX_PLAYERS];
new pSpawnerSpawnableId[MAX_PLAYERS] = {-1, ... };
// new pSelectingObject[MAX_PLAYERS];
new pSpawnerInvalid[MAX_PLAYERS];
new pFirstSpawnable[MAX_PLAYERS] = {1, ... };
new pCarryObject[MAX_PLAYERS];
new Float:pSpawnerPos[MAX_PLAYERS][4];
new pEditingSpawnable[MAX_PLAYERS];
new pMovingSpawnable[MAX_PLAYERS];

/* New spawnables stuff */

CanUseSpawnCmd(playerid)
{
    return CanPlayerUseGuns(playerid, 8, -1);
    // return GetFactionType(playerid) > 0 || IsSpawnerAdmin(playerid) || PlayerData[playerid][pPlayingHours] >= 12 || PlayerData[playerid][pCanUseSpawnables] == 1;
    //return true;
}

bool:CanUseSpawnables(playerid)
{
    // return GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_NONE && PlayerData[playerid][pHospital] == -1 && !PlayerData[playerid][pCuffed] && !PlayerData[playerid][pInjured] && IsPlayerSpawned(playerid) && PlayerData[playerid][pCanUseSpawnables] != 2;
    return PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] || (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_NONE && !Character[playerid][E_CHARACTER_ARREST_TIME] && !IsPlayerIncapacitated(playerid, false) && !Character[playerid][E_CHARACTER_AJAIL_TIME]);
}


enum eSpawnableData
{
    spObjectId,
    spPlayerName[32],
    spFaction,
    spTimestamp,
    Float:spPos[6],
    spInterior,
    spWorld,
    spSpawnableModelId,
    spCustomModelId,
    spTimeout
}

#define MAX_SPAWNABLES 250
new SpawnableData[MAX_SPAWNABLES][eSpawnableData];

bool:IsValidSpawnable(spawnid)
{
    return SpawnableData[spawnid][spObjectId] != INVALID_OBJECT_ID;
}
#define MAX_SPAWNABLE_CATEGORIES 9
new const SpawnableCategories[MAX_SPAWNABLE_CATEGORIES][32] = 
{
    "Faction Items",
    "Weapon Objects",
    "Food & Drink",
    "Clothing",
    "Trash",
    "Personal Items",
    "Decorations",
    "Misc. Props",
    "Carried Items"
};

#define SPAWNABLE_CATEGORY_FACTION 0
#define SPAWNABLE_CATEGORY_WEAPON 1
#define SPAWNABLE_CATEGORY_FOOD 2
#define SPAWNABLE_CATEGORY_CLOTHES 3
#define SPAWNABLE_CATEGORY_TRASH 4
#define SPAWNABLE_CATEGORY_PERSONAL 5
#define SPAWNABLE_CATEGORY_DECOR 6
#define SPAWNABLE_CATEGORY_MISC 7
#define SPAWNABLE_CATEGORY_CARRY 8
#define MAX_SPAWNABLES_IN_CAT 50

#define SPAWN_FACTION_POLICE 1
//#define FACTION_FEDERAL_POLICE 2
//#define FACTION_COAST_GUARD 3
//#define FACTION_GOV 4
#define SPAWN_FACTION_MEDIC 4
#define SPAWN_FACTION_NEWS  5
#define SPAWN_FACTION_DEA  6
//#define FACTION_TOWING 6


#define SPAWNABLE_MAX_DURATION 5400 // 90 min

enum eSpawnableModelData
{
    spmModel,
    spmName[32],
    spmCategory,
    Float:spmPlacementOffset[6],
    spmFactions[MAX_FACTION_TYPES],
    Float:spmDrawDistance
}

new const SpawnableModels[][eSpawnableModelData] = 
{
    { 1238, "Traffic Cone", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_POLICE, SPAWN_FACTION_MEDIC, SPAWN_FACTION_DEA} },
    {-25185, "Solid Concrete Block", SPAWNABLE_CATEGORY_FACTION, {-0.25, 170.0}, {SPAWN_FACTION_POLICE, SPAWN_FACTION_DEA} },
    {1459, "Small Barrier Fence", SPAWNABLE_CATEGORY_FACTION, {-0.40, 170.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE, SPAWN_FACTION_DEA} },
    {-25186, "Road Closed Barrier", SPAWNABLE_CATEGORY_FACTION, {-0.25, 170.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE} },
    {-25187, "No Cars Beyond Sign", SPAWNABLE_CATEGORY_FACTION, {-0.40, 170.0}, {SPAWN_FACTION_POLICE} },
    {-25188, "Stop Sign", SPAWNABLE_CATEGORY_FACTION, {-0.40, 170.0}, {SPAWN_FACTION_POLICE} },
    {1425, "Detour Sign", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_POLICE} },
    {19834, "Police Tape", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_POLICE, SPAWN_FACTION_DEA} },
    {19871, "Cordon Stand", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_POLICE, SPAWN_FACTION_NEWS, SPAWN_FACTION_DEA} },
    {1211, "Fire Hydrant", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC} },
    {18728, "Red Warning Flare", SPAWNABLE_CATEGORY_FACTION, {-0.60, 170.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE} },
    {18690, "Fire", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC}, 50.0 },
    {18727, "White Smoke", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC}, 300.0 },
    {18726, "Black Smoke", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC}, 300.0 },
    {18723, "Huge Riot Smoke", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC}, 300.0 },
    {1428, "Ladder", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC} },
    {1437, "Large Ladder", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0}, {SPAWN_FACTION_MEDIC} },
    {19921, "Toolbox", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0} },
    {19917, "Car Engine", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0} },
    {19903, "Mechanic Computer", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0} },
    {19872, "Big Mechanic Car Ramp", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0} },
    {19898, "Oil Slick", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0} },
    {19621, "Oil Can", SPAWNABLE_CATEGORY_FACTION, {-0.60, 0.0} },
    {11736, "First Aid Kit", SPAWNABLE_CATEGORY_FACTION, {-0.90, 0.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE, SPAWN_FACTION_DEA} },
    {11738, "Red Medical Case", SPAWNABLE_CATEGORY_FACTION, {-0.80, 0.0}, {SPAWN_FACTION_MEDIC } },
    {11747, "Roll of Bandages", SPAWNABLE_CATEGORY_FACTION, {-0.80, 0.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE, SPAWN_FACTION_DEA} },
    {11748, "Pack of Bandages", SPAWNABLE_CATEGORY_FACTION, {-0.80, 0.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE, SPAWN_FACTION_DEA} },
    {1282, "Small Barrier", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_MEDIC, SPAWN_FACTION_POLICE} },
    {-25202, "Boom Microphone", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {3031, "Small Sat Dish", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {19611, "Microphone Stand", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {-25204, "Field Light", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {19157, "Lighting Rig", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {19143, "Rig Spotlight", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {1436, "Scaffholding", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {1840, "Speaker", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS} },
    {3350, "Toreno's Speaker", SPAWNABLE_CATEGORY_FACTION, {-0.45, 0.0}, {SPAWN_FACTION_NEWS, SPAWN_FACTION_DEA} },
    {-25270, "Lifepak Defibrillator", SPAWNABLE_CATEGORY_FACTION, {-0.80, 0.0}, {SPAWN_FACTION_MEDIC } },
    {1997, "Stretcher", SPAWNABLE_CATEGORY_FACTION, {-0.80, 0.0}, {SPAWN_FACTION_MEDIC } },
    {-25275, "Badge (DEA)", SPAWNABLE_CATEGORY_FACTION, {0.0, 0.0}, {SPAWN_FACTION_DEA } },
    {18671, "Carwash Spray Effect", SPAWNABLE_CATEGORY_FACTION, {0.0, 0.0}, {SPAWN_FACTION_MEDIC } },
    {18687, "Fire Extinguisher Spray", SPAWNABLE_CATEGORY_FACTION, {0.0, 0.0}, {SPAWN_FACTION_MEDIC } },
    {18694, "Flamethrower", SPAWNABLE_CATEGORY_FACTION, {0.0, 0.0}, {SPAWN_FACTION_MEDIC } },
    {18747, "Waterfall Spray Effect", SPAWNABLE_CATEGORY_FACTION, {0.0, 0.0}, {SPAWN_FACTION_MEDIC } },

    {321, "Purple Dildo", SPAWNABLE_CATEGORY_WEAPON },
    {322, "White Dildo", SPAWNABLE_CATEGORY_WEAPON }, 
    {371, "Parachute", SPAWNABLE_CATEGORY_WEAPON },
    {19626, "Shovel", SPAWNABLE_CATEGORY_WEAPON },
    {325, "Flowers", SPAWNABLE_CATEGORY_WEAPON },
    {19914, "Baseball Bat", SPAWNABLE_CATEGORY_WEAPON },
    {338, "Pool Cue", SPAWNABLE_CATEGORY_WEAPON },
    {333, "Golf Club", SPAWNABLE_CATEGORY_WEAPON },
    {365, "Spray Can", SPAWNABLE_CATEGORY_WEAPON },
    {330, "Cellphone", SPAWNABLE_CATEGORY_WEAPON },
    {328, "Red Gun Box", SPAWNABLE_CATEGORY_WEAPON },

    {11718, "Saucepan", SPAWNABLE_CATEGORY_FOOD },
    {19581, "Frying Pan", SPAWNABLE_CATEGORY_FOOD },
    {11744, "Plate", SPAWNABLE_CATEGORY_FOOD },
    {19993, "Bowl", SPAWNABLE_CATEGORY_FOOD },
    {19320, "Pumpkin", SPAWNABLE_CATEGORY_FOOD },
    {19346, "Hotdog", SPAWNABLE_CATEGORY_FOOD },
    {19582, "Raw Steak", SPAWNABLE_CATEGORY_FOOD },
    {19882, "Cooked Steak", SPAWNABLE_CATEGORY_FOOD },
    {19630, "Fish", SPAWNABLE_CATEGORY_FOOD },
    {19579, "Bread Loaf", SPAWNABLE_CATEGORY_FOOD },
    {19883, "Bread Slice", SPAWNABLE_CATEGORY_FOOD },
    {19847, "Hambone", SPAWNABLE_CATEGORY_FOOD },
    {19563, "Orange Juice", SPAWNABLE_CATEGORY_FOOD },
    {19564, "Apple Juice", SPAWNABLE_CATEGORY_FOOD },
    {19567, "Ice Cream", SPAWNABLE_CATEGORY_FOOD },
    {19569, "Milk Carton", SPAWNABLE_CATEGORY_FOOD },
    {19570, "Milk Bottle", SPAWNABLE_CATEGORY_FOOD },
    {19572, "Pack of Beer", SPAWNABLE_CATEGORY_FOOD },
    {19571, "Pizza Box", SPAWNABLE_CATEGORY_FOOD },
    {19580, "Pizza", SPAWNABLE_CATEGORY_FOOD },
    {19525, "Wedding Cake", SPAWNABLE_CATEGORY_FOOD },
    {19811, "Burger Box", SPAWNABLE_CATEGORY_FOOD },
    {2768, "Chicken Burger Box", SPAWNABLE_CATEGORY_FOOD },
    {1546, "Sprunk Cup", SPAWNABLE_CATEGORY_FOOD },
    {2647, "Soda Cup", SPAWNABLE_CATEGORY_FOOD },
    {2601, "Sprunk Can", SPAWNABLE_CATEGORY_FOOD },
    {1666, "Beer Glass", SPAWNABLE_CATEGORY_FOOD },
    {19818, "Wine Glass", SPAWNABLE_CATEGORY_FOOD },
    {19819, "Cocktail Glass", SPAWNABLE_CATEGORY_FOOD },
    {19823, "Whiskey Bottle", SPAWNABLE_CATEGORY_FOOD },
    {19822, "Wine Bottle", SPAWNABLE_CATEGORY_FOOD },
    {1668, "Vodka Bottle", SPAWNABLE_CATEGORY_FOOD },
    {1544, "Beer Bottle", SPAWNABLE_CATEGORY_FOOD },
    {19835, "Coffee Cup", SPAWNABLE_CATEGORY_FOOD },
    {11722, "Ketchup", SPAWNABLE_CATEGORY_FOOD },
    {11723, "Mustard", SPAWNABLE_CATEGORY_FOOD },
    {2663, "Takeway Food Bag", SPAWNABLE_CATEGORY_FOOD },

    {2751, "Hair Cream", SPAWNABLE_CATEGORY_PERSONAL },
    {1644, "Suncream", SPAWNABLE_CATEGORY_PERSONAL },
    {2709, "Pills Bottle", SPAWNABLE_CATEGORY_PERSONAL },
    {2752, "Deoderant", SPAWNABLE_CATEGORY_PERSONAL },
    {2749, "Hair Spray", SPAWNABLE_CATEGORY_PERSONAL },
    {-25176, "Cleaning Spray", SPAWNABLE_CATEGORY_PERSONAL },
    {-25177, "Box of Tissues", SPAWNABLE_CATEGORY_PERSONAL },
    {-25179, "Towel Roll", SPAWNABLE_CATEGORY_PERSONAL },
    {-25180, "Medicine Bottle", SPAWNABLE_CATEGORY_MISC },
    {11747, "Roll of Bandages", SPAWNABLE_CATEGORY_PERSONAL },
    {19874, "Soap", SPAWNABLE_CATEGORY_PERSONAL },
    {2750, "Hair Dryer", SPAWNABLE_CATEGORY_PERSONAL },
    {1210, "Briefcase", SPAWNABLE_CATEGORY_PERSONAL },
    {19624, "Suitcase", SPAWNABLE_CATEGORY_PERSONAL },
    //{19894, "Closed Laptop", SPAWNABLE_CATEGORY_PERSONAL },
    //{19893, "Open Laptop", SPAWNABLE_CATEGORY_PERSONAL },
    {19897, "Pack of Smokes", SPAWNABLE_CATEGORY_PERSONAL },
    {19878, "Skateboard", SPAWNABLE_CATEGORY_PERSONAL },
    {1598, "Beach Ball", SPAWNABLE_CATEGORY_PERSONAL },
    {3065, "Basket Ball", SPAWNABLE_CATEGORY_PERSONAL },
    {1641, "Blue Beach Towel", SPAWNABLE_CATEGORY_PERSONAL },
    {1640, "Green Beach Towel", SPAWNABLE_CATEGORY_PERSONAL },
    {1642, "Red Beach Towel", SPAWNABLE_CATEGORY_PERSONAL },
    {1643, "Yellow Beach Towel", SPAWNABLE_CATEGORY_PERSONAL },
    {2406, "Vice City Surfboard", SPAWNABLE_CATEGORY_PERSONAL },
    {2404, "R* Surfboard", SPAWNABLE_CATEGORY_PERSONAL },
    {2891, "White Package", SPAWNABLE_CATEGORY_PERSONAL },
    {1279, "Taped Package", SPAWNABLE_CATEGORY_PERSONAL },
    {1575, "Drugs Package", SPAWNABLE_CATEGORY_PERSONAL },
    {2901, "Weed", SPAWNABLE_CATEGORY_PERSONAL },

    {1665, "Ashtray", SPAWNABLE_CATEGORY_MISC },
    {19527, "Cauldron", SPAWNABLE_CATEGORY_MISC },
    {19614, "Guitar Amp", SPAWNABLE_CATEGORY_MISC },
    {19632, "Campfire", SPAWNABLE_CATEGORY_MISC },
    {19809, "Metal Tray", SPAWNABLE_CATEGORY_MISC },
    {19812, "Keg of Beer", SPAWNABLE_CATEGORY_MISC },
    {19816, "Oxygen Cylinder", SPAWNABLE_CATEGORY_MISC },
    {920, "Power Generator", SPAWNABLE_CATEGORY_MISC },
    {19831, "BBQ Grill", SPAWNABLE_CATEGORY_MISC },
    {19573, "BBQ Briquettes Bag", SPAWNABLE_CATEGORY_MISC }, 
    {19944, "Body Bag", SPAWNABLE_CATEGORY_MISC },
    {19997, "Small Wooden Table", SPAWNABLE_CATEGORY_MISC },
    {19922, "Large Wooden Tabke", SPAWNABLE_CATEGORY_MISC },
    {3041, "Outdoors Food Table", SPAWNABLE_CATEGORY_MISC },
    {19996, "Metal Folding Chair", SPAWNABLE_CATEGORY_MISC },
    {2121, "Red Folding Chair", SPAWNABLE_CATEGORY_MISC },
    {2295, "Beanbag Chair", SPAWNABLE_CATEGORY_MISC },
    {1805, "Red Bar Stool", SPAWNABLE_CATEGORY_MISC },
    {2723, "Strip Club Stool", SPAWNABLE_CATEGORY_MISC },
    {11734, "Rocking Chair", SPAWNABLE_CATEGORY_MISC },
    {19471, "For Sale Sign", SPAWNABLE_CATEGORY_MISC },
    {19611, "Microphone Stand", SPAWNABLE_CATEGORY_MISC },
    {19610, "Microphone", SPAWNABLE_CATEGORY_MISC },
    {19918, "Black Storage Box", SPAWNABLE_CATEGORY_MISC },
    {2894, "Madd Dogg's Rhymes Book", SPAWNABLE_CATEGORY_MISC },
    {11745, "Duffle Bag", SPAWNABLE_CATEGORY_MISC },
    {19088, "Rope Noose", SPAWNABLE_CATEGORY_MISC },
    {3017, "Blueprints", SPAWNABLE_CATEGORY_MISC },
    {1550, "Bag of Money", SPAWNABLE_CATEGORY_MISC },
    {-25159, "Box of Documents", SPAWNABLE_CATEGORY_MISC },
    {-25160, "Ham Radio Set", SPAWNABLE_CATEGORY_MISC },
    {-25161, "Document Pile", SPAWNABLE_CATEGORY_MISC },
    {-25162, "Papers Pile", SPAWNABLE_CATEGORY_MISC },
    {-25164, "Wad of Cash", SPAWNABLE_CATEGORY_MISC },
    {-25172, "B-Dup's Bed", SPAWNABLE_CATEGORY_MISC },
    {-25173, "B-Dup's Drugs", SPAWNABLE_CATEGORY_MISC },
    {-25174, "B-Dup's Ledger", SPAWNABLE_CATEGORY_MISC },
    {-25175, "B-Dup's Radio", SPAWNABLE_CATEGORY_MISC },
    {-25181, "Plastic Storage Bin", SPAWNABLE_CATEGORY_MISC },
    {19159, "Disco Ball", SPAWNABLE_CATEGORY_MISC },
    {19919, "Perch", SPAWNABLE_CATEGORY_MISC },
    {-25272, "Metal Briefcase", SPAWNABLE_CATEGORY_MISC },
    {-25273, "Briefcase (Drugs)", SPAWNABLE_CATEGORY_MISC },
    {-25274, "Briefcase (Cash)", SPAWNABLE_CATEGORY_MISC },
    {-25271, "Briefcase (Empty)", SPAWNABLE_CATEGORY_MISC },
    {2773, "Velvet Rope Barrier", SPAWNABLE_CATEGORY_MISC },
    {1340, "Chilli Dog Cart", SPAWNABLE_CATEGORY_MISC},

    {2386, "Pile of Jeans", SPAWNABLE_CATEGORY_CLOTHES },
    {2384, "Pile of Chinos", SPAWNABLE_CATEGORY_CLOTHES },
    {11735, "Leather Boot", SPAWNABLE_CATEGORY_CLOTHES },
    {-25165, "Lilac Dress", SPAWNABLE_CATEGORY_CLOTHES },
    {-25166, "Pink Heels", SPAWNABLE_CATEGORY_CLOTHES },
    {-25167, "Black Heels", SPAWNABLE_CATEGORY_CLOTHES },
    {-25168, "Red Heels", SPAWNABLE_CATEGORY_CLOTHES },
    {-25169, "Nude Heels", SPAWNABLE_CATEGORY_CLOTHES },
    {-25170, "Lilac Heels", SPAWNABLE_CATEGORY_CLOTHES },
    {2843, "Small Clothing Pile", SPAWNABLE_CATEGORY_CLOTHES },
    {2819, "Med. Clothing Pile", SPAWNABLE_CATEGORY_CLOTHES},
    {2845, "Big Clothing Pile", SPAWNABLE_CATEGORY_CLOTHES},
    {2694, "Shoebox", SPAWNABLE_CATEGORY_CLOTHES},

    {19836, "Blood Pool", SPAWNABLE_CATEGORY_DECOR },
    {19898, "Oil Slick", SPAWNABLE_CATEGORY_DECOR },
    {2906, "Bloody Limb", SPAWNABLE_CATEGORY_DECOR },
    {18693, "Small Flame", SPAWNABLE_CATEGORY_DECOR },
    {18701, "Molotov Flame", SPAWNABLE_CATEGORY_DECOR },
    {18718, "Sparks", SPAWNABLE_CATEGORY_DECOR },
    {18735, "Vent Smoke", SPAWNABLE_CATEGORY_DECOR },
    {18673, "Cigarette Smoke", SPAWNABLE_CATEGORY_DECOR },
    {18660, "Seville Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18661, "Aztecas Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18662, "KT Ballas Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18663, "Rifa Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18664, "TD Ballas Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18665, "Vagos Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18666, "FY Ballas Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18667, "RH Ballas Graffiti", SPAWNABLE_CATEGORY_DECOR },
    {18659, "Grove St. Graffiti", SPAWNABLE_CATEGORY_DECOR },

    {2856, "Milk Cartons", SPAWNABLE_CATEGORY_TRASH },
    {2823, "Cluckin Bell Boxes", SPAWNABLE_CATEGORY_TRASH },
    {2830, "Dirty Plates", SPAWNABLE_CATEGORY_TRASH },
    {2860, "Used Pizza Box", SPAWNABLE_CATEGORY_TRASH },
    {2342, "Used Donut Tray", SPAWNABLE_CATEGORY_TRASH },
    {1265, "Trash Bag", SPAWNABLE_CATEGORY_TRASH},

    {-25159, "Box of Documents", SPAWNABLE_CATEGORY_CARRY, {0.06, -0.06, -0.17, -109.19, 0.00, -9.09} },
    {19918, "Black Storage Box", SPAWNABLE_CATEGORY_CARRY, {0.00, 0.00, -0.12, -112.09, 0.00, 73.90} },
    {1575, "Drugs Package", SPAWNABLE_CATEGORY_CARRY, {0.00, 0.00, -0.11, -108.50, 0.00, 87.80} },
    {2694, "Shoebox", SPAWNABLE_CATEGORY_CARRY, {0.00, 0.08, -0.15, -111.19, 0.00, 0.00} },
    {19809, "Metal Tray", SPAWNABLE_CATEGORY_CARRY, {0.08, 0.06, -0.14, -111.59, 0.00, 0.00} },
    {2894, "Madd Dogg's Rhymes Book", SPAWNABLE_CATEGORY_CARRY, {0.12, 0.01, -0.14, -109.19, 0.00, 86.20} },
    //{19893, "Open Laptop", SPAWNABLE_CATEGORY_CARRY },
    {19573, "BBQ Briquettes Bag", SPAWNABLE_CATEGORY_CARRY, {0.03, 0.00, -0.42, -6.09, 0.00, 0.00} },
    {2663, "Takeway Food Bag", SPAWNABLE_CATEGORY_CARRY, {0.02, 0.19, -0.16, -105.59, -17.69, 83.79} },
    {19571, "Pizza Box", SPAWNABLE_CATEGORY_CARRY, {0.07, -0.02, -0.33, -18.79, -12.10, 0.00} },
    {19572, "Pack of Beer", SPAWNABLE_CATEGORY_CARRY, {-0.00, 0.00, -0.13, -105.19, -0.10, 80.39} },
    {2218, "Well Stacked Pizza Tray", SPAWNABLE_CATEGORY_CARRY, {0.11, -0.03, -0.44, 264.0, -36.0, 153.0} },
    {2213, "Burgershot Food Tray", SPAWNABLE_CATEGORY_CARRY, {0.11, -0.03, -0.44, 264.0, -36.0, 153.0} },
    {2215, "Cluckin' Bell Food Tray", SPAWNABLE_CATEGORY_CARRY, { 0.11, -0.03, -0.44, 264.0, -36.0, 153.0} },
    {2221, "Donut Food Tray", SPAWNABLE_CATEGORY_CARRY, {0.04, 0.07, -0.21, -111.0, -6.0, -12.0} },
    {2355, "Salad Food Tray", SPAWNABLE_CATEGORY_CARRY, {0.04, 0.07, -0.21, -111.0, -6.0, -12.0} },
    {-25273, "Briefcase (Drugs)", SPAWNABLE_CATEGORY_CARRY, {0.06, -0.06, -0.17, -109.19, 0.00, -9.09} },
    {-25274, "Briefcase (Cash)", SPAWNABLE_CATEGORY_CARRY, {0.06, -0.06, -0.17, -109.19, 0.00, -9.09} },
    {-25271, "Briefcase (Empty)", SPAWNABLE_CATEGORY_CARRY, {0.06, -0.06, -0.17, -109.19, 0.00, -9.09} }
};

forward SpawnablesTimer_Tick();
public SpawnablesTimer_Tick()
{
    new timenow = gettime();
    for (new i = 0; i < MAX_SPAWNABLES; i ++)
    {
        if (!IsValidSpawnable(i)) continue; 

        if (timenow - SpawnableData[i][spTimestamp] > SpawnableData[i][spTimeout])
        {
            // When a spawnable expires, first destroy the actual object.
            if (IsValidDynamicObject(SpawnableData[i][spObjectId]))
            {
                DestroyDynamicObject(SpawnableData[i][spObjectId]);
                printf("Spawnable %d by %s timed out (model: %d, spobjectid: %d).", i, SpawnableData[i][spPlayerName], GetDynamicObjectModel(SpawnableData[i][spObjectId]), SpawnableData[i][spObjectId]);
            }
            else
            {
                printf("Spawnable %d by %s timed out (spobjectid: %d) - warning: dynobj wasn't valid.", i, SpawnableData[i][spPlayerName], SpawnableData[i][spObjectId]);
            }

            // Then invalidate the spawnable id so it isn't recreated and disappears from the lists.
            SpawnableData[i][spObjectId] = INVALID_OBJECT_ID;
            continue;
        }

        if (!IsValidDynamicObject(SpawnableData[i][spObjectId]))
        {
            // The spawnable is valid but the object isn't - recreate the object
            new model = SpawnableData[i][spCustomModelId];
            new Float:drawdistance = 0.0;

            if (!model)
            {
                model = SpawnableModels[SpawnableData[i][spSpawnableModelId]][spmModel];
                drawdistance = SpawnableModels[SpawnableData[i][spSpawnableModelId]][spmDrawDistance];
            } 
            
            if (drawdistance == 0.0) drawdistance = 100.0;

            new newid = CreateDynamicObject(model, SpawnableData[i][spPos][0], SpawnableData[i][spPos][1], SpawnableData[i][spPos][2], SpawnableData[i][spPos][3], SpawnableData[i][spPos][4], SpawnableData[i][spPos][5], SpawnableData[i][spWorld], SpawnableData[i][spInterior], -1, drawdistance, drawdistance, -1, -1);
            printf("Spawnable %d by %s had to be recreated (old spobjid: %d, new spobjid: %d).", i, SpawnableData[i][spPlayerName], SpawnableData[i][spObjectId], newid);
            SpawnableData[i][spObjectId] = newid;
        }
    }
}

GetSpawnableName(model)
{
    new name[32] = "N/A";

    if (model)
    {
        format(name, sizeof(name), "Custom (%d)", model);
    }

    for (new i = 0; i < sizeof(SpawnableModels); i ++)
    {
        if (SpawnableModels[i][spmModel] == model)
        {
            format(name, sizeof(name), "%s", SpawnableModels[i][spmName]);
            break;
        }
    }

    return name;
}

new SpawnableItemsMap[MAX_PLAYERS][MAX_SPAWNABLES_IN_CAT];
new SpwanableCat[MAX_PLAYERS];

new SpawnableDlgStr[4000];

ShowSpawnCmdDlg(playerid)
{
    format(SpawnableDlgStr, sizeof(SpawnableDlgStr), "");
    for (new i = 0; i < sizeof(SpawnableCategories); i ++)
    {
        format(SpawnableDlgStr, sizeof(SpawnableDlgStr), "%s%s\n", SpawnableDlgStr, SpawnableCategories[i]);
    }

    inline SpawnableCats(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem

        if (response && listitem < MAX_SPAWNABLE_CATEGORIES) ShowSpawnCatDlg(playerid, listitem);
    }

    Dialog_ShowCallback ( playerid, using inline SpawnableCats, DIALOG_STYLE_LIST, "Select Category", SpawnableDlgStr, "Select ", "Back" );

    return 1;
}

static bool:ArrayContains(const array[], size, value)
{
    for (new i = 0; i < size; i ++)
    {
        if (array[i] == value) return true;
    }

    return false;
}

ShowSpawnCatDlg(playerid, cat)
{
    SpwanableCat[playerid] = cat;

    new faction = GetPlayerFactionType(playerid);
    new index = 0;

    // Reset the map
    for (new i = 0; i < MAX_SPAWNABLES_IN_CAT; i ++)
    {
        SpawnableItemsMap[playerid][i] = -1;
    }

    format(SpawnableDlgStr, sizeof(SpawnableDlgStr), "Spawnable Name\tID\n");
    for (new i = 0; i < sizeof(SpawnableModels); i ++)
    {
        if (index == MAX_SPAWNABLES_IN_CAT) break;
        if (SpawnableModels[i][spmCategory] != cat) continue;
        if (SpawnableModels[i][spmFactions] && !ArrayContains(SpawnableModels[i][spmFactions], MAX_FACTION_TYPES, faction + 1)) continue; // faction + 1 here as types start at 0, and no faction is -1
        
        format(SpawnableDlgStr, sizeof(SpawnableDlgStr), "%s%s\t%d\n", SpawnableDlgStr, SpawnableModels[i][spmName], i);
        SpawnableItemsMap[playerid][index] = i; 
        index ++;
    }

    if (index == 0)
    {
        // No items
        ShowSpawnCmdDlg(playerid);
        return 1;
    }

    inline SpawnableItems(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem

        if (!response) return ShowSpawnCmdDlg(playerid);
        
        if (listitem < MAX_SPAWNABLES_IN_CAT && SpawnableItemsMap[playerid][listitem] != -1)
        {
            new cmdstr[24];
            format(cmdstr, sizeof(cmdstr), "%d", SpawnableItemsMap[playerid][listitem]);
            cmd_spawn(playerid, cmdstr); 
        }
    }

    Dialog_ShowCallback ( playerid, using inline SpawnableItems, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Item", SpawnableDlgStr, "Spawn", "Back" );

    return 1;
}

ShowFirstSpanableDlg(playerid)
{
    //format(SpawnableDlgStr, sizeof(SpawnableDlgStr), "{FFFFFF}You are about to create a new Spawnable.");
    //strcat(SpawnableDlgStr, "\n{ADBEE6}Please read the following before continuing.\n\n");

    format(SpawnableDlgStr, sizeof(SpawnableDlgStr), "{FFFFFF}Introduction to Spawnables:{ADBEE6}\n");
    // strcat(SpawnableDlgStr, "{FFFFFF}Introduction to Spawnables:{ADBEE6}\n");
    strcat(SpawnableDlgStr, "- Spawnables are our unique system on SP:RP for spawning small objects and props for roleplay purposes.\n");
    strcat(SpawnableDlgStr, "- You can use these to decorate your scenes for screenshots or add in items that your character would be using.\n");
    strcat(SpawnableDlgStr, "- Each Spawnable is automatically deleted after two hours, or can be removed manually in {8D8DFF}/myspawns{ADBEE6}.\n");
    strcat(SpawnableDlgStr, "- Most factions have their own set of unique Spawnables like police roadblocks for example.\n");

    strcat(SpawnableDlgStr, "\n{FFFFFF}Rules for Spawnables:{ADBEE6}\n");
    strcat(SpawnableDlgStr, "- Spawnables should only be created for proper in-character (IC) purposes.\n");
    strcat(SpawnableDlgStr, "- Don't abuse the system to troll, interfere with other scenes, or create random items.\n");
    strcat(SpawnableDlgStr, "- Spawning items should only be done to make things more realistic, not to powergame or stall.\n");
    strcat(SpawnableDlgStr, "- Don't create items that your character does not actually have or could not currently use.\n");
    strcat(SpawnableDlgStr, "- Only create spawnables with agreement from other players involved, and after any roleplay.\n");

    strcat(SpawnableDlgStr, "\n{FFFFFF}Examples for Spawnables:{ADBEE6}\n");    
    strcat(SpawnableDlgStr, "- Placing down a beach towel to sit on while roleplaying at the beach.\n");
    strcat(SpawnableDlgStr, "- Spawning a coffee and snack for your desk inside an interior.\n");
    strcat(SpawnableDlgStr, "- Decorating a violent roleplay scene that has taken place with blood splatters.\n");
    strcat(SpawnableDlgStr, "- Creating an actual chair object for someone to sit on after appropriate roleplay.\n");
    
    strcat(SpawnableDlgStr, "\n{FFFFFF}Press {AA3333}OK{FFFFFF} to continue.\n{AA3333}By continuing, you agree to the rules above.");

    inline FirstSpawnableDlg(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem
        if (response)
        {
            pFirstSpawnable[playerid] = 0;
            cmd_spawn(playerid, "\1");
        }
    }

    Dialog_ShowCallback ( playerid, using inline FirstSpawnableDlg, DIALOG_STYLE_MSGBOX, "Spawnables", SpawnableDlgStr, "OK", "Back" );

}

CMD:customspawn(playerid, params[])
{
    if ( GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR ) 
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "You don't have permission to access this command." ) ;
    }

    if (!CanUseSpawnables(playerid) && !pCarryObject[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "You can't use spawnables just now.");

    if (pSpawnerObject[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "You are already creating a spawnable.");

    new model, Float:drawdistance, timeout;
    if (sscanf(params, "dF(100.0)D(60)", model, drawdistance, timeout))
    {
        return SendClientMessage(playerid, COLOR_ERROR, "USAGE: /customspawn [model id] [drawdistance | 100.0] [minutes | 60]");
    }

    if (timeout < 10 || timeout > 10080)
    {
        return SendClientMessage(playerid, COLOR_ERROR, "ERROR: Spawnable duration must be between 10 and 10800 minutes (default: 60)");
    }

    timeout = timeout * 60;

    // Spawn it
    new spawnableid = -1;

    for (new i = 0; i < MAX_SPAWNABLES; i ++)
    {
        if (!IsValidSpawnable(i))
        {
            // Find the first invalid spawnable id and use it as the id for this new one
            spawnableid = i;
            break;
        } 
    }

    new playername[32];
    GetPlayerName(playerid, playername, 32);

    if (spawnableid == -1)
    {
        // If the spawnable is still -1 (there was no free id) then we use the oldest spawnable this player has and replace it
        new current;
        new last = gettime();

        for (new i = 0; i < MAX_SPAWNABLES; i ++)
        {
            if (!IsValidSpawnable(i)) continue; // Check it's a valid spawnable
            if (strcmp(SpawnableData[i][spPlayerName], playername)) continue; // Check it's owned by this player

            current = SpawnableData[i][spTimestamp];
            
            if (current < last)
            {
                spawnableid = i;
                last = current;
            }
        }
    }

    if (spawnableid == -1)
    {
        return SendClientMessage(playerid, COLOR_ERROR, "There is no spawnable capacity left.");
    }

    new obj = SpawnObject_InfrontOfPlayer(playerid, model, 0.0, 0.0, drawdistance);

    if (IsValidDynamicObject(obj)) 
    {
        SpawnableData[spawnableid][spObjectId] = obj;
        SpawnableData[spawnableid][spTimestamp] = gettime();
        SpawnableData[spawnableid][spPlayerName] = playername;
        // SpawnableData[spawnableid][spFaction] = GetFactionType(playerid);
        SpawnableData[spawnableid][spSpawnableModelId] = 0;
        SpawnableData[spawnableid][spCustomModelId] = model;
        SpawnableData[spawnableid][spInterior] = GetPlayerInterior(playerid);
        SpawnableData[spawnableid][spWorld] = GetPlayerInterior(playerid);
        SpawnableData[spawnableid][spTimeout] = timeout; // custom timeout
        pSpawnerSpawnableId[playerid] = spawnableid;

        EditDynamicObject(playerid, obj);
        pSpawnerObject[playerid] = obj;

        GetPlayerPos(playerid, pSpawnerPos[playerid][0], pSpawnerPos[playerid][1], pSpawnerPos[playerid][2]);
        GetPlayerFacingAngle(playerid, pSpawnerPos[playerid][3]); 

        pEditingSpawnable[playerid] = 1;
    }
    
    return 1;
}

CMD:spawn(playerid, const params[])
{
    if (!CanUseSpawnCmd(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "You must have 8 playing hours to use spawnables.");

    if (!CanUseSpawnables(playerid) && !pCarryObject[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "You can't use spawnables just now.");

    if (pSpawnerObject[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "You are already creating a spawnable.");

    new index = -1;
    sscanf(params, "D(-1)", index);

    if (index == -1)
    {
     
        if (pFirstSpawnable[playerid])
        {
            ShowFirstSpanableDlg(playerid);
            return 1;
        }
        

        // Show the list.
        ShowSpawnCmdDlg(playerid);
        return 1;
    }

    else if (index < 0 || index > sizeof(SpawnableModels)) {

        SendClientMessage(playerid, COLOR_ERROR, "/spawn [spawnable id]");
        return 1;
    }

    // Spawn it
    new spawnableid = -1;

    for (new i = 0; i < MAX_SPAWNABLES; i ++)
    {
        if (!IsValidSpawnable(i))
        {
            // Find the first invalid spawnable id and use it as the id for this new one
            spawnableid = i;
            break;
        } 
    }

    new playername[32];
    GetPlayerName(playerid, playername, 32);

    if (spawnableid == -1)
    {
        // If the spawnable is still -1 (there was no free id) then we use the oldest spawnable this player has and replace it
        new current;
        new last = gettime();

        for (new i = 0; i < MAX_SPAWNABLES; i ++)
        {
            if (!IsValidSpawnable(i)) continue; // Check it's a valid spawnable
            if (strcmp(SpawnableData[i][spPlayerName], playername)) continue; // Check it's owned by this player

            current = SpawnableData[i][spTimestamp];
            
            if (current < last)
            {
                spawnableid = i;
                last = current;
            }
        }
    }

    if (spawnableid == -1)
    {
        return SendClientMessage(playerid, COLOR_ERROR, "There is no spawnable capacity left.");
    }

    if (SpawnableModels[index][spmFactions] && !ArrayContains(SpawnableModels[index][spmFactions], MAX_FACTION_TYPES, GetPlayerFactionType(playerid) + 1)) // faction + 1 here as types start at 0, and no faction is -1
    {
        return SendClientMessage(playerid, COLOR_ERROR, "You don't have permission to use this Spawnable ID.");
    }
    
    new model = SpawnableModels[index][spmModel];
    new Float:drawdistance = SpawnableModels[index][spmDrawDistance];
    if (drawdistance == 0.0) drawdistance = 100.0;

    if (SpawnableModels[index][spmCategory] == SPAWNABLE_CATEGORY_CARRY)
    {
        // Special carry behavior.
        SetPlayerArmedWeapon(playerid, 0);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        RemovePlayerAttachedObject(playerid,9);

        SetPlayerAttachedObject(playerid, 9, model, 6,
            SpawnableModels[index][spmPlacementOffset][0], SpawnableModels[index][spmPlacementOffset][1], SpawnableModels[index][spmPlacementOffset][2],
            SpawnableModels[index][spmPlacementOffset][3],SpawnableModels[index][spmPlacementOffset][4],SpawnableModels[index][spmPlacementOffset][5],
        1.00,1.00,1.00);

        PlayerVar [ playerid ] [ E_PLAYER_ATTACH_EDIT_TYPE ] = EDIT_TYPE_NONE ;

        EditAttachedObject(playerid, 9);
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 0, 0, 0, 0);
        
        
        pCarryObject[playerid] = model;
        pEditingSpawnable[playerid] = 1;
        return 1;
    }

    new obj = SpawnObject_InfrontOfPlayer(playerid, model, SpawnableModels[index][spmPlacementOffset][0], SpawnableModels[index][spmPlacementOffset][1], drawdistance);

    if (IsValidDynamicObject(obj)) 
    {
        SpawnableData[spawnableid][spObjectId] = obj;
        SpawnableData[spawnableid][spTimestamp] = gettime();
        SpawnableData[spawnableid][spPlayerName] = playername;
        // SpawnableData[spawnableid][spFaction] = GetFactionType(playerid);
        SpawnableData[spawnableid][spSpawnableModelId] = index;
        SpawnableData[spawnableid][spInterior] = GetPlayerInterior(playerid);
        SpawnableData[spawnableid][spWorld] = GetPlayerInterior(playerid);
        SpawnableData[spawnableid][spCustomModelId] = 0;
        SpawnableData[spawnableid][spTimeout] = SPAWNABLE_MAX_DURATION; // default 3600
        pSpawnerSpawnableId[playerid] = spawnableid;

        EditDynamicObject(playerid, obj);
        pSpawnerObject[playerid] = obj;

        GetPlayerPos(playerid, pSpawnerPos[playerid][0], pSpawnerPos[playerid][1], pSpawnerPos[playerid][2]);
        GetPlayerFacingAngle(playerid, pSpawnerPos[playerid][3]); 

        pEditingSpawnable[playerid] = 1;
    }
    
    return 1;
}

CMD:allspawns(playerid)
{
    if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_JUNIOR ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "You don't have permission to access this command." ) ;
    }

    new objectid, model, Float:pos[3], count;
    // new faction;
    format(SpawnerDlgStr, sizeof(SpawnerDlgStr), "ID\tType\tPlayer\tDistance");

    new map[MAX_SPAWNABLES] = { -1, ... };
    for (new i = 0; i < MAX_SPAWNABLES; i ++)
    {
        if (!IsValidSpawnable(i)) continue; // Don't show invalid spawnables

        map[count] = i;
        count ++;
        objectid = SpawnableData[i][spObjectId];
        model = GetDynamicObjectModel(objectid);
        // faction = SpawnableData[i][spFaction];
        GetDynamicObjectPos(objectid, pos[0], pos[1], pos[2]);
        format(SpawnerDlgStr, sizeof(SpawnerDlgStr), "%s\n%d\t%s\t%s\t%.2fm", SpawnerDlgStr, i, GetSpawnableName(model), SpawnableData[i][spPlayerName], GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]));
    }

    if (!count) return SendClientMessage(playerid, COLOR_ERROR, "There are no spawnables placed.");


    inline ListAllSpawnables(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem
        if (response) 
        {
            // new map[MAX_SPAWNABLES];
            new selected = map[listitem];

            if (IsValidSpawnable(selected))
            {
                // When a spawnable is deleted, first destroy the actual object.
                if (IsValidDynamicObject(SpawnableData[selected][spObjectId]))
                {
                    DestroyDynamicObject(SpawnableData[selected][spObjectId]);
                    printf("Spawnable %d by %s was admin-deleted (spobjectid: %d).", selected, SpawnableData[selected][spPlayerName], SpawnableData[selected][spObjectId]);
                }
                else
                {
                    printf("Spawnable %d by %s was admin-deleted (spobjectid: %d) - warning: dynobj wasn't valid.", selected, SpawnableData[selected][spPlayerName], SpawnableData[selected][spObjectId]);
                }

                // Then invalidate the spawnable id so it isn't recreated and disappears from the lists.
                SpawnableData[selected][spObjectId] = INVALID_OBJECT_ID;
            }
        }
    }

    Dialog_ShowCallback ( playerid, using inline ListAllSpawnables, DIALOG_STYLE_TABLIST_HEADERS, "All Spawnables", SpawnerDlgStr, "Delete", "Back" );


    return 1;
}

CMD:myspawns(playerid)
{   
    new objectid, model, Float:pos[3], count, playername[32];
    // new faction;
    GetPlayerName(playerid, playername, 32);
    format(SpawnerDlgStr, sizeof(SpawnerDlgStr), "ID\tType\tDistance");

    new map[MAX_SPAWNABLES] = { -1, ... };

    for (new i = 0; i < MAX_SPAWNABLES; i ++)
    {
        if (!IsValidSpawnable(i) || strcmp(SpawnableData[i][spPlayerName], playername))
        {
            continue;
        }

        map[count] = i;
        count ++;
        objectid = SpawnableData[i][spObjectId];
        model = GetDynamicObjectModel(objectid);
        // faction = SpawnableData[i][spFaction];
        GetDynamicObjectPos(objectid, pos[0], pos[1], pos[2]);
        format(SpawnerDlgStr, sizeof(SpawnerDlgStr), "%s\n%d\t%s\t%.2fm", SpawnerDlgStr, i, GetSpawnableName(model), GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]));
    }

    if (!count) return SendClientMessage(playerid, COLOR_ERROR, "You don't have any spawnables placed.");

    inline ListMySpawnables(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem
        if (response) 
        {
            // new map[MAX_SPAWNABLES];
            new selected = map[listitem];
            GetPlayerName(pid, playername, 32);

            if (IsValidSpawnable(selected) && !strcmp(SpawnableData[selected][spPlayerName], playername))
            {
                // New dialog for editing spawnables
                EditSpawnable(playerid, selected);
            }
        }
    }

    Dialog_ShowCallback ( playerid, using inline ListMySpawnables, DIALOG_STYLE_TABLIST_HEADERS, "Your Spawnables", SpawnerDlgStr, "Edit", "Back" );

    return 1;
}

EditSpawnable(playerid, spawnableid)
{
    inline DlgEditSpawnable(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem
        
        if (response) 
        {
            if (listitem == 0) // Edit position
            {
                if (IsValidDynamicObject(SpawnableData[spawnableid][spObjectId]))
                {
                    new Float:objectPos[3], Float:playerPos[3];
                    GetDynamicObjectPos(SpawnableData[spawnableid][spObjectId], objectPos[0], objectPos[1], objectPos[2]);
                    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
                    
                    if (GetPlayerAdminLevel(playerid) <= ADMIN_LVL_JUNIOR && GetDistanceBetweenPoints(playerPos[0], playerPos[1], playerPos[2], objectPos[0], objectPos[1], objectPos[2]) > 7.5)
                    {
                        return SendClientMessage(playerid, COLOR_ERROR, "You are too far away to edit this Spawnable.");
                    }

                    pSpawnerObject[playerid] = SpawnableData[spawnableid][spObjectId];
                    pMovingSpawnable[playerid] = 1;
                    pSpawnerSpawnableId[playerid] = spawnableid;

                    EditDynamicObject(playerid, SpawnableData[spawnableid][spObjectId]);
                }
                else
                {
                    printf("Spawnable %d by %s was edited (spobjectid: %d) - warning: dynobj wasn't valid.", spawnableid, SpawnableData[spawnableid][spPlayerName], SpawnableData[spawnableid][spObjectId]);
                }
            }
            else if (listitem == 1) // Delete spawnable
            {
                // When a spawnable is deleted, first destroy the actual object.
                if (IsValidDynamicObject(SpawnableData[spawnableid][spObjectId]))
                {
                    ShowPlayerFooter(playerid, "~w~Spawnable deleted successfully.");
                    DestroyDynamicObject(SpawnableData[spawnableid][spObjectId]);
                    printf("Spawnable %d by %s was deleted (spobjectid: %d).", spawnableid, SpawnableData[spawnableid][spPlayerName], SpawnableData[spawnableid][spObjectId]);
                }
                else
                {
                    printf("Spawnable %d by %s was deleted (spobjectid: %d) - warning: dynobj wasn't valid.", spawnableid, SpawnableData[spawnableid][spPlayerName], SpawnableData[spawnableid][spObjectId]);
                }

                // Then invalidate the spawnable id so it isn't recreated and disappears from the lists.
                SpawnableData[spawnableid][spObjectId] = INVALID_OBJECT_ID;
            }
        }
    }

    Dialog_ShowCallback ( playerid, using inline DlgEditSpawnable, DIALOG_STYLE_LIST, "Edit Spawnable", "Edit Position\nDelete Spawnable", "Select", "Back" );
    return 1;
}

CancelSpawnableCarry(playerid)
{
    if (pCarryObject[playerid])
    {
        RemovePlayerAttachedObject(playerid, 9);
        //ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
        ClearAnimations(playerid);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

        // Extra SOLS clear / resync        
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
        TRP_ClearAnimations(playerid);
        cmd_stopanim(playerid, "");
    }

    pEditingSpawnable[playerid] = 0;
    pCarryObject[playerid] = 0;
}

CancelSpawnablePlacement(playerid)
{
    new spawnableid = pSpawnerSpawnableId[playerid];
 
    if (pMovingSpawnable[playerid] && spawnableid >= 0 && IsValidDynamicObject(pSpawnerObject[playerid]))
    {
        // Set back to old position
        SetDynamicObjectPos(pSpawnerObject[playerid], SpawnableData[spawnableid][spPos][0], SpawnableData[spawnableid][spPos][1], SpawnableData[spawnableid][spPos][2]);
        SetDynamicObjectRot(pSpawnerObject[playerid], SpawnableData[spawnableid][spPos][3], SpawnableData[spawnableid][spPos][4], SpawnableData[spawnableid][spPos][5]);
    }
    else
    {
        // When a spawnable is deleted, first destroy the actual object.
        if (IsValidDynamicObject(pSpawnerObject[playerid]))
        {
            DestroyDynamicObject(pSpawnerObject[playerid]);
        }

        if (spawnableid >= 0)
        {
            if (IsValidDynamicObject(SpawnableData[spawnableid][spObjectId]))
            {
                DestroyDynamicObject(SpawnableData[spawnableid][spObjectId]);
            }

            // Then invalidate the spawnable id so it isn't recreated and disappears from the lists.
            SpawnableData[spawnableid][spObjectId] = INVALID_OBJECT_ID;
        }
    }

    pSpawnerSpawnableId[playerid] = -1;
    pSpawnerObject[playerid] = 0;
    pEditingSpawnable[playerid] = 0;
    pMovingSpawnable[playerid] = 0;
}

public OnPlayerUpdate(playerid)
{
    if (pSpawnerObject[playerid] && GetPlayerAdminLevel(playerid) <= ADMIN_LVL_JUNIOR)
    {
        if (GetPlayerDistanceFromPoint(playerid, pSpawnerPos[playerid][0], pSpawnerPos[playerid][1], pSpawnerPos[playerid][2]) > 7.5)
        {
            CancelSpawnablePlacement(playerid);
            CancelEdit(playerid);
        }
    }
    
    #if defined spawn_OnPlayerUpdate
        return spawn_OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate spawn_OnPlayerUpdate
#if defined spawn_OnPlayerUpdate
    forward spawn_OnPlayerUpdate(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{

    if (IsPlayerNPC(playerid)) return 1;
    CancelSpawnablePlacement(playerid);

    #if defined spawnables_OnPlayerDisconnect
        return spawnables_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect spawnables_OnPlayerDisconnect
#if defined spawnables_OnPlayerDisconnect
    forward spawnables_OnPlayerDisconnect(playerid, reason);
#endif

Spawnables_OnPlayerDeath(playerid) {

    CancelSpawnablePlacement(playerid);
    CancelEdit(playerid);
    CancelSpawnableCarry(playerid);
    
    return true ;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (pSpawnerObject[playerid] && newstate != PLAYER_STATE_ONFOOT)
    {
        CancelSpawnablePlacement(playerid);
        CancelEdit(playerid);
    }

    if (pCarryObject[playerid] && newstate != PLAYER_STATE_ONFOOT)
    {
        CancelSpawnableCarry(playerid);
    }

    
    #if defined spawnable_OnPlayerStateChange
        return spawnable_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange spawnable_OnPlayerStateChange
#if defined spawnable_OnPlayerStateChange
    forward spawnable_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerConnect(playerid)
{
    pSpawnerObject[playerid] = 0;
    pSpawnerSpawnableId[playerid] = -1;
    pFirstSpawnable[playerid] = 1;
    pCarryObject[playerid] = 0;
    pEditingSpawnable[playerid] = 0;
    pMovingSpawnable[playerid] = 0;
    
    #if defined spawnable_OnPlayerConnect
        return spawnable_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect spawnable_OnPlayerConnect
#if defined spawnable_OnPlayerConnect
    forward spawnable_OnPlayerConnect(playerid);
#endif


public OnGameModeInit()
{
    

    // Don't continue here, see "lspd_int!"

    SetTimer("SpawnablesTimer_Tick", 600000, true);


    for ( new i, j = MAX_SPAWNABLES; i < j ; i ++ ) {
        SpawnableData[i][spObjectId] = INVALID_OBJECT_ID;
    }

    #if defined spawnable_OnGameModeInit
        return spawnable_OnGameModeInit();
    #else
        return 1;
    #endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#define OnGameModeInit spawnable_OnGameModeInit
#if defined spawnable_OnGameModeInit
    forward spawnable_OnGameModeInit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (pCarryObject[playerid] && PRESSED(KEY_SECONDARY_ATTACK))
    {
        CancelSpawnableCarry(playerid);
        HidePlayerFooter(playerid);
    }

    #if defined spawnb_OnPlayerKeyStateChange
        return spawnb_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange spawnb_OnPlayerKeyStateChange
#if defined spawnb_OnPlayerKeyStateChange
    forward spawnb_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

#include <YSI_Coding\y_hooks>

hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
    if (!pCarryObject[playerid]) return 0;

    if ( PlayerVar [ playerid ] [ E_PLAYER_ATTACH_EDIT_TYPE ] ) 
    {
        return 0 ;
    }

    pEditingSpawnable[playerid] = 0;

    if (!response)
    {
        CancelSpawnableCarry(playerid);
        ShowPlayerFooter(playerid, "~r~Carrying was cancelled.");
        return -2;  // stop processing and return 1
    }

    ShowPlayerFooter(playerid, "~w~Press~y~ ~k~~VEHICLE_ENTER_EXIT~ ~w~to stop carrying.");

    ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
    TRP_ClearAnimations(playerid);
    cmd_stopanim(playerid, "");
    
    SetPlayerAttachedObject(playerid,9,modelid,6,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

    //printf("SetPlayerAttachedObject(playerid,9,%d,6,%.02f,%.02f,%.02f, %.02f,%.02f,%.02f, %.02f,%.02f,%.02f);", modelid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);

    printf("%d: {%.02f, %.02f, %.02f, %.02f, %.02f, %.02f}", modelid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ);

    //SetPlayerAttachedObject(playerid,9,modelid,5,0.01,0.00,0.14,-78.00,0.00,-65.99,1.00,1.00,1.00);

    return -2; // stop processing and return 1
}

hook OnPlayerEditDynamicObj(playerid, STREAMER_TAG_OBJECT:objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz )
{
    if (!pSpawnerObject[playerid] || pSpawnerObject[playerid] != objectid) return 0;

    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
    GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
    GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
    
    new Float:pos[3], bool:invalid = false;
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    
    if (GetPlayerAdminLevel(playerid) <= ADMIN_LVL_JUNIOR && GetDistanceBetweenPoints(pos[0], pos[1], pos[2], x, y, z) > 10.0) invalid = true;

    if (response == EDIT_RESPONSE_FINAL)
    {
        SetDynamicObjectPos(objectid, x, y, z);
        SetDynamicObjectRot(objectid, rx, ry, rz);

        new spawnableid = pSpawnerSpawnableId[playerid];
        SpawnableData[spawnableid][spPos][0] = x;
        SpawnableData[spawnableid][spPos][1] = y;
        SpawnableData[spawnableid][spPos][2] = z;
        SpawnableData[spawnableid][spPos][3] = rx;
        SpawnableData[spawnableid][spPos][4] = ry;
        SpawnableData[spawnableid][spPos][5] = rz;

        printf("Spawnable %d by %s was %s (model: %d, dynobj: %d, spobjectid: %d).", spawnableid, SpawnableData[spawnableid][spPlayerName], pMovingSpawnable[playerid] ? "moved" : "created", GetDynamicObjectModel(objectid), objectid, SpawnableData[spawnableid][spObjectId]);
        printf("%d, %f, %f, %f, %f, %f, %f", GetDynamicObjectModel(objectid), x, y, z, rx, ry, rz);

        if (pMovingSpawnable[playerid]) ShowPlayerFooter(playerid, "~w~Placement updated successfully.");
        else 
        {
            foreach(new i: Player)
            {
                if (GetPlayerInterior(i) == SpawnableData[spawnableid][spInterior] && GetPlayerVirtualWorld(i) == SpawnableData[spawnableid][spWorld] && IsPlayerInRangeOfPoint(i, 25.0, x, y, z))
                {
                    Streamer_Update(i, STREAMER_TYPE_OBJECT);
                }
            }

            ShowPlayerFooter(playerid, "~w~Placement saved successfully.  ~y~/myspawns ~w~to edit.");
        }

        pSpawnerObject[playerid] = 0;
        pEditingSpawnable[playerid] = 0;
        pSpawnerSpawnableId[playerid] = -1;
        pMovingSpawnable[playerid] = 0;
    }
    else if (response == EDIT_RESPONSE_CANCEL)
    {
        if (pMovingSpawnable[playerid])
        {
            CancelSpawnablePlacement(playerid);
            ShowPlayerFooter(playerid, "~r~Your Spawnable was moved back to its old position.");
        }
        else
        {
            CancelSpawnablePlacement(playerid);
            ShowPlayerFooter(playerid, "~r~Placement was cancelled.");
        }
    }
    else if (response == EDIT_RESPONSE_UPDATE)
    {
        // ClearAnimations(playerid);
        // SetPlayerPos(playerid, pSpawnerPos[playerid][0], pSpawnerPos[playerid][1], pSpawnerPos[playerid][2]);
        // SetPlayerFacingAngle(playerid, pSpawnerPos[playerid][3]);
        SetDynamicObjectPos(objectid, x, y, z);
        SetDynamicObjectRot(objectid, rx, ry, rz);
    }

    if (invalid)
    {
        if (response != EDIT_RESPONSE_UPDATE) SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
        pSpawnerInvalid[playerid] = true;
        ShowPlayerFooter(playerid, "~r~Placement is too far away.");
    }
    else
    {
        if (pSpawnerInvalid[playerid])
        {
            pSpawnerInvalid[playerid] = false;
            HidePlayerFooter(playerid);
        }
    }

    return -2;  // Return 1
}