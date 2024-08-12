// This is taken fron fuckCleo.inc 0.3.5 by Lorenc_. Credits to Cessil, Infamous and [FeK]Drakins, JernejL

new Float: fC_carSwing_X[MAX_PLAYERS];
new Float: fC_carSwing_Y[MAX_PLAYERS];
new Float: fC_carSwing_Z[MAX_PLAYERS];


#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {
    fC_carSwing_X[playerid] = 0;
    fC_carSwing_Y[playerid] = 0;
    fC_carSwing_Z[playerid] = 0;
}


hook OnPlayerUpdate( playerid )
{
    static
        Float: X,     Float: Y,     Float: Z,
        Float: vX,    Float: vY,     Float: vZ
    ;
    GetPlayerPos( playerid, X, Y, Z );

    if( X >= 99999.0 || Y >= 99999.0 || Z >= 99999.0 || X <= -99999.0 || Y <= -99999.0 || Z <= -99999.0 ) {
        SendClientMessage( playerid, 0xa9c4e4ff, "Warning: Excessive X, Y, Z has been breached thus last location set." );
        PauseAC(playerid, 3);
        SetPlayerPos( playerid, fC_carSwing_X[playerid] , fC_carSwing_Y[playerid] , fC_carSwing_Z[playerid]  );
    }
    else
    {
        fC_carSwing_X[playerid]  = X;
        fC_carSwing_Y[playerid]  = Y;
        fC_carSwing_Z[playerid]  = Z;
    }

    if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
    {
        GetPlayerPos( playerid, X, Y, Z );
        GetVehicleVelocity( GetPlayerVehicleID( playerid ), vX, vY, vZ );
        if( ( vX > 3.0 || vY > 3.0 || vZ > 3.0 || vX < -3.0 || vY < -3.0 || vZ < -3.0 ) && ( vX != X && vY != Y && vZ != Z ) )
        {
            SendAdminMessage(sprintf("[ANTICHEAT CRITICAL]: (%d) %s might be using car swing hack.", playerid, ReturnPlayerName(playerid)), COLOR_ANTICHEAT);
        }
    }
    return 1;
}
