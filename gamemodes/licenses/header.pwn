
// note: gun licenses aren't properly set up yet so beware of using them. their textures need a lot more work.


new bool:IsInLicenseCooldown[MAX_PLAYERS];

enum {
	E_LICENSE_TYPE_ID,
	E_LICENSE_TYPE_DRIVER,
	E_LICENSE_TYPE_GUN
}

enum {
	E_BADGE_TYPE_PD,
	E_BADGE_TYPE_SD,
	E_BADGE_TYPE_DEA,
	E_BADGE_TYPE_FBI
}

#include "licenses/gui.pwn"
#include "licenses/native.pwn"



// credits to spooky for the original license code which i just C&P'ed.

CMD:license(playerid, params[]) return cmd_licenses(playerid, params);
CMD:licence(playerid, params[]) return cmd_licenses(playerid, params);
CMD:showlicense(playerid, params[]) return cmd_licenses(playerid, params);
CMD:mylicense(playerid, params[]) return cmd_licenses(playerid, params);
CMD:licenses(playerid, params[]) {

	new target, option[16], gunlicensestr[64];

	if ( sscanf ( params, "k<player>s[16]", target, option ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/license [targetid] [id, drivers, gun]");
	}

	if(IsInLicenseCooldown[playerid]){
		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You've just shown your license. Wait a bit before showing it again.");
	}

	if ( ! IsPlayerConnected(target ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Target isn't connected.");
	}


 	if (!IsPlayerNearPlayer(playerid, target, 6.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
    }


    if(!strcmp(option, "id", true)){

    	if(!PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE])
    		License_ShowPlayerGUI(playerid, target, E_LICENSE_TYPE_ID);

    	SendClientMessage(target, 0xBC2626FF, "[__________] SAN ANDREAS IDENTIFICATION [__________]");
		SendClientMessage(target, COLOR_YELLOW, sprintf("[Full Name]:{DEDEDE} %s", ReturnMixedName(playerid) ) ) ;
		SendClientMessage(target, COLOR_YELLOW, sprintf("[Social Security Number]:{DEDEDE} %d", Character [ playerid ] [ E_CHARACTER_ID ] * Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ])) ;

		if( IsPlayerInPoliceFaction(target) ) {
			SendClientMessage(target, 0x3A84C4FF, "[__] MOBILE DATA COMPUTER PRINT OUT [__]");

			SendClientMessage(target, 0x3A84C4FF, sprintf("[Driving License]:{DEDEDE} %s", ( Character [ playerid ] [ E_CHARACTER_DRIVERSLICENSE ] != 0) ? ("{3FC62F}Yes") : ("{BC2626}No") )) ;	
			//SendClientMessage(target, 0x3A84C4FF, sprintf("[Outstanding fines]{DEDEDE}: $%s", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_OUTSTANDING_FINES ] )) ) ;
			SendClientMessage(target, 0x3A84C4FF, sprintf("[Driver Warnings]{DEDEDE}: %d/3", Character [ playerid ] [ E_CHARACTER_DRIVER_WARNINGS ] ) ) ;

			Property_ShowPlayerProperties(playerid, target ) ;
		}

		SendClientMessage(target, COLOR_HINT, sprintf("[INFO]: {DEDEDE}%s has just shown you their ID. It will go away in 30 seconds or you can /hidelicense.", ReturnSettingsName(playerid, target)));
		defer HidePlayerLicenseTD(target);
    }

    else if(!strcmp(option, "driver", true) || !strcmp(option, "drivers", true)){

    	if(Character[playerid][E_CHARACTER_DRIVERSLICENSE]) {

    		if(!PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE])
    			License_ShowPlayerGUI(playerid, target, E_LICENSE_TYPE_DRIVER);

	    	SendClientMessage(target, 0xBC2626FF, "[__________] SAN ANDREAS DRIVER'S LICENSE [__________]");
			SendClientMessage(target, COLOR_YELLOW, sprintf("[Full Name]:{DEDEDE} %s", ReturnMixedName ( playerid ) ) ) ;
			SendClientMessage(target, COLOR_YELLOW, sprintf("[Social Security Number]:{DEDEDE} %d", Character [ playerid ] [ E_CHARACTER_ID ] * Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ])) ;
			SendClientMessage(target, COLOR_YELLOW, sprintf("[Driving License]:{DEDEDE} %s", ( Character [ playerid ] [ E_CHARACTER_DRIVERSLICENSE ] != 0) ? ("{3FC62F}Yes") : ("{BC2626}No") )) ;

			if( IsPlayerInPoliceFaction(target) ) {
				SendClientMessage(target, 0x3A84C4FF, "[__] MOBILE DATA COMPUTER PRINT OUT [__]");

				//SendClientMessage(target, 0x3A84C4FF, sprintf("[Outstanding fines]{DEDEDE}: $%s", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_OUTSTANDING_FINES ] )) ) ;
				SendClientMessage(target, 0x3A84C4FF, sprintf("[Driver Warnings]{DEDEDE}: %d/3", Character [ playerid ] [ E_CHARACTER_DRIVER_WARNINGS ] ) ) ;

				Property_ShowPlayerProperties(playerid, target ) ;
			}

			SendClientMessage(target, COLOR_HINT, sprintf("[INFO]: {DEDEDE}%s has just shown you their Driver License. It will go away in 30 seconds or you can /hidelicense.", ReturnSettingsName(playerid, target)));
			defer HidePlayerLicenseTD(target);

    	} else {
    		return SendClientMessage(playerid, COLOR_ERROR, "You do not possess a driver license! Get one at the DMV. (/gps)");
    	}

    }

    else if(!strcmp(option, "gun", true) || !strcmp(option, "guns", true)){

    	if(Character[playerid][E_CHARACTER_GUNLICENSE]) {

    		if(!PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE])
    			License_ShowPlayerGUI(playerid, target, E_LICENSE_TYPE_GUN);

	    	SendClientMessage(target, 0xBC2626FF, "[__________] SAN ANDREAS FIREARMS LICENSE [__________]");
			SendClientMessage(target, COLOR_YELLOW, sprintf("[Full Name]:{DEDEDE} %s", ReturnMixedName ( playerid )) ) ;
			SendClientMessage(target, COLOR_YELLOW, sprintf("[Social Security Number]:{DEDEDE} %d", Character [ playerid ] [ E_CHARACTER_ID ] * Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ])) ;

			new year, month, day, hour, minute, second ;
			stamp2datetime(Character [ playerid ] [ E_CHARACTER_GUNLICENSE ], year, month, day, hour, minute, second, 1 ) ;
			if (Character [ playerid ] [ E_CHARACTER_GUNLICENSE ] < gettime()) format(gunlicensestr, sizeof(gunlicensestr), "{FBC02D}Expired (%02d/%02d/%04d)", day, month, year);
			else format(gunlicensestr, sizeof(gunlicensestr), "{3FC62F}Yes (Expires %02d/%02d/%04d)", day, month, year);

			SendClientMessage(target, COLOR_YELLOW, sprintf("[Firearms License]: %s", gunlicensestr)) ;

			if( IsPlayerInPoliceFaction(target) ) {
				SendClientMessage(target, 0x3A84C4FF, "[__] MOBILE DATA COMPUTER PRINT OUT [__]");

				//SendClientMessage(target, 0x3A84C4FF, sprintf("[Outstanding fines]{DEDEDE}: $%s", IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_OUTSTANDING_FINES ] )) ) ;
				SendClientMessage(target, 0x3A84C4FF, sprintf("[Driver Warnings]{DEDEDE}: %d/3", Character [ playerid ] [ E_CHARACTER_DRIVER_WARNINGS ] ) ) ;

				Property_ShowPlayerProperties(playerid, target ) ;
			}

			SendClientMessage(target, COLOR_HINT, sprintf("[INFO]: {DEDEDE}%s has just shown you their Firearms License. It will go away in 30 seconds or you can /hidelicense.", ReturnSettingsName(playerid, target)));
			defer HidePlayerLicenseTD(target);

    	} else {
    		return SendClientMessage(playerid, COLOR_ERROR, "You do not possess a firearms license!");
    	}
    } else return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/license [targetid] [id, drivers, gun]");

	//ProxDetector ( playerid,15.0, COLOR_ACTION, sprintf("* %s shows their license to %s.", ReturnPlayerNameData(playerid, 0, true), ReturnPlayerNameData(target, 0, true) ) );

	if(playerid == target) {
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "looks at their license card.", .annonated=true);
	} else {
		ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", sprintf("shows a license card to %s.", ReturnMixedName(target)), .annonated=true);
	}

	IsInLicenseCooldown[playerid] = true;
	defer ClearLicenseCooldown(playerid);

	return true ;
}

