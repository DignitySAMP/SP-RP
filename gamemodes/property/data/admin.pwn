CMD:propertycreate(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new price, type ;

	if ( sscanf ( params, "ii", price, type)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertycreate [price: 0 = non buyable] [type: 0 = house, 1 = biz, 2= static]") ;
	}

	if ( type < 0 || type > 2 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Type can't be less than 0 or more than 2.") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

	Property_OnCreate(playerid, type, x, y, z, GetPlayerInterior ( playerid ), GetPlayerVirtualWorld ( playerid ), price);

	return true ;
}

CMD:propertymove(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id ;

	if ( sscanf ( params, "i", id ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertymove [id]") ;

	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( playerid, x, y, z ) ;

	Property [id ] [ E_PROPERTY_EXT_X ] = x;
	Property [id ] [ E_PROPERTY_EXT_Y ] = y;
	Property [id ] [ E_PROPERTY_EXT_Z ] = z;

	Property [id ] [ E_PROPERTY_EXT_VW ] = GetPlayerVirtualWorld(playerid) ;
	Property [id ] [ E_PROPERTY_EXT_INT ] = GetPlayerInterior(playerid) ;

	Property_SetupVisualEntities(id);

	new query [ 1024 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_ext_x = '%f', property_ext_y = '%f', property_ext_z = '%f', property_ext_vw = %d, property_ext_int = %d WHERE property_id = %d",

		Property [id ] [ E_PROPERTY_EXT_X ],
		Property [id ] [ E_PROPERTY_EXT_Y ],
		Property [id ] [ E_PROPERTY_EXT_Z ],
		Property [id ] [ E_PROPERTY_EXT_VW ],
		Property [id ] [ E_PROPERTY_EXT_INT ],
		Property [id ] [ E_PROPERTY_ID ]

	) ;

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've moved property ID %d to your location.", id ) ) ;

	return true ;
}

CMD:propertydelete(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertydelete [id]") ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_OWNER ] > 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "This property is owned! Use /propertyauction first!") ;
	}


	Furniture_WipeAllContent ( playerid, Property [ id ] [ E_PROPERTY_ID ] ) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "DELETE FROM `properties` WHERE property_id = %d",

		Property [id ] [ E_PROPERTY_ID ]
	) ;

	mysql_tquery(mysql, query );


	if ( IsValidDynamicPickup( Property [ id ] [ E_PROPERTY_PICKUP ] [ 0 ] ) ) {
		DestroyDynamicPickup(Property [ id ] [ E_PROPERTY_PICKUP ] [ 0 ] ) ;
	}
	Property [ id ] [ E_PROPERTY_PICKUP ] [ 0 ] = INVALID_STREAMER_ID;

	if ( IsValidDynamicPickup( Property [ id ] [ E_PROPERTY_PICKUP ] [ 1 ] ) ) {
		DestroyDynamicPickup(Property [ id ] [ E_PROPERTY_PICKUP ] [ 1 ] ) ;
	}
	Property [ id ] [ E_PROPERTY_PICKUP ] [ 1 ]= INVALID_STREAMER_ID;

	if ( IsValidDynamicArea( Property [ id ] [ E_PROPERTY_AREA ] ) ) {
		DestroyDynamicArea( Property [ id ] [ E_PROPERTY_AREA ] ) ;
	}
	Property [ id ] [ E_PROPERTY_AREA ]= INVALID_STREAMER_ID;
	
	Iter_Remove(Properties, id);

	Property [ id ] [ E_PROPERTY_ID ] = INVALID_PROPERTY_ID ;

	Property [ id ] [ E_PROPERTY_PICKUP ] [ 0 ] = -1 ;
	Property [ id ] [ E_PROPERTY_PICKUP ] [ 1 ] = -1 ;
	Property [ id ] [ E_PROPERTY_AREA ] = -1 ;

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've deleted property ID %d.", id ) ) ;

	return true ;
}

CMD:propertygoto(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}


	new id ;

	if ( sscanf ( params, "i", id ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertygoto [id]") ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	PauseAC(playerid, 3);	
	SetPlayerPos(playerid, Property [ id ] [ E_PROPERTY_EXT_X], Property [ id ] [ E_PROPERTY_EXT_Y], Property [ id ] [ E_PROPERTY_EXT_Z]);
	SetPlayerInterior(playerid, Property [ id ] [ E_PROPERTY_EXT_INT ] ) ;
	SetPlayerVirtualWorld(playerid, Property [ id ] [ E_PROPERTY_EXT_VW ] ) ;

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've teleported to property ID %d", id) ) ;
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("teleported to Property %d (SQL: %d)", id, Property[id][E_PROPERTY_ID]));
	return true ;
}

CMD:propgoto(playerid, params[])
{
	return cmd_propertygoto(playerid, params);
}

CMD:propertyprice(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, price ;

	if ( sscanf ( params, "ii", id, price) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertyprice [id] [price] (0 disables buying it)") ;
	}

	if ( (price < 2500 || price > 1000000) && price != 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Price can't be less than 2,500 or more than 1,000,000.") ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	new query [ 256 ] ;

	Property [id ] [ E_PROPERTY_PRICE ] = price ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_price = %d WHERE property_id = %d",

		Property [id ] [ E_PROPERTY_PRICE ],
		Property [id ] [ E_PROPERTY_ID ]

	) ;

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've changed property ID %d's price to $%s", id, IntegerWithDelimiter(price) ) ) ;

	return true ;
}
CMD:propertytype(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, type ;

	if ( sscanf ( params, "ii", id, type) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertytype [id] [type]") ;
		SendClientMessage(playerid, 0xDEDEDEFF, "Types: 0) house, 1) business, 2) static");

		return true ;
	}

	
	if ( type < E_PROPERTY_TYPE_HOUSE || type > E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", sprintf("Type can't be less than %d or more than %d.", E_PROPERTY_TYPE_HOUSE, E_PROPERTY_TYPE_STATIC )) ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}
 
	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	new query [ 256 ] ;

	Property [id ] [ E_PROPERTY_TYPE ] = type ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_type = %d WHERE property_id = %d",

		Property [id ] [ E_PROPERTY_TYPE ],
		Property [id ] [ E_PROPERTY_ID ]

	) ;

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've changed property ID %d's type to %d", id, Property [id ] [ E_PROPERTY_TYPE ] ) ) ;

	Property_SetupVisualEntities(id);
	
	return true ;
}

CMD:propertyowner(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, owner;

	if ( sscanf ( params, "ii", id, owner) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertyowner [id] [char id]") ;
	}
	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if (owner <= 0)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid owner char ID entered!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	new query [ 256 ] ;
	inline ReturnCharName() 
	{
		if (!cache_num_rows()) 
		{
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Couldn't find a character with this ID.");
		}

		new charname[32];
		cache_get_value_name(0, "player_name", charname);
		Property [id ] [ E_PROPERTY_OWNER ] = owner;

		AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Changed owner of Property %d (SQL: %d) to %s (SQL: %d)", id, Property [ id ] [ E_PROPERTY_ID ], charname, owner));
		SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s changed the owner of Property %d to %s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], id, charname));

		mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d", Property [id ] [ E_PROPERTY_OWNER ], Property [id ] [ E_PROPERTY_ID ]);
		mysql_tquery(mysql, query);
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `player_name` FROM `characters` WHERE `player_id` = %d", owner ) ;
	MySQL_TQueryInline(mysql, using inline ReturnCharName, query, "");

	return true ;
}

