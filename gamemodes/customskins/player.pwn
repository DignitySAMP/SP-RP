
CMD:nextskinupdate(playerid) {

    new currentTime = GetTickCount();
    new timePassed = currentTime - lastSkinAddition;
    new timeRemaining = LIVE_SKIN_UPDATE_TIME - timePassed;

    if (timeRemaining < 0) {
        timeRemaining = 0; // Ensure the remaining time is not negative
    }
    
    new minutes = timeRemaining / 60000;
    new seconds = (timeRemaining % 60000) / 1000;
    new string[64];

    format(string, sizeof(string), "Time left until next skin update: %d minutes %d seconds", minutes, seconds);
    SendClientMessage(playerid, COLOR_GREEN, string);

    return true;
}

SetPlayerSkinEx ( playerid, skinid, bool:add_wardrobe = false) {

	Character [ playerid ] [ E_CHARACTER_SKINID ] = skinid ;
	SetPlayerSkin(playerid, skinid);

	new query [ 256 ] ;

    if(!IsCustomPlayerSkin(skinid)) {
        mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_skinid = %d WHERE player_id = %d",
        Character [ playerid ] [ E_CHARACTER_SKINID ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;
        mysql_tquery ( mysql, query);

        if (add_wardrobe)
        {
            mysql_format(mysql, query, sizeof(query), "INSERT INTO player_wardrobes (`player_wardrobe_char_id`, `player_wardrobe_skin_id`) VALUES (%d, %d) ON DUPLICATE KEY UPDATE `player_wardrobe_skin_lastused` = CURRENT_TIMESTAMP", Character[playerid][E_CHARACTER_ID], skinid);
            mysql_tquery(mysql, query);
        }

    }
    else if(IsCustomPlayerSkin(skinid)) {
        foreach(new i: CustomSkins) {
            if(CustomSkin[i][E_CUSTOM_SKIN_ID] == skinid && CustomSkin[i][E_CUSTOM_SKIN_CHARACTERID] == Character[playerid][E_CHARACTER_ID]) {
            
                format(Character [ playerid ] [ E_CHARACTER_SKIN_DIR ], 96, "%s", CustomSkin[i][E_CUSTOM_SKIN_DIR]);
                format(Character [ playerid ] [ E_CHARACTER_SKIN_MODEL ], 96, "%s", CustomSkin[i][E_CUSTOM_SKIN_DFF]);

                mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_skin_dir = '%e', player_skin_model = '%e' WHERE player_id = %d", 
                    Character [ playerid ] [ E_CHARACTER_SKIN_DIR ], Character [ playerid ] [ E_CHARACTER_SKIN_MODEL ], Character[playerid][E_CHARACTER_ID]);
                mysql_tquery(mysql, query);

                SetPlayerSkin(playerid, CustomSkin[i][E_CUSTOM_SKIN_ID]);
                break;
            }
        }
    }

    // Likewise update the last used in the wardrobe, too
    // UPDATE 2024: Custom skin IDs might shift. This might make this system redundant, time will tell, Don't have time to rewrite it rn.
    mysql_format(mysql, query, sizeof ( query ), "UPDATE player_wardrobes SET player_wardrobe_skin_lastused = CURRENT_TIMESTAMP WHERE player_wardrobe_skin_id = %d AND player_wardrobe_char_id = %d", Character [ playerid ] [ E_CHARACTER_SKINID ], Character[playerid][E_CHARACTER_ID]);
    mysql_tquery(mysql, query);
}

SOLS_SetPlayerSkin(playerid) {
    // This will see if there is a custom skin saved. If there isn't, it will use the default saved skin ID.

    if(strlen(Character [ playerid ] [ E_CHARACTER_SKIN_MODEL ]) >= 3 && strlen(Character [ playerid ] [ E_CHARACTER_SKIN_DIR ])  >= 3) {

        SetPlayerSkin(playerid, 264); // We set a temp skin here so we can check later if the custom skin worked.
        foreach(new i: CustomSkins) {

            // Do we have a custom skin loaded for the player?
            if(CustomSkin[i][E_CUSTOM_SKIN_CHARACTERID] == Character[playerid][E_CHARACTER_ID]) {

                // Does the saved directory exist?
                if(!strcmp(CustomSkin[i][E_CUSTOM_SKIN_DIR], Character [ playerid ] [ E_CHARACTER_SKIN_DIR ])) {

                    // Do the final checks... comparing the saved model name with what's cached.
                    if( !strcmp(CustomSkin[i][E_CUSTOM_SKIN_DFF], Character [ playerid ] [ E_CHARACTER_SKIN_MODEL ])) {

                        // All checks ok, we should have the proper index now. Apply the custom cached skin.
                        SetPlayerSkin(playerid, CustomSkin[i][E_CUSTOM_SKIN_ID]);
                        break;
                    }
                }
            }
        }

        // For some reason, their custom skin wasn't set. We'll revert to the default skin.
        if(GetPlayerSkin(playerid) == 264) {
            SendClientMessage(playerid, COLOR_ERROR, "Your custom skin couldn't be loaded. Visit a wardrobe and re-equip it.");

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_skin_model = '', player_skin_dir = '' WHERE player_id = %d", Character[playerid][E_CHARACTER_ID]);
            mysql_tquery(mysql, query);

            Character [ playerid ] [ E_CHARACTER_SKIN_MODEL ][0] = EOS;
            Character [ playerid ] [ E_CHARACTER_SKIN_DIR ][0] = EOS;

            SetPlayerSkin(playerid, Character[playerid][E_CHARACTER_SKINID]);
        }
    }

    else SetPlayerSkin(playerid, Character[playerid][E_CHARACTER_SKINID]);
    
}