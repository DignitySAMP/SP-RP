enum WoundData {
	dmg_player,
	dmg_giver[32],
	dmg_weapon,
	dmg_bodypart,
	Float: dmg_amount
} ;

#define MAX_WOUNDS	( MAX_PLAYERS * 10 )
new PlayerWounds [ MAX_WOUNDS ] [ WoundData ] ;

Wounds_LoadEntities ( ) {

	for ( new i; i < MAX_WOUNDS; i ++ ) {
		PlayerWounds [ i ] [ dmg_player ] = -1 ;
		PlayerWounds [ i ] [ dmg_giver ][0] = EOS;
		PlayerWounds [ i ] [ dmg_bodypart ] = -1 ;
		PlayerWounds [ i ] [ dmg_weapon] = -1 ;
		PlayerWounds [ i ] [ dmg_amount ] = 0.0 ;
	}

	return true ;
}

GetFreeWoundID ( ) {

	for ( new i; i < MAX_WOUNDS; i ++ ) {

		if ( PlayerWounds [ i ] [ dmg_player ] == -1 ) {

			return i ;
		}

		else continue ;
	}

	return -1 ;
}

CMD:damages(playerid, params[]) {

	return cmd_showinjuries(playerid, params);
}

static InjuriesDlgStr[2500];

CMD:showinjuries ( playerid, params [] ) {

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage( playerid, COLOR_INJURY, "Syntax", "A3A3A3",  "/showinjuries [target]" );	
	
	}

	if ( ! IsPlayerConnected( target ) ) {
		return SendServerMessage( playerid, COLOR_INJURY, "Syntax", "A3A3A3",  "Target isn't connected." );	
	}

	if ( ! IsPlayerNearPlayer( playerid, target, 5.0 ) && GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR ) {
		return SendServerMessage( playerid, COLOR_INJURY, "Syntax", "A3A3A3",  "You're not close enough to this player to check their injuries." );	
	}

	new count;

	new Float:head, Float:torso;
	Wounds_GetWoundDamage(target, BODY_PART_HEAD, head);
	Wounds_GetWoundDamage(target, BODY_PART_TORSO, torso);

	format(InjuriesDlgStr, sizeof(InjuriesDlgStr), "Injury\tType\tDamage");
	if (GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR)
	{
		strcat(InjuriesDlgStr, "\tPlayer");
	}

	for ( new i; i < MAX_WOUNDS; i ++ ) 
	{
		if ( PlayerWounds [ i ] [ dmg_player ] == target ) 
		{

			// color coded damage:
			// white - leg/arm etc.
			// yellow - potentially critical wound (any to head or torso)
			// red - critical wound (when damage exceeds threshold)

			new color = 0;

			if (PlayerWounds[i][dmg_bodypart] == BODY_PART_TORSO || PlayerWounds[i][dmg_bodypart] == BODY_PART_HEAD)
			{
				color = 0xFFFF00;

				if (PlayerVar [target][E_PLAYER_INJUREDMODE])
				{
					if (PlayerWounds[i][dmg_bodypart] == BODY_PART_HEAD && head > INJURY_CRITICAL_DMG_HEAD) color = 0xFF0000;
					else if (PlayerWounds[i][dmg_bodypart] == BODY_PART_TORSO && torso > INJURY_CRITICAL_DMG_TORSO) color = 0xFF0000;
				}
			}

			if ( GetPlayerAdminLevel(playerid) > ADMIN_LVL_JUNIOR )
			{
				// shows who issued damage if admin
				if (color)
				{
					strcat ( InjuriesDlgStr, sprintf("\n{%06x}%s\t{%06x}%s\t{%06x}(%0.1f)\t{%06x}%s", color, GetBodyPartName (PlayerWounds [ i ] [ dmg_bodypart ] ),  color, GetWoundType ( PlayerWounds [ i ] [ dmg_weapon ] ), color, PlayerWounds [ i ] [ dmg_amount ], color, PlayerWounds [ i ] [ dmg_giver ] )) ;
				}
				else
				{
					strcat ( InjuriesDlgStr, sprintf("\n%s\t%s\t(%0.1f)\t%s", GetBodyPartName (PlayerWounds [ i ] [ dmg_bodypart ] ),  GetWoundType ( PlayerWounds [ i ] [ dmg_weapon ] ), PlayerWounds [ i ] [ dmg_amount ], PlayerWounds [ i ] [ dmg_giver ] )) ;
				}	
			}
			else
			{
				if (color)
				{
					strcat ( InjuriesDlgStr, sprintf("\n{%06x}%s\t{%06x}%s\t{%06x}(%0.1f)", color, GetBodyPartName (PlayerWounds [ i ] [ dmg_bodypart ] ),  color, GetWoundType ( PlayerWounds [ i ] [ dmg_weapon ] ), color, PlayerWounds [ i ] [ dmg_amount ] )) ;
				}
				else
				{
					strcat ( InjuriesDlgStr, sprintf("\n%s\t%s\t(%0.1f)", GetBodyPartName (PlayerWounds [ i ] [ dmg_bodypart ] ),  GetWoundType ( PlayerWounds [ i ] [ dmg_weapon ] ), PlayerWounds [ i ] [ dmg_amount ] )) ;
				}
				
			}

			count ++ ;
		}

		else continue ;
	}

	if ( count == 0 ) 
	{
		return SendServerMessage( playerid, COLOR_INJURY, "Injury", "A3A3A3",  sprintf("%s (%d) has no visible injuries.", ReturnSettingsName ( target, playerid ), target ) );	
	}

	ShowPlayerDialog(playerid, 546, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Injuries to %s (%d)\n", ReturnSettingsName ( target, playerid ), target ), InjuriesDlgStr, "Close", "" ) ;

	return true ;
}

