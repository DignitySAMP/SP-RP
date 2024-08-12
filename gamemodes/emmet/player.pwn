enum E_EMMET_PLAYER_DATA {
    E_EMMET_PLAYER_ACCOUNT_ID,

    E_EMMET_PLAYER_COLT_TAX,
    E_EMMET_PLAYER_COLT_CD,

    E_EMMET_PLAYER_UZI_TAX,
    E_EMMET_PLAYER_UZI_CD,    
    E_EMMET_PLAYER_TEC_TAX,
    E_EMMET_PLAYER_TEC_CD,
    
    E_EMMET_PLAYER_AK47_TAX,
    E_EMMET_PLAYER_AK47_CD,    
    E_EMMET_PLAYER_SHOTGUN_TAX,
    E_EMMET_PLAYER_SHOTGUN_CD
};
new EmmetPlayer[MAX_PLAYERS][E_EMMET_PLAYER_DATA];

Emmet_HandlePaycheck(playerid) {
    new money;
    for(new i, j = MAX_EMMET_NPCS; i < j; i ++) {

        if(Emmet[i][E_EMMET_OWNEDBY] == Character [ playerid ] [ E_CHARACTER_FACTIONID ] && Character [ playerid ] [ E_CHARACTER_FACTIONID ] > 0) {
            money = 250;
            money += RandomEx(150,500);
        }
    }
    return money;
}

Emmet_CheckCooldowns(playerid,weapon_constant) {
    switch(weapon_constant) {
        case WEAPON_COLT45: if(EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] >= (CalculateEmmetRefillCap(WEAPON_COLT45) / 2)) return false; 
        case WEAPON_UZI: if(EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] >= (CalculateEmmetRefillCap(WEAPON_UZI) / 2)) return false; 
        case WEAPON_TEC9: if(EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] >= (CalculateEmmetRefillCap(WEAPON_TEC9) / 2)) return false; 
        case WEAPON_AK47: if(EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] >= (CalculateEmmetRefillCap(WEAPON_AK47) - 1)) return false; 
        case WEAPON_SHOTGUN: if(EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] >= (CalculateEmmetRefillCap(WEAPON_SHOTGUN) - 1)) return false; 
        default: return true;
    }

    return true; 
}

Emmet_DeclarePlayerCooldowns(playerid,weapon_constant) {

    new query[384];
    switch(weapon_constant) {

        case WEAPON_COLT45: {
            EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] ++;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] >= (CalculateEmmetRefillCap(WEAPON_COLT45) / 2)) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD] =  gettime() + (3600 * 2); // 2 hrs (locked)
            }
            else EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD] = gettime() + 3600 ; // 1 hours (tax reset)
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_player SET emmet_player_colt_tax=%i,emmet_player_colt_cd=%i WHERE emmet_player_account_id = %i", 
            EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX], EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD],Account[playerid][E_PLAYER_ACCOUNT_ID]);
            mysql_tquery(mysql, query);
        }
        case WEAPON_UZI: {
            EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] ++;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] >= (CalculateEmmetRefillCap(WEAPON_UZI) / 2)) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD] =  gettime() + (3600 * 2); // 2 hrs (locked)
            }
            else EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD] = gettime() + 3600 ; // 1 hours (tax reset)
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_player SET emmet_player_uzi_tax=%i,emmet_player_uzi_cd=%i WHERE emmet_player_account_id = %i", 
            EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX], EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD],Account[playerid][E_PLAYER_ACCOUNT_ID]);
            mysql_tquery(mysql, query);
        }        
        case WEAPON_TEC9: {
            EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] ++;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] >= (CalculateEmmetRefillCap(WEAPON_TEC9) / 2)) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD] =  gettime() + (3600 * 3); // 3 hrs (locked)
            }
            else EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD] = gettime() + 3600 ; // 1 hours (tax reset)
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_player SET emmet_player_tec_tax=%i,emmet_player_tec_cd=%i WHERE emmet_player_account_id = %i", 
            EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX], EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD],Account[playerid][E_PLAYER_ACCOUNT_ID]);
            mysql_tquery(mysql, query);
        }
        case WEAPON_AK47: {
            EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] ++;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] >= (CalculateEmmetRefillCap(WEAPON_AK47) / 2)) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD] =  gettime() + (3600 * 12); // 12 hrs (locked)
            }
            else EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD] = gettime() + 3600 ; // 1 hours (tax reset)
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_player SET emmet_player_ak47_tax=%i,emmet_player_ak47_cd=%i WHERE emmet_player_account_id = %i", 
            EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX], EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD],Account[playerid][E_PLAYER_ACCOUNT_ID]);
            mysql_tquery(mysql, query);
        }       
        case WEAPON_SHOTGUN: {
            EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] ++;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] >= (CalculateEmmetRefillCap(WEAPON_SHOTGUN) / 2)) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD] =  gettime() + (3600 * 6); // 6 hrs (locked)
            }
            else EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD] = gettime() + 3600 ; // 1 hours (tax reset)
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_player SET emmet_player_shotgun_tax=%i,emmet_player_shotgun_cd=%i WHERE emmet_player_account_id = %i", 
            EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX], EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD], Account[playerid][E_PLAYER_ACCOUNT_ID]);
            mysql_tquery(mysql, query);
        }
    }
}

