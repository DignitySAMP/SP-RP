
CMD:emmetcreate(playerid, params[]) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    new skin, name[32];
    if(sscanf(params, "is[32]", skin, name)) {
        
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/emmetcreate [skin] [name]" ) ;
    }
    if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0) {
        return SendClientMessage(playerid, COLOR_ERROR, "You can only do this in interior or virtual world 0.");
    }
    if(strlen(name) > 32) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Name can't be more than 32 letters." ) ;
    }
    Emmet_Create(playerid, name, skin);
    return true;
}

CMD:emmetowner(playerid, params[]) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {
        return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }
    new id = Emmet_GetClosestEntity(playerid);
    if(id == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }
    new faction_id;
    if(sscanf(params,"i",faction_id)) {
        SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "/emmetowner [factionid]");
        SendClientMessage(playerid, COLOR_ERROR, "Important{DEDEDE}: Enter the ID (Not SQL ID!!) from /factions.");
        return true;
    }

    Emmet[id][E_EMMET_OWNEDBY] = Faction[faction_id][E_FACTION_ID];

    new query[128];
    mysql_format(mysql, query, sizeof(query), "UPDATE emmet SET emmet_ownedby = %i WHERE emmet_sqlid = %i",  Emmet[id][E_EMMET_OWNEDBY], Emmet[id][E_EMMET_SQLID]);
    mysql_tquery(mysql, query);

    SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", sprintf("Set gun dealer %i (sql %i, %s) owner to %s (sql %i)", id, Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], Faction[faction_id][E_FACTION_ABBREV],Emmet[id][E_EMMET_OWNEDBY]));
    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Set gun dealer sql %i (%s) owner to %s (sql %i)", Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], Faction[faction_id][E_FACTION_ABBREV],Emmet[id][E_EMMET_OWNEDBY]));
    return true;
}

