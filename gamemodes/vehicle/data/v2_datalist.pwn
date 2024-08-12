/*
	Many useful functions for the new fuel script, paintjobs and more.
	Convert the old vehicle system to work with this.
*/

#if defined _mainvehicle_included
	#endinput
#endif
#define _mainvehicle_included

#define MAX_VEHICLE_MODELS					212

#if !defined IsValidVehicle
	native bool:IsValidVehicle(vehicleid);
#endif

// native bool:IsVehicleInNormalWorld(vehicleid); // Fake native
stock bool:IsVehicleInNormalWorld(vehicleid) {
	if(IsValidVehicle(vehicleid)) {
		if(GetVehicleVirtualWorld(vehicleid) == VIRTUAL_WORLD_NORMAL && GetVehicleInterior(vehicleid) == INTERIOR_NORMAL) {
			return true;
		}
	}
	return false;
}

// TRAINS
/**
 * -DESCRIPTION:
 * 		-Makes sure that trains are always created with AddStaticVehicleEx and not wrongly with CreateVehicle. Trains can only be added with AddStaticVehicle and AddStaticVehicleEx.
 */

// SPAWN PAINTJOBS
/**
 * -DESCRIPTION:
 * 		-Makes sure that the vehicle respawns with the paintjob it was given when it was first created.
 * -NOTES:
 * 		-Defaults to PAINTJOB_NONE.
 */
#define INVALID_PAINTJOB_ID					-1
#define PAINTJOB_NONE						3

// SYNCED RANDOM SP COLOURS
/**
 * -DESCRIPTION:
 * 		-Syncs random vehicle colours between players.
 * -NOTES:
 * 		-Using fixed vehicle colours is synced between players, however using -1 as a vehicle colour is not.
 * 		- -1 selects a random vehicle colour of possible known singleplayer values. Therefore it is not completely random with values like 0 to 127.
 * 		-The singleplayer values are always a pair of 2 (1 exception, see below), of which the first value is the always the first colour and the second value is always the second colour.
 * 		-When no know singplayer values are present, a single value of -1 is used.
 * 		-When both to be assigned vehicle colours are -1, a random pair will be chosen. The first colour will be the first value, the second colour the second value.
 * 		-When only the first to be assigned vehicle colour is -1, a random pair is still chosen, but only the first value will be used. The second colour is fixed.
 * 		-When only the second to be assigned vehicle colour is -1, a random pair is still chosen, but only the second value will be used. The first colour is fixed.
 * 		-In other words, the first value can not be used for the second colour and vice versa.
 * 		-We can sync these random colours with ChangeVehicleColor.
 * 		-Upon spawning, the -1 colours are assigned and synced with ChangeVehicleColor.
 * 		-Upon respawning, the -1 colours are chosen again and synced with ChangeVehicleColor.
 * 		-If only one colour was -1 upon first spawning, only that colour will be chosen again upon respawning. The other colour remains fixed.
 * 		-When a spawn paintjob is also used, the spawn colours won't affect the paintjob.
 * 		-Defaults to -1 for both colours.
 * -CREDITS:
 * 		-MP2: http://forum.sa-mp.com/showthread.php?t=339088
 */
#define INVALID_VEHICLE_COLOR_ID			-2 // -1 is used for synced random SP colours


