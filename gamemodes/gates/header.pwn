#if !defined GATE_RESET_TIME
	#define GATE_RESET_TIME 15000 // ms
#endif

#if !defined SERVER_TOLL_FEE 
	#define SERVER_TOLL_FEE	( 150 )
#endif

#include "gates/data.pwn"
#include "gates/func.pwn"
#include "gates/cmds.pwn"
#include "gates/tolls.pwn"


// ############################################################# //

CMD:gatedelete(playerid, params[]) {

	new gateid ;

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	if ( sscanf ( params, "i", gateid ) ) {

		return SendClientMessage(playerid, -1, "/gatedelete [gateid]");
	}

	if ( gateid > MAX_GATES ) {

		return SendClientMessage(playerid, -1, "Gate ID you entered is invalid." ) ;
	}	

	if ( Gate [ gateid ] [ E_GATE_SQLID ] == INVALID_GATE_ID ) {

		return SendClientMessage(playerid, -1, "Gate ID you entered is invalid." ) ;
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "DELETE FROM gates WHERE gate_sqlid = %d", Gate [ gateid ] [ E_GATE_SQLID ] ) ;
	mysql_tquery(mysql, query );

	if ( IsValidDynamicObject( Gate [ gateid ] [ E_GATE_OBJECTID ] ) ) {

		SOLS_DestroyObject(Gate [ gateid ] [ E_GATE_OBJECTID ], "Gate/CMD_GateDelete", true ) ;
	}

	SendClientMessage(playerid, -1, sprintf("You've deleted gate SQL ID %d.", Gate [ gateid ] [ E_GATE_SQLID ] ) ) ;
	
	Gate [ gateid ] [ E_GATE_SQLID ] = INVALID_GATE_ID ;

	Gate [ gateid ] [ E_GATE_CLOSED_POS_X ] = 0.0 ;
	Gate [ gateid ] [ E_GATE_CLOSED_POS_Y ] = 0.0 ;  
	Gate [ gateid ] [ E_GATE_CLOSED_POS_Z ] = 0.0 ;

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Deleted gate SQL ID %d's speed to  %.3f.", Gate [ gateid ] [ E_GATE_SQLID ] ));

	return true ;
}

CMD:gatespeed(playerid, params[]) 
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new gateid,Float: speed ;

	if ( sscanf ( params, "if", gateid, speed ) ) {

		return SendClientMessage(playerid, -1, "/gatespeed [gateid] [speed (in miliseconds, i.e. \"0.75\")]");
	}

	if ( gateid > MAX_GATES ) {

		return SendClientMessage(playerid, -1, "Gate ID you entered is invalid." ) ;
	}	

	if ( Gate [ gateid ] [ E_GATE_SQLID ] == INVALID_GATE_ID ) {

		return SendClientMessage(playerid, -1, "Gate ID you entered is invalid." ) ;
	}

	Gate [ gateid ] [ E_GATE_SPEED ] = speed ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE gates SET gate_speed = '%f' WHERE gate_sqlid = %d",

		speed, Gate [ gateid ] [ E_GATE_SQLID ] ) ;

	mysql_tquery(mysql, query );

	SendClientMessage(playerid, -1, sprintf("Updated gate ID %d's speed to %.3f.", gateid, Gate [ gateid ] [ E_GATE_SPEED ] ) ) ;
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Updated gate %d's speed to  %.3f.", gateid, Gate [ gateid ] [ E_GATE_SPEED ] ));
	return true ;
}


// ############################################################# //

CMD:door(playerid, params[]) {

	return cmd_gate(playerid, params);
}

CMD:toll(playerid, params[]) {

	return cmd_gate(playerid, params);
}


