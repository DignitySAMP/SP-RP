#warning Add all definitions to a global file.
#warning Add a hook for loading models, then call it in the respective files. This way the server-log.txt isn't clogged with model loading messages that overlap other systems.

#define SHORT_URL_DONATIONS		"https://donate.sp-rp.cc"
#define SHORT_URL_PAINTJOBS		"https://paintjobs.sp-rp.cc"

#define MAX_FACTION_TYPES       8
 
#define FACTION_TYPE_POLICE 	0
#define FACTION_TYPE_EMS		3
#define FACTION_TYPE_NEWS		4
#define FACTION_TYPE_TRUCKER	5
#define FACTION_TYPE_GOV  		6

#define FACTION_SQUAD_NONE 0

#define FACTION_SQUAD_CRASH 1
#define FACTION_SQUAD_SWAT 	2
#define FACTION_SQUAD_TRAFF	3

#define FACTION_SQUAD_GOV_DAO       1
#define FACTION_SQUAD_GOV_PW        2
#define FACTION_SQUAD_GOV_ADMIN     3
#define FACTION_SQUAD_GOV_COURT     4
#define FACTION_SQUAD_GOV_COUNCIL   5
  
enum E_PLAYER_NAME_STYLE
{
    PLAYER_NAME_STYLE_ROLEPLAY,   // RP name (so char name replaced with spaces, but uses mask if masked)
    PLAYER_NAME_STYLE_CHARACTER,  // Char name replaced by spaces, ignores mask
    PLAYER_NAME_STYLE_ACCOUNT,    // Account name
    PLAYER_NAME_STYLE_LEGACY,     // Old shit like Account (F. Last)
    PLAYER_NAME_STYLE_DEFAULT     // Wrapper for default GetPlayerName
}
  
enum E_LOG_TYPES
{
	LOG_TYPE_NONE,
	LOG_TYPE_CHAT,
	LOG_TYPE_ACTION,
	LOG_TYPE_SCRIPT,
	LOG_TYPE_GAME,
	LOG_TYPE_DAMAGE,
	LOG_TYPE_OOC,
	LOG_TYPE_PM,
	LOG_TYPE_PHONE,
	LOG_TYPE_PAGER,
	LOG_TYPE_ADMIN,
	LOG_TYPE_RADIO,
	LOG_TYPE_CMD,
	LOG_TYPE_DRUGS,
	LOG_TYPE_ANTICHEAT,
	LOG_TYPE_GRAFFITI,
	LOG_TYPE_JOB,
	LOG_TYPE_STAFFCHAT
}

enum
{
	DEATHTYPE_WEAPON,
	DEATHTYPE_KNIFED,
	DEATHTYPE_CUSTOM
}

enum { // represents constants for /weapons/data/header.pwn
	CUSTOM_FIST,
	CUSTOM_BRASSKNUCKLE = 1,
	CUSTOM_GOLFCLUB,
	CUSTOM_NITESTICK,
	CUSTOM_KNIFE,
	CUSTOM_BAT,
	CUSTOM_SHOVEL,
	CUSTOM_POOLSTICK,
	CUSTOM_KATANA,
	CUSTOM_CHAINSAW,
	CUSTOM_CANE,
	CUSTOM_SPRAYCAN,
	CUSTOM_COLT,
	CUSTOM_COLT_SILENCED,
	CUSTOM_DEAGLE,
	CUSTOM_UZI,
	CUSTOM_TEC,
	CUSTOM_MP5,
	CUSTOM_AK47,
	CUSTOM_M4A1,
	CUSTOM_SHOTGUN,
	CUSTOM_COMBAT_SHOTGUN,
	CUSTOM_SAWNOFF_SHOTGUN,
	CUSTOM_RIFLE,
	CUSTOM_SNIPER_RIFLE,
	CUSTOM_CAMERA,
	CUSTOM_TAZER,
	CUSTOM_FIRE_EXTINGUISHER,
	CUSTOM_POLICE_GLOCK,
	CUSTOM_LICENSED_COLT,
	CUSTOM_LICENSED_DEAGLE
}

 
enum { // gym stats

