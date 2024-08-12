static CharNameDlgStr[1024];
// mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO accounts (Character_name, Character_rentedhouse, Character_health) VALUES ('%e', '%e', '%e', '%d', '%d', '-1', '100.0')",
Account_CharacterCreation ( playerid, error = 0 ) {

	inline CharacterCreation(pid, dialogid, response, listitem, string:inputtext[] ) { 
		#pragma unused pid, dialogid, response, listitem, inputtext

		if ( ! response ) 
		{
			// Take them back
			SOLS_ShowCharSelection(playerid, 0, false);
			return true ;
		}

		if ( response ) {

			if ( strlen ( inputtext ) < 6 || strlen ( inputtext ) > MAX_PLAYER_NAME ) {

				//SendClientMessage(playerid, COLOR_ERROR, sprintf("Your name can't be less than 6 characters or more than %d!", MAX_PLAYER_NAME ) );
				Account_CharacterCreation ( playerid, 1 );

				return true ;
			}

			if ( ! IsRPNameRegex(inputtext) ) {

				//SendClientMessage(playerid, COLOR_ERROR, "The name you entered isn't valid. Try again and make sure you include the underscore." );
				Account_CharacterCreation ( playerid, 2 );

				return true ;
			}

			new query [ 96 ] ;
			mysql_format ( mysql, query, sizeof ( query ), "SELECT * FROM characters WHERE player_name = '%e'", inputtext);
			mysql_tquery(mysql, query, "Account_CheckPlayerName", "is", playerid, inputtext);
		}
	}

	CharNameDlgStr[0] = EOS;
	strcat(CharNameDlgStr, "{FFFFFF}You are about to create a new {5DB6E5}Player Character{FFFFFF}.");

	strcat(CharNameDlgStr, "\n\n{FFFFFF}Please read the following information:{ADBEE6}");
	strcat(CharNameDlgStr, "\n- Names must follow the Firstname_Lastname format (including the underscore).");
	strcat(CharNameDlgStr, "\n- Characters should be fictional, do not use famous, or recognizeable real-life names.");
	strcat(CharNameDlgStr, "\n- After entering a name, you will be able to select your character and complete their profile.\n\n");

	if (error == 1) strcat(CharNameDlgStr, sprintf("{FF0000}Names must be between 6 and %d characters in length.\n", MAX_PLAYER_NAME));
	else if (error == 2) strcat(CharNameDlgStr, "{FF0000}The name you entered wasn't in the correct format (Firstname_Lastname).\n");
	else if (error == 3) strcat(CharNameDlgStr, "{FF0000}Sorry, this character name is already taken by another player.\n");

	strcat(CharNameDlgStr, "{FFFFFF}Enter a name for your character and press {AA3333}OK{FFFFFF} to continue.");
	Dialog_ShowCallback ( playerid, using inline CharacterCreation, DIALOG_STYLE_INPUT, "Create New Character", CharNameDlgStr, "OK", "Back" );


	return true ;
}

GetCharacterCount(playerid) {


	return PlayerVar [ playerid ] [ E_PLAYER_CHARACTER_FOUND ] ;
}

