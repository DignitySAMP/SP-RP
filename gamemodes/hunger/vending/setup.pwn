public OnGameModeInit(){

 	CreateVendingMachines();

	#if defined vending_OnGameModeInit
		return vending_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit vending_OnGameModeInit
#if defined vending_OnGameModeInit
	forward vending_OnGameModeInit();
#endif

public OnPlayerConnect(playerid) {
	
	RemoveDefaultVendingMachines(playerid);

	if ( IsValidDynamicObject( g_PlayerVendingProp [ playerid ] ) ) {
		DestroyDynamicObject( g_PlayerVendingProp [ playerid ]);
		g_PlayerVendingProp [ playerid ] = INVALID_OBJECT_ID ;
	}
	g_PlayerVendingModel [ playerid ] = 0 ;

	#if defined vending_OnPlayerConnect
		return vending_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect vending_OnPlayerConnect
#if defined vending_OnPlayerConnect
	forward vending_OnPlayerConnect(playerid);
#endif
