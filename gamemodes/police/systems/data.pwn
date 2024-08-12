CMD:searchplate(playerid, params[]) {
    
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true)  && !IsPlayerGovRecords(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new licenseplate [ 32 ] ;

	if ( sscanf ( params, "s[32]", licenseplate ) ) 
	{
		// New: automatically check for nearby car (that the player isn't in) and use it if no plate is specified
		new Float:x, Float:y, Float:z, playerveh = GetPlayerVehicleID(playerid), world = GetPlayerVirtualWorld(playerid);
		new closest = INVALID_VEHICLE_ID, Float:current, Float:last = 10.0; // 10.0 radius for /searchplate
		
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, 2.0);

		for (new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
		{
			if (!IsValidVehicle(i)) continue;
			if (playerveh == i) continue;
			if (GetVehicleVirtualWorld(i) != world) continue;

			current = GetVehicleDistanceFromPoint(i, x, y, z);

			if (current < last)
			{
				closest = i;
				last = current;
			}
		}

		if (closest == INVALID_VEHICLE_ID) return SendClientMessage(playerid, -1, "/searchplate [number-plate]");
		
		new veh_enum_id = Vehicle_GetEnumID(closest);
		format(licenseplate, sizeof(licenseplate), "%s", Vehicle[veh_enum_id][E_VEHICLE_LICENSE]);
	}

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s ran a vehicle check on \"%s\" }", 
			Faction[faction_enum_id][E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), licenseplate), faction_enum_id, false ) ;

	new query [ 512 ] ;

	mysql_format ( mysql, query, sizeof ( query ), 
		"SELECT `player_name`, `account_name`, `vehicle_type`, `vehicle_modelid`, `vehicle_license`, `vehicle_color_a` FROM `vehicles` JOIN `characters` ON `characters`.`player_id` = `vehicles`.`vehicle_owner` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `vehicle_license` LIKE '%e'", licenseplate ) ;

	SendClientMessage(playerid, COLOR_BLUE, sprintf("Vehicle Database result for '%s':", licenseplate));

	new owner_name [ 96 ] ; 

	inline Vehicle_FetchRegistry() 
	{
		if (!cache_num_rows())
		{
			return SendClientMessage(playerid, 0xDEDEDEFF, "No personal vehicles found for this plate.");
		}

		new veh_model, veh_plate [ 32 ], veh_owner, veh_charname [ MAX_PLAYER_NAME ], veh_accountname [ MAX_PLAYER_NAME ], account_id = -1, veh_color, veh_type;
		#pragma unused veh_owner, account_id

		for (new i = 0, r = cache_num_rows(); i < r; ++i)
		{ 
			cache_get_value_name_int(i, "vehicle_modelid", veh_model);
			cache_get_value_name_int(i, "vehicle_color_a", veh_color);
			cache_get_value_name_int(i, "vehicle_type", veh_type);
			cache_get_value_name( i, "vehicle_license", veh_plate);
			cache_get_value_name( i, "player_name", veh_charname);
			cache_get_value_name( i, "account_name", veh_accountname);

			switch ( veh_type ) {

				case E_VEHICLE_TYPE_RENTAL: format ( owner_name, sizeof ( owner_name), "{90CAF9}Rental {FFFFFF}((Government))" ) ;
				case E_VEHICLE_TYPE_DMV: format ( owner_name, sizeof ( owner_name), "{90CAF9}DMV{FFFFFF}((Government))" ) ;
				case E_VEHICLE_TYPE_FACTION: format ( owner_name, sizeof ( owner_name), "{90CAF9}Organization{FFFFFF}((Faction))" ) ;
				case E_VEHICLE_TYPE_JOB: format ( owner_name, sizeof ( owner_name), "{90CAF9}Business{FFFFFF} ((Job))" ) ;
				case E_VEHICLE_TYPE_FIRM: format ( owner_name, sizeof ( owner_name), "{90CAF9}Business{FFFFFF} ((Firm))" ) ;

				default: format ( owner_name, sizeof ( owner_name ), "{90CAF9}%s {FFFFFF}((%s))", veh_charname, veh_accountname ) ; // player type
			}

			SendClientMessage(playerid, -1, sprintf("> {%s}[%d] {FFFFFF}%s (%s), Owned By: %s", 
				VehicleColoursTableRGBA[veh_color], i+1, ReturnVehicleModelName(veh_model), veh_plate, owner_name) 
			) ;
		}
	}

	MySQL_TQueryInline(mysql, using inline Vehicle_FetchRegistry, query, "");

	return true ;
}

