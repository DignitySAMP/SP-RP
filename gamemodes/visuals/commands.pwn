CMD:blindfold(playerid, params[]) {

    if ( PlayerVar [ playerid ] [ E_PLAYER_BLINDFOLDED ] ) {

        PlayerVar [ playerid ] [ E_PLAYER_BLINDFOLDED ] = false ;
        TextDrawHideForPlayer(playerid, gBlindfoldTD);
    }

    else if ( ! PlayerVar [ playerid ] [ E_PLAYER_BLINDFOLDED ] ) {

        PlayerVar [ playerid ] [ E_PLAYER_BLINDFOLDED ] = true ;
        TextDrawShowForPlayer(playerid, gBlindfoldTD);
    }

    return true ;
}