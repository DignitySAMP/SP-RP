

RemovePlayerCustomWeapon(playerid, idx ) {

	new query [ 384 ] ;

	for ( new i, j = MAX_WEAPON_SLOTS, index ; i < j ; i ++ ) {
		index = PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] ;
		if ( index == idx ) {

			mysql_format(mysql, query, sizeof(query), "DELETE FROM player_weapons WHERE weapon_id = %d AND character_id = %d", idx, Character [ playerid ] [ E_CHARACTER_ID ] ) ;
		    mysql_tquery(mysql, query );

			AC_RemovePlayerWeapon(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ] ) ;
			SOLS_SetPlayerAmmo(playerid, Weapon [ idx ] [ E_WEAPON_GUNID ], 0);
			PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] = 0 ;

			break;
		}
		else continue ;
	}
}

Weapon_ResetPlayerWeapons(playerid) {

	new query[384] ;

	// Clearing the database to make sure that invalid guns are gone.
	mysql_format(mysql, query, sizeof(query), "DELETE FROM player_weapons WHERE character_id = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
    mysql_tquery(mysql, query );


	for ( new i, j = MAX_WEAPON_SLOTS ; i < j ; i ++ ) {

		PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ] = 0 ;
	}

    ResetPlayerWeapons(playerid);
}

Weapon_SavePlayerWeapons(playerid) 
{
	if (!PlayerVar[playerid][E_PLAYER_WEAPONS_LOADED])
	{
		// Don't need to save a players weapons if they haven't first been loaded :)
		printf("Skipping saving weapons for (%d) %s (Char ID: %d) as they weren't loaded in the first place.", playerid, ReturnMixedName(playerid), Character[playerid][E_CHARACTER_ID]);
		return false;
	}

	new ammo, idx, query[256];

	if ( PlayerVar [ playerid ] [ E_PLAYER_DRIVEBY_BRASSKNUCKLES ] ) {
		PlayerVar [ playerid ] [ E_PLAYER_DRIVEBY_BRASSKNUCKLES ]  = false ;
		PlayerVar [ playerid ] [ E_PLAYER_WEAPON_EQUIPPED ][ 0 ] = 1 ;
	}

	for ( new i, j = MAX_WEAPON_SLOTS ; i < j ; i ++ ) 
	{
		idx = PlayerVar[playerid][E_PLAYER_WEAPON_EQUIPPED][i];
		ammo = PlayerVar[playerid][E_PLAYER_AMMO_SYNCED][i];
		
		if (idx > 0) 
		{
	    	mysql_format(mysql, query, sizeof(query), "INSERT INTO player_weapons VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE weapon_ammo = %d;", Character [ playerid ] [ E_CHARACTER_ID ], idx, ammo, ammo);
	    	mysql_pquery(mysql, query); // parallel queries
			print(query);
	  	}

		else continue ;
	}

	return true;
}

Weapon_LoadPlayerWeapons(playerid) 
{
	if (!IsPlayerSpawned(playerid) || !IsPlayerPlaying(playerid) || PlayerVar[playerid][E_PLAYER_WEAPONS_LOADED] || Character[playerid][E_CHARACTER_AJAIL_TIME] > 0)
	{
		// Don't need to load weapons if the player is not playing, not spawned, already loaded or in ajail
		// SendClientMessage(playerid, -1, "TEST: The server declined to load your saved weapons (if any).");
		PlayerVar[playerid][E_PLAYER_WEAPONS_LOADED] = true;
		return false;
	}

	ResetPlayerWeapons(playerid);

    new
        index,
        ammo,
        query[256],
		gun_name[64]
    ;

	inline Server_OnDataLoad() 
	{
		new count;
	    for (new i = 0, r = cache_num_rows(); i < r; ++i) // loop through all the rows that were found
	    {
			cache_get_value_name_int(i, "weapon_id", index);
			cache_get_value_name_int(i, "weapon_ammo", ammo);
	        
	        if(!(0 <= index <= sizeof ( Weapon ) ) ) // check if weapon is valid (should be)
	        {
	            printf("[warning] OnLoadPlayerWeapons (%d: %s) - Unknown weaponid '%d'. Skipping.", playerid, TEMP_ReturnPlayerName(playerid), index);
	            continue;
	        }

			if (ammo < 1)
			{
				printf("[warning] OnLoadPlayerWeapons (%d: %s) - Invalid ammo (%d) for weaponid '%d'. Skipping.", playerid, TEMP_ReturnPlayerName(playerid), ammo, index);
	            continue;
			}

			if (index == 67)
			{
				// skip pd deagle if not in a police faction, or not on duty as arson
				if (!IsPlayerInPoliceFaction(playerid) && !IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_DAO, FACTION_TYPE_GOV))
				{
					printf("[warning] OnLoadPlayerWeapons (%d: %s) - Not in faction/on duty for weaponid '%d'. Skipping.", playerid, TEMP_ReturnPlayerName(playerid), index);
					continue;
				}
			}

	        GiveCustomWeapon(playerid, index, ammo ) ;
			Weapon_GetGunName(index, gun_name, sizeof(gun_name ));
			AddLogEntry(playerid, LOG_TYPE_GAME, sprintf("Loaded into the game with a %s (%d) (Ammo: %d)", gun_name, index, ammo), true);
			
			count ++;
	    }

		if (count)
		{
			SetPlayerArmedWeapon(playerid, 0);
			if (count == 1) SendServerMessage(playerid, COLOR_INFO, "Weapons", "A3A3A3", sprintf("%d saved weapon was loaded and given to you.", count));
			else SendServerMessage(playerid, COLOR_INFO, "Weapons", "A3A3A3", sprintf("%d saved weapons were loaded and given to you.", count));
			printf("[weapons load] Restored %d saved weapons for (%d) %s (Char: %d)", count, playerid, ReturnMixedName(playerid), Character [ playerid ] [ E_CHARACTER_ID ]);
		}
		else
		{
			AddLogEntry(playerid, LOG_TYPE_GAME, "Loaded into the game.", true);
		}
	}

	mysql_format(mysql, query, sizeof(query), "SELECT weapon_id, weapon_ammo FROM player_weapons WHERE character_id = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	MySQL_TQueryInline(mysql, using inline Server_OnDataLoad, query, "" ) ;

	// Stop weapons being loaded again now that they've been loaded :)
	PlayerVar[playerid][E_PLAYER_WEAPONS_LOADED] = true;

    return true;
}

Weapon_SetSkillLevel(playerid, amount) {

	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 			0 );	
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 	amount );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 	amount );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 			amount );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 	0 );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 	200 );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 		0 );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 				amount );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 			amount );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 				amount );
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 		amount );
}
