/*  <SA-MP Objects Physics - Handle collisions and more.>
	Copyright (C) <2013>  <Peppe, Lorenc_>

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. */

#include <modelsizes>
#pragma compress 1

#if !defined PHY_TIMER_INTERVAL
	//#define PHY_TIMER_INTERVAL (50.0)
	#define PHY_TIMER_INTERVAL (30.0)
#endif
#if !defined PHY_MAX_OBJECTS
	#define PHY_MAX_OBJECTS (1024)
#endif
#if !defined PHY_MAX_WALLS
	#define PHY_MAX_WALLS (512)
#endif
#if !defined PHY_MAX_CYLINDERS
	#define PHY_MAX_CYLINDERS (512)
#endif

#define PHY_MODE_3D (0)
#define PHY_MODE_2D (1)

#if !defined FLOAT_INFINITY
	#define FLOAT_INFINITY   (Float:0x7F800000)
#endif
#if !defined FLOAT_NEG_INFINITY
	#define FLOAT_NEG_INFINITY (Float:0xFF800000)
#endif
#if !defined FLOAT_NAN
	#define FLOAT_NAN	 (Float:0xFFFFFFFF)
#endif

/* Callbacks */
forward PHY_OnObjectUpdate(handleid);
forward PHY_OnObjectCollideWithObject(handleid_a, handleid_b);
forward PHY_OnObjectCollideWithZBound(handleid, lowhigh); // low bound = 0, high bound = 1
forward PHY_OnObjectCollideWithWall(handleid, wallid);
forward PHY_OnObjectCollideWithCylinder(handleid, cylinderid);
forward PHY_OnObjectCollideWithPlayer(handleid, playerid);

enum E_PHY_OBJECT
{
	PHY_Created,
	PHY_DynamicObject,

	PHY_World,
	Float:PHY_Size,
	Float:PHY_Mass,
	Float:PHY_VX,
	Float:PHY_VY,
	Float:PHY_VZ,
	Float:PHY_AX,
	Float:PHY_AY,
	Float:PHY_AZ,
	Float:PHY_Friction,
	Float:PHY_AirResistance,
	Float:PHY_Gravity,
	Float:PHY_LowZBound,
	/*Float:PHY_LowZRX,
	Float:PHY_LowZRY,*/
	Float:PHY_HighZBound,
	Float:PHY_BoundConst,
	Float:PHY_PlayerConst,
	Float:PHY_PlayerDist,
	Float:PHY_PlayerLowZ,
	Float:PHY_PlayerHighZ,

	PHY_Mode,
	bool:PHY_Rolling,
	bool:PHY_Object_Ghost_Objects,
	bool:PHY_Object_Ghost_Walls,
	bool:PHY_Object_Ghost_Cylinders,
	bool:PHY_Object_Player_Collision
} ;

new
	PHY_Object[PHY_MAX_OBJECTS][E_PHY_OBJECT],
	Iterator:ITER_Object<PHY_MAX_OBJECTS>;

enum E_PHY_WALL
{
	PHY_Created,
	PHY_World,
	Float:PHY_X1,
	Float:PHY_Y1,
	Float:PHY_X2,
	Float:PHY_Y2,
	Float:PHY_Z1,
	Float:PHY_Z2,
	Float:PHY_BounceConst,
	Float:PHY_ANG
} ;

new
	PHY_Wall[PHY_MAX_WALLS][E_PHY_WALL],
	Iterator:ITER_Wall<PHY_MAX_WALLS>;


enum E_PHY_CYLINDER
{
	PHY_Created,
	PHY_World,
	Float:PHY_X,
	Float:PHY_Y,
	Float:PHY_Z1,
	Float:PHY_Z2,
	Float:PHY_Size,
	Float:PHY_BounceConst
} ;

new
	PHY_Cylinder[PHY_MAX_CYLINDERS][E_PHY_CYLINDER],
	Iterator:ITER_Cylinder<PHY_MAX_CYLINDERS>;


enum E_PHY_PLAYER
{
	PHY_World
} ;

new
	PHY_Player[MAX_PLAYERS][E_PHY_PLAYER];


/* Macros are self-explanatory */
#define PHY_IsHandleValid(%1) (%1 != ITER_NONE && Iter_Contains(ITER_Object, %1))
#define PHY_IsHandleUsing3D(%1) (PHY_Object[%1][PHY_Mode] == PHY_MODE_3D)
#define PHY_IsHandleGhostWithObjects(%1) (PHY_Object[%1][PHY_Object_Ghost_Objects])
#define PHY_IsHandleGhostWithWalls(%1) (PHY_Object[%1][PHY_Object_Ghost_Walls])
#define PHY_IsHandleGhostWithCylinders(%1) (PHY_Object[%1][PHY_Object_Ghost_Cylinders])
#define PHY_IsHandleCollidingWithPlayers(%1) (PHY_Object[%1][PHY_Object_Player_Collision])
#define PHY_IsHandleMoving(%1) (PHY_Object[%1][PHY_VX] != 0.0 || PHY_Object[%1][PHY_VY] != 0.0 || PHY_Object[%1][PHY_VZ] != 0.0)
#define PHY_IsHandleRolling(%1) (PHY_Object[%1][PHY_Rolling])
#define PHY_GetHandleFriction(%1) (PHY_Object[%1][PHY_Friction])
#define PHY_GetHandleAirResistance(%1) (PHY_Object[%1][PHY_AirResistance])
#define PHY_GetHandleGravity(%1) (PHY_Object[%1][PHY_Gravity])
#define PHY_GetHandleMode(%1) (PHY_Object[%1][PHY_Mode])
#define PHY_GetHandleObject(%1) (PHY_Object[%1][PHY_DynamicObject])


PHY_ScriptInit() {

	SetTimer("PHY_CoreTimer", floatround(PHY_TIMER_INTERVAL), true);
}

