CMD:shout(playerid, params[]) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {
		
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't shout. Use /acceptdeath to continue.");
		return 0 ;
	}

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/shout [text]" ) ;
	}

	new Float:range = 30.0;

	if ( Character [ playerid ] [ E_CHARACTER_ARREST_TIME ] ) 
	{
		// Might help to stop the irritation of prisoners shouting for now
		range = 15.0;
	}

	new string[256];
	format(string, sizeof(string), "shouts: %s", text);
	ProxDetectorEx(playerid, range, 0xFCE7AEFF, "", string, .showtagcolor=true, .annonated=true); 

	format ( string, sizeof ( string ), "%s shouts: %s", ReturnMixedName(playerid), text ) ;
	SendMoleMessage(playerid, string);
	
	AddLogEntry(playerid, LOG_TYPE_CHAT, sprintf("Shouts: %s", text));

	return true ;
}
CMD:s(playerid, params[]) {

	return cmd_shout(playerid, params);
}

CMD:low(playerid, params[]) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {
		
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't speak. Use /acceptdeath to continue.");
		return 0 ;
	}

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/low [text]" ) ;
	}
	
	new string [ 256 ] ;

	if ( IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)) ) {
		new veh_enum_id = Vehicle_GetEnumID (GetPlayerVehicleID(playerid));

		if ( veh_enum_id != -1 ) {
			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] ) {// up

				foreach(new targetid: Player) {
					if ( GetPlayerVehicleID(targetid) == GetPlayerVehicleID ( playerid ) ) {

						format(string, sizeof(string), "(Windows Closed) %s says [low]: %s", ReturnSettingsName(playerid, targetid, true), text);
						ZMsg_SendClientMessage(targetid, 0xDEDEDEFF, string);
					}
				}
			}
			
			else if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] ) {// down
				format(string, sizeof(string), "says [low]: %s", text);
				ProxDetectorEx(playerid, 5.0, 0xA3A3A3FF, "(Windows Open)", string, .showtagcolor=true, .annonated=true); 
			}
		}
	}

	else {

		format(string, sizeof(string), "says [low]: %s", text);
		ProxDetectorEx(playerid, 5.0, 0xA3A3A3FF, "", string, .showtagcolor=true); 
	}

	PlayChatAnimation(playerid, text) ;
	SendMoleMessage(playerid, string);

	// NEW LOGGING: Log this as a LOG_TYPE_CHAT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_CHAT, sprintf("[low]: %s", text));

	return true ;
}

CMD:l(playerid, params[])
{
	return cmd_low(playerid, params);
}

IsPlayerDriveBying(playerid) {

	if ( GetPlayerState(playerid) == PLAYER_STATE_PASSENGER ) {

		if ( AC_GetPlayerWeapon ( playerid ) != 0 ) {

			return true ;
		}
	}

	return false ;
}

