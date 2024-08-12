#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {

    // ELS Carwash
    SOLS_RemoveBuilding(playerid, 17738, 2459.3594, -1486.1250, 34.1641, 0.25);
    SOLS_RemoveBuilding(playerid, 17855, 2490.9063, -1474.3438, 27.3438, 0.25);
    SOLS_RemoveBuilding(playerid, 17856, 2492.3203, -1484.8047, 28.2656, 0.25);
    SOLS_RemoveBuilding(playerid, 17852, 2490.9063, -1474.3438, 27.3438, 0.25);
    SOLS_RemoveBuilding(playerid, 17853, 2492.3203, -1484.8047, 28.2656, 0.25);
    SOLS_RemoveBuilding(playerid, 17537, 2459.3594, -1486.1250, 34.1641, 0.25);

    // Janichar ELS vagos apt enex
    SOLS_RemoveBuilding(playerid, 17729, 2540.8281, -1350.5859, 40.8984, 0.25);
    SOLS_RemoveBuilding(playerid, 17679, 2540.8281, -1350.5859, 40.8984, 0.25);
    SOLS_RemoveBuilding(playerid, 17591, 2606.3828, -1341.8438, 47.5469, 0.25);
}

#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    LoadLSVMaps();
    return 1;
}


LoadLSVMaps() {
    
    // * ELS CARWASH / GARAGE
    AddSimpleModel(-1, 19478, ELScw_ELScw_alphas, "gtac/els_carwash/ELScw_alphas.dff", "gtac/els_carwash/ELScw_alphas.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, ELScw_ELScw_autoshpbloklae, "gtac/els_carwash/ELScw_autoshpbloklae2.dff", "gtac/els_carwash/ELScw_ext.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, ELScw_ELScw_cineblock1lae2, "gtac/els_carwash/ELScw_cineblock1lae2.dff", "gtac/els_carwash/ELScw_ext.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, ELScw_ELScw_cinemarklae2, "gtac/els_carwash/ELScw_cinemarklae2.dff", "gtac/els_carwash/ELScw_ext.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, ELScw_ELScw_int, "gtac/els_carwash/ELScw_int.dff", "gtac/els_carwash/ELScw_int.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, ELScw_ELScw_props_1, "gtac/els_carwash/ELScw_props_1.dff", "gtac/els_carwash/ELScw_props_1.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, ELScw_ELScw_props_2, "gtac/els_carwash/ELScw_props_2.dff", "gtac/els_carwash/ELScw_props_2.txd");
  	// ELS CARWASH / GARAGE
    CreateDynamicObject(ELScw_ELScw_alphas, 2487.1490, -1471.5900, 25.0890, 0.0000, 0.0000, 0.0000, -1, 0, -1, 150.00, 150.00); //gtac/els_carwash/ELScw_alphas
    CreateDynamicObject(ELScw_ELScw_autoshpbloklae, 2490.9060, -1474.3440, 27.3440, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //gtac/els_carwash/ELScw_autoshpbloklae2
    CreateDynamicObject(ELScw_ELScw_cineblock1lae2, 2459.3590, -1486.1250, 34.1640, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //gtac/els_carwash/ELScw_cineblock1lae2
    CreateDynamicObject(ELScw_ELScw_cinemarklae2, 2492.3200, -1484.8050, 28.2660, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //gtac/els_carwash/ELScw_cinemarklae2
    CreateDynamicObject(ELScw_ELScw_int, 2487.6820, -1472.9780, 24.9210, 0.0000, 0.0000, 0.0000, -1, 0, -1, 250.00, 250.00); //gtac/els_carwash/ELScw_int
    CreateDynamicObject(ELScw_ELScw_props_1, 2487.5320, -1472.6920, 24.9710, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00); //gtac/els_carwash/ELScw_props_1
    CreateDynamicObject(ELScw_ELScw_props_2, 2491.5960, -1483.6870, 29.2670, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00); //ELScw_props_2


    // * (LSV APARTMENTS): New gtac/els_apartments/ Apts by Ryhes
    AddSimpleModel(-1, 19379,LAUREL_M, "gtac/els_apartments//elsapt_m.dff", "gtac/els_apartments//elsapt_m.txd");
    AddSimpleModel(-1, 19379,LAUREL_INT, "gtac/els_apartments//elsapt_int.dff", "gtac/els_apartments//elsapt_int.txd");
    AddSimpleModel(-1, 19379,LAUREL_STAIRS, "gtac/els_apartments//elsapt_stairs.dff", "gtac/els_apartments//elsapt_stairs.txd");
    AddSimpleModel(-1, 19478,LAUREL_ALPHAS, "gtac/els_apartments//elsapt_alphas.dff", "gtac/els_apartments//elsapt_alphas.txd"); //*
    AddSimpleModel(-1, 19325,LAUREL_WINDOWS, "gtac/els_apartments//elsapt_windows.dff", "gtac/els_apartments//elsapt_alphas.txd"); //*
    AddSimpleModel(-1, 19379,LAUREL_1F_BITS, "gtac/els_apartments//elsapt_1f_1bits.dff", "gtac/els_apartments//elsapt_1f_1bits.txd");
    AddSimpleModel(-1, 19379,LAUREL_1F_RUBBLE, "gtac/els_apartments//elsapt_1f_rubble.dff", "gtac/els_apartments//elsapt_1f_rubble.txd");
    AddSimpleModel(-1, 19379,LAUREL_1F_HALLBITS, "gtac/els_apartments//elsapt_1f_hallbits.dff", "gtac/els_apartments//elsapt_1f_hallbits.txd");
    AddSimpleModel(-1, 19379,LAUREL_2F_HALLBITS, "gtac/els_apartments//elsapt_2f_hallbits.dff", "gtac/els_apartments//elsapt_2f_hallbits.txd");
    AddSimpleModel(-1, 19379,LAUREL_3F_HALLBITS, "gtac/els_apartments//elsapt_3f_hallbits.dff", "gtac/els_apartments//elsapt_3f_hallbits.txd");
    AddSimpleModel(-1, 19379,LAUREL_3F_1BITS, "gtac/els_apartments//elsapt_3f_1bits.dff", "gtac/els_apartments//elsapt_3f_1bits.txd");
    AddSimpleModel(-1, 19379,LAUREL_3F_2BITS, "gtac/els_apartments//elsapt_3f_2bits.dff", "gtac/els_apartments//elsapt_3f_2bits.txd");
    AddSimpleModel(-1, 19379,LAUREL_3F_3BITS, "gtac/els_apartments//elsapt_3f_3bits.dff", "gtac/els_apartments//elsapt_3f_3bits.txd");

    // gtac/els_apartments/
    CreateDynamicObject(LAUREL_M, 2540.8281, -1350.5859, 40.8984, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //els_apts_m
    CreateDynamicObject(LAUREL_INT, 2549.4995, -1411.0126, 34.4984, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00); //elsapt_int
    CreateDynamicObject(LAUREL_STAIRS, 2548.5571, -1413.7032, 37.6382, 0.0000, 0.0000, 0.0000, -1, 0, -1, 50.00, 50.00); //elsapt_stairs
    CreateDynamicObject(LAUREL_ALPHAS, 2563.0127, -1416.3363, 37.1961, 0.0000, 0.0000, 0.0000, -1, 0, -1, 300.00, 300.00); //elsapt_alphas
    CreateDynamicObject(LAUREL_WINDOWS, 2561.0325, -1409.7738, 33.6966, 0.0000, 0.0000, 0.0000, -1, 0, -1, 300.00, 300.00); //elsapt_windows
    CreateDynamicObject(LAUREL_1F_BITS, 2556.2522, -1407.3519, 33.9761, 0.0000, 0.0000, 0.0000, -1, 0, -1, 30.00, 30.00); //gtac/els_apartments//elsapt_1f_1bits
    CreateDynamicObject(LAUREL_1F_RUBBLE, 2545.5181, -1401.5587, 34.4024, 0.0000, 0.0000, 0.0000, -1, 0, -1, 30.00, 30.00); //gtac/els_apartments//elsapt_1f_rubble
    CreateDynamicObject(LAUREL_1F_HALLBITS, 2548.2234, -1410.5703, 33.5429, 0.0000, 0.0000, 0.0000, -1, 0, -1, 30.00, 30.00); //gtac/els_apartments//elsapt_1f_hallbits
    CreateDynamicObject(LAUREL_2F_HALLBITS, 2548.3008, -1411.6577, 37.1633, 0.0000, 0.0000, 0.0000, -1, 0, -1, 15.00, 15.00); //gtac/els_apartments//elsapt_2f_hallbits
    CreateDynamicObject(LAUREL_3F_HALLBITS, 2547.6875, -1411.2302, 40.6159, 0.0000, 0.0000, 0.0000, -1, 0, -1, 25.00, 25.00); //gtac/els_apartments//elsapt_3f_hallbits
    CreateDynamicObject(LAUREL_3F_1BITS, 2555.0422, -1407.2258, 41.1124, 0.0000, 0.0000, 0.0000, -1, 0, -1, 15.00, 15.00); //gtac/els_apartments//elsapt_3f_1bits
    CreateDynamicObject(LAUREL_3F_2BITS, 2557.2151, -1423.3451, 40.8858, 0.0000, 0.0000, 0.0000, -1, 0, -1, 15.00, 15.00); //gtac/els_apartments//elsapt_3f_2bits
    CreateDynamicObject(LAUREL_3F_3BITS, 2539.5249, -1425.2834, 40.3884, 0.0000, 0.0000, 0.0000, -1, 0, -1, 15.00, 15.00); //gtac/els_apartments//elsapt_3f_3bits

    // Trailer park
    CreateDynamicObject(3174, 2507.18188, -1527.31897, 22.70000,   0.00000, 0.00000, -177.47900, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(3172, 2518.00562, -1528.81006, 22.43000,   0.00000, 0.00000, 3.76500, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(3172, 2521.77051, -1528.30811, 22.65000,   -2.51000, 0.00000, 175.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(3171, 2512.72803, -1534.44690, 22.70000,   0.00000, 0.00000, -103.45500, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(3167, 2533.13916, -1525.39929, 22.67000,   0.00000, 0.00000, 174.72900, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(3174, 2527.01099, -1534.84900, 22.60000,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(691, 2519.29028, -1536.58972, 20.74600,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(3171, 2509.46509, -1520.13989, 22.70000,   0.00000, 0.00000, -220.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(669, 2532.80908, -1534.36829, 22.26760,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(669, 2532.80908, -1517.04932, 22.26760,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(669, 2507.96021, -1516.79834, 22.51860,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(669, 2520.00830, -1522.06934, 22.51860,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(669, 2506.95630, -1532.86230, 22.51860,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1442, 2516.13208, -1533.37219, 23.25000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1442, 2530.94116, -1533.37219, 23.25000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1441, 2517.38403, -1522.22864, 23.56000,   0.00000, 0.00000, 184.98700, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1439, 2531.01733, -1522.72693, 22.92010,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1413, 2535.81250, -1517.56274, 24.00000,   0.00000, 0.00000, 90.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2535.81250, -1522.83374, 24.00000,   0.00000, 0.00000, 90.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1413, 2535.81250, -1528.10474, 24.00000,   0.00000, 0.00000, 90.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2535.81250, -1533.37573, 24.00000,   0.00000, 0.00000, 90.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2535.81250, -1538.64673, 24.00000,   0.00000, 0.00000, 90.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2533.05151, -1541.25000, 24.00000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1413, 2527.78052, -1541.25000, 24.00000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1413, 2518.24268, -1541.25000, 24.00000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2512.97168, -1541.25000, 24.00000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2507.70068, -1541.25000, 24.00000,   0.00000, 0.00000, 0.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1413, 2505.05005, -1538.48901, 24.00000,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2505.05005, -1533.21802, 24.00000,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2505.05005, -1527.94702, 24.00000,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1413, 2505.05005, -1522.67603, 24.00000,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
    CreateDynamicObject(1412, 2505.05005, -1517.40503, 24.00000,   0.00000, 0.00000, 270.00000, -1, 0, -1, 250.0, 250.0);
}