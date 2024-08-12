// This spawns random crates around the map every 6 hours. It gives you access to rare weapons.
#include <YSI_Coding\y_hooks>

// Data
enum _:CRATE_RARITIES {

    E_CRATE_RARITY_COMMON,
    E_CRATE_RARITY_RARE,
    E_CRATE_RARITY_EPIC,
    E_CRATE_RARITY_LEGENDARY
};

enum E_CRATE_GUNS {
    E_CRATE_GUN_CUSTOMID,
    E_CRATE_GUN_MIN_AMMO,
    E_CRATE_GUN_MAX_AMMO,
    E_CRATE_GUN_RARITY
};

new CrateGuns[][E_CRATE_GUNS] = {
    {CUSTOM_KNIFE, 1, 2, E_CRATE_RARITY_COMMON},
    {CUSTOM_DEAGLE, 20, 50, E_CRATE_RARITY_COMMON},
    {CUSTOM_SAWNOFF_SHOTGUN, 15, 30, E_CRATE_RARITY_RARE},
    {CUSTOM_RIFLE, 10, 25, E_CRATE_RARITY_RARE},
    {CUSTOM_AK47, 120, 300, E_CRATE_RARITY_EPIC},
    {CUSTOM_COLT, 999, 1000, E_CRATE_RARITY_LEGENDARY}
};


enum E_CRATE_LOCATIONS {
    Float: E_CRATE_LOC_POS_X,
    Float: E_CRATE_LOC_POS_Y,
    Float: E_CRATE_LOC_POS_Z,
    E_CRATE_LEGENDARY
}

