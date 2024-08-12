CMD:ecc(playerid, params[]) {

    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

    new vid = GetClosestVehicle(playerid), string [ 64 ] ;
    if (vid != -1) {

        new seat = GetAvailableVehicleSeat(vid);

        if (seat != -1) {

            PauseAC(playerid, 3);   
            
            format ( string, sizeof  (string ), "entered closest car ID %d with seat %d", vid, seat ) ;
            AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

            JT_PutPlayerInVehicle(playerid, vid, seat);
        }
        else SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The closest car is full.") ;
    }
    else SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "No vehicle found - maybe there are no cars in the server?") ;

    return 1;
}

CMD:entercar(playerid, params[]) {

    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

    new carid, seat, string [ 75 ] ;

    if ( sscanf ( params, "iI(0)", carid, seat ) ){

        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/entercar [carid] [optional: seat]") ; 
    }

    if ( seat < 0 || seat > 4 ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "There are no less than 0 seats or more than 4 seats in a vehicle.") ; 
    }

    if ( seat > GetVehicleMaxSeats ( carid ) ) {
        format ( string, sizeof  (string ),"The car you are trying to enter only has %d seats.", GetVehicleMaxSeats ( carid ) ); 
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", string);
    }

    new bool: seat_taken = false ;

    foreach(new i: Player) {
        if ( IsPlayerInAnyVehicle(i) ) {
            if ( GetPlayerVehicleID ( i ) == carid ) {

                if ( GetPlayerVehicleSeat(i ) == seat ) {

                    seat_taken = true ;
                }

                else continue ;
            }

            else continue ;
        }

        else continue ;
    }

    if ( seat_taken ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The seat you are trying to enter is already occupied!" ) ; 
    }

    JT_PutPlayerInVehicle(playerid, carid, seat ) ;

    format ( string, sizeof  (string ),"AdminWarn:{DEDEDE} Warped you inside of vehicle %d, seat slot %d.", carid, seat );
    SendClientMessage(playerid, COLOR_YELLOW, string ) ;


    format ( string, sizeof  (string ),"warped themselves inside car ID %d with seat %d", carid, seat ) ;
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

    return true ;
}

CMD:fcargoto(playerid, params[]) return cmd_gotocar(playerid, params);
CMD:fgotocar(playerid, params[]) return cmd_gotocar(playerid, params);
CMD:gotocar(playerid, params[])
{
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR)  {

        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

    new carid, Float:x, Float:y, Float:z;
    if (sscanf(params, "d", carid) == 0)
    {
        if (IsValidVehicle(carid))
        {
            GetVehiclePos(carid, x, y, z);
		    PauseAC(playerid, 3);
            SetPlayerPos(playerid, x+2, y+2, z);
            SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(carid));
            // SendClientMessage(playerid, -1, "Teleported to car.");

            new string [ 128 ] ;
            format ( string, sizeof  (string ),"teleported to a \"%s\" (%d)", ReturnVehicleName(carid), carid );
            AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

            if (GetPlayerAdminLevel(playerid) <= ADMIN_LVL_JUNIOR)
            {
                format (string, sizeof ( string ), "[AdminCmd]: (%d) %s %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], string);
   	            SendAdminMessage(string);
            }

        }
        else SendClientMessage(playerid, -1,"That vehicle ID does not exist.");
    }
    else SendClientMessage(playerid, -1,"Usage: /gotocar [car id]");

    return 1 ;
}
CMD:carget(playerid, params[]) {

    return cmd_getcar(playerid, params);
}

CMD:getcar(playerid, params[]){

    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }


    new carid, Float:x, Float:y, Float:z;
    if (sscanf(params, "d", carid) == 0)
    {
        if (IsValidVehicle(carid))
        {
            GetPlayerPos(playerid, x, y, z);
            SetVehiclePos(carid, x+2, y+2, z-0.2);
            //SendClientMessage(playerid, -1, "Car teleported to you.");
            SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid));
            LinkVehicleToInterior(carid, GetPlayerInterior(playerid));

            new string [ 128 ] ;
            format ( string, sizeof  (string ),"teleported a \"%s\" (%d) to them.", ReturnVehicleName(carid), carid );
            AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

            if (GetPlayerAdminLevel(playerid) <= ADMIN_LVL_JUNIOR)
            {
                format (string, sizeof ( string ), "[AdminCmd]: (%d) %s %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], string);
   	            SendAdminMessage(string);
            }
        }
        else SendClientMessage(playerid, -1, "That vehicle ID does not exist.");
    }
    else SendClientMessage(playerid, -1, "Usage: /getcar [car id]");
    return 1;

}

CMD:cleartrucker(playerid, params[])
{
    if (!IsPlayerHelper(playerid)) 
    {
        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

    new carid;
    if (sscanf(params, "d", carid)) return SendClientMessage(playerid, -1,"Usage: /cleartrucker [car id]");
    if (!IsValidVehicle(carid)) SendClientMessage(playerid, -1,"That vehicle ID does not exist.");

    new veh_enum_id = Vehicle_GetEnumID(carid);
    Vehicle_ClearTruckerVariables(veh_enum_id);
    return true;
}

CMD:takecar(playerid, params[])
{
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR && !IsPlayerHelper(playerid) ) {

        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new carid, occupants;
    if (sscanf(params, "d", carid) == 0)
    {
        if (IsValidVehicle(carid))
        {
            foreach ( new i : Player ) 
			{
				if (IsPlayerConnected(i) && GetPlayerVehicleID(i) == carid && i != playerid)
				{
					// Kick occupants out before respawning the car
					JT_RemovePlayerFromVehicle(i);
                    occupants ++;
				}
			}

            if (occupants) defer TakecarTimed(playerid, carid);
            else TakecarTimed(playerid, carid);
        }
        else SendClientMessage(playerid, -1,"That vehicle ID does not exist.");
    }
    else SendClientMessage(playerid, -1,"Usage: /takecar [car id]");

    return 1 ;
}

CMD:respawncar(playerid, params[]) return cmd_takecar(playerid, params);

timer TakecarTimed[500](playerid, carid)
{
    new Float:x, Float:y, Float:z;

    foreach ( new i : Player ) 
    {
        if (GetPlayerVehicleID(i) == carid)
        {
            JT_RemovePlayerFromVehicle(i);
            GetPlayerPos(i, x, y, z);
		    PauseAC(i, 3);
			SetPlayerPos(i, x, y, z);
        }
    }

    JT_PutPlayerInVehicle(playerid, carid, 0);
    SOLS_SetVehicleToRespawn(carid, "/takecar", true);

    new string [ 100 ] ;
    format ( string, sizeof ( string ), "[!!!] [AdmWarn] %s respawned a \"%s\" (VID: %d)", Account[playerid][E_PLAYER_ACCOUNT_NAME], ReturnVehicleName(carid), carid ) ;
    SendAdminMessage(string) ;

    format ( string, sizeof  (string ),"respawned vehicle ID %d", carid );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);
}