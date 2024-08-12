#include "weapons/data/weapon_data.pwn"

enum {
	E_GUN_SEL_NONE,
	E_GUN_SEL_MELEE, 
	E_GUN_SEL_PISTOL,
	E_GUN_SEL_SHOTGUN,
	E_GUN_SEL_SMG,
	E_GUN_SEL_ASSAULT,
	E_GUN_SEL_BOLT_ACTION
} ;

enum E_AMMO_DATA {

	E_AMMO_CONSTANT,
	E_AMMO_DESC [ 32 ],
	E_AMMO_TIME,
	E_AMMO_METAL,
	E_AMMO_PARTS,
	E_AMMO_CLIPSIZE
} ;

enum {
	AMMO_TYPE_NONE = 0, 
	AMMO_TYPE_A, AMMO_TYPE_B, AMMO_TYPE_C, AMMO_TYPE_D, 
	AMMO_TYPE_F, AMMO_TYPE_G, AMMO_TYPE_H, AMMO_TYPE_I,
	AMMO_TYPE_J, AMMO_TYPE_K, AMMO_TYPE_L
} ;
 
new Ammo [ ] [ E_AMMO_DATA ] = {

	{ AMMO_TYPE_NONE,	"None (invalid)" } ,
	// type 			name 				    time 	 	metal 	parts 	clip
	{ AMMO_TYPE_A, 		"9x19mm Parabellum",	60, 		1, 		1, 		48 }, // default clip: 24
	{ AMMO_TYPE_B, 		".45 ACP",				60, 		1, 		2, 		32 }, // default clip: 17
	{ AMMO_TYPE_C, 		".44 Magnum",			105, 		2, 		2, 		12 }, // default clip: 6
	{ AMMO_TYPE_D, 		".30-06 Springfield",	150, 		2, 		2, 		8 }, // default clip: 4
	{ AMMO_TYPE_F, 		".308 Winchester",		160, 		2, 		2, 		8 }, // default clip: 4
	{ AMMO_TYPE_G, 		".223 Rem",				120, 		2, 		3, 		8 }, // default clip: 4
	{ AMMO_TYPE_H, 		"12 gauge",				125, 		2, 		3, 		12 }, // default clip: 6
	{ AMMO_TYPE_I, 		"7.62x39mm",			130, 		1, 		2, 		90 }, // default clip: 45
	{ AMMO_TYPE_J, 		"5.56x45mm",			140, 		1, 		2, 		90 }, // default clip: 45
	{ AMMO_TYPE_K,		".357 SIG",				60, 		2, 		2, 		7 }, // default clip: 7
	{ AMMO_TYPE_L,		"5.7x28mm",				60, 		2, 		2, 		30 } // default clip: 30
} ;	

enum E_WEAPON_DATA {

	E_WEAPON_GUNID,
	E_WEAPON_DESC[32],
	E_WEAPON_AMMO,
	E_WEAPON_CLIP_SIZE, // taken from singleplayer
	E_WEAPON_TYPE,

	E_WEAPON_TIME, // seconds
	E_WEAPON_WOOD,
	E_WEAPON_METAL,
	E_WEAPON_PARTS,

	bool: E_WEAPON_CRAFTABLE
} ;

