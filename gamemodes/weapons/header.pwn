/*

	Weapons can be created by admins (IRL variants).

	Settings:
	 1. Name

	 2. Weapon ID (i.e. colt, deagle, ... - if set to deagle players will see a deagle in hand)

	 3. Magazine size

	 4. Type (Pistol, SMG, Assault Rifle, Shotgun, Long range rifle, Military Grade)
	 (Used for GD crafting, determines which components are needed)

	 4. Weapon Range Modifier
	 (This buffs or nerfs the damage per range)
	 (i.e. -3.0 nerfs the range by 30%, useful for i.e. SMGs or shotguns)
	 (For long range you'd pick "3.0" or more, i.e. m4 or sniper range)

	 5. Weapon Recoil Setting
	 (Adds small drunk effect when shooting the weapon and aiming.)
	 (Useful for 'heavy' guns like an AK-47 or an M4)

	 6. Bullet Type (DEV: Add +- 15 different bullets from Hollow point tips to blanks)
	 (Determines base damage and setup for weapons.)
	 (A colt would have smaller and less lethal bullets than an AK-47 or a Shotgun)

	Add the possibility to add new weapons through a nifty dialog.

*/

#include "weapons/driveby.pwn"
#include "weapons/data/header.pwn"
#include "weapons/player.pwn"
//#include "weapons/visible.pwn"


CanPlayerDoGunCMD(playerid) {

	if ( IsPlayerIncapacitated(playerid, false) ) {

		return false ;
	}

	if ( IsPlayerInAnyVehicle(playerid)) {

		return false ;
	}

	// Account is gun banned!
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNBAN ] ) {

		return false ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_GUN_LAST_CMD_CD ]  >= gettime () ) {

		return false ;
	}

	// Set to 3 second cooldown after the cmd is doable!
	PlayerVar [ playerid ] [ E_PLAYER_GUN_LAST_CMD_CD ] = gettime() + 3 ;

	return true ;
}

CanPlayerUseGuns(playerid, required, weaponid = -1) {

	if ( playerid == INVALID_PLAYER_ID ) {

		return false ;
	}

	// Account is gun banned! Don't bother doing other checks!
	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNBAN ] ) {

		return false ;
	}

	switch ( weaponid ) {
		case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15: return true ;
	}

	new faction_enum_id = Faction_GetEnumID(Character [ playerid ] [ E_CHARACTER_FACTIONID ] );

	// Players need 12 hours played to be able to use guns.
	if ( faction_enum_id != INVALID_FACTION_ID ) {

		if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == 0 ) {
			return true ;
		}
	}

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ] ) {

		return true ;
	}

	if ( Character [ playerid ] [ E_CHARACTER_HOURS] >= required ) {

		if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ] ) {
			new query [ 512 ] ;

			mysql_format(mysql, query, sizeof ( query ), "UPDATE accounts SET account_gunaccess = 1 WHERE account_id = %d", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;

			Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ] = true ;
		}

		return true ;
	}

	return false ;
}

Spectate_RefundAdminGuns(playerid) {
	new idx  ;

	// Give back their guns.
	for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		if ( idx != -1 || idx != 0 ) {

			if ( idx >= sizeof ( Weapon ) ) {

				printf("[SPEC/AdminSaveGuns] Tried accessing index %d in ceiling %d. Skipping weapon...", idx, sizeof ( Weapon ) ) ;
				continue ;
			}

			GivePlayerWeapon(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ;
			SetPlayerArmedWeapon(playerid, 0);
			SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ; // hard setting ammo
		}

		PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = 0 ;
	}
}
Spectate_SaveAdminGuns(playerid) {
	new idx, temp_gun, ammo ;

	for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		GetPlayerWeaponData(playerid, i, temp_gun, ammo) ;

		if ( Weapon [ idx ] [ E_WEAPON_GUNID ] == temp_gun ) {

			PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = ammo ;
			if ( idx != 0 ) {

				// printf("[SPEC] Found weapon ID %d (server %d) on player %d with %d ammo. Storing!", idx, temp_gun, playerid, ammo ) ;
			}

		}
	}
}
stock DoesPlayerHaveAnyWeapon(playerid)
{
    new
        iWeaponID,
        iAmmo;

    for(new i =0; i < 13; i++)
    {
        GetPlayerWeaponData(playerid, i, iWeaponID, iAmmo);
    
        if(iWeaponID > 0 && iAmmo > 0)
        {
            return 1;
        }
    }
    return 0;
}

