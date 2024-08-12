#warning Dissect this module into different files.
enum
{
    // new
    CHEAT_TYPE_AMMO_SOBEIT_HACK,
    CHEAT_TYPE_ARMOUR_HACK
};

AC_GetPlayerWeapon(playerid) {

    return GetPlayerWeapon(playerid);
}

forward OnPlayerCheatDetected( playerid, detection, params ) ;
public OnPlayerCheatDetected( playerid, detection, params ) {

    new string [ 512 ], query [ 512 ], reason [ 64 ] ;

    new hours ; // 10 years
    new secs = hours * 3600 ;
    new unbants = gettime() + secs;

    switch ( detection ) {
        case CHEAT_TYPE_AMMO_SOBEIT_HACK: {

            switch ( GetPlayerWeapon ( playerid ) ) {

                case 0, WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NITESTICK, WEAPON_KNIFE, WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK,
                WEAPON_KATANA, WEAPON_CHAINSAW, WEAPON_CANE, WEAPON_SPRAYCAN, WEAPON_CAMERA: {
                    return true ;
                }
            }

            ProxDetectorEx(playerid, 20.0, COLOR_ORANGE, "[AntiCheat]:", "has been banned for ammo hacks.", .showid = true);
            SendAdminMessage(string) ;

            format ( reason, sizeof ( reason ), "Anticheat Detection: Ammo Hacking" ) ;
            SetAdminRecord ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_BAN, reason, -1, ReturnDateTime () ) ;

            
            mysql_format(mysql, query, sizeof(query), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
            Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( playerid ), "Anticheat", reason, gettime(), unbants);
            mysql_tquery(mysql, query);


            format ( string, sizeof ( string ),"banip %s", ReturnIP ( playerid ));
            SendRconCommand(string);

            KickPlayer ( playerid ) ;   
        }

    }

    return 1;
}


forward Anticheat_IsPlayerSynced(playerid) ;
public Anticheat_IsPlayerSynced(playerid) {

    new vehicleid = GetPlayerVehicleID(playerid) ;

    if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
        if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

            new Float: x, Float: y, Float: z ;
            GetPlayerPos(playerid, x, y, z ) ;

            JT_RemovePlayerFromVehicle(playerid);

            TogglePlayerControllable(playerid, false );
            SetPlayerPosFindZ(playerid, x, y, z ) ;

            // Forcing death animation, UNDER the vehicle (if need be)
            defer Injury_AppendAnimAfterEject(playerid);

            return false ;
        }
    }

    // Is player in injury mode, OR dead...
    if ( IsPlayerInAnyVehicle(playerid) ) {

        // Kick the player out, re-append animation if necessary.
        if ( vehicleid != INVALID_VEHICLE_ID ) {

            if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {

                new Float: x, Float: y, Float: z ;
                GetPlayerPos(playerid, x, y, z ) ;

                JT_RemovePlayerFromVehicle(playerid);

                TogglePlayerControllable(playerid, false );
                SetPlayerPosFindZ(playerid, x, y, z ) ;

                // Forcing death animation, UNDER the vehicle (if need be)
                defer Injury_AppendAnimAfterEject(playerid);

                return false ;
            }
        }
    }

    return true ;
}

