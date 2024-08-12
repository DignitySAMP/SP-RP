CMD:invite(playerid, params[]) {

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

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/invite [target]");
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target is already in a faction!");
	}

	Character [ target ] [ E_CHARACTER_FACTIONID ] =  Character [ playerid ] [ E_CHARACTER_FACTIONID ]  ;
	Character [ target ] [ E_CHARACTER_FACTIONTIER ] = 3 ;
	Character [ target ] [ E_CHARACTER_FACTION_SUSPENSION ] = 0 ;
	Character [ target ] [ E_CHARACTER_FACTIONRANK ] [ 0 ] = EOS ;
	strcat(Character [ target ] [ E_CHARACTER_FACTIONRANK ], "New Member" ) ;
	PlayerVar[target][E_PLAYER_PD_RADIO_CHANNEL] = -1;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factionid = %d, player_factiontier = 3, player_factionsuspension = 0, player_factionrank = 'New Member' WHERE player_id = %d",
		Character [ target ] [ E_CHARACTER_FACTIONID ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);


	//Player_UpdateNameTag(target)  ;
	//UpdateTabListForOthers ( playerid ) ;

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has invited %s to the faction. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid ), ReturnMixedName ( target)
	), faction_enum_id, false ) ;

	return true ;
}

CMD:uninvite(playerid, params[]) {
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

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/uninvite [target]");
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONID ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't in the same faction as you!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONTIER ] <  Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target's tier has more privileges than you, so you can't modify them.");
	}

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has removed %s from the faction. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid), ReturnMixedName ( target )
	), faction_enum_id, false ) ;

	
	if(IsPlayerInPoliceFaction(target)){
		ResetPlayerWeapons(target) ;
		Weapon_ResetPlayerWeapons(target) ;
	}

	Character [ target ] [ E_CHARACTER_FACTIONID ] = 0 ;
	Character [ target ] [ E_CHARACTER_FACTIONTIER ] = 3 ;
	Character [ target ] [ E_CHARACTER_FACTION_SUSPENSION ] = 0 ;
	Character [ target ] [ E_CHARACTER_FACTIONRANK ] [ 0 ] = EOS ;
	strcat(Character [ target ] [ E_CHARACTER_FACTIONRANK ], "None" ) ;

	PlayerVar [ target ] [ E_PLAYER_FACTION_DUTY ] = false;
	PlayerVar[target][E_PLAYER_PD_RADIO_CHANNEL] = -1;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factionid = 0, player_factiontier = 3, player_factionsuspension = 0, player_factionrank = 'None' WHERE player_id = %d", Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	UpdateTabListForOthers ( target ) ;
	//Player_UpdateNameTag(target)  ;

	return true ;
}

CMD:suspend(playerid, params[]) 
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid || !IsPlayerInDutyFaction(playerid) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction that can suspend its members.");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if (Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 2 ) {
		// 1 : owner, 2: command, 3 : member

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to do this.");
	}

	new target, hours, seconds;

	if ( sscanf ( params, "k<player>d", target, hours ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/suspend [player] [hours] (Setting 0 hours will unsuspend)");
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONID ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't in the same faction as you!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONTIER ] <=  Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target's tier has the same or more privileges than you, so you can't suspend them.");
	}

	if (hours < 0 || hours > 120)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't suspend someone for less than 0 or more than 120 hours.");
	}

	seconds = hours * 3600;

	if (hours == 0)
	{
		Faction_SendMessage(factionid, sprintf("{ [%s] %s has unsuspended %s from the faction. }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid ), ReturnMixedName ( target )), faction_enum_id, false ) ;
		Character[target][E_CHARACTER_FACTION_SUSPENSION] = 0;
	}
	else
	{
		Faction_SendMessage(factionid, sprintf("{ [%s] %s has suspended %s from the faction for %d hours. }", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid), ReturnMixedName ( target ), hours), faction_enum_id, false ) ;
		Character[target][E_CHARACTER_FACTION_SUSPENSION] = gettime() + seconds;
	}

	new query [ 256 ] ;
	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factionsuspension = %d WHERE player_id = %d", Character[target][E_CHARACTER_FACTION_SUSPENSION], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	return true ;
}

