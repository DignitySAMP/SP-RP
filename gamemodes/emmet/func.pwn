Emmet_DeclareCooldowns(weapon_constant, faction_enum_id, emmet_index) {
    new refill_unix = CalculateEmmetRefillUnix(weapon_constant);
    //new refill_unix = gettime() + 60; // 1 min (testing purposes) 
    new query[256];

    switch(weapon_constant) {
        case WEAPON_COLT45: {

            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_UNIX] = refill_unix;
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] --;

            if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] <= 0) {
                EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] = 0;
            }
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_colt45_stock = %i, emmet_colt45_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK], EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction_enum_id][E_FACTION_ID]);
            mysql_tquery(mysql, query);
        }

        case WEAPON_UZI: {

            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_UNIX]  = refill_unix;
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] --;

            if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] <= 0) {
                EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] = 0;
            }
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_uzi_stock = %i, emmet_uzi_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK], EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction_enum_id][E_FACTION_ID]);
            mysql_tquery(mysql, query);
        }

        case WEAPON_TEC9: {

            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_UNIX]  = refill_unix;
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] --;

            if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] <= 0) {
                EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] = 0;
            }
            
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_tec_stock = %i, emmet_tec_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK], EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction_enum_id][E_FACTION_ID]);
            mysql_tquery(mysql, query);
        }

        case WEAPON_AK47:  {

            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_UNIX]  = refill_unix;
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] --;

            if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] <= 0) {
                EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] = 0;
            }
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_ak47_stock = %i, emmet_ak47_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK], EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction_enum_id][E_FACTION_ID]);
            mysql_tquery(mysql, query);
        }

        case WEAPON_SHOTGUN: {

            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_UNIX]  = refill_unix;
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] --;

            if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] <= 0) {
                EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] = 0;
            }
            mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_shotgun_stock = %i, emmet_shotgun_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
            EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK], EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction_enum_id][E_FACTION_ID]);
            mysql_tquery(mysql, query);
        }
    }
}

CalculateEmmetRefillUnix(weapon_constant) {
    new unix;
    switch(weapon_constant) {
        case WEAPON_COLT45: unix = (gettime() + (3600 * 4)); // 4 hours
        case WEAPON_UZI: unix = (gettime() + (3600 * 6)); // 6 hours
        case WEAPON_TEC9: unix = (gettime() + (3600 * 6)); // 6 hours
        case WEAPON_AK47: unix = (gettime() + (3600 * 36)); // 36 hours
        case WEAPON_SHOTGUN: unix = (gettime() + (3600 * 24)); // 24 hours
    }
    return unix;
}

CalculateEmmetRefillCap(weapon_constant) {
    new cap;
    switch(weapon_constant) {
        case WEAPON_COLT45: cap = 10;
        case WEAPON_UZI: cap = 8;
        case WEAPON_TEC9: cap = 8;
        case WEAPON_AK47: cap = 2;
        case WEAPON_SHOTGUN: cap = 3;
    }
    return cap;
}

CalculateEmmetTax(weapon_constant) {
    new tax;
    switch(weapon_constant) {
        case WEAPON_COLT45: tax = 175;
        case WEAPON_UZI: tax = 600;
        case WEAPON_TEC9: tax = 600;
        case WEAPON_AK47: tax = 2500;
        case WEAPON_SHOTGUN: tax = 1250;
    }
    return tax;
}
CalculateEmmetBaseCost(weapon_constant) {
    new base_cost;
    switch(weapon_constant) {
        case WEAPON_COLT45: base_cost = 2750;
        case WEAPON_UZI: base_cost = 6000;
        case WEAPON_TEC9: base_cost = 6000;
        case WEAPON_AK47: base_cost = 25000;
        case WEAPON_SHOTGUN: base_cost = 12500;
    }
    return base_cost;
}
