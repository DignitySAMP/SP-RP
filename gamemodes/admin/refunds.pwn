static RefundDlgStr[2048];
static RefundQuery[512];

enum
{
    REFUND_TYPE_CASH,
    REFUND_TYPE_WEAPON,
    REFUND_TYPE_DRUG
}

PlayerClaimRefund(playerid, refund_id)
{
    mysql_format(mysql, RefundQuery, sizeof ( RefundQuery ), "SELECT `refund_id`, DATE(`refund_date`) AS `date`, `refund_type`, `refund_itemtype`, `refund_subtype`, `refund_infratype`, `refund_amount`, `refund_reason` FROM `refunds` WHERE `refund_id` = %d AND `refund_player_id` = %d AND `refund_claimed` = 0", refund_id, Character [ playerid ] [ E_CHARACTER_ID ]);
    mysql_tquery ( mysql, RefundQuery, "OnPlayerClaimRefund", "dd", playerid, refund_id ) ;
}

forward OnPlayerClaimRefund(playerid, refund_id);
public OnPlayerClaimRefund(playerid, refund_id)
{
	new refund_type, refund_itemtype, refund_subtype, refund_infratype, Float:refund_amount, refund_reason[128], refund_date[16];
    new refund_amount_int;

    for (new i = 0, r = cache_num_rows(); i < r; ++i)
    {
        cache_get_value_name(i, "date", refund_date);
        cache_get_value_name(i, "refund_reason", refund_reason);
        cache_get_value_name_float(i, "refund_amount", refund_amount);
        cache_get_value_name_int(i, "refund_id", refund_id);
        cache_get_value_name_int(i, "refund_type", refund_type); // gun, money, drug, etc.
        cache_get_value_name_int(i, "refund_itemtype", refund_itemtype); // weapon id, drug type (coke, etc.)
        cache_get_value_name_int(i, "refund_subtype", refund_subtype); // drug sub type (northern lights e.g.)
        cache_get_value_name_int(i, "refund_infratype", refund_infratype); // drug container

        refund_amount_int = floatround(refund_amount);

        if (refund_amount)
        {
            if (refund_type == REFUND_TYPE_CASH)
            {
                GivePlayerCash(playerid, refund_amount_int);
                SendServerMessage(playerid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("(%s) {A5D6A7}$%s {A3A3A3}Reason: %s.", refund_date, IntegerWithDelimiter(refund_amount_int), refund_reason));
                AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Claimed Refund ID %d ($%s)", refund_id, IntegerWithDelimiter(refund_amount_int)));
            }
            else if (refund_type == REFUND_TYPE_WEAPON)
            {
                new gun_name[32], gunid, ammo;
                new gunslot = GetCustomWeaponSlot(refund_itemtype);
                Weapon_GetGunName(refund_itemtype, gun_name, sizeof(gun_name));
                GetPlayerWeaponData(playerid, gunslot, gunid, ammo);

                if (PlayerVar[playerid][E_PLAYER_WEAPON_EQUIPPED][gunslot] && ammo)
                {
                    return SendServerMessage ( playerid, COLOR_DRUGS, "Error", "A3A3A3", "Failed to collect weapon - you already have one in this weapon slot." ) ;
                }

                GiveCustomWeapon(playerid, refund_itemtype, refund_amount_int); 
                SendServerMessage(playerid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("(%s) {A5D6A7}%s (%d Ammo) {A3A3A3}Reason: %s.", refund_date, gun_name, refund_amount_int, refund_reason));
                AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Claimed Refund ID %d (%s with %d ammo)", refund_id, gun_name, refund_amount_int));
            }
            else if (refund_type == REFUND_TYPE_DRUG)
            {
                new player_enum_id = PlayerDrugs_GetFreeID(playerid) ;

                if ( player_enum_id == INVALID_DRUG_ID ) 
                {
                    return SendServerMessage ( playerid, COLOR_DRUGS, "Error", "A3A3A3", "Failed to collect drugs - you have no free slots left." ) ;
                }

                PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ]  		= refund_itemtype;
                PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ]  		= refund_subtype;
                PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ]  	= refund_infratype;
                PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ]  		= refund_amount;
                PlayerDrugs_Save(playerid) ;

                new drug_name [ 32 ], drug_type [ 32 ], package_name [ 32 ] ;

                Drugs_GetParamName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_PARAM ], drug_name ) ;
                Drugs_GetPackageName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_CONTAINER ], package_name ) ;
                Drugs_GetTypeName ( PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_TYPE ], drug_type ) ;

                SendServerMessage(playerid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("(%s) {A5D6A7}%.02fg of %s (%s) {A3A3A3}Reason: %s.", refund_date, refund_amount, drug_name, drug_type, refund_reason));
                AddLogEntry(playerid, LOG_TYPE_DRUGS, sprintf("Claimed %s with %.02fgr of %s from Refund ID %d", package_name, PlayerDrugs [ playerid ] [ player_enum_id ] [ E_PLAYER_DRUG_AMOUNT ], drug_name, refund_id));
                AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Claimed Refund ID %d (%.02fg of %s)", refund_id, refund_amount, drug_name, true));
            }
            else
            {
                return SendServerMessage ( playerid, COLOR_DRUGS, "Error", "A3A3A3", "Invalid refund type." ) ;
            }

            mysql_format(mysql, RefundQuery, sizeof ( RefundQuery ), "UPDATE `refunds` SET `refund_claimed` = %d WHERE `refund_id` = %d", gettime(), refund_id);
            mysql_pquery(mysql, RefundQuery);
        }
    }
    return true;
}