static const MainVehicle_SPColours[][] = { // Data from singleplayer in pairs
	{4,1, 123,1, 113,1, 101,1, 75,1, 62,1, 40,1, 36,1, -1}, // Landstalker
	{41,41, 47,47, 52,52, 66,66, 74,74, 87,87,91,91, 113,113, -1}, // Bravura
	{10,10, 13,13, 22,22, 30,30, 39,39, 90,90, 98,98, 110,110, -1}, // Buffalo
	{36,1, 37,1, 30,1, 28,1, 25,1, 40,1, 101,1, 113,1, -1}, // Linerunner
	{113,39, 119,50, 123,92, 109,100, 101,101, 95,105, 83,110, 66,25, -1}, // Perennial
	{11,1, 24,1, 36,1, 40,1, 75,1, 91,1, 123,1, 4,1, -1}, // Landstalker
	{1,1, -1}, // Dumper
	{3,1, -1}, // Firetruck
	{26,26, -1}, // Trashmaster
	{1,1, -1}, // Stretch
	{4,1, 9,1, 10,1, 25,1, 36,1, 40,1, 45,1, 84,1, -1}, // Manana
	{12,1, 64,1, 123,1, 116,1, 112,1, 106,1, 80,1, 75,1, -1}, // Infernus
	{9,1, 10,8, 11,1, 25,8, 27,1, 29,8, 30,1, 37,8, -1}, // Voodoo
	{87,1, 88,1, 91,1, 105,1, 109,1, 119,1, 4,1, 25,1, -1}, // Pony
	{25,1, 28,1, 43,1, 67,1, 72,1, 9,1, 95,1, 24,1, -1}, // Mule
	{20,1, 25,1, 36,1, 40,1, 62,1, 75,1, 92,1, 0,1, -1}, // Cheetah
	{1,3, -1}, // Ambulance
	{0,0, -1}, // Leviathan
	{119,119, 117,227, 114,114, 108,108, 95,95, 81,81, 61,61, 41,41, -1}, // Moonbeam
	{45,75, 47,76, 33,75, 13,76, 54,75, 69,76, 59,75, 87,76, -1}, // Esperanto
	{6,1, -1}, // Taxi
	{4,1, 13,1, 25,1, 30,1, 36,1, 40,1, 75,1, 95,1, -1}, // Washington
	{96,25, 97,25, 101,25, 111,31, 113,36, 83,57, 67,59, -1}, // Bobcat
	{1,16, 1,56, 1,17, 1,53, 1,5, 1,35, -1}, // Mr.Whoopie/Mr.Whoopee
	{1,0, 2,2, 3,2, 3,6, 6,16, 15,30, 24,53, 35,61, -1}, // BF Injection
	{43,0, -1}, // Hunter
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Premier
	{0,1, -1}, // Enforcer
	{4,75, -1}, // Securicar
	{12,12, 13,13, 14,14, 1,2, 2,1, 1,3, 3,1, 10,10, -1}, // Banshee
	{46,26, -1}, // Predator
	{71,59, 75,59, 92,72, 47,74, 55,83, 59,83, 71,87, 82,87, -1}, // Bus
	{43,0, -1}, // Rhino
	{43,0, -1}, // Barracks
	{1,1, 12,12, 2,2, 6,6, 4,4, 46,46, 53,53, -1}, // Hotknife
	{1, 1, -1}, // Articulated Trailer 1
	{83,1, 87,1, 92,1, 95,1, 109,1, 119,45, 11,1, -1}, // Previon
	{54,7, 79,7, 87,7, 95,16, 98,20, 105,20, 123,20, 125,21, -1}, // Coach
	{6,76, -1}, // Cabbie
	{57,8, 8,17, 43,21, 54,38, 67,8, 37,78, 65,79, 25,78, -1}, // Stallion
	{34,34, 32,32, 20,20, 110,110, 66,66, 84,84, 118,118, 121,121, -1}, // Rumpo
	{2,96, 79,42, 82,54, 67,86, 126,96, 70,96, 110,54, 67,98, -1}, // RC Bandit
	{0,0, 11,105, 25,109, 36,0, 40,36, 75,36, 0,36, 0,109, -1}, // Romero
	{4,1, 20,1, 24,1, 25,1, 36,1, 40,1, 54,1, 84,1, -1}, // Packer
	{32,36, 32,42, 32,53, 32,66, 32,14, 32,32, -1}, // Monster
	{34,34, 35,35, 37,37, 39,39, 41,41, 43,43, 45,45, 47,47, -1}, // Admiral
	{-1}, // Squalo - 4 colors two of which can not be changed, will not be synced
	{75,2, -1}, // Seasparrow
	{3,6, -1}, // Pizzaboy
	{1,74, -1}, // Tram
	{1,1, -1}, // Articulated Trailer 2 [NO COLORS]
	{123,123, 125,125, 36,36, 16,16, 18,18, 46,46, 61,61, 75,75, -1}, // Turismo
	{1,3, 1,5, 1,16, 1,22, 1,35, 1,44, 1,53, 1,57, -1}, // Speeder
	{56,56, -1}, // Reefer
	{26,26, -1}, // Tropic
	{84,15, 84,58, 84,31, 32,74, 43,31, 1,31, 77,31, 32,74, -1}, // Flatbed
	{84,63, 91,63, 102,65, 105,72, 110,93, 121,93, 12,95, 23,1, -1}, // Yankee
	{58,1, 2,1, 63,1, 18,1, 32,1, 45,1, 13,1, 34,1, -1}, // Caddy
	{91,1, 101,1, 109,1, 113,1, 4,1, 25,1, 30,1, 36,1, -1}, // Solair
	{26,26, 28,28, 44,44, 51,51, 57,57, 72,72, 106,106, 112,112, -1}, // Berkley's RC Van (Topfun)
	{1,3, 1,9, 1,18, 1,30, 17,23, 46,23, 46,32, 57,34, -1}, // Skimmer
	{36,1, 37,1, 43,1, 53,1, 61,1, 75,1, 79,1, 88,1, -1}, // PCJ-600
	{12,12, 13,13, 14,14, 1,2, 2,1, 1,3, 3,1, 10,10, -1}, // Faggio
	{79,79, 84,84, 7,7, 11,11, 19,19, 22,22, 36,36, 53,53, -1}, // Freeway
	{14,75, -1}, // RC Baron
	{14,75, -1}, // RC Raider
	{67,76, 68,76, 78,76, 2,76, 16,76, 18,76, 25,76, 45,88, -1}, // Glendale
	{51,1, 58,8, 60,1, 68,8, 2,1, 13,8, 22,1, 36,8, -1}, // Oceanic
	{6,6, 46,46, 53,53, 3,3, -1}, // Sanchez
	{1,3, -1}, // Sparrow
	{43,0, -1}, // Patriot
	{120,117, 103,111, 120,114, 74,91, 120,112, 74,83, 120,113, 66,71, -1}, // Quad
	{56,15, 56,53, -1}, // Coastguard
	{56,15, 56,53, -1}, // Dinghy
	{97,1, 81,1, 105,1, 110,1, 91,1, 74,1, 84,1, 83,1, -1}, // Hermes
	{2,39, 9,39, 17,1, 21,1, 33,0, 37,0, 41,29, 56,29, -1}, // Sabre
	{6,7, 7,6, 1,6, 89,91, 119,117, 103,102, 77,87, 71,77, -1}, // Rustler
	{92,1, 94,1, 101,1, 121,1, 0,1, 22,1, 36,1, 75,1, -1}, // ZR-350
	{72,1, 66,1, 59,1, 45,1, 40,1, 39,1, 35,1, 20,1, -1}, // Walton
	{27,36, 59,36, 60,35, 55,41, 54,31, 49,23, 45,32, 40,29, -1}, // Regina
	{73,45, 12,12, 2,2, 6,6, 4,4, 46,46, 53,53, -1}, // Comet
	{1,1, 3,3, 6,6, 46,46, 65,9, 14,1, 12,9, 26,1, -1}, // BMX
	{41,41, 48,48, 52,52, 64,64, 71,71, 85,85, 10,10, 62,62, -1}, // Burrito
	{-1}, // Camper [4 colors - can not be synced]
	{12,35, 50,32, 40,26, 66,36, -1}, // Marquis
	{1,73, 1,74, 1,75, 1,76, 1,77, 1,78, 1,79, -1}, // Baggage
	{1,1, -1}, // Dozer
	{26,14, 29,42, 26,57, 54,29, 26,3, 3,29, 12,39, 74,35, -1}, // Maverick
	{2,26, 2,29, -1}, // News Macerick/News Helicopter
	{13,118, 14,123, 120,123, 112,120, 84,110, 76,102, -1}, // Rancher
	{0,0, -1}, // FBI Rancher
	{40,65, 71,72, 52,66, 64,72, 30,72, 60,72, -1}, // Virgo
	{30,26, 77,26, 81,27, 24,55, 28,56, 49,59, 52,69, 71,107, -1}, // Greenwood
	{36,13, -1}, // Jetmax
	{36,117, 36,13, 42,30, 42,33, 54,36, 75,79, 92,101, 98,109, -1}, // Hotring Racer
	{123,124, 119,122, 118,117, 116,115, 114,108, 101,106, 88,99, 5,6, -1}, // Sandking
	{74,72, 66,72, 53,56, 37,19, 22,22, 20,20, 9,14, 0,0, -1}, // Blista Compact
	{0,1, -1}, // Police Maverick/Police Helicopter
	{11,123, 13,120, 20,117, 24,112, 27,107, 36,105, 37,107, 43,93, -1}, // Boxville
	{109,25, 109,32, 112,32, 10,32, 30,44, 32,52, 84,66, 84,69, -1}, // Benson
	{75,84, 40,84, 40,110, 28,119, 25,119, 21,119, 13,119, 4,119, -1}, // Mesa
	{14,75, -1}, // RC Goblin
	{7,94, 36,88, 51,75, 53,75 ,58,67, 75,67, 75,61, 79,62, -1}, // Hotring Racer A
	{83,66, 87,74, 87,75, 98,83, 101,100, 103,101, 117,116, 123,36, -1}, // Hotring Racer B
	{51,39, 57,38, 45,29, 34,9, 65,9, 14,1, 12,9, 26,1, -1}, // Bloodring Banger
	{13,118, 14,123, 120,123, 112,120, 84,110, 76,102, -1}, // Rancher (LURE)
	{3,3, 6,6, 7,7, 52,52, 76,76, -1}, // Super GT
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Elegant
	{1,1, -1}, // Journey
	{7,1, 74,1, 61,1, 16,1, 25,1, 30,1, 36,1, 53,1, -1}, // Bike
	{43,43, 46,46, 39,39, 28,28, 16,16, 6,6, 5,5, 2,2, -1}, // Mountain Bike
	{3,90, 4,90, 7,68, 8,66, 12,60, 27,97, 34,51, 37,51, -1}, // Beagle
	{17,39, 15,123, 32,112, 45,88, 52,71, 57,67, 61,96, 96,96, -1}, // Cropduster
	{38,51, 21,36, 21,34, 30,34, 54,34, 55,20, 48,18, 51,6, -1}, // Stuntplane
	{10,1, 25,1, 28,1, 36,1, 40,1, 54,1, 75,1, 113,1, -1}, // Tanker
	{13,76, 24,77, 63,78, 42,76, 54,77, 39,78, 11,76, 62,77, -1}, // Roadtrain
	{116,1, 119,1, 122,1, 4,1, 9,1, 24,1, 27,1, 36,1, -1}, // Nebula
	{37,36, 36,36, 40,36, 43,41, 47,41, 51,72, 54,75, 55,84, -1}, // Majestic
	{2,39, 9,39, 17,1, 21,1, 33,0, 37,0, 41,29, 56,29, -1}, // Buccaneer
	{1,1, -1}, // Shamal
	{-1}, // Hydra [NO DATA FOUND]
	{74,74, 75,13, 87,118, 92,3, 115,118, 25,118, 36,0, 118,118, -1}, // FCR-900
	{3,3, 3,8, 6,25, 7,79, 8,82, 36,105, 39,106, 51,118, -1}, // NRG-500
	{-1}, // Cop Bike [NO DATA FOUND]
	{-1}, // Cement [4 colors - not synced]
	{1,1, 17,20, 18,20, 22,30, 36,43, 44,51, 52,54, -1}, // Towtruck
	{2,39, 9,39, 17,1, 21,1, 33,0, 37,0, 41,29, 56,29, -1}, // Fortune
	{52,1, 53,1, 66,1, 75,1, 76,1, 81,1, 95,1, 109,1, -1}, // Cadrona
	{-1}, // FBI Truck [ NO DATA FOUND]
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Willard
	{110,1, 111,1, 112,1, 114,1, 119,1, 122,1, 4,1, 13,1, -1}, // Forklift
	{2,35, 36,2, 51,53, 91,2, 11,22, 40,35, -1}, // Tractor
	{-1}, // Combine [NO DATA FOUND]
	{73,1, 74,1, 75,1, 77,1, 79,1, 83,1, 84,1, 91,1, -1}, // Feltzer
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Remington
	{3,1, 28,1, 31,1, 55,1, 66,1, 97,1, 123,1, 118,1, -1}, // Slamvan
	{9,1, 12,1, 26,96, 30,96, 32,1, 37,1, 57,96, 71,96, -1}, // Blade
	{1,1, -1}, // Freight
	{1,1, -1}, // Streak
	{96,67, 86,70, 79,74, 70,86, 61,98, 75,75, 75,91, -1}, // Vortex
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Vincent
	{51,1, 58,8, 60,1, 68,8, 2,1, 13,8, 22,1, 36,8, -1}, // Bullet
	{13,118, 24,118, 31,93, 32,92, 45,92, 113,92, 119,113, 122,113, -1}, // Clover
	{76,8, 32,8, 43,8, 67,8, 11,11, 8,90, 2,2, 83,13, -1}, // Sadler
	{3,1, -1}, // Firetruck LA (Ladder Truck)
	{50,1, 47,1, 44,96, 40,96, 39,1, 30,1, 28,96, 9,96, -1}, // Hustler
	{62,37, 78,38, 2,62, 3,87, 2,78, 113,78, 119,62, 7,78, -1}, // Intruder
	{122,1, 123,1, 125,1, 10,1, 24,1, 37,1, 55,1, 66,1, -1}, // Primo
	{1,1, -1}, // Cargobob
	{74,39, 72,39, 75,39, 79,39, 83,36, 84,36, 89,35, 91,35, -1}, // Tampa
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Sunrise
	{67,1, 72,1, 75,1, 83,1, 91,1, 101,1, 109,1, 20,1, -1}, // Merit
	{56,56, 49,49, 26,124, -1}, // Utility
	{38,9, 55,23, 61,74, 71,87, 91,87, 98,114, 102,119, 111,3, -1}, // Nevada
	{53,32, 15,32, 45,32, 34,30, 65,32, 14,32, 12,32, 43,32, -1}, // Yosemite
	{51,1, 58,1, 60,1, 68,1, 2,1, 13,1, 22,1, 36,1, -1}, // Windsor
	{1,1, -1}, // Monster A
	{1,1, -1}, // Monster B
	{112,1, 116,1, 117,1, 24,1, 30,1, 35,1, 36,1, 40,1, -1}, // Uranus
	{51,1, 58,8, 60,1, 68,8, 2,1, 13,8, 22,1, 36,8, -1}, // Jester
	{52,39, 9,39, 17,1, 21,1, 33,0, 37,0, 41,29, 56,29, -1}, // Sultan
	{57,8, 8,17, 43,21, 54,38, 67,8, 37,78, 65,79, 25,78, -1}, // Stratum
	{36,1, 35,1, 17,1, 11,1, 116,1, 113,1, 101,1, 92,1, -1}, // Elegy
	{1,6, -1}, // Raindance
	{-1}, // RC Tiger [NO DATA FOUND]
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Flash
	{109,1, 30,8, 95,1, 84,8, 83,1, 72,8, 71,1, 52,8, -1}, // Tahoma
	{97,96, 88,64, 90,96, 93,64, 97,96, 99,81, 102,114, 114,1, -1}, // Savanna
	{2,39, 9,39, 17,1, 21,1, 33,0, 37,0, 41,29, 56,29, -1}, // Bandito
	{1,1, -1}, // Freight Flat Carriage
	{1,1, -1}, // Streak Carriage
	{2,35, 36,2, 51,53, 91,2, 11,22, 40,35, -1}, // Kart
	{94,1, 101,1, 116,1, 117,1, 4,1, 25,1, 30,1, 37,1, -1}, // Mower
	{91,38, 115,43, 85,6, 79,7, 78,8, 77,18, 79,18, 86,24, -1}, // Duneride
	{26,26, -1}, // Sweeper
	{12,1, 19,96, 31,64, 25,96, 38,1, 51,96, 57,1, 66,96, -1}, // Broadway
	{67,1, 68,96, 72,1, 74,8, 75,96, 76,8, 79,1, 84,96, -1}, // Tornado
	{1,3, 8,7, 8,10, 8,16, 23,31, 40,44, -1}, // AT-400
	{1,1, -1}, // DFT-30
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Huntley
	{92,92, 81,81, 67,67, 66,66, 61,61, 53,53, 51,51, 47,47, 43,43, -1}, // Stafford
	{54,1, 58,1, 66,1, 72,1, 75,1, 87,1, 101,1, 36,1, -1}, // BF-400
	{41,10, 41,20, 49,11, 56,123, 110,113, 112,116, 114,118, 119,101, -1}, // Newsvan/news Van
	{1,1, -1}, // Tug
	{1,1, -1}, // Petrol Trailer
	{37,37, 42,42, 53,53, 62,62, 7,7, 10,10, 11,11, 15,15, -1}, // Emperor
	{119,1, 122,1, 8,1, 10,1, 13,1, 25,1, 27,1, 32,1, -1}, // Wayfarer
	{36,1, 40,1, 43,1, 53,1, 72,1, 75,1, 95,1, 101,1, -1}, // Euros
	{1,1, -1}, // Hotdog
	{37,37, 31,31, 23,23, 22,22, 7,7, 124,124, 114,114, 112,112, -1}, // Club
	{-1}, // Freight Box Carriage [NO DATA FOUND]
	{1,1, -1}, // Articulated Trailer 3
	{1,1, -1}, // Andromada
	{51,1, 58,8, 60,1, 68,8, 2,1, 13,8, 22,1, 36,8, -1}, // Dodo
	{-1}, // RC Cam [NO DATA FOUND]
	{112,20, -1}, // Launch
	{0,1, -1}, // Cop Car LSPD
	{0,1, -1}, // Cop Car SFPD
	{0,1, -1}, // Cop Car LVPD
	{0,1, -1}, // Cop Car Ranger (Police Ranger)
	{81,8, 32,8, 43,8, 67,8, 11,11, 8,90, 2,2, 83,13, -1}, // Picador
	{1,1, -1}, // Swatvan S.W.A.T Van
	{58,1, 69,1, 75,77, 18,1, 32,1, 45,45, 13,1, 34,1, -1}, // Alpha
	{58,1, 69,1, 75,77, 18,1, 32,1, 45,45, 13,1, 34,1, -1}, // Phoenix
	{67,76, 68,76, 78,76, 2,76, 16,76, 18,76, 25,76, 45,88, -1}, // Glendale Shit
	{61,8, 32,8, 43,8, 67,8, 11,11, 8,90, 2,2, 83,13, -1}, // Sadler Shit
	{-1}, // Baggage Box A [NO DATA FOUND]
	{-1}, // Baggage Box B [NO DATA FOUND]
	{1,1, -1}, // Tug Stairs
	{36,36, -1}, // Burglary Boxville
	{-1}, // Farm Plow Trailer [NO DATA FOUND]
	{-1} // Utility Trailer [NO DATA FOUND]
};

