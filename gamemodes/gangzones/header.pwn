#include "gangzones/data.pwn"
#include "gangzones/func.pwn"
#include "gangzones/admin.pwn"


Gangzone_Paycheck(playerid) {
	new money;
	for(new i, j = MAX_GANG_ZONES; i < j; i ++) {
		if(GangZone[i][E_GANGZONE_FACTION] == Character [ playerid ] [ E_CHARACTER_FACTIONID ] && Character [ playerid ] [ E_CHARACTER_FACTIONID ] > 0) {
			money += RandomEx(25, 100);
		}
	}

	if(money >= 2000) money = 2000;
	return money;
}

Gangzone_Count(faction_id) {
	new count;
	for(new i, j = MAX_GANG_ZONES; i < j; i ++) {
		if(GangZone[i][E_GANGZONE_FACTION] == faction_id) {
			count ++;
		}
		else continue;
	}
	return count;
}

CMD:gangzoneid(playerid) {
	new gz_id = GetPlayerGangZone(playerid) ;

	if ( gz_id == INVALID_GANG_ZONE ) {

		return SendClientMessage(playerid, -1, "You're not in a gangzone!" ) ;
	}

	if ( !GangZone_IsPlayerInArea(playerid, gz_id) ) {

		return SendClientMessage(playerid, -1, sprintf("Tried to match gangzone %d with enum, but returned -1 (invalid).", gz_id ) ) ;
	}


	SendClientMessage(playerid, -1, sprintf("Zone: %d (sql %d)", gz_id, GangZone [ gz_id ] [ E_GANGZONE_SQLID ] ));

	return true ;
}
