#define DOUBLE_CLICK_TIME 1500
#define REARMED_WEAPON_UPDATES 4

new
    g_TickPushed[MAX_PLAYERS],
    g_Count[MAX_PLAYERS],
    g_Weapon[MAX_PLAYERS] ;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if(!IsABike(GetPlayerVehicleID(playerid))){
	    if (GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {

		    if (newkeys & KEY_CROUCH) {

				if (GetTickCount() - g_TickPushed[playerid] < DOUBLE_CLICK_TIME ) {

				   	g_Weapon[playerid] = AC_GetPlayerWeapon(playerid);
		            g_Count[playerid] = REARMED_WEAPON_UPDATES;
		            ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1, 1);
		            ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1, 1);
		            ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1, 1);
		            ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1, 1);

		            if ( DoesPlayerHaveWeapon(playerid, WEAPON_BRASSKNUCKLE ) ) {
		           	 	AC_RemovePlayerWeapon ( playerid, WEAPON_BRASSKNUCKLE ) ; 
		           	 	PlayerVar [ playerid ] [ E_PLAYER_DRIVEBY_BRASSKNUCKLES ] = true ;
		           	}
		            SetPlayerArmedWeapon(playerid, 0);
				}

				g_TickPushed[playerid] = GetTickCount();
			}

		}
	}
	
	#if defined db_OnPlayerKeyStateChange
		return db_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange db_OnPlayerKeyStateChange
#if defined db_OnPlayerKeyStateChange
	forward db_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerUpdate(playerid) {
	if (GetPlayerState(playerid) == PLAYER_STATE_PASSENGER ){
		if(g_Count[playerid] ) {
	        if(--g_Count[playerid] == 0) {

	        	if ( g_Weapon[playerid] == WEAPON_DEAGLE ) {

	        		SendClientMessage(playerid, -1, "Tried to give back your weapon but it was switched to a Desert Eagle.");
	        		SendClientMessage(playerid, -1, "You can temporarily fix this by using /setaw. To fix it, re-enter the vehicle with a proper gun.");

	        		g_Weapon[playerid] = 0 ;

	        		return true ;
	        	}

	            SetPlayerArmedWeapon(playerid, g_Weapon[playerid]);
	        }
		}
	}
	
	#if defined db_OnPlayerUpdate
		return db_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate db_OnPlayerUpdate
#if defined db_OnPlayerUpdate
	forward db_OnPlayerUpdate(playerid);
#endif
