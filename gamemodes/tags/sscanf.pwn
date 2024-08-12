SSCANF:unmaskedplayer(name[]) 
{
    if(isnull(name)) 
    {
        return INVALID_PLAYER_ID ;
    }

    new id, matches;

    if ( sscanf(name, "i", id ) ) 
    {
        foreach(new i : Player) 
        {
            if( strfind( Account [ i ] [ E_PLAYER_ACCOUNT_NAME ], name, true) != -1 || 
                strfind( Character [ i ] [ E_CHARACTER_NAME ], name, true ) != -1) {

                matches++;
                id = i;

                if(matches > 1) {
                    return INVALID_PLAYER_ID;
                }
            }            
        }

        if(matches) return id;
        return INVALID_PLAYER_ID;
    }

    if(id < 0 || id > MAX_PLAYERS) {
        return INVALID_PLAYER_ID;
    }

    if (!IsPlayerConnected(id)) {
        return INVALID_PLAYER_ID;
    }

    return id;
}

SSCANF:player(name[]) {

    if(isnull(name)) {

        return INVALID_PLAYER_ID ;
    }

    new id, matches;

    if ( sscanf(name, "i", id ) ) {

        foreach(new i : Player) {

            /*
            if(strfind( Account [ i ] [ E_PLAYER_ACCOUNT_NAME ], name, true) != -1) {
                matches++;
                id = i;

                if(matches > 1) return INVALID_PLAYER_ID;
            }

            else if ( strfind( Character [ i ] [ E_CHARACTER_NAME ], name, true ) != -1) {
                matches++;
                id = i;

                if(matches > 1) return INVALID_PLAYER_ID;
            }*/
            if( strfind( Account [ i ] [ E_PLAYER_ACCOUNT_NAME ], name, true) != -1 || 
                strfind( Character [ i ] [ E_CHARACTER_NAME ], name, true ) != -1) {

                matches++;
                id = i;

                if(matches > 1) {
                    return INVALID_PLAYER_ID;
                }
            }            
        }

        if(matches) return id;
        return INVALID_PLAYER_ID;
    }

    if(id < 0) {
        return INVALID_PLAYER_ID;
    }

    if (id > MAX_PLAYERS)
    {
        // Presumably this is a mask id
        foreach(new i : Player) 
        {
            if (PlayerVar[i][E_PLAYER_IS_MASKED] && Character[i][E_CHARACTER_MASKID] == id)
            {
                return i;
            }
        }

        return INVALID_PLAYER_ID;
    }

    if (!IsPlayerConnected(id)) {
        return INVALID_PLAYER_ID;
    }

    return id;
}