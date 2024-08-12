#if !defined INVALID_CONTRACT_ID
	#define INVALID_CONTRACT_ID	(-1 )
#endif


enum E_CONTRACT_DATA {

	E_CONTRACT_SQLID,
	E_CONTRACT_STATUS,

	E_CONTRACT_HIRER,
	E_CONTRACT_VICTIM [ MAX_PLAYER_NAME ],

	E_CONTRACT_FEE
} ;

#if !defined MAX_CONTRACTS 
	#define MAX_CONTRACTS	75
#endif

new Contract [ MAX_CONTRACTS ] [ E_CONTRACT_DATA ] ;

enum {

	E_CONTRACT_STATUS_PENDING,
	E_CONTRACT_STATUS_APPROVED
} ;

Contract_GetStatus(idx, status[], len = sizeof ( status ) ) {

	if ( idx < 0 || idx > sizeof ( Contract ) ) {

		format ( status, len, "Invalid" ) ;
	}

	switch ( Contract [ idx ] [ E_CONTRACT_STATUS ] ) {

		case E_CONTRACT_STATUS_PENDING: {

			format ( status, len, "Pending") ;
		}
		case E_CONTRACT_STATUS_APPROVED: {

			format ( status, len, "In Progress") ;
		}
	}

	return true ;
}


Contract_GetFreeEntity() {
	for ( new i, j = sizeof ( Contract ); i < j ; i ++ ) {

		if ( Contract [ i ] [ E_CONTRACT_SQLID ] == INVALID_CONTRACT_ID ) {

			return i ;
		}
	}

	return INVALID_CONTRACT_ID ;
}

Hitman_LoadEntities() {
	for ( new i, j = sizeof ( Contract ); i < j ; i ++ ) {

		Contract [ i ] [ E_CONTRACT_SQLID ] = INVALID_CONTRACT_ID ;
	}

	print(" * [CONTRACTS] Loading all contracts...");

	inline Contract_OnDataLoad() {
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "contract_sqlid", Contract [ i ] [ E_CONTRACT_SQLID ]);
			cache_get_value_name_int(i, "contract_status", Contract [ i ] [ E_CONTRACT_STATUS ]);
			cache_get_value_name_int(i, "contract_hirer", Contract [ i ] [ E_CONTRACT_HIRER ]);
			cache_get_value_name_int(i, "contract_fee", Contract [ i ] [ E_CONTRACT_FEE ]);

			cache_get_value_name(i, "contract_victim", Contract [ i ] [ E_CONTRACT_VICTIM ]);
		}

		printf(" * [CONTRACTS] Loaded %d contracts.", cache_num_rows() ) ;
	}

	MySQL_TQueryInline(mysql, using inline Contract_OnDataLoad, "SELECT * FROM contracts", "" ) ;

	return true ;
}

Contract_StoreNewData(playerid, number) {

	new idx = Contract_GetFreeEntity();

	if ( idx == INVALID_CONTRACT_ID ) {

		return SendClientMessage(playerid, COLOR_YELLOW, "Couldn't process your V-ROCK HOTEL request because they are too busy!" ) ;
	}
	 
	Contract [ idx ] [ E_CONTRACT_STATUS ] = 0 ;
	Contract [ idx ] [ E_CONTRACT_HIRER ] = number ;

	format ( Contract [ idx ] [ E_CONTRACT_VICTIM ], MAX_PLAYER_NAME, "None" ) ;
	Contract [ idx ] [ E_CONTRACT_FEE ] = 0 ;


	new string [ 512 ] ; 

	mysql_format ( mysql, string, sizeof ( string ), "INSERT INTO contracts(contract_status, contract_hirer, contract_victim, contract_fee) VALUES (%d, %d, '%e', %d)",
		Contract [ idx ] [ E_CONTRACT_STATUS ], Contract [ idx ] [ E_CONTRACT_HIRER ], Contract [ idx ] [ E_CONTRACT_VICTIM ], Contract [ idx ] [ E_CONTRACT_FEE ]
	) ; 

	inline Contract_OnDatabaseInsert() {

		Contract [ idx ] [ E_CONTRACT_SQLID ] = cache_insert_id ();

		printf(" * [CONTRACT] Stored contract (%d) with ID %d.", 
			idx, Contract [ idx ] [ E_CONTRACT_SQLID ] ) ;
	}

	MySQL_TQueryInline(mysql, string, using inline Contract_OnDatabaseInsert, "");

	format ( string, sizeof ( string ), "{[ [HITMAN] A new contract with ID %d has been posted by caller %d. ]}", 
		idx, Contract [ idx ] [ E_CONTRACT_HIRER ]
	) ;

	SendHitmanMessage ( string ) ;

	return true ;
}

