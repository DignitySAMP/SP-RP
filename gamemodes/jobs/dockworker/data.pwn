

enum E_DOCKWORKER_COLLECT_DATA {

	E_DOCK_COLLECT_DESC [ 64 ],
	Float: E_DOCK_COLLECT_POS_X,
	Float: E_DOCK_COLLECT_POS_Y,
	Float: E_DOCK_COLLECT_POS_Z
} ;

new Dockworker_Collect[ ] [ E_DOCKWORKER_COLLECT_DATA ] = {

	{ "Malt Brewery", 2744.0205,-2431.5742,13.1646 },
	{ "Textile Factory", 2700.3538,-2386.6963,13.1379 },
	{ "Plank Sawmill", 2681.6643,-2532.4707,12.9019 }
} ;

enum E_DOCKWORKER_STORE_DATA {

	E_DOCK_STORE_MODEL,
	E_DOCK_STORE_DESC [ 64 ],
	Float: E_DOCK_STORE_POS_X,
	Float: E_DOCK_STORE_POS_Y,
	Float: E_DOCK_STORE_POS_Z
} ;

new Dockworker_Store [ ] [ E_DOCKWORKER_STORE_DATA ] = {
 	{1579, "Blue Warehouse", 2786.3252, -2494.3704, 13.1621 }, // blue_hangar
 	{1578, "Green Warehouse", 2787.7900, -2417.4697, 13.1483 }, // green_hangar
 	{1580, "Red Warehouse", 2788.8965, -2456.6426, 13.1327 } // red_hangar
} ;


Job_Dockworker_Init() {

	for ( new i, j = sizeof ( Dockworker_Collect ); i < j ; i ++ ) {

		CreateDynamic3DTextLabel(sprintf("Dockworker Job\n{CBAE3D}[%s]{DEDEDE}\nAvailable commands: /cargocollect",

			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_DESC ] ), COLOUR_JOB, 
			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_X ], 
			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_Y ], 
			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_Z ],
		 	25.0 
		) ;
 
		CreateDynamicPickup(2912, 1, 
			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_X ], 
			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_Y ], 
			Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_Z ]
		) ;

		CreateDynamicMapIcon( Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_X ], Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_Y ], Dockworker_Collect [ i ] [ E_DOCK_COLLECT_POS_Z ], 9, 0xA3A3A3FF);
	}

	for ( new i, j = sizeof ( Dockworker_Store ); i < j ; i ++ ) {

		CreateDynamic3DTextLabel(sprintf("Dockworker Job\n{CBAE3D}[%s]{DEDEDE}\nAvailable commands: /cargostore",

			Dockworker_Store [ i ] [ E_DOCK_STORE_DESC ] ), COLOUR_JOB, 
			Dockworker_Store [ i ] [ E_DOCK_STORE_POS_X ], 
			Dockworker_Store [ i ] [ E_DOCK_STORE_POS_Y ], 
			Dockworker_Store [ i ] [ E_DOCK_STORE_POS_Z ],
		 	25.0 
		) ;
 
		CreateDynamicPickup(Dockworker_Store [ i ] [ E_DOCK_STORE_MODEL ], 1, 
			Dockworker_Store [ i ] [ E_DOCK_STORE_POS_X ], 
			Dockworker_Store [ i ] [ E_DOCK_STORE_POS_Y ], 
			Dockworker_Store [ i ] [ E_DOCK_STORE_POS_Z ]
		) ;

	}
}