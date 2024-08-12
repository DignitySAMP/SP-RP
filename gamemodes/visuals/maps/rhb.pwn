#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    RemoveBuildingForPlayer(playerid, 3562, 2232.3984, -1464.7969, 25.6484, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2247.5313, -1464.7969, 25.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2263.7188, -1464.7969, 25.4375, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2243.7109, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2230.6094, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2256.6641, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 5649, 2252.0000, -1434.1406, 23.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 713, 2275.3906, -1438.6641, 22.5547, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2229.0234, -1411.6406, 22.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2265.6172, -1410.3359, 21.7734, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2230.6094, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2243.7109, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 645, 2237.5313, -1395.4844, 23.0391, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2256.6641, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2232.3984, -1464.7969, 25.6484, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2241.8906, -1458.9297, 22.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2247.5313, -1464.7969, 25.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2263.7188, -1464.7969, 25.4375, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2227.2031, -1444.5000, 22.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 5428, 2252.0000, -1434.1406, 23.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 700, 2226.5156, -1426.7656, 23.1172, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2243.5703, -1423.6094, 22.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 3593, 2261.7734, -1441.1016, 23.5000, 0.25);
    RemoveBuildingForPlayer(playerid, 3593, 2265.0781, -1424.4766, 23.5000, 0.25);
    RemoveBuildingForPlayer(playerid, 1297, 2273.6406, -1434.1484, 26.3906, 0.25); // Bugged pole in middle of kelly park street

}

#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    LoadRHBMaps();
}

LoadRHBMaps() {    
    // Jefferson Motel
    AddSimpleModel(-1, 8674, JEFFERSON_MOTEL_INT, "reyo/jm_bits2.dff", "reyo/jm_bits2.txd");
    AddSimpleModel(-1, 1923, JEFFERSON_MOTEL_EXT, "reyo/jm_main.dff", "reyo/jm_main.txd");
    CreateObject(JEFFERSON_MOTEL_EXT, 2222.992100, -1162.601400, 30.039100, 0.000000, 0.000000, 0.000000, 800.00);
    CreateDynamicObject(JEFFERSON_MOTEL_INT, 2184.500000, -1179.328100, 36.406200, 0.000000, 0.000000, 0.000000, -1, 0, -1, 800.00, 800.00);

    // Kelly Park
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, NEW3101_KP_BITS1, "gtac/jefferson/kellyland.dff",             "gtac/jefferson/kellyland.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, NEW3101_KP_BITS2, "gtac/jefferson/kellyprj1.dff",             "gtac/jefferson/kellyprj1.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, NEW3101_KP_BITS3, "gtac/jefferson/kellydetails1.dff",         "gtac/jefferson/kellydetails1.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, NEW3101_KP_BITS4, "gtac/jefferson/kellybits1.dff",            "gtac/jefferson/kellybits1.txd");
    AddSimpleModel(-1, 8674, NEW3101_KP_BITS5, "gtac/jefferson/kellyprj_alpha.dff",        "gtac/jefferson/kellyprj_alpha.txd");

    CreateObject(NEW3101_KP_BITS1, 2249.5129, -1433.3548, 22.9319, 0.0000, 0.0000, 0.0000, 800.0000); //3101/kellyland.dff
    CreateObject(NEW3101_KP_BITS2, 2229.4741, -1434.0080, 24.9169, 0.0000, 0.0000, 0.0000, 800.0000); //3101/kellyprj1.dff
    CreateDynamicObject(NEW3101_KP_BITS3, 2224.8588, -1431.9890, 24.3320, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //3101/kellydetails1.dff
    CreateDynamicObject(NEW3101_KP_BITS4, 2235.5629, -1429.5107, 26.2390, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //3101/kellybits1.dff
    CreateDynamicObject(NEW3101_KP_BITS5, 2241.4299, -1433.6717, 31.2810, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00); //3101/kellyprj_alpha.dff

}