SetPlayerWound ( playerid, weaponid, bodypart, Float: amount, giver=-1) {

	if ( weaponid == 0 || weaponid == 41 ) {

		return true ;
	}

	new woundid = GetFreeWoundID ( ) ;

	if ( woundid == -1 ) {

		return printf("Tried setting wound for player %s (%d) [DATA: wep %d amount %.02f] but GetFreeWoundID() returned -1.", ReturnMixedName ( playerid ), playerid, weaponid, amount ) ;
	}

	PlayerWounds [ woundid ] [ dmg_player ] 	= playerid ;
	PlayerWounds [ woundid ] [ dmg_weapon ] 	= weaponid ;
	PlayerWounds [ woundid ] [ dmg_bodypart ] 	= bodypart ;
	format(PlayerWounds [ woundid ] [ dmg_giver ], 32, ReturnMixedName(giver));
	PlayerWounds [ woundid ] [ dmg_amount ]		= amount ;

	return true ;
}

Wounds_GetWoundCount(playerid, bodypart) {

	new count = 0 ;

	for ( new i; i < sizeof ( PlayerWounds ); i ++ ) {

		if ( PlayerWounds [ i ] [ dmg_player ] == playerid ) {

			if ( PlayerWounds [ i ] [ dmg_bodypart ] == bodypart ) {

				count ++ ;
			}

			else continue ;
		}

		else continue ;
	}

	return count ;
}


Wounds_GetWoundDamage(playerid, bodypart, &Float:damage) {

	damage = 0.0;

	for ( new i; i < sizeof ( PlayerWounds ); i ++ ) {

		if ( PlayerWounds [ i ] [ dmg_player ] == playerid ) {

			if ( PlayerWounds [ i ] [ dmg_bodypart ] == bodypart ) {

				damage += PlayerWounds [ i ] [ dmg_amount ];
			}

			else continue ;
		}

		else continue ;
	}
}

ResetPlayerWounds ( playerid ) {

	for ( new i; i < sizeof ( PlayerWounds ); i ++ ) {

		if ( PlayerWounds [ i ] [ dmg_player ] == playerid ) {

			PlayerWounds [ i ] [ dmg_player ] 	= -1 ;

			PlayerWounds [ i ] [ dmg_weapon ] 	= -1 ;
			PlayerWounds [ i ] [ dmg_bodypart ] = -1 ;
			PlayerWounds [ i ] [ dmg_giver ] = -1 ;

			PlayerWounds [ i ] [ dmg_amount ]	= 0.0 ;

		}

		else continue ;
	}

	return true ;
}

GetWoundType ( weaponid ) {

	new woundtype [ 25 ] ;

	switch ( weaponid ) {

		case 0: woundtype = "Fist";
		case 1 .. 3, 5 .. 7, 10 .. 15: woundtype = "Blunt Trauma" ;
		case 4, 8 .. 9: woundtype = "Stab Wound" ;
		case 22 .. 34: woundtype = "Gunshot Wound" ;
		case 18, 35 .. 37, 16, 39 .. 40: woundtype = "Burn Wound" ;
		default: woundtype = "Unknown";
	}

	return woundtype ;
}

GetBodyPartName ( bodypart ) {
	new bodypartname [ 25 ] ;

	switch ( bodypart ) {
		case BODY_PART_GROIN: 		bodypartname = "Groin" ;
		case BODY_PART_TORSO: 		bodypartname = "Torso" ;
		case BODY_PART_LEFT_ARM:	bodypartname = "Left Arm" ;
		case BODY_PART_RIGHT_ARM:	bodypartname = "Right Arm" ;
		case BODY_PART_LEFT_LEG: 	bodypartname = "Left Leg" ;
		case BODY_PART_RIGHT_LEG:	bodypartname = "Right Leg" ;
		case BODY_PART_HEAD:		bodypartname = "Head" ;
		default: {

			bodypartname = "Unknown";
		}
	}

	return bodypartname ;
}