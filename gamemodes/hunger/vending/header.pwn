new g_PlayerVendingProp [ MAX_PLAYERS ] ;
new g_PlayerVendingModel [ MAX_PLAYERS ] ;

#include "hunger/vending/setup.pwn"
#include "hunger/vending/data.pwn"
#include "hunger/vending/func.pwn"


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if ( newkeys & KEY_SECONDARY_ATTACK ) {
		for (new i = 0; i < sizeof(sc_VendingMachines); i++) {

			if ( IsPlayerInDynamicArea(playerid, s_VendingMachineArea[i] )) {

				OnPlayerUseVending(playerid, i);
			}
		}
	}
	
	#if defined vending_OnPlayerKeyStateChange
		return vending_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange vending_OnPlayerKeyStateChange
#if defined vending_OnPlayerKeyStateChange
	forward vending_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

OnPlayerApproachVending(playerid, arrayid ) {

	switch ( sc_VendingMachines[arrayid][e_Model] ) {
		case E_VENDING_MACHINE_SPRUNK: ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Buy Sprunk: $10", .height=285.0); // sprunk
		case E_VENDING_MACHINE_ECOLA: ShowPlayerInfoMessage(playerid, "~k~~VEHICLE_ENTER_EXIT~ Buy eCola: $10", .height=285.0); // soda
	}

	return true ;
}


OnPlayerLeaveVending(playerid ) {

	HidePlayerInfoMessage(playerid);
	return true ;
}


OnPlayerUseVending(playerid, arrayid) {

	if ( GetPlayerAnimationIndex(playerid) != 1660) {
		new bool:failed = false;

		if (GetPlayerCash ( playerid ) < 10 ) {
			ShowPlayerInfoMessage(playerid, "You need at least $10 to use this machine.", .height=285.0); //
			failed = true;
		}

		if ( GetCharacterHealth (playerid) >= 100.0 ) {
			ShowPlayerInfoMessage(playerid, "You can't use this machine with full health.", .height=285.0); //
			failed = true ;
		}

		new Float:z;

		GetPlayerPos(playerid, z, z, z); 

		for (new i = 0; i < sizeof(sc_VendingMachines); i++) {

			if (IsPlayerInRangeOfPoint(playerid, 0.5, sc_VendingMachines[i][e_FrontX], sc_VendingMachines[i][e_FrontY], z)) {
				if (failed) {
					PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
					break;
				}

				TakePlayerCash ( playerid, 10 ) ;

				SetPlayerFacingAngle(playerid, sc_VendingMachines[i][e_RotZ]);
				PauseAC(playerid, 3);
				SetPlayerPos(playerid, sc_VendingMachines[i][e_FrontX], sc_VendingMachines[i][e_FrontY], z);

				ApplyAnimation(playerid, "VENDING", "VEND_USE", 4.1, 0, 0, 0, 0, 0, 1);

				SetCharacterHealth(playerid, GetCharacterHealth(playerid) + 5 );
				Gym_AppendPlayerNeeds ( playerid, E_GYM_STAT_THIRST, 2+random(3));

				switch ( sc_VendingMachines[i][e_Model] ) {
					case E_VENDING_MACHINE_SPRUNK: PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0); // sprunk
					case E_VENDING_MACHINE_ECOLA: PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0); // soda
				}

				defer Vending_AnimatePlayer[2500](playerid, arrayid, 0);
			}
		}
	}

	return true ;
}

timer Vending_AnimatePlayer[5000](playerid, arrayid, anim_reel) {

	new Float: x, Float: y, Float: z ;

	// Declaring the model id!
	if (! g_PlayerVendingModel [ playerid ] ) {

		switch ( sc_VendingMachines[arrayid][e_Model]) {

			case E_VENDING_MACHINE_SPRUNK: {
				switch ( random ( 2 ) ) {

					case 0: g_PlayerVendingModel [ playerid ] = E_VENDING_CAN_SPRUNK_BIG ;
					default: g_PlayerVendingModel [ playerid ] = E_VENDING_CAN_SPRUNK_SMALL ;
				}
			}
			case E_VENDING_MACHINE_ECOLA: {
				
				switch ( random ( 2 ) ) {

					case 0: g_PlayerVendingModel [ playerid ] = E_VENDING_CAN_ECOLA_BIG ;
					default: g_PlayerVendingModel [ playerid ] = E_VENDING_CAN_ECOLA_SMALL ;
				}
			}
		}
	}

	switch(anim_reel) {

		case 0: { // attach object

			SetPlayerAttachedObject(playerid,0,g_PlayerVendingModel [ playerid ],5,0.135999,0.043999,-0.031000,177.199951,0.0,0.0,1.0,1.0,1.0); // soda
			ApplyAnimation(playerid, "VENDING", "VEND_USE_PT2", 4.1, 0, 0, 0, 0, 0, 1);
			defer Vending_AnimatePlayer[250](playerid, arrayid, 1);
		}

		case 1: { // drink/eat anim

 			ApplyAnimation(playerid, "VENDING", "VEND_DRINK_P", 4.1, 0, 0, 0, 0, 0, 1); // sprunk
			defer Vending_AnimatePlayer[1500](playerid, arrayid, 2);
		}

		case 2: { // drop object

			if ( IsValidDynamicObject( g_PlayerVendingProp [ playerid ] ) ) {
				DestroyDynamicObject( g_PlayerVendingProp [ playerid ]);
				g_PlayerVendingProp [ playerid ] = INVALID_OBJECT_ID ;
			}

			GetPlayerPos(playerid, x, y, z ) ;
			GetXYLeftOfPlayer(playerid, x, y, 0.35 );

			RemovePlayerAttachedObject(playerid, 0);

			g_PlayerVendingProp [ playerid ] = CreateDynamicObject(g_PlayerVendingModel [ playerid ], x, y, z, 0.0, 90.0, 90.0);
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

			MoveDynamicObject(g_PlayerVendingProp [ playerid ], x + 0.02, y + 0.02, z - 0.95, 3.0);

			defer Vending_AnimatePlayer[7500](playerid, arrayid, 3);
		}

		case 3: { // destroy object

			if ( IsValidDynamicObject( g_PlayerVendingProp [ playerid ] ) ) {
				DestroyDynamicObject( g_PlayerVendingProp [ playerid ]);
				g_PlayerVendingProp [ playerid ] = INVALID_OBJECT_ID ;
			}
			g_PlayerVendingModel [ playerid ] = 0 ;
		}
	}

	return true ;
}