/*
	> Sometimes knife fully desyncs people (they do tabbed icon, looks like all packets get halted)
	--> Think this happened because Greco forced OnPlayerDeath on Kosidian. So he actually died
		DEBUG:
			Trying to kill 1,  health 0.000000 (health- amount: 50.000000
			1 damages 2 who is in deathmode. health 50.000000, amount: 1833.331542

		Kosidian (who had the bug) pressed F4 and killed himself at the gas station.
		After logging back in it was fixed.
 
	-------------------

	Sometimes knife aim becomes bugged. You can then knife people with normal weapons.
	Add a check for killer equipped weapon under the knife callbacks.

	You can knife people when you're not standing behind them and in range.
	(Greco stood 3-4 steps behind me and could still do the knife aim anim)
	https://i.imgur.com/AC1tKEG.png

	-------------------


*/

// Restore spraycan/camera on death
new InjuryRestoreCamera[MAX_PLAYERS];
new InjuryRestoreSpraycan[MAX_PLAYERS];

#define INJURY_CRITICAL_DMG_HEAD 	33
#define INJURY_CRITICAL_DMG_TORSO 	66

enum {

	BODY_PART_TORSO = 3,
	BODY_PART_GROIN = 4,
	BODY_PART_LEFT_ARM = 5,
	BODY_PART_RIGHT_ARM = 6,
	BODY_PART_LEFT_LEG = 7,
	BODY_PART_RIGHT_LEG = 8,
	BODY_PART_HEAD = 9
} ;

#define MAX_BODY_PARTS  ( 2 ) // start at 3, end at 9

enum {
	DAMAGE_LEGS = 0,
	DAMAGE_ARMS,
}

new bool: PlayerDamage [ MAX_PLAYERS ] [ MAX_BODY_PARTS ] ;

#define WEAPON_UNARMED 0

#include "injury/health.pwn"
#include "injury/utils.pwn"
#include "injury/list.pwn"
#include "injury/injury.pwn"
#include "injury/func.pwn"
#include "injury/stumble.pwn"
#include "injury/knife.pwn"

#if !defined INVALID_HOSPITAL_ID
	#define INVALID_HOSPITAL_ID	( -1 )
#endif

#if !defined SURGERY_FEE
	#define SURGERY_FEE ( 50 )
#endif

#if !defined BANDAGE_FEE
	#define BANDAGE_FEE	( 15 )
#endif

public OnPlayerDeath(playerid, killerid, reason) {


	//RemovePlayerFromGym(playerid, GetPlayerGymID(playerid), 2);
	Minigame_ResetVariables(playerid);
	PlayerVar [ playerid ] [ E_PLAYER_ONPLAYERDEATH ] = true ;

	new Float: x, Float: y, Float: z, Float: a ;
	GetPlayerPos(playerid, x, y, z );
	GetPlayerFacingAngle(playerid, a);

	PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_X ] = x ;
	PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Y ] = y ;
	PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Z ] = z ;
	PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_A ] = a ;
	PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_INT ] = GetPlayerInterior(playerid);
	PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_VW ] = GetPlayerVirtualWorld(playerid) ;

	new idx, temp_gun, ammo ;

	for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
		idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

		GetPlayerWeaponData(playerid, i, temp_gun, ammo) ;

		if ( Weapon [ idx ] [ E_WEAPON_GUNID ] == temp_gun ) {

			PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = ammo ;
			if ( idx != 0 ) {
				printf("[CLIENT DEATH] Found weapon ID %d (server %d) on player %d with %d ammo. Storing!", idx, temp_gun, playerid, ammo ) ;
			}
		}

	}

	return true ;
}



