
#include "admin/data.pwn"
#include "admin/contributor.pwn"
#include "admin/arecord.pwn"
#include "admin/misc.pwn"
#include "admin/ajail.pwn"
#include "admin/bans.pwn"
#include "admin/movement.pwn"
#include "admin/spectate_gui.pwn"
#include "admin/spectate.pwn"
#include "admin/vehicle.pwn"
#include "admin/vehicle_func.pwn"
#include "admin/jetpack.pwn"
#include "admin/true-rp.pwn"
#include "admin/namechanges.pwn"
#include "admin/reports.pwn"
#include "admin/setstat.pwn"
#include "admin/coc.pwn"
#include "admin/convo.pwn"
#include "admin/banevade.pwn"
#include "admin/public.pwn"
#include "admin/maintenance.pwn"
#include "admin/noclip.pwn"
#include "admin/note.pwn"


CMD:admins(playerid, params[]) {

	new rank_name [ 32 ], rank_color [ 16 ], string[128], count  ;

	SendClientMessage(playerid, 0xb18745FF, "__________________ Online Administrators __________________") ;

	foreach(new targetid: Player) {
		if ( Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] > ADMIN_LVL_NONE && !Account [ targetid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ]) {

			/*if ( Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] >= ADMIN_LVL_DEVELOPER ) {

				continue ;
			}*/

			if( PlayerVar [ targetid ] [ E_PLAYER_ADMIN_HIDDEN ] )
				continue;

			rank_name [ 0 ] = EOS ;
			GetAdminRankName( Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ], rank_name, 32 ) ;
			GetAdminRankColor(Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ], rank_color, 16);

			count ++ ;

			if ( ! PlayerVar [ targetid ] [ E_PLAYER_ADMIN_DUTY ] ) {
				format ( string, sizeof ( string ), "» %s%s{DEDEDE} | %s (ID: %d) | Requests: %d",
				rank_color, rank_name, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid, Account [ targetid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ]  );
				SendClientMessage(playerid, 0xa6a492FF,string );
			
			} else if ( PlayerVar [ targetid ] [ E_PLAYER_ADMIN_DUTY ] ) {
				format ( string, sizeof ( string ), "» %s%s{DEDEDE} | %s (ID: %d) | Requests: %d",
				rank_color, rank_name, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid , Account [ targetid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ] );
				SendClientMessage(playerid, 0x54acd2FF, string);
			}

			else continue ;
		}

		if (  Account [ targetid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] == E_CONTRIBUTOR_DEVELOPER || ( Account [ targetid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] && PlayerVar [ targetid ] [ E_PLAYER_ADMIN_DUTY ]) ) {


			if( PlayerVar [ targetid ] [ E_PLAYER_ADMIN_HIDDEN ] )
				continue;
			
			count ++ ;
			
			rank_name [ 0 ] = EOS ;
			GetContributorRankName ( Account [ targetid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ], rank_name, 32 ) ;

			if (Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ])
			{
				GetAdminRankColor(Account [ targetid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ], rank_color, 16);
				format ( string, sizeof ( string ), "» %s%s{DEDEDE} | %s (ID: %d) | Requests: %d", rank_color, rank_name, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid , Account [ targetid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ] );
			}
			else
			{
				format ( string, sizeof ( string ), "» {5097d9}%s{DEDEDE} | %s (ID: %d) | Requests: %d", rank_name, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], targetid , Account [ targetid ] [ E_PLAYER_ACCOUNT_REPORTS_DONE ] );
			}

			SendClientMessage(playerid, 0xa6a492FF, string);

		}

		else continue ;
	}

	if ( ! count ) {
		SendClientMessage(playerid, COLOR_GRAD0, "None");
	}

	SendClientMessage(playerid, COLOR_GRAD1, "Read the private message warning before messaging admins." ) ;
	SendClientMessage(playerid, COLOR_GRAD1, "To view a list of helpers, use /helpers." ) ;

	return true ;
}

CMD:gunban(playerid, params[]) {

	return cmd_setgunrights(playerid, params);
}

CMD:setgunrights(playerid, params[]) {


	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Only big dick niggas!" ) ;
	}

	new user, status, string [ 256 ] ;

	if ( sscanf ( params, "k<player>i", user, status ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setgunrights [target] [status: 0 (able), 1 (banned)" ) ;
		return true ;
	}

	if ( ! IsPlayerConnected(user)) {
		SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Target isn't connected." ) ;
		return true ;	
	}

	Account [ user ] [ E_PLAYER_ACCOUNT_GUNBAN ] =  status ;

	string [ 0 ] = EOS ;

	mysql_format(mysql, string, 	sizeof ( string ), 	"UPDATE accounts SET account_gunban = %d WHERE account_id = %d",
		Account [ user ] [ E_PLAYER_ACCOUNT_GUNBAN ], Account [ user ] [ E_PLAYER_ACCOUNT_ID ]
	);

	mysql_tquery(mysql, string);

	if ( status ) {

		
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("You've just gun banned (%d) %s.", user, ReturnMixedName(user) ) ) ;
		SendClientMessage(user, COLOR_YELLOW, sprintf("You've just been gun banned by (%d) %s.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME] ) ) ;

		string [ 0 ] = EOS ;

		format ( string, sizeof ( string ), "[GUN-BAN] %s (%d) has just gun banned %s (%d).", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, ReturnMixedName(user), user );
		SendAdminMessage ( string ) ;
	}

	else if ( ! status ) {
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("You've removed (%d) %s's gun ban.", user, ReturnMixedName(user) ) ) ;
		SendClientMessage(user, COLOR_YELLOW, sprintf("Your gun ban has been removed by (%d) %s. You will be watched!", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME] ) ) ;

		string [ 0 ] = EOS ;

		format ( string, sizeof ( string ), "[GUN-BAN] %s (%d) has removed %s (%d)'s gun ban.", Account[playerid][E_PLAYER_ACCOUNT_NAME], playerid, ReturnMixedName(user), user );
		SendAdminMessage ( string ) ;	
	}

	return true ;
}

