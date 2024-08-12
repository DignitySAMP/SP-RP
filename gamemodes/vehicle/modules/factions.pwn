#if !defined INVALID_FACTION_ID 
	#define INVALID_FACTION_ID 	(-1)
#endif

CMD:m(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerInMedicFaction(playerid, true))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a government faction.");

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	new Float: x, Float: y, Float: z ;
	GetVehiclePos ( vehicleid, x, y, z );

	if ( IsPlayerInRangeOfPoint(playerid, 5, x, y, z ) || GetPlayerVehicleID(playerid) == vehicleid ) {

		if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) {

			return SendClientMessage(playerid, COLOR_ERROR, "You need to be inside a vehicle!");
		}

		if( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION) {

			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {

				new text [ 144 ] ;

				if ( sscanf ( params, "s[144]", text ) ) {

					return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/m(egaphone) [text]" ) ;
				}
				
				new string [ 256 ] ;

				format ( string, sizeof ( string ), ":o< %s ]",  text ) ;
				ProxDetectorEx(playerid,100.0, COLOR_YELLOW, "[ ", string);

				// NEW LOGGING: Log this as a LOG_TYPE_CHAT for sender (playerid)
				AddLogEntry(playerid, LOG_TYPE_CHAT, sprintf("[megaphone]: %s", text));

				return true ;
			}

		}

		return SendClientMessage(playerid, COLOR_ERROR, "The vehicle you're near doesn't have a megaphone!");
	}
  	return SendClientMessage(playerid, COLOR_ERROR, "You're not near or in a vehicle.");
}


CMD:megaphone(playerid, params[]) {

	return cmd_m(playerid, params);
}


CMD:ftow(playerid, params[]) {
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 2 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}


	Faction_SendMessage(factionid, sprintf("{ [%s] All faction vehicles will respawn in 15 seconds. Action by: %s }",
		
		Faction_GetAbbreviationByID (faction_enum_id), ReturnMixedName ( playerid )
	), faction_enum_id, false ) ;

	defer Faction_RespawnCars(playerid, factionid, faction_enum_id);

	return true ;
}

timer Faction_RespawnCars[15000](playerid, factionid, factionenum) {

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {

		if ( IsValidVehicle ( Vehicle [ i ] [ E_VEHICLE_ID ] ) && GetVehicleDriver ( Vehicle [ i ] [ E_VEHICLE_ID ]  ) == INVALID_PLAYER_ID  ) {

			if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION && Vehicle [ i ] [ E_VEHICLE_OWNER ] == factionid ) {

						
				if ( IsValidDynamic3DTextLabel( Vehicle [ i ] [ E_VEHICLE_LABEL ] ) ) {

					DestroyDynamic3DTextLabel( Vehicle [ i ] [ E_VEHICLE_LABEL ] ) ;
				}

				SOLS_SetVehicleToRespawn(Vehicle [ i ] [ E_VEHICLE_ID ], "/ftow") ;
				ChangeVehicleColorEx(Vehicle [ i ] [ E_VEHICLE_ID ], Vehicle [ i ] [ E_VEHICLE_COLOR_A ], Vehicle [ i ] [ E_VEHICLE_COLOR_B ]);

				Vehicle [ i ] [ E_VEHICLE_FUEL ] = 100 ;
			}

			else continue ;
		}

		else continue ;
	}

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has respawned all faction vehicles. }",

		Faction_GetAbbreviationByID (factionenum), ReturnMixedName ( playerid )
	), factionenum, false ) ;

	return true ;
}

CMD:fvehicles(playerid, params[]) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	SendClientMessage(playerid, COLOR_BLUE, sprintf("[%s] %s's faction vehicles:",
		Faction_GetAbbreviationByID (faction_enum_id), Faction_GetNameByID(faction_enum_id) )) ;

	for ( new i, j = sizeof ( Vehicle ); i < j; i ++ ) {

		if ( IsValidVehicle ( Vehicle [ i ] [ E_VEHICLE_ID ] ) ) {

			if ( Vehicle [ i ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION && Vehicle [ i ] [ E_VEHICLE_OWNER ] == factionid ) {

				if ( GetVehicleDriver (Vehicle [ i ] [ E_VEHICLE_ID ] ) == INVALID_PLAYER_ID ) {
					SendClientMessage(playerid, COLOR_INFO, sprintf("[%s] [VID: %d] [MODID: %d] [UNOCCUPIED]",
						ReturnVehicleName ( Vehicle [ i ] [ E_VEHICLE_ID ] ), Vehicle [ i ] [ E_VEHICLE_ID ],  GetVehicleModel ( Vehicle [ i ] [ E_VEHICLE_ID ] )));
				}

				else SendClientMessage(playerid, COLOR_ERROR, sprintf("[%s] [VID: %d] [MODID: %d] [OCCUPIED]",
						ReturnVehicleName ( Vehicle [ i ] [ E_VEHICLE_ID ] ), Vehicle [ i ] [ E_VEHICLE_ID ],  GetVehicleModel ( Vehicle [ i ] [ E_VEHICLE_ID ] )));
			}

			else continue ;
		}

		else continue ;
	}

	return true ;
}