// NAMES
/**
 * -DESCRIPTION:
 * 		-Vehicle model names.
 * -CREDITS:
 * 		-Originally by Sacky and Gabriel 'Larcius' Cordes: https://raw.githubusercontent.com/Kaperstone/uf.inc/master/uf.inc
 * 		-Edited by Freaksken.
 */
#define MAX_VEHICLE_MODEL_NAME				21
static const MainVehicle_VehicleModelNames[][] = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perennial", "Sentinel", "Dumper", "Fire Truck", "Trashmaster", "Stretch", "Manana",
	"Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat",
	"Mr. Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife",
	"Articulated Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo",
	"Seasparrow", "Pizzaboy", "Tram", "Articulated Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
	"Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
	"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito",
	"Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer",
	"Sandking", "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B",
	"Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker",
	"Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck", "Fortune",
	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Brown Streak",
	"Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Fire Truck Ladder", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit",
	"Utility Van", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance",
	"RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway",
	"Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Tanker Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog",
	"Club", "Freight Box", "Articulated Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police (LS)", "Police (SF)",
	"Police (LV)", "Ranger", "Picador", "S.W.A.T.", "Alpha", "Phoenix", "Glendale (Damaged)", "Sadler (Damaged)", "Baggage Box A",
	"Baggage Box B", "Tug Stairs", "Boxville", "Farm Trailer", "Utility Trailer"
};