	E_GYM_STAT_ENERGY,
	E_GYM_STAT_WEIGHT,
	E_GYM_STAT_MUSCLE,
	E_GYM_STAT_HUNGER,
	E_GYM_STAT_THIRST
} ;

enum { // gps colors
	E_GPS_COLOR_DEFAULT = 0x9E1A1AFF, // red
	E_GPS_COLOR_SCRIPT = 0x2D3E77FF, // blue
	E_GPS_COLOR_JOB = 0x318635FF // green
} ;

enum E_SERVER_DATA {

	// Non saving
	E_SERVER_UPTIME,

	E_SERVER_TIME_HOURS,
	E_SERVER_TIME_MINUTES,

	E_SERVER_TIME_DAYS,
	E_SERVER_TIME_MONTHS,
 
	E_SERVER_WEATHER_TICK,
	E_SERVER_WEATHER, 

	E_SERVER_OOC_ENABLED,
	//E_SERVER_RC_ENABLED, // respected
	E_SERVER_DC_ENABLED, // donator
	E_SERVER_SC_ENABLED, // strawman
	E_SERVER_TOLLS_LOCKED,

	E_SERVER_ADMIN_HEX,
	E_SERVER_HELPER_HEX,

	// motd
	E_SERVER_MOTD_STRING_1 [ 96 ],
	E_SERVER_MOTD_STRING_2 [ 96 ],
	E_SERVER_MOTD_STRING_3 [ 96 ],
	E_SERVER_MOTD_EDITOR   [ 24 ],
	E_SERVER_MOTD_EDIT_TIME,

	E_SERVER_TEXTDRAW_TICK,

	E_SERVER_CHOPSHOP_FACTIONID,
	E_SERVER_CHOPSHOP_COLLECT,

	DynamicText3D: E_SERVER_CHOPSHOP_LABEL,

	// Random help msgs
	E_SERVER_RAND_MSG,

	// For casinos
	E_SERVER_SLOTS_JACKPOT,
	DynamicText3D: E_SERVER_SLOTS_JACKPOTLABEL [ 3 ],

	Float: E_SERVER_LAST_911_POS_X,
	Float: E_SERVER_LAST_911_POS_Y,
	Float: E_SERVER_LAST_911_POS_Z,
	E_SERVER_LAST_911_TYPE,


	Float: E_SERVER_POLICE_KIOSK_X,
	Float: E_SERVER_POLICE_KIOSK_Y,
	Float: E_SERVER_POLICE_KIOSK_Z,
	E_SERVER_POLICE_KIOSK_INT,
	E_SERVER_POLICE_KIOSK_VW,
	DynamicText3D: POLICE_KIOSK_LABEL,

	E_SERVER_SONG_URL[128],
	E_SERVER_ACCS_DISABLED_UNTIL,

	bool: E_SERVER_IS_DS_OFF

} ;

new Server [ E_SERVER_DATA ] ;

// Locations (make these dynamic eventually... /createpoint [type: chopshop/dmv/...], /movepoint, /deletepoint, /setpoint?)
#define CHOPSHOP_X 2081.6187
#define CHOPSHOP_Y -2033.8485
#define CHOPSHOP_Z 13.2042

#define SERVER_DMV_X	1838.3475
#define SERVER_DMV_Y	-1443.8835
#define SERVER_DMV_Z	13.5657


// Forwards
forward bool:IsFactionVehicle(vehicleid, factionid);
forward bool:IsGovFactionVehicle(vehicleid);
forward Float:SP_GetWeaponDamageFromDistance(weaponid, Float:distance);
forward Float: GetAngleToPos(Float: PX, Float: PY, Float: X, Float: Y);


#define CGEN_MEMORY 20000
#include "config/header.pwn"
#include "browser/header.pwn"

