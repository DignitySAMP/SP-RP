// not accurate but stops bmxes at least
static bool:IsATrunkVehicle(vehicleid)
{
	if (IsAircraft(vehicleid) || IsABoat(vehicleid)) return false;
	if (IsABike(vehicleid)) return false;

	//new model = GetVehicleModel(vehicleid);
	//if (model == 509 || model == 481 || model == 510) return false;

	return true;
}

CMD:cartrunkstore(playerid, params[]) {

	SendClientMessage(playerid, COLOR_ERROR, "Invalid command!{DEDEDE} Did you mean /cartrunkstoregun or /cartrunkstoredrug?" ) ;
	return true ;
}

CMD:cartrunktake(playerid, params[]) {

	SendClientMessage(playerid, COLOR_ERROR, "Invalid command!{DEDEDE} Did you mean /cartrunktakegun or /cartrunktakedrug?" ) ;
	return true ;
}

CMD:cartrunkstoregun(playerid, params[]) {
	if ( ! CanPlayerDoGunCMD(playerid) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command when you're inside a vehicle, or are on temporary cooldown." );
	}


	if ( (IsPlayerInPoliceFaction ( playerid ) || IsPlayerInMedicFaction ( playerid )) && !PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) {
        return SendServerMessage ( playerid, COLOR_ERROR, "Warning", "A3A3A3", "Members of your faction cannot use gun-related commands to avoid abuse." ) ;
    }

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

    if ( ! CanPlayerUseGuns(playerid, 8) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use gun related features yet." ) ;
	}

	new vehicleid, slot ;

	if ( sscanf ( params, "i", slot ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/cartrunkstoregun (/ctsgun) [slot] (0-9)" ) ;
	}

	if ( slot < 0 || slot > 9 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Trunk slot can't be less than 0 or more than 9.");
	}

	if ( ! IsPlayerInAnyVehicle(playerid) ) {

		vehicleid = Vehicle_GetClosestEntity(playerid, 5.0);

		if ( ! GetTrunkStatus ( vehicleid )) {

			SendServerMessage(playerid, COLOR_BLUE, "Trunk", "DEDEDE", "This trunk is closed!");
			return true ;
		}
	}

	else vehicleid = GetPlayerVehicleID(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if (!IsATrunkVehicle(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk.");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	new model_type = Vehicle_GetTypeByModel ( Vehicle [ veh_enum_id ] [ E_VEHICLE_MODELID ] ) ;
	new sols_type = Vehicle_GetSOLSTypeByModel ( model_type ) ;
	new max_slots = Vehicle_GetMaxSlotsPerType ( sols_type ) ;

	if ( slot > max_slots ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("This vehicle has room for %d slots. Can't be less than 0 or more than %d.", max_slots, max_slots));
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Trunk", "DEDEDE", "There's already a weapon in this slot.");
	}

	if ( ! AC_GetPlayerWeapon(playerid) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Weapon", "DEDEDE", "You don't have a weapon equipped.");
	}

	new idx = GetPlayerCustomWeapon(playerid) ;

	if ( idx == -1 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Weapon", "DEDEDE", "There was an error calculating your weapon. (returned -1).");
	}

	//Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ] =  AC_GetPlayerWeapon(playerid) ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ] = idx ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ] =  SOLS_GetPlayerAmmo(playerid) ;

	RemovePlayerCustomWeapon(playerid, idx ) ; // remove the gun

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof(query), 
		"UPDATE vehicles SET vehicle_trunk_wep_%d = %d, vehicle_trunk_ammo_%d = %d where VEHICLE_SQLID = %d", 
			slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ], slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ],
			Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]
	);

	mysql_tquery(mysql, query);

	query [ 0 ] = EOS ;
	Weapon_GetGunName ( idx, query, sizeof ( query ) );

	ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("stores a %s in the %s's trunk", query, ReturnVehicleName ( vehicleid )));

	//NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Stored a %s (%d) (Ammo: %d) in the trunk of a %s (ID: %d, SQL: %d)", query, idx, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ], ReturnVehicleName ( vehicleid ), vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));


	return true ;
}

CMD:ctsgun(playerid, params[]) {

	return cmd_cartrunkstoregun(playerid, params);
}

