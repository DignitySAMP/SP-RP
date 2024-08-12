#include "police/systems/header.pwn"
#include "police/detaining/header.pwn"
#include "police/stun/header.pwn"

// Spooky's pd interior
#include "police/interior.pwn"

IsPlayerInPoliceFaction(playerid, bool:onduty=false) 
{
	return IsPlayerInFactionType(playerid, FACTION_TYPE_POLICE, onduty);
}