#include <a_samp>

#pragma compress 0
#define YSI_NO_HEAP_MALLOC

#define KEY_AIM KEY_HANDBRAKE
#define KEY_AIM_FIRE    132


#undef MAX_PLAYERS
#define MAX_PLAYERS 100

#include "crashdetect"
#include "sscanf2"


#include <YSI_Coding\y_hooks>
DEFINE_HOOK_REPLACEMENT(Vehicle, Veh);

#include <YSI_Coding\y_inline>
#include <ww_mysql>
#include <samp_bcrypt>
#include <strlib>
#define STREAMER_USE_DYNAMIC_TEXT3D_TAG
#include <streamer>
#define GetDynamicObjectModel(%0) Streamer_GetIntData(STREAMER_TYPE_OBJECT, %0, E_STREAMER_MODEL_ID)

#include <zcmd>
#include <YSI_Visual\y_dialog>
#include <YSI_Coding\y_timers>
#include <YSI_Data\y_iterate>
#include <progress2>

// misc
//#include "zmessage"
#include "config/zmessage_custom.pwn" // no longer hooking sendclientmessage!

#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg>

#include <menustore>
#include <iptrace>
//#include "callbacks.pwn"	
//#include <PawnPlus>

// objects
#include <colandreas>
#include <fsutil>

// array hack
#include <md-sort>

// regex
#include <Pawn.Regex>