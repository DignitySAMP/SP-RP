static PropInviteDlgStr[512];
new bool: HasActivePropertyOffer[MAX_PLAYERS];

CMD:furniperm(playerid, params[]) 
{
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be inside your property, near the door." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own this property." );
	}

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/furniperm [player]");

	if (!IsPlayerConnected(targetid) || !IsPlayerLogged(targetid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't connected." );
	}
	
	if (PlayerVar[targetid][E_PLAYER_FURNI_PERM] == Property[property_enum_id][E_PROPERTY_ID])
	{
		SendServerMessage(playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You have revoked furniture permission for (%d) %s.", targetid, ReturnSettingsName(targetid, playerid)));
		SendServerMessage(targetid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("(%d) %s has revoked your furniture permission for their property.", playerid, ReturnSettingsName(playerid, targetid)));
		PlayerVar[targetid][E_PLAYER_FURNI_PERM] = 0;
	}
	else if (!PlayerVar[targetid][E_PLAYER_FURNI_PERM])
	{
		SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You have allowed (%d) %s to fully manage your property furniture until they logout.", targetid, ReturnSettingsName(targetid, playerid)) );
		SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", "Note: you can do the command again to revoke permission.");

		SendServerMessage ( targetid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("(%d) %s has given you furniture permission for their property.", playerid, ReturnSettingsName(playerid, targetid)) );
		SendServerMessage ( targetid, COLOR_PROPERTY, "Property", "A3A3A3", "Note: furniture permission only lasts until you disconnect.");
		PlayerVar[targetid][E_PLAYER_FURNI_PERM] = Property[property_enum_id][E_PROPERTY_ID];
	}
	else
	{
		SendServerMessage ( playerid, COLOR_PROPERTY, "Error", "A3A3A3", "This player already has furniture permission for a different property.");
	}
	
	return true ;
}

CMD:propertyinvite(playerid, params[]) 
{
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own this property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] != E_PROPERTY_TYPE_HOUSE ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only invite a player to rent a residence." );
	}

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/propertyinvite [player]");

	if (!IsPlayerConnected(targetid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't connected." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == Character [ targetid ] [ E_CHARACTER_ID ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You already own this property." );
	}

	if (!IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near this player." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_ID ] == Character [ targetid ] [ E_CHARACTER_RENTEDHOUSE ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player already rents your property.  Type /propertyevict to evict them." );
	}

	new address [ 64 ], zone [ 64 ] ;

	GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );
	
	inline DlgPropInvite(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused dialogid, inputtext, listitem, inputtext
        
        if (response)
        {
			if (Property [ property_enum_id ] [ E_PROPERTY_RENT ] > 0 && GetPlayerCash(pid) < Property [ property_enum_id ] [ E_PROPERTY_RENT ])
			{
				return SendServerMessage ( pid, COLOR_ERROR, "Error", "A3A3A3", "You can't afford to rent this property." );
			}

            Character [ pid ] [ E_CHARACTER_RENTEDHOUSE ] = Property [ property_enum_id ] [ E_PROPERTY_ID ] ;

			new query [ 256 ] ;
			mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_rentroom = %d WHERE player_id = %d", 

				Character [ pid ] [ E_CHARACTER_RENTEDHOUSE ], Character [ pid ] [ E_CHARACTER_ID] ) ;

			mysql_tquery(mysql, query);

			

			SendServerMessage ( pid, COLOR_PROPERTY, "Property", "A3A3A3",  sprintf("You've rented %d %s, %s for $%s. Type /propertyhelp for commands.",
				property_enum_id, address, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_RENT ])  ) );

			if (Property [ property_enum_id ] [ E_PROPERTY_RENT ] > 0)
			{
				TakePlayerCash(pid, Property [ property_enum_id ] [ E_PROPERTY_RENT ]);
			}

			SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("%s accepted your invite to rent at your property.", ReturnSettingsName(pid, playerid)) );

			AddLogEntry(pid, LOG_TYPE_SCRIPT, sprintf("Rented %d, %s %s (SQL: %d) for $%s", property_enum_id, address, zone, Property [ property_enum_id ] [ E_PROPERTY_ID ], Property [ property_enum_id ] [ E_PROPERTY_RENT ]));
        }

        return true;
    }

	format(PropInviteDlgStr, sizeof(PropInviteDlgStr), "%s has invited you to rent %d %s, %s.\nThe rental price is $%s per paycheck.\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to pay $%s and rent the property.\n{ADBEE6}If you are already renting a property, this will override it.",
		ReturnSettingsName(playerid, targetid), property_enum_id, address, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_RENT ]), IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_RENT ]));

    Dialog_ShowCallback ( targetid, using inline DlgPropInvite, DIALOG_STYLE_MSGBOX, "Property Invite", PropInviteDlgStr, "OK", "Back" );
	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You invited %s to rent at your property.", ReturnSettingsName(targetid, playerid)) );
	return true ;
}

CMD:propertyevict(playerid, params[]) 
{
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own this property." );
	}

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/propertyevict [player]");

	if (!IsPlayerConnected(targetid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't connected." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == Character [ targetid ] [ E_CHARACTER_ID ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You already own this property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_ID ] != Character [ targetid ] [ E_CHARACTER_RENTEDHOUSE ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player doesn't rent at your property." );
	}

	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Evicted from property SQL ID %d", Character [ targetid ] [ E_CHARACTER_RENTEDHOUSE ]));

	Character [ targetid ] [ E_CHARACTER_RENTEDHOUSE ] = -1 ;
	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_rentroom = %d WHERE player_id = %d", 

		Character [ targetid ] [ E_CHARACTER_RENTEDHOUSE ], Character [ targetid ] [ E_CHARACTER_ID] ) ;

	mysql_tquery(mysql, query);
	SendServerMessage ( targetid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You have been evicted from the property you were renting at by %s.", ReturnSettingsName(playerid, targetid)) );
	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You evicted %s from renting your property.", ReturnSettingsName(targetid, playerid)) );

	return true ;
}

CMD:unrentroom(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Unrented property SQL ID %d", Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ]));

	Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ] = -1 ;
	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_rentroom = %d WHERE player_id = %d", 

		Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ], Character [ playerid ] [ E_CHARACTER_ID] ) ;

	mysql_tquery(mysql, query);
	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", "You have unrented the property you were renting at." );


	return true ;
}

