enum RadioChannelData {
	radioch_name [ 32 ],
	radioch_url [ 128 ]
} ;


new RadioChannels [ ] [ RadioChannelData ] = {

 	//{ "[SOLS] Radio Los Santos",			"http://tachyon.shoutca.st:8136/stream"},
 	//{ "[SOLS] Playback FM",					"http://pollux.shoutca.st:8527/stream"},
 	{ "[SOLS] Los Oldies",					"http://pollux.shoutca.st:8242/stream"},
 	//{ "[COMMUNITY] Music Box Ent.","https://stream.radio.co/s6b841d535/listen"},
	//{ "[COMMUNITY] Bliss FM", 				"http://stream.zeno.fm/y56e9s0xwwzuv" },
	//{ "[COMMUNITY] Vermillion FM",			"https://node-09.zeno.fm/aqf3hrkpgf9uv"},
	//{ "[COMMUNITY] Club Eleven Radio", 		"http://stream.zeno.fm/pes3gh1kbchvv"},
	//{ "[COMMUNITY] Pillow Talk FM", 		"http://stream.zeno.fm/ykf2asmukchvv"},
	//{ "[COMMUNITY] The Valley 88.8FM",      "http://stream.zeno.fm/z0cm7tu1uchvv"},
	//{ "[COMMUNITY] Empire Records",			"http://stream.zeno.fm/hc76na0u3ehvv"}, // GizzlyBear/Darnell Wilkinson
	//{ "[COMMUNITY] Front Yard FM",				"https://stream.zeno.fm/vichq0rkmmgvv"}, // misiek fyfm link
	{ "[COMMUNITY] Front Yard FM",				"https://stream.zeno.fm/xvv7d2efe3etv"},
	{ "[COMMUNITY] LATIN GROOVE FM",				"https://stream.zeno.fm/068ez20mj5evv"},
	{ "[COMMUNITY] CHICANO SOUNDS FM",				"https://stream.zeno.fm/9ngmrucaqw8tv"},
	{ "[COMMUNITY] Ganton Classics", 		"https://stream.zeno.fm/xe56hbppxrhvv"},
	{ "[COMMUNITY] MOB FM", 				"https://stream.zeno.fm/yh46ordl2cduv "},
	{ "[COMMUNITY] Kelly Park FM",			"https://stream.zeno.fm/d9lsyj8k0zdtv"},
	{ "[HIPHOP] BIG FM - Oldschool Rap", 	"http://streams.bigfm.de/bigfm-oldschool-128-mp3" },
	{ "[HIPHOP] All Compton Rap",			"http://149.56.147.197:8716" },
	{ "[HIPHOP] 181.fm - Hiphop", 			"http://relay.181.fm:8068/" },
	{ "[HIPHOP] 90s90s Hiphop",				"http://streams.90s90s.de/hiphop/mp3-192/radiode/"},
	{ "[HIPHOP] One Hip Hop", 				"http://listen.one.hiphop/live.mp3" },
	{ "[HIPHOP] AMW HIPHOP",				"http://77.168.22.74:8008/"},
 	{ "[CLUB] Deep House Lounge", 			"http://198.15.94.34:8006/stream" },
 	{ "[CLUB] Puls FM", 					"http://tuner.pulsfm.de" },
 	{ "[CLUB] Gay / Dance FM", 				"http://icepool.silvacast.com/GAYFM.mp3" },
 	{ "[ROCK/COUNTY] 57 Chevy Radio", 		"https://listen1.outpostradio.com/chevy" },
 	{ "[ROCK/COUNTY] 181.fm - Rock 40", 	"http://mp3uplink.duplexfx.com:8028/" },
	{ "[ROCK/COUNTY] 181.fm - Highway", 	"http://mp3uplink.duplexfx.com:8018/" },
 	{ "[CLASSIC] Venice Classic Radio", 	"http://174.36.206.197:8000"  },
 	{ "[CLASSIC ROCK] The Eagle", 			"http://listen.livestreamingservice.com/181-eagle_128k.mp3"},
 	{ "[ROCK] Awesome 80's", 				"http://listen.livestreamingservice.com/181-awesome80s_128k.mp3"},
 	{ "[ALT] 90's Alternative", 			"http://listen.livestreamingservice.com/181-90salt_128k.mp3"},
 	{ "[DANCE] 90's Dance", 				"http://listen.livestreamingservice.com/181-90sdance_128k.mp3"},
 	{ "[RNB] 90's RNB", 					"http://listen.livestreamingservice.com/181-90srnb_128k.mp3"}
 	//{ "[RUSSIAN] Radio Blatnyak",			"https://pub0202.101.ru:8443/stream/personal/aacp/64/675938"}
} ;

