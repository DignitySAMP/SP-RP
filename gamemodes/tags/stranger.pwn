CMD:mask(playerid) {

	if(Character[playerid][E_CHARACTER_HOURS] < 8) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You need at least 8 playing hours before you can use a /mask.");
	}


	if(! Character[playerid][E_CHARACTER_MASKID] && !IsPlayerInAnyGovFaction(playerid, false)) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a mask! Buy one from the 24/7.");
	}

	if(IsPlayerIncapacitated(playerid, false) && !PlayerVar[playerid][E_PLAYER_IS_MASKED]) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't put on a mask just now.");
	}

	// Special case if they're a cop and never had a mask before
	if(!Character[playerid][E_CHARACTER_MASKID] && IsPlayerInAnyGovFaction(playerid, false)) {
		Character [ playerid ] [ E_CHARACTER_MASKID ] = CalculateMaskID(playerid)  ;
    	SendServerMessage ( playerid, COLOR_SERVER, "Server", "DEDEDE", sprintf("You recieved a mask from your faction. Your new mask ID is %d.", Character [ playerid ] [ E_CHARACTER_MASKID ] ) ) ;

    	new query [ 256 ] ;

    	mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_maskid = %d WHERE player_id = %d", 

    		Character [ playerid ] [ E_CHARACTER_MASKID ], 
    		Character [ playerid ] [ E_CHARACTER_ID ] ) ;

    	mysql_tquery(mysql, query);
	}

	if(PlayerVar[playerid][E_PLAYER_IS_MASKED]) {

		ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "**", "takes off their mask.", .showid = false, .annonated=true);
        PlayerVar[playerid][E_PLAYER_IS_MASKED]= false ;
        ToggleMask(playerid, false);

		new year, month, day, hour, minute, second;
		stamp2datetime(gettime(), year, month, day, hour, minute, second, 1);
		SendServerMessage(playerid, COLOR_ORANGE, "Mask", "A3A3A3", sprintf("You removed your mask at %02d:%02d:%02d, it will be discoverable in your inventory for 30 minutes.", hour, minute, second));
    }

    else if(! PlayerVar[playerid][E_PLAYER_IS_MASKED]) 
	{

		if(!Attachments_CountMask(playerid) && !GetPlayerAdminLevel(playerid) && !Character[playerid][E_CHARACTER_FACTIONID])
		{
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You aren't wearing a face covering object, check /toys.");
		}

		ProxDetectorEx(playerid, 15.0, COLOR_ACTION, "**", "puts on their mask.", .showid = false, .annonated=true);
        PlayerVar[playerid][E_PLAYER_IS_MASKED]= true ;
        ToggleMask(playerid, true);

		new year, month, day, hour, minute, second;
		stamp2datetime(gettime(), year, month, day, hour, minute, second, 1);
		SendServerMessage(playerid, COLOR_ORANGE, "Mask", "A3A3A3", sprintf("You put on your mask at %02d:%02d:%02d.", hour, minute, second));
    }

	PlayerVar[playerid][E_PLAYER_LAST_MASKED_AT]= gettime();

	return true ;
}

CMD:removemask(playerid, params[]) {

	new userid ;

	if(sscanf(params, "u", userid)) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/removemask [targetid]");
	}

	if(! IsPlayerConnected(userid)) {

		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected.") ;
	}

	// If no admin
	if(GetPlayerAdminLevel(playerid) < 1) {

		if(! IsPlayerIncapacitated(userid, false)) {

			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Your target must be incapacitated!(injured/tased/cuffed/...)");
		}
		else if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		{
			return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You're too far away from this player.");
		}
	}

	if(!PlayerVar[userid][E_PLAYER_IS_MASKED])
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't masked.");
	}

	SendClientMessage(userid, COLOR_GRAD0, sprintf("%s has removed your mask.",  ReturnSettingsName(playerid, userid, false))) ;
	SendClientMessage(playerid, COLOR_GRAD0, sprintf("You removed the mask from(%d) %s.",  userid, ReturnSettingsName(userid, playerid, false))) ;
	cmd_mask(userid);

	return true ;
}

CMD:showmasks(playerid) {

	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z);

	foreach(new targetid: Player) {

		if(GetPlayerDistanceFromPoint(targetid, x, y, z) < 10.0 && PlayerVar[targetid][E_PLAYER_IS_MASKED]) {

			SetPlayerChatBubble(targetid, sprintf("Stranger %i", GetPlayerMaskID(targetid)), 0xA3A3A3AA, 15.0, 10000);
		}
		else if(!PlayerVar[targetid][E_PLAYER_IS_MASKED]) continue;
	}

	return 1;
}

CMD:checkmasks(playerid) {
	return cmd_showmasks(playerid);
}

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    foreach(new targetid: Player) {
        ShowPlayerNameTagForPlayer(targetid, playerid, true); // Enable names from connector for everybody.
    }
	return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerSpawn(playerid) {
	foreach(new targetid: Player) {
        if(IsPlayerMasked(targetid)) {
            ShowPlayerNameTagForPlayer(playerid, targetid, false); // If target is masked, make sure to hide their names for new connector
        }
    }
	return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerStreamIn(playerid, forplayerid) { 
	if(IsPlayerMasked(playerid)) {
		ShowPlayerNameTagForPlayer(forplayerid, playerid, false); 
	}
    return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) { 
	foreach(new targetid: Player) {
        if(IsPlayerMasked(targetid)) {
            ShowPlayerNameTagForPlayer(playerid, targetid, false); // If target is masked, make sure to hide their names for new connector
        }
    }
    return 1;
}

ToggleMask(playerid, bool: status) {
    foreach(new targetid: Player) {

        if(status) {
            ShowPlayerNameTagForPlayer(targetid, playerid, false);
        }
        else ShowPlayerNameTagForPlayer(targetid, playerid, true);
		UpdateTabList(targetid, playerid); // this might be laggy as fuck
    }
}

CalculateMaskID(playerid) {

	new accid = Account[playerid][E_PLAYER_ACCOUNT_ID], 
		charid = Character[playerid][E_CHARACTER_ID];

	new mask_id =((accid + charid) / 2);

	// Since this algorithm consists of accid and charid, it will fail for the first few hundred players.(and provide ids below MAX_PLAYERS)
	// To prevent this, let's check if it's smaller than MAX_PLAYERS and edit it if so.
	if(mask_id < MAX_PLAYERS) {
		mask_id += MAX_PLAYERS;
	} 

	mask_id += random(99) ;

	return mask_id ;
}

IsPlayerMasked(playerid) {

	if(playerid == INVALID_PLAYER_ID) {

		return false ;
	}

	return PlayerVar[playerid][E_PLAYER_IS_MASKED];
}

GetPlayerMaskID(playerid) {

	if(playerid == INVALID_PLAYER_ID) {

		return false ;
	}

	return Character[playerid][E_CHARACTER_MASKID];
}