CMD:getplayernumber(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "/getnumber [number]: gets name of number holder") ;
	}

	if ( ! IsPlayerConnected(targetid) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "Target isn't connected!") ;
	}

	SendClientMessage(playerid, COLOR_BLUE, "Target is CURRENTLY ONLINE:" ) ;

	new query [ 256 ] ;

	format ( query, sizeof ( query ), "Last result fetched: found name %s (%s) linked to number %d.",
		Character [ targetid ] [ E_CHARACTER_NAME ], Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], Character [ targetid ] [ E_CHARACTER_PHONE_NUMBER ] ) ;

	SendClientMessage(playerid, COLOR_YELLOW, query);
	
	return true ;
}

CMD:getnumber(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new input ;

	if ( sscanf ( params, "i", input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "/getnumber [number]: gets name of number holder") ;
	}


	new targetid = INVALID_PLAYER_ID  ;

	foreach(new i: Player) {

		if ( Character [ i ] [ E_CHARACTER_PHONE_NUMBER ] == input ) {

			targetid = i ;
		
			break ;
		}

		else continue ;
	}

	new query [ 256 ] ;

	if ( targetid == INVALID_PLAYER_ID ) {

		SendClientMessage(playerid, COLOR_BLUE, "Target is not online - consulting database..." ) ;

		new name [ MAX_PLAYER_NAME ] ;
		inline Number_OnDataLoad() {
			if(!cache_num_rows()) {
				SendClientMessage(playerid, COLOR_RED, "Database returned no rows - are you sure the input is correct?" ) ;
				return true ;
			}

			for(new i = 0, r = cache_num_rows(); i < r; ++i) {
				cache_get_value_name(i, "player_name", name);

				query [ 0 ] = EOS ;
				format ( query, sizeof ( query ), "Database result %d: found name %s linked to number %d.", i, name, input ) ;
			}
				
		}

		query [ 0 ] = EOS ;
		mysql_format(mysql, query, sizeof(query), "SELECT player_name FROM characters WHERE player_phnumber = %d", input ) ;

		MySQL_TQueryInline(mysql, using inline Number_OnDataLoad, query, "" ) ;
	}

	else if ( targetid != INVALID_PLAYER_ID ) {

		SendClientMessage(playerid, COLOR_BLUE, "Target is CURRENTLY ONLINE:" ) ;

		query [ 0 ] = EOS ;

		format ( query, sizeof ( query ), "Last result fetched: found name %s (%s) linked to number %d.",
			ReturnMixedName(targetid), Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], input ) ;

		SendClientMessage(playerid, COLOR_YELLOW, query);
	}

	return true ;
}

IsAnyAdminOnline() {

	foreach(new playerid: Player) {

		if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] ) {
			return true ;
		}
	}

	return false ;
}

