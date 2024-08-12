Drugs_OnPlayerUse(playerid, type, param, Float: amount ) {


	new drug_name [ 32 ], drug_type [ 32 ] ;
	Drugs_GetParamName ( type, param, drug_name ) ;
	Drugs_GetTypeName ( type, drug_type ) ;


	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Has used %0.2fgr of %s (%s).",
	 	amount, drug_type, drug_name ) 
	) ;

	switch ( type ) {
		case E_DRUG_TYPE_WEED: {
			SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "DEDEDE", "To smoke weed, use /blunt. Use F to cancel and save the blunt for later." ) ;

			new ticks = floatround ( Weed [ param ] [ E_WEED_TICKS ] / amount ) ;

			if ( ticks > 500 ) {
				ticks = ticks / 2 ;
			}

			// Ticks before the effect runs out.
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] = ticks ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] = param ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] = type ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_CD ] = 0 ;
		}

		case E_DRUG_TYPE_COKE: {
			new ticks = floatround ( Cocaine [ param ] [ E_COKE_TICKS ] / amount ) ;

			if ( ticks > 500 ) {
				ticks = ticks / 2 ;
			}

			// Ticks before the effect runs out.
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] = ticks ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] = param ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] = type ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = false ;
		}
		case E_DRUG_TYPE_CRACK: {
			new ticks = floatround ( Crack [ param ] [ E_CRACK_TICKS ] / amount ) ;

			if ( ticks > 500 ) {
				ticks = ticks / 2 ;
			}

			// Ticks before the effect runs out.
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] = ticks ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] = param ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] = type ;
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = false ;
		}

		case E_DRUG_TYPE_METH: return true ;
	}

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_drug_effect_ticks = %d,\
	 	player_drug_effect_active = %d, player_drug_effect_param = %d, player_drug_effect_type = %d WHERE player_id =%d",
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ], Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ], 
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ],Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);


	return true ;
}

CMD:blunt(playerid, params[]) {

	if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] < 0 ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "You've got no active drug." ) ;
	}
	new type = Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] ;

	if ( type == E_DRUG_TYPE_WEED ) {

		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY ) ;
		SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "You've lit up a fat blunt. Smoke some weed." ) ;
	}

	return true ;
}

ResetPlayerDrugEffectTick(playerid) {
	if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] <= 0 ) {

		SetPlayerDrunkLevel(playerid, 0);

		if (!IsPlayerInPoliceFaction(playerid, true))
		{
			// Don't reset armor for on duty cops
			SetCharacterArmour ( playerid, 0.0 );
		}

		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] = 0 ;
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] = 0 ;
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] = -1 ;
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = false ;
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_CD ] = 0 ;

		new query [ 512 ] ;

		mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_drug_effect_ticks = %d,\
		 	player_drug_effect_active = %d, player_drug_effect_param = %d, player_drug_effect_type = %d WHERE player_id =%d",
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ], Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ], 
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ],Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ],
			Character [ playerid ] [ E_CHARACTER_ID ]
		);

		mysql_tquery(mysql, query);

		SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "You feel the effects of the drug you used waning away." ) ;

		return true ;
	}

	return true ;
}

PlayerDrug_EffectTick ( playerid ) {

	new param = Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] ;
	new type = Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] ;

	#pragma unused param

	switch ( type ) {

		case E_DRUG_TYPE_WEED: {

			if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] ) {

				SetPlayerDrunkLevel(playerid, 2000 + Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] ) ;
			}

			if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] && 
				GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_SMOKE_CIGGY ) {

				Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] -- ;

				if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] <= 0 ) {

					ResetPlayerDrugEffectTick(playerid);
					return true ;
				}

				// We don't turn the effect on for weed - we just keep giving the player random health
				if ( random ( 350 ) < 80 ) {

					// If cooldown is active, don't heal.
					if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_CD ] ) {

						Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_CD ] -- ;

						return true ;
					}

					// Make it so they can do /blunt when weed effect is active.

					// Give health here
					// Send msg of effect being active

					new Float: health = GetCharacterHealth ( playerid );

					health += Weed [ param ] [ E_WEED_HEALING ] ;

					if ( health  >= 100 ) {
						SetCharacterHealth ( playerid, 100.0 ) ;
					}

					else SetCharacterHealth ( playerid, health ) ;

					Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_CD ] = 3 ;

					SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "You feel rejuvenated after hitting the blunt." ) ;
				}
			}
		}

		case E_DRUG_TYPE_CRACK: {

			if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] ) {
				if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] ) {

					SetPlayerDrunkLevel(playerid, 2000 + Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] ) ;
				}

				if ( random ( 100 ) < 10 ) {


					new Float: armour = GetCharacterArmour ( playerid ) ;

					if ( armour <= 0.01 ) {
						Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = false ;

						SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "As your crack effect fades, you feel another hit coming." ) ;
					}

					// Crack gives you a one time armour 
					if ( ! Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] ) {

						Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = true ;

						new Float: amount = Crack [ param ] [ E_CRACK_ARMOUR ] ;


						armour += amount ;
						if ( armour >= 100.0 ) {
							armour = 100.0 ;
						}

						SetCharacterArmour(playerid, armour ) ;

						SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "You feel unstoppable after smoking the crack rocks." ) ;
					}
				}

				Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] -- ;

				if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] <= 0 ) {

					ResetPlayerDrugEffectTick(playerid);
					return true ;
				}
			}
		}

		case E_DRUG_TYPE_COKE: {

			if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] ) {
				if ( random ( 100 ) < 10 ) {

					// Crack gives you a one time armour 
					if ( ! Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] ) {

						Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = true ;


						// Give dmg under melee getdmg!
						SendServerMessage ( playerid, COLOR_DRUGS, "Drug Effect", "A3A3A3", "You feel powerful after snorting the line of cocaine." ) ;

					}
				}


				if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] <= 0 ) {

					ResetPlayerDrugEffectTick(playerid);
					return true ;
				}

				Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] -- ;
			}

		}

		case E_DRUG_TYPE_METH: {

		}
	}

	return true ;
}