new CrateLocations[][E_CRATE_LOCATIONS] = {
    
    { 2641.8481, -2079.6799, 13.1205},  //guncrate
    { 2437.9321, -2091.8982, 13.1109},  //guncrate
    { 2300.4292, -2131.0713, 13.2782},  //guncrate
    { 2690.3547, -2340.2312, 13.1976},  //guncrate
    { 2746.8958, -2552.2644, 13.2109},  //guncrate
    { 2522.8181, -2609.2854, 13.2033},  //guncrate
    { 2399.0017, -2555.2751, 13.2596},  //guncrate
    { 2206.1392, -2397.2307, 13.1143},  //guncrate
    { 2260.5649, -2592.0562, 7.8994},  //guncrate
    { 2594.7319, -2127.1096, 0.0290},  //guncrate
    { 2193.8184, -1955.6345, 13.1074},  //guncrate
    { 2471.8855, -1815.9076, 15.3254},  //guncrate
    { 2583.0596, -1704.2507, 1.2028},  //guncrate
    { 2607.7124, -1471.7133, 16.3171},  //guncrate
    { 2684.8909, -1429.6017, 15.8122},  //guncrate
    { 2809.7002, -1417.7407, 15.8144},  //guncrate
    { 2814.0129, -1429.8015, 23.7497},  //guncrate
    { 2772.3147, -1613.5900, 10.4863},  //guncrate
    { 2771.3599, -1392.1703, 26.7421},  //guncrate
    { 2693.7183, -1393.6993, 32.2716},  //guncrate
    { 2674.0251, -1111.3693, 68.8722},  //guncrate
    { 2800.7781, -1195.2900, 25.0803},  //guncrate
    { 2580.6563, -847.1459, 80.2706},  //guncrate
    { 2357.8357, -654.2305, 127.6518},  //guncrate
    { 2106.2832, -961.3572, 53.4986},  //guncrate
    { 2011.3242, -957.6477, 38.7478},  //guncrate
    { 2040.0554, -1034.0995, 25.3358},  //guncrate
    { 1836.6460, -1052.0297, 24.5888},  //guncrate
    { 1964.6353, -1317.4131, 23.2558},  //guncrate
    { 1953.6689, -1380.5717, 18.1366},  //guncrate
    { 1811.9072, -1412.2522, 12.9939},  //guncrate
    { 1811.9072, -1412.2522, 12.9910},  //guncrate
    { 1763.3715, -1382.7133, 15.3233},  //guncrate
    { 1660.8535, -1211.9819, 14.4244},  //guncrate
    { 1560.0472, -1214.2762, 16.9873},  //guncrate
    { 1491.3688, -1238.3804, 13.9228},  //guncrate
    { 1423.7155, -1300.4218, 13.1202},  //guncrate
    { 1407.7018, -1320.0060, 8.1351},  //guncrate
    { 1409.6741, -1300.3943, 13.1145},  //guncrate
    { 1485.1266, -1420.7155, 11.4543},  //guncrate
    { 1520.3732, -1463.7865, 9.0664},  //guncrate
    { 1554.3678, -1478.0088, 13.1199},  //guncrate
    { 1630.0173, -1551.0402, 13.2096},  //guncrate
    { 1733.0652, -1795.7395, 3.5570},  //guncrate
    { 1475.4412, -1732.8854, 6.3567},  //guncrate
    { 1359.0146, -1718.7572, 8.1436},  //guncrate
    { 1340.5889, -1809.1395, 13.1125},  //guncrate
    { 1368.8175, -1822.3176, 13.1392},  //guncrate
    { 1385.9869, -1896.6565, 13.0582},  //guncrate
    { 1144.6211, -1940.2003, 42.3844},  //guncrate
    { 1025.1212, -2164.0083, 39.6780},  //guncrate
    { 1195.6888, -2123.4294, 63.0604},  //guncrate
    { 1481.6602, -2081.5398, 30.5909},  //guncrate
    { 1550.5325, -2090.6785, 25.0800},  //guncrate
    { 1805.5546, -2335.4016, 13.0956},  //guncrate
    { 1400.4952, -2193.8440, 13.1034},  //guncrate
    { 1406.9727, -2376.8945, 13.1031},  //guncrate
    { 2119.7175, -2148.6323, 13.1112},  //guncrate
    { 2126.8086, -2016.4313, 13.1111},  //guncrate
    { 2020.4141, -1977.7938, 13.1121},  //guncrate
    { 1742.1995, -1768.4526, 13.2098},  //guncrate
    { 1739.9783, -1539.2706, 13.0397},  //guncrate
    { 1785.3988, -1215.8699, 16.4964},  //guncrate
    { 1812.8634, -1118.3862, 23.6418},  //guncrate
    { 1664.8396, -999.9912, 23.6099},  //guncrate
    { 1426.9095, -1081.4579, 17.1409},  //guncrate
    { 1300.2648, -1239.6449, 13.1115},  //guncrate
    { 1253.4441, -1260.1572, 12.7699},  //guncrate
    { 1137.2412, -1331.0753, 13.2164},  //guncrate
    { 1245.8871, -1486.4272, 13.1130},  //guncrate
    { 1249.7780, -1508.8678, 9.6125},  //guncrate
    { 1175.8271, -1643.2639, 13.5540},  //guncrate
    { 1197.7581, -1685.1604, 12.7204},  //guncrate
    { 1198.4679, -1882.2960, 13.1786},  //guncrate
    { 833.2957, -1856.4688, 7.9152},  //guncrate
    { 695.4135, -1849.6078, 6.7882},  //guncrate
    { 392.9758, -1880.3518, 2.1792},  //guncrate
    { 154.5189, -1958.3904, 3.3378},  //guncrate
    { 122.9955, -1508.7509, 10.4641},  //guncrate
    { 242.7723, -1106.4230, 86.6912},  //guncrate
    { 572.8611, -982.2593, 85.5032},  //guncrate
    { 694.3800, -917.8405, 74.8823},  //guncrate
    { 1434.8690, -738.6260, 82.6106},  //guncrate
    { 1335.6050, -839.2466, 53.2197},  //guncrate
    { 1212.1064, -986.5335, 43.0410},  //guncrate
    { 1117.0411, -1007.0355, 29.4259},  //guncrate
    { 1017.2247, -1070.9255, 28.0204},  //guncrate
    { 900.1343, -1056.7834, 24.5960},  //guncrate
    { 884.0214, -1124.5961, 23.5620},  //guncrate
    { 815.1780, -1095.4473, 25.3539},  //guncrate
    { 860.1965, -1167.0435, 16.5422},  //guncrate
    { 890.8602, -1301.5159, 13.3268},  //guncrate
    { 860.3057, -1365.8861, 13.1147},  //guncrate
    { 996.9915, -1445.1963, 13.1107},  //guncrate
    { 983.0223, -1536.1398, 13.1450},  //guncrate
    { 863.7817, -1718.1873, 13.1113},  //guncrate
    { 589.5203, -1604.3009, 15.7858},  //guncrate
    { 401.0490, -1533.7461, 31.8368},  //guncrate
    { 214.3817, -1559.2583, 30.3231},  //guncrate
    { 308.9337, -1358.3337, 13.9643},  //guncrate
    { 420.0189, -1297.7227, 14.5962},  //guncrate
    { 479.3207, -1334.7249, 14.9813},  //guncrate
    { 566.4698, -1357.2814, 14.5549},  //guncrate
    { 584.6702, -1557.2537, 15.2846},  //guncrate
    { 850.8950, -1546.3688, 13.1078},  //guncrate
    { 1008.0822, -1259.6833, 22.6296},  //guncrate
    { 993.0371, -1241.3898, 18.9665},  //guncrate
    { 961.2820, -1189.9535, 16.5111},  //guncrate
    { 1087.8691, -1186.8843, 17.8740},  //guncrate
    { 1195.7026, -1681.8140, 12.7195},  //guncrate
    { 1369.1770, -1632.5582, 12.9459},  //guncrate
    { 1372.2446, -1502.8683, 13.1015},  //guncrate
    { 1526.1238, -1110.3173, 20.4446},  //guncrate
    { 2341.4104, -1249.1678, 22.0648},  //guncrate
    { 2500.2966, -1219.5327, 36.8982},  //guncrate
    { 2674.9915, -1556.4645, 21.3426},  //guncrate
    { 2874.6777, -2124.9043, 3.5597},  //guncrate
    { 2319.6797, -60.1962, 26.0503, true},  //guncrate_county
    { 2320.2410, 56.0267, 26.0504, true},  //guncrate_county
    { 2319.9666, 17.5732, 26.0482, true},  //guncrate_county
    { 2309.5110, -6.0448, 32.5313, true},  //guncrate_county
    { 2256.5864, 73.2060, 26.0515, true},  //guncrate_county
    { 2215.2615, 183.3977, 21.7129, true},  //guncrate_county
    { 1445.1104, 347.8102, 18.4090, true},  //guncrate_county
    { 1301.8513, 353.3145, 19.1206, true},  //guncrate_county
    { 1265.1179, 295.6848, 19.1215, true},  //guncrate_county
    { 1338.0581, 197.0139, 19.1214, true},  //guncrate_county
    { 1433.0125, 258.8992, 19.1226, true},  //guncrate_county
    { 1197.6682, 145.7450, 20.0791, true},  //guncrate_county
    { 368.7167, -80.2372, 0.9501, true},  //guncrate_county
    { 316.2773, -34.9416, 1.1436, true},  //guncrate_county
    { 249.5024, -157.5331, 1.1472, true},  //guncrate_county
    { 91.1040, -164.9794, 2.1510, true},  //guncrate_county
    { 212.9293, 24.6301, 2.1363, true},  //guncrate_county
    { 269.3554, 18.2727, 2.0006, true},  //guncrate_county
    { -80.3179, -300.6014, 0.9875, true},  //guncrate_county
    { 159.8264, -288.1758, 1.1425, true},  //guncrate_county
    { 28.3954, -278.9721, 1.8542, true},  //guncrate_county
    { 670.3662, -428.6523, 16.3286, true},  //guncrate_county
    { 639.0914, -509.4451, 15.9015, true},  //guncrate_county
    { 797.6260, -618.6171, 15.9017, true},  //guncrate_county
    { 691.2322, -444.9254, 15.9045, true},  //guncrate_county
    { 857.6135, -584.3932, 17.6820, true}  //guncrate_county
};

