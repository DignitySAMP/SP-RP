enum E_TURN_SIGNAL_STATE(<<= 1)
{
	EI_TURN_SIGNAL_NONE,
	EI_TURN_SIGNAL_LEFT = 1,
	EI_TURN_SIGNAL_RIGHT,
	EI_TURN_SIGNAL_BOTH = EI_TURN_SIGNAL_LEFT | EI_TURN_SIGNAL_RIGHT
};

enum E_TDW_TURN_SIGNAL_OBJECT_IDS
{
	EI_TURN_SIGNAL_FRONT_LEFT,
	EI_TURN_SIGNAL_FRONT_RIGHT,
	EI_TURN_SIGNAL_BACK_LEFT,
	EI_TURN_SIGNAL_BACK_RIGHT
};

// -----------------------------------------------------------------------------
// Static scope:

static stock
	TDW_g_sVehicleObjects[MAX_VEHICLES][E_TDW_TURN_SIGNAL_OBJECT_IDS];
static E_TURN_SIGNAL_STATE: E_VEHICLE_BLINKER_STATE [MAX_VEHICLES];

static enum eBO {
    bM, Float:bX, Float:bY, Float:bZ, Float:brX, Float:brY, Float:brZ
};

static BlinkOffset[212][eBO] = {
    {400, -0.9001, 2.0490, -0.0965, -0.9605, -2.2404, -0.0965},
    {401, -0.9686, 2.5393, 0.0235, -0.9970, -2.2863, 0.0235},
    {402, -0.8788, 2.5160, -0.0565, -0.9208, -2.5936, 0.0435},
    {403, -1.3897, 3.6007, -0.2194, -1.1904, -0.9415, 1.8389},
    {404, -0.7236, 2.1715, -0.0365, -0.7906, -2.7052, 0.0635},
    {405, -0.9127, 2.2766, -0.0565, -0.8723, -2.6526, -0.0565},
    {406, -2.2165, 4.9242, -0.0332, -2.0785, -5.2054, 0.5468},
    {407, -0.9887, 4.0622, -0.0913, -1.0141, -3.4034, -0.0913},
    {408, -0.9659, 4.7615, -0.2513, -0.8430, -3.9722, -0.5113},
    {409, -0.7859, 3.5522, -0.0313, -0.8027, -3.8228, -0.0313},
    {410, -0.825, 2.105, 0.0635, -0.8723, -2.1926, 0.1235},
    {411, -0.9405, 2.6710, -0.1825, -0.9636, -2.4525, 0.0825},
    {412, -0.8965, 2.6478, -0.0575, -0.9592, -3.4870, -0.1575},
    {413, -0.8669, 2.5464, -0.0913, -0.8209, -2.5829, 0.0687},
    {414, -0.8069, 2.7473, 0.0087, -0.9058, -3.2050, 0.1094},
    {415, -0.8738, 2.4866, -0.2357, -0.7792, -2.3501, 0.0450},
    {416, -0.8469, 2.9073, 0.0087, -1.0352, -3.5937, 1.4522},
    {417, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {418, -0.9511, 2.3820, -0.2357, -1.0081, -2.4904, -0.1557},
    {419, -1.0742, 2.3978, -0.1757, -0.8127, -2.8620, -0.1557},
    {420, -1.0142, 2.2978, -0.0157, -0.9637, -2.6744, 0.0043},
    {421, -0.9013, 2.5343, -0.1357, -0.5921, -2.9228, -0.1957},
    {422, -0.7813, 2.1543, -0.2657, -0.8985, -2.4349, -0.1057},
    {423, -0.7817, 2.2093, -0.0313, -0.8340, -2.1794, 0.0596},
    {424, -0.7350, 1.4505, 0.1087, -0.7062, -1.4778, 0.2996},
    {425, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {426, -1.0006, 2.3164, -0.0100, -0.9627, -2.6930, -0.0100},
    {427, -0.8728, 2.5856, 0.1887, -0.9831, -3.8383, -0.3495},
    {428, -0.8728, 2.5856, -0.2103, -0.9045, -2.8871, 1.2466},
    {429, -0.7942, 2.2846, -0.2500, -0.8397, -2.3849, -0.0070},
    {430, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {431, -0.9771, 5.8479, 0.3497, -1.0300, -5.7043, -0.1041},
    {432, -1.7168, 4.0330, 0.4497, -1.5830, -4.3414, 0.7039},
    {433, -1.2619, 3.7708, -0.2163, -1.2966, -4.6534, -0.1051},
    {434, 0.0, 0.0, 0.0, -0.4811, -1.9838, -0.0670},
    {435, 0.0000, 0.0000, 0.0000, -1.0697, -3.9690, -1.1053}, //trailer
    {436, -0.8495, 2.2519, -0.0070, -0.8948, -2.4838, 0.1130},
    {437, -1.1156, 5.5395, -0.2163, -0.9856, -5.3099, 1.6458},
    {438, -1.1128, 2.3675, -0.2870, -1.0992, -2.4601, -0.2870},
    {439, -0.8381, 2.3101, -0.1470, -0.8221, -2.6534, -0.1070},
    {440, -0.8270, 2.5573, -0.3173, -0.8676, -2.5376, -0.0149},
    {441, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {442, -1.0354, 2.8278, -0.1870, -1.0226, -3.0877, -0.1270},
    {443, -1.0610, 5.7528, -0.9573, -1.2388, -7.1392, -0.8250},
    {444, -0.9880, 2.7188, 0.6140, -1.0722, -3.0184, 0.7248},
    {445, -0.9590, 2.3460, -0.0840, -0.9773, -2.8049, -0.0840},
    {446, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {447, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {448,  -0.1992, -0.9229, -0.1270},
    {449, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {450,  0.0000, 0.0000, 0.0000, -1.0697, -3.9690, -1.1053}, //trailer
    {451, -0.9826, 1.9642, -0.1399, -0.8894, -2.3991, -0.0199},
    {452, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {453, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {454, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {455, 0.0000, 0.0000, 0.0000, -1.3866, -4.5162, -0.7399},
    {456, 0.0000, 0.0000, 0.0000, -1.3045, -4.6123, 0.4601},
    {457, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {458, -0.9513, 2.4197, -0.1399, -0.9703, -2.7779, 0.0201},
    {459, -0.8214, 2.5716, -0.1274, -0.8760, -2.5775, 0.1127},
    {460, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {461, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {462, 0.0000, 0.0000, 0.0000, -0.2054, -0.9359, -0.1399},
    {463, -0.2276, 0.7185, 0.3201, -0.1952, -1.0037, 0.1601},
    {464, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {465, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {466, 0.0000, 0.0000, 0.0000, -1.0201, -2.7994, 0.0401},
    {467, 0.0000, 0.0000, 0.0000, -0.9401, -3.0594, 0.1601},
    {468, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {469, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {470, -1.0259, 2.1382, 0.2001, -1.0433, -2.5463, 0.1201},
    {471, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {472, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {473, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {474, 0.0000, 0.0000, 0.0000, -0.9833, -2.7663, -0.0599},
    {475, -0.8681, 2.4086, -0.3399, -0.8632, -2.7629, -0.2399},
    {476, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {477, -0.8081, 2.6686, -0.1999, -0.9945, -2.6987, 0.0801},
    {478, -1.0938, 2.0255, 0.1001, -1.0579, -2.5378, -0.2799},
    {479, -0.9671, 2.4844, 0.0201, -0.9578, -2.7556, 0.0601},
    {480, -0.5897, 2.2607, -0.4399, -0.9183, -2.3388, -0.1399},
    {481, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {482, -0.8841, 2.4094, -0.3399, -0.8685, -2.5676, 0.0201},
    {483, -0.7770, 2.6235, -0.0199, -0.6709, -2.7712, -0.1999},
    {484,  0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {485, -0.6104, 1.7180, 0.2201, -0.7074, -1.3681, 0.1201},
    {486, 0.0000, 0.0000, 0.0000, -0.5919, -3.2353, 0.9601},
    {487, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {488, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {489, -1.1024, 2.5796, 0.0401, -1.1261, -2.6473, 0.1601},
    {490, -1.0971, 3.1462, 0.0401, -1.1327, -3.1055, 0.1601},
    {491, -0.8495, 2.5284, -0.0799, -0.8870, -2.7776, 0.0001},
    {492, -0.7905, 2.4656, -0.0599, -0.9075, -2.8130, 0.0001},
    {493, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {494, -0.8513, 2.3630, -0.2199, -0.8275, -2.8485, 0.1401},
    {495, -1.0909, 2.3818, 0.0001, -1.1540, -2.1156, -0.0399},
    {496, -0.9219, 2.1787, 0.0401, -0.7095, -2.1087, 0.0801},
    {497, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
    {498, -0.8915, 3.0670, 0.2201, -0.9740, -3.0460, 0.3601},
    {499, -0.7725, 2.4576, -0.1999, -1.1318, -3.4186, 0.1401},
    {500, -0.9152, 1.9097, -0.0355, -0.7552, -1.9266, -0.0355},
    {501, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {502, -0.8723, 2.5986, -0.1770, 0.0, 0.0, 0.0},
    {503, -0.8579, 2.3582, -0.0213, 0.0, 0.0, 0.0},
    {504, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {505, -1.1068, 2.5744, 0.0086, -1.1365, -2.6250, 0.1679},
    {506, -0.7672, 2.2106, -0.3185, -0.9113, -2.3474, -0.0273},
    {507, -1.1143, 2.6057, -0.0456, -1.1410, -2.9714, -0.0456},
    {508, -0.7012, 3.0199, -0.6678, -1.3807, -3.3356, 1.2628},
    {509, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {510, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {511, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {512, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {513, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {514, -1.2341, 4.2204, 0.0806, 0.0, 0.0, 0.0},
    {515, -1.4241, 4.4811, -0.7354, -1.2973, -4.8274, -0.8974},
    {516, -0.9512, 2.7208, -0.0543, -0.9926, -2.7809, -0.0348},
    {517, -0.9401, 2.7868, -0.0726, -1.0208, -2.7461, -0.1324},
    {518, -0.9166, 2.6548, -0.0487, -1.0124, -2.8219, -0.0487}, //fake
    {519, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {520, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {521, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {522, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {523, -0.2607, 0.6038, 0.2881, -0.1973, -0.9958, 0.0638},
    {524, -0.9279, 3.6538, -0.0473, -1.3003, -3.9309, -1.0661}, //fake back
    {525, -0.8576, 2.9431, 0.1425, -1.0428, -2.9851, -0.1486}, //fake back
    {526, -0.9421, 2.3087, -0.1128, -0.9559, -2.2882, -0.0411},
    {527, -0.9351, 2.4078, -0.0242, -0.9825, -2.2344, 0.0844},
    {528, -0.8783, 2.5102, -0.1526, -0.8133, -2.5965, -0.3237}, //fake back
    {529, -1.0177, 2.5256, 0.0698, -1.0505, -2.5713, 0.2047},
    {530, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {531, -0.4216, 1.5030, -0.1191, -0.5225, -1.0517, 0.4484}, //fake
    {532, -4.0331, 3.9619, -0.9118, -1.5976, -0.3739, 0.4484}, //fake!
    {533, -0.9410, 2.3774, 0.0985, -0.9852, -2.4663, -0.0020},
    {534, -1.0159, 2.9278, -0.1698, -0.8236, -2.7548, -0.0574},
    {535, -0.8265, 2.5014, -0.2084, -0.9267, -2.6058, -0.1784},
    {536, -0.8577, 2.3943, -0.1248, -0.8736, -3.0999, -0.0900},
    {537, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {538, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {539, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {540, -0.9827, 2.5810, -0.1248, -1.0597, -2.7121, -0.0842},
    {541, -0.6055, 2.3378, -0.2108, -0.7826, -2.1992, 0.0913},
    {542, -0.9712, 2.6252, -0.0064, -0.8281, -2.9729, -0.0577},
    {543, -0.8414, 2.2904, 0.0719, -0.9831, -2.6214, -0.0116}, //fake front
    {544, -0.7346, 3.5720, 0.0200, -0.8597, -3.2242, -0.5918},
    {545, -0.4372, 1.6776, -0.0400, -0.7955, -2.0453, -0.2888},
    {546, -1.1294, 1.0702, 0.0719, -1.0580, -2.6948, 0.0719},
    {547, -0.9582, 2.5222, 0.0271, -0.9937, -2.5915, 0.0719},
    {548, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {549, -0.9264, 2.4914, 0.0271, -0.9070, -2.5802, 0.0271},
    {550, -1.0477, 2.5642, -0.1807, -1.0302, -2.6549, -0.1297},
    {551, -0.9334, 2.6344, -0.0448, -0.9785, -3.0524, 0.0366},
    {552, -0.8757, 3.0634, 0.3600, -0.9933, -2.9119, 0.4752},
    {553, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {554, -0.9409, 2.5345, 0.0600, -1.1112, -2.8095, 0.0651},
    {555, -0.9236, 1.1282, -0.0462, 0.0, 0.0, 0.0},
    {556, -0.9686, 2.5396, 0.5800, -1.1128, -2.8895, 0.7691},
    {557, -0.9886, 2.4796, 0.7000, -1.0904, -2.7699, 0.6871},
    {558, -0.9452, 2.0854, 0.0836, -0.9187, -2.4047, 0.3185},
    {559, -0.9037, 2.4333, -0.0168, -0.8819, -2.2910, 0.1482},
    {560, -0.9347, 2.5097, -0.2644, -0.9639, -2.2337, 0.1259},
    {561, -0.9157, 2.5754, -0.0857, -0.9317, -2.5444, -0.0191},
    {562, -0.9299, 2.3759, 0.0201, -0.8575, -2.2773, 0.1659},
    {563, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {564, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {565, -0.8503, 2.0545, 0.0346, -0.9249, -1.9224, 0.0816},
    {566, -0.9539, 2.7226, 0.0346, -0.9506, -2.9199, 0.0346},
    {567, -0.9942, 2.9212, -0.1543, -1.0077, -2.9164, -0.1543},
    {568, -0.2962, 2.0729, -0.0171, -0.2384, -1.2180, 0.0720},
    {569, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {570, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {571, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {572, -0.3095, 0.7291, -0.0971, -0.4318, -0.8940, -0.0510},
    {573, -0.7949, 3.0624, -0.3371, -0.8727, -3.0917, -0.4540},
    {574, -0.4348, 1.6912, -0.2171, -0.4277, -1.1358, -0.2069},
    {575, -0.9483, 2.3252, 0.1334, -0.9173, -2.7359, -0.0291},
    {576, -0.9948, 2.4505, 0.1883, -0.9983, -3.1357, -0.0291},
    {577, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {578, -1.0478, 4.3687, -0.1800, -1.1188, -5.3472, -0.5099},
    {579, -1.0598, 2.3634, 0.1013, -1.0873, -2.7596, 0.1013},
    {580, -0.7970, 2.6313, -0.2429, -1.0776, -2.8302, 0.1013},
    {581, 0.0, 0.0, 0.0, -0.1975, -1.0375, 0.3448},
    {582, -0.8583, 2.4404, -0.0571, -0.9214, -3.3625, 0.0521},
    {583, -0.5225, 1.3799, 0.2429, -0.5486, -1.5684, 0.2462},
    {584, 0.0, 0.0, 0.0, -1.0452, -4.3338, -0.7298}, //trailer
    {585, -1.0068, 2.7905, 0.0907, -0.9760, -3.0160, 0.2088},
    {586, -0.2872, 0.5383, 0.2009, -0.1703, -1.3533, 0.2784},
    {587, -1.0236, 2.1415, -0.2834, -1.0832, -2.4851, 0.1047},
    {588, -1.0116, 3.3590, 0.1029, -1.0679, -3.9639, -0.3029},
    {589, -0.8107, 2.3905, 0.1834, -0.9605, -2.2799, 0.3761},
    {590, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {591, 0.0, 0.0, 0.0, -1.0590, -3.9902, -1.0809}, //trailer
    {592, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {593, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {594, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {595, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	{596, -1.0419, 2.2929, -0.0255, -1.0332, -2.6951, 0.0005},
	{597, -1.0419, 2.2929, -0.0255, -1.0332, -2.6951, 0.0005},
	{598, -1.0423, 2.3495, 0.0600, -1.0326, -2.6930, 0.0600},
    {599, -1.0837, 2.5663, 0.0301, -1.1267, -2.6290, 0.1451},
    {600, -0.8782, 2.6525, -0.0344, -1.0586, -2.6696, 0.0596},
    {601, -0.8094, 3.0084, 0.5429, -0.9321, -3.0808, 0.9071},
    {602, -1.0297, 2.0487, -0.0543, -0.8907, -2.5334, -0.3228},
    {603, -0.9069, 2.6672, -0.1335, -0.8647, -2.5991, -0.1335},
    {604, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {605, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {606, 0.0, 0.0, 0.0, -0.5702, -1.5842, 0.7956}, //trailer
    {607, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {608, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {609, -0.8972, 3.0244, 0.2629, -0.9349, -2.9809, 0.2791},
    {610, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    {611, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
    //END GTA CARS
};


// -----------------------------------------------------------------------------
// Functions:

stock SOLS_SetVehicleBlinkers(vehicleid, E_TURN_SIGNAL_STATE:turn_signal)
{
	RemoveVehicleTurnSignals(vehicleid, EI_TURN_SIGNAL_BOTH);
	E_VEHICLE_BLINKER_STATE [ vehicleid ] = turn_signal ;

	if (turn_signal != EI_TURN_SIGNAL_NONE)
		AddVehicleTurnSignals(vehicleid, turn_signal );
	
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if (Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ] && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER && IsValidVehicle ( GetPlayerVehicleID ( playerid ) ) ) {

		new vehicleid = GetPlayerVehicleID ( playerid );

		if ( newkeys & KEY_YES ) 
		{
			SOLS_SetVehicleBlinkers(vehicleid, E_VEHICLE_BLINKER_STATE [ vehicleid ] == EI_TURN_SIGNAL_LEFT ? EI_TURN_SIGNAL_NONE: EI_TURN_SIGNAL_LEFT);
		}
		else if ( newkeys & KEY_NO ) 
		{
			SOLS_SetVehicleBlinkers(vehicleid, E_VEHICLE_BLINKER_STATE [ vehicleid ] == EI_TURN_SIGNAL_RIGHT ? EI_TURN_SIGNAL_NONE: EI_TURN_SIGNAL_RIGHT);
		}
	}

	#if defined signals_OnPlayerKeyStateChange
		return signals_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange signals_OnPlayerKeyStateChange
#if defined signals_OnPlayerKeyStateChange
	forward signals_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


CMD:carblink(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if (!vehicleid ) return SendClientMessage(playerid, COLOR_ERROR, "You're not in a vehicle!");
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	new blinktype[6];

	if (sscanf ( params, "s[6] ", blinktype))
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/carblink [both / left / right / off]");

	if (strcmp(blinktype, "off", true) == 0)
	{
		SOLS_SetVehicleBlinkers(vehicleid, EI_TURN_SIGNAL_NONE);
		return true;
	}

	if (strcmp(blinktype, "both", true) == 0)
	{
		SOLS_SetVehicleBlinkers(vehicleid, EI_TURN_SIGNAL_BOTH);
		return true;
	}

	if (strcmp(blinktype, "left", true) == 0)
	{
		SOLS_SetVehicleBlinkers(vehicleid, EI_TURN_SIGNAL_LEFT);
		return true;
	}

	if (strcmp(blinktype, "right", true) == 0)
	{
		SOLS_SetVehicleBlinkers(vehicleid, EI_TURN_SIGNAL_RIGHT);
		return true;
	}

	return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/carblink [all / left / right / off]");
}

CMD:blinkers(playerid, params[]) return cmd_carblink(playerid, params);
CMD:carblinkers(playerid, params[]) return cmd_carblink(playerid, params);

// New one using predefined offsets:
stock AddVehicleTurnSignals(vehicleid, E_TURN_SIGNAL_STATE:turn_signal)
{
	new
		vehicle_model;

	if ((vehicle_model = GetVehicleModel(vehicleid)) == 0)
		return 0;

	if ((!IsACar(vehicleid) && !IsABike(vehicleid)) || !IsEngineVehicle(vehicleid))
		return 0;

	vehicle_model -= 400;

	if (BlinkOffset[vehicle_model][bX] == 0.0)
	{
		// No blinker for this car
		return 0;
	}

	if (turn_signal & EI_TURN_SIGNAL_LEFT) 
	{
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_LEFT] = CreateObject(TDW_SIGNAL_OBJECT_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_LEFT] = CreateObject(TDW_SIGNAL_OBJECT_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_LEFT],
			vehicleid,
			BlinkOffset[vehicle_model][bX],BlinkOffset[vehicle_model][bY],BlinkOffset[vehicle_model][bZ], // Offsets
			0.0, 0.0, 0.0 // Rotations
		);

		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_LEFT],
			vehicleid,
			BlinkOffset[vehicle_model][brX],BlinkOffset[vehicle_model][brY],BlinkOffset[vehicle_model][brZ], // Offsets
			0.0, 0.0, 180.0 // Rotations
		);
	}

	if (turn_signal & EI_TURN_SIGNAL_RIGHT) 
	{
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_RIGHT] = CreateObject(TDW_SIGNAL_OBJECT_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_RIGHT] = CreateObject(TDW_SIGNAL_OBJECT_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_RIGHT],
			vehicleid,
			-BlinkOffset[vehicle_model][bX],BlinkOffset[vehicle_model][bY],BlinkOffset[vehicle_model][bZ], // Offsets
			0.0, 0.0, 0.0 // Rotations
		);

		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_RIGHT],
			vehicleid,
			-BlinkOffset[vehicle_model][brX],BlinkOffset[vehicle_model][brY],BlinkOffset[vehicle_model][brZ], // Offsets
			0.0, 0.0, 180.0 // Rotations
		);
	}

	return 1;
}

/*
stock AddVehicleTurnSignals(vehicleid, E_TURN_SIGNAL_STATE:turn_signal)
{
	new
		vehicle_model;

	if ((vehicle_model = GetVehicleModel(vehicleid)) == 0)
		return 0;

	if (!IsACar(vehicleid))
		return 0;

	new
		Float:x,
		Float:y,
		Float:z;

	GetVehicleModelInfo(vehicle_model, VEHICLE_MODEL_INFO_SIZE, x, y, z);

	if (turn_signal & EI_TURN_SIGNAL_LEFT) {
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_LEFT] =
			CreateObject(
			TDW_SIGNAL_OBJECT_ID,
			0.0, 0.0, 0.0,
			0.0, 0.0, 0.0, // Rotations
			0.0 // DrawDistance
		);
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_LEFT] =
			CreateObject(
			TDW_SIGNAL_OBJECT_ID,
			0.0, 0.0, 0.0,
			0.0, 0.0, 0.0, // Rotations
			0.0 // DrawDistance
		);
		AttachObjectToVehicle( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_LEFT], vehicleid,
			-x / 2.15, y / 2.15, 0.1, // Offsets 	//-x / 2.23, y / 2.23, 0.1, // Offsets
			0.0, 0.0, 0.0 // Rotations
		);
		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_LEFT],
			vehicleid,
			-x / 2.23, -y / 2.23, 0.1, // Offsets
			0.0, 0.0, 0.0 // Rotations
		);
	}
	if (turn_signal & EI_TURN_SIGNAL_RIGHT) {
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_RIGHT] =
			CreateObject(
			TDW_SIGNAL_OBJECT_ID,
			0.0, 0.0, 0.0,
			0.0, 0.0, 0.0, // Rotations
			0.0 // DrawDistance
		);
		TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_RIGHT] =
			CreateObject(
			TDW_SIGNAL_OBJECT_ID,
			0.0, 0.0, 0.0,
			0.0, 0.0, 0.0, // Rotations
			0.0 // DrawDistance
		);
		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_RIGHT],
			vehicleid,
			//x / 2.23, y / 2.23, 0.1, // Offsets
			x / 2.15, y / 2.15, 0.1, // Offsets
			0.0, 0.0, 0.0 // Rotations
		);

		AttachObjectToVehicle(
			TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_RIGHT],
			vehicleid,
			x / 2.23, -y / 2.23, 0.1, // Offsets
			0.0, 0.0, 0.0 // Rotations
		);
	}
	return 1;
}
*/

stock RemoveVehicleTurnSignals(vehicleid, E_TURN_SIGNAL_STATE:turn_signal) {

	/*if (!IsACar(vehicleid))
		return 0;*/

	if ((!IsACar(vehicleid) && !IsABike(vehicleid)) || !IsEngineVehicle(vehicleid))
		return 0;

	if ( ! IsValidVehicle ( vehicleid ) ) {

		return true ;
	}

	if (turn_signal & EI_TURN_SIGNAL_LEFT) {
		if ( IsValidObject ( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_LEFT] ) ) {
			DestroyObject(TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_LEFT]);
		}
		if ( IsValidObject ( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_LEFT] ) ) {
			DestroyObject(TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_LEFT]);
		}
	}
	if (turn_signal & EI_TURN_SIGNAL_RIGHT) {
		if ( IsValidObject ( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_RIGHT] ) ) {
			DestroyObject( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_FRONT_RIGHT]);
		}

		if ( IsValidObject ( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_RIGHT] ) ) {
			DestroyObject( TDW_g_sVehicleObjects[vehicleid][EI_TURN_SIGNAL_BACK_RIGHT]);
		}
	}
	
    E_VEHICLE_BLINKER_STATE [ vehicleid ] = EI_TURN_SIGNAL_NONE ;
	return 1;

}