Anticheat_NewPlayerGunCheck(playerid) {

	if ( ! CanPlayerUseGuns ( playerid, 8 ) ) {

		if ( DoesPlayerHaveAnyWeapon ( playerid ) ) {
			new weaponData[13][2], string[256] ;

			new bool: safe_slot ;

			for(new i = 0; i < 13; i++) {
			    GetPlayerWeaponData(playerid, i, weaponData[i][0], weaponData[i][1]);

		    	if ( weaponData[i][0] != 0 ) {
			        
			        if ( i == 1 || i == 10 || i == 9 ) {

			        	safe_slot = true ;
			        }

			        else {
			        	
			        	safe_slot = false ;
			        }
			    }

			    else continue ;
		    }

		    if ( ! safe_slot ) {
				SendClientMessage(playerid, COLOR_RED, "Your account is too new! You're not allowed to have any weapons." ) ;
				SendClientMessage(playerid, COLOR_YELLOW, "For security reasons they have been reset. If you think this is a mistake" ) ;
				SendClientMessage(playerid, COLOR_YELLOW, "please post a refund request with the following info:" );

				for(new i = 0; i < 13; i++) {
				    GetPlayerWeaponData(playerid, i, weaponData[i][0], weaponData[i][1]);

			    	if ( weaponData[i][0] != 0 ) {
				        
				        SendClientMessage(playerid, COLOR_RED, sprintf("Slot ID: %d  Weapon ID: %s Ammo: %d", i, Weapon_GetName ( playerid,weaponData[i][0]), weaponData[i][1]));
				    }

				    else continue ;
			    }
			
		        format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s is using weapons whilst their account is marked as new player.", playerid, ReturnMixedName ( playerid )  ) ;
				SendAdminMessage(string, COLOR_ANTICHEAT) ;

				ResetPlayerWeapons(playerid) ;
				Weapon_ResetPlayerWeapons(playerid) ;
			}
		}
	}
}

DriveBy_IsValidWeapon(weaponid) {

	switch ( weaponid ) {

		case 22, 23, 25, 28, 29, 30, 31, 32, 33: return true ;
		default: return false ;
	}

	return false ;
}

GetWeaponSlot(weaponid)
{
	new slot;
	switch(weaponid){
		case 0, 1: slot = 0; // No weapon
		case 2 .. 9: slot = 1; // Melee
		case 22 .. 24: slot = 2; // Handguns
		case 25 .. 27: slot = 3; // Shotguns
		case 28, 29, 32: slot = 4; // Sub-Machineguns
		case 30, 31: slot = 5; // Machineguns
		case 33, 34: slot = 6; // Rifles
		case 35 .. 38: slot = 7; // Heavy Weapons
		case 16, 18, 39: slot = 8; // Projectiles
		case 41 .. 43: slot = 9; // Special 1
		case 10 .. 15: slot = 10; // Gifts
		case 44 .. 46: slot = 11; // Special 2
		case 40: slot = 12; // Detonators
		default: slot = -1; // No slot
	}
	return slot;
}

GetCustomWeaponGunId(weaponid)
{
	return Weapon[weaponid][E_WEAPON_GUNID];
}

GetCustomWeaponSlot(weaponid)
{
	return GetWeaponSlot(GetCustomWeaponGunId(weaponid));
}

PlayReloadAnimation(playerid, weaponid)
{
	if( GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK ) {
		switch (weaponid)
		{
		    case 22: ApplyAnimation(playerid, "COLT45", "colt45_crouchreload", 4.0, 0, 0, 0, 0, 0);
			case 23: ApplyAnimation(playerid, "SILENCED", "CrouchReload", 4.0, 0, 0, 0, 0, 0);
			case 24: ApplyAnimation(playerid, "PYTHON", "python_crouchreload", 4.0, 0, 0, 0, 0, 0);
			case 25, 27: ApplyAnimation(playerid, "BUDDY", "buddy_crouchreload", 4.0, 0, 0, 0, 0, 0);
			case 26: ApplyAnimation(playerid, "COLT45", "colt45_crouchreload", 4.0, 0, 0, 0, 0, 0);
			case 29..31, 33, 34: ApplyAnimation(playerid, "RIFLE", "RIFLE_crouchload", 4.0, 0, 0, 0, 0, 0);
			case 28, 32: ApplyAnimation(playerid, "TEC", "TEC_crouchreload", 4.0, 0, 0, 0, 0, 0);
		}
	}

	else {
		switch (weaponid)
		{
		    case 22: ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0);
			case 23: ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.0, 0, 0, 0, 0, 0);
			case 24: ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0);
			case 25, 27: ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0);
			case 26: ApplyAnimation(playerid, "COLT45", "sawnoff_reload", 4.0, 0, 0, 0, 0, 0);
			case 29..31, 33, 34: ApplyAnimation(playerid, "RIFLE", "rifle_load", 4.0, 0, 0, 0, 0, 0);
			case 28, 32: ApplyAnimation(playerid, "TEC", "tec_reload", 4.0, 0, 0, 0, 0, 0);
		}
	}
	
	return 1;
}

