
CMD:carcolor(playerid, params[]) {

    if ( ! IsPlayerNearPayNSpray(playerid) ) {
        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be near a Pay and Spray in order to be able to do this!" ) ;
        return true ;
    }
    
    new vehicleid = GetPlayerVehicleID ( playerid );
    new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

    if ( veh_enum_id == -1 ) {

        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be in a valid vehicle in order to do this." ) ;
        ShowMenuForPlayer(pns_menu, playerid);
        return true ;
    }

    if ( GetPlayerState ( playerid ) != PLAYER_STATE_DRIVER ) {

        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be the driver of a vehicle in order to do this." ) ;
        return true ;
    }

    new color_a, color_b ;

    if ( sscanf ( params, "ii", color_a, color_b ) ) {
        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "/carcolor [color-a] [color-b] (/carcolorlist)" ) ;
        return true ;
    }

    if (color_a < 0 || color_a >= 256 || color_b < 0 || color_b >= 256)
    {
        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "/carcolor [color-a] [color-b] (/carcolorlist)" ) ;
        return true;
    }

    if ( GetPlayerCash(playerid) < 100 ) {

        GameTextForPlayer(playerid, "~n~~n~~n~~w~No more freebies!~n~You need at least $100!", 2000, 4);
        return true ;
    }
    GameTextForPlayer(playerid, "~w~Resprayed Car For $100!", 2000, 3);
    TakePlayerCash ( playerid, 100 ) ;

    Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ] = color_a ;
    Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] = color_b ;

    ChangeVehicleColorEx( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ,  Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] ) ;

    PlayerPlaySound(playerid, 1134, 0, 0, 0);

    new query [ 256 ] ;
    mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_color_a = %d, vehicle_color_b = %d WHERE vehicle_sqlid = %d",
        Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
    );

    mysql_tquery(mysql, query);

    return true ;
}