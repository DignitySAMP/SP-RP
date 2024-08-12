CMD:carrespawn(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new endpid, vid, name[MAX_PLAYER_NAME+1], string [ 128 ], msgfrom[MAX_PLAYER_NAME+24];

    if (sscanf(params, "k<player>", endpid) == 0)
    {
    	vid = GetPlayerVehicleID(playerid) ;

        if (IsPlayerConnected(endpid))
        {

            GetPlayerName(endpid, name, sizeof(name));
			if (vid != 0)
			{

				SOLS_SetVehicleToRespawn(vid, "/carrespawn");

				format(msgfrom, sizeof(msgfrom), "%s has had their car respawned.", name);
			    SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);

			    if (endpid != playerid)
			    {
			        new msgto[34];
				    format(msgto, sizeof(msgto), "Your car has been respawned by an admin.", name);
					SendClientMessage(endpid, 0xFFFFFFFF, msgto);
				}

			   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has respawned car (%d).", 
		   			playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
		   		SendAdminMessage(string) ;
	    	}
	    	else
			{
   				new msg[MAX_PLAYER_NAME+33];
			    format(msg, sizeof(msg), "%s is not in any vehicle.", name);
				SendClientMessage(playerid, COLOR_RED, msg);
			}
    	}
    	else SendClientMessage(playerid, COLOR_RED, "Invalid player ID");
	}
	else
	{
		vid = GetPlayerVehicleID(playerid) ;
        GetPlayerName(playerid, name, sizeof(name));
		if (vid != 0)
		{
			SOLS_SetVehicleToRespawn(vid, "/carrespawn");

			format(msgfrom, sizeof(msgfrom), "%s has had their car respawned.", name);
			SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);


			format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has respawned car (%d).", 
		   		playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
	   		SendAdminMessage(string) ;
    	}
    	else SendClientMessage(playerid, COLOR_RED,"Usage: /carrespawn [playerid]");
	}

	return true ;
}

CMD:carflip(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	if ( IsPlayerInAnyVehicle(playerid)) {

		new vid = GetPlayerVehicleID(playerid);

		new Float: angle, string [ 128 ] ;

		GetVehicleZAngle(vid, angle);
		SetVehicleZAngle(vid, angle);

	   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has flipped  car (%d).", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ; 	
		SendAdminMessage(string) ;
	}

	/*
    new endpid, vid, string [ 128 ], Float:angle, name[MAX_PLAYER_NAME+1], msgfrom[MAX_PLAYER_NAME+24]; 

    if (sscanf(params, "k<player>", endpid) == 0)
    {

    	vid = GetPlayerVehicleID(endpid);

        if (IsPlayerConnected(endpid))
        {

            GetPlayerName(endpid, name, sizeof(name));
			if (vid != 0)
			{
				GetVehicleZAngle(vid, angle);
				SetVehicleZAngle(vid, angle);

				format(msgfrom, sizeof(msgfrom), "%s has been car flipped.", name);
			    SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);

			    if (endpid != playerid)
			    {
			        new msgto[34];
				    format(msgto, sizeof(msgto), "You were car flipped by an admin.", name);
					SendClientMessage(endpid, 0xFFFFFFFF, msgto);
				}

			   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has flipped  car (%d).", 
		   			playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
		   		SendAdminMessage(string) ;
	    	}
	    	else
			{
   				new msg[MAX_PLAYER_NAME+33];
			    format(msg, sizeof(msg), "%s is not in any vehicle.", name);
				SendClientMessage(playerid, COLOR_RED, msg);
			}
    	}
    	else SendClientMessage(playerid, COLOR_RED, "Invalid player ID");
	}
	else
	{

		vid = GetPlayerVehicleID(endpid);
        GetPlayerName(playerid, name, sizeof(name));
		if (vid != 0)
		{
			GetVehicleZAngle(vid, angle);
			SetVehicleZAngle(vid, angle);
			format(msgfrom, sizeof(msgfrom), "%s has been car flipped.", name);
			SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);


		   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has flipped car (%d).", 
	   			playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
	   		SendAdminMessage(string) ;
    	}
    	else SendClientMessage(playerid, COLOR_RED,"Usage: /carflip [playerid]");
	}
*/
	return 1;
}

