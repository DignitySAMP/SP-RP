
timer Phone_ConnectPlayer[1000](playerid, fromplayerid) {

	if ( ! IsPlayerConnected ( playerid ) || ! IsPlayerConnected ( fromplayerid ) || PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] || PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] ) {

		PlayerVar [ playerid ] [ player_phonecalling ] = INVALID_PLAYER_ID ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

		PlayerVar [ fromplayerid ] [ player_phonecalling ] = INVALID_PLAYER_ID ;
		PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = false ;
		PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
		PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
		PlayerVar [ fromplayerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(fromplayerid, 0, 0.0, 0.0, 0.0);

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The line died down." ) ;
		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The line died down." ) ;


		ApplyAnimation(fromplayerid,"PED", "phone_out", 4.1, 0, 0, 0, 0, 0);
		ApplyAnimation(playerid,"PED", "phone_out", 4.1, 0, 0, 0, 0, 0);

		PlayerTextDrawHide(fromplayerid, ptd_ph_design[playerid] [ 9 ] ) ;
		PlayerTextDrawColor(fromplayerid, ptd_ph_design[playerid][9], 0xFFFFFFFF);

		if ( PlayerVar [ fromplayerid ] [ player_viewphone ] ) {
			PlayerTextDrawShow(fromplayerid, ptd_ph_design[playerid] [ 9 ] ) ;
		}

		PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ 9 ] ) ;
		PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], 0xFFFFFFFF);

		if (  PlayerVar [ playerid ] [ player_viewphone ] ) {
			PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ 9 ] ) ;
		}

		for(new i, j = 3 ; i < j ; i ++ ) {
			PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ i ] ) ;
			PlayerTextDrawHide(fromplayerid, ptd_ph_popup[playerid] [ i ] ) ;
		}

		return true ;
	}

	defer Phone_ConnectPlayer(playerid, fromplayerid);
	return true ;

}

static const DispatcherNames[11][16] = {"Monica", "Jacqueline", "Janette", "Kaitlin", "Shenelle", "Brandi", "Rosalia", "Carlos", "Andrea", "Jason", "Marcus" };

Phone_OnPlayerCallStaticNumber(playerid, number) {

	// !!!!!!!!!!!!! THIS MAKES THE PHONE POP UP INCASE HIDDEN SO THERE'S NO OVERLAP !!!!!!!!!!!!!
	if ( !PlayerVar [ playerid ] [ player_viewphone ] ) {
			
		for ( new i = 5, j = 13; i < j ; i ++ ) {

			PlayerTextDrawShow(playerid, ptd_ph_design[playerid][i]);
		}

		cmd_phone(playerid);
	}

	cmd_phanim(playerid);
	SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "To cancel animation, do /sa. To re-do it, use /ph(one)anim." ) ;


	PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = number ;

	PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 1 ], "Requesting Connection");
	PlayerTextDrawColor(playerid, ptd_ph_popup[playerid][1], PHONE_COLOUR_OK);

	PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 2 ], sprintf("%d", PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ]));

	for(new i, j = 3 ; i < j ; i ++ ) {
		PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ i ] ) ;
		PlayerTextDrawShow(playerid, ptd_ph_popup[playerid] [ i ] ) ;
	}


	switch ( number ) {

		case 726: // SAN
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Secretary says (phone): San Andreas Network hotline, Karen speaking.  Can I take a message?");
			SendServerMessage(playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Type your message now.") ;
		}

		case 311:
		{
			new dispatcher = random(sizeof(DispatcherNames));
			SendClientMessage(playerid, COLOR_YELLOW, sprintf("Line Operator says (phone): 3-1-1 Non Emergency, %s speaking.  Which department is your call for?", DispatcherNames[dispatcher]));
			SendServerMessage(playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Type \"Police Department\", \"Fire Department\" or \"City Services\".") ;
		}

		case 911: {
			new dispatcher = random(sizeof(DispatcherNames));
			SendClientMessage(playerid, COLOR_YELLOW, sprintf("Line Operator says (phone): 9-1-1 Emergency, %s speaking.  Which emergency service do you require?", DispatcherNames[dispatcher]));
			SendServerMessage(playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Type \"Police\", \"Fire\" or \"Medical\".") ;
		}

		case 666: {
			SendClientMessage(playerid, COLOR_YELLOW, "A voice says (phone): Hello, welcome to the V-Rock hotel in Las Venturas, how may I assist you?");
		}

		default: {

			SendClientMessage(playerid, COLOR_ERROR, "You've tried to dial a static number however it failed to connect.");

			for(new i, j = 3 ; i < j ; i ++ ) {
				PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ i ] ) ;
			}	


			PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;	
		}
	}




	return true ;
}


