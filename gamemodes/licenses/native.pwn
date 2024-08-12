public OnPlayerConnect(playerid) {
	
	License_OnLoadPlayerGUI(playerid);

	#if defined license_OnPlayerConnect
		return license_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect license_OnPlayerConnect
#if defined license_OnPlayerConnect
	forward license_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason) {
	
	License_DestroyPlayerGUI(playerid);
	Badge_DestroyPlayerGUI(playerid);

	#if defined license_OnPlayerDisconnect
		return license_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect license_OnPlayerDisconnect
#if defined license_OnPlayerDisconnect
	forward license_OnPlayerDisconnect(playerid, reason);
#endif