CMD:rentroom(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't rent at a static property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't need to rent this property - you own it!");
	}

	if ( ! Property [ property_enum_id ] [ E_PROPERTY_RENT ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "This property isn't rentable." );
	}

	if ( Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ] == Property [ property_enum_id ] [ E_PROPERTY_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're already renting here!" );
	}

	if (GetPlayerCash( playerid ) < Property [ property_enum_id ] [ E_PROPERTY_RENT ]) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't afford to rent this property." );
	}

	Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ] = Property [ property_enum_id ] [ E_PROPERTY_ID ] ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_rentroom = %d WHERE player_id = %d", 

		Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ], Character [ playerid ] [ E_CHARACTER_ID] ) ;

	mysql_tquery(mysql, query);

	new address [ 64 ], zone [ 64 ] ;

	GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );


	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3",  sprintf("You've rented %d %s, %s for $%s. Type /propertyhelp for commands.",
		property_enum_id, address, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_RENT ])  ) );

	TakePlayerCash(playerid, Property [ property_enum_id ] [ E_PROPERTY_RENT ]);
	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Rented %d, %s %s (SQL: %d) for $%s", property_enum_id, address, zone, Property [ property_enum_id ] [ E_PROPERTY_ID ], Property [ property_enum_id ] [ E_PROPERTY_RENT ]));

	return true ;
}

CMD:propname(playerid, params[]) {

	return cmd_propertyname(playerid, params);
}

CMD:propnamecolor(playerid, params[]) {

	return cmd_propertynamecolor(playerid, params);
}

static const PropertyNameColors[][] = 
{
	"White",
	"Red",
	"Green",
	"Blue",
	"Yellow",
	"Purple",
	"Black"
};

CMD:propertynamecolor (playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    } 

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER) ;


	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're not near a property entrance." );
	}

	if ( GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL && Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't own this property!" );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] != E_PROPERTY_TYPE_BIZ ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can only change the name of a business." );
	}

	new type = -1, type_name[10];

	new helpstr[128];
	format(helpstr, sizeof(helpstr), "Available Colors: ");

	sscanf ( params, "s[10]", type_name ); 

	for ( new i, j = sizeof ( PropertyNameColors ); i < j ; i ++ ) 
	{
		if (strlen(type_name) && !strcmp(type_name, PropertyNameColors[i], true))
		{
			type = i;
			break;
		}

		if (i > 0) strcat(helpstr, ", ");
		format(helpstr, sizeof(helpstr), "%s\"%s\"", helpstr, PropertyNameColors[i]);
	}

	if (type == -1)
	{
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/propertynamecolor [color]" );
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  helpstr );
	}

	Property [ property_enum_id ] [ E_PROPERTY_NAME_COLOR ] = type ;

	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_name_color = %d WHERE property_id = %d", 

		Property [ property_enum_id ] [ E_PROPERTY_NAME_COLOR ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3",  sprintf("Changed property name color to %s.", PropertyNameColors[type] ) );
	return true ;
} 

stock IsValidPropertyName(const propname[])
{
	static Regex:regex;
	if (!regex) regex = Regex_New("^[a-zA-Z0-9 \\/,.'&]*$");

	return Regex_Check(propname, regex);
}


CMD:propertyname(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    } 

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;


	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're not near a property entrance." );
	}

	if ( GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL && Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't own this property!" );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] != E_PROPERTY_TYPE_BIZ ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can only change the name of a business." );
	}

	new name [ 128 ] ;

	if ( sscanf ( params, "s[128]", name ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/propertyname [name]" );
	}

	if ( strlen ( name ) <= 3 || strlen ( name ) > 64  ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Property name can't be less than 3 or more than 64 characters." );
	}

	if (!IsValidPropertyName(name))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Keep it simple, your property name can't contain special characters." );
	}

	Property [ property_enum_id ] [ E_PROPERTY_NAME ] [ 0 ] = EOS ;
	format ( Property [ property_enum_id ] [ E_PROPERTY_NAME ], sizeof ( name ), "%s", name ) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_name = '%e' WHERE property_id = %d", 

		Property [ property_enum_id ] [ E_PROPERTY_NAME ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3",  sprintf("Changed property name to \"%s\".", Property [ property_enum_id ] [ E_PROPERTY_NAME ] ) );

	return true ;
}

CMD:propfee(playerid, params[]) {

	return cmd_propertyfee(playerid, params);
}
CMD:propertyfee(playerid, params[]) 
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL)
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3",  "Contact a General Admin or higher to set property fees.");
	}

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;
	if ( property_enum_id == INVALID_PROPERTY_ID ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't set the fee of a static property." );
	}

	new amount ;

	if ( sscanf ( params, "i", amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/propertyfee [amount] (0 to disable)" );
	}

	if ( amount < 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Entrance fee can't be less than 0." );
	}

	Property [ property_enum_id ] [ E_PROPERTY_FEE ] = amount ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_fee = %d WHERE property_id = %d", 

		Property [ property_enum_id ] [ E_PROPERTY_FEE ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3",  sprintf("You set the entrance fee to $%s.", IntegerWithDelimiter(amount) ) );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Set the entrance fee of Property %d (SQL: %d) to $%s", property_enum_id, Property [ property_enum_id ] [ E_PROPERTY_ID ], IntegerWithDelimiter(amount)));
	SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s set the entrance fee of Property %d (SQL: %d) to $%s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], property_enum_id, Property [ property_enum_id ] [ E_PROPERTY_ID ], IntegerWithDelimiter(amount)));


	return true ;
}

CMD:proprent(playerid, params[]) {

	return cmd_propertyrent(playerid, params);
}
CMD:propertyrent(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;


	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You can't rent a static property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3",  "You don't own this property!" );
	}

	new amount ;

	if ( sscanf ( params, "i", amount ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "/propertyrent [amount] (0 to disable)" );
	}

	if ( amount < 0 || amount > 250 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3",  "Rent price can't be less than 0 or more than 250." );
	}

	Property [ property_enum_id ] [ E_PROPERTY_RENT ] = amount ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_rent = %d WHERE property_id = %d", 

		Property [ property_enum_id ] [ E_PROPERTY_RENT ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3",  sprintf("Set rent fee to %d.", amount ) );

	return true ;
}

CMD:proplock(playerid, params[]) {

	return cmd_propertylock(playerid, params);
}

