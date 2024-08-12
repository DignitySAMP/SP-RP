
static PropertyDlgStr[4096];

enum
{
	PLAYER_SPAWN_TYPE_LAST,
	PLAYER_SPAWN_TYPE_FACTION,
	PLAYER_SPAWN_TYPE_PROPERTY,
	PLAYER_SPAWN_TYPE_NEWBIE
}

new PlayerSpawnOptions[MAX_PLAYERS][4];

Player_DisplaySpawnList(playerid, bool:respawn=false) {

	inline SpawnLocationPick(pid, dialogid, response, listitem, string:inputtext[] ) 
	{ 
		#pragma unused pid, dialogid, response, listitem, inputtext

		if ( ! response && !respawn ) 
		{
			SendClientMessage(pid, COLOR_RED, "Actually choose a spawn location!");
			return Player_DisplaySpawnList(pid) ;
		}

		if ( response ) 
		{
			PlayerSpawnSelection(pid, listitem, respawn );
			return true;
		}
	}

	format(PropertyDlgStr, sizeof(PropertyDlgStr), "Type\tOption\n");

	new options = 0, address[64], zone[64];

	if (Character[playerid][E_CHARACTER_ARREST_TIME])
	{
		strcat(PropertyDlgStr, "{BCAAA4}Prison\tBack to your cell...");
		PlayerSpawnOptions[playerid][options] = PLAYER_SPAWN_TYPE_LAST;
		options ++;
	}
	else
	{
		if (Character[playerid][E_CHARACTER_LAST_POS_X] && Character[playerid][E_CHARACTER_LAST_POS_Y] && Character[playerid][E_CHARACTER_LAST_POS_Z])
		{
			new Float:x, Float:y;
			x = Character[playerid][E_CHARACTER_LAST_POS_X];
			y = Character[playerid][E_CHARACTER_LAST_POS_Y];
			//new Float:z = Character[playerid][E_CHARACTER_LAST_POS_Z];

			if (Character[playerid][E_CHARACTER_LAST_POS_VW] > 0)
			{
				// TODO: They were probably in a property, so use the exterior of that if they were for the last position name
			}

			GetCoords2DZone(x, y, zone, sizeof(zone));
			GetPlayerAddress(x, y, address);

			strcat(PropertyDlgStr, sprintf("{FFCC80}Previous Location\t%s, %s\n", address, zone));
			PlayerSpawnOptions[playerid][options] = PLAYER_SPAWN_TYPE_LAST;
			options ++;
		}

		if (Character[playerid][E_CHARACTER_FACTIONID]) 
		{
			new faction_enum_id = Faction_GetEnumID(Character[playerid][E_CHARACTER_FACTIONID]);
			if (faction_enum_id != -1) 
			{
				strcat(PropertyDlgStr, sprintf("{9FA8DA}Your Faction\t%s\n", Faction_GetNameByID(faction_enum_id)));
				PlayerSpawnOptions[playerid][options] = PLAYER_SPAWN_TYPE_FACTION;
				options ++;
			}
		}

		new properties = GetPlayerPropertyCount(playerid);
		if (properties)
		{
			strcat(PropertyDlgStr, "{80CBC4}Your Properties\tSelect...\n");
			PlayerSpawnOptions[playerid][options] = PLAYER_SPAWN_TYPE_PROPERTY;
			options ++;
		}

		strcat(PropertyDlgStr, "{F48FB1}Newcomer Spawns\tSelect...\n");
		PlayerSpawnOptions[playerid][options] = PLAYER_SPAWN_TYPE_NEWBIE;

		PlayerVar[playerid][E_PLAYER_SPAWN_OPTIONS_COUNT] = options;
	}

	if (options)
	{
		if (respawn)
		{
			Dialog_ShowCallback ( playerid, using inline SpawnLocationPick, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Selection", PropertyDlgStr, "Select", "Back" ) ;
		}
		else
		{
			Dialog_ShowCallback ( playerid, using inline SpawnLocationPick, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Selection", PropertyDlgStr, "Select", "" ) ;
		}
	}
	else
	{
		// Show the newcomer spawn dialog instead since there's nowhere else
		Spawn_Newbie(playerid, respawn);
	}

	if (respawn)
	{
		return true;
	}


	return true ;			
}


timer OnSpawn_Common[1000](playerid, isrespawn)
{
	Attach_LoadDelayedEntities(playerid);

	if (!isrespawn)
	{
		// Legacy refunds (the old code like furniture)
		CheckLegacyRefunds(playerid);
		
		// New refund system (weapons and properties)
		Refund_CheckRefunds(playerid); 

		// Load players weapons (this function has additional checks in it)
		Weapon_LoadPlayerWeapons(playerid); 
	}

	// And then fire the hookable spawn event for setting other stuff
	CallLocalFunction("SOLS_OnCharacterSpawn", "dd", playerid, isrespawn);
	PlayerVar[playerid][E_PLAYER_FIRST_SPAWN] = false;
}

Spawn_Common(playerid, isrespawn=0)
{
	// Very important that this is set.
	PlayerVar[playerid][E_PLAYER_SPAWNED_CHARACTER] = true;
	PlayerVar[playerid][E_PLAYER_CREATING_CHAR] = false;

	// Then doing the rest on a short delay to maybe solve some spawn issues for people
	defer OnSpawn_Common(playerid, isrespawn);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	// printf("OnPlayerRequestSpawn: (%d) %s", playerid, SOLS_PlayerName(playerid, PLAYER_NAME_STYLE_DEFAULT));

    if (!IsPlayerLogged(playerid) || !PlayerVar[playerid][E_PLAYER_CHOSE_CHARACTER])
	{
		SendClientMessage(playerid, -1, "You must login to spawn!");
		SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s tried to spawn without logging in or choosing a character.", playerid, ReturnMixedName(playerid)));
		printf("Blocked OnPlayerRequestSpawn for %d (%s)", playerid, ReturnMixedName(playerid));
		return 0;
	}

    return 1;
}

#include <YSI_Coding\y_hooks>

forward SOLS_OnPlayerSpawn(playerid);
public SOLS_OnPlayerSpawn(playerid)
{	
	if (!PlayerVar[playerid][E_PLAYER_SPAWNED_CHARACTER])
	{
		printf("SOLS_OnPlayerSpawn (FIRST): (%d) %s", playerid, ReturnMixedName(playerid));
		new year, month, day, hour, minute, second;
		stamp2datetime(gettime(), year, month, day, hour, minute, second, 1 );
		// SendClientMessage(playerid, -1, sprintf("TEST: You were spawned into the game at %02d:%02d:%02d.", hour, minute, second));
		Spawn_Common(playerid, 0);
	}
	else
	{
		printf("SOLS_OnPlayerSpawn (RESPAWN): (%d) %s", playerid, ReturnMixedName(playerid));
		Spawn_Common(playerid, 1);
	}

	return 1;
}

hook OnPlayerSpawn(playerid)
{
	printf("OnPlayerSpawn: (%d) %s", playerid, ReturnMixedName(playerid));

	if (!IsPlayerLogged(playerid))
	{
		// SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s spawned without logging in and was kicked.", playerid, SOLS_PlayerName(playerid, PLAYER_NAME_STYLE_DEFAULT)));
		printf("[!] Kicked (%d) %s for spawning without being logged in.", playerid, ReturnMixedName(playerid));
		Kick(playerid);
		return 0;
	}

	if (!PlayerVar[playerid][E_PLAYER_CHOSE_CHARACTER])
	{
		// SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s spawned without choosing a character and was kicked.", playerid, SOLS_PlayerName(playerid, PLAYER_NAME_STYLE_DEFAULT)));
		printf("[!] Kicked (%d) %s for spawning without choosing a character.", playerid, ReturnMixedName(playerid));
		Kick(playerid);
		return 0;
	}

	CallLocalFunction("SOLS_OnPlayerSpawn", "d", playerid);
	return 1;
}

// Handles refunds on login.
static LegacyRefundQuery[256];
static CheckLegacyRefunds(playerid)
{
	if ( Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] ) {
		FuelStation_RefundPlayer(playerid);

		Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ] = 0 ;

		mysql_format(mysql, LegacyRefundQuery, sizeof(LegacyRefundQuery), "UPDATE characters SET player_soldfuelstation = 0 WHERE player_id = %d", 
			Character [ playerid ] [ E_CHARACTER_ID ] ) ;
		mysql_tquery(mysql, LegacyRefundQuery);
	}

	if ( Character [ playerid ] [ E_CHARACTER_SOLD_PROPERTY ] ) {

		new id = Character [ playerid ] [ E_CHARACTER_SOLD_PROPERTY ] ;

		Property_RefundPlayer(playerid, id) ;

		Character [ playerid ] [ E_CHARACTER_SOLD_PROPERTY ] = -1 ;
		mysql_format(mysql, LegacyRefundQuery, sizeof(LegacyRefundQuery), "UPDATE characters SET player_soldproperty = 0 WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, LegacyRefundQuery);
	}

	if ( Character [ playerid ] [ E_CHARACTER_SOLD_FURNITURE ] ) {

		SendClientMessage(playerid, -1, " " ) ;
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("WARNING:{DEDEDE} ALL of your furniture has been sold while you were OFFLINE. You have been refunded $%s.",
			IntegerWithDelimiter ( Character [ playerid ] [ E_CHARACTER_SOLD_FURNITURE ] ) ) ) ;
		SendClientMessage(playerid, COLOR_RED, "If you think this was a mistake, post a refund request with the property ID. ");
		SendClientMessage(playerid, -1, " " ) ;

		GivePlayerCash ( playerid, Character [ playerid ] [ E_CHARACTER_SOLD_FURNITURE ] ) ;
		Character [ playerid ] [ E_CHARACTER_SOLD_FURNITURE ] = 0 ;

		mysql_format(mysql, LegacyRefundQuery, sizeof(LegacyRefundQuery), "UPDATE characters SET player_soldfurni = 0 WHERE player_id = %d",
			Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, LegacyRefundQuery);
	}
}



// -------------------------------------------------------
// The below functions are whenever a player spawns or respawns from the MENUS only (e.g. login or /respawnplayer) and NOT if they die/respawn from the GAME
// Use them when your scripts need to do stuff when a player logs in, e.g. checking if they have an email address set
// Example is below, always include y_hooks at the top of the file first (so that the same hook in different files don't conflict)


// #include <YSI_Coding\y_hooks>

/*
	hook SOLS_OnCharacterSpawn(playerid, isrespawn)
	{
		PlayerVar[playerid][E_PLAYER_PM_BLOCKED] = true;
		SendClientMessage(playerid, COLOR_YELLOW, "Your PMs have been automatically blocked to avoid player nuisance.");
		return 1;
	}
*/

// -----------------------------------------------------
