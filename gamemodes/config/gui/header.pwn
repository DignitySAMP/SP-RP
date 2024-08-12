//#include "config/gui/gui_datetime.pwn"

#include <YSI_Coding\y_hooks>

// Cross hook
new PlayerText:zoneTextDraw[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:vehicleTextDraw[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:streetTextDraw[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

new PlayerStreet [ MAX_PLAYERS ] = { -1, ... } ;
new MapZone:PlayerZone [ MAX_PLAYERS ] = { INVALID_MAP_ZONE_ID, ... } ;
new bool: PlayerZoneFading [ MAX_PLAYERS ] ;
new bool: PlayerStreetFading [ MAX_PLAYERS ] ;


#include "config/gui/zone.pwn"
#include "config/gui/vehicle.pwn"
#include "config/gui/street.pwn"
#include "config/gui/time.pwn"
#include "config/gui/direction.pwn"

#include "config/gui/info_box.pwn"
#include "config/gui/info_subtitle.pwn"

new Text: gBlindfoldTD 	= Text: INVALID_TEXT_DRAW ;
new Text: E_ADMIN_DUTY_TEXT = Text: INVALID_TEXT_DRAW ;
new Text: E_HELPER_DUTY_TEXT = Text: INVALID_TEXT_DRAW;

/*
	new Text: E_SERVER_LOGO = Text: INVALID_TEXT_DRAW ;

	E_SERVER_LOGO = TextDrawCreate(575, 415, "~r~F~w~ear and ~b~R~w~espect~n~~b~S~w~treets of ~r~L~w~os Santos");
    TextDrawFont(E_SERVER_LOGO, 0);
    TextDrawSetShadow(E_SERVER_LOGO, 0);
    TextDrawSetOutline(E_SERVER_LOGO, 1);
    TextDrawLetterSize(E_SERVER_LOGO, 0.45, 1.5);
    TextDrawAlignment(E_SERVER_LOGO, 2);
    TextDrawBackgroundColor(E_SERVER_LOGO, 255);
*/

ResetZonePlayerText(playerid, bool:resetPlayerVar = true)
{
	if (zoneTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, zoneTextDraw[playerid]);
    }

    zoneTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    if (resetPlayerVar) PlayerZone[playerid] = INVALID_MAP_ZONE_ID;
	PlayerZoneFading[playerid] = false;
}

ResetVehiclePlayerText(playerid)
{
	if (vehicleTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, vehicleTextDraw[playerid]);
    }

    vehicleTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

ResetStreetPlayerText(playerid, bool:resetPlayerVar = true)
{
	if (streetTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, streetTextDraw[playerid]);
    }

    streetTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	if (resetPlayerVar) PlayerStreet[playerid] = -1;
	PlayerStreetFading[playerid] = false;
}

hook OnGameModeInit()
{
	E_ADMIN_DUTY_TEXT = TextDrawCreate(552.000000, 66.500000, "ADMIN ON DUTY");
	TextDrawBackgroundColor(E_ADMIN_DUTY_TEXT, 255);
	TextDrawFont(E_ADMIN_DUTY_TEXT, 1);
	TextDrawLetterSize(E_ADMIN_DUTY_TEXT, 0.180000, 0.899999);
	TextDrawColor(E_ADMIN_DUTY_TEXT, -65281);
	TextDrawSetOutline(E_ADMIN_DUTY_TEXT, 1);
	TextDrawSetProportional(E_ADMIN_DUTY_TEXT, 1);

	E_HELPER_DUTY_TEXT = TextDrawCreate(552.000000, 66.500000, "HELPER ON DUTY");
	TextDrawBackgroundColor(E_HELPER_DUTY_TEXT, 255);
	TextDrawFont(E_HELPER_DUTY_TEXT, 1);
	TextDrawLetterSize(E_HELPER_DUTY_TEXT, 0.180000, 0.899999);
	TextDrawColor(E_HELPER_DUTY_TEXT, -1375784961);
	TextDrawSetOutline(E_HELPER_DUTY_TEXT, 1);
	TextDrawSetProportional(E_HELPER_DUTY_TEXT, 1);

	gBlindfoldTD = TextDrawCreate(0, 0, "_");
	TextDrawTextSize(gBlindfoldTD, 640, 480);
	TextDrawLetterSize(gBlindfoldTD, 0.35, 100);
	TextDrawUseBox(gBlindfoldTD, 1);
	TextDrawBoxColor(gBlindfoldTD, 0xff);
	TextDrawColor(gBlindfoldTD, 0xffffffff);
	TextDrawFont(gBlindfoldTD, 1);
	TextDrawAlignment(gBlindfoldTD, 0);
	TextDrawSetOutline(gBlindfoldTD, 0);
	TextDrawSetShadow(gBlindfoldTD, 0);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	// Destroy the player textdraws when they disconnect
	ResetZonePlayerText(playerid);
	ResetStreetPlayerText(playerid);
	ResetVehiclePlayerText(playerid);
	//printf("Reset zone/veh/street TD for disconnecting PID %d", playerid);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	// Destroy/reset the street/zone/veh player TDs on connection too cause why not
	ResetZonePlayerText(playerid);
	ResetStreetPlayerText(playerid);
	ResetVehiclePlayerText(playerid);
	//printf("Reset zone/veh/street TD for connecting PID %d", playerid);

	return 1;
}