enum E_ACTIVE_CRATE {
    Float: E_ACTIVE_CRATE_POS_X,
    Float: E_ACTIVE_CRATE_POS_Y,
    Float: E_ACTIVE_CRATE_POS_Z,

    E_ACTIVE_CRATE_OBJECT,
    E_ACTIVE_CRATE_MAPICON
};
new ActiveCrate[E_ACTIVE_CRATE];

#define MAX_CRATE_GUNS 7
enum E_ACTIVE_CRATE_GUNS {
    E_ACTIVE_CRATE_GUNS_WEAPONID,
    E_ACTIVE_CRATE_GUNS_AMMO
};
new ActiveCrateGuns[MAX_CRATE_GUNS][E_ACTIVE_CRATE_GUNS];
new EmmetCrateCooldown = 0; // determines when the next crate will spawn (unix)

enum _:EMMET_TIP_STATUS {
    EMMET_TIP_STATUS_NONE, // no crate spawned
    EMMET_TIP_STATUS_FREE, // crate spawned, no tip given
    EMMET_TIP_STATUS_GIVEN, // faction already underway
    EMMET_TIP_STATUS_COOLDOWN, // after 45 min of giving tip
    EMMET_TIP_STATUS_POLICE, // prev gate busted by cops
};
new EmmetTipStatus = EMMET_TIP_STATUS_NONE;
new EmmetTipCooldown = 0;