// Use the constants from the above list
new Weapon [31] [E_WEAPON_DATA] = {
	
	// Add guns to the END of this array, not inbetween!! (fucks up guns for players)
	{ 0,			"Fist",								AMMO_TYPE_NONE,	1, 	E_GUN_SEL_NONE,		9999, 9999,	9999,	9999, false  },
	// Melee
	{ WEAPON_BRASSKNUCKLE,	"Brass Knuckle",			AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_GOLFCLUB,		"Golf Club", 				AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_NITESTICK,		"Nitestick", 				AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_KNIFE,			"Knife", 					AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_BAT,			"Bat", 						AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_SHOVEL,		"Shovel", 					AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_POOLSTICK,		"Poolstick", 				AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_KATANA,		"Katana", 					AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_CHAINSAW,		"Chainsaw", 				AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_CANE,			"Cane", 					AMMO_TYPE_NONE,	1,  E_GUN_SEL_MELEE, 	30, 0, 1, 0, true } , // 150
	{ WEAPON_SPRAYCAN, 		"Spray Can",				AMMO_TYPE_NONE,	15000, E_GUN_SEL_MELEE,	30, 0, 1, 0, true } , // 150

	// PIstols
	{ WEAPON_COLT45,		"Colt 45",					AMMO_TYPE_A, 	17, E_GUN_SEL_PISTOL,	45, 4, 5, 2, true }, // 
	{ WEAPON_SILENCED,		"Colt 45 Silenced",			AMMO_TYPE_A, 	17, E_GUN_SEL_PISTOL,	60, 5, 5, 5, true }, //  2250
	{ WEAPON_DEAGLE,		"Desert Eagle",				AMMO_TYPE_I, 	7, E_GUN_SEL_PISTOL,	90, 7, 7, 10, true }, 
	// SMG	
	{ WEAPON_UZI,			"Uzi",						AMMO_TYPE_A,	50, E_GUN_SEL_SMG,		115, 10, 10, 8, true }, // 4100
	{ WEAPON_TEC9,			"TEC-9",					AMMO_TYPE_A,	50, E_GUN_SEL_SMG,		115, 10, 10, 9, true }, // 4300
	{ WEAPON_MP5,			"MP5",						AMMO_TYPE_A,	30, E_GUN_SEL_SMG,		150, 12, 12, 10, false }, // 5000

	// Assault Riffles
	{ WEAPON_AK47,			"AK-47", 					AMMO_TYPE_I,	30, E_GUN_SEL_ASSAULT,	180, 15, 15, 15, true }, // 6750
	{ WEAPON_M4,			"M4A1", 					AMMO_TYPE_J,	50, E_GUN_SEL_ASSAULT,	200, 18, 18, 18, false }, // 8100

	// Shotguns
	{ WEAPON_SHOTGUN, 		"Shotgun", 					AMMO_TYPE_H,	1, E_GUN_SEL_SHOTGUN,	175, 20, 20, 15, true }, // 8000
	{ WEAPON_SHOTGSPA, 		"Combat Shotgun", 			AMMO_TYPE_H,	7, E_GUN_SEL_SHOTGUN,	200, 20, 20, 20, false }, // 9000
  	{ WEAPON_SAWEDOFF, 		"Sawn Off Shotgun", 		AMMO_TYPE_H,	2, E_GUN_SEL_SHOTGUN,	250, 25, 30, 20, true }, // 11000

  	// Bolt Action Rifles
	{ WEAPON_RIFLE, 		"Bolt Action Rifle", 		AMMO_TYPE_D,	1, E_GUN_SEL_BOLT_ACTION,	275, 20, 25, 25, true  }, //10750
	{ WEAPON_SNIPER, 		"Sniper Rifle", 			AMMO_TYPE_F, 	1, E_GUN_SEL_BOLT_ACTION,	300, 25, 25, 25, false  }, // 11250

	// Misc
	{ WEAPON_CAMERA, 		"Camera",					AMMO_TYPE_NONE,	1500, E_GUN_SEL_MELEE,	30, 1, 1, 1, false  }, // 450
	{ WEAPON_SILENCED,		"Tazer",					AMMO_TYPE_A, 	10, E_GUN_SEL_PISTOL,	60, 5, 5, 5, false  }, //  2250
	{ WEAPON_FIREEXTINGUISHER,	"Fire Extinguisher", 	AMMO_TYPE_NONE,	15000, E_GUN_SEL_MELEE,	30, 0, 1, 0, true }, // 150

	// New pistol for cops
	{ WEAPON_DEAGLE,		"Police Glock",				AMMO_TYPE_B, 	7, E_GUN_SEL_PISTOL,	90, 7, 7, 10, false }, // for pd only

	// Civilian PF Weapons
	{ WEAPON_COLT45,		"Licensed Colt.45",				AMMO_TYPE_A,	17, E_GUN_SEL_PISTOL,	45, 3, 2, 2, false  },
	{ WEAPON_DEAGLE,		"Licensed Desert Eagle",		AMMO_TYPE_B,	7, E_GUN_SEL_PISTOL,	90, 7, 7, 10, false }
} ;

Ammo_SaveForPlayer(playerid) {

	new query [ 512 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_ammo_a = %d, player_ammo_b = %d, player_ammo_c = %d WHERE player_id = %d",

		Character [ playerid ] [ E_CHARACTER_AMMO_A ], Character [ playerid ] [ E_CHARACTER_AMMO_B ], Character [ playerid ] [ E_CHARACTER_AMMO_C ],
		Character [ playerid ] [ E_CHARACTER_ID ]
 	) ;

	mysql_tquery(mysql, query);

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_ammo_d = %d, player_ammo_e = %d, player_ammo_f = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_AMMO_D ], Character [ playerid ] [ E_CHARACTER_AMMO_E ], Character [ playerid ] [ E_CHARACTER_AMMO_F ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	) ;

	mysql_tquery(mysql, query);

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_ammo_g = %d, player_ammo_h = %d, player_ammo_i = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_AMMO_G ], Character [ playerid ] [ E_CHARACTER_AMMO_H ], Character [ playerid ] [ E_CHARACTER_AMMO_I ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	) ;

	mysql_tquery(mysql, query);

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_ammo_j = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_AMMO_J ], 
		Character [ playerid ] [ E_CHARACTER_ID ]
	) ;

	mysql_tquery(mysql, query);

	return true ;
}

Weapon_GetGunName ( idx, gun_name[], len = sizeof ( gun_name ) ) {


	if ( idx < 0 || idx > sizeof ( Weapon ) ) {

		format ( gun_name, len, "Invalid" ) ;
	}


	else {
		format ( gun_name, len, "%s", Weapon [ idx ] [ E_WEAPON_DESC ] ) ;
	}
}

Weapon_GetGunReason ( idx, gun_name[], len = sizeof ( gun_name ) ) {


	if ( idx < 0 || idx > sizeof ( Weapon ) ) {

		format ( gun_name, len, "Unknown Weapon" ) ;
	}
	else 
	{
		format ( gun_name, len, "%s", Weapon [ idx ] [ E_WEAPON_DESC ] ) ;
	}

	new firstchar = gun_name[0];
	if (firstchar == 'A' || firstchar == 'E' || firstchar == 'I' || firstchar == 'O' || firstchar == 'U')
	{
		format(gun_name, len, "an %s", gun_name);
	}
	else
	{
		format(gun_name, len, "a %s", gun_name);
	}
}

Weapon_GetAmmoName ( idx, ammo_name[], len = sizeof ( ammo_name ) ) {

	if ( idx < 0 || idx > sizeof ( Weapon ) ) {

		format ( ammo_name, len, "Invalid" ) ;
	}

	new ammo_const = Weapon [ idx ] [ E_WEAPON_AMMO ] ;

	for ( new i, j = sizeof ( Ammo ); i < j ; i ++ ) {

		if ( Ammo [ i ] [ E_AMMO_CONSTANT ] == ammo_const ) {

			format ( ammo_name, len, "%s", Ammo [ i ] [ E_AMMO_DESC] ) ;
		}
	}
}

