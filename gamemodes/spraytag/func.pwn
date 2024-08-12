
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if( newkeys & KEY_FIRE ) {

		if( AC_GetPlayerWeapon(playerid ) == WEAPON_SPRAYCAN ) {

			// Check if player is near static spray...
			if ( ! SprayTag_CheckStaticTagSpray(playerid) ) {

				if( SprayTag_IsPlayerNearStaticTag( playerid ) == -1 ) {
					SprayTag_CheckDynamicTagSpray(playerid);
				}
			}
		}
	}
	
	#if defined spray_OnPlayerKeyStateChange
		return spray_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange spray_OnPlayerKeyStateChange
#if defined spray_OnPlayerKeyStateChange
	forward spray_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


CMD:stchoose(playerid, params[]) {

	return cmd_spraytagchoose(playerid, params);
}

CMD:spraytagchoose(playerid, params[]) {

	new string [ 1024 ] ;

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	inline SprayTagList_Choose(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
		#pragma unused pidx, dialogidx, inputtextx

		if ( ! responsex ) {

			return true ;
		}

		switch ( listitemx ) {

			case 0: {
				string[0]=EOS;

				inline SprayTagList(pid, dialogid, response, listitem, string:inputtext[]) {
					#pragma unused pid, dialogid, inputtext

					if ( response ) {
						SendClientMessage(playerid, -1, sprintf("You chose \"%s\" (%d) as your spray tag. Spray some graffiti to make it show up.", tag_information [ listitem ] [ e_st_tag_name ], listitem ) ) ;

						Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ] = tag_information [ listitem ] [ tag_model_id ] ;

						string [ 0 ] = EOS ;
						mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_spraytag = %d WHERE player_id = %d", 
							Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ], Character [ playerid ] [ E_CHARACTER_ID ]
						) ;

						mysql_tquery(mysql, string);
					}
				}

				format ( string, sizeof ( string ), "Description\n" ) ;

				for ( new i, j = sizeof ( tag_information ); i < j ; i ++ ) {
					format ( string, sizeof ( string ), "%s%s\n",string, tag_information [ i ] [ e_st_tag_name ] ) ;
				}

				Dialog_ShowCallback ( playerid, using inline SprayTagList, DIALOG_STYLE_TABLIST_HEADERS, "Choose a Spray Tag", string, "Store", "Cancel" );
			}
			case 1: { 

				string[0]=EOS;

				SendClientMessage(playerid, -1, "You chose custom text as your spray tag. Spray some graffiti to make it show up");

				Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ] = 19482 ;


				mysql_format ( mysql, string, sizeof ( string ), "UPDATE characters SET player_spraytag_dynamic = %d WHERE player_id = %d",
					Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ], Character [ playerid ] [ E_CHARACTER_ID ]
				) ;

				mysql_tquery(mysql, string);


				SprayTag_DynamicCustomTextMenu(playerid);
			}
		}
   	}

	Dialog_ShowCallback ( playerid, using inline SprayTagList_Choose, DIALOG_STYLE_LIST, "What tag do you want to choose?", "Default Spraytag\nCustom Text", "Select", "Cancel" );


	return true ;
}

CMD:stclearcd(playerid, params[]) {

	return cmd_spraytagclearcd(playerid, params);
}

CMD:spraytagclearcd(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

	    return  SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/s(pray)t(ag)clearcd [playerid/part of name]" );
	}

	if ( ! IsPlayerConnected(target ) ) {

	    return  SendServerMessage( playerid, COLOR_RED, "Connection", "A3A3A3",  "Your target isn't connected." );
	}

	Character [ target ] [ E_CHARACTER_SPRAYTAG_DYN_CD ] = gettime() - 1;
	Character [ target ] [ E_CHARACTER_SPRAYTAG_STATIC_CD ] = gettime() - 1 ;

	new string [ 256 ] ;
	
	mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_spraytag_dyn_cd = %d, player_spraytag_static_cd = %d WHERE player_id=%d", 
			Character [ target ] [ E_CHARACTER_SPRAYTAG_DYN_CD ], Character [ target ] [ E_CHARACTER_SPRAYTAG_STATIC_CD ], Character [ target ] [ E_CHARACTER_ID]
	);

	mysql_tquery(mysql, string);


	AddLogEntry(target, LOG_TYPE_ADMIN, sprintf("Had spraytag cooldown cleared by %s", ReturnMixedName(playerid)));
	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Cleared %s spraytag cooldown", ReturnMixedName(target)));

	SendClientMessage(playerid, COLOR_YELLOW, sprintf("* You cleared %s's spraytag cooldown.", ReturnMixedName(target) ) ) ;
	SendClientMessage(target, COLOR_YELLOW, sprintf("* Your spraytag cooldown was cleared by admin %s.", ReturnMixedName(playerid) ) ) ;

	return true; 
}

CMD:stinfo(playerid, params[]) {

	return cmd_spraytaginfo(playerid, params);
}