CMD:searchdata(playerid, params[]) {
    
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovRecords(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new rpname [ 32 ] ;

	if ( sscanf ( params, "s[32]", rpname ) ) {

		return SendClientMessage(playerid, -1, "/searchdata [firstname_lastname] (include the underscore!)" ) ;
	}

	new query [ 512 ], display_name[32];

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `player_id`, `player_name`, `player_driverslicense`, `player_gunlicense`, `player_outstanding_fines` FROM `characters` WHERE `player_name` LIKE '%e'", rpname ) ;

	new char_id, dlicense, glicense, veh_plate[32], actual_name[32], veh_model, veh_color, fines_str[32], crimes, gunlicensestr[32], licenses_str[32], crimes_str[32];
	// new fines;

	inline Character_FetchDetails() {
		if (cache_num_rows())
		{
			cache_get_value_name_int(0, "player_id", char_id);
			cache_get_value_name_int(0, "player_driverslicense", dlicense);
			cache_get_value_name_int(0, "player_gunlicense", glicense);
			cache_get_value_name(0, "player_name", actual_name);
			cache_get_value_name(0, "player_name", display_name);
		}

		if (!cache_num_rows() || !char_id)
		{
			//SendClientMessage(playerid, COLOR_BLUE, sprintf("Person Database result for '%s':", rpname ) ) ;
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("No results found for '%s'.", rpname));
		}

		new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
		new faction_enum_id = Faction_GetEnumID( factionid ); 

		strreplace(display_name, "_", " ");

		Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s ran a person check on \"%s\" }", 
			Faction[faction_enum_id][E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), display_name), faction_enum_id, false ) ;

		SendClientMessage(playerid, COLOR_BLUE, sprintf("Person Database result for '%s':", display_name ) ) ;


		mysql_format ( mysql, query, sizeof ( query ), "SELECT `fine_status`, UNIX_TIMESTAMP(`fine_date`) AS `timestamp` FROM `criminalfines` WHERE `fine_player_name` LIKE '%e'", actual_name ) ;

		new total_tickets, unpaid_tickets, expired_tickets, status, timestamp;
		new days = 259200; // 3 days to seconds // if you change this, change it in arrest/crimes too
		new now = gettime(); // current time

		inline Character_FetchTickets() 
		{
			for (new i = 0, r = cache_num_rows(); i < r; ++i)
			{ 
				cache_get_value_name_int(i, "fine_status", status);
				cache_get_value_name_int(i, "timestamp", timestamp);
				
				new due = days - (now - timestamp);
				total_tickets ++ ;

				if (due < 0 && status == 0) expired_tickets ++;
				else if (status == 0) unpaid_tickets ++;
			}

			mysql_format ( mysql, query, sizeof ( query ), "SELECT COUNT(*) AS `crimes` FROM `criminalrecords` WHERE `record_holder` LIKE '%e'", actual_name ) ;

			inline Character_FetchCrimes() 
			{
				cache_get_value_name_int(0, "crimes", crimes);
				format(crimes_str, sizeof(crimes_str), "{A5D6A7}%s", "None");
				if (crimes > 0)
				{
					format(crimes_str, sizeof(crimes_str), "{EF9A9A}%d", crimes);
				}

				format(gunlicensestr, sizeof(gunlicensestr), "{EF9A9A}%s", "None");
				if (glicense > 0)
				{
					new year, month, day, hour, minute, second;
					stamp2datetime(glicense, year, month, day, hour, minute, second, 1 ) ;
					if (glicense < gettime()) format(gunlicensestr, sizeof(gunlicensestr), "{FFCC80}Expired (%02d/%02d/%04d)", day, month, year);
					else format(gunlicensestr, sizeof(gunlicensestr), "{A5D6A7}Valid (%02d/%02d/%04d)", day, month, year);
				}

				format(licenses_str, sizeof(licenses_str), "{EF9A9A}%s", "None");
				if (dlicense)
				{
					format(licenses_str, sizeof(licenses_str), "{A5D6A7}Valid");
				}

				format(fines_str, sizeof(fines_str), "{A5D6A7}%s", "None");
				if (total_tickets > 0 && !unpaid_tickets && !expired_tickets) format(fines_str, sizeof(fines_str), "{A5D6A7}%d (0 Pending)", total_tickets);
				else if (total_tickets > 0 && expired_tickets > 0) format(fines_str, sizeof(fines_str), "{EF9A9A}%d (%d Unpaid)", total_tickets, expired_tickets);
				else if (total_tickets > 0 && unpaid_tickets > 0) format(fines_str, sizeof(fines_str), "{A5D6A7}%d (%d Pending)", total_tickets, unpaid_tickets);

				SendClientMessage(playerid, -1, sprintf("> Name: {90CAF9}%s {FFFFFF}| Drivers: %s {FFFFFF}| Firearms: %s", display_name, licenses_str, gunlicensestr));
				SendClientMessage(playerid, -1, sprintf("> Priors: %s {FFFFFF}| Tickets: %s", crimes_str, fines_str));

				SendClientMessage(playerid, COLOR_BLUE, "Vehicle Database result:");

				mysql_format ( mysql, query, sizeof ( query ), "SELECT `vehicle_modelid`, `vehicle_license`, `vehicle_color_a` FROM `vehicles` WHERE `vehicle_type` = 3 AND `vehicle_owner` = %d", char_id ) ;

				inline Vehicle_FetchOwner() {
					if (cache_num_rows()) {
						for (new i = 0, r = cache_num_rows(); i < r; ++i) { 
							cache_get_value_name_int(i, "vehicle_modelid", veh_model);
							cache_get_value_name_int(i, "vehicle_color_a", veh_color);
							cache_get_value_name( i, "vehicle_license", veh_plate);

							SendClientMessage(playerid, -1, sprintf("> {%s}[%d] {FFFFFF}%s (%s)", 
								VehicleColoursTableRGBA[veh_color], i+1, ReturnVehicleModelName(veh_model), veh_plate ) ) ;
						}
					}
					else
					{
						SendClientMessage(playerid, 0xDEDEDEFF, "No vehicles found.");
					}
				}

				MySQL_TQueryInline(mysql, using inline Vehicle_FetchOwner, query, "");
			}

			MySQL_TQueryInline(mysql, using inline Character_FetchCrimes, query, "");

		}

		MySQL_TQueryInline(mysql, using inline Character_FetchTickets, query, "");

	}

	MySQL_TQueryInline(mysql, using inline Character_FetchDetails, query, "");
	return true ;
}

