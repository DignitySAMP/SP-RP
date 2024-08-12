LoadStaticMaps() {
	// base systems
	LoadPnSMaps();
	LoadELSJewelryMap();
	LoadGarbageJobMap();
	LoadEmmetMaps();
	LoadSweetFix();
	LoadTollMaps();

	// Decorations
	LoadRodeoMap() ;
	LoadBeachMap();
	LoadSAPDLBTraining() ;
	LoadSAPDDrivingMap() ;
	//LoadAuthObjects();
	LoadSAPDTrainingMap();

	// Donator stars
	LoadDonatorStars();

	// Misc interiors
	LoadChurchInterior();
	LoadRatInterior();
	LoadStaffMeetingInterior(); // staff meeting interior

	// trucker shortcut block
	CreateObject(4519, 2766.83594, 323.85938, 9.15625,   0, 0.00000, 270);
	CreateDynamic3DTextLabel("Did you really think this is a good idea?\nThis is a roleplaying server.", COLOR_RED, 2766.71680, 321.58621, 8.02740, 25.00, .testlos = false);

	// LV trucker shortcut blocks
	CreateObject(16121, -175.49429, 2283.28491, 26.69450,   0.00000, 0.00000, 40.16000);
	CreateObject(16121, -34.64740, 2250.48584, 37.43610,   0.00000, 0.00000, 50.00000);
	CreateObject(16121, -286.77109, 2089.66162, 22.80190,   0.00000, 0.00000, 0.00000);
	CreateObject(16121, -216.57390, 2205.47876, 27.46330,   10.54200, 6.52600, -25.35100);
	CreateObject(16121, -216.57390, 2243.63086, 27.46330,   10.54200, 6.52600, -25.35100);
}


