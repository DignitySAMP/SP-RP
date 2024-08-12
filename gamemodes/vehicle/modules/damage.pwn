#include <YSI_Coding\y_hooks>

static veh_id, Float:veh_hp;
hook OnPlayerUpdate(playerid)
{
	// Temp code to stop cars blowing up
	if (IsPlayerInAnyVehicle(playerid))
	{
		veh_id = GetPlayerVehicleID(playerid);
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER && veh_id)
		{
			GetVehicleHealth(veh_id, veh_hp);

			if (veh_hp < 300 && !VehicleVar[veh_id][E_VEHICLE_CAN_EXPLODE])
			{
				veh_hp = 300;

				if (IsEngineVehicle(veh_id) && GetEngineStatus(veh_id))
				{
					SetEngineStatus(veh_id, false);

					new Float: vx, Float: vy, Float: vz;
					GetVehiclePos(veh_id, vx, vy, vz);

					ProxDetectorXYZ(vx, vy, vz, 0, GetPlayerVirtualWorld(playerid), 30.0, COLOR_PURPLE, sprintf("The engine of the %s shuts off with a bang.", ReturnVehicleName ( veh_id )));
					//ProxDetectorEx(playerid, 30.0, COLOR_PURPLE, "**", sprintf("The engine of the %s shuts off with a bang.", ReturnVehicleName ( veh_id )));

					ShowPlayerSubtitle( playerid, "~r~Your vehicle has been totalled!", .showtime = 5000 ) ;

					new Float:x, Float:y, Float:z, Float:ox, Float:oy, Float:oz;
					if (GetEnginePos(veh_id, x, y, z))
					{
						if (VehicleVar[veh_id][E_VEHICLE_FLAME_OBJECT] && IsValidDynamicObject(VehicleVar[veh_id][E_VEHICLE_FLAME_OBJECT]))
						{
							DestroyDynamicObject(VehicleVar[veh_id][E_VEHICLE_FLAME_OBJECT]);
						}

						z = z - 1.0;
						GetVehicleRelativePos(veh_id, ox, oy, oz, x, y, z);
						VehicleVar[veh_id][E_VEHICLE_FLAME_OBJECT] = CreateDynamicObject(18680, ox, oy, oz, 0.0, 0.0, 0.0);
						AttachDynamicObjectToVehicle(VehicleVar[veh_id][E_VEHICLE_FLAME_OBJECT], veh_id, x, y, z, 0.0, 0.0, 0.0);

						defer DeleteVehicleFlame(veh_id);
					}
				}

				new veh_enum_id = Vehicle_GetEnumID(veh_id);
				if (veh_enum_id)
				{
					SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], veh_hp);
		    		Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] = veh_hp;
				}
			}
		}
	}

    return 1;
}

timer DeleteVehicleFlame[5000](vehicleid) 
{
	if (VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT] && IsValidDynamicObject(VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT]))
	{
		DestroyDynamicObject(VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT]);
		VehicleVar[vehicleid][E_VEHICLE_FLAME_OBJECT] = 0;
	}

    return true ;
}

// Temp engine offsets
static enum E_ENGINE_OFFSET
{
	E_ENGINE_OFFSET_MODEL,
	Float:E_ENGINE_OFFSET_X,
	Float:E_ENGINE_OFFSET_Y,
	Float:E_ENGINE_OFFSET_Z
}

