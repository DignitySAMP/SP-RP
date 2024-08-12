CMD:balance(playerid, params[]) {


	SendClientMessage(playerid, COLOR_YELLOW, 
		sprintf ( "[BANK RECEIPT]: [Bank Account]: $%s", 
			IntegerWithDelimiter ( Character [ playerid ] [ E_CHARACTER_BANKCASH ] ) ) ) ;

	SendClientMessage(playerid, COLOR_YELLOW, 
		sprintf ( "[Savings: $%s ($%s per paycheck)]", 
			IntegerWithDelimiter ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] ), IntegerWithDelimiter( ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] / 700 ) / 2 ) ) ) ;

	return true ;
}

CMD:withdraw(playerid, params[]) {

	new property_id = IsPlayerNearSpecificBuyPoint(playerid, E_BUY_TYPE_BANK) ;

	if ( property_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You're not near a bank till.");
	}

	PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = property_id ;

	new amount ;

	if ( sscanf ( params, "i", amount ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/withdraw [amount]");
	}

	if ( amount <= 0 || amount > Character [ playerid ] [ E_CHARACTER_BANKCASH ] ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You don't have the amount you're trying to withdraw!");
	}

	Character [ playerid ] [ E_CHARACTER_BANKCASH ] -= amount ;
	GivePlayerCash ( playerid, amount) ;

	new price = amount / 100 ; //
	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_bankcash = %d WHERE player_id = %d", 
		Character [ playerid ] [ E_CHARACTER_BANKCASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've withdrawn $%s from your bank account.", IntegerWithDelimiter(amount)));
	SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've got $%s remaining in your deposit box.", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ])));


	SendServerMessage(playerid, COLOR_BLUE, "Bank", "DEDEDE", sprintf("The bank has taken $%s (a small percentile) as service tax.", IntegerWithDelimiter ( price ) ) ) ;
	TakePlayerBankCash(playerid, price);

	Property_AddMoneyToTill(playerid, price, .margin=false ) ; 
	//SendClientMessage(playerid, -1, sprintf("bank generated %d margin", margin));

	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Withdrew $%s from bank (New balance: $%s)", IntegerWithDelimiter(amount), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ])));

	return true ;
}

CMD:deposit(playerid, params[]) {

	new property_id = IsPlayerNearSpecificBuyPoint(playerid, E_BUY_TYPE_BANK) ;

	if ( property_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You're not near a bank till.");
	}

	PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = property_id ;
	
	new amount ;

	if ( sscanf ( params, "i", amount ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/deposit [amount]");
	}

	if ( amount <= 0 || amount > GetPlayerCash(playerid) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You don't have the amount you're trying to deposit!");
	}

	Character [ playerid ] [ E_CHARACTER_BANKCASH ] += amount ;
	TakePlayerCash ( playerid, amount ) ;

	new price = amount / 100 ; //

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_bankcash = %d WHERE player_id = %d", 
		Character [ playerid ] [ E_CHARACTER_BANKCASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've deposited $%s into your bank account.", IntegerWithDelimiter(amount)));
	SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've now got $%s collected in your deposit box.", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ])));

	SendServerMessage(playerid, COLOR_BLUE, "Bank", "DEDEDE", sprintf("The bank has taken $%s (a small percentile) as service tax.", IntegerWithDelimiter ( price ) ) ) ;
	TakePlayerBankCash(playerid, price);

	Property_AddMoneyToTill(playerid, price, .margin=false ) ; 
	//	SendClientMessage(playerid, -1, sprintf("bank generated %d margin", margin));

	// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Deposited $%s into bank (New balance: $%s)", IntegerWithDelimiter(amount), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ])));

	return true ;
}


CMD:savings(playerid, params[]) {

	new property_id = IsPlayerNearSpecificBuyPoint(playerid, E_BUY_TYPE_BANK) ;

	if ( property_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You're not near a bank till.");
	}

	PlayerVar [ playerid ] [ E_PLAYER_BIZ_MENU ] = property_id ;
	
	new amount, choice[64] ;

	if ( sscanf ( params, "s[64]i", choice, amount ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/savings [deposit/withdraw] [amount]");
	}

	if ( amount <= 0  ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You can't enter negative digits Your actions have been logged for abuse!");
	}

	new query [ 256 ] ;
	new price = amount / 150 ; //
	new bool: success = false ;

	if ( ! strcmp ( choice, "deposit", false ) ) {

		if ( amount <= 0 || amount > GetPlayerCash(playerid) ) {

			return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You don't have the amount you're trying to deposit!");
		}

		if ( amount < 150000 || amount > 1500000) {
			return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Can't deposit less than 150.000 or more than 1.500.000!");
		}

		if ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] >= 1500000) {
			return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You can't store more than 1.500.000 in your savings account at once!");
		}

		
		Character [ playerid ] [ E_CHARACTER_SAVINGS ] += amount ;
		TakePlayerCash ( playerid, amount ) ;

		mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_savings = %d WHERE player_id = %d", 
			Character [ playerid ] [ E_CHARACTER_SAVINGS ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, query);

		SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've deposited $%s into your savings account.", IntegerWithDelimiter(amount)));
		SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've now got $%s collected in your savings account.", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_SAVINGS ])));

		// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Deposited $%s into savings (New balance: $%s)", IntegerWithDelimiter(amount), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_SAVINGS ])));
		success=true;
	}
	else if ( ! strcmp ( choice, "withdraw", false ) ) {

		if ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] < amount ) {
			return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You don't have the amount you're trying to withdraw!");
		}

		Character [ playerid ] [ E_CHARACTER_SAVINGS ] -= amount ;
		GivePlayerCash ( playerid, amount ) ;

		mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_savings = %d WHERE player_id = %d", 
			Character [ playerid ] [ E_CHARACTER_SAVINGS ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, query);


		SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've withdrawn $%s from your savings account.", IntegerWithDelimiter(amount)));
		SendServerMessage(playerid, COLOR_BLUE, "Bank", "a3a3a3", sprintf("You've now got $%s collected in your savings account.", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_SAVINGS ])));

		// NEW LOGGING: Log this as a LOG_TYPE_SCRIPT for sender (playerid)
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Withdrew $%s from savings (New balance: $%s)", IntegerWithDelimiter(amount), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_SAVINGS ])));
		success=true;
	}

	if ( success ) {
		SendServerMessage(playerid, COLOR_BLUE, "Bank", "DEDEDE", sprintf("The bank has taken $%s (a small percentile) as service tax.", IntegerWithDelimiter ( price ) ) ) ;
		TakePlayerBankCash(playerid, price);

		Property_AddMoneyToTill(playerid, price, .margin=false ) ; 
	}

	return true ;
}