CMD:propertylock(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ANYWHERE );

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be close to your property, near the door." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't lock a static property." );
	}

	new access = Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] || Character[playerid][E_CHARACTER_RENTEDHOUSE] == Property[property_enum_id][E_PROPERTY_ID] || Character[playerid][E_CHARACTER_PROP_DUP] == Property[property_enum_id][E_PROPERTY_ID] ;

	if (!access)
	{
		if (GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR && PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) SendClientMessage(playerid, COLOR_YELLOW, "You're using your admin powers to lock/unlock this property." );
		else if (GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR) return SendClientMessage(playerid, -1, "You don't have normal access to this property, but can go on admin duty to do this.");
		else return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own or rent this property." );
	}	

	new address [ 64 ], zone [ 64 ] ;
	GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );

	if ( Property [ property_enum_id ] [ E_PROPERTY_LOCKED ] ) {

		Property [ property_enum_id ] [ E_PROPERTY_LOCKED ] = 0 ;
		SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", "You've unlocked your property." );
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Unlocked %d, %s %s (SQL: %d)", property_enum_id, address, zone, Property [ property_enum_id ] [ E_PROPERTY_ID ]));
	}

	else if ( ! Property [ property_enum_id ] [ E_PROPERTY_LOCKED ] ) {

		Property [ property_enum_id ] [ E_PROPERTY_LOCKED ] = 1 ;
		SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", "You've locked your property." );
		AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Locked %d, %s %s (SQL: %d)", property_enum_id, address, zone, Property [ property_enum_id ] [ E_PROPERTY_ID ]));
	}

	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_locked = %d WHERE property_id = %d", 

		Property [ property_enum_id ] [ E_PROPERTY_LOCKED ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query );

	return true ;
}



CMD:propfind(playerid, params[]) {

	return cmd_propertyfind(playerid, params);
}
CMD:bfind(playerid, params[]) {

	return cmd_propertyfind(playerid, params);
}
CMD:propertyfind(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new id = -1;

	if ( sscanf ( params, "i", id ) || id == -1 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/propertyfind [id]" );
	}

	if ( id < 0 || id > MAX_PROPERTIES ) {

		return SendServerMessage ( playerid, COLOR_PROPERTY, "Error", "A3A3A3", sprintf("The ID you entered is out of bounds! Can't be less than 0 or more than %d.", MAX_PROPERTIES ));
	}

	new access = Property[id][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_BIZ || Property [ id ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ];
	if (Property[id][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_HOUSE && Character[playerid][E_CHARACTER_RENTEDHOUSE] == Property[id][E_PROPERTY_ID]) access = 1;

	if (!access)
	{
		if (GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR) SendClientMessage(playerid, COLOR_YELLOW, "You're using your admin powers to find this property." );
		else return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have permission to find this property." );
	}	

	new Float: x, Float: y, Float: z ;

	x = Property [ id ] [ E_PROPERTY_EXT_X ] ; 
	y = Property [ id ] [ E_PROPERTY_EXT_Y ] ; 
	z = Property [ id ] [ E_PROPERTY_EXT_Z ] ; 

	new address [ 64 ], zone [ 64 ] ;
	GetCoords2DZone(x, y, zone, sizeof ( zone ));
	GetPlayerAddress(x, y, address );

	GPS_MarkLocation(playerid, sprintf("~y~%d %s, %s~w~ has been marked on your ~r~minimap~w~.", id, address, zone), E_GPS_COLOR_SCRIPT, x, y, z) ;

	return true ;
}

CMD:propbuy(playerid, params[]) {

	return cmd_propertybuy(playerid, params);
}

CMD:propertybuy(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;


	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	switch (  Property [ property_enum_id ] [ E_PROPERTY_TYPE ] ) {

		case E_PROPERTY_TYPE_STATIC: return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't buy this property." );
		case E_PROPERTY_TYPE_BIZ: {
		
			if ( Player_GetOwnedBusinesses ( playerid ) >= Player_GetMaxOwnedBusinesses ( playerid ) ) {

				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any business ownership slots left. Use /myslots to check." );
			}	
		}
		case E_PROPERTY_TYPE_HOUSE: {
			
			if ( Player_GetOwnedHouses ( playerid ) >= Player_GetMaxOwnedHouses ( playerid ) ) {

				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any house ownership slots left. Use /myslots to check." );
			}			
		}
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != INVALID_PROPERTY_OWNER ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is already owned by someone else." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_PRICE ] <= 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is not for sale." );
	}

	if ( GetPlayerCash ( playerid ) < Property [ property_enum_id ] [ E_PROPERTY_PRICE ] ) {


		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You don't have enough money. You need at least $%s. You have $%s.",

			IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_PRICE ]),  IntegerWithDelimiter(GetPlayerCash ( playerid )) 
		) ) ;

	}

	TakePlayerCash ( playerid, Property [ property_enum_id ] [ E_PROPERTY_PRICE ] ) ;

	Property [ property_enum_id ] [ E_PROPERTY_OWNER ] = Character [ playerid ] [ E_CHARACTER_ID ] ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d", 
		Property [ property_enum_id ] [ E_PROPERTY_OWNER ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	// Resetting property collect upon buying to avoid money hoarding / going out of bounds.
	Property [ property_enum_id ] [ E_PROPERTY_COLLECT ] = 0 ; 

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_collect = 0 WHERE property_id = %d",
		Property [ property_enum_id ] [ E_PROPERTY_ID ] ) ;
	
	mysql_tquery(mysql, query);

	new address [ 64 ], zone [ 64 ] ;
	GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );

	SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've bought %d %s, %s for $%s.", property_enum_id, address, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_PRICE ]) ) );

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Purchased %d, %s %s for $%s", property_enum_id, address, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_PRICE ])));

	foreach(new syncid: Player) {
		if ( IsPlayerInDynamicArea(syncid, Property [ property_enum_id ] [ E_PROPERTY_AREA ]  )) {

			PlayerTextDrawHide(syncid, house_info_box[playerid] );

			if (Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == playerid) {

				PlayerTextDrawSetString(playerid, house_info_box[playerid], sprintf("%s, %d~n~%s, Los Santos~n~~b~This is your property", address, property_enum_id, zone ) ) ;
			}

			else PlayerTextDrawSetString(syncid, house_info_box[playerid], sprintf("%s, %d~n~%s, Los Santos~n~~g~Player Owned", address, property_enum_id, zone ) ) ;

			PlayerTextDrawShow(syncid, house_info_box[playerid] );
		}
	}

	PlayerTextDrawHide(playerid, house_info_box[playerid]);

	return true ;
}

CMD:propsell(playerid, params[]) {

	return cmd_propertysell(playerid, params);
}