CMD:contracts(playerid, params[]) {

	if ( ! IsPlayerHitman ( playerid ) ) {

		return false ;
	}

	new string [ 256 ], status [ 24 ] ;

	format ( string, sizeof ( string ), "ID\tHirer\tStatus\n" ) ;

	inline Hitman_ViewContracts(pid, dialogid, response, listitem, string:inputtext[]) {
    	#pragma unused pid, dialogid, listitem, inputtext

    	if (response) {

    		new selection = listitem ;

    		format ( string, sizeof ( string ), "[SQL ID: %d] [Contract By: %d ((phone number))] ", 
    			Contract [ selection ] [ E_CONTRACT_SQLID ],Contract [ selection ] [ E_CONTRACT_HIRER ]
    		) ;

    		SendClientMessage(playerid, COLOR_YELLOW, string);


			Contract_GetStatus ( selection, status, sizeof ( status ) ) ;

			string[0]=EOS;
    		format ( string, sizeof ( string ), "[Contract Target: %s ((IC description))] [Reward: $%s] [Status: %s]",
    			 Contract [ selection ] [ E_CONTRACT_VICTIM ] , IntegerWithDelimiter(Contract [ selection] [ E_CONTRACT_FEE ]), status
    		) ;

    		SendClientMessage(playerid, COLOR_YELLOW, string);
    	}
	}

	new count = 0 ;

	for ( new i, j = sizeof ( Contract ); i < j ; i ++ ) {

		if ( Contract [ i ] [ E_CONTRACT_SQLID ] == INVALID_CONTRACT_ID ) {

			continue ;
		}

		else {
			Contract_GetStatus ( i, status, sizeof ( status ) ) ;

			format ( string, sizeof ( string ), "%s%d \t %d \t %s\n", string, 
				i, Contract [ i ] [ E_CONTRACT_HIRER ], status
			) ;

			count ++ ;
		}
	}

	if ( count ) {
		Dialog_ShowCallback ( playerid, using inline Hitman_ViewContracts, DIALOG_STYLE_TABLIST_HEADERS, "Contracts", string, "Okay", "Cancel" );
	}

	else SendClientMessage(playerid, COLOR_YELLOW, "There are no contracts.");

	return true ;
}


CMD:contractupdate(playerid, params[]) {

	new idx, victim [ MAX_PLAYER_NAME ] ;

	if ( sscanf  (params, "is[24]", idx, victim ) ) {

		SendClientMessage(playerid, COLOR_YELLOW, "/contractupdate [id: /contracts] [name-of-victim] ((IC description))" ) ;
	
		SendClientMessage(playerid, COLOR_ERROR, "Only do this once the contract has been approved by the hirer!");
		return true; 
	}

	if ( Contract [ idx ] [ E_CONTRACT_SQLID ] == INVALID_CONTRACT_ID ) {
		return SendClientMessage(playerid, COLOR_ERROR, "The contract ID you entered doesn't exist." ) ;
	}

	format ( Contract [ idx ] [ E_CONTRACT_VICTIM ], MAX_PLAYER_NAME, "%s", victim ) ;

	new string [ 256 ] ;


	// Update contract data
	mysql_format ( mysql, string, sizeof ( string ), "UPDATE contracts SET contract_victim = '%e' contract_sqlid = %d",
		Contract [ idx ] [ E_CONTRACT_VICTIM ], Contract [ idx ] [ E_CONTRACT_SQLID ]
	) ; 

	mysql_tquery(mysql, string);

	format ( string, sizeof ( string ), "{[ [HITMAN] %s has been updated the victim of contract ID %d (%s). ]}", 
		ReturnMixedName(playerid), idx, victim
	) ;

	SendHitmanMessage ( string ) ;

	return true ;
}