public OnPlayerConnect(playerid) {
	PHY_Player[playerid][PHY_World] = 0;

	#if defined physics_OnPlayerConnect
		return physics_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect physics_OnPlayerConnect
#if defined physics_OnPlayerConnect
	forward physics_OnPlayerConnect(playerid);
#endif

forward PHY_CoreTimer();
public PHY_CoreTimer()
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:x1,
		Float:y1,
		Float:z1,
		Float:xclosest,
		Float:yclosest,
		Float:x2,
		Float:y2,
		Float:z2,
		Float:speed,
		Float:dx,
		Float:dy,
		Float:dz,
		Float:dist,
		Float:maxdist,
		Float:angle,
		Float:moveangle,
		Float:dvx,
		Float:dvy,
		Float:dvz,
		Float:mag,
		Float:tmpvx,
		Float:tmpvy,
		Float:tmpvz,
		Float:newvy1,
		Float:newvy2,
		Float:newvx1,
		Float:newvx2,
		Float:newvz1,
		Float:newvz2;

 	foreach(new a : ITER_Object)
	{
		if (!Iter_Count(ITER_Object)) {
			printf("\n\n\n[DEBUG A] !!!! INFINITE LOOP %d %d !!!!\n\n\n", GetTickCount( ), Iter_Count(ITER_Object));
			return 1;
		}

		if(PHY_Object[a][PHY_Created])
		{
			new
				obj_a = PHY_Object[a][PHY_DynamicObject];

			GetDynamicObjectPos(obj_a, x, y, z);

			x1 = x + PHY_Object[a][PHY_VX] * (PHY_TIMER_INTERVAL/1000.0);
			y1 = y + PHY_Object[a][PHY_VY] * (PHY_TIMER_INTERVAL/1000.0);

			// 3D Mode
			if(PHY_GetHandleMode(a) == PHY_MODE_3D)
			{
				z1 = z + PHY_Object[a][PHY_VZ] * (PHY_TIMER_INTERVAL/1000.0);

				if(z1 > PHY_Object[a][PHY_HighZBound])
				{
					if(PHY_Object[a][PHY_VZ] > 0.0)
					{
						PHY_Object[a][PHY_VZ] = -PHY_Object[a][PHY_VZ] * PHY_Object[a][PHY_BoundConst];
						CallLocalFunction("PHY_OnObjectCollideWithZBound", "dd", a, 1);
					}
					z1 = PHY_Object[a][PHY_HighZBound];
				}
				else if(z1 < PHY_Object[a][PHY_LowZBound])
				{
					if(PHY_Object[a][PHY_VZ] < 0.0)
					{
						PHY_Object[a][PHY_VZ] = -PHY_Object[a][PHY_VZ] * PHY_Object[a][PHY_BoundConst];
						CallLocalFunction("PHY_OnObjectCollideWithZBound", "dd", a, 0.0);
					}
					z1 = PHY_Object[a][PHY_LowZBound];
				}
				if(PHY_GetHandleGravity(a) != 0.0)
				{
					if(PHY_Object[a][PHY_VZ] > 0.0)
					{
						PHY_Object[a][PHY_VZ] -= PHY_Object[a][PHY_Gravity] * (PHY_TIMER_INTERVAL/1000.0);
						if(PHY_Object[a][PHY_VZ] < 0.0)
							PHY_Object[a][PHY_VZ] = 0.0;
					}
					else
						PHY_Object[a][PHY_VZ] -= PHY_Object[a][PHY_Gravity] * (PHY_TIMER_INTERVAL/1000.0);
				}
			}
			else
				z1 = z;

			// 2D mode
			if(PHY_IsHandleMoving(a))
			{
				if(!PHY_IsHandleGhostWithObjects(a))
				{
					foreach(new b : ITER_Object)
					{
						if (!Iter_Count(ITER_Object)) {
							printf("\n\n\n[DEBUG B] !!!! INFINITE LOOP %d %d !!!!\n\n\n", GetTickCount( ), Iter_Count(ITER_Object));
							return 1;
						}

						if(PHY_Object[b][PHY_Created])
						{
							if(a != b && !PHY_IsHandleGhostWithObjects(b) && (!PHY_Object[a][PHY_World] || !PHY_Object[b][PHY_World] || PHY_Object[a][PHY_World] == PHY_Object[b][PHY_World]))
							{
								new
									obj_b = PHY_Object[b][PHY_DynamicObject];

								GetDynamicObjectPos(obj_b, x2, y2, z2);
								dx = x1 - x2;
								dy = y1 - y2;
								dz = (PHY_GetHandleMode(a) == PHY_MODE_3D && PHY_GetHandleMode(b) == PHY_MODE_3D) ? (z1 - z2) : (0.0);
								dist = (dx * dx) + (dy * dy) + (dz * dz);
								maxdist = PHY_Object[a][PHY_Size] + PHY_Object[b][PHY_Size];
								if(dist < (maxdist * maxdist))
								{
									dvx = PHY_Object[a][PHY_VX] - PHY_Object[b][PHY_VX];
									dvy = PHY_Object[a][PHY_VY] - PHY_Object[b][PHY_VY];
									dvz = PHY_Object[a][PHY_VZ] - PHY_Object[b][PHY_VZ];
									mag = dvx * dx + dvy * dy + dvz * dz;

									if(mag < 0.0)
									{
										newvx1 = PHY_Object[a][PHY_VX];
										newvy1 = PHY_Object[a][PHY_VY];
										newvz1 = PHY_Object[a][PHY_VZ];
										newvx2 = PHY_Object[b][PHY_VX];
										newvy2 = PHY_Object[b][PHY_VY];
										newvz2 = PHY_Object[b][PHY_VZ];

										projectVonU(PHY_Object[a][PHY_VX], PHY_Object[a][PHY_VY], PHY_Object[a][PHY_VZ], dx, dy, dz, tmpvx, tmpvy, tmpvz);
										newvx1 -= tmpvx;
										newvy1 -= tmpvy;
										newvz1 -= tmpvz;
										projectVonU(PHY_Object[b][PHY_VX], PHY_Object[b][PHY_VY], PHY_Object[b][PHY_VZ], -dx, -dy, -dz, tmpvx, tmpvy, tmpvz);
										tmpvx = ((PHY_Object[a][PHY_Mass] - PHY_Object[b][PHY_Mass]) * PHY_Object[a][PHY_VX] + 2 * PHY_Object[b][PHY_Mass] * tmpvx) / (PHY_Object[a][PHY_Mass] + PHY_Object[b][PHY_Mass]);
										tmpvy = ((PHY_Object[a][PHY_Mass] - PHY_Object[b][PHY_Mass]) * PHY_Object[a][PHY_VY] + 2 * PHY_Object[b][PHY_Mass] * tmpvy) / (PHY_Object[a][PHY_Mass] + PHY_Object[b][PHY_Mass]);
										tmpvz = ((PHY_Object[a][PHY_Mass] - PHY_Object[b][PHY_Mass]) * PHY_Object[a][PHY_VZ] + 2 * PHY_Object[b][PHY_Mass] * tmpvz) / (PHY_Object[a][PHY_Mass] + PHY_Object[b][PHY_Mass]);
										newvx1 += tmpvx;
										newvy1 += tmpvy;
										newvz1 += tmpvz;

										projectVonU(PHY_Object[b][PHY_VX], PHY_Object[b][PHY_VY], PHY_Object[b][PHY_VZ], dx, dy, dz, tmpvx, tmpvy, tmpvz);
										newvx2 -= tmpvx;
										newvy2 -= tmpvy;
										newvz2 -= tmpvz;
										projectVonU(PHY_Object[a][PHY_VX], PHY_Object[a][PHY_VY], PHY_Object[a][PHY_VZ], -dx, -dy, -dz, tmpvx, tmpvy, tmpvz);
										tmpvx = ((PHY_Object[b][PHY_Mass] - PHY_Object[a][PHY_Mass]) * PHY_Object[b][PHY_VX] + 2 * PHY_Object[a][PHY_Mass] * tmpvx) / (PHY_Object[a][PHY_Mass] + PHY_Object[b][PHY_Mass]);
										tmpvy = ((PHY_Object[b][PHY_Mass] - PHY_Object[a][PHY_Mass]) * PHY_Object[b][PHY_VY] + 2 * PHY_Object[a][PHY_Mass] * tmpvy) / (PHY_Object[a][PHY_Mass] + PHY_Object[b][PHY_Mass]);
										tmpvz = ((PHY_Object[b][PHY_Mass] - PHY_Object[a][PHY_Mass]) * PHY_Object[b][PHY_VZ] + 2 * PHY_Object[a][PHY_Mass] * tmpvz) / (PHY_Object[a][PHY_Mass] + PHY_Object[b][PHY_Mass]);
										newvx2 += tmpvx;
										newvy2 += tmpvy;
										newvz2 += tmpvz;

										PHY_Object[a][PHY_VX] = newvx1;
										PHY_Object[a][PHY_VY] = newvy1;
										PHY_Object[a][PHY_VZ] = newvz1;

										PHY_Object[b][PHY_VX] = newvx2;
										PHY_Object[b][PHY_VY] = newvy2;
										PHY_Object[b][PHY_VZ] = newvz2;

										CallLocalFunction("PHY_OnObjectCollideWithObject", "dd", a, b);
									}
								}
							}
						}
						else Iter_Remove(ITER_Object, b); //, printf("SAFE REMOVED B %d", b);
					}
				}

				if(!PHY_IsHandleGhostWithWalls(a))
				{
					foreach(new w : ITER_Wall)
					{
						if(PHY_Wall[w][PHY_Created])
						{
							if((!PHY_Object[a][PHY_World] || !PHY_Wall[w][PHY_World] || PHY_Object[a][PHY_World] == PHY_Wall[w][PHY_World]))
							{
								//dist = (y1 - PHY_Wall[w][PHY_M] * x1 - PHY_Wall[w][PHY_Q])/floatsqroot(1 + PHY_Wall[w][PHY_M] * PHY_Wall[w][PHY_M]);
								//dist = (PHY_Wall[w][PHY_A] * x1 + PHY_Wall[w][PHY_B] * y1 + PHY_Wall[w][PHY_C])/floatsqroot(PHY_Wall[w][PHY_A] * PHY_Wall[w][PHY_A] + PHY_Wall[w][PHY_B] * PHY_Wall[w][PHY_B]);
								angle = PHY_Wall[w][PHY_ANG];
								if(PHY_Wall[w][PHY_Z1] - PHY_Object[a][PHY_Size] < z1 < PHY_Wall[w][PHY_Z2] + PHY_Object[a][PHY_Size] &&
								(check_segment_intersection(PHY_Wall[w][PHY_X1], PHY_Wall[w][PHY_Y1], PHY_Wall[w][PHY_X2], PHY_Wall[w][PHY_Y2], x1, y1, PHY_Object[a][PHY_Size], xclosest, yclosest) || /* && floatabs(dist) < PHY_Object[a][PHY_Size]*/
								check_segment_intersection(PHY_Wall[w][PHY_X1], PHY_Wall[w][PHY_Y1], PHY_Wall[w][PHY_X2], PHY_Wall[w][PHY_Y2], (x + x1)/2, (y + y1)/2, PHY_Object[a][PHY_Size], xclosest, yclosest)))
								{
									//mag = y1 + PHY_Object[a][PHY_Size] * floatcos(-moveangle, degrees) - (x1 + PHY_Object[a][PHY_Size] * floatsin(-moveangle, degrees)) * PHY_Wall[w][PHY_M] - PHY_Wall[w][PHY_Q];
									//mag = PHY_Wall[w][PHY_A] * (x1 + PHY_Object[a][PHY_Size] * floatsin(-moveangle, degrees)) + PHY_Wall[w][PHY_B] * (y1 + PHY_Object[a][PHY_Size] * floatcos(-moveangle, degrees)) + PHY_Wall[w][PHY_C];
									//if((dist >= 0) ? (mag <= 0) : (mag >= 0))
				   			 		newvx1 = PHY_Wall[w][PHY_BounceConst] * (PHY_Object[a][PHY_VX] * floatcos(angle, degrees) - PHY_Object[a][PHY_VY] * floatsin(angle, degrees));
									newvy1 = -PHY_Wall[w][PHY_BounceConst] * (PHY_Object[a][PHY_VX] * floatsin(angle, degrees) + PHY_Object[a][PHY_VY] * floatcos(angle, degrees));
									angle = -angle;
									PHY_Object[a][PHY_VX] = newvx1 * floatcos(angle, degrees) - newvy1 * floatsin(angle, degrees);
									PHY_Object[a][PHY_VY] = newvx1 * floatsin(angle, degrees) + newvy1 * floatcos(angle, degrees);

									angle = angle + (newvy1 > 0.0 ? 90.0 : -90.0);
									x1 = xclosest + (PHY_Object[a][PHY_Size] + 0.001) * floatcos(angle, degrees);
									y1 = yclosest + (PHY_Object[a][PHY_Size] + 0.001) * floatsin(angle, degrees);

									CallLocalFunction("PHY_OnObjectCollideWithWall", "dd", a, w);
								}
							}
						}
						else
							Iter_Remove(ITER_Wall, w);
					}
				}

				if(!PHY_IsHandleGhostWithCylinders(a))
				{
					foreach(new c : ITER_Cylinder)
					{
						if(PHY_Cylinder[c][PHY_Created])
						{
							if((!PHY_Object[a][PHY_World] || !PHY_Cylinder[c][PHY_World] || PHY_Object[a][PHY_World] == PHY_Cylinder[c][PHY_World]))
							{
								if(PHY_Cylinder[c][PHY_Z1] - PHY_Object[a][PHY_Size] < z1 < PHY_Cylinder[c][PHY_Z2] + PHY_Object[a][PHY_Size])
								{
									x2 = PHY_Cylinder[c][PHY_X];
									y2 = PHY_Cylinder[c][PHY_Y];
									dx = x1 - x2;
									dy = y1 - y2;
									dist = (dx * dx) + (dy * dy);
									maxdist = PHY_Object[a][PHY_Size] + PHY_Cylinder[c][PHY_Size];
									if(dist < (maxdist * maxdist))
									{
										mag = PHY_Object[a][PHY_VX] * dx + PHY_Object[a][PHY_VY] * dy;

										if(mag < 0.0)
										{
								   			angle = -atan2(dy, dx);
											newvx1 = -PHY_Cylinder[c][PHY_BounceConst] * (PHY_Object[a][PHY_VX] * floatcos(angle, degrees) - PHY_Object[a][PHY_VY] * floatsin(angle, degrees));
											newvy1 = PHY_Cylinder[c][PHY_BounceConst] * (PHY_Object[a][PHY_VX] * floatsin(angle, degrees) + PHY_Object[a][PHY_VY] * floatcos(angle, degrees));

											angle = -angle;
											PHY_Object[a][PHY_VX] = newvx1 * floatcos(angle, degrees) - newvy1 * floatsin(angle, degrees);
											PHY_Object[a][PHY_VY] = newvx1 * floatsin(angle, degrees) + newvy1 * floatcos(angle, degrees);

											CallLocalFunction("PHY_OnObjectCollideWithCylinder", "dd", a, c);
										}
									}
								}
							}
						}
						else
							Iter_Remove(ITER_Cylinder, c);
					}
				}

				if(PHY_IsHandleCollidingWithPlayers(a))
				{
					foreach(new i : Player)
					{
						if((!PHY_Object[a][PHY_World] || !PHY_Player[i][PHY_World] || PHY_Object[a][PHY_World] == PHY_Player[i][PHY_World]))
						{
							GetPlayerPos(i, x2, y2, z2);

							if(z2 - PHY_Object[a][PHY_PlayerLowZ] - PHY_Object[a][PHY_Size] < z1 < z2 + PHY_Object[a][PHY_PlayerHighZ] + PHY_Object[a][PHY_Size])
							{
								dx = x1 - x2;
								dy = y1 - y2;
								dist = (dx * dx) + (dy * dy);
								maxdist = PHY_Object[a][PHY_Size] + PHY_Object[a][PHY_PlayerDist];
								if(dist < (maxdist * maxdist))
								{
									mag = PHY_Object[a][PHY_VX] * dx + PHY_Object[a][PHY_VY] * dy;

									if(mag < 0.0)
									{
							   			angle = -atan2(dy, dx);
										newvx1 = -PHY_Object[a][PHY_PlayerConst] * (PHY_Object[a][PHY_VX] * floatcos(angle, degrees) - PHY_Object[a][PHY_VY] * floatsin(angle, degrees));
										newvy1 = PHY_Object[a][PHY_PlayerConst] * (PHY_Object[a][PHY_VX] * floatsin(angle, degrees) + PHY_Object[a][PHY_VY] * floatcos(angle, degrees));

										angle = -angle;
										PHY_Object[a][PHY_VX] = newvx1 * floatcos(angle, degrees) - newvy1 * floatsin(angle, degrees);
										PHY_Object[a][PHY_VY] = newvx1 * floatsin(angle, degrees) + newvy1 * floatcos(angle, degrees);

										CallLocalFunction("PHY_OnObjectCollideWithPlayer", "dd", a, i);
									}
								}
							}
						}
					}
				}

				moveangle = atan2(PHY_Object[a][PHY_VY], PHY_Object[a][PHY_VX]) - 90.0;
				speed = floatsqroot(PHY_Object[a][PHY_VX] * PHY_Object[a][PHY_VX] + PHY_Object[a][PHY_VY] * PHY_Object[a][PHY_VY]);
				if(PHY_GetHandleFriction(a) != 0.0 && z1 == PHY_Object[a][PHY_LowZBound])
				{
					speed -= PHY_Object[a][PHY_Friction] * (PHY_TIMER_INTERVAL/1000.0);
					if(speed < 0.001)
						speed = 0.0;
					PHY_Object[a][PHY_VX] = speed * floatsin(-moveangle, degrees);
					PHY_Object[a][PHY_VY] = speed * floatcos(-moveangle, degrees);
				}
				if(PHY_GetHandleAirResistance(a) != 0.0)
				{
					PHY_Object[a][PHY_VX] -= PHY_Object[a][PHY_VX] * PHY_Object[a][PHY_AirResistance] * (PHY_TIMER_INTERVAL/1000.0);
					PHY_Object[a][PHY_VY] -= PHY_Object[a][PHY_VY] * PHY_Object[a][PHY_AirResistance] * (PHY_TIMER_INTERVAL/1000.0);
					PHY_Object[a][PHY_VZ] -= PHY_Object[a][PHY_VZ] * PHY_Object[a][PHY_AirResistance] * (PHY_TIMER_INTERVAL/1000.0);
				}
				if(PHY_IsHandleRolling(a) && speed > 0.0)
					PHY_ApplyRotation(a, speed, moveangle);
			}

			PHY_Object[a][PHY_VX] += PHY_Object[a][PHY_AX];
			PHY_Object[a][PHY_VY] += PHY_Object[a][PHY_AY];
			PHY_Object[a][PHY_VZ] += PHY_Object[a][PHY_AZ];

			SetDynamicObjectPos(obj_a, x1, y1, z1);
			CallLocalFunction("PHY_OnObjectUpdate", "d", a);
		}
		else
		{
			Iter_Remove(ITER_Object, a); //, printf("SAFE REMOVED A %d", a);
		}
	}
	return 1;
}