CMD:propertysell(playerid, params[]) {

	if (HasActivePropertyOffer[playerid]){
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You already have sent an active offer to someone.") ;
	}

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;
	new address [ 64 ], zone [ 64 ] ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't sell this property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != INVALID_PROPERTY_OWNER ) {

		if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is owned by someone else" );
		}
	}

	else if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == INVALID_PROPERTY_OWNER ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is already for sale!" );
	}

	new targetid, price ;

	if ( sscanf ( params, "k<player>i", targetid, price ) ) {

		SendClientMessage(playerid, COLOR_ERROR, "/propertysell [playerid] [price]" ) ;
		return SendClientMessage(playerid, COLOR_ERROR, "INFO: This command SELLS your property. Use /propertytransfer if you want to transfer it for free.");
	}

	if(targetid == playerid)
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You can't sell your property to yourself." );

	if ( ! IsPlayerConnected(targetid ) || !IsPlayerNearPlayer(playerid, targetid, 10.0) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Target isn't online or near you.");
	}

	if ( Property [property_enum_id] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_HOUSE && Player_GetOwnedHouses(targetid) >= Player_GetMaxOwnedHouses(targetid)) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your targetid doesn't have any house ownership slots left." );
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any house ownership slots left. Use /myslots to check." );

	} else if ( Property [property_enum_id] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_BIZ && Player_GetOwnedBusinesses(targetid) >= Player_GetMaxOwnedBusinesses(targetid) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your targetid doesn't have any business ownership slots left." );
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any business ownership slots left. Use /myslots to check." );
	}

	if(price <= 0) 
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't sell your property for $0. Use /propertytransfer to transfer it for free instead." );

	if(price > Character[targetid][E_CHARACTER_CASH])
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Your target doesn't have that much cash on hand.");

	SendClientMessage(playerid, COLOR_INFO, sprintf("[SELL] {DEDEDE}You have sent %s an offer to buy your property for {32CD32}$%s{DEDEDE}.", ReturnSettingsName(targetid, playerid), IntegerWithDelimiter(price)));
	SendClientMessage(targetid, COLOR_INFO, sprintf("[BUY] {DEDEDE}%s has sent you an offer to buy their property for {32CD32}$%s{DEDEDE}.", ReturnSettingsName(playerid, targetid), IntegerWithDelimiter(price)));

	GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );

	HasActivePropertyOffer[playerid] = true;

	inline PropSellConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) {

			HasActivePropertyOffer[playerid] = false;

			SendClientMessage(playerid, COLOR_INFO, sprintf("[SELL] {DEDEDE}%s has {db1233}declined{DEDEDE} your offer to buy your property.", ReturnSettingsName(targetid, playerid)));
			SendClientMessage(targetid, COLOR_INFO, sprintf("[BUY] {DEDEDE}You have {db1233}declined{DEDEDE} %s's offer to buy their property.", ReturnSettingsName(playerid, targetid)));

	    	return false ;
		}

		if ( response ) {

			HasActivePropertyOffer[playerid] = false;

			Property [ property_enum_id ] [ E_PROPERTY_OWNER ] = Character [ targetid ] [ E_CHARACTER_ID ] ;

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d", 
				Property [ property_enum_id ] [ E_PROPERTY_OWNER ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
			);

			mysql_tquery(mysql, query);

			// Resetting property collect upon buying to avoid money hoarding / going out of bounds.
			Property [ property_enum_id ] [ E_PROPERTY_COLLECT ] = 0 ; 

			mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_collect = 0 WHERE property_id = %d",
				Property [ property_enum_id ] [ E_PROPERTY_ID ] ) ;
			
			mysql_tquery(mysql, query);

			SendServerMessage ( targetid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've bought %d %s, %s for $%s.", property_enum_id, address, zone, IntegerWithDelimiter(price) ) );
			SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've sold %d %s, %s for $%s.", property_enum_id, address, zone, IntegerWithDelimiter(price) ) );

			AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Purchased property %d for $%s from %s", property_enum_id, IntegerWithDelimiter(price), ReturnPlayerName(playerid)));
			AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Sold property %d for $%s to %s", property_enum_id, IntegerWithDelimiter(price), ReturnPlayerName(targetid)));

			GivePlayerCash(playerid, price);
			TakePlayerCash(targetid, price);

			if(price <= 10000) {
				SendAdminMessage(sprintf("(%d) %s has sold their property (ID %d) to (%d) %s for a very small price ( < $10000 ).", playerid, ReturnMixedName(playerid), Property [ property_enum_id ] [ E_PROPERTY_ID ], targetid, ReturnMixedName(targetid)));
			}

			foreach(new syncid: Player) {
				if ( IsPlayerInDynamicArea(syncid, Property [ property_enum_id ] [ E_PROPERTY_AREA ]  )) {

					PlayerTextDrawHide(syncid, house_info_box[playerid] );
					PlayerTextDrawSetString(playerid, house_info_box[playerid], sprintf("%s, %d~n~%s, Los Santos", address, property_enum_id, zone) ) ;
					PlayerTextDrawShow(syncid, house_info_box[playerid] );
				}
			}

			PlayerTextDrawHide(playerid, house_info_box[playerid]);

			return true ;
		}

	}

	new confirmstring[1024];

	format(confirmstring, sizeof(confirmstring), "{DEDEDE}{ed7f2b}(%d) %s{DEDEDE} is offering to sell you their {ed7f2b}property{DEDEDE}.\n\n", playerid, ReturnSettingsName(playerid, targetid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Seller: {DEDEDE}%s\n", confirmstring, ReturnSettingsName(playerid, targetid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Buyer: {DEDEDE}%s\n", confirmstring, ReturnSettingsName(targetid, targetid));
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Address: {DEDEDE} %d, %s, %s\n", confirmstring, property_enum_id, address, zone);
	format(confirmstring, sizeof(confirmstring), "%s{A3A3A3}Price: {32CD32}$%s\n\n", confirmstring, IntegerWithDelimiter(price));
	strcat(confirmstring, "{DEDEDE}Make sure the property details and price are correct.\n");
	strcat(confirmstring, "Press {A3A3A3}Accept {DEDEDE}to confirm the sale.");

	Dialog_ShowCallback ( targetid, using inline PropSellConfirm, DIALOG_STYLE_MSGBOX, "{A3A3A3}PROPERTY PURCHASE CONFIRMATION", confirmstring, "Accept", "Decline" );

	return true ;
}