CMD:dropgun(playerid, params[]) {


	if ( ! CanPlayerDoGunCMD(playerid) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command when you're inside a vehicle, or are on temporary cooldown." );
	}

	new idx = GetPlayerCustomWeapon(playerid) ;

	if ( idx == -1 || GetPlayerWeapon ( playerid ) == 0) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't have a weapon in your hands!" );
    }

	static DropGunDlgStr[1024];

	inline ConfirmDropGun(pid, dialogid, response, listitem, string:inputtext[]) 
	{
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You have cancelled the drop, your weapon is still on you." ) ;
		}

		if ( response ) {
			
			new ammo = SOLS_GetPlayerAmmo(playerid), gun_name [ 32 ];
			Weapon_GetGunName ( idx, gun_name, sizeof ( gun_name ) );

			ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", sprintf("drops their %s.", gun_name), .annonated=true);

			//format ( string, sizeof ( string ), "You've discared your %s with %d ammo to the server.", gun_name, ammo ) ;
			//SendClientMessage(playerid, COLOR_YELLOW, string ) ;

			ApplyAnim(playerid, "GRENADE", "WEAPON_throw", 4.0, 0, 0, 0, 0, 0);
			RemovePlayerCustomWeapon(playerid, idx ) ;

			AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Dropped a (%d) %s (Ammo: %d)", idx, gun_name, ammo));

		}

		return true ;
	}

	format(DropGunDlgStr, sizeof(DropGunDlgStr), "{D82323}Warning! {DEDEDE}This is a destructive action!");

	strcat(DropGunDlgStr, "\n\n{DEDEDE}You are about to drop and {D82323}DESTROY{DEDEDE} your weapon.");
	strcat(DropGunDlgStr, "\n{DEDEDE}It will be lost forever. If you want to give it to");
	strcat(DropGunDlgStr, "\nsomeone else, use /passgun instead.");
	strcat(DropGunDlgStr, "\n\n{DEDEDE}Are you sure you want to continue?");
	strcat(DropGunDlgStr, "\n{EF7C7C}You will not be refunded if you change your mind.");

	Dialog_ShowCallback ( playerid, using inline ConfirmDropGun, DIALOG_STYLE_MSGBOX, "{D82323}DROPGUN WARNING{DEDEDE}", DropGunDlgStr, "Delete it", "Cancel" );

	return true ;
}

CMD:setaw(playerid, params[] ) {

	return cmd_setarmedweapon(playerid, params);
}

CMD:setarmedweapon(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

    
	new gunid, weaponid, idx, vehicleid;

	if ( sscanf ( params, "i", gunid ) ){

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "/seta(rmed)w(eapon) [ID - take from /myguns (or 0 for unarmed)]" ) ;
	}

	if (gunid == 0)
	{
		SendServerMessage(playerid, COLOR_BLUE, "Weapon", "A3A3A3", "Armed weapon set to unarmed.");
		SetPlayerArmedWeapon(playerid, 0);
		return true;
	}

	for ( new i, j = 13 ; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		if ( idx == -1 ) {

			continue ;
		}

		if ( idx == gunid ) {
			weaponid = Weapon [ idx ] [ E_WEAPON_GUNID ] ;
			break;
		}

		else continue ;
	}
	
	vehicleid = GetPlayerVehicleID(playerid);

	if ( IsPlayerInAnyVehicle(playerid)) {

		if ( GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "As a driver you can't have any weapon equipped." ) ;
		}
		else if ( GetPlayerState(playerid) == PLAYER_STATE_PASSENGER ) {

			if ( ! DriveBy_IsValidWeapon ( weaponid ) ) {
				
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This weapon can't be used in a driveby." ) ;
			}
		}
		
		if (IsABike(vehicleid) || IsAircraft(vehicleid))
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't arm a weapon while using bikes or aircraft." ) ;
		}
	}

	//g_Weapon[playerid] = weaponid ;
	SetPlayerArmedWeapon(playerid, weaponid) ;

	new gun_name[32];
	Weapon_GetGunName ( idx, gun_name, sizeof ( gun_name ) );

	SendServerMessage ( playerid, COLOR_BLUE, "Weapon", "A3A3A3", sprintf("Armed weapon set to %d (%s).", idx, gun_name ) ) ;
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Set their armed weapon to a %s (%d)", gun_name, weaponid));

	return true ;
}

