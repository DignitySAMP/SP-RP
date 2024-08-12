enum E_WEED_DATA {

	E_WEED_TYPE,
	E_WEED_NAME [ 32 ],
	E_WEED_MAX_BUDS,
	Float: E_WEED_HEALING,
	Float: E_WEED_MIN_HAUL,
	Float: E_WEED_MAX_HAUL,

	E_WEED_TICKS, // ticks required til fully grown
	E_WEED_HEX,
	E_WEED_SEED_COST
} ;

enum {
	E_WEED_TYPE_NONE = 0,
	E_WEED_TYPE_MAUI_WAUI,
	E_WEED_TYPE_NORTHERN_LIGHTS,
	E_WEED_TYPE_OG_KUSH,
	E_WEED_TYPE_PURPLE_KUSH
} ;

new Weed [ ] [ E_WEED_DATA ] = {

	{ E_WEED_TYPE_NONE, 			"None",				-1,	0.00, 2.5, 15.0, 0, 	0xFFFFFFFF }, // 15 min
	{ E_WEED_TYPE_MAUI_WAUI, 		"Maui Waui", 		8,  0.50, 2.0, 12.5, 60, 0x99991EFF }, // 20 min
	{ E_WEED_TYPE_NORTHERN_LIGHTS, 	"Northern Lights", 	8,  1.00, 1.5, 10.0, 120, 0x2C89AAFF }, // 30 min
	{ E_WEED_TYPE_OG_KUSH, 			"O.G. Kush", 		6,  2.00, 1.0, 7.5,  180, 0x993E4DFF }, // 50 min
	{ E_WEED_TYPE_PURPLE_KUSH,  	"Purple Kush", 		4,  2.50, 0.5, 5.0,  200, 0x6C3F99FF } // 60 min
} ;

#define E_DRUG_WEED_MODELID ( 19473 )

Weed_SetupGrowth ( enum_id ) {

	new drug_type = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;

	new max_buds = Weed [ drug_type ] [ E_WEED_MAX_BUDS ] ;
	new buds = 1 + random ( max_buds ) ;

	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ] = buds ;

	new Float: amount = frandom(Weed [drug_type][ E_WEED_MIN_HAUL ], Weed [drug_type][ E_WEED_MAX_HAUL ] );

	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ] = amount ;
	Drugs [ enum_id ] [ E_DRUG_STAGE ] = E_DRUG_STAGE_TICKS ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_int = %d, drug_growth_param_float_i = '%f', drug_stage = %d WHERE drug_sqlid = %d", 

		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ], Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ], Drugs [ enum_id ] [ E_DRUG_STAGE ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
	) ;

	mysql_tquery(mysql, query);


	Weed_SetupPlantVisuals ( enum_id ) ;
}

Weed_FinalizeGrowth( enum_id ) {

	if ( Drugs [ enum_id ] [ E_DRUG_STAGE ] == E_DRUG_STAGE_FINISH ) {
		new type = Drugs [ enum_id ] [  E_DRUG_PARAM ] ;
		new Float: final_haul = frandom(Weed [type][ E_WEED_MIN_HAUL ], Weed [type][ E_WEED_MAX_HAUL ] );
		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] = final_haul ;
			
		new query [ 256 ] ;

		mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_float_ii = '%f' WHERE drug_sqlid = %d", 

			Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
		) ;

		mysql_tquery(mysql, query);

		Weed_SetupPlantVisuals ( enum_id ) ;
	}
}

Weed_SetupPlantVisuals ( enum_id ) {

	new drug_type = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;
	new drug_ticks = Drugs [ enum_id ] [ E_DRUG_TICKS ] ;

	new drug_label [ 512 ], label_colour = Weed [ drug_type ] [ E_WEED_HEX ];

	format ( drug_label, sizeof ( drug_label ), "[%d] [%s]{DE801F} (ticks: %d){dedede}\n", enum_id, Weed [ drug_type ] [ E_WEED_NAME ], drug_ticks ) ;

	switch ( Drugs [ enum_id ] [ E_DRUG_STAGE ] ) {
		case E_DRUG_STAGE_NONE: {

			format ( drug_label, sizeof ( drug_label ), "%s\nThis weed plant isn't set up.", drug_label ) ;
		}

		case E_DRUG_STAGE_START: {
			format ( drug_label, sizeof ( drug_label ), "%s\nThis plant needs some water to start growing.\n\n{DE801F}/drugwater", drug_label ) ;
		}

		case E_DRUG_STAGE_TICKS: {

			format ( drug_label, sizeof ( drug_label ), "%s\nTotal Buds: %d\n(%0.2fgr / bud)\n\n{DE801F}The plant is growing.", 
				drug_label, Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ], Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ]
			);
		}

		case E_DRUG_STAGE_FINISH: {

			format ( drug_label, sizeof ( drug_label ), "%s\nTotal Grams: %0.2fgr\n\n{DE801F}/drugcollect", 
				drug_label, Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ]
			);
		}
	}

	if ( ! IsValidDynamicObject( Drugs [ enum_id ] [ E_DRUG_OBJECT ] ) ) {
		Drugs [ enum_id ] [ E_DRUG_OBJECT ] = CreateDynamicObject(E_DRUG_WEED_MODELID, Drugs [ enum_id ] [ E_DRUG_POS_X ], Drugs [ enum_id ] [ E_DRUG_POS_Y ], 
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
	SetDynamicObjectMaterial( Drugs [ enum_id ] [ E_DRUG_OBJECT ], 0, 19473, "grassplant01", "veg_marijuana", RGBAtoARGB(label_colour) ) ;

	return true ;
}