#include "config/includes.pwn"

#if !defined SERVER_HOSTNAME
	#define SERVER_HOSTNAME   		"[0.3.DL] Singleplayer Roleplay | discord.gg/sp-rp"
#endif

#if !defined SERVER_MODE

/* 


	Revision format:

	Example:
	v1.2.9

	version 1 - the main gamemode version
	subversion 2 - the 'content stage' or whatever
	infraversion 9 - each update this gets increased until the subversion is increased

*/

	#define SERVER_MODE       		"SP-RP v1.0.5"
#endif

#if !defined SERVER_MAP
	#define SERVER_MAP		    	"Los Santos"
#endif

#if !defined SERVER_NAME 
	#define SERVER_NAME 			"Singleplayer Roleplay"
#endif

#if !defined SERVER_WEBSITE
	#define SERVER_WEBSITE	    	"singleplayer-roleplay.com"
#endif

#if !defined SERVER_VEH_RENT_FEE
	#define SERVER_VEH_RENT_FEE			( 125 )
#endif 

#if !defined SERVER_DMV_FEE
	#define SERVER_DMV_FEE 			( 250 )
#endif

#if !defined SERVER_MAX_NAME_UNDERSCORES
	#define SERVER_MAX_NAME_UNDERSCORES	(2)
#endif

#include "config/data/header.pwn"
#include "config/utils/header.pwn"
#include "config/gui/header.pwn"


#include "config/fader.pwn"
#include "config/commands.pwn"
#include "config/main.pwn"

#include "config/modelconstants.pwn"
#include "config/colors.pwn"