CMD:propertyauction(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
 
	new id ;

	if ( sscanf ( params, "i", id) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertyauction [id]") ;
	}
	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	foreach(new targetid: Player) {

		if ( Character [ targetid ] [ E_CHARACTER_ID ] == Property [ id ] [ E_PROPERTY_OWNER ] ) {

			SendClientMessage(targetid, COLOR_YELLOW, sprintf("WARNING: Your property with ID %d has been sold by an administrator!", id));
			SendClientMessage(targetid, COLOR_RED, "If this was not intended, take a screenshot IMMEDIATELY. To get refunded, relog.");
			SendClientMessage(targetid, COLOR_GRAD0, "The system will automatically refund you a portion of the buy price when you next log in.");
			break ;
		}
	}

	new query [ 256 ] ;

// Setting variable so player gets msg upon logging in & refund
	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_soldproperty = %d WHERE player_id = %d",

		Property [ id ] [ E_PROPERTY_ID ],
		Property [ id ] [ E_PROPERTY_OWNER ]
	);

	mysql_tquery(mysql, query );

	query [ 0 ] = EOS ;

	Property [id ] [ E_PROPERTY_OWNER ] = INVALID_PROPERTY_OWNER ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d",

		Property [id ] [ E_PROPERTY_OWNER ],
		Property [id ] [ E_PROPERTY_ID ]
	) ;

	mysql_tquery(mysql, query );

	
	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've admin sold property ID %d.", id ) ) ;

	return true ;
}