#include <YSI_Coding\y_hooks>
hook OnPlayerSpawn(playerid) {

	SetPlayerTeam(playerid, 1);

	// Re attach toys on respawn
	for ( new x = 0; x < MAX_PLAYER_ATTACHMENTS; x ++ ) 
	{
		if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ x ] ) 
		{
			SOLS_SetPlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ x ], 
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ x ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ x ] ,
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ x ],	
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ x ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ x ], 
				.save = false
			);
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_ONPLAYERDEATH ] ) {

		if ( PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_X ] == 0.0 ||
			PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Y ] == 0.0 ||
			PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Z ] == 0.0
		) {

			SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  "You've died clientwise due to an explosion, an undeclared weapon id or falling damage." );
			SendClientMessage(playerid, 0xA3A3A3FF, "We tried to respawn you to your last location but something went wrong. Porting you to the hospital..." ) ;


			PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] = 0 ;
			Injury_OnPlayerDeath(playerid) ;
		}

		else {

			PauseAC(playerid, 3);
			SetPlayerPos(playerid, PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_X ], 
				PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Y ], PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Z ] 
			) ;

			SetPlayerFacingAngle (playerid, PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_A ] ) ;

			SetPlayerInterior ( playerid, PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_INT ] );
			SetPlayerVirtualWorld ( playerid, PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_VW ] ); 

			SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  "You've died clientwise due to an explosion, an undeclared weapon id or falling damage." );
			SendClientMessage(playerid, 0xA3A3A3FF, "You will be respawned momentarily. Your weapons will be restored." ) ;

			// They died clientwise - let's refund their shit.
			new idx  ;

			for ( new i, j = MAX_WEAPON_SLOTS; i < j ; i ++ ) {
				idx = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;

				if ( idx != -1 || idx != 0 ) {

					GivePlayerWeapon(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ;
					SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] ) ; // hard setting ammo
				}

				PlayerVar [ playerid ] [ E_PLAYER_AMMO_TEMP ] [ i ] = 0 ;
			}

		}

		PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_X ] = 0.0 ;
		PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Y ] = 0.0 ;
		PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_Z ] = 0.0 ;

		PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_POS_A ]  = 0.0 ;

		PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_INT ] = 0;
		PlayerVar [ playerid ] [ E_PLAYER_CLIENT_DEATH_VW ] = 0 ;
	}	

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

		PlayerVar [ playerid ] [ E_PLAYER_ONPLAYERDEATH ] = false ;
	}

	/*

	if(InjuryRestoreCamera[playerid]) {
		GiveCustomWeapon(playerid, CUSTOM_CAMERA, InjuryRestoreCamera[playerid]);
		InjuryRestoreCamera[playerid] = 0;
		SendClientMessage(playerid, COLOR_GRAD1, "You've been given back your camera.");
	}	
	if(InjuryRestoreSpraycan[playerid]) {
		GiveCustomWeapon(playerid, CUSTOM_SPRAYCAN, InjuryRestoreSpraycan[playerid]);
		InjuryRestoreSpraycan[playerid] = 0;
		SendClientMessage(playerid, COLOR_GRAD1, "You've been given back your spray can.");
	}*/


	return 1;
}

Injury_ApplyAnim (playerid, const animlib[32], const animname[32], anim_loop = 0, respawn_time = -1, bool:freeze_sync = true, anim_freeze = 1) {

	#pragma unused anim_loop, respawn_time, freeze_sync, anim_freeze

	ApplyAnimation(playerid, animlib, animname, 4.1, 0, anim_loop, true, anim_freeze, 0, 1);

	defer Injury_ReAppendAnim(playerid, animlib, sizeof(animlib), animname, sizeof(animname), anim_loop, anim_freeze ) ;

	return true ;
}

timer Injury_ReAppendAnim[1500](playerid, const animlib[], animlib_len, const animname[], animname_len, anim_loop, anim_freeze) {
	#pragma unused animlib_len, animname_len

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

		ApplyAnimation(playerid, animlib, animname, 4.1, anim_loop, true, true, anim_freeze, 0, 1);
	}

	return true ;
}

