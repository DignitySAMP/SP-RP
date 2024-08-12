static ConfirmStr[1024];

CMD:logout(playerid, params[]) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] ) {
		return SendClientMessage(playerid, COLOR_ERROR, "You're already logging out! Wait for the timer to end." ) ;
	}

	if ( ! IsPlayerSpawned ( playerid ) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You can only do this command whilst you are spawned." ) ;
	}

	if ( IsPlayerInMinigame(playerid) ) {
		return SendClientMessage(playerid, COLOR_ERROR, "You can't do this command whilst playing a minigame." ) ;
	}
 

	inline LogoutConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( response ) {


			SendClientMessage(playerid, COLOR_BLUE, "Logout timer started: if you take damage during this time the timer will be cancelled." ) ;

			JT_RemovePlayerFromVehicle(playerid);
			TogglePlayerControllable(playerid, false);

			PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] = 10;
			defer OnPlayerLogout(playerid);
			SetPlayerArmedWeapon(playerid, 0);

			new query [ 1024 ] ;
			new Float: x, Float: y, Float: z, Float: a ;
			GetPlayerPos ( playerid, x, y, z ) ;
			GetPlayerFacingAngle(playerid, a);

			mysql_format ( mysql, query, sizeof ( query ), 
			"UPDATE characters SET player_last_pos_x = '%f', player_last_pos_y = '%f', player_last_pos_z = '%f', player_last_pos_a = '%f', player_last_pos_int = %d, player_last_pos_vw = %d, player_arrest_time = %d WHERE player_id = %d",
			x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), Character [ playerid ] [ E_CHARACTER_ARREST_TIME ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

			mysql_tquery(mysql, query);

		}
	}

	format(ConfirmStr, sizeof(ConfirmStr), "{FFFFFF}You are about to {AA3333}sign out{FFFFFF} and {AA3333}return to the main menu{FFFFFF}.\n{ADBEE6}- Only do this with a legitimate reason like switching to a different character.\n- Do not continue if you're currently involved in anything or would disturb others.\n\n{FFFFFF}Press {AA3333}Confirm{FFFFFF} to continue if you are certain.");

	Dialog_ShowCallback ( playerid, using inline LogoutConfirm, DIALOG_STYLE_MSGBOX, "Are you sure?", ConfirmStr, "Confirm", "Back");
	return true ;
}


timer OnPlayerLogout[1000](playerid) {

	new string [ 144 ] ;

	if( !IsPlayerConnected(playerid) )
		return true; 

	if ( IsPlayerPaused ( playerid ) ) {

		SendClientMessage(playerid, COLOR_YELLOW, "You can't tab out while using /logout! You must remain ingame to avoid desync.");

		PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_DMG ] = false ;
		TogglePlayerControllable(playerid, true);

		return true ;
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_DMG ] ) {

		SendClientMessage(playerid, COLOR_YELLOW, "You've taken damage whilst logging out. Timer cancelled. Move to a neutral zone.");
		SendClientMessage(playerid, COLOR_RED, "People will be alerted if you do /logout. If you abuse this, you WILL be punished!");

		string[0]=EOS;
		format ( string, sizeof ( string ), "[LOGOUT] (%d) %s (%s) has failed to log out because they have been damaged.", 
			playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]  ) ;

		SendAdminMessage(string) ;

		PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] = 0 ;
		PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_DMG ] = false ;
		TogglePlayerControllable(playerid, true);

		return true ;
	}

	if ( -- PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] <= 0 ) {
		string[0]=EOS;
		format ( string, sizeof ( string ), "[LOGOUT] (%d) %s (%s) has just used /logout.", 
			playerid, Character [ playerid ] [ E_CHARACTER_NAME ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]  ) ;

		SendAdminMessage(string) ;

		Logout_ResetVariables(playerid) ;

		return true; 
	}

	string[0]=EOS;
	format ( string, sizeof ( string ), "~w~~n~~n~~n~~n~~n~~n~Log-out Timer: ~n~~b~%d seconds left", PlayerVar [ playerid ] [ E_PLAYER_LOGOUT_TICK ] ) ;
	GameTextForPlayer(playerid, string, 950, 3 ) ;

	defer OnPlayerLogout(playerid);

	return true ;
}



Logout_ResetVariables(playerid) 
{
	PlayerVar [ playerid ] [ E_PLAYER_JUST_LOGGED_OUT ] = true; // gets reset below so dw

	if( strlen(Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]) < 3 || strlen(Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]) > 24 ) 
		return Kick(playerid);

	SetPlayerName(playerid, Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ] ) ;

	// Clears variables the same way as OnPlayerDisconnect.
	CloseConnection(playerid, 3);
	TogglePlayerSpectating(playerid, true);

	defer Logout_ResetVariables_Cont(playerid);

	return true ;
}

timer Logout_ResetVariables_Cont[1000](playerid) {

	StartConnection(playerid) ;

	defer OnPlayerFullyConnected[1000](playerid);	
}



