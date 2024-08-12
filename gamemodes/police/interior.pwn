//------------------------------------------------------------------------------
// Custom LSPD Central Police Station Interior (Converted from Redwood RP Sheriff's Dept.)
// Written by Sporky (www.github.com/sporkyspork) for Singleplayer Roleplay (www.stretzofls.com)

#include <YSI_Coding\y_hooks>

#define MODELS_PATH "sporky/sols/int/lspd"
#define COP_INTERIOR 6
#define COP_WORLD -1
#define COP_BOT -25190
#define COP_TOP -25191
#define COP_SIGNS -25192
#define COP_GLASS -25193
#define COP_DOOR_GLASS -25194
#define COP_DOOR_DYNAMIC -25195
#define COP_DOOR_STATIC -25196

hook OnGameModeInit()
{
    AddSimpleModel(-1, 14846, COP_BOT, MODELS_PATH"/cop_bot.dff", MODELS_PATH"/cop_lspd.txd");
	AddSimpleModel(-1, 14846, COP_TOP, MODELS_PATH"/cop_top.dff", MODELS_PATH"/cop_lspd.txd");
	AddSimpleModel(-1, 18112, COP_SIGNS, MODELS_PATH"/cop_signs.dff", MODELS_PATH"/cop_lspd.txd");
	AddSimpleModel(-1, 14501, COP_GLASS, MODELS_PATH"/cop_glass.dff", MODELS_PATH"/cop_lspd.txd");
    AddSimpleModel(-1, 1523, COP_DOOR_GLASS, MODELS_PATH"/cop_door_glass.dff", MODELS_PATH"/cop_doors.txd");
    AddSimpleModel(-1, 1523, COP_DOOR_DYNAMIC, MODELS_PATH"/cop_door_blue.dff", MODELS_PATH"/cop_doors.txd");
    AddSimpleModel(-1, 1495, COP_DOOR_STATIC, MODELS_PATH"/cop_door_blue.dff", MODELS_PATH"/cop_doors.txd"); 
    
    CreatePoliceInterior();
    return 1;
}

#undef MODELS_PATH

