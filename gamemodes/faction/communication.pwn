CMD:pagerhelp(playerid, params[]) {

	SendClientMessage(playerid, COLOR_SERVER, "[List of pager commands]");
	SendClientMessage(playerid, COLOR_GRAD0, "/pager (/pg), /pagerfrequency, /pagernick, /nopager");
	return true ;
}

CMD:pagerfrequency(playerid, params[])
{
	if (IsPlayerIncapacitated(playerid, false)) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
	}

	if (Character[playerid][E_CHARACTER_ARREST_TIME])
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You can't use a pager while in jail." ) ;
	}

	if (!Character[playerid][E_CHARACTER_PAGER_FREQ])
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a pager - buy one at an electronics store." ) ;
	}

	new Float:frequency, frequencystr[6], frequencyint;

	if ( sscanf ( params, "f", frequency )) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/pagerfrequency [frequency] (900.0 to 999.9 MHz)");
	}

	format(frequencystr, sizeof(frequencystr), "%.1f", frequency + 0.05);
	frequencyint = floatround(floatstr(frequencystr) * 10.0);

	if (frequencyint < 9000 || frequencyint >= 10000)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/pagerfrequency [frequency] (900.0 to 999.9 MHz)");
	}

	
	Character [ playerid ] [ E_CHARACTER_PAGER_FREQ ] = frequencyint;

	new string[128];
	mysql_format(mysql, string, sizeof ( string ), "UPDATE `characters` SET `player_pager_freq` = %d WHERE `player_id` = %d", Character [ playerid ] [ E_CHARACTER_PAGER_FREQ ], Character [ playerid ] [ E_CHARACTER_ID ]) ;
	mysql_tquery(mysql, string);

	SendClientMessage(playerid, COLOR_INFO, sprintf("You set your pager frequency to %s MHz.", frequencystr ));
	return true;
}

CMD:pagerf(playerid, params[])
{
	return cmd_pagerfrequency(playerid, params);
}

CMD:pagerfreq(playerid, params[])
{
	return cmd_pagerfrequency(playerid, params);
}

CMD:pagernick(playerid, params[])
{
	if (IsPlayerIncapacitated(playerid, false)) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
	}

	if (!Character[playerid][E_CHARACTER_PAGER_FREQ])
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a pager." ) ;
	}

	new name[11];

	if ( sscanf ( params, "s[11]", name )) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/pagernick [nickname]");
	}

	if (strlen(name) < 3 || strlen(name) > 10)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Pager nicknames can only be between 3 and 10 characters long.");
	}

	format(Character[playerid][E_CHARACTER_PAGER_NICK], 11, "%s", name);

	new string[128];
	mysql_format(mysql, string, sizeof ( string ), "UPDATE `characters` SET `player_pager_nick` = '%e' WHERE `player_id` = %d", Character [ playerid ] [ E_CHARACTER_PAGER_NICK ], Character [ playerid ] [ E_CHARACTER_ID ]) ;
	mysql_tquery(mysql, string);

	SendClientMessage(playerid, COLOR_INFO, sprintf("You set your pager handle (nickname) to %s.", Character[playerid][E_CHARACTER_PAGER_NICK]));
	return true;
}

CMD:pagernickname(playerid, params[])
{
	return cmd_pagernick(playerid, params);
}

CMD:pagerhandle(playerid, params[])
{
	return cmd_pagernick(playerid, params);
}

CMD:pagername(playerid, params[])
{
	return cmd_pagernick(playerid, params);
}

CMD:pager(playerid, params[]) 
{
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if (!Character[playerid][E_CHARACTER_PAGER_FREQ])
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a pager - buy one at an electronics store." ) ;
	}

	if (strlen(Character[playerid][E_CHARACTER_PAGER_NICK]) < 3)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You need to set a pager handle (name) first (/pagernick)." ) ;
	}

	new input[128], output[144];

	if ( sscanf ( params, "s[128]", input ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/p(a)g(er) [message]");
	}

	if (strlen(input) > 64)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("Your message is %d characters too long for the pager.", strlen(input) - 64));
	} 

 	if (PlayerVar [ playerid ] [ E_PLAYER_PAGER_COOLDOWN ]  >= gettime ()) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You need to wait %d seconds before sending another page.", PlayerVar [ playerid ] [ E_PLAYER_PAGER_COOLDOWN] - gettime ()));
	}

	PlayerVar [ playerid ] [ E_PLAYER_PAGER_COOLDOWN ] = gettime () + 10 ;

	new Float:frequency = (float(Character[playerid][E_CHARACTER_PAGER_FREQ])+0.05)/10.0;
	format(output, sizeof(output), "[%.1f MHz] %s#%04d: %s", frequency, Character[playerid][E_CHARACTER_PAGER_NICK],  Character[playerid][E_CHARACTER_MASKID] ? Character[playerid][E_CHARACTER_MASKID] : Character[playerid][E_CHARACTER_ID], input);
	
	foreach (new targetid: Player) 
	{
		if ( IsPlayerSpawned ( targetid) && IsPlayerLogged ( targetid ) && Character[targetid][E_CHARACTER_PAGER_FREQ] == Character[playerid][E_CHARACTER_PAGER_FREQ]) 
		{
			if ( ! PlayerVar [ playerid ] [ E_PLAYER_HIDING_PAGER] ) 
			{
				PlayerPlaySound (targetid, 1085, 0.0, 0.0, 0.0);
				ZMsg_SendClientMessage ( targetid, 0xE3A360FF, output ) ;
			}
		}
	}

	AddLogEntry(playerid, LOG_TYPE_PAGER, sprintf("[%.1f MHz (%s)]: %s", frequency, Character[playerid][E_CHARACTER_PAGER_NICK], input));
	SendAdminListen(playerid, output);

	ProxDetectorEx(playerid, 20.0, COLOR_PURPLE, "**", "sends a message on their pager.", .annonated=true ) ;
	return true ;
}

CMD:pg(playerid, params[]) {

	return cmd_pager(playerid, params);
}