StartConnection(playerid) {

	new acc_data_clear [ E_PLAYER_ACCOUNT_DATA ] ;
	Account [ playerid ] = acc_data_clear ;

	new char_buffer_clear [ E_PLAYER_CHARACTER_BUFFER_DATA ] ;
	for ( new i, j = MAX_CHARACTERS; i < j ; i ++ ) {
		CharacterBuffer [ playerid ] [ i ] = char_buffer_clear ;
	}

	new char_clear [E_PLAYER_CHARACTER_DATA ] ;
	Character [ playerid ] = char_clear ;

	new acc_vars_clear [PlayerVars] ;
	PlayerVar [ playerid ] = acc_vars_clear ;

	new job_vars_clear [ E_PLAYER_JOB_DATA ] ;
	PlayerJobVars [ playerid ] = job_vars_clear ;

	new session_clear [ SESSION_DATA ] ;
	Session [ playerid ] = session_clear ;


	PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] = -1 ;
	PlayerVar [ playerid ] [ E_PLAYER_SPAWNED_CHARACTER ] = false ;

	
	PlayerPlaySound(playerid, 0, 0, 0, 0);

	Attach_OnPlayerConnect(playerid);
	Pool_OnPlayerConnect(playerid);
	Basketball_OnPlayerConnect(playerid);
	//Poker_OnPlayerConnect(playerid);

	#warning This must be integrated under SOLS_OnCloseConnection. This is what sets up / removes variables.
	
	return true ;
}

static const DisconnectReason[4][] = 
{
	"Timeout/Crash",
	"Quit",
	"Kick/Ban",
	"Used /logout"
};

static DisconQueryStr[512];

CloseConnection(playerid, reason) 
{
	// * All the old horrible unhooked systems (don't put anything that saves stuff here)
	Basketball_OnPlayerDisconnect(playerid) ;
	OnDestroyPlayerTextdraws(playerid);
	Minigame_ResetVariables(playerid);
	GPS_OnPlayerDisconnect ( playerid );
	Boombox_OnOwnerDisconnect(playerid);

	// * Any misc variables that need cleared on disconnect specifically:
	PlayerVar [ playerid ] [ E_PLAYER_ADMIN_CONVO ] = -1 ;
	//PlayerVar [ playerid ] [ E_PLAYER_SPAWNED_CHARACTER ] = false ;

	// * Other stuff
	if ( IsValidDynamicCP( PlayerVar [ playerid ] [ E_PLAYER_GPS_CP ]  ) ) 
	{
		DestroyDynamicCP(PlayerVar [ playerid ] [ E_PLAYER_GPS_CP ]  ) ;
	}

	SetPlayerChatBubble(playerid," ", 0xFFFFFFFF, 7.5, 10000);

	new keepduty = 0;
	if (PlayerVar[playerid][E_PLAYER_FACTION_DUTY])
	{
		keepduty = gettime() + 7200; // 2 hours
	}

	// * Now saving:
	DisconQueryStr[0] = EOS;
	
	if (IsPlayerLogged(playerid) && IsPlayerPlaying(playerid) && Character[playerid][E_CHARACTER_ID] > 0) 
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		mysql_format ( mysql, DisconQueryStr, sizeof ( DisconQueryStr ), 
			"UPDATE characters SET player_last_pos_x = '%f', player_last_pos_y = '%f', player_last_pos_z = '%f', player_last_pos_a = '%f', player_last_pos_int = %d, player_last_pos_vw = %d, player_arrest_time = %d, player_keep_duty = %d WHERE player_id = %d",
			x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), 
				Character [ playerid ] [ E_CHARACTER_ARREST_TIME ], keepduty, Character [ playerid ] [ E_CHARACTER_ID ] ) ;

		mysql_tquery(mysql, DisconQueryStr);

		if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) 
		{
			Weapon_ResetPlayerWeapons(playerid);
		}
		else
		{
			if (CanPlayerUseGuns(playerid, 8))
			{
				printf("CloseConnection: Saving weapons for (%d) %s (Char ID: %d)", playerid, TEMP_ReturnPlayerName(playerid), Character [ playerid ] [ E_CHARACTER_ID ]);
				Weapon_SavePlayerWeapons(playerid);
			}
		}

		
		// Pretty important that saving anything goes in here (you don't want to save stuff if they never properly logged in/spawned etc.)
		Gym_SaveVariables(playerid);
	}

	ResetPlayerWounds(playerid);
	Injury_RemoveVariables(playerid);
	Vehicle_OnPlayerDisconnect(playerid);

	// This calls our new hookable function
	CallLocalFunction("SOLS_OnCloseConnection", "dd", playerid, reason);

	// And finally show players the disconnection message (as long as they weren't a spectator)
	if (PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] == INVALID_PLAYER_ID)
	{
		ProxDetectorEx(playerid, 30.0, COLOR_GREEN, "[-]", sprintf("has disconnected (%s)", DisconnectReason[reason]));
	}

	AddLogEntry(playerid, LOG_TYPE_GAME, sprintf("Left the server (%s)", DisconnectReason [ reason ]));
}

#warning This is our "ResetPlayerVariables" - append it to replicate OnPlayerDisconnect
forward SOLS_OnCloseConnection(playerid, reason);
public SOLS_OnCloseConnection(playerid, reason)
{
	// You can hook this instead of OnPlayerDisconnect :)
	return 1;
}
