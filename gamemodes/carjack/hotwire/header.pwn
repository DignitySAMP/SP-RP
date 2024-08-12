#include "carjack/hotwire/gui.pwn"
#include "carjack/hotwire/func.pwn"
#include "carjack/hotwire/native.pwn"

Hotwire_CloseMenu(playerid) {
 
 	if ( PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING ] ) {
	 	PlayerVar [ playerid ] [ E_PLAYER_HOTWIRING ] = false ;

		PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_WIRE_SELECTED ] = -1;
		E_PLAYER_HOTWIRE_SELECTED_PTD [ playerid ] = PlayerText: INVALID_TEXT_DRAW ;
		E_PLAYER_HOTWIRE_SELECTED_TD [ playerid ] = Text: INVALID_TEXT_DRAW ;
		PlayerVar [ playerid ] [ E_PLAYER_HOTWIRE_TIER ] = 5 ;

		GUI_HideHotwireGUI(playerid) ;
		GUI_HideHotwirePlayerGUI(playerid);
	}

	return true ;
}

CMD:hotwire(playerid, params[]) {


	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any proper vehicle! (couldn't fetch ID)");
	}
	if (!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");


	if (Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] <= 1) {
	    return SendClientMessage(playerid, COLOR_ERROR, "The fuel tank is empty.");
	}

	if (ReturnVehicleHealth(vehicleid) <= 300) {
		if ( ! IsAircraft ( vehicleid ) ) {
	    	return SendClientMessage(playerid, COLOR_ERROR, "This vehicle is totalled and can't be started.");
	    }

	    else {

	    	SendClientMessage(playerid, COLOR_YELLOW, "Your vehicle is in very bad condition (engine damage). Get it fixed before it blows up!");
	    }
	}

	if ( GetEngineStatus(vehicleid) ) {

    	return SendClientMessage(playerid, COLOR_ERROR, "The engine is already on...");
	}

	switch ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ]) {

		case E_VEHICLE_TYPE_PLAYER: {
			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

				Hotwire_SetupForPlayer ( playerid, Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
			}

			else if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

	    		return SendClientMessage(playerid, COLOR_ERROR, "Why would you hotwire your own car?");
			}

		}

		case E_VEHICLE_TYPE_DEFAULT: {
			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

				Hotwire_SetupForPlayer ( playerid, Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
			}
		
		}

		default: {

	    	return SendClientMessage(playerid, COLOR_ERROR, "This vehicle can't be hotwired.");
		}
	}	


	return true ;
}