static const EngineOffsets[][E_ENGINE_OFFSET] = { {400,  0.00, 1.54, -0.04}, {401,  0.00, 1.77, 0.14}, {402,  0.00, 1.47, 0.14}, {403,  0.00, 3.30, 0.40}, {404,  0.00, 1.61, 0.12}, {405,  0.00, 1.72, -0.11}, {406,  -0.01, 4.97, 0.89}, {407,  0.00, 3.95, -0.08}, {408,  0.00, 4.40, -0.16}, {409,  0.00, 2.73, 0.18}, {410,  0.00, 1.55, 0.09}, {411,  0.00, 1.82, 0.09}, {412,  0.00, 1.64, 0.13}, {413,  0.00, 2.16, -0.01}, {414,  0.00, 2.36, 0.19}, {415,  0.00, -1.60, 0.03}, {416,  0.00, 2.54, 0.11}, {417,  0.00, 1.55, 2.32}, {418,  0.00, 2.00, 0.08}, {419,  0.00, 1.53, 0.12}, {420,  0.00, 1.61, 0.22}, {421,  0.00, 2.00, -0.11}, {422,  0.00, 1.71, -0.01}, {423,  0.00, 2.04, 0.24}, {424,  -0.03, -1.60, 0.06}, {426,  0.00, 1.61, 0.18}, {427,  0.00, 2.65, 0.25}, {428,  0.00, 2.36, 0.06}, {429,  0.00, 1.37, 0.21}, {431,  0.00, -5.48, -0.01}, {433,  0.00, 2.98, 0.28}, {434,  -0.06, 1.65, -0.07}, {436,  0.00, 1.88, -0.04}, {437,  0.00, -5.13, -0.85}, {438,  0.00, 1.82, 0.10}, {439,  0.00, 1.54, 0.06}, {440,  0.00, 2.01, -0.08}, {442,  0.00, 1.98, -0.04}, {443,  0.00, 5.17, 0.30}, {444,  0.00, 1.95, 0.97}, {445,  0.00, 1.65, 0.20}, {446,  0.00, -2.70, 0.66}, 
	{448,  0.00, -0.89, -0.22}, {451,  0.00, -1.53, 0.31}, {453,  0.84, 3.42, 1.83}, {454,  0.00, -4.71, 0.00}, {455,  0.07, 3.68, 0.60}, {456,  -0.02, 3.11, 0.39}, {457,  0.00, 0.96, 0.11}, {458,  0.00, 1.81, -0.10}, {459,  0.00, 2.16, -0.01}, {460,  0.00, 2.48, 0.22}, {461,  0.00, 0.00, 0.00}, {462,  0.00, -0.89, -0.22}, {463,  0.00, 0.22, 0.05}, 
	{466,  0.00, 1.62, 0.21}, {467,  0.00, 1.72, 0.21}, {468,  0.00, 0.18, 0.03}, {470,  0.00, 1.48, 0.13}, {472,  -0.44, -3.49, 0.23}, {474,  0.00, 1.62, 0.27}, {475,  0.00, 1.54, 0.15}, {476,  0.46, 2.13, -0.15}, {477,  0.00, 1.55, -0.06}, {478,  0.00, 1.56, 0.07}, {479,  0.02, 1.70, 0.26}, {480,  0.00, 1.30, 0.13}, {482,  0.00, 2.04, -0.09}, {483,  0.00, -2.74, -0.54}, {485,  0.00, 1.21, 0.40}, {486,  0.00, -3.19, 0.61}, {489,  0.00, 1.72, 0.19}, {490,  -0.01, 2.26, 0.21}, {491,  0.00, 1.49, -0.03}, {492,  0.00, 1.64, 0.23}, {493,  0.00, -2.66, 0.92}, {494,  0.00, 1.62, -0.16}, {495,  -0.06, 1.68, 0.19}, {496,  0.00, 1.51, 0.16}, {498,  -0.21, 2.76, 0.42}, {499,  0.00, 1.90, 0.01}, {500,  0.00, 1.43, -0.09}, {502,  0.00, 1.62, -0.13}, {503,  0.00, 1.46, -0.13}, {504,  0.00, 1.62, 0.21}, {505,  0.00, 1.72, 0.19}, {506,  0.00, 1.22, -0.07}, {507,  0.00, 1.78, 0.13}, {508,  0.00, 2.72, 0.03}, {511,  -2.92, 0.52, 0.49}, {513,  0.00, 1.80, 0.01}, {514,  0.00, 3.32, 0.27}, {515,  0.00, 3.83, 0.23}, {516,  0.00, 1.82, 0.00}, {517,  0.00, 1.78, -0.06}, {518,  0.04, 1.81, 0.14}, {519,  1.42, -5.45, 0.39}, {520,  0.77, -2.34, -0.02}, {521,  0.00, 0.11, 0.07}, 
	{522,  0.00, 0.17, 0.05}, {523,  0.00, 0.11, 0.04}, {524,  0.00, 2.85, 0.07}, {525,  0.00, 2.35, 0.37}, {526,  0.00, 1.53, 0.10}, {527,  0.00, 1.73, 0.01}, {528,  0.00, 1.69, 0.01}, {529,  0.03, 1.73, 0.13}, {530,  0.00, -0.96, -0.01}, {531,  -0.01, 0.89, 0.29}, {532,  -0.07, -1.84, 0.43}, {533,  0.53, 1.67, 0.20}, {534,  0.00, 1.86, -0.01}, {535,  0.00, 1.72, 0.12}, {536,  0.00, 1.69, 0.08}, {540,  0.00, 1.80, -0.47}, {541,  0.00, -0.98, 0.45}, {542,  0.00, 1.51, -0.03}, {543,  0.00, 1.58, 0.20}, {544,  0.00, 3.48, 0.18}, {545,  0.00, 0.98, 0.28}, {546,  0.00, 1.75, 0.09}, {547,  0.00, 1.63, -0.01}, {549,  0.00, 1.74, -0.36}, {550,  0.04, 1.87, 0.00}, {551,  0.00, 1.99, -0.01}, {552,  -0.11, 2.26, 0.62}, {553,  3.91, 5.61, -0.89}, {554,  0.01, 1.67, 0.30}, {555,  0.00, 1.53, -0.33}, {557,  0.00, 1.81, 0.84}, {558,  0.00, 1.35, -0.25}, {559,  0.02, 1.51, 0.13}, {560,  0.04, 1.73, 0.07}, {561,  0.09, 1.97, 0.01}, {562,  0.00, 1.92, 0.08}, {563,  1.02, -2.44, 1.23}, {565,  -0.06, 1.73, -0.08}, {566,  0.00, 1.71, 0.26}, {567,  0.00, 1.99, 0.03}, {568,  0.00, -0.98, 0.05}, {571,  0.32, -0.47, -0.14}, {572,  0.00, 0.55, 0.17}, {573,  0.00, 3.14, 0.20}, 
	{574,  0.00, -0.61, 0.03}, {575,  0.00, 1.61, 0.34}, {576,  0.00, 1.59, 0.31}, {578,  0.00, 4.48, -0.53}, {579,  0.00, 1.58, 0.29}, {580,  -0.02, 2.18, 0.26}, {581,  0.00, 0.14, 0.03}, {582,  0.00, 2.08, 0.02}, {583,  0.00, 0.73, 0.51}, {583,  -0.01, 1.47, 0.59}, {585,  0.00, 2.28, 0.20}, {586,  0.00, 0.14, 0.02}, {587,  0.00, 1.46, -0.11}, {588,  0.00, -4.07, -0.14}, {589,  0.00, 1.81, 0.27}, {593,  0.00, 2.45, 0.07}, {595,  0.48, -3.57, 0.30}, {596,  0.00, 1.61, 0.18}, {597,  0.00, 1.61, 0.20}, {598,  0.00, 1.57, 0.26}, {600,  0.00, 1.83, -0.34}, {601,  -0.38, -2.59, 1.00}, {602,  0.00, 1.52, 0.12}, {603,  0.00, 1.60, -0.09}, {604,  0.00, 1.62, 0.21}, {605,  0.00, 1.58, 0.20}, {609,  -0.21, 2.76, 0.42} };

