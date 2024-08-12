#define COLOR_FURNITURE	0x7F75A6FF

// data
#include "furniture/furni.pwn" // mats / obj
#include "furniture/data.pwn" // saving

#include "furniture/objects.pwn" // object stuff
#include "furniture/textures.pwn" // texture stuff


#include "furniture/interiors.pwn" // blank ints

//#include "furniture/html.pwn" // prints page

Furniture_IncrementPropLimit ( playerid, property_sql ) {

	new index = -1 ;

	foreach(new i: Properties) {

		if ( Property [ i ] [ E_PROPERTY_ID ] == property_sql ) {

			index = i ;
		}

		else continue ;
	}

	if ( index == -1 ) {

		return false ;
	}

	if ( Property [ index ] [ E_PROPERTY_FURNI_LIMIT ] >= MAX_FURNITURE ) {

		return false ;
	}

	Property [ index ] [ E_PROPERTY_FURNI_LIMIT ] ++ ;

	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE properties SET property_furni_limit = %d WHERE property_id = %d",
		Property [ index ] [ E_PROPERTY_FURNI_LIMIT ], Property [ index ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	query [ 0 ] = EOS ;

	format ( query, sizeof ( query ), "Furniture added to property stock; you are currently using %d/%d furniture slots.",
		Property [ index ] [ E_PROPERTY_FURNI_LIMIT ], MAX_FURNITURE ) ;

	SendServerMessage ( playerid, COLOR_YELLOW, "Furniture", "DEDEDE", query);

	return true ;
}

Furniture_DecreasePropLimit ( playerid, property_sql ) {

	new index = -1 ;

	foreach(new i: Properties) {

		if ( Property [ i ] [ E_PROPERTY_ID ] == property_sql ) {

			index = i ;
		}

		else continue ;
	}

	if ( index == -1 ) {

		return false ;
	}


	Property [ index ] [ E_PROPERTY_FURNI_LIMIT ] -- ;

	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE properties SET property_furni_limit = %d WHERE property_id = %d",
		Property [ index ] [ E_PROPERTY_FURNI_LIMIT ], Property [ index ] [ E_PROPERTY_ID ]
	);

	mysql_tquery(mysql, query);

	query [ 0 ] = EOS ;

	format ( query, sizeof ( query ), "Furniture removed from property stock; you are currently using %d/%d furniture slots.",
		Property [ index ] [ E_PROPERTY_FURNI_LIMIT ], MAX_FURNITURE ) ;

	SendServerMessage ( playerid, COLOR_YELLOW, "Furniture", "DEDEDE", query);

	return true ;
}

Furniture_SetPlayerVariables(playerid) {
	PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] = INVALID_PROPERTY_ID ;

	PlayerVar [ playerid ] [ E_FURNI_EDITING_OBJECT ] = false ;
	PlayerVar [ playerid ] [ E_FURNI_EDITING_EXTRAID ] = -1 ;
	PlayerVar [ playerid ] [ E_FURNI_EDITING_OBJECTID ] = -1 ;
}

CMD:furnimode(playerid) {

	new index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( index == INVALID_PROPERTY_ID ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You must be inside your property, near the door." );
		return true ;
	}
	
	if ( Property [ index ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] && PlayerVar [ playerid ] [ E_PLAYER_FURNI_PERM ] != Property [ index ] [ E_PROPERTY_ID ] ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You need permission from the property's owner to do this." );
	}

	if ( IsPlayerInRangeOfPoint ( playerid, 5.0, Property [ index ] [ E_PROPERTY_INT_X ], Property [ index ] [ E_PROPERTY_INT_Y ], Property [ index ] [ E_PROPERTY_INT_Z ] )) {

		PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] = Property [ index ] [ E_PROPERTY_ID ] ;

		new string [ 256 ] ;

		format ( string, sizeof ( string ), "You've enabled furniture mode on property ID %d (sql %d).", index, Property [ index ] [ E_PROPERTY_ID ] ) ;

		SendServerMessage ( playerid, COLOR_FURNITURE, "Furniture", "DEDEDE", string );

		return true ;
	}

	return true ;
}

CMD:furni(playerid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You're not in furniture mode! Head to the EXIT point and do /furnimode. (don't do /exit).");
	}
		
	if ( GetPlayerVirtualWorld(playerid) == 0 ) {

		CancelEdit(playerid);
		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE",  "You can't create furniture outside a house!" ) ;
	}

	Furni_ListCategory(playerid);

	return true ;
}

