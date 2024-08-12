SprayTag_SprayingStaticTag(playerid){
	if ( GetPlayerState ( playerid ) != PLAYER_STATE_ONFOOT ) {

		return true ;
	}

    if( PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] ) {

		new keys, updown, leftright;
	    GetPlayerKeys(playerid, keys, updown, leftright);
		if( keys == KEY_AIM_FIRE && AC_GetPlayerWeapon( playerid ) == WEAPON_SPRAYCAN ) {

			if( SprayTag_IsPlayerNearStaticTag( playerid ) != 0 ) {

      			PlayerVar [ playerid ] [ E_PLAYER_TAGS_NEARTAG ] = SprayTag_IsPlayerNearStaticTag( playerid ) ;

				new sp_string[50];
				format( sp_string, sizeof( sp_string ), "~r~Spraying~n~~w~[%d]", PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] );
				GameTextForPlayer(playerid, sp_string, 1500, 3);

				PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ]--;
				if( !PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] )
				{
					sp_OnPlayerSprayTag( playerid, PlayerVar [ playerid ] [ E_PLAYER_TAGS_NEARTAG ] );
				}
				return 1;
			}
		}

		PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] = 0;
		GameTextForPlayer(playerid, "~r~Spray Cancelled", 1500, 3);
	}

	return 1;
}

sp_OnPlayerSprayTag( playerid, tag_id ) {
	if ( tag_id == -1 ) {

		return SendClientMessage(playerid, -1, "You're too far away from the original tag!");
	}


	Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC_CD ] = gettime() + 300 ; // 5 min

	new string [ 128 ] ;
	mysql_format(mysql, string, sizeof(string), "UPDATE characters SET player_spraytag_static_cd = %d WHERE player_id=%d", 
			Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC_CD ],  Character [ playerid ] [ E_CHARACTER_ID]
	);

	mysql_tquery(mysql, string);

	new tag_obj_id 	= SprayTag[ tag_id ][ E_SPRAY_TAG_OBJECT ];

	SprayTag[ tag_id ][ E_SPRAY_TAG_OWNER ]  	= Character [ playerid ] [ E_CHARACTER_ID ];
	format( SprayTag[ tag_id ][ E_SPRAY_TAG_OWNER_ACC ], 24,"%s", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]  );
	format( SprayTag[ tag_id ][ E_SPRAY_TAG_OWNER_CHAR ], 24,"%s", Character [ playerid ] [ E_CHARACTER_NAME ] );

	new query [ 256 ] ;
	mysql_format(mysql, query, sizeof(query), "UPDATE spraytags SET spraytag_modelid = %d, spraytag_owner = %d,\
	 spraytag_owner_acc = '%e', spraytag_owner_char = '%e' WHERE spraytag_sqlid = %d", 
	 	Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ], SprayTag[ tag_id ][ E_SPRAY_TAG_OWNER ],
	 	SprayTag[ tag_id ][ E_SPRAY_TAG_OWNER_ACC ], SprayTag[ tag_id ][ E_SPRAY_TAG_OWNER_CHAR ],
	 	SprayTag[ tag_id ][ E_SPRAY_TAG_SQLID ]
	);

	mysql_tquery(mysql, query);

	Streamer_SetIntData(STREAMER_TYPE_OBJECT, tag_obj_id, E_STREAMER_MODEL_ID, Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ] ) ;
	SprayTag [ tag_id ] [ E_SPRAY_TAG_MODELID ] = Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ] ;
	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 0 ;

	GameTextForPlayer(playerid, "~g~Sprayed", 5000, 3);
	return 1;
}


SprayTag_CheckStaticTagSpray(playerid) {

    if( SprayTag_IsPlayerNearStaticTag( playerid ) != -1 ) {

    	if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ] != -1 ) {


			if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC_CD ] > gettime() ) {
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You're on a static spray cooldown! Try again in %d seconds.", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC_CD ] - gettime() ) ) ;
	    	}


			new sp_object = SprayTag_IsPlayerNearStaticTag( playerid );
			PlayerVar [ playerid ] [ E_PLAYER_TAGS_NEARTAG ] = sp_object;
			PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] = 5 ;
			PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 1 ;

			return true ;
		}

		else SendClientMessage(playerid, COLOR_ERROR, "You need to select a STATIC spray tag! Use /s(pray)t(ag)choose");
    }

    return false ;
}