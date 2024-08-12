

ReturnRPName ( playerid, bool:masked=false) 
{ // Returns "Firstname_Lastname"
    new name[64];
    

    if(PlayerVar [ playerid ] [ E_PLAYER_ADMIN_DUTY ]) {
        format(name, sizeof(name), "{E8871B}[Admin] %s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
        return name;
    } else if (PlayerVar [playerid] [E_PLAYER_HELPER_DUTY]) {
        format(name, sizeof(name), "{38C751}[Helper] %s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
        return name;
    } else if (IsPlayerMasked(playerid) && masked) {        
        format ( name, sizeof ( name ), "Stranger %d", GetPlayerMaskID(playerid) ) ;
        return name;
    }

    format(name, sizeof(name), Character[playerid][E_CHARACTER_NAME]);

    for (new i = 0, len = strlen(name); i < len; i ++) 
    {
        if (name[i] == '_') name[i] = ' ';
    }
    
    return name;
}

ReturnTagName(playerid,color=true, bool:masked=false) 
{ // Returns "[LSB]Account"
    new name[64], faction_enum_id, faction_sql_id = Character[playerid][E_CHARACTER_FACTIONID];

    if(PlayerVar [ playerid ] [ E_PLAYER_ADMIN_DUTY ]) {
        format(name, sizeof(name), "{E8871B}[Admin] %s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
    } else if(PlayerVar [ playerid ] [ E_PLAYER_HELPER_DUTY ]) {
        format(name, sizeof(name), "{38C751}[Helper] %s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
    } 
    else if (!IsPlayerMasked(playerid) || !masked) {
        if (faction_sql_id) {
            faction_enum_id = Faction_GetEnumID(faction_sql_id) ;

            if(faction_enum_id != -1) {
               
                format (name, sizeof ( name ), "%s%s", Faction_GetTag(faction_sql_id, color), Account [playerid][E_PLAYER_ACCOUNT_NAME]); 
            }
        }
        else format(name, sizeof(name), "%s", Account [playerid][E_PLAYER_ACCOUNT_NAME]);
    }
    else if(IsPlayerMasked(playerid) && masked) 
    { 
        format (name, sizeof (name), "Stranger %d", GetPlayerMaskID(playerid)) ;
    }

    new nameEx[64]; // zMessage can't handle color codes
    format(nameEx, sizeof(nameEx), "%s", name);
    return nameEx;
}

ReturnMixedName(playerid) 
{ // Returns "Account (F. Lastname)"
	new name[64], shortname[MAX_PLAYER_NAME];
	format(shortname, sizeof ( shortname ), "%s", Character [ playerid ] [ E_CHARACTER_NAME ] ) ;
    strdel(shortname, 0, strfind(shortname,"_",true) + 1);

    format(name, sizeof(name), "%s (%.1s. %s)", Account[playerid][E_PLAYER_ACCOUNT_NAME], Character[playerid][E_CHARACTER_NAME], shortname ) ;
    return name;
}

ReturnSettingsName(fromplayerid, toplayerid, color=false, bool:masked=true) 
{ // Returns either one of the above, depending on setting.
    new name[64];
    if (IsPlayerPlaying(fromplayerid) && Character[fromplayerid][E_CHARACTER_ID] > 0) {
        switch(GetPlayerNametagPreference(toplayerid)) {
            case 0: format(name, sizeof(name), "%s", ReturnTagName(fromplayerid, color, masked));
            case 1:	format(name, sizeof(name), "%s", ReturnRPName(fromplayerid, masked));
        }
    }
    else format(name, sizeof(name), "%s", TEMP_ReturnPlayerName(fromplayerid));
    return name;
}