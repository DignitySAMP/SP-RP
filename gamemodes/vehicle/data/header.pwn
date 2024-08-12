#include "vehicle/data/data.pwn"
#include "vehicle/data/data_type.pwn"
#include "vehicle/data/func.pwn"
#include "vehicle/data/native.pwn"
#include "vehicle/data/hooks.pwn"

#include "vehicle/data/cmds/header.pwn"


stock Vehicle_PlayRandomEvent(playerid, cooldown=true) {
	if ( cooldown ) {

		if ( PlayerVar [ playerid ] [ E_PLAYER_CAR_RANDOM_EVENT_CD ] > gettime () ) {

			return true ;
		}
	}

	new vehicleid = GetPlayerVehicleID(playerid);

	if ( IsABike(vehicleid) || IsAircraft(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid) ) {

		return true ;
	}

	new money, name[64], extra[64], loc[64] ;


	switch ( random ( 45 ) ) {

		// Found cash when entering car
		case 0 .. 15 : { 

			money = 15 + random ( 50 ) ;

			switch ( random ( 3 ) ) {

				case 0:format(name, sizeof(name), "small leather wallet" ) ;
				case 1:format(name, sizeof(name), "ripped envelope" ) ;
				case 2:format(name, sizeof(name), "money clip" ) ;
			}
			switch ( random ( 4 ) ) {

				case 0: {
					format(extra, sizeof(extra), "Under" ) ;
					format(loc, sizeof(loc), "driver's seat" ) ;
				}

				case 1: {

					format(extra, sizeof(extra), "on" ) ;
					format(loc, sizeof(loc), "dashboard" ) ;
				}

				case 2: {

					format(extra, sizeof(extra), "in" ) ;
					format(loc, sizeof(loc), "glove compartment" ) ;
				}

				default: {

					format(extra, sizeof(extra), "beneath some rubble on" ) ;
					format(loc, sizeof(loc), "floor" ) ;
				}
			}

			GivePlayerCash ( playerid, money ) ;
			SendClientMessage(playerid, COLOR_INFO, sprintf("You found $%s in a %s %s the %s.", IntegerWithDelimiter(money), name, extra, loc )) ;
		}
		// Discount cards
		case 16 .. 30 : { 
			money = 5 + random ( 25 ) ;

			switch ( random ( 4 ) ) {

				case 0: format(name, sizeof(name), "Burgershot" ) ;
				case 1: format(name, sizeof(name), "Cluckin' Bell" ) ;
				case 2: format(name, sizeof(name), "Pizza Stack" ) ;
				default:  format(name, sizeof(name), "Rusty's Donuts" ) ;
			}

			switch ( random ( 4 ) ) {

				case 0:{
					format(extra, sizeof(extra), "Under some trash on" ) ;
					format(loc, sizeof(loc), "dashboard" ) ;
				}
				case 1:{
					format(extra, sizeof(extra), "in an empty wrapper on" ) ;
					format(loc, sizeof(loc), "dusty carpet" ) ;
				}
				case 2:{
					format(extra, sizeof(extra), "ontop of the car's registration" ) ;
					format(loc, sizeof(loc), "glove compartment" ) ;
				}
				default: {

					format(extra, sizeof(extra), "beneath some clothing on" ) ;
					format(loc, sizeof(loc), "rear seat" ) ;
				}
			}

			SendClientMessage(playerid, COLOR_INFO, sprintf("You found a %s discount card of $%s %s the %s.", 
				name, IntegerWithDelimiter(money), extra, loc )) ;
		}

		// Miscalleneous
		case 31 .. 45 : { 

			switch ( random ( 6 ) ) {

				case 0: format(name, sizeof(name), "worn dice" ) ;
				case 1: format(name, sizeof(name), "cut out picture of Candy Suxxx" ) ;
				case 2: format(name, sizeof(name), "piece of a treasure map" ) ;

				case 3: format(name, sizeof(name), "zip bag named \"for b1g smok3\"" ) ;
				case 4: format(name, sizeof(name), "old picture of Old Reece and Emmet" ) ;
				case 5: format(name, sizeof(name), "newspaper with the headliner \"Tenpenny Killed in Accident\"" ) ;
			}

			switch ( random ( 3 ) ) {

				case 0: {
					format(extra, sizeof(extra), "Under some ash in" ) ;
					format(loc, sizeof(loc), "ashtray" ) ;
				}
				case 1:{
					format(extra, sizeof(extra), "hanging down" ) ;
					format(loc, sizeof(loc), "rear-view mirror" ) ;
				}
				case 2:{
					format(extra, sizeof(extra), "in the folds of" ) ;
					format(loc, sizeof(loc), "passenger seat" ) ;
				}
			}

			SendClientMessage(playerid, COLOR_INFO, sprintf("You found a %s %s the %s.", 
				name, extra, loc )) ;
		}
	}

	PlayerVar [ playerid ] [ E_PLAYER_CAR_RANDOM_EVENT_CD ]  = gettime () + 180 ; // triggerable ever 3 min

	return true ;
}