/* Starts using physics for objectid.
modelid - object's modelid, used to get its size with modelsizes include.
mass - object's mass, it is like its weight and is used in collisions.
size - object's sphere radius, taken from modelsizes.inc by default.
mode - PHY_MODE_3D or PHY_MODE_2D. */
stock PHY_InitObject(objectid, modelid = 0, Float:mass = 1.0, Float:size = FLOAT_NAN, mode = PHY_MODE_3D)
{
	new
		handleid = Iter_Free(ITER_Object);

	if(handleid != ITER_NONE)
	{
		new
			Float:z;

		GetDynamicObjectPos(objectid, z, z, z);

		PHY_Object[handleid][PHY_DynamicObject] = objectid;
		PHY_Object[handleid][PHY_Mode] = mode;
		PHY_Object[handleid][PHY_Mass] = mass;
		PHY_Object[handleid][PHY_World] = 0;
		PHY_Object[handleid][PHY_VX] = 0.0;
		PHY_Object[handleid][PHY_VY] = 0.0;
		PHY_Object[handleid][PHY_VZ] = 0.0;
		PHY_Object[handleid][PHY_Gravity] = 0.0;
		PHY_Object[handleid][PHY_LowZBound] = z;
		PHY_Object[handleid][PHY_HighZBound] = FLOAT_INFINITY;
		PHY_Object[handleid][PHY_BoundConst] = 0.0;
		PHY_Object[handleid][PHY_Created] = 1;

		if(size != size)
		{
			if(modelid)
				PHY_Object[handleid][PHY_Size] = GetColSphereRadius(modelid);
		}
		else
			PHY_Object[handleid][PHY_Size] = size;

		Iter_Add(ITER_Object, handleid);
	}
	return handleid;
}

