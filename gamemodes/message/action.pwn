new logString[150];
static SendPlayerMeAction(playerid, text[144], bool:islow=false)
{

    if(PlayerVar[playerid][E_PLAYER_LOGOUT_TICK]) {

    	SendClientMessage(playerid, COLOR_YELLOW, "You can't use local chat while your /logout timer is ticking.") ;
        return 0 ;
    }

	new Float: range = 15.0, color = COLOR_ACTION;
	if(islow) {
		range = 30.0;
		color = COLOR_ACTION_LOW;
	}

	format(logString, sizeof(logString), "%s", text);
	ProxDetectorEx(playerid, range, color, "*", logString);
	
	format(logString, sizeof(logString), "* %s", text);
	AddLogEntry(playerid, LOG_TYPE_ACTION, logString);
	return true ;
}

static SendPlayerDoAction(playerid, text[144], bool:islow=false)
{
   	if(PlayerVar[playerid][E_PLAYER_LOGOUT_TICK]) {

    	SendClientMessage(playerid, COLOR_YELLOW, "You can't use local chat while your /logout timer is ticking.") ;
        return 0 ;
    }

	new Float: range = 15.0, color = COLOR_ACTION;
	if(islow) {
		range = 30.0;
		color = COLOR_ACTION_LOW;
	}

	ProxDetectorEx(playerid, range, color, "*", text, .inverted = true);

	format(logString, sizeof(logString), "* %s", text);
	AddLogEntry(playerid, LOG_TYPE_ACTION, logString);

	return true ;
}

CMD:me(playerid, params[]) {

	new text[144], bool:quiet = Character[playerid][E_CHARACTER_ARREST_TIME] > 0;

	if(sscanf(params, "s[144]", text)) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/me [text]") ;
	}

	SendPlayerMeAction(playerid, text, quiet);
	return true ;
}

CMD:melow(playerid, params[]) {

	new text[144];

	if(sscanf(params, "s[144]", text)) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/melow [text]") ;
	}

	SendPlayerMeAction(playerid, text, true);
	return true ;
}

CMD:mel(playerid, params[]) 
{
	return cmd_melow(playerid, params);
}

CMD:do(playerid, params[]) {

	new text[144], bool:quiet = Character[playerid][E_CHARACTER_ARREST_TIME] > 0;

	if(sscanf(params, "s[144]", text)) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/do [text]") ;
	}

	SendPlayerDoAction(playerid, text, quiet);
	return true ;
}

CMD:ado(playerid, params[])
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL)
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float:radius, text[144], string[150];
	if(sscanf(params, "fs[144]", radius, text)) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/ado [radius] [text]") ;
	}

	format(string, sizeof(string), "* %s", text);
	ProxDetectorEx(playerid, radius, COLOR_ACTION, "*", text, .inverted = true);

	format(logString, sizeof(logString), "[ADO] %s", text);
	AddLogEntry(playerid, LOG_TYPE_ACTION, logString);
	return true;
}

CMD:dolow(playerid, params[]) {

	new text[144];

	if(sscanf(params, "s[144]", text)) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/dolow [text]") ;
	}

	SendPlayerDoAction(playerid, text, true);
	return true ;
}

CMD:dol(playerid, params[]) 
{
	return cmd_dolow(playerid, params);
}

CMD:my(playerid, params[]) {

	new text[144];

	if (sscanf(params, "s[144]", text)) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/my [text]") ;
	}

    if (PlayerVar[playerid][E_PLAYER_LOGOUT_TICK]) {

    	SendClientMessage(playerid, COLOR_YELLOW, "You can't use local chat while your /logout timer is ticking.") ;
        return 0 ;
    }
    
	new string[256];
	format(string, sizeof(string), "'s %s", text);
	ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", string, .autospacing=false);

	AddLogEntry(playerid, LOG_TYPE_ACTION, string);

	return true ;
}

CMD:attempt(playerid, params[]) {

	new text[144], string [256] ;

	if(sscanf(params, "s[144]", text)) {

		SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/attempt [text]") ;
		return SendClientMessage(playerid, COLOR_YELLOW, "Will return: \"{ff6347}NAME{FFFF00} attempts to {ff6347}INPUT{FFFF00} and succeeds/fails\".");
	}

	switch(random(100)) {
		case 0 .. 50:  format(string, sizeof(string), "attempts to %s and succeeds.", text) ;
		default: {
			format(string, sizeof(string), "attempts to %s and fails.", text) ;
		}
	}

	ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", string);
	AddLogEntry(playerid, LOG_TYPE_ACTION, string);

	return true ;
}
