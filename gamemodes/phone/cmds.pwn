

CMD:call(playerid, params[]) {

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You don't have a phone! Head to an electronics store to buy one!" ) ;

		return true ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] ) {

		return SendServerMessage ( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Your phone is turned off!" ) ;
	}


	new input[64];
	if ( sscanf ( params, "s[64]", input ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/call [number]" ) ;
		SendServerMessage(playerid, COLOR_ERROR, "Emergency", "A3A3A3", "PD/FD/EMS: 911");
		return SendServerMessage(playerid, COLOR_ERROR, "Non-Emergency", "A3A3A3", "PD/FD/EMS: 311, SAN: 726, Chuff: 732");
	}

	if ( ! PlayerVar [ playerid ] [ player_viewphone ]  ) {

		cmd_ph(playerid);
	}

	if ( IsNumeric ( input ) ) {

		new number = strval ( input ) ;

		if ( number <= 1 ) {
			return SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've entered an invalid number!") ;
		}


		switch ( number ) {

			case 911, 666, 311, 726, 732: {

				Phone_OnPlayerCallStaticNumber(playerid, number);
			}
			
			default: {
				new count ;

				foreach(new target: Player) {

					if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == number ) {

						if ( GetPlayerState ( playerid ) == PLAYER_STATE_SPECTATING ) {

							continue ;
						}

						Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_CALL ) ;
						count ++ ;
						break ;
					} 
					else continue ;
				}

				if ( ! count ) {
					SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("The number \"%d\" can't be reached.",number)) ;
					return true ;
				}
			}
		}
	}

	else if ( ! IsNumeric ( input ) ) {
		//Phone_ViewPhonebook_SQL(playerid,.view=false);
		CallRemoteNumberFromPhonebook(playerid, input);
	}

	return true ;
}

CMD:h(playerid) {

	return cmd_hangup(playerid);
}
CMD:hangup(playerid) {
	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] ) {

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You've hung up. Your recipient hasn't received your message!" ) ;
	}

	PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATIC_CALL ] = 0 ;

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] <= 0  && PlayerVar [ playerid ] [ player_phonecalling ] == INVALID_PLAYER_ID ) {
		for(new i, j = 3; i < j ; i ++ ) {

			PlayerTextDrawHide(playerid, ptd_ph_popup[playerid][i]);
		}
	}

	else {

		PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = true ;
	}

	return true ;
}

CMD:pickup(playerid) {

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {
		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You don't have a phone! Head to an electronics store to buy one!" ) ;
		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] != 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = true ;
	}

	else if ( PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] == 0 ) {

		if ( PlayerVar [ playerid ] [ player_phonecalling ] == INVALID_PLAYER_ID ) {

			Phone_ViewDialMenu ( playerid ) ;
		}

		else SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You're already in a call with someone." ) ;
	}

	else SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Make sure to cancel the alert in your phone before continuing." ) ;

	return true ;
}

CMD:phlow(playerid, params[])
{
	new text[144], string[256];

	if (sscanf(params, "s[144]", text))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/phlow [text]" ) ;
	}

	new targetid = PlayerVar [ playerid ] [ player_phonecalling ];

	if (targetid != INVALID_PLAYER_ID && IsPlayerConnected(targetid))
	{
		format(string, sizeof(string), "%s{FFFF00} says (phone) [low]: %s", ReturnSettingsName(playerid, targetid, true), text);
		ZMsg_SendClientMessage(targetid, COLOR_YELLOW, string);

		format(string, sizeof(string), "says (phone) [low]: %s", text);
		ProxDetectorEx(playerid, 7.5, 0xDEDEDEFF, "", string);
		return true;
	}

	return SendServerMessage ( playerid, PHONE_COLOUR_BAD, "Error", "A3A3A3", "You're not on a call with another player." ) ;
}

CMD:sms(playerid, params[]) {

	if ( ! Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) {

		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "You don't have a phone! Head to an electronics store to buy one!" ) ;

		return true ;
	}

	if ( ! PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] ) {

		return SendServerMessage ( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Your phone is turned off!" ) ;
	}

	new sms_target, sms_text [ 144 ], count = 0 ;

	if ( sscanf ( params, "is[144]", sms_target, sms_text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/sms [number] [text]" ) ;
	}
	
	if ( strlen ( sms_text ) < 0 || strlen ( sms_text ) > 144 ) {

		return SendServerMessage ( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", "Your text can't be less than 0 or more than 144 characters." ) ;
	}

	if (sms_target == 726)
	{
		// SAN Hotline, new.
		if (PlayerVar [ playerid ] [ E_PLAYER_HOTLINE_COOLDOWN ] && (gettime() - PlayerVar [ playerid ] [ E_PLAYER_HOTLINE_COOLDOWN ]) < 60)
		{
			return SendServerMessage ( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("You must wait %d seconds before sending another message to the hotline.", 60 - (gettime() - PlayerVar [ playerid ] [ E_PLAYER_HOTLINE_COOLDOWN ])) ) ;
		}

		foreach(new i: Player) 
		{
			if (IsPlayerInNewsFaction(i, true))
			{
				SendClientMessage(i, COLOR_FACTION, sprintf("[Received SAN (7-2-6) Hotline SMS]: From %d", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ] ) ) ;
				ZMsg_SendClientMessage(i, COLOR_FACTION, sprintf("[SMS Message]: %s", sms_text ) ) ;
			}
		}

		ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", "sends a message on their phone.", .annonated = true);
		SendClientMessage(playerid, COLOR_FACTION, sprintf("[SMS] to SAN (726): %s", sms_text));

		PlayerVar [ playerid ] [ E_PLAYER_HOTLINE_COOLDOWN ] = gettime();
		return true;
	}

	foreach(new target: Player) {

		if ( Character [ target ] [ E_CHARACTER_PHONE_NUMBER ] == sms_target ) 
		{
			ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", "sends a message on their phone.", .annonated = true);
			SendClientMessage(playerid, 0xDEC61FFF, sprintf("[SMS] to %d: %s", sms_target, sms_text));
			SMS_SendMessage(target, playerid, sms_text ) ;
			Phone_OnPlayerReceiveAlert(target, playerid, PHONE_ALERT_SMS ) ;
			count ++ ;
			break ;
		} 
		else continue ;
	}

	if ( ! count ) {
		SendServerMessage( playerid, PHONE_COLOUR_BAD, "Phone", "A3A3A3", sprintf("The number \"%d\" can't be reached.", sms_target)) ;
		return true ;
	}

	return true ;
}
