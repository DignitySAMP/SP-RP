


ShowVehicleCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Vehicle Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]: {B2FFCD}/mycars, /carfind, /engine, /carlock, /carlights, /carwindow");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]: {B2FFCD}/cartrunk, /carhood, /carcheck, /setstation, /seatbelt");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]: {B2FFCD}/carspawn, /cardespawn, /cartransfer, /carsell, /carattach");
	SendClientMessage(playerid, 0xF87070FF, "[STORAGE]: {FDBCBC}/cartrunkstoregun (/ctsgun), /cartrunktakegun (/cttgun)");
	SendClientMessage(playerid, 0xF87070FF, "[STORAGE]: {FDBCBC}/cartrunkstoredrug (/ctsdrug), /cartrunktakedrug (/cttdrug)");
	SendClientMessage(playerid, 0xF87070FF, "[STORAGE]: {FDBCBC}/cartrunkcheck (/ctcheck, /cartrunkshow), /carscrap, /cartow, /carcolor");
	SendClientMessage(playerid, 0xFFCC68FF, "[MISC]: {FFE1A8}/removemods, /setaw, /vehiclename, /carblink, /cardoor [open/close]");

	return true ;
}


ShowPropertyCommands(playerid) {
		
	SendClientMessage(playerid, 0x297183FF, "[ ___________ Property Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]: {B2FFCD}/myproperties, /propertybuy, /propertysell, /propertylock, /propertyfind");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]: {B2FFCD}/propertytransfer, /propertyscrap, /nosound, /furnihelp, /propertycollect");
	SendClientMessage(playerid, 0xFFCC68FF, "[RENTING]: {FFE1A8}/(un)rentroom, /propertyrent, /propertyinvite, /propertyevict");
	SendClientMessage(playerid, 0xF87070FF, "[STORAGE]: {FDBCBC}/propstorage, /propstoregun, /proptakegun, /propstoredrug, /proptakedrug");
	SendClientMessage(playerid, 0x77BBFAFF, "[COMMUNICATION]: {BBDEFF}/doorknock, /doorbell, /doorshout, /doorme, /doordo");
	SendClientMessage(playerid, 0x77BBFAFF, "[MISC/NEW]: {DEDEDE}/propertyad, /propertyname, /propertynamecolor, /propertywardrobe");
	return true;
}

ShowGunCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Gun Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]: {B2FFCD}/passgun, /passammo, /seta(rmed)w(eapon)");
	ZMsg_SendClientMessage(playerid, 0x297183FF, "If you want to store / retrieve a gun, see /help property or /help vehicle.");

	return true;
}

ShowJobCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Job Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[DOCKWORKER]:{B2FFCD} /cargojob, /cargostop, /cargocollect, /cargostore") ;
	SendClientMessage(playerid, 0xF87070FF, "[TRUCKER]:{FDBCBC} /transport, /crate [pickup / putdown / list / reset]") ;
	SendClientMessage(playerid, 0xFFCC68FF, "[GARBAGEMAN]:{FFE1A8} Go to the trash depot (/gps), enter a truck and type /garbagejob!") ;

	return true ;
}

ShowDrugCommands(playerid){

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Drug Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[STORAGE]: {B2FFCD}/mydrugs, /drugsupplies, /drugcontainers (/drugpackages)" ) ;
	SendClientMessage(playerid, 0xF87070FF, "[PRODUCTION]: {FDBCBC}/drugsnear, /buysupplies, /drugsetup, /drugproduce (/drugwater, /drugcook), /drugcollect" ) ;
	SendClientMessage(playerid, 0xFFCC68FF, "[USAGE]: {FFE1A8}/druguse, /drugpass, /blunt, /stopdrugeffect [will not refund], /drugsplit" ) ;

	return true;
}

ShowVoiceCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Voiceline Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "{B2FFCD}/voicelines - Shows all possible voicelines in a list");
	SendClientMessage(playerid, 0xF87070FF, "{FDBCBC}/myvoices - A list of your saved voicelines");
	SendClientMessage(playerid, 0xFFCC68FF, "{FFE1A8}/vl - Play a voiceline from your saved voicelines");

	return true ;
}

ShowPhoneCommands(playerid) {
	SendClientMessage(playerid, 0x297183FF, "[ ___________ Phone Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "[GENERAL]:{B2FFCD} /ph(one), /pc, /ph(one)anim");
	SendClientMessage(playerid, 0xF87070FF, "[TEXTING]:{FDBCBC} /inbox, /sms");
	SendClientMessage(playerid, 0xFFCC68FF, "[CALLING]:{FFE1A8} /call, /h(angup), /pickup");

	return true;
}

ShowFurniCommands(playerid) {


	SendClientMessage(playerid, 0x5FB9D1FF, "[ ___________ Furniture Commands  ___________ ]");
	SendClientMessage(playerid, 0x58DD85FF, "{B2FFCD}/furnimode - use this at your property exit point");
	SendClientMessage(playerid, 0xF87070FF, "{FDBCBC}/furni - to buy new furniture, for a price");
	SendClientMessage(playerid, 0xFFCC68FF, "{FFE1A8}/furnilist - shows a list of all furniture spawned in the property");
	SendClientMessage(playerid, 0xFFCC68FF, "{FFE1A8}/furniedit - lets you select furniture to edit");
	SendClientMessage(playerid, 0x77BBFAFF, "{BBDEFF}/furniwipe - removes and refunds all furni");
	SendClientMessage(playerid, 0x58DD85FF, "{B2FFCD}/intfurni - lets you change interior to blank interior");
	SendClientMessage(playerid, 0x58DD85FF, "{B2FFCD}/furniperm - gives another player furniture permissions");

	return true ;
}


ShowSpraytagCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Spraytag Commands  ___________ ]");
	SendClientMessage(playerid, COLOR_GRAD0, "{B2FFCD}/s(pray)t(ag)choose - pick a static and/or dynamic tag");
	SendClientMessage(playerid, COLOR_GRAD1, "{FDBCBC}/s(pray)t(ag)info - shows information of the spraytag");
	SendClientMessage(playerid, COLOR_GRAD0, "{FFE1A8}/s(pray)t(ag)wipe - lets you wipe the spraytag (LSPD only)");

	return true ;
}

