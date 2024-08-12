CMD:modcar(playerid, params[]) {

    return cmd_tunemenu(playerid, params);
}CMD:tune(playerid, params[]) {

    return cmd_tunemenu(playerid, params);
}CMD:modshop(playerid, params[]) {

    return cmd_tunemenu(playerid, params);
}

CMD:tunemenu(playerid, params[]) {

    if ( !IsPlayerInAnyVehicle(playerid)) {

        return SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle Components", "A3A3A3", "You're not in a vehicle.");
    }

    if ( GetPlayerState ( playerid ) != PLAYER_STATE_DRIVER ) {

        return SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle Components", "A3A3A3", "You're not the driver of this vehicle.");
    }

	// New faction /tune check
	new vehicleid = GetPlayerVehicleID(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) 
	{
		return SendClientMessage(playerid, COLOR_ERROR, "You need to be inside a vehicle!");
	}

	new factiontype = GetVehicleFactionType(vehicleid);
	if (factiontype == FACTION_TYPE_POLICE || factiontype == FACTION_TYPE_EMS || factiontype == FACTION_TYPE_NEWS)
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Vehicle Components", "A3A3A3", "You can't tune this faction vehicle.");
	}

    new property_id = IsPlayerNearSpecificProperty(playerid, E_BUY_TYPE_MODSHOP, 5.0) ;

    if ( property_id == INVALID_PROPERTY_ID ) {

        return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You're not near a mod shop.");
    }

    PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = property_id ;

	DisplayTuneMenu(playerid) ;

	return true ;
}

DisplayTuneMenu(playerid) {

 	new 
 		vehicleid = GetPlayerVehicleID(playerid), 
 		modelid = GetVehicleModel( vehicleid),

 		componentid, 
 		component_type_id, 
        component_cost,

    	component_name[MAX_VEHICLE_COMPONENT_NAME], // All names (component, type, ...) names are stored in here
    	dialog_info_string [ 1024 ] 
    ;

    new 
    	// All compatible components will be stored in this array
    	component_array[MAX_VEHICLE_COMPONENTS],

    	// All compatible types will be stored in these arrays
    	bool: component_type_used[MAX_COMPONENT_TYPES], 
    	component_type_array[MAX_COMPONENT_TYPES], 

    	// Components which are "filtered" after selecting type
    	component_index_array [ MAX_VEHICLE_COMPONENTS ], 
    	component_index_count, component_count
    ;

	if (DoesVehicleHaveUpgrades(modelid)) {
        GetVehicleCompatibleUpgrades(modelid, component_array, sizeof(component_array), component_count);
    }

    for (new j; j < component_count; j++) {
        componentid = component_array[j];

        if (IsVehicleUpgradeCompatible(modelid, componentid)) {
        	
            component_type_id = SOLS_GetComponentType(componentid) ;
            component_type_used [ component_type_id ] = true ;
        }
    }

    for ( new i, j = MAX_COMPONENT_TYPES ; i < j ; i ++ ) {

    	if ( component_type_used [ i ] ) {

			SOLS_GetComponentTypeName(i, component_name);
    		format ( dialog_info_string, sizeof ( dialog_info_string ), "%s\n%s", dialog_info_string,  component_name) ;
    		component_type_array [ component_index_count ++ ] = i;
    	}
    }

    component_index_count = 0 ;

	inline ComponentMenuList(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, response, listitem, inputtext

		if ( response ) { // component_type_array[listitem] for component type!

        	dialog_info_string [ 0 ] = EOS;

			inline ComponentMenu(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
				#pragma unused pidx, dialogidx, responsex, listitemx, inputtextx

				if ( ! responsex ) {
					
					return DisplayTuneMenu(playerid) ;
				}

				if ( response ) { // component_index_array [ listitemx] for compatible components (filtered by type)!

        			GetVehicleComponentName(component_index_array [ listitemx], component_name, sizeof(component_name));
                    component_cost = GetVehicleComponentCost(component_index_array [ listitemx]) ;

                    if ( GetPlayerCash(playerid) < component_cost ) {
                        SendServerMessage ( playerid, COLOR_RED, "Vehicle Components", "DEDEDE", sprintf("You don't have enough money, you need at least $%s.", IntegerWithDelimiter(component_cost) )) ;
                        return true ;
                    }

                    TakePlayerCash(playerid, component_cost ) ;
					Property_AddMoneyToTill(playerid, (component_cost/6), .margin=false ) ; 

					SendServerMessage ( playerid, COLOR_VEHICLE, "Vehicle Components", "DEDEDE", sprintf("You've added a \"%s\" modification to your car for $%s.", component_name, IntegerWithDelimiter(component_cost) ) ) ;

					Tune_AddVehicleComponent(playerid, vehicleid, component_index_array [ listitemx]);
				}
			}

		    for (new j; j < component_count; j++) {
		        componentid = component_array[j];

		        if (IsVehicleUpgradeCompatible(modelid, componentid)) {
		            component_type_id = SOLS_GetComponentType(componentid) ;

		            if ( component_type_id == component_type_array[listitem] ) {

            			GetVehicleComponentName(componentid, component_name, sizeof(component_name));
                        component_cost = GetVehicleComponentCost(componentid) ;
    					format ( dialog_info_string, sizeof ( dialog_info_string ), "%s\n%s ($%s)", dialog_info_string,  component_name, IntegerWithDelimiter(component_cost)) ;
    					component_index_array [ component_index_count ++ ] = componentid ;
		            }
		        }
		    }

			Dialog_ShowCallback ( playerid, using inline ComponentMenu, DIALOG_STYLE_LIST, "Title", dialog_info_string, "Select", "Back" ) ;
		}
	}

	Dialog_ShowCallback ( playerid, using inline ComponentMenuList, DIALOG_STYLE_LIST, "Title", dialog_info_string, "Select", "Back" ) ;
 
 	return true ; 
}