timer Account_DisplayCharacters[500](playerid) {

	if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) {

		SendClientMessage(playerid, -1, "Tried fetching characters, but your account ID isn't valid. Please relog.");
		defer LoginWindow[1000](playerid, AUTH_MSG_DEFAULT);
		return false ;
	}

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	// SetPlayerTime(playerid, Server [ E_SERVER_TIME_HOURS], Server [ E_SERVER_TIME_MINUTES]);

	inline E_CHECK_PLAYER_CHARACTERS() {
		PlayerVar [ playerid ] [ E_PLAYER_CHARACTER_FOUND ] = 0;

		if (!cache_num_rows()) {

			//SendClientMessage(playerid, -1, "No characters to show!");
			//Account_CharacterCreation(playerid);

			// NEW: Show them the normal char select screen
			SOLS_ShowCharSelection(playerid, 0);

			return true ;
		}
		else {
			new name [ 24 ] ;

			for(new i = 0, r = cache_num_rows(); i < r; ++i) {

				cache_get_value_name(i, "player_name", name);
		
				if ( i >= MAX_CHARACTERS) {

					SendClientMessage(playerid, COLOR_RED, sprintf("Tried loading character \"%s\", but you've passed your character limit! It's unusable!", name));
					continue;
				}

				// Core data
				cache_get_value_name_int ( i, "player_id", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_ID ]);
				cache_get_value_name_int ( i, "account_id", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_ACC_ID ]);

				format ( CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_NAME ], MAX_PLAYER_NAME, name);
				format ( CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_RP_NAME ], MAX_PLAYER_NAME, name);
				strreplace(CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_RP_NAME ], "_", " ");

				cache_get_value_name_int ( i, "player_skinid", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_SKIN ]);

				// Custom selection stuff
				cache_get_value_name_int ( i, "player_factionid", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_FACTION_ID ]);
				cache_get_value_name_int ( i, "player_factiontier", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_FACTION_TIER ]);
				cache_get_value_name ( i, "player_factionrank", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_FACTION_RANK ]);
				cache_get_value_name_int ( i, "player_hours", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_HOURS_PLAYED ]);
				cache_get_value_name_int ( i, "player_logindate", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_LAST_LOGIN ]);
				//cache_get_value_name ( i, "login_date_str", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_LAST_LOGIN_STR ]);

				

				// Hitman lockout
				cache_get_value_name_int( i, "player_hitman_killed", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_HITMAN_KILLED ]);
				cache_get_value_name_int( i, "player_hitman_unlocked", CharacterBuffer [ playerid ] [ i ] [ E_CHAR_BUFFER_HITMAN_UNLOCKED ]);


				// For the selection script so we can use this value cross value.
				PlayerVar [ playerid ] [ E_PLAYER_CHARACTER_FOUND ] ++ ;
			}

			//PlayerClassSelection [ playerid ] [ E_PLAYER_CLASS_SEL_CHARID ] = 0 ;
			//Select_StartCharacterSelection(playerid, PlayerClassSelection [ playerid ] [ E_PLAYER_CLASS_SEL_CHARID ] );
			//SendClientMessage(playerid, -1, "Found character!");

			SOLS_ShowCharSelection(playerid, 0);
		}
	}

	MySQL_TQueryInline(mysql, using inline E_CHECK_PLAYER_CHARACTERS, "SELECT * FROM `characters` WHERE `account_id` = %d", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]);

	return true ;
}

forward SOLS_OnLoadCharacter(playerid, character_id);
public SOLS_OnLoadCharacter(playerid, character_id)
{
	// You can hook this :)
	return 1;
}