static GetEnginePos(vehicleid, &Float:x, &Float:y, &Float:z)
{
	new model = GetVehicleModel(vehicleid);
	for (new i = 0; i < sizeof(EngineOffsets); i++)
	{
		if (EngineOffsets[i][E_ENGINE_OFFSET_MODEL] != model) continue;

		x = EngineOffsets[i][E_ENGINE_OFFSET_X];
		y = EngineOffsets[i][E_ENGINE_OFFSET_Y];
		z = EngineOffsets[i][E_ENGINE_OFFSET_Z];
		
		return 1;
	}

	return 0;
}

// This stops cars randomly respawning via OnVehicleDeath, etc.
// TAKEN FROM RAKNET EXAMPLES PAGE

static VehicleDestroyed = 136;

stock IsVehicleUpsideDown(vehicleid)
{
    new Float:quat_w, Float:quat_x, Float:quat_y, Float:quat_z;
    GetVehicleRotationQuat(vehicleid, quat_w, quat_x, quat_y, quat_z);
    return (
        floatabs(
            atan2(
                2 * (quat_y * quat_z + quat_w * quat_x),
                quat_w * quat_w - quat_x * quat_x - quat_y * quat_y + quat_z * quat_z
            )
        ) > 90.0
    );
}

IRPC:VehicleDestroyed(playerid, BitStream:bs)
{
    new vehicleid;

    BS_ReadUint16(bs, vehicleid);

    if (GetVehicleModel(vehicleid) < 400)
    {
        return 0;
    }

    return OnVehicleRequestDeath(vehicleid, playerid);
}