Refund_CheckRefunds(playerid)
{
    mysql_format(mysql, RefundQuery, sizeof ( RefundQuery ), "SELECT COUNT(*) FROM `refunds` WHERE `refund_player_id` = %d AND `refund_claimed` = 0", Character [ playerid ] [ E_CHARACTER_ID ]);
    mysql_tquery ( mysql, RefundQuery, "Player_CheckRefunds", "d", playerid ) ;
}

forward Player_CheckRefunds(playerid);
public Player_CheckRefunds(playerid)
{
    new count;
    cache_get_value_index_int(0, 0, count);

    if (count == 1) SendServerMessage(playerid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("You have %d unclaimed refund: type {FFFFFF}/myrefunds{A3A3A3} to claim.", count));
    else if (count > 1) SendServerMessage(playerid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("You have %d unclaimed refunds: type {FFFFFF}/myrefunds{A3A3A3} to claim.", count));
    return true;
}

ShowPlayerRefunds(playerid, toplayerid)
{
	inline ReturnRefunds() 
	{
		new refund_str[64];
        new map[100], index;
		new Float:refund_amount, refund_id, refund_amount_int, refund_type, refund_subtype, refund_itemtype, refund_reason[128], refund_date[16], refund_claimed, claimed_date[16];

		if (!cache_num_rows()) 
		{
			return SendClientMessage(toplayerid, -1, "There are no refunds to show.");
		}

		format(RefundDlgStr, sizeof(RefundDlgStr), "Date\tRefund\tReason\tClaimed");

		for (new i = 0, r = cache_num_rows(); i < r; ++i)
		{
			cache_get_value_name(i, "date", refund_date);
            cache_get_value_name(i, "claimed_date", claimed_date);
			cache_get_value_name_int(i, "refund_claimed", refund_claimed);
			cache_get_value_name(i, "refund_reason", refund_reason);
            cache_get_value_name_int(i, "refund_type", refund_type);
            cache_get_value_name_int(i, "refund_subtype", refund_subtype);
            cache_get_value_name_int(i, "refund_itemtype", refund_itemtype);
			cache_get_value_name_float(i, "refund_amount", refund_amount);
            cache_get_value_name_int(i, "refund_id", refund_id);

            refund_amount_int = floatround(refund_amount);
            
            if (refund_type == REFUND_TYPE_CASH)
            {
                format(refund_str, sizeof(refund_str), "$%s", IntegerWithDelimiter(refund_amount_int));
            } 
            else if (refund_type == REFUND_TYPE_WEAPON)
            {
                new gun_name[32];
                Weapon_GetGunName(refund_itemtype, gun_name, sizeof(gun_name));	
                format(refund_str, sizeof(refund_str), "%s (%d Ammo)", gun_name, refund_amount_int);
            }
            else if (refund_type == REFUND_TYPE_DRUG)
            {
                new drug_name [ 32 ], drug_type [ 32 ];
                Drugs_GetParamName ( refund_itemtype, refund_subtype, drug_name ) ;
                Drugs_GetTypeName ( refund_itemtype, drug_type ) ;
                format(refund_str, sizeof(refund_str), "%s (%s) (%.02fg)", drug_name, drug_type, refund_amount);
            }
            else
            {
                // Invalid refund type
                format(refund_str, sizeof(refund_str), "Invalid Refund Type");
            }  

            if (refund_claimed)
            {
                format(RefundDlgStr, sizeof(RefundDlgStr), "%s\n%s\t%s\t%s\t%s", RefundDlgStr, refund_date, refund_str, refund_reason, claimed_date);
                map[index] = 0;
            }
            else
            {
                format(RefundDlgStr, sizeof(RefundDlgStr), "%s\n%s\t%s\t%s\t%s", RefundDlgStr, refund_date, refund_str, refund_reason, "No");
                map[index] = refund_id;
            }

            index ++;
		}
		
		inline MyRefundsDlg(pid, dialogid, response, listitem, string:inputtext[]) 
		{
			#pragma unused pid, dialogid, inputtext, listitem

			if ( response ) 
			{
                // Claim refund
                if (toplayerid == playerid)
                {
                    if (map[listitem])
                    {
                        PlayerClaimRefund(pid, map[listitem]);
                    }
                    else
                    {
                        SendServerMessage(pid, COLOR_ERROR, "Error", "A3A3A3", "You have already claimed this refund");
                    }
                }

				// nothing
			}
		}

		if (playerid == toplayerid) Dialog_ShowCallback ( toplayerid, using inline MyRefundsDlg, DIALOG_STYLE_TABLIST_HEADERS, "Your Refunds", RefundDlgStr, "Claim", "Back" );
		else Dialog_ShowCallback ( toplayerid, using inline MyRefundsDlg, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Refunds for (%d) %s", playerid, ReturnMixedName(playerid)), RefundDlgStr, "Claim", "Back" );
	}

	mysql_format ( mysql, RefundQuery, sizeof ( RefundQuery ), "SELECT `refund_id`, DATE(`refund_date`) AS `date`, `refund_type`, `refund_itemtype`, `refund_subtype`, `refund_amount`, `refund_reason`, `refund_claimed`, DATE(FROM_UNIXTIME(`refund_claimed`)) AS 'claimed_date' FROM `refunds` WHERE `refund_player_id` = %d ORDER BY `refund_date` DESC", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	MySQL_TQueryInline(mysql, using inline ReturnRefunds, RefundQuery, "");
    return true;
}

CMD:myrefunds(playerid)
{
	ShowPlayerRefunds(playerid, playerid);
	return true;
}

CMD:checkrefunds(playerid, params[])
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new targetid;

	if (sscanf(params, "k<player>", targetid))
		return SendClientMessage(playerid, -1, "/checkrefunds [player]");

	if (!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, -1, "Target isn't connected.");

	ShowPlayerRefunds(targetid, playerid);
	return true;
}

CMD:addrefund(playerid, params[])
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_ADVANCED)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new targetid, refund_type, item_type, item_subtype, item_infratype, Float:item_amount, item_amount_int, reason[128];

    if (sscanf(params, "k<player>d", targetid, refund_type))
    {
		SendClientMessage(playerid, -1, "/addrefund [player] [refund type]");
        SendClientMessage(playerid, -1, "Refund Types: 0 Money | 1 Weapon | 2 Drug");
        return true;
    }

    if (!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, -1, "Target isn't connected.");

    if (refund_type == 0 && sscanf(params, "k<player>dds[128]", targetid, refund_type, item_amount_int, reason))
    {
        SendClientMessage(playerid, -1, "/addrefund [player] [refund type] [money amount] [reason]");
        return true;
    }
    else if (refund_type == 1 && sscanf(params, "k<player>ddds[128]", targetid, refund_type, item_type, item_amount_int, reason))
    {
        SendClientMessage(playerid, -1, "/addrefund [player] [refund type] [custom gun id] [ammo] [reason]");
        return true;
    }
    else if (refund_type == 2 && sscanf(params, "k<player>ddddfs[128]", targetid, refund_type, item_type, item_subtype, item_infratype, item_amount, reason))
    {
        SendClientMessage(playerid, -1, "/addrefund [player] [refund type] [drug type id] [drug subtype id] [drug container] [amount] [reason]");
        SendClientMessage(playerid, -1, "Drug Types: 1 Weed | 2 Coke | 3 Crack || Subtypes: 1 to 4 || Container Types 0 to 8");
        return true;
    }

    if (item_amount_int)
    {
        item_amount = float(item_amount_int);
    }

    if (item_amount <= 0)
    {
        SendClientMessage(playerid, -1, "Refund amount can not be nil.");
        return true;
    }

    if (!strlen(reason))
    {
        SendClientMessage(playerid, -1, "Refund reason can not be nil.");
        return true;
    }

    if (item_type < 0 || refund_type < 0 || item_infratype < 0 || refund_type < 0 || refund_type > 2)
    {
        SendClientMessage(playerid, -1, "Refund/item/subtype type can not be nil.");
        return true;
    }

    inline RefundAdded() 
	{
        new inserted_id = cache_insert_id();
        SendServerMessage(playerid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("You created a new refund for (%d) %s.", targetid, ReturnMixedName(targetid)));
        SendServerMessage(targetid, COLOR_BLUE, "Refund", "A3A3A3", sprintf("A new refund for you was created by (%d) %s, type {FFFFFF}/myrefunds{A3A3A3} to claim.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME]));
        AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Created Refund #%d for (%d) %s", inserted_id, targetid, ReturnMixedName(targetid)));
    }

    mysql_format(mysql, RefundQuery, sizeof(RefundQuery), "INSERT INTO `refunds` (`refund_player_id`, `refund_type`, `refund_itemtype`, `refund_subtype`, `refund_infratype`, `refund_amount`, `refund_reason`) VALUES (%d, %d, %d, %d, %d, %f, '%e')", 
        Character[targetid][E_CHARACTER_ID], refund_type, item_type, item_subtype, item_infratype, item_amount, reason);

    MySQL_TQueryInline(mysql, using inline RefundAdded, RefundQuery, "");

	return true;
}

CMD:oaddrefund(playerid, params[])
{
	if (GetPlayerAdminLevel(playerid) < ADMIN_LVL_ADVANCED)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.");

	new targetid, refund_type, item_type, item_subtype, item_infratype, Float:item_amount, item_amount_int, reason[128];

    if (sscanf(params, "dd", targetid, refund_type))
    {
		SendClientMessage(playerid, -1, "/oaddrefund [character id] [refund type]");
        SendClientMessage(playerid, -1, "Refund Types: 0 Money | 1 Weapon | 2 Drug");
        return true;
    }

    if (targetid <= 0)
		return SendClientMessage(playerid, -1, "Character ID is invalid.");

    if (refund_type == 0 && sscanf(params, "ddds[128]", targetid, refund_type, item_amount_int, reason))
    {
        SendClientMessage(playerid, -1, "/oaddrefund [character id] [refund type] [money amount] [reason]");
        return true;
    }
    else if (refund_type == 1 && sscanf(params, "dddds[128]", targetid, refund_type, item_type, item_amount_int, reason))
    {
        SendClientMessage(playerid, -1, "/oaddrefund [character id] [refund type] [custom gun id] [ammo] [reason]");
        return true;
    }
    else if (refund_type == 2 && sscanf(params, "dddddfs[128]", targetid, refund_type, item_type, item_subtype, item_infratype, item_amount, reason))
    {
        SendClientMessage(playerid, -1, "/oaddrefund [character id] [refund type] [drug type id] [drug subtype id] [drug container] [amount] [reason]");
        SendClientMessage(playerid, -1, "Drug Types: 1 Weed | 2 Coke | 3 Crack || Subtypes: 1 to 4 || Container Types 0 to 8");
        return true;
    }

    if (item_amount_int)
    {
        item_amount = float(item_amount_int);
    }

    if (item_amount <= 0)
    {
        SendClientMessage(playerid, -1, "Refund amount can not be nil.");
        return true;
    }

    if (item_type < 0 || refund_type < 0 || item_subtype < 0 || item_infratype < 0 || refund_type < 0 || refund_type > 2)
    {
        SendClientMessage(playerid, -1, "Refund/item/subtype type can not be nil.");
        return true;
    }

    if (!strlen(reason))
    {
        SendClientMessage(playerid, -1, "Refund reason can not be nil.");
        return true;
    }

    inline RefundAdded() 
	{
        new inserted_id = cache_insert_id();
		SendClientMessage(playerid, -1, sprintf("You created a new refund for Character ID %d.", targetid));
        AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Created Refund #%d for Character ID %d", inserted_id, targetid));
    }

    mysql_format(mysql, RefundQuery, sizeof(RefundQuery), "INSERT INTO `refunds` (`refund_player_id`, `refund_type`, `refund_itemtype`, `refund_subtype`, `refund_infratype`, `refund_amount`, `refund_reason`) VALUES (%d, %d, %d, %d, %d, %f, '%e')", 
        targetid, refund_type, item_type, item_subtype, item_infratype, item_amount, reason);

    MySQL_TQueryInline(mysql, using inline RefundAdded, RefundQuery, "");

	return true;
}