/* Stops using physics for objectid (doesn't destroy it). */
stock PHY_DeleteHandle(handle)
{
	if(PHY_IsHandleValid(handle)) {
		PHY_Object[handle][PHY_Created] = 0;
	}
	return 1;
}

/* Moves the object with vx, vy, vz velocities. */
stock PHY_SetHandleVelocity(objectid, Float:vx, Float:vy, Float:vz = 0.0)
{
	if(PHY_IsHandleValid(objectid))
	{
		PHY_Object[objectid][PHY_VX] = vx;
		PHY_Object[objectid][PHY_VY] = vy;
		PHY_Object[objectid][PHY_VZ] = vz;
		return 1;
	}
	return 0;
}

/* Self-explanatory */
stock PHY_GetHandleVelocity(objectid, &Float:vx, &Float:vy, &Float:vz)
{
	if(PHY_IsHandleValid(objectid))
	{
		vx = PHY_Object[objectid][PHY_VX];
		vy = PHY_Object[objectid][PHY_VY];
		vz = PHY_Object[objectid][PHY_VZ];
		return 1;
	}
	return 0;
}

/* Sets the object's acceleration. */
stock PHY_SetHandleAcceleration(objectid, Float:ax, Float:ay, Float:az = 0.0)
{
	if(PHY_IsHandleValid(objectid))
	{
		PHY_Object[objectid][PHY_AX] = ax;
		PHY_Object[objectid][PHY_AY] = ay;
		PHY_Object[objectid][PHY_AZ] = az;
		return 1;
	}
	return 0;
}

