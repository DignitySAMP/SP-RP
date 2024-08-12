#include "browser/engine.pwn"

/*
CMD:cars(playerid, params[]) {

	ModelBrowser_ClearData(playerid);
	ModelBrowser_AddData(playerid, 400, "Landstalker" ) ;
	ModelBrowser_AddData(playerid, 401, "Bravura" ) ;
	ModelBrowser_AddData(playerid, 402, "Buffalo" ) ;
	ModelBrowser_AddData(playerid, 403, "Linerunner" ) ;
	ModelBrowser_AddData(playerid, 404, "Perennial" ) ;
	ModelBrowser_AddData(playerid, 405, "Sentinel" ) ;
	ModelBrowser_AddData(playerid, 406, "Dumper" ) ;
	ModelBrowser_AddData(playerid, 407, "Firetruck" ) ;
	ModelBrowser_AddData(playerid, 408, "Trashmaster" ) ;
	ModelBrowser_AddData(playerid, 409, "Stretch" ) ;
	ModelBrowser_AddData(playerid, 410, "Manana" ) ;
	ModelBrowser_AddData(playerid, 411, "Infernus" ) ;
	ModelBrowser_AddData(playerid, 412, "Voodoo" ) ;
	ModelBrowser_AddData(playerid, 413, "Pony" ) ;
	ModelBrowser_AddData(playerid, 414, "Mule" ) ;
	print("Second page" ) ;
	ModelBrowser_AddData(playerid, 415, "Cheetah" ) ;
	ModelBrowser_AddData(playerid, 416, "Ambulance" ) ;
	ModelBrowser_AddData(playerid, 417, "Leviathan" ) ;
	ModelBrowser_AddData(playerid, 418, "Moonbeam" ) ;
	ModelBrowser_AddData(playerid, 419, "Esperanto" ) ;	
	ModelBrowser_AddData(playerid, 420, "Taxi" ) ;
	ModelBrowser_AddData(playerid, 421, "Washington" ) ;
	ModelBrowser_AddData(playerid, 422, "Bobcat" ) ;
	ModelBrowser_AddData(playerid, 423, "Mr. Whoopee" ) ;
	ModelBrowser_AddData(playerid, 424, "BF Injection" ) ;
	ModelBrowser_AddData(playerid, 425, "Hunter" ) ;
	ModelBrowser_AddData(playerid, 426, "Premier" );
	ModelBrowser_AddData(playerid, 427, "Enforcer" );
	ModelBrowser_AddData(playerid, 428, "Securicar" );
	ModelBrowser_AddData(playerid, 429, "Banshee" );
	print("Third page" ) ;
	ModelBrowser_AddData(playerid, 430, "Predator" );
	ModelBrowser_AddData(playerid, 431, "Bus" );
	ModelBrowser_AddData(playerid, 432, "Rhino" );
	ModelBrowser_AddData(playerid, 433, "Barracks" );
	ModelBrowser_AddData(playerid, 434, "Hotknife" );
	ModelBrowser_AddData(playerid, 435, "Article Trailer" );
	ModelBrowser_AddData(playerid, 436, "Previon" );
	ModelBrowser_AddData(playerid, 437, "Coach" );
	ModelBrowser_AddData(playerid, 438, "Cabbie" );
	ModelBrowser_AddData(playerid, 439, "Stallion" );
	ModelBrowser_AddData(playerid, 440, "Rumpo" );
	ModelBrowser_AddData(playerid, 441, "RC Bandit" );
	ModelBrowser_AddData(playerid, 442, "Romero" );
	ModelBrowser_AddData(playerid, 443, "Packer" );
	ModelBrowser_AddData(playerid, 444, "Monster" );
	print("Fourth page" ) ;
	ModelBrowser_AddData(playerid, 445, "Admiral" );
	ModelBrowser_SetupTiles(playerid, "Vehicle List", "Vehicle_List");

	return true ;
}

mBrowser:Vehicle_List(playerid, response, row, model, name[]) {

	if ( ! response ) {

		SendClientMessage(playerid, -1, "VehicleList: Negative response!");
	}

	else if ( response ) {

		SendClientMessage(playerid, -1, "VehicleList: Positive response!");
	}

	new string [ 96 ] ;

	format ( string, sizeof ( string ), "VehicleList: Selected row %d, having model %d and name %s.",
		row, model, name
	) ;

	SendClientMessage(playerid, -1, string);

	return true ;
}


CMD:skins(playerid, params[]) {

	ModelBrowser_ClearData(playerid);
	ModelBrowser_AddData(playerid, 0, "Carl CJ Johnson" );
	ModelBrowser_AddData(playerid, 1, "The Truth" );
	ModelBrowser_AddData(playerid, 2, "Maccer" );
	ModelBrowser_AddData(playerid, 3, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 4, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 5, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 6, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 7, "Taxi Driver/Train Driver" );
	ModelBrowser_AddData(playerid, 8, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 9, "Normal Ped" );
	ModelBrowser_AddData(playerid, 10, "Normal Ped" );
	ModelBrowser_AddData(playerid, 11, "Casino Worker" );
	ModelBrowser_AddData(playerid, 12, "Normal Ped" );
	ModelBrowser_AddData(playerid, 13, "Normal Ped" );
	ModelBrowser_AddData(playerid, 14, "Normal Ped" );
	ModelBrowser_AddData(playerid, 15, "RS Haul Owner" );
	ModelBrowser_AddData(playerid, 16, "Airport Ground Worker" );
	ModelBrowser_AddData(playerid, 17, "Normal Ped" );
	ModelBrowser_AddData(playerid, 18, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 19, "Normal Ped" );
	ModelBrowser_AddData(playerid, 20, "Madd Dogg's Manager" );
	ModelBrowser_AddData(playerid, 21, "Normal Ped" );
	ModelBrowser_AddData(playerid, 22, "Normal Ped" );
	ModelBrowser_AddData(playerid, 23, "BMXer" );
	ModelBrowser_AddData(playerid, 24, "Madd Dogg Bodyguard" );
	ModelBrowser_AddData(playerid, 25, "Madd Dogg Bodyguard" );
	ModelBrowser_AddData(playerid, 26, "Mountain Climber" );
	ModelBrowser_AddData(playerid, 27, "Builder" );
	ModelBrowser_AddData(playerid, 28, "Drug Dealer" );
	ModelBrowser_AddData(playerid, 29, "Drug Dealer" );
	ModelBrowser_AddData(playerid, 30, "Drug Dealer" );
	ModelBrowser_AddData(playerid, 31, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 32, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 33, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 34, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 35, "Normal Ped" );
	ModelBrowser_AddData(playerid, 36, "Golfer" );
	ModelBrowser_AddData(playerid, 37, "Golfer" );
	ModelBrowser_AddData(playerid, 38, "Normal Ped" );
	ModelBrowser_AddData(playerid, 39, "Normal Ped" );
	ModelBrowser_AddData(playerid, 40, "Normal Ped" );
	ModelBrowser_AddData(playerid, 41, "Normal Ped" );
	ModelBrowser_AddData(playerid, 42, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 43, "Normal Ped" );
	ModelBrowser_AddData(playerid, 44, "Normal Ped" );
	ModelBrowser_AddData(playerid, 45, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 46, "Normal Ped" );
	ModelBrowser_AddData(playerid, 47, "Normal Ped" );
	ModelBrowser_AddData(playerid, 48, "Normal Ped" );
	ModelBrowser_AddData(playerid, 49, "Snakehead (Da Nang)" );
	ModelBrowser_AddData(playerid, 50, "Mechanic" );
	ModelBrowser_AddData(playerid, 51, "Mountain Biker" );
	ModelBrowser_AddData(playerid, 52, "Mountain Biker" );
	ModelBrowser_AddData(playerid, 53, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 54, "Normal Ped" );
	ModelBrowser_AddData(playerid, 55, "Normal Ped" );
	ModelBrowser_AddData(playerid, 56, "Normal Ped" );
	ModelBrowser_AddData(playerid, 57, "Feds" );
	ModelBrowser_AddData(playerid, 58, "Normal Ped" );
	ModelBrowser_AddData(playerid, 59, "Normal Ped" );
	ModelBrowser_AddData(playerid, 60, "Normal Ped" );
	ModelBrowser_AddData(playerid, 61, "Pilot" );
	ModelBrowser_AddData(playerid, 62, "Colonel Fuhrberger" );
	ModelBrowser_AddData(playerid, 63, "Prostitute" );
	ModelBrowser_AddData(playerid, 64, "Prostitute" );
	ModelBrowser_AddData(playerid, 65, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 66, "Pool Player" );
	ModelBrowser_AddData(playerid, 67, "Pool Player" );
	ModelBrowser_AddData(playerid, 68, "Priest" );
	ModelBrowser_AddData(playerid, 69, "Normal Ped" );
	ModelBrowser_AddData(playerid, 70, "Scientist" );
	ModelBrowser_AddData(playerid, 71, "Security Guard" );
	ModelBrowser_AddData(playerid, 72, "Normal Ped" );
	ModelBrowser_AddData(playerid, 73, "Jethro" );
	ModelBrowser_AddData(playerid, 74, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 75, "Prostitute" );
	ModelBrowser_AddData(playerid, 76, "Normal Ped" );
	ModelBrowser_AddData(playerid, 77, "Homeless" );
	ModelBrowser_AddData(playerid, 78, "Homeless" );
	ModelBrowser_AddData(playerid, 79, "Homeless" );
	ModelBrowser_AddData(playerid, 80, "Boxer" );
	ModelBrowser_AddData(playerid, 81, "Boxer" );
	ModelBrowser_AddData(playerid, 82, "Elvis Wannabe" );
	ModelBrowser_AddData(playerid, 83, "Elvis Wannabe" );
	ModelBrowser_AddData(playerid, 84, "Elvis Wannabe" );
	ModelBrowser_AddData(playerid, 85, "Prostitute" );
	ModelBrowser_AddData(playerid, 86, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 87, "Whore" );
	ModelBrowser_AddData(playerid, 88, "Normal Ped" );
	ModelBrowser_AddData(playerid, 89, "Normal Ped" );
	ModelBrowser_AddData(playerid, 90, "Whore" );
	ModelBrowser_AddData(playerid, 91, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 92, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 93, "Normal Ped" );
	ModelBrowser_AddData(playerid, 94, "Normal Ped" );
	ModelBrowser_AddData(playerid, 95, "Normal Ped" );
	ModelBrowser_AddData(playerid, 96, "Jogger" );
	ModelBrowser_AddData(playerid, 97, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 98, "Normal Ped" );
	ModelBrowser_AddData(playerid, 99, "Skeelering" );
	ModelBrowser_AddData(playerid, 100, "Biker" );
	ModelBrowser_AddData(playerid, 101, "Normal Ped" );
	ModelBrowser_AddData(playerid, 102, "Balla" );
	ModelBrowser_AddData(playerid, 103, "Balla" );
	ModelBrowser_AddData(playerid, 104, "Balla" );
	ModelBrowser_AddData(playerid, 105, "Grove Street Families" );
	ModelBrowser_AddData(playerid, 106, "Grove Street Families" );
	ModelBrowser_AddData(playerid, 107, "Grove Street Families" );
	ModelBrowser_AddData(playerid, 108, "Los Santos Vagos" );
	ModelBrowser_AddData(playerid, 109, "Los Santos Vagos" );
	ModelBrowser_AddData(playerid, 110, "Los Santos Vagos" );
	ModelBrowser_AddData(playerid, 111, "The Russian Mafia" );
	ModelBrowser_AddData(playerid, 112, "The Russian Mafia" );
	ModelBrowser_AddData(playerid, 113, "The Russian Mafia" );
	ModelBrowser_AddData(playerid, 114, "Varios Los Aztecas" );
	ModelBrowser_AddData(playerid, 115, "Varios Los Aztecas" );
	ModelBrowser_AddData(playerid, 116, "Varios Los Aztecas" );
	ModelBrowser_AddData(playerid, 117, "Traid" );
	ModelBrowser_AddData(playerid, 118, "Traid" );
	ModelBrowser_AddData(playerid, 119, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 120, "Traid" );
	ModelBrowser_AddData(playerid, 121, "Da Nang Boy" );
	ModelBrowser_AddData(playerid, 122, "Da Nang Boy" );
	ModelBrowser_AddData(playerid, 123, "Da Nang Boy" );
	ModelBrowser_AddData(playerid, 124, "The Mafia" );
	ModelBrowser_AddData(playerid, 125, "The Mafia" );
	ModelBrowser_AddData(playerid, 126, "The Mafia" );
	ModelBrowser_AddData(playerid, 127, "The Mafia" );
	ModelBrowser_AddData(playerid, 128, "Farm Inhabitant" );
	ModelBrowser_AddData(playerid, 129, "Farm Inhabitant" );
	ModelBrowser_AddData(playerid, 130, "Farm Inhabitant" );
	ModelBrowser_AddData(playerid, 131, "Farm Inhabitant" );
	ModelBrowser_AddData(playerid, 132, "Farm Inhabitant" );
	ModelBrowser_AddData(playerid, 133, "Farm Inhabitant" );
	ModelBrowser_AddData(playerid, 134, "Homeless" );
	ModelBrowser_AddData(playerid, 135, "Homeless" );
	ModelBrowser_AddData(playerid, 136, "Normal Ped" );
	ModelBrowser_AddData(playerid, 137, "Homeless" );
	ModelBrowser_AddData(playerid, 138, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 139, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 140, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 141, "Office Worker" );
	ModelBrowser_AddData(playerid, 142, "Taxi Driver" );
	ModelBrowser_AddData(playerid, 143, "Normal Ped" );
	ModelBrowser_AddData(playerid, 144, "Normal Ped" );
	ModelBrowser_AddData(playerid, 145, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 146, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 147, "Director" );
	ModelBrowser_AddData(playerid, 148, "Secretary" );
	ModelBrowser_AddData(playerid, 149, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 150, "Secretary" );
	ModelBrowser_AddData(playerid, 151, "Normal Ped" );
	ModelBrowser_AddData(playerid, 152, "Prostitute" );
	ModelBrowser_AddData(playerid, 153, "Coffee mam'" );
	ModelBrowser_AddData(playerid, 154, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 155, "Well Stacked Pizza" );
	ModelBrowser_AddData(playerid, 156, "Normal Ped" );
	ModelBrowser_AddData(playerid, 157, "Farmer" );
	ModelBrowser_AddData(playerid, 158, "Farmer" );
	ModelBrowser_AddData(playerid, 159, "Farmer" );
	ModelBrowser_AddData(playerid, 160, "Farmer" );
	ModelBrowser_AddData(playerid, 161, "Farmer" );
	ModelBrowser_AddData(playerid, 162, "Farmer" );
	ModelBrowser_AddData(playerid, 163, "Bouncer" );
	ModelBrowser_AddData(playerid, 164, "Bouncer" );
	ModelBrowser_AddData(playerid, 165, "MIB Agent" );
	ModelBrowser_AddData(playerid, 166, "MIB Agent" );
	ModelBrowser_AddData(playerid, 167, "Cluckin' Bell" );
	ModelBrowser_AddData(playerid, 168, "Food Vendor" );
	ModelBrowser_AddData(playerid, 169, "Normal Ped" );
	ModelBrowser_AddData(playerid, 170, "Normal Ped" );
	ModelBrowser_AddData(playerid, 171, "Casino Worker" );
	ModelBrowser_AddData(playerid, 172, "Hotel Services" );
	ModelBrowser_AddData(playerid, 173, "San Fierro Rifa" );
	ModelBrowser_AddData(playerid, 174, "San Fierro Rifa" );
	ModelBrowser_AddData(playerid, 175, "San Fierro Rifa" );
	ModelBrowser_AddData(playerid, 176, "Tatoo Shop" );
	ModelBrowser_AddData(playerid, 177, "Tatoo Shop" );
	ModelBrowser_AddData(playerid, 178, "Whore" );
	ModelBrowser_AddData(playerid, 179, "Ammu-Nation Salesmen" );
	ModelBrowser_AddData(playerid, 180, "Normal Ped" );
	ModelBrowser_AddData(playerid, 181, "Punker" );
	ModelBrowser_AddData(playerid, 182, "Normal Ped" );
	ModelBrowser_AddData(playerid, 183, "Normal Ped" );
	ModelBrowser_AddData(playerid, 184, "Normal Ped" );
	ModelBrowser_AddData(playerid, 185, "Normal Ped" );
	ModelBrowser_AddData(playerid, 186, "Normal Ped" );
	ModelBrowser_AddData(playerid, 187, "Buisnessman" );
	ModelBrowser_AddData(playerid, 188, "Normal Ped" );
	ModelBrowser_AddData(playerid, 189, "Valet" );
	ModelBrowser_AddData(playerid, 190, "Barbara Schternvart" );
	ModelBrowser_AddData(playerid, 191, "Helena Wankstein" );
	ModelBrowser_AddData(playerid, 192, "Michelle Cannes" );
	ModelBrowser_AddData(playerid, 193, "Katie Zhan" );
	ModelBrowser_AddData(playerid, 194, "Millie Perkins" );
	ModelBrowser_AddData(playerid, 195, "Denise Robinson" );
	ModelBrowser_AddData(playerid, 196, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 197, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 198, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 199, "Farm-Town inhabitant" );
	ModelBrowser_AddData(playerid, 200, "Farmer" );
	ModelBrowser_AddData(playerid, 201, "Farmer" );
	ModelBrowser_AddData(playerid, 202, "Farmer" );
	ModelBrowser_AddData(playerid, 203, "Karate Teacher" );
	ModelBrowser_AddData(playerid, 204, "Karate Teacher" );
	ModelBrowser_AddData(playerid, 205, "Burger Shot Cashier" );
	ModelBrowser_AddData(playerid, 206, "Normal Ped" );
	ModelBrowser_AddData(playerid, 207, "Prostitute" );
	ModelBrowser_AddData(playerid, 208, "Well Stacked Pizza" );
	ModelBrowser_AddData(playerid, 209, "Normal Ped" );
	ModelBrowser_AddData(playerid, 210, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 211, "Shop Staff" );
	ModelBrowser_AddData(playerid, 212, "Homeless" );
	ModelBrowser_AddData(playerid, 213, "Weird old man" );
	ModelBrowser_AddData(playerid, 214, "Normal Ped" );
	ModelBrowser_AddData(playerid, 215, "Normal Ped" );
	ModelBrowser_AddData(playerid, 216, "Normal Ped" );
	ModelBrowser_AddData(playerid, 217, "Shop Staff" );
	ModelBrowser_AddData(playerid, 218, "Normal Ped" );
	ModelBrowser_AddData(playerid, 219, "Secretary" );
	ModelBrowser_AddData(playerid, 220, "Taxi Driver" );
	ModelBrowser_AddData(playerid, 221, "Normal Ped" );
	ModelBrowser_AddData(playerid, 222, "Normal Ped" );
	ModelBrowser_AddData(playerid, 223, "Normal Ped" );
	ModelBrowser_AddData(playerid, 224, "Sofori" );
	ModelBrowser_AddData(playerid, 225, "Normal Ped" );
	ModelBrowser_AddData(playerid, 226, "Normal Ped" );
	ModelBrowser_AddData(playerid, 227, "Normal Ped" );
	ModelBrowser_AddData(playerid, 228, "Normal Ped" );
	ModelBrowser_AddData(playerid, 229, "Normal Ped" );
	ModelBrowser_AddData(playerid, 230, "Homeless" );
	ModelBrowser_AddData(playerid, 231, "Normal Ped" );
	ModelBrowser_AddData(playerid, 232, "Normal Ped" );
	ModelBrowser_AddData(playerid, 233, "Normal Ped" );
	ModelBrowser_AddData(playerid, 234, "Normal Ped" );
	ModelBrowser_AddData(playerid, 235, "Normal Ped" );
	ModelBrowser_AddData(playerid, 236, "Normal Ped" );
	ModelBrowser_AddData(playerid, 237, "Prostitute" );
	ModelBrowser_AddData(playerid, 238, "Prostitute" );
	ModelBrowser_AddData(playerid, 239, "Homeless" );
	ModelBrowser_AddData(playerid, 240, "The D.A" );
	ModelBrowser_AddData(playerid, 241, "Afro-American" );
	ModelBrowser_AddData(playerid, 242, "Mexican" );
	ModelBrowser_AddData(playerid, 243, "Prostitute" );
	ModelBrowser_AddData(playerid, 244, "Whore" );
	ModelBrowser_AddData(playerid, 245, "Prostitute" );
	ModelBrowser_AddData(playerid, 246, "Whore" );
	ModelBrowser_AddData(playerid, 247, "Biker" );
	ModelBrowser_AddData(playerid, 248, "Biker" );
	ModelBrowser_AddData(playerid, 249, "Pimp" );
	ModelBrowser_AddData(playerid, 250, "Normal Ped" );
	ModelBrowser_AddData(playerid, 251, "Beach Visitor" );
	ModelBrowser_AddData(playerid, 252, "Naked Valet" );
	ModelBrowser_AddData(playerid, 253, "Bus Driver" );
	ModelBrowser_AddData(playerid, 254, "Drug Dealer" );
	ModelBrowser_AddData(playerid, 255, "Limo Driver" );
	ModelBrowser_AddData(playerid, 256, "Whore" );
	ModelBrowser_AddData(playerid, 257, "Whore" );
	ModelBrowser_AddData(playerid, 258, "Golfer" );
	ModelBrowser_AddData(playerid, 259, "Golfer" );
	ModelBrowser_AddData(playerid, 260, "Construction Site" );
	ModelBrowser_AddData(playerid, 261, "Normal Ped" );
	ModelBrowser_AddData(playerid, 262, "Taxi Driver" );
	ModelBrowser_AddData(playerid, 263, "Normal Ped" );
	ModelBrowser_AddData(playerid, 264, "Clown" );
	ModelBrowser_AddData(playerid, 265, "Tenpenny" );
	ModelBrowser_AddData(playerid, 266, "Pulaski" );
	ModelBrowser_AddData(playerid, 267, "Officer Frank Tenpenny (Crooked Cop)" );
	ModelBrowser_AddData(playerid, 268, "Dwaine" );
	ModelBrowser_AddData(playerid, 269, "Melvin Big Smoke Harris" );
	ModelBrowser_AddData(playerid, 270, "Sweet " );
	ModelBrowser_AddData(playerid, 271, "Lance Ryder Wilson" );
	ModelBrowser_AddData(playerid, 272, "Mafia Boss" );
	ModelBrowser_AddData(playerid, 273, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 274, "Paramedic" );
	ModelBrowser_AddData(playerid, 275, "Paramedic" );
	ModelBrowser_AddData(playerid, 276, "Paramedic" );
	ModelBrowser_AddData(playerid, 277, "Firefighter" );
	ModelBrowser_AddData(playerid, 278, "Firefighter" );
	ModelBrowser_AddData(playerid, 279, "Firefighter" );
	ModelBrowser_AddData(playerid, 280, "Los Santos Police" );
	ModelBrowser_AddData(playerid, 281, "San Fierro Police" );
	ModelBrowser_AddData(playerid, 282, "Las Venturas Police" );
	ModelBrowser_AddData(playerid, 283, "Country Sheriff" );
	ModelBrowser_AddData(playerid, 284, "San Andreas Police Dept." );
	ModelBrowser_AddData(playerid, 285, "S.W.A.T Special Forces" );
	ModelBrowser_AddData(playerid, 286, "Federal Agents" );
	ModelBrowser_AddData(playerid, 287, "San Andreas Army" );
	ModelBrowser_AddData(playerid, 288, "Desert Sheriff" );
	ModelBrowser_AddData(playerid, 289, "INVALID_SKIN_ID" );
	ModelBrowser_AddData(playerid, 290, "Ken Rosenberg" );
	ModelBrowser_AddData(playerid, 291, "Desert Sheriff" );
	ModelBrowser_AddData(playerid, 292, "Cesar Vialpando" );
	ModelBrowser_AddData(playerid, 293, "Jeffrey OG Loc Cross" );
	ModelBrowser_AddData(playerid, 294, "Wu Zi Mu (Woozie)" );
	ModelBrowser_AddData(playerid, 295, "Michael Toreno" );
	ModelBrowser_AddData(playerid, 296, "Jizzy B." );
	ModelBrowser_AddData(playerid, 297, "Madd Dogg" );
	ModelBrowser_AddData(playerid, 298, "Catalina" );
	ModelBrowser_AddData(playerid, 299, "Claude" );

	ModelBrowser_SetupTiles(playerid, "Skin List", "Skins_List");

	return true ;
}

mBrowser:Skins_List(playerid, response, row, model, name[]) {

	if ( ! response ) {

		SendClientMessage(playerid, -1, "SkinList: Negative response!");
	}

	else if ( response ) {

		SendClientMessage(playerid, -1, "SkinList: Positive response!");
	}

	new string [ 96 ] ;

	format ( string, sizeof ( string ), "SkinList: Selected row %d, having model %d and name %s.",
		row, model, name
	) ;

	SendClientMessage(playerid, -1, string);

	return true ;
}
*/