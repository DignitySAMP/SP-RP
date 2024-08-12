/*
    TODO: only loading the skin when the player connects (set ACTIVE var to true)

    - finding a way to save the skin name as a player skin, rather than an id
    (i can simply do this by setting the saved skin id to -1 and then adding an extra table that gets checked if -1 with the model name, which is then linked with the skin repository cache)

*/

#define LIVE_SKIN_UPDATE_TIME (900000) // 15 minutes
new lastSkinAddition;

#include "customskins/loading.pwn"
#include "customskins/cache.pwn"
#include "customskins/player.pwn"

public OnPlayerSpawn(playerid) {
    // There is an issue with player skins not being set, and this skipping important spawn functions. This seems to be the fix (don't set saved skin anywhere, only once they spawn)
	SOLS_SetPlayerSkin(playerid);
	return 1;
}