Ammo_GetAmmoName(idx, ammo_name[], len = sizeof ( ammo_name ) ) {

	for ( new i, j = sizeof ( Ammo ); i < j ; i ++ ) {

		if ( Ammo [ i ] [ E_AMMO_CONSTANT ] == idx ) {

			format ( ammo_name, len, "%s", Ammo [ i ] [ E_AMMO_DESC] ) ;
		}
	}
}

CMD:spoofgivegun(playerid, params[]) {

	new targetid, id, ammo ;

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( sscanf  ( params, "k<player>ii", targetid, id, ammo ) ) {

		return SendClientMessage(playerid, -1, "/spoofgivegun [player] [id] [ammo]" ) ;
	}

	if ( ammo < 0 || ammo > 999 ) {
		return SendClientMessage(playerid, -1, "Not gonna happen." ) ;
	}

	GiveCustomWeapon ( targetid, id, ammo ); 
	new gun_name[32];
	Weapon_GetGunName(id, gun_name, 32);

	SendClientMessage(playerid, -1, sprintf("You gave (%d) %s a %s (%d) with %d ammo.", targetid, ReturnSettingsName(targetid, playerid), gun_name, id, ammo ) );

	return true ;
}

CMD:spoofgun(playerid, params[]) {

	new id, ammo ;

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( sscanf  ( params, "ii", id, ammo ) ) {

		return SendClientMessage(playerid, -1, "/spoofgun [id] [ammo]" ) ;
	}

	if ( ammo < 0 || ammo > 999 ) {
		return SendClientMessage(playerid, -1, "Not gonna happen." ) ;
	}

	GiveCustomWeapon ( playerid, id, ammo ); 
	new gun_name[32];
	Weapon_GetGunName(id, gun_name, 32);

	SendClientMessage(playerid, -1, sprintf("You gave yourself a %s (%d) with %d ammo.", gun_name, id, ammo ) );

	return true ;
}

stock GetCustomWeaponInSlot(playerid, slot ) {

	new idx = -1 ;

	for ( new i, j = 13 ; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		if ( idx == -1 ) {

			continue ;
		}

		if ( GetWeaponSlot ( Weapon [ idx ] [ E_WEAPON_GUNID ] ) == slot ) {

			return idx ;
		}
	}

	return idx ;
}

GiveCustomWeapon(playerid, index, ammo ) {

	new gunid = Weapon [ index ] [ E_WEAPON_GUNID ] ;
	new slot = GetWeaponSlot ( gunid ) ;

	if ( gunid == 0 || ammo < 1 ) {
		SendClientMessage(playerid, COLOR_YELLOW, "Invalid weapon or ammo amount." ) ;
		return true ;
	}

	if ( gunid == 41 && ammo < 0.0 ) {

		if ( Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
			ammo = 15000 ;
		}

		else {
			ammo = 1000 ;
			SendClientMessage(playerid, COLOR_YELLOW, "There was an error processing your spray-can ammo. We've reset it to 1000." ) ;
		}
	}

	new query [ 256 ] ;

	// Inform if replaced
	if(PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][slot] != 0) {
		new gun_name [ 32 ] ;
		Weapon_GetGunName ( index, gun_name, sizeof ( gun_name ) );
		SendClientMessage(playerid, COLOR_RED, "Your previous weapon of this slot has been overwritten. For reference: (screenshot if needed)");
		SendClientMessage(playerid, COLOR_RED, "IF you bought a weapon from Emmet, this is intended - stockpiling is disabled for this weapon.");
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("Weapon (%d) %s with %i bullets (synced).", index, gun_name, PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ][slot]));
		new year, month, day, hour, minute, second;
		stamp2datetime(gettime(), year, month, day, hour, minute, second);
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("Account %i (%s) on %i/%i/%i at %.02i:%.02i:%.02i", 
		Account[playerid][E_PLAYER_ACCOUNT_ID], Account[playerid][E_PLAYER_ACCOUNT_NAME], day, month, year, hour, minute, second));
		SendClientMessage(playerid, COLOR_ORANGE, "You may ONLY post a refund request if this was a mistake. PD weapons won't be refunded (and WILL be checked).");
	} 
	

	if ( slot != -1 ) {

		// Because the script doesn't clear weapons replaced by weapon slots, we do it when a new gun is given to avoid doubles
		mysql_format ( mysql, query, sizeof ( query ), "DELETE FROM player_weapons WHERE character_id = %d AND weapon_id = %d",
			Character [ playerid ] [ E_CHARACTER_ID ], PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][slot ]
		 ) ;

		mysql_tquery(mysql, query);
	}

	//ResetPlayerWeapons(playerid);
	PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][slot ] = index ;
	PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ][slot] =  ammo ;
	GivePlayerWeapon ( playerid, gunid, ammo ) ;
	SOLS_SetPlayerAmmo ( playerid, gunid, ammo ) ;

	return true ;
}

forward GetPlayerCustomWeapon(playerid);
public GetPlayerCustomWeapon(playerid) {

	new idx = -1 ;

	if ( playerid == INVALID_PLAYER_ID ) {

		return idx ;
	}

	for ( new i, j = 13 ; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		if ( idx < 0 || idx > sizeof ( Weapon ) )  {

			continue ;
		}

		if ( Weapon [ idx ] [ E_WEAPON_GUNID ] == GetPlayerWeapon ( playerid ) ) {

			return idx ;
		}
	}

	return idx ;
}

