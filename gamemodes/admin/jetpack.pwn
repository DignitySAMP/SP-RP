CMD:jetpack(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK) ;

	return true ;
}