#include "player/header.pwn"
#include "tags/header.pwn" // up to date (2024)
#include "visuals/header.pwn"
#include "admin/header.pwn"
#include "attachments/header.pwn"
#include "anims/header.pwn" // up to date (2024)
#include "money/header.pwn" // up to date (2024)
#include "vehicle/header.pwn"
#include "carjack/header.pwn"
#include "faction/header.pwn"
#include "weapons/header.pwn"
#include "drugs/header.pwn"
#include "emmet/header.pwn" // up to date (2024) - rewrite needed later for /buygun
#include "hunger/header.pwn" // up to date (2024)
#include "gym/header.pwn"
#include "customskins/header.pwn"
#include "property/header.pwn"// up to date (2024)
#include "gps/header.pwn" // up to date (2024)
#include "furniture/header.pwn"
#include "passpoints/header.pwn"// up to date (2024)
#include "police/header.pwn"// up to date (2024)
#include "news/header.pwn"// up to date (2024)
#include "boombox/header.pwn"
#include "gates/header.pwn" 
#include "injury/header.pwn"
#include "message/header.pwn" // up to date (2024)
#include "phone/header.pwn" // up to date (2024)
#include "config/time_weather.pwn" // up to date (2024)
#include "config/native.pwn"
#include "money/paycheck.pwn" // up to date (2024)
#include "jobs/header.pwn"
#include "minigame/header.pwn"
#include "anticheat/header.pwn" // up to date (2024) - minor remodularisation needed
#include "helpers/header.pwn"
#include "misc/header.pwn"
#include "gangzones/header.pwn"
#include "spraytag/header.pwn"
#include "paynspray/header.pwn" // up to date (2024)
#include "modshops/header.pwn"
#include "chopshop/header.pwn"
#include "admin/refunds.pwn"
#include "licenses/header.pwn"
//#include "lowrider/header.pwn"

#include "player/player_hooked.pwn"
#include "config/server-native.pwn"
#include "visuals/loadtextdraws.pwn"

//#include "discord/header.pwn"
//#include "event_easter.pwn"
//#include "event_halloween.pwn"
//#include "event_christmas.pwn"

forward OnStartSQL();
public OnStartSQL()
{
	// You can hook this
	return 1;
}

main() {

	MySQL_Init();
	
	CallLocalFunction("OnStartSQL", "");
	CA_Init();

	//Streamer_TickRate( 1000 );
	Streamer_VisibleItems( STREAMER_TYPE_OBJECT, 900 );
	//Streamer_CellSize( 300.0 );
	//Streamer_CellDistance( 450.0 );

	Main_LoadDatabaseSettings();
	Main_LoadServerSettings();
	
	OnLoadTextdraws();

	Models_AddModels ( ); 
	Models_AddSkins ( ) ;
	LoadStaticMaps();

	// Model loading goes first!
	//PlayerSkin_LoadEntities();
	Attachments_LoadCustomModels();

	Fine_LoadLabel() ;
	Vehicle_LoadEntities ();
	SavedFurni_LoadEntities();
	Tune_LoadEntities() ;
	Faction_LoadEntities ();
	SprayTag_LoadEntities( );
	Wounds_LoadEntities ( ) ;
	Emmet_LoadEntities(); // new
	ScrapYard_LoadEntities();
	Gate_LoadEntities();
	Drugs_LoadEntities();
	Jobs_Init() ;
	Advert_Init() ;
	Minigames_LoadEntities();
	RPRF_LoadEntities();
	Respray_LoadEntities();
	Toll_LoadEntities();
	Impound_LoadEntities();
	ActorRobbery_LoadEntities();
	GangZone_LoadEntities();
	Attachments_LoadEntities();
	Boombox_LoadEntities ();
	ChopShop_LoadEntities();
	Fuel_OnScriptInit();

	Realty_LoadEntities();
	Notes_Load();

	//EasterEggs_LoadEntities() ; // Holiday Event: Easter
	//Halloween_LoadEntities(); // Holiday Event: Halloween
	//Christmas_LoadEntities(); // Holiday Event: Christmas

	// load npcs
	//NPC_Init();

	// Deleting empty weapons for database maintenance
	mysql_tquery(mysql, "DELETE FROM player_weapons WHERE weapon_ammo = 0");

	AddPlayerClass(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

	defer ASCII_Print[5000]() ;
	defer UpdateTablist(); // force update nametags to fix color bug, sloppy but for now itll work

	return true ;
}


public OnGameModeExit(){

	mysql_close(mysql);

	return true ;
}

stock HandleTestingProps(playerid) { // Make sure this is disabled on runtime.
	Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] = ADMIN_LVL_DEVELOPER;
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, COLOR_YELLOW, "Welcome to the test server of Singleplayer Roleplay.");
	SendClientMessage(playerid, COLOR_YELLOW, "Use /help and /staffhelp for command lists.");
	SendClientMessage(playerid, COLOR_ERROR, "It is HIGHLY discouraged to do anything other than testing.");
	SendClientMessage(playerid, COLOR_ERROR, "If you impede people from doing their testing tasks, you will be sanctioned.");
	SendClientMessage(playerid, COLOR_ERROR, "If you leak the IP address, you will be permanently banned.");
	SendClientMessage(playerid, -1, " ");
}

