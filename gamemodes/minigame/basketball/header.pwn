/*

	Changes:

	*Fixed timers
	*Improved physics
	*Player now has to finish performing picking up ball animation
	*Fixed overlapping back spins
	*Added back spin (KEY_JUMP)
	*Fixed catching ball from player who bounce it
	*Players now be able to leave game by pressing F
	*Added finger spin (KEY_WALK)
	*Fixed other basketballs get attached to players in different courts.
	*Now basketball rotates while being bounced.
	*Now basketball is an attached object thus it syncs better.
	*Small fixes.

	Known bugs:

	*Once you pass the ball to void, it always skims to south.

*/

#include <progress2>
#include <dini>

#include "minigame/basketball/data.pwn"
#include "minigame/basketball/misc.pwn"
#include "minigame/basketball/func.pwn"
#include "minigame/basketball/player.pwn"
#include "minigame/basketball/timers.pwn"

Basketball_Init() {
	LoadCourts();
/*
	TextdrawAccuracy = TextDrawCreate(553.00000, 108.000000, "ACCURACY");
	TextDrawAlignment(TextdrawAccuracy, 2);
	TextDrawBackgroundColor(TextdrawAccuracy, 255);
	TextDrawFont(TextdrawAccuracy, 2);
	TextDrawLetterSize(TextdrawAccuracy, 0.3, 1.499999);
	TextDrawColor(TextdrawAccuracy, -1);
	TextDrawSetOutline(TextdrawAccuracy, 1);
	TextDrawSetProportional(TextdrawAccuracy, 1);
	TextDrawSetSelectable(TextdrawAccuracy, 0);
*/
}

Basketball_OnPlayerConnect(playerid) {
	

	// Removing hoops from SP
	RemoveBuildingForPlayer(playerid, 947, 2533.8828, -1667.5781, 16.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 946, 2290.5781, -1514.2734, 28.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 946, 2316.9375, -1541.6094, 26.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 946, 2768.1563, -2019.6172, 14.6016, 0.25);

	BasketPlayerVars [ playerid ] [ PlayerImmunity ] = false;
    Timer_Airblock [ playerid ] = -1;
    Timer_Endblock [ playerid ] = -1;
    BasketPlayerVars [ playerid ] [ ThrottleUpdate ] = 0;
    BasketPlayerVars [ playerid ] [ PlayerCourtID ] = -1;
    //BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ] = CreatePlayerProgressBar(playerid, 525.00, 125, 62.50, 5.19, -1395920385, 100.0);

    return true ;
}

Basketball_OnPlayerDisconnect(playerid) {

 	if(BasketPlayerVars[playerid][PlayerCourtID] != -1 && CourtVars[BasketPlayerVars[playerid][PlayerCourtID]][CourtBasketball_BouncerID] == playerid)
    {
        KillAllTimers(BasketPlayerVars[playerid][PlayerCourtID]);
        ResetBasketball(BasketPlayerVars[playerid][PlayerCourtID]);
        BasketPlayerVars[playerid][PlayerCourtID] = -1;
        //TextDrawHideForPlayer(playerid, TextdrawAccuracy);
    }

	//DestroyPlayerProgressBar(playerid, BasketPlayerVars [ playerid ] [ PlayerAccuracyBar ]);
	//TextDrawHideForPlayer(playerid, TextdrawAccuracy);
	RemovePlayerFromBasketball(playerid) ;

	return true ;
}

/*

public OnFilterScriptInit()
{
	LoadCourts();

	TextdrawAccuracy = TextDrawCreate(574.000000, 139.000000, "ACCURACY");
	TextDrawAlignment(TextdrawAccuracy, 2);
	TextDrawBackgroundColor(TextdrawAccuracy, 255);
	TextDrawFont(TextdrawAccuracy, 2);
	TextDrawLetterSize(TextdrawAccuracy, 0.339999, 1.499999);
	TextDrawColor(TextdrawAccuracy, -1);
	TextDrawSetOutline(TextdrawAccuracy, 1);
	TextDrawSetProportional(TextdrawAccuracy, 1);
	TextDrawSetSelectable(TextdrawAccuracy, 0);
	return 1;
}

public OnFilterScriptExit()
{
	for(new c = 0; c < MAX_COURTS; c++)
	{
	    if(IsValidObject(CourtVars [ c ] [ CourtBasketball ] ))
	    {
	        DestroyObject(CourtVars [ c ] [ CourtBasketball ] );
	    }
	    if(IsValidObject(CourtVars [ c ] [ CourtHoop ] [0]))
	    {
	   		DestroyObject(CourtVars [ c ] [ CourtHoop ] [0]);
   		}
   		if(IsValidObject(CourtVars [ c ] [ CourtHoop ] [1]))
	    {
	   		DestroyObject(CourtVars [ c ] [ CourtHoop ] [1]);
   		}
	}

	return 1;
}*/

// when player starts to enter vehicle
public OnPlayerEnterVehicle (playerid, vehicleid, ispassenger) {

	new courtid = BasketPlayerVars[playerid][PlayerCourtID] ;

	if ( courtid != -1 ) {

		if(CourtVars[courtid][CourtBasketball_BouncerID] == playerid ) { 

			RefreshBasketballCourt ( courtid ) ;
	    }

	    HideMinigameHelpBox ( playerid ) ;
	    RemovePlayerFromBasketball(playerid);
	    ApplyAnimation(playerid, "bsktball", "bball_jump_cancel_o", 4.1, 0, 0, 0, 1, 1, 1);

		SendClientMessage(playerid, COLOR_YELLOW, "Warning: there's a vehicle nearby. This could cause problems with your basketball game. Move it away or ask an admin to move it." ) ;
	}

	#if defined minigame_OnPlayerEnterVehicle 
		return minigame_OnPlayerEnterVehicle ( playerid, vehicleid, ispassenger );
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEnterVehicle 
	#undef OnPlayerEnterVehicle 
#else
	#define _ALS_OnPlayerEnterVehicle 
#endif

#define OnPlayerEnterVehicle  minigame_OnPlayerEnterVehicle 
#if defined minigame_OnPlayerEnterVehicle 
	forward minigame_OnPlayerEnterVehicle ( playerid, vehicleid, ispassenger );
#endif