Float: Weapon_GetAmmoDamage ( idx ) {

	if(idx == -1) return 0.0;
	new Float: amount = 0.5 ;

	new ammo = Weapon [ idx ] [ E_WEAPON_AMMO ] ;

	if ( ammo < 0 || ammo > sizeof ( Ammo ) ) {

		print("Returning invalid amount!" ) ;
		return amount ;
	}

	switch ( Ammo [ ammo ] [ E_AMMO_CONSTANT ] ) {

		case AMMO_TYPE_NONE: amount = 0.15 ;	//	None (invalid)
		case AMMO_TYPE_A: amount = 2.5 ;		//	9x19mm Parabellum
		case AMMO_TYPE_B: amount = 4.0 ; 		//	.45 ACP	
		case AMMO_TYPE_C: amount = 7.0 ;		//	.44 Magnum		
		case AMMO_TYPE_D: amount = 5.0 ;		//	.30-06 Springfield
		case AMMO_TYPE_F: amount = 5.0 ;		//	.308 Winchester
		case AMMO_TYPE_G: amount = 7.5 ;		//	.223 Rem
		case AMMO_TYPE_H: amount = 7.5 ;		//	12 gauge	
		case AMMO_TYPE_I: amount = 3.75 ;		//	7.62?39mm	
		case AMMO_TYPE_J: amount = 4.0 ;		//	5.56x45mm	
		case AMMO_TYPE_K: amount = 12.50 ;		//  .357 SIG  // deagle
		case AMMO_TYPE_L: amount = 7.0 ;		//  FN 5.7x28mm
	}

	return amount ;
}

Weapon_GetClipSize ( idx ) {

	if ( idx < 0 || idx > sizeof ( Weapon ) ) {

		return 0 ;
	}

	return Weapon [ idx ] [ E_WEAPON_CLIP_SIZE ] ;
}

CMD:givegun(playerid, params[]) {

	return cmd_passgun(playerid, params);
}

Weapon_PassGunResponse(playerid, target) {

	// minigame/shakehands.pwn

	if ( ! IsPlayerConnected(target) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "The player who offered to give you the gun is not connected." );	
	}

	new idx = GetPlayerCustomWeapon(playerid) ;

	if ( idx == -1 || GetPlayerWeapon ( playerid ) == 0) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have a weapon in your hands!" );
    }

 
 	if (!IsPlayerNearPlayer(playerid, target, 6.0)) {

		SendServerMessage( target, COLOR_ERROR, "Error", "A3A3A3",  "You aren't near the person who is giving you the gun." );
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You aren't near the person you want to give the gun to." );
    }

    if ( ! CanPlayerUseGuns(target, 8) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use gun related features yet." ) ;
	}


    // Only do anim if they're close to the player to avoid abuse
    if ( IsPlayerNearPlayer ( playerid, target, 2.0 ) ) {
		SetPlayerToFacePlayer(target, playerid);
		SetPlayerToFacePlayer(playerid, target);

		ApplyAnimation(target, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
		ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
	}

	new ammo = SOLS_GetPlayerAmmo ( playerid ) ;

	if ( idx != GetPVarInt(target, "GUNREQUEST_ID" ) ) {

		SendServerMessage( target, COLOR_ERROR, "Error", "A3A3A3",  "The request sender scrolled to a different weapon. They must keep the weapon they want to pass in their hand." );
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You scrolled to a different weapon. Keep the weapon you want to pass in your hand!" );
    }

    if ( IsPlayerPaused ( playerid ) ) {

		SendServerMessage( target, COLOR_ERROR, "Error", "A3A3A3",  "The sender has tabbed out. They must remain ingame when giving the gun to avoid security issues." );
 		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't tab out when giving a gun - the anticheat may mark you as a weapon hacker otherwise." );
    }

	RemovePlayerCustomWeapon(playerid, idx ) ;
	GiveCustomWeapon ( target, idx, ammo ) ;

	new gun_name [ 32 ], string [ 128 ] ;
	Weapon_GetGunName ( idx, gun_name, sizeof ( gun_name ) );

	format ( string, sizeof ( string ), "passes their %s to %s.", gun_name,  ReturnMixedName ( target ) ) ;
	ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", string, .annonated=true);

	SendAdminMessage ( sprintf("[ANTICHEAT] ** %s (%d) passes their %s to %s (%d).", 
    	ReturnMixedName(playerid), playerid, gun_name, ReturnMixedName ( target ), target));

	//NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Passed a %s (%d) (Ammo: %d) to %s (%d)", gun_name, idx, ammo, ReturnMixedName ( target ), target));
	AddLogEntry(target, LOG_TYPE_SCRIPT, sprintf("Received a %s (%d) (Ammo: %d) from %s (%d)", gun_name, idx, ammo, ReturnMixedName ( playerid ), playerid));

	return true ;
}

