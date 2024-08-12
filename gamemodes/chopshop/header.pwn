#include "chopshop/dropoff.pwn"
#include "chopshop/owner.pwn"
#include "chopshop/lockpick.pwn"

ChopShop_CheckVehicleRange(playerid) {

	if ( ! IsPlayerInAnyVehicle(playerid) && IsValidVehicle ( PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ]) ) {
		new vehicleid = Vehicle_GetClosestEntity(playerid, 50.0);
		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

		if ( veh_enum_id != -1 ) {

			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] == PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ] ) {

				return true ;
			}
		}

		GameTextForPlayer(playerid, "~r~Mission Failed~n~~w~You're too far away from the chopshop car.", 5000, 6);
	 	PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_PAYOUT ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_CARID ] = INVALID_VEHICLE_ID ;
		PlayerVar [ playerid ] [ E_PLAYER_CHOPSHOP_DROPPOINT ] = -1 ;	
		cmd_nocp(playerid);
	}

	return true ;
}

CMD:chopcar(playerid) {
	
	if (IsPlayerInAnyGovFaction(playerid))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't chop cars as a member of a government faction.");

	if ( ! IsPlayerInRangeOfPoint(playerid, 5.0, CHOPSHOP_X, CHOPSHOP_Y, CHOPSHOP_Z  ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near the chopshop!");
	}
	
	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
	if ( veh_enum_id == -1 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You're not near any proper vehicle! (couldn't fetch ID)");
	}
	if (!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");

	if ( ! IsPlayerInAnyVehicle(playerid))	    
		return SendClientMessage(playerid, COLOR_ERROR, "You must be in a vehicle!");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");

	if ( Character [ playerid ] [ E_CHARACTER_CHOPSHOP_CD ] > gettime () ) {
		return SendClientMessage(playerid, COLOR_ERROR, sprintf("You're on cooldown from doing this command another %d seconds!", Character [ playerid ] [ E_CHARACTER_CHOPSHOP_CD ] - gettime ()));
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {
		return SendClientMessage(playerid, COLOR_ERROR, "You can't chop your own car up, are you an idiot?");
	}

	if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_PLAYER && Vehicle [ veh_enum_id ] [ E_VEHICLE_TYPE ] != E_VEHICLE_TYPE_DEFAULT ) {
		return SendClientMessage(playerid, COLOR_ERROR, "You can only chop player vehicles and default cars, nothing else.");
	}
	
	Character [ playerid ] [ E_CHARACTER_CHOPSHOP_CD ] = gettime() + 1200;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_chopshop_cd = %d WHERE player_id = %d",
		Character [ playerid ] [ E_CHARACTER_CHOPSHOP_CD ], Character [ playerid ] [ E_CHARACTER_ID]
	) ;

	mysql_tquery(mysql, query);

	
	ChopShop_CalculateRandomPoint(playerid, vehicleid);

	return true ;
}

CMD:tempclearchopshopcd(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ))  {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "/tempclearchopshopcd [targetid]") ;
	}

	if ( ! IsPlayerConnected(targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "Target isn't connected!") ;
	}

	Character [ playerid ] [ E_CHARACTER_CHOPSHOP_CD ] = gettime() - 1 ;
	SendClientMessage(playerid, COLOR_YELLOW, sprintf("You've reset (%d) %s's chopshop cooldown. This does NOT save and is for testing purposes only.", 
		playerid, ReturnMixedName(targetid) ) ) ;

	SendClientMessage(targetid, COLOR_YELLOW, sprintf("Developer (%d) %s has reset your chopshop cooldown. This does NOT save and is for testing purposes only.", 
		targetid, ReturnMixedName(playerid) ) ) ;
	
	return true ;
}

CMD:forcechopshop(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	ChopShop_VerifyPointLocation(playerid, .skip_range = true ) ;

	return true ;
}