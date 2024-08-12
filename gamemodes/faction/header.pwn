enum { // Cross script!

	E_FACTION_EXTRA_NONE,
	E_FACTION_EXTRA_GUNS,
	E_FACTION_EXTRA_DRUGS_WEED,
	E_FACTION_EXTRA_DRUGS_CRACK,
	E_FACTION_EXTRA_DRUGS_COKE,
	E_FACTION_EXTRA_DRUGS_METH
}

#include "faction/data.pwn"
#include "faction/func.pwn"
#include "faction/squads.pwn"
#include "faction/admin.pwn"
#include "faction/member.pwn"
#include "faction/player.pwn"
#include "faction/spawn.pwn"
#include "faction/communication.pwn"

#include "faction/bank/header.pwn"
#include "faction/armory.pwn"
#include "faction/skins/header.pwn"

// https://i.imgur.com/37peJ77.png
// https://imgur.com/a/B5UvTyo?fbclid=IwAR1rSO8Gu7HdGmLczirxDHx9gjldtHFvHJrnU0S8zdgEjf85jGVC9UtBJCY
// https://i.imgur.com/Z6ihs2Z.png

// func IsFactionTypeVehicle
IsFactionTypeVehicle(vehicleid, factiontype)
{
	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) 
	{
		return false;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) 
	{
		return false;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION )
	{
		for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) 
		{
			if ( Faction [ i ] [ E_FACTION_ID ] == Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] && Faction [ i ] [ E_FACTION_TYPE ] == factiontype ) 
			{
				return true;
			}
		}
	}

	return false;
}

bool:IsFactionVehicle(vehicleid, factionid)
{
	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) 
	{
		return false;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) 
	{
		return false;
	}

	return Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION && Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == factionid;
}

bool:IsGovFactionVehicle(vehicleid)
{
	new factiontype = GetVehicleFactionType(vehicleid);
	return factiontype == FACTION_TYPE_POLICE || factiontype == FACTION_TYPE_EMS || factiontype == FACTION_TYPE_GOV;
}

// func GetVehicleFactionType
GetVehicleFactionType(vehicleid)
{
	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) 
	{
		return -1;
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) 
	{
		return -1;
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION )
	{
		for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) 
		{
			if ( Faction [ i ] [ E_FACTION_ID ] == Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] ) 
			{
				return Faction [ i ] [ E_FACTION_TYPE ];
			}
		}
	}

	return -1;
}

GetPlayerFactionType(playerid)
{
	if ( Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) 
	{
		new faction_enum_id = Faction_GetEnumID ( Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) ;
		return Faction_GetType(faction_enum_id );
	}

	return -1;       
}

GetPlayerFactionSuspension(playerid)
{
	new suspended = 0;

	if (Character[playerid][E_CHARACTER_FACTIONID] && Character[playerid][E_CHARACTER_FACTION_SUSPENSION] && Character[playerid][E_CHARACTER_FACTION_SUSPENSION] > gettime())
	{
		suspended = Character[playerid][E_CHARACTER_FACTION_SUSPENSION] - gettime();
	}

	return suspended;
}

stock IsPlayerInFaction(playerid, factionid, bool:onduty=false)
{
	new faction = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	return faction == factionid && (!onduty || PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ]);
}

IsPlayerInFactionType(playerid, factiontype, bool:onduty=false) 
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return false ;
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return false ;
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == factiontype && (!onduty || PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ])) {

		return true ;
	}

	return false ;
}

IsPlayerInDutyFaction(playerid) 
{
	return IsPlayerInPoliceFaction(playerid) || IsPlayerInMedicFaction(playerid) || IsPlayerInNewsFaction(playerid) || IsPlayerInGovFaction(playerid);
}

IsPlayerInMedicFaction(playerid, bool:onduty=false) 
{
	return IsPlayerInFactionType(playerid, FACTION_TYPE_EMS, onduty);
}

IsPlayerInTruckerFaction(playerid, bool:onduty=false) 
{
	return IsPlayerInFactionType(playerid, FACTION_TYPE_TRUCKER, onduty);
}

IsPlayerInGovFaction(playerid, bool:onduty=false) 
{
	return IsPlayerInFactionType(playerid, FACTION_TYPE_GOV, onduty);
}

IsPlayerInAnyGovFaction(playerid, bool:onduty=false) 
{
	return IsPlayerInPoliceFaction(playerid, onduty) || IsPlayerInMedicFaction(playerid, onduty) || IsPlayerInGovFaction(playerid, onduty);
}

// TODO: Move these to gov
IsPlayerGovJudge(playerid, bool:onduty=false)
{
	return IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_COURT, FACTION_TYPE_GOV, onduty);
}

IsPlayerGovAdmin(playerid, bool:onduty=false)
{
	return IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_ADMIN, FACTION_TYPE_GOV, onduty);
}

