/*
 * Irresistible Gaming 2018
 * Developed by Southclaw
 * Module: gta\weapon_data.inc
 * Purpose: advanced weapon damage library
 */

#define MAX_WEAPONS     (50)
#define MAX_WEAPON_NAME (17)

#if defined __WEAPONDAMAGEINC__
	#endinput
#endif
#define __WEAPONDAMAGEINC__


enum
{
	WEAPON_VEHICLE_BULLET = WEAPON_PARACHUTE + 1,
	WEAPON_VEHICLE_EXPLOSIVE,
	WEAPON_VEHICLE_COLLISION
}

enum E_WEAPON_SP_DATA
{
		weapon_name[MAX_WEAPON_NAME],   // A
		weapon_model,                   // B
		weapon_magSize,                 // C
		weapon_slot,                    // D
Float:  weapon_minDmg,                  // E
Float:  weapon_maxDmg,                  // F
Float:  weapon_minRange,                // G
Float:  weapon_maxRange,                // H
Float:  weapon_shotInterval,            // I
Float:  weapon_rangeCap                 // J
}


stock const WeaponData[MAX_WEAPONS][E_WEAPON_SP_DATA]=
{
//  A                   B       C       D       E       F       G       H           I           J
	{"Fist",            000,    1,      0,      0.25,    1.0,    0.0,    2.0,        0.0,        1.6},       // 0
	{"Knuckle Duster",  331,    1,      1,      0.5,    2.0,    0.0,    2.0,        0.0,        1.6},       // 1
	{"Golf Club",       333,    1,      1,      0.5,    2.0,    0.0,    2.0,        0.0,        1.6},       // 2
	{"Baton",           334,    1,      1,      0.5,    2.0,    0.0,    2.0,        0.0,        1.6},       // 3
	{"Knife",           335,    1,      1,      0.5,	2.0,    0.0,    1.6,        0.0,        1.6},       // 4
	{"Baseball Bat",    336,    1,      1,      0.5,    2.0,    0.0,    2.0,        0.0,        1.6},       // 5
	{"Spade",           337,    1,      1,      0.5,    2.0,    0.0,    2.0,        0.0,        1.6},       // 6
	{"Pool Cue",        338,    1,      1,      0.5,    2.0,    0.0,    2.0,        0.0,        1.6},       // 7
	{"Katana",        	339,    1,      1,      24.0,   31.5,   0.0,    2.0,        0.0,        1.6},       // 8
	{"Chainsaw",        341,    1,      1,      24.5,   50.0,   0.0,    2.0,        0.0,        1.6},       // 9

//  A                   B       C       D       E       F       G       H           I           J
	{"Dildo",           321,    1,      10,     0.5,    1.0,    0.0,    2.0,        0.0,        1.6},       // 10
	{"Dildo",           322,    1,      10,     0.5,    1.0,    0.0,    2.0,        0.0,        1.6},       // 11
	{"Dildo",           323,    1,      10,     0.5,    1.0,    0.0,    2.0,        0.0,        1.6},       // 12
	{"Dildo",           324,    1,      10,     0.5,    1.0,    0.0,    2.0,        0.0,        1.6},       // 13
	{"Flowers",         325,    1,      10,     0.5,    1.0,    0.0,    2.0,        0.0,        1.6},       // 14
	{"Cane",            326,    1,      10,     0.5,    1.0,    0.0,    2.0,        0.0,        1.6},       // 15

//  A                   B       C       D       E       F       G       H           I           J
	{"Grenade",         342,    1,      8,      50.0,   100.0,  0.0,    2.0,        0.0,        40.0},      // 16
	{"Teargas",         343,    1,      8,      0.0,    0.0,    0.0,    2.0,        0.0,        40.0},      // 17
	{"Molotov",         344,    1,      8,      0.1,    0.1,    0.0,    1.0,        0.0,        40.0},      // 18

	{"<null>",          000,    0,      0,      0.0,    0.0,    0.0,    2.0,        0.0,        0.0},       // 19
	{"<null>",          000,    0,      0,      0.0,    0.0,    0.0,    2.0,        0.0,        0.0},       // 20
	{"<null>",          000,    0,      0,      0.0,    0.0,    0.0,    2.0,        0.0,        0.0},       // 21

//  A                   B       C       D       E       F       G       H           I           J
	{"9mm Pistol", 		346,    10,     2,      9.0,   16.0,   10.0,   30.0,       164.83,     35.0},      // 22
	{"Silenced Pistol", 347,    10,     2,      6.0,   10.0,   10.0,   25.0,       166.61,     35.0},      // 23
	{"Desert Eagle",    348,    7,      2,      17.0,   25.0,   12.0,  40.0,       82.54,      35.0},      // 24

//  A                   B       C       D       E       F       G       H           I           J
	{"Shotgun",         349,    6,      3,      15.0,   57.0,   11.0,   35.0,       56.40,      40.0},      // 25
	{"Sawn-off Shotgun",350,    2,      3,      5.0,    55.0,   5.0,    24.0,       196.07,     35.0},      // 26
	{"Spas 12",         351,    7,      3,      16.0,   52.0,   14.0,   40.0,       179.10,     40.0},      // 27

//  A                   B       C       D       E       F       G       H           I           J
	{"Mac 10",          352,    36,     4,      9.0,   15.0,   10.0,   35.0,       461.26,     35.0},      // 28
	{"MP5",             353,    30,     4,      9.0,   18.0,   9.0,    38.0,       554.98,     45.0},      // 29
	{"AK-47",           355,    30,     5,      14.0,  20.0,   11.0,   39.0,       474.47,     70.0},      // 30
	{"M4",             	356,    30,     5,      12.0,  25.0,   13.0,   46.0,       490.59,     90.0},      // 31
	{"Tec 9",           372,    30,     4,      8.0,   14.0,   10.0,   25.0,       447.48,     35.0},      // 32

//  A                   B       C       D       E       F       G       H           I           J
	{"Rifle",           357,    5,      6,      45.0,   60.0,   30.0,   100.0,      55.83,      100.0},     // 33
	{"Sniper",          358,    5,      6,      45.0,   65.0,   30.0,   100.0,      55.67,      100.0},     // 34 [Jul 1 2015] Sniper max dmg (F) changed from 60 to 65

//  A                   B       C       D       E       F       G       H           I           J
	{"RPG",             359,    1,      7,      100.0,  100.0,  1.0,    30.0,       0.0,        55.0},      // 35
	{"Heatseeker",      360,    1,      7,      100.0,  100.0,  1.0,    30.0,       0.0,        55.0},      // 36
	{"Flamer",          361,    100,    7,      10.1,   15.1,   1.0,    5.0,        2974.95,    5.1},       // 37
	{"Minigun",         362,    100,    7,      1.1,    2.0,    1.0,    60.0,       2571.42,    75.0},      // 38

//  A                   B       C       D       E       F       G       H           I           J
	{"Remote Bomb",     363,    1,      8,      5.0,    20.0,   10.0,   50.0,       0.0,        40.0},      // 39
	{"Detonator",       364,    1,      12,     0.0,    0.0,    0.0,    0.0,        0.0,        25.0},      // 40
	{"Spray Paint",     365,    500,    9,      0.0,    0.1,    0.0,    2.0,        0.0,        6.1},       // 41
	{"Extinguisher",    366,    500,    9,      0.0,    0.0,    0.0,    2.0,        0.0,        10.1},      // 42
	{"Camera",          367,    36,     9,      0.0,    0.0,    0.0,    0.0,        0.0,        100.0},     // 43
	{"Night Vision",    000,    1,      11,     0.0,    0.0,    0.0,    0.0,        0.0,        100.0},     // 44
	{"Thermal Vision",  000,    1,      11,     0.0,    0.0,    0.0,    0.0,        0.0,        100.0},     // 45
	{"Parachute",       371,    1,      11,     0.0,    0.0,    0.0,    0.0,        0.0,        50.0},      // 46

//  A                   B       C       D       E       F       G       H           I           J
	{"Vehicle Gun",     000,    0,      0,      3.0,    7.0,    0.0,    50.0,       0.0,        50.0},      // 47
	{"Vehicle Bomb",    000,    0,      0,      50.0,   50.0,   0.0,    50.0,       0.0,        50.0},      // 48
	{"Vehicle",         000,    0,      0,      0.25,   0.5,   0.0,    10.0,       0.0,        25.0}       // 49 Should be scripted to be based on velocity.
};