CMD:punishlist(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	SendClientMessage(playerid,-1,"{71EB00}[KICKABLE] {FFFFFF}AFK IN PUBLIC | FOREIGN LANGUAGES IN PUBLIC CHATS | SPAM | REQUESTING ADMIN HELP IN /PM");
	SendClientMessage(playerid,-1,"{EBCF00}[5-15 MIN] {ADADAD}BRAWL RULES | COMING BACK TO DEATH SCENE | ABUSING ANIMS OR STOPANIM | OLYMPIC SWIMMING");
	SendClientMessage(playerid,-1,"{EBCF00}[5-15 MIN] {ADADAD}NON-RP CAR SURF | AFK DURING RP | BUNNYHOPPING | STEALING MARKED GOV VEHICLES");
	SendClientMessage(playerid,-1,"{EBCF00}[5-15 MIN] {ADADAD}ABUSE OF VOIP | FIREARM/DRUG ADVERTISEMENTS | OOC SALES OF FIREARMS/DRUGS");
	SendClientMessage(playerid,-1,"{FF8400}[15-45 MIN] {FFFFFF}NINJA JACKING | NON-RP DRIVING | COP WHORING | GANG WHORING | DRIVER DRIVE BY");
	SendClientMessage(playerid,-1,"{FF8400}[15-45 MIN] {FFFFFF}GUN WHORING | CAR DEATHMATCH | OOC INSULTS | CHICKEN RUNNING | GREENZONE RULES");
	SendClientMessage(playerid,-1,"{FF8400}[15-45 MIN] {FFFFFF}MIXING IC AND OOC | INAPPROPRIATE USAGE OF /DO | MOANING IN /B");
	SendClientMessage(playerid,-1,"{FF4000}[45-120 MIN] {ADADAD}POWERGAMING | METAGAMING | FAILURE TO SHOW FEAR | TERRORISM | SCAM/ROB/TICKET RULES");
	SendClientMessage(playerid,-1,"{F00000}[60-120 MIN] {FFFFFF}DEATHMATCHING/POOR REASON TO KILL | TROLLING | REVENGE KILLING");
	SendClientMessage(playerid,-1,"{F00000}[60-120 MIN] {FFFFFF}QUIT/CRASH TO AVOID DEATH/JAIL/RP | OOC LYING | REFUSING/FAILURE TO RP");
	SendClientMessage(playerid,-1,"{B00000}[3+ DAY BAN] {ADADAD}STAFF DISRESPECT | OOC RACISM | OOC SCAMMING | LYING TO AN ADMIN");
	SendClientMessage(playerid,-1,"{B00000}[7+ DAY BAN] {ADADAD}HACKING (PERM) | BUG ABUSING | CHEATING | RAPE WITHOUT PERMISSION | ADVERTISING");
	SendClientMessage(playerid,-1,"{B000A4}[ACCOUNT] {FFFFFF}CELEBRITY NAMES | UNREALISTIC NAMES | RACIST NAMES");

	return 1;
}

CMD:adminhelp(playerid) {
	return ShowStaffCategoryCommands(playerid);
}

