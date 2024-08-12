enum E_ADDRESS_DATA {
	E_ADDRESS_NAME [ 128 ], 
	Float: E_ADDRESS_MIN_X,
	Float: E_ADDRESS_MIN_Y,
	Float: E_ADDRESS_MAX_X,
	Float: E_ADDRESS_MAX_Y
} ;


new Address [ ] [ E_ADDRESS_DATA ] = 
{
	{ "Ronald Reagan Federal Plaza", 929.4,			-1559.9,			1027.6,				-1504.0 },
	{ "Rockford Plaza",				1683.0,			-1723.0,			1754.0,				-1610.0 },
	{ "Grove Street",				2439.0,			-1726.0,			2544.0,				-1622.0 },
	{ "Grove Street",				2334.0,			-1726.0,			2439.0,				-1595.0 },
	{ "Grove Street",				2228.0,			-1725.0,			2334.0,				-1608.0 },
	{ "Southbridge Avenue",			2228.0,			-1848.0,			2407.0,				-1725.0 },
	{ "Southbridge Avenue",			2407.0,			-1744.0,			2623.0,				-1726.0 },
	{ "Alandele Avenue",			2422.0,			-1848.0,			2550.0,				-1744.0 },
	{ "Clifford Avenue",			2407.0,			-2042.0,			2422.0,				-1744.0 },
	{ "Alandele Avenue",			2470.0,			-1925.0,			2553.0,				-1848.0 },
	{ "Clifford Avenue",			2357.0,			-1965.0,			2406.0,				-1848.0 },
	{ "Clifford Avenue",			2422.0,			-1926.0,			2471.0,				-1848.0 },
	{ "Sampson Street",				2422.0,			-1943.0,			2718.0,				-1926.0 },
	{ "Sampson Street",				2422.0,			-1980.0,			2563.0,				-1943.0 },
	{ "Acacia Street",				2617.0,			-2041.0,			2709.0,				-1969.0 },
	{ "Sampson Street",				2617.0,			-1969.0,			2709.0,				-1943.0 },
	{ "Melrose Avenue",				2708.0,			-2152.0,			2721.0,				-1943.0 },
	{ "Melrose Avenue",				2718.0,			-1989.0,			2745.0,				-1898.0 },
	{ "Loma Avenue",				2745.0,			-1989.0,			2827.0,				-1898.0 },
	{ "Memphis Street",				2721.0,			-2040.0,			2820.0,				-1989.0 },
	{ "Terminal Street",			2721.0,			-2149.0,			2820.0,				-2040.0 },
	{ "Terminal Way",				2424.0,			-2148.0,			2709.0,				-2041.0 },
	{ "Westmont Avenue",			2088.0,			-1905.0,			2308.0,				-1887.0 },
	{ "Westmont Avenue",			2088.0,			-1957.0,			2207.0,				-1905.0 },
	{ "Westmont Avenue",			2088.0,			-1887.0,			2203.0,				-1853.0 },
	{ "Fremont Street",				2307.0,			-1964.0,			2358.0,				-1848.0 },
	{ "Westmont Avenue",			2237.0,			-1964.0,			2309.0,				-1905.0 },
	{ "Westmont Avenue",			2228.0,			-1887.0,			2307.0,				-1848.0 },
	{ "Arbutus Street",				2422.0,			-2042.0,			2565.0,				-1980.0 },
	{ "Arbutus Street",				2237.0,			-2039.0,			2407.0,				-1964.0 },
	{ "Alondra Street",				2202.0,			-1887.0,			2228.0,				-1614.0 },
	{ "Alondra Street",				2207.0,			-2039.0,			2237.0,				-1905.0 },
	{ "Winona Avenue",				1833.0,			-1760.0,			2202.0,				-1737.0 },
	{ "Gilmore Avenue",				2064.0,			-1957.0,			2088.0,				-1853.0 },
	{ "Gilmore Avenue",				2064.0,			-1853.0,			2099.0,				-1760.0 },
	{ "Palmwood Avenue",			2170.0,			-1737.0,			2202.0,				-1640.0 },
	{ "Palmwood Avenue",			2202.0,			-1614.0,			2229.0,				-1390.0 },
	{ "Palmwood Avenue",			2124.0,			-1638.0,			2203.0,				-1528.0 },
	{ "Winona Avenue",				2125.0,			-1737.0,			2170.0,				-1639.0 },
	{ "Crenshaw Avenue",			2098.0,			-1737.0,			2124.0,				-1393.0 },
	{ "Crenshaw Avenue",			2124.0,			-1531.0,			2172.0,				-1393.0 },
	{ "Gilmore Avenue",				2100.0,			-1853.0,			2203.0,				-1759.0 },
	{ "106th Street",				2037.0,			-1737.0,			2098.0,				-1610.0 },
	{ "107th Street",				1974.0,			-1737.0,			2037.0,				-1609.0 },
	{ "Arbot Vitae Street",			1831.0,			-1610.0,			2098.0,				-1530.0 },
	{ "Arbot Vitae Street",			1831.0,			-1736.0,			1928.0,				-1610.0 },
	{ "Martin L. King Drive",		1928.0,			-1736.0,			1976.0,				-1610.0 },
	{ "Dalerose Avenue",			1968.0,			-1859.0,			2064.0,				-1760.0 },
	{ "Imperial Avenue",			1872.0,			-1859.0,			1968.0,				-1760.0 },
	{ "Imperial Avenue",			1952.0,			-2161.0,			1974.0,				-1859.0 },
	{ "Pecado Boulevard",			1832.0,			-1945.0,			1952.0,				-1859.0 },
	{ "Pecado Boulevard",			1973.0,			-1945.0,			2064.0,				-1859.0 },
	{ "Artesia Avenue",				1808.0,			-1946.0,			1832.0,				-1530.0 },
	{ "Artesia Avenue",				1832.0,			-1860.0,			1873.0,				-1760.0 },
	{ "Imperial Avenue",			1974.0,			-2101.0,			2005.0,				-1945.0 },
	{ "Imperial Avenue",			1921.0,			-2043.0,			1952.0,				-1945.0 },
	{ "38th Street",				1830.0,			-2067.0,			1953.0,				-2043.0 },
	{ "38th Street",				1812.0,			-2044.0,			1921.0,				-1945.0 },
	{ "King's Avenue",				1810.0,			-2161.0,			1830.0,				-2043.0 },
	{ "38th Street",				1829.0,			-2104.0,			1951.0,				-2067.0 },
	{ "King's Avenue",				1830.0,			-2161.0,			1952.0,				-2104.0 },
	{ "28th Dead End",				1660.0,			-2161.0,			1811.0,				-2061.0 },
	{ "Newport Boulevard",			1660.0,			-2179.0,			2065.0,				-2161.0 },
	{ "Newport Boulevard",			1504.0,			-2104.0,			1569.0,				-1883.0 },
	{ "Newport Boulevard",			1591.0,			-2178.0,			1660.0,				-2099.0 },
	{ "Altura Street",				1698.0,			-1860.0,			1809.0,				-1770.0 },
	{ "El Pecado",					1701.0,			-1951.0,			1808.0,				-1860.0 },
	{ "El Pecado",					1662.0,			-2061.0,			1812.0,				-1948.0 },
	{ "Hill Street",				1697.0,			-1771.0,			1810.0,				-1630.0 },
	{ "Arbot Vitae Street",			1624.0,			-1630.0,			1808.0,				-1562.0 },
	{ "Lukas Avenue",				1636.0,			-1884.0,			1698.0,				-1630.0 },
	{ "Azalea Street",				1378.0,			-1883.0,			1636.0,				-1845.0 },
	{ "El Pecado",					1662.0,			-1951.0,			1701.0,				-1884.0 },
	{ "Chavez Avenue",				1544.0,			-1845.0,			1635.0,				-1739.0 },
	{ "Hill Street",				1414.0,			-1845.0,			1543.0,				-1742.0 },
	{ "Hill Street",				1317.0,			-1742.0,			1636.0,				-1702.0 },
	{ "Cesar Avenue",				1354.0,			-1845.0,			1414.0,				-1742.0 },
	{ "Central Street",				1317.0,			-1602.0,			1624.0,				-1562.0 },
	{ "Central Street",				1428.0,			-1562.0,			1594.0,				-1490.0 },
	{ "Station Avenue",				1368.0,			-1703.0,			1638.0,				-1602.0 },
	{ "Palmwood Avenue",			2172.0,			-1531.0,			2203.0,				-1393.0 },
	{ "Palmwood Avenue",			2229.0,			-1479.0,			2291.0,				-1394.0 },
	{ "Bronson Street",				2224.0,			-1555.0,			2337.0,				-1479.0 },
	{ "Bronson Street",				2228.0,			-1608.0,			2337.0,				-1554.0 },
	{ "Marlton Street",				2060.0,			-1488.0,			2098.0,				-1390.0 },
	{ "Marlton Street",				1861.0,			-1487.0,			2061.0,				-1344.0 },
	{ "Artesia Avenue",				1831.0,			-1529.0,			1861.0,				-1172.0 },
	{ "Voctoria Street",			1861.0,			-1344.0,			2061.0,				-1294.0 },
	{ "Degnan Street",				1861.0,			-1294.0,			2061.0,				-1244.0 },
	{ "Romona Avenue",				1869.0,			-1155.0,			2061.0,				-1105.0 },
	{ "Glen Park",					1861.0,			-1246.0,			2062.0,				-1155.0 },
	{ "Rosemont Avenue",			2061.0,			-1390.0,			2082.0,				-1105.0 },
	{ "Rosemont Avenue",			2082.0,			-1205.0,			2120.0,				-1105.0 },
	{ "Exton Street",				2082.0,			-1264.0,			2161.0,				-1205.0 },
	{ "Florence Avenue",			2120.0,			-1206.0,			2183.0,				-1111.0 },
	{ "Florence Avenue",			2161.0,			-1268.0,			2186.0,				-1205.0 },
	{ "Florence Avenue",			2154.0,			-1370.0,			2179.0,				-1264.0 },
	{ "Santa Rosalia Street",		2082.0,			-1393.0,			2267.0,				-1370.0 },
	{ "Santa Rosalia Street",		2082.0,			-1371.0,			2155.0,				-1331.0 },
	{ "Santa Rosalia Street",		2180.0,			-1371.0,			2267.0,				-1330.0 },
	{ "Washington Street",			2082.0,			-1332.0,			2157.0,				-1264.0 },
	{ "Washington Street",			2180.0,			-1331.0,			2268.0,				-1264.0 },
	{ "Exton Street",				2186.0,			-1264.0,			2265.0,				-1205.0 },
	{ "Jefferson Motel",			2183.0,			-1205.0,			2263.0,				-1139.0 },
	{ "Artesia Avenue",				1724.0,			-1434.0,			1831.0,				-1172.0 },
	{ "Evadonna Street",			1462.0,			-1434.0,			1724.0,				-1172.0 },
	{ "Marlton Street",				1462.0,			-1490.0,			1831.0,				-1434.0 },
	{ "Marlton Street",				1594.0,			-1530.0,			1832.0,				-1490.0 },
	{ "Marlton Street",				1594.0,			-1563.0,			1684.0,				-1530.0 },
	{ "Arbot Vitae Street",			1684.0,			-1564.0,			1809.0,				-1530.0 },
	{ "Arbot Vitae Street",			1861.0,			-1530.0,			2100.0,				-1488.0 },
	{ "Princeton Street",			1869.0,			-1105.0,			2064.0,				-1017.0 },
	{ "Princeton Street",			2064.0,			-1106.0,			2115.0,				-1017.0 },
	{ "Princeton Street",			2114.0,			-1111.0,			2177.0,				-1070.0 },
	{ "Princeton Street",			2178.0,			-1139.0,			2269.0,				-1095.0 },
	{ "Coronado S-Curve",			2115.0,			-1070.0,			2178.0,				-1017.0 },
	{ "Coronado S-Curve",			2177.0,			-1095.0,			2240.0,				-1031.0 },
	{ "Santa Ana Street",			1964.0,			-1017.0,			2178.0,				-923.0 },
	{ "Santa Ana Street",			2178.0,			-1031.0,			2240.0,				-923.0 },
	{ "Santa Ana Street",			2240.0,			-1096.0,			2269.0,				-923.0 },
	{ "Santa Ana Street",			2595.0,			-1144.0,			2718.0,				-1059.0 },
	{ "Santa Ana Street",			2269.0,			-1081.0,			2551.0,				-1059.0 },
	{ "Santa Ana Street",			2269.0,			-1140.0,			2314.0,				-1081.0 },
	{ "Clarissa Street",			2551.0,			-1083.0,			2595.0,				-1059.0 },
	{ "Clarissa Street",			2314.0,			-1144.0,			2595.0,				-1081.0 },
	{ "Santa Ana Street",			2269.0,			-1059.0,			2831.0,				-888.0 },
	{ "Claremont Street",			2374.0,			-1212.0,			2719.0,				-1144.0 },
	{ "Firmona Street",				2374.0,			-1269.0,			2718.0,				-1212.0 },
	{ "6th Street",					2374.0,			-1439.0,			2461.0,				-1269.0 },
	{ "Juniper Avenue",				2461.0,			-1439.0,			2548.0,				-1269.0 },
	{ "Laurel Avenue",				2548.0,			-1439.0,			2608.0,				-1269.0 },
	{ "San Pedro Avenue",			2608.0,			-1439.0,			2680.0,				-1269.0 },
	{ "San Pedro Avenue",			2608.0,			-1602.0,			2680.0,				-1439.0 },
	{ "Ferndale Avenue",			2265.0,			-1395.0,			2376.0,				-1140.0 },
	{ "Alexandria Avenue",			2291.0,			-1479.0,			2375.0,				-1394.0 },
	{ "Alexandria Avenue",			2337.0,			-1595.0,			2421.0,				-1479.0 },
	{ "54th Street",				2438.0,			-1598.0,			2609.0,				-1439.0 },
	{ "Cedar Street",				2374.0,			-1479.0,			2439.0,				-1436.0 },
	{ "Cedar Street",				2421.0,			-1595.0,			2439.0,				-1479.0 },
	{ "East Beach Boulevard",		2680.0,			-1644.0,			2870.0,				-1269.0 },
	{ "East Beach Boulevard",		2718.0,			-1270.0,			2859.0,				-1059.0 },
	{ "Vermont Street",				2623.0,			-1901.0,			2847.0,				-1644.0 },
	{ "Sampson Street",				2626.0,			-1926.0,			2718.0,				-1900.0 },
	{ "East Side Freeway",			2439.0,			-1624.0,			2684.0,				-1595.0 },
	{ "East Side Freeway",			2626.0,			-1644.0,			2680.0,				-1625.0 },
	{ "Grove Street Sewers",		2544.0,			-1726.0,			2623.0,				-1622.0 },
	{ "Ganton Sewers",				2550.0,			-1848.0,			2623.0,				-1744.0 },
	{ "Willowfield Sewers",			2553.0,			-1925.0,			2625.0,				-1848.0 },
	{ "Willowfield Sewers",			2563.0,			-2042.0,			2619.0,				-1943.0 },
	{ "Toledo Street",				1974.0,			-2162.0,			2064.0,				-2101.0 },
	{ "Toledo Street",				2064.0,			-2177.0,			2207.0,				-1957.0 },
	{ "Toledo Street",				2005.0,			-2101.0,			2064.0,				-1945.0 },
	{ "Seaside Boulevard",			2207.0,			-2149.0,			2423.0,				-2039.0 },
	{ "Seaside Boulevard",			2207.0,			-2178.0,			2390.0,				-2149.0 },
	{ "Shoreline Drive",			2075.0,			-2365.0,			2244.0,				-2177.0 },
	{ "Shoreline Drive",			2244.0,			-2286.0,			2390.0,				-2177.0 },
	{ "Los Santos Docks",			2346.0,			-2724.0,			2878.0,				-2286.0 },
	{ "Shoreline Drive",			2244.0,			-2366.0,			2346.0,				-2286.0 },
	{ "Shoreline Drive",			2120.0,			-2723.0,			2346.0,				-2365.0 },
	{ "Shoreline Drive",			2390.0,			-2286.0,			2795.0,				-2148.0 },
	{ "Los Santos Airport",			2075.0,			-2783.0,			2120.0,				-2365.0 },
	{ "Los Santos Airport",			1256.0,			-2783.0,			2075.0,				-2179.0 },
	{ "Verdant Hill",				1069.0,			-2103.0,			1504.0,				-1883.0 },
	{ "Newport Boulevard",			1504.0,			-2181.0,			1591.0,				-2104.0 },
	{ "Verdant Hill",				1027.0,			-2340.0,			1256.0,				-2103.0 },
	{ "Verdant Hill",				1256.0,			-2179.0,			1504.0,				-2102.0 },
	{ "Newport Boulevard",			1569.0,			-2102.0,			1661.0,				-1883.0 },
	{ "East Beach Freeway",			2831.0,			-1059.0,			2933.0,				-715.0 },
	{ "East Beach Freeway",			2859.0,			-1271.0,			2955.0,				-1059.0 },
	{ "East Beach Freeway",			2870.0,			-1645.0,			2979.0,				-1269.0 },
	{ "East Beach Freeway",			2847.0,			-1901.0,			2984.0,				-1644.0 },
	{ "East Beach Freeway",			2820.0,			-2151.0,			2982.0,				-1898.0 },
	{ "East Beach Freeway",			2789.0,			-2287.0,			2980.0,				-2148.0 },
	{ "Fountain Avenue",			1568.0,			-1171.0,			1869.0,				-1017.0 },
	{ "Allison Avenue",				1387.0,			-1172.0,			1568.0,				-994.0 },
	{ "Main Street",				1342.0,			-1119.0,			1387.0,				-941.0 },
	{ "Main Street",				1333.0,			-1174.0,			1388.0,				-1119.0 },
	{ "Main Street",				1332.0,			-1490.0,			1462.0,				-1172.0 },
	{ "Main Street",				1292.0,			-1844.0,			1317.0,				-1562.0 },
	{ "Main Street",				1317.0,			-1702.0,			1368.0,				-1602.0 },
	{ "Main Street",				1317.0,			-1842.0,			1357.0,				-1742.0 },
	{ "Main Street",				1292.0,			-1562.0,			1428.0,				-1491.0 },
	{ "Temple Drive",				970.00,			-1047.0,			1342.0,				-1003.0 },
	{ "Leona Avenue",				1055.0,			-1123.0,			1119.0,				-1047.0 },
	{ "Leona Avenue",				970.00,			-1124.0,			1054.0,				-1047.0 },
	{ "St. Nicholas Avenue",		1119.0,			-1123.0,			1207.0,				-1047.0 },
	{ "Monterey Avenue",			1207.0,			-1123.0,			1342.0,				-1047.0 },
	{ "Monterey Avenue",			1207.0,			-1004.0,			1342.0,				-941.0 },
	{ "St. Nicholas Avenue",		1119.0,			-1003.0,			1207.0,				-963.0 },
	{ "Leona Avenue",				1053.0,			-1004.0,			1120.0,				-962.0 },
	{ "Sunset Boulevard",			803.00,			-1167.0,			1333.0,				-1123.0 },
	{ "Alta Avenue",				886.00,			-1123.0,			970.00, 			-986.0 },
	{ "Alta Avenue",				969.00,			-1003.0,			1053.0,				-962.0 },
	{ "Alta Avenue",				803.00,			-1123.0,			887.00, 			-1055.0 },
	{ "Redmont Avenue",				1067.0,			-1293.0,			1333.0,				-1167.0 },
	{ "Medina Avenue",				1066.0,			-1390.0,			1220.0,				-1293.0 },
	{ "Hopkins Avenue",				1220.0,			-1390.0,			1333.0,				-1293.0 },
	{ "Market Street",				647.00,			-1430.0,			1332.0,				-1390.0 },
	{ "Market Street",				647.00,			-1390.0,			1066.0,				-1374.0 },
	{ "Normandie Avenue",			952.00,			-1315.0,			1066.0,				-1167.0 },
	{ "Galloway Street",			803.00,			-1375.0,			1066.0,				-1315.0 },
	{ "Idaho Avenue",				803.00,			-1316.0,			953.00, 			-1167.0 },
	{ "Waterford Street",			646.00,			-1375.0,			803.00, 			-1212.0 },
	{ "Waterford Street",			723.00,			-1212.0,			803.00, 			-1068.0 },
	{ "Waterford Street",			675.00,			-1212.0,			723.00, 			-1166.0 },
	{ "Midred Avenue",				724.00,			-1578.0,			849.00, 			-1430.0 },
	{ "Alamosa Avenue",				849.00,			-1562.0,			971.00, 			-1430.0 },
	{ "Alamosa Avenue",				906.00,			-1757.0,			1028.0,				-1581.0 },
	{ "Pico Boulevard",				784.00,			-1756.0,			906.00, 			-1578.0 },
	{ "Pico Boulevard",				849.00,			-1581.0,			1028.0,				-1562.0 },
	{ "Pico Boulevard",				971.00,			-1562.0,			1035.0,				-1524.0 },
	{ "Lorena Street",				971.00,			-1525.0,			1036.0,				-1430.0 },
	{ "Aurora Avenue",				719.00,			-1756.0,			784.00, 			-1578.0 },
	{ "Dupont Street",				648.00,			-1754.0,			719.00, 			-1578.0 },
	{ "Rodeo Boulevard",			648.00,			-1578.0,			726.00, 			-1430.0 },
	{ "Rodeo Boulevard",			617.00,			-1757.0,			650.00, 			-1220.0 },
	{ "Rodeo Boulevard",			552.00,			-1577.0,			617.00, 			-1426.0 },
	{ "Highland Avenue",			487.00,			-1577.0,			553.00, 			-1428.0 },
	{ "Calzada Street",				391.00,			-1723.0,			617.00, 			-1577.0 },
	{ "Calzada Street",				218.00,			-1670.0,			392.00, 			-1614.0 },
	{ "Lafayette Street",			218.00,			-1614.0,			391.00, 			-1558.0 },
	{ "Lafayette Street",			314.00,			-1558.0,			392.00, 			-1502.0 },
	{ "Lafayette Street",			391.00,			-1578.0,			487.00, 			-1502.0 },
	{ "Lafayette Street",			314.00,			-1502.0,			486.00, 			-1460.0 },
	{ "Lafayette Street",			365.00,			-1460.0,			488.00, 			-1418.0 },
	{ "Lafayette Street",			487.00,			-1428.0,			617.00, 			-1399.0 },
	{ "Sunset Boulevard",			129.00,			-1558.0,			314.00, 			-1460.0 },
	{ "Sunset Boulevard",			180.00,			-1460.0,			365.00, 			-1366.0 },
	{ "Sunset Boulevard",			308.00,			-1366.0,			452.00, 			-1314.0 },
	{ "Cala Moreya Street",			365.00,			-1418.0,			488.00, 			-1366.0 },
	{ "Cala Moreya Street",			487.00,			-1399.0,			616.00, 			-1314.0 },
	{ "Cala Moreya Street",			452.00,			-1366.0,			486.00, 			-1314.0 },
	{ "Sunset Boulevard",			399.00,			-1314.0,			617.00, 			-1278.0 },
	{ "Sunset Boulevard",			454.00,			-1278.0,			617.00, 			-1240.0 },
	{ "Sunset Boulevard",			510.00,			-1240.0,			617.00, 			-1203.0 },
	{ "Sunset Boulevard",			616.00,			-1219.0,			676.00, 			-1178.0 },
	{ "Etrada Road",				123.00,			-1804.0,			391.00, 			-1670.0 },
	{ "Etrada Road",				391.00,			-1937.0,			617.00, 			-1723.0 },
	{ "Etrada Road",				617.00,			-1936.0,			1031.0,				-1754.0 },
	{ "Los Santos Lighthouse",		123.00,			-1983.0,			189.00, 			-1804.0 },
	{ "The Pier",					391.00,			-2099.0,			418.00, 			-1997.0 },
	{ "The Pier",					324.00,			-2099.0,			391.00, 			-1804.0 },
	{ "Empty Pier",					811.00,			-2077.0,			862.00, 			-1936.0 },
	{ "South Beach",				189.00,			-1926.0,			325.00, 			-1804.0 },
	{ "Etrada Road",				84.000, 		-1670.0,			218.00, 			-1559.0 },
	{ "Etrada Road",				84.000, 		-1786.0,			124.00, 			-1670.0 },
	{ "Somera Road",				38.000, 		-1558.0,			129.00, 			-1460.0 },
	{ "Somera Road",				37.000, 		-1460.0,			180.00, 			-1365.0 },
	{ "Somera Road",				165.00,			-1366.0,			308.00, 			-1313.0 },
	{ "Somera Road",				165.00,			-1314.0,			400.00, 			-1276.0 },
	{ "Somera Road",				164.00,			-1278.0,			456.00, 			-1240.0 },
	{ "Somera Road",				164.00,			-1240.0,			512.00, 			-1202.0 },
	{ "Carmino Del Sol",			373.00,			-1203.0,			617.00, 			-1177.0 },
	{ "Carmino Del Sol",			461.00,			-1178.0,			675.00, 			-1124.0 },
	{ "Sunset Boulevard",			674.00,			-1166.0,			723.00, 			-1068.0 },
	{ "Carmino Del Sol",			556.00,			-1124.0,			675.00, 			-1070.0 },
	{ "Carmino Del Sol",			556.00,			-1070.0,			744.00, 			-1014.0 },
	{ "Sunset Boulevard",			742.00,			-1068.0,			803.00, 			-1014.0 },
	{ "Sunset Boulevard",			803.00,			-1055.0,			886.00, 			-987.0 },
	{ "Galicia Way",				164.00,			-1202.0,			373.00, 			-1033.0 },
	{ "Galicia Way",				373.00,			-1177.0,			461.00, 			-1033.0 },
	{ "Galicia Way",				461.00,			-1125.0,			556.00, 			-1033.0 },
	{ "Galicia Way",				164.00,			-1033.0,			557.00, 			-941.0 },
	{ "Galicia Way",				83.000, 		-1366.0,			164.00, 			-1033.0 },
	{ "Galicia Way",				556.00,			-1014.0,			803.00, 			-922.0 },
	{ "Sunset Boulevard",			803.00,			-987.00, 			969.00, 			-919.0 },
	{ "Sunset Boulevard",			969.00,			-963.00, 			1207.0,				-923.0 },
	{ "Sunset Boulevard",			1204.0,			-941.00, 			1387.0,				-862.0 },
	{ "Sunset Boulevard",			969.00,			-923.00, 			1208.0,				-862.0 },
	{ "Sunset Boulevard",			803.00,			-919.00, 			969.00, 			-879.0 },
	{ "Galicia Way",				556.00,			-922.00, 			803.00, 			-830.0 },
	{ "Galicia Way",				310.00,			-941.00, 			557.00, 			-849.0 },
	{ "Galicia Way",				802.00,			-879.00, 			969.00, 			-786.0 },
	{ "Galicia Way",				969.00,			-862.00, 			1200.0,				-786.0 },
	{ "Vinceza Road",				802.00,			-786.00, 			1130.0,				-608.0 },
	{ "Vinceza Road",				556.00,			-830.00, 			802.00, 			-704.0 },
	{ "Stradella Road",				1130.0,			-786.00, 			1561.0,				-616.0 },
	{ "Stradella Road",				1200.0,			-863.00, 			1561.0,				-786.0 },
	{ "Stradella Road",				1387.0,			-995.00, 			1562.0,				-862.0 },
	{ "Mulholland Intersection",	1561.0,			-1017.0,			1968.0,				-723.0 },
	{ "Olympia Ave",				1035.0,			-1565.0,			1237.0,				-1430.0 },
	{ "Main Street",				1237.0,			-1566.0,			1294.0,				-1430.0 },
	{ "Main Street",				1292.0,			-1491.0,			1332.0,				-1430.0 },
	{ "Orinda Street",				1028.0,			-1746.0,			1295.0,				-1565.0 },
	{ "Azalea Street",				1031.0,			-1882.0,			1298.0,				-1746.0 },
	{ "Azalea Street",				1298.0,			-1885.0,			1381.0,				-1842.0 },
	{ "Verdant Hill",				1028.0,			-2103.0,			1069.0,				-1882.0 },
	{ "Verdant Hill",				1028.0,			-2537.0,			1256.0,				-2340.0 },
	{ "Verdant Hill",				929.00,			-2384.0,			1027.0,				-1936.0 },
	{ "Cedros",						15811.0,		-16154.0,			16203.0,			-15823.0}
} ;

