#if defined _inc_rpchat
    #undef _inc_rpchat
#endif

#include "message/local.pwn"
#include "message/action.pwn"
#include "message/annonated.pwn"
#include "message/ooc.pwn"

CMD:chathelp(playerid, params[]) {

	return ShowChatCommands(playerid) ;
}

SendPlayerChatText(playerid, text[], toid=INVALID_PLAYER_ID)
{
	if (!IsPlayerSpawned ( playerid ) ) 
	{
		SendClientMessage(playerid, COLOR_ERROR, "You must be spawned before you can use the chat.");
		return 0 ;
	}
	
	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_MIN_TICK ] <= 0 ) {
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't speak. Use /acceptdeath to continue.");
		return 0 ;
	}

    if ( PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] ) {

    	SendClientMessage(playerid, COLOR_YELLOW, "You can't use local chat while your /logout timer is ticking." ) ;
        return 0 ;
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new string[256];

	// Send phone message to recipient
	if ( PlayerVar [ playerid ] [ player_phonecalling ] != INVALID_PLAYER_ID) {

		new targetid = PlayerVar [ playerid ] [ player_phonecalling ] ;
		format(string, sizeof(string), "%s{FFFF00} says (phone): %s", ReturnSettingsName(playerid, targetid, true), text);
		ZMsg_SendClientMessage(targetid, COLOR_YELLOW, string);
	}

	// Send local message
	if (vehicleid && IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(vehicleid)) 
	{
		new veh_enum_id = Vehicle_GetEnumID(GetPlayerVehicleID(playerid));
		
		if ( veh_enum_id != INVALID_VEHICLE_ID ) {
			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] ) {// up

				foreach(new targetid: Player) 
				{
					if ( GetPlayerVehicleID(targetid) == GetPlayerVehicleID ( playerid ) ) {

						if (PlayerVar [ playerid ] [ player_phonecalling ] != INVALID_PLAYER_ID ) {
							format ( string, sizeof ( string ), "(Windows Closed) %s{DEDEDE} says (phone): %s", ReturnSettingsName(playerid, targetid, true), text ) ;
						}
						else {

							if (toid != INVALID_PLAYER_ID) {
								if(playerid == toid) {
									format ( string, sizeof ( string ), "(Windows Closed) %s says (to self): %s",  ReturnSettingsName(playerid, targetid, true), text ) ;
								} 
								else format ( string, sizeof ( string ), "(Windows Closed) %s says (to %s): %s",  ReturnSettingsName(playerid, targetid, true), ReturnSettingsName(toid, targetid, true), text ) ;
							}

							else format ( string, sizeof ( string ), "(Windows Closed) %s{DEDEDE} says: %s",  ReturnSettingsName(playerid, targetid, true), text ) ;
						}


						ZMsg_SendClientMessage(targetid, 0xDEDEDEFF, string);
					}
				}
			}
			
			else if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] ) {// down

				if (PlayerVar [ playerid ] [ player_phonecalling ] == INVALID_PLAYER_ID ) {

					if (toid != INVALID_PLAYER_ID) {
						format(string, sizeof(string), "says (to %s): %s", ReturnMixedName(toid), text);
						ProxDetectorEx(playerid, 15.0, 0xDEDEDEFF, "(Windows Open)", string, .showtagcolor=true, .annonated=true, .chat=true);
					} 
					else {
						format(string, sizeof(string), "says: %s", text);
						ProxDetectorEx(playerid, 15.0, 0xDEDEDEFF, "(Windows Open)", string, .showtagcolor=true, .annonated=true, .chat=true);
					}
    			}

    			else {
					format(string, sizeof(string), "says (phone): %s", text);
					ProxDetectorEx(playerid, 15.0, 0xDEDEDEFF, "(Windows Open)", string, .showtagcolor=true, .annonated=true, .chat=true);
    			}
			}
		}
	}

	else {

		if(PlayerVar [ playerid ] [ player_phonecalling ] != INVALID_PLAYER_ID ) {

			format(string, sizeof(string), "says (phone): %s", text);

			if ( GetPlayerVirtualWorld(playerid) == 0) {
				ProxDetectorEx(playerid, 15.0, 0xDEDEDEFF, "", string, .showtagcolor=true, .annonated=true, .chat=true);
			}
			else ProxDetectorEx(playerid, 10.0, 0xDEDEDEFF, "", string, .showtagcolor=true, .annonated=true, .chat=true);
		}

		else 
		{
			new Float:range = 15.0;

			// Make arrested people quieter cause honestly fuck the spam
			if ( Character [ playerid ] [ E_CHARACTER_ARREST_TIME ] ) range = 7.5;
			else if ( GetPlayerVirtualWorld(playerid) != 0 ) range = 10.0; // Make interiors a bit quieter too

			if(toid != INVALID_PLAYER_ID) {
				format(string, sizeof(string), "says (to %s): %s", ReturnMixedName(toid), text);
				ProxDetectorEx(playerid, range, 0xDEDEDEFF, "", string, .showtagcolor=true, .annonated=true, .chat=true);
			} 
			else {
			
				format(string, sizeof(string), "says: %s", text);
				ProxDetectorEx(playerid, range, 0xDEDEDEFF, "", string, .showtagcolor=true, .annonated=true, .chat=true);
			}

			PlayChatAnimation(playerid, text);
		}
	}

	return 1;
}