CMD:propertytransfer(playerid, params[]){


	if ( IsPlayerIncapacitated(playerid, false) ) {
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;
	new address [ 64 ], zone [ 64 ] ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't transfer this property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != INVALID_PROPERTY_OWNER ) {

		if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is owned by someone else" );
		}
	}

	else if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == INVALID_PROPERTY_OWNER ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is already for sale!" );
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		SendClientMessage(playerid, COLOR_ERROR, "/propertytransfer [playerid]" ) ;
		return SendClientMessage(playerid, COLOR_ERROR, "INFO: This command TRANSFERS your property. Use /propertysell if you want to sell it to someone.");
	}

	if(targetid == playerid)
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You can't transfer your property to yourself." );

	if ( ! IsPlayerConnected(targetid ) || !IsPlayerNearPlayer(playerid, targetid, 10.0) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "Target isn't online or near you.");
	}

	if ( Property [property_enum_id] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_HOUSE && Player_GetOwnedHouses(targetid) >= Player_GetMaxOwnedHouses(targetid)) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your targetid doesn't have any house ownership slots left." );
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any house ownership slots left. Use /myslots to check." );

	} else if ( Property [property_enum_id] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_BIZ && Player_GetOwnedBusinesses(targetid) >= Player_GetMaxOwnedBusinesses(targetid) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your targetid doesn't have any business ownership slots left." );
		return SendServerMessage ( targetid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any business ownership slots left. Use /myslots to check." );
	}

	SendClientMessage(playerid, COLOR_INFO, sprintf("[TRANSFER] {DEDEDE}You have transferred your property to %s.", ReturnSettingsName(targetid, playerid)));
	SendClientMessage(targetid, COLOR_INFO, sprintf("[TRANSFER] {DEDEDE}%s has sent transferred their property to you.", ReturnSettingsName(playerid, targetid)));

	GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );

	Property [ property_enum_id ] [ E_PROPERTY_OWNER ] = Character [ targetid ] [ E_CHARACTER_ID ] ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d", 
		Property [ property_enum_id ] [ E_PROPERTY_OWNER ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	// Resetting property collect upon buying to avoid money hoarding / going out of bounds.
    Property [ property_enum_id ] [ E_PROPERTY_COLLECT ] = 0 ; 

	mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_collect = 0 WHERE property_id = %d",
	    Property [ property_enum_id ] [ E_PROPERTY_ID ] ) ;
			
	mysql_tquery(mysql, query);

	AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Transferred property %d to %s", property_enum_id, ReturnPlayerName(targetid)));
	AddLogEntry(targetid, LOG_TYPE_SCRIPT, sprintf("Was transferred property %d from %s", property_enum_id, ReturnPlayerName(playerid)));

	foreach(new syncid: Player) {
	    if ( IsPlayerInDynamicArea(syncid, Property [ property_enum_id ] [ E_PROPERTY_AREA ]  )) {

			PlayerTextDrawHide(syncid, house_info_box[playerid] );
			PlayerTextDrawSetString(playerid, house_info_box[playerid], sprintf("%s, %d~n~%s, Los Santos", address, property_enum_id, zone) ) ;
			PlayerTextDrawShow(syncid, house_info_box[playerid] );
		}
	}

    PlayerTextDrawHide(playerid, house_info_box[playerid]);

	return true ;
}

 
CMD:propertyscrap(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;


	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_STATIC ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't buy this property." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != INVALID_PROPERTY_OWNER ) {

		if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is owned by someone else." );
		}
	}

	else if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] == INVALID_PROPERTY_OWNER ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This property is already for sale!" );
	}

	static ConfirmPropScrapStr[1024];

	inline ConfirmPropScrapDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You have cancelled the scrap, your property wasn't affected." ) ;
		}

		if ( response ) {

			Property [ property_enum_id ] [ E_PROPERTY_OWNER ] = INVALID_PROPERTY_OWNER ;
			GivePlayerCash ( playerid, Property [ property_enum_id ] [ E_PROPERTY_PRICE ] / 3 ) ;

			new query [ 256 ] ;

			mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d", 
				Property [ property_enum_id ] [ E_PROPERTY_OWNER ], Property [ property_enum_id ] [ E_PROPERTY_ID ]
			);

			mysql_tquery(mysql, query);

			new address [ 64 ], zone [ 64 ] ;
			GetCoords2DZone(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
			GetPlayerAddress(Property [ property_enum_id ] [ E_PROPERTY_EXT_X ], Property [ property_enum_id ] [ E_PROPERTY_EXT_Y ], address );

			SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You've sold %s, %d. You've been refunded some of the buy cost.", address, property_enum_id  ));

			AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Sold %d, %s %s (SQL: %d) for $%s", property_enum_id, address, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_PRICE ] / 3)));

			if ( Property [ property_enum_id ] [ E_PROPERTY_COLLECT ]  ) {
				SendServerMessage ( playerid, COLOR_PROPERTY, "Property", "A3A3A3", sprintf("You have received the remaining money in your property till: $%s.", IntegerWithDelimiter ( Property [ property_enum_id ] [ E_PROPERTY_COLLECT ] ) ) );

				GivePlayerCash ( playerid, Property [ property_enum_id ] [ E_PROPERTY_COLLECT ]  ) ;

				Property [ property_enum_id ] [ E_PROPERTY_COLLECT ] = 0 ; 

				mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_collect = 0 WHERE property_id = %d",
					Property [ property_enum_id ] [ E_PROPERTY_ID ] ) ;
				
				mysql_tquery(mysql, query);
			}

			foreach(new syncid: Player) {
				if ( IsPlayerInDynamicArea(syncid, Property [ property_enum_id ] [ E_PROPERTY_AREA ]  )) {

					PlayerTextDrawHide(syncid, house_info_box[playerid] );

					if ( Property [ property_enum_id ] [ E_PROPERTY_PRICE ] > 0 ) {
						PlayerTextDrawSetString(playerid, house_info_box[playerid], sprintf("%s, %d~n~%s, Los Santos~n~~r~For Sale: $%s", address, property_enum_id, zone, IntegerWithDelimiter(Property [ property_enum_id ] [ E_PROPERTY_PRICE ]) ) ) ;
					}

					else {
						PlayerTextDrawSetString(playerid, house_info_box[playerid], sprintf("%s, %d~n~%s, Los Santos", address, property_enum_id, zone) ) ;
					}

					PlayerTextDrawShow(syncid, house_info_box[playerid] );
				}
			}

			PlayerTextDrawHide(playerid, house_info_box[playerid]);

		}

		return true ;
	}

	format(ConfirmPropScrapStr, sizeof(ConfirmPropScrapStr), "{EC9424}Warning! {DEDEDE}This is a destructive action!");

	strcat(ConfirmPropScrapStr, "\n\n{DEDEDE}You are about to scrap and {EC9424}SELL{DEDEDE} your property.");
	strcat(ConfirmPropScrapStr, "\n{DEDEDE}You will only be refunded a 1/3 of the price you bought it for.");
	strcat(ConfirmPropScrapStr, "\n{DEDEDE}If you want to sell it to someone, use /propertysell.");
	strcat(ConfirmPropScrapStr, "\n\n{DEDEDE}Are you sure you want to continue?");
	strcat(ConfirmPropScrapStr, "\n{f1c38a}You will not be refunded if you change your mind.");

	Dialog_ShowCallback ( playerid, using inline ConfirmPropScrapDlg, DIALOG_STYLE_MSGBOX, "{EC9424}SCRAP WARNING{DEDEDE}", ConfirmPropScrapStr, "Scrap it", "Cancel" );

	return true ;
}