Anticheat_Tick(playerid) {

    new string [ 256 ] ;

    if ( IsPlayerPaused ( playerid ) ) {

        return true ;
    }

    if ( ! Anticheat_IsPlayerSynced ( playerid ) ) {

        return true ;
    }

    if ( PlayerVar [ playerid ] [ E_PLAYER_SPOOFED_GUN_AC_WARNING ] ) {


        // decrease the warning amount every +- 2.5 min
        if ( ++ PlayerVar [ playerid ] [ E_PLAYER_SPOOFED_GUN_AC_TICK ] >= 150 ) {
            PlayerVar [ playerid ] [ E_PLAYER_SPOOFED_GUN_AC_TICK ] = 0 ;
            PlayerVar [ playerid ] [ E_PLAYER_SPOOFED_GUN_AC_WARNING ]  -- ;
        }

        if ( PlayerVar [ playerid ] [ E_PLAYER_SPOOFED_GUN_AC_WARNING ] >= 3 ) {
            // Player has tried to do damage using a spoofed gun 3 times within 2.5 min!
            // Fuck them up!

            new reason [ 64 ] ;

            new hours ; // 10 years
            new secs = hours * 3600 ;
            new unbants = gettime() + secs;

            format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s is suspected of weapon(spoofed) hacks. Banning them.", playerid, ReturnMixedName(playerid) ) ;
            SendAdminMessage(string, COLOR_ANTICHEAT) ;


            ProxDetectorEx(playerid, 20.0, COLOR_ORANGE, "[AntiCheat]:", "has been banned for suspected weapon(spoofed) hacks.", .showid = true);

            format ( reason, sizeof ( reason ), "Anticheat Detection: Weapon Hacks (Spoofed)!" ) ;
            SetAdminRecord ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_BAN, reason, -1, ReturnDateTime () ) ;
            
            mysql_format(mysql, string, sizeof(string), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
            Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( playerid ), "Anticheat", reason, gettime(), unbants);
            mysql_tquery(mysql, string);

            format ( string, sizeof ( string ),"banip %s", ReturnIP ( playerid ));
            SendRconCommand(string);

            KickPlayer ( playerid ) ;       
        }
    }

	new Float: armour ;
	GetPlayerArmour ( playerid, armour ) ;
	if (  armour > Character [ playerid ] [ E_CHARACTER_ARMOUR ] ) {

        SetPlayerArmour ( playerid, Character [ playerid ] [ E_CHARACTER_ARMOUR ] ) ;
	}

    if ( GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
        if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {
            format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s is using a jetpack without being an admin.", playerid, ReturnMixedName(playerid) ) ;
            SendAdminMessage(string, COLOR_ANTICHEAT) ;

            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        }
    }

    if ( IsPlayerPlaying(playerid)) {
        
        if(Character [ playerid ] [ E_CHARACTER_ARMOUR ] != 0 ) 
        {
            if ( ! IsPlayerInPoliceFaction(playerid, true) && !IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_DAO, FACTION_TYPE_GOV)) 
            {
                if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] ) {
                    
                    // Player is using crack - so we're giving them the benefit of the doubt.
                    if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] == E_DRUG_TYPE_CRACK ) {

                        return true ;
                    }
                }

                // If tick has been active for 5 seconds
                if ( PlayerVar [ playerid ] [ E_PLAYER_ARMOR_AC_TICK ] >= gettime()) {

                    if (IsPlayerInPoliceFaction(playerid) || IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_DAO, FACTION_TYPE_GOV))
                    {
                        SetCharacterArmour ( playerid, 0.0 ) ;
                        SetPlayerArmour ( playerid, 0.0 ) ;
                        return true;
                    }
                    
                    new acstr[256];
                    format(acstr, sizeof(acstr), "[Anticheat]: (%d) %s is wearing admin without being a cop", playerid, ReturnMixedName(playerid));
                    SendAdminMessage(acstr, COLOR_ANTICHEAT);

                    if ( ++ PlayerVar [ playerid ] [ E_PLAYER_ARMOR_AC_WARNING ] >= 3 ) {
                        if ( ! IsAnyAdminOnline() ) {
                            format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s's has gotten %d/3 warnings. Banning them preemptively. [Client armour: %.02f] [Server: %.02f]", 
                                playerid, ReturnMixedName(playerid), PlayerVar [ playerid ] [ E_PLAYER_ARMOR_AC_WARNING ], Character [ playerid ] [ E_CHARACTER_ARMOUR ], armour  ) ;
                            SendAdminMessage(string, COLOR_ANTICHEAT) ;

                            PlayerVar [ playerid ] [ E_PLAYER_ARMOR_AC_WARNING ] = 0 ;

                            new reason [ 64 ] ;

                            new hours ; // 10 years
                            new secs = hours * 3600 ;
                            new unbants = gettime() + secs;

                            format ( string, sizeof ( string ), "[AntiCheat]: (%d) %s is suspected of armour hacks. Banning them.", playerid, ReturnMixedName(playerid) ) ;
                            SendAdminMessage(string, COLOR_ANTICHEAT) ;

                            ProxDetectorEx(playerid, 20.0, COLOR_ORANGE, "[AntiCheat]:", "has been banned for armour hacks.", .showid = true);

                            format ( reason, sizeof ( reason ), "Anticheat Detection: Armour Hacks" ) ;
                            SetAdminRecord ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], -1337, ARECORD_TYPE_BAN, reason, -1, ReturnDateTime () ) ;
                            
                            mysql_format(mysql, string, sizeof(string), "INSERT INTO bans (account_id, account_name, account_ip, ban_admin, ban_reason, ban_time, unban_time) VALUES (%d, '%e', '%e', '%e', '%e', %d, %d)",
                            Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], ReturnIP ( playerid ), "Anticheat", reason, gettime(), unbants);
                            mysql_tquery(mysql, string);

                            format ( string, sizeof ( string ),"banip %s", ReturnIP ( playerid ));
                            SendRconCommand(string);

                            KickPlayer ( playerid ) ;       
                        }
                    }

                    SetCharacterArmour ( playerid, 0.0 ) ;
                    SetPlayerArmour ( playerid, 0.0 ) ;

                    return true ;
                }

                PlayerVar [ playerid ] [ E_PLAYER_ARMOR_AC_TICK ] = gettime () + 5 ;
            }
        }
    }

    new synced_ammo = SOLS_GetPlayerAmmo(playerid);
    new client_ammo = GetPlayerAmmo(playerid);
    new client_weapon = AC_GetPlayerWeapon(playerid);

    if ( synced_ammo < 0 && GetPlayerWeapon ( playerid ) != 0 ) {


        format ( string, sizeof ( string ), "[AntiCheat]: (%s) %s has a gun with less than 0 ammo (%d)! Reset it to 0.", 
            playerid, ReturnMixedName(playerid), client_ammo ) ;
        SendAdminMessage(string, COLOR_ANTICHEAT) ;

        SOLS_SetPlayerAmmo(playerid, client_weapon, 0 );

    }

    // Only allow spray can to have infinite ammo!
	if ( synced_ammo > 9998 ) {

        new idx = GetPlayerCustomWeapon(playerid) ;

        if ( idx == -1 ) {

            return true ;
        }

        switch ( Weapon [ idx ] [ E_WEAPON_GUNID ] ) {

            case 0, WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NITESTICK, WEAPON_KNIFE, WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK,
                WEAPON_KATANA, WEAPON_CHAINSAW, WEAPON_CANE, WEAPON_SPRAYCAN, WEAPON_CAMERA: {
                    return true ;
            }
        }

        switch ( client_weapon ) {

            case 0, WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NITESTICK, WEAPON_KNIFE, WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK,
                WEAPON_KATANA, WEAPON_CHAINSAW, WEAPON_CANE, WEAPON_SPRAYCAN, WEAPON_CAMERA: {
                    return true ;
            }
        }

		OnPlayerCheatDetected ( playerid, CHEAT_TYPE_AMMO_SOBEIT_HACK, SOLS_GetPlayerAmmo(playerid));
	}

    // Vehicle anticheat ticks
    if(IsPlayerInAnyVehicle(playerid)) {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid != INVALID_VEHICLE_ID) {
            CheckVehicleColorMatches(vehicleid);
        }
    }

    return true ;
}


// block mapstealers

CMD:startrecording(playerid, params[]){

    new string [ 192 ];
    format(string, sizeof(string), "[!!!] [AdmWarn] (%d) %s has just tried a common map stealer command. They have been kicked as a precaution.", playerid, ReturnMixedName(playerid));
    SendAdminMessage(string);

    AddLogEntry ( playerid, LOG_TYPE_SCRIPT, "has been kicked for trying a map stealer command.");
    ProxDetectorEx(playerid, 45.0, COLOR_ORANGE, "[AntiCheat]:", "has been kicked by the anticheat.", .showid = true);

    Kick(playerid);

    return true;
}

CMD:stoprecording(playerid, params[]){
    return cmd_startrecording(playerid, params);
}

CMD:savemodels(playerid, params[]){
    return cmd_startrecording(playerid, params);
}

CMD:saveremovebuildings(playerid, params[]){
    return cmd_startrecording(playerid, params);
}