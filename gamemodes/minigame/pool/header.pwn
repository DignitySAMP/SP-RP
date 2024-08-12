// purpose: get distance between 2d points
stock Float: GetDistanceFromPointToPoint( Float: fX, Float: fY, Float: fX1, Float: fY1 ) {
    return Float: floatsqroot( floatpower( fX - fX1, 2 ) + floatpower( fY - fY1, 2 ) );
}

#include "minigame/pool/pool.pwn"

Pool_OnModeInit() {
    PHY_ScriptInit();
    Pool_LoadEntities() ;
    Pool_OnScriptInit (); 

    return true ;
}