ShowOldStaffCommands(playerid) {

	if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_CONTRIBUTOR ] ) {
		if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR && !IsPlayerHelper(playerid) ) {

			return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
		}
	}

	SendClientMessage(playerid, COLOR_ERROR, "[List of administrator commands]:" ) ;

	if (IsPlayerHelper(playerid))
	{
		SendClientMessage ( playerid, 0xD1B68DFF, "[HELPER] /h(elper)c(hat), /a(ccept)h(elp), /answer, /questions, /checkcars, /respawnplayer");
		SendClientMessage ( playerid, 0xD1B68DFF, "[HELPER] /cleartrucker, /helperduty");
	}

	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_JUNIOR ) {

		SendClientMessage ( playerid, 0xD1B68DFF, "[JUNIOR] /togadmin, /punishlist, /aduty, /reports, /acceptreport (/ar), /denyreport (/dr), /acinvite, /acuninvite");
		SendClientMessage ( playerid, 0xD1B68DFF, "[JUNIOR] /a(chat), /fw, /up, /dn, /setint, /setvw, /ajail, /unajail, /offlineajail, /removemask, /omaskid" ) ;
		SendClientMessage ( playerid, 0xD1B68DFF, "[JUNIOR] /goto, /gethere, /adminrecord, /kick, /carrespawn, /gotocar, /getcar, /getcharid, /getc, /getma" ) ;
		SendClientMessage ( playerid, 0xD1B68DFF, "[JUNIOR] /boomboxremove, /slap, /freeze, /unfreeze, /toggleooc, /getnumber, /whonear, /getcoordinates, /findrentals" ) ;
		SendClientMessage ( playerid, 0xD1B68DFF, "[JUNIOR] /spec(tate), /disarm, /confiscate, /frisk, /maskid, /respawnallcars, /respawnrentals, /resetemail" ) ;
		SendClientMessage ( playerid, 0xD1B68DFF, "[JUNIOR] /processn(ame)c(hange), /namechanges, /factiongoto, /ban, /unban, /acarfuel, /carfix, /clearinjuries" ) ;
	}

	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_GENERAL ) {

		SendClientMessage ( playerid, 0xDBB275FF, "[GENERAL] /offlineban, /banip, /unbanip, /a(dmin)f(action)join, /setskin, /jetpack, /carflip, /damages, /deletecar" ) ;
		SendClientMessage ( playerid, 0xDBB275FF, "[GENERAL] /carslap, /carhp, /propertycheck, /propertygoto, /propertyint(erior)list, /carsavesiren, /caradminpark" ) ;
		SendClientMessage ( playerid, 0xDBB275FF, "[GENERAL] /mark[1-3], /gotomark[1-3], /gotoxyz, /s(pray)t(ag)goto");
		SendClientMessage ( playerid, 0xDBB275FF, "[GENERAL] /ecc, /entercar, /geoip, /settime, /setweather, /s(pray)t(ag)clearcd, /engine, /tp, /aooc" ) ;	
		SendClientMessage ( playerid, 0xDBB275FF, "[GENERAL] /allspawns /setarmor /sethealth, /caradmincolor, /checkstats, /checkproperties, /checkguns, /makeooc" ) ;	
		SendClientMessage ( playerid, 0xDBB275FF, "[GENERAL] /adminad, /adminbreaking, /admin911, /wardrobehelp" ) ;	
	}

	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_SENIOR ) {
		SendClientMessage ( playerid, 0xD5A04EFF, "[SENIOR] /propertycreate, /propertymove, /propertydelete, /propertyprice, /propertytype, /propertyauction" ) ;
		SendClientMessage ( playerid, 0xD5A04EFF, "[SENIOR] /propertybuytype, /propertybuypoint, /propertyint(erior), /gatecreate, /gateradius, /gateopen, /viewcars" ) ;
		SendClientMessage ( playerid, 0xD5A04EFF, "[SENIOR] /gatetoll, /gategoto, /gatemove, /gatetexture, /gateworld, /gateint, /gatetype, /poolcreate, /poolendgame" ) ;
		SendClientMessage ( playerid, 0xD5A04EFF, "[SENIOR] /poolcolor,  /poolmove, /pooldelete, /pokercreate, /pokernear, /pokerdelete, /pokerendgame, /passpointcreate");
		SendClientMessage ( playerid, 0xD5A04EFF, "[SENIOR] /passpointdelete, /passpointlink, /passpointmove, /passpointgoto, /passpointname, /passpointtype");
		SendClientMessage ( playerid, 0xD5A04EFF, "[SENIOR] /passpointcolor, /passpointfaction, /addattachpoint, /attachpointdelete, /attachpointlink");
	}


	if ( GetPlayerAdminLevel ( playerid ) >= ADMIN_LVL_ADVANCED ) {

		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] /f(action)name, /f(action)create,  /f(action)hex, /f(action)skinadd, /f(action)extra, /f(action)visible" ) ;
		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] /s(pray)t(ag)create, /s(pray)t(ag)delete, /addattachpoint, /attachpointdelete, /attachpointlink, /createatm");
		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] /gangzoneassign, /gangzonecontest, /gangzoneid, /carcreate, /carowner, /cartype, /carjob, /chopshopfaction");
		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] /createfuelpump, /linkpumptostation, /unlinkpump, /viewlinkedpumps, /gotopump, /movepump, /deletepump, /unlinkedpumps");
		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] /createfuelstation, /gotostation, /movestation, /auctionstation, /deletestation, /stationinfo, /setmotd");
		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] NEW: /noclip, /togglenoclip [player] (sets noclip on/off for another player), /(set)customanim, /setstat");
		SendClientMessage ( playerid, 0xD08615FF, "[ADVANCED] NEW: /toggleac, /checkpausedac");
	}

	if ( GetPlayerAdminLevel ( playerid ) > ADMIN_LVL_ADVANCED ) {

		SendClientMessage ( playerid, 0x965B00FF, "[MANAGER] /man, /makeadmin /makehelper, /givemoney, /takemoney, /adminhex, /helperhex" ) ;
		SendClientMessage ( playerid, 0x965B00FF, "[MANAGER] /addplayerskin, /spoofbuy, /spoofpool, /spoofgun, /spoofmats, /spoofdrugstation, /spoofammo");
		SendClientMessage ( playerid, 0x965B00FF, "[MANAGER] /drugsetparam, /drugsetstage /drugsetticks, /drugforcefinish, /drugsuppliergoto, /spoofattach" ) ;
		SendClientMessage ( playerid, 0x965B00FF, "[MANAGER] /spoofprop, /gotostore, /gotowholesaler, /poolspoof, /forcechopshop, /tempclearchopshopcd" ) ;
		SendClientMessage ( playerid, 0x965B00FF, "[MANAGER] /setintrosong, /togd(onator)c(hat), /setgunrights ((gun ban)), /makecontributor" ) ;
		SendClientMessage ( playerid, 0x965B00FF, "[MANAGER] /emmetcreate, /emmetowner, /emmetassign, /emmetid, /emmetgoto, /emmetmove, /emmetskin, /emmetname " ) ;
	}	// /movepdarmory,/moveemsarmory, /movedeaarmory
	
	return true ;
}