CMD:surgery(playerid, params[]) {
    if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	new property_id = IsPlayerNearSpecificBuyPoint(playerid, E_BUY_TYPE_HOSPITAL) ;


	if ( property_id == INVALID_PROPERTY_ID ) {

    	return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not at the right place! Head to either the ASGH or CGH! (red cross on map)" );
    }

	PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = property_id ;

	if ( GetPlayerCash ( playerid ) < SURGERY_FEE ) {

		SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  sprintf("You need at least $%s in order to use this service.", IntegerWithDelimiter(SURGERY_FEE) ));
	}

	new fee, bool: arms_pass, bool:legs_pass, string [ 256 ] ;

	format ( string, sizeof ( string  ), "You're being charged for" ) ;

	if ( PlayerDamage [ playerid ] [ DAMAGE_ARMS ] ) {

		format(string, sizeof ( string ), "%s your arm damage", string );
		if ( ! PlayerDamage [ playerid ] [ DAMAGE_LEGS ] ) {
			format(string, sizeof ( string ), "%s, and your arm damage", string );
		}

		fee += 500 ;
		arms_pass = true ;
		PlayerDamage [ playerid ] [ DAMAGE_ARMS ] = false ;
	}

 	if ( PlayerDamage [ playerid ] [ DAMAGE_LEGS ] ) {

		if ( arms_pass ) {
			format(string, sizeof ( string ), "%s, and your leg damage", string );
		}
		else format(string, sizeof ( string ), "%s your leg damage", string );

		legs_pass=true ;
 		fee += 500 ;
 		PlayerDamage [ playerid ] [ DAMAGE_LEGS ] = false ;
 	}

 	if (! arms_pass && ! legs_pass ) {

		format(string, sizeof ( string ), "%s absolutely nothing", string );
		fee = 0 ;
 	}

	format(string, sizeof ( string ), "%s. Total cost: $%s. Your health is set to 75.", string, IntegerWithDelimiter(fee) );
	SendClientMessage(playerid, COLOR_GRAD0, string);

	TakePlayerCash ( playerid, fee ) ;
	new price = fee * 50 ; // i.e. 15 * 50 = 750
	Property_AddMoneyToTill(playerid, price, .margin=false ) ; 

	SetCharacterHealth(playerid, 75.0);
	AddLogEntry(playerid, LOG_TYPE_DAMAGE, "got surgery and fixed arm/leg dmg");

	return true ;
}

CMD:helpup(playerid, params[]) {
    if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
   

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

	    return  SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/helpup [playerid/part of name]" );
	}

	if ( ! IsPlayerConnected(target ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Connection", "A3A3A3",  "Your target isn't connected." );
	}

	if ( !IsPlayerNearPlayer(playerid, target, 4.0 ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not near your target." );
	}

	if ( !PlayerVar [ target ] [ E_PLAYER_INJUREDMODE ] ) {

	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Target isn't in injury mode!" );
	}

	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerInMedicFaction(playerid, true) && Character [ target ] [ E_CHARACTER_HELPUP_CD ])
	{
		// New cops/medics can always help up as long as they are on duty (we assume they rp it properly with their medical training/kits)
		new	cooldown = 3600 - (gettime() - Character [ target ] [ E_CHARACTER_HELPUP_CD ]);
		if (cooldown > 0)
		{
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  sprintf("Your target is on a /helpup cooldown for %d more seconds.", cooldown) );
		}
	}

	if (PlayerVar [ target ] [ E_PLAYER_INJURY_MIN_TICK ] > 60)
	{
		SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3", sprintf("You must wait %d seconds before this player can be helped up.", PlayerVar [ target ] [ E_PLAYER_INJURY_MIN_TICK ] - 60) ) ;
		return true;
	}

	// New smarter critical injury calcuation:
	new critical = IsPlayerCriticallyWounded(target);

	if (critical && !IsPlayerInMedicFaction(playerid, true)) 
	{
		return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "This player is critically wounded and can only be revived by paramedics." );
	}

	Injury_RemoveData_Player(target) ;

	if (critical)
	{	
		ProxDetectorEx ( playerid,30.0, COLOR_ACTION, "** Paramedic", sprintf("revives %s from critical injury.", ReturnMixedName ( target ) ), .annonated=true );
		SendClientMessage(target, COLOR_RED, sprintf("You were revived from critical injury by Paramedic %s (%d).", ReturnSettingsName ( playerid, target ), playerid ) ) ;
		SendClientMessage(playerid, COLOR_RED, sprintf("You revived %s (%d) from critical injury using your faction's medical capabilities.", ReturnSettingsName ( target, playerid ), target ) ) ;
	}
	else
	{
		ProxDetectorEx ( playerid,30.0, COLOR_ACTION, "**", sprintf("helps %s to their feet.", ReturnMixedName ( target ) ), .annonated=true );
		SendClientMessage(target, COLOR_RED, sprintf("You've been helped back up to your feet by %s (%d).", ReturnSettingsName ( playerid, target ), playerid ) ) ;
		SendClientMessage(playerid, COLOR_RED, sprintf("You helped %s (%d) back up to their feet.", ReturnSettingsName ( target, playerid ), target ) ) ;
	}
	
	SendClientMessage(target, COLOR_YELLOW, "Note that you are still injured and should visit a hospital to receive surgery for your wounds.") ;
	SendClientMessage(target, COLOR_YELLOW, "You must also wait 30 minutes before using weapons again or attacking other players.");

	SendClientMessage(playerid, COLOR_YELLOW, "Note that they are still injured, are not allowed to use weapons, and should be taken to a hospital.");
	SendClientMessage(playerid, COLOR_YELLOW, "They must also wait 30 minutes before using weapons again or attacking other players.");

	Character [ target ] [ E_CHARACTER_HELPUP_CD ]  = gettime();
	SetPlayerChatBubble(target, "", COLOR_YELLOW, 7.5, 900000);

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_helpup_cd = %d WHERE player_id = %d", 
		Character [ target ] [ E_CHARACTER_HELPUP_CD ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	//NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Helped up %s (%d) from injury", ReturnMixedName ( target ), target));
	AddLogEntry(target, LOG_TYPE_SCRIPT, sprintf("Was helped up from injury by %s (%d)", ReturnMixedName ( playerid ), playerid));

	return true ;
}