ShowGateCommands(playerid){


	SendClientMessage(playerid, 0x297183FF, "[ ___________ Gate Commands  ___________ ]");
	SendClientMessage(playerid, COLOR_GRAD0, "{B2FFCD}/gate - opens / closes a gate.");
	/*if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_STAFFLEVEL ] > ADMIN_LVL_NONE ) {

		SendClientMessage(playerid, COLOR_YELLOW, "When using admin commands on gates, use the NORMAL ID. Not the SQL/Database ID!");
		SendClientMessage(playerid, COLOR_BLUE, "[ADMIN]{A3A3A3}/gatecreate, /gateradius, /gateopen, /gatemove, /gatetexture");
		SendClientMessage(playerid, COLOR_BLUE, "[ADMIN]{DEDEDE}/gateworld, /gateint, /gatetype, /gatedelete, /gatespeed");
	}*/
	
	return true ;
}

ShowAnimCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ________________________ Available Animations ________________________ ]") ;

	SendClientMessage(playerid, 0xF1D55EFF, "» Actions {FFFFFF}| /time - /jog - /handsup - /crossarms - /spray - /fucku - /wank - /throw - /lean - /gsign") ;
	SendClientMessage(playerid, 0xF1D55EFF, "» Actions {FFFFFF}| /slapass - /wave - /wash - /ganghands - /guardstance - /patdown - /cmon - /jump - /bomb") ;
	SendClientMessage(playerid, 0xF1D55EFF, "» Actions {FFFFFF}| /goggles - /slide - /balcony - /undercar - /flagdrop - /liftup - /casino - /swipe - /press ") ;
	SendClientMessage(playerid, 0xF1D55EFF, "» Actions {FFFFFF}| /cover - /look - /squat - /plunger - /carry - /hitchhike - /deal - /gkick - /walk - /switchseat") ;
	SendClientMessage(playerid, 0xF1D55EFF, "» Actions {FFFFFF}| /camcrouch - /carryidle - /taichi - /skate - /liftdown - /jogging") ;
	SendClientMessage(playerid, 0x729767FF, "» Express {FFFFFF}| /kiss - /eat - /smoke - /drink - /laugh - /cry - /tired - /facepalm - /angry - /dancing - /drunk") ;	
	SendClientMessage(playerid, 0xEF6060FF, "» Injury {FFFFFF}| /injured - /fall - /crack - /ko - /gethit - /fight - /cpr - /getup - /hurt") ;
	SendClientMessage(playerid, 0xA0765AFF, "» Weapons {FFFFFF}| /aim - /bat - /batidle - /knifehold - /pointgun - /pistolwhip - /riflehold - /knife - /point") ;
	SendClientMessage(playerid, 0xA0765AFF, "» Weapons {FFFFFF}| /reloadanim - /bikepunch - /gunhold") ;
	SendClientMessage(playerid, 0xACA179FF, "» Comfort {FFFFFF}| /sit - /lay - /sleep - /foodsit - /office - /blowjob") ;
	SendClientMessage(playerid, 0x81AE99FF, "» Ambient {FFFFFF}| /dance - /gfunk - /playidle - /copambient - /clothes - /recruit - /bop - /handstand - /dj") ;
	SendClientMessage(playerid, 0x81AE99FF, "» Ambient {FFFFFF}| /bar - /barber - /workout - /chat - /cheer - /strip - /smokeidle - /stop") ;
	SendClientMessage(playerid, 0xF2A55DFF, "» Vehicle {FFFFFF}| /carlook - /caranim - /carphone - /carfuss - /cartalk - /driverko - /lowrideranim") ;
	SendClientMessage(playerid, 0x985F83FF, "» Particle {FFFFFF}| /puke - /exhale - /shakebottle - /shit - /piss");

	SendClientMessage(playerid, 0xffffffFF, "To stop an animation use /sa or /stopanim.");

	return 1;
}

ShowMiscCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Miscellaneous Commands  ___________ ]");
	SendClientMessage(playerid, COLOR_GRAD0, "/settings, /pay, /paya(nim), /id, /boombox, /factions, /showinjuries, /showmasked");
	SendClientMessage(playerid, COLOR_GRAD1, "/bus, /(un)rentvehicle, /taketest, /setchat, /clearcp (/nocp), /nosound, /license(s)");
	SendClientMessage(playerid, COLOR_GRAD0, "/fillcar, /buygun, /emmettip, /emmetcrate, /carcolorlist, /hudscalefix, /payfine");
	SendClientMessage(playerid, COLOR_GRAD1, "/gascan, /cmc, /mask, /removemask, /call, /sms, /pickup, /h(angup), /nextskinupdate");
	SendClientMessage(playerid, COLOR_GRAD0, "/helpup, /surgery, /address (/whereami, /street), /kane, /adminrecord, /playerskin");
	SendClientMessage(playerid, COLOR_GRAD1, "/rules, /blindfold, /accept, /charity, /servertime, /advert, /coin, /dice, /greet");
	SendClientMessage(playerid, COLOR_GRAD0, "/namechange, /toys, /reloadtoys, /buytoys, /lockpick");
	SendClientMessage(playerid, COLOR_GRAD1, "/dropgun, /credits, /atc, /toys, /mytoys, /mycrimes, /fightstyle");
	SendClientMessage(playerid, COLOR_GRAD0, "/chopshop, /prisoners, /savings, /mytickets, /togdc, /gymstats");
	SendClientMessage(playerid, COLOR_GRAD1, "/spawn, /myspawns, /dc, /hold");
	
	return true ;
}

ShowHelpCommands(playerid) {

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Common Server Commands  ___________ ]");

	SendClientMessage(playerid, 0xDEDEDEFF, "[COMMANDS]: {DEDEDE}/help {b8b8b8}[ chat, vehicle, property, guns, job, faction, drug, voice, phone,");
	SendClientMessage(playerid, 0xb8b8b8FF, "furniture, spraytag, basketball, gate, anims, misc ]");
	ZMsg_SendClientMessage(playerid, 0x297183FF, "Useful commands:{DEDEDE} /mycars, /myproperties, /myguns, /mydrugs, /myslots, /myitems, /myprofile, /syncnames");
	if(IsPlayerHelper(playerid)) {
		SendClientMessage(playerid, 0xF1D55EFF, "[STAFF]: {DEDEDE}Use /staffhelp to see all staff commands.");
	}

	return true;
}

ShowChatCommands(playerid) {
	
	SendClientMessage(playerid, 0x297183FF, "[ ___________ Chat Commands  ___________ ]");


	SendClientMessage(playerid, 0x58DD85FF, "[OOC]:{B2FFCD} /b, /bl(ow), /c(ar)b, /toggleooc, /o(oc), /pm, /blockpm(s)");
	SendClientMessage(playerid, 0x58DC99FF, "[LOCAL]:{B2FFCD} /s(hout), /l(ow), /t, /setchat, /w(hisper), /c(ar)w(hisper)");
	SendClientMessage(playerid, 0x58DD85FF, "[ACTIONS]:{B2FFCD} /me, /mel(ow), /do, /ado, /dol(ow), /my, /attempt, /ame");

	return true;
}

ShowHelperCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_SUPPORTER] && !Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Helper Commands  ___________ ]");

	if(Account[playerid][E_PLAYER_ACCOUNT_SUPPORTER] == 1) {
		SendClientMessage(playerid, 0x58DD85FF, "[CHAT]: {B2FFCD}/h(elper)c(hat)");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/a(ccept)h(elp), /answer, /questions");
		SendClientMessage(playerid, 0x58DD85FF, "[MISC]: {B2FFCD}/cleartrucker, /checkcars");
	}

	if(Account[playerid][E_PLAYER_ACCOUNT_SUPPORTER] == 2) {
		SendClientMessage(playerid, 0x58DD85FF, "[CHAT]: {B2FFCD}/h(elper)c(hat)");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/a(ccept)h(elp), /answer, /questions, /helperduty");
		SendClientMessage(playerid, 0x58DD85FF, "[MISC]: {B2FFCD}/cleartrucker, /checkcars, /resetattributes, /respawnplayer, /processnc");
	}

	if(Account[playerid][E_PLAYER_ACCOUNT_SUPPORTER] > 2 || Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL] ) {
		SendClientMessage(playerid, 0x58DD85FF, "[CHAT]: {B2FFCD}/h(elper)c(hat)");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/a(ccept)h(elp), /answer, /questions, /helperduty, /kick");
		SendClientMessage(playerid, 0x58DD85FF, "[MISC]: {B2FFCD}/cleartrucker, /checkcars, /resetattributes, /respawnplayer, /processnc");
	}

	return true;
}


ShowAdminGeneralCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ General Administrator Commands  ___________ ]");
	
	if ( GetPlayerAdminLevel ( playerid ) == 1 ) {

		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/ajail, /unajail, /offlineajail, /gotoajail, /kick, /slap, /(un)freeze, /(un)ban");
		SendClientMessage(playerid, 0x58DC99FF, "[DUTY]: {B2FFCD}/aduty, /reports, /a(ccept)r(eport), /d(eny)r(eport), /punishlist, /(get)dist(ance)");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/spec(tate), /getcoordinates, /whonear, /clearinjuries");
		SendClientMessage(playerid, 0xD95023FF, "[CHAT]: {FA6D3E}/a(chat), /acinvite, /acuninvite, /toggleooc, /adminrumour");
		SendClientMessage(playerid, 0xFFCC68FF, "[TELEPORT]: {DEDEDE}/fw, /up, /dn, /goto, /gethere");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/getcharid, /getc, /getma, /adminrecord, /maskid, /getnumber");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/disarm, /confiscate, /frisk, /resetemail, /processn(ame)c(hange), /namechanges");
		SendClientMessage(playerid, 0x985F83FF, "[MISC]: {BF7AA6}/setint, /setvw, /removemask, /omaskid");
	}


	if ( GetPlayerAdminLevel ( playerid ) == 2 || GetPlayerAdminLevel ( playerid ) == 3 ) {

		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/ajail, /unajail, /offlineajail, /kick, /slap, /(un)freeze, /(un)ban");
		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/offlineban, /(un)banip, /settime, /setweather, /(get)dist(ance), /getstate");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/aduty, /reports, /a(ccept)r(eport), /d(eny)r(eport), /punishlist");
		SendClientMessage(playerid, 0x58DC99FF, "[DUTY]: {B2FFCD}/spec(tate), /getcoordinates, /whonear, /clearinjuries, /jetpack");
		SendClientMessage(playerid, 0xD95023FF, "[CHAT]: {FA6D3E}/a(chat), /acinvite, /acuninvite, /toggleooc, /aooc, /adminrumour");
		SendClientMessage(playerid, 0xFFCC68FF, "[TELEPORT]: {FFE1A8}/fw, /up, /dn, /goto, /gethere, /mark[1-3], /gotomark[1-3], /gotoxyz, /tp");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/getcharid, /getc, /getma, /adminrecord, /maskid, /getnumber");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/disarm, /confiscate, /frisk, /resetemail, /processn(ame)c(hange), /namechanges");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/setskin, /geoip, /checkstats, /checkproperties, /checkguns, /makeooc, /admin911");
		SendClientMessage(playerid, 0x985F83FF, "[MISC]: {BF7AA6}/ecc, /entercar, /setint, /setvw, /removemask, /omaskid, /adminad, /adminbreaking");

	}

	if ( GetPlayerAdminLevel ( playerid ) == 4 ) {

		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/ajail, /unajail, /offlineajail, /kick, /slap, /(un)freeze, /(un)ban");
		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/offlineban, /(un)banip, /settime, /setweather, /setgunrights ((gun ban))");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/aduty, /reports, /a(ccept)r(eport), /d(eny)r(eport), /punishlist");
		SendClientMessage(playerid, 0x58DC99FF, "[DUTY]: {B2FFCD}/spec(tate), /getcoordinates, /whonear, /clearinjuries, /jetpack");
		SendClientMessage(playerid, 0xD95023FF, "[CHAT]: {FA6D3E}/a(chat), /acinvite, /acuninvite, /toggleooc, /aooc, /adminrumour, /togd(onator)c(hat)");
		SendClientMessage(playerid, 0xFFCC68FF, "[TELEPORT]: {FFE1A8}/fw, /up, /dn, /goto, /gethere, /mark[1-3], /gotomark[1-3], /gotoxyz, /tp");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/getcharid, /getc, /getma, /adminrecord, /maskid, /getnumber");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/disarm, /confiscate, /frisk, /resetemail, /processn(ame)c(hange), /namechanges");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/setskin, /geoip, /checkstats, /checkproperties, /checkguns, /makeooc");
		SendClientMessage(playerid, 0x985F83FF, "[MISC]: {BF7AA6}/ecc, /entercar, /setint, /setvw, /removemask, /omaskid, /adminad, /adminbreaking");
		SendClientMessage(playerid, 0x985F83FF, "[MISC]: {BF7AA6}/setmotd, /(toggle)noclip, /(set)customanim, /admin911, /makehelper, /createatm");
		SendClientMessage(playerid, 0x58DC99FF, "[REFUNDS]: {B2FFCD}/addrefund, /oaddrefund, /checkrefunds");
		SendClientMessage(playerid, 0xF87070FF, "[ANTICHEAT]: {FDBCBC}/toggleac, /checkpausedac");

	}

	if ( GetPlayerAdminLevel ( playerid ) > 4 ) {

		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/ajail, /unajail, /offlineajail, /kick, /slap, /(un)freeze, /(un)ban");
		SendClientMessage(playerid, 0xF87070FF, "[ADMIN]: {FDBCBC}/offlineban, /(un)banip, /settime, /setweather, /setintrosong");
		SendClientMessage(playerid, 0xF87070FF, "[MANAGER]: {FDBCBC}/makeadmin /makehelper, /adminhex, /helperhex, /givemoney, /takemoney");
		SendClientMessage(playerid, 0xF87070FF, "[MANAGER]: {FDBCBC}/addplayerskin, /makecontributor, /setgunrights ((gun ban))");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/aduty, /reports, /a(ccept)r(eport), /d(eny)r(eport), /punishlist");
		SendClientMessage(playerid, 0x58DD85FF, "[DUTY]: {B2FFCD}/spec(tate), /getcoordinates, /whonear, /clearinjuries, /jetpack");
		SendClientMessage(playerid, 0xD95023FF, "[CHAT]: {FA6D3E}/a(chat), /acinvite, /acuninvite, /toggleooc, /aooc, /man, /togd(onator)c(hat), /adminrumour");
		SendClientMessage(playerid, 0xFFCC68FF, "[TELEPORT]: {FFE1A8}/fw, /up, /dn, /goto, /gethere, /mark[1-3], /gotomark[1-3], /gotoxyz, /tp");
		SendClientMessage(playerid, 0xFFCC68FF, "[TELEPORT]: {FFE1A8}/gotostore, /gotowholesaler");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/getcharid, /getc, /getma, /adminrecord, /maskid, /getnumber");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/disarm, /confiscate, /frisk, /resetemail, /processn(ame)c(hange), /namechanges");
		SendClientMessage(playerid, 0x77BBFAFF, "[PLAYER]: {BBDEFF}/setskin, /geoip, /checkstats, /checkproperties, /checkguns, /makeooc");
		SendClientMessage(playerid, 0x985F83FF, "[MISC]: {BF7AA6}/ecc, /entercar, /setint, /setvw, /removemask, /omaskid, /adminad, /adminbreaking");
		SendClientMessage(playerid, 0x985F83FF, "[MISC]: {BF7AA6}/setmotd, /(toggle)noclip, /(set)customanim, /admin911");
		SendClientMessage(playerid, 0x58DC99FF, "[REFUNDS]: {B2FFCD}/addrefund, /oaddrefund, /checkrefunds");
		SendClientMessage(playerid, 0xF87070FF, "[ANTICHEAT]: {FDBCBC}/toggleac, /checkpausedac");

	}

	return true;
}

ShowAdminVehicleCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Vehicle Administrator Commands  ___________ ]");
	
	if ( GetPlayerAdminLevel ( playerid ) == 1 ) {
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carfix, /acarfuel, /respawnrentals, /respawnallcars, /findrentals");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carrespawn, /gotocar, /getcar");
	}


	if ( GetPlayerAdminLevel ( playerid ) == 2 ) {
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carfix, /acarfuel, /respawnrentals, /respawnallcars, /findrentals");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carrespawn, /gotocar, /getcar, /carflip, /deletecar, /carslap");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carhp, /carsavesiren, /caradminpark, /ecc, /entercar, /engine");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/caradmincolor");
	}

	if ( GetPlayerAdminLevel ( playerid ) == 3 ) {
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carfix, /acarfuel, /respawnrentals, /respawnallcars, /findrentals");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carrespawn, /gotocar, /getcar, /carflip, /deletecar, /carslap");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carhp, /carsavesiren, /caradminpark, /ecc, /entercar, /engine");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/caradmincolor, /viewcars");
	}

	if ( GetPlayerAdminLevel ( playerid ) >= 4 ) {
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carfix, /acarfuel, /respawnrentals, /respawnallcars, /findrentals");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carrespawn, /gotocar, /getcar, /carflip, /deletecar, /carslap");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/carhp, /carsavesiren, /caradminpark, /ecc, /entercar, /engine");
		SendClientMessage(playerid, 0xF87070FF, "[VEHICLE]: {FDBCBC}/caradmincolor, /viewcars, /carcreate, /carowner, /cartype, /carjob");
	}

	return true;
}

ShowAdminPropertyCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Property Administrator Commands  ___________ ]");
	
	if ( GetPlayerAdminLevel ( playerid ) == 1 ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
	}


	if ( GetPlayerAdminLevel ( playerid ) == 2 ) {
		SendClientMessage(playerid, 0x58DD85FF, "[PROPERTY]: {B2FFCD}/propertycheck, /propertygoto, /propertyintlist, /checkproperties");
	}

	if ( GetPlayerAdminLevel ( playerid ) >= 3 ) {
		SendClientMessage(playerid, 0x58DD85FF, "[PROPERTY]: {B2FFCD}/propertycheck, /propertygoto, /propertyintlist, /checkproperties");
		SendClientMessage(playerid, 0x58DD85FF, "[PROPERTY]: {B2FFCD}/propertycreate, /propertymove, /propertydelete, /propertyprice, /propertyauction");
		SendClientMessage(playerid, 0x58DD85FF, "[PROPERTY]: {B2FFCD}/propertybuytype, /propertybuypoint, /propertyint(erior), /propertytype, /passpointcreate");
		SendClientMessage(playerid, 0x58DD85FF, "[PROPERTY]: {B2FFCD}/passpointdelete, /passpointlink, /passpointmove, /passpointgoto, /passpointname, /passpointtype");
		SendClientMessage(playerid, 0x58DD85FF, "[PROPERTY]: {B2FFCD}/passpointcolor, /passpointfaction");
	}

	return true;
}

ShowAdminFactionCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Faction Administrator Commands  ___________ ]");
	
	if ( GetPlayerAdminLevel ( playerid ) == 1 ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
	}

	if ( GetPlayerAdminLevel ( playerid ) == 2 ) {
		SendClientMessage(playerid, 0x77BBFAFF, "[FACTION]: {BBDEFF}/afjoin, /fchatban, /setduty");
	}

	if ( GetPlayerAdminLevel ( playerid ) >= 3 ) {
		SendClientMessage(playerid, 0x77BBFAFF, "[FACTION]: {BBDEFF}/afjoin, /f(action)name, /f(action)create, /f(action)hex, /f(action)skinadd");
		SendClientMessage(playerid, 0x77BBFAFF, "[FACTION]: {BBDEFF}/f(action)extra, /factionresetperkcd, /f(action)visible, /fchatban");
	}

	return true;
}

ShowAdminDynamicCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Dynamic System Administrator Commands  ___________ ]");
	
	if ( GetPlayerAdminLevel ( playerid ) <= 2 ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
	}

	if ( GetPlayerAdminLevel ( playerid ) == 3 ) {
		SendClientMessage(playerid, 0x58DD85FF, "[GATE]: {B2FFCD}/gatecreate, /gateradius, /gateopen, /gatetoll, /gategoto, /gatemove");
		SendClientMessage(playerid, 0x58DD85FF, "[GATE]: {B2FFCD}/gatetexture, /gateworld, /gateint, /gatetype, /gatespeed, /gateautoclose");

		SendClientMessage(playerid, 0xF87070FF, "[POOL]: {FDBCBC}/poolcreate, /poolendgame, /poolcolor,  /poolmove, /pooldelete");

		SendClientMessage(playerid, 0xD95023FF, "[POKER]: {FA6D3E}/pokercreate, /pokernear, /pokerdelete, /pokerendgame");

		SendClientMessage(playerid, 0x094204FF, "[TURF]: {199C0E}/gangzoneassign, /gangzonecontest, /gangzoneid");

		SendClientMessage(playerid, 0x985F83FF, "[ATTACH]: {BF7AA6}/addattachpoint, /attachpointdelete, /attachpointlink");

		SendClientMessage(playerid, 0x297183FF, "[WARDROBE]: {FFE1A8}/wardrobecheck, /wardrobeadd, /wardrobedelete");
		SendClientMessage(playerid, 0x297183FF, "[WARDROBE]: {FFE1A8}/wardrobetype, /wardrobeowner, /wardrobemove, /wardrobegoto");
	}

	if ( GetPlayerAdminLevel ( playerid ) == 4 ) {
		SendClientMessage(playerid, 0x58DD85FF, "[GATE]: {B2FFCD}gatecreate, /gateradius, /gateopen, /gatetoll, /gategoto, /gatemove");
		SendClientMessage(playerid, 0x58DD85FF, "[GATE]: {B2FFCD}/gatetexture, /gateworld, /gateint, /gatetype, /gatespeed, /gateautoclose");

		SendClientMessage(playerid, 0xF87070FF, "[POOL]: {FDBCBC}/poolcreate, /poolendgame, /poolcolor,  /poolmove, /pooldelete");

		SendClientMessage(playerid, 0xD95023FF, "[POKER]: {FA6D3E}/pokercreate, /pokernear, /pokerdelete, /pokerendgame");

		SendClientMessage(playerid, 0x985F83FF, "[ATTACH]: {BF7AA6}/addattachpoint, /attachpointdelete, /attachpointlink");

		SendClientMessage(playerid, 0x77BBFAFF, "[SPRAY]: {BBDEFF}/s(pray)t(ag)create, /s(pray)t(ag)delete");

		SendClientMessage(playerid, 0x094204FF, "[TURF]: {199C0E}/gangzoneassign, /gangzonecontest, /gangzoneid");
		
		SendClientMessage(playerid, 0xFFCC68FF, "[FUEL]: {FFE1A8}/createfuelpump, /linkpumptostation, /unlinkpump, /viewlinkedpumps, /gotopump");
		SendClientMessage(playerid, 0xFFCC68FF, "[FUEL]: {FFE1A8}/movepump, /deletepump, /unlinkedpumps, createfuelstation, /gotostation");
		SendClientMessage(playerid, 0xFFCC68FF, "[FUEL]: {FFE1A8}/movestation, /auctionstation, /deletestation, /stationinfo");

		SendClientMessage(playerid, 0x58DD85FF, "[EMMET]: {B2FFCD}/emmetcreate, /emmetowner, /emmetassign, /emmetid, /emmetgoto, /emmetmove, /emmetskin, /emmetname, /emmetcreatespawn, /emmetcrateinfo");
	
		SendClientMessage(playerid, 0x297183FF, "[WARDROBE]: {FFE1A8}/wardrobecheck, /wardrobeadd, /wardrobedelete");
		SendClientMessage(playerid, 0x297183FF, "[WARDROBE]: {FFE1A8}/wardrobetype, /wardrobeowner, /wardrobemove, /wardrobegoto");
	}

	if ( GetPlayerAdminLevel ( playerid ) > 4 ) {
		SendClientMessage(playerid, 0x58DD85FF, "[GATE]: {B2FFCD}gatecreate, /gateradius, /gateopen, /gatetoll, /gategoto, /gatemove");
		SendClientMessage(playerid, 0x58DD85FF, "[GATE]: {B2FFCD}/gatetexture, /gateworld, /gateint, /gatetype, /gatespeed, /gateautoclose");

		SendClientMessage(playerid, 0xF87070FF, "[POOL]: {FDBCBC}/poolcreate, /poolendgame, /poolcolor,  /poolmove, /pooldelete");

		SendClientMessage(playerid, 0xD95023FF, "[POKER]: {FA6D3E}/pokercreate, /pokernear, /pokerdelete, /pokerendgame");

		SendClientMessage(playerid, 0x985F83FF, "[ATTACH]: {BF7AA6}/addattachpoint, /attachpointdelete, /attachpointlink");

		SendClientMessage(playerid, 0x77BBFAFF, "[SPRAY]: {BBDEFF}/s(pray)t(ag)create, /s(pray)t(ag)delete");

		SendClientMessage(playerid, 0x094204FF, "[TURF]: {199C0E}/gangzoneassign, /gangzonecontest, /gangzoneid");

		SendClientMessage(playerid, 0xFFCC68FF, "[FUEL]: {FFE1A8}/createfuelpump, /linkpumptostation, /unlinkpump, /viewlinkedpumps, /gotopump");
		SendClientMessage(playerid, 0xFFCC68FF, "[FUEL]: {FFE1A8}/movepump, /deletepump, /unlinkedpumps, createfuelstation, /gotostation");
		SendClientMessage(playerid, 0xFFCC68FF, "[FUEL]: {FFE1A8}/movestation, /auctionstation, /deletestation, /stationinfo");

		SendClientMessage(playerid, 0x58DD85FF, "[EMMET]: {B2FFCD}/emmetcreate, /emmetowner, /emmetassign, /emmetid, /emmetgoto, /emmetmove, /emmetskin, /emmetname");
		SendClientMessage(playerid, 0xF87070FF, "[DRUGS]: {FDBCBC}/drugsetparam, /drugsetstage /drugsetticks, /drugforcefinish, /drugsuppliergoto ");
	
		SendClientMessage(playerid, 0x297183FF, "[WARDROBE]: {FFE1A8}/wardrobecheck, /wardrobeadd, /wardrobedelete");
		SendClientMessage(playerid, 0x297183FF, "[WARDROBE]: {FFE1A8}/wardrobetype, /wardrobeowner, /wardrobemove, /wardrobegoto");
	}

	return true;
}