/* Self-explanatory */
stock PHY_GetHandleAcceleration(objectid, &Float:ax, &Float:ay, &Float:az)
{
	if(PHY_IsHandleValid(objectid))
	{
		ax = PHY_Object[objectid][PHY_AX];
		ay = PHY_Object[objectid][PHY_AY];
		az = PHY_Object[objectid][PHY_AZ];
		return 1;
	}
	return 0;
}

/* Self-explanatory */
stock PHY_GetHandleSpeed(objectid, &Float:speed, _3D = 0)
{
	if(PHY_IsHandleValid(objectid))
	{
		speed = floatsqroot(PHY_Object[objectid][PHY_VX] * PHY_Object[objectid][PHY_VX] + PHY_Object[objectid][PHY_VY] * PHY_Object[objectid][PHY_VY] + _3D ? (PHY_Object[objectid][PHY_VZ] * PHY_Object[objectid][PHY_VZ]) : 0.0);
		return 1;
	}
	return 0;
}

/* Self-explanatory */
stock PHY_GetHandleMoveAngle(objectid, &Float:moveangle)
{
	if(PHY_IsHandleValid(objectid))
	{
		moveangle = atan2(PHY_Object[objectid][PHY_VY], PHY_Object[objectid][PHY_VX]) - 90.0;
		return 1;
	}
	return 0;
}

