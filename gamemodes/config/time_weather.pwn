static enum WEATHER_IDS
{
	EXTRASUNNY_LA = 0,
	SUNNY_LA,
	EXTRASUNNY_SMOG_LA,
	SUNNY_SMOG_LA,
	CLOUDY_LA,
	SUNNY_SF,
	EXTRASUNNY_SF,
	CLOUDY_SF,
	RAINY_SF,
	FOGGY_SF,
	SUNNY_VEGAS,
	EXTRASUNNY_VEGAS,
	CLOUDY_VEGAS,
	EXTRASUNNY_COUNTRYSIDE,
	SUNNY_COUNTRYSIDE,
	CLOUDY_COUNTRYSIDE,
	RAINY_COUNTRYSIDE,
	EXTRASUNNY_DESERT,
	SUNNY_DESERT,
	SANDSTORM_DESERT,
	UNDERWATER
};

static const WEATHER_IDS:ServerWeatherIds[] = 
{
	EXTRASUNNY_LA, SUNNY_LA, EXTRASUNNY_SMOG_LA, SUNNY_SMOG_LA, CLOUDY_LA, EXTRASUNNY_COUNTRYSIDE, SUNNY_COUNTRYSIDE, CLOUDY_COUNTRYSIDE, RAINY_COUNTRYSIDE
};


task HandleIngameTime[4500]() {

	if ( Server [ E_SERVER_TIME_DAYS ] <= 0 ) {
		Server [ E_SERVER_TIME_DAYS ] = 1 ;
	}

	if ( Server [ E_SERVER_TIME_MONTHS ] < 0 ) {
		Server [ E_SERVER_TIME_MONTHS ] = 0 ;
	}

	if ( ++ Server [ E_SERVER_TIME_MINUTES ] >= 60 ) 
	{
		Server [ E_SERVER_TIME_MINUTES ] = 0 ;
		Server [ E_SERVER_WEATHER_TICK ] ++ ;

		if ( Server [ E_SERVER_WEATHER_TICK ] > 24 && (Server[E_SERVER_WEATHER] == _:RAINY_COUNTRYSIDE || random(4) == 0)) // Chance to change the weather every 24 ingame hours
		{ 
			Server [ E_SERVER_WEATHER_TICK ] = -1 ;

			new weather = _:ServerWeatherIds[random(sizeof(ServerWeatherIds))];
			SOLS_SetWeather(weather);

			SendClientMessageToAll( 0xA3A3A3FF, "The weather shifts...");
		}

		if ( ++ Server [ E_SERVER_TIME_HOURS] > 23 ) {
			if ( Server [ E_SERVER_TIME_DAYS ] > 31 ) {

				Server [ E_SERVER_TIME_DAYS ] = 1 ;

				if ( Server [ E_SERVER_TIME_MONTHS ] ++ >= 11 ) {

					Server [ E_SERVER_TIME_MONTHS ] = 1 ;
				}

				Server [ E_SERVER_TIME_HOURS] = 0 ;
			}

			else {

				new month = Server [ E_SERVER_TIME_MONTHS ] - 1 ;

				if ( month == -1 ) {
					month = 0 ;
				}

				if ( ++ Server [ E_SERVER_TIME_DAYS ] >= monthArray [ month ] [ month_days ])  {

					Server [ E_SERVER_TIME_DAYS ] = 1 ;

					if ( Server [ E_SERVER_TIME_MONTHS ] ++ >= 11 ) {

						Server [ E_SERVER_TIME_MONTHS ] = 1 ;
					}
				}

				Server [ E_SERVER_TIME_HOURS] = 0 ;
			}
		}

		if ( Server [ E_SERVER_TIME_HOURS ] == 20 ) 
		{
			// SendClientMessageToAll(COLOR_POLICE, "** The time is now 20:00 PM, remember to turn your headlights on until 7:00 AM. (( /lights ))");
		}

		// Update global worldtime var here.  Per player is done later.
		SetWorldTime(Server [ E_SERVER_TIME_HOURS ]);
	}


	new string [ 16 ] ;

	string [ 0 ] = EOS ;

	if ( Server [ E_SERVER_TIME_HOURS] < 10 ) {

		strcat(string, sprintf("0%d:", Server [ E_SERVER_TIME_HOURS] ) );
	}

	else strcat(string, sprintf("%d:", Server [ E_SERVER_TIME_HOURS] )) ;

	if ( Server [ E_SERVER_TIME_MINUTES ] < 10 ) {

		strcat(string, sprintf("0%d", Server [ E_SERVER_TIME_MINUTES] )) ;
	}
	else strcat(string, sprintf("%d", Server [ E_SERVER_TIME_MINUTES] )) ;


	UpdateGymStatsDay(); // updates the "day" in stats

	foreach(new playerid: Player) {
		PlayerTextDrawSetString(playerid, ptd_ph_design[playerid][10], string ) ;

		/*
		if ( Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN] ) {

			GUI_UpdateDateTimeLabel(playerid);
		}*/

		if ( IsPlayerLogged ( playerid ) ) {

			if ( IsPlayerSpawned ( playerid ) && PlayerVar [ playerid ] [ E_PLAYER_CHOSE_CHARACTER ] ) {
				SetPlayerTime(playerid, Server [ E_SERVER_TIME_HOURS], Server [ E_SERVER_TIME_MINUTES]);
				TextDrawSetString(hud_time, sprintf("%02d:%02d", Server [ E_SERVER_TIME_HOURS], Server [ E_SERVER_TIME_MINUTES ]) ) ;
				TextDrawShowForPlayer(playerid, hud_time ) ; 

				if ( ! Character [ playerid ] [ E_CHARACTER_HUD_CLOCK] ) {

					TextDrawHideForPlayer ( playerid, hud_time ); 
				}
			}

			//SetPlayerTime(playerid, Server [ E_SERVER_TIME_HOURS], Server [ E_SERVER_TIME_MINUTES]);
		}
	}
}

