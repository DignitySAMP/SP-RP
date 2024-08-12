#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {

    // Ryhes Westmont
    SOLS_RemoveBuilding(playerid, 5205, 2111.6563, -1873.3672, 16.3984, 0.25);
    SOLS_RemoveBuilding(playerid, 5206, 2163.6719, -1873.6172, 15.8203, 0.25);
    SOLS_RemoveBuilding(playerid, 5207, 2167.0391, -1925.2031, 15.8281, 0.25);
    SOLS_RemoveBuilding(playerid, 5208, 2115.0000, -1921.5234, 15.3906, 0.25);
    SOLS_RemoveBuilding(playerid, 3744, 2159.8281, -1930.6328, 15.0781, 0.25);
    SOLS_RemoveBuilding(playerid, 3567, 2142.9141, -1947.4219, 13.2656, 0.25);
    SOLS_RemoveBuilding(playerid, 1226, 2118.2891, -1939.3984, 16.3906, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2114.5547, -1928.1875, 5.0313, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2113.3984, -1925.0391, 10.8047, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2115.6719, -1922.7656, 10.8047, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2123.3594, -1928.0703, 6.8438, 0.25);
    SOLS_RemoveBuilding(playerid, 3574, 2159.8281, -1930.6328, 15.0781, 0.25);
    SOLS_RemoveBuilding(playerid, 5181, 2167.0391, -1925.2031, 15.8281, 0.25);
    SOLS_RemoveBuilding(playerid, 5182, 2115.0000, -1921.5234, 15.3906, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2122.6563, -1916.7891, 10.8047, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2116.9297, -1916.0781, 10.8047, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2121.5078, -1909.5313, 10.8047, 0.25);
    SOLS_RemoveBuilding(playerid, 620, 2110.2734, -1906.5859, 5.0313, 0.25);
    SOLS_RemoveBuilding(playerid, 5183, 2111.6563, -1873.3672, 16.3984, 0.25);
    SOLS_RemoveBuilding(playerid, 5180, 2163.6719, -1873.6172, 15.8203, 0.25);
    // Reyo Westmont Graffiti on Fence
    SOLS_RemoveBuilding(playerid, 5374, 2085.2666, -1909.7165, 22.9930, 0.50 );
    // Ryhes Seville
    SOLS_RemoveBuilding(playerid, 5256, 2768.4453, -2012.0938, 14.7969, 0.25);
    SOLS_RemoveBuilding(playerid, 1532, 2724.8594, -2025.7969, 12.5469, 0.25);
    SOLS_RemoveBuilding(playerid, 5302, 2741.0703, -2004.7813, 14.8750, 0.25);
    SOLS_RemoveBuilding(playerid, 5173, 2768.4453, -2012.0938, 14.7969, 0.25);

    SOLS_RemoveBuilding(playerid, 3244, 2632.3906, -1954.8203, 12.7578, 0.25);
    SOLS_RemoveBuilding(playerid, 5151, 2674.1016, -1990.7891, 15.1875, 0.25);
    SOLS_RemoveBuilding(playerid, 5241, 2674.1016, -1990.7891, 15.1875, 0.25);
    SOLS_RemoveBuilding(playerid, 3638, 2644.6172, -1955.7031, 15.7344, 0.25);
    SOLS_RemoveBuilding(playerid, 3638, 2666.4375, -1955.7031, 15.7344, 0.25);
    SOLS_RemoveBuilding(playerid, 3638, 2687.1250, -1955.7031, 15.7344, 0.25);
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    LoadSBFMaps();
    return 1;
}


