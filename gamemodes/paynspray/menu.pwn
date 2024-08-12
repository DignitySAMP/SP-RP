
#define PNS_BODYKIT_COST 150
#define PNS_ENGINE_COST 200

#include <YSI_Coding\y_hooks>
hook OnPlayerSelectedMenuRow(playerid, row)
{
    if ( PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] ) {

        if(GetPlayerMenu(playerid) == pns_menu) {

            new query [ 512 ], Float: health,  vehicleid, veh_enum_id, panels, doors, lights, tires, string[64], cost;

            vehicleid = GetPlayerVehicleID ( playerid );
            veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

            if ( veh_enum_id == -1 ) {

                SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be in a valid vehicle in order to do this." ) ;
                //HideCBrowser(playerid);
                HideMenuForPlayer(pns_menu, playerid);
                TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] = false ;
                return true ;
            }

            switch(row) {
                case 0: { // int

                    PlayerVar [ playerid ] [ E_PLAYER_PNS_MENU_CHOICE ] = 1 ;

                    static color_list[4096];

                    inline PNS_ColorSelectInt(pid, dialogid, response, listitem, string: inputtext[]) {
                        #pragma unused pid, dialogid, listitem

                        if ( ! response ) {

                            ShowMenuForPlayer(pns_menu, playerid);
                            return true ;
                        }

                        else if ( response ) {

                            if ( GetPlayerCash(playerid) < 100 ) {

                                GameTextForPlayer(playerid, "~n~~n~~n~~w~No more freebies!~n~You need at least $100!", 2000, 4);
                                ShowMenuForPlayer(pns_menu, playerid);
                                return true ;
                            }

                            if ( ! IsNumeric ( inputtext ) ) {

                                GameTextForPlayer(playerid, "~n~~n~~n~~w~Invalid color code entered!~n~Enter a ~r~proper number~w~!", 2000, 4);
                                ShowMenuForPlayer(pns_menu, playerid);
                                return true ;
                            }

                            if ( strval ( inputtext ) < 0 || strval ( inputtext ) > g_MaxVehicleColors ) {

                                GameTextForPlayer(playerid, sprintf("~n~~n~~n~~w~Invalid color code entered!~n~Enter a ~r~valid number~w~ (0-%d)!", g_MaxVehicleColors), 2000, 4);
                                ShowMenuForPlayer(pns_menu, playerid);
                                return true ;
                            }

                            GameTextForPlayer(playerid, "~w~Resprayed Car For $100!", 2000, 3);
                            TakePlayerCash ( playerid, 100 ) ;

                            new color = strval(inputtext);

                            Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ] = color ;

                            ChangeVehicleColorEx( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ,  Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] ) ;

                            PlayerPlaySound(playerid, 1134, 0, 0, 0);

                            mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_color_a = %d, vehicle_color_b = %d WHERE vehicle_sqlid = %d",
                                Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
                            );

                            mysql_tquery(mysql, query);
                            return true ;
                        }
                    }

                    format ( color_list, sizeof color_list, "Please choose a color from the list below:\n\n");

                    for (new colorid; colorid != sizeof g_VehicleColors; colorid++) {
                        format(color_list, sizeof color_list, "%s{%06x}%03d%s", color_list, g_VehicleColors[colorid] >>> 8, colorid, !((colorid + 1) % 16) ? ("\n") : (" "));
                    }

                    format ( color_list, sizeof color_list, "%s\n\n{DEDEDE}Enter the color id you wish to use for the INTERIOR.", color_list);

                    Dialog_ShowCallback ( playerid, using inline PNS_ColorSelectInt, DIALOG_STYLE_INPUT, "Respray Interior", color_list, "Respray", "Back" ) ;


                    //SendClientMessage(playerid, COLOR_YELLOW, "PNS:{DEDEDE} The color picker is temporarily disabled. Use /carcolorlist and /carcolor for now." ) ;
                    TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                    PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] = false ;
                }

                case 1: { // ext

                    PlayerVar [ playerid ] [ E_PLAYER_PNS_MENU_CHOICE ] = 2 ;
                    static color_list[4096];

                    inline PNS_ColorSelectExt(pid, dialogid, response, listitem, string: inputtext[]) {
                        #pragma unused pid, dialogid, listitem

                        if ( ! response ) {

                            ShowMenuForPlayer(pns_menu, playerid);
                            return true ;
                        }

                        else if ( response ) {

                            if ( GetPlayerCash(playerid) < 100 ) {

                                GameTextForPlayer(playerid, "~n~~n~~n~~w~No more freebies!~n~You need at least $100!", 2000, 4);
                                ShowMenuForPlayer(pns_menu, playerid);
                                return true ;
                            }

                            if ( ! IsNumeric ( inputtext ) ) {

                                GameTextForPlayer(playerid, "~n~~n~~n~~w~Invalid color code entered!~n~Enter a ~r~proper number~w~!", 2000, 4);
                                ShowMenuForPlayer(pns_menu, playerid);
                                return true ;
                            }

                            if ( strval ( inputtext ) < 0 || strval ( inputtext ) >= g_MaxVehicleColors ) {

                                GameTextForPlayer(playerid, sprintf("~n~~n~~n~~w~Invalid color code entered!~n~Enter a ~r~valid number~w~ (0-%d)!", g_MaxVehicleColors - 1), 2000, 4);
                                ShowMenuForPlayer(pns_menu, playerid);
                                return true ;
                            }

                            GameTextForPlayer(playerid, "~w~Resprayed Car For $100!", 2000, 3);
                            TakePlayerCash ( playerid, 100 ) ;

                            new color = strval(inputtext);

                            Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] = color ;

                            ChangeVehicleColorEx( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID] ,  Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] ) ;

                            PlayerPlaySound(playerid, 1134, 0, 0, 0);

                            mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_color_a = %d, vehicle_color_b = %d WHERE vehicle_sqlid = %d",
                                Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
                            );

                            mysql_tquery(mysql, query);

                            return true ;
                        }
                    }

                    format ( color_list, sizeof color_list, "Please choose a color from the list below:\n\n");
                    for (new colorid; colorid != sizeof g_VehicleColors; colorid++) {
                        format(color_list, sizeof color_list, "%s{%06x}%03d%s", color_list, g_VehicleColors[colorid] >>> 8, colorid, !((colorid + 1) % 16) ? ("\n") : (" "));
                    }

                    format ( color_list, sizeof color_list, "%s\n\n{DEDEDE}Enter the color id you wish to use for the EXTERIOR.", color_list);

                    Dialog_ShowCallback ( playerid, using inline PNS_ColorSelectExt, DIALOG_STYLE_INPUT, "Respray Exterior", color_list, "Respray", "Back" ) ;

                    //SendClientMessage(playerid, COLOR_YELLOW, "PNS:{DEDEDE} The color picker is temporarily disabled. Use /carcolorlist and /carcolor for now." ) ;
                    TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                    PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] = false ;
                }

                case 2: {
                    if ( GetPlayerState ( playerid ) != PLAYER_STATE_DRIVER ) {

                        TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be the driver of a vehicle in order to do this." ) ;
                        return true ;
                    }

                    cost = PNS_BODYKIT_COST;
                    if (IsPlayerInAnyGovFaction(playerid, true)) cost = 0;

                    if ( GetPlayerCash(playerid) < cost )
                    {
                        TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                        format(string, sizeof(string), "~n~~n~~n~~w~No more freebies!~n~You need at least $%d!", cost);
                        GameTextForPlayer(playerid, string, 2000, 4);
                        return true ;
                    }

                    format(string, sizeof(string), "~w~Repaired Bodykit For $%d!", cost);
                    GameTextForPlayer(playerid, string, 2000, 3);
                    TakePlayerCash ( playerid, cost ) ;

                    GetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], health);
                    SOLS_RepairVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]) ;

                    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 0000); //
                    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

                    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ]    = panels ;
                    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ]     = doors ;
                    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ]    = lights ;
                    Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ]     = tires ;

                    // Resetting health back to original value after repairing
                    SOLS_SetVehicleHealth(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], health);
                    Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] = health ;
        
                    PlayerVar [ playerid ] [ E_PLAYER_PNS_MENU_CHOICE ] = 3 ;


                    query[0]=EOS;
                    mysql_format(mysql, query, sizeof ( query ), "UPDATE vehicles SET vehicle_dmg_panels = %d, vehicle_dmg_doors = %d, vehicle_dmg_lights = %d, vehicle_dmg_tires = %d, vehicle_health = '%f', vehicle_pos_x = '%f', vehicle_pos_y = '%f', vehicle_pos_z = '%f', vehicle_pos_a = '%f' WHERE vehicle_sqlid = %d",
                        Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_PANELS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_DOORS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_LIGHTS ] , Vehicle [ veh_enum_id ] [ E_VEHICLE_DMG_TIRES ],
                    
                        Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], 
                        Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], 
                        Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID] 
                    ) ;

                    mysql_tquery ( mysql, query ) ;

                    PlayerPlaySound(playerid, 1134, 0, 0, 0);

                    ShowMenuForPlayer(pns_menu, playerid);
                    return true ;
                }
                case 3: {
                    if ( GetPlayerState ( playerid ) != PLAYER_STATE_DRIVER ) {

                        TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                        SendServerMessage(playerid, COLOR_ERROR, "Pay'n'Spray", "DEDEDE", "You must be the driver of a vehicle in order to do this." ) ;
                        return true ;
                    }

                    cost = PNS_ENGINE_COST;
                    if (IsPlayerInAnyGovFaction(playerid, true)) cost = 0;

                    if ( GetPlayerCash(playerid) < cost ) 
                    {
                        TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                        format(string, sizeof(string), "~n~~n~~n~~w~No more freebies!~n~You need at least $%d!", cost);
                        GameTextForPlayer(playerid, string, 2000, 4);
                        return true ;
                    }

                    format(string, sizeof(string), "~w~Repaired Engine For $%d!", cost);
                    GameTextForPlayer(playerid, string, 2000, 3);
                    TakePlayerCash ( playerid, cost ) ;

                    Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ] = 1000.0;
                    SOLS_SetVehicleHealth(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ]);

                    PlayerVar [ playerid ] [ E_PLAYER_PNS_MENU_CHOICE ] = 4 ;

                    PlayerPlaySound(playerid, 1134, 0, 0, 0);

                    query[0]=EOS;
                    mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_health='%f' WHERE vehicle_sqlid = %d",
                        Vehicle [ veh_enum_id ] [ E_VEHICLE_HEALTH ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]
                    );

                    mysql_tquery(mysql, query);

                    ShowMenuForPlayer(pns_menu, playerid);
                }


                case 4: { // change paintjob

                    switch (GetVehicleModel ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {
                        case 483, 534, 535, 536, 558, 559, 560, 561, 562, 565, 566, 567, 575, 576: {
                            if ( GetPlayerCash(playerid) < 250 ) {

                                TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                                GameTextForPlayer(playerid, "~n~~n~~n~~r~No more freebies!~n~You need at least $250!", 2000, 4);
                                return true ;
                            }


                            inline VehiclePaintJobList(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
                                #pragma unused pidx, dialogidx, inputtextx

                                if ( responsex ) {
                                    GameTextForPlayer(playerid, "~w~Added Paintjob For $250!", 2000, 3);
                                    TakePlayerCash ( playerid, 250 ) ;

                                    Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ] = listitemx ;
                                    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), listitemx);

                                    query[0]=EOS;

                                    mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_paintjob = %d WHERE vehicle_sqlid = %d",
                                        Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]);

                                    mysql_tquery(mysql, query);
                                    
                                    ShowMenuForPlayer(pns_menu, playerid);

                                    return true ;
                                }

                                else if  (! responsex ) {
                                   TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                                   return true ;
                                }
                            }

                            string[0]=EOS;
                            SendClientMessage(playerid, 0xDEDEDEFF, "For a list of paintjobs, go to {DF5547}"SHORT_URL_PAINTJOBS"" ) ;

                            if ( GetVehicleModel ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) == 536 ||  GetVehicleModel ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) == 558 ) {

                                format ( string, sizeof ( string ), "Paintjob 0", string ) ;
                            }

                            else format ( string, sizeof ( string ), "Paintjob 0\nPaintjob 1\nPaintjob 2", string ) ;

                            Dialog_ShowCallback ( playerid, using inline VehiclePaintJobList, DIALOG_STYLE_LIST, "Paintjobs", string, "Select", "Close" );

                        }

                        default: {

                            TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                            GameTextForPlayer(playerid, "~n~~n~~n~~w~This vehicle doesn't have a paintjob!", 2000, 4);
                            return true ;
                        }
                    }

                }
                case 5: { // no paintjob 
                    if ( GetPlayerCash(playerid) < 50 ) {

                        TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
                        GameTextForPlayer(playerid, "~n~~n~~n~~r~No more freebies!~n~You need at least $50!", 2000, 4);
                        return true ;
                    }
                    GameTextForPlayer(playerid, "~w~Removed Paintjob For $50!", 2000, 3);
                    TakePlayerCash ( playerid, 50 ) ;

                    Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ] = 3 ;
                    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 3);

                    query[0]=EOS;

                    mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_paintjob = %d WHERE vehicle_sqlid = %d",
                        Vehicle [ veh_enum_id ] [ E_VEHICLE_PAINTJOB ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]);

                    mysql_tquery(mysql, query);
                    
                    ShowMenuForPlayer(pns_menu, playerid);
                }
            }
        }
    }

    else if ( !  PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ]  ) {

        //HideCBrowser(playerid);
        HideMenuForPlayer(pns_menu, playerid);
    }
  
    return 1;
}

hook OnPlayerExitedMenu(playerid) {
    for ( new i, j =sizeof ( E_PNS_LOCATIONS ); i < j ; i ++ ) {

        // Only do this if they are in a PNS checkpoint!
        if ( IsPlayerInDynamicCP(playerid, E_PNS_CP [ i ] ) ) {

            //HideCBrowser(playerid);
            TogglePlayerControllable(playerid, true); // unfreeze the player when they exit a menu
            PlayerVar [ playerid ] [ E_PLAYER_USING_PNS ] = false ;
        }
    }
    
    return 1;
}