public OnPlayerText(playerid, text[]) 
{
	if (!IsPlayerSpawned(playerid) || !IsPlayerPlaying(playerid) || PlayerVar[playerid][E_PLAYER_LOGOUT_TICK])
	{
		return 0;
	}

	foreach (new i: Player) 
	{
		if ( ! IsPlayerLogged ( i ) || Account [ i ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] <= 0 ) 
		{
			continue ;
		}

		if ( PlayerVar [ i ] [ E_PLAYER_IS_SPECTATING ] == playerid ) 
		{
			SendClientMessage(i, 0xDEDEDEFF, sprintf("[SPEC]: (%d) %s said: %s", playerid, ReturnMixedName(playerid), text));
			continue ;
		}

		else continue ;
	}

	HandlePlayerPhoneCall(playerid, text);
	SendPlayerChatText(playerid, text);

	#if defined chat_OnPlayerText
		return chat_OnPlayerText(playerid, text[]);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif

#define OnPlayerText chat_OnPlayerText
#if defined chat_OnPlayerText
	forward chat_OnPlayerText(playerid, text[]);
#endif

CMD:t(playerid, params[])
{
	new text[128];
	
	if (sscanf(params, "s[128]", text))
	    return  SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3",  "/t [text]" );

	SendPlayerChatText(playerid, text);
	return true;
}

CMD:setchat(playerid, params[]) {
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
    new type;

	if (sscanf(params, "d", type))
	    return  SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3",  "/setchat [1-9] (or 0 to disable)" );

	if (type < 0 || type > 9)
	    return  SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3",  "Type can't be less than 0 or higher than 9." );

	Character [ playerid ] [ E_CHARACTER_CHAT_STYLE ] = type ;

	new query [ 128 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_chatstyle = %d WHERE player_id = %d", 
		Character [ playerid ] [ E_CHARACTER_CHAT_STYLE ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;

	
	if ( type == 0 ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You have removed your chat animation." ) ;
	}

 	SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", sprintf("You've changed your automatic chat animation style to %d.", type ) ) ;

	return 1;
}


CMD:to(playerid, params[]) {
	
	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {
		
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't speak. Use /acceptdeath to continue.");
		return 0 ;
	}

	new userid, text[144];

	if (sscanf(params, "k<player>s[128]", userid, text))
		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "/to [id] [text]" ) ;

	if (!IsPlayerConnected(userid))
		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "Player isn't connected." ) ;


	new Float: pos_x, Float: pos_y, Float: pos_z ;
	GetPlayerPos ( userid, pos_x, pos_y, pos_z ) ;

	if ( ! IsPlayerInRangeOfPoint ( playerid, 15.0, pos_x, pos_y, pos_z ) || GetPlayerInterior(userid) != GetPlayerInterior(playerid) || GetPlayerVirtualWorld(userid) != GetPlayerVirtualWorld(playerid)) {
		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You're not near the player you're trying to talk to!" ) ;
	}

	if(!GetPlayerPos ( playerid, pos_x, pos_y, pos_z )) return 0;

	new prox[256];
	new Float: max_range = 15.0;
	new color = 0xDEDEDEFF;
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if (vehicleid && IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(vehicleid)) 
	{
		new veh_enum_id = Vehicle_GetEnumID(GetPlayerVehicleID(playerid));
		
		if ( veh_enum_id != INVALID_VEHICLE_ID ) {
			if ( Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] ) {// up

				foreach(new targetid: Player) {
					if ( GetPlayerVehicleID(targetid) == GetPlayerVehicleID ( playerid ) ) {

						if(playerid == userid) {
							format ( prox, sizeof ( prox ), "(Windows Closed) %s{DEDEDE} says (to self): %s",  ReturnSettingsName(playerid, targetid, true), text ) ;
						} 
						else format ( prox, sizeof ( prox ), "(Windows Closed) %s{DEDEDE} says (to %s{DEDEDE}): %s",  ReturnSettingsName(playerid, targetid, true), ReturnSettingsName(userid, targetid, true), text ) ;
		
						ZMsg_SendClientMessage(targetid, 0xDEDEDEFF, prox);
						
					}
				}
			}		
			else if ( ! Vehicle [ veh_enum_id ] [ E_VEHICLE_WINDOW ] ) {// down
			
				new Float:range, Float:range_ratio, Float:max_ratio = 1.6, Float:range_with_ratio = (max_range * max_ratio), final_color;
				new clr_r, clr_g, clr_b, Float:color_r = float(color >> 24 & 0xFF), Float:color_g = float(color >> 16 & 0xFF), Float:color_b = float(color >> 8 & 0xFF);

				foreach(new i: Player) {
					range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);

					if (range > max_range) {
						continue ;
					}

					if(GetPlayerInterior(i) != GetPlayerInterior(playerid) || GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
						continue;

					range_ratio = (range_with_ratio - range) / range_with_ratio;
					clr_r = floatround(range_ratio * color_r);
					clr_g = floatround(range_ratio * color_g);
					clr_b = floatround(range_ratio * color_b);
					final_color = (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24);
								
					if(playerid == userid) {
						format(prox, sizeof(prox), "(Windows Open) %s{%06x} says (to self): %s", ReturnSettingsName(playerid, i, true), (final_color >>> 8), text);
					} 
					else format(prox, sizeof(prox), "(Windows Open) %s{%06x} says (to %s{%06x}): %s", ReturnSettingsName(playerid, i, true), (final_color >>> 8), ReturnSettingsName(userid, i, true), (final_color >>> 8), text);

					ZMsg_SendClientMessage(i, final_color, prox);

					format(prox, sizeof(prox), "says: %s", text);
					SetPlayerChatBubble(playerid, prox, color, 7.5, 5000);
				}
    		}
		}
	} else {

		if ( Character [ playerid ] [ E_CHARACTER_ARREST_TIME ] ) max_range = 7.5;
		else if ( GetPlayerVirtualWorld(playerid) != 0 ) max_range = 10.0;

		new Float:range, Float:range_ratio, Float:max_ratio = 1.6, Float:range_with_ratio = (max_range * max_ratio), final_color;
		new clr_r, clr_g, clr_b, Float:color_r = float(color >> 24 & 0xFF), Float:color_g = float(color >> 16 & 0xFF), Float:color_b = float(color >> 8 & 0xFF);

		foreach(new i: Player) {

			range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);

			if (range > max_range) {
				continue ;
			}

			if(GetPlayerInterior(i) != GetPlayerInterior(playerid) || GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
				continue;

			range_ratio = (range_with_ratio - range) / range_with_ratio;
			clr_r = floatround(range_ratio * color_r);
			clr_g = floatround(range_ratio * color_g);
			clr_b = floatround(range_ratio * color_b);
			final_color = (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24);
								
			if(playerid == userid) {
				format(prox, sizeof(prox), "%s{%06x} says (to self): %s", ReturnSettingsName(playerid, i, true), (final_color >>> 8), text);
			} 
			else format(prox, sizeof(prox), "%s{%06x} says (to %s{%06x}): %s", ReturnSettingsName(playerid, i, true), (final_color >>> 8), ReturnSettingsName(userid, i, true), (final_color >>> 8), text);

			ZMsg_SendClientMessage(i, final_color, prox);

			format(prox, sizeof(prox), "says: %s", text);
			SetPlayerChatBubble(playerid, prox, color, 7.5, 5000);
		}
		
		PlayChatAnimation(playerid, text);
	}

	return true;
}

