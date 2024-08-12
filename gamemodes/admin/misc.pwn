CMD:slap(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/slap [targetid]");
	}

	if ( ! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected.");
	}

  	new Float:x, Float:y, Float:z;

	GetPlayerPos ( targetid, x, y, z ) ;
	PauseAC(targetid, 3);
	SetPlayerPos ( targetid, x, y, z + 4 ) ;

	PlayerPlaySound ( targetid, 1190, x, y, z ) ;
	
	AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("Was slapped by %s", ReturnMixedName(playerid)));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Slapped %s", ReturnMixedName(targetid)));

	GPS_ClearCheckpoint(targetid);
	return true ;
}

CMD:setinterior(playerid, params[]) {

	return cmd_setint(playerid, params);
}
CMD:setint(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, interior ;

	if ( sscanf ( params, "k<player>i", targetid, interior ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setint(erior) [targetid] [interior]");
	}

	if ( ! IsPlayerConnected(targetid) ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target isn't connected.");
	}	

	SetPlayerInterior(targetid, interior);

	new string [ 96 ] ;

	format ( string, sizeof ( string ), "Set %s's interior to %d", ReturnSettingsName(targetid, playerid, .color=false), interior ) ;
	SendClientMessage(playerid, -1, string );
	
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	format ( string, sizeof ( string ), "%s has set your interior to %d", ReturnSettingsName(targetid, playerid, .color=false), interior ) ;
	SendClientMessage(targetid, -1, string );

	return true ;
}

CMD:setvirtualworld(playerid, params[]) {

	return cmd_setvw(playerid, params);
}
CMD:setvw(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, virtualworld ;

	if ( sscanf ( params, "k<player>i",targetid, virtualworld ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setv(irtual)w(orld) [targetid] [virtualworld]");
	}

	if ( ! IsPlayerConnected(targetid) ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target isn't connected.");
	}	

	SetPlayerVirtualWorld(targetid, virtualworld);

	new string [ 96 ] ;
	format ( string, sizeof ( string ), "Set %s's virtualworld to %d", ReturnSettingsName(targetid, playerid, .color=false), virtualworld ) ;
	SendClientMessage(playerid, -1, string );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	format ( string, sizeof ( string ), "%s has set your virtualworld to %d", ReturnSettingsName(playerid, targetid, .color=false), virtualworld ) ;
	SendClientMessage(targetid, -1, string );

	return true ;
}


CMD:gotoxyz ( playerid, params [] ) {
	
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new Float: x, Float: y, Float: z, interior, virtualworld ;

	if ( sscanf ( params, "fffI(0)I(0)", x, y, z, interior, virtualworld ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/gotoxyz [x coord] [y coord] [z coord] [optional:interior] [optional:virtualworld]" )  ;
	}

	SOLS_SetPlayerPos ( playerid, x, y, z ) ;

	SetPlayerInterior ( playerid, interior ) ;
	SetPlayerVirtualWorld ( playerid, virtualworld ) ;

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("teleported to %.02f, %.02f, %.02f in interior ID %i and virtual world ID %i.", x, y, z, interior, virtualworld));

	return true ;
}

CMD:gotopos ( playerid, params [] ) {
	return cmd_gotoxyz(playerid, params);
}


CMD:getcoordinates(playerid, params[]) {
	
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new Float: x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;

	new Float: angle ;
	GetPlayerFacingAngle(playerid, angle ) ;

	new interior = GetPlayerInterior(playerid), virtualworld = GetPlayerVirtualWorld(playerid) ;

	SendClientMessage(playerid, COLOR_INFO, "Your current coordinates:" ) ;
	SendClientMessage(playerid, 0xDEDEDEFF, sprintf(" x(%f) y(%f) z(%f) a(%f)", x, y, z, angle ) ) ;
	SendClientMessage(playerid, 0xA3A3A3FF, sprintf(" int(%d) world (%d)", interior, virtualworld ) ) ;

	return true ;
}

CMD:ahide(playerid, params[]){

	if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

	if(PlayerVar[playerid][E_PLAYER_ADMIN_HIDDEN]) {

		SendServerMessage ( playerid, COLOR_ERROR, "Admin Hide", "A3A3A3", "You are no longer admin hidden.") ;
		PlayerVar[playerid][E_PLAYER_ADMIN_HIDDEN] = false;

	} else {

		SendServerMessage ( playerid, COLOR_ERROR, "Admin Hide", "A3A3A3", "You have just hidden yourself as an admin. You are no longer shown on /admins. ") ;
		SendServerMessage ( playerid, COLOR_ERROR, "Admin Hide", "A3A3A3", "If you want to be hidden from /id aswell, go on admin duty.") ;

		PlayerVar[playerid][E_PLAYER_ADMIN_HIDDEN] = true;
	}

	return true;
}


// Just some extra stuff that might be helpful atm
static PlayerStates[10][40] = 
{
	"PLAYER_STATE_NONE",
	"PLAYER_STATE_ONFOOT",
	"PLAYER_STATE_DRIVER",
	"PLAYER_STATE_PASSENGER",
	"PLAYER_STATE_EXIT_VEHICLE",
	"PLAYER_STATE_ENTER_VEHICLE_DRIVER",
	"PLAYER_STATE_ENTER_VEHICLE_PASSENGER",
	"PLAYER_STATE_WASTED",
	"PLAYER_STATE_SPAWNED",
	"PLAYER_STATE_SPECTATING"
};

CMD:getstate(playerid, params[])
{
    if (GetPlayerAdminLevel(playerid) < 2) return 0;

	new targetid, playerstate;
    if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/getplayerstate [player]");

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, -1, "Invalid player target.");

	playerstate = GetPlayerState(targetid);
    SendClientMessage(playerid, -1, sprintf("%s (%d): %s (%d)", ReturnMixedName(targetid), targetid, PlayerStates[playerstate], playerstate));

	return 1;
}


CMD:getdistance(playerid, params[])
{
    if (GetPlayerAdminLevel(playerid) < 1) return 0;

	new targetid;
    if (sscanf(params, "k<player>", targetid) || !IsPlayerConnected(targetid))
		return SendClientMessage(playerid, -1, "/getdistance [player]");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);

	new Float:distance = GetPlayerDistanceFromPoint(playerid, x, y, z);

	new address[64], zone[64];
	GetCoords2DZone(x, y, zone, sizeof ( zone ));
	GetPlayerAddress(x, y, address );

    SendClientMessage(playerid, -1, sprintf("You are %.02fm away from %s (%d), location: %s, %s.", distance, ReturnMixedName(targetid), targetid, address, zone));

	return 1;
}

CMD:distance(playerid, params[])
{
	return cmd_getdistance(playerid, params);
}

CMD:dist(playerid, params[])
{
	return cmd_getdistance(playerid, params);
}