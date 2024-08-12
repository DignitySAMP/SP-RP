new bool:AC_HEALTH = true;
new bool:AC_TELEPORT = true;
new bool:AC_AIRBREAK = true;
new bool:AC_MODHACKS = true;

GetAnticheatStatus(setting) {
	new string[32];

	if(setting) string = "On";
	else string = "Off";
	
	return string;
}

CMD:acstatus(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

	SendClientMessage(playerid, -1, sprintf("Health Hack AC: [%s]\n", GetAnticheatStatus(AC_HEALTH)));
	SendClientMessage(playerid, -1, sprintf("Teleport Hack AC: [%s]\n", GetAnticheatStatus(AC_HEALTH)));
	SendClientMessage(playerid, -1, sprintf("Airbreak AC: [%s]\n", GetAnticheatStatus(AC_AIRBREAK)));
	SendClientMessage(playerid, -1, sprintf("Mod Hacks AC: [%s]\n", GetAnticheatStatus(AC_MODHACKS)));

	return true;

}

CMD:toggleac(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
    }

	new option[16];
	if ( sscanf ( params, "s[16]", option ) )
        return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/toggleac [health, tp, airbreak, mod]");


	if ( !strcmp ( option, "health", true ) ) {
		AC_HEALTH = !AC_HEALTH;
		SendClientMessage(playerid, -1, sprintf("Health Hack AC: [%s]\n", GetAnticheatStatus(AC_HEALTH)));
		SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s has toggled health hack AC to %s.", playerid, ReturnPlayerName(playerid), GetAnticheatStatus(AC_HEALTH)), COLOR_ANTICHEAT);
		return true;
	}

	if ( !strcmp ( option, "tp", true ) ) {
		AC_TELEPORT = !AC_TELEPORT;
		SendClientMessage(playerid, -1, sprintf("Teleport Hack AC: [%s]\n", GetAnticheatStatus(AC_TELEPORT)));
		SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s has toggled teleport hack AC to %s.", playerid, ReturnPlayerName(playerid), GetAnticheatStatus(AC_TELEPORT)), COLOR_ANTICHEAT);
		return true;
	}

	if ( !strcmp ( option, "airbreak", true ) ) {
		AC_TELEPORT = !AC_TELEPORT;
		SendClientMessage(playerid, -1, sprintf("Airbreak AC: [%s]\n", GetAnticheatStatus(AC_AIRBREAK)));
		SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s has toggled Airbreak AC to %s.", playerid, ReturnPlayerName(playerid), GetAnticheatStatus(AC_AIRBREAK)), COLOR_ANTICHEAT);
		return true;
	}

	if ( !strcmp ( option, "mod", true ) ) {
		AC_MODHACKS = !AC_MODHACKS;
		SendClientMessage(playerid, -1, sprintf("Modhacks AC: [%s]\n", GetAnticheatStatus(AC_MODHACKS)));
		SendAdminMessage(sprintf("[ANTICHEAT]: (%d) %s has toggled Modhacks AC to %s.", playerid, ReturnPlayerName(playerid), GetAnticheatStatus(AC_MODHACKS)), COLOR_ANTICHEAT);
		return true;
	}

	return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/toggleac [health, tp, airbreak]");

}