CMD:passgun(playerid, params[]) {

	if ( ! CanPlayerDoGunCMD(playerid) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command when you're inside a vehicle, or are on temporary cooldown." );
	}

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "/passgun [target]" );
	}

	if ( target == INVALID_PLAYER_ID ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "Player isn't connected." );
	}

	if (  PlayerVar [ target ] [ E_PLAYER_IS_SPECTATING ] == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_SENIOR)
	{
		// new: allows tier 2 and 1 to pass guns to tier 3, and tier 3 to pass guns to tier 2 and 1
		// senior admins can pass to anyone

		if (IsPlayerInMedicFaction(playerid))
		{
			return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "Members of your faction cannot use this command." );
		}

		if (IsPlayerInPoliceFaction(playerid))
		{
			if (!IsPlayerInPoliceFaction(target)) 
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "Police faction members cannot pass weapons to anyone outside their faction." );
			
			if ( Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 2 && Character [ target ] [ E_CHARACTER_FACTIONTIER ] > 2 ) 
			{
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You need to be at least tier 2 to be able to pass weapons." ) ;
			}
		}
	}

    if ( IsPlayerIncapacitated(target, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "Your target is incapacitated and can't accept this." ) ;
    }

	if ( ! CanPlayerUseGuns(target, 8) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "Target player can't receive weapons until they have 8 playing hours." );
	}	

	if ( ! CanPlayerUseGuns(playerid, 8) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command until you have 8 playing hours." );
	}	

 	if (!IsPlayerNearPlayer(playerid, target, 6.0)) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're not near your target." );
    }

 	if(GetPVarInt(target, "GUNREQUEST") != 0) {
 		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This person already has a request wait till the time expires.");
	}	
 
    new string[144], gun_name [ 32 ] ;

	new idx = GetPlayerCustomWeapon(playerid) ;


	if ( idx == -1 || GetPlayerWeapon ( playerid ) == 0) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have a weapon in your hands!" );
    }

	Weapon_GetGunName ( idx, gun_name, sizeof ( gun_name ) );
	new ammo = SOLS_GetPlayerAmmo ( playerid ) ;



    format(string, sizeof(string), "[Info] {777777}You have offered your {DE9B1F}%s{777777} with %d ammo to %s (This person has 30 seconds to respond).", 
    	gun_name, ammo, ReturnSettingsName(target, playerid));

    SendClientMessage(playerid, 0xAAFF00FF, string);

    format(string, sizeof(string), "[Info] {777777}%s (%d) has offered you their {DE9B1F}%s{777777} with %d ammo.",
    	ReturnSettingsName(playerid, target), playerid, gun_name, ammo );

    SendClientMessage(target, 0xAAFF00FF, string);
    SendClientMessage(target, 0xAAFF00FF, "Type \"/accept gun\" to cooperate (you have 30 seconds to respond).");

	SendClientMessage(playerid, COLOR_YELLOW, "Friendly reminder: this won't stack ammo with the gun you already have." ) ;
	SendClientMessage(target, COLOR_YELLOW, "Friendly reminder: this won't stack ammo with the gun you already have." ) ;

    SetPVarInt(target, "GUNREQUEST", 1);
    SetPVarInt(target, "GUNREQUEST_TARGET", playerid);
    SetPVarInt(target, "GUNREQUEST_ID", idx);

    defer PassRequestExpire(target, playerid);
			       
	return true ;
}
timer PassRequestExpire[30000](playerid, targetid) {

	// playerid = player who has request
	// targetid = player who sent request

	if(GetPVarInt(playerid, "GUNREQUEST") == 1)
	{
	    SendClientMessage(playerid, -1, "{AAFF00}[Info] {777777}Your gun pass request has expired.");
	    SendClientMessage(targetid, -1, "{AAFF00}[Info] {777777}Your gun pass request has expired.");
	    SetPVarInt(playerid, "GUNREQUEST", 0);
    	SetPVarInt(playerid, "GUNREQUEST_TARGET", INVALID_PLAYER_ID);
	    return 1;
	}
	return 1;
}

CMD:loadgun(playerid, params[]) {

	return cmd_reload(playerid, params);
}
CMD:reload(playerid, params[]) {

	if ( ! CanPlayerDoGunCMD(playerid) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command when you're inside a vehicle, or are on temporary cooldown." );
	}

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	new idx = GetPlayerCustomWeapon(playerid) ;

	if ( idx == -1 ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Ammo", "A3A3A3",  "You must have a weapon equipped in your hands!" );
	}

	// Fetches slot automatically... Leaves less time for the player!
	new amount ;

	if ( sscanf ( params, "i", amount ) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/reload [amount-of-bullets]" );
	}

	if ( amount < 0 ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Why the fuck would you /reload negative ammo? Are you retarded?" );
	}
	
	new string[128], ammo, ammo_name [ 64 ] ;

	switch ( Weapon [ idx ] [ E_WEAPON_AMMO ] ) {
		case 0: {
			return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "This weapon doesn't have ammo!" );
		}

		case 1: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_A ] < amount ) {

				Weapon_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;
				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_A ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_A ) {

					Weapon_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_A ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 2: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_B ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_B ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_B ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_B ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 3: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_C ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_C ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_C ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_C ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 4: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_D ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_D ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_D ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_D ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 5: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_F ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_F ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_F ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_F ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 6: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_G ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_G ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_G ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_G ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 7: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_H ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_H ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_H ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_H ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 8: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_I ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_I ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_I ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_I ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
		case 9: {
			if ( Character [ playerid ] [ E_CHARACTER_AMMO_J ] < amount ) {

				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have this many bullets from this ammo type!" );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_J ] >= amount ) {

				if ( Weapon [ idx ] [ E_WEAPON_AMMO ] != AMMO_TYPE_J ) {

					Weapon_GetAmmoName (idx, ammo_name, sizeof ( ammo_name ) ) ;
					format ( string, sizeof ( string ), "The bullet type you're trying to store isn't for this weapon. You need %s shells.", ammo_name );
					return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
				}

				Character [ playerid ] [ E_CHARACTER_AMMO_J ] -= amount ;

				ammo = SOLS_GetPlayerAmmo ( playerid ) ;
				ammo += amount ;

				GiveCustomWeapon ( playerid, idx, amount ) ;
				SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], ammo ) ;
			}
		}
	}

	new gun_name [ 64 ] ;

	Weapon_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;
	Weapon_GetGunName ( idx, gun_name, sizeof ( gun_name ) ) ;

	ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("reloads their %s with %d %s bullets.", 
			gun_name, amount, ammo_name ), .annonated=true);

	Ammo_SaveForPlayer ( playerid ) ;

	PlayReloadAnimation(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ] ) ;

	return true ;
}