CMD:badge(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid) && !IsPlayerInMedicFaction(playerid) && !IsPlayerInNewsFaction(playerid, true) || GetPlayerFactionSuspension(playerid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're either not on duty, or you can't use this.");
	}

	if(IsInLicenseCooldown[playerid]){
		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You've just shown your badge. Wait a bit before showing it again.");
	}
		

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID(factionid ); 
	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Syntax", "a3a3a3", "/badge [targetid]");
	}

	if ( ! IsPlayerConnected(target ) ) {

		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "Target isn't connected.");
	}

 	if (!IsPlayerNearPlayer(playerid, target, 6.0)) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "DEDEDE", "You're not near your target." ) ;
	}

	new msg[256];

    switch(Faction [ faction_enum_id ] [ E_FACTION_ID ]) {

    	case 34: { //fbi (34)
    		Badge_ShowPlayerGUI(playerid, target, E_BADGE_TYPE_FBI);
    		format(msg, sizeof(msg), sprintf("[INFO]: {DEDEDE}%s has just shown you their FBI Badge. It will go away in 30 seconds or you can /hidebadge.", ReturnSettingsName(playerid, target)));
    	}

    	case 29: { //dea
    		Badge_ShowPlayerGUI(playerid, target, E_BADGE_TYPE_DEA);
    		format(msg, sizeof(msg), sprintf("[INFO]: {DEDEDE}%s has just shown you their DEA Badge. It will go away in 30 seconds or you can /hidebadge.",  ReturnSettingsName(playerid, target)));
    	}

    	case 10: { // pd
    		Badge_ShowPlayerGUI(playerid, target, E_BADGE_TYPE_PD);
    		format(msg, sizeof(msg), sprintf("[INFO]: {DEDEDE}%s has just shown you their PD Badge. It will go away in 30 seconds or you can /hidebadge.",  ReturnSettingsName(playerid, target)));
    	}

    	case 16: { // sd
    		Badge_ShowPlayerGUI(playerid, target, E_BADGE_TYPE_SD);
    		format(msg, sizeof(msg), sprintf("[INFO]: {DEDEDE}%s has just shown you their SD Badge. It will go away in 30 seconds or you can /hidebadge.",  ReturnSettingsName(playerid, target)));
    	}

    }

	ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", sprintf("shows their badge to %s.", ReturnMixedName(target)), .annonated=true);

	SendClientMessage(target, COLOR_BLUE, sprintf("[__________] %s Badge [__________]", Faction[faction_enum_id][E_FACTION_ABBREV]));
	SendClientMessage(target, COLOR_GRAD1, sprintf("Name: %s", ReturnMixedName(playerid) ) ) ;
	SendClientMessage(target, COLOR_GRAD1, sprintf("Rank: %s", Character [ playerid ] [ E_CHARACTER_FACTIONRANK ] ) ) ;
	SendClientMessage(target, COLOR_GRAD1, sprintf("Badge: #%05d", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ] ) ) ;

	SendClientMessage(target, COLOR_HINT, msg);

	defer HidePlayerBadgeTD(target);

	IsInLicenseCooldown[playerid] = true;
	defer ClearLicenseCooldown(playerid);

	return true ;
}