CMD:searchplayer(playerid, params[]) { return cmd_searchdata(playerid, params); }
CMD:searchname(playerid, params[]) { return cmd_searchdata(playerid, params); }


CMD:searchaddress(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerInMedicFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

    new input[64] ;

    if ( sscanf ( params, "s[64]", input ) ) {
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/searchaddress [address]" ) ;
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "If you know the address number, put it FIRST!" ) ;
    }

	new id = strval(input);

	if (id < 0 || id > MAX_PROPERTIES) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Invalid ID found." ) ;
	}

	if ( id > 0 && id < MAX_PROPERTIES ) {
		if ( Property [ id ] [ E_PROPERTY_ID ] != INVALID_PROPERTY_ID ) {
			new zone[64], area[64];
			GetPlayerAddress(Property[id][E_PROPERTY_EXT_X], Property[id][E_PROPERTY_EXT_Y], zone);
			GetCoords2DZone(Property[id][E_PROPERTY_EXT_X], Property[id][E_PROPERTY_EXT_Y], area, sizeof ( area ));

			SendServerMessage ( playerid, COLOR_REALTY, "Address", "DEDEDE", sprintf("%s, %s {A3A3A3}(ID: %d)", zone, area, id)) ;
			SendServerMessage ( playerid, COLOR_REALTY, "Address", "DEDEDE",  sprintf("Use {A3A3A3}/propertyfind [%d]{DEDEDE} to get a route to this location.", id)) ;

			return true;
		} else {
			SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("Found Property ID %d, but property was invalid. Please try again.", id)) ;
			return true;
		}
	} else {

		new count = 0;

		foreach(new i: Properties) {

			new zone[64], area[64];
			GetPlayerAddress(Property[i][E_PROPERTY_EXT_X], Property[i][E_PROPERTY_EXT_Y], zone);
			GetCoords2DZone(Property[id][E_PROPERTY_EXT_X], Property[id][E_PROPERTY_EXT_Y], area, sizeof ( area ));

			if (strfind(zone, input, true) != -1) {
				count++;

				if(count <= 20) 
					SendServerMessage ( playerid, COLOR_REALTY, "Address", "DEDEDE", sprintf("%s, %s {A3A3A3}(ID: %d)", zone, area, i)) ;

            } else continue;

		}

		if(!count) {
			SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "No properties match your search. Please try again.") ;
		} else {		
			SendServerMessage ( playerid, COLOR_REALTY, "Address", "DEDEDE",  sprintf("Found {A3A3A3}%d{A3A3A3} properties.", count)) ;
			SendServerMessage ( playerid, COLOR_REALTY, "Address", "DEDEDE",  "Use {A3A3A3}/propertyfind [ID]{DEDEDE} to get a route to a property.") ;
		}
		return true;
	}
}

CMD:addressearch(playerid, params[]) { return cmd_searchaddress(playerid, params); }