CMD:furniedit(playerid) {
	if ( PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You're not in furniture mode! Head to the EXIT point and do /furnimode. (don't do /exit).");
	}

	SendServerMessage ( playerid, COLOR_FURNITURE, "Furniture", "DEDEDE", "Select a furniture item you wish to edit using the 3D mouse. You can only select furniture items." ) ;

	SelectObject(playerid);

	return true ;
}

CMD:furnilist(playerid, params[]) {

	new Float: yards ;

	if ( sscanf ( params, "f", yards ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "/furnilist [yards]{A3A3A3} (min: 2.5 / max: 15.0)");
	}
	
	if ( yards < 2.5 || yards > 15.0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "/furnilist [yards]{A3A3A3} (min: 2.5 / max: 15.0)");
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] == INVALID_PROPERTY_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You're not in furniture mode! Head to the EXIT point and do /furnimode. (don't do /exit).");
	}

	new index [ MAX_FURNITURE ], index_count = 0, index_max = 20, bool: max_limit ;

	new string [ 2048 ] ;
    strcat(string, "Index\tModel\tName\tDistance\n");

    new furni_id, furni_name [ 64 ], Float: dist = 0.0 ;
	for(new i, j = sizeof ( Furniture ); i < j ; i ++ ) {

		if(index_count <= index_max ) {
			if ( GetPlayerDistanceFromPoint(playerid, Furniture [ i ] [ E_FURNI_POS_X ], 
				Furniture [ i ] [ E_FURNI_POS_Y ], Furniture [ i ] [ E_FURNI_POS_Z ]) < yards ) {

				if ( PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] == Furniture [ i ] [ E_FURNI_EXTRA_ID ] ) {

					furni_id = Furniture_FetchIDFromModel ( Furniture [ i ] [ E_FURNI_MODEL ] ) ;
					Furniture_FetchName(furni_id, furni_name, sizeof(furni_name)) ;

					dist = GetPlayerDistanceFromPoint(playerid, 
						Furniture [ i ] [ E_FURNI_POS_X ], Furniture [ i ] [ E_FURNI_POS_Y ], Furniture [ i ] [ E_FURNI_POS_Z ]);

					format(string, sizeof(string), "%s(index %d) \t %d \t %s \t %0.2f yds\n", string, 
						i, Furniture [ i ] [ E_FURNI_MODEL ], furni_name, dist
					); 

					index [ index_count ] = i;
					index_count ++ ; 
				}
			}
		}
		else {
			max_limit = true ;
		}
	}

	if ( max_limit) {

		SendClientMessage(playerid, COLOR_YELLOW, sprintf("Found more than %d results, but only showing the first %d results.", index_count, index_max));
	}

	inline furni_list_display(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = index [ listitem ];

		if ( ! response ) {

			return true ;
		}

		if ( response ) {



			furni_id = Furniture_FetchIDFromModel ( Furniture [ selection ] [ E_FURNI_MODEL ] ) ;
			Furniture_FetchName(furni_id, furni_name, sizeof(furni_name)) ;

			format(string, sizeof(string), "Selected index %d with model %d and name %s", 
				selection, Furniture [ selection ] [ E_FURNI_MODEL ], furni_name
			); 

			SendServerMessage ( playerid, COLOR_FURNITURE, "Furniture", "DEDEDE", string ) ;

			new objectid = Furniture [ selection ] [ E_FURNI_OBJECTID ] ;
			new extra_id = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID) ;

			Furniture_ViewMenu(playerid, objectid, extra_id ) ;

			return true ;
		}
	}

	Dialog_ShowCallback ( playerid, using inline furni_list_display, DIALOG_STYLE_TABLIST_HEADERS, sprintf("All furniture within %f yards", yards), string, "Select", "Back" ) ;

	return true ;
}

CMD:furniwipe(playerid) {

	new index = Property_GetClosestEntity( playerid, PROPERTY_NEAR_EXIT ) ;

	if ( index == INVALID_PROPERTY_ID ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "You must be inside your property, near the door." );
		return true ;
	}
	
	if ( Property [ index ] [ E_PROPERTY_OWNER ] != Character [ playerid ] [ E_CHARACTER_ID ] ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Furniture", "DEDEDE", "Only the property owner can do this." );
	}

	if ( IsPlayerInRangeOfPoint ( playerid, 5.0, Property [ index ] [ E_PROPERTY_INT_X ], Property [ index ] [ E_PROPERTY_INT_Y ], Property [ index ] [ E_PROPERTY_INT_Z ] )) {


		Furniture_WipeAllContent ( playerid, Property [ index ] [ E_PROPERTY_ID ] ) ;
	}

	return true ;
}