CMD:viewcars(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new modelid ;

	if ( sscanf ( params, "i", modelid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/viewcars [modelid]");
	}

	for ( new i, j = MAX_VEHICLES; i < j ; i ++ ) {

		if ( IsValidVehicle(i)){
			if ( GetVehicleModel(i) == modelid ) {

				SendClientMessage(playerid, -1, sprintf("Model ID %d; vehicle ID %d", modelid, i ) ) ;
			}
		}
	}

	new string [ 150 ] ;
	format ( string, sizeof ( string ), "checked all spawned cars with model %d.", modelid);
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	return true ;
}

CMD:blockaccounts(playerid, params[])
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new seconds;

	if ( sscanf ( params, "i", seconds ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/blockaccounts [seconds] (disables new accounts for x seconds)");

	}

	if (seconds == 0) Server[E_SERVER_ACCS_DISABLED_UNTIL] = 0;
	else if (seconds < 0 || seconds > 3600) return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Seconds can't be less than 0 or more than 3600.");

	Server[E_SERVER_ACCS_DISABLED_UNTIL] = gettime() + seconds;
	SendAdminMessage(sprintf("[!!!] [AdmWarn] (%d) %s has disabled new accounts for %d seconds.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], seconds )) ;

	return true;
}

CMD:setmotd(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new slot, text [ 96 ] ;

	if ( sscanf ( params, "is[96]", slot, text ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setmotd [1, 2, 3] [text]");

	}

	switch ( slot ) {

		case 1 : format (Server [ E_SERVER_MOTD_STRING_1 ], 96, "%s", text ) ;
		case 2 : format (Server [ E_SERVER_MOTD_STRING_2 ], 96, "%s", text ) ;
		case 3 : format (Server [ E_SERVER_MOTD_STRING_3 ], 96, "%s", text ) ; 
		default : {

			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Slot can't be lower than 1 or higher than 3.");
		}
	}

	format ( Server [ E_SERVER_MOTD_EDITOR ], MAX_PLAYER_NAME, "%s", Account [ playerid ] [ E_PLAYER_ACCOUNT_NAME ]) ;
	Server [ E_SERVER_MOTD_EDIT_TIME ] = gettime();

	new query [ 512 ] ;
	mysql_format(mysql, query, sizeof ( query ), "UPDATE server SET server_slots_motd_1 = '%e', server_slots_motd_2 = '%e', server_slots_motd_3 = '%e', server_motd_editor = '%e', server_motd_edit_time = %d", 
		Server [ E_SERVER_MOTD_STRING_1 ], Server [ E_SERVER_MOTD_STRING_2 ], Server [ E_SERVER_MOTD_STRING_3 ], 
		Server [ E_SERVER_MOTD_EDITOR ], Server [ E_SERVER_MOTD_EDIT_TIME ]
	) ;

	mysql_tquery(mysql, query);

	return cmd_viewmotd(playerid);
}	

CMD:geoip ( playerid, params [] ) {

	
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "/geoip [target]") ;
	}

	if (! IsPlayerConnected ( targetid ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This player doesn't need to be connected.") ;
	}

	if ( GetPlayerAdminLevel ( playerid ) < GetPlayerAdminLevel(targetid) ) {

		return SendClientMessage(playerid, COLOR_ERROR, "No, you don't.");
	}


	new country [ 32 ], region [ 32 ], city [ 32 ], isp [ 32 ], timez [ 32 ], zipcode [ 32 ] ;

	GetPlayerCountry(targetid, country ) ;
	GetPlayerRegion(targetid, region ) ;
	GetPlayerCity(targetid, city ) ;
	GetPlayerISP(targetid, isp ) ;
	GetPlayerZipcode(targetid, zipcode ) ;
	GetPlayerTimezone(targetid, timez ) ; 

	new string [ 150 ] ;

	format ( string, sizeof ( string ), "(%d) %s's GEODATA (IP: %s) [TIMEZONE: %s]", targetid, ReturnMixedName(targetid), ReturnIP ( targetid ), timez );
	SendClientMessage(playerid, COLOR_YELLOW, string ) ;

	format ( string, sizeof ( string ), "Country: %s - Region: %s - City: %s - ISP: %s - Zipcode: %s", country, region, city, isp, zipcode );
	SendClientMessage(playerid, COLOR_YELLOW, string ) ;

	format ( string, sizeof ( string ), "has checked %s's geo data.", ReturnMixedName(targetid) ) ;
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	return true ;
}

CMD:setarmor(playerid, params[]) 
{
	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

	new targetid, armor;

	if (sscanf ( params, "k<player>i", targetid, armor))
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setarmor [player] [armor]");

	if ( ! IsPlayerConnected ( targetid ) )
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target isn't connected.");

	if (armor < 0 || armor > 100)
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Armor must be between 0 - 100.");

	SetCharacterArmour(targetid, armor);

	new string [ 128 ] ;
	format ( string, sizeof ( string ), "set %s's armor to %d.", ReturnMixedName(targetid), armor );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	return true ;
}

CMD:setkevlar(playerid, params[]) return cmd_setarmor(playerid, params);
CMD:setkev(playerid, params[]) return cmd_setarmor(playerid, params);
CMD:setarmour(playerid, params[]) return cmd_setarmor(playerid, params);
CMD:seta(playerid, params[]) return cmd_setarmor(playerid, params);
CMD:setap(playerid, params[]) return cmd_setarmor(playerid, params);

CMD:sethealth(playerid, params[]) 
{
	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

	new targetid, health;

	if (sscanf ( params, "k<player>i", targetid, health))
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/sethealth [player] [health]");

	if ( ! IsPlayerConnected ( targetid ) )
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target isn't connected.");

	if (health < 0 || health > 100)
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Heath must be between 0 - 100.");

	SetCharacterHealth(targetid, health);

	new string [ 128 ] ;

	format ( string, sizeof ( string ), "set %s's health to %d.",ReturnMixedName(targetid), health );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	return true ;
}

CMD:sethp(playerid, params[]) return cmd_sethealth(playerid, params);
CMD:seth(playerid, params[]) return cmd_sethealth(playerid, params);

CMD:setduty(playerid, params[]) 
{
	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

	new targetid, duty;

	if (sscanf ( params, "k<player>i", targetid, duty))
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setduty [player] [duty status]");

	if ( ! IsPlayerConnected ( targetid ) )
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target isn't connected.");

	if (duty != 0 && duty != 1)
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Duty status must be 0 [off] or 1 [on]");

	if (!IsPlayerInDutyFaction(targetid))
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This player isn't in a faction that can go on or off duty.");

	new string [ 128 ] ;
	format ( string, sizeof ( string ), "set %s (%d)'s duty status to %d.", ReturnMixedName(targetid), targetid, duty );
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	if (duty == 0) PlayerVar [ targetid ] [ E_PLAYER_FACTION_DUTY ] = false;
	else if (duty == 1) PlayerVar [ targetid ] [ E_PLAYER_FACTION_DUTY ] = true;

	CallLocalFunction("SOLS_OnDutyStateChange", "d", targetid);

	return true ;
}


CMD:akill(playerid, params[])
{
	if (GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR)
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;

	new targetid, reason[64];

	if (sscanf ( params, "k<player>s[64]", targetid, reason))
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/akill [player] [death reason]");

	format(PlayerVar [ targetid ] [ E_PLAYER_INJURY_REASON ], 64, "%s", reason);

	TogglePlayerControllable(targetid, false);
	OnPlayerInjuryMode(targetid, playerid, DEATHTYPE_CUSTOM, 0) ;
	SetCharacterHealth(targetid, 25.0);
	return true;
}


CMD:setskin(playerid, params[]) {


	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid, skinid ;

	if ( sscanf ( params, "k<player>i", targetid, skinid ) ) {

		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setskin [targetid] [skinid]");
	}

	if ( ! IsPlayerConnected ( targetid ) ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "Target isn't connected.");
	}

	SetPlayerSkinEx ( targetid, skinid ) ;

	new string [ 128 ] ;

	format ( string, sizeof ( string ), "Changed your skin to ID %d!", skinid ) ;
	SendClientMessage(targetid, COLOR_INFO, string ) ;

	format ( string, sizeof ( string ), "You've changed (%d) %s's skin to %d.", targetid, ReturnMixedName(targetid), skinid )  ;
	SendClientMessage(playerid, COLOR_INFO, string );

	format ( string, sizeof ( string ), "changed %s's skin to %d.", targetid, ReturnMixedName(targetid), skinid )  ;
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);

	return true ;
}

CMD:omaskid(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new maskid ;

	if ( sscanf ( params, "i", maskid ) ) {

		return SendClientMessage(playerid, -1, "/omaskid [maskid]" ) ;
	}

	new string [ 96 ], returned_name [ MAX_PLAYER_NAME ] ;

	inline FindOfflineMaskID() {
		if(cache_num_rows()) {
			cache_get_value_name(0, "player_name", returned_name);
			format ( string, sizeof ( string ), "Mask ID %d is linked to \"%s\" (/getma)", maskid, returned_name ) ;

			return SendClientMessage ( playerid, 0xD19932FF, string ) ; 
		} else {
			format (string, sizeof ( string ), "The mask ID \"%d\" could not be found.", maskid ) ;
			return SendServerMessage ( playerid, COLOR_RED, "Error", "DEDEDE", string ) ;
		}

	}

	mysql_format ( mysql, string, sizeof ( string ), "SELECT player_name FROM characters WHERE player_maskid = %d", maskid ) ;
	MySQL_TQueryInline(mysql, using inline FindOfflineMaskID, string, "");

	format ( string, sizeof ( string ), "offline checked mask ID %d.", maskid) ;
	AddLogEntry(playerid, LOG_TYPE_ADMIN, string);


	return true ;
}


CMD:charity ( playerid, params [] ) {

	new amount, reason [ 64 ], string [ 256 ] ;

	if ( sscanf ( params, "is[64]", amount, reason ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "/charity [amount] [reason]");
	}

	if ( amount < 0 ) {

		format ( string, sizeof ( string ), "[AdminWarn]: (%d) %s just tried to spawn money by /charity'ing negative values! (amount: %d)", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], amount );
		SendAdminMessage ( string ) ;

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Nice try. This action has been logged.");
	}

	if ( Character [ playerid ] [ E_CHARACTER_CASH ] < amount ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have that much money in your hand!");
	}

	if ( ! strlen ( reason ) || strlen ( reason ) > 64 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Your reason can't be longer than 64 characters, or empty.");
	}

	inline CharityConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, listitem, inputtext

		if ( ! response ) {

	    	return false ;
		}

		if ( response ) {

			format ( string, sizeof ( string ), "[CHARITY] (%d) %s has just charitied $%s. Reason: %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], IntegerWithDelimiter ( amount ), reason );
			SendClientMessage(playerid, COLOR_YELLOW, string ) ;
			
			format ( string, sizeof ( string ), "[CHARITY] (%d) %s has just charitied $%s. Reason: %s", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], IntegerWithDelimiter ( amount ), reason );
			SendAdminMessage ( string ) ;

			AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Charitied $%s for %s", IntegerWithDelimiter(amount), reason));
			DCC_SendCharityLogMessage(string);
			
			TakePlayerCash ( playerid, amount ) ;

			return true ;
		}
	}

	new confirmstring [ 1024 ] ;

	format ( confirmstring, sizeof ( confirmstring ), 

		"{C23030}READ THIS BEFORE PRESSING CONTINUE.{DEDEDE}\n\n\
		You're about to charity {C23030}%s{DEDEDE} to the server.\n\n\
		{C23030}THERE IS NO WAY TO GET THIS MONEY BACK.{DEDEDE}\n\n\
		Only press continue if you're certain."

	, IntegerWithDelimiter ( amount )  ) ;

	Dialog_ShowCallback ( playerid, using inline CharityConfirm, DIALOG_STYLE_MSGBOX, "{C23030}ANTI DUMBASS WARNING{DEDEDE}", confirmstring, "{C23030}Continue", "No way" );

	return true ;
}