/* Starts rolling the object when it moves of toggle = 1 or stops if toggle = 0. */
stock PHY_RollObject(objectid, bool: toggle = true)
{
	if(PHY_IsHandleValid(objectid))
	{
		PHY_Object[objectid][PHY_Rolling] = toggle;
		return 1;
	}
	return 0;
}

/* Applies friction to the object when it moves on the floor. */
stock PHY_SetHandleFriction(objectid, Float:friction)
{
	if(PHY_IsHandleValid(objectid))
	{
		if(friction >= 0.0)
			PHY_Object[objectid][PHY_Friction] = friction;
		return 1;
	}
	return 0;
}

/* Applies air resistance to the object when it moves. */
stock PHY_SetHandleAirResistance(objectid, Float:resistance)
{
	if(PHY_IsHandleValid(objectid))
	{
		if(0.0 <= resistance <= 1.0)
			PHY_Object[objectid][PHY_AirResistance] = resistance;
		return 1;
	}
	return 0;
}

/* Limits the object's Z position.
low - The lowest Z that the object can have (you can use FLOAT_NEG_INFINITY). If it is set to NaN it doesn't change.
high - The highest Z that the object can have (you can use FLOAT_INFINITY). If it is set to NaN it doesn't change.
(When you use PHY_InitObject lowest Z is set to the current object's Z and highest Z to FLOAT_INFINITY.
constant - It should be from 0.0 to 1.0. If it is 1.0 the object doesn't lose velocity,
if it is 0.0 the object stops when it bounces. It could be a middle ground.*/
stock PHY_SetHandleZBound(objectid, Float:low = FLOAT_NAN, Float:high = FLOAT_NAN, Float:constant = 0.0)
{
	if(PHY_IsHandleValid(objectid))
	{
		if(low == low)
			PHY_Object[objectid][PHY_LowZBound] = low;
		if(high == high)
			PHY_Object[objectid][PHY_HighZBound] = high;
		PHY_Object[objectid][PHY_BoundConst] = constant;
		return 1;
	}
	return 0;
}

/* Sets the gravity's acceleration that the object is subjected to. */
stock PHY_SetHandleGravity(objectid, Float:gravity)
{
	if(PHY_IsHandleValid(objectid))
	{
		PHY_Object[objectid][PHY_Gravity] = gravity;
		return 1;
	}
	return 0;
}

/* Object and walls collide only if the are in the same world or one of them is in the world 0 (default). */
stock PHY_SetHandleWorld(objectid, world)
{
	if(PHY_IsHandleValid(objectid))
	{
		PHY_Object[objectid][PHY_World] = world;
		return 1;
	}
	return 0;
}

/* Toggles object's collisions with players.
- constant - It should be from 0.0 to 1.0. If it is 1.0 the object doesn't lose velocity,
if it is 0.0 the object stops when it bounces. It could be a middle ground.
- distoffset - The distance at which the object collides with the player.
- zoffsetlow/zoffsethigh - The max Z distance (downward/upward) at which the object collides with the player. */
stock PHY_ToggleObjectPlayerColls(objectid, bool: toggle = true, Float:constant = 1.0, Float:distoffset = 0.8, Float:zoffsetlow = 1.0, Float:zoffsethigh = 1.0)
{
	if(PHY_IsHandleValid(objectid))
	{
		PHY_Object[objectid][PHY_Object_Player_Collision] = toggle;

		if(toggle)
		{
			PHY_Object[objectid][PHY_PlayerConst] = constant;
			PHY_Object[objectid][PHY_PlayerDist] = distoffset;
			PHY_Object[objectid][PHY_PlayerLowZ] = zoffsetlow;
			PHY_Object[objectid][PHY_PlayerHighZ] = zoffsethigh;
		}
		return 1;
	}
	return 0;
}

/* Used internally to rotate the objects */
stock PHY_ApplyRotation(handleid, Float:speed, Float:moveangle)
{
	new objectid = PHY_Object[handleid][PHY_DynamicObject];
	new Float:rx, Float:ry, Float:rz;
	GetDynamicObjectRot(objectid, rx, ry, rz);
	rx -= speed * (PHY_TIMER_INTERVAL/1000.0) * (180.0/3.14159) / PHY_Object[handleid][PHY_Size];
	if(rx < 0.0)
		rx += 360.0;
	rz = moveangle;
	//FixRot(rx, ry, rz);
	//PHY_Roll(rx, ry, rz, PHY_Object[handleid][PHY_VX], PHY_Object[handleid][PHY_VY], ((speed * PHY_TIMER_INTERVAL)/1000) * (180/3.14159) / PHY_Object[handleid][PHY_Size]);
	SetDynamicObjectRot(objectid, rx, ry, rz);
	return 1;
}

