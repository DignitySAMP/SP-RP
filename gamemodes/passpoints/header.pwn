#define MAX_PASSPOINTS			( 150 )
#define INVALID_PASSPOINT_ID	(-1)

#include "passpoints/data.pwn"
#include "passpoints/admin.pwn"

CMD:pass(playerid, params[]) 
{
	if (IsPlayerFading(playerid)) return true; // Make them wait first

	new closest_point = GetClosestPasspoint(playerid) ;

	if ( PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {
		SendClientMessage(playerid, -1, sprintf("Closest point (enum ID): %d", closest_point ) ) ;
	}

	return true ;
}