Account_LoadCharacterData(playerid, character_id) {
	new query [ 512 ] ; 
	inline E_FETCH_PLAYER_CHARACTER() {
		if (cache_num_rows()) {
			cache_get_value_name_int ( 0, "player_id", Character [ playerid ] [ E_CHARACTER_ID ]);
			cache_get_value_name_int ( 0, "account_id", Character [ playerid ] [ E_CHARACTER_ACCOUNT_ID ]);

			cache_get_value_name( 0, "player_name", Character [ playerid ] [ E_CHARACTER_NAME ]);

			cache_get_value_name( 0, "player_uniqueid", Character [ playerid ] [ E_CHARACTER_UNIQUEID ]);
			cache_get_value_name( 0, "player_ip", Character [ playerid ] [ E_CHARACTER_IP ]);

			cache_get_value_name_int( 0, "player_registered", Character [ playerid ] [ E_CHARACTER_REGISTERED ]) ;

			cache_get_value_name_float ( 0, "player_last_pos_x", Character [ playerid ] [ E_CHARACTER_LAST_POS_X ]) ;
			cache_get_value_name_float ( 0, "player_last_pos_y", Character [ playerid ] [ E_CHARACTER_LAST_POS_Y ]) ;
			cache_get_value_name_float ( 0, "player_last_pos_z", Character [ playerid ] [ E_CHARACTER_LAST_POS_Z ]) ;
			cache_get_value_name_float ( 0, "player_last_pos_a", Character [ playerid ] [ E_CHARACTER_LAST_POS_A ]) ;
			cache_get_value_name_int( 0, "player_last_pos_int", Character [ playerid ] [ E_CHARACTER_LAST_POS_INT ]) ;
			cache_get_value_name_int( 0, "player_last_pos_vw", Character [ playerid ] [ E_CHARACTER_LAST_POS_VW ]) ;

			cache_get_value_name_int( 0, "player_skinid", Character [ playerid ] [ E_CHARACTER_SKINID ]) ;
			cache_get_value_name( 0, "player_skin_model", Character [ playerid ] [ E_CHARACTER_SKIN_MODEL ]);
			cache_get_value_name( 0, "player_skin_dir", Character [ playerid ] [ E_CHARACTER_SKIN_DIR ]);

			cache_get_value_name_int( 0, "player_chatstyle", Character [ playerid ] [ E_CHARACTER_CHAT_STYLE ]) ;

			cache_get_value_name_int( 0, "player_factionid", Character [ playerid ] [ E_CHARACTER_FACTIONID ]) ;

			cache_get_value_name_int( 0, "player_factiontier", Character [ playerid ] [ E_CHARACTER_FACTIONTIER ]) ;
			cache_get_value_name_int( 0, "player_factionrank", Character [ playerid ] [ E_CHARACTER_FACTIONRANK ]);
			cache_get_value_name_int( 0, "player_factionsquad", Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD ]) ;
			cache_get_value_name_int( 0, "player_factionbadge", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ]) ;
			cache_get_value_name_int( 0, "player_factionsuspension", Character [ playerid ] [ E_CHARACTER_FACTION_SUSPENSION ]) ;

			cache_get_value_name_int( 0, "player_outstanding_fines", Character [ playerid ] [ E_CHARACTER_OUTSTANDING_FINES ]) ;

			cache_get_value_name_int ( 0, "player_factiontier", Character [ playerid ] [ E_CHARACTER_FACTIONTIER ]);
			cache_get_value_name ( 0, "player_factionrank", Character [ playerid ] [ E_CHARACTER_FACTIONRANK ]);
			cache_get_value_name_int ( 0, "player_factionsquad", Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD ]);
			cache_get_value_name_int ( 0, "player_factionsquad2", Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD2 ]);
			cache_get_value_name_int ( 0, "player_factionsquad3", Character [ playerid ] [ E_CHARACTER_FACTION_SQUAD3 ]);
			cache_get_value_name_int ( 0, "player_factionbadge", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ]);
			cache_get_value_name_int ( 0, "player_factionsuspension", Character [ playerid ] [ E_CHARACTER_FACTION_SUSPENSION ]);

			cache_get_value_name_int(0, "player_cash", Character [ playerid ] [ E_CHARACTER_CASH ]);
			cache_get_value_name_int(0, "player_bankcash", Character [ playerid ] [ E_CHARACTER_BANKCASH ]);
			cache_get_value_name_int(0, "player_savings", Character [ playerid ] [ E_CHARACTER_SAVINGS ]);

			cache_get_value_name_int(0, "player_paycheck", Character [ playerid ] [ E_CHARACTER_PAYCHECK ]);
			cache_get_value_name_int(0, "player_level", Character [ playerid ] [ E_CHARACTER_LEVEL ]);
			cache_get_value_name_int(0, "player_hours", Character [ playerid ] [ E_CHARACTER_HOURS ]);
			cache_get_value_name_int(0, "player_exp", Character [ playerid ] [ E_CHARACTER_EXP ]);

			cache_get_value_name_int(0, "player_registerdate", Character [ playerid ] [ E_CHARACTER_REGISTERDATE ]);
			cache_get_value_name_int(0, "player_logindate", Character [ playerid ] [ E_CHARACTER_LOGINDATE ]);

			// Inventory
			cache_get_value_name_int(0, "player_driverslicense", Character [ playerid ] [ E_CHARACTER_DRIVERSLICENSE ]);
			cache_get_value_name_int(0, "player_gunlicense", Character [ playerid ] [ E_CHARACTER_GUNLICENSE ]);

			cache_get_value_name_int(0, "player_phnumber", Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ]);
			cache_get_value_name_int(0, "player_phcolour", Character [ playerid ] [ E_CHARACTER_PHONE_COLOUR ]);
			cache_get_value_name_int(0, "player_phbg", Character [ playerid ] [ E_CHARACTER_PHONE_BACKGROUND ]);
			cache_get_value_name_int(0, "player_phcredit", Character [ playerid ] [ E_CHARACTER_PHONE_CREDIT ]);
			cache_get_value_name_int(0, "player_phbattery", Character [ playerid ] [ E_CHARACTER_PHONE_BATTERY ]);

			cache_get_value_name_float(0, "player_health", Character [ playerid ] [ E_CHARACTER_HEALTH ]);
			cache_get_value_name_float(0, "player_armour", Character [ playerid ] [ E_CHARACTER_ARMOUR ]);

			cache_get_value_name_int(0, "player_soldproperty", Character [ playerid ] [ E_CHARACTER_SOLD_PROPERTY ]);
			cache_get_value_name_int(0, "player_soldfuelstation", Character [ playerid ] [ E_CHARACTER_SOLD_FUELSTATION ]);
			cache_get_value_name_int(0, "player_soldfurni", Character [ playerid ] [ E_CHARACTER_SOLD_FURNITURE ]);


			cache_get_value_name_int(0, "player_rentroom", Character [ playerid ] [ E_CHARACTER_RENTEDHOUSE ]);
			cache_get_value_name_int(0, "player_spawnproperty", Character [ playerid ] [ E_CHARACTER_PROPERTYSPAWN ]);

			cache_get_value_name_int(0, "player_maskid", Character [ playerid ] [ E_CHARACTER_MASKID ]);

			cache_get_value_name_int(0, "player_hud_direction", Character [ playerid ] [ E_CHARACTER_HUD_DIRECTION ]);
			cache_get_value_name_int(0, "player_hud_vehfadein", Character [ playerid ] [ E_CHARACTER_HUD_VEH_FADEIN]);
			cache_get_value_name_int(0, "player_hud_trademark", Character [ playerid ] [ E_CHARACTER_HUD_TRADEMARK]);
			cache_get_value_name_int(0, "player_hud_vehicle", Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE]);
			cache_get_value_name_int(0, "player_hud_territory", Character [ playerid ] [ E_CHARACTER_HUD_TERRITORY]);
			cache_get_value_name_int(0, "player_hud_minigame", Character [ playerid ] [ E_CHARACTER_HUD_MINIGAME]);
			cache_get_value_name_int(0, "player_hud_clock", Character [ playerid ] [ E_CHARACTER_HUD_CLOCK]);

			cache_get_value_name_int(0, "player_blunt_strain", Character [ playerid ] [ E_CHARACTER_BLUNT_STRAIN ]);
			cache_get_value_name_int(0, "player_blunt_progress", Character [ playerid ] [ E_CHARACTER_BLUNT_PROGRESS ]);

			cache_get_value_name_int(0, "player_bandage_cd", Character [ playerid ] [ E_CHARACTER_BANDAGE_COOLDOWN ]);
			cache_get_value_name_int(0, "player_last_bandage_cd", Character [ playerid ] [ E_CHARACTER_LAST_BANDAGE_CD ]);

			cache_get_value_name_int(0, "player_helpup_cd", Character [ playerid ] [ E_CHARACTER_HELPUP_CD ]);
			cache_get_value_name_int(0, "player_heal_cd", Character [ playerid ] [ E_CHARACTER_HEAL_CD ]);

			cache_get_value_name_int(0, "player_ajail_time", Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ]);
			cache_get_value_name(0, "player_oajail_reason", Character [ playerid ] [ E_CHARACTER_OAJAIL_REASON ]);
			cache_get_value_name(0, "player_oajail_admin", Character [ playerid ] [ E_CHARACTER_OAJAIL_ADMIN ]);

			cache_get_value_name_int(0, "player_gd_wood", Character [ playerid ] [ E_CHARACTER_GD_WOOD ]);
			cache_get_value_name_int(0, "player_gd_metal", Character [ playerid ] [ E_CHARACTER_GD_METAL ]);
			cache_get_value_name_int(0, "player_gd_parts", Character [ playerid ] [ E_CHARACTER_GD_PARTS ]);

			cache_get_value_name_int(0, "player_tutorial", Character [ playerid ] [ E_CHARACTER_TUTORIAL ]);

			cache_get_value_name_int(0, "player_ammo_a", Character [ playerid ] [ E_CHARACTER_AMMO_A ]);
			cache_get_value_name_int(0, "player_ammo_b", Character [ playerid ] [ E_CHARACTER_AMMO_B ]);
			cache_get_value_name_int(0, "player_ammo_c", Character [ playerid ] [ E_CHARACTER_AMMO_C ]);
			cache_get_value_name_int(0, "player_ammo_d", Character [ playerid ] [ E_CHARACTER_AMMO_D ]);
			cache_get_value_name_int(0, "player_ammo_e", Character [ playerid ] [ E_CHARACTER_AMMO_E ]);
			cache_get_value_name_int(0, "player_ammo_f", Character [ playerid ] [ E_CHARACTER_AMMO_F ]);
			cache_get_value_name_int(0, "player_ammo_g", Character [ playerid ] [ E_CHARACTER_AMMO_G ]);
			cache_get_value_name_int(0, "player_ammo_h", Character [ playerid ] [ E_CHARACTER_AMMO_H ]);
			cache_get_value_name_int(0, "player_ammo_i", Character [ playerid ] [ E_CHARACTER_AMMO_I ]);
			cache_get_value_name_int(0, "player_ammo_j", Character [ playerid ] [ E_CHARACTER_AMMO_J ]);

			cache_get_value_name_int(0, "player_vl_slot_0", Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ]);
			cache_get_value_name_int(0, "player_vl_slot_1", Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ]);
			cache_get_value_name_int(0, "player_vl_slot_2", Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ]);
			cache_get_value_name_int(0, "player_vl_slot_3", Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ]);
			cache_get_value_name_int(0, "player_vl_slot_4", Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ]);
			cache_get_value_name_int(0, "player_vl_slot_5", Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ]);
			cache_get_value_name_int(0, "player_vl_slot_6", Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ]);
			cache_get_value_name_int(0, "player_vl_slot_7", Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ]);
			cache_get_value_name_int(0, "player_vl_slot_8", Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ]);
			cache_get_value_name_int(0, "player_vl_slot_9", Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ]);

			cache_get_value_name_int(0, "player_hud_voicelines", Character [ playerid ] [ E_CHARACTER_VOICELINE_SOUND]);
			cache_get_value_name_int(0, "player_spraytag", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ]);

			// Money givers
			cache_get_value_name_int(0, "player_property_refund", Character [ playerid ] [ E_CHARACTER_PROPERTY_REFUND ]);
			cache_get_value_name_int(0, "player_vehicle_refund", Character [ playerid ] [ E_CHARACTER_VEHICLE_REFUND ]);
			cache_get_value_name_int(0, "player_update_reward", Character [ playerid ] [ E_CHARACTER_UPDATE_REWARD ]);

			// Fear and respect
			cache_get_value_name_int(0, "player_respect", Character [ playerid ] [ E_CHARACTER_RESPECT ]);
			cache_get_value_name_int(0, "player_fear", Character [ playerid ] [ E_CHARACTER_FEAR ]);
			cache_get_value_name_int(0, "player_fnr_givable", Character [ playerid ] [ E_CHARACTER_FnR_GIVABLE ]);

			// Drugs
			cache_get_value_name_int(0, "player_drug_effect_ticks", Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TICKS ]);
			cache_get_value_name_int(0, "player_drug_effect_active", Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_ACTIVE ]);
			cache_get_value_name_int(0, "player_drug_effect_param", Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_PARAM ]);
			cache_get_value_name_int(0, "player_drug_effect_type", Character [ playerid ] [ E_CHARACTER_DRUG_EFFECT_TYPE ]);

			cache_get_value_name_int(0, "player_mole", Character [ playerid ] [ E_CHARACTER_MOLE ]);


			cache_get_value_name_int(0, "player_prop_food", Character [ playerid ] [ E_CHARACTER_PROP_FOOD ]);
			cache_get_value_name_int(0, "player_prop_food_timeleft", Character [ playerid ] [ E_CHARACTER_PROP_FOOD_TIME ]);
			cache_get_value_name_int(0, "player_prop_food_uses", Character [ playerid ] [ E_CHARACTER_PROP_FOOD_USES ]);

			cache_get_value_name_int(0, "player_prop_drink", Character [ playerid ] [ E_CHARACTER_PROP_DRINK ]);
			cache_get_value_name_int(0, "player_prop_drink_timeleft", Character [ playerid ] [ E_CHARACTER_PROP_DRINK_TIME ]);
			cache_get_value_name_int(0, "player_prop_drink_uses", Character [ playerid ] [ E_CHARACTER_PROP_DRINK_USES ]);

			cache_get_value_name_int(0, "player_prop_cigarette", Character [ playerid ] [ E_CHARACTER_PROP_CIGARETTE ]);
			cache_get_value_name_int(0, "player_prop_cigarette_uses_left", Character [ playerid ] [ E_CHARACTER_PROP_CIGARETTE_USES ]);

			cache_get_value_name_int(0, "player_prop_menu", Character [ playerid ] [ E_CHARACTER_PROP_MENU ]);
			cache_get_value_name_int(0, "player_prop_crate", Character [ playerid ] [ E_CHARACTER_PROP_CRATE ]);

			cache_get_value_name_int(0, "player_hitman" , Character [ playerid ] [ E_CHARACTER_HITMAN ]);
			cache_get_value_name_int(0, "player_hitman_rank", Character [ playerid ] [ E_CHARACTER_HITMAN_RANK ]);

			cache_get_value_name_int(0, "player_hitman_killed", Character [ playerid ] [ E_CHARACTER_HITMAN_KILLED ]);
			cache_get_value_name_int(0, "player_hitman_unlocked", Character [ playerid ] [ E_CHARACTER_HITMAN_UNLOCKED ]);
			cache_get_value_name_int(0, "player_robbery_cooldown", Character [ playerid ] [ E_CHARACTER_ROBBERY_COOLDOWN ]);

			cache_get_value_name_int(0, "player_fightstyle", Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ]);
			cache_get_value_name_int(0, "player_fightstyle_tick", Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE_TICK ]);

			cache_get_value_name_int(0, "player_spraytag_wipe_cd", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_WIPE_CD ]);
			cache_get_value_name_int(0, "player_spraytag_dynamic", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC]);
			cache_get_value_name(0, "player_spraytag_dyn_text", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_TEXT]);
			cache_get_value_name_int(0,"player_spraytag_dyn_fcolor", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_FCOLOR]);
			cache_get_value_name_int(0,"player_spraytag_dyn_cd", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYN_CD]);
			cache_get_value_name_int(0,"player_spraytag_static_cd", Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC_CD]);
			
			cache_get_value_name_int(0,"player_driver_warnings", Character [ playerid ] [ E_CHARACTER_DRIVER_WARNINGS]);
			cache_get_value_name_int(0,"player_chopshop_cd", Character [ playerid ] [ E_CHARACTER_CHOPSHOP_CD]);
			cache_get_value_name_int(0,"player_lockpicks", Character [ playerid ] [ E_CHARACTER_LOCKPICK]);
			cache_get_value_name_int(0,"player_keep_duty", Character [ playerid ] [ E_CHARACTER_CRASHED_DUTY]);


			cache_get_value_name_int(0,"player_gym_setup", Character [ playerid ] [ E_CHARACTER_GYM_SETUP ]);
			cache_get_value_name_int(0,"player_gym_energy", Character [ playerid ] [ E_CHARACTER_GYM_ENERGY ]);
			cache_get_value_name_int(0,"player_gym_energy_internal", Character [ playerid ] [ E_CHARACTER_GYM_ENERGY_INTERNAL ]);

			cache_get_value_name_int(0,"player_gym_weight", Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT ]);
			cache_get_value_name_int(0,"player_gym_weight_xp", Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_XP ]);
			cache_get_value_name_int(0,"player_gym_weight_internal", Character [ playerid ] [ E_CHARACTER_GYM_WEIGHT_INTERNAL ]);

			cache_get_value_name_int(0,"player_gym_muscle", Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE ]);
			cache_get_value_name_int(0,"player_gym_muscle_xp", Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_XP ]);
			cache_get_value_name_int(0,"player_gym_muscle_internal", Character [ playerid ] [ E_CHARACTER_GYM_MUSCLE_INTERNAL ]);

			cache_get_value_name_int(0,"player_gym_hunger", Character [ playerid ] [ E_CHARACTER_GYM_HUNGER ]);
			cache_get_value_name_int(0,"player_gym_hunger_internal", Character [ playerid ] [ E_CHARACTER_GYM_HUNGER_INTERNAL ]);

			cache_get_value_name_int(0,"player_gym_thirst", Character [ playerid ] [ E_CHARACTER_GYM_THIRST ]);
			cache_get_value_name_int(0,"player_gym_thirst_internal", Character [ playerid ] [ E_CHARACTER_GYM_THIRST_INTERNAL ]);
			
			cache_get_value_name_int(0,"player_pager_freq", Character [ playerid ] [ E_CHARACTER_PAGER_FREQ ]);
			cache_get_value_name(0, "player_pager_nick", Character [ playerid ] [ E_CHARACTER_PAGER_NICK ]);

			cache_get_value_name_int(0,"player_strawman", Character [ playerid ] [ E_CHARACTER_STRAWMAN ]);

			cache_get_value_name_int(0,"player_vehdup", Character [ playerid ] [ E_CHARACTER_VEH_DUP ]);
			cache_get_value_name_int(0,"player_propdup", Character [ playerid ] [ E_CHARACTER_PROP_DUP ]);


			cache_get_value_name_int(0,"player_attribute_sex", Character [ playerid ][ E_CHARACTER_ATTRIB_SEX ]);
			cache_get_value_name_int(0,"player_attribute_age", Character [ playerid ][ E_CHARACTER_ATTRIB_AGE ]);
			cache_get_value_name_int(0,"player_attribute_race", Character [ playerid ][ E_CHARACTER_ATTRIB_RACE ]);
			cache_get_value_name_int(0,"player_attribute_eyes", Character [ playerid ][ E_CHARACTER_ATTRIB_EYES ]);
			cache_get_value_name_int(0,"player_attribute_hair", Character [ playerid ][ E_CHARACTER_ATTRIB_HAIR ]);
			cache_get_value_name_int(0,"player_attribute_body", Character [ playerid ][ E_CHARACTER_ATTRIB_BODY ]);
			cache_get_value_name_int(0,"player_attribute_height", Character [ playerid ][ E_CHARACTER_ATTRIB_HEIGHT ]);
			cache_get_value_name(0, "player_attribute_desc", Character [ playerid ] [ E_CHARACTER_ATTRIB_DESC ]);

			SetPlayerName(playerid, Account [playerid] [ E_PLAYER_ACCOUNT_NAME ] );
			SetPlayerScore(playerid, Character [ playerid ] [ E_CHARACTER_LEVEL ] ) ;
			
			if ( Character [ playerid ] [ E_CHARACTER_HOURS] >= 6 ) {

				if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ] ) {

					mysql_format(mysql, query, sizeof ( query ), "UPDATE accounts SET account_gunaccess = 1 WHERE account_id = %d", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
					mysql_tquery(mysql, query ) ;

					Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNACCESS ] = true ;
				}
			}

			/*
			SendClientMessage(playerid, -1, sprintf("Logged in as (%d) %s.", 
				Character [ playerid ] [ E_CHARACTER_ID ], Character [ playerid ] [ E_CHARACTER_NAME ]
			)) ;
			*/

			PlayerVar [ playerid ] [ E_PLAYER_CHOSE_CHARACTER ] = true ;

			mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_logindate = %d, player_ip = '%e' WHERE player_id = %d",
				gettime(), ReturnIP(playerid), Character [ playerid ] [ E_CHARACTER_ID ] ) ;
			mysql_tquery(mysql, query, "", "");

			/*
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior ( playerid, 3 ) ;
			SetPlayerCameraPos(playerid, 1525.4880, -7.4773, 1002.6321);
			SetPlayerCameraLookAt(playerid, 1526.3781, -7.9292, 1002.4353);
			*/


			// SetPlayerTime(playerid, Server [ E_SERVER_TIME_HOURS], 00);
			

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT ) ;
			SetPlayerHealth(playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;
			//SetPlayerArmour ( playerid, Character [ playerid ] [ E_CHARACTER_ARMOUR ] ) ;

			SetPlayerFightingStyle(playerid, Character [ playerid ] [ E_CHARACTER_FIGHTSTYLE ]);
 
			Player_SendLoginMessage ( playerid ); 
			//PlayerSkin_PurgeCheck(playerid); // Skin wipes shouldn't be necessary with the only load on login script.

			// Temp Holiday
			//EasterEgg_LoadPlayerEntities(playerid) ; // Holiday Event: Easter
			//Halloween_LoadPlayerEntities(playerid); // Holiday Event: Halloween
			//Christmas_LoadPlayerEntities(playerid); // Holiday Event: Christmas

			// Drugs loading
			Drugs_LoadEntity_Containers(playerid) ;
			Drugs_LoadEntities_PlayerDrugs(playerid) ;
			Drugs_LoadEntity_Supplies ( playerid ) ;

			Phone_ViewPhonebook_SQL(playerid, .view=false); // load phonebook

			PlayerVar [ playerid ] [ E_PLAYER_PLACING_DRUG_PLANT ] = -1 ;
			PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = -1 ;

			// Clearing phone variables.
			PlayerVar [ playerid ] [ player_phonecalling ] = INVALID_PLAYER_ID ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_STATUS ] = true ; // phone on by default
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ACCEPT_CALL ] = false ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_DECLINE_CALL ] = false ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_ALERT_TICKS ] = 0 ;
			PlayerVar [ playerid ] [ E_PLAYER_PHONE_RINGTONE_TICK ] = 0 ;
			PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);

			SetPlayerCash(playerid, Character [ playerid ] [ E_CHARACTER_CASH ]) ;
			Contributor_ApplyRights(playerid) ;

			Weapon_SetSkillLevel(playerid, 999);

			if ( ! Character [ playerid ] [ E_CHARACTER_REGISTERED ] ) 
			{
				SOLS_ShowCharCreation(playerid, Character [ playerid ] [ E_CHARACTER_ID ]);
				// Player_ShowSkinMenu(playerid) ;
			}

			else if ( Character [ playerid ] [ E_CHARACTER_REGISTERED ] ) {

//				SendClientMessage(playerid, COLOR_YELLOW, "If the spawn dialog doesn't show up, use /spawn to trigger it again.");
				Player_DisplaySpawnList(playerid);
			}

			CallLocalFunction("SOLS_OnLoadCharacter", "dd", playerid, character_id);
		}
	}

	MySQL_TQueryInline(mysql, using inline E_FETCH_PLAYER_CHARACTER, "SELECT * FROM characters WHERE player_id = %d", character_id);

	return true ;
}

