#define MAX_RMB_LINES 2000

static enum E_RMB
{
    E_RMB_MODEL,
    Float:E_RMB_X,
    Float:E_RMB_Y,
    Float:E_RMB_Z,
    Float:E_RMB_RADIUS,
    bool:E_RMB_BAD
}

//static RMBLines[MAX_RMB_LINES][E_RMB];
//static RMB_INDEX = 0;

SOLS_RemoveBuilding(playerid, modelid, Float:x, Float:y, Float:z, Float:radius)
{
    // print("SOLS RMB");

    /*
    RMBLines[RMB_INDEX][E_RMB_MODEL] = modelid;
    RMBLines[RMB_INDEX][E_RMB_X] = x;
    RMBLines[RMB_INDEX][E_RMB_Y] = y;
    RMBLines[RMB_INDEX][E_RMB_Z] = z;
    RMBLines[RMB_INDEX][E_RMB_RADIUS] = radius;
    
    new Float:distance;

    for (new i = 0; i < RMB_INDEX; i++)
    {
        if (RMBLines[i][E_RMB_MODEL] != modelid) continue;

        distance = GetDistanceBetweenPoints(x, y, z, RMBLines[i][E_RMB_X], RMBLines[i][E_RMB_Y], RMBLines[i][E_RMB_Z]);

        if (distance < 10.0)
        {
            RMBLines[RMB_INDEX][E_RMB_BAD] = true;
            break;
        }

        // printf("Removing (%d) %d at %.02f, %.02f, %.02f which is %.02fm away from (%d) %d at %.02f, %.02f, %.02f", RMB_INDEX, modelid, x, y, z, GetDistanceBetweenPoints(x, y, z, RMBLines[i][E_RMB_X], RMBLines[i][E_RMB_Y], RMBLines[i][E_RMB_Z]), i, RMBLines[i][E_RMB_MODEL], RMBLines[i][E_RMB_X], RMBLines[i][E_RMB_Y], RMBLines[i][E_RMB_Z]);
    }

    RMB_INDEX ++;
    */

    return RemoveBuildingForPlayer(playerid, modelid, x, y, z, radius);
}


Map_RemoveBuildings(playerid) {
    // Pizza Stack
    SOLS_RemoveBuilding(playerid, 1432, 2104.0156, -1812.4219, 12.6719, 50.0);
    SOLS_RemoveBuilding(playerid, 1408, 2099.8516, -1813.9063, 13.1016, 50.0);
    SOLS_RemoveBuilding(playerid, 5418, 2112.9375, -1797.0938, 19.3359, 0.25);

    // Idlegas Enex Ryhes
    SOLS_RemoveBuilding(playerid, 5535, 1918.8516, -1776.3281, 16.9766, 0.25); //LOD laepetrol1a
    SOLS_RemoveBuilding(playerid, 5409, 1918.8516, -1776.3281, 16.9766, 0.25); //laepetrol1a (IDLEGAS)
    // Ganton 24.7 ENEX Ryhes
    SOLS_RemoveBuilding(playerid, 17757, 2450.8750, -1757.3984, 16.0000, 0.25); //LOD market2_lae
    SOLS_RemoveBuilding(playerid, 17519, 2450.8750, -1757.3984, 16.0000, 0.25); //market2_lae (ganton24/7)

    // KACC Factory for Parts
    SOLS_RemoveBuilding(playerid, 985, 2497.4063, 2777.0703, 11.5313, 0.25);
    SOLS_RemoveBuilding(playerid, 986, 2497.4063, 2769.1094, 11.5313, 0.25);


    // Janichar Update 3! (Ganton Gym ENEX)
    SOLS_RemoveBuilding(playerid, 17758, 2260.0000, -1707.7344, 17.1719, 0.25);
    SOLS_RemoveBuilding(playerid, 1498, 2229.6641, -1720.4219, 12.5547, 0.25);
    SOLS_RemoveBuilding(playerid, 17515, 2260.0000, -1707.7344, 17.1719, 0.25);
    SOLS_RemoveBuilding(playerid, 17978, 2260.0000, -1707.7344, 17.1719, 0.25);

    // Willowfield PnS
    SOLS_RemoveBuilding(playerid, 3744, 2331.3828, -2001.6719, 15.0234, 0.25);
    SOLS_RemoveBuilding(playerid, 3744, 2313.0469, -2008.5391, 15.0234, 0.25);
    SOLS_RemoveBuilding(playerid, 1266, 2336.9141, -1987.6328, 21.8281, 0.25);
    SOLS_RemoveBuilding(playerid, 3574, 2313.0469, -2008.5391, 15.0234, 0.25);
    SOLS_RemoveBuilding(playerid, 3574, 2331.3828, -2001.6719, 15.0234, 0.25);
    SOLS_RemoveBuilding(playerid, 1260, 2336.9141, -1987.6328, 21.8281, 0.25);
  
    // ELS LOD FIX!
    SOLS_RemoveBuilding(playerid, 17754, 2402.3125, -1503.5938, 28.9922, 0.25);

    // ELS jewelry store
    SOLS_RemoveBuilding(playerid, -1 ,2846.0469, -1453.3281, 24.7969, 0.25);

    // Ganton Gym 2021
    //- Fixed floating graffiti at Little Mexico. (Add RMB)
    SOLS_RemoveBuilding(playerid, 4227, 1614.6328, -1862.2109, 14.0156, 0.25);

    // Removes a door for a garage in EC
    SOLS_RemoveBuilding(playerid, 5020, 1877.4141, -2096.5078, 14.0391, 0.25);

    // FAST FOODS
    SOLS_RemoveBuilding(playerid, -1, 2105.4885, -1806.3651, 13.5547, 20.0); // pizzastacks

    SOLS_RemoveBuilding(playerid, -1, 2419.7024, -1509.0459, 24.0000, 8.00); // ELS cluck (doors)
    SOLS_RemoveBuilding(playerid, -1, 2402.3125, -1503.5938, 28.9922, 0.25); // ELS cluck (building+lod)

    SOLS_RemoveBuilding(playerid, -1, 2397.7568, -1899.1840, 13.5469, 3.0); // cluck2 (doors)
    SOLS_RemoveBuilding(playerid, -1, 2401.5962, -1904.2756, 13.5489, 5.0); // cluck2 (chairsntables)
    SOLS_RemoveBuilding(playerid, -1, 2385.1875, -1906.5156, 18.4453, 0.25); //
    SOLS_RemoveBuilding(playerid, 1527, 2392.3594, -1914.5703, 14.7422, 0.25); //g tag

    // Jefferson motel
    SOLS_RemoveBuilding(playerid, 5612, 2222.9922, -1162.6016, 30.0391, 0.25);
    SOLS_RemoveBuilding(playerid, 5413, 2222.9922, -1162.6016, 30.0391, 0.25);
    SOLS_RemoveBuilding(playerid, 1493, 2233.7188, -1160.5547, 24.8672, 0.25);

    // Donut Enex in Market
    SOLS_RemoveBuilding(playerid, 5975, 1014.0234, -1361.4609, 20.3516, 0.25);
    SOLS_RemoveBuilding(playerid, 5732, 1014.0234, -1361.4609, 20.3516, 0.25);
    SOLS_RemoveBuilding(playerid, 1522, 1038.9453, -1341.1484, 12.7188, 0.25);
    SOLS_RemoveBuilding(playerid, 5764, 1065.1406, -1270.5781, 25.7109, 0.25); // power lines

    return true ;
}
