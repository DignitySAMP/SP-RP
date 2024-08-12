#define SERVER_PAYCHECK 	( 150 )

// Force paycheck
CMD:paycheck(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	foreach(new targetid: Player) {
		PaycheckTick ( targetid ) ;
	}
	new string [ 85 ] ;
	format ( string, sizeof ( string ), "[PAYCHECK] (%d) %s has forced a serverwide paycheck.",  playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME]);
	SendAdminMessage ( string ) ;

	return true ;
}

// Paycheck tick
ptask PaycheckTick[3600000](playerid) { // Every hour

	PlayerVar [ playerid ] [ E_PLAYER_PAYCHECK_INCR ] ++ ; // Track how many paychecks have been recieved
	SendClientMessage(playerid, COLOR_YELLOW, "BANK STATEMENT");

	// Calculate the base payouts
	new paycheck_total = (SERVER_PAYCHECK * PlayerVar [ playerid ] [ E_PLAYER_PAYCHECK_INCR ]);
	new salary_total = Paycheck_CalculateSalary(playerid);

	// Limit the income if they've been ingame for a long time
	paycheck_total = Paycheck_CalculateAFKDebuff(playerid, paycheck_total, salary_total);

	// Send them welfare and savings message
	Paycheck_CalculateSavings(playerid, paycheck_total);

 	// Calculate illegal income (after savings)
	paycheck_total += Paycheck_CalculateIllegal(playerid);

	// Calculate new and final income (takes into account rent)
	Paycheck_CalculateBankReceipt(playerid, paycheck_total);

	// Miscellaneous
	Paycheck_IncreaseHours(playerid); // Increase hours and level if applicable
	Paycheck_CheckFightStyle(playerid); // Check how long fightstyle lasts

	return true ;
}


// Calculations
Paycheck_CalculateSalary(playerid) {

	new salary = 0;
	new salary_total = 0;
	new duty_bonus = 0;
	
	if (IsPlayerInPoliceFaction(playerid)) 	{ salary = 225; duty_bonus = 250; }
	else if (IsPlayerInMedicFaction(playerid)) 		{ salary = 200; duty_bonus = 250; }
	else if (IsPlayerInNewsFaction(playerid)) 		{ salary = 250;	duty_bonus = 150; }
	else if (IsPlayerInGovFaction(playerid)) 		{ salary = 250; duty_bonus = 100; }
	else if (IsPlayerInTruckerFaction(playerid)) 	{ salary = 250; duty_bonus = 0;	  }
	else if (IsPlayerInAnyGovFaction(playerid))		{ salary = 200; duty_bonus = 100; }

	if (salary)
	{
		if (Character[playerid][E_CHARACTER_FACTIONTIER] == 1) salary += 175;
		if (Character[playerid][E_CHARACTER_FACTIONTIER] == 2) salary += 100;
		if (Character[playerid][E_CHARACTER_FACTIONTIER] > 3) salary -= 50; // tier 4 or higher gets less

		salary_total = salary * PlayerVar [ playerid ] [ E_PLAYER_PAYCHECK_INCR ] ;
	}

	// Send them salary message
	if (salary_total) 
	{
		new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ], faction_enum_id = Faction_GetEnumID(factionid), salarystr[128];
		if (PlayerVar[playerid][ E_PLAYER_FACTION_DUTY] && duty_bonus > 0)
		{
			format(salarystr, sizeof(salarystr), "%s SALARY: {7ea928}$%s {b3b3b3}(Tier %d){b3b3b3} || DUTY BONUS: {7ea928}$%s", Faction[faction_enum_id][E_FACTION_ABBREV], IntegerWithDelimiter(salary_total), Character[playerid][E_CHARACTER_FACTIONTIER], IntegerWithDelimiter(duty_bonus));
			salary_total += duty_bonus;
		}
		else format(salarystr, sizeof(salarystr), "%s SALARY: {7ea928}$%s {b3b3b3}(Tier %d)", Faction[faction_enum_id][E_FACTION_ABBREV], IntegerWithDelimiter(salary_total), Character[playerid][E_CHARACTER_FACTIONTIER]);
		SendClientMessage(playerid, 0xb3b3b3FF, salarystr);
	}

	return salary_total;
}

Paycheck_CalculateSavings(playerid, current_pay) {
	
	new savings_calc = ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] / 700 ) / 2 ;
	Character [ playerid ] [ E_CHARACTER_SAVINGS ] += savings_calc ;

	new query [ 144 ] ;
	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_savings = %d WHERE player_id = %d", 
		Character [ playerid ] [ E_CHARACTER_SAVINGS ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "UNIVERSAL INCOME: {7ea928}$%s {b3b3b3}|| SAVINGS INTEREST: {7ea928}$%s{b3b3b3} ($%s total)", IntegerWithDelimiter(current_pay), IntegerWithDelimiter(savings_calc), IntegerWithDelimiter(Character[playerid][E_CHARACTER_SAVINGS])); 
	SendClientMessage(playerid, 0xb3b3b3FF, query);
	return savings_calc;
}

Paycheck_CalculateIllegal(playerid) {
	new total_illegal_pay = 0;
	if (GetPlayerFactionType(playerid) != -1 || Character[playerid][E_CHARACTER_FACTIONID] > 0) {

		new turf_pay = Gangzone_Paycheck(playerid);
		if(turf_pay) {

			SendClientMessage(playerid, 0xb3b3b3FF, sprintf("ILLEGAL (GANG ZONES): {7ea928}$%s{b3b3b3} (%d owned)", IntegerWithDelimiter(turf_pay), Gangzone_Count(Character[playerid][E_CHARACTER_FACTIONID]) ));	
			total_illegal_pay += turf_pay;
		}
		new emmet_pay = Emmet_HandlePaycheck(playerid);
		if(emmet_pay) {
			SendClientMessage(playerid, 0xb3b3b3FF, sprintf("ILLEGAL (GUN DEALER PROFITS): {7ea928}$%s", IntegerWithDelimiter(emmet_pay)));	
			total_illegal_pay += turf_pay;

		}
	}
	return total_illegal_pay;
}