Weapon_GetName ( playerid, weaponid, empty_return_val=0) {
	// empty_return_val returns different terms for empty slots (id 0)

	new weapon [ 256 ] ;
	weapon [ 0 ] = EOS ;

	switch ( weaponid ) {

		case 0: { 

			if ( ! empty_return_val ) {
				strcat(weapon, "Fist" ) ;
			}

			else if ( empty_return_val ) {

				strcat(weapon, "None" ) ;
			}
		}
		case WEAPON_SILENCED: {
			if ( PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] ) {
		 		strcat(weapon, "Taser" ) ;
			}

			else if ( ! PlayerVar [ playerid ] [ E_PLAYER_TASER_EQUIPPED ] ) {
				strcat ( weapon, "Silenced Pistol" ) ;
			}
		}

		default: {

			GetWeaponName(weaponid, weapon, sizeof ( weapon ) ) ;
		}
	}

	return weapon ;
}

AC_RemovePlayerWeapon(playerid, weaponid ) {
    new gun [ 12 ], ammo [ 12 ] ;

    for ( new i, j = 12 ; i < j ; i ++ ) {

    	GetPlayerWeaponData(playerid, i, gun [ i ], ammo [ i ] ) ;
    }

    ResetPlayerWeapons(playerid) ;

    for ( new i, j = 12 ; i < j ; i ++ ) {

    	if ( gun [ i ] == weaponid ) {

    		continue ;
    	}

    	else {

    		GivePlayerWeapon(playerid, gun [ i ], ammo [ i ] ) ;
    	}
    }
}


stock DoesPlayerHaveWeaponInSlot(playerid, slot) {
	new wep, ammo;
	GetPlayerWeaponData(playerid, slot, wep, ammo);
	if(ammo > 0)
		return true;
	return false;
}

DoesPlayerHaveWeapon(playerid, weaponid) {
	new wep, ammo;
	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), wep, ammo);
	if(wep == weaponid && ammo > 0)
	{
		return true;
	}
	return false;
}

static weaponshotstr [ 144 ] ;

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {

    if(!(22 <= weaponid <= 38)) return 1; //Small anti to prevent hackers crashing other clients.
 
	if (weaponid)
	{
		new slot = GetWeaponSlot(weaponid);

		if (slot > 0 && Weapon[PlayerVar[playerid][E_PLAYER_WEAPON_EQUIPPED][slot]][E_WEAPON_GUNID] != weaponid)
		{
			new acstr[256];
			format(acstr, sizeof(acstr), "[Anticheat]: (%d) %s fired weapon (%d) in slot %d doesn't match server (%d)", playerid, ReturnMixedName(playerid), slot, weaponid, Weapon[PlayerVar[playerid][E_PLAYER_WEAPON_EQUIPPED][slot]][E_WEAPON_GUNID]);
			SendAdminMessage(acstr, COLOR_ANTICHEAT);

			// Should block the damage
			return false;
		}

    	PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] -- ;

		// SendClientMessage(playerid, -1, sprintf("Slot: %d Client: %d, server: %d", slot, GetPlayerAmmo(playerid), PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] ) ) ;

    	if ( GetPlayerAmmo ( playerid ) != 0 && GetPlayerAmmo ( playerid ) < PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] ) {

    		//SendClientMessage(playerid, -1, "Client ammo is less than server ammo - syncing now!");
    		PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] = GetPlayerAmmo(playerid);
    	}

		if (GetPlayerAdminLevel(playerid) != ADMIN_LVL_DEVELOPER)
		{
			if ( GetPlayerAmmo ( playerid ) > PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] ) {
				new spoofed_ammo = GetPlayerAmmo ( playerid );

				new difference = spoofed_ammo - PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] ;

				SOLS_SetPlayerAmmo(playerid, weaponid, PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ] ) ;

				if ( difference > 3 ) { // only warn if bullet difference is more than 3 to avoid false positives
					if ( ++ PlayerVar [ playerid ] [ E_PLAYER_AMMO_WARNING ] >= 3 ) {

						PlayerVar [ playerid ] [ E_PLAYER_AMMO_WARNING ] = 0 ;

						format ( weaponshotstr, sizeof ( weaponshotstr ), "[Anticheat]: (%d) %s ammo doesnt match. Client: %d, server: %d (difference: %d|slot: %d).",
							playerid, ReturnMixedName ( playerid ), spoofed_ammo, PlayerVar [ playerid ] [ E_PLAYER_AMMO_SYNCED ] [ slot ], difference, slot );
						
						SendAdminMessage ( weaponshotstr, COLOR_ANTICHEAT ) ;
					}
				}
			}
		}
    }

  	Vehicle_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float: fY, Float: fZ) ;
	return true ;
}