CMD:emmetassign(playerid, params[]) {	
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    new emmet_index = Emmet_GetClosestEntity(playerid);
    if(emmet_index == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }

    new faction, qty,  choice[12];
    if(sscanf(params, "iis[12]", faction, qty, choice)) {
        SendClientMessage(playerid, COLOR_YELLOW, "Syntax: /emmetassign [faction] [stock] [colt/uzi/tec/ak47/shotgun]");
        SendClientMessage(playerid, COLOR_ERROR, "Important{DEDEDE}: Enter the ID (Not SQL ID!!) from /factions.");
        SendClientMessage(playerid, COLOR_ERROR, "Important:{DEDEDE} each gun has to be assigned individually. Set \"stock\" to 0 to deplete. Set \"stock\" to -1 to lock.");
        SendClientMessage(playerid, COLOR_ERROR, "If you set stock to 0, the refill time will be automatically calculated!");
        return true;
    }
    
    // These are already saved per-gun, but just set them to be sure they can access the shop.
    if(EmmetFaction[faction][emmet_index][E_EMMET_FACTION_INDEX] != Emmet[emmet_index][E_EMMET_SQLID]) {
        EmmetFaction[faction][emmet_index][E_EMMET_FACTION_INDEX] = Emmet[emmet_index][E_EMMET_SQLID];
    }
    if(EmmetFaction[faction][emmet_index][E_EMMET_FACTION_INDEX] != Emmet[emmet_index][E_EMMET_SQLID]) {
        EmmetFaction[faction][emmet_index][E_EMMET_FACTION_INDEX] = Emmet[emmet_index][E_EMMET_SQLID];
    }

    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Used /emmetassign (faction %i, stock %i, prefix %s)", faction, qty, choice));

    new query[256];
    if(!strcmp(choice, "colt", true)) {
        if(qty > CalculateEmmetRefillCap(WEAPON_COLT45)) {
            SendClientMessage(playerid, COLOR_ERROR, sprintf("Max stock for the COLT 45 is %i. Adjusted your entry to match this.", CalculateEmmetRefillCap(WEAPON_COLT45)));
            qty = CalculateEmmetRefillCap(WEAPON_COLT45);
        }

        EmmetFaction[faction][emmet_index][E_EMMET_COLT45_STOCK] = qty;

        if(qty == -1) EmmetFaction[faction][emmet_index][E_EMMET_COLT45_UNIX] = -1;
        else if(qty == 0) EmmetFaction[faction][emmet_index][E_EMMET_COLT45_UNIX] = CalculateEmmetRefillUnix(WEAPON_COLT45);

        SendServerMessage ( playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You have set %s's Colt-45 stock to %i for gun dealer %s(%i).", Faction[faction][E_FACTION_ABBREV], qty,Emmet[emmet_index][E_EMMET_NAME], emmet_index));

        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_colt45_stock = %i, emmet_colt45_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
        EmmetFaction[faction][emmet_index][E_EMMET_COLT45_STOCK], EmmetFaction[faction][emmet_index][E_EMMET_COLT45_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction][E_FACTION_ID]);

        mysql_tquery(mysql, query);
    }
    else if(!strcmp(choice, "uzi", true)) {
        if(qty > CalculateEmmetRefillCap(WEAPON_UZI)) {
            SendClientMessage(playerid, COLOR_ERROR, sprintf("Max stock for the Uzi is %i. Adjusted your entry to match this.", CalculateEmmetRefillCap(WEAPON_UZI)));
            qty = CalculateEmmetRefillCap(WEAPON_UZI);
        }

        EmmetFaction[faction][emmet_index][E_EMMET_UZI_STOCK] = qty;

        if(qty == -1) EmmetFaction[faction][emmet_index][E_EMMET_UZI_UNIX] = -1;
        else if(qty == 0) EmmetFaction[faction][emmet_index][E_EMMET_UZI_UNIX] = CalculateEmmetRefillUnix(WEAPON_UZI);

        SendServerMessage ( playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You have set %s's Uzi stock to %i for gun dealer %s(%i).", Faction[faction][E_FACTION_ABBREV], qty,Emmet[emmet_index][E_EMMET_NAME], emmet_index));
        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_uzi_stock = %i, emmet_uzi_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
        EmmetFaction[faction][emmet_index][E_EMMET_UZI_STOCK], EmmetFaction[faction][emmet_index][E_EMMET_UZI_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction][E_FACTION_ID]);

        mysql_tquery(mysql, query);
    }
    else if(!strcmp(choice, "tec", true)) {
        if(qty > CalculateEmmetRefillCap(WEAPON_TEC9)) {
            SendClientMessage(playerid, COLOR_ERROR, sprintf("Max stock for the TEC-9 is %i. Adjusted your entry to match this.", CalculateEmmetRefillCap(WEAPON_TEC9)));
            qty = CalculateEmmetRefillCap(WEAPON_TEC9);
        }
        EmmetFaction[faction][emmet_index][E_EMMET_TEC_STOCK] = qty;

        if(qty == -1) EmmetFaction[faction][emmet_index][E_EMMET_TEC_UNIX] = -1;
        else if(qty == 0) EmmetFaction[faction][emmet_index][E_EMMET_TEC_UNIX] = CalculateEmmetRefillUnix(WEAPON_TEC9);

        SendServerMessage ( playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You have set %s's Tec-9 stock to %i for gun dealer %s(%i).", Faction[faction][E_FACTION_ABBREV], qty,Emmet[emmet_index][E_EMMET_NAME], emmet_index));
        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_tec_stock = %i, emmet_tec_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
        EmmetFaction[faction][emmet_index][E_EMMET_TEC_STOCK], EmmetFaction[faction][emmet_index][E_EMMET_TEC_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction][E_FACTION_ID]);

        mysql_tquery(mysql, query);
    }
    else if(!strcmp(choice, "ak47", true)) {
        if(qty > CalculateEmmetRefillCap(WEAPON_AK47)) {
            SendClientMessage(playerid, COLOR_ERROR, sprintf("Max stock for the AK-47 is %i. Adjusted your entry to match this.", CalculateEmmetRefillCap(WEAPON_AK47)));
            qty = CalculateEmmetRefillCap(WEAPON_AK47);
        }
        EmmetFaction[faction][emmet_index][E_EMMET_AK47_STOCK] = qty;

        if(qty == -1) EmmetFaction[faction][emmet_index][E_EMMET_AK47_UNIX] = -1;
        else if(qty == 0) EmmetFaction[faction][emmet_index][E_EMMET_AK47_UNIX] = CalculateEmmetRefillUnix(WEAPON_AK47);

        SendServerMessage ( playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You have set %s's AK-47 stock to %i for gun dealer %s(%i).", Faction[faction][E_FACTION_ABBREV], qty,Emmet[emmet_index][E_EMMET_NAME], emmet_index));
        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_ak47_stock = %i, emmet_ak47_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
        EmmetFaction[faction][emmet_index][E_EMMET_AK47_STOCK], EmmetFaction[faction][emmet_index][E_EMMET_AK47_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction][E_FACTION_ID]);
   
        mysql_tquery(mysql, query);
    }
    else if(!strcmp(choice, "shotgun", true)) {
        if(qty > CalculateEmmetRefillCap(WEAPON_SHOTGUN)) {
            SendClientMessage(playerid, COLOR_ERROR, sprintf("Max stock for the Shotgun is %i. Adjusted your entry to match this.", CalculateEmmetRefillCap(WEAPON_SHOTGUN)));
            qty = CalculateEmmetRefillCap(WEAPON_SHOTGUN);
        }
        EmmetFaction[faction][emmet_index][E_EMMET_SHOTGUN_STOCK] = qty;

        if(qty == -1) EmmetFaction[faction][emmet_index][E_EMMET_SHOTGUN_UNIX] = -1;
        else if(qty == 0) EmmetFaction[faction][emmet_index][E_EMMET_SHOTGUN_UNIX] = CalculateEmmetRefillUnix(WEAPON_SHOTGUN);

        SendServerMessage ( playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You have set %s's Shotgun stock to %i for gun dealer %s(%i).", Faction[faction][E_FACTION_ABBREV], qty,Emmet[emmet_index][E_EMMET_NAME], emmet_index));
        mysql_format(mysql, query, sizeof(query), "UPDATE emmet_factions SET emmet_shotgun_stock = %i, emmet_shotgun_unix = %i WHERE emmet_faction_index = %i AND emmet_faction_fid = %i",
        EmmetFaction[faction][emmet_index][E_EMMET_SHOTGUN_STOCK], EmmetFaction[faction][emmet_index][E_EMMET_SHOTGUN_UNIX], Emmet[emmet_index][E_EMMET_SQLID], Faction[faction][E_FACTION_ID]);

        mysql_tquery(mysql, query);
    }
    else {
        SendClientMessage(playerid, COLOR_YELLOW, "Syntax: /emmetassign [faction] [stock] [colt/uzi/tec/ak47/shotgun]");
        SendClientMessage(playerid, COLOR_ERROR, "Important{DEDEDE}: Enter the ID (Not SQL ID!!) from /factions.");
        SendClientMessage(playerid, COLOR_ERROR, "Important:{DEDEDE} each gun has to be assigned individually. Set \"stock\" to 0 to deplete. Set \"stock\" to -1 to lock.");
        SendClientMessage(playerid, COLOR_ERROR, "If you set stock to 0, the refill time will be automatically calculated!");
    }

    return true;
}

CMD:emmetgoto(playerid, params[]) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    new id;
    if(sscanf(params,"i",id)) {
        SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "/emmetgoto [id] (teleports you to the dealer)");
        return true;
    }
    if(id < 0 || id > MAX_EMMET_NPCS) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Invalid Gun Dealer ID provided! Most be more than 0 or under 32.");
    if(Emmet[id][E_EMMET_SQLID] == INVALID_EMMET_ID) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This Gun Dealer ID isn't set up yet. Wrong ID!");
 
    SOLS_SetPlayerPos(playerid, Emmet[id][E_EMMET_POS_X], Emmet[id][E_EMMET_POS_Y], Emmet[id][E_EMMET_POS_Z]);
    SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", sprintf("You teleported to gun dealer %i (sql %i, %s)", id, Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME]));
    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Teleported to gun dealer sql %i (%s) ", Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME]));

    return true;
}
CMD:emmetid(playerid, params[]) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    new emmet_index = Emmet_GetClosestEntity(playerid);
    if(emmet_index == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }
    SendClientMessage(playerid, COLOR_YELLOW, sprintf("Nearest gun dealer: id: %i (sql %i)", emmet_index, Emmet[emmet_index][E_EMMET_SQLID]));
    return true;
}
CMD:emmetmove(playerid, params[]) { 
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    new id;
    if(sscanf(params,"i",id)) {
        SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "/emmetmove [id] moves the gun dealer to ur location -> only world 0 / int 0 works!");
        SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "Use /emmetid, DON'T use SQLID ONLY \"id:\"!!!!");
        return true;
    }
    if(id < 0 || id > MAX_EMMET_NPCS) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "Invalid Gun Dealer ID provided! Most be more than 0 or under 32.");
    if(Emmet[id][E_EMMET_SQLID] == INVALID_EMMET_ID) return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This Gun Dealer ID isn't set up yet. Wrong ID!");
    new Float: x, Float: y, Float: z, Float: a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    Emmet[id][E_EMMET_POS_X] = x;
    Emmet[id][E_EMMET_POS_Y] = y;
    Emmet[id][E_EMMET_POS_Z] = z;
    Emmet[id][E_EMMET_POS_A] = a;

    SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", sprintf("Moved gun dealer %i (sql %i) (%s) to your location.", 
    id, Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME]));

    new query[256]; // emmet_sqlid
    mysql_format(mysql, query, sizeof(query), "UPDATE `emmet` SET emmet_pos_x='%f',emmet_pos_y='%f',emmet_pos_z='%f',emmet_pos_a='%f' WHERE emmet_sqlid = %i",
    Emmet[id][E_EMMET_POS_X], Emmet[id][E_EMMET_POS_Y], Emmet[id][E_EMMET_POS_Z], Emmet[id][E_EMMET_POS_A],
    Emmet[id][E_EMMET_SQLID]);
    mysql_tquery(mysql, query);

    Emmet_LoadVisuals(id);
    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Moved gun dealer sql %i (%s) to %.03f, %.03f, %.03f", Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], Emmet[id][E_EMMET_POS_X], Emmet[id][E_EMMET_POS_Y], Emmet[id][E_EMMET_POS_Z]));

    return true;
}
CMD:emmetskin(playerid, params[]) { 
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    new id = Emmet_GetClosestEntity(playerid);
    if(id == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }
    new skin;
    if(sscanf(params,"i", skin)) {
        SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "/emmetskin [skinid]");
        return true;
    }

    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Changed gun dealer sql %i (%s) skin to %i (was %i)", Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], skin, Emmet[id][E_EMMET_SKIN]));

    Emmet[id][E_EMMET_SKIN] = skin;

    SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", sprintf("Changed gun dealer %i (sql %i) (%s) skin to %i.", 
    id, Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], skin));

    new query[256]; // emmet_sqlid
    mysql_format(mysql, query, sizeof(query), "UPDATE `emmet` SET emmet_skin = %i WHERE emmet_sqlid = %i",
    Emmet[id][E_EMMET_SKIN], Emmet[id][E_EMMET_SQLID]);
    mysql_tquery(mysql, query);

    Emmet_LoadVisuals(id);

    return true;
}

