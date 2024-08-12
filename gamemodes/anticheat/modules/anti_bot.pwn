#include <a_samp>
#include <zcmd>

#define SAMPVERSION	"0.3.DL-R1"

public OnPlayerConnect(playerid) {
    new version[24], ip_address[32];
    GetPlayerVersion(playerid, version, sizeof(version));
    GetPlayerIp(playerid, ip_address, sizeof ( ip_address));

    if ( strcmp(version, SAMPVERSION, true)) {

    	BlockIpAddress(ip_address, 300000); // 5 minutes

		SendAdminMessage(sprintf("[ANTI_ATTACK] IP %s tried to connect with an invalid version, blocking it for 5 minutes.", ip_address)) ;	
    	return true ;
    }

    SendClientMessage(playerid, 0xa9c4e4ff, "Checking client validity, please be patient...");
	
	#if defined a_OnPlayerConnect
		return a_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect a_OnPlayerConnect
#if defined a_OnPlayerConnect
	forward a_OnPlayerConnect(playerid);
#endif