CMD:myammo(playerid, params[]) {


	SendClientMessage(playerid, COLOR_RED, "List of owned ammo" ) ;	
	
	new string [ 64 ] ;

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_A ] ) {
		format ( string, sizeof ( string ), "[Slot 0]: [9x19mm Parabellum: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_A ]);
		SendClientMessage(playerid, 0xDEDEDEFF, string );
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_B ] ) {
		format ( string, sizeof ( string ), "[Slot 1]: [.45 ACP: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_B ] ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_C ] ) {
		format ( string, sizeof ( string ), "[Slot 2]: [.44 Magnum: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_C ] ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_D ] ) {
		format ( string, sizeof ( string ), "[Slot 3]: [.30-06 Springfield: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_D ] ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_F ] ) {
		format ( string, sizeof ( string ), "[Slot 4]: [.308 Winchester: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_F ] ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_G ] ) {
		format ( string, sizeof ( string ), "[Slot 5]: [.223 Rem: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_G ] ) ;

		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_H ] ) {
		format ( string, sizeof ( string ), "[Slot 6]: [12 gauge: %d bullets] ", Character [ playerid ] [ E_CHARACTER_AMMO_H ]) ;

		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_I ] ) {
		format ( string, sizeof ( string ), "[Slot 7]: [7.62?39mm: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_I ]) ;
		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}

	if ( Character [ playerid ] [ E_CHARACTER_AMMO_J ] ) {
		format ( string, sizeof ( string ), "[Slot 8]: [5.56x45mm: %d bullets]", Character [ playerid ] [ E_CHARACTER_AMMO_J ] ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, string);
	}


	return true ;
}

CMD:giveammo(playerid, params[]) {

	return cmd_passammo(playerid, params);
}

CMD:passammo(playerid, params[]) {


	// Fetches slot automatically... Leaves less time for the player!
	new targetid, slot, amount ;

	if ( sscanf ( params, "k<player>ii", targetid, slot, amount ) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/passammo [targetid] [slot] [amount-of-bullets]" );
	}

	if ( ! IsPlayerConnected ( targetid ) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Player isn't connected!" );
	}

	if (  PlayerVar [ targetid ] [ E_PLAYER_IS_SPECTATING ] == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

	if ( ! CanPlayerUseGuns(targetid, 8) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "Target player can't receive weapons until they have 8 playing hours." );
	}	

	if ( ! CanPlayerUseGuns(playerid, 8) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command until you have 8 playing hours." );
	}	

 	if (!IsPlayerNearPlayer(playerid, targetid, 6.0)) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're not near your target." );
    }

    if ( amount < 0 ) {

    	new string [ 128 ] ;
        format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s has tried to give NEGATIVE ammo (ammo dupe: %dx) to (%d) %s.", 
    		playerid, ReturnMixedName ( playerid ), amount, targetid, ReturnMixedName ( targetid )   ) ;
		SendAdminMessage(string, COLOR_ANTICHEAT) ;

		SendClientMessage(playerid, COLOR_ERROR, "You can't give negative ammo. Your action has been logged and admins are notified.");

		return true ;
    }


	new string [64], ammo_name [ 32 ], idx ;

	switch ( slot ) {
		case 0: {
			idx = AMMO_TYPE_A ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_A ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_A ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_A ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_A ] += amount ;
			}
		}
		case 1: {
			idx = AMMO_TYPE_B ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_B ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_B ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_B ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_B ] += amount ;
			}
		}
		case 2: {
			idx = AMMO_TYPE_C ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_C ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_C ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_C ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_C ] += amount ;
			}
		}
		case 3: {
			idx = AMMO_TYPE_D ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_D ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_D ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_D ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_D ] += amount ;
			}
		}
		case 4: {
			idx = AMMO_TYPE_F ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_F ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_F ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_F ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_F ] += amount ;
			}
		}
		case 5: {
			idx = AMMO_TYPE_G ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_G ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_G ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_G ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_G ] += amount ;
			}
		}

		case 6: {
			idx = AMMO_TYPE_H ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_H ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_H ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_H ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_H ] += amount ;
			}
		}
		case 7: {
			idx = AMMO_TYPE_I ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_I ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_I ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_I ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_I ] += amount ;
			}
		}
		case 8: {
			idx = AMMO_TYPE_J ;
			Ammo_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if ( Character [ playerid ] [ E_CHARACTER_AMMO_J ] < amount ) {

				format ( string, sizeof ( string ), "You don't have this many %s bullets!", ammo_name  );
				return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  string );
			}

			else if ( Character [ playerid ] [ E_CHARACTER_AMMO_J ] >= amount ) {

				Character [ playerid ] [ E_CHARACTER_AMMO_J ] -= amount ;
				Character [ targetid ] [ E_CHARACTER_AMMO_J ] += amount ;
			}
		}

		default: {

			return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "Only slots 0-8!" );
		}
	}

	ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", sprintf("passes %s %d %s bullets.", 
			ReturnMixedName ( targetid ), amount, ammo_name ), .annonated=true);

	Ammo_SaveForPlayer ( playerid ) ;
	Ammo_SaveForPlayer ( targetid ) ;

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Passed %d x %s Ammo to %s (%d)", amount, ammo_name,  ReturnMixedName ( targetid ), targetid), true);
	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Received %d x %s Ammo from %s (%d)", amount, ammo_name,  ReturnMixedName ( playerid ), playerid), true);
	return true ;
}

CMD:checkguns(playerid, params[])
{
	new targetid;

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have access to this command." );
	}

	if ( sscanf ( params, "k<player>", targetid ) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/checkguns [player]" );
	}

	if ( ! IsPlayerConnected ( targetid ) ) {
		return SendServerMessage( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Player isn't connected!" );
	}

	ShowPlayerGunsDlg(playerid, targetid);

	return true;
}