// GET VEHICLE MODEL NAME
/**
 * -DESCRIPTION:
 * 		-Get a vehicle model's name.
 * -PARAMETERS:
 * 		-modelid: The ID of the vehicle model to get the name of.
 * 		-name[]: An array into which to store the name, passed by reference.
 * 		-len: The length of the string that should be stored. Recommended to be MAX_VEHICLE_MODEL_NAME + 1.
 * -RETURN VALUES:
 * 		-name length: The function executed successfully.
 * 		-0: The function failed to execute. An invalid vehicle modelid was given.
 * -NOTES:
 * 		-Works like GetPlayerName so that the name is stored in the given string parameter.
 */
// native GetVehicleModelName(modelid, name[], len); // Fake native
stock GetVehicleModelName(modelid, name[], len=sizeof(name)) {
	if(modelid >= 400 && modelid <= 611) {
		return strmid(name, MainVehicle_VehicleModelNames[modelid - 400], 0, len, len);
	}
	return 0;
}

// SEAT COUNTS
/**
 * -DESCRIPTION:
 * 		-Vehicle model seat counts.
 * -CREDITS:
 * 		-MP2: http://forum.sa-mp.com/showthread.php?t=339088
 */
static const MainVehicle_ModelSeatCount[] = {
	// Comments indicate last vehicle on row
	4,2,2,2,4,4,1,2,2,4, // Stretch
	2,2,2,4,2,2,4,2,4,2, // Esperanto
	4,2,2,2,2,1,4,4,4,2, // Banshee
	1,9,1,2,2,1,2,9,4,2, // Stallion
	4,1,2,2,2,4,1,2,1,2, // Tram
	1,2,1,1,1,2,2,2,4,4, // Berkley's RC Van
	2,2,2,2,1,1,4,4,2,2, // Sparrow
	4,2,1,1,2,2,1,2,2,4, // Regina
	2,1,2,3,1,1,1,4,2,2, // Rancher
	4,2,4,1,2,2,2,4,4,2, // Benson
	2,1,2,2,2,2,2,4,2,1, // Bike
	1,2,1,1,2,2,4,2,2,1, // Shamal
	1,2,2,2,2,2,2,2,2,4, // Willard
	1,1,1,2,2,2,2,2,2,1, // Vortex
	4,2,2,2,2,2,4,4,2,2, // Tampa
	4,4,2,1,2,2,2,2,2,2, // Jester
	4,4,2,2,1,2,4,4,1,1, // Freight Trailer
	1,1,1,2,1,2,2,2,2,4, // Huntley
	4,2,4,1,1,4,2,2,2,2, // Club
	1,1,2,2,1,1,4,4,4,2, // Police Ranger
	2,2,2,2,4,2,1,1,1,4, // Boxville
	1,1					 // Utility Trailer
};