Paycheck_CalculateRent(playerid) {
	
	new renting = Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ], rent, query[144] ;

	if ( renting != -1 ) {
		// Player is using rented room
		if ( Character [ playerid ] [ E_CHARACTER_PROPERTYSPAWN ] == 1 ) {

			rent = Property [ renting ] [ E_PROPERTY_RENT ] ;
			Property [ renting ] [ E_PROPERTY_COLLECT ] += rent ;

			mysql_format(mysql, query, sizeof ( query ), "UPDATE properties SET property_collect = %d WHERE property_id = %d", Property [ renting ] [ E_PROPERTY_COLLECT ], Property [ renting ] [ E_PROPERTY_ID ] );
			mysql_tquery(mysql, query );
		}

		// Player isn't using rented room
		else if ( Character [ playerid ] [ E_CHARACTER_PROPERTYSPAWN ] == 0 ) {
			rent = 0 ;
		}
	}
	 
	if (rent > 0) SendClientMessage(playerid, 0xb3b3b3FF, sprintf("RENT:{a43e2c} $%d", rent) ) ;
	return rent;
}

Paycheck_CalculateBankReceipt(playerid, amount) {
	new old_balance = Character [ playerid ] [ E_CHARACTER_BANKCASH ], query [ 256 ] ;
	
	Character [ playerid ] [ E_CHARACTER_BANKCASH ] += amount ;
	Character [ playerid ] [ E_CHARACTER_BANKCASH ] -= Paycheck_CalculateRent(playerid) ;

	SendClientMessage(playerid, 0xb3b3b3FF, sprintf("OLD BALANCE:{2ebae8} $%d{b3b3b3} || NEW BALANCE:{2ebae8} $%d{b3b3b3}", old_balance, Character [ playerid ] [ E_CHARACTER_BANKCASH ] ) ) ;

	Character [ playerid ] [ E_CHARACTER_PAYCHECK ] = 0 ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_bankcash = %d, player_paycheck = 0 WHERE player_id = %d", Character [ playerid ] [ E_CHARACTER_BANKCASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;
}

Paycheck_CalculateAFKDebuff(playerid, paycheck_total, salary_total) {
	new final_amount = 0;
	if ( PlayerVar [ playerid ] [ E_PLAYER_PAYCHECK_INCR ] >= 6 ) 
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You've been ingame for a long time! Your paycheck has been limited to avoid money farming.");
		paycheck_total = SERVER_PAYCHECK - (SERVER_PAYCHECK / PlayerVar [ playerid ] [ E_PLAYER_PAYCHECK_INCR ]) ;
		salary_total = (salary_total - (salary_total / PlayerVar [ playerid ] [ E_PLAYER_PAYCHECK_INCR ]));
	}

	// Add the salary to the paycheck
	final_amount = (paycheck_total + salary_total);
	return final_amount;
}

// Misc functions
Paycheck_IncreaseHours(playerid) {
	Character [ playerid ] [ E_CHARACTER_HOURS ] ++ ;

	new old_level = Character [ playerid ] [ E_CHARACTER_LEVEL ] ;
	new level = Character [ playerid ] [ E_CHARACTER_HOURS ] / 8 ;

	level = level + 1; // starting level is 1, not 0

	Character [ playerid ] [ E_CHARACTER_LEVEL ] = level ;
	SetPlayerScore(playerid, Character [ playerid ] [ E_CHARACTER_LEVEL ] ) ;

	if ( old_level != level ) {
		SendClientMessage(playerid, COLOR_BLUE, sprintf("You've now played for %d hours and have advanced to Level %d.", Character [ playerid ] [ E_CHARACTER_HOURS ], level));
	}

	new query [ 256 ] ;
	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_hours = %d, player_level=%d WHERE player_id=%d",
		Character [ playerid ] [ E_CHARACTER_HOURS ], Character [ playerid ] [ E_CHARACTER_LEVEL ], Character [ playerid ] [ E_CHARACTER_ID ]
	);
	mysql_tquery(mysql, query);
}

Paycheck_CheckFightStyle(playerid) {

	new bool: recent_removal = false ;
	if ( Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ]  ) {
		Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] -- ;

		SendClientMessage ( playerid, COLOR_BLUE, sprintf("Your fightstyle is protected for %d more paychecks.", Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] ));
		if ( Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] <= 0 ) {

			SendClientMessage ( playerid, COLOR_ERROR, "Your fightstyle protection is now gone. If you do not maintain your skills from this point forward, you will LOSE the fightstyle!");
			SendClientMessage(playerid, COLOR_YELLOW, "If you have the proper stats required for your fightstyle, you can go back to any gym to \"extend\" this protection.");
			Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ] = 0 ;
			Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ] = FIGHT_STYLE_NORMAL ;
		}

		recent_removal = true ;
		Gym_SaveVariables(playerid);
	}

	else {
		if (! recent_removal ) {
			Gym_CheckFightStyleExpiration(playerid);
		}
	}
}

// Helper function
GetPlayerCharacterLevel(playerid) {
	new level = Character [ playerid ] [ E_CHARACTER_HOURS ] / 8 ;
	return level + 1;
}