CMD:testadmin(playerid, params[]) {
	Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] = 0;
	SendClientMessage(playerid, COLOR_YELLOW, "Temporarily removed your admin.");
	return 1;
}


timer ASCII_Print[5000]() {

	print("  ");
	print("       __                        __                          ___  ");
	print("      /\\ \\__                    /\\ \\__                     /'___\\ ");
	print("  ____\\ \\ ,_\\  _ __    __     __\\ \\ ,_\\   ____        ___ /\\ \\__/ ");
	print(" /',__\\\\ \\ \\/ /\\`'__\\/'__`\\ /'__`\\ \\ \\/  /',__\\      / __`\\ \\ ,__\\");
	print("/\\__, `\\\\ \\ \\_\\ \\ \\//\\  __//\\  __/\\ \\ \\_/\\__, `\\    /\\ \\L\\ \\ \\ \\_/");
	print("\\/\\____/ \\ \\__\\\\ \\_\\\\ \\____\\ \\____\\\\ \\__\\/\\____/    \\ \\____/\\ \\_\\ ");
	print(" \\/___/   \\/__/ \\/_/ \\/____/\\/____/ \\/__/\\/___/      \\/___/  \\/_/ ");
	print("  ");
	print("  ");
	print(" ___                                                __            ");
	print("/\\_ \\                                              /\\ \\__                  ");
	print("\\//\\ \\     ___     ____        ____     __      ___\\ \\ ,_\\   ___     ____  ");
	print("  \\ \\ \\   / __`\\  /',__\\      /',__\\  /'__`\\  /' _ `\\ \\ \\/  / __`\\  /',__\\ ");
	print("   \\_\\ \\_/\\ \\L\\ \\/\\__, `\\    /\\__, `\\/\\ \\L\\.\\_/\\ \\/\\ \\ \\ \\_/\\ \\L\\ \\/\\__, `\\");
	print("   /\\____\\ \\____/\\/\\____/    \\/\\____/\\ \\__/.\\_\\ \\_\\ \\_\\ \\__\\ \\____/\\/\\____/");
	print("   \\/____/\\/___/  \\/___/      \\/___/  \\/__/\\/_/\\/_/\\/_/\\/__/\\/___/  \\/___/ ");
	print("  ");                                                                      
}


// Misc unused shit
DCC_SendAdminPunishmentMessage(const msg[]) print(msg);
DCC_SendAdvertisementMessage(type, const msg[]) {
	printf("%d - %s", type, msg);
}
stock DCC_SendAntiCheatMessage(const title[], const msg[]) {
	printf("%s - %s", title, msg);
}
DCC_SendCharityLogMessage(const msg[]) print(msg);
DCC_SendAdminLogMessage(const msg[]) print(msg);

#pragma unused Attachments_CountBone
#pragma unused ClassBrowser_HideTextDraws
#pragma unused FactionSkin_LoadEntities
#pragma unused Faction_GetHex
#pragma unused Faction_GetName
#pragma unused Faction_SendTypeMessage
#pragma unused GetPlayerPenaltyCount
#pragma unused HasPropertyDuplicateKey
#pragma unused IsGovVehicle
#pragma unused IsPlayerContributor
#pragma unused PlayerClassSelection
#pragma unused Player_ShowSkinMenu
#pragma unused Property_GetSQLID
#pragma unused Property_GetType
#pragma unused SOLS_GetBaseSkinID
#pragma unused SOLS_IsPropertyRenter
#pragma unused illegal_nos_vehicle