static CreatePoliceInterior()
{
	// Base objects:
    CreateDynamicObject(COP_BOT, -14.211, -99.601, 898.931, 0.000000, 0.000000, 0.000000, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_TOP, -13.499, -87.99, 902.461, 0.000000, 0.000000, 0.000000, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_SIGNS, -10.7, -91.6, 902.148, 0.000000, 0.000000, 0.000000, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_GLASS, -17.183, -91.105, 899.252, 0.000000, 0.000000, 0.000000, COP_WORLD, COP_INTERIOR);

    // Blue dynamic doors
	CreateDynamicObject(COP_DOOR_DYNAMIC, -5.66, -94.52, 897.56,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_DOOR_DYNAMIC, -21.57, -97.57, 897.56,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_DOOR_DYNAMIC, -21.57, -101.60, 897.56,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_DOOR_DYNAMIC, -16.23, -106.31, 897.56,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);

	// Glass dynamic doors
    CreateDynamicObject(COP_DOOR_GLASS, -17.44, -91.04, 901.41,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_DOOR_GLASS, -8.74, -91.04, 901.41,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_DOOR_GLASS, -6.28, -90.21, 901.41,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(COP_DOOR_GLASS, -6.33, -80.18, 901.41,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
	
	// Textured:
	new copfolders[13];
	copfolders[0] = CreateDynamicObject(2162, -15.61, -83.00, 901.27,   0.00, 0.00, 181.20, COP_WORLD, COP_INTERIOR);
	copfolders[1] = CreateDynamicObject(2162, -18.59, -79.55, 901.38,   0.00, 0.00, 0.60, COP_WORLD, COP_INTERIOR);
	copfolders[2] = CreateDynamicObject(2162, -12.36, -94.62, 897.72,   0.00, 0.00, 365.82, COP_WORLD, COP_INTERIOR);
	copfolders[3] = CreateDynamicObject(2162, -15.52, -91.35, 897.71,   0.00, 0.00, 7.92, COP_WORLD, COP_INTERIOR);
	copfolders[4] = CreateDynamicObject(2162, -13.13, -100.14, 897.69,   0.00, 0.00, 552.12, COP_WORLD, COP_INTERIOR);
	copfolders[5] = CreateDynamicObject(2162, -9.99, -96.41, 898.02,   0.00, 0.00, 277.80, COP_WORLD, COP_INTERIOR);
	copfolders[6] = CreateDynamicObject(2162, -16.76, -90.51, 897.45,   0.00, 0.00, 182.10, COP_WORLD, COP_INTERIOR);
	copfolders[7] = CreateDynamicObject(2162, -13.61, -90.71, 898.04,   0.00, 0.00, 189.36, COP_WORLD, COP_INTERIOR);
	copfolders[8] = CreateDynamicObject(2162, -15.83, -82.06, 897.45,   0.00, 0.00, 182.10, COP_WORLD, COP_INTERIOR);
	copfolders[9] = CreateDynamicObject(2162, -16.49, -79.54, 901.38,   0.00, 0.00, 0.60, COP_WORLD, COP_INTERIOR);
	copfolders[10] = CreateDynamicObject(2162, -15.24, -79.60, 901.38,   0.00, 0.00, 6.36, COP_WORLD, COP_INTERIOR);
	copfolders[11] = CreateDynamicObject(2162, -13.58, -88.17, 901.27,   0.00, 0.00, 544.26, COP_WORLD, COP_INTERIOR);
	copfolders[12] = CreateDynamicObject(2162, -10.12, -85.43, 901.27,   0.00, 0.00, 633.72, COP_WORLD, COP_INTERIOR);

	for (new i = 0; i < sizeof(copfolders); i ++)
	{
	    SetDynamicObjectMaterial(copfolders[i], 1, 18887, "forcefields", "white");
	    SetDynamicObjectMaterial(copfolders[i], 2, 18887, "forcefields", "white");
	}

	new coprubbish[6];
	coprubbish[0] = CreateDynamicObject(2674, -10.97, -86.56, 901.43,   0.00, 0.00, -60.36, COP_WORLD, COP_INTERIOR);
	coprubbish[1] = CreateDynamicObject(2674, -15.50, -86.50, 901.43,   0.00, 0.00, -60.36, COP_WORLD, COP_INTERIOR);
	coprubbish[2] = CreateDynamicObject(2674, -4.44, -85.31, 901.43,   0.00, 0.00, -60.36, COP_WORLD, COP_INTERIOR);
	coprubbish[3] = CreateDynamicObject(2674, -10.48, -101.48, 897.57,   0.00, 0.00, 57.00, COP_WORLD, COP_INTERIOR);
	coprubbish[4] = CreateDynamicObject(2674, -12.40, -83.89, 901.43,   0.00, 0.00, 112.98, COP_WORLD, COP_INTERIOR);
	coprubbish[5] = CreateDynamicObject(2674, -12.13, -86.69, 901.43,   0.00, 0.00, 53.94, COP_WORLD, COP_INTERIOR);

	for (new i = 0; i < sizeof(coprubbish); i ++)
	{
	    SetDynamicObjectMaterial(coprubbish[i], 0, 18887, "forcefields", "white");
	}

	//new copdish = CreateDynamicObject(3031, -14.17, -99.01, 899.13,   0.00, 0.00, -95.28, COP_WORLD, COP_INTERIOR);
 	//SetDynamicObjectMaterial(copdish, 0, 18887, "forcefields", "white");
 	//SetDynamicObjectMaterial(copdish, 1, 1715, "cj_office", "CJ_blackplastic");

    new copmat = CreateDynamicObject(2261, -14.510, -103.183, 898.067, 270.000, 0.000, -2.500, COP_WORLD, COP_INTERIOR);// Apple_Mercer (2261)
	SetDynamicObjectMaterial(copmat, 0, 18646, "matcolours", "grey-70-percent");
	SetDynamicObjectMaterial(copmat, 1, 19362, "all_walls", "la_carp3");

    new clothes = CreateDynamicObject(2384, -15.60, -106.74, 898.35,   0.00, 0.00, 80.82, COP_WORLD, COP_INTERIOR);
	SetDynamicObjectMaterial(clothes, 0, 2384, "zip_clothes", "chinosbiege", 0xFFff9d00);

	// Coffee Steam
	CreateDynamicObject(18673, -14.995626, -89.715026, 896.963684, 0.000000, 0.000000, 0.000000, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(18673, -24.842929, -99.719429, 896.569213, 0.000000, 0.000000, 0.000000, COP_WORLD, COP_INTERIOR);

	new copframes[3];
	copframes[0] = CreateDynamicObject(2271, -23.92, -94.11, 903.60,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	copframes[1] = CreateDynamicObject(2271, -23.92, -92.63, 903.60,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	copframes[2] = CreateDynamicObject(2271, -23.93, -95.59, 903.60,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);

	for (new i = 0; i < sizeof(copframes); i++)
	{
	    if (i == 0) SetDynamicObjectMaterial(copframes[i], 1, 7184, "vgndwntwn1", "newpolice_sa", 0);
	    else if (i == 1) SetDynamicObjectMaterial(copframes[i], 1, 19774, "MatCopStuff", "PoliceBadge2", 0);
	    else if (i == 2) SetDynamicObjectMaterial(copframes[i], 1, 19774, "MatCopStuff", "PoliceBadge3", 0);
	}

	new copdskstuff = CreateDynamicObject(1964, -11.97, -86.52, 899.00,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    SetDynamicObjectMaterial(copdskstuff, 6, 18887, "forcefields", "white");
	SetDynamicObjectMaterial(copdskstuff, 3, 18887, "forcefields", "white");
	SetDynamicObjectMaterial(copdskstuff, 4, 18887, "forcefields", "white");

	new copkitchen[4];
	copkitchen[0] = CreateDynamicObject(2136, -20.33, -86.89, 901.42,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	copkitchen[1] = CreateDynamicObject(2139, -20.30, -84.92, 901.42,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	copkitchen[2] = CreateDynamicObject(2139, -20.30, -83.95, 901.42,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	copkitchen[3] = CreateDynamicObject(2139, -20.30, -82.96, 901.42,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);

	for (new i = 0; i < sizeof(copkitchen); i++)
	{
	    SetDynamicObjectMaterial(copkitchen[i], 3, 2163, "cj_office", "CJ_WOOD5", 0);
	    SetDynamicObjectMaterial(copkitchen[i], 2, 2163, "white32", "CJ_WOOD5", 0);
	}

	// Windows
	CreateDynamicObject(19325, -22.37, -91.09, 903.21,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(19325, -13.58, -91.06, 903.21,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(19325, -6.31, -85.26, 903.21,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);

	// Jail Bars
	CreateDynamicObject(19303, -21.00, -109.66, 898.80,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(19303, -16.20, -111.14, 898.80,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
	CreateDynamicObject(19303, -21.00, -104.97, 898.80,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);

	// The rest:
	CreateDynamicObject(1722, -25.68, -102.64, 897.55,   0.00, 0.00, -33.06, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19997, -24.10, -102.44, 897.55,   0.00, 0.00, 89.52, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1722, -22.46, -102.61, 897.57,   0.00, 0.00, 45.30, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1827, -25.26, -99.97, 897.55,   0.00, 0.00, 89.52, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1715, -23.66, -99.64, 897.55,   0.00, 0.00, 334.32, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1782, -25.67, -99.80, 898.05,   0.00, 0.00, 64.44, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2342, -24.71, -99.74, 898.09,   0.00, 0.00, -65.94, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(18868, -24.82, -99.90, 897.98,   0.00, 0.00, 120.42, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2953, -24.75, -100.03, 897.99,   0.00, 0.00, 109.14, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2647, -24.59, -102.43, 898.51,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19807, -24.27, -102.72, 898.46,   0.00, 0.00, 190.50, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1963, -25.45, -95.83, 897.95,   0.00, 0.00, 269.52, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1722, -25.80, -98.02, 897.57,   0.00, 0.00, 300.78, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1715, -23.63, -95.59, 897.55,   0.00, 0.00, 273.66, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1782, -25.70, -95.04, 898.44,   0.00, 0.00, 61.98, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2342, -25.07, -94.93, 898.47,   0.00, 0.00, -120.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2196, -25.44, -95.84, 898.35,   0.00, 0.00, 38.58, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2074, -24.02, -96.48, 900.80,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2074, -14.54, -105.98, 900.80,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2074, -24.19, -101.12, 900.80,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2180, -15.48, -106.84, 897.55,   0.00, 0.00, -90.72, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1722, -15.72, -103.94, 897.55,   0.00, 0.00, 221.22, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1722, -16.90, -97.70, 897.55,   0.00, 0.00, 275.88, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -13.01, -97.46, 897.55,   0.00, 0.00, 448.08, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2604, -10.34, -100.31, 898.33,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2007, -10.46, -96.57, 897.56,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2000, -10.52, -95.64, 897.56,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1518, -10.26, -95.58, 899.25,   0.00, 0.00, -54.54, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2894, -25.04, -95.89, 898.36,   0.00, 0.00, 100.08, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2894, -24.78, -100.31, 897.98,   0.00, 0.00, 147.48, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1719, -14.99, -98.65, 898.69,   0.00, 0.00, 96.78, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19808, -14.64, -98.57, 898.69,   0.00, 0.00, 102.30, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11706, -11.04, -91.60, 897.52,   0.00, 0.00, -3.54, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11728, -20.97, -98.81, 899.26,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11713, -7.33, -91.31, 899.01,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(18636, -10.36, -95.65, 899.58,   0.00, 0.00, -153.48, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -15.46, -107.14, 898.35,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2741, -15.85, -106.80, 899.10,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19809, -15.59, -107.24, 898.40,   0.00, 0.00, -111.48, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19809, -15.05, -96.06, 898.75,   0.00, 0.00, -82.98, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19043, -14.98, -96.05, 898.73,   0.00, 0.00, 140.74, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2894, -15.01, -97.51, 898.69,   0.00, 0.00, 87.54, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2855, -23.83, -102.70, 898.39,   0.00, 0.00, 165.72, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2741, -13.52, -103.29, 899.10,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19903, -10.16, -102.77, 897.56,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11711, -3.48, -92.76, 900.49,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11711, -18.66, -114.59, 900.49,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19086, -9.63, -95.60, 897.66,   15.00, 270.00, -20.28, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19809, -14.98, -95.62, 898.75,   0.00, 0.00, -59.28, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(18641, -15.49, -107.05, 898.44,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11713, -20.85, -108.03, 898.88,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2690, -7.18, -91.40, 897.92,   0.00, 0.00, 369.06, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2690, -7.56, -91.42, 897.92,   0.00, 0.00, 356.10, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19809, -18.59, -91.53, 898.70,   0.00, 0.00, -81.42, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1998, -15.07, -89.43, 897.56,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2008, -17.04, -90.43, 897.56,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -16.57, -88.96, 897.54,   0.00, 0.00, 215.70, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -17.74, -89.03, 897.54,   0.00, 0.00, 170.64, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2342, -14.94, -89.59, 898.50,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2000, -13.49, -90.32, 897.56,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2000, -14.01, -90.32, 897.56,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2186, -20.34, -86.95, 897.56,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2186, -20.34, -85.04, 897.56,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -20.07, -86.52, 897.56,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2197, -19.43, -82.53, 897.54,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2197, -19.44, -81.83, 897.54,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2197, -19.45, -81.12, 897.54,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1998, -15.83, -81.92, 897.56,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2008, -17.84, -80.90, 897.56,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -15.35, -80.56, 897.54,   0.00, 0.00, 116.10, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -18.58, -81.41, 897.54,   0.00, 0.00, 261.42, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1808, -20.04, -90.64, 897.56,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -20.30, -89.71, 897.56,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1808, -10.19, -97.36, 897.56,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1209, -8.51, -91.35, 897.54,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2751, -9.46, -95.73, 899.13,   0.00, 0.00, 90.24, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2752, -9.50, -95.55, 899.10,   0.00, 0.00, 90.22, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(322, -9.78, -95.28, 897.65,   -10.00, 0.00, 23.16, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2855, -4.65, -81.67, 897.98,   0.00, 0.00, 39.78, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2194, -4.29, -81.30, 898.26,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1209, -8.76, -80.72, 897.53,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1702, -7.87, -80.87, 897.56,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1827, -4.40, -81.25, 897.55,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1705, -4.04, -82.69, 897.56,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11706, -9.82, -80.62, 897.52,   0.00, 0.00, 10.32, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2811, -11.13, -90.53, 897.56,   0.00, 0.00, -40.62, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2190, -12.07, -87.00, 898.67,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19835, -16.62, -81.56, 898.46,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -10.20, -100.78, 897.56,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2205, -22.13, -93.55, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1705, -19.61, -95.73, 901.42,   0.00, 0.00, -170.70, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1705, -20.58, -92.94, 901.42,   0.00, 0.00, -10.62, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1702, -17.23, -93.68, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2725, -17.17, -96.30, 901.80,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2066, -17.21, -93.02, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2066, -17.21, -92.44, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2194, -22.00, -95.21, 902.65,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1964, -22.29, -93.74, 902.49,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19893, -22.21, -94.23, 902.36,   0.00, 0.00, -80.76, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2192, -17.42, -92.24, 902.79,   0.00, 0.00, 102.48, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11664, -23.40, -100.56, 902.02,   0.00, 0.00, 267.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2162, -24.41, -96.25, 901.38,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2162, -24.38, -92.89, 901.38,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2205, -12.58, -93.46, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11664, -13.08, -100.42, 901.94,   0.00, 0.00, 273.72, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2163, -15.67, -94.82, 901.38,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2164, -15.66, -93.02, 901.38,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1715, -10.63, -95.20, 901.42,   0.00, 0.00, -122.94, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1715, -10.80, -93.49, 901.42,   0.00, 0.00, -68.58, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1964, -12.74, -93.64, 902.49,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19893, -12.61, -94.07, 902.36,   0.00, 0.00, -80.76, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2194, -15.43, -95.09, 902.59,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(14705, -15.45, -94.62, 902.55,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2251, -15.44, -93.98, 903.13,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2828, -12.46, -93.31, 902.36,   0.00, 0.00, 115.86, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2066, -8.48, -94.66, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2066, -8.48, -95.25, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2066, -8.48, -95.85, 901.42,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -8.07, -95.58, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2186, -13.59, -96.35, 901.40,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2248, -15.38, -96.37, 901.92,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -2.14, -79.59, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -3.00, -79.62, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -3.80, -79.61, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -4.58, -79.59, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -1.32, -79.59, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2673, -1.91, -83.55, 901.49,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19805, -20.88, -83.69, 903.49,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19805, -20.88, -86.28, 903.49,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2149, -20.40, -82.97, 902.64,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2830, -20.45, -86.65, 902.48,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2647, -20.42, -86.97, 902.63,   0.00, 0.00, 202.02, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(11743, -20.40, -83.71, 902.48,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(19835, -20.41, -84.05, 902.56,   0.00, 0.00, -36.36, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2426, -20.50, -84.85, 902.50,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1702, -24.95, -90.30, 901.42,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1827, -23.10, -89.33, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2830, -23.53, -89.35, 901.84,   0.00, 0.00, -74.94, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2008, -10.25, -83.47, 901.40,   0.00, 0.00, 90.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1998, -12.31, -82.46, 901.40,   0.00, 0.00, 270.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1998, -13.66, -87.82, 901.40,   0.00, 0.00, 89.88, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2008, -15.73, -86.83, 901.41,   0.00, 0.00, 269.76, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1998, -16.70, -84.69, 901.40,   0.00, 0.00, -0.06, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2008, -15.69, -82.65, 901.40,   0.00, 0.00, 179.94, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2008, -11.42, -87.48, 901.40,   0.00, 0.00, 359.76, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1998, -10.39, -85.45, 901.40,   0.00, 0.00, 179.70, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -17.10, -87.58, 901.42,   0.00, 0.00, -82.08, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -13.18, -86.62, 901.42,   0.00, 0.00, 118.32, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -12.60, -83.82, 901.42,   0.00, 0.00, -53.52, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -15.54, -85.23, 901.42,   0.00, 0.00, 16.50, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -16.42, -81.96, 901.42,   0.00, 0.00, 191.58, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -11.60, -85.02, 901.42,   0.00, 0.00, 219.06, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -10.72, -87.97, 901.42,   0.00, 0.00, 363.72, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1806, -8.99, -82.39, 901.42,   0.00, 0.00, 475.32, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2186, -9.87, -79.95, 901.40,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2186, -11.77, -79.96, 901.40,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -15.40, -89.82, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2163, -15.29, -79.49, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2163, -17.09, -79.49, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2163, -18.89, -79.49, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2342, -10.79, -86.52, 902.33,   0.00, 0.00, -117.96, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2342, -12.25, -82.33, 902.33,   0.00, 0.00, -10.14, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2342, -16.58, -83.62, 902.33,   0.00, 0.00, -57.66, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2647, -11.17, -87.34, 902.40,   0.00, 0.00, 138.36, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(3017, -12.26, -82.54, 902.22,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2828, -10.50, -83.49, 902.21,   0.00, 0.00, -93.72, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2250, -16.30, -83.50, 902.64,   0.00, 0.00, 67.98, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1811, -21.14, -89.78, 901.92,   0.00, 0.00, -37.80, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1808, -16.74, -90.77, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1808, -16.22, -90.75, 901.42,   0.00, 0.00, 180.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(2613, -12.19, -78.78, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -12.22, -90.74, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -12.90, -90.74, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
    CreateDynamicObject(1721, -11.51, -90.74, 901.42,   0.00, 0.00, 0.00, COP_WORLD, COP_INTERIOR);
}
