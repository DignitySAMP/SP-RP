// Sporky: Hook this elsewhere if needed (example in sirens)
forward SOLS_OnSettingChanged(playerid, E_PLAYER_CHARACTER_DATA:setting);
public SOLS_OnSettingChanged(playerid, E_PLAYER_CHARACTER_DATA:setting) 
{
	// printf("Setting %d for %s changed to: %d", _:setting, ReturnPlayerNameData(playerid), Character[playerid][setting]);
	return 1;
}

Settings_GetTrademarkValue(playerid) {

	return Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK] ;
}
Settings_GetVehicleFadeValue(playerid) {

	return Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN] ;
}

Settings_GetDirectionValue(playerid) {

	return Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION ] ;
}

CMD:settings(playerid, params[]) {

 	new string [ 1024 ] ;

 	strcat(string, "Setting\tToggle\n");

 	inline PlayerGUISettings(pid, dialogid, response, listitem, string: inputtext[]) {
 		#pragma unused pid, dialogid, response, listitem, inputtext

 		if ( ! response ) {

 			return true ;
 		}

 		switch ( listitem ) {
 			case 0: { // watermark gui
 				if (Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK]  ) {

 					SendClientMessage(playerid, COLOR_INFO, "You've turned off the zone fadein textdraw." ) ;
 					Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK] = false ;
 				}

 				else if ( ! Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK]  ) {
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on the zone fadein textdraw." ) ;
 					Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK]  = true ;
 				}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_trademark = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

 				mysql_tquery(mysql, string);
 			}

 			case 1: { // date gui
 				if (Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN ]  ) {


 					Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN] = false ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off the vehicle fadein textdraw." ) ;
	    			PlayerTextDrawHide(playerid, vehicleTextDraw[playerid]);
	    			PlayerVehicleAlertFading [ playerid ]=false;
 				}
 				else if ( ! Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN]  ) {

 					Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN]  = true ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on the vehicle fadein textdraw." ) ;
 				}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_vehfadein = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

 				mysql_tquery(mysql, string);
 			}


 			case 2: {// vehicle gui

				Settings_OnVehicleToggleGUI(playerid);
				CallLocalFunction("SOLS_OnSettingChanged", "dd", playerid, _:E_CHARACTER_HUD_VEHICLE); // Sporky: new, hooked by sirens
 			} 

 			case 3: { // Gangzone
 
			 	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ] == 1 ) {

			 		Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ] = 0 ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off minimap gangzones." ) ;
 					GangZone_HideForPlayer(playerid);
			 	}

			 	else if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ] == 0 ) {

			 		Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ] = 1 ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on minimap gangzones." ) ;
					GangZone_ShowForPlayer(playerid) ;
			 	}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE accounts SET account_setting_gangzones = %d WHERE account_id = %d",
					Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]) ;

 				mysql_tquery(mysql, string);
				
 			}

 			case 4: { // voiceline sound

 				if ( Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND] ) {

					PlayerPlaySound(playerid, 0, 0, 0, 0);
 					Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND] = false ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off voiceline sounds." ) ;
 				}

 				else if ( ! Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND] ) {

 					Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND] = true ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on voiceline sounds." ) ;
 				}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_voicelines = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

 				mysql_tquery(mysql, string);
 			}

 			case 5: { // minigame tds

 				if ( Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ] ) {

					PlayerPlaySound(playerid, 0, 0, 0, 0);
 					Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ] = false ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off the minigame hud." ) ;
 				}

 				else if ( ! Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ] ) {

 					Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ] = true ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on the minigame hud." ) ;
 				}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_minigame = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

 				mysql_tquery(mysql, string);
				HideMinigameHelpBox ( playerid ) ;

				PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_MSG_CD ] = false ;
				PlayerVar [ playerid ] [ E_PLAYER_MINIGAME_MSG_CD_2 ] = false ;
 			}
			
 			case 6: { // nametag style

			 	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] ) {

			 		Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] = 0 ;
 					SendClientMessage(playerid, COLOR_INFO, "You've switched your namestyle to gang tags." ) ;
			 	}

			 	else if ( !Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] ) {

			 		Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] = 1 ;
 					SendClientMessage(playerid, COLOR_INFO, "You've switched your namestyle to Firstname_Lastname." ) ;
			 	}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE accounts SET account_namestyle = %d WHERE account_id = %d",
					Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]) ;

 				mysql_tquery(mysql, string);

 				UpdateTabListForPlayer ( playerid ) ;	
    			//UpdateTabListForPlayers(playerid);
 			}

 			case 7: { // tips

			 	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ] == 1 ) {

			 		Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ] = 0 ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off server tips / helpful messages." ) ;
			 	}

			 	else if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ] == 0 ) {

			 		Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ] = 1 ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on server tips / helpful messages." ) ;
			 	}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE accounts SET account_setting_tips = %d WHERE account_id = %d",
					Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]) ;

 				mysql_tquery(mysql, string);
 			} 

			case 8: { // blinkers

				if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ] == 1 ) {

					Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ] = 0 ;
					SendClientMessage(playerid, COLOR_INFO, "You've turned off the vehicle blinker keys.  You can still use /carblink" ) ;
				}

				else if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ] == 0 ) {

					Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ] = 1 ;
					SendClientMessage(playerid, COLOR_INFO, "You've turned on the vehicle blinker keys.  Press Y or N in a vehicle." ) ;
				}

				string [ 0 ] = EOS ;

				mysql_format(mysql, string, sizeof(string), "UPDATE accounts SET account_setting_blinkers = %d WHERE account_id = %d",
					Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ], Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]) ;

				mysql_tquery(mysql, string);
			} 									
 			case 9: { // date gui
 				if (Character [ playerid ] [ E_CHARACTER_HUD_CLOCK ]  ) {

 					Character [ playerid ] [ E_CHARACTER_HUD_CLOCK] = false ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off the server clock textdraw." ) ;
					TextDrawHideForPlayer(playerid, hud_time ) ; 
 				}
 				else if ( ! Character [ playerid ] [ E_CHARACTER_HUD_CLOCK]  ) {

 					Character [ playerid ] [ E_CHARACTER_HUD_CLOCK]  = true ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on the server clock textdraw." ) ;
					TextDrawShowForPlayer(playerid, hud_time ) ; 
 				}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_clock = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_HUD_CLOCK], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

 				mysql_tquery(mysql, string);
 			}

 			case 10: { // directional gui v2
				if (Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION ]  ) {

 					Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION] = false ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned off the directional compass textdraw." ) ;

					PlayerTextDrawHide(playerid, gui_direction [ playerid ] [ 0 ] );
					PlayerTextDrawHide(playerid, gui_direction [ playerid ] [ 1 ] );
					PlayerTextDrawHide(playerid, gui_direction [ playerid ] [ 2 ] );
 				}
 				else if ( ! Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION]  ) {

 					Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION]  = true ;
 					SendClientMessage(playerid, COLOR_INFO, "You've turned on the directional compass textdraw." ) ;

 					if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER) {
						PlayerTextDrawShow(playerid, gui_direction [ playerid ] [ 0 ] );
						PlayerTextDrawShow(playerid, gui_direction [ playerid ] [ 1 ] );
						PlayerTextDrawShow(playerid, gui_direction [ playerid ] [ 2 ] );
					}
 				}

 				string [ 0 ] = EOS ;

 				mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_hud_direction = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

 				mysql_tquery(mysql, string);
 			}
 		}

 	}

 	format(string, sizeof(string), "%sZone Fadein GUI:\t%s\n", 	string, (Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sVehicle Fadein GUI:\t%s\n",string, (Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sVehicle GUI:\t%s\n", 		string, (Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE]  ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sHUD Gangzone:\t%s\n",string, (Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_GZES] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sVoiceline Sound:\t%s\n", 	string, (Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sMinigame HUD:\t%s\n", 	string, (Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME ] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;

	if(Account [ playerid ] [ E_PLAYER_ACCOUNT_NAMESTYLE ] == 0) format(string, sizeof(string), "%sNametag Style:\t{5DB145}SOLS\n", string) ;
	else format(string, sizeof(string), "%sNametag Style:\t{B14545}Firstname_Lastname\n", string) ;


 	format(string, sizeof(string), "%sServer Tips:\t%s\n", string, (Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_TIPS ] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
	format(string, sizeof(string), "%sVehicle Blink Keys:\t%s\n", string, (Account [ playerid ] [ E_PLAYER_ACCOUNT_SETTINGS_BLNK ] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sServer Clock:\t%s\n", string, (Character [ playerid ] [ E_CHARACTER_HUD_CLOCK ] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;
 	format(string, sizeof(string), "%sDirectional HUD:\t%s\n", string, (Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION ] ) ? ("{5DB145}On") : ("{B14545}Off")  ) ;

	Dialog_ShowCallback ( playerid, using inline PlayerGUISettings, DIALOG_STYLE_TABLIST_HEADERS, "Player Settings", string, "Toggle", "Cancel" ) ;

	SendClientMessage(playerid, COLOR_YELLOW, "Also view /toghelp. Use /setchat to control talking animations." ) ;
 
	return true ;
}