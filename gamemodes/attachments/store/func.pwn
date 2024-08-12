Attach_DetermineCost(type) {

    new cost  = 125 ; // default

    switch ( type ) {

        case 0: cost = 150 ; // cloth face samp
        case 1: cost = 200 ; // cloth face sols
        case 2: cost = 500 ; // cloth head samp
        case 3: cost = 500 ; // cloth head sols
        case 4: cost = 250 ; // cloth neck sols
        case 5: cost = 200 ; // cloth misc samp
        case 6: cost = 0 ; // cloth lspd
        case 7: cost = 9000 ; // jewelryt chains
        case 8: cost = 8000; // jewelry watches
        case 9: cost = 8500 ; // jewelry rings
        case 10: cost = 8000 ; // jewelry extra
        case 11: cost = 300 ; // barber main
		case 12: cost = 0 ; // cloth news
		case 13: cost = 0 ; // cloth lsfd
		case 14: cost = 0 ; // cloth dea
    }

    return cost ;
}


Attach_GetType(modelid) {

	for ( new i, j = sizeof ( AttachStore_Clothing_Face_SAMP ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_Face_SAMP [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 0 ;			
		}
	}

	for ( new i, j = sizeof ( AttachStore_Clothing_Face_SOLS ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_Face_SOLS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 1 ;			
		}
	}

	for ( new i, j = sizeof ( AttachStore_Clothing_Head_SAMP ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_Head_SAMP [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 2 ;			
		}
	}		

	for ( new i, j = sizeof ( AttachStore_Clothing_Head_SOLS ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_Head_SOLS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 3 ;			
		}
	}	

	for ( new i, j = sizeof ( AttachStore_Clothing_Neck_SOLS ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_Neck_SOLS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 4 ;
		}
	}	

	for ( new i, j = sizeof ( AttachStore_Clothing_MISC_SAMP ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_MISC_SAMP [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 5 ;			
		}
	}	

	for ( new i, j = sizeof ( AttachStore_Clothing_LSPD ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_LSPD [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 6 ;			
		}
	}	

	for ( new i, j = sizeof ( AttachStore_Jewelry_Chains ); i < j ; i ++ ) {

		if ( AttachStore_Jewelry_Chains [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 7 ;			
		}
	}			

	for ( new i, j = sizeof ( AttachStore_Jewelry_Watches ); i < j ; i ++ ) {

		if ( AttachStore_Jewelry_Watches [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 8 ;			
		}
	}			

	for ( new i, j = sizeof ( AttachStore_Jewelry_Rings ); i < j ; i ++ ) {

		if ( AttachStore_Jewelry_Rings [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 9 ;			
		}
	}		

	for ( new i, j = sizeof ( AttachStore_Jewelry_Extra ); i < j ; i ++ ) {

		if ( AttachStore_Jewelry_Extra [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 10 ;			
		}
	}	

	for ( new i, j = sizeof ( AttachStore_Barber ); i < j ; i ++ ) {

		if ( AttachStore_Barber [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 11 ;			
		}
	}

	for ( new i, j = sizeof ( AttachStore_Clothing_NEWS ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_NEWS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 12 ;			
		}
	}		

	for ( new i, j = sizeof ( AttachStore_Clothing_EMS ); i < j ; i ++ ) {

		if ( AttachStore_Clothing_EMS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
			return 13 ;			
		}
	}	


	return -1;
}

Attach_GetName(type, modelid, name[], len=sizeof(name)) {

	switch ( type ) {

		case 0: { // "Clothing Store: Facewear (SA-MP)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Face_SAMP ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_Face_SAMP [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s", AttachStore_Clothing_Face_SAMP [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}
		}
		
		case 1: { // "Clothing Store: Facewear (SOLS)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Face_SOLS ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_Face_SOLS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s", AttachStore_Clothing_Face_SOLS [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}
		}
		
		case 2: { // "Clothing Store: Headwear (SA-MP)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Head_SAMP ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_Head_SAMP [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s", AttachStore_Clothing_Head_SAMP [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}		
		}
		
		case 3: { // "Clothing Store: Headwear (SOLS)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Head_SOLS ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_Head_SOLS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",AttachStore_Clothing_Head_SOLS [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}
		
		case 4: { // "Clothing Store: Neckwear (SOLS)" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_Neck_SOLS ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_Neck_SOLS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s", AttachStore_Clothing_Neck_SOLS [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}
		
		case 5: { // "Clothing Store: Miscalleneous" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_MISC_SAMP ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_MISC_SAMP [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s", AttachStore_Clothing_MISC_SAMP [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}
		
		case 6: { // "Clothing Store: LSPD Restricted" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_LSPD ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_LSPD [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",AttachStore_Clothing_LSPD [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}

		case 7:{  // "Jewelry Store: Chains" ) ;

			for ( new i, j = sizeof ( AttachStore_Jewelry_Chains ); i < j ; i ++ ) {

				if ( AttachStore_Jewelry_Chains [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s", AttachStore_Jewelry_Chains [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}			
		}
		case 8: { // "Jewelry Store: Watches" ) ;

			for ( new i, j = sizeof ( AttachStore_Jewelry_Watches ); i < j ; i ++ ) {

				if ( AttachStore_Jewelry_Watches [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",  AttachStore_Jewelry_Watches [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}			
		}
		case 9: { // "Jewelry Store: Rings" ) ;

			for ( new i, j = sizeof ( AttachStore_Jewelry_Rings ); i < j ; i ++ ) {

				if ( AttachStore_Jewelry_Rings [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",  AttachStore_Jewelry_Rings [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}		
		}
		case 10: { //  "Jewelry Store: Miscalleneous" ) ;

			for ( new i, j = sizeof ( AttachStore_Jewelry_Extra ); i < j ; i ++ ) {

				if ( AttachStore_Jewelry_Extra [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",  AttachStore_Jewelry_Extra [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}

		case 11: {	//  "Barbershop: Hairstyles" ) ;

			for ( new i, j = sizeof ( AttachStore_Barber ); i < j ; i ++ ) {

				if ( AttachStore_Barber [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",  AttachStore_Barber [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}

		case 12: { // "Clothing Store: NEWS Restricted" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_NEWS ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_NEWS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",AttachStore_Clothing_NEWS [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}

		case 13: { // "Clothing Store: LSFD Restricted" ) ;

			for ( new i, j = sizeof ( AttachStore_Clothing_EMS ); i < j ; i ++ ) {

				if ( AttachStore_Clothing_EMS [ i ] [ E_ATTACH_MODEL ] == modelid ) {
					format ( name, len, "%s",AttachStore_Clothing_EMS [ i ] [ E_ATTACH_NAME ] ) ;
				}
			}	
		}

		default: {
			format ( name, len, "None" ) ;
		}
	}

}