CMD:settier(playerid, params[]) {
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

	new target, tier ;

	if ( sscanf ( params, "k<player>i", target, tier ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Tiers: 1. Owner | 2. Commander | 3. Normal | 4. Restricted");
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/settier [target] [tier]");
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected!");
	}

	if ( tier < 1 || tier > 4 ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Tier can't be less than 1 or higher than 4.");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONID ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't in the same faction as you!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONTIER ] <  Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target's tier has more privileges than you, so you can't modify them.");
	}

	if ( Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > tier ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't set a tier that's more privileged than your own.");	
	}

	Character [ target ] [ E_CHARACTER_FACTIONTIER ] = tier ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factiontier = %d WHERE player_id = %d",
		Character [ target ] [ E_CHARACTER_FACTIONTIER ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has changed %s to tier %d. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid), ReturnMixedName ( target ), tier
	), faction_enum_id, false ) ;


	return true ;
}

CMD:adminfactionjoin(playerid, params[]) {

	return cmd_afjoin(playerid, params);
}

CMD:afjoin(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new factionid ;

	if ( sscanf ( params, "i", factionid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/afjoin [faction]");	
	}

	Character [ playerid ] [ E_CHARACTER_FACTIONID ] = Faction [ factionid ] [ E_FACTION_ID ] ;
	Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] = 1 ;


	Character [ playerid ] [ E_CHARACTER_FACTIONRANK ] [ 0 ] = EOS ;
	strcat(Character [ playerid ] [ E_CHARACTER_FACTIONRANK ], "Admin" ) ;

	SendClientMessage(playerid, COLOR_INFO, sprintf("You made yourself the leader of faction %d (%s).",
		factionid, Faction [ factionid ] [ E_FACTION_NAME ])) ;

	Radio_InitializePlayer(playerid);

	
    UpdateTabListForPlayer(playerid);
    UpdateTabListForOthers(playerid);

	return true ;
}

CMD:setbadge(playerid, params[]) {
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

	new target, badge;

	if ( sscanf ( params, "k<player>d", target, badge ) || badge < 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setbadge [target] [badge number (5 digits max)]");
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONID ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't in the same faction as you!");
	}

	Character [ target ] [ E_CHARACTER_FACTION_BADGE ] = badge;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factionbadge = %d WHERE player_id = %d",
		Character [ target ] [ E_CHARACTER_FACTION_BADGE ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	Faction_SendMessage(factionid, sprintf("{ [%s] %s set badge #%05d for %s. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid ), Character [ target ] [ E_CHARACTER_FACTION_BADGE ], ReturnMixedName ( target)
	), faction_enum_id, false ) ;


	return true ;
}

CMD:setrank(playerid, params[]) {
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
	

	new target, rank [ 64 ] ;

	if ( sscanf ( params, "k<player>s[64]", target, rank ) || !strcmp(rank, "Admin")) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setrank [target] [rank]");
	}

	if ( ! IsPlayerConnected ( target ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONID ] != Character [ playerid ] [ E_CHARACTER_FACTIONID ] ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't in the same faction as you!");
	}

	if ( Character [ target ] [ E_CHARACTER_FACTIONTIER ] <  Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target's tier has more privileges than you, so you can't modify them.");
	}

	if ( target == playerid && Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] != 1 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't modify your own rank.");	
	}

	Character [ target ] [ E_CHARACTER_FACTIONRANK ] [ 0 ] = EOS ;
	strcat(Character [ target ] [ E_CHARACTER_FACTIONRANK ], rank) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_factionrank = '%e' WHERE player_id = %d",
		Character [ target ] [ E_CHARACTER_FACTIONRANK ], Character [ target ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery(mysql, query);

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has changed %s to %s. }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid ), ReturnMixedName ( target), Character [ target ] [ E_CHARACTER_FACTIONRANK ]
	), faction_enum_id, false ) ;


	return true ;
}

CMD:nofac(playerid, params[]) {
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

	Faction [ faction_enum_id ] [ E_FACTION_CHAT ] = !Faction [ faction_enum_id ] [ E_FACTION_CHAT ] ;

	switch ( Faction [ faction_enum_id ] [ E_FACTION_CHAT ] ) {

		case false : {
			Faction_SendMessage(factionid, sprintf("{ [%s] %s has disabled the faction chat. }",

				Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid )
			), faction_enum_id, false ) ;
		}

		case true: {

			Faction_SendMessage(factionid, sprintf("{ [%s] %s has enabled the faction chat. }",

				Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid )
			), faction_enum_id, false ) ;
		}
	}

	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE factions SET faction_chat = %d WHERE faction_id = %d",
		Faction [ faction_enum_id ] [ E_FACTION_CHAT ], Faction [ faction_enum_id ] [ E_FACTION_ID ] ) ;

	mysql_tquery ( mysql, query ) ;

	return true ;
}