Furniture_WipeAllContent(playerid, property_sql_id ) {
	new query [ 256 ], total_refund ;

	for ( new i, j = sizeof ( Furniture ); i < j ; i ++ ) {

		if ( Furniture [ i ] [ E_FURNI_SQL_ID ] != -1 ) {

			if ( Furniture [ i ] [ E_FURNI_EXTRA_ID ] == property_sql_id ) {

				if ( IsValidDynamicObject(Furniture [ i ] [ E_FURNI_OBJECTID ] ) ) {

					DestroyDynamicObject( Furniture [ i ] [ E_FURNI_OBJECTID ] ) ;
					Furniture [ i ] [ E_FURNI_OBJECTID ] = -1 ;
				}

				mysql_format(mysql, query, sizeof(query), "DELETE FROM furniture WHERE furniture_sqlid = %d", Furniture [ i ] [ E_FURNI_SQL_ID ] ) ;
				mysql_tquery(mysql, query);

				total_refund += Furniture_GetPrice(i);

				Furniture [ i ] [ E_FURNI_SQL_ID ] = -1 ;
				Furniture [ i ] [ E_FURNI_EXTRA_ID ] = -1 ;
			}

			else continue ;
		}

		else continue ;
	}

	new property_index = INVALID_PROPERTY_ID ;

	foreach(new i: Properties) {
		if ( Property [ i ] [ E_PROPERTY_ID ] == property_sql_id ) {

			Property [ i ] [ E_PROPERTY_FURNI_LIMIT ] = 0 ;

			mysql_format(mysql, query, sizeof ( query ), "UPDATE properties SET property_furni_limit = 0 WHERE property_id = %d",
				Property [ i ] [ E_PROPERTY_ID ]
			);

			mysql_tquery(mysql, query);

			property_index = i ;

			break ;
		}

		else continue ;
	}

	if ( IsPlayerConnected ( playerid ) ) {

		total_refund = total_refund / 2;
		
		SendClientMessage(playerid, COLOR_YELLOW, 
			sprintf("All your furniture has been wiped. You have been refunded $%s (half the total value of the items).",
				IntegerWithDelimiter ( total_refund ) 
			) 
		) ;

		GivePlayerCash ( playerid, total_refund ) ;
		total_refund = 0 ;
	}

	else if ( ! IsPlayerConnected ( playerid ) ) {

		if ( property_index != INVALID_PROPERTY_ID ) {

			mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_soldfurni=%d WHERE player_id = %d", 
				total_refund, Property [ property_index ] [ E_PROPERTY_OWNER ] ) ;
			mysql_tquery(mysql, query );
		}

	}
	
	return true ;
}

ptask FurniMode_Check[5000](playerid) {

	if ( IsPlayerLogged ( playerid ) && IsPlayerSpawned ( playerid ) ) {

		if ( PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] != INVALID_PROPERTY_ID ) {

			new Float: MAX_FURNI_MODE_RANGE = 150.0, bool: disclosed = false ;

			foreach(new i: Properties) {

				if ( PlayerVar [ playerid ] [ E_PLAYER_FURNI_MODE ] == Property [ i ] [ E_PROPERTY_ID ] ) {

					if ( IsPlayerInRangeOfPoint ( playerid, MAX_FURNI_MODE_RANGE, Property [ i ] [ E_PROPERTY_INT_X ], Property [ i ] [ E_PROPERTY_INT_Y ], Property [ i ] [ E_PROPERTY_INT_Z ] )) {
						if ( GetPlayerVirtualWorld(playerid) ==  Property [ i ] [ E_PROPERTY_ID ] && GetPlayerInterior ( playerid ) ==  Property [ i ] [ E_PROPERTY_INT_INT ] ) {

							disclosed = true ;
							break ;
						}

						else continue ;
					}

					else continue ;
				}

				else continue ;
			}

			if ( GetPlayerVirtualWorld(playerid) == 0 ) {

				disclosed=false;
			}

			if ( ! disclosed ) {
				SendServerMessage ( playerid, COLOR_FURNITURE, "Furniture", "DEDEDE", "You've travelled too far away from your furnimode point. It has been disabled." ) ;
			
				Furniture_SetPlayerVariables(playerid) ;
				CancelEdit(playerid);
			}
		}
	}
		
	return true ;
}