LoadEmmetMaps() {
    
    // Families Emmet (pull original mapping)
    new g_Object[151];

    g_Object[0] = CreateDynamicObject(1448, 2440.3666, -1967.6428, 12.6197, 0.0000, 0.0000, 0.0000); //DYN_CRATE_1
    g_Object[1] = CreateDynamicObject(2968, 2440.1203, -1967.8758, 12.9933, 0.0000, 0.0000, 0.0000); //cm_box
    g_Object[2] = CreateDynamicObject(928, 2440.6364, -1967.4493, 12.9525, 0.0000, 0.0000, 0.0000); //RUBBISH_BOX1
    g_Object[3] = CreateDynamicObject(964, 2440.1801, -1966.3198, 12.5731, 0.0000, 0.0000, 90.0000); //CJ_METAL_CRATE
    SetDynamicObjectMaterial(g_Object[3], 0, 10839, "aircarpkbarier_sfse", "cratetop128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[3], 1, 3066, "ammotrx", "ammotrn92crate64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[3], 2, 10839, "aircarpkbarier_sfse", "cratetop128", 0xFFFFFFFF);
    g_Object[4] = CreateDynamicObject(1431, 2440.0378, -1964.1656, 13.1028, 0.0000, 0.0000, 86.9999); //DYN_BOX_PILE
    SetDynamicObjectMaterial(g_Object[4], 0, 12821, "alleystuff", "Gen_Crate", 0xFFFFFFFF);
    g_Object[5] = CreateDynamicObject(1449, 2441.0214, -1962.5495, 13.1049, 0.0000, 0.0000, 0.0000); //DYN_CRATE_2
    SetDynamicObjectMaterial(g_Object[5], 0, 3063, "col_wall1x", "ab_wood1", 0xFFFFFFFF);
    g_Object[6] = CreateDynamicObject(941, 2443.0495, -1962.6407, 13.0080, 0.0000, 0.0000, 0.0000); //CJ_DF_WORKTOP_3
    SetDynamicObjectMaterial(g_Object[6], 0, 10839, "aircarpkbarier_sfse", "cratetop128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[6], 1, 3066, "ammotrx", "ammotrn92crate64", 0xFFFFFFFF);
    g_Object[7] = CreateDynamicObject(1450, 2445.1274, -1962.6312, 13.1105, 0.0000, 0.0000, 0.0000); //DYN_CRATE_3
    g_Object[8] = CreateDynamicObject(924, 2444.1213, -1962.6595, 13.6716, 0.0000, 0.0000, -90.0000); //FRUITCRATE3
    g_Object[9] = CreateDynamicObject(917, 2442.5366, -1962.3260, 13.6218, 0.0000, 0.0000, 0.0000); //FRUITCRATE1
    g_Object[10] = CreateDynamicObject(2749, 2442.7336, -1962.1982, 13.4820, 0.0000, 0.0000, 0.0000); //CJ_hairspray
    SetDynamicObjectMaterial(g_Object[10], 0, 6869, "vegastemp1", "vgnbarbtex1_256", 0xFFFFFFFF);
    g_Object[11] = CreateDynamicObject(2749, 2442.7336, -1962.3784, 13.4820, 0.0000, 0.0000, 0.0000); //CJ_hairspray
    SetDynamicObjectMaterial(g_Object[11], 0, 19344, "egg_texts", "easter_egg01", 0xFFFFFFFF);
    g_Object[12] = CreateDynamicObject(2749, 2442.3791, -1962.3614, 13.5621, 0.0000, 90.0000, 27.6000); //CJ_hairspray
    SetDynamicObjectMaterial(g_Object[12], 0, 18835, "mickytextures", "metal013", 0xFFFFFFFF);
    g_Object[13] = CreateDynamicObject(19914, 2442.3395, -1962.9560, 13.5165, 0.0000, 0.0000, 26.7999); //CutsceneBat1
    SetDynamicObjectMaterial(g_Object[13], 0, 18028, "cj_bar2", "CJ_nastybar_D3", 0xFFFFFFFF);
    g_Object[14] = CreateDynamicObject(2676, 2443.5129, -1963.4809, 12.6801, 0.0000, 0.0000, 0.0000); //PROC_RUBBISH_8
    g_Object[15] = CreateDynamicObject(2853, 2443.1823, -1962.6400, 13.4729, 0.0000, 0.0000, -22.2000); //gb_bedmags03
    SetDynamicObjectMaterial(g_Object[15], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[15], 9, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[16] = CreateDynamicObject(960, 2442.8374, -1962.5334, 12.8899, 0.0000, 0.0000, 0.0000); //CJ_ARM_CRATE
    g_Object[17] = CreateDynamicObject(3015, 2445.6723, -1965.8929, 12.6878, 0.0000, 0.0000, -147.3999); //cr_cratestack
    SetDynamicObjectMaterial(g_Object[17], 0, 5132, "imstuff_las2", "sjmlawarshcrategen", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[17], 1, 5132, "imstuff_las2", "sjmlawarshcrategen", 0xFFFFFFFF);
    g_Object[18] = CreateDynamicObject(2040, 2444.1262, -1966.3917, 13.1351, 0.0000, 0.0000, 35.3997); //AMMO_BOX_M1
    g_Object[19] = CreateDynamicObject(2586, 2444.1928, -1966.3205, 13.0354, 0.0000, 0.0000, 14.3999); //CJ_SEX_COUNTER2
    SetDynamicObjectMaterial(g_Object[19], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 2, 15040, "cuntcuts", "csnewspaper02", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 5, 18064, "ab_sfammuunits", "gun_targetc", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 7, 16387, "des_gunclub", "woodenpanels256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 9, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 10, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 11, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[20] = CreateDynamicObject(2042, 2444.4499, -1966.3508, 12.8634, 0.0000, 0.0000, -14.0000); //AMMO_BOX_M3
    g_Object[21] = CreateDynamicObject(2043, 2444.8005, -1966.0992, 13.1267, 0.0000, 0.0000, -36.7999); //AMMO_BOX_M4
    g_Object[22] = CreateDynamicObject(2358, 2443.5849, -1966.5322, 12.8697, 0.0000, 0.0000, -165.1999); //AMMO_BOX_c2


    // VLA Emmet
    CreateDynamicObject(3577, 1691.07727, -1975.60339, 8.53939,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3576, 1688.32947, -1972.35852, 9.30083,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3576, 1687.89685, -1976.10913, 9.30080,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(941, 1694.97595, -1973.16956, 8.23873,   0.00000, 0.00000, 90.36005);
    CreateDynamicObject(936, 1694.61487, -1970.61035, 8.28345,   0.00000, 0.00000, -74.52010);
    CreateDynamicObject(3577, 1694.29370, -1975.81567, 8.53940,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3577, 1687.96301, -1969.23523, 8.53940,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(937, 1692.87610, -1969.34448, 8.28299,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(941, 1690.48828, -1969.25732, 8.23870,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2358, 1690.13464, -1969.29773, 7.92955,   0.00000, 0.00000, 22.02000);
    CreateDynamicObject(2358, 1690.87610, -1969.25159, 7.92955,   0.00000, 0.00000, 178.85921);
    CreateDynamicObject(3014, 1691.38904, -1969.75879, 8.02065,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3014, 1694.42542, -1972.29150, 8.02065,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3014, 1694.91541, -1973.68152, 8.02065,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2358, 1694.63831, -1972.97400, 7.92955,   0.00000, 0.00000, 100.80054);
    CreateDynamicObject(2945, 1687.89868, -1969.81567, 10.54690,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2945, 1687.93445, -1973.57031, 10.54690,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2945, 1690.01440, -1975.59729, 10.54690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2945, 1693.75916, -1975.57959, 10.54690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2068, 1692.39307, -1972.87085, 12.10386,   0.00000, 0.00000, -4.13999);
    CreateDynamicObject(2058, 1694.61292, -1970.69580, 8.77704,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2058, 1690.09436, -1969.21301, 8.71985,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2064, 1695.77808, -1969.79456, 8.41505,   0.00000, 0.00000, 63.78013);
    CreateDynamicObject(2047, 1691.90625, -1975.54980, 10.50250,   0.00000, 0.00000, 180.00000);


    // Vagos Emmet
    CreateDynamicObject(3577, 2615.04443, -1390.87744, 34.46767,   0.60000, -5.22000, 181.25914);
    CreateDynamicObject(3576, 2615.11792, -1394.72986, 35.24468,   0.00000, 0.00000, 90.60009);
    CreateDynamicObject(3576, 2609.21655, -1390.27869, 35.28242,   0.00000, 0.00000, -89.76016);
    CreateDynamicObject(2062, 2612.98975, -1391.38354, 34.30603,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2062, 2612.70776, -1392.17700, 34.26943,   0.00000, 0.00000, 88.49998);
    CreateDynamicObject(2064, 2611.55811, -1392.03406, 34.31248,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(941, 2609.93726, -1395.42847, 34.50162,   -1.38000, -1.62000, -37.98002);
    CreateDynamicObject(936, 2608.85864, -1393.61023, 34.31594,   2.52000, 5.40000, 95.76000);
    CreateDynamicObject(937, 2612.52734, -1396.00488, 34.41574,   3.00000, -4.20000, 184.49910);
    CreateDynamicObject(3014, 2609.37378, -1395.38110, 34.24118,   -1.80000, -3.06000, -41.82007);
    CreateDynamicObject(3014, 2611.17456, -1396.56042, 34.33735,   -0.60000, 5.94000, -17.64005);
    CreateDynamicObject(2358, 2610.20581, -1396.14783, 34.20118,   -2.94000, 0.48000, -19.62001);
    CreateDynamicObject(2358, 2612.08569, -1396.27039, 34.27462,   -2.46000, 2.94000, 0.84001);
    CreateDynamicObject(2358, 2612.82983, -1396.14832, 34.62661,   -2.46000, 2.94000, 0.84001);
    CreateDynamicObject(2058, 2610.08838, -1395.58813, 34.99343,   -1.01999, -0.36000, 0.00000);
    CreateDynamicObject(2050, 2609.67188, -1390.81006, 35.93570,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2049, 2610.41357, -1390.80920, 36.45600,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2051, 2611.15503, -1390.80835, 35.72570,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2047, 2616.67725, -1391.86365, 35.82505,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(2068, 2613.23096, -1390.48145, 34.66608,   0.00000, 90.00000, 87.71992);


    // Ballas Emmet
    CreateDynamicObject(3577, 2169.22485, -1510.74890, 23.66784,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3577, 2172.48730, -1510.68274, 23.66780,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(3576, 2171.87158, -1507.45837, 24.43359,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2062, 2167.22388, -1510.64514, 23.47137,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2062, 2167.22437, -1511.62476, 23.45225,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2062, 2166.30835, -1510.98621, 23.27288,   0.00000, 90.00000, 175.55917);
    CreateDynamicObject(941, 2167.42383, -1505.95703, 23.44052,   0.00000, 0.00000, 40.74009);
    CreateDynamicObject(936, 2169.80127, -1504.89368, 23.44364,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3577, 2172.45972, -1505.88196, 23.63123,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(937, 2166.54517, -1507.98572, 23.40520,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2358, 2167.56006, -1505.71045, 23.06591,   0.00000, 0.00000, -140.15967);
    CreateDynamicObject(3014, 2167.94873, -1505.23096, 23.17045,   0.00000, 0.00000, 44.16003);
    CreateDynamicObject(2358, 2167.12109, -1506.23389, 23.06591,   0.00000, 0.00000, -231.35869);
    CreateDynamicObject(2358, 2166.41797, -1507.55273, 23.24356,   0.00000, 0.00000, -90.95975);
    CreateDynamicObject(2358, 2166.42334, -1508.29346, 23.24356,   0.00000, 0.00000, -75.83991);
    CreateDynamicObject(2358, 2166.41895, -1507.83301, 23.60356,   0.00000, 0.00000, -96.17988);
    CreateDynamicObject(2064, 2166.43530, -1509.69617, 23.45910,   0.00000, 0.00000, -69.96008);
    CreateDynamicObject(2058, 2167.48608, -1505.71094, 23.92630,   0.00000, 0.00000, 74.34007);
    CreateDynamicObject(2050, 2172.32520, -1506.22571, 25.00286,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(2051, 2172.30640, -1505.58997, 25.80780,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(2049, 2172.31689, -1505.12280, 24.84580,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(2047, 2173.45679, -1504.04236, 25.93031,   0.00000, 0.00000, 180.00000);

    // Weapons
    CreateDynamicObject(337, 2170.47144, -1505.10559, 24.00065,   0.00000, 90.00000, 90.00000); // Shovel
    CreateDynamicObject(336, 2169.82715, -1504.59607, 24.00070,   0.00000, 90.00000, -79.08002); // Bat
    CreateDynamicObject(346, 2169.09839, -1504.90320, 23.91879,   85.74005, 92.33997, -45.00000); // Colt
    CreateDynamicObject(352, 2168.07275, -1505.27966, 23.91880,   90.00000, 90.00000, -72.66008); // Uzi
    CreateDynamicObject(372, 2166.94263, -1506.31592, 23.91880,   90.00000, 90.00000, -26.57990); // Tec
    CreateDynamicObject(349, 2166.26147, -1507.68811, 23.85945,   97.01997, 93.36000, -49.50007); // Shotgun
    CreateDynamicObject(355, 2166.29810, -1508.62866, 23.85940,   97.02000, 93.36000, -51.59982); // AK
}

LoadGarbageJobMap() {
	new txt_map;
	txt_map=CreateDynamicObject(10985, 2263.6838, -2685.8937, 13.6094, 0.0000, 0.0000, 40.7999);
	SetDynamicObjectMaterial(txt_map,0, 5122, "ground3_las2", "Was_scrpyd_tires_pile", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1462, 2237.8085, -2672.0314, 12.4588, 0.0000, 0.0000, 152.9998);
	txt_map=CreateDynamicObject(11280, 2234.7185, -2660.1142, 12.4820, 0.0000, 0.0000, -115.9999);
	txt_map=CreateDynamicObject(3722, 2270.8127, -2689.5900, 16.8791, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,0, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 18245, "cw_junkyardmachin", "Was_scrpyd_baler_gen_rvt", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 18245, "cw_junkyardmachin", "Was_scrpyd_baler_gen_rvt", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2790, 2239.3930, -2675.3383, 18.8598, 0.0000, 0.0000, 179.8000);
	SetDynamicObjectMaterial(txt_map,1, 17535, "lae2billboards", "SunBillB03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 18246, "cw_junkyard2cs_t", "Was_scrpyd_carhood", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2228.5007, -2668.9333, 15.2613, 0.0000, 0.0000, -22.3999);
	SetDynamicObjectMaterial(txt_map,3, 10840, "bigshed_sfse", "ws_reinforcedbutwonky", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2265.1035, -2705.2744, 15.2613, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,3, 6282, "beafron2_law2", "shutter03LA", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2276.0803, -2684.9338, 15.2613, 0.0000, 0.0000, 90.0000);
	SetDynamicObjectMaterial(txt_map,3, 10840, "bigshed_sfse", "ws_reinforcedbutwonky", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2220.3056, -2705.2744, 15.2613, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,1, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 10840, "bigshed_sfse", "ws_reinforcedbutwonky", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2242.7248, -2705.2744, 15.2613, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,1, 5461, "glenpark6d_lae", "shutter01LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 10840, "bigshed_sfse", "ws_reinforcedbutwonky", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2264.9790, -2673.6921, 15.2613, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,1, 18245, "cw_junkyardmachin", "Was_scrpyd_wall_grn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 18249, "cw_junkyardccs_t", "Was_scrpyd_trk_contnr_sd", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(8229, 2276.0402, -2693.9348, 15.2613, 0.0000, 0.0000, 90.0000);
	SetDynamicObjectMaterial(txt_map,3, 18245, "cw_junkyardmachin", "Was_scrpyd_baler_gen_rvt", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(18260, 2257.9899, -2698.2907, 14.0558, 0.0000, 0.0000, 21.0000);
	SetDynamicObjectMaterial(txt_map,0, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(18260, 2263.5722, -2681.4255, 13.9958, 0.0000, 0.0000, 76.7998);
	SetDynamicObjectMaterial(txt_map,0, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(18260, 2268.0817, -2695.8811, 14.0558, 0.0000, 0.0000, 90.0000);
	SetDynamicObjectMaterial(txt_map,0, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 5122, "ground3_las2", "Was_crush", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1684, 2237.7856, -2698.8454, 14.1013, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,0, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_edge", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,5, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,6, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_edge", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,7, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_front", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1684, 2227.7050, -2698.8454, 17.1413, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,0, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 3897, "libertyhi", "inddoorway128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,5, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,6, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_edge", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,7, 17535, "lae2billboards", "SunBillB03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_front", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1265, 2236.3750, -2671.3791, 13.0508, 0.0000, 0.0000, -122.4000);
	txt_map=CreateDynamicObject(8572, 2228.7001, -2701.9008, 14.4933, 0.0000, 0.0000, 0.0000);
	txt_map=CreateDynamicObject(1684, 2227.7050, -2698.8454, 14.1013, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,0, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 18247, "cw_junkyarddigcs_t", "Was_scrpyd_step", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 3897, "libertyhi", "inddoorway128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,5, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,6, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_edge", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,7, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 18246, "cw_junkyard2cs_t", "Was_scrpyd_trailer_front", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19872, 2235.7001, -2698.8576, 15.1434, 0.0000, 0.0000, 90.0000);
	SetDynamicObjectMaterial(txt_map,0, 18245, "cw_junkyardmachin", "Was_scrpyd_baler_decking", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(3576, 2236.0012, -2698.9865, 18.5403, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterial(txt_map,0, 9583, "bigshap_sfw", "freight_crate6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 18249, "cw_junkyardccs_t", "Was_scrpyd_trk_contnr_sd", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 18249, "cw_junkyardccs_t", "Was_scrpyd_trk_contnr_sd", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3066, "ammotrx", "ammotrn92crate64", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(3576, 2241.1848, -2698.7263, 17.0543, 0.0000, -2.8000, 180.0000);
	SetDynamicObjectMaterial(txt_map,0, 9583, "bigshap_sfw", "freight_crate5", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 2972, "k_cratesx", "747_crate", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1265, 2238.2243, -2672.1972, 13.0508, 0.0000, 0.0000, 72.199);
}

LoadPnSMaps() {
	new txt_map;
	txt_map = CreateDynamicObject(5532, 199.708200, -1438.699700, 20.214300, 0.000000, 0.000000, -41.299900, -1, -1, -1, 500.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 3355, "cxref_savhus", "des_brick1", 0xFF9F9D94);
	SetDynamicObjectMaterial(txt_map,3, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 3355, "cxref_savhus", "des_brick1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 19297, "matlights", "invisible", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(5532, 1295.907700, -1876.841500, 20.651800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 500.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 4830, "airport2", "sanairtex2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 16093, "a51_ext", "alleydoor2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 4830, "airport2", "sanairtex1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,6, 4830, "airport2", "sanairtex2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,7, 11301, "carshow_sfse", "laspryshpsig1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 19297, "matlights", "invisible", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(5532, 1822.195500, -1397.333200, 20.463800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 3979, "civic01_lan", "sl_laglasswall2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 16093, "a51_ext", "alleydoor9b", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 3979, "civic01_lan", "sl_laglasswall1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,6, 4830, "airport2", "aarprt3LAS", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,7, 11301, "carshow_sfse", "ws_Transfender_dirty", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 19297, "matlights", "invisible", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(5532, 2324.045100, -1990.593100, 20.613300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 5040, "shopliquor_las", "lasjmliq2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 13363, "cephotoblockcs_t", "alleydoor3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,4, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,7, 5774, "garag3_lawn", "sprysig1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,8, 19297, "matlights", "invisible", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(1259, 2336.891300, -1989.011500, 21.495600, 0.000000, 0.000000, 179.800000, -1, -1, -1, 250.0, 300.0);

	//Blocks
	txt_map = CreateDynamicObject(19790, 1025.136300, -1027.008500, 31.064500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 18045, "gen_munation", "mp_gun_shutter", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(971, -1904.015700, 278.164700, 43.043800, 0.000000, 0.000000, 180.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 11395, "corvinsign_sfse", "shutters", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19790, 488.153900, -1737.290500, 9.956800, 0.000000, 0.000000, -4.799900, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 6282, "beafron2_law2", "LoadingDoorClean", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19790, 719.962700, -460.027000, 14.472200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 6282, "beafron2_law2", "LoadingDoorClean", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19791, 1973.537700, 2162.068800, 4.575600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 6282, "beafron2_law2", "LoadingDoorClean", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(971, -99.663100, 1111.609700, 20.718000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 11395, "corvinsign_sfse", "shutters", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 19297, "matlights", "invisible", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(971, -1420.636300, 2590.556100, 56.731700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 3586, "la_props1", "shutters2", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19790, -1786.874700, 1211.984700, 23.239000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(971, -2425.864200, 1028.040000, 51.897300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,2, 11395, "corvinsign_sfse", "shutters", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19790, 2006.077100, 2305.844900, 9.613400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 18045, "gen_munation", "mp_gun_shutter", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19790, 2005.957000, 2315.427700, 9.613400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 18045, "gen_munation", "mp_gun_shutter", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19791, 2386.605200, 1048.517900, 4.014100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 17064, "cw2_storesnstuff", "des_garagedoor1", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(19790, 1041.375800, -1023.468000, 31.064500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 18045, "gen_munation", "mp_gun_shutter", 0xFFFFFFFF);
	// Idlewood PnS block
	CreateDynamicObject(19911, 2071.54077, -1831.40784, 14.41456,   0.00000, 0.00000, 0.00000, -1, -1, -1, 100.0, 300.0);


}	

LoadELSJewelryMap() {
	new txt_map;
	txt_map=CreateDynamicObject(1337, 2838.212, -1474.327, -11.871, 0.000, 0.000, 0.000, -1, -1, -1, 10.0, 10.0);
	txt_map=CreateDynamicObject(19377, 2857.50, -1465.932, 9.819, 0.000, -89.999, 0.000);
	txt_map=CreateDynamicObject(19447, 2833.597, -1473.437, 11.879, 0.000, 0.000, 0.000);
	SetDynamicObjectMaterial(txt_map,0, 18887, "forcefields", "white", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(-3497, 2836.209, -1473.814, 12.661, 0.00, 0.00, 0.00, -1, -1, -1, 100.0, 100.0);
	txt_map = CreateDynamicObject(-3496, 2836.209, -1473.814, 12.661, 0.00, 0.00, 0.00, -1, -1, -1, 100.0, 100.0);
	txt_map = CreateDynamicObject(-3495, 2836.824, -1477.902, 10.917, 0.00, 0.00, 0.00, -1, -1, -1, 150.0, 150.0);
	txt_map = CreateDynamicObject(-3494, 2839.259, -1477.902, 10.917, 0.00, 0.00, 0.00, -1, -1, -1, 150.0, 150.0);
	txt_map = CreateDynamicObject(-3493, 2861.733, -1470.087, 28.141, 0.000, 0.000, 0.000, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3491, 2855.356, -1470.510, 29.921, 0.000, 0.000, 0.000, -1, -1, -1, 100.0, 100.0);
	txt_map = CreateDynamicObject(-3490, 2855.356, -1470.510, 29.921, 0.000, 0.000, 0.000, -1, -1, -1, 100.0, 100.0);
	txt_map = CreateDynamicObject(-3489, 2855.356, -1470.510, 29.921, 0.000, 0.000, 0.000, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3488, 2855.356, -1470.510, 29.921, 0.000, 0.000, 0.000, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3487, 2855.356, -1470.510, 29.921, 0.000, 0.000, 0.000, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3486, 2855.356, -1470.510, 29.921, 0.000, 0.000, 0.000, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3499, 2846.05, -1453.33, 24.80, 0.00, 0.00, 0.00, -1, -1, -1, 150.0, 150.0);
	txt_map = CreateObject(-3500, 2846.05, -1453.33, 24.80, 0.00, 0.00, 0.00, 800.0);
	txt_map = CreateDynamicObject(-3498, 2847.493, -1472.948, 12.251, 0.00, 0.00, 0.00, -1, -1, -1, 400.0, 400.0);
	txt_map = CreateDynamicObject(-3485, 2836.221, -1470.019, 12.761, 0.00, 0.00, 0.00, -1, -1, -1, 100.0, 100.0);
	txt_map = CreateDynamicObject(-3484, 2837.321, -1470.019, 12.761, 0.00, 0.00, 0.00, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3483, 2837.221, -1470.019, 12.761, 0.00, 0.00, 0.00, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3485, 2853.385, -1464.444, 30.025, 0.00, 0.00, 0.00, -1, -1, -1, 100.0, 100.0);
	txt_map = CreateDynamicObject(-3484, 2854.385, -1464.444, 30.025, 0.00, 0.00, 0.00, -1, -1, -1, 50.0, 50.0);
	txt_map = CreateDynamicObject(-3483, 2854.385,  -1464.444, 30.025, 0.00, 0.00, 0.00, -1, -1, -1, 50.0, 50.0);
	txt_map=CreateDynamicObject(11711, 2839.030700, -1457.881800, 39.214600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 50.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2854.283400, -1470.473700, 11.106800, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1298, 2854.026800, -1462.916500, 11.703200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2854.283400, -1469.773000, 11.106800, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2854.283400, -1469.112600, 11.106800, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2854.283400, -1469.373000, 10.706800, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(11711, 2851.772900, -1478.023500, 12.759400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2854.283400, -1470.173800, 10.706800, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1298, 2854.026800, -1461.905700, 11.703200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1470.277300, 11.503100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1298, 2854.026800, -1461.905700, 10.883100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1298, 2854.026800, -1462.756400, 10.883100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2854.296800, -1462.197100, 11.501600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1469.376900, 11.503100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1476.644000, 11.503100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1475.483000, 11.503100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1476.063400, 11.103000, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1476.704200, 11.103000, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2854.296800, -1461.216400, 11.501600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1475.423300, 11.103000, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2854.296800, -1461.216400, 12.301600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2854.214300, -1476.198200, 11.499500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2854.296800, -1462.176700, 12.301600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2854.214300, -1475.557700, 10.719400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2854.148600, -1458.898500, 10.998900, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2854.148600, -1459.609100, 10.998900, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2854.214300, -1475.938100, 10.719400, 0.000000, 0.000000, 34.599900, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2854.214300, -1476.899000, 10.719400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2854.214300, -1476.418400, 10.719400, 0.000000, 0.000000, -38.400000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2854.257800, -1476.338700, 11.903100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2854.148600, -1458.157900, 10.998900, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2854.148600, -1459.278900, 10.569000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(19353, 2854.370800, -1473.098200, 11.060700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 6349, "sunbill_law2", "SunBillB02", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19353, 2854.370800, -1459.196100, 13.500600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 6349, "sunbill_law2", "SunBillB02", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(-1290, 2854.148600, -1458.418300, 10.569000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2413, 2858.979000, -1457.108500, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1456.392800, 11.433400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1456.022400, 11.433400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1455.572000, 11.433400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1455.081500, 11.433400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1454.831100, 11.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1455.331600, 11.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1455.892300, 11.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2854.220400, -1456.322600, 11.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2413, 2858.979200, -1460.180500, 9.914800, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(936, 2839.631500, -1463.179000, 10.431600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.347600, -1457.687500, 9.913300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2860.590000, -1457.108000, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19786, 2856.088800, -1478.334200, 11.576300, 0.000000, 90.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 8463, "vgseland", "tiadbuddhagold", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2861.221100, -1453.845900, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(936, 2839.471400, -1468.119700, 10.431600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2859.609600, -1453.845400, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.347600, -1460.829300, 9.913300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2859.949200, -1457.688100, 9.914800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2860.590000, -1460.180500, 9.914500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(10252, 2834.044600, -1464.536100, 15.302200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(3801, 2864.758000, -1463.620200, 13.333900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2413, 2859.949200, -1460.829300, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2411, 2863.958900, -1456.383900, 11.070500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2411, 2863.768700, -1457.784400, 11.070500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2411, 2863.958900, -1459.205400, 11.070500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(1522, 2851.078100, -1456.835200, 9.947500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1361, 2865.064600, -1469.199300, 10.640000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 300.0);
	txt_map=CreateDynamicObject(19325, 2864.762600, -1457.882200, 10.975800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14853, "gen_pol_vegas", "pol_win_kb", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2994, 2837.543400, -1467.883000, 10.466700, 0.000000, 0.000000, 59.599900, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(10252, 2835.416000, -1463.847400, 15.302200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(2994, 2837.114700, -1464.963100, 10.466700, 0.000000, 0.000000, 0.200000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(19325, 2864.522400, -1473.872800, 10.995900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14853, "gen_pol_vegas", "pol_win_kb", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1522, 2851.078100, -1461.797700, 9.947500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2930, 2834.702600, -1463.330200, 16.295700, 0.000000, 180.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 16640, "a51", "Metal3_128", 0xFF221918);
	txt_map=CreateDynamicObject(1361, 2865.064600, -1462.536800, 10.640000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 300.0);
	txt_map=CreateDynamicObject(19786, 2856.088800, -1453.479600, 11.576300, 0.000000, 90.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 8463, "vgseland", "tiadbuddhagold", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19786, 2863.414000, -1453.479600, 11.576300, 0.000000, 90.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 8463, "vgseland", "tiadbuddhagold", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19786, 2863.144500, -1478.334200, 11.576300, 0.000000, 90.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 8463, "vgseland", "tiadbuddhagold", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19786, 2859.762400, -1453.479600, 11.866300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 8463, "vgseland", "tiadbuddhagold", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 6349, "sunbill_law2", "SunBillB02", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19786, 2859.762400, -1478.321000, 11.866300, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 8463, "vgseland", "tiadbuddhagold", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 6349, "sunbill_law2", "SunBillB02", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19806, 2858.811200, -1465.953800, 13.944100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2413, 2857.998000, -1453.845900, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(3801, 2864.758000, -1468.051200, 13.333900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(927, 2852.957500, -1469.333200, 12.183300, 0.000000, 0.000000, -90.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(1431, 2841.367400, -1476.740700, 11.544400, 0.000000, 0.000000, 105.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 9583, "bigshap_sfw", "freight_crate1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19921, 2852.394700, -1469.127800, 10.029100, 0.000000, 0.000000, -22.100000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19843, 2852.960400, -1469.787700, 11.616200, 0.000000, 90.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 9278, "gazsfnlite", "fusebox1_128", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(18644, 2852.632500, -1468.882400, 10.137100, 0.000000, 90.000000, 0.000000, -1, -1, -1, 50.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1454.809400, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1463.021800, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1458.849200, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1456.768500, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1460.842000, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1476.823100, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1468.679800, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1473.220700, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1474.960400, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(957, 2858.891600, -1470.979200, 13.757200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(19353, 2842.759500, -1456.373400, 9.863200, 0.000000, 90.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14415, "carter_block_2", "mp_motel_carpet1", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2257, 2844.246800, -1453.722900, 11.711700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 14706, "labig2int2", "HS_art2", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2209, 2842.807100, -1456.951400, 9.960100, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,1, 3922, "bistro", "Marble2", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19999, 2842.036100, -1456.333300, 9.888800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2257, 2841.434000, -1453.722900, 11.711700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 14707, "labig3int2", "HS_art8", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1720, 2844.060500, -1457.094100, 9.927200, 0.000000, 0.000000, -112.300000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1720, 2844.020000, -1455.788800, 9.927200, 0.000000, 0.000000, -68.199900, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2861.861800, -1477.923300, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2860.250400, -1477.923300, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.639100, -1477.923300, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2859.949200, -1474.753600, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.337600, -1474.753600, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.337600, -1471.371300, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2859.948900, -1471.371300, 9.913900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.979000, -1470.711600, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2860.580500, -1470.711600, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2860.580500, -1474.102500, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2413, 2858.979000, -1474.102500, 9.913900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 14581, "ab_mafiasuitea", "barbersmir1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,2, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(txt_map,3, 3922, "bistro", "Marble", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2411, 2863.458400, -1474.110200, 11.070500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2411, 2863.918900, -1475.950400, 11.070500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2411, 2863.918900, -1472.418400, 11.070500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(1514, 2857.707500, -1465.909000, 11.031100, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(19477, 2864.500700, -1465.874500, 13.234600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 6988, "vgnfremnt1", "goldframe_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2710, 2858.706200, -1470.698800, 10.573100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2860.276800, -1470.621800, 10.573100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2859.680100, -1470.621400, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2860.531000, -1470.621400, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2858.949400, -1470.621400, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2858.078600, -1470.621400, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.115200, -1470.560900, 10.242600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2858.493800, -1470.560900, 10.242600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2858.343700, -1471.550900, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2859.214500, -1471.550900, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.095400, -1471.550900, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.776100, -1471.550900, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1298, 2859.794900, -1471.231400, 10.366100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1298, 2858.153500, -1471.231400, 10.366100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2861.177400, -1474.253600, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2860.386900, -1474.253600, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2859.616200, -1474.253600, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2858.725300, -1474.253600, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2860.095200, -1473.906700, 10.247000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2858.543700, -1473.906700, 10.247000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2860.155700, -1474.763500, 10.448400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2858.494600, -1474.763500, 10.448400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2859.056100, -1474.806600, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1283, 2863.966500, -1455.349200, 10.930000, 0.000000, -90.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2858.185500, -1474.806600, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2859.766800, -1474.806600, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2860.797800, -1474.806600, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1286, 2859.692100, -1474.890200, 10.236100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1286, 2860.532200, -1474.890200, 10.236100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1286, 2858.931600, -1474.890200, 10.236100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1286, 2858.091000, -1474.890200, 10.236100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1287, 2858.260000, -1477.833000, 10.508600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1287, 2861.603200, -1477.833000, 10.508600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1288, 2859.909900, -1477.894100, 10.496800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1292, 2859.398600, -1477.855200, 10.560100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1292, 2860.399600, -1477.855200, 10.560100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1292, 2861.050200, -1477.855200, 10.560100, 0.000000, 0.000000, -19.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1292, 2862.116900, -1477.867600, 10.560100, 0.000000, 0.000000, 22.899900, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1292, 2858.768000, -1477.855200, 10.560100, 0.000000, 0.000000, 18.899900, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1292, 2857.747500, -1477.855200, 10.560100, 0.000000, 0.000000, -22.399900, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1283, 2863.766300, -1456.750700, 10.930000, 0.000000, -90.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2860.276800, -1460.068800, 10.573100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1283, 2863.946500, -1458.172100, 10.930000, 0.000000, -90.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2858.645200, -1460.068800, 10.573100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2858.078600, -1460.109000, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1283, 2863.946500, -1471.377300, 10.930000, 0.000000, -90.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2858.949400, -1460.109000, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2859.680100, -1460.109000, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2860.531000, -1460.109000, 10.567100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.115200, -1460.109000, 10.242600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2858.493800, -1460.109000, 10.242600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.095400, -1461.040000, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.776100, -1461.040000, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2859.214500, -1461.040000, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2858.343700, -1461.040000, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2859.786300, -1460.639600, 10.368800, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2858.095200, -1460.639600, 10.368800, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2860.386900, -1457.232000, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2860.386900, -1457.232000, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2858.543700, -1456.961600, 10.247000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1294, 2860.095200, -1456.981800, 10.247000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2861.187700, -1457.232000, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2859.547600, -1457.232000, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1295, 2858.776800, -1457.232000, 10.368800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1283, 2863.446000, -1473.078800, 10.930000, 0.000000, -90.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1283, 2863.906400, -1474.920000, 10.930000, 0.000000, -90.000000, -90.000000, -1, -1, -1, 75.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2860.797800, -1457.765000, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2859.766800, -1457.765000, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2859.056100, -1457.765000, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2858.343700, -1457.757800, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1293, 2858.185500, -1457.765000, 10.578300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2859.144500, -1457.757800, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2860.485800, -1457.757800, 10.242600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2858.494600, -1457.698600, 10.448400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2860.276800, -1457.052800, 10.573100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1290, 2860.096100, -1457.698600, 10.448400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2858.655200, -1457.052800, 10.573100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2857.814400, -1453.812100, 10.573100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2858.835400, -1453.812100, 10.573100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2859.935700, -1453.812100, 10.573100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2860.976500, -1453.812100, 10.573100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(2710, 2862.117600, -1453.812100, 10.573100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2861.692100, -1453.885200, 10.567100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2860.531000, -1453.885200, 10.567100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2859.650100, -1453.885200, 10.567100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2858.448900, -1453.885200, 10.567100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2838.890800, -1468.167800, 11.027100, 0.000000, 0.000000, 45.599900, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1297, 2837.193300, -1464.791500, 10.929400, 0.000000, 0.000000, -86.199800, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2837.470900, -1467.636300, 10.427200, 0.000000, 0.000000, -29.799900, -1, -1, -1, 250.0, 300.0);
	txt_map = CreateDynamicObject(-1296, 2837.118400, -1464.876700, 10.427200, 0.000000, 0.000000, -29.799900, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(1998, 2841.307100, -1460.980900, 9.935500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(638, 2846.618400, -1465.647300, 10.611400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(1663, 2842.109300, -1461.138400, 10.369000, 0.000000, 0.000000, 129.899900, -1, -1, -1, 250.0, 300.0);
	txt_map=CreateDynamicObject(638, 2850.598300, -1458.506100, 10.611400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(1209, 2847.819800, -1453.797300, 9.905500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(1776, 2848.979000, -1453.807200, 11.014800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 75.0, 300.0);
	txt_map=CreateDynamicObject(1720, 2846.700900, -1458.150000, 9.927200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(2673, 2848.445000, -1454.574900, 10.040300, 0.000000, 0.000000, -43.200000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,1, 1355, "break_s_bins", "CJ_RED_LEATHER", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1720, 2846.700900, -1458.950400, 9.927200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1720, 2846.700900, -1459.830900, 9.927200, 0.000000, 0.000000, 130.199900, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(19825, 2846.248000, -1458.990100, 12.264600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 75.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 1654, "dynamite", "clock64", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1491, 2851.098800, -1466.652800, 9.935400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 100.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1491, 2848.576400, -1468.474600, 9.935400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1491, 2846.178900, -1457.508500, 9.935400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 100.0, 300.0);
	SetDynamicObjectMaterial(txt_map,0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	txt_map=CreateDynamicObject(1893, 2848.672300, -1464.802100, 13.911000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(1893, 2848.672300, -1457.979100, 13.911000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(1893, 2842.729700, -1457.038300, 13.831000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 100.0, 300.0);
	txt_map=CreateDynamicObject(1893, 2835.886900, -1459.837800, 13.810900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.0, 300.0);

}

LoadRodeoMap() {
	// START // Grumbleduck -- Honey_Caleno -- Rodeo Mapping 2015 // BY Gemma
	// From True Roleplay made by Ashley Lipscombe (aka Limex).

	CreateDynamicObject(1537, 480.399231, -1466.906372, 17.945024, 0.000000, 3.500001, 67.399956);
	CreateDynamicObject(1537, 479.823914, -1468.287720, 18.036587, 0.000000, 3.500001, 67.399956);
	CreateDynamicObject(1557, 475.210205, -1500.308105, 19.434126, 0.000000, 0.000000, 82.099983);
	CreateDynamicObject(1557, 475.440308, -1497.308105, 19.434126, 0.000000, 0.000000, -90.899994);
	CreateDynamicObject(1537, 473.983521, -1517.379395, 19.399544, 0.000000, 0.000000, 95.000000);
	CreateDynamicObject(19176, 493.431915, -1503.016235, 20.997993, 0.000000, 1.000000, 85.599976);
	CreateDynamicObject(19176, 495.748993, -1486.486938, 20.313019, 0.000000, 1.000001, 76.300003);
	CreateDynamicObject(19176, 477.809052, -1536.783203, 19.868849, 0.000000, -1.100015, 107.300026);
	CreateDynamicObject(19176, 493.499023, -1510.411133, 20.963711, 0.000000, 0.000000, 94.700005);
	CreateDynamicObject(19176, 494.104309, -1517.655518, 20.783705, 0.000000, 0.000000, 94.700005);
	CreateDynamicObject(1346, 493.030670, -1499.498779, 20.768122, 0.000000, 0.000000, -92.399963);
	CreateDynamicObject(3471, 476.934601, -1501.526245, 20.622097, 0.000000, 0.000000, -7.299994);
	CreateDynamicObject(18014, 494.382904, -1490.581665, 19.562868, -3.199998, 0.000000, -12.200003);
	CreateDynamicObject(3749, 505.409821, -1446.285889, 19.831541, 0.000000, 0.000000, -39.600002);
	CreateDynamicObject(1231, 479.309723, -1505.094360, 20.595934, 0.000000, 0.000000, 85.499992);
	CreateDynamicObject(1231, 479.977020, -1493.682617, 20.375929, 0.000000, 0.000000, 85.499992);
	CreateDynamicObject(1231, 476.453400, -1514.367920, 20.475929, 0.000000, 0.000000, 91.500000);
	CreateDynamicObject(1231, 478.422241, -1483.869751, 20.035921, 0.000000, 0.000000, 85.499992);
	CreateDynamicObject(1231, 483.644318, -1462.065674, 18.515913, 0.000000, 0.000000, 62.300014);
	CreateDynamicObject(1231, 496.275543, -1482.797363, 19.705908, 0.000000, 0.000000, 75.900024);
	CreateDynamicObject(3749, 508.858673, -1567.105957, 21.171509, 0.000000, 0.000000, 41.299965);
	CreateDynamicObject(18014, 494.398254, -1521.845215, 19.554516, 3.700001, 0.199999, 14.599996);
	CreateDynamicObject(1231, 495.268463, -1525.488525, 19.965919, 0.000000, 0.000000, 103.799965);
	CreateDynamicObject(1231, 493.498871, -1514.975098, 20.455921, 0.000000, 0.000000, 95.699898);
	CreateDynamicObject(1231, 493.450897, -1498.698242, 20.505922, 0.000000, 0.000000, 87.799904);
	CreateDynamicObject(1257, 513.218628, -1448.806152, 15.242550, 0.000000, 0.000000, -129.199997);
	CreateDynamicObject(1366, 487.810852, -1454.569336, 17.162024, 0.000000, 0.000000, -36.900005);
	CreateDynamicObject(1280, 476.579041, -1488.901855, 19.591982, 1.899999, 0.000000, -171.599884);
	CreateDynamicObject(1280, 475.183441, -1509.124268, 19.946339, 0.700000, 0.000000, 165.099869);
	CreateDynamicObject(3041, 493.492706, -1494.528809, 19.269119, 1.500000, -2.100002, -95.400047);
	CreateDynamicObject(2714, 494.295868, -1492.162720, 21.799555, 0.099999, -18.900001, -102.699905);
	CreateDynamicObject(792, 479.386688, -1527.282837, 19.125481, 3.399999, 0.000000, 15.300003);
	CreateDynamicObject(792, 485.045197, -1543.729858, 17.951363, 5.199999, 0.000000, 26.100002);
	CreateDynamicObject(792, 475.575165, -1506.931396, 19.711905, 0.000000, 0.000000, -14.900004);
	CreateDynamicObject(792, 474.244171, -1511.314819, 19.711905, 0.000000, 0.000000, -21.100010);
	CreateDynamicObject(792, 476.709564, -1491.219727, 19.443443, -2.300001, -0.199999, 7.599990);
	CreateDynamicObject(792, 476.074432, -1486.659424, 19.231682, -2.500001, 2.399998, 104.099937);
	CreateDynamicObject(792, 496.404846, -1538.164062, 17.951363, 5.199999, 0.000000, 23.600004);
	CreateDynamicObject(792, 491.569061, -1523.950073, 19.125481, 3.399999, 0.000000, 13.699996);
	CreateDynamicObject(16760, 473.871460, -1487.875122, 31.047207, 0.000000, 0.000000, 175.699966);
	CreateDynamicObject(18014, 475.632965, -1492.384155, 19.731031, -1.899997, 0.000000, 6.899995);
	CreateDynamicObject(3471, 477.320435, -1496.409668, 20.622097, 0.000000, 0.000000, -0.299996);
	CreateDynamicObject(18014, 474.589752, -1486.236816, 19.523470, -1.899997, 0.000000, 13.099998);
	CreateDynamicObject(1231, 475.331573, -1489.216064, 20.265926, 0.000000, 0.000000, 97.899918);
	CreateDynamicObject(1231, 473.651581, -1508.837646, 20.575928, 0.000000, 0.000000, 73.599930);
	CreateDynamicObject(18014, 474.518402, -1505.755005, 20.026606, -0.099997, 0.000000, -12.800005);
	CreateDynamicObject(18014, 472.735443, -1511.635742, 19.957403, 1.000003, 0.000000, -20.800003);
	CreateDynamicObject(18013, 468.921936, -1499.525879, 22.860556, 0.000000, 0.000000, 81.999992);
	CreateDynamicObject(18013, 469.073639, -1494.921509, 22.860556, 0.000000, 0.000000, 90.000000);
	CreateDynamicObject(1231, 492.770264, -1506.776245, 20.505922, 0.000000, 0.000000, 87.799904);
	CreateDynamicObject(18013, 486.685455, -1532.106079, 24.826889, 0.000000, 0.000000, 11.500003);
	CreateDynamicObject(18013, 492.184509, -1530.793823, 24.826889, 0.000000, 0.000000, 11.500003);
	CreateDynamicObject(3498, 490.955688, -1524.952881, 26.010344, 0.000000, 90.000000, 11.799988);
	CreateDynamicObject(3498, 482.116486, -1526.799561, 26.010344, 0.000000, 90.000000, 11.799988);
	CreateDynamicObject(3498, 473.277557, -1528.645020, 26.010344, 0.000000, 90.000000, 11.799988);
	CreateDynamicObject(3498, 483.188690, -1539.120972, 26.670334, 0.000000, 90.000000, 11.799988);
	CreateDynamicObject(3498, 492.027710, -1537.274902, 26.670334, 0.000000, 90.000000, 11.799988);
	CreateDynamicObject(3498, 500.866852, -1535.428589, 26.670334, 0.000000, 90.000000, 11.799988);
	CreateDynamicObject(18013, 493.023346, -1466.625000, 24.226891, 0.000000, 0.000000, -23.099997);
	CreateDynamicObject(3498, 495.253448, -1474.338257, 26.081476, -17.799999, 90.000000, -23.499998);
	CreateDynamicObject(3498, 486.981506, -1470.741943, 26.081476, -17.799999, 90.000000, -23.499998);
	CreateDynamicObject(3498, 478.700439, -1467.141602, 26.081476, -17.799999, 90.000000, -23.499998);
	CreateDynamicObject(3498, 501.585114, -1463.112061, 25.546774, -17.799999, 90.000000, -23.499998);
	CreateDynamicObject(3498, 493.304108, -1459.511230, 25.546774, -17.799999, 90.000000, -23.499998);
	CreateDynamicObject(3498, 485.032349, -1455.915405, 25.546774, -17.799999, 90.000000, -23.499998);
	CreateDynamicObject(18013, 491.832764, -1465.747559, 24.300758, 4.199998, 0.000000, 156.899979);
	CreateDynamicObject(2895, 497.340820, -1460.849731, 25.595287, -90.599983, 0.000000, -33.300003);
	CreateDynamicObject(2895, 495.894501, -1460.246460, 25.598330, -90.599983, 0.000000, -33.300003);
	CreateDynamicObject(2895, 488.725861, -1471.159424, 25.935083, -90.599983, 0.000000, -33.300003);
	CreateDynamicObject(2895, 492.756866, -1472.946899, 25.927536, -90.599983, 0.000000, -33.300003);
	CreateDynamicObject(1616, 493.263550, -1512.702881, 23.391989, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(3038, 485.365417, -1526.150757, 25.466019, 0.000000, 0.000000, 103.099998);
	CreateDynamicObject(3038, 488.146362, -1538.101929, 26.096029, 0.000000, 0.000000, 103.099998);
	CreateDynamicObject(3038, 489.981567, -1472.108887, 25.472712, 0.000000, 0.000000, 65.900009);
	CreateDynamicObject(3038, 495.240967, -1460.351318, 24.972706, 0.000000, 0.000000, 65.900009);
	CreateDynamicObject(7655, 489.262909, -1484.099487, 27.926231, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(7655, 483.412964, -1493.560425, 27.926231, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(7655, 489.262909, -1504.931396, 27.926231, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(7655, 489.262909, -1521.589844, 27.926231, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(1972, 493.617462, -1513.105469, 20.902733, 0.000000, 0.000000, -87.200005);
	SetDynamicObjectMaterial(CreateDynamicObject(19426, 494.929108, -1513.163330, 20.668415, 0.000000, 90.000000, 3.099999), 0, 5134, "wasteland_las2", "ws_sandstone2", 0);
	CreateDynamicObject(19623, 493.442017, -1512.876953, 20.811777, 0.000000, 0.000000, -44.300003);
	CreateDynamicObject(19623, 493.446350, -1513.230347, 20.811777, 0.000000, 0.000000, -44.300003);
	CreateDynamicObject(367, 493.682098, -1513.587646, 20.771786, 0.000000, 0.000000, 142.999985);
	SetDynamicObjectMaterial(CreateDynamicObject(19426, 495.697388, -1520.647827, 20.668415, 0.000000, 90.000000, 14.200004), 0, 5134, "wasteland_las2", "ws_sandstone2", 0);
	CreateDynamicObject(1972, 494.402130, -1520.844849, 20.902733, 0.000000, 0.000000, -75.600037);
	SetDynamicObjectMaterial(CreateDynamicObject(19426, 477.861908, -1540.308350, 19.618410, 0.000000, 90.000000, 27.600004), 0, 5134, "wasteland_las2", "ws_sandstone2", 0);
	CreateDynamicObject(1972, 479.054382, -1539.811401, 19.862734, 0.000000, 0.000000, 117.699997);
	SetDynamicObjectMaterial(CreateDynamicObject(19426, 476.511749, -1475.752930, 19.788412, 0.000000, 90.000000, -11.999998), 0, 5134, "wasteland_las2", "ws_sandstone2", 0);
	CreateDynamicObject(1972, 477.766479, -1476.160889, 20.032730, 0.000000, 0.000000, 77.800003);
	CreateDynamicObject(18950, 479.257507, -1540.071533, 19.752674, -8.199995, -92.600021, -29.199995);
	CreateDynamicObject(18950, 479.106720, -1539.827148, 19.741253, -8.199995, -92.600021, -29.199995);
	CreateDynamicObject(2710, 478.892609, -1539.367920, 19.811083, 0.000000, 0.000000, 85.199997);
	CreateDynamicObject(2050, 497.661072, -1532.879761, 19.908098, 0.000000, 0.000000, -66.100006);
	CreateDynamicObject(2049, 497.652313, -1532.874390, 20.796572, 0.000000, -0.100000, -66.600021);
	CreateDynamicObject(2386, 494.237885, -1520.725464, 20.838236, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(2384, 494.408020, -1521.315308, 20.848228, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(14521, 496.155792, -1520.624023, 21.099384, 0.000000, 0.000000, 21.599997);
	CreateDynamicObject(18874, 477.989655, -1475.793213, 19.859676, 0.000000, 0.000000, 30.499996);
	CreateDynamicObject(18874, 478.024872, -1475.656250, 19.859676, 0.000000, 0.000000, 30.499996);
	CreateDynamicObject(18869, 477.979340, -1476.058594, 19.859678, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(18869, 477.849304, -1476.058594, 19.859678, 0.000000, 0.000000, 0.000000);
	CreateDynamicObject(18866, 477.894836, -1476.448853, 19.859678, 0.000000, 0.000000, 114.999992);
	CreateDynamicObject(18866, 477.893799, -1476.328613, 19.859678, 0.000000, 0.000000, 114.999992);
	CreateDynamicObject(1234, 477.884064, -1475.156250, 19.896099, 0.000000, 0.000000, -13.600000);
	CreateDynamicObject(330, 477.584747, -1476.199707, 20.128231, 0.000000, 0.000000, -100.700027);
	CreateDynamicObject(330, 477.603302, -1476.101318, 20.128231, 0.000000, 0.000000, -100.700027);
}

LoadBeachMap() {
	CreateDynamicObject(16003, 309.64999390, -1836.00000000, 4.11999989, 0.00000000, 0.00000000, 180.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(16003, 309.62554932, -1846.19995117, 3.80119991, 0.00000000, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(2405, 310.60000610, -1847.69995117, 3.62999988, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(2404, 308.39999390, -1837.46997070, 3.90000010, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(2404, 309.16000366, -1837.46997070, 3.90000010, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1461, 327.20001221, -1879.19995117, 2.20000005, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1461, 255.39999390, -1873.59997559, 1.89999998, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1461, 183.69999695, -1872.69995117, 2.50000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1598, 203.19921875, -1848.50000000, 2.70000005, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 333.79998779, -1847.90002441, 2.97008395, 0.00000000, 0.00000000, 299.99816895, 0, 0, -1, 400.0); //
	CreateDynamicObject(2406, 310.69921875, -1844.72949219, 3.70000005, 0.00000000, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(2405, 309.09960938, -1844.72949219, 3.70000005, 0.00000000, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 335.89999390, -1847.90002441, 2.97008395, 0.00000000, 0.00000000, 239.99633789, 0, 0, -1, 400.0); //
	CreateDynamicObject(1642, 265.79980469, -1853.39941406, 2.16700006, 1.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1641, 267.50000000, -1853.39941406, 2.17900014, 1.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1280, 303.19921875, -1823.19921875, 3.41000009, 358.00000000, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(1280, 303.09960938, -1841.39941406, 2.90555549, 358.40002441, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(1280, 303.19921875, -1837.39941406, 3.02999997, 358.00000000, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(1280, 308.79980469, -1856.19921875, 2.53999996, 2.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1281, 233.59960938, -1842.29980469, 3.25000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(2406, 308.89999390, -1834.52050781, 4.00000000, 0.00000000, 0.00000000, 179.99450684, 0, 0, -1, 400.0); //
	CreateDynamicObject(1598, 309.79998779, -1834.59997559, 3.05999994, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1598, 311.60000610, -1847.30004883, 2.70000005, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1328, 303.19921875, -1839.39941406, 3.09999990, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1280, 308.59960938, -1828.59960938, 3.31555629, 2.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(642, 334.89999390, -1847.09997559, 3.75000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 278.70001221, -1837.69995117, 3.20000005, 0.00000000, 0.00000000, 270.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 276.10000610, -1837.59997559, 3.20000005, 0.00000000, 0.00000000, 270.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 277.39999390, -1837.59997559, 3.20000005, 0.00000000, 0.00000000, 270.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(642, 344.29998779, -1847.80004883, 3.77999997, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 345.39999390, -1848.90002441, 3.03700829, 0.00000000, 0.00000000, 239.99633789, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 342.70001221, -1848.40002441, 3.03700829, 0.00000000, 0.00000000, 299.99816895, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 350.00000000, -1862.80004883, 2.65000010, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 347.79998779, -1862.80004883, 2.65000010, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1647, 348.89999390, -1862.80004883, 2.50000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1281, 180.80000305, -1816.30004883, 4.11999989, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1645, 218.89999390, -1863.59997559, 2.20099998, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 220.19999695, -1863.59997559, 2.20099998, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1645, 173.10000610, -1856.09997559, 2.60000014, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 175.39999390, -1856.09997559, 2.60000014, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1647, 174.19999695, -1856.00000000, 2.50000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 194.00000000, -1874.19946289, 2.08100009, 0.00000000, 5.00000000, 300.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1255, 196.10000610, -1874.30004883, 2.00100017, 0.00000000, 5.00000000, 240.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(2817, 224.39999390, -1856.90002441, 2.14099979, 0.00000000, 358.59997559, 90.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(2818, 225.60000610, -1856.90002441, 2.09999990, 0.00000000, 358.50000000, 90.00000000, 0, 0, -1, 400.0); //
	//CreateDynamicObject(1646, 268.19921875, -1870.79980469, 1.77999997, 3.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	//CreateDynamicObject(1645, 269.39941406, -1870.79980469, 1.77999997, 3.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	//CreateDynamicObject(1645, 270.59960938, -1870.79980469, 1.77999997, 3.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	//CreateDynamicObject(1646, 271.79980469, -1870.89941406, 1.77999997, 3.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1598, 255.10000610, -1868.59997559, 1.79999995, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1598, 338.89999390, -1887.90002441, 1.20000005, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1598, 169.19999695, -1880.19995117, 1.39999998, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	//CreateDynamicObject(1646, 272.89941406, -1870.89941406, 1.77999997, 3.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1645, 313.79980469, -1871.79980469, 1.93999994, 2.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 314.79980469, -1871.79980469, 1.93999994, 2.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1645, 315.89941406, -1871.79980469, 1.93999994, 2.00000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 291.20001221, -1844.69995117, 2.73000002, 2.99926758, 0.00000000, 340.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 290.10000610, -1844.40002441, 2.73000002, 2.99926758, 0.00000000, 339.99938965, 0, 0, -1, 400.0); //
	CreateDynamicObject(1645, 245.30000305, -1845.69995117, 2.58999991, 1.50000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
	CreateDynamicObject(1646, 246.60000610, -1845.69995117, 2.58999991, 1.50000000, 0.00000000, 0.00000000, 0, 0, -1, 400.0); //
}

LoadSAPDLBTraining() {

	CreateDynamicObject(3335, -799.37000000, 1347.17000000, 12.61000000, 0.00000000, 0.00000000, 28.00000000, 0, 0, -1); //
	CreateDynamicObject(3335, -914.59000000, 1692.67000000, 26.43000000, 0.00000000, 0.00000000, 214.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -809.18000000, 1618.38000000, 26.37000000, 0.00000000, 0.00000000, 324.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -811.38000000, 1619.99000000, 26.37000000, 0.00000000, 0.00000000, 324.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -804.41000000, 1611.53000000, 26.37000000, 0.00000000, 0.00000000, 282.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -803.88000000, 1608.85000000, 26.38000000, 0.00000000, 0.00000000, 282.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -856.09000000, 1624.60000000, 26.40000000, 0.00000000, 0.00000000, 328.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -853.76000000, 1623.15000000, 26.39000000, 0.00000000, 0.00000000, 328.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -848.10000000, 1610.74000000, 26.29000000, 0.00000000, 0.00000000, 240.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -777.65000000, 1582.22000000, 26.37000000, 0.00000000, 0.00000000, 180.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -767.26000000, 1581.94000000, 26.38000000, 0.00000000, 0.00000000, 173.99000000, 0, 0, -1); //
	CreateDynamicObject(1422, -764.56000000, 1581.51000000, 26.38000000, 0.00000000, 0.00000000, 167.99000000, 0, 0, -1); //
	CreateDynamicObject(1422, -780.37000000, 1582.24000000, 26.37000000, 0.00000000, 0.00000000, 179.99000000, 0, 0, -1); //
	CreateDynamicObject(1422, -720.14000000, 1618.71000000, 26.53000000, 0.00000000, 0.00000000, 87.99000000, 0, 0, -1); //
	CreateDynamicObject(1422, -720.34000000, 1614.66000000, 26.53000000, 0.00000000, 0.00000000, 87.99000000, 0, 0, -1); //
	CreateDynamicObject(17037, -781.34000000, 1635.28000000, 28.55000000, 0.00000000, 0.00000000, 356.25000000, 0, 0, -1); //
	CreateDynamicObject(17037, -781.83000000, 1627.81000000, 28.55000000, 0.00000000, 0.00000000, 356.25000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.79000000, 1632.96000000, 26.10000000, 0.00000000, 0.00000000, 86.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.80000000, 1633.92000000, 26.08000000, 0.00000000, 0.00000000, 92.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.80000000, 1634.83000000, 26.07000000, 0.00000000, 0.00000000, 91.99000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.74000000, 1635.84000000, 26.06000000, 0.00000000, 0.00000000, 85.99000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.70000000, 1636.83000000, 26.06000000, 0.00000000, 0.00000000, 88.24000000, 0, 0, -1); //
	CreateDynamicObject(2002, -782.73000000, 1637.67000000, 26.04000000, 0.00000000, 0.00000000, 84.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -783.04000000, 1630.89000000, 26.12000000, 0.00000000, 0.00000000, 116.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.94000000, 1629.73000000, 26.12000000, 0.00000000, 0.00000000, 86.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -782.98000000, 1628.86000000, 26.12000000, 0.00000000, 0.00000000, 86.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -779.65000000, 1638.51000000, 26.03000000, 0.00000000, 0.00000000, 86.00000000, 0, 0, -1); //
	CreateDynamicObject(1810, -779.69000000, 1637.70000000, 26.04000000, 0.00000000, 0.00000000, 86.00000000, 0, 0, -1); //
	CreateDynamicObject(13640, -767.01000000, 1629.37000000, 26.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -754.18000000, 1627.09000000, 27.42000000, 0.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -754.15000000, 1631.12000000, 27.42000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(16500, -751.66000000, 1630.76000000, 29.24000000, 0.00000000, 270.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(16500, -751.66000000, 1627.46000000, 29.26000000, 0.00000000, 270.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(16500, -749.13000000, 1630.75000000, 30.16000000, 90.00000000, 0.00000000, 180.00000000, 0, 0, -1); //
	CreateDynamicObject(16500, -749.13000000, 1627.44000000, 30.16000000, 90.00000000, 0.00000000, 179.99000000, 0, 0, -1); //
	CreateDynamicObject(2945, -747.73000000, 1631.12000000, 32.65000000, 90.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -747.73000000, 1627.09000000, 32.65000000, 270.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -744.50000000, 1631.12000000, 32.65000000, 90.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -744.51000000, 1627.09000000, 32.65000000, 270.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(16500, -749.13000000, 1630.75000000, 25.19000000, 90.00000000, 0.00000000, 179.99000000, 0, 0, -1); //
	CreateDynamicObject(16500, -749.13000000, 1627.44000000, 25.19000000, 90.00000000, 0.00000000, 179.99000000, 0, 0, -1); //
	CreateDynamicObject(2945, -741.39000000, 1627.08000000, 31.74000000, 310.00000000, 179.99000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -741.41000000, 1630.73000000, 31.74000000, 310.00000000, 179.99000000, 89.99000000, 0, 0, -1); //
	CreateDynamicObject(2945, -738.91000000, 1627.09000000, 29.66000000, 310.00000000, 179.99000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -738.92000000, 1630.73000000, 29.66000000, 310.00000000, 179.99000000, 89.99000000, 0, 0, -1); //
	CreateDynamicObject(16500, -751.66000000, 1630.76000000, 26.23000000, 0.00000000, 270.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(16500, -751.66000000, 1627.46000000, 26.24000000, 0.00000000, 270.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -736.44000000, 1627.09000000, 27.59000000, 310.00000000, 179.99000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -736.44000000, 1630.73000000, 27.59000000, 310.00000000, 179.99000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(16101, -734.12000000, 1632.81000000, 25.59000000, 50.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(16101, -734.12000000, 1625.47000000, 25.59000000, 50.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(8673, -765.38000000, 1624.43000000, 27.53000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(8673, -744.98000000, 1624.43000000, 27.53000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(9339, -762.78000000, 1624.42000000, 26.82000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(9339, -738.57000000, 1624.42000000, 26.82000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(9339, -762.24000000, 1634.68000000, 26.93000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(9339, -748.78000000, 1634.68000000, 26.93000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(9131, -773.67000000, 1637.50000000, 26.45000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(9131, -768.18000000, 1637.47000000, 26.45000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -768.29000000, 1637.51000000, 27.66000000, 344.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -768.26000000, 1637.52000000, 27.66000000, 344.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(9131, -762.86000000, 1637.47000000, 26.45000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -762.49000000, 1637.51000000, 27.61000000, 15.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -774.06000000, 1637.52000000, 27.61000000, 15.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(9131, -762.86000000, 1640.57000000, 26.45000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(9131, -768.18000000, 1640.57000000, 26.45000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(9131, -773.67000000, 1640.57000000, 26.45000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -768.29000000, 1640.56000000, 27.66000000, 344.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -768.26000000, 1640.57000000, 27.66000000, 343.99000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -762.49000000, 1640.56000000, 27.61000000, 15.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2893, -774.05000000, 1640.57000000, 27.61000000, 14.99000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -754.39000000, 1638.01000000, 28.77000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -757.27000000, 1641.80000000, 27.49000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -757.30000000, 1637.76000000, 27.49000000, 0.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(2945, -757.27000000, 1641.80000000, 30.67000000, 0.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(16501, -767.00000000, 1629.38000000, 27.39000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -756.98000000, 1643.43000000, 28.85000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -756.99000000, 1636.25000000, 28.85000000, 0.00000000, 0.00000000, 346.74000000, 0, 0, -1); //
	CreateDynamicObject(2945, -757.30000000, 1637.76000000, 30.67000000, 0.00000000, 0.00000000, 270.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -751.49000000, 1638.01000000, 23.75000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -751.49000000, 1638.50000000, 23.75000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -754.39000000, 1638.50000000, 28.77000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -751.49000000, 1641.01000000, 23.75000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -751.49000000, 1641.52000000, 23.75000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -754.39000000, 1641.01000000, 28.77000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(1437, -754.39000000, 1641.52000000, 28.77000000, 340.00000000, 0.00000000, 90.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -756.98000000, 1639.90000000, 32.53000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -742.57000000, 1632.64000000, 28.63000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -742.56000000, 1629.16000000, 32.52000000, 90.00000000, 0.00000000, 180.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -742.57000000, 1625.69000000, 28.63000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -735.06000000, 1629.07000000, 26.06000000, 90.00000000, 0.00000000, 179.99000000, 0, 0, -1); //
	CreateDynamicObject(3498, -747.87000000, 1636.25000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -747.74000000, 1640.04000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -747.70000000, 1643.43000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -743.17000000, 1636.25000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -742.95000000, 1640.04000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -742.94000000, 1643.55000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -738.82000000, 1636.25000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -738.82000000, 1640.04000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -738.82000000, 1643.55000000, 22.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -743.30000000, 1640.04000000, 27.09000000, 72.00000000, 270.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -743.30000000, 1636.25000000, 27.09000000, 72.00000000, 269.99000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -743.30000000, 1643.55000000, 27.09000000, 72.00000000, 269.99000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(8673, -735.57000000, 1624.42000000, 27.53000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(1422, -725.83000000, 1623.07000000, 26.53000000, 0.00000000, 0.00000000, 151.99000000, 0, 0, -1); //
	CreateDynamicObject(1422, -721.96000000, 1620.92000000, 26.53000000, 0.00000000, 0.00000000, 151.98000000, 0, 0, -1); //
	CreateDynamicObject(9339, -727.09000000, 1639.59000000, 24.95000000, 9.00000000, 0.00000000, 44.25000000, 0, 0, -1); //
	CreateDynamicObject(9339, -726.93000000, 1639.44000000, 26.32000000, 9.00000000, 0.00000000, 44.25000000, 0, 0, -1); //
	CreateDynamicObject(9339, -726.77000000, 1639.29000000, 27.70000000, 9.00000000, 0.00000000, 44.25000000, 0, 0, -1); //
	CreateDynamicObject(16500, -733.44000000, 1643.18000000, 25.90000000, 0.00000000, 270.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -729.97000000, 1639.58000000, 25.90000000, 0.00000000, 270.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -726.53000000, 1635.96000000, 25.90000000, 0.00000000, 270.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -734.03000000, 1638.14000000, 25.90000000, 0.00000000, 270.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -735.77000000, 1634.18000000, 25.90000000, 0.00000000, 270.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -732.33000000, 1630.58000000, 25.90000000, 0.00000000, 270.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -724.67000000, 1634.38000000, 23.51000000, 90.00000000, 90.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -727.54000000, 1631.63000000, 23.51000000, 90.00000000, 90.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -730.44000000, 1628.86000000, 23.51000000, 90.00000000, 90.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -728.01000000, 1634.74000000, 23.98000000, 0.00000000, 0.00000000, 43.75000000, 0, 0, -1); //
	CreateDynamicObject(16500, -731.45000000, 1638.35000000, 23.98000000, 0.00000000, 0.00000000, 43.74000000, 0, 0, -1); //
	CreateDynamicObject(16500, -732.50000000, 1636.27000000, 23.98000000, 0.00000000, 0.00000000, 133.74000000, 0, 0, -1); //
	CreateDynamicObject(16500, -730.98000000, 1631.93000000, 23.98000000, 0.00000000, 0.00000000, 223.74000000, 0, 0, -1); //
	CreateDynamicObject(16500, -734.44000000, 1635.54000000, 23.98000000, 0.00000000, 0.00000000, 223.74000000, 0, 0, -1); //
	CreateDynamicObject(3498, -729.18000000, 1630.10000000, 27.88000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -733.83000000, 1634.84000000, 27.88000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(3498, -731.71000000, 1632.70000000, 32.02000000, 90.00000000, 0.00000000, 224.49000000, 0, 0, -1); //
	CreateDynamicObject(19089, -747.69000000, 1636.10000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -738.89000000, 1636.21000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -739.77000000, 1636.20000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -740.80000000, 1636.18000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -741.81000000, 1636.17000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -742.82000000, 1636.15000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -743.84000000, 1636.14000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -744.85000000, 1636.12000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -745.77000000, 1636.11000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19089, -746.68000000, 1636.10000000, 27.15000000, 90.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19088, -732.41000000, 1633.53000000, 29.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19088, -730.63000000, 1631.77000000, 29.89000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19087, -732.41000000, 1633.53000000, 32.28000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
	CreateDynamicObject(19087, -730.63000000, 1631.77000000, 32.28000000, 0.00000000, 0.00000000, 0.00000000, 0, 0, -1); //
}

LoadSAPDDrivingMap() {
	CreateDynamicObject(1238, -2064.6001000, -122.1000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2058.1999500, -121.9000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2071.1999500, -122.1000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2064.6999500, -116.1000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2071.1999500, -116.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2057.8999000, -116.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2077.6001000, -122.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2077.8000500, -116.1000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2084.0000000, -122.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2084.1999500, -116.4000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2090.8000500, -116.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.3999000, -122.4000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2088.1001000, -122.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2094.1001000, -118.1000000, 34.7000000, 0.0000000, 0.0000000, 328.0000000); //
	CreateDynamicObject(1238, -2088.3999000, -128.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.1999500, -128.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.3000500, -134.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.3000500, -139.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2090.6999500, -143.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2090.6001000, -148.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.5000000, -150.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.6001000, -156.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2094.6001000, -161.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2093.8000500, -165.2000000, 34.7000000, 0.0000000, 0.0000000, 47.9970000); //
	CreateDynamicObject(1238, -2088.3999000, -132.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2088.3000500, -137.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.6999500, -141.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.5000000, -146.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.6999500, -151.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2089.6001000, -154.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2088.8999000, -159.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2090.3999000, -165.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.8000500, -165.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.6999500, -160.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2087.3999000, -153.5000000, 34.7000000, 0.0000000, 0.0000000, 306.7470000); //
	CreateDynamicObject(1228, -2092.5000000, -141.8000000, 34.7000000, 0.0000000, 0.0000000, 49.9970000); //
	CreateDynamicObject(1238, -2081.5000000, -165.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2076.8999000, -165.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2072.6001000, -165.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2068.0000000, -165.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2063.8999000, -165.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2081.6001000, -160.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2076.8000500, -159.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2070.6001000, -159.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2068.0000000, -159.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2063.6001000, -160.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2063.0000000, -163.1000100, 34.7000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2079.8000500, -155.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2081.1999500, -150.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.5000000, -145.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2078.0000000, -141.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2075.8999000, -137.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2078.1999500, -133.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2081.1999500, -130.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.1999500, -130.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2085.1001000, -125.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.3999000, -125.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2075.3000500, -125.4000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2073.3000500, -155.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2074.8999000, -151.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2074.5000000, -146.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2071.6001000, -143.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2069.0000000, -138.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2069.6999500, -133.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2072.3999000, -130.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2068.1001000, -130.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2068.1999500, -124.9000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(3578, -2081.5000000, -123.5000000, 34.3000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(3578, -2082.6999500, -146.3999900, 34.3000000, 0.0000000, 0.0000000, 90.0000000); //
	CreateDynamicObject(3578, -2086.6999500, -129.2000000, 34.3000000, 0.0000000, 0.0000000, 90.0000000); //
	CreateDynamicObject(1238, -2062.1001000, -125.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2057.3999000, -127.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2052.8999000, -130.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2062.1999500, -131.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2057.8999000, -134.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2054.6001000, -138.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2048.8999000, -135.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2056.1999500, -143.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2047.4000200, -139.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2049.5000000, -144.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2058.6001000, -147.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2052.0000000, -147.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2058.1001000, -152.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2051.5000000, -151.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2056.0000000, -156.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2049.6001000, -156.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2055.5000000, -161.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2049.3999000, -161.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2057.1001000, -166.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2051.3999000, -166.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2053.1001000, -170.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2058.6999500, -170.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2075.6999500, -191.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.3999000, -199.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2061.6999500, -179.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2068.1001000, -186.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.8000500, -209.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.8000500, -218.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.6999500, -228.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.6001000, -238.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.6001000, -249.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2080.6001000, -259.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2089.0000000, -268.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2084.5000000, -274.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2077.0000000, -274.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2072.1999500, -270.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1318, -2078.1001000, -194.7000000, 34.2700000, 0.0000000, 90.0000000, 314.0000000); //
	CreateDynamicObject(1238, -2082.0000000, -181.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2089.3999000, -185.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2089.6999500, -179.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2084.3000500, -174.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2078.3999000, -173.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2073.3000500, -176.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2087.1001000, -191.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1318, -2076.2998000, -181.0996100, 34.3000000, 0.0000000, 90.0000000, 125.9970000); //
	CreateDynamicObject(1238, -2015.8000500, -149.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2032.0000000, -141.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2054.3000500, -175.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2060.3000500, -174.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2062.8000500, -195.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2067.1999500, -198.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2064.1001000, -203.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2059.6001000, -206.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2053.8000500, -208.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2048.3999000, -208.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2043.6999500, -210.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2040.0999800, -214.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2039.6999500, -219.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2042.3000500, -224.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2047.5999800, -227.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2053.3000500, -227.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2058.1999500, -229.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2062.3000500, -232.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2065.1001000, -238.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2063.8999000, -244.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2061.3999000, -249.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2060.0000000, -254.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2059.8999000, -260.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2059.3999000, -266.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2054.1001000, -267.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2048.6999500, -268.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2016.0999800, -276.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2020.5000000, -278.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2026.0999800, -278.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2013.8000500, -270.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2013.5999800, -265.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2016.5999800, -260.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2030.0999800, -275.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2021.9000200, -258.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2022.6999500, -268.7000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.4000200, -259.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2031.5000000, -269.7000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2031.4000200, -263.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2043.4000200, -268.7999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2038.5999800, -269.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2034.5000000, -269.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2059.5000000, -198.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2056.3999000, -201.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2052.0000000, -202.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2047.5000000, -202.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2043.1999500, -203.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2039.0999800, -205.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.5000000, -209.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2033.9000200, -214.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2034.1999500, -220.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2036.1999500, -225.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2039.3000500, -230.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2043.9000200, -232.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2050.1999500, -234.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2055.6999500, -235.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2059.0000000, -239.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2057.3000500, -244.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2055.6999500, -249.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2055.1001000, -254.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2054.8999000, -260.2000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2059.1999500, -266.0000000, 34.7000000, 0.0000000, 0.0000000, 47.9940000); //
	CreateDynamicObject(1238, -2050.0000000, -261.7000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2044.6999500, -262.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2039.8000500, -262.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.3000500, -262.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2031.0999800, -255.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.4000200, -253.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2040.0999800, -253.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2040.3000500, -248.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.8000500, -248.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.5999800, -254.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.0000000, -250.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.0000000, -250.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.0000000, -246.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2027.8000500, -245.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2030.4000200, -243.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2033.6999500, -247.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.9000200, -244.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2036.3000500, -240.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.0999800, -237.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2032.1999500, -235.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2030.0999800, -240.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.3000500, -237.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2029.5999800, -232.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.8000500, -227.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.5999800, -222.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.5999800, -216.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2025.6999500, -235.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2023.9000200, -227.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.5999800, -232.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2023.6999500, -222.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2023.6999500, -216.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.5999800, -211.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2023.5000000, -211.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2030.0999800, -206.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.5999800, -206.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(3578, -2031.0996100, -216.3994100, 34.3000000, 0.0000000, 0.0000000, 90.0000000); //
	CreateDynamicObject(1228, -2040.4000200, -250.8000000, 34.7000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2022.7998000, -248.5996100, 34.7000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.0999800, -144.8000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2015.4000200, -153.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2021.6999500, -154.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2020.6999500, -160.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2023.5999800, -163.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2020.9000200, -170.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2018.1999500, -174.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2018.3000500, -180.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2021.5000000, -185.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.6999500, -147.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2021.8000500, -150.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2025.0999800, -157.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.1999500, -161.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.6999500, -165.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.3000500, -170.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.4000200, -174.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.4000200, -180.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2027.6999500, -183.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2032.5999800, -203.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2036.5999800, -200.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2041.0999800, -199.0000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2033.0000000, -184.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2025.5000000, -188.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2030.9000200, -190.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2027.0999800, -201.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2031.3000500, -197.8999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2036.0000000, -194.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2039.0000000, -192.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2036.1999500, -190.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2038.4000200, -183.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2044.0999800, -182.7000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2049.1999500, -184.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2047.3000500, -197.3999900, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2051.8999000, -195.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2053.6001000, -191.5000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2052.6001000, -187.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(3578, -2032.4000200, -192.7000000, 34.3000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(3578, -2055.0000000, -190.8999900, 34.3000000, 0.0000000, 0.0000000, 90.0000000); //
	CreateDynamicObject(1238, -2023.4000200, -167.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2017.0999800, -157.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2018.0000000, -146.1000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2021.3000500, -143.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2024.5999800, -140.3000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2028.3000500, -137.6000100, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1238, -2035.8000500, -139.2000000, 34.6000000, 0.0000000, 0.0000000, 0.0000000); //
	CreateDynamicObject(1228, -2027.0999800, -158.8999900, 34.7000000, 0.0000000, 0.0000000, 320.0000000); //
	CreateDynamicObject(1228, -2016.5000000, -147.7000000, 34.7000000, 0.0000000, 0.0000000, 31.9990000); //
	CreateDynamicObject(1228, -2019.0999800, -172.0000000, 34.7000000, 0.0000000, 0.0000000, 34.7480000); //
	CreateDynamicObject(1318, -2073.8999000, -159.8999900, 34.3000000, 0.0000000, 90.0000000, 300.0000000); //
	CreateDynamicObject(1318, -2073.1001000, -127.6000000, 34.3000000, 0.0000000, 90.0000000, 180.0000000); //
	CreateDynamicObject(1318, -2061.8000500, -180.8000000, 34.3000000, 0.0000000, 90.0000000, 27.0000000); //
	CreateDynamicObject(1318, -2086.3000500, -262.6000100, 34.3000000, 0.0000000, 90.0000000, 126.0000000); //
	CreateDynamicObject(1318, -2078.5000000, -259.6000100, 34.3000000, 0.0000000, 90.0000000, 292.0000000); //
	CreateDynamicObject(1318, -2030.8000500, -265.6000100, 34.3000000, 0.0000000, 90.0000000, 180.0000000); //
	CreateDynamicObject(1318, -2026.5999800, -269.0000000, 34.3000000, 0.0000000, 90.0000000, 270.0000000); //
	CreateDynamicObject(1318, -2031.3000500, -251.8999900, 34.3000000, 0.0000000, 90.0000000, 340.0000000); //
	CreateDynamicObject(1318, -2030.6999500, -246.6000100, 34.3000000, 0.0000000, 90.0000000, 310.0000000); //
	CreateDynamicObject(1318, -2030.3000500, -249.6000100, 34.3000000, 0.0000000, 90.0000000, 190.0000000); //
	CreateDynamicObject(1318, -2041.5000000, -189.8999900, 34.3000000, 0.0000000, 90.0000000, 200.0000000); //

}

LoadSAPDTrainingMap() {


	// Start SAST Training (Ozone)

	new t_1817;
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2311.381104, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2321.014893, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.963379, -2296.908936, 14.306875, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2311.376465, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2321.010254, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1949.593506, -2345.131104, 14.306875, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	CreateDynamicObject(1569, 1931.598267, -2303.038086, 12.566861, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(1569, 1931.588257, -2300.045166, 12.566861, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2311.434082, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12848, "cunte_town1", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2321.063721, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12848, "cunte_town1", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.347046, -2311.434082, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.347656, -2321.063721, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.848633, -2311.434082, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12848, "cunte_town1", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.848999, -2321.063721, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12848, "cunte_town1", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2330.641357, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2330.648926, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2330.692871, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.347656, -2330.695557, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.848389, -2330.695557, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12848, "cunte_town1", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1930.341309, -2296.908936, 17.806879, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2311.381104, 17.806879, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2321.014893, 17.806885, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2330.648926, 17.806858, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1949.593506, -2345.139404, 17.806892, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.962769, -2345.129395, 14.306875, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1930.332153, -2345.129639, 14.306875, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.962769, -2345.129150, 17.806883, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1930.332153, -2345.130127, 17.806890, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2330.641357, 17.806892, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2321.010254, 17.806881, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2311.376465, 17.806898, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2301.741943, 17.806885, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1949.603516, -2304.964355, 21.306883, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.972168, -2304.961914, 21.306887, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1930.341309, -2304.964355, 21.306883, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1949.593506, -2345.139160, 21.306913, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.962769, -2345.128174, 21.306896, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1930.332153, -2345.131104, 21.306910, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2301.741943, 21.306887, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2311.376465, 21.306923, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2321.010254, 21.306894, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2330.641357, 21.306917, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2301.750000, 21.306898, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2311.381104, 21.306890, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2321.014893, 21.306911, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2330.648926, 21.306881, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.855835, -2301.804199, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2311.436768, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2321.071777, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2330.703613, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.346802, -2330.703613, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.338013, -2321.071777, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.347290, -2311.436768, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.355957, -2301.804199, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.856079, -2301.804199, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.848389, -2311.436768, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.839966, -2321.071777, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.849121, -2330.703613, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1936.752808, -2303.459229, 11.676860, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1936.752319, -2297.899170, 14.302797, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1936.752808, -2303.519287, 16.936861, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1936.752808, -2293.889648, 17.806871, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1940.772705, -2308.350586, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1950.403198, -2308.350586, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.253906, -2303.510254, 14.306854, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.253906, -2293.879395, 14.306854, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1949.364258, -2296.951416, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.734009, -2296.951416, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1930.104370, -2296.951416, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1948.920654, -2303.535889, 12.516863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1938.421143, -2303.535889, 12.516863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1948.920654, -2293.904541, 12.516863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1938.420044, -2293.904541, 12.516863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1927.921753, -2303.535889, 12.516863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1927.921753, -2293.908447, 12.516863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.554810, -2303.560303, 14.306854, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1934.351562, -2308.359619, 14.302797, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1927.932983, -2308.350586, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.554810, -2293.931885, 14.306854, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1948.920654, -2303.535889, 16.106871, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1948.920654, -2293.905029, 16.106871, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1938.420532, -2303.535889, 16.106871, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1938.420532, -2293.897949, 16.106871, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1927.918823, -2293.897949, 16.106871, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1927.918823, -2303.529541, 16.106871, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1953.471802, -2303.535889, 14.349140, 0.000000, 52.800003, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1953.471802, -2293.893311, 14.349140, 0.000000, 52.800003, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1950.403198, -2308.360596, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1940.771973, -2308.360596, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1934.361572, -2308.369629, 14.312797, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1927.942139, -2308.360596, 14.306854, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1950.393188, -2308.360596, 17.806858, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1940.763062, -2308.360596, 17.806858, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.130371, -2308.360596, 17.806858, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1949.130859, -2303.625977, 19.486916, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 13066, "sw_fact01a", "concretedust2_line", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1938.629883, -2303.625977, 19.486916, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 13066, "sw_fact01a", "concretedust2_line", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1928.130127, -2303.625977, 19.486916, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 13066, "sw_fact01a", "concretedust2_line", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2340.281006, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2340.271729, 14.306875, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2340.281006, 17.806877, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1954.433960, -2340.281006, 21.316889, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2340.271729, 17.806908, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8494, "vgslowbuild1", "vgnmetalwall1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1931.546143, -2340.271729, 21.296926, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2340.322510, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.347656, -2340.326660, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.848389, -2340.327148, 12.496863, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 12962, "sw_apartflat", "floor_tileone_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1936.845825, -2340.332764, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1947.345459, -2340.332764, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1957.847168, -2340.322754, 23.006849, 0.000000, 90.000000, 0.000000, 6003, 7, -1), 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19431, 1936.035522, -2299.408936, 14.302813, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19431, 1936.035522, -2301.130615, 14.302813, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19431, 1936.035522, -2302.872314, 14.302813, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19431, 1936.035522, -2304.634033, 14.302813, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19431, 1936.035522, -2306.495605, 14.302813, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1933.600464, -2316.354980, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1938.331787, -2311.623779, 14.302802, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1944.749146, -2311.625977, 14.302806, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1933.600464, -2322.777100, 14.302806, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1931.669922, -2329.181396, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1936.371948, -2345.049072, 14.302802, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1954.277466, -2340.186279, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1954.270996, -2314.498779, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1941.853516, -2314.906494, 14.302802, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1937.120850, -2319.637451, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1938.641235, -2324.389160, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1935.882324, -2327.650146, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1939.091675, -2327.650146, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1941.851440, -2324.389160, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1943.370483, -2329.122070, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1945.069458, -2324.398193, 14.302805, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1946.591064, -2322.879883, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1946.591064, -2319.668701, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1946.589600, -2316.457764, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1932.079712, -2324.299561, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1931.669922, -2338.814941, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1931.669922, -2348.444580, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1946.002441, -2345.049072, 14.302802, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1955.632202, -2345.049072, 14.302802, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1954.277466, -2330.554199, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1954.277466, -2320.921631, 14.302802, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19458, 1951.163208, -2311.623779, 14.302802, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1954.281006, -2313.167480, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1934.361206, -2329.171631, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1940.612793, -2329.171631, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1934.348877, -2332.382080, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1940.612793, -2332.380859, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1934.351318, -2335.583984, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1939.091675, -2337.110596, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1935.881714, -2337.110596, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1940.612793, -2335.590820, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1942.312622, -2337.110596, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1948.033203, -2337.110596, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1953.965088, -2337.110596, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1941.878418, -2338.766602, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1941.882935, -2341.972900, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1941.873779, -2345.183105, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1950.254028, -2313.275146, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1950.254028, -2316.486816, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19384, 1950.249634, -2319.698975, 14.302805, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1950.254028, -2322.908691, 14.302795, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1951.775269, -2324.430176, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19366, 1954.985474, -2324.430176, 14.302795, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	CreateDynamicObject(8673, 1952.977661, -2318.256836, 19.552835, -90.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(8673, 1952.977661, -2338.718506, 19.552835, -90.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(8673, 1933.055176, -2332.145264, 19.552835, -90.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(8673, 1941.526611, -2343.598389, 19.552835, -90.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(8673, 1933.055176, -2311.745117, 19.552835, -90.000000, 0.000000, -90.000000, 6003, 7, -1);
	t_1817 = CreateDynamicObject(2774, 1941.656250, -2322.054199, 24.232796, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	SetDynamicObjectMaterial(t_1817, 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(t_1817, 1, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	t_1817 = CreateDynamicObject(2774, 1941.656250, -2337.356934, 24.232796, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	SetDynamicObjectMaterial(t_1817, 0, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	SetDynamicObjectMaterial(t_1817, 1, 8555, "vgsdwntwn2", "marbletilewal1_256", 0);
	CreateDynamicObject(8673, 1941.727295, -2332.143311, 19.552835, -90.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(1999, 1940.022827, -2315.472900, 12.542785, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(922, 1951.708252, -2328.022949, 13.462798, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(944, 1947.999634, -2336.171631, 13.442797, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	SetDynamicObjectMaterial(CreateDynamicObject(1416, 1942.283203, -2320.387207, 13.132790, 0.000000, 0.000000, -118.800003, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	CreateDynamicObject(944, 1945.038574, -2328.318115, 13.442797, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(944, 1952.579712, -2332.161377, 13.442797, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	SetDynamicObjectMaterial(CreateDynamicObject(1741, 1940.597778, -2319.570312, 12.572786, 0.000000, 0.000000, 98.699989, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	CreateDynamicObject(2708, 1950.081909, -2339.668457, 12.552781, 0.000000, 0.000000, 12.300002, 6003, 7, -1);
	CreateDynamicObject(1271, 1942.745972, -2319.239258, 12.912785, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1939.274292, -2320.520508, 12.912785, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1942.996216, -2316.537354, 12.912785, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1942.996216, -2316.537354, 13.590999, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(937, 1947.424927, -2342.707031, 13.052792, 0.000000, 0.000000, 33.000011, 6003, 7, -1);
	CreateDynamicObject(1271, 1939.442749, -2319.345703, 14.062808, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1712, 1943.324951, -2341.546875, 12.572780, 0.000000, 0.000000, -15.699999, 6003, 7, -1);
	CreateDynamicObject(1271, 1943.570068, -2323.912842, 12.912789, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1943.570068, -2323.912842, 13.582795, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2708, 1947.587769, -2339.659424, 12.552781, 0.000000, 0.000000, -5.099995, 6003, 7, -1);
	CreateDynamicObject(2708, 1945.101929, -2340.567383, 12.552781, 0.000000, 0.000000, 27.200005, 6003, 7, -1);
	SetDynamicObjectMaterial(CreateDynamicObject(2323, 1950.821167, -2314.474609, 12.572787, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	CreateDynamicObject(2708, 1932.503784, -2341.520996, 12.552781, 0.000000, 0.000000, 27.200005, 6003, 7, -1);
	SetDynamicObjectMaterial(CreateDynamicObject(1416, 1953.391724, -2316.259521, 13.132790, 0.000000, 0.000000, 20.599997, 6003, 7, -1), 0, 10388, "scum2_sfs", "ws_sheetwood_clean", 0);
	CreateDynamicObject(1271, 1953.158813, -2316.377930, 14.052809, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1951.397705, -2313.327393, 13.912805, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2008, 1950.829956, -2322.169189, 12.572784, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1952.681152, -2321.488281, 12.922787, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1952.681152, -2321.488281, 13.602787, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2708, 1939.515381, -2340.119141, 12.552781, 0.000000, 0.000000, -80.899986, 6003, 7, -1);
	CreateDynamicObject(1712, 1937.365112, -2340.284912, 12.572780, 0.000000, 0.000000, -15.699999, 6003, 7, -1);
	CreateDynamicObject(1712, 1934.469727, -2341.995850, 12.572780, 0.000000, 0.000000, 27.699999, 6003, 7, -1);
	CreateDynamicObject(936, 1950.999146, -2342.214355, 13.052786, 0.000000, 0.000000, -25.300001, 6003, 7, -1);
	CreateDynamicObject(1271, 1946.933838, -2342.885498, 13.862807, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1951.432861, -2342.352539, 13.862807, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2991, 1937.463989, -2330.641846, 13.202792, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2991, 1937.463989, -2330.641846, 14.460000, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1999, 1935.005859, -2334.622559, 12.542783, 0.000000, 0.000000, -12.900003, 6003, 7, -1);
	CreateDynamicObject(1271, 1942.966064, -2323.127686, 12.922789, 0.000000, 0.000000, 42.499989, 6003, 7, -1);
	CreateDynamicObject(1271, 1936.947754, -2334.627197, 12.902787, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1936.947754, -2334.627197, 13.580797, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1942.966064, -2323.127686, 13.592797, 0.000000, 0.000000, 42.499989, 6003, 7, -1);
	CreateDynamicObject(1271, 1937.796875, -2334.689697, 12.902784, 0.000000, 0.000000, -22.600002, 6003, 7, -1);
	CreateDynamicObject(1271, 1937.796875, -2334.689697, 13.580797, 0.000000, 0.000000, -22.600002, 6003, 7, -1);
	CreateDynamicObject(1271, 1935.146362, -2334.627197, 13.682796, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1938.239014, -2335.558105, 12.902787, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1271, 1938.239014, -2335.558105, 13.580797, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1712, 1934.555298, -2325.865967, 12.572779, 0.000000, 0.000000, -0.700003, 6003, 7, -1);
	CreateDynamicObject(944, 1941.497070, -2329.619385, 13.442796, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1946.784180, -2302.466797, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1946.786987, -2302.463867, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1946.791992, -2302.458252, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1946.796387, -2302.468262, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1946.797485, -2302.473877, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1946.802856, -2302.459473, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1946.806152, -2302.461670, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1946.133667, -2305.529541, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1946.126343, -2305.522949, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1946.132080, -2305.520508, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1946.126099, -2305.529541, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1946.117188, -2305.534912, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1946.122437, -2305.528320, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1946.125732, -2305.531738, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(2502, 1952.119385, -2308.548340, 12.562784, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2502, 1950.758789, -2308.548340, 12.562784, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2502, 1949.398560, -2308.548340, 12.562784, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2502, 1948.038086, -2308.548340, 12.562784, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2509, 1946.174194, -2308.463623, 14.322804, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2509, 1944.863403, -2308.463623, 14.322804, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2509, 1943.553223, -2308.463623, 14.322804, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2509, 1942.243042, -2308.463623, 14.322804, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1948.485107, -2303.827881, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1948.466309, -2303.821289, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1948.462158, -2303.818848, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1948.466675, -2303.817871, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1948.467651, -2303.823242, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1948.462646, -2303.817139, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1948.467041, -2303.820801, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1946.133667, -2300.647217, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1946.126343, -2300.639893, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1946.132080, -2300.639893, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1946.126099, -2300.649170, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1946.117188, -2300.653564, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1946.122437, -2300.646729, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1946.125732, -2300.651367, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1943.892090, -2307.019775, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1943.884766, -2307.012939, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1943.891602, -2307.011475, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1943.887085, -2307.019531, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1943.895874, -2307.025635, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1943.891357, -2307.019043, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1943.894043, -2307.022461, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1950.245361, -2303.827881, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1950.246338, -2303.821289, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1950.242188, -2303.818848, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1950.247314, -2303.817871, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1950.248169, -2303.823242, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1950.243286, -2303.817139, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1950.246826, -2303.820801, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1948.024658, -2305.529541, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1948.017944, -2305.522949, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1948.022461, -2305.520508, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1948.027466, -2305.529541, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1948.028931, -2305.534912, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1948.023071, -2305.528320, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1948.027466, -2305.531738, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1949.244751, -2300.647217, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1949.246948, -2300.639893, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1949.253174, -2300.639893, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1949.248047, -2300.649170, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1949.249512, -2300.653564, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1949.254150, -2300.646729, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1949.246338, -2300.651367, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1947.352417, -2307.019775, 16.242796, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1947.345947, -2307.012939, 16.252789, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3020, 1947.351196, -2307.011475, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3021, 1947.358154, -2307.019531, 16.242813, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1947.358154, -2307.025635, 16.242805, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1947.352173, -2307.019043, 16.242798, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(3024, 1947.354614, -2307.022461, 16.242811, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1945.513062, -2294.875000, 14.306854, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19358, 1940.780884, -2299.605957, 14.302808, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19451, 1939.261230, -2294.875000, 14.306854, 0.000000, 0.000000, 0.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19358, 1943.991821, -2299.605957, 14.302808, 0.000000, 0.000000, 90.000000, 6003, 7, -1), 0, 12911, "sw_farm1", "sw_walltile", 0);
	CreateDynamicObject(348, 1941.791870, -2308.514648, 14.932809, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1941.791870, -2308.514648, 14.602807, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1941.791870, -2308.514648, 14.282804, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1941.791870, -2308.514648, 13.982810, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.342163, -2308.514648, 14.932809, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.342163, -2308.514648, 14.612807, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.342163, -2308.514648, 14.282804, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.342163, -2308.514648, 13.982805, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.912720, -2308.514648, 14.932809, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.912720, -2308.514648, 14.612803, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.912720, -2308.514648, 14.282802, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(348, 1942.912720, -2308.514648, 13.972806, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1941.823120, -2308.525635, 13.612795, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1942.363647, -2308.525635, 13.612795, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1942.943115, -2308.525635, 13.612795, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1943.513672, -2308.525635, 13.612795, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1943.513672, -2308.525635, 13.942798, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1943.513672, -2308.525635, 14.272796, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1943.513672, -2308.525635, 14.602795, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(346, 1943.513672, -2308.525635, 14.912796, 0.000000, 21.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(353, 1945.604248, -2308.523193, 14.922806, 0.000000, 0.000000, 7.199998, 6003, 7, -1);
	CreateDynamicObject(353, 1945.604248, -2308.523193, 14.502801, 0.000000, 0.000000, 7.199998, 6003, 7, -1);
	CreateDynamicObject(353, 1946.320312, -2308.524902, 14.922806, 0.000000, 0.000000, 7.199998, 6003, 7, -1);
	CreateDynamicObject(353, 1946.320312, -2308.524902, 14.502799, 0.000000, 0.000000, 7.199998, 6003, 7, -1);
	CreateDynamicObject(353, 1946.320312, -2308.524902, 14.092796, 0.000000, 0.000000, 7.199998, 6003, 7, -1);
	CreateDynamicObject(353, 1945.604248, -2308.523193, 14.092794, 0.000000, 0.000000, 7.199998, 6003, 7, -1);
	CreateDynamicObject(19142, 1947.802979, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1948.303467, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1948.803223, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1949.293213, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1949.773193, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1950.264038, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1950.743774, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1951.234131, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1951.744507, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1952.245117, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(19142, 1952.753662, -2308.707520, 13.832800, 0.000000, -90.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1947.856323, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1948.256714, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1949.207397, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1949.616455, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1950.566895, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1950.977173, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1951.907593, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2040, 1952.316528, -2308.792480, 12.752791, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2041, 1948.666992, -2308.790527, 12.842790, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2041, 1950.017334, -2308.790527, 12.842790, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2041, 1951.386719, -2308.790527, 12.842790, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(2041, 1952.727051, -2308.790527, 12.842790, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(8613, 1936.547119, -2312.574707, 16.172825, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19143, 1953.390869, -2343.846680, 22.922901, 0.000000, 0.000000, 47.799999, 6003, 7, -1);
	CreateDynamicObject(19143, 1932.348999, -2344.507568, 22.922901, 0.000000, 0.000000, -51.400013, 6003, 7, -1);
	CreateDynamicObject(19143, 1953.390869, -2325.800537, 22.922901, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(19143, 1953.390869, -2305.709229, 22.922901, 0.000000, 0.000000, 145.799973, 6003, 7, -1);
	CreateDynamicObject(19143, 1932.620483, -2305.709229, 22.922901, 0.000000, 0.000000, -142.899979, 6003, 7, -1);
	CreateDynamicObject(19143, 1932.348999, -2325.787354, 22.922901, 0.000000, 0.000000, -90.000000, 6003, 7, -1);
	CreateDynamicObject(1893, 1933.526489, -2306.086914, 16.252817, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(1893, 1933.526489, -2301.315918, 16.252817, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(1893, 1946.788208, -2306.086914, 16.252817, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(1893, 1946.787354, -2301.315918, 16.252817, 0.000000, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(997, 1934.784546, -2308.304443, 19.642847, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(2232, 1954.257935, -2344.903564, 21.877010, 8.900005, 0.000000, -134.900070, 6003, 7, -1);
	CreateDynamicObject(2232, 1954.213013, -2305.114014, 21.910345, 12.100006, 0.000000, -38.200012, 6003, 7, -1);
	CreateDynamicObject(2232, 1931.758667, -2305.191895, 21.910345, 8.199997, 0.000000, 44.999989, 6003, 7, -1);
	CreateDynamicObject(2232, 1931.787354, -2344.937988, 21.899620, 10.300003, 0.000000, 131.400024, 6003, 7, -1);
	CreateDynamicObject(996, 1943.309692, -2308.294434, 20.282846, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 14.902803, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 14.652804, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 14.402801, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 14.182800, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 13.962795, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 13.752803, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1944.350830, -2308.525146, 13.542809, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(349, 1945.662231, -2308.521484, 13.642810, 0.000000, 0.000000, 2.400001, 6003, 7, -1);
	CreateDynamicObject(19828, 1946.741943, -2305.053467, 20.982862, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1947.092285, -2305.053467, 20.982862, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1947.442505, -2305.053467, 20.982862, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1939.672119, -2305.053467, 20.982862, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1939.351929, -2305.053467, 20.982862, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1939.011841, -2305.053467, 20.982862, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1934.911011, -2297.041016, 13.972806, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19828, 1934.590454, -2297.041016, 13.972806, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19325, 1936.747437, -2302.798096, 16.572803, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19466, 1936.747437, -2307.238037, 15.477999, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(19622, 1945.718262, -2297.916748, 13.292701, -10.499999, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(19622, 1945.718262, -2298.767578, 13.292701, -10.499999, 0.000000, 90.000000, 6003, 7, -1);
	CreateDynamicObject(936, 1947.560669, -2297.692627, 13.072791, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(936, 1949.581299, -2297.692627, 13.072791, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1649, 1947.803345, -2299.695801, 13.602800, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1649, 1947.803345, -2299.695801, 13.602800, 0.000000, 0.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(1649, 1947.803345, -2299.695801, 16.932800, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1649, 1947.803345, -2299.695801, 16.932800, 0.000000, 0.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(1649, 1952.244507, -2299.695801, 16.932800, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(1649, 1952.244507, -2299.695801, 16.932800, 0.000000, 0.000000, 180.000000, 6003, 7, -1);
	CreateDynamicObject(16101, 1950.004272, -2299.703857, 12.472783, 0.000000, 0.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(16101, 1950.031616, -2299.703857, 15.312790, 0.000000, 90.000000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(3018, 1946.582520, -2294.475586, 13.541984, -90.000000, -17.000001, 0.000000, 6003, 7, -1);
	CreateDynamicObject(3019, 1948.021362, -2294.400146, 13.542787, -90.000000, 2.600003, 0.000000, 6003, 7, -1);
	CreateDynamicObject(3023, 1948.458374, -2295.712646, 13.522782, -90.000000, -20.100000, 0.000000, 6003, 7, -1);
	CreateDynamicObject(3022, 1950.762817, -2295.343018, 13.522791, -90.000000, 3.200001, 0.000000, 6003, 7, -1);

	// End SAST Training (Ozone)
}


LoadDonatorStars() { // Do not remove this under any circumstances, people paid for this...
	new g_DynamicObject[68];
	g_DynamicObject[0] = CreateDynamicObject(19483, 1020.3718, -1133.6745, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[0], 0, "Bishop", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[1] = CreateDynamicObject(19483, 974.8618, -1133.6745, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[1], 0, "Filiposq", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[2] = CreateDynamicObject(19483, 979.3926, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[2], 0, "shoreline", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[3] = CreateDynamicObject(19483, 983.9432, -1133.5344, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[3], 0, "rusu", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[4] = CreateDynamicObject(19483, 988.4937, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[4], 0, "Lion", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[5] = CreateDynamicObject(19483, 993.0543, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[5], 0, "Inkeri0", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[6] = CreateDynamicObject(19483, 997.6054, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[6], 0, "Ziv", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[7] = CreateDynamicObject(19483, 1002.1675, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[7], 0, "CoKane", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[8] = CreateDynamicObject(19483, 1006.6901, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[8], 0, "Sons", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[9] = CreateDynamicObject(19483, 1011.2512, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[9], 0, "gus", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[10] = CreateDynamicObject(19483, 1015.7910, -1133.6545, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[10], 0, "Lorence", 90, "Arial", 24, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[11] = CreateDynamicObject(19483, 997.8256, -1133.5844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[11], 0, "Ziv Stein", 130, "Arial", 24, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[12] = CreateDynamicObject(19483, 984.2057, -1133.5444, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[12], 0, "Martin Osborn", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[13] = CreateDynamicObject(19483, 1011.4364, -1133.5944, 22.8372, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[13], 0, "Lance Rizzi", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[14] = CreateDynamicObject(19483, 1025.4821, -1133.6745, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[14], 0, "Condone", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[15] = CreateDynamicObject(19483, 1029.9742, -1133.6745, 22.8572, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[15], 0, "Waka", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[16] = CreateDynamicObject(19483, 1034.4479, -1133.6745, 22.8572, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[16], 0, "Lion", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[17] = CreateDynamicObject(19483, 1038.9393, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[17], 0, "HeartBeat", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[18] = CreateDynamicObject(19483, 1043.4500, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[18], 0, "RaZzor", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[19] = CreateDynamicObject(19483, 1047.9607, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[19], 0, "lance", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[20] = CreateDynamicObject(19483, 1052.4714, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[20], 0, "Vanquish", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[21] = CreateDynamicObject(19483, 1052.6014, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[21], 0, "Ezequiel Vega", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[22] = CreateDynamicObject(19483, 1056.9714, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[22], 0, "ManeMag", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[23] = CreateDynamicObject(19483, 1057.0800, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[23], 0, "Ryker Brown", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[24] = CreateDynamicObject(19483, 1061.4021, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[24], 0, "Blejicaaa", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[25] = CreateDynamicObject(19483, 1061.5321, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[25], 0, "Shawn Blackburn", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[26] = CreateDynamicObject(19483, 1065.9021, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[26], 0, "smurda ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[27] = CreateDynamicObject(19483, 1066.0321, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[27], 0, "Andre Hicks", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[28] = CreateDynamicObject(19483, 1070.4021, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[28], 0, "Rodriguez ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[29] = CreateDynamicObject(19483, 1070.5321, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[29], 0, "Olivia Rodriguez", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[30] = CreateDynamicObject(19483, 1094.7280, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[30], 0, "MeeP ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[31] = CreateDynamicObject(19483, 1094.8580, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[31], 0, "Kimberly Coleman", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[32] = CreateDynamicObject(19483, 1099.0387, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[32], 0, "Snafu ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[33] = CreateDynamicObject(19483, 1099.1687, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[33], 0, "Pancho Cordozar", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[34] = CreateDynamicObject(19483, 1103.3494, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[34], 0, "rebdissolved1119 ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[35] = CreateDynamicObject(19483, 1103.4794, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[35], 0, "Sol Prisa", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[36] = CreateDynamicObject(19483, 1107.6511, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[36], 0, "Catster420 ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[37] = CreateDynamicObject(19483, 1107.7811, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[37], 0, "Nick Sanchez", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);

	g_DynamicObject[38] = CreateDynamicObject(19483, 1111.9228, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[38], 0, "Zigua6089 ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[39] = CreateDynamicObject(19483, 1112.0528, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[39], 0, "Ernest Bartaglieri", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[40] = CreateDynamicObject(19483, 1116.1945, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[40], 0, "twigyy ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[41] = CreateDynamicObject(19483, 1116.3245, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[41], 0, "Jamaar Finson", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	g_DynamicObject[42] = CreateDynamicObject(19483, 1120.4662, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[42], 0, "MrDreamer ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[43] = CreateDynamicObject(19483, 1120.5962, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[43], 0, "George Jefferson", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);

	g_DynamicObject[44] = CreateDynamicObject(19483, 1124.7679, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[44], 0, "Grafake ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[45] = CreateDynamicObject(19483, 1124.8979, -1133.6844, 22.8472, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[45], 0, "Edmunds Niedre", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);

	g_DynamicObject[46] = CreateDynamicObject(19483, 1129.0696, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[46], 0, "Saif Malice McMalice", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[47] = CreateDynamicObject(19483, 1133.3713, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[47], 0, "Leonidas", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[48] = CreateDynamicObject(19483, 1137.673, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[48], 0, "jayfinesse", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[49] = CreateDynamicObject(19483, 1141.9747, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[49], 0, "Graeme", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[50] = CreateDynamicObject(19483, 1146.2764, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[50], 0, "TyDolla", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[51] = CreateDynamicObject(19483, 1150.5781, -1133.6745, 22.8371, 180.0000, 90.0000, 180.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[51], 0, "Lamar_Prowell", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[52] = CreateDynamicObject(19483, 1175.3240, -1133.7745, 22.8871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[52], 0, "Chuckyloec ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[53] = CreateDynamicObject(19483, 1175.2000, -1133.7844, 22.8972, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[53], 0, "Raymond Taylor", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);

	g_DynamicObject[54] = CreateDynamicObject(19483, 1180.4257, -1133.7745, 22.8871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[54], 0, "Sizzurp ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[55] = CreateDynamicObject(19483, 1185.5274, -1133.7745, 22.8871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[55], 0, "Lucius ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[56] = CreateDynamicObject(19483, 1185.4034, -1133.7844, 22.8972, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[56], 0, "Mikhail Antonov", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);

	g_DynamicObject[57] = CreateDynamicObject(19483, 1190.8691, -1133.7745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[57], 0, "Spade ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[58] = CreateDynamicObject(19483, 1196.0000, -1133.6745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[58], 0, "Foxx ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[59] = CreateDynamicObject(19483, 1201.4325, -1133.6745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[59], 0, "SohaibM ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[60] = CreateDynamicObject(19483, 1201.3100, -1133.6844, 22.9972, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[60], 0, "Christopher Atonal", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);

	g_DynamicObject[61] = CreateDynamicObject(19483, 1206.8634, -1133.6745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[61], 0, "flffy ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[62] = CreateDynamicObject(19483, 1212.2943, -1133.6745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[62], 0, "vibes ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[63] = CreateDynamicObject(19483, 1217.6252, -1133.6745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[63], 0, "Nubzzy ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[64] = CreateDynamicObject(19483, 1223.0561, -1133.4745, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[64], 0, "Krypto ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[65] = CreateDynamicObject(19483, 1228.4570, -1133.4445, 22.9871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[65], 0, "Fifty ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);

	g_DynamicObject[66] = CreateDynamicObject(19483, 1233.8879, -1133.4445, 22.8871, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[66], 0, "LionVenom ", 90, "Arial", 20, 1, 0xFF745217, 0x0, 1);
	g_DynamicObject[67] = CreateDynamicObject(19483, 1233.6879, -1133.4445, 22.8972, 180.0000, 90.0000, 0.0000, -1, -1, -1, 250.0, 250.0); // Plane009
	SetDynamicObjectMaterialText(g_DynamicObject[67], 0, "Ignacio Abraham", 130, "Arial", 20, 1, 0xFF840410, 0x0, 1);
	
}

LoadSweetFix() {
	CreateDynamicObject(18765, 2529.66479, -1681.88513, 1011.99500,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18765, 2536.44189, -1679.37512, 1011.99500,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2536.27417, -1684.34998, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2541.44995, -1679.58105, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2530.75220, -1688.46997, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2535.64990, -1684.34998, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2525.37012, -1683.51001, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2533.64990, -1688.28003, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2526.25000, -1688.28003, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(19447, 2537.43066, -1678.06006, 1016.23199,   0.00000, 0.00000, 90.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(18764, 2521.25000, -1679.49402, 1015.98779,   0.00000, 0.00000, 0.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(19368, 2527.50000, -1681.14001, 1015.93329,   0.00000, 0.00000, 90.00000, -1, -1, -1, 250.0, 250.0);
	CreateDynamicObject(19368, 2532.47998, -1681.14001, 1015.93329,   0.00000, 0.00000, 90.00000, -1, -1, -1, 250.0, 250.0);
}

LoadRatInterior() {
	CreateDynamicObject(3064, 2321.59180, -1179.13135, 1033.19995,   0.00000, 0.00000, 180.00000, 1, 5, -1, 250.0, 250.0);
	CreateDynamicObject(14819, 2321.85010, -1178.25098, 1032.13000,   0.00000, 0.00000, 90.00000, 1, 5, -1, 250.0, 250.0);
	CreateDynamicObject(19369, 2322.19995, -1179.04675, 1032.72986,   0.00000, 0.00000, 0.00000, 1, 5, -1, 250.0, 250.0);
	CreateDynamicObject(3063, 2340.27808, -1182.29297, 1026.95996,   0.00000, 0.00000, 90.00000, 1, 5, -1, 250.0, 250.0);
	CreateDynamicObject(2950, 2330.38989, -1179.15503, 1030.54700,   0.00000, 0.00000, 0.00000, 1, 5, -1, 250.0, 250.0);

}

LoadChurchInterior() { 
	new tmpobjid;
	tmpobjid = CreateObject(19375,-2023.961,1010.056,1417.401,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_wpaper5", 0);
	tmpobjid = CreateObject(19379,-2029.131,1010.057,1417.411,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_poshwdflr1", 0);
	tmpobjid = CreateObject(19379,-2015.046,1010.057,1417.411,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_poshwdflr1", 0);
	tmpobjid = CreateObject(19378,-2022.178,1005.338,1413.199,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3961, "lee_kitch", "rack", 0);
	tmpobjid = CreateObject(19375,-2023.962,1019.687,1417.401,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_wpaper5", 0);
	tmpobjid = CreateObject(19379,-2015.046,1019.687,1417.411,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_poshwdflr1", 0);
	tmpobjid = CreateObject(19379,-2029.131,1019.687,1417.411,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_poshwdflr1", 0);
	tmpobjid = CreateObject(19449,-2030.010,1010.088,1419.246,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2030.012,1019.687,1419.246,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2014.162,1010.070,1419.246,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2014.162,1019.653,1419.246,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19379,-2032.241,999.152,1418.411,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 16136, "des_telescopestuff", "stoneclad1", 0);
	tmpobjid = CreateObject(19378,-2026.916,1000.602,1413.199,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3961, "lee_kitch", "rack", 0);
	tmpobjid = CreateObject(19449,-2030.010,1000.486,1419.246,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19378,-2017.447,1000.552,1413.199,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3961, "lee_kitch", "rack", 0);
	tmpobjid = CreateObject(19379,-2012.120,999.152,1418.411,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 16136, "des_telescopestuff", "stoneclad1", 0);
	tmpobjid = CreateObject(19449,-2014.162,1000.448,1419.246,0.000,0.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19379,-2022.178,1000.152,1418.411,0.000,90.000,89.999,300.000);
	SetObjectMaterial(tmpobjid, 0, 16136, "des_telescopestuff", "stoneclad1", 0);
	tmpobjid = CreateObject(19449,-2012.570,999.406,1419.246,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2031.796,999.406,1419.246,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2012.571,999.406,1422.746,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2031.796,999.406,1422.746,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19325,-2020.643,999.376,1420.560,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19325,-2027.287,999.377,1420.560,0.000,0.000,269.994,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19325,-2020.644,999.377,1424.686,0.000,0.000,269.994,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19325,-2027.287,999.376,1424.686,0.000,0.000,269.989,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19377,-2027.250,1004.106,1423.646,0.000,45.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 8591, "olympic01", "vgscityhwal1", 0);
	tmpobjid = CreateObject(19377,-2027.250,1013.520,1423.646,0.000,44.994,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 8591, "olympic01", "vgscityhwal1", 0);
	tmpobjid = CreateObject(19377,-2027.250,1022.883,1423.646,0.000,44.994,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 8591, "olympic01", "vgscityhwal1", 0);
	tmpobjid = CreateObject(19377,-2017.108,1004.106,1423.748,0.000,315.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 8591, "olympic01", "vgscityhwal1", 0);
	tmpobjid = CreateObject(19377,-2017.108,1013.635,1423.748,0.000,315.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 8591, "olympic01", "vgscityhwal1", 0);
	tmpobjid = CreateObject(19377,-2017.108,1023.148,1423.748,0.000,315.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 8591, "olympic01", "vgscityhwal1", 0);
	tmpobjid = CreateObject(19378,-2022.043,1016.110,1425.817,0.000,90.000,89.994,300.000);
	SetObjectMaterial(tmpobjid, 0, 14526, "sweetsmain", "ah_whitpanelceil", 0);
	tmpobjid = CreateObject(19378,-2022.043,1005.688,1425.817,0.000,90.000,89.994,300.000);
	SetObjectMaterial(tmpobjid, 0, 14526, "sweetsmain", "ah_whitpanelceil", 0);
	tmpobjid = CreateObject(19378,-2022.043,995.190,1425.817,0.000,90.000,89.999,300.000);
	SetObjectMaterial(tmpobjid, 0, 14526, "sweetsmain", "ah_whitpanelceil", 0);
	tmpobjid = CreateObject(19356,-2022.134,997.676,1418.746,270.000,179.994,179.994,300.000);
	SetObjectMaterial(tmpobjid, 0, 1929, "kbroul2", "oliveash_256", 0);
	tmpobjid = CreateObject(19356,-2022.134,997.676,1421.907,270.000,180.005,179.983,300.000);
	SetObjectMaterial(tmpobjid, 0, 1929, "kbroul2", "oliveash_256", 0);
	tmpobjid = CreateObject(19356,-2022.200,997.826,1421.792,0.000,90.000,0.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 1929, "kbroul2", "oliveash_256", 0);
	tmpobjid = CreateObject(19377,-2022.162,999.139,1423.748,0.000,180.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14785, "gen_offtrackint", "otb_rooftile1", 0);
	tmpobjid = CreateObject(19449,-2012.570,1021.158,1419.246,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2012.570,1021.158,1422.746,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2031.796,1021.158,1419.246,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19449,-2031.796,1021.158,1422.746,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 4558, "lanlacmab_lan2", "sl_plazatile02", 0);
	tmpobjid = CreateObject(19325,-2023.711,1021.138,1419.550,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19325,-2017.067,1021.138,1419.550,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19325,-2023.711,1021.138,1423.676,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19325,-2017.067,1021.138,1423.676,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 3906, "libertyhi5", "grating 64HV", 0);
	tmpobjid = CreateObject(19377,-2022.166,1021.270,1422.738,0.000,179.994,90.000,300.000);
	SetObjectMaterial(tmpobjid, 0, 14785, "gen_offtrackint", "otb_rooftile1", 0);
	tmpobjid = CreateObject(1537,-2029.889,1020.952,1417.496,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 1, 14847, "mp_policesf", "mp_cop_lectern", 0);
	SetObjectMaterial(tmpobjid, 2, 18058, "mp_diner2", "mp_diner_table", 0);
	tmpobjid = CreateObject(1537,-2029.880,1019.468,1417.496,0.000,0.000,90.000,300.000);
	SetObjectMaterial(tmpobjid, 1, 14847, "mp_policesf", "mp_cop_lectern", 0);
	SetObjectMaterial(tmpobjid, 2, 18058, "mp_diner2", "mp_diner_table", 0);
	tmpobjid = CreateObject(1537,-2014.270,1019.500,1417.496,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 1, 14847, "mp_policesf", "mp_cop_lectern", 0);
	SetObjectMaterial(tmpobjid, 2, 18058, "mp_diner2", "mp_diner_table", 0);
	tmpobjid = CreateObject(1537,-2014.270,1017.992,1417.496,0.000,0.000,270.000,300.000);
	SetObjectMaterial(tmpobjid, 1, 14847, "mp_policesf", "mp_cop_lectern", 0);
	SetObjectMaterial(tmpobjid, 2, 18058, "mp_diner2", "mp_diner_table", 0);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateObject(19461,-2020.350,1010.238,1415.757,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2020.349,1019.857,1415.757,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2023.921,1010.236,1415.757,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2023.921,1019.862,1415.757,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(19375,-2023.961,1029.313,1417.401,0.000,90.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1021.000,1419.246,270.000,0.000,90.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1018.000,1419.246,270.000,180.000,270.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1015.000,1419.246,269.994,0.000,90.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1012.000,1419.246,269.994,0.000,90.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1009.000,1419.246,269.994,0.000,90.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1006.000,1419.246,270.000,180.000,270.000,300.000);
	tmpobjid = CreateObject(2639,-2018.641,1008.434,1418.125,0.000,0.000,180.000,300.000);
	tmpobjid = CreateObject(2639,-2016.059,1008.446,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2016.059,1010.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2018.641,1010.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2016.059,1012.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2028.253,1010.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2018.641,1012.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2018.641,1016.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2016.059,1014.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2025.591,1010.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2016.059,1016.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2018.641,1014.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2025.591,1008.434,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2028.253,1008.434,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(14409,-2029.006,1005.812,1415.300,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(14409,-2015.459,1005.812,1415.300,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1003.000,1419.246,270.000,180.000,269.994,300.000);
	tmpobjid = CreateObject(19461,-2012.505,999.557,1420.246,270.000,180.000,269.994,300.000);
	tmpobjid = CreateObject(19461,-2031.665,999.562,1420.246,90.000,189.875,260.125,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1003.000,1420.246,90.000,187.973,262.021,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1006.000,1419.246,90.000,173.366,276.622,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1009.000,1419.246,90.000,174.171,275.812,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1012.000,1419.246,90.000,174.651,275.327,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1015.000,1419.246,90.000,184.915,265.057,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1018.000,1419.246,90.000,184.272,265.693,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1021.000,1419.246,90.000,175.297,274.663,300.000);
	tmpobjid = CreateObject(19461,-2024.975,1016.330,1427.466,0.000,180.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2024.975,1006.664,1427.466,0.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2024.975,997.057,1427.466,0.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2019.265,1016.239,1427.466,0.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2019.265,1006.659,1427.466,0.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2019.265,997.046,1427.466,0.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2017.302,997.752,1420.246,270.000,180.000,180.000,300.000);
	tmpobjid = CreateObject(19461,-2027.064,997.752,1420.246,270.000,179.999,179.999,300.000);
	tmpobjid = CreateObject(2639,-2025.591,1012.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2025.591,1014.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2025.591,1016.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2028.253,1012.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2028.253,1014.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(2639,-2028.253,1016.400,1418.125,0.000,0.000,179.994,300.000);
	tmpobjid = CreateObject(19461,-2027.066,1022.812,1419.246,270.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2017.303,1022.815,1419.246,270.000,179.994,0.000,300.000);
	tmpobjid = CreateObject(19461,-2012.505,1022.809,1420.000,0.000,270.000,0.000,300.000);
	tmpobjid = CreateObject(19461,-2031.665,1022.809,1420.000,0.000,90.000,0.000,300.000);
	tmpobjid = CreateObject(2205,-2022.656,1004.554,1418.496,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(2309,-2021.995,1003.379,1418.496,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(2894,-2021.970,1004.530,1419.433,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(630,-2029.339,1017.335,1418.521,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(630,-2027.333,1020.669,1418.521,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(630,-2016.932,1020.552,1418.521,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(630,-2014.512,1017.344,1418.521,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(630,-2014.839,999.883,1419.521,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(630,-2029.334,999.851,1419.521,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(18075,-2019.551,1006.838,1425.645,0.000,0.000,0.000,300.000);
	tmpobjid = CreateObject(18075,-2019.551,1018.989,1425.645,0.000,0.000,0.000,300.000);
}

LoadTollMaps() {
	new g_Object[13];
	g_Object[0] = CreateObject(16003, 609.5999, 356.8854, 19.3498, 0.0000, 0.0000, -55.0998, 200.0000); //drvin_ticket
	g_Object[1] = CreateObject(16003, 598.7849, 349.3405, 19.3498, 0.0000, 0.0000, -55.0998, 200.0000); //drvin_ticket
	g_Object[2] = CreateObject(16003, -202.1325, 263.4269, 12.4630, 0.0000, 0.0000, 74.9000, 200.0000); //drvin_ticket
	g_Object[3] = CreateObject(3578, 603.9953, 353.3843, 17.9528, 0.0000, 0.0000, -54.9000, 200.0000); //DockBarr1_LA
	SetObjectMaterial(g_Object[3], 0, 9623, "toll_sfw", "toll_SFw3", 0xFFFFFFFF);
	g_Object[4] = CreateObject(16003, -189.4463, 260.0039, 12.4630, 0.0000, 0.0000, 74.9000, 200.0000); //drvin_ticket
	g_Object[5] = CreateObject(8168, 48.7205, -1531.0426, 6.0587, 0.0000, 0.0000, 7.8997, 200.0000); //Vgs_guardhouse01
	g_Object[6] = CreateObject(19966, 35.5605, -1529.4277, 4.3737, 0.0000, 0.0000, -99.0000, 100.0000); //SAMPRoadSign19
	g_Object[7] = CreateObject(3578, -195.8231, 261.7597, 11.1463, 0.0000, 0.0000, 75.5998, 200.0000); //DockBarr1_LA
	SetObjectMaterial(g_Object[7], 0, 9623, "toll_sfw", "toll_SFw3", 0xFFFFFFFF);
	g_Object[8] = CreateObject(19966, 65.7406, -1533.5294, 4.3137, 0.0000, 0.0000, 83.8000, 100.0000); //SAMPRoadSign19
	g_Object[9] = CreateObject(3578, 58.9141, -1532.4768, 4.1132, 0.0000, 0.7997, -9.0000, 200.0000); //DockBarr1_LA
	SetObjectMaterial(g_Object[9], 0, 9623, "toll_sfw", "toll_SFw3", 0xFFFFFFFF);
	g_Object[10] = CreateObject(19428, 52.6142, -1528.4117, 3.7307, 0.0000, 0.0000, -7.9998, 100.0000); //wall068
	SetObjectMaterial(g_Object[10], 0, 982, "bar_chainlink", "awirex2", 0xFFFFFFFF);
	g_Object[11] = CreateObject(19428, 51.6305, -1534.7119, 3.7307, 0.0000, 0.0000, -7.7999, 100.0000); //wall068
	SetObjectMaterial(g_Object[11], 0, 982, "bar_chainlink", "awirex2", 0xFFFFFFFF);
	g_Object[12] = CreateObject(9623, 1708.4427, 435.3139, 32.7448, 0.7997, 0.0000, -19.2000, 500.0000); //toll_SFW
}



LoadStaffMeetingInterior() {
	new g_Object[90];
	g_Object[0] = CreateDynamicObject(19377, -1593.7746, -320.4092, 89.7099, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[0], 0, 14847, "mp_policesf", "mp_cop_tile", 0xFFFFFFFF);
	g_Object[1] = CreateDynamicObject(19353, -1581.4182, -320.4645, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[1], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[2] = CreateDynamicObject(2205, -1586.4145, -317.3290, 89.8069, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //MED_OFFICE8_DESK_1
	SetDynamicObjectMaterial(g_Object[2], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[3] = CreateDynamicObject(3013, -1584.3536, -320.6585, 90.6959, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //cr_ammobox
	SetDynamicObjectMaterial(g_Object[3], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[4] = CreateDynamicObject(2209, -1584.0904, -321.2749, 89.7750, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //MED_OFFICE9_DESK_1
	SetDynamicObjectMaterial(g_Object[4], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[4], 1, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[5] = CreateDynamicObject(2205, -1586.4145, -322.4790, 89.8069, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //MED_OFFICE8_DESK_1
	SetDynamicObjectMaterial(g_Object[5], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[6] = CreateDynamicObject(19353, -1588.4283, -318.3641, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[6], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[7] = CreateDynamicObject(19353, -1588.4283, -323.0643, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[7], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[8] = CreateDynamicObject(19353, -1588.4283, -326.2745, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[8], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[9] = CreateDynamicObject(1491, -1588.4217, -321.4718, 88.2733, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //Gen_doorINT01
	SetDynamicObjectMaterial(g_Object[9], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[10] = CreateDynamicObject(19353, -1588.4283, -315.1643, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[10], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[11] = CreateDynamicObject(19353, -1581.4182, -323.6643, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[11], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[12] = CreateDynamicObject(19353, -1581.4182, -317.2546, 89.0649, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[12], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[13] = CreateDynamicObject(19377, -1583.2751, -320.4092, 89.7099, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[13], 0, 14847, "mp_policesf", "mp_cop_tile", 0xFFFFFFFF);
	g_Object[14] = CreateDynamicObject(19377, -1576.2458, -320.4092, 90.7302, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[14], 0, 14847, "mp_policesf", "mp_cop_tile", 0xFFFFFFFF);
	g_Object[15] = CreateDynamicObject(1416, -1581.2053, -320.0393, 91.3887, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //DYN_UNIT
	SetDynamicObjectMaterial(g_Object[15], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[16] = CreateDynamicObject(1416, -1581.2054, -321.4595, 91.3887, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //DYN_UNIT
	SetDynamicObjectMaterial(g_Object[16], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[17] = CreateDynamicObject(1416, -1584.3056, -320.2290, 90.0087, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //DYN_UNIT
	SetDynamicObjectMaterial(g_Object[17], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[18] = CreateDynamicObject(19353, -1581.4082, -317.7445, 89.8546, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[18], 0, 18368, "cs_mountaintop", "des_woodrails", 0xFF1E1306);
	g_Object[19] = CreateDynamicObject(19353, -1581.4082, -323.7745, 89.8546, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[19], 0, 18368, "cs_mountaintop", "des_woodrails", 0xFF1E1306);
	g_Object[20] = CreateDynamicObject(2808, -1591.2299, -318.7727, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[20], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[20], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[21] = CreateDynamicObject(2808, -1589.6385, -316.6828, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[21], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[21], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[22] = CreateDynamicObject(2808, -1592.9409, -318.7727, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[22], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[22], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[23] = CreateDynamicObject(2808, -1592.8895, -322.7131, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[23], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[23], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[24] = CreateDynamicObject(2808, -1591.2390, -322.7232, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[24], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[24], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[25] = CreateDynamicObject(2808, -1589.6385, -324.8034, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[25], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[25], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[26] = CreateDynamicObject(19353, -1586.7379, -315.6943, 89.0649, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[26], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[27] = CreateDynamicObject(19377, -1583.6767, -313.9895, 89.0802, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[27], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[28] = CreateDynamicObject(19353, -1582.0603, -315.6943, 89.0649, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[28], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[29] = CreateDynamicObject(19377, -1588.4372, -311.4898, 89.0802, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[29], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[30] = CreateDynamicObject(19353, -1578.5876, -317.2146, 92.5848, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[30], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[31] = CreateDynamicObject(14892, -1568.1612, -325.7124, 91.3246, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //mp_sfpd_win2
	SetDynamicObjectMaterial(g_Object[31], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
	g_Object[32] = CreateDynamicObject(14892, -1568.1612, -325.7622, 91.3246, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //mp_sfpd_win2
	SetDynamicObjectMaterial(g_Object[32], 0, 14853, "gen_pol_vegas", "mp_cop_wood", 0xFFFFFFFF);
	g_Object[33] = CreateDynamicObject(19353, -1578.5876, -320.4244, 92.5848, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[33], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[34] = CreateDynamicObject(19377, -1583.3149, -325.2691, 89.0802, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[34], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[35] = CreateDynamicObject(19377, -1592.9447, -325.2691, 89.0802, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[35], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[36] = CreateDynamicObject(19353, -1578.5876, -323.6343, 92.5848, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[36], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[37] = CreateDynamicObject(19377, -1581.5665, -310.7897, 89.0802, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[37], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[38] = CreateDynamicObject(19377, -1576.8364, -315.5194, 89.0802, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[38], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[39] = CreateDynamicObject(14892, -1611.5511, -313.5625, 91.3346, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //mp_sfpd_win2
	SetDynamicObjectMaterial(g_Object[39], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
	g_Object[40] = CreateDynamicObject(19377, -1583.2751, -310.7791, 89.7099, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[40], 0, 14847, "mp_policesf", "mp_cop_tile", 0xFFFFFFFF);
	g_Object[41] = CreateDynamicObject(14892, -1611.5495, -313.4826, 91.3245, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //mp_sfpd_win2
	SetDynamicObjectMaterial(g_Object[41], 0, 14853, "gen_pol_vegas", "mp_cop_wood", 0xFFFFFFFF);
	g_Object[42] = CreateDynamicObject(1491, -1585.1721, -315.6918, 88.2733, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //Gen_doorINT01
	SetDynamicObjectMaterial(g_Object[42], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[43] = CreateDynamicObject(2808, -1587.2486, -314.5133, 90.4047, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[43], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[43], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[44] = CreateDynamicObject(14892, -1616.5306, -315.7926, 91.3346, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //mp_sfpd_win2
	SetDynamicObjectMaterial(g_Object[44], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
	g_Object[45] = CreateDynamicObject(14892, -1616.5295, -315.7326, 91.3245, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //mp_sfpd_win2
	SetDynamicObjectMaterial(g_Object[45], 0, 14853, "gen_pol_vegas", "mp_cop_wood", 0xFFFFFFFF);
	g_Object[46] = CreateDynamicObject(19377, -1593.1750, -316.2294, 89.0802, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[46], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[47] = CreateDynamicObject(2808, -1585.1777, -314.5133, 90.4047, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[47], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[47], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[48] = CreateDynamicObject(2808, -1583.1074, -314.5136, 90.4047, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[48], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[48], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[49] = CreateDynamicObject(19353, -1586.7392, -325.2648, 89.0649, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[49], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[50] = CreateDynamicObject(19353, -1583.5288, -325.2648, 89.0649, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[50], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[51] = CreateDynamicObject(19353, -1580.3293, -325.2648, 89.0649, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[51], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[52] = CreateDynamicObject(19377, -1597.7955, -320.3992, 89.0802, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[52], 0, 14853, "gen_pol_vegas", "mp_cop_wall", 0xFFFFFFFF);
	g_Object[53] = CreateDynamicObject(2808, -1589.6385, -318.7727, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[53], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[53], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[54] = CreateDynamicObject(2808, -1592.9409, -316.6628, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[54], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[54], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[55] = CreateDynamicObject(2808, -1591.2297, -316.6628, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[55], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[55], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[56] = CreateDynamicObject(2808, -1589.6385, -322.7235, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[56], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[56], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[57] = CreateDynamicObject(2808, -1591.2490, -324.8131, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[57], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[57], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[58] = CreateDynamicObject(2808, -1592.8890, -324.8031, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[58], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[58], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[59] = CreateDynamicObject(2808, -1581.0472, -314.5136, 90.4047, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[59], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[59], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[60] = CreateDynamicObject(19353, -1581.4082, -314.5447, 89.8546, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall001
	SetDynamicObjectMaterial(g_Object[60], 0, 18368, "cs_mountaintop", "des_woodrails", 0xFF1E1306);
	g_Object[61] = CreateDynamicObject(11714, -1597.7159, -320.6730, 91.0322, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //MaintenanceDoors1
	SetDynamicObjectMaterial(g_Object[61], 0, 17036, "cuntwbt", "carparkdoor1_256", 0xFFFFFFFF);
	g_Object[62] = CreateDynamicObject(2048, -1581.5233, -320.7479, 91.4961, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_FLAG2
	SetDynamicObjectMaterial(g_Object[62], 0, 4003, "cityhall_tr_lan", "mc_flags1", 0xFFFFFFFF);
	g_Object[63] = CreateDynamicObject(19610, -1584.1505, -320.6291, 90.8857, 55.9000, 0.0000, -86.9000, 1, 0, -1, 250.0, 300.0); //Microphone1
	g_Object[64] = CreateDynamicObject(1416, -1584.2956, -321.0193, 90.0087, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //DYN_UNIT
	SetDynamicObjectMaterial(g_Object[64], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[65] = CreateDynamicObject(19377, -1583.2751, -320.4092, 94.4000, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[65], 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0xFFFFFFFF);
	g_Object[66] = CreateDynamicObject(1501, -1578.7199, -316.9007, 90.7935, 0.0000, 0.0000, 270.0000, 1, 0, -1, 250.0, 300.0); //Gen_doorEXT04
	SetDynamicObjectMaterial(g_Object[66], 1, 14847, "mp_policesf", "mp_cop_lectern", 0xFFFFFFFF);
	g_Object[67] = CreateDynamicObject(19377, -1593.7712, -320.4092, 94.4000, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[67], 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0xFFFFFFFF);
	g_Object[68] = CreateDynamicObject(19377, -1583.2751, -310.7794, 94.4000, 0.0000, 90.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //wall025
	SetDynamicObjectMaterial(g_Object[68], 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0xFFFFFFFF);
	g_Object[69] = CreateDynamicObject(2808, -1588.0570, -318.0527, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[69], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[69], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[70] = CreateDynamicObject(2808, -1588.0570, -323.3226, 90.4047, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //CJ_PIZZA_CHAIR4
	SetDynamicObjectMaterial(g_Object[70], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[70], 1, 3881, "apsecurity_sfxrf", "leather_seat_256", 0xFFFFFFFF);
	g_Object[71] = CreateDynamicObject(19482, -1578.7331, -324.5263, 91.7844, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //Plane008
	SetDynamicObjectMaterialText(g_Object[71],  0, "- if you want to speak do /salute and wait", 130, "Arial", 16, 1, 0xFFFFFFFF, 0x0, 0);
	g_Object[72] = CreateDynamicObject(1616, -1578.9970, -316.0093, 94.1510, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //nt_securecam1_01
	g_Object[73] = CreateDynamicObject(3077, -1578.6751, -323.3502, 90.7798, 0.0000, 0.0000, 90.0000, 1, 0, -1, 250.0, 300.0); //nf_blackboard
	SetDynamicObjectMaterial(g_Object[73], 0, 14443, "ganghoos", "mp_burn_carpet", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[73], 1, 14853, "gen_pol_vegas", "mp_cop_wood", 0xFFFFFFFF);
	g_Object[74] = CreateDynamicObject(19482, -1578.7331, -324.5263, 91.9344, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //Plane008
	SetDynamicObjectMaterialText(g_Object[74],  0, "- don't interrupt eachother (no matter what)", 130, "Arial", 16, 1, 0xFFFFFFFF, 0x0, 0);
	g_Object[75] = CreateDynamicObject(19482, -1578.7331, -324.5263, 92.4444, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //Plane008
	SetDynamicObjectMaterialText(g_Object[75],  0,"council rules", 90, "Arial", 24, 1, 0xFF2A77A1, 0x0, 0);
	g_Object[76] = CreateDynamicObject(19482, -1578.7331, -324.5263, 91.6343, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //Plane008
	SetDynamicObjectMaterialText(g_Object[76],  0,"- keep an open mind > don't get heated", 130, "Arial", 16, 1, 0xFFFFFFFF, 0x0, 0);
	g_Object[77] = CreateDynamicObject(19482, -1578.7331, -324.5263, 91.4843, 0.0000, 0.0000, 180.0000, 1, 0, -1, 250.0, 300.0); //Plane008
	SetDynamicObjectMaterialText(g_Object[77],  0,"- no finger pointing > no beefing > no autism", 130, "Arial", 16, 1, 0xFFFFFFFF, 0x0, 0);
	g_Object[78] = CreateDynamicObject(19476, -1593.7442, -319.0982, 91.1020, 0.0000, 0.0000, -157.2002, 1, 0, -1, 250.0, 300.0); //Plane002
	SetDynamicObjectMaterialText(g_Object[78], 0, "at the door!!", 40, "Arial", 24, 1, 0xFF221918, 0x0, 0);
	g_Object[79] = CreateDynamicObject(3264, -1593.6961, -319.0820, 89.3775, 0.0000, 0.0000, -67.1999, 1, 0, -1, 250.0, 300.0); //privatesign3
	SetDynamicObjectMaterial(g_Object[79], 0, 14420, "dr_gsbits", "mp_gs_carpet", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_Object[79], 1, 2423, "cj_ff_counters", "CJ_Laminate1", 0xFFFFFFFF);
	g_Object[80] = CreateDynamicObject(19476, -1593.7442, -319.0982, 91.6620, 0.0000, 0.0000, -157.2002, 1, 0, -1, 250.0, 300.0); //Plane002
	SetDynamicObjectMaterialText(g_Object[80],  0,"leave ur guns", 40, "Arial", 24, 1, 0xFF221918, 0x0, 0);
	g_Object[81] = CreateDynamicObject(19476, -1593.7442, -319.0982, 91.4820, 0.0000, 0.0000, -157.2002, 1, 0, -1, 250.0, 300.0); //Plane002
	SetDynamicObjectMaterialText(g_Object[81],  0,"ooc beef and", 40, "Arial", 24, 1, 0xFF221918, 0x0, 0);
	g_Object[82] = CreateDynamicObject(19476, -1593.7442, -319.0982, 91.2920, 0.0000, 0.0000, -157.2002, 1, 0, -1, 250.0, 300.0); //Plane002
	SetDynamicObjectMaterialText(g_Object[82],  0,"ooc conflict", 40, "Arial", 24, 1, 0xFF221918, 0x0, 0);
	g_Object[83] = CreateDynamicObject(1416, -1593.7572, -317.6190, 90.0087, 0.0000, 0.0000, -90.0000, 1, 0, -1, 250.0, 300.0); //DYN_UNIT
	SetDynamicObjectMaterial(g_Object[83], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[84] = CreateDynamicObject(1416, -1594.0574, -316.7087, 89.9987, 0.0000, 0.0000, 0.0000, 1, 0, -1, 250.0, 300.0); //DYN_UNIT
	SetDynamicObjectMaterial(g_Object[84], 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0xFFFFFFFF);
	g_Object[85] = CreateDynamicObject(348, -1593.6616, -317.8504, 90.5912, 90.0000, 90.0000, 35.0000, 1, 0, -1, 250.0, 300.0); //desert_eagle
	g_Object[86] = CreateDynamicObject(352, -1593.7329, -317.3020, 90.5860, 90.0000, 112.2999, -45.0000, 1, 0, -1, 250.0, 300.0); //micro_uzi
	g_Object[87] = CreateDynamicObject(355, -1594.3721, -318.3687, 90.0596, -29.4999, -90.7999, -90.0999, 1, 0, -1, 250.0, 300.0); //ak47
	g_Object[88] = CreateDynamicObject(357, -1593.9879, -316.7662, 90.5559, 68.8999, 0.0000, 165.3000, 1, 0, -1, 250.0, 300.0); //cuntgun
	g_Object[89] = CreateDynamicObject(336, -1594.8952, -316.7681, 89.9935, 0.0000, 6.0999, 0.0000, 1, 0, -1, 250.0, 300.0); //bat
}