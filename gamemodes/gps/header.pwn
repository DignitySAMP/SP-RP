#include "gps/data.pwn"
#include "gps/utils.pwn"
#include "gps/func.pwn"

CMD:clearcp(playerid) 
{
	GPS_ClearCheckpoint(playerid);
	SendClientMessage(playerid, -1, "Removed all visible synced checkpoints. Your GPS has also been reset.");

	return true ;
}

CMD:nocp(playerid) return cmd_clearcp(playerid);
CMD:cleargps(playerid) return cmd_clearcp(playerid);