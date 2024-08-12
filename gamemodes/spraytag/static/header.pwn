#include "spraytag/static/data.pwn"
#include "spraytag/static/func.pwn"


CMD:stgoto(playerid, params[]) {

	return cmd_spraytaggoto(playerid, params);
}
CMD:spraytaggoto(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendClientMessage(playerid, -1, "/s(pray)t(ag)goto");
	}

	if ( id > sizeof ( SprayTag  ) ) {

		return SendClientMessage(playerid, -1, sprintf("Your ID (%d) exceeds the amount of tags. Max %d tags.", 
			id, sizeof ( SprayTag  ) ) ) ;
	}

	if ( ! IsValidDynamicObject(SprayTag  [ id ] [ E_SPRAY_TAG_OBJECT ] ) ) {

		return SendClientMessage(playerid, -1, "Selected ID is invalid (doesn't exist." ) ;
	}

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, SprayTag [ id ][ E_SPRAY_TAG_POS_X ], SprayTag [ id ][ E_SPRAY_TAG_POS_Y ], SprayTag [ id ][ E_SPRAY_TAG_POS_Z ] ) ;
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	
	SendClientMessage(playerid, -1, sprintf("Teleported to spray tag ID %d. Use /fw, /up, and /dn to move out of objects.", id ) ) ;

	return true ;
}
