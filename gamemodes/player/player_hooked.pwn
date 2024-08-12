// A more "optimized" OnPlayerUpdate. Useful when constant 
// checks are required such as gang tag script or boombox sync.

static plrIP[16];
static plrIPMsg[128];

static CheckInvalidIP(playerid)
{
	GetPlayerIp(playerid, plrIP, sizeof(plrIP));

	if (!strcmp(plrIP, "255.255.255.255"))
	{
		format(plrIPMsg, sizeof(plrIPMsg), "[AdmWarn] (%d) %s was kicked for having an invalid IP.", playerid, ReturnMixedName(playerid));
		Kick(playerid);
		SendAdminMessage(plrIPMsg);
		print(plrIPMsg);
	}
}

ptask PLAYER_CONSTANT_TICK[1000](playerid){

	if ( playerid > MAX_PLAYERS ) {

		return true ;
	}

	if ( ++ PlayerVar [ playerid ] [ E_PLAYER_OTHER_STUFF_TICK ] >= 5 ) 
	{
		PlayerVar [ playerid ] [ E_PLAYER_OTHER_STUFF_TICK ] = 0 ;
		CheckInvalidIP(playerid); // Temp anti invalid IP measure here
	}

	if ( PlayerVar [ playerid ] [ player_islogged ] ) {
		
		// Report Reminders
		Report_PlayerTick(playerid);
		Question_PlayerTick(playerid);

		// Trying Clothes
		TryingSkin_Tick(playerid);

		// Anticheat tick
		Anticheat_Tick ( playerid );

		// Re-apply injury animation!
		if (  PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] ) {
			if ( GetPlayerAnimationIndex ( playerid ) != 1701 ) {

				ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
			}
		}

		// reset crate pos on death
		if ( PlayerVar [ playerid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] != -1 ) {
			RemovePlayerAttachedObject(playerid, 0);
			SetPlayerSpecialAction(playerid, 0);
			PlayerVar [ playerid ] [ E_PLAYER_TRUCKER_CARRY_BOX ] = -1 ; 
			ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
		}

		Tazer_ResetTick(playerid );
		Beanbag_ResetTick(playerid) ;
		SpectateTick(playerid, PlayerVar [ playerid ] [ E_PLAYER_IS_SPECTATING ] ) ;

		if ( IsPlayerSpawned ( playerid ) ) {

			//Gym_CheckForSync(playerid) ;
			Gym_StatsUpdate(playerid);
			OnPlayerRefuelCar(playerid);

			if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_GUNBAN ] && GetPlayerWeapon ( playerid ) != 0 ) {
				if ( AC_GetPlayerWeapon(playerid) || GetPlayerCustomWeapon(playerid) != -1 ) {

					SendAdminMessage(sprintf("[GUN BAN VIOLATION] (%d) %s has a gun ban and is holding weapons! (client %d server %d)", playerid, ReturnMixedName ( playerid ), AC_GetPlayerWeapon(playerid), GetPlayerCustomWeapon(playerid) )) ;
					RemovePlayerCustomWeapon(playerid, GetPlayerCustomWeapon(playerid) ) ;
					AC_RemovePlayerWeapon(playerid, AC_GetPlayerWeapon(playerid) ) ;
				}
			}

			Pool_OnPlayerUpdate(playerid);

			if ( IsPlayerPaused ( playerid ) ) {

				if ( ! PlayerVar [ playerid ] [ E_PLAYER_PAUSE_TAG_UPDATE ] ) {

					PlayerVar [ playerid ] [ E_PLAYER_PAUSE_TAG_UPDATE ] = true ;
       				//UpdateTabListForOthers ( playerid ) ;
				}
			}

			else if ( ! IsPlayerPaused ( playerid ) ) {

				if ( PlayerVar [ playerid ] [ E_PLAYER_PAUSE_TAG_UPDATE ] ) {

					PlayerVar [ playerid ] [ E_PLAYER_PAUSE_TAG_UPDATE ] = false ;
        			//UpdateTabListForOthers ( playerid ) ;
				}
			}


			if ( PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_USED ]  ) {
				if ( -- PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_TICKS ] <= 0 ) {

					PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_TICKS ] = 0 ;
					PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_USED ] = false ;

					SendClientMessage(playerid, 0xDEDEDEFF, "Your backup/panic button activation has expired.");
				}
				else
				{
					if (!PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_PROPERTY ])
					{
						// Only update if they're not in a property
						GetPlayerPos(playerid, PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 0 ], PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 1 ], PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 2 ] ) ;
					}
				}
			}

			if (PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_ACCEPTED ] )
			{
				new targetid = PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_TARGET ];
				if (IsPlayerConnected(targetid) && !PlayerVar [ targetid ] [ E_PLAYER_INJUREDMODE ] && PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_USED ])
				{
					if (PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_TICKS ] % 2 == 0)
					{
						//DisablePlayerCheckpoint(playerid);
						RemovePlayerMapIcon(playerid, 0);
						SetPlayerMapIcon(playerid, 0, PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 0 ], PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 1 ], PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_POS ] [ 2 ], 0, PlayerVar [ targetid ] [ E_PLAYER_PANIC_BUTTON_COLOR ], MAPICON_GLOBAL );
					}
				}
				else
				{
					PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_TARGET ] = INVALID_PLAYER_ID ;
					PlayerVar [ playerid ] [ E_PLAYER_PANIC_BUTTON_ACCEPTED ] = false ;
				}
			}


			Robbery_OnPlayerCooldown(playerid) ;
			ChopShop_CheckVehicleRange(playerid) ;
			Garbage_CheckVehicleRange(playerid) ;

			if ( ! IsPlayerInMinigame(playerid) && !PlayerVar[playerid][E_PLAYER_USING_HOSE] ) {

				if ( IsPlayerAttachedObjectSlotUsed ( playerid, E_ATTACH_INDEX_MINIGAME ) ) {

					RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MINIGAME ) ;
				}
			}

			//Spike_Tick(playerid) ;
			Anticheat_NewPlayerGunCheck(playerid);

			if ( PlayerVar [ playerid ] [ E_PLAYER_WARP_AC_2 ] > 1 ) {
				PlayerVar [ playerid ] [ E_PLAYER_WARP_AC_2 ] -- ;
				if ( PlayerVar [ playerid ] [ E_PLAYER_WARP_AC_2 ] < 0 ) {
					PlayerVar [ playerid ] [ E_PLAYER_WARP_AC_2 ] = 0 ;
				}
			}


			// Spraytag shit
			if ( ! PlayerVar [ playerid ] [ E_PLAYER_EDITING_TAG ] ) {
				switch ( PlayerVar [ playerid ] [ E_PLAYER_TAGS_STATE ] ) {

					case 1: SprayTag_SprayingStaticTag(playerid);
					case 2: SprayTag_SprayingDynamicTag(playerid);
				}
			}

			GUI_UpdateDirectionLabels(playerid);

			if ( ! Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ] ) {
				Arrest_Tick(playerid);
			}

			else if (  Character [ playerid ] [ E_CHARACTER_AJAIL_TIME ] ) {

				AdminJail_Tick(playerid) ;
			}

			PlayerDrug_EffectTick ( playerid ) ;

			if ( ++ PlayerVar [ playerid ] [ E_PLAYER_WEAPON_SAVE_TICK ] > 180 ) 
			{
				// Autosaves weapons every 3 mins
				PlayerVar [ playerid ] [ E_PLAYER_WEAPON_SAVE_TICK ] = 0 ;
				Weapon_SavePlayerWeapons(playerid) ;
			}

			Emmet_PlayerCooldownTick(playerid); // emmet cooldown handler
			Weapon_AnticheatCheck ( playerid ) ;

			/*
			if ( GetPVarInt(playerid, "AprilFooled") && ! IsPlayerIncapacitated(playerid, false) )
			{
				if (random(30) == 0)
				{
					CallRemoteFunction("SOLS_OnPlayerAprilFool", "dd", playerid, GetPVarInt(playerid, "AprilFooled"));
				}
			}
			*/
		}

	}

	return true ;
}
/*
static ShowPlayerStatsToPlayer(playerid, showplayerid)
{
	new string [ 144 ], buffer [ 32 ] ;

	format ( string, sizeof ( string ), "|_____________| (%d) %s's statistics |_____________|", playerid, ReturnPlayerNameData ( playerid ) ) ;
	SendClientMessage(showplayerid, COLOR_SERVER, string ) ;

	format ( string, sizeof ( string ), "[Account ID: %d] [Character ID: %d] [Account Name: \"%s\"] [Character Name: \"%s\"]",

		Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Character [ playerid ] [ E_CHARACTER_ID ],
		Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], Character [ playerid ] [ E_CHARACTER_NAME ]
	) ;
	SendClientMessage(showplayerid, COLOR_GRAD0, string);


	new year, month, day, hour, minute, second ;
	stamp2datetime(Character [ playerid ] [ E_CHARACTER_REGISTERDATE ], year, month, day, hour, minute, second, 1 ) ;

	format ( string, sizeof ( string ), "%s the %d%s of %s, %d at %d:%d:%d",
	date_dayName(day, month, year), day, date_dayOrdinal (day), date_getMonth(month), year, hour, minute, second ) ;

	format ( string, sizeof ( string ), "[Register Date: %s]", string );

	if (playerid != showplayerid)
	{
		format ( string, sizeof ( string ), "%s [Last IP Used: %s]", string, Character [ playerid ] [ E_CHARACTER_IP ] );
	}

	SendClientMessage(showplayerid, COLOR_GRAD1, string );


	format ( string, sizeof ( string ), "[Playing Hours: %d] [Hand Cash: $%s] [Bank Cash: $%s] [Savings: $%s ($%s per paycheck)] [Outstanding Fines: $%s]",
		Character [ playerid ] [ E_CHARACTER_HOURS], IntegerWithDelimiter ( Character [ playerid ] [ E_CHARACTER_CASH ] ), 
		IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ]), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_SAVINGS ]),
		IntegerWithDelimiter( ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] / 700 ) / 2 ),
		IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_OUTSTANDING_FINES ] ) 
	) ;

	SendClientMessage(showplayerid, COLOR_GRAD0, string );

	string [ 0 ] = EOS ;

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if (  factionid ) {
		new faction_enum_id = Faction_GetEnumID(factionid ); 

		if ( faction_enum_id != INVALID_FACTION_ID ) {

		 	format ( string, sizeof ( string ), "%s", Faction [ faction_enum_id ] [ E_FACTION_NAME ]);

		}

		else format ( string, sizeof ( string ), "None");
	}

	else format ( string, sizeof ( string ), "None");

	format (string, sizeof ( string ), "[FID SQL: %d] [Faction: \"%s\"] [Faction Rank: \"%s\"] [Faction Tier: %d]",
		factionid, string, Character [ playerid ] [ E_CHARACTER_FACTIONRANK ],  Character [ playerid ] [ E_CHARACTER_FACTIONTIER ]
	);
	SendClientMessage(showplayerid, COLOR_GRAD1, string);

	string [ 0 ] = EOS ;

	switch (PlayerVar [ playerid ] [ player_hasboombox ] ) {

		case 1:	format ( string, sizeof ( string ), "Red" ) ;
		case 2:	format ( string, sizeof ( string ), "Grey" ) ;
		case 3:	format ( string, sizeof ( string ), "Black" ) ;
		default: format ( string, sizeof ( string ), "None" ) ;
	}


	format ( string, sizeof ( string ), "[Mask ID: %d] [Phone Number: %d] [Gas Can: %s] [Toolkit: %s] [Boombox: %s] [Lockpicks: %d]", 
		Character [ playerid ] [ E_CHARACTER_MASKID ], Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ],
		(PlayerVar [ playerid ] [ E_PLAYER_HAS_GASCAN ] ? ("Yes") : ("No")),
		(PlayerVar [ playerid ] [ E_PLAYER_HAS_TOOLKIT ] ? ("Yes") : ("No")),
		string,  Character [ playerid ] [ E_CHARACTER_LOCKPICK ]
	);
	SendClientMessage(showplayerid, COLOR_GRAD0, string );

	buffer[0]=EOS;
	SprayTag_GetNameByModel( Character [ playerid ] [ E_CHARACTER_SPRAYTAG_STATIC ], buffer, sizeof ( buffer ) ) ;

	string[0]=EOS;
	SprayTag_GetDynNameByModel(Character [ playerid ] [ E_CHARACTER_SPRAYTAG_DYNAMIC ], string, sizeof(string) ) ;

	format ( string, sizeof ( string), "[Static Spray-tag: %s] [Dynamic Spray-tag: %s] [Wood: %d] [Metal: %d] [Parts: %d]", 
		buffer, string,
		Character [ playerid ] [ E_CHARACTER_GD_WOOD ], Character [ playerid ] [ E_CHARACTER_GD_METAL ],
		Character [ playerid ] [ E_CHARACTER_GD_PARTS ] ) ;

	SendClientMessage(showplayerid, COLOR_GRAD1, string);

	format ( string, sizeof ( string ), "[Fear: %d] [Respect: %d] [Passable Points: %d]",
		Character [ playerid ] [ E_CHARACTER_FEAR ], Character [ playerid ] [ E_CHARACTER_RESPECT ], Character [ playerid ] [ E_CHARACTER_FnR_GIVABLE ]
	);

	SendClientMessage(showplayerid, COLOR_GRAD0, string);
}
*/

