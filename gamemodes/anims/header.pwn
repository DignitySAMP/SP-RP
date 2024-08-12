// This houses all animation related code. Credits to Spooky, Reyo, BigBear, SC-RP by Emmet_ and parts of LS-RP (thanks to DamianC for open sourcing the 2011 LS-RP codebase).


// Preliminaries
#include "anims/stopanim.pwn"
#include "anims/preload.pwn"

// Animations
#include "anims/anim_single.pwn" // Single anim => do the cmd and u do the anim
#include "anims/anim_choice.pwn" // Listed anims => do the cmd and choose from a list
#include "anims/anim_animated.pwn" // Animated anims => anims with extra code attached to work


// Functions
ApplyAnim(playerid, const animlib[], const animname[], Float: fDelta, loop, lockx, locky, freeze, time, forcesync = 0 ) {

	if ( IsPlayerIncapacitated(playerid, true)) {
    
        return true ;
    }

	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync );
 	PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ] = 1 ;

	// re-cuff anyone that was cuffed
	if (GetPVarInt(playerid, "CUFFED") == 1) SOLS_SetPlayerCuffed(playerid, true, false);

	return true ;
}

AnimationLoop(playerid, const animlib[], const animname[], Float: speed, loop, lockx, locky, freeze, time, forcesync = 1 ) {

	ApplyAnimation(playerid, animlib, animname, speed, loop, lockx, locky, freeze, time, forcesync );

    PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ] = 1;
	
	return true ;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerDeath(playerid, killerid, reason)
{
	// if they die whilst performing a looping anim, we should reset the state
	if (PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ]) 
	{
        PlayerVar [ playerid ] [ E_PLAYER_LOOPING_ANIM ] = 0;
	}

	return 1;
}