CMD:druguse(playerid, params[]){
	return cmd_usedrug(playerid, params);
}

CMD:usedrug(playerid, params[]) {

	new slot, Float: amount ;

	if ( sscanf ( params, "if", slot, amount ) ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "/usedrug [slot] [amount]" ) ;
	}

	if ( slot < 0 || slot >= MAX_PLAYER_DRUGS ) {
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("Slot can't be less than 0 or higher than %d", MAX_PLAYER_DRUGS ) ) ;
	}

	if ( amount <= 0.01 ) {
		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "Nigga you can't take less than 0.01 grams, the fuck?" ) ;
	}

	if ( amount > 1.0 ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "You can't take more than one gram - you might die!" ) ;
	}

	if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] < amount ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You don't have that much of this drug - you only have %0.2f.", PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] ) ) ;
	}

	new type = PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] ;

	if ( type == E_DRUG_TYPE_NONE ) {

		return SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "This slot has no valid drug in it." ) ;
	}

	if ( Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] ) {

		SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", sprintf("You already have a drug effect active. Wait for it to pass! (%d ticks left).",
			Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ]
		) );

		SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "If your current drug is weed, you MUST consume it via /blunt to make the effect pass. ");
		SendClientMessage(playerid, 0xA3A3A3FF, "Alternatively you can use /stopdrugeffect which will reset your used drug. This will NOT refund the amount used." ) ;


		return true ;
	}

	new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

	Drugs_GetParamName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
	Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
	Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

	Drugs_OnPlayerUse(playerid, PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ],  PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ], amount ) ;

	switch ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] ) {
		case E_DRUG_TYPE_WEED, E_DRUG_TYPE_CRACK: 
			ProxDetectorEx ( playerid, 15.0, COLOR_ACTION, "*", sprintf("withdraws %0.2f of %s from a %s and smokes it.", amount, drug_name, package_name ), .annonated=true );
		case E_DRUG_TYPE_COKE: 
			ProxDetectorEx( playerid, 15.0, COLOR_ACTION, "*", sprintf("withdraws %0.2f of %s from a %s and snorts it.", amount, drug_name, package_name ), .annonated=true );
	}

	PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] -= amount ;
	PlayerDrugs_Save(playerid) ;

	if ( PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ] <= 0.01 ) {
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_SQLID ] 		= -1 ;
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_TYPE ] 		= 0 ;
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_PARAM ] 		= 0 ;
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_CONTAINER ] 	= 0 ;
		PlayerDrugs [ playerid ] [ slot ] [ E_PLAYER_DRUG_AMOUNT ]		= 0.0 ;
		
		SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "You've used the very last grams of your drug. Your batch has ran out.");
		PlayerDrugs_Save(playerid) ;
	}


	return true ;
}

CMD:stopdrugeffect(playerid, params[]) {

	SetPlayerDrunkLevel(playerid, 0);
	SetCharacterArmour ( playerid, 0.0 );

	Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ] = 0 ;
	Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ] = 0 ;
	Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ] = -1 ;
	Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ] = false ;
	Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_CD ] = 0 ;

	SendServerMessage ( playerid, COLOR_DRUGS, "Drugs", "A3A3A3", "You've cancelled your drug effect. Your used grams are not refunded.");

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_drug_effect_ticks = %d,\
	 	player_drug_effect_active = %d, player_drug_effect_param = %d, player_drug_effect_type = %d WHERE player_id =%d",
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ], Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ], 
		Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ],Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	);

	mysql_tquery(mysql, query);

	AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Has cancelled their drug effect." ) ) ;

	return true ;
}