CMD:boomboxlisten(playerid, params[]) {

	new index ;

	if ( sscanf ( params, "i", index ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/boomboxlisten [boombox-id]" ) ;
	}

	new boombox_id = Boombox_GetNearestEntity(playerid);

	if ( boombox_id != index ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near this boombox." ) ;
	}

	if ( strlen ( Boombox [ boombox_id ] [ E_BOOMBOX_STATION ] ) < 3  ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "This boombox isn't playing any music!" ) ;
	}

	SOLS_StopAudioStreamForPlayer(playerid);

	SOLS_PlayAudioStreamForPlayer(playerid, Boombox [ boombox_id ] [ E_BOOMBOX_STATION ], 
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ], Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ], 
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ], BOOMBOX_RADIUS, true 
	) ; 

	PlayerVar [ playerid ] [ E_PLAYER_LISTENING_BOOMBOX ] = boombox_id ;
	SendServerMessage ( playerid, COLOR_INFO, "Boombox", "DEDEDE", sprintf("You've attuned to boombox %d. You're listening to \"%s\".",
		boombox_id,
		Boombox [ boombox_id ] [ E_BOOMBOX_STATION ]
	) ) ;

	return true ;
}

CMD:setstation(playerid) {
	new boombox_id = Boombox_GetNearestEntity(playerid);

	if ( boombox_id != INVALID_BOOMBOX_ID || IsPlayerInAnyVehicle(playerid)) {

		if (IsPlayerInAnyVehicle(playerid) && !IsEngineVehicle(GetPlayerVehicleID(playerid)))
		{
			return SendClientMessage(playerid, -1, "You can't use radio stations with this vehicle." ) ;
		}

		if ( ! IsPlayerInAnyVehicle ( playerid ) && Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

			return SendClientMessage(playerid, -1, "You're not near a boombox that you own." ) ;
		}

		inline SetStation_Intro(pid, dialogid, response, listitem, string:inputtext[]) {

			#pragma unused pid, dialogid, inputtext

			if ( response ) {
				switch ( listitem ) {

					case 0: { // Official channels

						Boombox_ShowOfficialChannels(playerid) ;
					}

					case 1: { // Custom

						//SendClientMessage(playerid, COLOR_RED, "Custom channels are disabled because people can't stop using dodgy sites.");
						Boombox_EnterCustomChannel(playerid) ;
					}

					case 2: { // Turn off

						Boombox_DisconnectForPlayer	(playerid);
					}
				}
			}
		}

		Dialog_ShowCallback ( playerid, using inline SetStation_Intro, DIALOG_STYLE_LIST, "Set Radio Station", "Official Channels\nEnter Custom URL\nTurn Radio Off", "Select", "Close" );

	}

	else SendClientMessage(playerid, -1, "You're not near a boombox or in a vehicle." ) ;

	return true ;
}


Boombox_ShowOfficialChannels(playerid) {

	new string [ 1024 ] ;

	inline SetStation_Menu(pid, dialogid, response, listitem, string: inputtext[]) {

		#pragma unused pid, dialogid, inputtext 

		if ( ! response ) {

			return cmd_setstation(playerid);
		}

		if ( response ) {

			new boombox_id = Boombox_GetNearestEntity(playerid);

			if ( boombox_id != INVALID_BOOMBOX_ID && !IsPlayerInAnyVehicle ( playerid )) {

				format(Boombox [ boombox_id ] [ E_BOOMBOX_STATION ], 128, "%s", RadioChannels [ listitem ] [ radioch_url ] ) ;

				foreach ( new targetid: Player) {

					Boombox_SyncForPlayer( targetid ) ;
				} 

				SendClientMessage(playerid, -1, sprintf("You've changed boombox ID %d's channel to \"%s\".",  Boombox [ boombox_id ] [ E_BOOMBOX_ID ], RadioChannels [ listitem ] [ radioch_name ]  )) ;
				ProxDetectorEx ( playerid, 15.0, COLOR_ACTION, "*", sprintf("has changed the boombox's channel to \"%s\".", RadioChannels [ listitem ] [ radioch_name ] )) ;
			}

			else {


				if ( IsPlayerInAnyVehicle(playerid) )  {

					new vehicleid = GetPlayerVehicleID ( playerid );
					new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;


					format(VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ], 128, "%s", RadioChannels [ listitem ] [ radioch_url ] ) ;
					
					foreach ( new targetid: Player) {
						if ( IsPlayerSpawned ( targetid ) ) {

							if ( GetPlayerVehicleID(targetid) == GetPlayerVehicleID(playerid) ) {

								SOLS_StopAudioStreamForPlayer(targetid);
								SOLS_PlayAudioStreamForPlayer(targetid, VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] ); 
							}

							else continue ;
						}

						else continue ;
					} 

					SendClientMessage(playerid, -1, sprintf("You've changed the vehicle's channel to \"%s\".", RadioChannels [ listitem ] [ radioch_name ]  )) ;
					ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", sprintf("has changed the vehicles's channel to \"%s\".", RadioChannels [ listitem ] [ radioch_name ] ) ) ;

				}
			}
		}
	}
	for ( new i, j = sizeof ( RadioChannels ); i < j ; i ++ ) {

		format ( string, sizeof ( string ), "%s%s\n", string, RadioChannels [ i ] [ radioch_name ] ) ;
	}

	Dialog_ShowCallback ( playerid, using inline SetStation_Menu, DIALOG_STYLE_LIST, "Set Radio Station",string, "Select", "Back" );

	return true ;
}