static ShowPlayerStatsToPlayer(playerid, showplayerid)
{
	new string [ 512 ] ;

	format ( string, sizeof ( string ), "{[ _______ (%d) %s's statistics  _______ ]}", playerid, ReturnMixedName ( playerid ) ) ;
	SendClientMessage(showplayerid, 0xE9691BFF, string ) ;

	format ( string, sizeof ( string ), "[ACCOUNT]:{DEDEDE} [Account ID: %d]{AAAAAA} [Character ID: %d]{DEDEDE} [Account: \"%s\"]{AAAAAA} [Character: \"%s\"]",

		Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ], Character [ playerid ] [ E_CHARACTER_ID ],
		Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ], Character [ playerid ] [ E_CHARACTER_NAME ]
	) ;
	SendClientMessage(showplayerid, 0xA37EBEFF, string);


	new year, month, day, hour, minute, second ;
	stamp2datetime(Character [ playerid ] [ E_CHARACTER_REGISTERDATE ], year, month, day, hour, minute, second, 1 ) ;


	format ( string, sizeof ( string ), "[SESSION]:{DEDEDE} [Registered: %02d/%02d/%04d at %02d:%02d:%02d]{AAAAAA} [Hours: %d]", 
		day, month, year, hour, minute, second, Character [ playerid ] [ E_CHARACTER_HOURS ] );

	if (playerid != showplayerid) {
		format ( string, sizeof ( string ), "%s {DEDEDE}[Last IP: %s]", string, Character [ playerid ] [ E_CHARACTER_IP ] );
	}

	else format ( string, sizeof ( string ), "%s {DEDEDE}[Last IP: {C6694C}Hidden{DEDEDE}]", string);

	SendClientMessage(showplayerid, 0x98D988FF, string );

	format ( string, sizeof ( string ), 
		"[FINANCIAL]:{DEDEDE} [Hand Cash: $%s]{AAAAAA} [Bank Cash: $%s]{DEDEDE} [Savings: $%s ($%s per paycheck)]",
		IntegerWithDelimiter ( Character [ playerid ] [ E_CHARACTER_CASH ] ), 
		IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ]), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_SAVINGS ]),
		IntegerWithDelimiter( ( Character [ playerid ] [ E_CHARACTER_SAVINGS ] / 700 ) / 2 )
	) ;

	SendClientMessage(showplayerid, 0xD39483FF, string );

	string [ 0 ] = EOS ;

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if (  factionid ) {
		new faction_enum_id = Faction_GetEnumID(factionid ); 

		if ( faction_enum_id != INVALID_FACTION_ID ) {

		 	format ( string, sizeof ( string ), "%s", Faction [ faction_enum_id ] [ E_FACTION_ABBREV ]);

		}

		else format ( string, sizeof ( string ), "None");
	}

	else format ( string, sizeof ( string ), "None");

	format (string, sizeof ( string ), "[FACTION]:{DEDEDE} [FID: %d]{AAAAAA} [Faction: \"%s\"]{DEDEDE} [Rank: \"%s\"]{AAAAAA} [Tier: %d]",
		factionid, string, Character [ playerid ] [ E_CHARACTER_FACTIONRANK ],  Character [ playerid ] [ E_CHARACTER_FACTIONTIER ]
	);
	SendClientMessage(showplayerid, 0x88D9D8FF, string);

	string [ 0 ] = EOS ;

	switch (PlayerVar [ playerid ] [ player_hasboombox ] ) {

		case 1:	format ( string, sizeof ( string ), "Red" ) ;
		case 2:	format ( string, sizeof ( string ), "Grey" ) ;
		case 3:	format ( string, sizeof ( string ), "Black" ) ;
		default: format ( string, sizeof ( string ), "None" ) ;
	}

	format ( string, sizeof ( string ), "[MISCELLANEOUS]:{DEDEDE} [Mask ID: %d]{AAAAAA} [Phone Number: %d]", 
		Character [ playerid ] [ E_CHARACTER_MASKID ], Character [ playerid ] [ E_CHARACTER_PHONE_NUMBER ]
	);

	if (playerid != showplayerid && GetPlayerAdminLevel(playerid) >= ADMIN_LVL_MANAGER) 
	{
		format ( string, sizeof ( string ), "%s {DEDEDE}[Email: %s]", string, Account [ playerid ] [ E_PLAYER_ACCOUNT_EMAIL ] );
	}

	SendClientMessage(showplayerid, 0xD9C388FF, string );
}


CMD:stats(playerid, params[]) 
{
	ShowPlayerStatsToPlayer(playerid, playerid);
	ZMsg_SendClientMessage(playerid, 0x297183FF, "Related commands:{DEDEDE} /mycars, /myproperties, /myguns, /mydrugs, /myslots, /myattributes");

	return true;
}

CMD:checkstats(playerid, params[]) {

	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_GENERAL)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/checkstats [player]");

	if (!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, -1, "Target isn't connected.");

	ShowPlayerStatsToPlayer(targetid, playerid);

	return true ;
}