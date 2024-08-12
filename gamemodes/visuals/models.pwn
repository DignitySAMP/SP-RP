// Now found in "config/modelconstants.pwn"

/*
CreateTestObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 300.0, Float:drawdistance = 300.0)
{
    streamdistance = 800.0;
    drawdistance = 800.0;

    return CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance);
}
*/


Models_AddModels() { 

    /*
        OTHER MODELS:

        sporky/sols/int/lspd
        sporky/firehose/
        sporky/sols/int/lsfd
        sporky/news/
        sporky/sirens
    */

    // Kosidian graffiti murals
    AddSimpleModel(-1,      CUSTOM_OBJECT_BASEID,       KOSIDIAN_MURAL_1,       "kosidian/mural1.dff",     "kosidian/murals.txd" );
    AddSimpleModel(-1,      CUSTOM_OBJECT_BASEID,       KOSIDIAN_MURAL_2,       "kosidian/mural2.dff",     "kosidian/murals.txd" );
    AddSimpleModel(-1,      CUSTOM_OBJECT_BASEID,       KOSIDIAN_MURAL_3,       "kosidian/mural3.dff",     "kosidian/murals.txd" );
    AddSimpleModel(-1,      CUSTOM_OBJECT_BASEID,       KOSIDIAN_MURAL_4,       "kosidian/mural4.dff",     "kosidian/murals.txd" );
    CreateDynamicObject(KOSIDIAN_MURAL_1, 2498.073974, -1413.896850, 30.790044, 0.000000, 0.000000, 0.00000, -1, 0, -1, 200.00, 200.00);
    CreateDynamicObject(KOSIDIAN_MURAL_2, 2498.260498, -1395.281127, 30.811275, 0.000000, 0.000000, 0.00000, -1, 0, -1, 200.00, 200.00);
    CreateDynamicObject(KOSIDIAN_MURAL_3, 2464.354980, -1395.276611, 30.818149, 0.000000, 0.000000, 0.00000, -1, 0, -1, 200.00, 200.00);
    CreateDynamicObject(KOSIDIAN_MURAL_4, 2464.508544, -1413.910034, 30.834453, 0.000000, 0.000000, 0.00000, -1, 0, -1, 200.00, 200.00);

    // Idlewood gas station enex 
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_ENEX_IDLEGAS, "ryhes/idlegas.dff", "ryhes/idlegas.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_ENEX_IDLEGAS_INT, "ryhes/idlegas_objects.dff",  "ryhes/idlegas_objects.txd");
    CreateObject(RYHES_ENEX_IDLEGAS, 1918.872802, -1776.312255, 17.002790, 0.000000, 0.000000, 0, 800.0);
    CreateDynamicObject(RYHES_ENEX_IDLEGAS_INT,  1924.132568, -1778.515136, 12.542808, 0.000000, 0.000000, 90.0, -1, 0, -1, 200.00, 200.00);
   
    // Idlewood 24/7 enex
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_ENEX_GANTON247, "ryhes/ganton24.dff",            "ryhes/ganton24.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, RYHES_ENEX_GANTON_INT, "ryhes/ganton24_objects.dff",            "ryhes/ganton24_objects.txd");
    CreateObject(RYHES_ENEX_GANTON247, 2450.767333, -1757.388916, 16, 0.000000, 0.000000, 0, 800.00);
    CreateDynamicObject(RYHES_ENEX_GANTON_INT, 2428.597900, -1747.966674, 12.646861, 0.000000, 0.000000, -90.0, -1, 0, -1, 200.00, 200.00); 

    // Idlewood gym enex
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID,    GANTON_GYM_1, "reyo/gymenex.dff", "reyo/gymenex.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID,    GANTON_GYM_2, "reyo/gymsolids.dff", "reyo/gymsolids.txd");
    AddSimpleModel(-1, 8674,    GANTON_GYM_3, "reyo/gymalpha.dff", "reyo/gymalpha.txd");
    CreateObject(GANTON_GYM_1, 2260.0000, -1707.7342, 17.1718, 0.0000, 0.0000, 0.0000, 800.00);  //REYO/GGRE/gymenex.dff
    CreateDynamicObject(GANTON_GYM_2, 2243.2453, -1702.9897, 14.1324, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00);  //REYO/GGRE/gymsolids.dff
    CreateDynamicObject(GANTON_GYM_3, 2236.4431, -1709.0810, 13.7950, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00);  //REYO/GGRE/gymalpha.dff

    // FAST FOODs ENEX
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, fastfood_cluck, "fastfood/cluck.dff", "fastfood/cluck.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, fastfood_cluck2, "fastfood/cluck2.dff", "fastfood/cluck2.txd");
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, fastfood_pizzastacks, "fastfood/pizzastacks.dff", "fastfood/pizzastacks.txd");
    CreateObject(fastfood_cluck, 2402.2970, -1503.6120, 29.0500, 0.0000, 0.0000, 0.0000, 800.00); //fastfood/cluck
    CreateObject(fastfood_cluck2, 2385.1875, -1906.5156, 18.4453, 0.0000, 0.0000, 0.0000, 800.00); //fastfood/cluck2
    CreateObject(fastfood_pizzastacks, 2112.9375, -1797.0938, 19.3359, 0.0000, 0.0000, 0.0000, 800.00); //fastfood/pizzastacks
    AddSimpleModel(-1, 19325, fastfood_cluck_alphas, "fastfood/cluck_alphas.dff", "fastfood/cluck.txd");
    AddSimpleModel(-1, 19325, fastfood_cluck2_alphas, "fastfood/cluck2_alphas.dff", "fastfood/cluck2.txd");
    AddSimpleModel(-1, 19325, fastfood_pizzastacks_alphas, "fastfood/pizzastacks_alphas.dff", "fastfood/pizzastacks.txd");
    CreateDynamicObject(fastfood_cluck_alphas, 2419.0390, -1493.4800, 24.9900, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00); //fastfood/cluck_alphas
    CreateDynamicObject(fastfood_cluck2_alphas, 2381.4150, -1899.8350, 14.5060, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00); //fastfood/cluck2_alphas
    CreateDynamicObject(fastfood_pizzastacks_alphas, 2103.3430, -1794.5850, 14.5440, 0.0000, 0.0000, 0.0000, -1, 0, -1, 200.00, 200.00); //fastfood/pizzastacks_alphas
    AddSimpleModel(-1, 19479, fastfood_donutla_enex, "fastfood/donutla_enex.dff", "fastfood/donutla_enex.txd");
    AddSimpleModel(-1, 19479, fastfood_donutla_bits, "fastfood/donutla_bits.dff", "fastfood/donutla_bits.txd");
    CreateObject(fastfood_donutla_enex, 1014.0234, -1361.4609, 20.3516, 0.0000, 0.0000, 0.0000, 800.00); //fastfood/donutla_enex
    CreateDynamicObject(fastfood_donutla_bits, 1036.5775, -1348.8992, 14.6441, 0.0000, 0.0000, 0.0000, -1, 0, -1, 150.00, 150.00); //fastfood/donutla_bits
    
    // Impound lot
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, IMPOUND_LOT_NEW, "impoundnew.dff",  "impoundnew.txd");
    CreateDynamicObject(IMPOUND_LOT_NEW, 1086.1781, -1756.4338, 14.9353, 0.0000, 0.0000, 0.0000, -1, 0, -1, 800.00, 800.00);

    // Misc stuff
    AddSimpleModel(-1, CUSTOM_OBJECT_BASEID, NEW_AJAIL_MODEL, "ryhes/ajail.dff",  "ryhes/ajail.txd");
	AddSimpleModel(-1, 1337, -29993, "dignity/champagne_bottle.dff", "dignity/champagne_bottle.txd");
	AddSimpleModel(-1, 1923, TDW_SIGNAL_OBJECT_ID, "sporky/blinker2.dff", "sporky/blinker.txd");


    // Sprites
	AddSimpleModel(-1, 1337, -28992, "sprite_model.dff", "license.txd");
	AddSimpleModel(-1, 1337, -29992, "sprite_model.dff", "fuel/fuel.txd");
	AddSimpleModel(-1, 1337, -29994, "phone.dff", "phone_nice.txd");
	AddSimpleModel(-1, 1337, -29995, "phone.dff", "phone.txd");
	AddSimpleModel(-1, 1337, -29996, "sprite_model.dff", "newgen.txd");

	AddSimpleModel(-1, 1923, -29997, "sprite_model.dff", "speedometer.txd");
	AddSimpleModel(-1, 1923, -29998, "sprite_model.dff", "nosmeter.txd");
	AddSimpleModel(-1, 1923, -29999, "sprite_model.dff", "fuelmeter.txd");
	AddSimpleModel(-1, 1337, -30000, "sprite_model.dff", "gymbar.txd");
	AddSimpleModel(-1, 1337, -30001, "sprite_model.dff", "fuel/jerrycan.txd");

	AddSimpleModel(-1, 1923, -29000, "spraytag_vla.dff", "spraytag_vla.txd");
	AddSimpleModel(-1, 1923, -29001, "spraytag_tdf.dff", "spraytag_tdf.txd");

    // Gym
	AddSimpleModel(-1, 1337, -16000,	"v2/gym/kmb_dumbbell2.dff" , 	"v2/gym/gym_weights.txd");
	AddSimpleModel(-1, 1337, -16001, 	"v2/gym/kmb_bpress.dff" , 		"v2/gym/gym_weights.txd");
	AddSimpleModel(-1, 1337, -16002,	"v2/gym/kmb_dumbbell_l.dff" , 	"v2/gym/gym_weights.txd");
	AddSimpleModel(-1, 1337, -16003,	"v2/gym/kmb_dumbbell_r.dff" , 	"v2/gym/gym_weights.txd");

    // Garbage job
	AddSimpleModel(-1, 1271, -28100, "garbage/bag_1.dff", "garbage/rubbish.txd");
	AddSimpleModel(-1, 1271, -28101, "garbage/bag_2.dff", "garbage/rubbish.txd");
	AddSimpleModel(-1, 1271, -28102, "garbage/box_1.dff", "garbage/rubbish.txd");
	AddSimpleModel(-1, 1271, -28103, "garbage/box_2.dff", "garbage/rubbish.txd");    

    // Trucking job
	AddSimpleModel(-1, 1271, -28000, "trucker/crate_a.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28001, "trucker/crate_b.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28002, "trucker/crate_c.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28003, "trucker/crate_d.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28004, "trucker/crate_e.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28005, "trucker/crate_f.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28006, "trucker/crate_g.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28007, "trucker/crate_h.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28008, "trucker/crate_i.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28009, "trucker/crate_j.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28010, "trucker/crate_k.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28011, "trucker/crate_l.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28012, "trucker/crate_m.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28013, "trucker/crate_n.dff", "trucker/trucker_crates.txd");
	AddSimpleModel(-1, 1271, -28014, "trucker/crate_o.dff", "trucker/trucker_crates.txd");

    // Vending machines
	AddSimpleModel(-1, 1337, E_VENDING_CAN_ECOLA_BIG, 	"vending/can_ecola_big.dff", 	"vending/can_ecola_big.txd");
	AddSimpleModel(-1, 1337, E_VENDING_CAN_ECOLA_SMALL, "vending/can_ecola_small.dff", 	"vending/can_ecola_small.txd");
	AddSimpleModel(-1, 1337, E_VENDING_CAN_SPRUNK_BIG, 	"vending/can_sprunk_big.dff", 	"vending/can_sprunk_big.txd");
	AddSimpleModel(-1, 1337, E_VENDING_CAN_SPRUNK_SMALL, "vending/can_sprunk_small.dff", "vending/can_sprunk_small.txd");
	AddSimpleModel(-1, 1337, E_VENDING_MACHINE_ECOLA, 	"vending/machine_ecola.dff", 	"vending/machine_ecola.txd");
	AddSimpleModel(-1, 1337, E_VENDING_MACHINE_SPRUNK, 	"vending/machine_sprunk.dff", 	"vending/machine_sprunk.txd");

    // Fuel system
	AddSimpleModel(-1, 1337, FUELSYS_PUMP_1, "fuel/pump_none.dff", 		"fuel/pumps.txd");
	AddSimpleModel(-1, 1337, FUELSYS_PUMP_2, "fuel/pump_ron.dff", 		"fuel/pumps.txd");
	AddSimpleModel(-1, 1337, FUELSYS_PUMP_3, "fuel/pump_globeoil.dff", 	"fuel/pumps.txd");
	AddSimpleModel(-1, 1337, FUELSYS_PUMP_4, "fuel/pump_terroil.dff", 	"fuel/pumps.txd");


    // Spawnables (Misc props from sandbox)
    AddSimpleModel(-1,14633, -25159, "sporky/spawnmodels/props/docbox.dff", "sporky/spawnmodels/props/paperstuff.txd"); // -313,
    AddSimpleModel(-1,16155, -25160, "sporky/spawnmodels/props/hamradio.dff", "sporky/spawnmodels/props/ufostuff.txd"); // -314,
    AddSimpleModel(-1,16155, -25161, "sporky/spawnmodels/props/ufopapers01.dff", "sporky/spawnmodels/props/ufostuff.txd"); // -315,
    AddSimpleModel(-1,16155, -25162, "sporky/spawnmodels/props/ufopapers02.dff", "sporky/spawnmodels/props/ufostuff.txd"); // -316,
    AddSimpleModel(-1,16155, -25163, "sporky/spawnmodels/props/ufomap.dff", "sporky/spawnmodels/props/ufostuff.txd"); // -317,
    AddSimpleModel(-1, 2005, -25164, "sporky/spawnmodels/props/money.dff", "sporky/spawnmodels/props/money.txd"); // -319,
    AddSimpleModel(-1,11735, -25165, "sporky/spawnmodels/props/csdress.dff", "sporky/spawnmodels/props/csdress.txd"); // -320,
    AddSimpleModel(-1,11735, -25166, "sporky/spawnmodels/props/heels.dff", "sporky/spawnmodels/props/heelspink.txd"); // -321,
    AddSimpleModel(-1,11735, -25167, "sporky/spawnmodels/props/heels.dff", "sporky/spawnmodels/props/heelsblack.txd"); // -322,
    AddSimpleModel(-1,11735, -25168, "sporky/spawnmodels/props/heels.dff", "sporky/spawnmodels/props/heelsred.txd"); // -323,
    AddSimpleModel(-1,11735, -25169, "sporky/spawnmodels/props/heels.dff", "sporky/spawnmodels/props/heelsnude.txd"); // -324,
    AddSimpleModel(-1,11735, -25170, "sporky/spawnmodels/props/heels.dff", "sporky/spawnmodels/props/heelslilac.txd"); // -325,
    //AddSimpleModel(-1,14813, -25171, "sporky/spawnmodels/props/watercooler.dff", "sporky/spawnmodels/props/watercooler.txd"); // -326,
    AddSimpleModel(-1,14802, -25172, "sporky/spawnmodels/props/bdupsbed.dff", "sporky/spawnmodels/props/bdupstuff.txd"); // -327,
    AddSimpleModel(-1,14802, -25173, "sporky/spawnmodels/props/bdupsdrugs.dff", "sporky/spawnmodels/props/bdupstuff.txd"); // -328,
    AddSimpleModel(-1,14802, -25174, "sporky/spawnmodels/props/bdupsledger.dff", "sporky/spawnmodels/props/bdupstuff.txd"); // -329,
    AddSimpleModel(-1,2103,  -25175, "sporky/spawnmodels/props/bdupsradio.dff", "sporky/spawnmodels/props/bdupstuff.txd"); // -330,
    AddSimpleModel(-1,14685, -25176, "sporky/spawnmodels/props/cleaningspray.dff", "sporky/spawnmodels/props/tatstuff.txd"); // -331,
    AddSimpleModel(-1,14685, -25177, "sporky/spawnmodels/props/tissuesbox01.dff", "sporky/spawnmodels/props/tatstuff.txd"); // -332,
    AddSimpleModel(-1,14685, -25178, "sporky/spawnmodels/props/tissuesbox02.dff", "sporky/spawnmodels/props/tatstuff.txd"); // -333,
    AddSimpleModel(-1,14685, -25179, "sporky/spawnmodels/props/towelroll.dff", "sporky/spawnmodels/props/tatstuff.txd"); // -334,
    AddSimpleModel(-1,14633, -25180, "sporky/spawnmodels/props/medbottle.dff", "sporky/spawnmodels/props/paperstuff.txd"); // -335,
    AddSimpleModel(-1,14633, -25181, "sporky/spawnmodels/props/plasticbin01.dff", "sporky/spawnmodels/props/paperstuff.txd"); // -336,
    AddSimpleModel(-1,14633, -25182, "sporky/spawnmodels/props/plasticbin02.dff", "sporky/spawnmodels/props/paperstuff.txd"); // -337,
    AddSimpleModel(-1,14633, -25183, "sporky/spawnmodels/props/plasticbin03.dff", "sporky/spawnmodels/props/paperstuff.txd"); // -338,
    AddSimpleModel(-1,14633, -25184, "sporky/spawnmodels/props/plasticbin04.dff", "sporky/spawnmodels/props/paperstuff.txd"); // -339,

    // Extracted roadblock items
    AddSimpleModel(-1, 16439, -25185, "sporky/spawnmodels/objects/rbconc.dff", "sporky/spawnmodels/objects/roadblocks.txd"); // -350,
    AddSimpleModel(-1, 16439, -25186, "sporky/spawnmodels/objects/rbfence.dff", "sporky/spawnmodels/objects/roadblocks.txd"); // -351,
    AddSimpleModel(-1, 16439, -25187, "sporky/spawnmodels/objects/rbnocars.dff", "sporky/spawnmodels/objects/roadblocks.txd"); // -352,
    AddSimpleModel(-1, 16439, -25188, "sporky/spawnmodels/objects/rbstop.dff", "sporky/spawnmodels/objects/roadblocks.txd"); // -353,
    AddSimpleModel(-1, 16439, -25189, "sporky/spawnmodels/objects/rbnobridge.dff", "sporky/spawnmodels/objects/roadblocks.txd"); // -354,

    // Jewelry stuff
    AddSimpleModel(-1, 1923, -3483, "sporky/eagle/eagleliftdr.dff", "sporky/eagle/eaglelift.txd");
    AddSimpleModel(-1, 1923, -3484, "sporky/eagle/eagleliftdl.dff", "sporky/eagle/eaglelift.txd");
    AddSimpleModel(-1, 1923, -3485, "sporky/eagle/eaglelift.dff", "sporky/eagle/eaglelift.txd");
    AddSimpleModel(-1, 1923, -3486, "sporky/eagle/eagleuplights.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 19325, -3487,  "sporky/eagle/eagleupglass.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 1923, -3488, "sporky/eagle/eagleupfurn.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 1923, -3489, "sporky/eagle/eagleupreflect.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 19325, -3490,  "sporky/eagle/eagleupfloor.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 1923, -3491, "sporky/eagle/eagleupmain.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 19325, -3492,  "sporky/eagle/eagleroomfloor.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 1923, -3493, "sporky/eagle/eagleroom.dff", "sporky/eagle/hi_cutlaw2.txd");
    AddSimpleModel(-1, 1523, -3494, "sporky/eagle/eagledoor_r.dff", "sporky/eagle/eagle.txd");
    AddSimpleModel(-1, 1523, -3495, "sporky/eagle/eagledoor_l.dff", "sporky/eagle/eagle.txd");
    AddSimpleModel(-1, 1923, -3496, "sporky/eagle/eaglebits.dff", "sporky/eagle/eagle.txd");
    AddSimpleModel(-1, 1923, -3497, "sporky/eagle/eaglelobby.dff", "sporky/eagle/eagle.txd");
    AddSimpleModel(-1, 1923, -3498, "sporky/eagle/eaglejewel.dff", "sporky/eagle/eagle.txd");
    AddSimpleModel(-1, 1923, -3499, "sporky/eagle/eb_jewelry_int.dff", "sporky/eagle/eb_jewelry_int.txd");
    AddSimpleModel(-1, 1923, -3500, "sporky/eagle/eb_jewelry.dff", "sporky/eagle/eb_jewelry.txd");

    AddSimpleModel(-1, 1923, -1283, "reyo/chain3.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1284, "reyo/chain2.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1285, "reyo/chain1.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1286, "reyo/diamonds3.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1287, "reyo/diamonds2.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1288, "reyo/diamonds1.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1290, "reyo/gold1.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1291, "reyo/minidiamond3.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1292, "reyo/minidiamond2.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1293, "reyo/minidiamond1.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1294, "reyo/watches5.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1295, "reyo/watches4.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1296, "reyo/watches3.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1297, "reyo/watches2.dff", "reyo/jwlrytextures.txd");
    AddSimpleModel(-1, 1923, -1298, "reyo/watches1.dff", "reyo/jwlrytextures.txd");
    
    return true ;
}


Models_AddSkins() {
    
    // fyb
    SOLS_AddCharModel(103, 20001, "skins_faction/fyb/fyb1.dff", "skins_faction/fyb/fyb1.txd");
    SOLS_AddCharModel(104, 20002, "skins_faction/fyb/fyb2.dff", "skins_faction/fyb/fyb2.txd");
    SOLS_AddCharModel(103, 20003, "skins_faction/fyb/fyb3.dff", "skins_faction/fyb/fyb3.txd");
    SOLS_AddCharModel(103, 20004, "skins_faction/fyb/fyb4.dff", "skins_faction/fyb/fyb4.txd");

    // gsf
    SOLS_AddCharModel(105, 20005, "skins_faction/gsf/fam1.dff", "skins_faction/gsf/fam1.txd");
    //SOLS_AddCharModel(106, 20006, "skins_faction/gsf/fam2.dff", "skins_faction/gsf/fam2.txd"); // No textures
    SOLS_AddCharModel(107, 20007, "skins_faction/gsf/fam3.dff", "skins_faction/gsf/fam3.txd");
    SOLS_AddCharModel(105, 20008, "skins_faction/gsf/fam4.dff", "skins_faction/gsf/fam4.txd");

    // ktb
    SOLS_AddCharModel(102, 20009, "skins_faction/ktb/ktb1.dff", "skins_faction/ktb/ktb1.txd");
    SOLS_AddCharModel(103, 20010, "skins_faction/ktb/ktb2.dff", "skins_faction/ktb/ktb2.txd");
    //SOLS_AddCharModel(104, 20011, "skins_faction/ktb/KTB3.dff", "skins_faction/ktb/KTB3.txd"); // Doesn't get loaded
    SOLS_AddCharModel(102, 20011, "skins_faction/ktb/KTB4.dff", "skins_faction/ktb/KTB4.txd");

    // lsv
    SOLS_AddCharModel(110, 20012, "skins_faction/lsv/vago1walkslsv1.dff", "skins_faction/lsv/vago1walkslsv1.txd"); // replace
    SOLS_AddCharModel(109, 20013, "skins_faction/lsv/lsv5behaveslike109.dff", "skins_faction/lsv/lsv5behaveslike109.txd"); // replace
    SOLS_AddCharModel(108, 20014, "skins_faction/lsv/vago2walkslsv2.dff", "skins_faction/lsv/vago2walkslsv2.txd");
    SOLS_AddCharModel(108, 20015, "skins_faction/lsv/vago3walkslsv3.dff", "skins_faction/lsv/vago3walkslsv3.txd"); // replace

    // rhb
    SOLS_AddCharModel(102, 20016, "skins_faction/rhb/AWOL.dff", "skins_faction/rhb/AWOL.txd");
    SOLS_AddCharModel(103, 20017, "skins_faction/rhb/khakisuit.dff", "skins_faction/rhb/khakisuit.txd");
    SOLS_AddCharModel(104, 20018, "skins_faction/rhb/RHBSkin1.dff", "skins_faction/rhb/RHBSkin1.txd");
    SOLS_AddCharModel(102, 20019, "skins_faction/rhb/RHBSkin4.dff", "skins_faction/rhb/RHBSkin4.txd");

    // sbf
    SOLS_AddCharModel(105, 20020, "skins_faction/sbf/fam1.dff", "skins_faction/sbf/fam1.txd");
    SOLS_AddCharModel(106, 20021, "skins_faction/sbf/fam2.dff", "skins_faction/sbf/fam2.txd");
    SOLS_AddCharModel(107, 20022, "skins_faction/sbf/fam3.dff", "skins_faction/sbf/fam3.txd");
    SOLS_AddCharModel(105, 20023, "skins_faction/sbf/fam4.dff", "skins_faction/sbf/fam4.txd");

    // tdf
    SOLS_AddCharModel(105, 20024, "skins_faction/tdf/TDF1.dff", "skins_faction/tdf/TDF1.txd");
    SOLS_AddCharModel(106, 20025, "skins_faction/tdf/TDF2.dff", "skins_faction/tdf/TDF2.txd");
    SOLS_AddCharModel(107, 20026, "skins_faction/tdf/TDF3.dff", "skins_faction/tdf/TDF3.txd");
    SOLS_AddCharModel(105, 20027, "skins_faction/tdf/TDF4.dff", "skins_faction/tdf/TDF4.txd");

    // VLA
    SOLS_AddCharModel(114, 20028, "skins_faction/vla/vla4behaveslike114.dff", "skins_faction/vla/vla4behaveslike114.txd");
    SOLS_AddCharModel(115, 20029, "skins_faction/vla/vla5behaveslike115.dff", "skins_faction/vla/vla5behaveslike115.txd");
    SOLS_AddCharModel(116, 20030, "skins_faction/vla/vla6behaveslike116.dff", "skins_faction/vla/vla6behaveslike116.txd");
    SOLS_AddCharModel(116, 20031, "skins_faction/vla/vla7behaveslike116.dff", "skins_faction/vla/vla7behaveslike116.txd");

    // LSPD skins
    SOLS_AddCharModel(280, 20032, "skins_faction/lspd/wmypdA1.dff", "skins_faction/lspd/wmypdA1.txd");
    SOLS_AddCharModel(280, 20033, "skins_faction/lspd/wmypdA2.dff", "skins_faction/lspd/wmypdA2.txd");
    SOLS_AddCharModel(280, 20034, "skins_faction/lspd/wmypdA4.dff", "skins_faction/lspd/wmypdA4.txd");
    SOLS_AddCharModel(280, 20035, "skins_faction/lspd/wmypdA5.dff", "skins_faction/lspd/wmypdA5.txd");
    SOLS_AddCharModel(280, 20036, "skins_faction/lspd/wmypdA7.dff", "skins_faction/lspd/wmypdA7.txd");
    SOLS_AddCharModel(280, 20037, "skins_faction/lspd/wmypdc1.dff", "skins_faction/lspd/wmypdc1.txd");
    SOLS_AddCharModel(280, 20038, "skins_faction/lspd/wmypdc2.dff", "skins_faction/lspd/wmypdc2.txd");
    SOLS_AddCharModel(280, 20039, "skins_faction/lspd/wmypdc4.dff", "skins_faction/lspd/wmypdc4.txd");
    SOLS_AddCharModel(280, 20040, "skins_faction/lspd/wmypdc5.dff", "skins_faction/lspd/wmypdc5.txd");
    SOLS_AddCharModel(280, 20041, "skins_faction/lspd/wmypdc7.dff", "skins_faction/lspd/wmypdc7.txd");
    SOLS_AddCharModel(280, 20042, "skins_faction/lspd/wmopdA1.dff", "skins_faction/lspd/wmopdA1.txd");
    SOLS_AddCharModel(280, 20043, "skins_faction/lspd/wmopdA2.dff", "skins_faction/lspd/wmopdA2.txd");
    SOLS_AddCharModel(280, 20044, "skins_faction/lspd/wmopdc1.dff", "skins_faction/lspd/wmopdc1.txd");
    SOLS_AddCharModel(280, 20045, "skins_faction/lspd/wmopdc2.dff", "skins_faction/lspd/wmopdc2.txd");
    SOLS_AddCharModel(280, 20046, "skins_faction/lspd/bmypdA1.dff", "skins_faction/lspd/bmypdA1.txd");
    SOLS_AddCharModel(280, 20047, "skins_faction/lspd/bmypdA3.dff", "skins_faction/lspd/bmypdA3.txd");
    SOLS_AddCharModel(280, 20048, "skins_faction/lspd/bmypdA5.dff", "skins_faction/lspd/bmypdA5.txd");
    SOLS_AddCharModel(280, 20049, "skins_faction/lspd/bmypdA6.dff", "skins_faction/lspd/bmypdA6.txd");
    SOLS_AddCharModel(280, 20050, "skins_faction/lspd/bmypdc1.dff", "skins_faction/lspd/bmypdc1.txd");
    SOLS_AddCharModel(280, 20051, "skins_faction/lspd/bmypdc3.dff", "skins_faction/lspd/bmypdc3.txd");
    SOLS_AddCharModel(280, 20052, "skins_faction/lspd/bmypdc5.dff", "skins_faction/lspd/bmypdc5.txd");
    SOLS_AddCharModel(280, 20053, "skins_faction/lspd/bmypdc6.dff", "skins_faction/lspd/bmypdc6.txd");
    SOLS_AddCharModel(280, 20054, "skins_faction/lspd/hmypdA6.dff", "skins_faction/lspd/hmypdA6.txd");
    SOLS_AddCharModel(280, 20055, "skins_faction/lspd/hmypdc6.dff", "skins_faction/lspd/hmypdc6.txd");
    SOLS_AddCharModel(280, 20056, "skins_faction/lspd/omypdA1.dff", "skins_faction/lspd/omypdA1.txd");
    SOLS_AddCharModel(280, 20057, "skins_faction/lspd/omypdA2.dff", "skins_faction/lspd/omypdA2.txd");
    SOLS_AddCharModel(280, 20058, "skins_faction/lspd/omypdc1.dff", "skins_faction/lspd/omypdc1.txd");
    SOLS_AddCharModel(280, 20059, "skins_faction/lspd/omypdc2.dff", "skins_faction/lspd/omypdc2.txd");
    SOLS_AddCharModel(306, 20060, "skins_faction/lspd/wfypdA1.dff", "skins_faction/lspd/wfypdA1.txd");
    SOLS_AddCharModel(306, 20061, "skins_faction/lspd/wfypdA3.dff", "skins_faction/lspd/wfypdA3.txd");
    SOLS_AddCharModel(306, 20062, "skins_faction/lspd/wfypdc1.dff", "skins_faction/lspd/wfypdc1.txd");
    SOLS_AddCharModel(306, 20063, "skins_faction/lspd/wfypdc3.dff", "skins_faction/lspd/wfypdc3.txd");
    SOLS_AddCharModel(306, 20064, "skins_faction/lspd/bfypdA1.dff", "skins_faction/lspd/bfypdA1.txd");
    SOLS_AddCharModel(306, 20065, "skins_faction/lspd/bfypdA2.dff", "skins_faction/lspd/bfypdA2.txd");
    SOLS_AddCharModel(306, 20066, "skins_faction/lspd/bfypdc1.dff", "skins_faction/lspd/bfypdc1.txd");
    SOLS_AddCharModel(306, 20067, "skins_faction/lspd/bfypdc2.dff", "skins_faction/lspd/bfypdc2.txd");
    SOLS_AddCharModel(306, 20068, "skins_faction/lspd/hfypdA1.dff", "skins_faction/lspd/hfypdA1.txd");
    SOLS_AddCharModel(306, 20069, "skins_faction/lspd/hfypdc1.dff", "skins_faction/lspd/hfypdc1.txd");
    SOLS_AddCharModel(306, 20070, "skins_faction/lspd/ofypdA1.dff", "skins_faction/lspd/ofypdA1.txd");
    SOLS_AddCharModel(306, 20071, "skins_faction/lspd/ofypdc1.dff", "skins_faction/lspd/ofypdc1.txd");
    SOLS_AddCharModel(280, 20072, "skins_faction/lspd/wmypdm1.dff", "skins_faction/lspd/wmypdm1.txd");
    SOLS_AddCharModel(280, 20073, "skins_faction/lspd/bmypdm1.dff", "skins_faction/lspd/bmypdm1.txd");
    SOLS_AddCharModel(306, 20074, "skins_faction/lspd/wfypdm1.dff", "skins_faction/lspd/wfypdm1.txd");
    SOLS_AddCharModel(306, 20075, "skins_faction/lspd/bfypdm1.dff", "skins_faction/lspd/bfypdm1.txd");
    SOLS_AddCharModel(280, 20076, "skins_faction/lspd/wmypdplt.dff", "skins_faction/lspd/wmypdplt.txd");
    SOLS_AddCharModel(280, 20077, "skins_faction/lspd/bmypdplt.dff", "skins_faction/lspd/bmypdplt.txd");
    SOLS_AddCharModel(306, 20078, "skins_faction/lspd/wfypdplt.dff", "skins_faction/lspd/wfypdplt.txd");
    SOLS_AddCharModel(306, 20079, "skins_faction/lspd/bfypdplt.dff", "skins_faction/lspd/bfypdplt.txd");
    SOLS_AddCharModel(285, 20080, "skins_faction/lspd/wmypdbdu.dff", "skins_faction/lspd/wmypdbdu.txd");
    SOLS_AddCharModel(285, 20081, "skins_faction/lspd/wmypdbdu2.dff", "skins_faction/lspd/wmypdbdu2.txd");
    SOLS_AddCharModel(285, 20082, "skins_faction/lspd/wmypdbdu3.dff", "skins_faction/lspd/wmypdbdu3.txd");
    SOLS_AddCharModel(285, 20083, "skins_faction/lspd/bmypdbdu.dff", "skins_faction/lspd/bmypdbdu.txd");
    SOLS_AddCharModel(280, 20084, "skins_faction/lspd/omypdbdu.dff", "skins_faction/lspd/omypdbdu.txd");
    SOLS_AddCharModel(285, 20085, "skins_faction/lspd/wmypdswat.dff", "skins_faction/lspd/wmypdswat.txd");
    SOLS_AddCharModel(285, 20086, "skins_faction/lspd/wmypdswat2.dff", "skins_faction/lspd/wmypdswat2.txd");
    SOLS_AddCharModel(285, 20087, "skins_faction/lspd/wmypdswat3.dff", "skins_faction/lspd/wmypdswat3.txd");
    SOLS_AddCharModel(285, 20088, "skins_faction/lspd/bmypdswat.dff", "skins_faction/lspd/bmypdswat.txd");
    SOLS_AddCharModel(285, 20089, "skins_faction/lspd/omypdswat.dff", "skins_faction/lspd/omypdswat.txd");
}
// Sporky: new stuff to prevent model picker issues (and make sure all custom faction skins have a name)

#define MAX_ADDED_FACTION_SKINS 250

enum E_ADDED_SKIN_DATA
{
    E_ADDED_SKIN_BASE_ID,
    E_ADDED_SKIN_ID,
    E_ADDED_SKIN_NAME[64]
}

static AddedSkins[MAX_ADDED_FACTION_SKINS][E_ADDED_SKIN_DATA];
static AddedSkinsCount;

SOLS_AddCharModel(baseid, skinid, const dff[64], const txd[64], name[64]="")
{
    new i = AddedSkinsCount;

    if (i >= MAX_ADDED_FACTION_SKINS)
    {
        print("WARNING - MAX_ADDED_FACTION_SKINS LIMIT REACHED");
        return;
    }

    AddCharModel(baseid, skinid, dff, txd ) ;
    AddedSkins[i][E_ADDED_SKIN_BASE_ID] = baseid;
    AddedSkins[i][E_ADDED_SKIN_ID] = skinid;

    GetSkinName(baseid, AddedSkins[i][E_ADDED_SKIN_NAME], 64 ) ;

    if (strlen(name) > 1)
    {
        // custom name
        format(AddedSkins[i][E_ADDED_SKIN_NAME], 64, "%s", name);
    }

    AddedSkinsCount ++;
}

static GetAddedSkinEnumId(skinid)
{
    for (new i = 0; i < AddedSkinsCount; i ++)
    {
        if (AddedSkins[i][E_ADDED_SKIN_ID] == skinid)
        {
            return i;
        }
    }

    return -1;
}

SOLS_GetBaseSkinID(skinid)
{
    if (skinid >= 20000)
    {
        new id = GetAddedSkinEnumId(skinid);
        if (id != -1)
        {
            return AddedSkins[id][E_ADDED_SKIN_BASE_ID];
        }
    }

    return skinid;
}

SOLS_GetCustomSkinName(skinid)
{
    new name[64];

    if (skinid > 0 && skinid <= 312)
    {
        GetSkinName(skinid, name, sizeof ( name ) ) ;
        return name;
    }

    format(name, sizeof(name), "%d", skinid);

    /*
    new id = GetAddedSkinEnumId(skinid);

    if (id != -1)
    {
        format(name, sizeof(name), "%s", AddedSkins[id][E_ADDED_SKIN_NAME]);
    }

    // uncomment this block to use the actual names instead of id (either uses base id name or custom name)

    */
    
    return name;
}

#pragma unused GetAddedSkinEnumId