IsPlayerGovCop(playerid, bool:onduty=false)
{
	return IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_DAO, FACTION_TYPE_GOV, onduty);
}

IsPlayerGovRecords(playerid, bool:onduty=false)
{
	return IsPlayerGovJudge(playerid, onduty) || IsPlayerGovCop(playerid, onduty) || IsPlayerGovAdmin(playerid, onduty);
}

//--
CMD:leavefaction(playerid, params[]) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id != INVALID_FACTION_ID ) 
	{
		Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has left the faction. }",
			Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid )), faction_enum_id, false ) ;
	}

	// Disarm them as a precaution
	if (IsPlayerInDutyFaction(playerid))
	{
		Weapon_ResetPlayerWeapons(playerid);
	}

	Character [ playerid ] [ E_CHARACTER_FACTIONID ] = 0 ;
	Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] = 3 ;
	Character [ playerid ] [ E_CHARACTER_FACTION_SUSPENSION ] = 0 ;
	Character [ playerid ] [ E_CHARACTER_FACTIONRANK ] [ 0 ] = EOS ;
	strcat(Character [ playerid ] [ E_CHARACTER_FACTIONRANK ], "None" ) ;

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factionid = 0, player_factiontier = 3, player_factionrank = 'None', player_factionsuspension = 0 WHERE player_id = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	SendClientMessage(playerid, 0xA3A3A3FF, "You've left your faction.");
	return true ;
}


ShowFactionCommands(playerid) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new  faction_enum_id = Faction_GetEnumID(factionid);

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	SendClientMessage(playerid, 0x5FB9D1FF, "[ ___________ Faction Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]:{B2FFCD} /f(action), /(un)invite, /settier, /setrank, /setsquad, /nofac, /ftow");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]:{B2FFCD} /fvehicles (/fcars, /fveh, /fvehs), /fpark, /fskins, /fspawn");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]:{B2FFCD} /fspawnicon, /fspawntog /nofac, /fcarcolor, /factionbank");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]:{B2FFCD} /leavefaction, /chopshopcollect, /suspend, /fonline, /foffline");

	// Is player police
	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == 0 ) {

		SendClientMessage(playerid, 0x77BBFAFF, "[PD]: {BBDEFF}/duty, /kev, /armory, /radio, /dep, /channel, /hq, /m, /searchaddress, /cuff");
		SendClientMessage(playerid, 0x77BBFAFF, "[PD]: {BBDEFF}/(un)cuff, /tazer, /beanbag, /tackle, /carcheck, /searchplate, /searchdata");
		SendClientMessage(playerid, 0x77BBFAFF, "[PD]: {BBDEFF}/takelicense, /frisk, /disarm, /confiscate, /breakincar, /tolls, /arrest");
		SendClientMessage(playerid, 0x77BBFAFF, "[PD]: {BBDEFF}/charge, /viewcrimes, /writeticket, /giveticket, /viewtickets, /driverwarn");
		SendClientMessage(playerid, 0x77BBFAFF, "[PD]: {BBDEFF}/prisoners, /viewairspace, /atc, /setsquad, /setbadge, /showbadge, /lastalarm");
		SendClientMessage(playerid, 0x77BBFAFF, "[PD]: {BBDEFF}/p(anic)b(utton), /b(ac)k(up), /cancelpanic, /cancelbk, /cad, /units, /swat, /spikes");
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == FACTION_TYPE_GOV ) {

		SendClientMessage(playerid, 0x7a8ea1FF, "[GOV]: {BBDEFF}/duty, /radio, /dep, /hq, /armory, /setbadge, /showbadge");

		if (IsPlayerGovCop(playerid))
		{
			SendClientMessage(playerid, 0x7a8ea1FF, "[GOV Investigator]: {BBDEFF}/kevlar, /(un)cuff, /tackle, /charge");
		}

		if (IsPlayerGovRecords(playerid))
		{
			SendClientMessage(playerid, 0x7a8ea1FF, "[GOV Records]: {BBDEFF}/searchdata, /searchplate, /viewcrimes, /viewtickets");
		}
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == FACTION_TYPE_EMS ) {

		SendClientMessage(playerid, 0xF87070FF, "[FD]: {FDBCBC}/duty, /radio, /dep, /hq, /armory, /setbadge, /showbadge");
		SendClientMessage(playerid, 0xF87070FF, "[FD]: {FDBCBC}/cad, /m, /atc, /revive, /heal, /lastalarm, /panic");
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == FACTION_TYPE_NEWS ) {

		SendClientMessage(playerid, 0xFFCC68FF, "[NEWS]: {FFE1A8}/pager, /atc, /showbadge, /breaking, /broadcast, /live");
	}


	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] > ADMIN_LVL_NONE ) {
		SendClientMessage(playerid, 0x58DD85FF, "[ADMIN]:{B2FFCD} /afjoin, /f(action)name, /f(action)create, /fskinadd, /fhex");
	}
	
	return true ;
}