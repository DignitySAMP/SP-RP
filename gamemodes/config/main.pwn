
Main_LoadDatabaseSettings() {

	inline Server_OnDataLoad() {
		if(cache_num_rows()) {
			cache_get_value_name_int(0, "server_slots_jackpot", Server [ E_SERVER_SLOTS_JACKPOT ]);

			cache_get_value_name ( 0, "server_slots_motd_1", Server[ E_SERVER_MOTD_STRING_1 ]);
			cache_get_value_name ( 0, "server_slots_motd_2", Server [ E_SERVER_MOTD_STRING_2 ]);
			cache_get_value_name ( 0, "server_slots_motd_3", Server [ E_SERVER_MOTD_STRING_3 ]);
			cache_get_value_name ( 0, "server_motd_editor", Server [ E_SERVER_MOTD_EDITOR ]);
			cache_get_value_name_int(0, "server_motd_edit_time", Server [ E_SERVER_MOTD_EDIT_TIME ]);

			cache_get_value_name_int(0, "server_chopshop_factionid", Server [ E_SERVER_CHOPSHOP_FACTIONID ]);
			cache_get_value_name_int(0, "server_chopshop_collect", Server [ E_SERVER_CHOPSHOP_COLLECT ]);
			cache_get_value_name_int(0, "server_admin_hex", Server [ E_SERVER_ADMIN_HEX ]);
			cache_get_value_name_int(0, "server_helper_hex", Server [ E_SERVER_HELPER_HEX ]);


			cache_get_value_name_float(0, "police_kiosk_x", Server [ E_SERVER_POLICE_KIOSK_X ]);
			cache_get_value_name_float(0, "police_kiosk_y", Server [ E_SERVER_POLICE_KIOSK_Y ]);
			cache_get_value_name_float(0, "police_kiosk_z", Server [ E_SERVER_POLICE_KIOSK_Z ]);
			cache_get_value_name_int(0, "police_kiosk_int", Server [ E_SERVER_POLICE_KIOSK_INT ]);
			cache_get_value_name_int(0, "police_kiosk_vw", Server [ E_SERVER_POLICE_KIOSK_VW ]);

			cache_get_value_name( 0, "server_song_url", Server [ E_SERVER_SONG_URL ]);

			Armory_LoadEntities () ;
		}
	}

	MySQL_TQueryInline(mysql, using inline Server_OnDataLoad, "SELECT * FROM server");

	//Server [ E_SERVER_RC_ENABLED ] = true ;
	Server [ E_SERVER_DC_ENABLED ] = true ;
	Server [ E_SERVER_SC_ENABLED ] = true ;
	Server [ E_SERVER_UPTIME ] = gettime () ; 
}

Main_LoadServerSettings() {
	//ImportGrandLarcenyVehicles();

    DisableInteriorEnterExits() ; 
    AllowInteriorWeapons(false);
    SetNameTagDrawDistance(20.0);

	DisableNameTagLOS() ;
	//ShowNameTags(false); // handles custom name script (UPDATE 07/07/2024): this the custom name script now bitch

	ShowPlayerMarkers ( PLAYER_MARKERS_MODE_OFF );
	SetGameModeText(SERVER_MODE);

	// Because SOLS uses special characters that go lost when encoding, we don't use this...
	SendRconCommand("hostname   "SERVER_HOSTNAME"");
	SendRconCommand("mapname 	"SERVER_MAP"	");
	SendRconCommand("weburl 	"SERVER_WEBSITE"");
	SendRconCommand("password 420ZazaBlazer69");
}