CMD:maskid(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {

		return SendClientMessage(playerid, -1, "/maskid [playerid]" ) ;
	}

	if ( ! IsPlayerConnected( targetid ) ) {

		return SendClientMessage(playerid, -1, "Target isn't connected." ) ;
	}

	new string [ 96 ] ;

	format ( string, sizeof ( string ), "(%d) %s's mask ID is %d.", targetid, Account [ targetid ] [ E_PLAYER_ACCOUNT_NAME ], GetPlayerMaskID(targetid ) ) ;
	SendClientMessage(playerid, COLOR_YELLOW, string);

	AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Checked %s's mask ID", ReturnMixedName(targetid)));

	return true ;
}

#warning Go through all admin msgs, everything logged in AddLogEntry doesn't have to be broadcasted.

CMD:whonear(playerid, params[]) {
 	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

   	const Float:DEFAULT_RANGE = 20.0; //THIS IS THE RANGE IF THE USER TYPES "/WHONEAR" ON IT'S OWN

    new count, Float:range;
    if (sscanf(params, "f", range) == 0) count = DisplayPlayersInRange(playerid, range);
    else count = DisplayPlayersInRange(playerid, DEFAULT_RANGE);
	if (count == 0) SendClientMessage(playerid, 0xFFFFFFFF, "None");
    return 1;
}