// GET VEHICLE MODEL SEAT COUNT
/**
 * -DESCRIPTION:
 * 		-Get a vehicle model's seat count.
 * -PARAMETERS:
 * 		-modelid: The ID of the vehicle model to get the seat count of.
 * -RETURN VALUES:
 * 		-valid seat count: The function executed successfully.
 * 		-0: The function failed to execute. An invalid vehicle modelid was given.
 */
// native GetVehicleModelSeatCount(modelid); // Fake native
stock GetVehicleModelSeatCount(modelid) {
	if(modelid >= 400 && modelid <= 611) {
		return MainVehicle_ModelSeatCount[modelid - 400];
	} else {
		return 0;
	}
}

// TYPES
/**
 * -DESCRIPTION:
 * 		-Vehicle types.
 * -CREDITS:
 * 		-Originally by YellowBlood and Gabriel 'Larcius' Cordes: https://raw.githubusercontent.com/Kaperstone/uf.inc/master/uf.inc
 * 		-Edited by Freaksken.
 */
#define INVALID_VEHICLE_TYPE				-1
enum {
	VEHICLE_TYPE_CAR,
	VEHICLE_TYPE_TRACTOR,
	VEHICLE_TYPE_BIKE,
	VEHICLE_TYPE_BICYCLE,
	VEHICLE_TYPE_QUAD,
	VEHICLE_TYPE_HOVERCRAFT,
	VEHICLE_TYPE_RC,
	VEHICLE_TYPE_BOAT,
	VEHICLE_TYPE_HELI,
	VEHICLE_TYPE_SEAHELI,
	VEHICLE_TYPE_PLANE,
	VEHICLE_TYPE_SEAPLANE,
	VEHICLE_TYPE_TRAIN,
	VEHICLE_TYPE_TRAILER
}