forward SOLS_OnCharacterSpawn(playerid, isrespawn);
public SOLS_OnCharacterSpawn(playerid, isrespawn)
{
	// printf("Processing SOLS_OnCharacterSpawn for (%d) %s: isrespawn = %d", playerid, SOLS_PlayerName(playerid), isrespawn);
	// Note that a respawn is only if they die or toggle spectate, etc.  It does NOT include /respawnplayer (which is a teleport only)

	if (!isrespawn)
	{
		// Hades' PMs thing
		if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] == 7 ) 
		{
			PlayerVar [ playerid ] [ E_PLAYER_PM_BLOCKED ]  = true ;
			SendClientMessage(playerid, COLOR_YELLOW, "Your PMs have been automatically blocked to avoid player nuisance." ) ;
		}

		// Email collection (but not for newly registered accounts as we do this after they close the info box)
		if (!PlayerVar [ playerid ] [ E_PLAYER_FRESH_SPAWN ])
		{
			if (!strcmp ( Account [ playerid ] [ E_PLAYER_ACCOUNT_EMAIL ], "Undefined", true) ) 
			{
				GetPlayerEmail(playerid);
			}
		}

		// Rewards (last was back in December, disabling this for now)
		if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ]) 
		{
			// SendClientMessage(playerid, 0xA3A3A3FF, sprintf("You have a reward pending. Type {38b088}\"/claimprize\"{A3A3A3} to collect it."));
		}

		// Faction related spawn stuff (moved from weapon loading code)
		if (Character [ playerid ] [ E_CHARACTER_FACTIONID ])
		{
			CheckFactionSpawnStuff(playerid);	
		}
	}

	// Temp for testing
	//HandleTestingProps(playerid);

	// Armor is re-set either on first or respawn, but only after CheckFactionSpawnStuff(playerid);	above.
	SetPlayerArmour (playerid, Character [ playerid ] [ E_CHARACTER_ARMOUR ] ) ;
	if (Character [ playerid ] [ E_CHARACTER_HEALTH ] > 0) SetPlayerHealth (playerid, Character [ playerid ] [ E_CHARACTER_HEALTH ] ) ;
	// SendClientMessage(playerid, -1, "TEST: Your health and armor were set to their saved values.");

	// TODO: MOVE THIS TO A HOOK PLEASE
	#if defined CUSTOM_SKINS_DEVBUILD
	Customization_OnPlayerSpawn ( playerid ) ;
	#endif

	// ------------------------------------------
	return 1;
}

static CheckFactionSpawnStuff(playerid)
{
	new suspension = GetPlayerFactionSuspension(playerid);
	if (suspension)
	{
		PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ] = false;
    	SendClientMessage(playerid, COLOR_BLUE, sprintf("You are currently suspended from your faction for another %d hour(s).", suspension / 3600));
	}
    else if ( Character [ playerid ] [ E_CHARACTER_CRASHED_DUTY] >= gettime() && IsPlayerInDutyFaction(playerid)) 
	{
    	PlayerVar [ playerid ] [ E_PLAYER_FACTION_DUTY ] = true;
    	SendClientMessage(playerid, COLOR_BLUE, "Your faction duty state has been restored (logged in before 2 hours passed).");
    }		
}

