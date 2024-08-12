CMD:frisk(playerid, params[])
{
	new giveplayerid;
	if (sscanf(params, "k<player>", giveplayerid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Usage: /frisk [playerid/name]");
	if (!IsPlayerConnected(giveplayerid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This player isn't connected.");

	if (playerid == giveplayerid || (IsPlayerNearPlayer(playerid, giveplayerid, 3.0) && (IsPlayerIncapacitated(giveplayerid, false) || GetPVarInt(giveplayerid, "CUFFED") == 1 || PlayerVar[playerid][E_PLAYER_ADMIN_DUTY])))
	{
		// Allow injured, tasered, cuffed or beanbagged players to be frisked without accepting
		// Also allow admins to force it

		Police_OnPlayerFriskResponse(giveplayerid, playerid, true);
		return true;
	}

	if (GetPlayerAdminLevel(playerid) >= ADMIN_LVL_JUNIOR && !IsPlayerNearPlayer(playerid, giveplayerid, 3.0))
	{
		// Allow admin frisk
		Police_OnPlayerFriskResponse(giveplayerid, playerid, true);
		return true;
	}

	if (!IsPlayerNearPlayer(playerid, giveplayerid, 3.0)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You are not near this player.");
	if (IsPlayerInAnyVehicle(playerid) || IsPlayerInAnyVehicle(giveplayerid)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You can't frisk someone if either you or they are in a vehicle.");	
	if (GetPVarInt(giveplayerid, "FRISKREQUEST") != 0) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This player already has a pending frisk request, wait for them to accept.");		        
	
	new string[144];
	format(string, sizeof(string), "[Info] {777777}You have sent a {1F85DE}frisk request{777777} to (%d) %s.", giveplayerid, ReturnSettingsName(giveplayerid, playerid));
	SendClientMessage(playerid, 0xAAFF00FF, string);
	format(string, sizeof(string), "[Info] {777777}%s wants to frisk you, type {1F85DE}\"/accept frisk\"{777777} to accept.", ReturnSettingsName(playerid, giveplayerid));
	SendClientMessage(giveplayerid, 0xAAFF00FF, string);

	SetPVarInt(giveplayerid, "FRISKREQUEST", 1);
	SetPVarInt(giveplayerid, "FRISKREQUESTER", playerid);

	defer FriskRequestExpire(giveplayerid, playerid);
	return true;
}

Police_OnPlayerFriskResponse(playerid, targetid=INVALID_PLAYER_ID, bool:force=false) 
{
	// Targetid here is the person who frisks. Playerid is the victim.
	if (targetid == INVALID_PLAYER_ID)
	{
		targetid = GetPVarInt(playerid, "FRISKREQUESTER");
	}

	if (!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid) || (!IsPlayerNearPlayer(playerid, targetid, 5.0) && !force))
	{
		// Don't do anything.
		SetPVarInt(playerid, "FRISKREQUEST", 0);
		return true;
	}

	if (GetPVarInt(playerid, "FRISKREQUEST") == 1 || force)
	{
	    SetPVarInt(playerid, "FRISKREQUEST", 0);
		ShowPlayerFriskDlg(targetid, playerid);

		if (IsPlayerNearPlayer(playerid, targetid, 5.0) && !PlayerVar[targetid][E_PLAYER_ADMIN_DUTY]) 
		{
			if (playerid == targetid) ProxDetectorEx(playerid, 15.0, COLOR_PURPLE, "**", "pats themselves down.", false, true);
			else ProxDetectorEx(targetid, 15.0, COLOR_PURPLE, "**", sprintf("has frisked %s.", ReturnMixedName(playerid)), false, true);
		}

		// No longer needed, since players have to accept frisks now
		//new query[144];
		//format(query, sizeof(query), "[!] FRISK: (%d) %s has frisked (%d) %s.", playerid, ReturnPlayerNameData(playerid), targetid, ReturnPlayerNameData(targetid));
		//SendAdminMessage(query);

		// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
		AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Used /frisk on %s (%d)", ReturnMixedName(playerid), playerid));
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Was frisked by %s (%d)", ReturnMixedName(targetid), targetid));
	}

	return true;		
}

timer FriskRequestExpire[15000](playerid, targetid) {

	#pragma unused targetid

	// playerid = player who has request
	// targetid = player who sent request
	
	if (GetPVarInt(playerid, "FRISKREQUEST") == 1)
	{
	    //SendClientMessage(playerid, -1, "{AAFF00}[Info] {777777}Your cuff request has expired.");
	    //SendClientMessage(targetid, -1, "{AAFF00}[Info] {777777}Your cuff request has expired.");
		SetPVarInt(playerid, "FRISKREQUEST", 0);
	}

	return 1;
}

static frisk_dlg_str[2048];

ShowPlayerFriskDlg(playerid, targetid, bool:print=false)
{
	// Generate Frisk Output - New Dialog
	format(frisk_dlg_str, sizeof(frisk_dlg_str), "Item\tAmount");
	new ammo_name[32];
	new gunid, ammo, count = 0;

	if (print)
	{
		if (targetid == playerid) SendClientMessage(playerid, COLOR_BLUE, sprintf("Inventory of %s:", ReturnSettingsName(targetid, playerid)));
		else SendClientMessage(playerid, COLOR_BLUE, sprintf("Items found on %s:", ReturnSettingsName(targetid, playerid)));
	} 

	for ( new i, j = 12 ; i < j ; i ++ ) 
	{
		new idx = PlayerVar [ targetid ] [ E_PLAYER_WEAPON_EQUIPPED ][ i ];
		GetPlayerWeaponData(targetid, i, gunid, ammo ) ;

		if ( idx != 0 && ammo > 0 ) 
		{
			Weapon_GetAmmoName ( idx, ammo_name, sizeof ( ammo_name ) ) ;

			if (print)
			{
				SendClientMessage(playerid, COLOR_BLUE, sprintf("{FFAB91}%s: %d (%s)", Weapon[idx][E_WEAPON_DESC], ammo, ammo_name));
			}
			else
			{
				if (Weapon[idx][E_WEAPON_AMMO]) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{FFAB91}%s\t%d x %s", frisk_dlg_str, Weapon[idx][E_WEAPON_DESC], ammo, ammo_name);
				else format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{FFAB91}%s\t%d", frisk_dlg_str, Weapon[idx][E_WEAPON_DESC], ammo);
			}

			count ++;
		}
	}

	new drug_name[32], drug_type[32], package_name[32], Float:drug_amount;
	for ( new i, j = MAX_PLAYER_DRUGS; i < j ; i ++ ) 
	{
		if ( PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_TYPE ] != E_DRUG_TYPE_NONE && PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_AMOUNT ] > 0 ) 
		{
			Drugs_GetParamName ( PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_PARAM ], drug_name) ;
			Drugs_GetPackageName ( PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
			Drugs_GetTypeName(PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;
			drug_amount = PlayerDrugs [ targetid ] [ i ] [ E_PLAYER_DRUG_AMOUNT ];

			if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{F48FB1}%s\t%.02fg (%s) (%s)", frisk_dlg_str, package_name, drug_amount, drug_name, drug_type);
			else SendClientMessage(playerid, COLOR_BLUE, sprintf("{F48FB1}%s: %.02fg (%s) (%s)", package_name, drug_amount, drug_name, drug_type));

			count ++;
		}
	}

	if (Character[targetid][E_CHARACTER_CASH] > 0)
	{
		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{C5E1A5}Money\t$%s", frisk_dlg_str, IntegerWithDelimiter(Character[targetid][E_CHARACTER_CASH]));
		else SendClientMessage(playerid, COLOR_BLUE, sprintf("{C5E1A5}Money: $%s", IntegerWithDelimiter(Character[targetid][E_CHARACTER_CASH])));

		count ++;
	} 

	if (GetPlayerAdminLevel(playerid) >= ADMIN_LVL_JUNIOR) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{C5E1A5}Bank\t$%s (Admin Frisk)", frisk_dlg_str, IntegerWithDelimiter(Character[targetid][E_CHARACTER_BANKCASH]));
	
	if (Character[targetid][E_CHARACTER_PHONE_NUMBER])
	{
		if (playerid == targetid)
		{
			if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}Cellphone\t%s (%d)", frisk_dlg_str, PlayerVar[targetid][E_PLAYER_PHONE_STATUS] ? "1 (On)" : "1 (Off)", Character[targetid][E_CHARACTER_PHONE_NUMBER]);
			else SendClientMessage(playerid, COLOR_BLUE, sprintf("{ADBEE6}Cellphone %s (%d)", PlayerVar[targetid][E_PLAYER_PHONE_STATUS] ? "(On)" : "(Off)", Character[targetid][E_CHARACTER_PHONE_NUMBER]));
		}
		else
		{
			if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}Cellphone\t%s", frisk_dlg_str, PlayerVar[targetid][E_PLAYER_PHONE_STATUS] ? "1 (On)" : "1 (Off)");
			else SendClientMessage(playerid, COLOR_BLUE, sprintf("{ADBEE6}Cellphone %s", PlayerVar[targetid][E_PLAYER_PHONE_STATUS] ? "(On)" : "(Off)"));
		}

		
		
		count ++;
	}

	if (Character[targetid][E_CHARACTER_PAGER_FREQ])
	{
		//if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}Pager\t%s", frisk_dlg_str, PlayerVar[targetid][E_PLAYER_HIDING_PAGER] ? "1 (On)" : "1 (Off)");
		//else SendClientMessage(playerid, COLOR_BLUE, sprintf("{ADBEE6}Pager %s", PlayerVar[targetid][E_PLAYER_HIDING_PAGER] ? "(On)" : "(Off)"));

		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}Pager\t%d", frisk_dlg_str, 1);
		else SendClientMessage(playerid, COLOR_BLUE, "{ADBEE6}Pager");

		count ++;
	}

	
	if (Character[targetid][E_CHARACTER_LOCKPICK])
	{
		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{BCAAA4}Lockpick\t%d", frisk_dlg_str, Character[targetid][E_CHARACTER_LOCKPICK]);
		else SendClientMessage(playerid, COLOR_BLUE, sprintf("{BCAAA4}Lockpick (x%d)", Character[targetid][E_CHARACTER_LOCKPICK]));

		count ++;
	}

	if (PlayerVar[targetid][E_PLAYER_ROPES])
	{
		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{BCAAA4}Ropes\t%d", frisk_dlg_str, PlayerVar[playerid][E_PLAYER_ROPES]);
		else SendClientMessage(playerid, COLOR_BLUE, sprintf("{BCAAA4}Ropes (x%d)", PlayerVar[playerid][E_PLAYER_ROPES]));

		count ++;
	} 

	if (Character[targetid][E_CHARACTER_MASKID]) 
	{
		if (playerid == targetid || PlayerVar[targetid][E_PLAYER_IS_MASKED] || (PlayerVar[targetid][E_PLAYER_LAST_MASKED_AT] && gettime() - PlayerVar[targetid][E_PLAYER_LAST_MASKED_AT] < 1800))
		{
			if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{BCAAA4}Mask (%d)\t%d", frisk_dlg_str, Character[targetid][E_CHARACTER_MASKID], 1);
			else SendClientMessage(playerid, COLOR_BLUE, sprintf("{BCAAA4}Mask (%d)", Character[targetid][E_CHARACTER_MASKID]));
			
			count ++;
		}
	}

	if (PlayerVar[targetid][E_PLAYER_HAS_GASCAN])
	{
		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}Jerry Can\t%d", frisk_dlg_str, 1);
		else SendClientMessage(playerid, COLOR_BLUE, "{ADBEE6}Jerry Can");

		count ++;
	} 
	
	if (PlayerVar[targetid][E_PLAYER_HAS_TOOLKIT])
	{
		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}Toolkit\t%d", frisk_dlg_str, 1);
		else SendClientMessage(playerid, COLOR_BLUE, "{ADBEE6}Toolkit");

		count ++;
	}

	new boombox = PlayerVar[targetid][player_hasboombox];
	if (boombox && playerid == targetid)
	{
		new boomboxstr[32];

		if (boombox == 1) format(boomboxstr, sizeof(boomboxstr), "Red Boombox");
		else if (boombox == 2) format(boomboxstr, sizeof(boomboxstr), "Grey Boombox");
		else if (boombox == 3) format(boomboxstr, sizeof(boomboxstr), "Black Boombox");

		if (!print) format(frisk_dlg_str, sizeof(frisk_dlg_str), "%s\n{ADBEE6}%s\t%d", frisk_dlg_str, boomboxstr, 1);
		else SendClientMessage(playerid, COLOR_BLUE, sprintf("{ADBEE6}%s", boomboxstr));

		count ++;
	}


	inline FriskDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

		if (response)
		{
			// print out a chatlog frisk
			ShowPlayerFriskDlg(playerid, targetid, true);
		}

    }

	if (!print)
	{
		if (targetid == playerid) Dialog_ShowCallback ( playerid, using inline FriskDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Inventory of %s (%d Items)", ReturnSettingsName(targetid, playerid), count), frisk_dlg_str, "Print", "Close" );
		else Dialog_ShowCallback ( playerid, using inline FriskDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Found %d items on %s", count, ReturnSettingsName(targetid, playerid)), frisk_dlg_str, "Print", "Close" );
		return 1;
	}

	return 1;
}

CMD:myitems(playerid, params[]) return cmd_inventory(playerid, params);
CMD:items(playerid, params[]) return cmd_inventory(playerid, params);
CMD:inventory(playerid, params[]){

	//ShowPlayerInventoryToPlayer(playerid, playerid);
	ShowPlayerFriskDlg(playerid, playerid);
	return true;
}