CMD:gate(playerid, params[]) {
	
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new gate_enum_id = Gate_GetClosestEntity(playerid) ;

	if ( gate_enum_id == INVALID_GATE_ID ) {

		return true ;
	}

	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_GENERAL && PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

		SendClientMessage(playerid, COLOR_YELLOW, sprintf("[GATE] Gate ID %d (SQL: %d). Type: %s. Owned by ID %d.",
			gate_enum_id,Gate [ gate_enum_id ] [ E_GATE_SQLID ], Gate_GetType(gate_enum_id), Gate [ gate_enum_id ] [ E_GATE_OWNER ] )) ;
	}

	if ( ! IsValidDynamicObject( Gate [ gate_enum_id ] [ E_GATE_OBJECTID] )) {

		return SendClientMessage(playerid, -1, "This gate isn't set up properly (no object)");
	}

	if (IsDynamicObjectMoving(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ]))
	{
		return SendClientMessage(playerid, -1, "Wait for the gate to finish moving first.");
	}

	// New gate access code by Spooks, supports properties now too.
	new bool:access = true;
	switch ( Gate [ gate_enum_id ] [ E_GATE_TYPE ] ) 
	{
		case E_GATE_TYPE_INVALID: return SendClientMessage(playerid, -1, "This gate isn't set up. Contact an admin.");
		case E_GATE_TYPE_PROPERTY:
		{
			if (!Gate[gate_enum_id][E_GATE_OWNER]) return SendClientMessage(playerid, -1, "This gate isn't assigned to a property. Contact an admin.");
			else if (Character[playerid][E_CHARACTER_RENTEDHOUSE]) access = Gate[gate_enum_id][E_GATE_OWNER] && Character[playerid][E_CHARACTER_RENTEDHOUSE] == Gate[gate_enum_id][E_GATE_OWNER];

			if (!access)
			{
				foreach(new i: Properties)
				{
					if (Gate[gate_enum_id][E_GATE_OWNER] == Property[i][E_PROPERTY_ID])
					{
						access = Property[i][E_PROPERTY_OWNER] == Character[playerid][E_CHARACTER_ID];
						break;
					}
				}
			}
		} 
		case E_GATE_TYPE_PLAYER: access = Character[playerid][E_CHARACTER_ID] == Gate[gate_enum_id][E_GATE_OWNER];
		case E_GATE_TYPE_FACTION:
		{
			if (!Gate[gate_enum_id][E_GATE_OWNER]) return SendClientMessage(playerid, -1, "This gate isn't assigned to a faction. Contact an admin.");

			access = Character[playerid][E_CHARACTER_FACTIONID] == Gate[gate_enum_id][E_GATE_OWNER];

			if (access && GetPlayerFactionSuspension(playerid) != 0) access = false;
		}
	}

	if (!access)
	{
		if (GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR && PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) SendClientMessage(playerid, COLOR_YELLOW, "You're using your admin powers to open this gate." );
		else if (GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR) return SendClientMessage(playerid, -1, "You don't have normal access to this gate, but can go on admin duty to open it.");
		else return SendClientMessage(playerid, -1, "You don't have access to this gate.");
	}	

	if ( Gate [ gate_enum_id ] [ E_GATE_TOLL ]) 
	{

		if ( ! IsPlayerInAnyVehicle(playerid)) {
			return SendClientMessage(playerid, COLOR_RED, "Trying to avoid the toll tax? Nice try! This command only works INSIDE a car!" ) ;
		}

		if ( GetPlayerCash ( playerid) < SERVER_TOLL_FEE ) {

			SendClientMessage(playerid, COLOR_RED, sprintf("You need at least $%s to operate the tolls.", IntegerWithDelimiter(SERVER_TOLL_FEE ) ) ) ;
			return true ;
		}

		if ( Server [ E_SERVER_TOLLS_LOCKED ] ) {

			return SendClientMessage(playerid, -1, "The tolls are currently closed by the LSPD. If they remain closed after extended duration, call 311 or an admin.");
		}

		if  (  Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {

			return SendClientMessage(playerid, COLOR_RED, "This toll gate is already opened!" ) ;
		}

		new toll_fee = GetMaxStorageModel(GetVehicleModel( GetPlayerVehicleID(playerid) )) * 10;

		TakePlayerCash ( playerid, toll_fee ) ;

		if  ( ! Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {
			SendClientMessage(playerid, COLOR_INFO, sprintf("The toll gate will shut automatically after 15 seconds. You've been charged $%s transportation tax.", IntegerWithDelimiter(toll_fee )));
			defer Gate_ResetState(gate_enum_id);
		}
	}

	else if ( ! Gate [ gate_enum_id ] [ E_GATE_TOLL ]) {

		if ( Gate [ gate_enum_id ] [ E_GATE_AUTOCLOSE] ) {

			if  ( ! Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {
				SendClientMessage(playerid, COLOR_INFO, "The gate will shut automatically after 15 seconds. Don't get stuck!");
				defer Gate_ResetState(gate_enum_id);
			}
		}
	}


	new movetime ;

	if ( Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {

		movetime = MoveDynamicObject(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ] + 0.001, Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ] + 0.001, 
			Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ], Gate [ gate_enum_id ] [ E_GATE_SPEED ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], 
			Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ] ) ;

		if ( PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

			SendClientMessage(playerid, COLOR_YELLOW, sprintf("[GATE] Gate ID %d (SQL: %d) closed in %d milliseconds.", gate_enum_id,Gate [ gate_enum_id ] [ E_GATE_SQLID ],  movetime )) ;
		}

		Gate [ gate_enum_id ] [ E_GATE_STATE ] = false ;
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Has closed gate %d", gate_enum_id));
						
	}
	else if ( ! Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {

		if ( Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_X ] == 0.0 || Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Y ] == 0.0 || Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Z ] == 0.0 ) {

			return SendClientMessage(playerid, -1, "Gate open positions aren't set up. Get an admin to set them up before doing this command.");
		}
		
		movetime = MoveDynamicObject(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_X ] + 0.001, Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Y ] + 0.001, 
			Gate [ gate_enum_id ] [ E_GATE_OPEN_POS_Z ], Gate [ gate_enum_id ] [ E_GATE_SPEED ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Y ], 
			Gate [ gate_enum_id ] [ E_GATE_OPEN_ROT_Z ] ) ;


		if ( PlayerVar[playerid][E_PLAYER_ADMIN_DUTY] ) {

			SendClientMessage(playerid, COLOR_YELLOW, sprintf("[GATE] Gate ID %d (SQL: %d) opened in %d milliseconds.", gate_enum_id,Gate [ gate_enum_id ] [ E_GATE_SQLID ],  movetime )) ;
		}

		Gate [ gate_enum_id ] [ E_GATE_STATE ] = true ;
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Has opened gate %d", gate_enum_id));
	}

	return true ;
}


timer Gate_ResetState[GATE_RESET_TIME](gate_enum_id) {

	if ( Gate [ gate_enum_id ] [ E_GATE_STATE ] ) {

		//SetDynamicObjectPos( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ] );
		//SOLS_SetObjectRot ( Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ], "Gate/ResetState", true) ; 
	
		MoveDynamicObject(Gate [ gate_enum_id ] [ E_GATE_OBJECTID ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_X ] + 0.001, Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Y ] + 0.001, 
		Gate [ gate_enum_id ] [ E_GATE_CLOSED_POS_Z ], Gate [ gate_enum_id ] [ E_GATE_SPEED ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_X ], Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Y ], 
		Gate [ gate_enum_id ] [ E_GATE_CLOSED_ROT_Z ] ) ;

		Gate [ gate_enum_id ] [ E_GATE_STATE ] = false ;
	}

	return true ;
}