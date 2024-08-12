#include <YSI_Coding\y_hooks>
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (newstate == PLAYER_STATE_SPECTATING && GetPlayerAdminLevel(playerid) < 1 && IsPlayerLogged(playerid) && PlayerVar[playerid][E_PLAYER_CHOSE_CHARACTER] && !PlayerVar [ playerid ] [ E_PLAYER_JUST_LOGGED_OUT ])
    {
		new acstr[256];
		format(acstr, sizeof(acstr), "[Anticheat]: (%i) %s is spectating without being an admin", playerid, ReturnMixedName(playerid));
		SendAdminMessage(acstr);

    }

    return 1;
}