CMD:makeooc(playerid, params[]){

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new targetid ;

	if ( sscanf ( params, "k<player>", targetid ) ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/makeooc [targetid]");
	}

	if ( ! IsPlayerConnected( targetid ) ) {
		return SendClientMessage(playerid, COLOR_ERROR, "Your target isn't connected." ) ;
	}

	if(targetid == playerid) {
		return SendClientMessage(playerid, COLOR_ERROR, "You cannot set yourself to OOC. Use /adminduty to get a tag above your name.");
	}

	if ( !PlayerVar [ targetid ] [ E_PLAYER_IS_OOC ] ) {

		PlayerVar [ targetid ] [ E_PLAYER_IS_OOC ] = true;

		if(PlayerVar [ targetid ] [ E_PLAYER_INJUREDMODE ] ||  PlayerVar [ targetid ] [ E_PLAYER_IS_BEANBAGGED ] || PlayerVar [ targetid ] [ E_PLAYER_IS_TAZED ]||PlayerVar [ targetid ] [ E_PLAYER_IS_TACKLED ]) {
			Injury_RemoveData_Player(targetid);
		}

		SendClientMessage(targetid, COLOR_YELLOW, sprintf("Administrator %s has set you to Out-Of-Character.", Account[playerid][E_PLAYER_ACCOUNT_NAME]));
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("You have set %s to OOC.", ReturnMixedName(targetid)));

		new string[128];
		format(string, sizeof(string), "[!!!] [AdmWarn] (%d) %s has made (%d) %s OOC.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid));

		SendAdminMessage(string);

	} else if (PlayerVar [ targetid ] [ E_PLAYER_IS_OOC ]) {

		PlayerVar [ targetid ] [ E_PLAYER_IS_OOC ] = false;

		SendClientMessage(targetid, COLOR_YELLOW, sprintf("Administrator %s has set you to In-Character.", Account[playerid][E_PLAYER_ACCOUNT_NAME]));
		SendClientMessage(playerid, COLOR_YELLOW, sprintf("You have set %s to IC.", ReturnMixedName(targetid)));

		new string[128];
		format(string, sizeof(string), "[!!!] [AdmWarn] (%d) %s has made (%d) %s IC.", playerid, Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid));

		SendAdminMessage(string);

    }

	return true;

}