CMD:revive(playerid, params[])
{
	return cmd_helpup(playerid, params);
}

CMD:heal(playerid, params[]) 
{
	if (!IsPlayerInMedicFaction(playerid, true)) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You're not on duty as a firefighter/medic.") ;
	}

	new target;

	if ( sscanf ( params, "k<player>", target ) ) 
	{
	    return  SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/heal [player]" );
	}

	if ( ! IsPlayerConnected(target ) ) 
	{
	    return  SendServerMessage( playerid, COLOR_RED, "Connection", "A3A3A3",  "Your target isn't connected." );
	}

	if ( target == playerid ) 
	{
	    return  SendServerMessage( playerid, COLOR_RED, "Connection", "A3A3A3",  "You can't heal yourself." );
	}

	if ( !IsPlayerNearPlayer(playerid, target, 4.0 ) ) 
	{
	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not near your target." );
	}

	if ( PlayerVar [ target ] [ E_PLAYER_INJUREDMODE ] ) 
	{
	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "This player needs to be revived first." );
	}

	if (Character [ target ] [ E_CHARACTER_HEAL_CD ])
	{
		new	cooldown = 3600 - (gettime() - Character [ target ] [ E_CHARACTER_HEAL_CD ]);
		if (cooldown > 0)
		{
			return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  sprintf("Your target is on a /heal cooldown for %d more seconds.", cooldown) );
		}
	}

	new count = 0;

	for ( new i; i < MAX_WOUNDS; i ++ ) 
	{
		if ( PlayerWounds [ i ] [ dmg_player ] == target ) 
		{
			count ++;
		}
	}

	if ( !count ) 
	{
	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "This player has no injuries to heal." );
	}

	ProxDetectorEx ( playerid, 30.0, COLOR_ACTION, "** Paramedic", sprintf("heals the wounds of %s.", ReturnMixedName ( target ) ), .annonated=true );

	Injury_RemoveData(target) ;
	TogglePlayerControllable ( playerid, true ) ;

	SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  sprintf("You have healed the injuries of (%d) %s using your faction's medical capabilities.", target, ReturnSettingsName ( target, playerid ) ) );
	SendServerMessage( target, COLOR_INJURY, "Injury", "A3A3A3",  sprintf("Your injuries have been healed by Paramedic %s (%d).", ReturnSettingsName ( playerid, target ), playerid ) );

	SendAdminMessage ( sprintf("[AdmWarn] ** Paramedic %s (%d) healed the injuries of (%d) %s.", 
    	ReturnMixedName(playerid), playerid, target, ReturnMixedName ( target )));

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Healed the injuries of %s (%d)", ReturnMixedName ( target ), target));

	Character [ target ] [ E_CHARACTER_HEAL_CD ] = gettime();

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_heal_cd = %d WHERE player_id = %d", 
		Character [ target ] [ E_CHARACTER_HEAL_CD ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	return true ;
}