stock GetPlayerAddress(Float:x, Float:y, zone[], len = sizeof zone)
{
 	for(new i = 0; i != sizeof(Address); i++ )
 	{
		if(x >= Address[i][E_ADDRESS_MIN_X] && x <= Address[i][E_ADDRESS_MAX_X] &&
		 	y >= Address[i][E_ADDRESS_MIN_Y] && y <= Address[i][E_ADDRESS_MAX_Y])
		{
		    return format(zone, len, Address[i][E_ADDRESS_NAME], 0);
		}
	}
	return format(zone, len, "Unknown", 0);
}

stock GetPlayerAddressID(playerid)
{
	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

 	for(new i = 0; i != sizeof(Address); i++ )
 	{
		if(x >= Address[i][E_ADDRESS_MIN_X] && x <= Address[i][E_ADDRESS_MAX_X] &&
		 	y >= Address[i][E_ADDRESS_MIN_Y] && y <= Address[i][E_ADDRESS_MAX_Y])
		{
		    return i;
		}
	}
	return -1;
}

stock GetAddressFromID(i, zone[], len = sizeof zone)
{
	if (i > -1) return format(zone, len, Address[i][E_ADDRESS_NAME], 0);
	else return format(zone, len, "Unknown", 0);
}

stock GetAddressID(Float:x, Float:y)
{
 	for(new i = 0; i != sizeof(Address); i++ )
 	{
		if(x >= Address[i][E_ADDRESS_MIN_X] && x <= Address[i][E_ADDRESS_MAX_X] &&
		 	y >= Address[i][E_ADDRESS_MIN_Y] && y <= Address[i][E_ADDRESS_MAX_Y])
		{
		    return i;
		}
	}
	return -1;
}

CMD:whereami(playerid, params[]) {

	return cmd_address(playerid);
}
CMD:street(playerid, params[]) {

	return cmd_address(playerid);
}
CMD:address(playerid) {

	new address[ 64 ], zone [ 64 ] ;

	new Float:x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;
	GetPlayerAddress(x, y, address) ;
	GetCoords2DZone(x, y, zone, sizeof ( zone ));

	SendClientMessage(playerid, -1, sprintf("You're at %s, %s.", address, zone));

	return true ;
}