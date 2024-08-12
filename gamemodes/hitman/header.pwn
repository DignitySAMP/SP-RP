#define COLOUR_HITMAN	(0x737373FF)

#include "hitman/roles.pwn"
#include "hitman/cmds.pwn"
#include "hitman/contracts.pwn"

IsPlayerHitman ( playerid ) {

	if ( Character [ playerid ] [ E_CHARACTER_HITMAN ] ) {

		return true ;
	}

	return false ;
}

SendHitmanMessage ( text [] ) {

	foreach(new playerid: Player) {

		if ( IsPlayerSpawned ( playerid ) && IsPlayerLogged ( playerid  ) ) {
			if ( IsPlayerHitman ( playerid ) ) {

				ZMsg_SendClientMessage(playerid, COLOUR_HITMAN, text ) ;
			}
		}
	}

	return true ;
}