/* Creates a collision wall (straight line) from A(x1, y1) to B(x2, y2).
constant should be from 0.0 to 1.0. If it is 1.0 the object doesn't lose velocity,
if it is 0.0 the object stops when it collides.
low is the lowest wall's Z, high is the highest. If they're set to default the wall is like infinitely high.*/
stock PHY_CreateWall(Float:x1, Float:y1, Float:x2, Float:y2, Float:constant = 1.0, Float:low = FLOAT_NEG_INFINITY, Float:high = FLOAT_INFINITY)
{
	new
		i = Iter_Free(ITER_Wall);
	if(i != ITER_NONE)
	{
		if(!PHY_Wall[i][PHY_Created])
		{
			PHY_Wall[i][PHY_Created] = 1;
			PHY_Wall[i][PHY_World] = 0;
			PHY_Wall[i][PHY_X1] = x1;
			PHY_Wall[i][PHY_Y1] = y1;
			PHY_Wall[i][PHY_X2] = x2;
			PHY_Wall[i][PHY_Y2] = y2;
			PHY_Wall[i][PHY_Z1] = low;
			PHY_Wall[i][PHY_Z2] = high;
			PHY_Wall[i][PHY_BounceConst] = constant;
			PHY_Wall[i][PHY_ANG] = atan2(y1 - y2, x1 - x2);
			/*PHY_Wall[i][PHY_A] = -(y2 - y1);
			PHY_Wall[i][PHY_B] = (x2 - x1);
			PHY_Wall[i][PHY_C] = (y2 - y1) * x1 - (x2 - x1) * y1;*/
			//PHY_Wall[i][PHY_Q] = -((y2 - y1) * x1)/(x2 - x1) + y1;

			Iter_Add(ITER_Wall, i);
		}
	}
	return i;
}

/* Creates four walls that form an area. Works like IsPlayerInArea. */
stock PHY_CreateArea(Float:minX, Float:minY, Float:maxX, Float:maxY, Float:constant = 1.0, Float:low = FLOAT_NEG_INFINITY, Float:high = FLOAT_INFINITY)
{
	PHY_CreateWall(minX, minY, minX, maxY, constant, low, high);
	PHY_CreateWall(minX, maxY, maxX, maxY, constant, low, high);
	PHY_CreateWall(maxX, maxY, maxX, minY, constant, low, high);
	PHY_CreateWall(maxX, minY, minX, minY, constant, low, high);
}

/* Self-explanatory */
stock PHY_DestroyWall(wallid)
{
	PHY_Wall[wallid][PHY_Created] = 0;
	// Iter_Remove(ITER_Wall, wallid);
	return 1;
}

/* See PHY_SetHandleWorld(objectid, world). */
stock PHY_SetWallWorld(wallid, world)
{
	if(PHY_Wall[wallid][PHY_Created])
	{
		PHY_Wall[wallid][PHY_World] = world;
		return 1;
	}
	return 0;
}

/* Creates a collision cylinder at position x, y.
constant should be from 0.0 to 1.0. If it is 1.0 the object doesn't lose velocity,
if it is 0.0 the object stops when it collides.
low is the lowest cylinder's Z, high is the highest. If they're set to default the cylinder is like infinitely high.*/
stock PHY_CreateCylinder(Float:x, Float:y, Float:size, Float:constant = 1.0, Float:low = FLOAT_NEG_INFINITY, Float:high = FLOAT_INFINITY)
{
	new
		i = Iter_Free(ITER_Cylinder);
	if(i != ITER_NONE)
	{
		if(!PHY_Cylinder[i][PHY_Created])
		{
			PHY_Cylinder[i][PHY_Created] = 1;
			PHY_Cylinder[i][PHY_World] = 0;
			PHY_Cylinder[i][PHY_X] = x;
			PHY_Cylinder[i][PHY_Y] = y;
			PHY_Cylinder[i][PHY_Size] = size;
			PHY_Cylinder[i][PHY_Z1] = low;
			PHY_Cylinder[i][PHY_Z2] = high;
			PHY_Cylinder[i][PHY_BounceConst] = constant;

			Iter_Add(ITER_Cylinder, i);
		}
	}
	return i;
}

/* Self-explanatory */
stock PHY_DestroyCylinder(cylinderid)
{
	PHY_Cylinder[cylinderid][PHY_Created] = 0;
	// Iter_Remove(ITER_Cylinder, cylinderid);
	return 1;
}

/* See PHY_SetHandleWorld(objectid, world). */
stock PHY_SetCylinderWorld(cylinderid, world)
{
	if(PHY_Cylinder[cylinderid][PHY_Created])
	{
		PHY_Cylinder[cylinderid][PHY_World] = world;
		return 1;
	}
	return 0;
}

/* See PHY_SetHandleWorld(objectid, world). */
stock PHY_SetPlayerWorld(playerid, world)
{
	PHY_Player[playerid][PHY_World] = world;
	return 1;
}

/* Privates */

stock Float:vectordotp(Float:v1x, Float:v1y, Float:v1z, Float:v2x, Float:v2y, Float:v2z)
	return (v1x * v2x + v1y * v2y + v1z * v2z);

stock projectVonU(Float:vx, Float:vy, Float:vz, Float:ux, Float:uy, Float:uz, &Float:x, &Float:y, &Float:z)
{
	new Float:fac = vectordotp(vx, vy, vz, ux, uy, uz) / vectordotp(ux, uy, uz, ux, uy, uz);
	x = ux * fac;
	y = uy * fac;
	z = uz * fac;
}