CMD:carslap(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new endpid, vid, string [ 128 ], Float:x, Float:y, Float:z;

    if (sscanf(params, "k<player>", endpid) == 0)
    {
    	vid = GetPlayerVehicleID(playerid);

        if (IsPlayerConnected(endpid))
        {

			if (vid != 0)
			{
				GetVehiclePos(vid, x, y, z);
				SetVehiclePos(vid, x, y, z+5);

				new
					name[MAX_PLAYER_NAME+1],
					msgfrom[MAX_PLAYER_NAME+24];
			    GetPlayerName(endpid, name, sizeof(name));
				format(msgfrom, sizeof(msgfrom), "%s has been car slapped.", name);
			    SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);

			    if (endpid != playerid)
				{
				    new msgto[34];
				    format(msgto, sizeof(msgto), "You were car slapped by an admin.", name);
					SendClientMessage(endpid, 0xFFFFFFFF, msgto);
				}

			   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has slapped car (%d).", 
		   			playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
		   		SendAdminMessage(string) ;
	    	}
	    	else
			{
			    new name[MAX_PLAYER_NAME+1], msg[MAX_PLAYER_NAME+33];
			    GetPlayerName(endpid, name, sizeof(name));
			    format(msg, sizeof(msg), "{FFFFFF}%s is not in any vehicle.", name);
				SendClientMessage(playerid, COLOR_RED,msg);
			}
    	}
    	else SendClientMessage(playerid, COLOR_RED,"Invalid player ID");
	}
	else
	{
    	vid = GetPlayerVehicleID(playerid) ;

	    if (vid != 0)
		{
			GetVehiclePos(vid, x, y, z);
			SetVehiclePos(vid, x, y, z+5);

			new
				name[MAX_PLAYER_NAME+1],
				msgfrom[MAX_PLAYER_NAME+24];
	    	GetPlayerName(playerid, name, sizeof(name));
			format(msgfrom, sizeof(msgfrom), "%s has been car slapped.", name);
			SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);

		   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has slapped car (%d).", 
		   		playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
		   	SendAdminMessage(string) ;
    	}
	    else SendClientMessage(playerid, COLOR_RED,"Usage: /carslap [playerid]");
	}
	return 1;
}

CMD:setcarhp(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new vehicleid, hp;
	if (sscanf(params, "dd", vehicleid, hp) || vehicleid < 1 || !IsValidVehicle(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_RED,"Usage: /setcarhp [vehicle id] [health]");
	}

	if (hp < 250) SOLS_SetVehicleCanExplode(vehicleid, true);
	else SOLS_SetVehicleCanExplode(vehicleid, false);	

	SOLS_SetVehicleHealth(vehicleid, hp);
	return true;
}

CMD:carhp(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new endpid = INVALID_PLAYER_ID, vid, hp = -1;

    sscanf(params, "k<player>d", endpid, hp);
	if (endpid == INVALID_PLAYER_ID)
	{
		sscanf(params, "d", hp);
	}

	if (hp > 999) hp = 999;

	if (hp >= 0)
	{
		if (endpid == INVALID_PLAYER_ID) endpid = playerid;
		vid = GetPlayerVehicleID(endpid);
		if (!vid) return SendServerMessage (playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("(%d) %s is not in a vehicle.", endpid, ReturnSettingsName(endpid, playerid, .color=false))) ;
    
    	if (hp < 250) SOLS_SetVehicleCanExplode(vid, true);		
		SOLS_SetVehicleHealth(vid, hp);

		SendAdminMessage(sprintf("[AdminCmd]: (%d) %s has set car (%d) health to %d.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid, hp));
		return 1;
	}

	SendClientMessage(playerid, COLOR_RED,"Usage: /carhp [playerid] [health]");
	return 1;
}

CMD:carfix(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new endpid, vid, string [ 128 ], name[MAX_PLAYER_NAME+1], msgfrom[MAX_PLAYER_NAME+24] ;

    if (sscanf(params, "k<player>", endpid) == 0)
    {
    	vid = GetPlayerVehicleID(endpid);

        if (IsPlayerConnected(endpid))
        {

            GetPlayerName(endpid, name, sizeof(name));
			if (vid != 0)
			{
				
				SOLS_RepairVehicle(vid);

			   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has fixed car (%d).", 
			   		playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
			   	
			   	SendAdminMessage(string) ;

			    if (endpid != playerid)
			    {
			        new msgto[34];
				    format(msgto, sizeof(msgto), "Your car has been fixed by an admin", name);
					SendClientMessage(endpid, 0xFFFFFFFF, msgto);
				}
	    	}
	    	else
			{
   				new msg[MAX_PLAYER_NAME+33];
			    format(msg, sizeof(msg), "%s is not in any vehicle.", name);
				SendClientMessage(playerid, COLOR_RED, msg);
			}
    	}
    	else SendClientMessage(playerid, COLOR_RED, "Invalid player ID");
	}
	else
	{
		vid = GetPlayerVehicleID(playerid) ;
        GetPlayerName(playerid, name, sizeof(name));
		if (vid != 0)
		{
		   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has fixed car (%d).", 
		   		playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], vid ) ;
		   	
		   	SendAdminMessage(string) ;

			SOLS_RepairVehicle(vid);

			format(msgfrom, sizeof(msgfrom), "%s's car has been fixed.", name);
			SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);
    	}
    	else SendClientMessage(playerid, COLOR_RED,"Usage: /carfix [playerid]");
	}

	return 1;
}