CMD:contractdelete(playerid, params[]) {

	new idx ;

	if ( sscanf  (params, "i", idx ) ) {

		SendClientMessage(playerid, COLOR_YELLOW, "/contractdelete [id: /contracts]" ) ;

		return true; 
	}

	if ( Contract [ idx ] [ E_CONTRACT_SQLID ] == INVALID_CONTRACT_ID ) {
		return SendClientMessage(playerid, COLOR_ERROR, "The contract ID you entered doesn't exist." ) ;
	}

	new string [ 256 ] ;

	// Clear contract data
	mysql_format ( mysql, string, sizeof ( string ), "DELETE FROM contracts WHERE contract_sqlid = %d",
		 Contract [ idx ] [ E_CONTRACT_SQLID ]
	) ; 

	mysql_tquery(mysql, string);

	Contract [ idx ] [ E_CONTRACT_SQLID ] = -1 ;
	Contract [ idx ] [ E_CONTRACT_HIRER ] = 0 ;
	Contract [ idx ] [ E_CONTRACT_STATUS ] = 0 ;
	Contract [ idx ] [ E_CONTRACT_FEE ] = 0 ;

	format ( string, sizeof ( string ), "{[ [HITMAN] %s has deleted contract ID %d. ]}", 
		ReturnMixedName(playerid), idx
	) ;

	SendHitmanMessage ( string ) ;

	return true ;
}

CMD:contractoffer(playerid, params[]) {

	new idx, targetid, fee, string [ 256 ] ;

	if ( sscanf ( params, "iui", idx, targetid, fee ) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "/contractofficer [id: /contracts] [targetid/partOfName] [price]" ) ;
	}

	if ( fee < 25000 ) {
		return SendClientMessage(playerid, COLOR_ERROR, "Fee can't be less than $25.000" ) ;
	}

	if ( ! IsPlayerConnected(targetid)) {
		return SendClientMessage(playerid, COLOR_ERROR, "Targetid isn't connected." ) ;
	}

	if ( Contract [ idx ] [ E_CONTRACT_SQLID ] == INVALID_CONTRACT_ID ) {
		return SendClientMessage(playerid, COLOR_ERROR, "The contract ID you entered doesn't exist." ) ;
	}

	if ( GetPlayerCash ( targetid ) < fee ) {
		return SendClientMessage(playerid, COLOR_ERROR, "Target doesn't have enough money. RP asking him for the money!" ) ;
	}

	if ( strlen ( Contract [ idx ] [ E_CONTRACT_VICTIM ] ) < 3 ) {

		return SendClientMessage(playerid, COLOR_ERROR, "UPDATE the victim first (get this info RPly)! Use /contractupdate." ) ;
	}

	if ( Character [ targetid ] [ E_CHARACTER_PHONE_NUMBER ] != Contract [ idx ] [ E_CONTRACT_HIRER ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "This person is not the right contractor! Cease contact IMMEDIATELY." ) ;
	}

	if ( Contract [ idx ] [ E_CONTRACT_STATUS ] == E_CONTRACT_STATUS_APPROVED ) {
		return SendClientMessage(playerid, COLOR_ERROR, "This contract is already approved and in motion." ) ;
	}

	if ( !IsPlayerNearPlayer(playerid, targetid, 5.0 ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not near your target." );
	}

	format ( string, sizeof ( string ), "A hitman has offered you a contract on \"%s\" ((IC Description)) costing $%s. Use /acceptcontract.", 
		Contract [ idx ] [ E_CONTRACT_VICTIM ], IntegerWithDelimiter ( fee )  ) ;
	SendServerMessage ( targetid, COLOUR_HITMAN, "Hitman", "DEDEDE", string );

	PlayerVar [ targetid ] [ E_HITMAN_CONTRACT_OFFERED ] = idx ;
	PlayerVar [ targetid ] [ E_HITMAN_CONTRACT_COST ] = fee ;

	SendClientMessage(playerid, COLOR_YELLOW, "You offered the contract." ) ;

	return true ;
}

