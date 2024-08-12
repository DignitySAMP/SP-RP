#if !defined ADV_POS_X
	#define ADV_POS_X 1721.9359
#endif
#if !defined ADV_POS_Y
	#define ADV_POS_Y -1608.7891
#endif
#if !defined ADV_POS_Z
	#define ADV_POS_Z 13.5469
#endif

#if !defined ADV_PICKUP_MODEL
	#define ADV_PICKUP_MODEL 19807
#endif

#if !defined ADV_MAP_ICON
	#define ADV_MAP_ICON 36
#endif


Advert_Init() {

	print(" * [ADVERTISEMENTS] Loaded advertisements.") ;

	CreateDynamic3DTextLabel("[Advertisement Location]\n{DEDEDE}Available commands: /advert, /rumour",
		COLOR_BLUE, ADV_POS_X, ADV_POS_Y, ADV_POS_Z, 10.0, .testlos = 1 
	);

	CreateDynamicPickup(ADV_PICKUP_MODEL, 1,  ADV_POS_X, ADV_POS_Y, ADV_POS_Z ) ;
	CreateDynamicMapIcon(ADV_POS_X, ADV_POS_Y, ADV_POS_Z, ADV_MAP_ICON, 0 );

}


CMD:adminad(playerid, params[]) 
{
	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Acess Denied", "DEDEDE", "You don't have access to this command.");
	}

	new text[128];
	if ( sscanf ( params, "s[128]", text ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/adminad [advert text]" );
	}

	if ( strlen ( text ) < 6 || strlen ( text ) > 128 ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "Your text can't have less than 6 or more than 128 characters." );
	}

	new string [ 144 ] ;
	format ( string, sizeof ( string ), "[Advertisement] %s", text) ;
	ZMsg_SendClientMessageToAll( COLOR_ADV, string);
	SendAdminMessage(sprintf("[Last /adminad was done by (%d) %s [%s].]", playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] ) ) ;

	return true ;
}

static adcooldown = 0;
static rumorcooldown = 0;
static badcooldown = 0;
CMD:advert(playerid, params[]) {
	if ( ! IsPlayerInRangeOfPoint ( playerid, 5.0, ADV_POS_X, ADV_POS_Y, ADV_POS_Z ) && GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Advert", "DEDEDE", "You're not in range of the advertisment place!");
	}

	if (adcooldown && (gettime() - adcooldown) < 300)
	{
        SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You must wait %d seconds until another advertisement can be placed.", 300 - (gettime() - adcooldown) )) ;
		return SendClientMessage(playerid, COLOR_INFO, "Tip: You can \"/call 726\" to contact SAN, who can broadcast ads for you instead.");
	}

	new text [ 128 ] ;

	if ( sscanf ( params, "s[128]", text ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/advert [text] (you will be charged for text length)" );
	}

	if ( strlen ( text ) < 6 || strlen ( text ) > 128 ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "Your text can't have less than 6 or more than 128 characters." );
	}

    if ( ! CanPlayerUseGuns(playerid, 3) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use this feature yet." ) ;
	}

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {

		SendServerMessage( playerid, 0xE83A2BFF, "Phone", "A3A3A3", "You don't have a phone! How will people contact you? Buy one in an electronics store." ) ;

		return true ;
	}

	new price = 10 * strlen ( text )  ;

	if ( GetPlayerCash ( playerid ) < price ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You don't have enough money for this advertisement! You need at least $%s.", IntegerWithDelimiter ( price ) )) ;
	}

	TakePlayerCash(playerid, price ) ;

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "[Advertisement] %s [By: %d]", text, Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) ;
	ZMsg_SendClientMessageToAll( COLOR_ADV, string);
	DCC_SendAdvertisementMessage(0, string);

	SendAdminMessage(sprintf("[Last /advert was done by (%d) %s [%s].]", playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] ) ) ;
	adcooldown = gettime();

	return true ;
}