CMD:spraytaginfo(playerid, params[]) {

	new idx = SprayTag_IsPlayerNearStaticTag( playerid )  ;

	switch ( idx ) {

		case -1: { // check for custom tag

			idx = SprayTag_IsPlayerNearDynamicTag( playerid ) ;

			if ( idx != -1 ) {

				SendClientMessage(playerid, COLOR_BLUE, "Dynamic Spray Tag Info:" ) ;

				SendClientMessage(playerid, 0xA3A3A3FF, sprintf("> Custom Text: {%06x}\"%s\"", (PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ] >>> 8), SprayTag_Dynamic [ idx ] [ E_DYN_ST_TEXT ] ) ) ;

				if ( GetPlayerAdminLevel ( playerid ) > ADMIN_LVL_JUNIOR ) {
					SendClientMessage(playerid, COLOR_YELLOW, sprintf("[ADMIN] Array: %d SQL: %d", idx, SprayTag_Dynamic [ idx ] [ E_DYN_ST_ID ] ) ) ;
					SendClientMessage(playerid, COLOR_YELLOW, sprintf("[ADMIN] Sprayed By %s (RP: %s) (SQL ID %d)", 
						SprayTag_Dynamic [ idx ] [ E_DYN_ST_OWNER_ACC ], SprayTag_Dynamic [ idx ] [ E_DYN_ST_OWNER_CHAR ],
						SprayTag_Dynamic [ idx ] [ E_DYN_ST_OWNER_ID] ) 
					) ;
				}

				SendClientMessage(playerid, COLOR_INFO, sprintf("Time left: %d", (SprayTag_Dynamic [ idx ] [ E_DYN_ST_UNIX ] - gettime() ) ) ) ;
			}

			// Not near static tag OR dynamic tag, they're not near any tag at all!
			else return SendClientMessage(playerid, COLOR_RED, "You're not near a spray-tag!") ;
		}

		default: {
			SendClientMessage(playerid, COLOR_BLUE, "Static Spray Tag Info:" ) ;

			new name [ 64 ] ;
			SprayTag_GetNameByModel(SprayTag [ idx ] [ E_SPRAY_TAG_MODELID ], name, sizeof ( name ) ) ;

			SendClientMessage(playerid, 0xDEDEDEFF, sprintf("Tag Text: \"%s\"", name ) ) ;
			SendClientMessage(playerid, 0xA3A3A3FF, sprintf("Array: %d SQL: %d", idx, SprayTag [ idx ] [ E_SPRAY_TAG_SQLID ] ) ) ;

			if ( GetPlayerAdminLevel ( playerid ) > ADMIN_LVL_JUNIOR ) {
				SendClientMessage(playerid, COLOR_YELLOW, sprintf("[ADMIN] Last Spray: %s (RP: %s) (SQL ID %d)", 
					SprayTag [ idx ] [ E_SPRAY_TAG_OWNER_ACC ], SprayTag [ idx ] [ E_SPRAY_TAG_OWNER_CHAR ],
					SprayTag [ idx ] [ E_SPRAY_TAG_OWNER] ) 
				) ;
			} 
		}
	}


	return true ;
}

CMD:stwipe(playerid, params[]) {


	return cmd_spraytagwipe(playerid, params) ;
}

CMD:spraytagwipe(playerid, params[]) {

	new idx = SprayTag_IsPlayerNearDynamicTag( playerid ), string [ 256 ] ;

	if ( idx != -1 ) {

		if( ! IsPlayerInPoliceFaction(playerid) ) {
			if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You are unable to do this (lack of access)." ) ;
		    }
		}

		if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
			if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ] > gettime() ) {
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You're on a wipe cooldown! Try again in %d seconds.", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ] - gettime() ) ) ;
	    	}
	    }

	    else if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_JUNIOR ) {
			if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ] > gettime() ) {
				SendServerMessage ( playerid, COLOR_WARNING, "Admin", "DEDEDE", sprintf("You're using your admin powers to circumvent the wipe cooldown (%d seconds).", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ] - gettime() ) ) ;
		    }
	    }

	    Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ] = gettime() + 600 ; // 10 min

	    string[0]=EOS;
	    mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_spraytag_wipe_cd = %d WHERE player_id=%d", 
				Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ],  Character [ playerid ] [ E_CHARACTER_ID]
		);

	    mysql_tquery(mysql, string);

	    string[0]=EOS;

		if ( IsValidDynamicObject( SprayTag_Dynamic [ idx ] [ E_DYN_ST_OBJECTID ] ) ) {

			SprayTag_Dynamic [ idx ] [ E_DYN_ST_ID ] = INVALID_DYN_ST_ID ;

			//format ( string, sizeof ( string ), "has wiped custom spray tag with id %d", idx );
		    //ProxDetectorNameTag(playerid, 15.0, COLOR_ACTION, string, "", 1,  .customcolor=false, .invert_action=false ) ;

			DestroyDynamicObject(SprayTag_Dynamic [ idx ] [ E_DYN_ST_OBJECTID ]);

			format ( string, sizeof ( string ), "[STAFF] %s (%d) has wiped custom tag idx %d.", ReturnMixedName(playerid), playerid, idx) ;
			SendAdminMessage(string) ;
		}
	}

	else return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near a spraytag that's wipe-able." ) ;

	return true ;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz ) {
	
	if ( PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] ) {

		if ( objectid == PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) {

			switch ( response ) {

				case EDIT_RESPONSE_UPDATE: {

					SetDynamicObjectPos(PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ], x, y, z);
					SetDynamicObjectRot(PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ], rx, ry, rz);
				}

				case EDIT_RESPONSE_CANCEL: {

					PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = false ;
					DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ;
					PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = -1 ;
					PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 0 ;	
				}

				case EDIT_RESPONSE_FINAL : {
					switch ( PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] ) {

						case 1: { // static

							SprayTag_OnStaticTagCreate(playerid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz);

						}
						case 2: { // dynamic
							SprayTag_OnDynamicTagCreate(playerid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz);
						}
					}
				}
			}

		}
	}

	#if defined sptag_OnPlayerEditDynamicObject
		return sptag_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz );
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEditDynamicObject
	#undef OnPlayerEditDynamicObject
#else
	#define _ALS_OnPlayerEditDynamicObject
#endif

#define OnPlayerEditDynamicObject sptag_OnPlayerEditDynamicObject
#if defined sptag_OnPlayerEditDynamicObject
	forward sptag_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz );
#endif