CMD:faction(playerid, params[]) {
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if ( ! Faction [ faction_enum_id ] [ E_FACTION_CHAT ] && Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 2 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction's chat is disabled.");
	}
	
	if (! Faction [ faction_enum_id ] [ E_FACTION_F_ON ] && GetPlayerAdminLevel(playerid) < 2) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This faction doesn't have a faction chat channel.");
	}

	new input [ 128 ] ;

	if ( sscanf ( params, "s[128]", input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/f(action) [text]");
	}

	if ( strlen ( input ) > sizeof ( input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("Your text can't be longer than %d characters.", sizeof ( input )));
	}

	new string[144];

	format(string, sizeof(string), "(( [%s] (%d) %s %s: %s ))", Faction[faction_enum_id][E_FACTION_ABBREV], playerid, Character[playerid][E_CHARACTER_FACTIONRANK], ReturnMixedName(playerid), input);
	Faction_SendMessage(factionid, string, faction_enum_id, true);
	SendAdminListen(playerid, string);

	format ( string, sizeof ( string ), "(( [%s] %s ))",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], input
	);

	AddLogEntry(playerid, LOG_TYPE_OOC, string);

	return true ;
}

CMD:f(playerid, params[]) {

	return cmd_faction(playerid, params ) ;
} 


CMD:ouninvite(playerid, params[]) {


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

	new offid ;

	if ( sscanf ( params, "i", offid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/ouninvite [offline-id] - use /factionoff");
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_factionid = 0, player_factiontier = 3 WHERE player_factionid = %d AND player_id = %d ", 
		Character [ playerid ] [ E_CHARACTER_FACTIONID ], offid
	) ;

	mysql_tquery(mysql, query);

	SendServerMessage ( playerid, COLOR_BLUE, "Faction", "A3A3A3", "If the offline ID you entered was correct, the player should be removed. Use /factionoff to check.");

	return true ;
}

CMD:factionoff(playerid, params[]) 
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	new query [ 512 ];

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `player_id`, `player_name`, `account_name`, `player_factionrank`, `player_factionbadge`, `player_factionsuspension`, `player_factiontier`, `player_factionsquad` FROM `characters` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `player_factionid` = '%d' ORDER BY `player_factionbadge` ASC",
		factionid
	) ; 


	inline OnOfflineMemberCheck() {
		new dutyfac = IsPlayerInDutyFaction(playerid), player_id, player_off_name [ MAX_PLAYER_NAME ], player_rank [ 64 ], player_badge, player_acc[32], suspension, tier, squad;
		for (new i = 0, r = cache_num_rows(); i < r; ++i) { 
			cache_get_value_name_int(i, "player_id", player_id);
			
			if (Player_IsPlayerConnected(player_id)) {
				continue ;
			}

			cache_get_value_name ( i, "player_name", player_off_name);
			cache_get_value_name ( i, "player_factionrank", player_rank);
			cache_get_value_name ( i, "account_name", player_acc);
			cache_get_value_name_int(i, "player_factionbadge", player_badge);
			cache_get_value_name_int(i, "player_factionsuspension", suspension);
			cache_get_value_name_int(i, "player_factiontier", tier);
			cache_get_value_name_int(i, "player_factionsquad", squad);

			new suspended = suspension && gettime() < suspension;

			if (player_badge && suspended && dutyfac) SendClientMessage(playerid, COLOR_FACTION_RED, sprintf("SUSPENDED: (%d) %s %s #%05d (%s) | Tier: %d, Squad: %d", player_id, player_rank, player_off_name, player_badge, player_acc, tier, squad));
			else if (player_badge && dutyfac) SendClientMessage(playerid, COLOR_FACTION_RED, sprintf("OFFLINE: (%d) %s %s #%05d (%s) | Tier: %d, Squad: %d", player_id, player_rank, player_off_name, player_badge, player_acc, tier, squad));
			else if (suspended) SendClientMessage(playerid, COLOR_FACTION_RED, sprintf("SUSPENDED: (%d) %s %s (%s) | Tier: %d", player_id, player_rank, player_off_name, player_acc, tier));
			else SendClientMessage(playerid, COLOR_FACTION_RED, sprintf("OFFLINE: (%d) %s %s (%s) | Tier: %d", player_id, player_rank, player_off_name, player_acc, tier));
		}	
	}

	MySQL_TQueryInline(mysql, using inline OnOfflineMemberCheck, query, "");

	return true ;
}