CMD:myguns(playerid, params[]) {

	ShowPlayerGunsDlg(playerid, playerid);
	SendClientMessage(playerid, COLOR_YELLOW, "To see your ammo, use /myammo. For packages, use /gunpackages.");

	return true ;
}

static guns_dlg_str[2048];

ShowPlayerGunsDlg(playerid, targetid, bool:print=false)
{
	
	format(guns_dlg_str, sizeof(guns_dlg_str), "ID\tSlot\tWeapon\tAmmo");
	new ammo_name[32];
	new gunid, ammo, idx, count = 0;

	if (print) { SendClientMessage(playerid, COLOR_BLUE, sprintf("Guns of %s:", ReturnSettingsName(targetid, playerid))); } 

	for ( new i, j = 12 ; i < j ; i ++ ) {

		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;
		GetPlayerWeaponData(playerid, i, gunid, ammo ) ;
		if ( idx != 0 && ammo > 0 ) {

			Weapon_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if (print)
			{
				SendClientMessage(playerid, COLOR_GD, sprintf("[Slot %d]{DEDEDE} (id %d) %s with %d ammo (%s).", 
					GetWeaponSlot(Weapon [ idx ] [ E_WEAPON_GUNID ]), idx, Weapon [ idx ] [ E_WEAPON_DESC ], ammo, ammo_name ) ) ;
			}
			else
			{
				if (Weapon[idx][E_WEAPON_AMMO]) format(guns_dlg_str, sizeof(guns_dlg_str), "%s\n{A3A3A3}(ID %d)\t{FFAB91}Slot %d\t%s\t%d x %s", guns_dlg_str, idx, GetWeaponSlot(Weapon [ idx ] [ E_WEAPON_GUNID ]), Weapon[idx][E_WEAPON_DESC], ammo, ammo_name);
				else format(guns_dlg_str, sizeof(guns_dlg_str), "%s\n{A3A3A3}(ID %d)\t{FFAB91}Slot %d\t%s\t%d", guns_dlg_str, idx, GetWeaponSlot(Weapon [ idx ] [ E_WEAPON_GUNID ]), Weapon[idx][E_WEAPON_DESC], ammo);
			}

			count++;
		}

		else continue ;
	}

	if (count == 0) {
		if (print) SendClientMessage(playerid, COLOR_RED, "No weapons found.");
		else format(guns_dlg_str, sizeof(guns_dlg_str), "%s\n{FFAB91}No weapons found.", guns_dlg_str);
	}

	inline GunsDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

		if (response)
		{
			ShowPlayerGunsDlg(playerid, targetid, true);
		}

    }

	if (!print)
	{
		Dialog_ShowCallback ( playerid, using inline GunsDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Weapons of %s", ReturnSettingsName(targetid, playerid)), guns_dlg_str, "Print", "Close" );
		return 1;
	}

	return 1;
}

Anticheat_RefundApprovedGuns(playerid) {
	new idx  ;

	// Give back their guns.
	for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		if ( idx != -1 || idx != 0 ) {

			GivePlayerWeapon(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ;
			SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ; // hard setting ammo
		}

		PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = 0 ;
	}
}


Anticheat_SaveApprovedGuns(playerid) {
	new idx, temp_gun, ammo ;

	for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		GetPlayerWeaponData(playerid, i, temp_gun, ammo) ;

		if ( Weapon [ idx ] [ E_WEAPON_GUNID ] == temp_gun ) {

			PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = ammo ;
			if ( idx != 0 ) {

				printf("[ANTICHEAT] Found weapon ID %d (server %d) on player %d with %d ammo. Storing!", idx, temp_gun, playerid, ammo ) ;
			}

		}
	}
}

static WeaponACStr[512];

