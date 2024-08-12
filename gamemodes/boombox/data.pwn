
enum E_BOOMBOX_DATA {
	E_BOOMBOX_ID,

	E_BOOMBOX_OWNER,
	E_BOOMBOX_STATION [ 128 ],

	Float: E_BOOMBOX_POS_X,
	Float: E_BOOMBOX_POS_Y,
	Float: E_BOOMBOX_POS_Z,
	Float: E_BOOMBOX_ROT_X,
	Float: E_BOOMBOX_ROT_Y,
	Float: E_BOOMBOX_ROT_Z,
	E_BOOMBOX_POS_INT,
	E_BOOMBOX_POS_VW,

	E_BOOMBOX_MODELID,
	E_BOOMBOX_TYPE,

	DynamicText3D: E_BOOMBOX_LABEL,
	E_BOOMBOX_OBJECTID,
	E_BOOMBOX_AREAID,
} ;

#if !defined MAX_BOOMBOXES
	#define MAX_BOOMBOXES	75
#endif

#if !defined INVALID_BOOMBOX_ID
	#define INVALID_BOOMBOX_ID	-1
#endif

#if !defined BOOMBOX_RADIUS
	#define BOOMBOX_RADIUS		( 25.0 )
#endif

new Boombox [ MAX_BOOMBOXES ] [ E_BOOMBOX_DATA ] ;

Boombox_CreateEntity(playerid, modelid, type, Float: x, Float: y, Float: z ) {


	if ( IsValidDynamicObject( PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ) {

		DestroyDynamicObject(  PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] ) ;
		PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = INVALID_OBJECT_ID ;
	}

	new boombox_id = Boombox_GetFreeEntity(); 

	if ( boombox_id == INVALID_BOOMBOX_ID ) {

		return SendClientMessage(playerid, -1, "Couldn't create boombox, server limit reached!" ) ;
	}

	new bool: found = false ;
	for ( new i, j = sizeof ( Boombox ) ; i < j ; i ++ ) {

		if ( Boombox [ i ] [ E_BOOMBOX_AREAID ] != INVALID_BOOMBOX_ID ) {
			
			if ( IsPointInDynamicArea(Boombox [ i ] [ E_BOOMBOX_AREAID ], x, y, z ) ) {

				SendClientMessage(playerid, COLOR_RED, "This boombox is too close to an existing boombox! Move it further away!" ) ;
				found = true ;
				break ;
			}
			
			else continue ;
		}

		else continue ;
	}

	if ( found ) {

		return false ;
	}

	Boombox [ boombox_id ] [ E_BOOMBOX_ID ] = boombox_id ;

	Boombox [ boombox_id ] [ E_BOOMBOX_OWNER ] = Character [ playerid ] [ E_CHARACTER_ID ] ; 
	Boombox [ boombox_id ] [ E_BOOMBOX_TYPE ] = type ; 

	Boombox [ boombox_id ] [ E_BOOMBOX_STATION ] [ 0 ] = EOS ;

	Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ] = x ;
	Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ] = y ;
	Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ] = z ;
	Boombox [ boombox_id ] [ E_BOOMBOX_POS_INT ] = GetPlayerInterior(playerid);
	Boombox [ boombox_id ] [ E_BOOMBOX_POS_VW ] = GetPlayerVirtualWorld(playerid) ;

	Boombox [ boombox_id ] [ E_BOOMBOX_MODELID ] = modelid ;

	PlayerVar [ playerid ] [ player_hasboombox ] = 0 ;
	PlayerVar [ playerid ] [ E_PLAYER_PLACE_BOOMBOX_ID ] = boombox_id ;
	PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ] = CreateDynamicObject(

		Boombox [ boombox_id ] [ E_BOOMBOX_MODELID ] ,
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_X ] ,
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_Y ] ,
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_Z ] ,
		0.0, 0.0, 0.0, 
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_VW ],
		Boombox [ boombox_id ] [ E_BOOMBOX_POS_INT ],
		-1 
	);

	EditDynamicObject(playerid,PlayerVar [ playerid ] [ E_PLAYER_PLACING_BOOMBOX ]);
	return true ;
}


Boombox_GetFreeEntity () {

	for ( new i, j = sizeof ( Boombox ) ; i < j ; i ++ ) {

		if ( Boombox [ i ] [ E_BOOMBOX_ID ] == INVALID_BOOMBOX_ID ) {

			return i ;
		}

		else continue ;
	}

	return INVALID_BOOMBOX_ID ;
}
Boombox_LoadEntities () {

	for ( new i, j = sizeof ( Boombox ) ; i < j ; i ++ ) {

		Boombox [ i ] [ E_BOOMBOX_ID ] = INVALID_BOOMBOX_ID ;
	}

	return INVALID_BOOMBOX_ID ;
}


Boombox_GetNearestEntity(playerid, Float: range = 2.5 ) {
	new Float: dis = 99999.99, Float: dis2, index = -1 ;

	for ( new i, j = sizeof ( Boombox ); i < j; i ++ ) {

		if ( Boombox [ i ] [ E_BOOMBOX_ID ] != INVALID_BOOMBOX_ID ) {

			dis2 = GetPlayerDistanceFromPoint(playerid, 
				Boombox [ i ] [ E_BOOMBOX_POS_X ], 
				Boombox [ i ] [ E_BOOMBOX_POS_Y ], 
				Boombox [ i ] [ E_BOOMBOX_POS_Z ]
			);

			if(dis2 < dis && GetPlayerInterior ( playerid ) == Boombox [ i ] [ E_BOOMBOX_POS_INT ] && 
				GetPlayerVirtualWorld(playerid) == Boombox [ i ] [ E_BOOMBOX_POS_VW ] ) {

	            dis = dis2;
	            index = i;
			}
		}

		else continue ;
	}

	if ( dis <= range ) {

		return index;
	}

	return INVALID_BOOMBOX_ID ;
}