ShowAdminMiscCommands(playerid) {

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
		return true;
	}

	SendClientMessage(playerid, 0x297183FF, "[ ___________ Misc Administrator Commands  ___________ ]");
	
	if ( GetPlayerAdminLevel ( playerid ) <= 4 ) {
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "There are no commands available to you in this category.");
	}

	if ( GetPlayerAdminLevel ( playerid ) >= 5) {
		SendClientMessage(playerid, 0x77BBFAFF, "[SPOOF]: {BBDEFF}/spoofbuy, /spoofpool, /spoofgun, /spoofmats, /spoofdrugstation, /spoofammo");
		SendClientMessage(playerid, 0x77BBFAFF, "[SPOOF]: {BBDEFF}/spoofattach, /spoofprop, /poolspoof, /forcechopshop, /tempclearchopshopcd");
	}

	return true;
}


CMD:help(playerid, params[]) {

	new option[32];

	if(sscanf(params, "s[32]", option))
		return ShowHelpCommands(playerid);

	if(!strcmp(option, "chat", true) || !strcmp(option, "text", true) || ! strcmp(option, "rp", true)) {
		return ShowChatCommands(playerid);
	}

	if(!strcmp(option, "property", true) || !strcmp(option, "prop", true) || !strcmp(option, "house", true) || !strcmp(option, "business", true) || !strcmp(option, "houses", true) || !strcmp(option, "properties", true) || !strcmp(option, "businesses", true))
		return ShowPropertyCommands(playerid);

	if(!strcmp(option, "car", true) || !strcmp(option, "vehicle", true) || !strcmp(option, "veh", true) || !strcmp(option, "v", true) || !strcmp(option, "cars", true) || !strcmp(option, "vehs", true)|| !strcmp(option, "vehicles", true))
		return ShowVehicleCommands(playerid);

	if(!strcmp(option, "gun", true) || !strcmp(option, "guns", true) || !strcmp(option, "weapon", true) || !strcmp(option, "weapons", true)|| !strcmp(option, "firearms", true))
		return ShowGunCommands(playerid);

	if(!strcmp(option, "jobs", true) || !strcmp(option, "job", true) || !strcmp(option, "work", true))
		return ShowJobCommands(playerid);

	if(!strcmp(option, "faction", true) || !strcmp(option, "factions", true))
		return ShowFactionCommands(playerid);

	if(!strcmp(option, "drug", true) || !strcmp(option, "drugs", true))
		return ShowDrugCommands(playerid);

	if(!strcmp(option, "voice", true) || !strcmp(option, "voiceline", true) || !strcmp(option, "voicelines", true))
		return ShowVoiceCommands(playerid);

	if(!strcmp(option, "phone", true) || !strcmp(option, "cell", true) || !strcmp(option, "call", true))
		return ShowPhoneCommands(playerid);

	if(!strcmp(option, "furniture", true) || !strcmp(option, "furni", true) || !strcmp(option, "decorate", true))
		return ShowFurniCommands(playerid);

	if(!strcmp(option, "spray", true) || !strcmp(option, "spraytag", true) || !strcmp(option, "tag", true))
		return ShowSpraytagCommands(playerid);

	if(!strcmp(option, "basket", true) || !strcmp(option, "basketball", true))
		return ShowBasketballCommmands(playerid);

	if(!strcmp(option, "gate", true) || !strcmp(option, "gates", true))
		return ShowGateCommands(playerid);

	if(!strcmp(option, "anim", true) || !strcmp(option, "anims", true))
		return ShowAnimCommands(playerid);

	if(!strcmp(option, "miscellaneous", true) || !strcmp(option, "misc", true))
		return ShowMiscCommands(playerid);

	if(!strcmp(option, "staff", true) || !strcmp(option, "admin", true))
		return ShowStaffCategoryCommands(playerid);


	return true ;
}

