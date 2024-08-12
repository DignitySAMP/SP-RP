#include <a_samp>
#include <streamer>
#include <sscanf2>
#include <strlib>
#include <YSI_Data\y_iterate>
#include <zcmd>
#include <progress2>

/*
	Player enters area and textdraw pops up, plus gets infobox "press X to refuel"
	To activate, you must choose your nozzle amount (low / med / high). 
	This enables a progress bar showing how much fuel you have left. 
	(counts up to the price based on progress bar %)

	If they hold the key, the nozzle textdraw will pop out & fuel sound will play
	Gametext will pop up showing how much fuel is being filled. 

	Fuel types:
		Sort all GTA SA cars into an array per type and assign them fuel types appropiately.
			tron = normal cars
			globeoil = sports / performance / bikes
			terroil = utility, 4x4, "heavy" 

	Players can "buy" fuel stations. They earn 30% of the fuel cost. 
	They can collect this freely by doing /fuelcollect near their fuel tank object.

	For now it's static, but add a modifier for EACH fuel type.
	(Upcoming government system from v2 will be able to change these prices per nozzle stage (low/med/high)!)
	(Add a default framework for government that allows government to change these prices (government fuel tax!))
	(This fuel tax is put into the government fbank, which will eventually be linked to PD / EMS / etc)

	Fuel station owners have to invest! Fuel stations need to be refilled and can run out of juice!
	(/fuelorder: you enter an amount of $ to invest, this is 50% the cost of fuel based on type)
	(so if your regular 100% amount is 250, you pay 125 per 10%. To get 100% filled you pay 12.5k)
*/

#include "vehicle/fuel/data_owner.pwn"
#include "vehicle/fuel/data_pump.pwn"
#include "vehicle/fuel/cmds_pump.pwn"
#include "vehicle/fuel/cmds_owner.pwn"
#include "vehicle/fuel/gui.pwn"
#include "vehicle/fuel/gui_extra.pwn"
#include "vehicle/fuel/func.pwn"
#include "vehicle/fuel/native.pwn"

Fuel_OnScriptInit() {
	FuelStation_LoadEntities();
	FuelPump_LoadEntities();

	return true ;
}

//#warning add /fuelstations CMD - shows all fuel stations, distance, and type! (like /firms)

CMD:refill(playerid) {

	SendClientMessage(playerid, COLOR_YELLOW, "To refill your car, drive it nearby a fuel pump and the menu should pop up.");
	SendClientMessage(playerid, COLOR_ORANGE, "Alternatively, purchase a gascan and use /gascan.");
	return true ;
}
CMD:refuel(playerid) return cmd_refill(playerid);
CMD:refuelcar(playerid) return cmd_refill(playerid);
CMD:fillcar(playerid) return cmd_refill(playerid);
CMD:carfill(playerid) return cmd_refill(playerid);
CMD:carrefuel(playerid) return cmd_refill(playerid);
CMD:carfuel(playerid) return cmd_refill(playerid);
CMD:fuelcar(playerid) return cmd_refill(playerid);
CMD:fuel(playerid) return cmd_refill(playerid);
CMD:fill(playerid) return cmd_refill(playerid);

CMD:gascan(playerid) {

    if ( ! PlayerVar [ playerid ] [ E_PLAYER_HAS_GASCAN ] ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a gascan! Buy one from a 24/7 or General Store.");
    }

    new vehicleid = GetPlayerVehicleID ( playerid );
    new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

    if ( veh_enum_id == -1 ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "You're not in a proper vehicle.");
    }

    if ( IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) {

        if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] >= 25 ) {

            return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Your vehicle still has 25 percent or more left in their tank!");
        }

        VehicleVar [ veh_enum_id ] [ E_VEHICLE_VAR_FUEL_INCR ] = 0 ;
        Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 35 ;
        PlayerVar [ playerid ] [ E_PLAYER_HAS_GASCAN ] = false ;


        new query [ 256 ] ;

        mysql_format(mysql, query, sizeof ( query), "UPDATE vehicles SET vehicle_fuel = %d WHERE vehicle_sqlid = %d",
            Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] );

        mysql_tquery(mysql, query);

		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "**", sprintf("uses a gascan to refill their %s.", ReturnVehicleName ( vehicleid )), .annonated=true);
        SendServerMessage ( playerid, COLOR_BLUE, "Fuel", "A3A3A3", "You've refueled your vehicle." ) ;

    }

    return true ;
}

CMD:acarfuel(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new endpid, vid, string [ 128 ], name[MAX_PLAYER_NAME+1], msgfrom[MAX_PLAYER_NAME+24] ;

    if (sscanf(params, "k<player>", endpid) == 0)
    {
    	vid = GetPlayerVehicleID(endpid);

        if (IsPlayerConnected(endpid))
        {

            GetPlayerName(endpid, name, sizeof(name));
			if (vid != 0)
			{
				
				new veh_enum_id = Vehicle_GetEnumID(vid) ;
				Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100;

			   	format (string, sizeof(string), "[AdminCmd]: (%d) %s has refuelled car (%d).", playerid, ReturnMixedName(playerid), vid) ;
			   	SendAdminMessage(string) ;

			    if (endpid != playerid)
			    {
			        new msgto[34];
				    format(msgto, sizeof(msgto), "Your car has been refuelled by an admin.", name);
					SendClientMessage(endpid, 0xFFFFFFFF, msgto);
				}
	    	}
	    	else
			{
   				new msg[MAX_PLAYER_NAME+33];
			    format(msg, sizeof(msg), "%s is not in any vehicle.", name);
				SendClientMessage(playerid, COLOR_RED, msg);
			}
    	}
    	else SendClientMessage(playerid, COLOR_RED, "Invalid player ID");
	}
	else
	{
		vid = GetPlayerVehicleID(playerid) ;
        GetPlayerName(playerid, name, sizeof(name));
		if (vid != 0)
		{
		   	format ( string, sizeof ( string ), "[AdminCmd]: (%d) %s has refuelled car (%d).", 
		   		playerid, ReturnMixedName ( playerid ), vid ) ;
		   	
		   	SendAdminMessage(string) ;

			new veh_enum_id = Vehicle_GetEnumID(vid) ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_FUEL ] = 100;

			format(msgfrom, sizeof(msgfrom), "%s's car has been refuelled.", name);
			SendClientMessage(playerid, 0xFFFFFFFF, msgfrom);
    	}
    	else SendClientMessage(playerid, COLOR_RED,"Usage: /acarfuel [playerid]");
	}

	return 1;
}