forward OnVehicleRequestDeath(vehicleid, killerid);
public OnVehicleRequestDeath(vehicleid, killerid)
{
    new Float:health;

    GetVehicleHealth(vehicleid, health);

    if (health >= 250.0 && !IsVehicleUpsideDown(vehicleid))
    {
        return 0;
    }

    return 1;
}

#if !defined IsNaN
    #define IsNaN(%0) ((%0) != (%0))
#endif

const UNOCCUPIED_SYNC = 209;

IPacket:UNOCCUPIED_SYNC(playerid, BitStream:bs)
{
    new unoccupiedData[PR_UnoccupiedSync];
 
    BS_IgnoreBits(bs, 8); // ignore packetid (byte)
    BS_ReadUnoccupiedSync(bs, unoccupiedData);

    if ((
            IsNaN(unoccupiedData[PR_position][0]) ||
            IsNaN(unoccupiedData[PR_position][1]) ||
            IsNaN(unoccupiedData[PR_position][2]) ||
            IsNaN(unoccupiedData[PR_angularVelocity][0]) ||
            IsNaN(unoccupiedData[PR_angularVelocity][1]) ||
            IsNaN(unoccupiedData[PR_angularVelocity][2]) ||
            IsNaN(unoccupiedData[PR_velocity][0]) ||
            IsNaN(unoccupiedData[PR_velocity][1]) ||
            IsNaN(unoccupiedData[PR_velocity][2]) ||
            floatabs(unoccupiedData[PR_position][0]) >= 20000.0 ||
            floatabs(unoccupiedData[PR_position][1]) >= 20000.0 ||
            floatabs(unoccupiedData[PR_position][2]) >= 20000.0 ||
            floatabs(unoccupiedData[PR_angularVelocity][0]) >= 1.0 ||
            floatabs(unoccupiedData[PR_angularVelocity][1]) >= 1.0 ||
            floatabs(unoccupiedData[PR_angularVelocity][2]) >= 1.0 ||
            floatabs(unoccupiedData[PR_velocity][0]) >= 100.0 ||
            floatabs(unoccupiedData[PR_velocity][1]) >= 100.0 ||
            floatabs(unoccupiedData[PR_velocity][2]) >= 100.0
        ) || (
            unoccupiedData[PR_roll][0] * unoccupiedData[PR_direction][0] +
            unoccupiedData[PR_roll][1] * unoccupiedData[PR_direction][1] +
            unoccupiedData[PR_roll][2] * unoccupiedData[PR_direction][2] >= 0.000001
        ) || (
            floatabs(
                1.0 - VectorSize(
                    unoccupiedData[PR_roll][0],
                    unoccupiedData[PR_roll][1],
                    unoccupiedData[PR_roll][2]
                )
            ) >= 0.000001
        ) || (
            floatabs(
                1.0 - VectorSize(
                    unoccupiedData[PR_direction][0],
                    unoccupiedData[PR_direction][1],
                    unoccupiedData[PR_direction][2]
                )
            ) >= 0.000001
        )
    ) {
        return 0; // ignore bad packet
    }

    return 1;
}