CMD:flashbadge(playerid, params[]){

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if ((!IsPlayerInPoliceFaction(playerid) && !IsPlayerInMedicFaction(playerid) && !IsPlayerInNewsFaction(playerid, true) && !IsPlayerInGovFaction(playerid)) || GetPlayerFactionSuspension(playerid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're either not on duty, or you can't use this.");
	}

	if(IsInLicenseCooldown[playerid]){
		return SendServerMessage(playerid, COLOR_RED, "Error", "a3a3a3", "You've just shown your badge. Wait a bit before showing it again.");
	}	

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID(factionid ); 

	new Float: x, Float: y, Float: z, msg[256];
	GetPlayerPos(playerid, x, y, z);

	//ProxDetectorAutoMe(playerid, 30.0, "flashes their badge.", true);
	ProxDetectorEx(playerid, 30.0, COLOR_ACTION, "*", "flashes their badge.", .annonated=true);

	foreach(new target: Player) {

		if(IsPlayerInRangeOfPoint(target, 6.0, x, y, z)){

			if(target == playerid) continue;

			if(IsPlayerInPoliceFaction(playerid)) {
				Badge_ShowPlayerGUI(playerid, target, E_BADGE_TYPE_PD);
				format(msg, sizeof(msg), sprintf("[INFO]: {DEDEDE}%s has just shown you their PD Badge. It will go away in 30 seconds or you can /hidebadge.", ReturnSettingsName(playerid, target)));
			}
			
			SendClientMessage(target, COLOR_BLUE, sprintf("[__________] %s Badge [__________]", Faction[faction_enum_id][E_FACTION_ABBREV]));
			SendClientMessage(target, COLOR_GRAD1, sprintf("Name: %s", ReturnMixedName(playerid) ) ) ;
			SendClientMessage(target, COLOR_GRAD1, sprintf("Rank: %s", Character [ playerid ] [ E_CHARACTER_FACTIONRANK ] ) ) ;
			SendClientMessage(target, COLOR_GRAD1, sprintf("Badge: #%05d", Character [ playerid ] [ E_CHARACTER_FACTION_BADGE ] ) ) ;

			SendClientMessage(target, COLOR_HINT, msg);

			defer HideQuickPlayerBadgeTD(target);

		}
	}

	IsInLicenseCooldown[playerid] = true;
	defer ClearLicenseCooldown(playerid);

	return true;
}

CMD:showbadge(playerid, params[]){
	return cmd_badge(playerid, params);
}

CMD:hidelicense(playerid, params[]){
	License_HidePlayerGUI(playerid);
	Badge_HidePlayerGUI(playerid);
	return true;
}

CMD:hidebadge(playerid, params[]){
	return cmd_hidelicense(playerid, params);
}

timer HidePlayerLicenseTD[30000](playerid) { 
		License_HidePlayerGUI(playerid);
		return true;
}

timer HidePlayerBadgeTD[30000](playerid) { 
		Badge_HidePlayerGUI(playerid);
		return true;
}

timer HideQuickPlayerBadgeTD[10000](playerid) { 
		Badge_HidePlayerGUI(playerid);
		return true;
}

timer ClearLicenseCooldown[10000](playerid){
	IsInLicenseCooldown[playerid] = false;
	return true;
}