Phone_OnPlayerReceiveAlert(playerid, fromplayerid, type) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You can't reach the recipient." ) ;

		return true ;
	}

	if ( GetPlayerState ( playerid ) == PLAYER_STATE_SPECTATING ) {

		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You can't reach the recipient." ) ;

		return true ;
	}


	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] ) {

		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The number you're trying to call is currently occupied. Try again later." ) ;

		return true ;
	}

	if ( PlayerVar [ playerid ] [ player_phonecalling ] != INVALID_PLAYER_ID ) {

		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The number you're trying to call is currently occupied. Try again later." ) ;

		return true ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] || !IsPlayerConnected(playerid) ) {

		SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You can't reach the recipient." ) ;

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = false ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

		return true ;
	}


	// !!!!!!!!!!!!! THIS MAKES THE PHONE POP UP INCASE HIDDEN SO THERE'S NO OVERLAP !!!!!!!!!!!!!
	if ( !PlayerVar [ playerid ] [ player_viewphone ] ) {
			
		for ( new i = 5, j = 13; i < j ; i ++ ) {

			PlayerTextDrawShow(playerid, ptd_ph_design[playerid][i]);
		}

		cmd_phone(playerid);
	}

	if ( !PlayerVar [ fromplayerid ] [ player_viewphone ] ) {
		
		for ( new i = 5, j = 13; i < j ; i ++ ) {

			PlayerTextDrawShow(fromplayerid, ptd_ph_design[playerid][i]);
		}

		cmd_phone(fromplayerid);
	}
	// !!!!!!!!!!!!! THIS MAKES THE PHONE POP UP INCASE HIDDEN SO THERE'S NO OVERLAP !!!!!!!!!!!!!

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] != 0 ) {
		// Player is already calling the timer for alerts. Let's not make it overflow.

		switch ( type ) {

			case PHONE_ALERT_SMS: {
				PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ 8 ] ) ;
				PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], PHONE_COLOUR_MED);
				PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ 8 ] ) ;

				SendServerMessage( playerid, PHONE_COLOUR_MED, "Phone", "A3A3A3", "You've received a text message whilst your phone was ringing." ) ;
			}

			case PHONE_ALERT_CALL: 	{

				SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "The number you're trying to call is currently occupied. Try again later." ) ;
			}
		}

		return true ;	
	}

	switch ( type ) {

		case PHONE_ALERT_SMS: 	{
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 10 ;
			PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 1 ], "New Text Message");
			PlayerTextDrawColor(playerid, ptd_ph_popup[playerid][1], PHONE_COLOUR_MED);

			PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ 8 ] ) ;
			PlayerTextDrawColor(playerid, ptd_ph_design[playerid][8], PHONE_COLOUR_MED);
			PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ 8 ] ) ;

			PlayerTextDrawSetString(fromplayerid, ptd_ph_popup[playerid] [ 1 ], "Text Message Sent");
			PlayerTextDrawColor(fromplayerid, ptd_ph_popup[playerid][1], PHONE_COLOUR_OK);

			PlayerTextDrawHide(fromplayerid, ptd_ph_design[playerid] [ 8 ] ) ;
			PlayerTextDrawColor(fromplayerid, ptd_ph_design[playerid][8], 0xFFFFFFFF);
			PlayerTextDrawShow(fromplayerid, ptd_ph_design[playerid] [ 8 ] ) ;

		}

		case PHONE_ALERT_CALL: 	{ 
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 25 ;
			PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 1 ], "Incoming Call From");
			PlayerTextDrawColor(playerid, ptd_ph_popup[playerid][1], PHONE_COLOUR_MED);


			PlayerTextDrawHide(playerid, ptd_ph_design[playerid] [ 9 ] ) ;
			PlayerTextDrawColor(playerid, ptd_ph_design[playerid][9], PHONE_COLOUR_MED);
			PlayerTextDrawShow(playerid, ptd_ph_design[playerid] [ 9 ] ) ;

			///////

			cmd_phanim(fromplayerid);
			SendServerMessage( fromplayerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "To cancel animation, do /sa. To re-do it, use /ph(one)anim." ) ;


			PlayerTextDrawSetString(fromplayerid, ptd_ph_popup[playerid] [ 1 ], "Requesting Connection");
			PlayerTextDrawColor(fromplayerid, ptd_ph_popup[playerid][1], PHONE_COLOUR_OK);


			PlayerTextDrawHide(fromplayerid, ptd_ph_design[playerid] [ 9 ] ) ;
			PlayerTextDrawColor(fromplayerid, ptd_ph_design[playerid][9], PHONE_COLOUR_MED);
			PlayerTextDrawShow(fromplayerid, ptd_ph_design[playerid] [ 9 ] ) ;

		}
	}

	defer Phone_FlashAlert(playerid, type, 0, fromplayerid);

	PlayerTextDrawSetString(playerid, ptd_ph_popup[playerid] [ 2 ], sprintf("%d", Character [ fromplayerid ] [ E_CHARACTER_PHONE_NUMBER ]));
	PlayerTextDrawSetString(fromplayerid, ptd_ph_popup[playerid] [ 2 ], sprintf("%d", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ]));

	for(new i, j = 3 ; i < j ; i ++ ) {
		PlayerTextDrawHide(playerid, ptd_ph_popup[playerid] [ i ] ) ;
		PlayerTextDrawShow(playerid, ptd_ph_popup[playerid] [ i ] ) ;
		PlayerTextDrawHide(fromplayerid, ptd_ph_popup[playerid] [ i ] ) ;
		PlayerTextDrawShow(fromplayerid, ptd_ph_popup[playerid] [ i ] ) ;
	}

	return true ;
}

