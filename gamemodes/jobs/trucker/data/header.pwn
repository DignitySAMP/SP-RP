#include "jobs/trucker/data/items.pwn"
#include "jobs/trucker/data/stores.pwn"
#include "jobs/trucker/data/wholesaler.pwn"


CMD:transport(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || !IsTruckingVehicle(GetPlayerVehicleID(playerid))) {
		return SendClientMessage(playerid, -1, "You have to be in a vehicle suitable for this work!");
	}


	inline TruckerMenu_Menu(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, inputtext

		if(response) {
			new string[1536], line[144];
			if(listitem == 0) { // wholesalers

				for(new w = 0; w < sizeof(Wholesalers); w++) {
					format(line, sizeof(line), "{ffff99}%s\t{bfbfbf}%s\n", Wholesalers[w][E_WHOLESALERS_DESC], GetGoodsFromWholesaler(w));
					strcat(string, line);
				}

				inline TruckerMenu_List(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
					#pragma unused dialogidx, pidx, inputtextx
					if(!responsex) {

						cmd_transport(playerid);
					}

					else if(responsex) {

						new wholesaler_id = listitemx;
						GPS_MarkLocation ( playerid, "The ~g~wholesaler~w~ has been marked on your ~g~minimap~w~.", E_GPS_COLOR_JOB, Wholesalers[wholesaler_id][E_WHOLESALERS_POS_X], Wholesalers[wholesaler_id][E_WHOLESALERS_POS_Y], Wholesalers[wholesaler_id][E_WHOLESALERS_POS_Z]  ) ;

					}
				}

				Dialog_ShowCallback ( playerid, using inline TruckerMenu_List, DIALOG_STYLE_TABLIST, "Wholesalers", string, "Select", "Cancel" );
			}

			else { // companies

				for(new w = 0; w < sizeof(TruckingStores); w++) {
					format(line, sizeof(line), "{ffff99}%s\t{bfbfbf}%s\n", TruckingStores[w][E_TRUCK_STORE_DESC], GetGoodsFromStores(w));
					strcat(string, line);
				}

				inline TruckerMenu_Stores(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
					#pragma unused dialogidx, pidx, inputtextx

					if(!responsex) {

						cmd_transport(playerid);
					}

					else if(responsex) {

						new store_id = listitemx;						

						GPS_MarkLocation ( playerid, "The ~g~goods buyer~w~ has been marked on your ~g~minimap~w~.", E_GPS_COLOR_JOB, TruckingStores[store_id][E_TRUCK_STORE_POS_X], TruckingStores[store_id][E_TRUCK_STORE_POS_Y], TruckingStores[store_id][E_TRUCK_STORE_POS_Z] ) ;

					}
				}

				Dialog_ShowCallback ( playerid, using inline TruckerMenu_Stores,DIALOG_STYLE_TABLIST, "Buyers", string, "Select", "Cancel" );

			}
		}

		return true ;
	}

	Dialog_ShowCallback ( playerid, using inline TruckerMenu_Menu, DIALOG_STYLE_TABLIST, "Salers and Buyers", "Wholesalers\nBuyer Companies", "Select", "Cancel" );
	return 1;
}