// new shit

static PropertiesDlgStr[2048];
static ShowPlayerProperties(playerid, showplayerid)
{
	new map[100];
	new count = 0;

	new address[64], zone[64];

	format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "Type\tAddress");
	
	foreach(new i: Properties) {
	
		if ( Property [ i ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) 
		{
			continue ;
		}

		if ( Property [ i ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && Character[playerid][E_CHARACTER_RENTEDHOUSE] != Property[i][E_PROPERTY_ID] )
		{
			continue;
		}

		address [ 0 ] = EOS, zone [ 0 ] = EOS ;

		GetCoords2DZone(Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
		GetPlayerAddress(Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], address );

		if (Property[i][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_BIZ) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\n{4FC3F7}Business\t%d %s, %s", PropertiesDlgStr, i, address, zone);
		else if (Character[playerid][E_CHARACTER_RENTEDHOUSE] == Property[i][E_PROPERTY_ID]) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\n{DCE775}Residence\t%d %s, %s (Rented)", PropertiesDlgStr, i, address, zone);
		else if (Property[i][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_HOUSE) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\n{AED581}Residence\t%d %s, %s", PropertiesDlgStr, i, address, zone);
		else format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nStatic\t%d %s, %s (SQL: %d)", PropertiesDlgStr, i, address, zone);

		map[count] = i;
		count ++;
	}

	if (!count)
	{
		if (playerid == showplayerid) SendClientMessage(showplayerid, COLOR_VEHICLE, "You don't own or rent any properties.");
		else SendClientMessage(showplayerid, COLOR_VEHICLE, "This player doesn't own or rent any properties.");
		return true;
	}

	inline MyPropertiesDlg(pid, dialogid, response, listitem, string:inputtext[]) 
	{
		#pragma unused dialogid, inputtext, listitem

		if ( response ) 
		{
			new chosen = map[listitem];

			if (response)
			{
				ShowPropertyToPlayer(playerid, chosen, pid);
			}
		}
	}

	Dialog_ShowCallback ( showplayerid, using inline MyPropertiesDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Properties of %s (%d)", ReturnSettingsName(playerid, showplayerid)), PropertiesDlgStr, "Select", "Close" );
	return true;
}

static ShowPropertyToPlayer(playerid, propid, showplayerid, bool:noback=false)
{
	new i = propid;
	new address[64], zone[64];

	GetCoords2DZone(Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], address );

	new query [ 256 ] ;
	inline ReturnPropertyShit() 
	{
		new charname[32], accname[32];
		if (cache_num_rows())
		{
			cache_get_value_name(0, "player_name", charname);
			cache_get_value_name(0, "account_name", accname);
			strreplace(charname, "_", " ");
		}


		format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "ID\t%d", propid);
		format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nSQL ID\t%d", PropertiesDlgStr, Property[i][E_PROPERTY_ID]);
		format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nAddress\t%d %s, %s", PropertiesDlgStr, propid, address, zone);
		if (Property[i][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_HOUSE) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nType\t%s", PropertiesDlgStr, "{AED581}Residence");
		else if (Property[i][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_BIZ) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nType\t%s", PropertiesDlgStr, "{4FC3F7}Business");
		else format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nType\t%s", PropertiesDlgStr, "Static");
		format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nLocked\t%s", PropertiesDlgStr, Property[i][E_PROPERTY_LOCKED] ? "{A5D6A7}Yes" : "{EF9A9A}No");
		
		if (cache_num_rows()) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nOwner\t%s (%s)", PropertiesDlgStr, charname, accname);
		else format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nOwner\t%s", PropertiesDlgStr, "{EF9A9A}None");

		format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nPrice\t$%s", PropertiesDlgStr, IntegerWithDelimiter(Property[i][E_PROPERTY_PRICE]));
		
		if (Property[i][E_PROPERTY_RENT])
		{
			format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nRentable\t{A5D6A7}Yes ($%s)", PropertiesDlgStr, IntegerWithDelimiter(Property[i][E_PROPERTY_RENT]));
		}
		else
		{
			format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nRentable\t%s", PropertiesDlgStr, "{EF9A9A}No");
		}

		if (Property[i][E_PROPERTY_FEE])
		{
			format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nEntrance Fee\t$%s", PropertiesDlgStr, IntegerWithDelimiter(Property[i][E_PROPERTY_FEE]));
		}
		else
		{
			format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nEntrance Fee\t%s", PropertiesDlgStr, "None");
		}
		
		if (Property [ i ] [ E_PROPERTY_OWNER ] == Character [ showplayerid ] [ E_CHARACTER_ID ] || GetPlayerAdminLevel(showplayerid))
		{
			new weapons = 0;
			for (new x = 0; x < 10; x ++)
			{
				if (Property [ i ] [ E_PROPERTY_GUN ] [ x ] && Property [ i ] [ E_PROPERTY_AMMO ] [ x ])
				{
					weapons ++;
				}
			}

			if (weapons) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nWeapons\t%d", PropertiesDlgStr, weapons);
			else format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nWeapons\t%s", PropertiesDlgStr, "None");

			new Float:drugs;
			for (new x = 0; x < 10; x ++)
			{
				if (Property [ i ] [ E_PROPERTY_DRUGS_AMOUNT ] [ x ] > 0)
				{
					drugs += Property [ i ] [ E_PROPERTY_DRUGS_AMOUNT ] [ x ];
				}
			}

			if (drugs) format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nDrugs\t%0.1fg", PropertiesDlgStr, drugs);
			else format(PropertiesDlgStr, sizeof(PropertiesDlgStr), "%s\nDrugs\t%s", PropertiesDlgStr, "None");
		}

		inline MyPropertiesDlg(pid, dialogid, response, listitem, string:inputtext[]) 
		{
			#pragma unused dialogid, inputtext, listitem

			if ( !response && !noback ) 
			{
				ShowPlayerProperties(playerid, pid);
				return true;
			}
		}

		if (!noback) Dialog_ShowCallback ( showplayerid, using inline MyPropertiesDlg, DIALOG_STYLE_TABLIST, sprintf("%d %s, %s", i, address, zone), PropertiesDlgStr, "OK", "Back" );
		else Dialog_ShowCallback ( showplayerid, using inline MyPropertiesDlg, DIALOG_STYLE_TABLIST, sprintf("%d %s, %s", i, address, zone), PropertiesDlgStr, "OK" );
	}

	mysql_format ( mysql, query, sizeof ( query ), "SELECT `characters`.`player_name`, `accounts`.`account_name` FROM `characters` JOIN `accounts` ON `accounts`.`account_id` = `characters`.`account_id` WHERE `player_id` = '%d'", Property [ i ] [ E_PROPERTY_OWNER ] ) ;
	MySQL_TQueryInline(mysql, using inline ReturnPropertyShit, query, "");

	return true;

}

CMD:checkproperties(playerid, params[]) {

	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/checkproperties [player]");

	if (!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, -1, "Target isn't connected.");

	ShowPlayerProperties(targetid, playerid);

	new string[100];
	format(string, sizeof(string), "used /checkproperties on (%d) %s", targetid, ReturnMixedName(targetid));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
	{
		format (string, sizeof ( string ), "[AdminCmd]: (%d) %s %s", playerid, ReturnMixedName(playerid), string);
		SendAdminMessage(string);
	}

	return true ;
}

CMD:propertycheck(playerid, params[])
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new id;

	if (sscanf(params, "d", id))
	{
		id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER );
	}

	if (id == INVALID_PROPERTY_ID)
	{
		return SendClientMessage(playerid, -1, "/propertycheck [property id]");
	}
		
	if ( id < 0 || id > MAX_PROPERTIES) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (doesn't exist)!") ;
	}

	if ( Property [ id ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid property ID entered (not set up)!") ;
	}

	ShowPropertyToPlayer(playerid, id, playerid, true);
	return true;
}

CMD:propcheck(playerid, params[])
{
	return cmd_propertycheck(playerid, params);
}

CMD:propinfo(playerid, params[])
{
	return cmd_propertycheck(playerid, params);
}

CMD:myproperties(playerid, params[]) 
{
	ShowPlayerProperties(playerid, playerid);
	return true ;
}

Property_ShowPlayerProperties(playerid, target ) {
	new address [ 64 ], zone [ 64 ] ;

	foreach(new i: Properties) {

		if ( Property [ i ] [ E_PROPERTY_ID ] == INVALID_PROPERTY_ID ) {

			continue ;
		}

		if ( Property [ i ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

			address [ 0 ] = EOS, zone [ 0 ] = EOS ;

			GetCoords2DZone(Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
			GetPlayerAddress(Property [ i ] [ E_PROPERTY_EXT_X ], Property [ i ] [ E_PROPERTY_EXT_Y ], address );

			SendClientMessage(target, 0x3A84C4FF, sprintf("[Owned Property]{DEDEDE} (id. %d) Located at %s, %s", i, address, zone ) );
		}

		else continue ;
	}

	return true ;
}

CMD:givepropertykey(playerid, params[]){ return cmd_pdup(playerid, params); }
CMD:givepropkey(playerid, params[]){ return cmd_pdup(playerid, params); }
CMD:givepkey(playerid, params[]){ return cmd_pdup(playerid, params); }
CMD:propertykey(playerid, params[]){ return cmd_pdup(playerid, params); }

CMD:pdup(playerid, params[]){

	if(IsPlayerIncapacitated(playerid, false))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't use this command right now.");
	
	new target;

	if(sscanf(params, "k<player>", target)) {
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/pdup [playerid]");
		return SendServerMessage ( playerid, COLOR_ERROR, "Warning", "A3A3A3", "Duplicate keys are saved. Use /changelock to revoke a key.");
	}

	if(!IsPlayerConnected(target))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target is not connected.");

	if(!IsPlayerNearPlayer(playerid, target, 10.0))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You need to be closer to your taget to give them the keys.");

	if(playerid == target)
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You already have keys to your own property.");

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_ENTER ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near a property entrance." );
	}

	if(Property[property_enum_id][E_PROPERTY_OWNER] != Character[playerid][E_CHARACTER_ID])
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only duplicate keys to properties you own!");

	SendServerMessage ( playerid, COLOR_SECURITY, "Keys", "A3A3A3", sprintf("You have given %s a pair of keys to your property.", ReturnSettingsName(target, playerid)));
	SendServerMessage ( target, COLOR_SECURITY, "Keys", "A3A3A3", sprintf("%s has given your a pair of keys to their property.", ReturnSettingsName(playerid, target)));

	GivePropertyKey(target, property_enum_id);

	return true;
}

GivePropertyKey(playerid, propid){

	new query[256];

	Character [ playerid ] [ E_CHARACTER_PROP_DUP ] = Property [propid] [E_PROPERTY_ID];

	format(query, sizeof(query), "UPDATE characters SET player_propdup = %d WHERE player_id = %d", Character [ playerid ] [ E_CHARACTER_PROP_DUP ], Character [ playerid ] [ E_CHARACTER_ID ] );
	mysql_tquery(mysql, query);

	return true;
}

CMD:duprevoke(playerid, params[]){ return cmd_changelock(playerid, params); }
CMD:changelock(playerid, params[]){

	if(IsPlayerIncapacitated(playerid, false))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't use this command right now.");
	
	new vehicleid = Vehicle_GetClosestEntity(playerid, .radius = 5.0);
	new propertyid = Property_GetClosestEntity(playerid, PROPERTY_NEAR_ENTER, .radius = 5.0);
	new type; 

	if ( vehicleid == INVALID_VEHICLE_ID && propertyid != INVALID_PROPERTY_ID) {
		type = 1;
	} else if(vehicleid != INVALID_VEHICLE_ID && propertyid == INVALID_PROPERTY_ID) {

		new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
		if ( veh_enum_id == -1 ) return SendClientMessage(playerid, COLOR_ERROR, "You're not near any proper vehicle! (couldn't fetch ID)");	
		type = 2;

	} else {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not near any vehicle / property entrance!");
	}

	new query[256];

	switch(type) {

		case 1: { // property

			new access = Property [ propertyid ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ];

			if(!access) {
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You do not own this property.");
			} else {
				SendServerMessage ( playerid, COLOR_SECURITY, "Lock", "A3A3A3", "You have changed your property's lock. No one but you can unlock / lock it now.");

				foreach(new userid: Player){

					if ( Character [ userid ] [ E_CHARACTER_PROP_DUP ] == Property [ propertyid ] [ E_PROPERTY_ID ] ) {
						Character [ userid ] [ E_CHARACTER_PROP_DUP ] = -1;
					} else continue;

				}

				format(query, sizeof(query), "UPDATE characters SET player_propdup = %d WHERE player_propdup = %d", -1, Property [ propertyid ] [ E_PROPERTY_ID ] );
				mysql_tquery(mysql, query);
			}
		}

		case 2: { // vehicle

			new veh_enum_id = Vehicle_GetEnumID ( vehicleid );
			new access = Vehicle [ veh_enum_id ] [ E_VEHICLE_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ];

			if(!access) {
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You do not own this vehicle.");
			} else {

				SendServerMessage ( playerid, COLOR_SECURITY, "Lock", "A3A3A3", "You have changed your vehicle's lock. No one but you can unlock / lock it now.");

				foreach(new userid: Player){

					if ( Character [ userid ] [ E_CHARACTER_VEH_DUP ] == Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] ) {
						Character [ userid ] [ E_CHARACTER_VEH_DUP ] = -1;
					} else continue;

				}

				format(query, sizeof(query), "UPDATE characters SET player_vehdup = %d WHERE player_vehdup = %d", -1, Vehicle [ veh_enum_id ] [ E_VEHICLE_SQLID ] );
				mysql_tquery(mysql, query);
			}
		}
	}

	return true;
}



HasPropertyDuplicateKey(playerid, propid){

	if( Character [playerid] [E_CHARACTER_PROP_DUP] == Property [propid] [E_PROPERTY_ID])
		return true;

	return false;
}

SOLS_IsPropertyRenter(playerid, prop_enum_id)
{
	if (Character[playerid][E_CHARACTER_RENTEDHOUSE] == Property[prop_enum_id][E_PROPERTY_ID]) return true;
	return false;
}

SOLS_IsPropertyOwner(playerid, prop_enum_id)
{
	if (Property[prop_enum_id][E_PROPERTY_OWNER] == Character[playerid][E_CHARACTER_ID]) return true;
	return false;
}

// Slots system


CMD:myslots(playerid) {

	/*
		Players can no longer own infinite houses / cars. This shows their used slots.
		In a future update, make this dependant on level / hours played.
	*/

	new owned_houses = Player_GetOwnedHouses ( playerid ) ;
	new max_houses  = Player_GetMaxOwnedHouses ( playerid ) ;

	new owned_bizzes = Player_GetOwnedBusinesses ( playerid ) ;
	new max_bizzes = Player_GetMaxOwnedBusinesses ( playerid ) ;

	new owned_cars = Player_GetOwnedVehicles ( playerid ) ;
	new max_cars = Player_GetMaxOwnedVehicles ( playerid );

	SendClientMessage ( playerid, COLOR_BLUE, "[Player Ownable Slots]:");

	SendClientMessage ( playerid, COLOR_GRAD0, sprintf("[Cars]{DEDEDE} %d / %d slots used.", owned_cars, max_cars )) ;
	SendClientMessage ( playerid, COLOR_GRAD0, sprintf("[House]{DEDEDE} %d / %d slots used.", owned_houses, max_houses )) ;
	SendClientMessage ( playerid, COLOR_GRAD0, sprintf("[Business]{DEDEDE} %d / %d slots used.", owned_bizzes, max_bizzes )) ;

	ZMsg_SendClientMessage ( playerid, COLOR_WARNING, "[Houses]{A3A3A3} (< 150 hours):{dedede} 1 house{a3a3a3} (> 150 hours, < 300 hours):{dedede} 2 houses{a3a3a3} (> 300 hours):{dedede} 3 houses");
	ZMsg_SendClientMessage ( playerid, COLOR_WARNING, "[Businesses]{A3A3A3} (< 100 hours):{dedede} 0 businesses{a3a3a3} (> 100 hours, < 300 hours):{dedede} 1 business{a3a3a3} (> 300 hours):{dedede} 2 businesses");
	ZMsg_SendClientMessage ( playerid, COLOR_WARNING, "[Vehicles]{A3A3A3} (< 150 hours):{dedede} 2 cars{a3a3a3} (> 150 hours, < 300 hours):{dedede} 3 cars{a3a3a3} (> 300 hours, < 500 hours):{dedede} 4 cars{a3a3a3} (> 500  hours):{dedede} 5 cars");


	return true ;
}


Player_GetOwnedHouses ( playerid ) {

	new count = 0 ;

	foreach(new i: Properties) {

		if ( Property [ i ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_HOUSE ) {
			if ( Property [ i ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				count ++ ;
			}

			else continue ;
		}
	}

	return count ;
}

Player_GetMaxOwnedHouses(playerid) {

	new max_houses = 1 ;

	if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 300) max_houses = 3;
	else if ( Character [ playerid ] [ E_CHARACTER_HOURS ] > 150 ) max_houses = 2;

	return max_houses ;
}

Player_GetOwnedBusinesses ( playerid ) {

	new count = 0 ;

	foreach(new i: Properties) {

		if ( Property [ i ] [ E_PROPERTY_TYPE ] == E_PROPERTY_TYPE_BIZ ) {
			if ( Property [ i ] [ E_PROPERTY_OWNER ] == Character [ playerid ] [ E_CHARACTER_ID ] ) {

				count ++ ;
			}

			else continue ;
		}
	}

	return count ;
}

Player_GetMaxOwnedBusinesses(playerid) 
{
	new max_businesses = 0 ;

	if (Character [ playerid ] [ E_CHARACTER_HOURS ] > 300)
	{
		max_businesses = 2;
	}
	else if (Character [ playerid ] [ E_CHARACTER_HOURS ] > 100)
	{
		max_businesses = 1;
	}
	
	return max_businesses ;
}