CMD:whisper(playerid, params[]) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {
		
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't speak. Use /acceptdeath to continue.");
		return 0 ;
	}

	new userid, text[144];

	if (sscanf(params, "k<player>s[128]", userid, text))
		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "/whisper [id] [text]" ) ;

	if (!IsPlayerConnected(userid))
		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "Player isn't connected." ) ;

	if (  PlayerVar [ userid ] [ E_PLAYER_IS_SPECTATING ] == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }

    if ( userid == playerid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You can't whisper yourself." ) ;
    }

	new Float: x, Float: y, Float: z ;
	GetPlayerPos ( userid, x, y, z ) ;

	if ( ! IsPlayerInRangeOfPoint ( playerid, 2.5, x, y, z ) ) {

		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "You're not near the player you're trying to whisper!" ) ;
	}
 
	new string [ 384 ] ;

	format ( string, sizeof ( string ), "Whisper to %s{FFFF22}: %s", ReturnSettingsName(userid, playerid, true), text )  ;
	ZMsg_SendClientMessage(playerid, 0xFFFF22AA, string ); 

	// NEW LOGGING: Log this as a LOG_TYPE_CHAT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_CHAT, string);

	format ( string, sizeof ( string ), "%s{FFCC22} whispers: %s", ReturnSettingsName(playerid, userid, true), text )  ;
	ZMsg_SendClientMessage(userid, 0xFFCC2299, string );

	SendMoleMessage(playerid, string);
	SendAdminListen(playerid, string);

	ProxDetectorEx(playerid, 5.0, COLOR_ACTION, "", sprintf("mutters something to %s.", ReturnMixedName(userid)));
	
	return 1;
}

CMD:w(playerid, params[]){
	return cmd_whisper ( playerid, params ) ;
}

CMD:carwhisper(playerid, params[]) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_INJURY_TICK ] <= 0 ) {
		
		SendClientMessage(playerid, COLOR_ERROR, "You are dead and can't speak. Use /acceptdeath to continue.");
		return true;
	}

	if ( ! IsPlayerInAnyVehicle(playerid) ) 
	{
		SendClientMessage(playerid, COLOR_ERROR, "You are not in a vehicle.");
		return true;
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	if (!IsWindowedVehicle(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle with windows.");
	}

	new text[144], string[256];

	if (sscanf(params, "s[144]", text))
		return SendServerMessage( playerid, COLOR_ERROR, "Chat", "A3A3A3", "/c(ar)w(hisper) [text]" ) ;

	foreach (new userid: Player) 
	{
		if ( GetPlayerVehicleID(userid) == vehicleid) 
		{

			format (string, sizeof(string), "[%s] %s {D99564}whispers: %s", ReturnVehicleName(vehicleid), ReturnSettingsName(playerid, userid, true), text);
			ZMsg_SendClientMessage(userid, 0xD9956499, string );
		}
	}

	SendMoleMessage(playerid, string);
	SendAdminListen(playerid, string);

	// NEW LOGGING: Log this as a LOG_TYPE_CHAT for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_CHAT, sprintf("[%s] whispers: %s", ReturnVehicleName(vehicleid), text));

	ProxDetectorEx(playerid, 7.5, COLOR_ACTION, "", "mutters something inside the vehicle.");

	return true ;
}

CMD:cw(playerid, params[]){
	return cmd_carwhisper ( playerid, params ) ;
}

PlayChatAnimation(playerid, const text[])
{
	if (!Character[playerid][E_CHARACTER_CHAT_STYLE] || IsPlayerInMinigame(playerid) || IsPlayerIncapacitated(playerid, false) || IsPlayerDriveBying(playerid) || IsPlayerInAnyVehicle(playerid) || PlayerVar[playerid][E_PLAYER_LOOPING_ANIM] || PlayerVar[playerid][E_PLAYER_USING_HOSE])
	{
		// Do nothing.
		return true;
	}

	new anim = GetPlayerAnimationIndex(playerid );
	if (anim == 1189 || anim == 1186 || anim == 1275)
	{
		switch ( Character [ playerid ] [ E_CHARACTER_CHAT_STYLE ] ) 
		{
			case 1: ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.1, true, 0, 0, 1, 1);
			case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, true, 0, 0, 1, 1);
			case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.1, true, 0, 0, 1, 1);
			case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkC", 4.1, true, 0, 0, 1, 1);
			case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.1, true, 0, 0, 1, 1);
			case 6: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.1, true, 0, 0, 1, 1);
			case 7: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.1, true, 0, 0, 1, 1);
			case 8: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.1, true, 0, 0, 1, 1);
			case 9: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.1, true, 0, 0, 1, 1);
		}

		defer ClearChatAnim[1000 + (strlen(text)*60)](playerid);
	}

	return true;
}


timer ClearChatAnim[1000](playerid) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return true ;
    }

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);

	return true ;
}