HandlePlayerPhoneCall(playerid, text[]) {
    
	new string [ 256 ], services[64] ;
	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] ) 
	{
		switch ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] ) {

			case 311: 
			{
				// Non emergency call service selection

				if (!strcmp(text, "Police", true) || !strcmp(text, "Police Department", true))
				{
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] = 1; // police
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 312; // next call stage
				}
				else if (!strcmp(text, "Fire", true) || !strcmp(text, "Fire Department", true)  || !strcmp(text, "Medical", true) || !strcmp(text, "EMS", true) || !strcmp(text, "Medic", true) || !strcmp(text, "Paramedics", true))
				{
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] = 2; // fire/ems
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 312; // next call stage
				}
				else if (!strcmp(text, "City Services", true) || !strcmp(text, "Government", true))
				{
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] = 3; // government
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 312; // next call stage
				}
				else
				{	
					SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Sorry, I don't understand.  Which department do you wish to contact?");
					SendServerMessage(playerid, 0xE83A2BFF, "Phone", "A3A3A3", "Type \"Police Department\", \"Fire Department\" or \"City Services\".") ;
					return 0;
				}

				text[0] = toupper(text[0]);

				format(string, sizeof(string), "says (phone): %s", text);
				ProxDetectorEx(playerid, (GetPlayerVirtualWorld(playerid) == 0 ? 15.0 : 10.0), 0xDEDEDEFF, "", string);
				SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Thank you, please leave your message now.");
				return 0;
			}

			case 312:
			{
				// Non emergency call description
				if (strlen(text) < 4)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Sorry, I didn't hear you.  Please leave your message again.");
					return 0;
				}

				format(string, sizeof(string), "says (phone): %s", text);
				ProxDetectorEx(playerid, (GetPlayerVirtualWorld(playerid) == 0 ? 15.0 : 10.0), 0xDEDEDEFF, "", string);

				new address [ 64 ], zone [ 64 ], Float: x, Float: y, Float: z  ;
				GetPlayerPos ( playerid, x, y, z ) ;
				
				if (GetPlayerVirtualWorld(playerid) > 0)
				{
					// They are probably in a property, so use the exterior of that if they are
					new property = Property_GetInside(playerid);
					if (property != INVALID_PROPERTY_ID)
					{
						x = Property [ property ] [ E_PROPERTY_EXT_X ]; 
						y = Property [ property ] [ E_PROPERTY_EXT_Y ]; 
						z = Property [ property ] [ E_PROPERTY_EXT_Z ];
					}
				}

				GetCoords2DZone(x, y, zone, sizeof ( zone ));
				GetPlayerAddress(x, y, address );

				Server [ E_SERVER_LAST_911_POS_X ] = x ;
				Server [ E_SERVER_LAST_911_POS_Y ] = y ;
				Server [ E_SERVER_LAST_911_POS_Z ] = z ;
				Server [ E_SERVER_LAST_911_TYPE ] = 0;

				format ( string, sizeof ( string ), "[Message]: %s", text ) ;

				new color = COLOR_FACTION; // police color
				if (PlayerVar[playerid][E_PLAYER_PHONE_EMERGENCY] == 2) color = COLOR_FIRE;

				foreach(new policeid: Player) {


					if ( Character [ policeid ] [ E_CHARACTER_FACTIONID ] ) {

						new faction_enum_id = Faction_GetEnumID(Character [ policeid ] [ E_CHARACTER_FACTIONID ] ); 

						if ( faction_enum_id != INVALID_FACTION_ID ) 
						{

							if ( (Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == 0 && PlayerVar[playerid][E_PLAYER_PHONE_EMERGENCY] == 1) || (Faction [ faction_enum_id ] [ E_FACTION_TYPE ] == 3 && PlayerVar[playerid][E_PLAYER_PHONE_EMERGENCY] == 2) ) 
							{
								SendClientMessage(policeid, color, sprintf("[311 Non-Emergency Call]: From: %d (Location: %s, %s)", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ], address, zone ) ) ;
								ZMsg_SendClientMessage(policeid, color, string);
								SendClientMessage(policeid, color, "To track this 311 call, type /lastalarm. (Puts GPS blip on map)" ) ;
							}
							else if ( IsPlayerInGovFaction(policeid) && PlayerVar[playerid][E_PLAYER_PHONE_EMERGENCY] == 3 )
							{
								SendClientMessage(policeid, color, sprintf("[311 Non-Emergency Call]: From: %d (Location: %s, %s)", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ], address, zone ) ) ;
								ZMsg_SendClientMessage(policeid, color, string);
							}

							else continue ;
						}

						else continue ;
					}

					else continue ;
				}

				Phone_HideCallTextDraws(playerid);

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

				SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Thank you.  Your chosen department has been notified of your call.");
				SendClientMessage(playerid, COLOR_ACTION, "** The line has been disconnected." );
				Phone_HideCallTextDraws(playerid);
				PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

				cmd_phone(playerid);
				cmd_stopanim(playerid, "");

				return 0;
			}

			case 726:
			{
				// SAN Hotline
				if (strlen(text) < 4)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Secretary says (phone): Sorry, I didn't hear you.  Please leave your message again.");
					return 0;
				}

				format(string, sizeof(string), "says (phone): %s", text);
				ProxDetectorEx(playerid, (GetPlayerVirtualWorld(playerid) == 0 ? 15.0 : 10.0), 0xDEDEDEFF, "", string);

				new address [ 64 ], zone [ 64 ], Float: x, Float: y, Float: z  ;
				GetPlayerPos ( playerid, x, y, z ) ;
				
				if (GetPlayerVirtualWorld(playerid) > 0)
				{
					// They are probably in a property, so use the exterior of that if they are
					new property = Property_GetInside(playerid);
					if (property != INVALID_PROPERTY_ID)
					{
						x = Property [ property ] [ E_PROPERTY_EXT_X ]; 
						y = Property [ property ] [ E_PROPERTY_EXT_Y ]; 
						z = Property [ property ] [ E_PROPERTY_EXT_Z ];
					}
				}

				GetCoords2DZone(x, y, zone, sizeof ( zone ));
				GetPlayerAddress(x, y, address );
				new color = COLOR_FACTION;

				foreach(new i: Player) 
				{
					if (IsPlayerInNewsFaction(i))
					{
						SendClientMessage(i, color, sprintf("[Secretary Forwards SAN (7-2-6) Hotline Call]: From %d", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) ) ;
						SendClientMessage(i, color, sprintf("[Call Location]: %s, %s", address, zone ) ) ;
						ZMsg_SendClientMessage(i, color, sprintf("[Message]: %s", text ) ) ;
					}
				}

				Phone_HideCallTextDraws(playerid);
				PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

				SendClientMessage(playerid, COLOR_YELLOW, "Secretary says (phone): Thank you, your message has been passed on to the news desk.");
				SendClientMessage(playerid, COLOR_ACTION, "** The line has been disconnected." );
				
				cmd_phone(playerid);
				cmd_stopanim(playerid, "");

				return 0;
			}

			case 911: 
			{
				// Emergency call service selection

				if (!strcmp(text, "Police", true))
				{
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] = 1; // police
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 912; // next call stage
				}
				else if (!strcmp(text, "Fire", true) || !strcmp(text, "Medical", true) || !strcmp(text, "EMS", true) || !strcmp(text, "Medic", true) || !strcmp(text, "Paramedics", true))
				{
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] = 2; // fire/ems
					PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 912; // next call stage
				}
				else
				{	
					SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Sorry, I don't understand.  Which emergency service do you require?");
					SendServerMessage(playerid, 0xE83A2BFF, "Phone", "A3A3A3", "Type \"Police\", \"Fire\" or \"Medical\".") ;
					return 0;
				}

				text[0] = toupper(text[0]);
				format(string, sizeof(string), "says (phone): %s", text);
				ProxDetectorEx(playerid, (GetPlayerVirtualWorld(playerid) == 0 ? 15.0 : 10.0), 0xDEDEDEFF, "", string);
				SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): And, what is your emergency?");
				return 0;
			}

			case 912:
			{
				// Emergency call description
				if (strlen(text) < 4)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Sorry, I didn't hear you.  What is your emergency?");
					return 0;
				}

				format(string, sizeof(string), "says (phone): %s", text);
				ProxDetectorEx(playerid, (GetPlayerVirtualWorld(playerid) == 0 ? 15.0 : 10.0), 0xDEDEDEFF, "", string);


				new address [ 64 ], zone [ 64 ], Float: x, Float: y, Float: z  ;
				GetPlayerPos ( playerid, x, y, z ) ;
				
				if (GetPlayerVirtualWorld(playerid) > 0)
				{
					// They are probably in a property, so use the exterior of that if they are
					new property = Property_GetInside(playerid);
					if (property != INVALID_PROPERTY_ID)
					{
						x = Property [ property ] [ E_PROPERTY_EXT_X ]; 
						y = Property [ property ] [ E_PROPERTY_EXT_Y ]; 
						z = Property [ property ] [ E_PROPERTY_EXT_Z ];
					}
				}

				GetCoords2DZone(x, y, zone, sizeof ( zone ));
				GetPlayerAddress(x, y, address );

				Server [ E_SERVER_LAST_911_POS_X ] = x ;
				Server [ E_SERVER_LAST_911_POS_Y ] = y ;
				Server [ E_SERVER_LAST_911_POS_Z ] = z ;
				Server [ E_SERVER_LAST_911_TYPE ] = 0;

				//if (IsPlayerInMallArea(playerid)) Server [ E_SERVER_LAST_911_TYPE ] = 1;
				
				format ( string, sizeof ( string ), "[Emergency]: %s", text ) ;
				format ( services, sizeof ( services ), "[Services Requested]: %s", PlayerVar[playerid][E_PLAYER_PHONE_EMERGENCY] == 1 ? "Police" : "Fire / EMS" ) ;

				new color = COLOR_FACTION; // police color
				if (PlayerVar[playerid][E_PLAYER_PHONE_EMERGENCY] == 2) color = COLOR_FIRE;

				foreach(new policeid: Player) 
				{
					if ( Character [ policeid ] [ E_CHARACTER_FACTIONID ] ) 
					{
						new faction_enum_id = Faction_GetEnumID(Character [ policeid ] [ E_CHARACTER_FACTIONID ] ); 

						if ( faction_enum_id != INVALID_FACTION_ID ) 
						{
							if (IsPlayerInPoliceFaction(policeid) || IsPlayerInMedicFaction(policeid)) 
							{
								SendClientMessage(policeid, color, sprintf("[Dispatch Forwards 911 Call]: From %d", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) ) ;
								SendClientMessage(policeid, color, sprintf("[Location]: %s, %s", address, zone ) ) ;
								ZMsg_SendClientMessage(policeid, color, services);
								ZMsg_SendClientMessage(policeid, color, string);
								SendClientMessage(policeid, color, "To track this 911 call, type /lastalarm. (Puts GPS blip on map)" ) ;
							}
						}
					}
				}

				Phone_HideCallTextDraws(playerid);

				PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

				if (PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] == 1)
				{	
					SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Thank you, the police have been notified of your location.");
				}	
				else if (PlayerVar [ playerid ] [ E_PLAYER_PHONE_EMERGENCY ] == 2)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Line Operator says (phone): Thank you, the fire and medical services have been notified of your location.");
				}
				
				SendClientMessage(playerid, COLOR_ACTION, "** The line has been disconnected." );
				Phone_HideCallTextDraws(playerid);
				PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

				cmd_phone(playerid);
				cmd_stopanim(playerid, "");

				return 0;
			}
		}
	}
	return 1;
}