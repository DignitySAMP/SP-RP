
static breakingcooldown = 0;

CMD:adminbreaking(playerid, params[])
{
    new text[128], str[144];

    if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL) return SendServerMessage (playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this." );

	if (sscanf ( params, "s[128]", text )) 
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/adminbreaking [text]" ) ;

	format ( str, sizeof ( str ), "[BREAKING NEWS] %s", text ) ;

	foreach(new targetid: Player) 
    {
		ZMsg_SendClientMessage ( targetid, 0xff2a00FF, str);
	}

    SendAdminMessage(sprintf("[Last /adminbreaking was done by (%d) %s [%s].]", playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] ) ) ;
	return true ;
}


CMD:breaking(playerid, params[])
{
    new text[128], str[144];

	if (sscanf ( params, "s[128]", text )) 
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/breaking [text]" ) ;

    if (!IsPlayerInNewsFaction(playerid, true))
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a news faction." ) ;

    if (breakingcooldown && (gettime() - breakingcooldown) < 60)
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must wait before sending another breaking news alert." ) ;

	format ( str, sizeof ( str ), "[BREAKING NEWS] %s: %s", ReturnMixedName(playerid), text ) ;

	foreach(new targetid: Player) 
    {
		ZMsg_SendClientMessage ( targetid, 0xff2a00FF, str);
	}

    breakingcooldown = gettime();
	
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("[breaking news]: %s", text));
	return true ;
}