CMD:acceptcontract(playerid, params[]) {

	new contract_id = PlayerVar [ playerid ] [ E_HITMAN_CONTRACT_OFFERED ] ;

	if ( Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] != Contract [ contract_id ] [ E_CONTRACT_HIRER ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You don't have a pending contract." ) ;
	}

	if ( GetPlayerCash ( playerid ) < PlayerVar [ playerid ] [ E_HITMAN_CONTRACT_COST ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You don't have enough money for the hitman contract." ) ;
	}

	TakePlayerCash ( playerid, PlayerVar [ playerid ] [ E_HITMAN_CONTRACT_COST ] ) ;

	Contract [ contract_id ] [ E_CONTRACT_STATUS ] = E_CONTRACT_STATUS_APPROVED ;
	Contract [ contract_id ] [ E_CONTRACT_FEE ] = PlayerVar [ playerid ] [ E_HITMAN_CONTRACT_COST ] ;

	new string [ 256 ] ;

	// Update contract data
	mysql_format ( mysql, string, sizeof ( string ), "UPDATE contracts SET contract_status = %d, contract_fee = %d contract_sqlid = %d",
		Contract [ contract_id ] [ E_CONTRACT_STATUS ], Contract [ contract_id ] [ E_CONTRACT_FEE ], Contract [ contract_id ] [ E_CONTRACT_SQLID ]
	) ; 

	mysql_tquery(mysql, string);

	PlayerVar [ playerid ] [ E_HITMAN_CONTRACT_OFFERED ] = 0 ;
	PlayerVar [ playerid ] [ E_HITMAN_CONTRACT_COST ] = 0 ;

	SendClientMessage(playerid, COLOR_YELLOW, "You have accepted the contract. The hitman will take care of it." ) ;

	format ( string, sizeof ( string ), "{[ [HITMAN] %s has been made contact with contractor - contract ID %d activated for $%s. ]}", 
		ReturnMixedName(playerid), contract_id, IntegerWithDelimiter ( Contract [ contract_id ] [ E_CONTRACT_FEE ] )
	) ;

	SendHitmanMessage ( string ) ;

	return true ;
}


CMD:marktarget(playerid, params[]) {
	if ( ! IsPlayerHitman ( playerid ) ) {

		return false ;
	}

	new targetid, idx ;

	// Marks target for 2 hour cooldown once kill succeeds by hitman
	if ( sscanf ( params, "k<player>i", targetid, idx ) ) {

		SendClientMessage(playerid, COLOR_YELLOW, "/marktarget [targetid] [contract-id: /contracts] ((will 'disable' their character for 2 hours))");
		SendClientMessage(playerid, COLOR_RED, "This marker does not save. If you fail, you must re-apply it later." ) ;
		return true ;
	}

	if ( !IsPlayerNearPlayer(playerid, targetid, 35.0 ) ) {

	    return SendServerMessage( playerid, COLOR_RED, "Error", "A3A3A3",  "You're not near your target." );
	}

	PlayerVar [ targetid ] [ E_PLAYER_HITMAN_MARKED ] = true ;
	PlayerVar [ targetid ] [ E_PLAYER_HITMAN_CONTRACT ] = idx ;
	PlayerVar [ targetid ] [ E_PLAYER_HITMAN_KILLER ] = Character [ playerid ] [ E_CHARACTER_ID ] ;
	
	new string [ 256 ] ;

	format ( string, sizeof ( string ), "You have marked (%d) %s to be killed for contract ID %d. You must execute them for the reward.",
		targetid, ReturnMixedName(targetid), idx 
	) ;

	SendClientMessage(targetid, COLOUR_HITMAN, "You've got an extremely uncomfortable feeling. You feel as if you're being watched by Death himself." ) ;

	format ( string, sizeof ( string ), "{[ [HITMAN] %s has marked %s as the target for contract %d. ]}", 
		ReturnMixedName(playerid), ReturnMixedName(targetid), idx 
	) ;

	SendHitmanMessage ( string ) ;

	return true ;

}


///contractupdate, /contractoffer, /contractremove
