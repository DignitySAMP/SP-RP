enum E_CRACK_DATA {

	E_CRACK_TYPE,
	E_CRACK_NAME [ 32 ],
	E_CRACK_MAX_ROCKS,
	Float: E_CRACK_ARMOUR,

	Float: E_CRACK_MIN_HAUL,
	Float: E_CRACK_MAX_HAUL,

	E_CRACK_TICKS,
	E_CRACK_HEX
} ;

enum {
	E_CRACK_TYPE_NONE = 0,
	E_CRACK_TYPE_MOON_ROCKS,
	E_CRACK_TYPE_GRAVEL_BALLS,
	E_CRACK_TYPE_BOULDER_CAKES,
	E_CRACK_TYPE_TORNADO_CRACK
}

new Crack [ ] [ E_CRACK_DATA ] = {
	{ E_CRACK_TYPE_NONE, 			"None", 		 -1, 0.0, 2.5, 15.0, 600, 0xFFFFFFFF },
	{ E_CRACK_TYPE_MOON_ROCKS,		"Moon Pebbles",	 5, 9.00, 2.0, 12.5,  600,  0x8AC2BFFF },
	{ E_CRACK_TYPE_GRAVEL_BALLS, 	"Gravel Balls",  4, 15.0, 1.5, 10.0, 1200, 0x98C2B4FF },
	{ E_CRACK_TYPE_BOULDER_CAKES, 	"Boulder Cakes", 3, 25.0, 1.0, 7.5,  1800, 0xC2B698FF },
	{ E_CRACK_TYPE_TORNADO_CRACK, 	"Tornado Rocks", 2, 35.0, 0.5, 5.0,  2400, 0xBFBCC8FF }
} ;

#define E_DRUG_CRACK_MODELID ( 19585 )

Crack_SetupGrowth ( enum_id ) {

	new drug_type = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;

	new max_rocks = Crack [ drug_type ] [ E_CRACK_MAX_ROCKS ] ;
	new rocks = 1 + random ( max_rocks ) ;

	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ] = rocks ;

	new Float: amount = frandom(Crack [drug_type][ E_CRACK_MIN_HAUL ], Crack [drug_type][ E_CRACK_MAX_HAUL ] );

	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ] = amount ;
	Drugs [ enum_id ] [ E_DRUG_STAGE ] = E_DRUG_STAGE_TICKS ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_int = %d, drug_growth_param_float_i = '%f', drug_stage = %d WHERE drug_sqlid = %d", 

		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ], Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ], Drugs [ enum_id ] [ E_DRUG_STAGE ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	Crack_SetupPlantVisuals ( enum_id ) ;
}

Crack_FinalizeGrowth( enum_id ) {

	if ( Drugs [ enum_id ] [ E_DRUG_STAGE ] == E_DRUG_STAGE_FINISH ) {

		new type = Drugs [ enum_id ] [  E_DRUG_PARAM ] ;
		new Float: final_haul = frandom(Crack [type][ E_CRACK_MIN_HAUL ], Crack [type][ E_CRACK_MAX_HAUL ] );
		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] = final_haul ;
		
		new query [ 256 ] ;

		mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_float_ii = '%f' WHERE drug_sqlid = %d", 

			Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
		) ;

		mysql_tquery(mysql, query);

		Crack_SetupPlantVisuals ( enum_id ) ;
	}
}

Crack_SetupPlantVisuals ( enum_id ) {

	new drug_type = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;
	new drug_ticks = Drugs [ enum_id ] [ E_DRUG_TICKS ] ;

	new drug_label [ 512 ], label_colour = Crack [ drug_type ] [ E_CRACK_HEX ];

	format ( drug_label, sizeof ( drug_label ), "[%d] [%s]{DE801F} (ticks: %d){dedede}\n", enum_id, Crack [ drug_type ] [ E_CRACK_NAME ], drug_ticks ) ;

	switch ( Drugs [ enum_id ] [ E_DRUG_STAGE ] ) {
		case E_DRUG_STAGE_NONE: {

			format ( drug_label, sizeof ( drug_label ), "%s\nThis crack broth isn't set up.", drug_label ) ;
		}

		case E_DRUG_STAGE_START: {
			format ( drug_label, sizeof ( drug_label ), "%s\nThe crack broth needs to be turned on before it can cook.\n\n{DE801F}/drugcook", drug_label ) ;
		}

		case E_DRUG_STAGE_TICKS: {

			format ( drug_label, sizeof ( drug_label ), "%s\nPowder Added: %d bags\n(%0.2fgr / powder)\n\n{DE801F}The broth is boiling.", 
				drug_label, Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ], Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ]
			);
		}

		case E_DRUG_STAGE_FINISH: {

			format ( drug_label, sizeof ( drug_label ), "%s\nTotal Rocks: %0.2fgr\n\n{DE801F}/drugcollect", 
				drug_label, Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ]
			);
		}
	}

	if ( ! IsValidDynamicObject( Drugs [ enum_id ] [ E_DRUG_OBJECT ] ) ) {
		Drugs [ enum_id ] [ E_DRUG_OBJECT ] = CreateDynamicObject(E_DRUG_CRACK_MODELID, Drugs [ enum_id ] [ E_DRUG_POS_X ], Drugs [ enum_id ] [ E_DRUG_POS_Y ], 
			Drugs [ enum_id ] [ E_DRUG_POS_Z ], Drugs [ enum_id ] [ E_DRUG_ROT_X ], Drugs [ enum_id ] [ E_DRUG_ROT_Y ], 
			Drugs [ enum_id ] [ E_DRUG_ROT_Z ],  Drugs [ enum_id ] [ E_DRUG_WORLDID ], Drugs [ enum_id ] [ E_DRUG_INTERIOR ] 
		);
	}

	if ( ! IsValidDynamic3DTextLabel( Drugs [ enum_id ] [ E_DRUG_LABEL ] )) {
		Drugs [ enum_id ] [ E_DRUG_LABEL ] = CreateDynamic3DTextLabel(" ", label_colour, 
			Drugs [ enum_id ] [ E_DRUG_POS_X ], Drugs [ enum_id ] [ E_DRUG_POS_Y ], Drugs [ enum_id ] [ E_DRUG_POS_Z ], 3.5,
			INVALID_PLAYER_ID, INVALID_VEHICLE_ID, false, Drugs [ enum_id ] [ E_DRUG_WORLDID ], Drugs [ enum_id ] [ E_DRUG_INTERIOR ]
		) ;
	}

	UpdateDynamic3DTextLabelText( Drugs [ enum_id ] [ E_DRUG_LABEL ], label_colour, drug_label ) ;
	SetDynamicObjectMaterial( Drugs [ enum_id ] [ E_DRUG_OBJECT ], 0, 19585, "lee_kitch", "Pot1", RGBAtoARGB(label_colour) ) ;

	return true ;
}