CMD:propertyadvert(playerid, params[]) {

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be inside your property, near the door." );
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_TYPE ] != E_PROPERTY_TYPE_BIZ ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only use this feature in a business." );
	}

	if (Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ])
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Only the business owner can post advertisements." );
	}

	if (badcooldown && (gettime() - badcooldown) < 600)
	{
        SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You must wait %d seconds until another business advertisement can be placed.", 600 - (gettime() - badcooldown) )) ;
		return SendClientMessage(playerid, COLOR_INFO, "Tip: You can \"/call 726\" to contact SAN, who can broadcast ads for you instead.");
	}

	new text [ 128 ] ;

	if ( sscanf ( params, "s[128]", text ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/bad(vert) [text] (you will be charged for text length)" );
	}

	if ( strlen ( text ) < 16 || strlen ( text ) > 100 ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "Your text can't have less than 16 or more than 100 characters." );
	}

    if ( ! CanPlayerUseGuns(playerid, 3) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use this feature yet." ) ;
	}

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {

		SendServerMessage( playerid, 0xE83A2BFF, "Phone", "A3A3A3", "You don't have a phone! How will people contact you? Buy one in an electronics store." ) ;

		return true ;
	}

	new price = 8 * strlen ( text )  ;

	if ( GetPlayerCash ( playerid ) < price ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You don't have enough money for this advertisement! You need at least $%s.", IntegerWithDelimiter ( price ) )) ;
	}

	TakePlayerCash(playerid, price ) ;
 
	new string [ 256 ] ;

	if(strcmp(Property [ property_enum_id ] [ E_PROPERTY_NAME ], "Undefined", true ) ) {
		format ( string, sizeof ( string ), "[%s] %s ((/propfind %d))",Property [ property_enum_id ] [ E_PROPERTY_NAME ], text, property_enum_id ) ;
	}
	else format ( string, sizeof ( string ), "[Business] %s ((/propfind %d))", text, property_enum_id ) ;
	ZMsg_SendClientMessageToAll( COLOR_BADV, string);
	DCC_SendAdvertisementMessage(1, string);

	SendAdminMessage(sprintf("[Last /propertyad was done by (%d) %s.]", playerid, Character [ playerid ] [ E_CHARACTER_NAME ] ) ) ;
	badcooldown = gettime();

	return true ;
}

CMD:badvert(playerid, params[]) return cmd_propertyadvert(playerid, params);
CMD:propad(playerid, params[]) return cmd_propertyadvert(playerid, params);
CMD:propertyad(playerid, params[]) return cmd_propertyadvert(playerid, params);

CMD:rumour(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		if ( ! IsPlayerInRangeOfPoint ( playerid, 5.0, ADV_POS_X, ADV_POS_Y, ADV_POS_Z ) ) {

			return SendServerMessage(playerid, COLOR_ERROR, "Advert", "DEDEDE", "You're not in range of the advertisment place!");
		}
	}

	if (rumorcooldown && (gettime() - rumorcooldown) < 600)
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You must wait %d seconds until another rumour can be sent.", 600 - (gettime() - rumorcooldown) )) ;

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/rumour [text] (you will be charged for text length)" );
	}

	if ( strlen ( text ) < 5 || strlen ( text ) > 144 ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "Your text can't have less than 5 or more than 144 characters." );
	}

    if ( ! CanPlayerUseGuns(playerid, 3) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use this feature yet." ) ;
	}

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {

		SendServerMessage( playerid, 0xE83A2BFF, "Phone", "A3A3A3", "You don't have a phone! How will people contact you? Buy one in an electronics store." ) ;

		return true ;
	}

	new price = 7 * strlen ( text )  ;

	if ( GetPlayerCash ( playerid ) < price ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You don't have enough money for this rumour! You need at least $%s.",
		IntegerWithDelimiter ( price ) )) ;
	}

	inline RumourAbuseWarning(pid, dialogid, response, listitem, string:inputtext[]) {

    	#pragma unused pid, dialogid, listitem, inputtext

		if ( response ) {

			TakePlayerCash(playerid, price ) ;

			new string [ 256 ] ;

			format ( string, sizeof ( string ), "[Rumour] %s", text ) ;
			ZMsg_SendClientMessageToAll( 0x2B8CC8FF, string);

			rumorcooldown = gettime();

			SendAdminMessage(sprintf("[Last /rumour was done by (%d) %s [%s]. If not related to events, punish them. ]",
				playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] ) ) ;
		}
	}

	new string [ 512 ] = "{D63C3C}WARNING:{DEDEDE} /rumour is only meant to be used for events.\n\n\
		It can not be used to defame another faction or to send random messages or adverts to the server.\n\n\
		If you are abusing this feature, you will be punished severely. Admins can see who use it.\n\n\
		Thanks for understanding." ;

	Dialog_ShowCallback(playerid, using inline RumourAbuseWarning, DIALOG_STYLE_MSGBOX, "{D63C3C}RUMOUR ABUSE WARNING:{DEDEDE}", string, "Proceed", "Cancel");

	return true ;
}

CMD:arumour(playerid, params[]) { return cmd_adminrumour(playerid, params); }
CMD:adminrumour(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You don't have access to this command.");
	}

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/adminrumour [text]" );
	}

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "[Rumour] %s", text ) ;
	ZMsg_SendClientMessageToAll( 0x2B8CC8FF, string);

	SendAdminMessage(sprintf("Last /adminrumour was done by (%d) %s [%s].",
	playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] ) ) ;

	return true ;
}