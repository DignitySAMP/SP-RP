new bool: player_damaged_leg[ MAX_PLAYERS ];
new bool: antiReFall [ MAX_PLAYERS ];

new player_leg_tick [ MAX_PLAYERS ];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
DamageArms ( playerid ) {

    if ( ! PlayerDamage [ playerid ] [ DAMAGE_ARMS ] ) {

        SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  "You've been hit in your arm! Shooting skills reduced." );

        Weapon_SetSkillLevel(playerid, 500);
        PlayerDamage [ playerid ] [ DAMAGE_ARMS ] = true ;
	    AddLogEntry(playerid, LOG_TYPE_DAMAGE, "injured their arms");

        return true ;
    }

    return true ;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DamageLegs ( playerid ) {

    if ( ! PlayerDamage [ playerid ] [ DAMAGE_LEGS ] ) {

        PlayerDamage [ playerid ] [ DAMAGE_LEGS ] = true ;

        SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  "Your legs have been injured. You may experience trouble walking." );
	    AddLogEntry(playerid, LOG_TYPE_DAMAGE, "injured their legs");

        defer LegDamageHandler(playerid);
        return true ;
    }

    return true ;
}

public OnPlayerKeyStateChange (playerid, newkeys, oldkeys) {

    if ( HOLDING ( KEY_SPRINT ) && IsPlayerRunning ( playerid ) && !IsPlayerInAnyVehicle(playerid)) {

        if ( PlayerDamage [ playerid ] [ DAMAGE_LEGS ] ) {

            player_damaged_leg [ playerid ] = true ;
        }
    }

    if ( newkeys & KEY_JUMP && !IsPlayerInAnyVehicle(playerid) ) {

        if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || PlayerDamage [ playerid ] [ DAMAGE_LEGS ] ) {
        
            return ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
        }
    }
    
    #if defined legs_OnPlayerKeyStateChange
        return legs_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange legs_OnPlayerKeyStateChange
#if defined legs_OnPlayerKeyStateChange
    forward legs_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

timer LegDamageHandler[1000](playerid) {

////    print("LegDamageHandler timer called (injuries.pwn)");

    if ( IsPlayerInAnyVehicle(playerid) ) {
        defer LegDamageHandler(playerid);
        return false ;
    }

    if ( PlayerDamage [ playerid ] [ DAMAGE_LEGS ] ) {

        if( player_damaged_leg [ playerid ] && IsPlayerRunning(playerid) ) {

            if( ++ player_leg_tick [playerid] >= 3) {

                antiReFall [ playerid ] = false ;
                player_leg_tick [ playerid ] = 0 ;
            }

            if ( ! IsPlayerRunning ( playerid ) ) {

                player_damaged_leg [ playerid ] = false;
                player_leg_tick [ playerid ] = 0 ;
            }

            if ( !antiReFall [ playerid ] ) {

                antiReFall [ playerid ] = true ;
                ApplyAnimation(playerid, "ped", "fall_collapse", 4.1, 0, 1, 1, 0, 0, 1);

            }
        }

        defer LegDamageHandler(playerid);
        return true ;
    }

    else return false ;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IsPlayerRunning ( playerid ) {
    new keys, ud, lr ;
    GetPlayerKeys ( playerid, keys, ud, lr ) ;

    if ( keys & KEY_WALK )
        return false ;

    if ( ud == 0 && lr == 0 )
        return false ;

    return true ;
}

stock IsPlayerFalling ( playerid ) {
    new index = GetPlayerAnimationIndex ( playerid ) ;

    if ( index >= 958 && index <= 979 || index == 1130 || index == 1195 || index == 1132 ) return true ;

    return false ;
}