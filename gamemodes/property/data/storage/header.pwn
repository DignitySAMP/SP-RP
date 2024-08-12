#include "property/data/storage/store_gun.pwn"
#include "property/data/storage/store_drugs.pwn"

CMD:propstorage(playerid, params[]) {

	return cmd_propertystorage(playerid, params);
}
CMD:propertystorage(playerid, params[]) {
	
	
	if (!PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) 
	{
		if ( IsPlayerInPoliceFaction ( playerid ) ) {
			return SendServerMessage ( playerid, COLOR_ERROR, "Warning", "A3A3A3", "Police officers can not use gun-related commands to avoid abuse." ) ;
		}
		if ( IsPlayerIncapacitated(playerid, false) ) {
		
			return true ; 
		}
		if ( ! CanPlayerUseGuns(playerid, 8) ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "Your account is too new! You can't use gun related features yet." ) ;
		}
	}

	new property_enum_id = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( property_enum_id == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be inside your property, near the door.");
	}

	if ( Property [ property_enum_id ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && !PlayerVar[playerid][E_PLAYER_ADMIN_DUTY]) {
		
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't own this property.");
	}

	SendClientMessage(playerid, COLOR_PROPERTY, "Property Contents:" ) ;
	new gun_name [ 32 ] ;

	new count  = 0 ;
	for ( new i, j = 10 ; i < j ; i ++ ) {


		if ( Property [ property_enum_id ] [ E_PROPERTY_GUN ] [ i ] ) { 
			Weapon_GetGunName ( Property [ property_enum_id ] [ E_PROPERTY_GUN ] [ i ], gun_name, sizeof ( gun_name ) );
			SendClientMessage(playerid, COLOR_GRAD0, sprintf("(Slot %d): %s with %d ammo.", i, gun_name, Property [ property_enum_id ] [ E_PROPERTY_AMMO ] [ i ] ) );
			count ++ ;
		}
	}

	if ( ! count ) {

		SendClientMessage(playerid, 0xDEDEDEFF, "No guns to show!");
	}

	count  = 0 ;

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ], string [ 256 ] ;

	for ( new i, j = 10 ; i < j ; i ++ ) {


		if ( Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ i ] != E_DRUG_TYPE_NONE ) {
			Drugs_GetParamName ( Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ i ], 
				Property [ property_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ i ], drug_name 
			) ;

			Drugs_GetPackageName ( Property [ property_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ i ], package_name ) ;

			Drugs_GetTypeName(Property [ property_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ i ], drug_type ) ;

			format ( string, sizeof ( string ), "(Slot %d): %.02fgr of %s stored in a %s. {FFFF00}[%s] ",
				i, Property [ property_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT] [ i ], drug_name, package_name, drug_type
			 ) ;

			SendClientMessage(playerid, COLOR_GRAD0, string );
			count ++ ;
		}
	}

	if ( ! count ) {

		SendClientMessage(playerid, 0xDEDEDEFF, "No drugs to show!");
	}

	return true ;
}