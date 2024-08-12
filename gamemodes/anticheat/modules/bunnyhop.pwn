//------------------------------------------------------------------------------
// Basic anti bunnyhopping
// Written by Spooky (www.github.com/sporkyspork) for GTAC:RP

#include <YSI_Coding\y_hooks> // A library which lets us hook SAMP callbacks

static enum E_PLAYER_JUMP_VARS
{
    E_PLAYER_JUMP_PRESSED_AT,	// When the player last pressed KEY_JUMP
    E_PLAYER_JUMPED_AT,			// When the player actually started jumping
    E_PLAYER_JUMP_CD			// When the player completed their last jump
}

// This is the main way of storing data in SAMP:
static PlayerJump[MAX_PLAYERS][E_PLAYER_JUMP_VARS];

static ClearVars(playerid)
{
	// Creates a new empty array of E_PLAYER_JUMP_VARS, then sets it for the player.
 	new var_clear[E_PLAYER_JUMP_VARS]; 
	PlayerJump[playerid] = var_clear;
}

// OnPlayerConnect is processed when a player joins the server
hook OnPlayerConnect(playerid)
{
	// Here we just clear their variables so they are reset (not strictly necessary in this script though)
	ClearVars(playerid);
    return 1;
}

// OnPlayerUpdate is processed every time the client updates the server with new sync data
hook OnPlayerUpdate(playerid)
{  
	// Here, if the player has pressed jump, we detect if they are ACTUALLY jumping
    if (PlayerJump[playerid][E_PLAYER_JUMP_PRESSED_AT])
	{
	    if (gettime() - PlayerJump[playerid][E_PLAYER_JUMP_PRESSED_AT] >= 5)
	    {
	        // Here, we ae basically saying that if the player's last jump was five seconds or longer ago not to worry about it.
	        PlayerJump[playerid][E_PLAYER_JUMP_PRESSED_AT] = 0;
	        return 1;
	    }
	
		// These animation IDs here relate to the GTA jump animations.
        if (GetPlayerAnimationIndex(playerid) == 1197 || GetPlayerAnimationIndex(playerid) == 1198)
	    {
			// We can say that the player has actually jumped, so we set E_PLAYER_JUMPED_AT to the current timestamp to signify this.
	        PlayerJump[playerid][E_PLAYER_JUMPED_AT] = gettime();
	        PlayerJump[playerid][E_PLAYER_JUMP_PRESSED_AT] = 0;
	    }
	}
	
	// So if the player has actually jumped, we detect once they land
	if (PlayerJump[playerid][E_PLAYER_JUMPED_AT])
	{
		if (GetPlayerAnimationIndex(playerid) == 1196) // This is the animation that plays when a jump lands
	    {
		    if (PlayerJump[playerid][E_PLAYER_JUMP_CD] && gettime() - PlayerJump[playerid][E_PLAYER_JUMP_CD] < 5)
		    {
				PauseAC(playerid, 3);
				// And if the player lands a jump within 5 seconds of their previous jump, we play a falling animation.
				ClearAnimations(playerid);
		 		ApplyAnimation(playerid, "ped", "fall_collapse", 4.1, 0, 1, 1, 0, 0);
		    }
		    
			// Reset the E_PLAYER_JUMPED_AT, but keep track of E_PLAYER_JUMP_CD so we can compare against it for the next jump
		    PlayerJump[playerid][E_PLAYER_JUMPED_AT] = 0;
		    PlayerJump[playerid][E_PLAYER_JUMP_CD] = gettime();
		}
	}

    return 1;
}

// OnPlayerKeyStateChange is processed when the client presses or releases a key (only default GTA SA controls like KEY_AIM or KEY_JUMP are detectable)
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_JUMP) && GetPlayerAdminLevel(playerid) <= 2 && !PlayerVar[playerid][E_PLAYER_ADMIN_DUTY])
	{
		// When they press jump, we just store the time at which they did it.
	    PlayerJump[playerid][E_PLAYER_JUMP_PRESSED_AT] = gettime();
	}

	return 1;
}