stock check_segment_intersection(Float:x1, Float:y1, Float:x2, Float:y2, Float:xc, Float:yc, Float:r, &Float:x, &Float:y)
{
	new Float:v1[2];
	new Float:v2[2];
	v1[0] = x2 - x1;
	v1[1] = y2 - y1;
	v2[0] = xc - x1;
	v2[1] = yc - y1;
	new Float:v1_len = floatsqroot(v1[0] * v1[0] + v1[1] * v1[1]);
	v1[0] /= v1_len;
	v1[1] /= v1_len;
	new Float:proj = vectordotp(v2[0], v2[1], 0.0, v1[0], v1[1], 0.0);
	x = proj * v1[0] + x1;
	y = proj * v1[1] + y1;
	return ((0 - r < proj < v1_len + r) && ((x - xc) * (x - xc) + (y - yc) * (y - yc) < (r * r)));
}

/* Function to make a better ball rolling, not used because it doesn't work well. */
stock PHY_Roll(&Float:x, &Float:y, &Float:z, Float:dx, Float:dy, Float:speed)
{
	new Float:q_roll[4];
	new Float:vx, Float:vy, Float:vz;
	vectorcrossp(dx, dy, 0.0, 0.0, 0.0, 1.0, vx, vy, vz);
	QuatFromAxisAngle(vx, vy, vz, -speed, q_roll[0], q_roll[1], q_roll[2], q_roll[3]);

	new Float:q_rot[4];
	EulerToQuaternion(x, y, z, q_rot[0], q_rot[1], q_rot[2], q_rot[3]);

	new Float:q_res[4];
	QuatMultiply(q_rot[0], q_rot[1], q_rot[2], q_rot[3], q_roll[0], q_roll[1], q_roll[2], q_roll[3], q_res[0], q_res[1], q_res[2], q_res[3]);

	QuaternionToEuler(q_res[0], q_res[1], q_res[2], q_res[3], x, y, z);
}

stock QuatMultiply(Float:w1, Float:x1, Float:y1, Float:z1, Float:w2, Float:x2, Float:y2, Float:z2, &Float:q_w, &Float:q_x, &Float:q_y, &Float:q_z)
{
	q_w = w1*w2 - x1*x2 - y1*y2 - z1*z2;
	q_x = w1*x2 + x1*w2 + y1*z2 - z1*y2;
	q_y = w1*y2 - x1*z2 + y1*w2 + z1*x2;
	q_z = w1*z2 + x1*y2 - y1*x2 + z1*w2;

	QuatNormalize(q_w, q_x, q_y, q_z);
}

stock QuatFromAxisAngle(Float:x, Float:y, Float:z, Float:angle, &Float:q_w, &Float:q_x, &Float:q_y, &Float:q_z)
{
	new
		Float:omega,
		Float:s;

	s = floatsqroot(x*x + y*y + z*z);

	if (s > 0.01)
	{

		x /= s;
		y /= s;
		z /= s;

		omega = 0.5 * angle;
		s = floatsin(omega, degrees);

		q_x = s*x;
		q_y = s*y;
		q_z = s*z;
		q_w = floatcos(omega, degrees);
	}
	else
	{
		q_x = 0.0;
		q_y = 0.0;
		q_z = 0.0;
		q_w = 1.0;
	}

	QuatNormalize(q_w, q_x, q_y, q_z);
}

stock QuatNormalize(&Float:q_w, &Float:q_x, &Float:q_y, &Float:q_z)
{
	new Float:magnitude = floatsqroot(q_w*q_w + q_x*q_x + q_y*q_y + q_z*q_z);
	if (magnitude == 0.0)
	{
		q_w = 1.0;
		q_x = 0.0;
		q_y = 0.0;
		q_z = 0.0;
	}
	else
	{
		q_w /= magnitude;
		q_x /= magnitude;
		q_y /= magnitude;
		q_z /= magnitude;
	}
}

stock EulerToQuaternion(Float:z, Float:x, Float:y, &Float:q_w, &Float:q_x, &Float:q_y, &Float:q_z)
{
	new Float:c1 = floatcos(x/2.0, degrees);
	new Float:s1 = floatsin(x/2.0, degrees);
	new Float:c2 = floatcos(y/2.0, degrees);
	new Float:s2 = floatsin(y/2.0, degrees);
	new Float:c3 = floatcos(z/2.0, degrees);
	new Float:s3 = floatsin(z/2.0, degrees);
	new Float:c1c2 = c1 * c2;
	new Float:s1s2 = s1 * s2;
	q_w = c1c2 * c3 - s1s2 * s3;
	q_x = c1c2 * s3 + s1s2 * c3;
	q_y = s1*c2*c3 + c1*s2*s3;
	q_z = c1*s2*c3 - s1*c2*s3;

	QuatNormalize(q_w, q_x, q_y, q_z);
}

stock QuaternionToEuler(Float:q_w, Float:q_x, Float:q_y, Float:q_z, &Float:z, &Float:x, &Float:y)
{
	new Float:test = q_x*q_y + q_z*q_w;
	if (test > 0.499) { // singularity at north pole
		x = 2 * atan2(q_x,q_w);
		y = 90.0;
		z = 0;
		return;
	}
	if (test < -0.499) { // singularity at south pole
		x = -2 * atan2(q_x,q_w);
		y = -90.0;
		z = 0;
		return;
	}
	new Float:sqx = q_x*q_x;
	new Float:sqy = q_y*q_y;
	new Float:sqz = q_z*q_z;
	x = atan2(2*q_y*q_w-2*q_x*q_z , 1 - 2*sqy - 2*sqz);
	y = asin(2*test);
	z = atan2(2*q_x*q_w-2*q_y*q_z , 1 - 2*sqx - 2*sqz);
}

stock vectorcrossp(Float:v1x, Float:v1y, Float:v1z, Float:v2x, Float:v2y, Float:v2z, &Float:c1, &Float:c2, &Float:c3)
{
	c1 = (v1y * v2z) - (v1z * v2y),
	c2 = (v1z * v2x) - (v1x * v2z),
	c3 = (v1x * v2y) - (v1y * v2x);
}