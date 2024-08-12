#include "player/auth/noclass.pwn"
#include "player/auth/data.pwn"
#include "player/auth/auth.pwn"
#include "player/auth/email.pwn"
#include "player/auth/register.pwn"
#include "player/auth/character.pwn"
#include "player/auth/spawn.pwn"
#include "player/auth/tempselect.pwn"


CMD:newplayers(playerid) {

	new string [ 128 ] ;

	SendClientMessage(playerid, COLOUR_HELPER, "[List of new players online]:" ) ;

	foreach(new targetid: Player) {

		if ( Character [ targetid ] [ E_CHARACTER_HOURS ] < 16 || Character [ targetid ] [ E_CHARACTER_LEVEL ] <= 2 ) {
			format ( string, sizeof ( string ), "(%d) %s - Level %d (%d hours)", 
				targetid, ReturnSettingsName(targetid, playerid, false), 
				Character [ targetid ] [ E_CHARACTER_LEVEL ], 
				Character [ targetid ] [ E_CHARACTER_HOURS ] 
			) ; 

			SendClientMessage(playerid, 0xDEDEDEFF, string);
		}
	}

	return true ;
}