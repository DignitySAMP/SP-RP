
SprayTag_DynamicCustomTextMenu(playerid) {
	static string[4096];
	inline SprayTag_CustomText(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if ( response ) {

			switch ( listitem ) {

				case 0: { // text

					inline SprayTag_CustomTextStr(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
						#pragma unused pidx, dialogidx, listitemx

						if ( responsex ) {

							if ( strlen ( inputtextx ) < 3 ) {

								SendClientMessage(playerid, -1, "You need at least 3 characters! You won't be able to spray!" ) ;

								SprayTag_DynamicCustomTextMenu(playerid) ;
								return true ;
							}

							if ( strlen ( inputtextx ) > 64 ) {

								SendClientMessage(playerid, -1, "You can only have 64 characters! Your text is cut off!" ) ;	

								SprayTag_DynamicCustomTextMenu(playerid) ;
								return true ;
							}
							
							mysql_escape_string(inputtextx, Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ], 64);

							string[0]=EOS;
							mysql_format ( mysql, string, sizeof ( string ), "UPDATE characters SET player_spraytag_dyn_text = '%e' WHERE player_id = %d",
								Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ], Character [ playerid ] [ E_CHARACTER_ID ]
							) ;

							mysql_tquery(mysql, string);
						}

						SprayTag_DynamicCustomTextMenu(playerid);
					}


					string[0]=EOS;
                    format ( string, sizeof string, "{DEDEDE}Enter some text for your graffiti tag.\n\n");

                    for (new colorid; colorid != sizeof g_VehicleColors; colorid++) {
                        format(string, sizeof string, "%s{%06x}%03d%s", string, g_VehicleColors[colorid] >>> 8, colorid, !((colorid + 1) % 16) ? ("\n") : (" "));
                    }

                    format ( string, sizeof string, "%s\n{DEDEDE}Note: Maximum of 64 characters and a minimum of 3 characters!", string);
                    format ( string, sizeof string, "%s\n\nUse (COLOR) to add a color. Example: (66)Test(1). Result: {341A1E}Test{FFFFFF}", string);
                    format ( string, sizeof string, "%s\nUse (n) to add a new line. Example: New line(n)test.\nResult: New line\ntest.", string);

                    Dialog_ShowCallback ( playerid, using inline SprayTag_CustomTextStr, DIALOG_STYLE_INPUT, "Custom Text Settings: String", 
                    	string, "Choose", "Back" ) ;
				}
				
				case 1: {// font color

					string[0]=EOS;
                    inline Graff_ColorSelect(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
                        #pragma unused pidx, dialogidx, listitemx

                     
                    	if(!responsex) {

                           	SprayTag_DynamicCustomTextMenu(playerid);
                            return true ;
                    	}

                     	if ( responsex ) {

                            if ( ! IsNumeric ( inputtextx ) ) {

                                SendClientMessage(playerid, -1, "Invalid color code entered. Only numerals allowed.");

                                SprayTag_DynamicCustomTextMenu(playerid);
                                return true ;
                            }

                            if ( strval ( inputtextx ) < 0 || strval ( inputtextx ) >= g_MaxVehicleColors ) {

                                SendClientMessage(playerid, -1, sprintf("Invalid color code entered. Enter a valid number! (0-%d)!", g_MaxVehicleColors - 1));
                                SprayTag_DynamicCustomTextMenu(playerid);
                                return true ;
                            }
 
                            PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ] = g_VehicleColors [ strval ( inputtextx ) ] ;
                            SendClientMessage(playerid, 0xDEDEDEFF, sprintf("> You've chosen {%06x}(%d){DEDEDE} as your desired tag color.", (PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ] >>> 8), inputtextx));

                            PlayerPlaySound(playerid, 1134, 0, 0, 0);
                           	SprayTag_DynamicCustomTextMenu(playerid);

                            return true ;
                        }
                    }

					string[0]=EOS;
                    format ( string, sizeof string, "{DEDEDE}Please choose a base color from the list below:\n\n");

                    for (new colorid; colorid != sizeof g_VehicleColors; colorid++) {
                        format(string, sizeof string, "%s{%06x}%03d%s", string, g_VehicleColors[colorid] >>> 8, colorid, !((colorid + 1) % 16) ? ("\n") : (" "));
                    }

                    format ( string, sizeof string, "%s\n{DEDEDE}You will be able to use extra formatting in the \"text\" option.", 
                    	string);

                    Dialog_ShowCallback ( playerid, using inline Graff_ColorSelect, DIALOG_STYLE_INPUT, "Choose base font colour for spray", 
                    	string, "Choose", "Back" ) ;

				}
			}

		}
	}

	new font_color = PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ]  ;

	if(!font_color ) {

		font_color = 0xDEDEDEFF ;
	}

	string[0]=EOS;
	format( string, sizeof ( string ), "Text: %s\n{%06x}Color",
		Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ],
		(font_color >>> 8)
	) ;

	Dialog_ShowCallback ( playerid, using inline SprayTag_CustomText, DIALOG_STYLE_LIST, 
		"Custom Text Settings", string, "Select", "Finish" );

	return true ;
}