// GET VEHICLE MODEL TYPE
/**
 * -DESCRIPTION:
 * 		-Get a vehicle model's type.
 * -PARAMETERS:
 * 		-modelid: The ID of the vehicle model to get the type of.
 * -RETURN VALUES:
 * 		-valid VEHICLE_TYPE: The function executed successfully.
 * 		-INVALID_VEHICLE_TYPE: The function failed to execute. An invalid vehicle modelid was given.
 * -CREDITS:
 * 		-Originally by YellowBlood and Gabriel 'Larcius' Cordes: https://raw.githubusercontent.com/Kaperstone/uf.inc/master/uf.inc
 * 		-Edited by Freaksken.
 */
// native GetVehicleModelType(modelid); // Fake native
stock GetVehicleModelType(modelid) {
	switch(modelid) {
		case
		416, // ambulan
		445, // admiral
		602, // alpha
		568, // bandito
		429, // banshee
		499, // benson
		424, // bfinject
		536, // blade
		496, // blistac
		504, // bloodra
		422, // bobcat
		609, // boxburg
		498, // boxville
		401, // bravura
		575, // broadway
		518, // buccanee
		402, // buffalo
		541, // bullet
		482, // burrito
		431, // bus
		438, // cabbie
		457, // caddy
		527, // cadrona
		483, // camper
		524, // cement
		415, // cheetah
		542, // clover
		589, // club
		480, // comet
		596, // copcarla
		599, // copcarru
		597, // copcarsf
		598, // copcarvg
		578, // dft30
		486, // dozer
		507, // elegant
		562, // elegy
		585, // emperor
		427, // enforcer
		419, // esperant
		587, // euros
		490, // fbiranch
		528, // fbitruck
		533, // feltzer
		544, // firela
		407, // firetruk
		565, // flash
		455, // flatbed
		530, // forklift
		526, // fortune
		466, // glendale
		604, // glenshit
		492, // greenwoo
		474, // hermes
		434, // hotknife
		502, // hotrina
		503, // hotrinb
		494, // hotring
		579, // huntley
		545, // hustler
		411, // infernus
		546, // intruder
		559, // jester
		508, // journey
		571, // kart
		400, // landstal
		517, // majestic
		410, // manana
		551, // merit
		500, // mesa
		418, // moonbeam
		572, // mower
		423, // mrwhoop
		516, // nebula
		582, // newsvan
		467, // oceanic
		404, // peren
		603, // phoenix
		600, // picador
		413, // pony
		426, // premier
		436, // previon
		547, // primo
		489, // rancher
		479, // regina
		534, // remingtn
		505, // rnchlure
		442, // romero
		440, // rumpo
		475, // sabre
		543, // sadler
		605, // sadlshit
		495, // sandking
		567, // savanna
		428, // securica
		405, // sentinel
		535, // slamvan
		458, // solair
		580, // stafford
		439, // stallion
		561, // stratum
		409, // stretch
		560, // sultan
		550, // sunrise
		506, // supergt
		601, // swatvan
		574, // sweeper
		566, // tahoma
		549, // tampa
		420, // taxi
		459, // topfun
		576, // tornado
		451, // turismo
		558, // uranus
		540, // vincent
		491, // virgo
		412, // voodoo
		478, // walton
		421, // washing
		529, // willard
		555, // windsor
		456, // yankee
		554, // yosemite
		477, // zr350
		588, // hotdog
		437, // coach
		532, // combine
		433, // barracks
		414, // mule
		443, // packer
		470, // patriot
		432, // rhino
		525, // towtruck
		408, // trash
		406, // dumper
		573, // duneride
		444, // monster
		556, // monstera
		557 // monsterb
		: return VEHICLE_TYPE_CAR;

		case
		403, // linerun
		515, // rdtrain
		514, // petro
		531, // tractor
		485, // baggage
		583, // tug
		552 // utility
		: return VEHICLE_TYPE_TRACTOR;

		case
		581, // bf400
		523, // copbike
		462, // faggio
		521, // fcr900
		463, // freeway
		522, // nrg500
		461, // pcj600
		448, // pizzaboy
		468, // sanchez
		586 // wayfarer
		: return VEHICLE_TYPE_BIKE;

		case
		509, // bike
		481, // bmx
		510 // mtbike
		: return VEHICLE_TYPE_BICYCLE;

		case
		471 // quad
		: return VEHICLE_TYPE_QUAD;

		case
		539 // vortex
		: return VEHICLE_TYPE_HOVERCRAFT;

		case
		441, // rcbandit
		594, // rccam
		564, // rctiger
		501, // rcgoblin
		465, // rcraider
		464 // rcbaron
		: return VEHICLE_TYPE_RC;

		case
		472, // coastg
		473, // dinghy
		493, // jetmax
		595, // launch
		484, // marquis
		430, // predator
		453, // reefer
		452, // speeder
		446, // squalo
		454 // tropic
		: return VEHICLE_TYPE_BOAT;

		case
		548, // cargobob
		425, // hunter
		487, // maverick
		497, // polmav
		563, // raindanc
		469, // sparrow
		488 // vcnmav
		: return VEHICLE_TYPE_HELI;

		case
		417, // leviathn
		447 // seaspar
		: return VEHICLE_TYPE_SEAHELI;

		case
		592, // androm
		577, // at-400
		511, // beagle
		512, // cropdust
		593, // dodo
		520, // hydra
		553, // nevada
		476, // rustler
		519, // shamal
		513 // stunt
		: return VEHICLE_TYPE_PLANE;

		case
		460 // skimmer
		: return VEHICLE_TYPE_SEAPLANE;

		case
		590, // freibox
		569, // freiflat
		537, // freight
		538, // streak
		570, // streakc
		449 // tram
		: return VEHICLE_TYPE_TRAIN;

		case
		435, // artict1
		450, // artict2
		591, // artict3
		606, // bagboxa
		607, // bagboxb
		610, // farmtr1
		584, // petrotr
		608, // tugstair
		611 // utiltr1
		: return VEHICLE_TYPE_TRAILER;
	}
	return INVALID_VEHICLE_TYPE;
}