Emmet_PlayerCooldownTick(playerid) {

    if(EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] != 0) {
        if(EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD] < gettime()) {
            EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] --;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] <= 0) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] = 0;
                EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD] = 0;
            }
        }
    }
    
    if(EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] != 0) {
        if(EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD] < gettime()) {
            EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] --;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] <= 0) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] = 0;
                EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD] = 0;
            }
        }
    }    
    if(EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] != 0) {
        if(EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD] < gettime()) {
            EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] --;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] <= 0) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] = 0;
                EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD] = 0;
            }
        }
    }
    if(EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] != 0) {
        if(EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD] < gettime()) {
            EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] --;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] <= 0) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] = 0;
                EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD] = 0;
            }
        }
    }
    if(EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] != 0) {
        if(EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD] < gettime()) {
            EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] --;
            if(EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] <= 0) {
                EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] = 0;
                EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD] = 0;
            }
        }
    }
}

Emmet_LoadPlayerEntities(playerid) {

    // Clearing containers
	new emmet_data_clear [ E_EMMET_PLAYER_DATA ] ;
	EmmetPlayer [ playerid ] = emmet_data_clear ;

    // Loading (or storing) emmet player info
	inline Emmet_OnDataLoad() {
		if (cache_num_rows()) {
            cache_get_value_name_int(0, "emmet_player_account_id", EmmetPlayer[playerid][E_EMMET_PLAYER_ACCOUNT_ID]);

            cache_get_value_name_int(0, "emmet_player_colt_tax", EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX]);
            cache_get_value_name_int(0, "emmet_player_colt_cd", EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD]);

            cache_get_value_name_int(0, "emmet_player_uzi_tax", EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX]);
            cache_get_value_name_int(0, "emmet_player_uzi_cd", EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD]);
            cache_get_value_name_int(0, "emmet_player_tec_tax", EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX]);
            cache_get_value_name_int(0, "emmet_player_tec_cd", EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD]);
            
            cache_get_value_name_int(0, "emmet_player_ak47_tax", EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX]);
            cache_get_value_name_int(0, "emmet_player_ak47_cd", EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD]);
            cache_get_value_name_int(0, "emmet_player_shotgun_tax", EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX]);
            cache_get_value_name_int(0, "emmet_player_shotgun_cd", EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD]);

			printf(" * [EMMET] Loaded %s (%d)'s emmet player data.", TEMP_ReturnPlayerName(playerid), playerid) ;
		} else { // Storing new line incase no rows found, for later extraction!
            mysql_tquery(mysql, sprintf("INSERT INTO `emmet_player`(emmet_player_account_id) VALUES (%i)", Account[playerid][E_PLAYER_ACCOUNT_ID] ));
        }
	}

	MySQL_TQueryInline(mysql, using inline Emmet_OnDataLoad, "SELECT * FROM emmet_player", "" ) ;

	return true ;
}