CMD:clearinjuriesradius(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float:radius;

	if ( sscanf ( params, "f", radius ) ) 
	{
	    return  SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/clearinjuriesradius [radius]" );
	}

	if (radius <= 0 || radius > 250)
	{
		return  SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "Radius must be between 1 and 250" );
	}

	new vw = GetPlayerVirtualWorld(playerid);
	new int = GetPlayerInterior(playerid);
	new count = 0;

	foreach(new i : Player) 
	{
		if (!IsPlayerPlaying(i)) continue;
		if (GetPlayerVirtualWorld(i) != vw || GetPlayerInterior(i) != int) continue;

		if (IsPlayerNearPlayer(i, playerid, radius))
		{
			Injury_RemoveData(i);
			TogglePlayerControllable(i, true );
			AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Cleared the injuries of (%d) %s", i, ReturnMixedName(i)));
			SendServerMessage(i, COLOR_INJURY, "Injury", "A3A3A3", sprintf("Your injuries have been cleared by (%d) %s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME]) );

			count ++;
		}	
	}

	if (count)
	{
		SendAdminMessage(sprintf("[AdmWarn] (%d) %s cleared the injuries of %d players in a %.02f radius.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], count, radius));
	}

	return true;
}

CMD:reviveradius(playerid, params[])
{
	return cmd_clearinjuriesradius(playerid, params);
}

CMD:clearinjuries(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

	    return  SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/clearinjuries [playerid/part of name]" );
	}

	if ( ! IsPlayerConnected(target ) ) {

	    return  SendServerMessage( playerid, COLOR_RED, "Connection", "A3A3A3",  "Your target isn't connected." );
	}

	Injury_RemoveData(target) ;
	TogglePlayerControllable ( target, true ) ;

	SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  sprintf("You have cleared the injuries of (%d) %s.", target, ReturnMixedName ( target ) ) );
	SendServerMessage( target, COLOR_INJURY, "Injury", "A3A3A3",  sprintf("Your injuries have been cleared by (%d) %s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME]) );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Cleared the injuries of (%d) %s", target, ReturnMixedName(target)));

	return true ;
}

Injury_RemoveVariables(playerid) {

	PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] = false ;
	PlayerVar [ playerid ] [ E_PLAYER_INJURED_LAST_VEH ] = 0 ;
	PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] = 60 ;

    PlayerDamage [ playerid ] [ DAMAGE_LEGS ] = false ;
    PlayerDamage [ playerid ] [ DAMAGE_ARMS ] = false ;

    // Leg stumble
    player_damaged_leg [ playerid ] = false;
    player_leg_tick [ playerid ] = 0 ;
    antiReFall [ playerid ] = false ;

	PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED_TIME ] = 0 ;
	PlayerVar [ playerid ] [ E_PLAYER_IS_TAZED ]  = false ;

	PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED_TIME ] = 0 ;
	PlayerVar [ playerid ] [ E_PLAYER_IS_BEANBAGGED ]  = false ;

	PlayerVar [ playerid ] [ E_PLAYER_IS_TACKLED ] = false ;

	return true ;
}

hook OnPlayerConnect(playerid) {
	InjuryRestoreCamera[playerid] = 0;
	InjuryRestoreSpraycan[playerid] = 0;
	return 1;
}