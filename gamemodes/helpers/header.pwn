

#include "helpers/data.pwn"
#include "helpers/chat.pwn"
#include "helpers/ask.pwn"


IsPlayerHelper ( playerid, allow_admin = true ) {

	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_JUNIOR && allow_admin ) {

		return true ; 
	}

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] > HELPER_LVL_NONE ) {

		return true ;
	}

	return false ;
}

SendHelperMessage(const text[], color = -1, bool: force = false, bool: chat = false, bool: include_admins = true) {

	if ( color == -1 ) {

		color = RGBA_DARKER(Server [ E_SERVER_HELPER_HEX ]);
	}

	foreach(new helperid: Player) {

		if ( ! IsPlayerLogged ( helperid ) ) {

			continue ;
		}

		if ( PlayerVar [ helperid ] [ E_PLAYER_ADMIN_WARNS_TOGGLED ] && !force) {
			continue ;
		}

		if ( PlayerVar [ helperid ] [ E_PLAYER_ADMIN_CHATS_TOGGLED ] && chat) {
			continue ;
		}

		if ( IsPlayerHelper ( helperid, include_admins ) || Account [ helperid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] ) {

			ZMsg_SendClientMessage(helperid, color, text ) ;
		}

		else continue ;
	}

	return true ;
}

CMD:answer ( playerid, params [] ) {

	//if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {
	if ( ! IsPlayerHelper ( playerid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new userid, answer [ 144 ] ;

	if ( sscanf ( params, "k<player>s[144]", userid, answer ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/answer [id] [answer]") ;
	}

	if ( ! IsPlayerConnected ( userid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Player isn't connected!") ;
	}

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "[Answer]{DEDEDE} (%d) %s replied: %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], answer ) ; 
	ZMsg_SendClientMessage(userid, RGBA_DARKER ( Server [ E_SERVER_HELPER_HEX ] ), string ) ;
	
	format ( string, sizeof ( string ), "[Answer] (%d) %s replies to (%d) %s: %s", playerid, ReturnMixedName(playerid), userid, ReturnMixedName(userid), answer) ; 
	SendHelperMessage( string ) ;

	return true ;
}

CMD:ans(playerid, params[])
{
	return cmd_answer(playerid, params);
}

CMD:helperduty (playerid, params[]){

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] < 2 ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new string[64];

	if(!PlayerVar[playerid][E_PLAYER_HELPER_DUTY]){

		inline HelperConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
	    	#pragma unused pid, dialogid, listitem, inputtext

			if ( ! response ) {

	    		return false ;
			}

			if ( response ) {

				PlayerVar [ playerid ] [ E_PLAYER_HELPER_DUTY ] = true ;
				TextDrawShowForPlayer(playerid, E_HELPER_DUTY_TEXT );

				UpdateTabListForOthers ( playerid ) ;

				format ( string, sizeof ( string ), "(%d) %s has gone on helper duty.", playerid, ReturnMixedName(playerid) ) ;
				SendAdminMessage(string);
				
				AddLogEntry(playerid, LOG_TYPE_ADMIN, "has gone on helper duty.");

				return true ;
			}
		}

		new confirmstring [ 1024 ] ;

		format ( confirmstring, sizeof ( confirmstring ), "{DEDEDE}You're now on {AEC77D}Helper Duty{DEDEDE}, an exemption from roleplay so you can perform your duties properly.\nDon't mistake this as an admin privilege.");

		Dialog_ShowCallback ( playerid, using inline HelperConfirm, DIALOG_STYLE_MSGBOX, "{AEC77D}HELPER DUTY CONFIRMATION{DEDEDE}", confirmstring, "Continue", "Exit" );

	} else if(PlayerVar[playerid][E_PLAYER_HELPER_DUTY]) {

		PlayerVar [ playerid ] [ E_PLAYER_HELPER_DUTY ] = false ;
		TextDrawHideForPlayer(playerid, E_HELPER_DUTY_TEXT );

		UpdateTabListForOthers ( playerid ) ;

		format ( string, sizeof ( string ), "(%d) %s has gone off helper duty.", playerid, ReturnMixedName(playerid) ) ;
		SendAdminMessage(string);

		AddLogEntry(playerid, LOG_TYPE_ADMIN, "has gone off helper duty.");

	}

	return true;

}

CMD:hduty(playerid, params[])
{
	return cmd_helperduty(playerid, params);
}