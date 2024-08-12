enum E_VENDING_MACHINE {
      	e_Model,
      	e_Interior,
		Float:e_PosX,
		Float:e_PosY,
		Float:e_PosZ,
		Float:e_RotX,
		Float:e_RotY,
		Float:e_RotZ,
		Float:e_FrontX,
		Float:e_FrontY
	}

new const Float:sc_VendingMachines[][E_VENDING_MACHINE] = {
		{E_VENDING_MACHINE_SPRUNK, 0, -862.82, 1536.60, 21.98, 0.00, 0.00, 180.00, -862.84, 1537.60},
		{E_VENDING_MACHINE_ECOLA, 0, 2271.72, -76.46, 25.96, 0.00, 0.00, 0.00, 2271.72, -77.46},
		{E_VENDING_MACHINE_SPRUNK, 0, 1277.83, 372.51, 18.95, 0.00, 0.00, 64.00, 1278.73, 372.07},
		{E_VENDING_MACHINE_ECOLA, 0, 662.42, -552.16, 15.71, 0.00, 0.00, 180.00, 662.41, -551.16},
		{E_VENDING_MACHINE_SPRUNK, 0, 201.01, -107.61, 0.89, 0.00, 0.00, 270.00, 200.01, -107.63},
		{E_VENDING_MACHINE_SPRUNK, 0, -253.74, 2597.95, 62.24, 0.00, 0.00, 90.00, -252.74, 2597.95},
		{E_VENDING_MACHINE_ECOLA, 0, -253.74, 2599.75, 62.24, 0.00, 0.00, 90.00, -252.74, 2599.75},
		{E_VENDING_MACHINE_ECOLA, 0, -76.03, 1227.99, 19.12, 0.00, 0.00, 90.00, -75.03, 1227.99},
		{E_VENDING_MACHINE_SPRUNK, 0, -14.70, 1175.35, 18.95, 0.00, 0.00, 180.00, -14.72, 1176.35},
		{E_VENDING_MACHINE_ECOLA, 7, 316.87, -140.35, 998.58, 0.00, 0.00, 270.00, 315.87, -140.36},
		{E_VENDING_MACHINE_SPRUNK, 17, 373.82, -178.14, 1000.73, 0.00, 0.00, 0.00, 373.82, -179.14},
		{E_VENDING_MACHINE_ECOLA, 17, 379.03, -178.88, 1000.73, 0.00, 0.00, 270.00, 378.03, -178.90},
		{E_VENDING_MACHINE_SPRUNK, 17, 495.96, -24.32, 1000.73, 0.00, 0.00, 180.00, 495.95, -23.32},
		{E_VENDING_MACHINE_ECOLA, 17, 500.56, -1.36, 1000.73, 0.00, 0.00, 0.00, 500.56, -2.36},
		{E_VENDING_MACHINE_SPRUNK, 17, 501.82, -1.42, 1000.73, 0.00, 0.00, 0.00, 501.82, -2.42},
		{E_VENDING_MACHINE_ECOLA, 0, -1455.11, 2591.66, 55.23, 0.00, 0.00, 180.00, -1455.13, 2592.66},
		{E_VENDING_MACHINE_SPRUNK, 0, 2352.17, -1357.15, 23.77, 0.00, 0.00, 90.00, 2353.17, -1357.15},
		{E_VENDING_MACHINE_SPRUNK, 0, 2325.97, -1645.13, 14.21, 0.00, 0.00, 0.00, 2325.97, -1646.13},
		{E_VENDING_MACHINE_ECOLA, 0, 2139.51, -1161.48, 23.35, 0.00, 0.00, 87.00, 2140.51, -1161.53},
		{E_VENDING_MACHINE_ECOLA, 0, 2153.23, -1016.14, 62.23, 0.00, 0.00, 127.00, 2154.03, -1015.54},
		{E_VENDING_MACHINE_SPRUNK, 0, 1928.73, -1772.44, 12.94, 0.00, 0.00, 90.00, 1929.73, -1772.44},
		{E_VENDING_MACHINE_ECOLA, 1, 2222.36, 1602.64, 1000.06, 0.00, 0.00, 90.00, 2223.36, 1602.64},
		{E_VENDING_MACHINE_SPRUNK, 1, 2222.20, 1606.77, 1000.05, 0.00, 0.00, 90.00, 2223.20, 1606.77},
		{E_VENDING_MACHINE_SPRUNK, 1, 2155.90, 1606.77, 1000.05, 0.00, 0.00, 90.00, 2156.90, 1606.77},
		{E_VENDING_MACHINE_SPRUNK, 1, 2209.90, 1607.19, 1000.05, 0.00, 0.00, 270.00, 2208.90, 1607.17},
		{E_VENDING_MACHINE_ECOLA, 1, 2155.84, 1607.87, 1000.06, 0.00, 0.00, 90.00, 2156.84, 1607.87},
		{E_VENDING_MACHINE_ECOLA, 1, 2202.45, 1617.00, 1000.06, 0.00, 0.00, 180.00, 2202.43, 1618.00},
		{E_VENDING_MACHINE_ECOLA, 1, 2209.24, 1621.21, 1000.06, 0.00, 0.00, 0.00, 2209.24, 1620.21},
		{E_VENDING_MACHINE_ECOLA, 3, 330.67, 178.50, 1020.07, 0.00, 0.00, 0.00, 330.67, 177.50},
		{E_VENDING_MACHINE_ECOLA, 3, 331.92, 178.50, 1020.07, 0.00, 0.00, 0.00, 331.92, 177.50},
		{E_VENDING_MACHINE_ECOLA, 3, 350.90, 206.08, 1008.47, 0.00, 0.00, 90.00, 351.90, 206.08},
		{E_VENDING_MACHINE_ECOLA, 3, 361.56, 158.61, 1008.47, 0.00, 0.00, 180.00, 361.54, 159.61},
		{E_VENDING_MACHINE_ECOLA, 3, 371.59, 178.45, 1020.07, 0.00, 0.00, 0.00, 371.59, 177.45},
		{E_VENDING_MACHINE_ECOLA, 3, 374.89, 188.97, 1008.47, 0.00, 0.00, 0.00, 374.89, 187.97},
		{E_VENDING_MACHINE_SPRUNK, 2, 2576.70, -1284.43, 1061.09, 0.00, 0.00, 270.00, 2575.70, -1284.44},
		{E_VENDING_MACHINE_SPRUNK, 15, 2225.20, -1153.42, 1025.90, 0.00, 0.00, 270.00, 2224.20, -1153.43},
		{E_VENDING_MACHINE_SPRUNK, 0, 1154.72, -1460.89, 15.15, 0.00, 0.00, 270.00, 1153.72, -1460.90},
		{E_VENDING_MACHINE_ECOLA, 0, 2480.85, -1959.27, 12.96, 0.00, 0.00, 180.00, 2480.84, -1958.27},
		{E_VENDING_MACHINE_SPRUNK, 0, 2060.11, -1897.64, 12.92, 0.00, 0.00, 0.00, 2060.11, -1898.64},
		{E_VENDING_MACHINE_SPRUNK, 0, 1729.78, -1943.04, 12.94, 0.00, 0.00, 0.00, 1729.78, -1944.04},
		{E_VENDING_MACHINE_ECOLA, 0, 1634.10, -2237.53, 12.89, 0.00, 0.00, 0.00, 1634.10, -2238.53},
		{E_VENDING_MACHINE_SPRUNK, 0, 1789.21, -1369.26, 15.16, 0.00, 0.00, 270.00, 1788.21, -1369.28},
		{E_VENDING_MACHINE_ECOLA, 0, -2229.18, 286.41, 34.70, 0.00, 0.00, 180.00, -2229.20, 287.41},
		{E_VENDING_MACHINE_SPRUNK, 256, -1980.78, 142.66, 27.07, 0.00, 0.00, 270.00, -1981.78, 142.64},
		{E_VENDING_MACHINE_SPRUNK, 256, -2118.96, -423.64, 34.72, 0.00, 0.00, 255.00, -2119.93, -423.40},
		{E_VENDING_MACHINE_SPRUNK, 256, -2118.61, -422.41, 34.72, 0.00, 0.00, 255.00, -2119.58, -422.17},
		{E_VENDING_MACHINE_SPRUNK, 256, -2097.27, -398.33, 34.72, 0.00, 0.00, 180.00, -2097.29, -397.33},
		{E_VENDING_MACHINE_SPRUNK, 256, -2092.08, -490.05, 34.72, 0.00, 0.00, 0.00, -2092.08, -491.05},
		{E_VENDING_MACHINE_SPRUNK, 256, -2063.27, -490.05, 34.72, 0.00, 0.00, 0.00, -2063.27, -491.05},
		{E_VENDING_MACHINE_SPRUNK, 256, -2005.64, -490.05, 34.72, 0.00, 0.00, 0.00, -2005.64, -491.05},
		{E_VENDING_MACHINE_SPRUNK, 256, -2034.46, -490.05, 34.72, 0.00, 0.00, 0.00, -2034.46, -491.05},
		{E_VENDING_MACHINE_SPRUNK, 256, -2068.56, -398.33, 34.72, 0.00, 0.00, 180.00, -2068.58, -397.33},
		{E_VENDING_MACHINE_SPRUNK, 256, -2039.85, -398.33, 34.72, 0.00, 0.00, 180.00, -2039.86, -397.33},
		{E_VENDING_MACHINE_SPRUNK, 256, -2011.14, -398.33, 34.72, 0.00, 0.00, 180.00, -2011.15, -397.33},
		{E_VENDING_MACHINE_SPRUNK, 2048, -1350.11, 492.28, 10.58, 0.00, 0.00, 90.00, -1349.11, 492.28},
		{E_VENDING_MACHINE_ECOLA, 2048, -1350.11, 493.85, 10.58, 0.00, 0.00, 90.00, -1349.11, 493.85},
		{E_VENDING_MACHINE_SPRUNK, 0, 2319.99, 2532.85, 10.21, 0.00, 0.00, 0.00, 2319.99, 2531.85},
		{E_VENDING_MACHINE_ECOLA, 0, 2845.72, 1295.04, 10.78, 0.00, 0.00, 0.00, 2845.72, 1294.04},
		{E_VENDING_MACHINE_SPRUNK, 0, 2503.14, 1243.69, 10.21, 0.00, 0.00, 180.00, 2503.12, 1244.69},
		{E_VENDING_MACHINE_ECOLA, 0, 2647.69, 1129.66, 10.21, 0.00, 0.00, 0.00, 2647.69, 1128.66},
		{E_VENDING_MACHINE_ECOLA, 0, -2420.21, 984.57, 44.29, 0.00, 0.00, 90.00, -2419.21, 984.57},
		{E_VENDING_MACHINE_ECOLA, 0, -2420.17, 985.94, 44.29, 0.00, 0.00, 90.00, -2419.17, 985.94},
		{E_VENDING_MACHINE_SPRUNK, 0, 2085.77, 2071.35, 10.45, 0.00, 0.00, 90.00, 2086.77, 2071.35},
		{E_VENDING_MACHINE_ECOLA, 0, 1398.84, 2222.60, 10.42, 0.00, 0.00, 180.00, 1398.82, 2223.60},
		{E_VENDING_MACHINE_ECOLA, 0, 1659.46, 1722.85, 10.21, 0.00, 0.00, 0.00, 1659.46, 1721.85},
		{E_VENDING_MACHINE_SPRUNK, 0, 1520.14, 1055.26, 10.00, 0.00, 0.00, 270.00, 1519.14, 1055.24},
		{E_VENDING_MACHINE_SPRUNK, 6, -19.03, -57.83, 1003.63, 0.00, 0.00, 180.00, -19.05, -56.83},
		{E_VENDING_MACHINE_SPRUNK, 18, -16.11, -91.64, 1003.63, 0.00, 0.00, 180.00, -16.13, -90.64},
		{E_VENDING_MACHINE_SPRUNK, 16, -15.10, -140.22, 1003.63, 0.00, 0.00, 180.00, -15.11, -139.22},
		{E_VENDING_MACHINE_SPRUNK, 17, -32.44, -186.69, 1003.63, 0.00, 0.00, 180.00, -32.46, -185.69},
		{E_VENDING_MACHINE_SPRUNK, 16, -35.72, -140.22, 1003.63, 0.00, 0.00, 180.00, -35.74, -139.22},
		{E_VENDING_MACHINE_ECOLA, 6, -36.14, -57.87, 1003.63, 0.00, 0.00, 180.00, -36.16, -56.87},
		{E_VENDING_MACHINE_ECOLA, 18, -17.54, -91.71, 1003.63, 0.00, 0.00, 180.00, -17.56, -90.71},
		{E_VENDING_MACHINE_ECOLA, 16, -16.53, -140.29, 1003.63, 0.00, 0.00, 180.00, -16.54, -139.29},
		{E_VENDING_MACHINE_ECOLA, 17, -33.87, -186.76, 1003.63, 0.00, 0.00, 180.00, -33.89, -185.76},

		// Custom LSFD
		{E_VENDING_MACHINE_ECOLA, 0, 1826.515, -1441.716, 12.95, 0.00, 0.00, 270.00, 1825.515, -1441.716}

		
	};