CMD:settime(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new hour, minute ;

	if ( sscanf ( params, "ii", hour, minute ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "/settime [hour] [minutes]") ;
	}

	new query [ 256 ] ;
	format ( query, sizeof ( query ), "[!!!] [AdmWarn] %s has has changed the time to [%d:%d]", Account[playerid][E_PLAYER_ACCOUNT_NAME], hour, minute  ) ;
	SendAdminMessage(query) ;

	SOLS_SetTime(hour, minute);
	return true ;
}


CMD:setweather(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new weather ;

	if ( sscanf ( params, "i", weather ) ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "/setweather [weather]") ;
	}

	new query [ 256 ] ;
	format ( query, sizeof ( query ), "[!!!] [AdmWarn] %s has has changed the weather to [%d]", Account[playerid][E_PLAYER_ACCOUNT_NAME], weather ) ;
	SendAdminMessage(query) ;

	SOLS_SetWeather(weather);
	return true ;
}

forward SOLS_OnWeatherChanged(old_weather, new_weather);
public SOLS_OnWeatherChanged(old_weather, new_weather)
{
	// Hook this shit
	return 1;
}

SOLS_SetWeather(weatherid)
{
	new oldweatherid = Server [ E_SERVER_WEATHER ];
	Server [ E_SERVER_WEATHER ] = weatherid ;

	// Global first
	SetWeather(weatherid);

	// Then, per player
	foreach(new i: Player)
	{
		SetPlayerWeather(i, weatherid);
	}

	// new, hookable
	CallLocalFunction("SOLS_OnWeatherChanged", "dd", oldweatherid, weatherid);
	return 1;
}

SOLS_SetTime(hour, minute)
{
	Server [ E_SERVER_TIME_HOURS ] = hour ;
	Server [ E_SERVER_TIME_MINUTES ] = minute - 1 ; // - 1 for update!
	
	// Global first
	SetWorldTime(hour);

	// Then, per player
	foreach(new i: Player)
	{
		SetPlayerTime(i, hour, minute);
	}

	return 1;
}

#include <YSI_Coding\y_hooks>

hook OnGameModeInit() 
{
	Server [ E_SERVER_TIME_HOURS] = 6 ;
	Server [ E_SERVER_TIME_MINUTES ] = 00 ;

	// Force weather change from default
	Server [ E_SERVER_WEATHER_TICK ] = 4 ;
	Server [ E_SERVER_TIME_DAYS ] = 1 + random ( 26 ) ;
	Server [ E_SERVER_TIME_MONTHS ] = random ( 10 ) ;

	// Set global time
	SetWorldTime(Server[E_SERVER_TIME_HOURS]);

	// Set global weather
	SetWeather(Server[E_SERVER_WEATHER]);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	SetPlayerWeather(playerid, Server [ E_SERVER_WEATHER ]);
	SetPlayerTime(playerid, Server [ E_SERVER_TIME_HOURS], Server [ E_SERVER_TIME_MINUTES]);
	return 1;
}