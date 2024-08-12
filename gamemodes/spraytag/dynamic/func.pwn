SprayTag_DynamicTagRangeCheck(playerid) {

	new Float:fPX, Float:fPY, Float:fPZ, 
		Float:fVX, Float:fVY, Float:fVZ, 
		Float:object_x, Float:object_y, Float:object_z
	;

    const Float:fScale = 5.0;

    GetPlayerCameraPos(playerid, fPX, fPY, fPZ);
    GetPlayerCameraFrontVector(playerid, fVX, fVY, fVZ);

    object_x = fPX + floatmul(fVX, fScale);
    object_y = fPY + floatmul(fVY, fScale);
    object_z = fPZ + floatmul(fVZ, fScale);



    new Float: x, Float: y, Float: z ;
    GetPlayerPos(playerid, x, y, z ) ;

    new Float: pos_x, Float: pos_y, Float: pos_z ;
    new result = CA_RayCastLine(x, y, z, object_x, object_y, object_z, pos_x, pos_y, pos_z);

    if ( result != 0 ) {

  		PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_X ] = pos_x ;
		PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_Y ] = pos_y ;
		PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_Z ] = pos_z ;


    	return true ;
    }

    else {

  		PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_X ] = -1.0 ;
		PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_Y ] = -1.0 ;
		PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_Z ] = -1.0 ;

    	return false ;
    }
}

SprayTag_CheckDynamicTagSpray(playerid) {

	if ( SprayTag_DynamicTagRangeCheck(playerid)) {

		if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ] != -1 ) {

			if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ] == 19482 ) {

				if ( strlen( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ] ) < 3 ) {

					return SendClientMessage(playerid, -1, "Your chosen graffiti (custom text) must have at least 3 characters in order to spray!");
				}
			}

			if ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_CD ] > gettime() ) {
				return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", sprintf("You're on a dynamic spray cooldown! Try again in %d seconds.", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_CD ] - gettime() ) ) ;
	    	}

			PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 2 ;
			PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] = 10 ;

			/*
	    	#warning Make it so you can choose to spray a tag or text (if official)
	   	 	new object = CreateDynamicObject(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ], pos_x, pos_y, pos_z, 0, 0, 0);
	    	EditDynamicObject(playerid, object);*/
		}

		else SendClientMessage(playerid, COLOR_ERROR, "You need to select a DYNAMIC spray tag! Use /s(pray)t(ag)choose");


    }

    return true ;
}

SprayTag_SprayingDynamicTag(playerid) {
	if ( GetPlayerState ( playerid ) != PLAYER_STATE_ONFOOT ) {

		return true ;
	}

    if( PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] ) {

		new keys, updown, leftright;
	    GetPlayerKeys(playerid, keys, updown, leftright);
		if( keys == KEY_AIM_FIRE && AC_GetPlayerWeapon( playerid ) == WEAPON_SPRAYCAN ) {

			if ( SprayTag_DynamicTagRangeCheck(playerid)) {

	  			PlayerVar [ playerid ] [ E_PLAYER_TAGS_NEARTAG ] = SprayTag_IsPlayerNearStaticTag( playerid ) ;

				new sp_string[50];
				format( sp_string, sizeof( sp_string ), "~r~Spraying Custom Tag~n~~w~[%d]", PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] );
				GameTextForPlayer(playerid, sp_string, 1500, 3);

				PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ]--;
				if( !PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] )
				{
					OnPlayerSprayDynamicTag( playerid );
				}
				return 1;
			}
		}

		PlayerVar [ playerid ] [ E_PLAYER_TAGS_TIMELEFT ] = 0;
		GameTextForPlayer(playerid, "~r~Custom Spray Cancelled", 1500, 3);
	}

	return 1;
}

OnPlayerSprayDynamicTag( playerid ) {

	new Float: pos_x, Float: pos_y, Float: pos_z ;

	pos_x = PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_X ] ;
	pos_y = PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_Y ] ;
	pos_z = PlayerVar [ playerid ] [ E_PLAYER_DYN_TAG_POS_Z ] ;

	if ( IsValidDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] ) ) {

		DestroyDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ]  ) ;
		PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ]  = -1 ;
	}

	SendClientMessage(playerid, -1, sprintf("%d", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ]));
	PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ] = CreateDynamicObject(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ], pos_x, pos_y, pos_z, 0, 0, 0);

	switch ( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ] ) {

		case 19482: { // Customtext
			
			new font_color = PlayerVar [ playerid ] [ E_PLAYER_DYN_ST_COLOR ] ;

			if ( ! font_color ) {
				// chosen when spraying their text using [[COLOR_HERE]]! /stcolors show the syntax!

				font_color = 0xDEDEDEFF ;
			}

			font_color = RGBAtoARGB(font_color);

			SetDynamicObjectMaterialText( PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ], 0, 
			 	st_FormatMessage(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT ]), 
				OBJECT_MATERIAL_SIZE_512x256, 
				"Arial", .fontsize = 40, .bold = 1, 
				.fontcolor = font_color, 
				.textalignment = OBJECT_MATERIAL_TEXT_ALIGN_CENTER 
			);

		}
	}

	PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] = true ;
	PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] = 2 ; // 2 = custom tag

	EditDynamicObject(playerid, PlayerVar [ playerid ] [ E_PLAYER_EDIT_TAG_OBJID ]);

	SendClientMessage(playerid, -1, "Position the tag to a favourable position then click the discette icon. To cancel, press ESC.");
}