new s_VendingMachineObject[sizeof(sc_VendingMachines)] = {-1, ...};
new s_VendingMachineArea[sizeof(sc_VendingMachines)] = {-1, ...};

RemoveDefaultVendingMachines(playerid) {
	RemoveBuildingForPlayer(playerid, 955, 0.0, 0.0, 0.0, 20000.0); // CJ_EXT_SPRUNK
	RemoveBuildingForPlayer(playerid, 956, 0.0, 0.0, 0.0, 20000.0); // CJ_EXT_CANDY
	RemoveBuildingForPlayer(playerid, 1209, 0.0, 0.0, 0.0, 20000.0); // vendmach
	RemoveBuildingForPlayer(playerid, 1302, 0.0, 0.0, 0.0, 20000.0); // vendmachfd
	RemoveBuildingForPlayer(playerid, 1775, 0.0, 0.0, 0.0, 20000.0); // CJ_SPRUNK1
	RemoveBuildingForPlayer(playerid, 1776, 0.0, 0.0, 0.0, 20000.0); // CJ_CANDYVENDOR
	RemoveBuildingForPlayer(playerid, 1977, 0.0, 0.0, 0.0, 20000.0); // vendin3

	/*
	// Make sure they're all gone..
	for (new i = 0; i < sizeof(sc_VendingMachines); i++) {
		RemoveBuildingForPlayer(
			playerid,
			sc_VendingMachines[i][e_Model],
			sc_VendingMachines[i][e_PosX],
			sc_VendingMachines[i][e_PosY],
			sc_VendingMachines[i][e_PosZ],
			1.0
		);
	}*/
}

CreateVendingMachines() {

	for (new i = 0; i < sizeof(sc_VendingMachines); i++) {

		s_VendingMachineObject[i] = CreateDynamicObject(
			sc_VendingMachines[i][e_Model],
			sc_VendingMachines[i][e_PosX],
			sc_VendingMachines[i][e_PosY],
			sc_VendingMachines[i][e_PosZ],
			sc_VendingMachines[i][e_RotX],
			sc_VendingMachines[i][e_RotY],
			sc_VendingMachines[i][e_RotZ],
			.interiorid = sc_VendingMachines[i][e_Interior]
		);

		s_VendingMachineArea[i] = CreateDynamicCircle(
			sc_VendingMachines[i][e_PosX], 
			sc_VendingMachines[i][e_PosY], 
			2.0, 
			.interiorid = sc_VendingMachines[i][e_Interior] 
		); 
	}
}