LoadSBFMaps() {

    new txt_map;

    // Westmont
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_WESTMONT1,           "gtac/westmont/reyo_westmont1.dff",    "gtac/westmont/reyo_westmont1.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_WESTMONT2,           "gtac/westmont/reyo_westmont2.dff",    "gtac/westmont/reyo_westmont2.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_WESTMONT_BITS,           "gtac/westmont/reyo_wm_bits.dff",  "gtac/westmont/reyo_wm_bits.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_WESTMONT_BITS2,           "gtac/westmont/w_bits2.dff",      "gtac/westmont/w_bits2.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_WESTMONT4,           "gtac/westmont/westmont_4.dff",        "gtac/westmont/westmont.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_WESTMONT_2A,           "gtac/westmont/westmont2.dff",       "gtac/westmont/westmont.txd" ) ;

    CreateObject(RYHES_WESTMONT_BITS, 2141.8728, -1884.4298, 12.6302, 0.0000, 0.0000, 0.0000, 800.0000); //gtac/westmont/reyo_wm_bits.dff
    CreateObject(RYHES_WESTMONT1, 2163.6718, -1873.6169, 15.8203, 0.0000, 0.0000, 0.0000, 800.0000); //gtac/westmont/reyo_westmont1.dff
    CreateObject(RYHES_WESTMONT_2A, 2167.0390, -1925.2031, 15.8281, 0.0000, 0.0000, 0.0000, 800.0000); //gtac/westmont/westmont2.dff
    CreateObject(RYHES_WESTMONT2, 2100.7656, -1870.1402, 13.7693, 0.0000, 0.0000, 90.0000, 800.0000); //gtac/westmont/reyo_westmont2.dff
    CreateObject(RYHES_WESTMONT4, 2115.0000, -1921.5234, 15.3900, 0.0000, 0.0000, 0.0000, 800.0000); //gtac/westmont/westmont_4.dff
    CreateObject(RYHES_WESTMONT_BITS2, 2115.0000, -1921.5234, 15.3906, 0.0000, 0.0000, 0.0000, 800.0000); //gtac/westmont/w_bits2.dff

    // Seville
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_SEVILLE_STORES,           "gtac/seville/sbfstores.dff",     "gtac/seville/sbfstores.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_SEVILLE_SBFVP,           "gtac/seville/sbf_vp.dff",         "gtac/seville/sevtextures.txd" ) ;
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, REYO_SBF4_VP,     "gtac/seville/sbf4_vp.dff", "gtac/seville/sevtextures.txd" ) ;

    CreateObject(RYHES_SEVILLE_SBFVP, 2674.1015, -1990.7889, 15.1875, 0.0000, 0.0000, 0.0000, 2000.0000); //gtac/seville/sbf_vp.dff
    CreateObject(REYO_SBF4_VP, 2651.4736, -2034.9664, 15.5515, 0.0000, 0.0000, 0.0000, 2000.0000); //gtac/seville/sbf4_vp.dff
    CreateObject(REYO_ALLEY_BITS, 2677.6855, -1972.0061, 13.2657, 0.0000, 0.0000, 180.0000, 200.0000); //gtac/seville/alley_bits.dff
    CreateObject(REYO_ALLEY_BITS, 2623.3261, -2038.7264, 13.2657, 0.0000, 0.0000, 90.0000, 200.0000); //gtac/seville/alley_bits.dff
    CreateObject(RYHES_SEVILLE_STORES, 2768.4453, -2012.0937, 14.7966, 0.0000, 0.0000, 0.0000, 800.0000); //gtac/seville/sbfstores.dff
    CreateObject(RYHES_ENEX_GANTON_INT, 2729.9924, -2034.0129, 12.6063, 0.0000, 0.0000, 0.0000, 150.0000); //ryhes/ganton24_objects.dff
    CreateObject(REYO_ALLEY_BITS, 2640.0285, -2051.8674, 13.2657, 0.0000, 0.0000, -90.0000, 200.0000); //gtac/seville/alley_bits.dff

    
    CreateDynamicObject(3646, 2676.8830, -1953.7281, 14.8739, 0.0000, 0.0000, -90.0000, -1, 0, -1, 2000.00, 2000.00);  //ganghous05_LAx
    CreateDynamicObject(3648, 2640.6843, -1954.1063, 15.2740, 0.0000, 0.0000, -90.0000, -1, 0, -1, 2000.00, 2000.00);  //ganghous02_LAx
    CreateDynamicObject(3589, 2660.1662, -1951.4543, 15.2536, 0.0000, 0.0000, 0.0000, -1, 0, -1, 2000.00, 2000.00);  //compfukhouse3
    CreateDynamicObject(1419, 2658.0886, -1945.0477, 13.3992, 0.0000, 0.0000, 180.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_IRON_1
    CreateDynamicObject(1446, 2697.1005, -1942.3430, 13.3472, 0.0000, 0.0000, 180.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_R_WOOD_4
    CreateDynamicObject(1446, 2704.0036, -1948.2635, 13.3472, 0.0000, 0.0000, 90.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_R_WOOD_4
    CreateDynamicObject(1446, 2703.9836, -1944.6838, 13.3472, 0.0000, 0.0000, 90.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_R_WOOD_4
    CreateDynamicObject(1418, 2683.9208, -1942.3885, 13.2809, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_WOOD_3
    CreateDynamicObject(1460, 2670.4216, -1942.3503, 13.3142, 0.0000, 0.0000, 180.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_R_WOOD_3
    CreateDynamicObject(1460, 2679.9216, -1942.3503, 13.3142, 0.0000, 0.0000, 180.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_R_WOOD_3
    CreateDynamicObject(1418, 2686.2006, -1944.0852, 13.2809, 0.0000, 0.0000, 106.8000, -1, 0, -1, 200.00, 200.00);  //DYN_F_WOOD_3
    CreateDynamicObject(1418, 2686.7011, -1947.5078, 13.2809, 0.0000, 0.0000, 90.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_WOOD_3
    CreateDynamicObject(1446, 2701.7416, -1942.3430, 13.3472, 0.0000, 0.0000, 180.0000, -1, 0, -1, 200.00, 200.00);  //DYN_F_R_WOOD_4
    CreateDynamicObject(1468, 2668.0236, -1944.9626, 13.7690, 0.0000, 0.0000, 90.0000, -1, 0, -1, 200.00, 200.00);  //DYN_MESH_05
    CreateDynamicObject(1468, 2665.3815, -1942.4012, 13.7690, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00);  //DYN_MESH_05
    txt_map = CreateDynamicObject(19325, 2670.8103, -1965.6656, 12.4905, 0.0000, 0.0000, 90.0000, -1, 0, -1, 200.00, 200.00);  //lsmall_window01
    SetDynamicObjectMaterial(txt_map, 0, 4981, "wiresetc2_las", "ganggraf03_LA", 0xFFFFFFFF);
    CreateDynamicObject(994, 2627.5957, -2043.0937, 12.5572, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00);  //lhouse_barrier2
    CreateDynamicObject(994, 2627.6552, -2049.4140, 12.5572, 0.0000, 0.0000, 90.0000, -1, 0, -1, 200.00, 200.00);  //lhouse_barrier2
    CreateDynamicObject(3557, 2695.8549, -1957.7043, 14.9870, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 2000.00);  //compmedhos4_LAe
    txt_map = CreateDynamicObject(2256, 2750.8720, -1979.3092, 15.0747, 0.0000, -5.1999, 90.0000, -1, 0, -1, 200.00, 200.00);  //Frame_Clip_3
    SetDynamicObjectMaterial(txt_map, 0, 14801, "lee_bdupsmain", "Bdup_graf3", 0xFF000000);
    SetDynamicObjectMaterial(txt_map, 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
}