// Hooks and timers
hook OnGameModeInit() {
    EmmetCrateCooldown = gettime() + (3600 * 4); // 4 hours after a restart.
    EmmetTipCooldown = gettime() + (15 * 60); // 15 minutes
    return 1;
}

task HandleEmmetRespawnTick[180000]() { // we check every 30 minutes to create deviation from the static 6 hours mark

    if(ActiveCrate[E_ACTIVE_CRATE_OBJECT] == INVALID_STREAMER_ID && ActiveCrate[E_ACTIVE_CRATE_MAPICON] == INVALID_STREAMER_ID) {
        if(EmmetCrateCooldown < gettime()) {
            CreateEmmetCrate(INVALID_PLAYER_ID);
        }
    }
}

// Player cmds
CMD:emmetcrate(playerid) {
    if(IsPlayerInRangeOfPoint(playerid, 7.5, ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y], ActiveCrate[E_ACTIVE_CRATE_POS_Z]))
    {   
        if (!IsPlayerInPoliceFaction(playerid, true)) {

            if(CanPlayerOpenCrate(playerid)) {  
                ShowCrateContents(playerid);
            }
            else return SendServerMessage(playerid, COLOR_EMMET, "Gun Crate", "DEDEDE", "You must have at least 8 hours, be in an official faction and be tier 2 or 1.");
        }
        else { // player is a cop and on duty
            new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ];
            if (factionid)
            {
                new zone_name [64], string[144] ;
		        GetMapZoneName(GetMapZoneAtPoint2D (ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y]), zone_name);

                // Inform their faction
                new faction_enum_id = Faction_GetEnumID(factionid); 
                Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has confiscated an Emmet's Crate at %s }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName(playerid), zone_name), faction_enum_id, false );

                // Reset the guns and force a respawn
                RemoveEmmetCrate();
                HandleEmmetCrateRespawn();

                format ( string, sizeof ( string ), "[Emmet] Police Officer %s (%d) confiscated the Emmet Crate.", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid);
                SendAdminMessage ( string ) ;	

                EmmetTipStatus = EMMET_TIP_STATUS_POLICE; // set tip status to police
            }
        }
    }
    else return SendServerMessage(playerid, COLOR_EMMET, "Gun Crate", "DEDEDE", "You aren't close to a gun crate.");

    return 1;
}

