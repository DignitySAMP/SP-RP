
#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    // Rancho
    RemoveBuildingForPlayer(playerid, 5198, 1983.5313, -2085.1172, 18.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 5189, 1983.5313, -2085.1172, 18.0781, 0.25);

    // Dead end house
    RemoveBuildingForPlayer(playerid, 3670, 1759.9375, -2136.1953, 15.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 3635, 1759.9375, -2136.1953, 15.1719, 0.25);

    return 1;
}


#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    LoadVLAMaps();
    return 1;
}

LoadVLAMaps() {

    // Models for Rancho Complex
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_EXT,        "ryhes/rancho/rchcomplex_ext.dff", "ryhes/rancho/rchcomplex_ext.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_APT_2,      "ryhes/rancho/bits/rchcomplex_apt_2.dff", "ryhes/rancho/bits/rchcomplex_apt_2.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_MBITS,      "ryhes/rancho/bits/rchcomplex_mBits.dff", "ryhes/rancho/bits/rchcomplex_mBits.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_ALPHAS,     "ryhes/rancho/rchcomplex_alphas.dff", "ryhes/rancho/rchcomplex_alphas.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_APT_4,      "ryhes/rancho/bits/rchcomplex_apt_4.dff", "ryhes/rancho/bits/rchcomplex_apt_4.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_INT,        "ryhes/rancho/rchcomplex_int.dff", "ryhes/rancho/rchcomplex_int.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_APT_1,      "ryhes/rancho/bits/rchcomplex_apt_1.dff", "ryhes/rancho/bits/rchcomplex_apt_1.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RCHCOMPLEX_APT_3,      "ryhes/rancho/bits/rchcomplex_apt_3.dff", "ryhes/rancho/bits/rchcomplex_apt_3.txd");

    // Rancho Complex
    CreateObject(RCHCOMPLEX_EXT,     1983.4536,-2085.1494,18.6397,0.000000,0.000000,0.000000);
    CreateDynamicObject(RCHCOMPLEX_APT_2,   1988.4525,-2073.1255,20.3897,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);
    CreateDynamicObject(RCHCOMPLEX_MBITS,   1984.7211,-2089.3706,16.6210,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);
    CreateDynamicObject(RCHCOMPLEX_ALPHAS,  1983.4536,-2085.1494,18.6397,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);
    CreateDynamicObject(RCHCOMPLEX_APT_4,   1988.0159,-2078.1699,16.7134,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);
    CreateDynamicObject(RCHCOMPLEX_INT,     1981.1716,-2085.3062,18.3002,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);
    CreateDynamicObject(RCHCOMPLEX_APT_1,   1976.3156,-2076.5000,20.1810,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);
    CreateDynamicObject(RCHCOMPLEX_APT_3,   1976.0215,-2096.6514,20.4050,0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0);


    // Models for El Corona Dead End Enex
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, GHOUSE_OUT,      "midnight/ghouse_out.dff",      "midnight/ghouse_out.txd" );
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, GHOUSE_BITS,      "midnight/ghouse_bits.dff",     "midnight/ghouse_bits.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, GHOUSE_IN,      "midnight/ghouse_in.dff",       "midnight/ghouse_in.txd" );
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, GHOUSE_ALPHA,      "midnight/ghouse_alpha.dff",    "midnight/ghouse_alpha.txd");

    // El Corona Dead End Enex
    CreateObject(GHOUSE_OUT,1759.933594,-2136.040039,15.284300 , 0.000000,0.000000,0.000000); // ghouse_out
    CreateDynamicObject(GHOUSE_BITS,1759.879639,-2130.981934,14.165700 , 0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0); // ghouse_bits
    CreateDynamicObject(GHOUSE_IN,1759.933594,-2136.040039,15.284300 , 0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0); // ghouse_in
    CreateDynamicObject(GHOUSE_ALPHA,1755.489990,-2125.742188,14.494900 , 0.000000,0.000000,0.000000 ,-1,-1,-1, 820.0, 800.0); // ghouse_alpha
}