stock DisplayPlayersInRange(playerid, Float:range)//returns the number of results found, 0 if no results
{
    const PID = 0;
	const DIST = 1;
    new
        msg[110],
		Float:PlayerDist[MAX_PLAYERS][2],
		count = 0;
	format(msg, sizeof(msg), "Players Found Within Range of %.1f:", range);
    SendClientMessage(playerid, 0xFFFFFFFF, msg);
    foreach(new pid: Player)
    {
        if (IsPlayerConnected(pid))
        {
            new
				Float:x, Float:y, Float:z, Float:dist;
			GetPlayerPos(pid, x, y, z);
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if (dist <= range)
			{
			    PlayerDist[count][PID] = pid;
			    PlayerDist[count][DIST] = dist;
			    count++;
			}
		}
    }
    quickSort(PlayerDist, 0, count-1);
    for (new i = 0; i < count; i++)
    {
        new name[MAX_PLAYER_NAME+1];
		GetPlayerName(floatround(PlayerDist[i][PID], floatround_ceil), name, sizeof(name));
	    format(msg, sizeof(msg), "[ID %.0f] [%s] [DIST %.1f]", PlayerDist[i][PID], name, PlayerDist[i][DIST]);
	    SendClientMessage(playerid, 0xFFFFFFFF, msg);
    }
    return count;
}

stock quickSort(Float:array[][], left, right)//sorts a 2D array, sorts by arr[X][1] NOT arr[X][0]
{
    new
        tempLeft = left,
        tempRight = right,
        Float:pivot = array[(left + right) / 2][1],
        Float:tempVar1, Float:tempVar2;
    while(tempLeft <= tempRight)
    {
        while(array[tempLeft][1] < pivot) tempLeft++;
        while(array[tempRight][1] > pivot) tempRight--;

        if(tempLeft <= tempRight)
        {
            tempVar1 = array[tempLeft][0];
            tempVar2 = array[tempLeft][1];
			array[tempLeft][0] = array[tempRight][0];
			array[tempLeft][1] = array[tempRight][1];
		 	array[tempRight][0] = tempVar1;
		 	array[tempRight][1] = tempVar2;
            tempLeft++, tempRight--;
        }
    }
    if(left < tempRight) quickSort(array, left, tempRight);
    if(tempLeft < right) quickSort(array, tempLeft, right);
}

CMD:ryhes(playerid, params[]) {

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new index ;

	sscanf ( params, "I(0)", index ) ;

	switch( index ) {
		case 1: {

			SOLS_SetPosWithFade(playerid, 1645.9507,-1645.1332,87.3750, "Ryhes Overview 1");
			SetPlayerFacingAngle(playerid, 133.5789);
		}

		case 2:{

			SOLS_SetPosWithFade(playerid, 1646.3711,-1629.0222,87.375, "Ryhes Overview 2");
			SetPlayerFacingAngle(playerid, 47.2594);
		}

		case 3:{

			SOLS_SetPosWithFade(playerid, 1662.5876,-1628.6708,87.3321, "Ryhes Overview 3");
			SetPlayerFacingAngle(playerid, 315.138);
		}

		default: {

			SOLS_SetPosWithFade(playerid, 1662.5555,-1644.9266,87.3750, "Ryhes Overview");
			SetPlayerFacingAngle(playerid, 225.6998);
		}
	}

	AddLogEntry(playerid, LOG_TYPE_ADMIN, "Teleported to Ryhes chill spot");

	return true ;
}

CMD:rules(playerid) {

	SendClientMessage(playerid, COLOR_SERVER, "[Frequently Misused Rules]");
	SendClientMessage(playerid, COLOR_BLUE, "This is a fraction of commonly misused rules. For a full list visit {FFD600}forum.singleplayer-roleplay.com");
	SendClientMessage(playerid, COLOR_GRAD1, "You {F14824}CAN NOT{DEDEDE} use spray-cans or firearms (inc. katanas/chainsaws) in brawls. Car ramming is also {F14824}NOT ALLOWED.") ;
	SendClientMessage(playerid, COLOR_GRAD0, "After dying you {F14824}CAN NOT{DEDEDE} go back to your death location for 30 minutes and forget EVERYTHING leading up to the killing.") ;
	SendClientMessage(playerid, COLOR_GRAD1, "Bunnyhopping is {F14824}discouraged{DEDEDE}. Bunnyhopping during a chase or RP scene is {F14824}NOT allowed");
	SendClientMessage(playerid, COLOR_GRAD0, "You are {F14824}NOT allowed{DEDEDE} to abuse/exploit/glitch animations AND /stopanim to get ANY advantage in ANY situation!");

	return true ;
}

CMD:resetemail(playerid, params[]){

	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new target ;

	if ( sscanf ( params, "k<player>", target ) ) {

		return SendServerMessage( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/resetemail [id] - forces player to change their email.") ;
	}

	if (!IsPlayerConnected(target))
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This ID isn't connected.") ;

	SendServerMessage( playerid, COLOR_SECURITY, "Security", "A3A3A3",  sprintf("You have forced (%d) %s to change their email.", target, ReturnMixedName(target))) ;
	SendServerMessage( target, COLOR_SECURITY, "Security", "A3A3A3",  sprintf("Admin %s has forced you to change your email. Please make sure it's correct before submitting.", Account[playerid][E_PLAYER_ACCOUNT_NAME])) ;

	SendAdminMessage(sprintf("[!!!][AdmWarn] Admin %s has forced (%d) %s to change their email.", Account[playerid][E_PLAYER_ACCOUNT_NAME], target, ReturnMixedName(target)));

	GetPlayerEmail(target);

	return true;
}