CMD:mark(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new choice ;

	if ( sscanf ( params, "i", choice ) ) {


		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/mark [1-3]") ;
	}

    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid, x, y, z);

	switch ( choice ) {

		case 1: SetPVarFloat(playerid, "markX", x), SetPVarFloat(playerid, "markY", y), SetPVarFloat(playerid, "markZ", z);
		case 2: SetPVarFloat(playerid, "mark2X", x), SetPVarFloat(playerid, "mark2Y", y), SetPVarFloat(playerid, "mark2Z", z);
		case 3: SetPVarFloat(playerid, "mark3X", x), SetPVarFloat(playerid, "mark3Y", y), SetPVarFloat(playerid, "mark3Z", z);
		default: return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Mark can't be less than 0 or more than 3.") ;
	}

	new string [ 96 ] ;

	format ( string, sizeof ( string ), "Mark %d has been set to %0.3f, %0.3f, %0.3f. Interior / worldid are NOT saved.", choice, x, y, z ) ;
	SendClientMessage(playerid, -1, string);

   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has marked their current location (slot %d).", 
   		playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], choice  ) ;

   	SendAdminMessage(string) ;

	return true ;
}

CMD:gotomark(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new choice ;

	if ( sscanf ( params, "i", choice ) ) {


		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/gotomark [1-3]") ;
	}

    new Float:x,Float:y,Float:z;
    new Float:final_x,Float:final_y,Float:final_z;
    GetPlayerPos(playerid, x, y, z);

	switch ( choice ) {

		case 1: final_x = GetPVarFloat(playerid,"markX"), final_y = GetPVarFloat(playerid,"markY"), final_z = GetPVarFloat(playerid,"markZ") ;
		case 2: final_x = GetPVarFloat(playerid,"mark2X"), final_y = GetPVarFloat(playerid,"mark2Y"), final_z = GetPVarFloat(playerid,"mark2Z") ;
		case 3: final_x = GetPVarFloat(playerid,"mark3X"), final_y = GetPVarFloat(playerid,"mark3Y"), final_z = GetPVarFloat(playerid,"mark3Z") ;
		default: return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Mark can't be less than 0 or more than 3.") ;
	}

	if ( ! IsPlayerInAnyVehicle(playerid)) {

		PauseAC(playerid, 3);
    	SetPlayerPos(playerid, final_x, final_y, final_z);
    }

    else {

    	SetVehiclePos(GetPlayerVehicleID(playerid), final_x, final_y, final_z) ;  	
    }

	new string [ 96 ] ;

	format ( string, sizeof ( string ), "You've teleported to your mark in slot %d, %.3f, %.3f, %.3f.", choice, x, y, z ) ;
	SendClientMessage(playerid, -1, string);

   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has teleported to their mark in slot %d.", 
   		playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], choice  ) ;
   	
   	SendAdminMessage(string) ;

	return true ;
}