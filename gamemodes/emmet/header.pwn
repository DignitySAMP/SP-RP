
#include "emmet/data.pwn"
#include "emmet/func.pwn"
#include "emmet/admin.pwn"
#include "emmet/player.pwn"
#include "emmet/crates.pwn"

CMD:buygun(playerid, params[]) {

    if(!CanPlayerUseGuns(playerid, 8, -1)) {

        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You need at least 8 hours to buy a gun!");
    }

    new emmet_index = Emmet_GetClosestEntity(playerid);
    if(emmet_index == INVALID_EMMET_ID) {
        return SendServerMessage(playerid, COLOR_ERROR, "Gun Dealer", "DEDEDE", "You're not near a gun dealer!");
    }

	new string [ 2048 ], title[64];

    // factionid, faction_enum_id, faction_tier
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	if ( ! factionid ) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	new faction_enum_id = Faction_GetEnumID(factionid ); 
	if ( faction_enum_id == INVALID_FACTION_ID ) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
    new faction_tier = Character [ playerid ] [ E_CHARACTER_FACTIONTIER ];

    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_FACTION_INDEX] != Emmet[emmet_index][E_EMMET_SQLID]) {
        return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "The gun dealer doesn't sell weapons to your faction!");
    }

    if(Emmet[emmet_index][E_EMMET_OWNEDBY] == Character [ playerid ] [ E_CHARACTER_FACTIONID ]) {
        SendClientMessage(playerid, COLOR_YELLOW, "Your faction owns this gun dealer. You will get a cut from all profits next paycheck.");
    }

    Emmet_TriggerAnims(emmet_index); // random dealer anim on buy
	SendClientMessage(playerid, COLOR_RED, "Warning: stacking ammo is NOT possible! If you attempt it, you will NOT be refunded!");

    new weapon_cost, weapon_timestamp[96];
    strcat(string, "{DEDEDE}Weapon Name\t{DEDEDE}Stock Left\t{DEDEDE}Time Until Refill\t{DEDEDE}Cost\n");

    // Add melee weapons

    if(faction_tier <= 3) {
        // Colt 45
        weapon_cost = CalculateEmmetBaseCost(WEAPON_COLT45) + (EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] * CalculateEmmetTax(WEAPON_COLT45));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_UNIX] == -1) format(weapon_timestamp, 12, "None");
        else format(weapon_timestamp, sizeof(weapon_timestamp), "%s", GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_UNIX]));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] == 0) format(string, sizeof(string), "%sColt 45\t{ffe100}Depleted\t{ead958}%s\t$%s\n", string, weapon_timestamp, IntegerWithDelimiter(weapon_cost));
        else if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] == -1) format(string, sizeof(string), "%sColt 45\t{ff0000}Disabled by server\n", string);
        else format(string, sizeof(string), "%sColt 45\t%i\t%s\t$%s\n", string, EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK], weapon_timestamp, IntegerWithDelimiter(weapon_cost));
    }
    
    if(faction_tier <= 2) {
        // Uzi
        weapon_cost = CalculateEmmetBaseCost(WEAPON_UZI) + (EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] * CalculateEmmetTax(WEAPON_UZI));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_UNIX] == -1) format(weapon_timestamp, 12, "None");
        else format(weapon_timestamp, sizeof(weapon_timestamp), "%s", GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_UNIX]));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] == 0) format(string, sizeof(string), "%sUzi\t{ffe100}Depleted\t{ead958}%s\t$%s\n", string, weapon_timestamp, IntegerWithDelimiter(weapon_cost));
        else if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] == -1) format(string, sizeof(string), "%sUzi\t{ff0000}Disabled by server\n", string);
        else format(string, sizeof(string), "%sUzi\t%i\t%s\t$%s\n", string, EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK], weapon_timestamp, IntegerWithDelimiter(weapon_cost));

        // Tec 9
        weapon_cost = CalculateEmmetBaseCost(WEAPON_TEC9) + (EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] * CalculateEmmetTax(WEAPON_TEC9));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_UNIX] == -1) format(weapon_timestamp, 12, "None");
        else format(weapon_timestamp, sizeof(weapon_timestamp), "%s", GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_UNIX]));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] == 0) format(string, sizeof(string), "%sTec 9\t{ffe100}Depleted\t{ead958}%s\t$%s\n", string, weapon_timestamp, IntegerWithDelimiter(weapon_cost));
        else if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] == -1) format(string, sizeof(string), "%sTec 9\t{ff0000}Disabled by server\n", string);
        else format(string, sizeof(string), "%sTec 9\t%i\t%s\t$%s\n", string, EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK], weapon_timestamp, IntegerWithDelimiter(weapon_cost));
    }

    if(faction_tier <= 1) {
        // ak-47
        weapon_cost = CalculateEmmetBaseCost(WEAPON_AK47) + (EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] * CalculateEmmetTax(WEAPON_AK47));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] == -1) format(weapon_timestamp, 12, "None");
        else format(weapon_timestamp, sizeof(weapon_timestamp), "%s", GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_UNIX]));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] == 0) format(string, sizeof(string), "%sAK-47\t{ffe100}Depleted\t{ead958}%s\t$%s\n", string, weapon_timestamp, IntegerWithDelimiter(weapon_cost));
        else if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] == -1) format(string, sizeof(string), "%sAK-47\t{ff0000}Disabled by server\n", string);
        else format(string, sizeof(string), "%sAK-47\t%i\t%s\t$%s\n", string, EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK], weapon_timestamp, IntegerWithDelimiter(weapon_cost));

        // shotgun
        weapon_cost = CalculateEmmetBaseCost(WEAPON_SHOTGUN) + (EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] * CalculateEmmetTax(WEAPON_SHOTGUN));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_UNIX] == -1) format(weapon_timestamp, 12, "None");
        else format(weapon_timestamp, sizeof(weapon_timestamp), "%s", GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_UNIX]));
        if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] == 0) format(string, sizeof(string), "%sShotgun\t{ffe100}Depleted\t{ead958}%s\t$%s\n", string, weapon_timestamp, IntegerWithDelimiter(weapon_cost));
        else if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] == -1) format(string, sizeof(string), "%sShotgun\t{ff0000}Disabled by server\n", string);
        else format(string, sizeof(string), "%sShotgun\t%i\t%s\t$%s\n", string, EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK], weapon_timestamp, IntegerWithDelimiter(weapon_cost));
    }
    
	format ( title, sizeof ( title ), "%s's Wares", Emmet[emmet_index][E_EMMET_NAME]) ;
    inline Emmet_GunBuyHandler(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext, listitem, response

		if(response) {
            switch(listitem) {

                case 0: { // colt

                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] == 0) { // depleted
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer has no more Colt stock left!");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("Come back in %s.", GetCountdown(gettime(), 
                        EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_UNIX])));
                        return true;
                    }
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_COLT45_STOCK] == -1) {
                        return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer is forbidden from selling Colts ((Admin Override))!");
                    }

                    if(!Emmet_CheckCooldowns(playerid, WEAPON_COLT45)) {

                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "You are capped from buying more Colts.");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You can buy more in %s.",  GetCountdown(gettime(), EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_CD])));
                        return true;
                    }

                    weapon_cost = CalculateEmmetBaseCost(WEAPON_COLT45) + (EmmetPlayer[playerid][E_EMMET_PLAYER_COLT_TAX] * CalculateEmmetTax(WEAPON_COLT45));
                    if(GetPlayerCash(playerid) < weapon_cost) return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You don't have enough money. You need at least $%s.",  IntegerWithDelimiter(weapon_cost)));
                    
                    Emmet_DeclarePlayerCooldowns(playerid, WEAPON_COLT45);
                    Emmet_DeclareCooldowns(WEAPON_COLT45, faction_enum_id, emmet_index);
                    TakePlayerCash(playerid, weapon_cost) ;

                    SendClientMessage(playerid, -1, sprintf("You've purchased a Colt with 40 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));
                    AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Bought a Colt with 40 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));

                    GiveCustomWeapon(playerid, CUSTOM_COLT, 40) ;
                    SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(CUSTOM_COLT), 40);
                } 
                case 1:  { // uzi
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] == 0) { // depleted
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer has no more Uzi stock left!");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("Come back in %s.", 
                        GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_UNIX])));
                        return true;
                    }
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_UZI_STOCK] == -1) {
                        return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer is forbidden from selling Uzis ((Admin Override))!");
                    }

                    if(!Emmet_CheckCooldowns(playerid, WEAPON_UZI)) {

                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "You are capped from buying more Uzis.");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You can buy more in %s.",  GetCountdown(gettime(), EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_CD])));
                        return true;
                    }

                    weapon_cost = CalculateEmmetBaseCost(WEAPON_UZI) + (EmmetPlayer[playerid][E_EMMET_PLAYER_UZI_TAX] * CalculateEmmetTax(WEAPON_UZI));
                    if(GetPlayerCash(playerid) < weapon_cost) return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You don't have enough money. You need at least $%s.",  IntegerWithDelimiter(weapon_cost)));
                    
                    Emmet_DeclarePlayerCooldowns(playerid, WEAPON_UZI);
                    Emmet_DeclareCooldowns(WEAPON_UZI, faction_enum_id, emmet_index);
                    TakePlayerCash(playerid, weapon_cost) ;

                    SendClientMessage(playerid, -1, sprintf("You've purchased a Uzi with 200 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));
                    AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Bought an Uzi with 200 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));

                    GiveCustomWeapon(playerid, CUSTOM_UZI, 200) ;
                    SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(CUSTOM_UZI), 200);
                }
                case 2: { // tec
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] == 0) { // depleted
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer has no more Tec-9 stock left!");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("Come back in %s.", 
                        GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_UNIX])));
                        return true;
                    }
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_TEC_STOCK] == -1) {
                        return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer is forbidden from selling Tec-9s ((Admin Override))!");
                    }

                    if(!Emmet_CheckCooldowns(playerid, WEAPON_TEC9)) {

                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "You are capped from buying more Tec 9s.");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You can buy more in %s.",  GetCountdown(gettime(), EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_CD])));
                        return true;
                    }

                    weapon_cost = CalculateEmmetBaseCost(WEAPON_TEC9) + (EmmetPlayer[playerid][E_EMMET_PLAYER_TEC_TAX] * CalculateEmmetTax(WEAPON_TEC9));
                    if(GetPlayerCash(playerid) < weapon_cost) return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You don't have enough money. You need at least $%s.",  IntegerWithDelimiter(weapon_cost)));
                    
                    Emmet_DeclarePlayerCooldowns(playerid, WEAPON_TEC9);
                    Emmet_DeclareCooldowns(WEAPON_TEC9, faction_enum_id, emmet_index);
                    TakePlayerCash(playerid, weapon_cost) ;

                    SendClientMessage(playerid, -1, sprintf("You've purchased a Tec-9 with 200 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));
                    AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Bought a Tec-9 with 200 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));

                    GiveCustomWeapon(playerid, CUSTOM_TEC, 200) ;
                    SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(CUSTOM_TEC), 200);
                }
                case 3:  { // ak                    
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] == 0) { // depleted
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer has no more AK-47 stock left!");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("Come back in %s.", 
                        GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_UNIX])));
                        return true;
                    }
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_AK47_STOCK] == -1) {
                        return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer is forbidden from selling AK-47s ((Admin Override))!");
                    }

                    if(!Emmet_CheckCooldowns(playerid, WEAPON_AK47)) {

                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "You are capped from buying more AK-47s.");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You can buy more in %s.",  GetCountdown(gettime(), EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_CD])));
                
                        return true;
                    }

                    weapon_cost = CalculateEmmetBaseCost(WEAPON_AK47) + (EmmetPlayer[playerid][E_EMMET_PLAYER_AK47_TAX] * CalculateEmmetTax(WEAPON_AK47));
                    if(GetPlayerCash(playerid) < weapon_cost) return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You don't have enough money. You need at least $%s.",  IntegerWithDelimiter(weapon_cost)));
                    
                    Emmet_DeclarePlayerCooldowns(playerid, WEAPON_AK47);
                    Emmet_DeclareCooldowns(WEAPON_AK47, faction_enum_id, emmet_index);
                    TakePlayerCash(playerid, weapon_cost) ;

                    SendClientMessage(playerid, -1, sprintf("You've purchased an AK-47 with 120 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));
                    AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Bought an AK-47 with 120 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));

                    GiveCustomWeapon(playerid, CUSTOM_AK47, 120) ;
                    SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(CUSTOM_AK47), 120);
                }
                case 4: { // shotgun                    
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] == 0) { // depleted
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer has no more Shotgun stock left!");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("Come back in %s.", 
                        GetCountdown(gettime(), EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_UNIX])));
                        return true;
                    }
                    if(EmmetFaction[faction_enum_id][emmet_index][E_EMMET_SHOTGUN_STOCK] == -1) {
                        return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "This dealer is forbidden from selling Shotguns ((Admin Override))!");
                    }
                    if(!Emmet_CheckCooldowns(playerid, WEAPON_SHOTGUN)) {
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", "You are capped from buying more shotguns.");
                        SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You can buy more in %s.",  GetCountdown(gettime(), EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_CD])));
                
                        return true;
                    }

                    weapon_cost = CalculateEmmetBaseCost(WEAPON_SHOTGUN) + (EmmetPlayer[playerid][E_EMMET_PLAYER_SHOTGUN_TAX] * CalculateEmmetTax(WEAPON_SHOTGUN));
                    if(GetPlayerCash(playerid) < weapon_cost) return SendServerMessage(playerid, COLOR_EMMET, "Gun Dealer", "DEDEDE", sprintf("You don't have enough money. You need at least $%s.",  IntegerWithDelimiter(weapon_cost)));
 
                    Emmet_DeclarePlayerCooldowns(playerid, WEAPON_SHOTGUN);
                    Emmet_DeclareCooldowns(WEAPON_SHOTGUN, faction_enum_id, emmet_index);
                    TakePlayerCash(playerid, weapon_cost) ;

                    SendClientMessage(playerid, -1, sprintf("You've purchased a shotgun with 30 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));
                    AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Bought a shotgun with 30 ammo from Emmet costing $%s.", IntegerWithDelimiter(weapon_cost)));

                    GiveCustomWeapon(playerid, CUSTOM_SHOTGUN, 30) ;
                    SOLS_SetPlayerAmmo(playerid, GetCustomWeaponGunId(CUSTOM_SHOTGUN), 30);
                }
            }

            return true;
		}
	}
 	Dialog_ShowCallback ( playerid, using inline Emmet_GunBuyHandler, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Purchase", "Close" );


    return true;
}