Property_RefundPlayer(playerid, id) {


	if ( id > 0 || id < MAX_PROPERTIES ) {
		if ( id > MAX_PROPERTIES ) {

			return true ;
		} 

		new amount = Property [ id ] [ E_PROPERTY_PRICE ]  ;

		SendClientMessage(playerid, -1, " " ) ;
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("WARNING:{DEDEDE} Your property (ID %d) was sold whilst you were offline. You have been refunded $%s.",
			id, IntegerWithDelimiter ( amount ) ) ) ;
		SendClientMessage(playerid, COLOR_RED, "If you think this was a mistake, post a refund requests with the property ID. ");
		SendClientMessage(playerid, -1, " " ) ;
		
		GivePlayerCash ( playerid, amount ) ;
		Character [ playerid ] [ E_CHARACTER_SOLD_PROPERTY ] = INVALID_PROPERTY_ID ;

		new query [ 256 ] ;

		mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_soldproperty = 0 WHERE player_id = %d",
			Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, query);

	}

	return true ;
}


CMD:propertybuytype(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, type ;

	if ( sscanf ( params, "ii", id, type ) ) {
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/propertybuytype [id] [type]") ;
		SendClientMessage(playerid, 0xDEDEDEFF, "Types: Use /buypointtypes");
		return true ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}
	Property [ id ] [ E_PROPERTY_BUY_TYPE ] = type ;


	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_buy_type = %d WHERE property_id = %d", 

		Property [ id ] [ E_PROPERTY_BUY_TYPE ], Property [ id ] [ E_PROPERTY_ID ] ) ;

	mysql_tquery(mysql, query);

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("Set property buy ID %d to type %d.", id, type ) ) ;
	
	Property_SetupVisualEntities(id);
	return true ;
}

CMD:propertyextra(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, type ;

	if ( sscanf ( params, "ii", id, type ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/propertyextra [id] [type]") ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	switch ( Property [ id ] [ E_PROPERTY_BUY_TYPE ] ) {
		case E_BUY_TYPE_DEALERSHIP: {

			SendClientMessage(playerid, COLOR_YELLOW, "This will set the type of cars the business will sell.");
			SendClientMessage(playerid, COLOR_RED, "It also sets the position where the cars will spawn! Make sure to place it proper!");

			new Float: x, Float: y, Float: z ;
			GetPlayerPos(playerid, x, y, z ) ;

			Property [ id ] [ E_PROPERTY_EXTRA_TYPE ] = type ;

			Property [ id ] [ E_PROPERTY_EXTRA_POS_X ] = x ;
			Property [ id ] [ E_PROPERTY_EXTRA_POS_Y ] = y ;
			Property [ id ] [ E_PROPERTY_EXTRA_POS_Z ] = z ;

			Property [ id ] [ E_PROPERTY_EXTRA_POS_INT ] = GetPlayerInterior(playerid);
			Property [ id ] [ E_PROPERTY_EXTRA_POS_VW ] = GetPlayerVirtualWorld(playerid);

			SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("Property ID %d 's extra type has been set to %d.",
				id, type )) ;

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof ( query ) , "UPDATE properties SET property_extra_type = %d, property_extra_pos_x = '%f',\
				property_extra_pos_y = '%f', property_extra_pos_z = '%f', property_extra_int = %d, property_extra_vw = %d WHERE property_id = %d",
					Property [ id ] [ E_PROPERTY_EXTRA_TYPE ],
					Property [ id ] [ E_PROPERTY_EXTRA_POS_X ],
					Property [ id ] [ E_PROPERTY_EXTRA_POS_Y ],
					Property [ id ] [ E_PROPERTY_EXTRA_POS_Z ],
					Property [ id ] [ E_PROPERTY_EXTRA_POS_INT ],
					Property [ id ] [ E_PROPERTY_EXTRA_POS_VW ],
					Property [ id ] [ E_PROPERTY_ID]
				);

			mysql_tquery(mysql, query);

			return true ;
		}
	}
	
	SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "The business ID you entered can't have extras assigned to them.") ;

	return true ;
}