CMD:emmettip(playerid) {

    new emmet_index = Emmet_GetClosestEntity(playerid);
    if(emmet_index == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }
    if(EmmetTipCooldown > gettime()) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", sprintf("You can't get a tip right now. Try in %s.", GetCountdown(gettime(), EmmetTipCooldown)));
    }
    new tip[144], zone_name[64];   
	GetMapZoneName(GetMapZoneAtPoint2D (ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y]), zone_name);
    switch(EmmetTipStatus) {
        case EMMET_TIP_STATUS_NONE: { // no crate spawned
        
            switch(random(3)) {
                case 0: format(tip, sizeof(tip), "Shit dog, I haven't heard of any lost crates recently. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                case 1: format(tip, sizeof(tip), "Ay, keep your voice low. They making a move soon, not yet. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                case 2: format(tip, sizeof(tip), "Nah homie, word on these streets is that there's no crate ri' now. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                default: format(tip, sizeof(tip), "We ain't missin' any shipments right now. Try again later homie. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
            }

            if(EmmetTipCooldown < gettime()) {
                EmmetTipCooldown = gettime() + (15 * 60); // 15 minutes
            }
        }
        case EMMET_TIP_STATUS_FREE: { // crate spawned, no tip given
        
            switch(random(3)) {
                case 0: format(tip, sizeof(tip), "I heard some army lookin' asses dropped a crate at %s.", zone_name);
                case 1: format(tip, sizeof(tip), "My homie was on the way here with the guns but lost a crate at %s.", zone_name);
                case 2: format(tip, sizeof(tip), "Word on the streets is that some Russians lost a shipment at %s.", zone_name);
                default: format(tip, sizeof(tip), "My plug from Las Venturas, some Italian lookin' ass, said he dropped a bag at %s.", zone_name);
            }

            EmmetTipCooldown = gettime() + (30 * 60); // 30 minutes
            EmmetTipStatus = EMMET_TIP_STATUS_GIVEN;
        }

        case EMMET_TIP_STATUS_GIVEN: { // faction already underway

            // Don't apply new cooldown here, just wait for the next one.
            if(EmmetTipCooldown >= gettime()) {
                switch(random(3)) {
                    case 0: format(tip, sizeof(tip), "Am I some kind of messenger? Some other fools are already going after it! Try in a little bit! (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                    case 1: format(tip, sizeof(tip), "I already sent some niggas to fetch it, you might be able to catch up to them. Wait a lil longer. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                    case 2: format(tip, sizeof(tip), "You a minute too late! I already gave the details to some other busta. Let 'em try first. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                    default: format(tip, sizeof(tip), "I ain't causing a gang war. Some other fools already lookin' for it. Try again later homie. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                }
            }
            // Their protection window is open, send the cavalry
            else {
                EmmetTipStatus = EMMET_TIP_STATUS_COOLDOWN;
                cmd_emmettip(playerid); // no new cooldown, everyone for himself.
            }

        }
        case EMMET_TIP_STATUS_COOLDOWN: { // after 45 min of giving tip
            switch(random(3)) {
                case 0: format(tip, sizeof(tip), "I sent some fools to pick it up but they ain't reached back yet. It's at %s.", zone_name);
                case 1: format(tip, sizeof(tip), "You ain't the first to ask homie. Head to %s. There may be others.", zone_name);
                case 2: format(tip, sizeof(tip), "I've already told some niggas, but it's at %s.", zone_name);
                default: format(tip, sizeof(tip), "I caught wind another group is lookin' for the crate. It's at %s.", zone_name);
            }
        }
        case EMMET_TIP_STATUS_POLICE: { // prev crate busted by cops
            switch(random(3)) {
                case 0: format(tip, sizeof(tip), "Shi' dog, the cops caught our last crate. It ain't here yet. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                case 1: format(tip, sizeof(tip), "Sssssh! Keep your voice down! The feds found the lost crate, they on the lookout. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                case 2: format(tip, sizeof(tip), "All I heard is that the cops are all over that place. You ain't wanna go near it. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
                default: format(tip, sizeof(tip), "The cops busted the last group I sent. Best stay clear of it and not mention no crates. (Tip cooldown for %s)", GetCountdown(gettime(), EmmetTipCooldown));
            }
            if(EmmetTipCooldown < gettime()) {
                EmmetTipCooldown = gettime() + (15 * 60); // 15 minutes
            }
        }
    }
    new string[256];
    format(string, sizeof(string), "Gun dealer says: %s", tip);
    SendClientMessage(playerid, 0xDEDEDEFF, string);

    return true;
}

// Admin cmds

CMD:emmetcratespawn(playerid) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {
        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

    CreateEmmetCrate(playerid); // we pass playerid here for admin msg
    AddLogEntry(playerid, LOG_TYPE_SCRIPT, "Force spawned an emmet crate");
    return 1;
}

CMD:emmetcrateinfo(playerid, params[]) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    // Show the countdown til next respawn
    if(ActiveCrate[E_ACTIVE_CRATE_OBJECT] == INVALID_STREAMER_ID && ActiveCrate[E_ACTIVE_CRATE_MAPICON] == INVALID_STREAMER_ID) {
       
        SendClientMessage(playerid, COLOR_EMMET, sprintf("The next crate will spawn in %s.", GetCountdown(gettime(), EmmetCrateCooldown)));
    }

    // Show the guns in the crate + location
    else {
        new string[256], gun_name[36], zone_name [64] ;
		GetMapZoneName(GetMapZoneAtPoint2D (ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y]), zone_name);
        
        format(string, sizeof(string), "The crate is located at %s (%f, %f, %f)\n", zone_name, ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y], ActiveCrate[E_ACTIVE_CRATE_POS_Z]);
        format(string, sizeof(string), "%s\nThe crate contains the following guns:\n", string);

        for(new i, j = MAX_CRATE_GUNS; i < j; i++) {
            if(ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_WEAPONID] != -1) {
                Weapon_GetGunName (ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_WEAPONID], gun_name, sizeof(gun_name)) ;	
                format(string, sizeof(string), "%s%i: %s with %i ammo\n", string, i + 1, gun_name, ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_AMMO]);
            }
        }

        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Crate Info", string, "Close", "");
    }
    return 1;
}

