
enum E_PH_TXD_DATA {

	E_PH_DATA_DESC [ 64 ],
	E_PH_DATA_TXD [ 32 ],
	E_PH_DATA_MODEL
} ;

new Phone_Backgrounds [ ] [ E_PH_TXD_DATA ] = {

	{ "Santa Maria Beach", 		"mdl-29995:bg_0", 	-1 },
	{ "Juniper Flats", 			"mdl-29995:bg_1", 	-1 },
	{ "Verona Beach", 			"mdl-29995:bg_2", 	-1 },
	{ "Police Car", 			"mdl-29995:bg_3", 	-1 },
	{ "Jogging Girl", 			"mdl-29995:bg_4", 	-1 },
	{ "Unity Station", 			"mdl-29995:bg_5", 	-1 },
	{ "Oldtimer", 				"mdl-29995:bg_6", 	-1 },
	{ "Ganton Corner", 			"mdl-29995:bg_7", 	-1 },
	{ "Gym Gains", 				"mdl-29995:bg_8", 	-1 },
	{ "Muscle car", 			"mdl-29995:bg_9", 	-1 },
	{ "Ball Courts", 			"mdl-29995:bg_10", -1 },
	// New Reyo 19/07/20

	{ "Sanchez Wheelie", 		"mdl-29995:bg_11", -1 },
	{ "Let me Bounce", 			"mdl-29995:bg_12", -1 },
	{ "Suxxx", 					"mdl-29995:bg_13", -1 },
	{ "Sa-bay", 				"mdl-29995:bg_14", -1 },
	{ "East Los Santos", 		"mdl-29995:bg_15", -1 },
	{ "Alhambra Fever", 		"mdl-29995:bg_16", -1 },
	{ "Retro Skyline", 			"mdl-29995:bg_17", -1 },
	{ "Moneymaker", 			"mdl-29995:bg_18", -1 },
	{ "Aimed Pistol", 			"mdl-29995:bg_19", -1 },
	{ "Ghetto Bird", 			"mdl-29995:bg_20", -1 },
	{ "Ganton Danger", 			"mdl-29995:bg_21", -1 },
	{ "Sports Car", 			"mdl-29995:bg_22", -1 },
	{ "City Skyline", 			"mdl-29995:bg_23", -1 },
	{ "Seville", 				"mdl-29995:bg_24", -1 },
	{ "Narcotics", 				"mdl-29995:bg_25", -1 },
	{ "City Skyline 2", 		"mdl-29995:bg_26", -1 }
} ;

new Phone_Colours [ ] [ E_PH_TXD_DATA ] = {

	{ "Black", 			"mdl-29995:phone_black",		18868 },
	{ "Blue", 			"mdl-29995:phone_blue",			18866 },
	{ "Green", 			"mdl-29995:phone_green",		18871 },
	{ "Purple", 		"mdl-29995:phone_purple",		18869 },
	{ "Yellow", 		"mdl-29995:phone_yellow",		18873 },
	{ "White", 			"mdl-29995:phone_white",		18874 }
} ;

static PhoneSettingsDlgStr[2048];

Phone_FixBuggedBackground(playerid)
{
	// Fixes a previous bug where some players had wrong phone backgrounds
	if (Character[playerid][E_CHARACTER_PHONE_BACKGROUND] >= sizeof(Phone_Backgrounds))
	{
		Character[playerid][E_CHARACTER_PHONE_BACKGROUND] = Character[playerid][E_CHARACTER_PHONE_BACKGROUND] % sizeof(Phone_Backgrounds);
	}
}

Phone_ShowSettings(playerid) 
{
	inline phone_setting_dialog(pid, dialogid, response, listitem, string: inputtext[]) {
 		#pragma unused pid, dialogid, response, listitem, inputtext
		if ( response ) {
			switch ( listitem ) {

				case 0: {
					// bg
						inline phone_setting_dialog_bg(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
	 						#pragma unused pidx, dialogidx, responsex, listitemx, inputtextx
							
							if ( ! responsex ) {
								Phone_ShowSettings(playerid) ;
							}

							if ( responsex ) {
								Character [ playerid ] [ E_CHARACTER_PHONE_BACKGROUND ] = listitemx ;

								new query [ 256 ] ;

								mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_phbg = %d WHERE player_id = %d", 

									Character [ playerid ] [ E_CHARACTER_PHONE_BACKGROUND ], Character [ playerid ] [ E_CHARACTER_ID ]
								);

								mysql_tquery(mysql, query);

								SendServerMessage( playerid, PHONE_COLOUR_OK, "Phone", "A3A3A3", sprintf("Background changed to (%d) \"%s\".",
									Character [ playerid ] [ E_CHARACTER_PHONE_BACKGROUND ], Phone_Backgrounds [ listitemx ] [ E_PH_DATA_DESC ] )) ;

								PlayerTextDrawSetString(playerid, ptd_ph_design[playerid][5], Phone_Backgrounds [ listitemx ] [ E_PH_DATA_TXD ]);
							}
						}

						PhoneSettingsDlgStr[0] = EOS;

						for(new i, j = sizeof ( Phone_Backgrounds ); i < j ; i ++ ) {
							format(PhoneSettingsDlgStr, sizeof ( PhoneSettingsDlgStr ), "%s(%d) %s\n", PhoneSettingsDlgStr, i, Phone_Backgrounds [ i ] [ E_PH_DATA_DESC ] ) ;
						}

						Dialog_ShowCallback ( playerid, using inline phone_setting_dialog_bg, DIALOG_STYLE_LIST, "Change background", PhoneSettingsDlgStr, "Proceed", "Back" ) ;

				}

				case 1: {

					return Phone_ShowSettings(playerid) ;
				}
			}
		}
	}
	Dialog_ShowCallback ( playerid, using inline phone_setting_dialog, DIALOG_STYLE_LIST, "Settings", sprintf("{DEDEDE}Change Background\nPhone Credit: [{5CC44F}%d{DEDEDE}]", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]), "Proceed", "Cancel" ) ;
	return true ;
}