Boombox_EnterCustomChannel(playerid) {


	inline SetStation_Menu(pid, dialogid, response, listitem, string: inputtext[]) {

		#pragma unused pid, dialogid, listitem 

		if ( ! response ) {

			return cmd_setstation(playerid);
		}

		if ( response ) {

			if ( strlen ( inputtext ) < 5 ) {

				SendClientMessage(playerid, -1, "Enter a proper channel name! Can't be less than 5 characters. ") ;
				//Boombox_EnterCustomChannel(playerid) ;
				
				//SendClientMessage(playerid, COLOR_RED, "Custom channels are disabled because people can't stop using dodgy sites.");

				return true ;
			}

			if ( ! CheckInputtextCrash ( playerid, inputtext )) {

				return true ;
			}		

			new boombox_id = Boombox_GetNearestEntity(playerid);

			if ( boombox_id != INVALID_BOOMBOX_ID && !IsPlayerInAnyVehicle ( playerid )) {

				format(Boombox [ boombox_id ] [ E_BOOMBOX_STATION ], 128, "%s", inputtext ) ;

				foreach ( new targetid: Player) {

					Boombox_SyncForPlayer( targetid, boombox_id ) ;
				} 

				SendClientMessage(playerid, -1, sprintf("You've changed boombox ID %d's channel to \"%s\".", Boombox [ boombox_id ] [ E_BOOMBOX_ID ], inputtext )) ;
				ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", "has changed the boombox's channel to a custom url.") ;
			}
			else {

				if ( IsPlayerInAnyVehicle(playerid) )  {

					new vehicleid = GetPlayerVehicleID ( playerid );
					new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;


					format(VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ], 128, "%s", inputtext ) ;
					
					foreach ( new targetid: Player) {
						if ( IsPlayerSpawned ( targetid ) ) {

							if ( GetPlayerVehicleID(targetid) == GetPlayerVehicleID(playerid) ) {

								SOLS_StopAudioStreamForPlayer(targetid);
								SOLS_PlayAudioStreamForPlayer(targetid, VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] ); 
							}

							else continue ;
						}

						else continue ;
					} 

					SendClientMessage(playerid, -1, sprintf("You've changed the vehicle's channel to \"%s\".", inputtext )) ;

					ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", "has changed the vehicle's channel to a custom url.") ;
				}
			}

		}
	}

	Dialog_ShowCallback ( playerid, using inline SetStation_Menu, DIALOG_STYLE_INPUT, "Set Radio Station: Custom", 
		"{DEDEDE}Enter a custom audio stream below.\n\nValid formats are mp3 and ogg/vorbis.\nA link to a .pls (playlist) file will play that playlist.\n\nAbusing this feature will result in punishment.", "Select", "Back" );

	return true ;
}

