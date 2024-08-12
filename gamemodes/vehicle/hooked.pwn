Settings_OnVehicleToggleGUI(playerid)
{
	new string [ 256 ] ;
	
	if ( Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] ) {

		//Vehicle_HidePlayerGUI(playerid) ;
		HideVehicleGUI(playerid) ;
		Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] = false ;
		SendClientMessage(playerid, COLOR_INFO, "You've turned off the vehicle GUI." ) ;
	}
 
	else {

		new vehicleid = GetPlayerVehicleID(playerid) ;

		Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] = true ;
		SendClientMessage(playerid, COLOR_INFO, "You've turned on the vehicle GUI." ) ;

		if ( vehicleid && GetPlayerVehicleSeat(playerid) <= 1 ) {

			ShowVehicleGUI(playerid) ;
			//Vehicle_OnPlayerUpdateGUI(playerid, vehicleid);
		}
	}

	string [ 0 ] = EOS ;

	mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_vehicle = %d WHERE player_id = %d",
	Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, string);
}

Vehicle_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float: fY, Float: fZ) {
	#pragma unused fX, fY, fZ

    if(hittype == BULLET_HIT_TYPE_VEHICLE) {

        if(1 <= hitid <= MAX_VEHICLES) {

            new Float:VehHealth, Float:damage = 15.0;
            GetVehicleHealth(hitid, VehHealth);

			new Float:x, Float:y, Float:z;
			GetVehiclePos(hitid, x, y, z);

			new Float: distance = GetPlayerDistanceFromPoint(playerid, x, y, z);
			damage = SP_GetWeaponDamageFromDistance(weaponid, distance);

			new aircraft = IsAircraft(hitid);

			
            switch (weaponid) 
			{
				case 22: damage = damage * 0.75;
                case 24: damage = damage * 2.5;
				case 25: damage = damage * 1.6;
                case 34: damage = damage * 3.33;
				case 38: damage = damage * 10.0;
            }

			new model = GetVehicleModel(hitid);
			if (model == 528) damage = damage * 0.33; // FBI Truck
			else if (model == 601) damage = damage * 0.2; // SWAT Van
			else if (model == 428) damage = damage * 0.2; // Securicar
			else if (model == 432) damage = damage * 0.1; // Rhino
			
			// SendClientMessage(playerid, -1, sprintf("Dist: %.02f, Damage: %.02f", distance, damage));
			
			if (aircraft || VehHealth - damage > 300.0) VehHealth = VehHealth - damage;
			else VehHealth = 300;

			SOLS_SetVehicleHealth(hitid, VehHealth);
			
			if (VehHealth <= 300 && !aircraft)
			{
				SetEngineStatus(hitid, false);
			}
	    }
    }

    return true ;
}

Vehicle_OnPlayerDisconnect(playerid) {
	for(new i, j = sizeof ( Vehicle ); i < j ; i ++ ) {

		if ( Vehicle [ i ] [ E_VEHICLE_IS_SPAWNED ] ) {
			if ( Vehicle [ i ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				if ( IsVehicleOccupied (  Vehicle [ i ] [ E_VEHICLE_ID ] ) ) {

					continue ;
				}

				defer OnPlayerDC_RespawnVehicle(i, Character [ playerid ] [ E_CHARACTER_ID ] ) ;
			}

			else continue ;
		}

		else continue ;
	}
}


timer OnPlayerDC_RespawnVehicle[300000](veh_enum_id, veh_owner_id) {
	#pragma unused veh_enum_id, veh_owner_id

	foreach(new playerid: Player) {
		if ( Character [ playerid ] [ E_CHARACTER_ID ] == veh_owner_id ) {
		// If the owner logs back on, cancel the timer!

			if ( IsPlayerConnected( playerid ) ) {

				SendClientMessage(playerid, COLOR_BLUE, "Your vehicles were about to be despawned but because you logged in again they've been restored.");
				return true ;
			}

			else continue ;
		}
	}

	if ( IsVehicleOccupied ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {

		// The car has a driver in it. We won't despawn it just yet. Wait 10 more minutes!
		defer OnPlayerDC_RespawnVehicle[600000](veh_enum_id, veh_owner_id);
		return true ;
	}

	// We've now checked that the owner is still offline and nobody is in the car. Respawn it!
	Vehicle [ veh_enum_id ] [ E_VEHICLE_IS_SPAWNED ] = false ;
		 
	if ( IsValidVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]  ) ) {

		SOLS_DestroyVehicle( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ;
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] = -1 ;

	return true ;
}