Weapon_AnticheatCheck(playerid) {

	if ( ! IsPlayerSpawned ( playerid ) ) {

		return true ;
	}

	if ( IsPlayerPaused ( playerid ) ) {

		return true ;
	}

	new gunid = GetPlayerWeapon ( playerid ) ;
	new slot = GetWeaponSlot ( gunid ) ;

	switch ( gunid ) {

		case 0, 1 : {
			return true ;
		}
	}

	new idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ slot ] ;

	if ( idx == -1  || idx > sizeof ( Weapon )) {

		idx = 0 ;
	}
 
	if ( gunid == WEAPON_SPRAYCAN || gunid == WEAPON_PARACHUTE ) {

		return true ;
	}

	if ( gunid != Weapon [ idx ] [ E_WEAPON_GUNID ] ) 
	{
		// If tick has been active for 5 seconds
	    if ( PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_TICK ] >= gettime()) {

            format ( WeaponACStr, sizeof ( WeaponACStr ), "[AntiCheat]: (%d) %s's client weapon doesn't match their server weapon. Removing weapon [%d/3]. [Client: %d] [Server %d:%d]", 
            	playerid, ReturnMixedName ( playerid ), PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING ], GetPlayerWeapon ( playerid ), idx, Weapon [ idx ] [ E_WEAPON_GUNID ]  ) ;
    		SendAdminMessage(WeaponACStr, COLOR_ANTICHEAT) ;

    		//ResetPlayerWeapons(playerid);
    		AC_RemovePlayerWeapon(playerid, GetPlayerWeapon ( playerid ));

    		if ( ++ PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING ] >= 3 ) {

    			// Player has sent 9 warnings so far! Ban the fucker!
    			if ( PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING_EXTRA ] >= 3 ) {

	        		format ( WeaponACStr, sizeof ( WeaponACStr ), "[AntiCheat]: (%d) %s's has gotten %d/3 warning AND %d/3 hard-reset ticks. Banning them preemptively. [Client weapon: %d] [Server: %d:%d]", 
	            		playerid, ReturnMixedName ( playerid ), PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING ], GetPlayerWeapon ( playerid), idx, Weapon [ idx ] [ E_WEAPON_GUNID ]  ) ;
	    			SendAdminMessage(WeaponACStr, COLOR_ANTICHEAT) ;	
  
  					PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING_EXTRA ] = 0 ;
    				PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING ] = 0 ;

    				new reason [ 64 ], hours, secs = hours * 3600, unbants = gettime() + secs;

 					format ( WeaponACStr, sizeof ( WeaponACStr ), "[AntiCheat]: (%d) %s has been banned for weapon hacks.", playerid, ReturnMixedName ( playerid )  ) ;
					ProxDetectorEx(playerid, 45.0, COLOR_ORANGE, "[AntiCheat]:", "has been banned for weapon hacks.", true, false);
		            SendAdminMessage(WeaponACStr, COLOR_ANTICHEAT) ;

		            format ( reason, sizeof ( reason ), "Anticheat Detection: Weapon Hacks" ) ;
		            SetAdminRecord ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_BAN, reason, -1, ReturnDateTime () ) ;
		            
		            mysql_format(mysql, WeaponACStr, sizeof(WeaponACStr), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
		            Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( playerid ), "Anticheat", reason, gettime(), unbants);
		            mysql_tquery(mysql, WeaponACStr);

		            SendRconCommand(sprintf("banip %s", ReturnIP ( playerid )));
		            KickPlayer ( playerid ) ;               
		        }

		        else {

			        format ( WeaponACStr, sizeof ( WeaponACStr ), "[AntiCheat]: (%d) %s's has gotten %d/3 warnings. Hard resetting & restoring ALL their weapons now! [Client weapon: %d] [Server: %d:%d]", 
			            playerid, ReturnMixedName ( playerid ), PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING ], GetPlayerWeapon ( playerid), idx, Weapon [ idx ] [ E_WEAPON_GUNID ]  ) ;
			    	SendAdminMessage(WeaponACStr, COLOR_ANTICHEAT) ;

			        Anticheat_SaveApprovedGuns(playerid);
			        ResetPlayerWeapons(playerid);
			        Anticheat_RefundApprovedGuns(playerid);

			        PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING_EXTRA ] ++ ;
			        PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_WARNING ] = 0 ;
			    }
    		}

    		return true ;
        }

        PlayerVar [ playerid ] [ E_PLAYER_GUN_AC_TICK ] = gettime () + 2 ;
	}

	return true ;
}

CMD:customgunlist(playerid, params[]) {

	Weapons_ShowList(playerid);

	return true ;
}

Weapons_ShowList (playerid ) {


	if ( PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] == 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] = 1 ;
	}


	// Pagination stuff
	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage ;
    new resultcount = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] ) - MAX_ITEMS_ON_PAGE ) ;


    new ammo_name [ 32 ] ;
    strcat(string, "ID\tReplacement\t Weapon \t Ammo\n");

    for ( new i = resultcount, j = sizeof ( Weapon ); i < j; i ++ ) {

		resultcount ++ ;

        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] ) {

        	Weapon_GetAmmoName ( i, ammo_name, sizeof ( ammo_name ) ) ;
			format(string, sizeof(string), "%s%d \t %s \t %s \t %s \n", string, 
				i, Weapon_GetName ( playerid, Weapon [ i ] [ E_WEAPON_GUNID ] ), Weapon [ i ] [ E_WEAPON_DESC ], ammo_name ); 
        }

     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] ) {

            nextpage = true;
            break;
        }
	}

	new pages = floatround ( resultcount / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }

	inline weapon_show_list(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

		if ( ! response ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] > 1 ) {

				PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] -- ;
				return Weapons_ShowList ( playerid ) ;
			}

			else return true ;
		}

		if ( response ) {

			if ( listitem >= MAX_ITEMS_ON_PAGE) {

				PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] ++ ;
				return Weapons_ShowList (playerid ) ;
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {


				SendClientMessage(playerid, COLOR_RED, "Gun Crafting Info:" ) ;

        		Weapon_GetAmmoName ( selection, ammo_name, sizeof ( ammo_name ) ) ;
				SendClientMessage(playerid, COLOR_YELLOW, sprintf("[ID: %d] [Name: \"%s\"] [Ammo:] \"%s\"] [Clip size: %d]", 
					selection,
					Weapon [ selection ] [ E_WEAPON_DESC ], 
					ammo_name, 
					Weapon [ selection ] [ E_WEAPON_CLIP_SIZE ] 
				) ) ;

				SendClientMessage(playerid, COLOR_YELLOW, sprintf("[Wood: %d] [Metal: %d] [Parts: %d] [Time: %d]",
					Weapon [ selection ] [ E_WEAPON_WOOD ], Weapon [ selection ] [ E_WEAPON_METAL ], 
					Weapon [ selection ] [ E_WEAPON_PARTS ], Weapon [ selection ] [ E_WEAPON_TIME ]
				 ) ) ;

 				return true ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ] > 1 ) {
		Dialog_ShowCallback ( playerid, using inline weapon_show_list, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Custom Weapons: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ], pages), string, "Select", "Previous" ) ;
	}

	else Dialog_ShowCallback ( playerid, using inline weapon_show_list, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Custom Weapons: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_GUNLIST_PAGE ], pages), string, "Select", "Back" ) ;

	// SendClientMessage(playerid, COLOR_YELLOW, "If you want to know the gun ID, use the \"ID\" row from this list!" ) ;

	return true ;
}