CMD:emmetname(playerid, params[]) {
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    new name[32];
    new id = Emmet_GetClosestEntity(playerid);
    if(id == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }

    if(sscanf(params,"s[32]", name)) {
        SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "/emmetname [name]");
        return true;
    }

    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Changed gun dealer sql %i (%s) name to %s", Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], name));

    SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", sprintf("Changed gun dealer %i (sql %i) (%s) name to %s.", 
    id, Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME], name));

    format(Emmet[id][E_EMMET_NAME], 32, "%s", name);

    new query[256]; // emmet_sqlid
    mysql_format(mysql, query, sizeof(query), "UPDATE `emmet` SET emmet_name = '%e' WHERE emmet_sqlid = %i", Emmet[id][E_EMMET_NAME], Emmet[id][E_EMMET_SQLID]);
    mysql_tquery(mysql, query);

    Emmet_LoadVisuals(id);
    return true;
}

new PlayerEmmetDeleteWarning[MAX_PLAYERS];
CMD:emmetdelete(playerid, params[]) { 
    if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

    if(!PlayerEmmetDeleteWarning[playerid]) {

        SendClientMessage(playerid, COLOR_RED, "Warning! This action is irreversible! If you wish to continue, do this command again!");
        PlayerEmmetDeleteWarning[playerid] = true;
        return true;
    }

    new id = Emmet_GetClosestEntity(playerid);
    if(id == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }

    if(IsValidDynamicActor(Emmet[id][E_EMMET_ACTOR])) {
        DestroyDynamicActor(Emmet[id][E_EMMET_ACTOR]);
        Emmet[id][E_EMMET_ACTOR] = INVALID_STREAMER_ID;
    }
    if(IsValidDynamic3DTextLabel(Emmet[id][E_EMMET_LABEL])) {
        DestroyDynamic3DTextLabel(Emmet[id][E_EMMET_LABEL]);
        Emmet[id][E_EMMET_LABEL] = DynamicText3D:INVALID_STREAMER_ID;
    }

    new query[256]; // emmet_sqlid
    mysql_format(mysql, query, sizeof(query), "DELETE FROM `emmet` WHERE emmet_sqlid = %i", Emmet[id][E_EMMET_SQLID]);
    mysql_tquery(mysql, query);

    mysql_format(mysql, query, sizeof(query), "DELETE FROM `emmet_factions` WHERE emmet_faction_index = %i", Emmet[id][E_EMMET_SQLID]);
    mysql_tquery(mysql, query);

    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Deleted gun dealer sql %i (%s)", Emmet[id][E_EMMET_SQLID], Emmet[id][E_EMMET_NAME]));
    Emmet[id][E_EMMET_SQLID] = INVALID_EMMET_ID;

    Emmet[id][E_EMMET_POS_X] = 0.0;
    Emmet[id][E_EMMET_POS_Y] = 0.0;
    Emmet[id][E_EMMET_POS_Z] = 0.0;
    Emmet[id][E_EMMET_POS_A] = 0.0;

    for(new i, j = MAX_FACTIONS; i < j; i ++) {
        EmmetFaction[i][id][E_EMMET_FACTION_SQLID] = -1;
        EmmetFaction[i][id][E_EMMET_FACTION_FID] = INVALID_FACTION_ID;
        EmmetFaction[i][id][E_EMMET_FACTION_INDEX] = INVALID_EMMET_ID;
    }

    PlayerEmmetDeleteWarning[playerid] = false;
    return true;
}