CMD:propertybuypoint(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id ;

	if ( sscanf ( params, "i", id ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/propertybuypoint [id]") ;
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	switch ( Property [ id ] [ E_PROPERTY_BUY_TYPE ] ) {
		case E_BUY_TYPE_DEALERSHIP, E_BUY_TYPE_GASSTATION, E_BUY_TYPE_MODSHOP: {
			return SendClientMessage(playerid, -1, "This business can't have buytypes assigned.");
		}
	}

	if ( Property [ id ] [ E_PROPERTY_TYPE ] != E_PROPERTY_TYPE_BIZ  ) {

		return SendClientMessage(playerid, -1, "Only businesses can sell wares.");
	}

	if ( ! Property [ id ] [ E_PROPERTY_BUY_TYPE ] ) {

		return SendClientMessage(playerid, -1, "This property isn't isn't permitted to sell wares.");
	}

	new Float: x , Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;

	Property [ id ] [ E_PROPERTY_BUY_POS_X ] = x;
	Property [ id ] [ E_PROPERTY_BUY_POS_Y ] = y;
	Property [ id ] [ E_PROPERTY_BUY_POS_Z ] = z;

	Property [ id ] [ E_PROPERTY_BUY_POS_VW ] = GetPlayerVirtualWorld(playerid);
	Property [ id ] [ E_PROPERTY_BUY_POS_INT ] = GetPlayerInterior(playerid);

	Property_SetupVisualEntities(id);

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_buy_pos_x = '%f',\
		property_buy_pos_y = '%f', property_buy_pos_z = '%f', property_buy_pos_vw = %d, property_buy_pos_int = %d WHERE property_id = %d", 
			Property [ id ] [ E_PROPERTY_BUY_POS_X ],
			Property [ id ] [ E_PROPERTY_BUY_POS_Y ],
			Property [ id ] [ E_PROPERTY_BUY_POS_Z ],
			Property [ id ] [ E_PROPERTY_BUY_POS_VW ],
			Property [ id ] [ E_PROPERTY_BUY_POS_INT ],

		Property [ id ] [ E_PROPERTY_ID ] ) ;

	mysql_tquery(mysql, query);

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", "Moved property's buy point to your location." ) ;

	return true ;
}

CMD:propertyintid(playerid, params[]) 
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, interior;
	if ( sscanf ( params, "dd", id, interior ) ) 
	{
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/propertyintid [property id] [interior world id]") ;
		return SendClientMessage(playerid, 0xDEDEDEFF, "This sets only the interior ID.");
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	Property [ id ] [ E_PROPERTY_INT_INT ] = interior;
	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE properties SET property_int_int = %d WHERE property_id = %d",
		Property [ id ] [ E_PROPERTY_INT_INT ],
		Property [ id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);
	SendClientMessage(playerid, COLOR_GRAD1, sprintf("You changed the interior ID of property %d to %d.", id, interior));

	return true;
}

CMD:propintid(playerid, params[]) {

	return cmd_propertyintid(playerid, params);
}

CMD:propertyinterior(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id; 

	if ( sscanf ( params, "i", id ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/propertyint(erior) [id]") ;
		return SendClientMessage(playerid, 0xDEDEDEFF, "Warning: this sets your current location (+ interior) to the entered ID's interior!");
	}

	new Float: x, Float: y, Float: z ;
	GetPlayerPos(playerid, x, y, z ) ;

	Property [ id ] [ E_PROPERTY_INT_X ] = x;
	Property [ id ] [ E_PROPERTY_INT_Y ] = y;
	Property [ id ] [ E_PROPERTY_INT_Z ] = z;
	Property [ id ] [ E_PROPERTY_INT_INT ] = GetPlayerInterior(playerid) ;

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("Property %d's interior location has been set to your current position.", id ) ) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE properties SET property_int_x = '%f', property_int_y = '%f', property_int_z = '%f', property_int_int = %d WHERE property_id = %d",
		Property [ id ] [ E_PROPERTY_INT_X ],
		Property [ id ] [ E_PROPERTY_INT_Y ],
		Property [ id ] [ E_PROPERTY_INT_Z ],
		Property [ id ] [ E_PROPERTY_INT_INT ],
		Property [ id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	PauseAC(playerid, 3);
	SetPlayerPos(playerid, Property [ id ] [ E_PROPERTY_EXT_X ], Property [ id ] [ E_PROPERTY_EXT_Y ], Property [ id ] [ E_PROPERTY_EXT_Z ] ) ;
	SetPlayerInterior(playerid, Property [ id ] [ E_PROPERTY_EXT_INT ] );
	SetPlayerVirtualWorld(playerid, Property [ id ] [ E_PROPERTY_EXT_VW ] );

	SendClientMessage(playerid, COLOR_GRAD1, "Warning: You've been teleported to the front door for security measures.");

	return true ;
}

CMD:propertyintlist(playerid, params[]) {

	return cmd_propertyinteriorlist(playerid, params);
}
CMD:propertyinteriorlist(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	SendClientMessage(playerid, COLOR_GRAD1, "Click on the list to teleport to the interior.");
	SendClientMessage(playerid, COLOR_GRAD1, "Use /propertysetint to set the interior to your location.");

	Interior_ListNatives (playerid ) ;

	return true ;
}

CMD:propertygetid(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new sqlid; 
	if ( sscanf ( params, "i", sqlid ) ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/propertygetid [SQL id]") ;
	}

	new id = Property_GetEnumID(sqlid);
	if (id == INVALID_PROPERTY_ID) SendClientMessage(playerid, COLOR_GRAD1, "Invalid property SQL ID.");
	
	return SendClientMessage(playerid, COLOR_GRAD1, sprintf("Property ID of SQL ID %d is %d.", sqlid, id));
}