Boombox_DisconnectForPlayer(playerid) {

	new vehicleid = GetPlayerVehicleID ( playerid );
	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;
	new boombox_id = Boombox_GetNearestEntity(playerid);

	if ( boombox_id != INVALID_BOOMBOX_ID ) {
		Boombox [ boombox_id ] [ E_BOOMBOX_STATION ] [ 0 ] = EOS ;
		ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", "has turned the boombox OFF.", .annonated=true) ;

		foreach(new targetid: Player) {
			if ( IsPlayerInAnyDynamicArea ( targetid ) ) {

				for ( new i, j = sizeof ( Boombox ); i < j ; i ++ ) {

					if ( Boombox [ i ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

						if ( IsPlayerInDynamicArea(targetid, Boombox [ i ] [ E_BOOMBOX_AREAID ] ) ) {

							if ( IsPlayerInAnyVehicle(targetid)) {

								vehicleid = GetPlayerVehicleID ( targetid );
								veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

								if ( strlen ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] ) >= 3 ) {

									continue ;
								}
							}

							if ( PlayerVar [ targetid ] [ E_PLAYER_LISTENING_BOOMBOX ] == i ) {

								SOLS_StopAudioStreamForPlayer(targetid);
								PlayerVar [ targetid ] [ E_PLAYER_LISTENING_BOOMBOX ] = INVALID_BOOMBOX_ID ;

								//Boombox_SyncForPlayer(targetid, i ) ;
							}

							else continue ;
						}

						else continue ;
					}

					else continue ;
				}
			}
		}
	}

	else {

		if ( IsPlayerInAnyVehicle(playerid) )  {

			vehicleid = GetPlayerVehicleID ( playerid );
			veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

			VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] [ 0 ] = EOS ;
			ProxDetectorEx ( playerid,15.0, COLOR_ACTION, "*", "has turned the vehicle's radio station OFF.", .annonated=true) ;

			foreach(new targetid: Player) {

				if ( IsPlayerSpawned ( targetid ) && IsPlayerInAnyVehicle(targetid)) {

					if ( GetPlayerVehicleID(targetid) == GetPlayerVehicleID(playerid)) {

						SOLS_StopAudioStreamForPlayer(targetid);
						Boombox_SyncForPlayer(targetid);
					}
				}
			}
		}
	}

	return true ;
}

Boombox_SyncForPlayer(playerid, boombox_id=INVALID_BOOMBOX_ID) {

	if ( IsPlayerListeningToAudioStream(playerid) && IsPlayerSpawned ( playerid ) && IsPlayerLogged ( playerid )  ) {

		if ( boombox_id != INVALID_BOOMBOX_ID ) {
			SendClientMessage(playerid, COLOR_YELLOW, sprintf("An audio stream is overlapping. To listen to the new stream, use /b(oom)b(ox)listen %d.", boombox_id )) ;
		}

		else {
			SendClientMessage(playerid, COLOR_YELLOW, "An audio stream is overlapping. To listen to the new stream, use /b(oom)b(ox)listen [id]." ) ;
		}

		return true ;
	}

	new vehicleid, veh_enum_id ;

	if ( IsPlayerInAnyDynamicArea ( playerid ) ) {

		if ( IsPlayerInAnyVehicle(playerid)) {

			
			vehicleid = GetPlayerVehicleID ( playerid );
			veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

			if ( veh_enum_id != -1 ) {

				if ( strlen ( VehicleVar [ veh_enum_id ] [ E_VEHICLE_STATION ] ) >= 3 ) {

					return true ;
				}
			}

		}

		for ( new i, j = sizeof ( Boombox ); i < j ; i ++ ) {

			if ( Boombox [ i ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

				if ( IsPlayerInDynamicArea(playerid, Boombox [ i ] [ E_BOOMBOX_AREAID ] ) ) {
					if ( strlen ( Boombox [ i ] [ E_BOOMBOX_STATION ] ) >= 3  ) {

						if ( PlayerVar [ playerid ] [ E_PLAYER_LISTENING_BOOMBOX ] == INVALID_BOOMBOX_ID ) {

							SOLS_StopAudioStreamForPlayer(playerid);

							SOLS_PlayAudioStreamForPlayer(playerid, Boombox [ i ] [ E_BOOMBOX_STATION ], 
								Boombox [ i ] [ E_BOOMBOX_POS_X ], Boombox [ i ] [ E_BOOMBOX_POS_Y ], 
								Boombox [ i ] [ E_BOOMBOX_POS_Z ], BOOMBOX_RADIUS, true 
							) ; 

							PlayerVar [ playerid ] [ E_PLAYER_LISTENING_BOOMBOX ] = i ;

							return true ;
						}

						else continue ;
					}

					else continue ;
				}

				else continue ;
			}

			else continue ;
		}
	}

	return true ;
}