CMD:foff(playerid, params[]) return cmd_factionoff(playerid, params);
CMD:foffline(playerid, params[]) return cmd_factionoff(playerid, params);

CMD:factionon(playerid, params[])
{
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	new tier, squadsString[64];
	new dutyfac = IsPlayerInDutyFaction(playerid);

	foreach(new idx: Player ) 
	{
		if (Character [ idx ] [ E_CHARACTER_FACTIONID ] == factionid && (strcmp(Character[idx][E_CHARACTER_FACTIONRANK], "Admin") != 0 || playerid == idx)) 
		{
			new suspended = GetPlayerFactionSuspension(idx);
			new badge = Character [ idx ] [ E_CHARACTER_FACTION_BADGE ];
			new duty = PlayerVar [ idx ] [ E_PLAYER_FACTION_DUTY ];
			tier = Character [ idx ] [ E_CHARACTER_FACTIONTIER ];

			format(squadsString, sizeof(squadsString), "%d|%d|%d", Character [ idx ] [ E_CHARACTER_FACTION_SQUAD ], Character [ idx ] [ E_CHARACTER_FACTION_SQUAD2 ], Character [ idx ] [ E_CHARACTER_FACTION_SQUAD3 ]);

			if (dutyfac && suspended && badge && duty) SendClientMessage(playerid, COLOR_FACTION_GREEN, sprintf("SUSPENDED: (ID %d) %s %s #%05d | Tier: %d, Squad: %s", idx, Character [ idx ] [ E_CHARACTER_FACTIONRANK ], ReturnMixedName ( idx ), Character [ idx ] [ E_CHARACTER_FACTION_BADGE ], tier, squadsString ) );
			else if (suspended && badge && dutyfac) SendClientMessage(playerid, COLOR_GREY, sprintf("SUSPENDED: (ID %d) %s %s #%05d | Tier: %d, Squad: %s", idx, Character [ idx ] [ E_CHARACTER_FACTIONRANK ], ReturnMixedName ( idx ), Character [ idx ] [ E_CHARACTER_FACTION_BADGE ], tier, squadsString ) );
			else if (suspended) SendClientMessage(playerid, COLOR_GREY, sprintf("SUSPENDED: (ID %d) %s %s | Tier: %d", idx, Character [ idx ] [ E_CHARACTER_FACTIONRANK ], ReturnMixedName ( idx), tier ) );
			else if (dutyfac && duty) SendClientMessage(playerid, COLOR_FACTION_GREEN, sprintf("ON DUTY: (ID %d) %s %s #%05d | Tier: %d, Squad: %s", idx, Character [ idx ] [ E_CHARACTER_FACTIONRANK ], ReturnMixedName ( idx), Character [ idx ] [ E_CHARACTER_FACTION_BADGE ], tier, squadsString ) );		
			else if (dutyfac) SendClientMessage(playerid, COLOR_GREY, sprintf("OFF DUTY: (ID %d) %s %s #%05d | Tier: %d, Squad: %s", idx, Character [ idx ] [ E_CHARACTER_FACTIONRANK ], ReturnMixedName ( idx), Character [ idx ] [ E_CHARACTER_FACTION_BADGE ], tier, squadsString ) );
			else SendClientMessage(playerid, COLOR_FACTION_GREEN, sprintf("ONLINE: (ID %d) %s %s | Tier: %d", idx, Character [ idx ] [ E_CHARACTER_FACTIONRANK ], ReturnMixedName ( idx), tier ) );
		}
	}

	return true;
}

CMD:fon(playerid, params[])
{
	return cmd_factionon(playerid, params);
}

CMD:fonline(playerid, params[])
{
	return cmd_factionon(playerid, params);
}

Player_IsPlayerConnected ( player_sql_id ) {
	foreach(new idx: Player ) {

		if ( Character [ idx ] [ E_CHARACTER_ID ] == player_sql_id ) {

			return true  ;
		}
	}

	return false ;
}