// Functions
ShowCrateContents(playerid) {
    new gun_name[32], line[144], dialog_string[1024], stored_id, weapon_index, weaponid;

    format(dialog_string, sizeof(dialog_string), "{DEDEDE}Weapon\tAmmo\tRarity\n");
    for(new i, j = MAX_CRATE_GUNS; i < j; i++) {

        stored_id = ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_WEAPONID];
        weapon_index = LinkCrateWeaponWithWeapons(stored_id);

        // Is slot empty? (Has it been looted yet?)
        if(weapon_index != -1) {
            weaponid = CrateGuns[weapon_index][E_CRATE_GUN_CUSTOMID];
            Weapon_GetGunName (weaponid, gun_name, sizeof(gun_name) ) ;	

            // Example of how to add rare gun names
            if(weaponid == CUSTOM_COLT && CrateGuns[weapon_index][E_CRATE_GUN_RARITY] == E_CRATE_RARITY_LEGENDARY) {
                format(gun_name, sizeof(gun_name), "Big Smoke's Colt");
            }

            // Formatting the dialog line
            format(line, sizeof(line), "%s\t%i\t%s%s{DEDEDE}\n", gun_name, ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_AMMO], GetCrateRarityColor(CrateGuns[weapon_index][E_CRATE_GUN_RARITY]), GetCrateRarityName(CrateGuns[weapon_index][E_CRATE_GUN_RARITY]) );

        } 
        else format(line, sizeof(line), "Empty{DEDEDE}\n");
        
        strcat(dialog_string, line);	
    }

    inline EmmetCrate(pid, dialogid, response, listitem, string:inputtext[] ) { 
        #pragma unused pid, dialogid, response, inputtext

        if(response) {
            
            stored_id = ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_WEAPONID];

            if(stored_id != -1) {
                weapon_index = LinkCrateWeaponWithWeapons(stored_id);
                weaponid = CrateGuns[weapon_index][E_CRATE_GUN_CUSTOMID];
                Weapon_GetGunName (weaponid, gun_name, sizeof(gun_name) ) ;	

                // Log the action
                SendServerMessage(playerid, COLOR_EMMET, "Gun Crate", "DEDEDE", sprintf("You've taken a %s with %i ammo from the crate.", gun_name, ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_AMMO]));
                AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Took a %s with %i ammo from emmet crate.", gun_name, ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_AMMO]));

                // Give the gun
                GiveCustomWeapon(playerid, ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_WEAPONID], ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_AMMO]) ;
                SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_WEAPONID]), ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_AMMO]);

                // Emptying crate content
                ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_WEAPONID] = -1; 
                ActiveCrateGuns[listitem][E_ACTIVE_CRATE_GUNS_AMMO] = 0; 

                // Call this function to see if it must be yeeted (cause its empty).
                HandleEmmetCrateRespawn();
            }
            else {
                SendServerMessage(playerid, COLOR_EMMET, "Gun Crate", "DEDEDE", "This crate slot is empty.");
                ShowCrateContents(playerid);
                return true;
            }
        }
    }

	Dialog_ShowCallback ( playerid, using inline EmmetCrate, DIALOG_STYLE_TABLIST_HEADERS, "Emmet Crate Contents", dialog_string, "Proceed", "Cancel" ) ;
    return true;
}