// GET VEHICLE DRIVER
/**
 * -DESCRIPTION:
 * 		-Get a vehicle's driver.
 * -PARAMETERS:
 * 		-vehicleid: The ID of the vehicle to get the driver of.
 * -RETURN VALUES:
 * 		-valid playerid: The function executed successfully.
 * 		-INVALID_PLAYER_ID:
 * 			-The function executed successfully. The vehicle doesn't have a driver.
 * 			-The function failed to execute. An invalid vehicleid was given.
 */
// native GetVehicleDriver(vehicleid); // Fake native
stock GetVehicleDriver(vehicleid) {
	if(IsValidVehicle(vehicleid)) {
		for(new playerid = 0, highestPlayerid = GetPlayerPoolSize(); playerid <= highestPlayerid; playerid++) {
			if(IsPlayerConnected(playerid) && IsPlayerInVehicle(playerid, vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
				return playerid;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

// IS VEHICLE UPSIDE DOWN
/**
 * -DESCRIPTION:
 * 		-Get whether a vehicle is upside down.
 * -PARAMETERS:
 * 		-vehicleid: The ID of the vehicle to get whether it is upside down.
 * -RETURN VALUES:
 * 		-true: The function executed successfully. The vehicle is upside down.
 * 		-false:
 * 			-The function executed successfully. The vehicle is right-side up.
 * 			-The function failed to execute. An invalid vehicleid was given.
 * -CREDITS:
 * 		-Hencz: http://forum.sa-mp.com/showthread.php?t=167669
 */
// native bool:IsVehicleUpsideDown(vehicleid); // Fake native
stock bool:IsVehicleUpsideDown(vehicleid) {
	if(IsValidVehicle(vehicleid)) {
		new Float:w, Float:x, Float:y, Float:z;
		GetVehicleRotationQuat(vehicleid, w, x, y, z);
		new Float:y2 = atan2(2 * ((y*z) + (w*x)), (w*w) - (x*x) - (y*y) + (z*z));
		return (y2 > 90 || y2 < -90);
	}
	return false;
}

// native ChangeVehicleColor(vehicleid, color1, color2); // Fake native
stock MainVehicle_ChangeVehicleColor(vehicleid, color1, color2) {
	new c1 = color1;
	new c2 = color2;
	if(IsValidVehicle(vehicleid)) {
		new modelid = GetVehicleModel(vehicleid);
		new lastIndex;
		for(lastIndex = 0; lastIndex < 20; lastIndex++) {
			if(MainVehicle_SPColours[modelid - 400][lastIndex] == -1) {
				break;
			}
		}

		// If the data from singleplayer is known and at least one colour is -1, choose a random pair
		if(lastIndex != 0 && (color1 == -1 || color2 == -1)) {
			// Get random pair
			new randomColor = random(lastIndex);

			// First color
			// An even value is color1, an odd value is color2
			// An odd and even value form a pair that will be used together if both colors are -1
			if(randomColor % 2 == 1) {
				randomColor--;
			}
			if(color1 == -1) {
				c1 = MainVehicle_SPColours[modelid - 400][randomColor];
			}

			// Second color
			++randomColor;
			if(color2 == -1) {
				c2 = MainVehicle_SPColours[modelid - 400][randomColor];
			}
		}
	}

	// SYNCED RANDOM SP COLOURS
	return ChangeVehicleColor(vehicleid, c1, c2);
}
#if defined _ALS_ChangeVehicleColor
	#undef ChangeVehicleColor
#else
	#define _ALS_ChangeVehicleColor
#endif
#define ChangeVehicleColor MainVehicle_ChangeVehicleColor