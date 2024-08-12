
static FacDlgStr[2048];
static FacDlgLine[200];

CMD:factions(playerid) 
{
	if (!GetPlayerAdminLevel(playerid)) format(FacDlgStr, sizeof(FacDlgStr), "ID\tTag\tName\tOnline");
	else format(FacDlgStr, sizeof(FacDlgStr), "ID [SQL]\tTag\tName\tOnline");
	
	new online[100]; // just assuming it's never gonna be more than 100...
	new map[32], index = 0;

	foreach (new i: Player) 
	{
		if (!Character [ i ] [ E_CHARACTER_FACTIONID ] || strcmp(Character[i][E_CHARACTER_FACTIONRANK], "Admin") == 0) continue;
		online[Character [ i ] [ E_CHARACTER_FACTIONID ]] ++;
	}

	for ( new i, j = sizeof ( Faction ); i < j ; i ++ ) 
	{
		if ( Faction [ i ] [ E_FACTION_ID ] == INVALID_FACTION_ID ) continue;
		new color = Faction [ i ] [ E_FACTION_VISIBLE ] ? 0 : 0x9E9E9E;

		/*
		No hidden factions. This isn't GTA-C where Spooky spawned Aperture factions anymore.
		This code is also bugged btw, so if we ever re-enable it, add a separate variable for visibility since because this one is linked to faction spawns.
		if (!Faction [ i ] [ E_FACTION_VISIBLE ])
		{
			print("Faction is not visible");
			if (GetPlayerAdminLevel ( playerid ) <= ADMIN_LVL_GENERAL) {
				
				print("Player is not admin, skipping loop.");
				continue;
			}
		}*/

		if (!GetPlayerAdminLevel(playerid)) {
			// No admin, we format this first. It will get overwritten if the player is an admin.
			format(FacDlgLine, sizeof(FacDlgLine), "\n%d\t%s\t%s\t%d", i, Faction [ i ] [ E_FACTION_ABBREV ], Faction [ i ] [ E_FACTION_NAME ], online[Faction [ i ] [ E_FACTION_ID ]]);
		}
		else {
		
			if (color)
			{
				format(FacDlgLine, sizeof(FacDlgLine), "\n{%06x}%d [%d]\t{%06x}%s\t{%06x}%s\t{%06x}%d", color, i, Faction [ i ] [ E_FACTION_ID ], color, Faction [ i ] [ E_FACTION_ABBREV ], color, Faction [ i ] [ E_FACTION_NAME ], color, online[Faction [ i ] [ E_FACTION_ID ]]);
			}
			else
			{
				format(FacDlgLine, sizeof(FacDlgLine), "\n%d [%d]\t%s\t%s\t%d", i, Faction [ i ] [ E_FACTION_ID ], Faction [ i ] [ E_FACTION_ABBREV ], Faction [ i ] [ E_FACTION_NAME ], online[Faction [ i ] [ E_FACTION_ID ]]);
			}
		}

		strcat(FacDlgStr, FacDlgLine);

		map[index] = i;
		index ++;
	}

	inline DlgShowFactions(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, dialogid, inputtext, listitem
		
		if (response)
		{
			new facindex = map[listitem];

			// Shows faction members (only to admins or their own faction)
			if (Character [ playerid ] [ E_CHARACTER_FACTIONID ] == Faction[facindex][E_FACTION_ID] || GetPlayerAdminLevel(playerid) >= ADMIN_LVL_JUNIOR)
			{
				ShowFactionMembersDlg(playerid, facindex);
			}
		}
	}

	Dialog_ShowCallback ( playerid, using inline DlgShowFactions, DIALOG_STYLE_TABLIST_HEADERS, "Factions", FacDlgStr, "View", "Close" );
	return true ;
}

ShowFactionMembersDlg(playerid, facindex)
{
	new count = 0;
	format(FacDlgStr, sizeof(FacDlgStr), "Player ID\tName\tRank\tTier");

	foreach (new i: Player) 
	{
		if (!IsPlayerConnected(i)) continue;
		if (Character[i][E_CHARACTER_FACTIONID] != Faction [facindex][E_FACTION_ID]) continue;

		count ++;
		format(FacDlgStr, sizeof(FacDlgStr), "%s\n%03d\t%s\t%s\tTier %d", FacDlgStr, i, ReturnMixedName(i), Character[i][E_CHARACTER_FACTIONRANK], Character[i][E_CHARACTER_FACTIONTIER]);
	}

	inline DlgShowFactionMembers(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused pid, dialogid, inputtext, listitem
		
		if (response)
		{
			// Back to factions
			cmd_factions(playerid);
		}
	}

	Dialog_ShowCallback ( playerid, using inline DlgShowFactionMembers, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s Online Members (%d)", Faction[facindex][E_FACTION_ABBREV], count), FacDlgStr, "Back", "Close" );
	return true ;
}

