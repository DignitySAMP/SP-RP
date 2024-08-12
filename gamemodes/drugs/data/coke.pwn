enum E_COKE_DATA {

	E_COKE_TYPE,
	E_COKE_NAME [ 32 ],
	E_COKE_MAX_LEAVES,
	Float: E_COKE_EXTRA_DAMAGE,

	Float: E_COKE_MIN_HAUL,
	Float: E_COKE_MAX_HAUL,

	E_COKE_TICKS,
	E_COKE_HEX
} ;

enum {
	E_COKE_TYPE_NONE = 0,
	E_COKE_TYPE_SLEIGH_RIDE,
	E_COKE_TYPE_BLANCA_FLAKES,
	E_COKE_TYPE_GOLD_DUST,
	E_COKE_TYPE_PARADISE_WHITE,
} ;

new Cocaine [ ] [ E_COKE_DATA ] = {
	{ E_COKE_TYPE_NONE, 		  "None", 		   		-1, 0.0,	2.5, 15.0, 600, 	0xFFFFFFFF },
	{ E_COKE_TYPE_SLEIGH_RIDE,	  "Sleigh Ride", 		9, 0.5,		2.0, 12.5, 600, 	0xD7A8A8FF } ,
	{ E_COKE_TYPE_BLANCA_FLAKES,  "Blanca Flakes", 		7, 1.5,		1.5, 10.0, 1200, 	0xCEA586FF } ,
	{ E_COKE_TYPE_GOLD_DUST,	  "Gold Dust", 			5, 2.5,		1.0, 7.5, 	1800, 	0xDECF88FF } ,
	{ E_COKE_TYPE_PARADISE_WHITE, "Paradise White", 	3, 3.5,		0.5, 5.0, 	2400, 	0x88DED8FF }
} ;

#define E_DRUG_COKE_MODELID ( 861 )

Coke_SetupGrowth ( enum_id ) {

	new drug_type = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;

	new max_leaves = Cocaine [ drug_type ] [ E_COKE_MAX_LEAVES ] ;
	new leaves = 1 + random ( max_leaves ) ;

	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ] = leaves ;

	new Float: amount = frandom(Cocaine [drug_type][ E_COKE_MIN_HAUL ], Cocaine [drug_type][ E_COKE_MAX_HAUL ] );

	Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ] = amount ;
	Drugs [ enum_id ] [ E_DRUG_STAGE ] = E_DRUG_STAGE_TICKS ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_int = %d, drug_growth_param_float_i = '%f', drug_stage = %d WHERE drug_sqlid = %d", 

		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_INT ], Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_I ], Drugs [ enum_id ] [ E_DRUG_STAGE ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	Coke_SetupPlantVisuals ( enum_id ) ;
}

Coke_FinalizeGrowth( enum_id ) {

	if ( Drugs [ enum_id ] [ E_DRUG_STAGE ] == E_DRUG_STAGE_FINISH ) {
		new type = Drugs [ enum_id ] [  E_DRUG_PARAM ] ;
		new Float: final_haul = frandom(Cocaine [type][ E_COKE_MIN_HAUL ], Cocaine [type][ E_COKE_MAX_HAUL ] );
		Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ] = final_haul ;
		
		new query [ 256 ] ;

		mysql_format(mysql, query, sizeof ( query ), "UPDATE drugs_player_stations SET drug_growth_param_float_ii = '%f' WHERE drug_sqlid = %d", 

			Drugs [ enum_id ] [ E_DRUG_GROWTH_PARAM_FLOAT_II ], Drugs [ enum_id ] [ E_DRUG_SQLID ]
		) ;

		mysql_tquery(mysql, query);

		Coke_SetupPlantVisuals ( enum_id ) ;
	}
}

Coke_SetupPlantVisuals ( enum_id ) {

	new drug_type = Drugs [ enum_id ] [ E_DRUG_PARAM ] ;
	new drug_ticks = Drugs [ enum_id ] [ E_DRUG_TICKS ] ;

	new drug_label [ 512 ], label_colour = Cocaine [ drug_type ] [ E_COKE_HEX ];

	format ( drug_label, sizeof ( drug_label ), "[%d] [%s]{DE801F} (ticks: %d){dedede}\n", enum_id, Cocaine [ drug_type ] [ E_COKE_NAME ], drug_ticks ) ;

	switch ( Drugs [ enum_id ] [ E_DRUG_STAGE ] ) {
		case E_DRUG_STAGE_NONE: {

			format ( drug_label, sizeof ( drug_label ), "%s\nThis plant isn't set up.", drug_label ) ;
		}

		case E_DRUG_STAGE_START: {
			format ( drug_label, sizeof ( drug_label ), "%s\nThis plant needs some water to start growing.\n\n{DE801F}/drugwater", drug_label ) ;
		}

		case E_DRUG_STAGE_TICKS: {

			format ( drug_label, sizeof ( drug_label ), "%s\nTotal Leaves: %d\n(%0.2fgr / coke)\n\n{DE801F}The plant is growing.", 
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
		Drugs [ enum_id ] [ E_DRUG_OBJECT ] = CreateDynamicObject(E_DRUG_COKE_MODELID, Drugs [ enum_id ] [ E_DRUG_POS_X ], Drugs [ enum_id ] [ E_DRUG_POS_Y ], 
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
	SetDynamicObjectMaterial( Drugs [ enum_id ] [ E_DRUG_OBJECT ], 0, 861, "gta_procdesert", "sm_minipalm", RGBAtoARGB(label_colour) ) ;

	return true ;
}