CMD:cartrunktakegun(playerid, params[]) {
	if ( ! CanPlayerDoGunCMD(playerid) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't do this command when you're inside a vehicle, or are on temporary cooldown." );
	}

	if ( (IsPlayerInPoliceFaction ( playerid ) || IsPlayerInMedicFaction ( playerid )) && !PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) {
        return SendServerMessage ( playerid, COLOR_ERROR, "Warning", "A3A3A3", "Members of your faction cannot use gun-related commands to avoid abuse." ) ;
    }

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    if ( ! CanPlayerUseGuns(playerid, 8) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use gun related features yet." ) ;
	}


	new vehicleid, slot ;

	if ( sscanf ( params, "i", slot ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/cartrunktakegun (/cttgun) [slot] (0-9)" ) ;
	}

	if ( slot < 0 || slot > 9 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "Trunk slot can't be less than 0 or more than 9.");
	}

	if ( ! IsPlayerInAnyVehicle(playerid) ) {

		vehicleid = Vehicle_GetClosestEntity(playerid, 5.0);

		if ( ! GetTrunkStatus ( vehicleid )) {

			SendServerMessage(playerid, COLOR_BLUE, "Trunk", "DEDEDE", "This trunk is closed!");
			return true ;
		}
	}

	else vehicleid = GetPlayerVehicleID(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if (!IsATrunkVehicle(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk.");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Trunk", "DEDEDE", "There isn't a weapon in this slot.");
	}

	new idx = Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ] ;

	//AC_GivePlayerWeapon( playerid, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ], Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ] );
	GiveCustomWeapon(playerid, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ], Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ] ) ;

	new query [ 512 ] ;

	Weapon_GetGunName ( idx, query, sizeof ( query ) );

	ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("takes a %s from the %s's trunk", query, ReturnVehicleName ( vehicleid )));

	//NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Took a %s (%d) (Ammo: %d) from the trunk of a %s (ID: %d, SQL: %d)", query, idx, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ], ReturnVehicleName ( vehicleid ), vehicleid, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]));

    query [ 0 ] = EOS ;

	mysql_format(mysql, query, sizeof(query), 
		"UPDATE vehicles SET vehicle_trunk_wep_%d = 0, vehicle_trunk_ammo_%d = 0 where VEHICLE_SQLID = %d", 
			slot + 1, slot + 1, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID]
	);

	mysql_tquery(mysql, query);

	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ slot ] = 0 ;
	Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ slot ] = 0 ;

	

	return true ;
}

CMD:cttgun(playerid, params[]) {

	return cmd_cartrunktakegun(playerid, params);
}

CMD:cartrunkshow(playerid, params[]) {

	return cmd_cartrunkcheck(playerid, params);
}
CMD:ctcheck(playerid, params[]) {

	return cmd_cartrunkcheck(playerid, params);
}

CMD:cartrunkcheck(playerid,params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    if ( ! CanPlayerUseGuns(playerid, 8) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use gun related features yet." ) ;
	}
	new vehicleid ;

	if ( ! IsPlayerInAnyVehicle(playerid) ) {

		vehicleid = Vehicle_GetClosestEntity(playerid, 5.0 );
	}

	else vehicleid = GetPlayerVehicleID(playerid);

	if ( vehicleid == INVALID_VEHICLE_ID ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any vehicle!");
	}

	if (!IsATrunkVehicle(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't have a trunk.");
	}

	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	new Float: x, Float: y, Float: z ;
	GetPosBehindVehicle ( vehicleid, x, y, z, 2.5 );

	if ( IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z ) ) {

		if ( ! GetTrunkStatus ( vehicleid )) {

			SendServerMessage(playerid, COLOR_BLUE, "Trunk", "DEDEDE", "This trunk is closed!");
			return true ;
		}

		else if ( GetTrunkStatus ( vehicleid ) ) {

			SendClientMessage(playerid, COLOR_BLUE, "Trunk Contents:");

			new gun_name [ 64 ],  string [ 256 ],  drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ], count = 0;

			for ( new i; i < 10; i ++ ) {

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ i ] ) {
			
					Weapon_GetGunName ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ i ], gun_name, sizeof ( gun_name ) );

					format ( string, sizeof ( string ), "Slot %d:{DEDEDE} (id %d) %s, with %d ammo.", i, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_WEP ] [ i ], 
						gun_name, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_AMMO ] [ i ]
						) ;

					SendClientMessage(playerid, COLOR_BLUE, string  ) ;

					count ++ ;
				}
			}

			if ( ! count ) {

				SendClientMessage(playerid, 0xDEDEDEFF, "No guns to show!");
			}

			count = 0 ;

			for ( new i; i < 10; i ++ ) {

				if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ i ] ) {
					Drugs_GetParamName ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ i ], 
						Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_PARAM ] [ i ], drug_name 
					) ;

					Drugs_GetPackageName ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_CONTAINER ] [ i ], package_name ) ;

					Drugs_GetTypeName(Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_TYPE ] [ i ], drug_type ) ;

					format ( string, sizeof ( string ), "Slot %d:{DEDEDE} %.02fgr of %s stored in a %s. {FFFF00}[%s] ",
						i, Vehicle [ veh_enum_id ] [ E_VEHICLE_TRUNK_DRUGS_AMOUNT] [ i ], drug_name, package_name, drug_type
					 ) ;

					SendClientMessage(playerid, COLOR_BLUE, string );

					count ++ ;
				}
			}

			if ( ! count ) {

				SendClientMessage(playerid, 0xDEDEDEFF, "No drugs to show!");
			}
		}
	}

	ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "**", sprintf("checks the trunk of the %s.", ReturnVehicleName ( vehicleid )), .annonated=true);

	return true ;
}