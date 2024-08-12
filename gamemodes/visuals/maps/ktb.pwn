
#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    LoadKTBMaps();
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    SOLS_RemoveBuilding(playerid, 5597, 2011.4688, -1300.8984, 28.6953, 0.25);
    SOLS_RemoveBuilding(playerid, 5461, 2011.4688, -1300.8984, 28.6953, 0.25);

    return 1;
}

LoadKTBMaps() {
    /*
    Bahamas
    */
    AddSimpleModel(-1, 19379,LAEGP_LOD, "gtac/bahamas/laegp_lod.dff", "gtac/bahamas/laegp_lod.txd");
    AddSimpleModel(-1, 19379,LAEGP_GARDOOR, "gtac/bahamas/laegp_gardoor.dff", "gtac/bahamas/laegp_gardoor.txd");
    AddSimpleModel(-1, 19379,LAEGP_EXT, "gtac/bahamas/laegp_ext.dff", "gtac/bahamas/laegp_ext.txd");
    AddSimpleModel(-1, 19379,LAEGP_INT, "gtac/bahamas/laegp_int.dff", "gtac/bahamas/laegp_int.txd");
    AddSimpleModel(-1, 19379,LAEGP_ALPHAS, "gtac/bahamas/laegp_alphas.dff", "gtac/bahamas/laegp_alphas.txd");
    AddSimpleModel(-1, 19379,LAEGP_BITS_1, "gtac/bahamas/laegp_bits_1.dff", "gtac/bahamas/laegp_bits_1.txd");

    CreateObject(LAEGP_LOD, 2011.47, -1300.9, 28.6953, 0.00, 0.00, 0.00, 800.00); // laegp_lod
    CreateObject(LAEGP_EXT, 2011.47, -1300.9, 28.6953, 0.00, 0.00, 0.00, 800.00); // laegp_ext
    CreateDynamicObject(LAEGP_INT, 2044.83, -1301.85, 26.4116, 0.00, 0.00, 0.00, -1, 0, -1, 200.00, 200.00); // laegp_int
    CreateDynamicObject(LAEGP_ALPHAS, 2044.83, -1301.85, 26.4116, 0.00, 0.00, 0.00, -1, 0, -1, 200.00, 200.00); // laegp_alphas
    CreateDynamicObject(LAEGP_BITS_1, 2044.83, -1301.85, 26.4116, 0.00, 0.00, 0.00, -1, 0, -1, 200.00, 200.00); // laegp_bits_1
}