LinkCrateWeaponWithWeapons(weaponid) {
    new weapon_index = -1;
    for(new i, j = sizeof(CrateGuns); i < j; i++) {
        if(CrateGuns[i][E_CRATE_GUN_CUSTOMID] == weaponid) {
            weapon_index = i;
            break;
        }
    }
    return weapon_index;
}

HandleEmmetCrateRespawn() {

    new count; 

    // Check how many guns are left
    for(new i, j = MAX_CRATE_GUNS; i < j; i++) {
        if(ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_WEAPONID] != -1) {
            count ++;
        }
    }

    // If no guns are left, respawn the crate and set new cooldown
    if(!count) {
        ProxDetectorXYZ ( ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y], ActiveCrate[E_ACTIVE_CRATE_POS_Z], 0, 0, 15.0, COLOR_ACTION, "* The emmet crate has been plundered and breaks into pieces.");
        RemoveEmmetCrate();
        EmmetCrateCooldown = gettime() + (3600 * 6) + random(3600 * 2); // 5 hours by default + random 2 hours
    }
}

RemoveEmmetCrate() {

    // Somewhere players can't reach
    ActiveCrate[E_ACTIVE_CRATE_POS_X] = 999.9;
    ActiveCrate[E_ACTIVE_CRATE_POS_Y] = 999.9;
    ActiveCrate[E_ACTIVE_CRATE_POS_Z] = 999.9;

    // Reset streamer data
    if(IsValidDynamicObject(ActiveCrate[E_ACTIVE_CRATE_OBJECT])) {
        DestroyDynamicObject(ActiveCrate[E_ACTIVE_CRATE_OBJECT]);
    }
    ActiveCrate[E_ACTIVE_CRATE_OBJECT] = INVALID_STREAMER_ID;

    if(IsValidDynamicMapIcon(ActiveCrate[E_ACTIVE_CRATE_MAPICON])) {
        DestroyDynamicMapIcon(ActiveCrate[E_ACTIVE_CRATE_MAPICON]);
    }
    ActiveCrate[E_ACTIVE_CRATE_MAPICON] = INVALID_STREAMER_ID;

    // Wipe the guns
    for(new i, j = MAX_CRATE_GUNS; i < j; i++) {
        ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_WEAPONID] = -1;
        ActiveCrateGuns[i][E_ACTIVE_CRATE_GUNS_AMMO] = 0;
    }

    EmmetTipStatus = EMMET_TIP_STATUS_NONE;
}

CreateEmmetCrate(playerid = INVALID_PLAYER_ID) {
    RemoveEmmetCrate(); // wipe the shit, this clears position, guns and object/mapicon

    new random_point = random(sizeof(CrateLocations));

    ActiveCrate[E_ACTIVE_CRATE_POS_X] = CrateLocations[random_point][E_CRATE_LOC_POS_X];
    ActiveCrate[E_ACTIVE_CRATE_POS_Y] = CrateLocations[random_point][E_CRATE_LOC_POS_Y];
    ActiveCrate[E_ACTIVE_CRATE_POS_Z] = CrateLocations[random_point][E_CRATE_LOC_POS_Z];

    ActiveCrate[E_ACTIVE_CRATE_OBJECT] = CreateDynamicObject(2977, ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y], ActiveCrate[E_ACTIVE_CRATE_POS_Z], 0.0, 0.0, 0.0);
    ActiveCrate[E_ACTIVE_CRATE_MAPICON] = CreateDynamicMapIcon(ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y], ActiveCrate[E_ACTIVE_CRATE_POS_Z], 23, 0xFFFFFFFF, .streamdistance = 25.0);

    GenerateRandomCrateWeapons(playerid); // playerid is used for admin log of creation.
    
    EmmetTipStatus = EMMET_TIP_STATUS_FREE;
}

