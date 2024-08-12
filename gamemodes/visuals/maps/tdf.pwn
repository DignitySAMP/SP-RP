#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    LoadTDFMaps();
    return 1;
}

LoadTDFMaps() {
    new g_Object[364];
    g_Object[0] = CreateObject(1362, 1269.6391, -893.6914, 42.4706, 0.0000, 0.0000, 5.7999, 200.0000); //CJ_FIREBIN_(L0)
    SetObjectMaterial(g_Object[0], 0, 1328, "labins01_la", "cj_bin2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[0], 1, 1574, "dyn_trash", "trash", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[0], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[1] = CreateObject(3496, 1276.2032, -881.0482, 41.5651, 0.0000, 0.0000, -174.5997, 200.0000); //vgsxrefbballnet
    SetObjectMaterial(g_Object[1], 0, 14785, "gen_offtrackint", "otb_mural4", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[1], 1, 16640, "a51", "banding9_64HV", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[1], 2, 2917, "a51_crane", "banding5_64HV", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[1], 3, 14785, "gen_offtrackint", "otb_mural1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[1], 5, 16640, "a51", "scratchedmetal", 0xFFFFFFFF);
    g_Object[2] = CreateObject(8674, 1265.3446, -897.1065, 43.3208, 0.0000, 0.0000, -84.4000, 250.0000); //csrsfence02_lvs
    g_Object[3] = CreateObject(1437, 1304.0495, -895.8950, 46.2304, -20.4999, -0.1999, 96.0000, 200.0000); //DYN_LADDER_2
    SetObjectMaterial(g_Object[3], 0, 3629, "arprtxxref_las", "metaldoor_128", 0xFFFFFFFF);
    g_Object[4] = CreateObject(3035, 1269.7397, -895.2581, 42.6557, 0.0000, 0.0000, 96.1996, 200.0000); //tmp_bin
    g_Object[5] = CreateObject(1208, 1269.6612, -891.7799, 42.1566, 90.0000, 0.0000, 4.9998, 200.0000); //washer
    g_Object[6] = CreateObject(19995, 1269.5770, -893.7940, 42.5690, 16.7999, 90.0000, 0.0000, 75.0000); //CutsceneAmmoClip1
    g_Object[7] = CreateObject(19995, 1269.5775, -893.6065, 42.6072, -1.2000, 101.9999, 90.4000, 75.0000); //CutsceneAmmoClip1
    g_Object[8] = CreateObject(19874, 1269.6881, -893.7130, 42.5861, -3.3998, 9.9996, -55.0000, 75.0000); //SoapBar1
    SetObjectMaterial(g_Object[8], 0, 1279, "craigpackage", "drugs", 0xFFFFFFFF);
    g_Object[9] = CreateObject(8674, 1271.2253, -903.1801, 43.2807, 0.0000, 0.0000, -84.4000, 250.0000); //csrsfence02_lvs
    g_Object[10] = CreateObject(8674, 1270.5688, -896.6945, 43.2807, 0.0000, 0.0000, -84.4000, 250.0000); //csrsfence02_lvs
    g_Object[11] = CreateObject(639, 1265.4012, -897.2219, 42.7728, 0.0000, 0.0000, -175.4001, 250.0000); //veg_ivy_balcny_kb3
    SetObjectMaterial(g_Object[11], 0, 17851, "cinemart_alpha", "kb_ivy2_256", 0xFFFFFFFF);
    g_Object[13] = CreateObject(1712, 1303.1245, -883.5087, 41.8501, 0.0000, 0.0000, -91.3999, 130.0000); //kb_couch05
    g_Object[14] = CreateObject(924, 1269.5704, -894.4766, 43.5527, 0.0000, 0.0000, 4.5998, 200.0000); //FRUITCRATE3
    SetObjectMaterial(g_Object[14], 0, 2567, "ab", "Box_Texturepage", 0xFFFFFFFF);
    g_Object[15] = CreateObject(2677, 1268.9099, -894.0197, 42.1543, 0.0000, 0.0000, 23.9999, 75.0000); //PROC_RUBBISH_7
    SetObjectMaterial(g_Object[15], 0, 2765, "cj_cb_sign", "CJ_CB_POST1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[15], 1, 2765, "cj_cb_sign", "CJ_CB_POST1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[15], 2, 13363, "cephotoblockcs_t", "lampost_16clr", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[15], 3, 14690, "7_11_posters", "cokopops_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[15], 4, 2059, "cj_ammo2", "cj_don_post_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[15], 5, 14742, "mp3", "GB_rapposter05", 0xFF9CA1A3);
    g_Object[16] = CreateObject(1265, 1266.1555, -899.9033, 42.1771, 0.0000, 0.0000, 127.5998, 200.0000); //BlackBag2
    g_Object[17] = CreateObject(1439, 1266.2331, -901.2155, 42.0018, 0.0000, 0.0000, 95.5998, 250.0000); //DYN_DUMPSTER_1
    SetObjectMaterial(g_Object[17], 1, 13059, "ce_fact03", "Ind_PKabin", 0xFFFFFFFF);
    g_Object[18] = CreateObject(10252, 1270.4486, -907.8272, 43.5022, 0.0000, 0.0000, 7.1999, 250.0000); //china_town_gateb
    g_Object[19] = CreateObject(10252, 1263.1793, -908.6798, 43.5022, 0.0000, 0.0000, 6.1999, 250.0000); //china_town_gateb
    g_Object[20] = CreateObject(1710, 1276.8740, -890.2683, 41.8745, 0.0000, 0.0000, -173.7998, 200.0000); //kb_couch07
    g_Object[21] = CreateObject(1670, 1300.8414, -884.6505, 42.6870, 0.0000, 0.0000, -87.7994, 100.0000); //propcollecttable
    SetObjectMaterial(g_Object[21], 0, 1488, "dyn_objects", "CJ_bottle3", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[21], 6, 1486, "break_bar", "CJ_bottle", 0xFFFFFFFF);
    g_Object[22] = CreateObject(2112, 1300.7950, -884.8643, 42.2605, 0.0000, 0.0000, 0.0000, 200.0000); //MED_DINNING_4
    SetObjectMaterial(g_Object[22], 0, 13003, "ce_racestart", "CJ_TARTAN", 0xFFFFFFFF);
    g_Object[23] = CreateObject(2112, 1300.7950, -883.4846, 42.2605, 0.0000, 0.0000, 0.0000, 200.0000); //MED_DINNING_4
    SetObjectMaterial(g_Object[23], 0, 13003, "ce_racestart", "CJ_TARTAN", 0xFFFFFFFF);
    g_Object[24] = CreateObject(1670, 1300.9465, -883.3350, 42.6870, 0.0000, 0.0000, -30.6000, 100.0000); //propcollecttable
    SetObjectMaterial(g_Object[24], 0, 1488, "dyn_objects", "CJ_bottle3", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[24], 6, 1486, "break_bar", "CJ_bottle2", 0xFFFFFFFF);
    g_Object[25] = CreateObject(2852, 1300.6955, -883.9495, 42.6487, 0.0000, 0.0000, -57.9999, 100.0000); //gb_bedmags02
    g_Object[26] = CreateObject(1946, 1276.3916, -881.6079, 42.0312, 0.0000, 0.0000, 97.1996, 100.0000); //baskt_ball_hi
    g_Object[27] = CreateObject(19325, 1304.3502, -884.3391, 42.2065, 1.1999, 0.0000, 0.0000, 200.0000); //lsmall_window01
    SetObjectMaterial(g_Object[27], 0, 1530, "tags_lavagos", "vagos", 0xFF000000);
    g_Object[28] = CreateObject(1707, 1247.7032, -906.6519, 45.4766, 0.0000, 0.0000, 98.5998, 250.0000); //kb_couch01
    g_Object[29] = CreateObject(1933, 1287.2600, -900.8903, 46.0494, 0.0000, 0.0000, 0.0000, 100.0000); //chip_stack16
    g_Object[30] = CreateObject(1827, 1287.4526, -900.3378, 45.6174, 0.0000, 0.0000, 0.0000, 200.0000); //man_sdr_tables
    SetObjectMaterial(g_Object[30], 0, 18058, "mp_diner2", "mp_diner_table", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[30], 1, 18058, "mp_diner2", "mp_diner_table", 0xFFFFFFFF);
    g_Object[31] = CreateObject(1933, 1288.0664, -900.4860, 46.0494, 0.0000, 0.0000, 6.8000, 100.0000); //chip_stack16
    SetObjectMaterial(g_Object[31], 0, 1859, "chips2", "indx_chip432", 0xFFFFFFFF);
    g_Object[32] = CreateObject(1933, 1287.9807, -900.5701, 46.0494, 0.0000, 0.0000, -45.4000, 100.0000); //chip_stack16
    SetObjectMaterial(g_Object[32], 0, 1859, "chips2", "chip_stck6", 0xFFFFFFFF);
    g_Object[33] = CreateObject(1933, 1287.3259, -899.8502, 46.0494, 0.0000, 0.0000, 6.8000, 100.0000); //chip_stack16
    SetObjectMaterial(g_Object[33], 0, 1859, "chips2", "indx_chip432", 0xFFFFFFFF);
    g_Object[34] = CreateObject(1933, 1287.4055, -899.8405, 46.0494, 0.0000, 0.0000, 65.9999, 100.0000); //chip_stack16
    SetObjectMaterial(g_Object[34], 0, 1859, "chips2", "chip_stck3", 0xFFFFFFFF);
    g_Object[35] = CreateObject(1933, 1287.0266, -900.0009, 46.0494, 0.0000, 0.0000, 65.9999, 100.0000); //chip_stack16
    SetObjectMaterial(g_Object[35], 0, 1859, "chips2", "indx_chip164", 0xFFFFFFFF);
    g_Object[36] = CreateObject(2660, 1287.5002, -900.3275, 46.0796, -90.0000, 0.0000, 28.3999, 100.0000); //CJ_BANNER06
    SetObjectMaterial(g_Object[36], 0, 1827, "kbmiscfrn2", "man_mny1", 0xFFFFFFFF);
    g_Object[37] = CreateObject(19825, 1285.1695, -900.8145, 47.9308, 0.0000, 0.0000, 96.3999, 100.0000); //SprunkClock1
    g_Object[38] = CreateObject(8674, 1275.1966, -891.0114, 43.2807, 0.0000, 0.0000, 6.7999, 250.0000); //csrsfence02_lvs
    g_Object[39] = CreateObject(2660, 1290.0233, -898.7976, 47.2573, 0.0000, 0.0000, -81.7994, 100.0000); //CJ_BANNER06
    SetObjectMaterial(g_Object[39], 0, 10148, "bombshop_sfe", "calendar01", 0xFFFFFFFF);
    g_Object[40] = CreateObject(2612, 1290.0716, -899.2653, 47.1977, 0.0000, 0.0000, -82.4000, 200.0000); //POLICE_NB2
    SetObjectMaterial(g_Object[40], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[40], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[40], 3, 15054, "savesfmid", "cspornmag", 0xFFFFFFFF);
    g_Object[41] = CreateObject(8674, 1259.7104, -892.5354, 43.3208, 0.0000, 0.0000, 6.3997, 250.0000); //csrsfence02_lvs
    g_Object[42] = CreateObject(14826, 1266.1373, -873.2985, 42.5601, 0.0000, 0.0000, 96.7994, 250.0000); //int_kbsgarage2
    g_Object[43] = CreateObject(18762, 1269.6584, -914.2133, 41.2172, 24.3999, 90.0000, 9.3999, 200.0000); //Concrete1mx1mx5m
    SetObjectMaterial(g_Object[43], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[44] = CreateObject(1704, 23.9458, -1.1094, 0.7487, 0.0000, 0.0000, 0.0000, 25.0000); //kb_chair03
    g_Object[45] = CreateObject(19790, 1035.6936, -1001.0360, 32.8558, 0.0000, 0.0000, 90.0000, 75.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[45], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[46] = CreateObject(1522, 2073.4011, -2048.3034, 180.0000, 0.0000, 0.0000, 0.0000, 75.0000); //Gen_doorSHOP3
    g_Object[47] = CreateObject(19393, 1036.6739, -1003.6173, 39.5167, 0.0000, 0.0000, 90.0000, 75.0000); //wall041
    SetObjectMaterial(g_Object[47], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[48] = CreateObject(19357, 1034.6556, -1003.6074, 37.2680, 0.0000, 0.0000, 90.0000, 250.0000); //wall005
    SetObjectMaterial(g_Object[48], 0, 3193, "cxref_desert", "sw_woodslat01", 0xFFFFFFFF);
    g_Object[49] = CreateObject(19357, 1033.1352, -1002.1370, 37.2680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[49], 0, 3193, "cxref_desert", "sw_woodslat01", 0xFFFFFFFF);
    g_Object[50] = CreateObject(8658, 1185.7977, -1305.8039, 13.4926, 0.0000, 0.0000, 180.0000, 300.0000); //shabbyhouse11_lvs
    SetObjectMaterial(g_Object[50], 0, 9524, "blokmodb", "Bow_Grimebrick", 0xFFFFFFFF);
    g_Object[51] = CreateObject(8661, 1165.8039, -1300.5937, 12.5289, 0.0000, 0.0000, 0.0000, 500.0000); //gnhtelgrnd_lvs
    SetObjectMaterial(g_Object[51], 0, 4833, "airprtrunway_las", "greyground256", 0xFFFFFFFF);
    g_Object[52] = CreateObject(10252, 1205.8204, -1118.4748, 24.5111, 0.0000, 0.0000, 180.0000, 120.0000); //china_town_gateb
    g_Object[53] = CreateObject(10252, 1203.3601, -1118.4748, 24.5111, 0.0000, 0.0000, 180.0000, 120.0000); //china_town_gateb
    g_Object[54] = CreateObject(19790, 1035.4355, -996.2567, 32.8460, 0.0000, 0.0000, 90.0000, 75.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[54], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[55] = CreateObject(19940, 1208.2380, -1117.8437, 23.3610, 0.0000, -10.6997, 90.0000, 75.0000); //MKShelf3
    SetObjectMaterial(g_Object[55], 0, 3314, "ce_burbhouse", "ventc64", 0xFFFFFFFF);
    g_Object[56] = CreateObject(19940, 1206.2480, -1117.8437, 23.3610, 0.0000, -10.6997, 90.0000, 75.0000); //MKShelf3
    SetObjectMaterial(g_Object[56], 0, 3314, "ce_burbhouse", "ventc64", 0xFFFFFFFF);
    g_Object[57] = CreateObject(2930, 1204.6197, -1117.7900, 26.1347, 0.0000, 0.0000, 161.6999, 75.0000); //chinaTgate
    SetObjectMaterial(g_Object[57], 0, 4829, "airport_las", "fencekb_64h", 0xFF000000);
    SetObjectMaterial(g_Object[57], 1, 11100, "bendytunnel_sfse", "blackmetal", 0xFFFFFFFF);
    g_Object[58] = CreateObject(2930, 1206.9665, -1117.6914, 26.1347, 0.0000, 0.0000, 161.8999, 120.0000); //chinaTgate
    SetObjectMaterial(g_Object[58], 0, 4829, "airport_las", "fencekb_64h", 0xFF000000);
    SetObjectMaterial(g_Object[58], 1, 11100, "bendytunnel_sfse", "blackmetal", 0xFFFFFFFF);
    g_Object[59] = CreateObject(19940, 1204.2578, -1117.8437, 23.3610, 0.0000, -10.6997, 90.0000, 75.0000); //MKShelf3
    SetObjectMaterial(g_Object[59], 0, 3314, "ce_burbhouse", "ventc64", 0xFFFFFFFF);
    g_Object[60] = CreateObject(19940, 1202.2578, -1117.8437, 23.3610, 0.0000, -10.6997, 90.0000, 100.0000); //MKShelf3
    SetObjectMaterial(g_Object[60], 0, 3314, "ce_burbhouse", "ventc64", 0xFFFFFFFF);
    g_Object[61] = CreateObject(19940, 1200.2473, -1117.8437, 23.3610, 0.0000, -10.6997, 90.0000, 100.0000); //MKShelf3
    SetObjectMaterial(g_Object[61], 0, 3314, "ce_burbhouse", "ventc64", 0xFFFFFFFF);
    g_Object[62] = CreateObject(19325, 1193.9305, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[62], 0, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
    g_Object[63] = CreateObject(19325, 1200.5522, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[63], 0, 6404, "beafron1_law2", "shutter04LA", 0xFFFFFFFF);
    g_Object[64] = CreateObject(19325, 1187.3098, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[64], 0, 6404, "beafron1_law2", "shutter02LA", 0xFFFFFFFF);
    g_Object[65] = CreateObject(19325, 1180.6888, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[65], 0, 6404, "beafron1_law2", "shutter04LA", 0xFFFFFFFF);
    g_Object[66] = CreateObject(19325, 1167.4206, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[66], 0, 5461, "glenpark6d_lae", "shutter01LA", 0xFFFFFFFF);
    g_Object[67] = CreateObject(19325, 1174.0400, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[67], 0, 5461, "glenpark6d_lae", "shutter01LA", 0xFFFFFFFF);
    g_Object[68] = CreateObject(19325, 1160.7912, -1159.5749, 24.5783, 0.0000, 0.0000, 90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[68], 0, 6404, "beafron1_law2", "shutter04LA", 0xFFFFFFFF);
    g_Object[69] = CreateObject(19325, 1180.6888, -1159.5749, 29.3183, 0.0000, 0.0000, -90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[69], 0, 6282, "beafron2_law2", "hollysign02_LAw", 0xFFFFFFFF);
    g_Object[70] = CreateObject(19325, 1200.4791, -1159.5749, 29.3183, 0.0000, 0.0000, -90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[70], 0, 17526, "eastls1_lae2", "comptsign3_LAe", 0xFFFFFFFF);
    g_Object[71] = CreateObject(19325, 1161.0572, -1159.5749, 29.3183, 0.0000, 0.0000, -90.0000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[71], 0, 17508, "barrio1_lae2", "gangsign4_LAe", 0xFFFFFFFF);
    g_Object[72] = CreateObject(19368, 1210.7679, -1131.1800, 23.9022, 0.0000, 0.0000, 90.0000, 250.0000); //wall016
    SetObjectMaterial(g_Object[72], 0, 13699, "cunte2_lahills", "laposhfence3", 0xFFFFFFFF);
    g_Object[73] = CreateObject(1256, 1179.4433, -1159.1164, 23.5076, 0.0000, 0.0000, -90.0000, 250.0000); //Stonebench1
    g_Object[74] = CreateObject(1256, 1159.2832, -1159.1164, 23.5076, 0.0000, 0.0000, -90.0000, 250.0000); //Stonebench1
    g_Object[75] = CreateObject(19790, 1186.7170, -1120.4366, 18.3558, 0.0000, 0.0000, 90.0000, 120.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[75], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[76] = CreateObject(19790, 1181.7374, -1120.4366, 18.3558, 0.0000, 0.0000, 90.0000, 75.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[76], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[77] = CreateObject(2957, 1189.3260, -1127.4614, 24.5701, 0.0000, 0.0000, 90.6996, 120.0000); //chinaTgarageDoor
    SetObjectMaterial(g_Object[77], 0, 3816, "bighangarsfxr", "ws_hangardoor", 0xFFFFFFFF);
    g_Object[78] = CreateObject(19325, 1209.8913, -1126.6739, 25.1784, 0.0000, 0.0000, -179.3999, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[78], 0, 18024, "intclotheshiphop", "mp_cloth_sub", 0xFF072407);
    g_Object[79] = CreateObject(2612, 1211.0100, -1131.3054, 24.4244, 0.0000, 0.0000, 0.0000, 250.0000); //POLICE_NB2
    SetObjectMaterial(g_Object[79], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[79], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[79], 2, 15040, "cuntcuts", "newspaper1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[79], 3, 15040, "cuntcuts", "csnewspaper", 0xFFFFFFFF);
    g_Object[80] = CreateObject(1569, 1181.8426, -1121.4377, 23.3085, 0.0000, 0.0000, 90.0000, 120.0000); //ADAM_V_DOOR
    SetObjectMaterial(g_Object[80], 0, 12805, "ce_loadbay", "sw_waredoor", 0xFFFFFFFF);
    g_Object[81] = CreateObject(1236, 1198.5144, -1118.5423, 24.0513, 0.0000, 0.0000, 0.0000, 75.0000); //rcyclbank01
    g_Object[82] = CreateObject(1339, 1182.3425, -1118.7325, 23.9848, 0.0000, 0.0000, 39.7000, 75.0000); //BinNt09_LA
    SetObjectMaterial(g_Object[82], 0, 1328, "labins01_la", "bins4_LAe2", 0xFFFFFFFF);
    g_Object[83] = CreateObject(1339, 1183.2812, -1118.6103, 23.9848, 0.0000, 0.0000, 0.6998, 75.0000); //BinNt09_LA
    SetObjectMaterial(g_Object[83], 0, 1328, "labins01_la", "bins7_LAe2", 0xFFFFFFFF);
    g_Object[84] = CreateObject(1236, 1213.6949, -1121.5826, 23.9113, 0.0000, 0.0000, 90.0000, 250.0000); //rcyclbank01
    g_Object[85] = CreateObject(1236, 1214.3856, -1129.0633, 23.6914, 0.0000, 0.0000, 94.5998, 250.0000); //rcyclbank01
    g_Object[86] = CreateObject(11714, 1214.8729, -1125.6711, 24.3631, 0.0000, 0.0000, 5.0998, 250.0000); //MaintenanceDoors1
    SetObjectMaterial(g_Object[86], 0, 18246, "cw_junkyard2cs_t", "Was_scrpyd_door_dbl_grey", 0xFFFFFFFF);
    g_Object[87] = CreateObject(11714, 1203.3835, -1122.5058, 24.4230, 0.0000, 0.0000, 90.0998, 250.0000); //MaintenanceDoors1
    SetObjectMaterial(g_Object[87], 0, 18246, "cw_junkyard2cs_t", "Was_scrpyd_door_dbl_grey", 0xFFFFFFFF);
    g_Object[88] = CreateObject(19325, 1181.9499, -1128.5655, 24.6583, 0.0000, 0.0000, 0.0000, 130.0000); //lsmall_window01
    SetObjectMaterial(g_Object[88], 0, 18028, "cj_bar2", "CJ_nastybar_D3", 0x99FFFFFF);
    g_Object[89] = CreateObject(19325, 1192.7110, -1122.3822, 24.7182, 0.0000, 0.0000, -91.0998, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[89], 0, 18028, "cj_bar2", "CJ_nastybar_D2", 0x99FFFFFF);
    g_Object[90] = CreateObject(19325, 1199.8708, -1122.4742, 24.7182, 0.0000, 0.0000, -90.5000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[90], 0, 18028, "cj_bar2", "CJ_nastybar_D6", 0x99FFFFFF);
    g_Object[91] = CreateObject(19325, 1206.5128, -1122.4853, 24.7182, 0.0000, 0.0000, -89.8000, 250.0000); //lsmall_window01
    SetObjectMaterial(g_Object[91], 0, 18028, "cj_bar2", "CJ_nastybar_D", 0x99FFFFFF);
    g_Object[92] = CreateObject(9131, 1189.5969, -1122.6986, 23.3586, 0.0000, 0.0000, 0.0000, 120.0000); //shbbyhswall13_lvs
    SetObjectMaterial(g_Object[92], 0, 18028, "cj_bar2", "GB_nastybar08", 0x99FFFFFF);
    g_Object[93] = CreateObject(9131, 1189.5969, -1122.6986, 25.6284, 0.0000, 0.0000, 0.0000, 120.0000); //shbbyhswall13_lvs
    SetObjectMaterial(g_Object[93], 0, 18028, "cj_bar2", "GB_nastybar08", 0x99FFFFFF);
    g_Object[94] = CreateObject(1256, 1217.8824, -1131.4272, 23.6228, 0.0000, 0.0000, 90.0000, 250.0000); //Stonebench1
    g_Object[95] = CreateObject(1256, 1237.0428, -1131.2572, 23.6228, 0.0000, 0.0000, 90.0000, 250.0000); //Stonebench1
    g_Object[96] = CreateObject(1257, 1191.8443, -1134.4510, 24.1714, 0.0000, 0.0000, 90.0000, 75.0000); //bustopm
    g_Object[97] = CreateObject(1440, 1210.6152, -1130.3863, 23.5037, 0.0000, 0.0000, 180.0000, 75.0000); //DYN_BOX_PILE_3
    SetObjectMaterial(g_Object[97], 0, 9583, "bigshap_sfw", "freight_crate7", 0xFFFFFFFF);
    g_Object[98] = CreateObject(1287, 1163.9466, -1155.0078, 23.3929, 0.0000, 0.0000, 0.0000, 250.0000); //newstandnew3
    g_Object[99] = CreateObject(1285, 1164.7617, -1154.9945, 23.3512, 0.0000, 0.0000, 0.0000, 250.0000); //newstandnew5
    g_Object[100] = CreateObject(1300, 1176.7860, -1159.1218, 23.2255, 0.0000, 0.0000, 0.0000, 250.0000); //bin1
    g_Object[101] = CreateObject(1300, 1156.7856, -1159.1218, 23.2255, 0.0000, 0.0000, 0.0000, 250.0000); //bin1
    g_Object[102] = CreateObject(2671, 1183.2574, -1119.6317, 23.3684, 0.0000, 0.0000, 0.0000, 100.0000); //PROC_RUBBISH_3
    SetObjectMaterial(g_Object[102], 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0xFFFFFFFF);
    g_Object[103] = CreateObject(2673, 1214.5766, -1128.6379, 24.4447, 0.0000, 0.0000, 0.0000, 75.0000); //PROC_RUBBISH_5
    g_Object[104] = CreateObject(1230, 1199.9737, -1118.3801, 23.7938, 0.0000, 0.0000, 0.0000, 75.0000); //cardboardbox
    g_Object[105] = CreateObject(1220, 1197.8872, -1118.5892, 25.0501, 0.0000, 0.0000, -46.0998, 75.0000); //cardboardbox2
    g_Object[106] = CreateObject(1220, 1197.6933, -1121.6899, 23.5503, 0.0000, 0.0000, 40.2999, 75.0000); //cardboardbox2
    g_Object[107] = CreateObject(1635, 1198.9051, -1121.9831, 26.4841, 0.0000, 0.0000, -90.6996, 75.0000); //nt_aircon1dbl
    g_Object[108] = CreateObject(19325, 1152.6655, -1121.3509, 23.4479, -2.4999, 0.0000, 180.0000, 150.0000); //lsmall_window01
    SetObjectMaterial(g_Object[108], 0, 1529, "tags_latemple", "temple", 0xFF177517);
    g_Object[109] = CreateObject(19466, 1152.3662, -1114.2679, 24.8171, 0.0000, 0.0000, 180.0000, 120.0000); //window001
    SetObjectMaterial(g_Object[109], 0, 14801, "lee_bdupsmain", "Bdup_graf3", 0xFF177517);
    g_Object[110] = CreateObject(19393, 1036.2425, -994.6887, 39.5768, 0.0000, 0.0000, 90.0000, 250.0000); //wall041
    SetObjectMaterial(g_Object[110], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[111] = CreateObject(19790, 1033.4432, -1009.1569, 31.2660, 0.0000, 0.0000, 90.0000, 250.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[111], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[112] = CreateObject(19790, 1033.3935, -1004.1770, 31.2660, 0.0000, 0.0000, 90.0000, 250.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[112], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[113] = CreateObject(19405, 1033.1246, -1002.1378, 39.5213, 0.0000, 0.0000, 0.0000, 250.0000); //wall053
    SetObjectMaterial(g_Object[113], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[114] = CreateObject(19405, 1034.6561, -1003.6768, 39.5811, 0.0000, 0.0000, 90.0000, 250.0000); //wall053
    SetObjectMaterial(g_Object[114], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[115] = CreateObject(19357, 1034.5456, -999.7669, 39.5680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[115], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[116] = CreateObject(19405, 1035.9764, -1005.3582, 39.5213, 0.0000, 0.0000, 0.0000, 250.0000); //wall053
    SetObjectMaterial(g_Object[116], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[117] = CreateObject(19357, 1037.9265, -999.4271, 39.5680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[117], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[118] = CreateObject(19357, 1037.9365, -1002.1472, 39.5680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[118], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[119] = CreateObject(19357, 1034.5456, -996.5570, 39.5680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[119], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[120] = CreateObject(19434, 1035.2541, -1001.2899, 39.5806, 0.0000, 0.0000, 90.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[120], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[121] = CreateObject(19434, 1033.8133, -1001.2800, 39.5806, 0.0000, 0.0000, 90.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[121], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[122] = CreateObject(2612, 1037.7873, -996.1751, 39.6888, 0.0000, 0.0000, -90.0000, 75.0000); //POLICE_NB2
    SetObjectMaterial(g_Object[122], 0, 10439, "hashblock3_sfs", "dt_road_to_alley", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[122], 1, 10439, "hashblock3_sfs", "ws_hs_awning", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[122], 2, 14654, "ab_trukstpe", "bbar_sports1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[122], 3, 13598, "destructo", "knifeAfterDark", 0xFFFFFFFF);
    g_Object[123] = CreateObject(19357, 1036.3363, -996.2263, 41.3582, 0.0000, 90.0000, 0.0000, 250.0000); //wall005
    SetObjectMaterial(g_Object[123], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[124] = CreateObject(19357, 1036.3363, -999.4362, 41.3582, 0.0000, 90.0000, 0.0000, 250.0000); //wall005
    SetObjectMaterial(g_Object[124], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[125] = CreateObject(19434, 1036.3745, -1002.9710, 41.3507, 0.0000, 90.0000, 0.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[125], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[126] = CreateObject(19434, 1036.3745, -1001.3698, 41.3507, 0.0000, 90.0000, 0.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[126], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[127] = CreateObject(19434, 1033.8352, -1002.0203, 41.3507, 0.0000, 90.0000, 90.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[127], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[128] = CreateObject(1491, 1034.3553, -1009.1392, 36.0984, 0.0000, 0.0000, 90.0000, 75.0000); //Gen_doorINT01
    SetObjectMaterial(g_Object[128], 0, 17933, "carter_mainmap", "mp_apt1_brokedoor", 0xFFFFFFFF);
    g_Object[129] = CreateObject(1491, 1035.4648, -994.7089, 37.8483, 0.0000, 0.0000, 0.0000, 75.0000); //Gen_doorINT01
    SetObjectMaterial(g_Object[129], 0, 17933, "carter_mainmap", "mp_apt1_brokedoor", 0xFFFFFFFF);
    g_Object[130] = CreateObject(19357, 1035.9659, -1005.3582, 36.0181, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[130], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[131] = CreateObject(19434, 1038.2546, -1011.5208, 37.9509, 0.0000, 0.0000, 90.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[131], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[132] = CreateObject(19434, 1035.2523, -1006.8809, 37.8208, 0.0000, 0.0000, 90.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[132], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[133] = CreateObject(19790, 1038.4361, -1004.1362, 31.2458, 0.0000, 0.0000, 90.0000, 75.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[133], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[134] = CreateObject(19790, 1036.9448, -1009.1162, 31.2458, 0.0000, 0.0000, 90.0000, 75.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[134], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[135] = CreateObject(19405, 1036.0478, -1011.5172, 37.9513, 0.0000, 0.0000, 90.0000, 250.0000); //wall053
    SetObjectMaterial(g_Object[135], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[136] = CreateObject(19393, 1034.3840, -1008.3980, 37.8269, 0.0000, 0.0000, 0.0000, 250.0000); //wall041
    SetObjectMaterial(g_Object[136], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[137] = CreateObject(19434, 1034.4144, -1010.7905, 37.8008, 0.0000, 0.0000, 0.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[137], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[138] = CreateObject(14877, 1037.3962, -1005.1942, 35.7453, 0.0000, 0.0000, 90.0000, 75.0000); //michelle-stairs
    g_Object[139] = CreateObject(19434, 1037.4956, -1005.2078, 41.2621, 0.0000, 87.5000, 90.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[139], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[140] = CreateObject(19434, 1036.6960, -1005.2083, 41.2719, 0.0000, 87.5000, 90.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[140], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[141] = CreateObject(19357, 1036.1158, -1008.3953, 39.5881, 0.0000, 90.0000, 0.0000, 250.0000); //wall005
    SetObjectMaterial(g_Object[141], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[142] = CreateObject(19434, 1036.1175, -1010.7894, 39.6142, 0.0000, 90.0000, 0.0000, 250.0000); //wall074
    SetObjectMaterial(g_Object[142], 0, 3555, "comedhos1_la", "comptroof3", 0xFFFFFFFF);
    g_Object[143] = CreateObject(2559, 1034.1540, -1004.0878, 39.0996, 0.0000, 0.0000, 0.0000, 75.0000); //CURTAIN_1_OPEN
    SetObjectMaterial(g_Object[143], 0, 3653, "beachapts_lax", "comptcowind1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[143], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[144] = CreateObject(19790, 1029.9311, -1005.8054, 30.8162, -15.0000, 0.0000, 90.0000, 250.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[144], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[145] = CreateObject(1464, 1031.6241, -1002.7655, 37.3320, 0.0000, 0.0000, 0.0000, 250.0000); //DYN_SCAFFOLD_3
    SetObjectMaterial(g_Object[145], 0, 18081, "cj_barb", "ab_panel_woodgrime", 0xFFFFFFFF);
    g_Object[146] = CreateObject(1819, 1035.1307, -999.6104, 37.8431, 0.0000, 0.0000, 41.0998, 75.0000); //COFFEE_SWANK_4
    SetObjectMaterial(g_Object[146], 0, 18058, "mp_diner2", "mp_diner_table", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[146], 1, 11100, "bendytunnel_sfse", "blackmetal", 0xFFFFFFFF);
    g_Object[147] = CreateObject(2559, 1035.1051, -1003.3472, 39.0996, 0.0000, 0.0000, 180.0000, 75.0000); //CURTAIN_1_OPEN
    SetObjectMaterial(g_Object[147], 0, 3653, "beachapts_lax", "comptcowind1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[147], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[148] = CreateObject(2558, 1033.4447, -1001.8654, 39.0410, 0.0000, 0.0000, 90.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[148], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[148], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[149] = CreateObject(2558, 1032.7137, -1000.8449, 39.0410, 0.0000, 0.0000, -90.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[149], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[149], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[150] = CreateObject(2558, 1035.5643, -1004.8347, 39.0410, 0.0000, 0.0000, -90.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[150], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[150], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[151] = CreateObject(2558, 1036.3050, -1005.9456, 39.0410, 0.0000, 0.0000, 90.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[151], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[151], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[152] = CreateObject(2558, 1036.6053, -1011.1259, 37.4710, 0.0000, 0.0000, 180.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[152], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[152], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[153] = CreateObject(2558, 1035.5748, -1011.8662, 37.4710, 0.0000, 0.0000, 0.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[153], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[153], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[154] = CreateObject(19357, 1037.9365, -1005.3568, 39.5680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[154], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[155] = CreateObject(19357, 1037.9365, -1005.3568, 36.0680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[155], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[156] = CreateObject(19357, 1037.9365, -1008.5667, 37.9882, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[156], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[157] = CreateObject(19434, 1037.9343, -1010.8104, 37.9509, 0.0000, 0.0000, 0.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[157], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[158] = CreateObject(1795, 1034.4504, -1010.1550, 36.2672, 0.0000, 0.0000, -90.0000, 75.0000); //SWANK_BED_2
    SetObjectMaterial(g_Object[158], 0, 2988, "kcomp_gx", "kmwood_gate", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[158], 1, 1738, "cjtemp", "CJ_bed1", 0xFFFFFFFF);
    g_Object[159] = CreateObject(2833, 1035.6042, -1009.3585, 36.2723, 0.0000, 0.5999, -0.7997, 75.0000); //gb_livingrug02
    g_Object[160] = CreateObject(2060, 1037.6540, -1010.6881, 36.7947, -151.1000, 0.0000, -95.2994, 75.0000); //CJ_SANDBAG
    SetObjectMaterial(g_Object[160], 0, 14802, "lee_bdupsflat", "Bdup_Pillow", 0xFFFFFFFF);
    g_Object[161] = CreateObject(2096, 1035.5648, -1007.8552, 36.1697, 2.9000, 0.0000, -156.5000, 75.0000); //CJ_RockingChair
    SetObjectMaterial(g_Object[161], 0, 1407, "break_f_w", "CJ_GREENWOOD", 0xFFFFFFFF);
    g_Object[162] = CreateObject(2158, 1037.3955, -1008.8720, 35.3399, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_KITCH1_L
    SetObjectMaterial(g_Object[162], 0, 5042, "bombshop_las", "shutterclosed_law", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[162], 1, 3374, "ce_farmxref", "sw_barndoor1", 0xFFFFFFFF);
    g_Object[163] = CreateObject(2607, 1035.4786, -1007.3806, 36.6421, 0.0000, 0.0000, 180.0000, 75.0000); //POLCE_DESK2
    SetObjectMaterial(g_Object[163], 0, 642, "canopy", "wood02", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[163], 2, 642, "canopy", "wood02", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[163], 3, 642, "canopy", "wood02", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[163], 4, 6282, "beafron2_law2", "boardwalk2_la", 0xFFFFFFFF);
    g_Object[164] = CreateObject(2611, 1035.3066, -1007.0197, 37.7262, 0.0000, 0.0000, 0.0000, 75.0000); //POLICE_NB1
    SetObjectMaterial(g_Object[164], 0, 16640, "a51", "Metalox64", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[164], 2, 1355, "break_s_bins", "CJ_WOOD_DARK", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[164], 3, 10713, "gayclub_sfs", "CJ_GEN_GLASS2", 0xFFFFFFFF);
    g_Object[165] = CreateObject(1744, 1038.0145, -1009.9359, 37.4281, 0.0000, 0.0000, -90.0000, 75.0000); //MED_SHELF
    SetObjectMaterial(g_Object[165], 0, 1453, "break_farm", "CJ_DarkWood", 0xFFFFFFFF);
    g_Object[166] = CreateObject(3431, 1035.6800, -1005.8499, 38.3498, 0.0000, 0.0000, 0.0000, 250.0000); //vgsclubox01
    SetObjectMaterial(g_Object[166], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[167] = CreateObject(3431, 1032.8354, -1002.3095, 38.3534, 0.0000, 0.0000, 0.0000, 250.0000); //vgsclubox01
    SetObjectMaterial(g_Object[167], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[168] = CreateObject(19790, 1033.4432, -1014.1168, 31.2660, 0.0000, 0.0000, 90.0000, 250.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[168], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[169] = CreateObject(3431, 1035.6855, -1004.5695, 38.3534, 0.0000, 0.0000, 0.0000, 250.0000); //vgsclubox01
    SetObjectMaterial(g_Object[169], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[170] = CreateObject(19790, 1038.4134, -1014.1168, 31.2660, 0.0000, 0.0000, 90.0000, 250.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[170], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[171] = CreateObject(2558, 1037.4165, -1006.4174, 39.9309, 0.0000, 0.0000, 180.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[171], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[171], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[172] = CreateObject(2558, 1036.4853, -1007.3178, 39.9309, 0.0000, 0.0000, 0.0000, 75.0000); //CURTAIN_1_CLOSED
    SetObjectMaterial(g_Object[172], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[172], 1, 14383, "burg_1", "curtain_sink2", 0xFFFFFFFF);
    g_Object[173] = CreateObject(2120, 1034.1977, -1001.7019, 38.5097, 0.0000, 0.0000, 176.8997, 75.0000); //MED_DIN_CHAIR_4
    SetObjectMaterial(g_Object[173], 0, 1738, "cjtemp", "cj_Mattress5", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[173], 1, 18081, "cj_barb", "ab_panel_woodgrime", 0xFFFFFFFF);
    g_Object[174] = CreateObject(2120, 1036.4110, -1001.6281, 38.5097, 0.0000, 0.0000, 33.9995, 75.0000); //MED_DIN_CHAIR_4
    SetObjectMaterial(g_Object[174], 0, 1738, "cjtemp", "cj_Mattress2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[174], 1, 18081, "cj_barb", "ab_panel_woodgrime", 0xFFFFFFFF);
    g_Object[175] = CreateObject(19325, 1034.6394, -998.0371, 39.2140, 0.0000, 0.0000, 0.0000, 75.0000); //lsmall_window01
    SetObjectMaterial(g_Object[175], 0, 18028, "cj_bar2", "CJ_nastybar_D3", 0x99FFFFFF);
    g_Object[176] = CreateObject(19357, 1034.6551, -1001.2968, 37.2680, 0.0000, 0.0000, 90.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[176], 0, 3193, "cxref_desert", "sw_woodslat01", 0xFFFFFFFF);
    g_Object[177] = CreateObject(19434, 1034.5439, -995.4191, 39.5606, 0.0000, 0.0000, 0.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[177], 0, 10434, "hashblock2b_sfs", "ws_haight2top", 0xFFFFFFFF);
    g_Object[178] = CreateObject(2160, 1034.1075, -1003.2899, 37.8263, 0.0000, 0.0000, 180.0000, 75.0000); //CJ_K6_LOW_UNIT3
    g_Object[179] = CreateObject(2157, 1035.4664, -1003.2910, 37.8297, 0.0000, 0.0000, 180.0000, 75.0000); //CJ_K6_LOW_UNIT2
    g_Object[180] = CreateObject(19916, 1037.7003, -1003.1510, 37.7933, 0.0000, 0.0000, -114.1996, 75.0000); //CutsceneFridge1
    SetObjectMaterial(g_Object[180], 0, 14495, "sweetshall", "mp_cooker1", 0xFFFFFFFF);
    g_Object[181] = CreateObject(2631, 1035.9458, -998.5111, 37.8314, 0.0000, 0.0000, -91.0998, 75.0000); //gym_mat1
    SetObjectMaterial(g_Object[181], 0, 14801, "lee_bdupsmain", "ahomcarpet", 0xFFFFFFFF);
    g_Object[182] = CreateObject(19915, 1033.5356, -1001.6848, 37.8353, 0.0000, 0.0000, 0.0000, 75.0000); //CutsceneCooker1
    SetObjectMaterial(g_Object[182], 3, 14495, "sweetshall", "mp_cooker1", 0xFFFFFFFF);
    g_Object[183] = CreateObject(1744, 1035.7738, -1001.2036, 39.0153, 180.0000, 0.0000, 180.0000, 75.0000); //MED_SHELF
    SetObjectMaterial(g_Object[183], 0, 3063, "col_wall1x", "ab_wood1", 0xFFFFFFFF);
    g_Object[184] = CreateObject(2833, 1034.4090, -1002.5427, 37.8451, 0.0000, 0.5999, -5.2999, 75.0000); //gb_livingrug02
    SetObjectMaterial(g_Object[184], 0, 15048, "labigsave", "AH_carpet4kb", 0xFFFFFFFF);
    g_Object[185] = CreateObject(1761, 1037.3454, -997.4655, 37.8361, 0.0000, 0.0000, -90.0000, 75.0000); //SWANK_COUCH_2
    SetObjectMaterial(g_Object[185], 0, 8534, "tikimotel", "sa_wood04_128", 0xFFBDBEC6);
    SetObjectMaterial(g_Object[185], 1, 14533, "pleas_dome", "ab_carpethexi", 0xFF8E8C46);
    g_Object[186] = CreateObject(1762, 1035.1136, -997.4212, 37.8577, 0.0000, 0.0000, 50.5998, 75.0000); //SWANK_SINGLE_2
    SetObjectMaterial(g_Object[186], 0, 8534, "tikimotel", "sa_wood04_128", 0xFFBDBEC6);
    SetObjectMaterial(g_Object[186], 1, 14533, "pleas_dome", "ab_carpethexi", 0xFF8E8C46);
    g_Object[187] = CreateObject(1786, 1034.7209, -999.0181, 38.3348, 0.0000, 0.0000, 90.0000, 75.0000); //SWANK_TV_4
    SetObjectMaterial(g_Object[187], 1, 15042, "svsfsm", "chin_carp2", 0xFF788222);
    g_Object[188] = CreateObject(2047, 1034.6529, -998.5916, 39.9771, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FLAG1
    SetObjectMaterial(g_Object[188], 0, 10355, "haight1_sfs", "ws_hashbanner", 0xFFFFFFFF);
    g_Object[189] = CreateObject(19393, 1036.2425, -994.7086, 39.5699, 0.0000, 0.0000, 90.0000, 75.0000); //wall041
    SetObjectMaterial(g_Object[189], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[190] = CreateObject(19357, 1037.9265, -996.2269, 39.5680, 0.0000, 0.0000, 0.0000, 75.0000); //wall005
    SetObjectMaterial(g_Object[190], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[191] = CreateObject(19393, 1037.0443, -1001.0855, 39.5666, 0.0000, 0.0000, 90.0000, 75.0000); //wall041
    SetObjectMaterial(g_Object[191], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[192] = CreateObject(19434, 1035.4742, -1001.0797, 39.5405, 0.0000, 0.0000, 90.0000, 75.0000); //wall074
    SetObjectMaterial(g_Object[192], 0, 10434, "hashblock2b_sfs", "ws_apartmentgrn2", 0xFFFFFFFF);
    g_Object[193] = CreateObject(19393, 1037.0443, -1001.2758, 39.5666, 0.0000, 0.0000, 90.0000, 75.0000); //wall041
    SetObjectMaterial(g_Object[193], 0, 5444, "chicano10_lae", "comptwall15", 0xFFFFFFFF);
    g_Object[194] = CreateObject(2238, 1037.1512, -996.9602, 38.2667, 0.0000, 0.0000, 0.0000, 75.0000); //CJ_LAVA_LAMP
    g_Object[195] = CreateObject(19327, 1037.7832, -999.7551, 39.8652, 0.0000, 4.9998, -90.0000, 75.0000); //7_11_sign02
    SetObjectMaterial(g_Object[195], 0, 4833, "airprtrunway_las", "homies_1", 0xFFFFFFFF);
    g_Object[196] = CreateObject(2329, 1036.5378, -999.6964, 37.8175, 0.0000, 0.0000, 146.8000, 75.0000); //LOW_CABINET_1_L
    SetObjectMaterial(g_Object[196], 0, 19598, "sfbuilding1", "darkwood1", 0xFFFFFFFF);
    g_Object[197] = CreateObject(2102, 1035.1496, -999.8297, 40.1029, 0.0000, 0.0000, 157.6999, 75.0000); //LOW_HI_FI_2
    g_Object[198] = CreateObject(948, 1035.2130, -1000.0197, 38.5726, 0.0000, 0.0000, -175.1999, 75.0000); //Plant_Pot_10
    SetObjectMaterial(g_Object[198], 2, 3261, "grasshouse", "veg_marijuana", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[198], 3, 3922, "bistro", "StainedGlass", 0xFFFFFFFF);
    g_Object[199] = CreateObject(19621, 1035.5655, -1000.1112, 38.7821, 0.0000, 0.0000, 79.6996, 75.0000); //OilCan1
    SetObjectMaterial(g_Object[199], 0, 13060, "ce_fact01", "glassblock_law", 0xFFFFFFFF);
    g_Object[200] = CreateObject(1623, 1035.4211, -994.7858, 40.9855, 0.0000, 0.0000, -90.0000, 250.0000); //nt_aircon3_01
    g_Object[201] = CreateObject(914, 1036.6385, -1006.8527, 40.4522, 0.0000, 0.0000, 0.0000, 75.0000); //GRILL
    g_Object[202] = CreateObject(914, 1037.2292, -1006.8527, 40.4522, 0.0000, 0.0000, 0.0000, 75.0000); //GRILL
    g_Object[203] = CreateObject(19790, 1023.8684, -1005.8054, 30.0361, 0.0000, 0.0000, 90.0000, 250.0000); //Cube5mx5m
    SetObjectMaterial(g_Object[203], 0, 5149, "lasground2_las2", "driveway4_128", 0xFFFFFFFF);
    g_Object[204] = CreateObject(638, 1278.4460, -886.2221, 42.5689, 0.0000, 0.0000, 96.0000, 250.0000); //kb_planter+bush
    SetObjectMaterial(g_Object[204], 0, 3455, "vgnhseblk1", "vnghse1_256", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[204], 1, 4992, "airportdetail", "sm_Agave_1", 0xFFFFFFFF);
    g_Object[205] = CreateObject(8645, 1229.3929, -891.1118, 43.6599, 0.0000, 0.0000, -80.5998, 250.0000); //shbbyhswall01_lvs
    SetObjectMaterial(g_Object[205], 0, 3455, "vgnhseblk1", "vnghse1_256", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[205], 1, 3455, "vgnhseblk1", "vnghse1_256", 0xFFFFFFFF);
    g_Object[206] = CreateObject(10444, 1001.8233, -1010.4235, 41.3521, 0.0000, 0.0000, 0.0000, 100.0000); //poolwater_SFS
    g_Object[207] = CreateObject(8658, 1149.9575, -1305.8039, 13.4926, 0.0000, 0.0000, 180.0000, 300.0000); //shabbyhouse11_lvs
    SetObjectMaterial(g_Object[207], 0, 9524, "blokmodb", "Bow_Grimebrick", 0xFFFFFFFF);
    g_Object[208] = CreateObject(996, 1162.4388, -1290.9465, 13.2454, 0.0000, 0.0000, 0.7997, 250.0000); //lhouse_barrier1
    SetObjectMaterial(g_Object[208], 0, 17547, "eastbeach4a_lae2", "bluestucco1", 0xFFFFFFFF);
    g_Object[209] = CreateObject(8658, 1164.9176, -1384.9654, 13.4926, 0.0000, 0.0000, 90.0000, 300.0000); //shabbyhouse11_lvs
    SetObjectMaterial(g_Object[209], 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    g_Object[210] = CreateObject(19449, 989.6657, -1264.1379, 14.2038, 0.0000, 0.0000, 0.0000, 100.0000); //wall089
    SetObjectMaterial(g_Object[210], 0, 5461, "glenpark6d_lae", "shutter01LA", 0xAAFFFFFF);
    g_Object[211] = CreateObject(19449, 989.6657, -1254.5383, 14.2038, 0.0000, 0.0000, 0.0000, 100.0000); //wall089
    SetObjectMaterial(g_Object[211], 0, 6282, "beafron2_law2", "shutter03LA", 0xAAFFFFFF);
    g_Object[212] = CreateObject(19449, 989.4660, -1262.6577, 15.4039, 0.0000, 0.0000, 0.0000, 100.0000); //wall089
    SetObjectMaterial(g_Object[212], 0, 10838, "airwelcomesign_sfse", "sl_rustyrailing", 0xFFFFFFFF);
    g_Object[213] = CreateObject(19449, 989.4660, -1253.0377, 15.4039, 0.0000, 0.0000, 0.0000, 100.0000); //wall089
    SetObjectMaterial(g_Object[213], 0, 10838, "airwelcomesign_sfse", "sl_rustyrailing", 0xFFFFFFFF);
    g_Object[214] = CreateObject(19479, 976.2166, -1250.9759, 20.7896, 0.0000, 0.0000, -90.0000, 150.0000); //Plane005
    SetObjectMaterial(g_Object[214], 0, 17526, "eastls1_lae2", "comptsign1_LAe", 0xFFFFFFFF);
    g_Object[215] = CreateObject(2991, 992.9954, -1255.1894, 14.0472, 0.0000, 0.0000, 91.3999, 75.0000); //imy_bbox
    SetObjectMaterial(g_Object[215], 1, 17526, "eastls1_lae2", "comptsign3_LAe", 0xFFFFFFFF);
    g_Object[216] = CreateObject(1339, 990.1375, -1268.5415, 14.6646, 0.0000, 0.0000, 0.6998, 75.0000); //BinNt09_LA
    SetObjectMaterial(g_Object[216], 0, 1328, "labins01_la", "bins7_LAe2", 0xFFFFFFFF);
    g_Object[217] = CreateObject(18262, 992.9671, -1254.4366, 14.7214, -2.2000, 0.0000, 0.0000, 120.0000); //cw2_phroofstuf
    SetObjectMaterial(g_Object[217], 0, 3080, "adjumpx", "planks64", 0xFF9F9D94);
    SetObjectMaterial(g_Object[217], 1, 1245, "newramp", "craneblnk_128", 0xFFFFFFFF);
    g_Object[218] = CreateObject(19325, 992.9348, -1248.8835, 16.7070, 0.0000, 0.0000, -90.0000, 100.0000); //lsmall_window01
    SetObjectMaterial(g_Object[218], 0, 5785, "melrosetr1_lawn", "blob1_LAwN", 0xFF9EA4AB);
    g_Object[219] = CreateObject(1709, 997.9243, -1262.8967, 14.0115, 0.0000, 0.0000, -90.0000, 75.0000); //kb_couch08
    g_Object[220] = CreateObject(2405, 989.8745, -1258.1816, 15.2123, -8.3999, 0.0000, 90.0000, 75.0000); //CJ_SURF_BOARD2
    SetObjectMaterial(g_Object[220], 0, 1453, "break_farm", "CJ_DarkWood", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[220], 1, 18028, "cj_bar2", "CJ_nastybar_D", 0xFFFFFFFF);
    g_Object[221] = CreateObject(2405, 989.8745, -1259.3830, 15.2123, -8.3999, 0.0000, 86.4000, 75.0000); //CJ_SURF_BOARD2
    SetObjectMaterial(g_Object[221], 0, 1453, "break_farm", "CJ_DarkWood", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[221], 1, 18028, "cj_bar2", "CJ_nastybar_D4", 0xFFFFFFFF);
    g_Object[222] = CreateObject(19878, 993.3079, -1252.2390, 14.8315, 0.0000, 0.0000, 100.3999, 75.0000); //Skateboard1
    SetObjectMaterial(g_Object[222], 0, 18028, "cj_bar2", "CJ_nastybar_D3", 0xFFFFFFFF);
    g_Object[223] = CreateObject(19878, 992.6898, -1256.6252, 14.8315, 0.0000, 0.0000, 33.0000, 75.0000); //Skateboard1
    SetObjectMaterial(g_Object[223], 0, 18028, "cj_bar2", "CJ_nastybar_D2", 0xFFFFFFFF);
    g_Object[224] = CreateObject(2032, 983.9835, -1276.8060, 14.1077, 0.0000, 0.0000, 0.0000, 75.0000); //MED_DINNING_2
    SetObjectMaterial(g_Object[224], 0, 14825, "genintint2_gym", "plywood3_gym", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[224], 1, 2343, "cb_bar_bits", "CJ_POLISHED", 0xFF989586);
    g_Object[225] = CreateObject(1811, 983.0258, -1276.8927, 14.7206, 0.0000, 0.0000, -90.0000, 75.0000); //MED_DIN_CHAIR_5
    SetObjectMaterial(g_Object[225], 0, 3586, "la_props1", "shutters2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[225], 1, 6282, "beafron2_law2", "shutter03LA", 0xFFFFFFFF);
    g_Object[226] = CreateObject(1811, 986.0767, -1276.8509, 14.7206, 0.0000, 0.0000, -65.3999, 75.0000); //MED_DIN_CHAIR_5
    SetObjectMaterial(g_Object[226], 0, 3586, "la_props1", "shutters2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[226], 1, 6282, "beafron2_law2", "shutter03LA", 0xFFFFFFFF);
    g_Object[228] = CreateObject(19479, 991.3792, -1277.3103, 14.1723, 0.0000, 0.0000, 90.0000, 100.0000); //Plane005
    SetObjectMaterial(g_Object[228], 0, 5390, "glenpark7_lae", "ganggraf01_LA", 0xFFFFFFFF);
    g_Object[229] = CreateObject(365, 1020.2321, -1245.0351, 14.2706, 0.0000, 90.0000, 0.0000, 40.0000); //spraycan
    g_Object[230] = CreateObject(1216, 1017.1400, -1310.5239, 13.1843, 0.0000, 0.0000, 0.0000, 100.0000); //phonebooth1
    g_Object[232] = CreateObject(19339, 885.8590, -1077.4266, 22.4689, 0.0000, 0.0000, 180.0000, 75.0000); //coffin01
    g_Object[233] = CreateObject(2790, 931.7614, -1095.2445, 25.3659, 0.0000, 0.0000, 0.0000, 100.0000); //CJ_ARRIVE_BOARD
    SetObjectMaterial(g_Object[233], 1, 10442, "graveyard_sfs", "ws_memorial", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[233], 2, 914, "industrialext", "CJ_VENT1", 0xFFFFFFFF);
    g_Object[234] = CreateObject(5777, 888.3134, -1077.3940, 23.8567, 0.0000, 0.0000, 0.0000, 100.0000); //tombston01_LAwN
    g_Object[235] = CreateObject(2660, 885.8848, -1077.4886, 22.8603, -90.0000, 0.0000, -39.0000, 75.0000); //CJ_BANNER06
    SetObjectMaterial(g_Object[235], 0, 14387, "dr_gsnew", "mp_flowerbush", 0xFFFFFFFF);
    g_Object[236] = CreateObject(10985, 888.3333, -1076.7197, 21.5876, 0.0000, 4.7999, 0.0000, 75.0000); //rubbled02_SFS
    SetObjectMaterial(g_Object[236], 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFFFFFFF);
    g_Object[237] = CreateObject(2739, 929.1920, -1094.8608, 23.9710, 180.0000, 0.0000, 0.0000, 75.0000); //CJ_B_SINK1
    SetObjectMaterial(g_Object[237], 0, 3440, "airportpillar", "metalic_64", 0xFFFFFFFF);
    g_Object[238] = CreateObject(2739, 933.3123, -1094.8608, 23.9710, 180.0000, 0.0000, 0.0000, 75.0000); //CJ_B_SINK1
    SetObjectMaterial(g_Object[238], 0, 3440, "airportpillar", "metalic_64", 0xFFFFFFFF);
    g_Object[239] = CreateObject(869, 928.7935, -1095.9477, 23.6217, 0.0000, 0.0000, 0.0000, 100.0000); //veg_Pflowerswee
    g_Object[240] = CreateObject(869, 933.7932, -1095.5876, 23.6217, 0.0000, 0.0000, 26.6000, 100.0000); //veg_Pflowerswee
    g_Object[241] = CreateObject(3630, 1156.5959, -1304.0605, 13.9848, 0.0000, 0.0000, 90.0000, 300.0000); //crdboxes2_LAs
    SetObjectMaterial(g_Object[241], 0, 12821, "alleystuff", "cratec", 0xFFFFFFFF);
    g_Object[242] = CreateObject(996, 1177.8586, -1290.7839, 13.2454, 0.0000, 0.0000, 0.5999, 250.0000); //lhouse_barrier1
    SetObjectMaterial(g_Object[242], 0, 17547, "eastbeach4a_lae2", "bluestucco1", 0xFFFFFFFF);
    g_Object[243] = CreateObject(1845, 1839.6175, -1847.6728, 180.0000, 0.0000, 0.0000, 0.0000, 100.0000); //shop_shelf10
    g_Object[244] = CreateObject(2807, 1031.9643, -1344.7082, 13.2391, 0.0000, 0.0000, 126.0000, 75.0000); //CJ_BURG_CHAIR_NA
    SetObjectMaterial(g_Object[244], 1, 19517, "noncolored", "bowlerwhite", 0xFFFFFFFF);
    g_Object[245] = CreateObject(2449, 1034.1123, -1340.6096, 12.6660, 0.0000, 0.0000, 180.0000, 75.0000); //CJ_FF_CONTER_5e
    g_Object[246] = CreateObject(2448, 1034.1191, -1343.8828, 12.6778, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_CONTER_5d
    g_Object[247] = CreateObject(2446, 1031.9593, -1343.6490, 12.6913, 0.0000, 0.0000, 0.0000, 75.0000); //CJ_FF_CONTER_5
    g_Object[248] = CreateObject(2447, 1033.9077, -1346.3319, 12.6976, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_CONTER_5c
    g_Object[249] = CreateObject(2457, 1034.0069, -1350.5820, 12.7137, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_CONTER_8c
    SetObjectMaterial(g_Object[249], 4, 2772, "airp_prop", "CJ_red_COUNTER", 0xFFFFFFFF);
    g_Object[250] = CreateObject(2586, 1034.0251, -1347.9803, 13.2156, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_SEX_COUNTER2
    SetObjectMaterial(g_Object[250], 1, 2772, "airp_prop", "CJ_red_COUNTER", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[250], 2, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[250], 7, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
    g_Object[251] = CreateObject(2665, 1031.0433, -1351.7329, 15.2875, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_LIST04
    SetObjectMaterial(g_Object[251], 0, 2221, "donut_tray", "rustycoffeerap_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[251], 1, 2059, "cj_ammo2", "cj_don_post_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[251], 2, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[251], 3, 2432, "cj_don_sign", "cj_don_post_3", 0xFFFFFFFF);
    g_Object[252] = CreateObject(2586, 1034.0251, -1352.2419, 13.2156, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_SEX_COUNTER2
    SetObjectMaterial(g_Object[252], 1, 2772, "airp_prop", "CJ_red_COUNTER", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[252], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[252], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[252], 7, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
    g_Object[253] = CreateObject(2682, 1033.9885, -1347.0152, 13.8922, 0.0000, 0.0000, 0.0000, 45.0000); //PIZZA_MENU
    SetObjectMaterial(g_Object[253], 0, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    g_Object[254] = CreateObject(2665, 1031.0433, -1348.1728, 15.2875, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_LIST04
    SetObjectMaterial(g_Object[254], 0, 18021, "genintintfastd", "CJ_DON_WIN", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[254], 1, 2059, "cj_ammo2", "cj_don_post_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[254], 2, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[254], 3, 2432, "cj_don_sign", "cj_don_post_3", 0xFFFFFFFF);
    g_Object[255] = CreateObject(2753, 1034.0395, -1348.7237, 13.9209, 0.0000, 0.0000, 90.0000, 45.0000); //CJ_FF_TILL_que
    g_Object[256] = CreateObject(2222, 1033.9884, -1350.2967, 13.6842, 0.0000, 0.0000, -1.3997, 45.0000); //rustyhigh
    SetObjectMaterial(g_Object[256], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 1, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 2, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[256], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[257] = CreateObject(2222, 1034.0052, -1349.5964, 13.6842, 0.0000, 0.0000, -1.3997, 45.0000); //rustyhigh
    SetObjectMaterial(g_Object[257], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[257], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[257], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[257], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[257], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[257], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[257], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[258] = CreateObject(2222, 1033.9967, -1349.9564, 13.6842, 0.0000, 0.0000, -1.3997, 45.0000); //rustyhigh
    SetObjectMaterial(g_Object[258], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 1, 19883, "breadslice1", "cj_bread_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 2, 2702, "pick_up", "CJ_BREAD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[258], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[259] = CreateObject(11741, 1034.0571, -1345.2319, 13.9594, 0.0000, 0.0000, 0.0000, 45.0000); //MCake3
    g_Object[260] = CreateObject(11741, 1034.0571, -1345.2325, 13.6590, 0.0000, 0.0000, 0.0000, 45.0000); //MCake3
    SetObjectMaterial(g_Object[260], 0, 19525, "weddingcake1", "weddingcake1", 0xFFFFFFFF);
    g_Object[261] = CreateObject(11741, 1034.0571, -1344.7320, 13.6590, 0.0000, 0.0000, 0.0000, 45.0000); //MCake3
    SetObjectMaterial(g_Object[261], 0, 19525, "weddingcake1", "bngdecoration1", 0xFFFFFFFF);
    g_Object[262] = CreateObject(11741, 1034.0571, -1344.0915, 13.6590, 0.0000, 0.0000, 0.0000, 45.0000); //MCake3
    SetObjectMaterial(g_Object[262], 0, 14660, "inttattoobits", "tat_spray1", 0xFFFFFFFF);
    g_Object[263] = CreateObject(11739, 1034.0367, -1344.7270, 13.9504, 0.0000, 0.0000, 0.0000, 45.0000); //MCake1
    g_Object[264] = CreateObject(2223, 1034.0345, -1346.3287, 14.0410, 0.0000, 0.0000, 0.0000, 45.0000); //rustymed
    g_Object[265] = CreateObject(11739, 1034.0367, -1344.1064, 13.9504, 0.0000, 0.0000, 0.0000, 45.0000); //MCake1
    SetObjectMaterial(g_Object[265], 0, 19517, "noncolored", "wmoice", 0xFFFFFFFF);
    g_Object[266] = CreateObject(2223, 1034.0355, -1346.2884, 13.7412, 0.0000, 0.0000, -1.3997, 45.0000); //rustymed
    g_Object[267] = CreateObject(2027, 1037.7762, -1346.0592, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[267], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[267], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[267], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[267], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[267], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[268] = CreateObject(19939, 1036.7724, -1353.3430, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[268], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[269] = CreateObject(19939, 1036.7724, -1350.9012, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[269], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[270] = CreateObject(2027, 1037.7762, -1353.3818, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[270], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[270], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[270], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[270], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[270], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[271] = CreateObject(2027, 1037.7762, -1350.9404, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[271], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[271], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[271], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[271], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[271], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[272] = CreateObject(2027, 1037.7762, -1348.4996, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[272], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[272], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[272], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[272], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[272], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[273] = CreateObject(19939, 1036.7724, -1348.4593, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[273], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[274] = CreateObject(19939, 1036.7724, -1346.0384, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[274], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[275] = CreateObject(1775, 1034.8243, -1355.2248, 13.8118, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_SPRUNK1
    g_Object[276] = CreateObject(1776, 1034.7491, -1356.4172, 13.8135, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_CANDYVENDOR
    g_Object[277] = CreateObject(2027, 1040.7364, -1344.1595, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[277], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[277], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[277], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[277], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[277], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[278] = CreateObject(2027, 1040.7364, -1347.1411, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[278], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[278], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[278], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[278], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[278], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[279] = CreateObject(2027, 1040.7364, -1350.1628, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[279], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[279], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[279], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[279], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[279], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[280] = CreateObject(2027, 1040.7364, -1353.1643, 13.2810, 0.0000, 0.0000, 90.0000, 75.0000); //dinerseat_4
    SetObjectMaterial(g_Object[280], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[280], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[280], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[280], 4, 14652, "ab_trukstpa", "CJ_CORD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[280], 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    g_Object[281] = CreateObject(19939, 1041.7346, -1353.1428, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[281], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[282] = CreateObject(19939, 1041.7346, -1350.1599, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[282], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[283] = CreateObject(19939, 1041.7346, -1347.0981, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[283], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[284] = CreateObject(19939, 1041.7346, -1344.1368, 13.5635, 0.0000, 0.0000, 0.0000, 45.0000); //MKShelf2
    SetObjectMaterial(g_Object[284], 0, 18021, "genintintfastd", "tile_test3red", 0xFFFFFFFF);
    g_Object[285] = CreateObject(2223, 1033.9746, -1340.5063, 14.0214, 0.0000, 0.0000, 90.0000, 45.0000); //rustymed
    g_Object[286] = CreateObject(2223, 1032.9538, -1340.5063, 14.0214, 0.0000, 0.0000, 90.0000, 45.0000); //rustymed
    g_Object[287] = CreateObject(2420, 1040.5804, -1355.9228, 12.7051, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_BUCKET
    SetObjectMaterial(g_Object[287], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[287], 1, 2221, "donut_tray", "rustyside_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[287], 2, 3629, "arprtxxref_las", "rustybolts", 0xFFFFFFFF);
    g_Object[288] = CreateObject(2420, 1040.5804, -1355.9228, 12.7051, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_BUCKET
    SetObjectMaterial(g_Object[288], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[288], 1, 2221, "donut_tray", "rustyside_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[288], 2, 3629, "arprtxxref_las", "rustybolts", 0xFFFFFFFF);
    g_Object[289] = CreateObject(2420, 1040.5804, -1356.8038, 12.7051, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_BUCKET
    SetObjectMaterial(g_Object[289], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[289], 1, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[289], 2, 3629, "arprtxxref_las", "rustybolts", 0xFFFFFFFF);
    g_Object[290] = CreateObject(2417, 1031.4171, -1353.4200, 12.6027, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_COOKER
    g_Object[291] = CreateObject(2419, 1031.6947, -1346.9903, 12.6812, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_WORKTOP_2
    g_Object[292] = CreateObject(2426, 1031.2253, -1346.2943, 13.6400, 0.0000, 0.0000, 90.0000, 45.0000); //CJ_FF_PIZZA_OVEN
    g_Object[293] = CreateObject(2417, 1031.4171, -1348.1778, 12.6027, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_COOKER
    g_Object[294] = CreateObject(2419, 1031.5544, -1352.4541, 12.6812, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_WORKTOP_2
    g_Object[295] = CreateObject(2425, 1031.1052, -1345.9609, 14.0326, 0.0000, 0.0000, 90.0000, 100.0000); //CJ_FF_JUICE
    g_Object[296] = CreateObject(19835, 1031.4022, -1346.5338, 14.1154, 0.0000, 0.0000, 0.0000, 45.0000); //CoffeeCup1
    SetObjectMaterial(g_Object[296], 0, 12847, "sprunkworks", "bigsprunkcan", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[296], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[296], 2, 2976, "gloopx", "alien_liquid", 0xFFFFFFFF);
    g_Object[297] = CreateObject(19835, 1031.3044, -1346.6334, 14.1154, 0.0000, 0.0000, -48.7999, 45.0000); //CoffeeCup1
    SetObjectMaterial(g_Object[297], 0, 12847, "sprunkworks", "bigsprunkcan", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[297], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[297], 2, 2976, "gloopx", "alien_liquid", 0xFFFFFFFF);
    g_Object[298] = CreateObject(2222, 1031.2135, -1353.2910, 13.6239, 0.0000, 0.0000, -1.3997, 45.0000); //rustyhigh
    SetObjectMaterial(g_Object[298], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 1, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 2, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[298], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[299] = CreateObject(2416, 1031.5638, -1350.3702, 12.7040, 0.0000, 0.0000, 90.0000, 75.0000); //CJ_FF_DISP
    SetObjectMaterial(g_Object[299], 0, 2221, "donut_tray", "rustyside_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[299], 1, 2221, "donut_tray", "rustyside_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[299], 2, 2772, "airp_prop", "CJ_red_COUNTER", 0xFFFFFFFF);
    g_Object[300] = CreateObject(2222, 1031.3017, -1353.7159, 13.6639, 0.0000, 0.0000, 62.0000, 45.0000); //rustyhigh
    SetObjectMaterial(g_Object[300], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 1, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 2, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[300], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[301] = CreateObject(2222, 1031.4361, -1353.8581, 13.5242, 0.0000, 0.0000, 8.7999, 45.0000); //rustyhigh
    SetObjectMaterial(g_Object[301], 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 1, 2221, "donut_tray", "bagel_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 4, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 5, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 6, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 7, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[301], 8, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[302] = CreateObject(2222, 1031.4178, -1351.6711, 13.7040, 0.0000, 0.0000, -39.1999, 45.0000); //rustyhigh
    g_Object[303] = CreateObject(11743, 1031.2286, -1347.9670, 13.6133, 0.0000, 0.0000, 90.0000, 45.0000); //MCoffeeMachine1
    g_Object[304] = CreateObject(2715, 1039.0091, -1357.4238, 14.8680, 0.0000, 0.0000, 0.0000, 45.0000); //CJ_DON_POSTER
    g_Object[305] = CreateObject(19835, 1031.3021, -1348.2552, 13.6954, 0.0000, 0.0000, 0.0000, 45.0000); //CoffeeCup1
    g_Object[306] = CreateObject(2665, 1041.7237, -1351.9128, 15.2875, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_LIST04
    SetObjectMaterial(g_Object[306], 0, 2221, "donut_tray", "rustycoffeerap_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[306], 1, 2059, "cj_ammo2", "cj_don_post_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[306], 2, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[306], 3, 2432, "cj_don_sign", "cj_don_post_3", 0xFFFFFFFF);
    g_Object[307] = CreateObject(2665, 1041.7237, -1345.5909, 15.2875, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_LIST04
    SetObjectMaterial(g_Object[307], 0, 2221, "donut_tray", "rustycoffeerap_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[307], 1, 2059, "cj_ammo2", "cj_don_post_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[307], 2, 2432, "cj_don_sign", "cj_don_post_2", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[307], 3, 2432, "cj_don_sign", "cj_don_post_3", 0xFFFFFFFF);
    g_Object[308] = CreateObject(19826, 1031.5062, -1342.9138, 14.4273, 0.0000, 0.0000, 90.0000, 45.0000); //LightSwitch1
    g_Object[309] = CreateObject(2715, 1041.7705, -1348.6628, 15.2679, 0.0000, 0.0000, 90.0000, 45.0000); //CJ_DON_POSTER
    SetObjectMaterial(g_Object[309], 0, 2432, "cj_don_sign", "cj_don_post_3", 0xFFFFFFFF);
    g_Object[310] = CreateObject(1893, 1032.5494, -1344.5141, 17.3309, 0.0000, 0.0000, 0.0000, 75.0000); //shoplight1
    g_Object[311] = CreateObject(1893, 1032.5494, -1350.6761, 17.3309, 0.0000, 0.0000, 0.0000, 75.0000); //shoplight1
    g_Object[312] = CreateObject(1893, 1038.6118, -1350.6761, 17.3309, 0.0000, 0.0000, 0.0000, 75.0000); //shoplight1
    g_Object[313] = CreateObject(1893, 1038.6706, -1344.5141, 17.3309, 0.0000, 0.0000, 0.0000, 75.0000); //shoplight1
    g_Object[314] = CreateObject(2342, 1031.5854, -1353.3996, 13.7263, 0.0000, 0.0000, -98.9999, 45.0000); //donut_disp
    SetObjectMaterial(g_Object[314], 1, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[314], 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[314], 3, 19297, "matlights", "invisible", 0xFFFFFFFF);
    g_Object[315] = CreateObject(2420, 1041.2613, -1340.9012, 12.7051, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_BUCKET
    SetObjectMaterial(g_Object[315], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[315], 1, 2221, "donut_tray", "rustyside_rb", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[315], 2, 3629, "arprtxxref_las", "rustybolts", 0xFFFFFFFF);
    g_Object[316] = CreateObject(2420, 1041.2613, -1341.9621, 12.7051, 0.0000, 0.0000, -90.0000, 75.0000); //CJ_FF_BUCKET
    SetObjectMaterial(g_Object[316], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[316], 1, 2059, "cj_ammo2", "cj_don_post_1", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[316], 2, 3629, "arprtxxref_las", "rustybolts", 0xFFFFFFFF);
    g_Object[318] = CreateObject(10985, 912.3532, -1069.6422, 21.2572, 7.7999, -1.7999, 0.0000, 75.0000); //rubbled02_SFS
    SetObjectMaterial(g_Object[318], 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFFFFFFF);
    g_Object[319] = CreateObject(19339, 911.3513, -1069.0655, 22.4489, 0.0000, 0.0000, -87.0000, 75.0000); //coffin01
    g_Object[320] = CreateObject(2660, 911.2797, -1069.0743, 22.8201, -90.0000, 0.0000, 125.1996, 75.0000); //CJ_BANNER06
    SetObjectMaterial(g_Object[320], 0, 14387, "dr_gsnew", "mp_flowerbush", 0xFFFFFFFF);
    g_Object[321] = CreateObject(5777, 911.1931, -1066.6545, 24.0566, 0.0000, 0.0000, -90.0000, 100.0000); //tombston01_LAwN
    g_Object[322] = CreateObject(2042, 1247.6057, -907.3239, 45.6878, 0.0000, 0.0000, 42.2000, 100.0000); //AMMO_BOX_M3
    g_Object[323] = CreateObject(1431, 1267.5605, -876.0546, 42.3395, 0.0000, 0.0000, 97.7994, 200.0000); //DYN_BOX_PILE
    SetObjectMaterial(g_Object[323], 0, 3066, "ammotrx", "ammotrn92tarp128", 0xFFD78E10);
    g_Object[324] = CreateObject(19480, 1267.5710, -878.7000, 45.9827, 0.0000, 0.0000, 99.0000, 250.0000); //Plane006
    SetObjectMaterial(g_Object[324], 0, 17518, "hub_alpha", "clothline1_LAe", 0xFFFFFFFF);
    g_Object[325] = CreateObject(19325, 1282.9072, -895.5219, 43.7700, 0.0000, 180.0000, 6.9998, 200.0000); //lsmall_window01
    SetObjectMaterial(g_Object[325], 0, 1530, "tags_lavagos", "vagos", 0xFF000000);
    g_Object[326] = CreateObject(19325, 1264.1412, -905.9641, 41.2728, -1.5999, 180.0000, 7.3997, 200.0000); //lsmall_window01
    SetObjectMaterial(g_Object[326], 0, 1525, "tags_lakilo", "kilotray", 0xFF000000);
    g_Object[327] = CreateObject(19325, 1260.2580, -876.7677, 40.8675, 1.0000, 180.0000, 7.3997, 200.0000); //lsmall_window01
    SetObjectMaterial(g_Object[327], 0, 1528, "tags_laseville", "seville", 0xFF000000);
    g_Object[330] = CreateObject(640, 1243.4995, -890.3165, 42.5550, 0.0000, 0.0000, 97.1996, 250.0000); //kb_planter+bush2
    SetObjectMaterial(g_Object[330], 0, 3455, "vgnhseblk1", "vnghse1_256", 0xFFFFFFFF);
    g_Object[331] = CreateObject(640, 1261.6180, -888.0288, 42.5550, 0.0000, 0.0000, 97.1996, 250.0000); //kb_planter+bush2
    SetObjectMaterial(g_Object[331], 0, 3455, "vgnhseblk1", "vnghse1_256", 0xFFFFFFFF);
    g_Object[333] = CreateObject(984, 1252.5461, -889.1881, 42.4832, 0.0000, 0.0000, 97.1996, 250.0000); //fenceshit2
    SetObjectMaterial(g_Object[333], 0, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 1, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 2, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 3, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 4, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 5, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 6, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 7, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 8, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[333], 9, 5418, "idlewood3_lae", "lasjmrail1", 0xFFFFFFFF);
    g_Object[334] = CreateObject(2673, 1236.9737, -893.1527, 42.6748, 0.0000, 0.0000, 0.0000, 100.0000); //PROC_RUBBISH_5
    g_Object[335] = CreateObject(1432, 1287.3935, -898.8192, 41.9972, 0.0000, 0.0000, -36.7999, 250.0000); //DYN_TABLE_2
    SetObjectMaterial(g_Object[335], 0, 1426, "break_scaffold", "CJ_BLUE_WOOD", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[335], 1, 16640, "a51", "bluemetal", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[335], 2, 17545, "burnsground", "bluapartwall1_256", 0xFFFFFFFF);
    g_Object[336] = CreateObject(2671, 1235.2165, -891.0689, 41.8991, 0.0000, 0.0000, 46.4000, 100.0000); //PROC_RUBBISH_3
    SetObjectMaterial(g_Object[336], 0, 12871, "ce_ground01", "desgreengrassmix", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[336], 1, 2924, "crash3doorx", "villagreen128256", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[336], 2, 701, "badlands", "newtreeleaves128", 0xFFFFFFFF);
    g_Object[337] = CreateObject(869, 1233.8009, -898.2531, 42.3474, 0.0000, 0.0000, 0.0000, 250.0000); //veg_Pflowerswee
    SetObjectMaterial(g_Object[337], 0, 701, "badlands", "newtreeleaves128", 0xFFFFFFFF);
    g_Object[338] = CreateObject(876, 1231.0882, -882.0189, 42.4700, 0.0000, 0.0000, -22.6000, 250.0000); //veg_Pflowers03
    SetObjectMaterial(g_Object[338], 0, 730, "gtatreeshifir", "cedar2", 0xFFFFFFFF);
    g_Object[339] = CreateObject(638, 1294.4177, -884.2415, 42.5689, 0.0000, 0.0000, 97.5998, 250.0000); //kb_planter+bush
    SetObjectMaterial(g_Object[339], 0, 3455, "vgnhseblk1", "vnghse1_256", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[339], 1, 17848, "eastlstr2_lae2", "deadpalm01", 0xFFFFFFFF);
    g_Object[340] = CreateObject(984, 1286.3758, -885.2578, 42.5433, 0.0000, 0.0000, 97.0000, 250.0000); //fenceshit2
    SetObjectMaterial(g_Object[340], 0, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 1, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 2, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 3, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 4, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 5, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 6, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 7, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 8, 3077, "blkbrdx", "nf_blackbrd", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[340], 9, 5418, "idlewood3_lae", "lasjmrail1", 0xFFFFFFFF);
    g_Object[341] = CreateObject(8661, 1165.8039, -1320.5727, 12.5289, 0.0000, 0.0000, 0.0000, 500.0000); //gnhtelgrnd_lvs
    SetObjectMaterial(g_Object[341], 0, 4833, "airprtrunway_las", "greyground256", 0xFFFFFFFF);
    g_Object[342] = CreateObject(8661, 1155.3049, -1338.3702, 12.5689, 0.0000, 0.0000, 90.0000, 500.0000); //gnhtelgrnd_lvs
    SetObjectMaterial(g_Object[342], 0, 4833, "airprtrunway_las", "greyground256", 0xFFFFFFFF);
    g_Object[343] = CreateObject(1503, 1301.0683, -856.3416, 42.9327, 0.0000, 0.0000, -90.1996, 250.0000); //DYN_RAMP
    SetObjectMaterial(g_Object[343], 0, 916, "crates_n_stuffext", "CJ_CABLEWRAP", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[343], 1, 18787, "matramps", "grating3", 0xFFFFFFFF);
    g_Object[344] = CreateObject(1462, 1288.4576, -891.3941, 40.3861, 0.0000, 0.0000, -83.0000, 100.0000); //DYN_woodpile
    SetObjectMaterial(g_Object[344], 0, 14786, "ab_sfgymbeams", "knot_wood128", 0xFFFFFFFF);
    g_Object[345] = CreateObject(19622, 1287.7110, -876.5759, 42.6547, -13.3999, 0.0000, -25.3999, 100.0000); //Broom1
    g_Object[346] = CreateObject(1795, 1288.8072, -877.2780, 41.1016, 81.1996, 0.0000, -83.9999, 250.0000); //SWANK_BED_2
    SetObjectMaterial(g_Object[346], 0, 14534, "ab_wooziea", "CJ_WOODDOOR5", 0xFFFFFFFF);
    SetObjectMaterial(g_Object[346], 1, 1738, "cjtemp", "cj_Mattress5", 0xFFFFFFFF);
    g_Object[347] = CreateObject(1810, 1288.2353, -876.4677, 41.9710, 0.0000, 0.0000, 39.9999, 250.0000); //CJ_FOLDCHAIR
    SetObjectMaterial(g_Object[347], 0, 1355, "break_s_bins", "CJ_TABLE_TOP", 0xFFFFFFFF);
    g_Object[348] = CreateObject(2713, 1288.4493, -878.9420, 42.1100, 0.0000, 0.0000, 23.5998, 100.0000); //cj_bucket


}