stock SP_GetWeaponName_New(weaponid, string[], size = sizeof(string))
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	string[0] = EOS;
	strcat(string, WeaponData[weaponid][weapon_name], size);

	return 1;
}

stock SP_GetWeaponModel(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_model];
}

stock SP_GetWeaponMagSize(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_magSize];
}

stock SP_GetWeaponSlot(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_slot];
}

stock Float:SP_GetWeaponMinDamage(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_minDmg];
}

stock Float:SP_GetWeaponMaxDamage(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_maxDmg];
}

stock Float:SP_GetWeaponMinRange(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_minRange];
}

stock Float:SP_GetWeaponMaxRange(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_maxRange];
}

stock Float:SP_GetWeaponShotInterval(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_shotInterval];
}

stock Float:SP_GetWeaponRangeCap(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_rangeCap];
}

stock Float:SP_GetWeaponDamageFromDistance(weaponid, Float:distance)
{
	if ( weaponid > sizeof ( WeaponData ) ) {

		return 5.0 ;
	}

	if(distance < WeaponData[weaponid][weapon_minRange])
		return WeaponData[weaponid][weapon_maxDmg];

	if(distance > WeaponData[weaponid][weapon_maxRange])
		return WeaponData[weaponid][weapon_minDmg];

	return ((WeaponData[weaponid][weapon_minDmg]-WeaponData[weaponid][weapon_maxDmg]) / (WeaponData[weaponid][weapon_maxRange]-WeaponData[weaponid][weapon_minRange])) * (distance - WeaponData[weaponid][weapon_maxRange]) + WeaponData[weaponid][weapon_minDmg];
}