CMD:oldahelp(playerid, params[]) {
	return ShowOldStaffCommands(playerid);
}

ShowStaffCategoryCommands(playerid) {
	
	SendClientMessage(playerid, 0x297183FF, "[ ___________ Admin Commands  ___________ ]");

	SendClientMessage(playerid, 0xDEDEDEFF, "[COMMANDS]: {B8B8B8}/staffhelp {b8b8b8}[helper, admin, vehicle, property, faction, dynamic, misc ]");
	SendClientMessage(playerid, 0xDEDEDEFF, "Use /oldahelp for the old command list format.");
	
	return true;
}


CMD:staffhelp(playerid, params[]) {

	if(IsPlayerHelper(playerid) && !Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		ShowHelperCommands(playerid);
	}

	if(!Account[playerid][E_PLAYER_ACCOUNT_STAFFLEVEL]) {
		return false;
	}

	new option[32];

	if(sscanf(params, "s[32]", option))
		return ShowStaffCategoryCommands(playerid);

	if(!strcmp(option, "helper", true)) {
		return ShowHelperCommands(playerid);
	}

	if(!strcmp(option, "admin", true) || !strcmp(option, "administrator", true)) {
		return ShowAdminGeneralCommands(playerid);
	}

	if(!strcmp(option, "car", true) || !strcmp(option, "vehicle", true)) {
		return ShowAdminVehicleCommands(playerid);
	}

	if(!strcmp(option, "house", true) || !strcmp(option, "biz", true) || !strcmp(option, "prop", true) || !strcmp(option, "properties", true) || !strcmp(option, "property", true)) {
		return ShowAdminPropertyCommands(playerid);
	}

	if(!strcmp(option, "f", true) || !strcmp(option, "faction", true)) {
		return ShowAdminFactionCommands(playerid);
	}

	if(!strcmp(option, "miscellaneous", true) || !strcmp(option, "misc", true)) {
		return ShowAdminMiscCommands(playerid);
	}

	if(!strcmp(option, "dynamic", true) || !strcmp(option, "dyn", true)) {
		return ShowAdminDynamicCommands(playerid);
	}
	

	return true;
}



// all shortcuts.

// property

CMD:bizhelp(playerid, params[]) {return cmd_propertyhelp(playerid, params);}
CMD:househelp(playerid, params[]) {return cmd_propertyhelp(playerid, params);}
CMD:prophelp(playerid, params[]) {return cmd_propertyhelp(playerid, params);}

CMD:propertyhelp(playerid, params[]) {
	return ShowPropertyCommands(playerid);
}

// car

CMD:vhelp(playerid, params[]) {return cmd_carhelp(playerid, params);}
CMD:vehiclehelp(playerid, params[]) {return cmd_carhelp(playerid, params);}

CMD:carhelp(playerid, params[]) {
	return ShowVehicleCommands(playerid);
}


// guns


CMD:ghelp(playerid, params[]) {return cmd_gunhelp(playerid, params);}
CMD:weaponhelp(playerid, params[]) {return cmd_gunhelp(playerid, params);}

CMD:gunhelp(playerid, params[]) {
	return ShowGunCommands(playerid);
}


// jobs
CMD:truckerhelp(playerid, params[]) {return cmd_jobhelp(playerid, params);}

CMD:jobs(playerid, params[]) {return cmd_jobhelp(playerid, params);}

CMD:jobhelp(playerid, params[]) {
	return ShowJobCommands(playerid);
}


//factions

CMD:fhelp(playerid, params[]) {return cmd_factionhelp(playerid, params);}

CMD:factionhelp(playerid, params[]){
	return ShowFactionCommands(playerid);
}

// drugs

CMD:drughelp(playerid, params[]){
	return ShowDrugCommands(playerid);
}

// voice
CMD:voicehelp(playerid, params[]){
	return ShowVoiceCommands(playerid);
}

// call
CMD:phonehelp(playerid, params[]){
	return ShowPhoneCommands(playerid);
}

// furni

CMD:furniturehelp(playerid, params[]){
	return ShowFurniCommands(playerid);
}

CMD:furnihelp(playerid, params[]){
	return ShowFurniCommands(playerid);
}

// spraytag

CMD:spraytaghelp(playerid, params[]){
	return ShowSpraytagCommands(playerid);
}

CMD:sprayhelp(playerid, params[]){
	return ShowSpraytagCommands(playerid);
}

//gate

CMD:gatehelp(playerid, params[]){
	return ShowGateCommands(playerid);
}

// anims

CMD:animhelp ( playerid, params [] ) {
	return ShowAnimCommands(playerid);
}

CMD:anims ( playerid, params [] ) {
	return ShowAnimCommands(playerid);
}

// misc

CMD:mischelp ( playerid, params [] ) {
	return ShowMiscCommands(playerid);
}

CMD:commands ( playerid, params [] ) {
	return ShowMiscCommands(playerid);
}


// staff
CMD:ahelp ( playerid, params [] ) {
	return ShowStaffCategoryCommands(playerid);
}

CMD:helperhelp ( playerid, params [] ) {
	return ShowStaffCategoryCommands(playerid);
}
