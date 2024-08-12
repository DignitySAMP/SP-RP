enum E_PLAYER_DRUGS_DATA {

	E_PLAYER_DRUG_SQLID,
	E_PLAYER_DRUG_TYPE,
	E_PLAYER_DRUG_PARAM,

	E_PLAYER_DRUG_CONTAINER,
	Float: E_PLAYER_DRUG_AMOUNT
} ;

#define MAX_PLAYER_DRUGS ( 15 )
new PlayerDrugs [ MAX_PLAYERS ] [ MAX_PLAYER_DRUGS ] [ E_PLAYER_DRUGS_DATA ] ;


PlayerDrugs_GetFreeID(playerid) {

	for ( new i, j = MAX_PLAYER_DRUGS; i < j ; i ++ ) {

		if ( PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_TYPE ] == 0 ) {

			return i ;
		}

		else continue ;
	}

	return INVALID_DRUG_ID ;
}

Drugs_LoadEntities_PlayerDrugs(playerid) {

  	new query [ 1024 ] ;

	for ( new i, j = MAX_PLAYER_DRUGS ; i < j ; i ++ ) {
		PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_SQLID ] 		= INVALID_DRUG_ID ;
		PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_TYPE ] 		= 0 ;
		PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_PARAM ] 		= 0 ;

		PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_CONTAINER ] 	= 0 ;
		PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_AMOUNT ] 	= 0.0 ;
	}

    inline DrugLoadPlayerDrugs() {
        if (!cache_num_rows()) {
        	for ( new i, j = MAX_PLAYER_DRUGS ; i < j ; i ++ ) {
        		mysql_format(mysql, query, sizeof ( query ), "INSERT INTO drugs_player_owned(player_drug_index, player_drug_characterid, \
        			player_drug_type, player_drug_param, player_drug_container, player_drug_amount) VALUES \
        			(%d, %d, 0, 0, 0, 0)", i, Character [ playerid ] [ E_CHARACTER_ID ]
        		);

        		mysql_tquery(mysql, query); 
        	}
        } else {
        	for ( new i, r = cache_num_rows(); i < r; ++i) {
				cache_get_value_name_int (i, "player_drug_sqlid", PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_SQLID ]);
				cache_get_value_name_int (i, "player_drug_type", PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_TYPE ]);
				cache_get_value_name_int (i, "player_drug_param", PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_PARAM ]);
				cache_get_value_name_int (i, "player_drug_container", PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_CONTAINER ]);
				cache_get_value_name_float (i, "player_drug_amount", PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_AMOUNT ]);
		 	}
        }
    }

    mysql_format(mysql, query, sizeof ( query ), "SELECT * FROM drugs_player_owned WHERE player_drug_characterid = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
    MySQL_TQueryInline(mysql, using inline DrugLoadPlayerDrugs, query, "" ) ;
}

PlayerDrugs_Save(playerid) {

	new query [ 1024 ] ;

	for ( new i, j = MAX_PLAYER_DRUGS ; i < j ; i ++ ) {

		mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_owned SET player_drug_type=%d,player_drug_param=%d,\
			player_drug_container=%d,player_drug_amount=%0.3f WHERE player_drug_characterid=%d AND player_drug_index=%d",
			PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_TYPE ], PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_PARAM ],
			PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_CONTAINER ], PlayerDrugs [ playerid ] [ i ] [ E_PLAYER_DRUG_AMOUNT ],
			Character [ playerid ] [ E_CHARACTER_ID ], i
		);

		//print(query);
		mysql_tquery(mysql, query); 
	}
}