CMD:fcars(playerid, params[]) {

	return cmd_fvehicles(playerid, params);
}

CMD:fveh(playerid, params[]) {
	
	return cmd_fvehicles(playerid, params);
}
CMD:fvehs(playerid, params[]) {
	
	return cmd_fvehicles(playerid, params);
}

CMD:fcarcolor(playerid, params[]) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	new color_a, color_b ;

	if ( sscanf ( params, "ii", color_a, color_b ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/fcarcolor [color-a] [color-b]");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {

			ChangeVehicleColorEx(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], color_a, color_b);

			Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ] = color_a ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ] = color_b ;

			Faction_SendMessage(factionid, sprintf("{ [%s] %s has changed the faction's [%d] %s's car colors to %d and %d. }",

				Faction_GetAbbreviationByID (faction_enum_id), ReturnMixedName ( playerid ),
				Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], ReturnVehicleName ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ), color_a, color_b
			), faction_enum_id, false ) ;


			new query [ 512 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_color_a = %d, vehicle_color_b = %d  WHERE vehicle_sqlid = %d",
				Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]) ;

			mysql_tquery(mysql, query);
		}
	}

	return true ;
}

CMD:fpark(playerid, params[]) {

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 1 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	if ( vehicleid == INVALID_VEHICLE_ID || !vehicleid ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] == E_VEHICLE_TYPE_FACTION) {

		if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {

			new Float: x, Float: y, Float: z, Float: a ;
			GetVehiclePos(vehicleid, x, y, z ) ;
			GetVehicleZAngle(vehicleid, a);

			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ] = x ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ] = y ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] = z ;
			Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ] = a ;

			SOLS_DestroyVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]) ;

			Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = SOLS_CreateVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_A], Vehicle [ veh_enum_id ] [ E_VEHICLE_COLOR_B], 0, false) ;
			Temp_SetVehicleEnumId(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], veh_enum_id);

			SetVehicleNumberPlate(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_LICENSE ] ) ;

			SetEngineStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_ENGINE ]);
			SetDoorStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ]);

			Faction_SendMessage(factionid, sprintf("{ [%s] %s has reparked the faction's [%d] %s. }",

				Faction_GetAbbreviationByID (faction_enum_id), ReturnMixedName ( playerid ),
				Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], ReturnVehicleName ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] )
			), faction_enum_id, false ) ;


			SetVehiclePos(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ] ) ;
			SetVehicleZAngle(vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ]);

			new query [ 512 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE vehicles SET vehicle_pos_x = '%f',vehicle_pos_y = '%f',vehicle_pos_z = '%f',vehicle_pos_a = '%f' WHERE vehicle_sqlid = %d",
				Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_X ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Y ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_Z ], Vehicle [ veh_enum_id ] [ E_VEHICLE_POS_A ], Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ]) ;

			mysql_tquery(mysql, query);

			return true ;
		}
	}	

	SendClientMessage(playerid, COLOR_ERROR, "You do not own this vehicle!");

	return true ;
}



CMD:breakincar(playerid, params[]) {
  	
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new vehicleid = Vehicle_GetClosestEntity(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any proper vehicle! (couldn't fetch ID)");
	}

	SendClientMessage(playerid, COLOR_YELLOW, "Warning: you /MUST/ roleplay breaking into the car! This action is logged and watched!" ) ;
	SendClientMessage(playerid, COLOR_YELLOW, "If you do not roleplay properly, you /WILL/ be banned for powergaming AND dismissed from PD!" ) ;

	if (GetDoorStatus ( vehicleid ) ) {
		PlayerPlaySound(playerid, 24600, 0, 0, 0);
   
		ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("breaks into the %s, unlocking the door.", ReturnVehicleName ( vehicleid )));
		
		Vehicle [ veh_enum_id ] [ E_VEHICLE_DOORS ] = false ;
		SetDoorStatus ( vehicleid, false );

	    SendAdminMessage ( sprintf("[ANTICHEAT] ** %s used the /breakincar command to unlock the (%d) %s .", 
    		ReturnMixedName(playerid), vehicleid, ReturnVehicleName ( vehicleid )), COLOR_ANTICHEAT);

		// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Used /breakincar on a %s (SQL ID: %d)", ReturnVehicleName(vehicleid), Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));
	}

	else {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This door is already unlocked. No need to smash it.");
	}

	return true ;
}