GenerateRandomCrateWeapons(playerid = INVALID_PLAYER_ID) {
    new amount_of_guns = random(MAX_CRATE_GUNS);
    if(amount_of_guns < 2) amount_of_guns = 2; // crates will always have this many guns

    new gun_count = 0, bool: melee_count = false;

    while(gun_count != amount_of_guns) {
        new random_gun = random(sizeof(CrateGuns));
        
        if(GetCrateRarityPercentage(CrateGuns[random_gun][E_CRATE_GUN_RARITY]) > random(100)) {

            // Example of how to limit the amount of melee weapons
            if(CrateGuns[random_gun][E_CRATE_GUN_CUSTOMID] == CUSTOM_KNIFE) {
                if(melee_count) continue;
                melee_count = true;
            }

            ActiveCrateGuns[gun_count][E_ACTIVE_CRATE_GUNS_WEAPONID] = CrateGuns[random_gun][E_CRATE_GUN_CUSTOMID];
            ActiveCrateGuns[gun_count][E_ACTIVE_CRATE_GUNS_AMMO] = RandomEx(CrateGuns[random_gun][E_CRATE_GUN_MIN_AMMO], CrateGuns[random_gun][E_CRATE_GUN_MAX_AMMO]);
            gun_count++;
        }
    }

    new string[256];
    if(playerid != INVALID_PLAYER_ID) {

        format ( string, sizeof ( string ), "[Emmet] %s (%d) has force spawned a new Emmet crate with %i guns.", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, amount_of_guns);
        SendAdminMessage ( string ) ;	
    }
    else {
        new zone_name [64] ;
		GetMapZoneName(GetMapZoneAtPoint2D (ActiveCrate[E_ACTIVE_CRATE_POS_X], ActiveCrate[E_ACTIVE_CRATE_POS_Y]), zone_name);
        format ( string, sizeof ( string ), "[Emmet Crate] has spawned at %s with %i guns. Use /emmetcrateinfo.", zone_name, amount_of_guns);
        SendAdminMessage ( string ) ;	
    }
}

GetCrateRarityName(rarity) {
    new name[16];
    format(name, sizeof(name), "Unknown");
    switch(rarity) {
        case E_CRATE_RARITY_COMMON: format(name, sizeof(name), "Common");
        case E_CRATE_RARITY_RARE: format(name, sizeof(name), "Rare");
        case E_CRATE_RARITY_EPIC: format(name, sizeof(name), "Epic");
        case E_CRATE_RARITY_LEGENDARY: format(name, sizeof(name), "Legendary");
    }
    return name;
}

GetCrateRarityColor(rarity) {
    new color[16];
    format(color, sizeof(color), "{DEDEDE}");
    switch(rarity) {
        case E_CRATE_RARITY_COMMON: format(color, sizeof(color), "{33b546}");
        case E_CRATE_RARITY_RARE: format(color, sizeof(color), "{3356b5}");
        case E_CRATE_RARITY_EPIC: format(color, sizeof(color), "{8833b5}");
        case E_CRATE_RARITY_LEGENDARY: format(color, sizeof(color), "{ff7b00}");
    }
    return color;
}

GetCrateRarityPercentage(rarity) {
    new percentage = 0;
    switch(rarity) {
        case E_CRATE_RARITY_COMMON: percentage = 90;
        case E_CRATE_RARITY_RARE: percentage = 50;
        case E_CRATE_RARITY_EPIC: percentage = 30;
        case E_CRATE_RARITY_LEGENDARY: percentage = 5;
    }
    return percentage;
}

CanPlayerOpenCrate(playerid) {
    if(IsPlayerConnected(playerid) && CanPlayerUseGuns(playerid, 8, -1)) { // Connected and has gun perms
        
        if(!Character[playerid][E_CHARACTER_FACTIONID] && Faction_GetEnumID(Character[playerid][E_CHARACTER_FACTIONID]) == INVALID_FACTION_ID) return false; // Not in a faction
        if(Character[playerid] [E_CHARACTER_FACTIONTIER] > 2) return false; // Not high enough rank

        return true;
    }
    return false;
}
