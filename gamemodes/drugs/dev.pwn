CMD:drugsuppliergoto(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugsuppliergoto [id]");
	}

	if ( id < 0 || id > sizeof ( Cartel ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("ID can't be less than 0 or higher than %d", sizeof ( Cartel ) ) );
	}


	PauseAC(playerid, 3);
	SetPlayerPos(playerid, Cartel [ id ] [ E_CARTEL_POS_X ], Cartel [ id ] [ E_CARTEL_POS_Y ], Cartel [ id ] [ E_CARTEL_POS_Z ] ) ;

	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Teleported to \"%s\".", Cartel [ id ] [ E_CARTEL_DESC ] ) );

	return true ;
}

CMD:spoofdrug(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER )
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new type = E_DRUG_TYPE_NONE, param, Float:amount, container;
	if ( sscanf ( params, "dddf", type, param, container, amount ) )
	{
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/spoofdrug [1: weed, 2: cocaine, 3: crack] [subtype 1-4] [container type 0-8] [amount]" ) ;
	}

	if ( type < 1 || type > 3 ) 
	{
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Type can't be lower than 1 or higher than 3." ) ;
	}

	if (amount <= 0 || amount > 10)
	{
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Amount can't be lower than 0 or higher than 10." ) ;
	}

	if (param < 1 || param > 4 )
	{
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Subtype can't be lower than 1 or higher than 4." ) ;
	}

	if (container < 0 || container > 8 )
	{
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Container type can't be lower than 0 or higher than 8." ) ;
	}

	new player_enum_id = PlayerDrugs_GetFreeID(playerid) ;

	if ( player_enum_id == INVALID_DRUG_ID ) 
	{
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Failed to collect drugs - you have no free slots left." ) ;
	}

	Drugs_IncreasePlayerContainer ( playerid, container );

	new name [ 32 ];

	switch ( type ) 
	{
		case E_DRUG_TYPE_NONE : format ( name, sizeof ( name ), "Invalid" ) ;
		case E_DRUG_TYPE_WEED : format ( name, sizeof ( name ), "%s", Weed [ param ] [ E_WEED_NAME ] ) ;
		case E_DRUG_TYPE_COKE : format ( name, sizeof ( name ), "%s", Cocaine [ param ] [ E_COKE_NAME ] ) ; 
		case E_DRUG_TYPE_CRACK : format ( name, sizeof ( name ), "%s", Crack [ param ] [ E_CRACK_NAME ] ) ;
		//case E_DRUG_TYPE_METH : format ( name, sizeof ( name ), "Meth" ) ;
	}

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ] = type ;
	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ] = param ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ] = container ;
	Drugs_DecreasePlayerContainer ( playerid, container ) ;

	PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ] = amount ;

	PlayerDrugs_Save(playerid) ;

	new package_name [ 32 ] ;
	Drugs_GetPackageName ( container, package_name ) ;

	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You've spoofed %0.2fgr of %s and stored it in a %s. (/mydrugs)", 
		PlayerDrugs [playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], name, package_name ) ) ;


	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Spoofed %0.2fgr of %s in %s",
		PlayerDrugs [playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], name, package_name )
	);

	SendAdminMessage(sprintf("[AdmWarn] (%d) %s spoofed %0.2fgr of %s", playerid, ReturnMixedName(playerid), PlayerDrugs [playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], name));

	return true;
}


CMD:spoofdrugstation(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new type ;

	if ( sscanf ( params, "i", type ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/spoofdrugstation [1: weed, 2: cocaine, 3: crack]" ) ;
	}


	if ( type <= 0 || type > 3 ) {
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Can't be lower than 0 or higher than 3." ) ;
	}


	if ( IsValidDynamicObject(PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_OBJECT ]) ) {
		SOLS_DestroyObject(PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_OBJECT ], "Drugs/SpoofDrugStation Creation", true ) ;

		PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_OBJECT ] = -1 ;
		PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_TYPE  ] = E_DRUG_TYPE_NONE ;
	}


	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

	x += 1.0 ;
	y += 1.0 ;

	PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_OBJECT ] = CreateDynamicObject(1271, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior ( playerid ) ) ;
	SetDynamicObjectMaterial(PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_OBJECT ], 0, 19519, "noncolored", "gen_white");
	EditDynamicObject(playerid,PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_OBJECT ]);

	PlayerVar [ playerid ] [ E_PLAYER_DRUGS_PLACING_TYPE  ] = type ;

	return true ;
}

CMD:drugsetticks(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new index, ticks ;

	if ( sscanf ( params, "ii", index, ticks )) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugsetticks [index] [ticks]" ) ;
	}

	if ( index < 0 || index > sizeof ( Drugs ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Index can't be less than 0 or higher than %d", sizeof ( Drugs ) ) ) ;
	}

	if ( Drugs [ index ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug isn't set up yet so you can't edit it." ) ;
	}

	if ( Drugs [ index ] [ E_DRUG_STAGE ] == E_DRUG_STAGE_TICKS ) {

		Drugs [ index ] [ E_DRUG_TICKS ] = ticks ;
		Drugs_UpdateObject ( index ) ;

		SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("DEV: set ticks of drug plant %d to %d.", index, ticks ) ) ;
	}

	else SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Drug must be ticking before you can do this." ) ;

	return true ;
}


CMD:drugforcefinish(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new index ;

	if ( sscanf ( params, "i", index )) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugforcefinish [index]" ) ;
	}

	if ( index < 0 || index > sizeof ( Drugs ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Index can't be less than 0 or higher than %d", sizeof ( Drugs ) ) ) ;
	}

	if ( Drugs [ index ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug isn't set up yet so you can't edit it." ) ;
	}

	if ( Drugs [ index ] [ E_DRUG_STAGE ] == E_DRUG_STAGE_TICKS ) {

		Drugs [ index ] [ E_DRUG_STAGE ] = E_DRUG_STAGE_FINISH ;
		Drugs_OnFinishTicks ( index ) ;

		SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("DEV: calculated haul of drug plant %d.", index ) ) ;
	}

	else SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Drug must be ticking before you can do this." ) ;

	return true ;
}

CMD:drugsetparam(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new index, param ;

	if ( sscanf ( params, "ii", index, param )) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugsetparam [index] [param]" ) ;
	}

	if ( index < 0 || index > sizeof ( Drugs ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Index can't be less than 0 or higher than %d", sizeof ( Drugs ) ) ) ;
	}

	if ( Drugs [ index ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug isn't set up yet so you can't edit it." ) ;
	}

	Drugs [ index ] [ E_DRUG_PARAM ] = param ;
	Drugs_UpdateObject ( index ) ;

	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("DEV: set param of drug plant %d to %d.", index, param ) ) ;

	return true ;
}

CMD:drugsetstage(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_DEVELOPER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new index, stage ;

	if ( sscanf ( params, "ii", index, stage )) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/drugsetstage [index] [stage]" ) ;
	}

	if ( index < 0 || index > sizeof ( Drugs ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Index can't be less than 0 or higher than %d", sizeof ( Drugs ) ) ) ;
	}

	if ( Drugs [ index ] [ E_DRUG_SQLID ] == INVALID_DRUG_ID ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This drug isn't set up yet so you can't edit it." ) ;
	}

	Drugs [ index ] [ E_DRUG_STAGE ] = stage ;	
	Drugs_UpdateObject ( index ) ;


	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("DEV: set stage of drug plant %d to %d.", index, stage ) ) ;

	return true ;
}