enum { // package_constants

	E_DRUG_PACKAGE_ZIPLOC_BAG,
	E_DRUG_PACKAGE_WRAPPED_FOIL,
	E_DRUG_PACKAGE_PILL_BOTTLE,
	E_DRUG_PACKAGE_PIZZA_BOX,
	E_DRUG_PACKAGE_BURGER_CARTON,
	E_DRUG_PACKAGE_TAKEAWAY_BAG,
	E_DRUG_PACKAGE_MILK_CARTON,
	E_DRUG_PACKAGE_PLASTIC_CUP,
	E_DRUG_PACKAGE_BRICK
} ;

enum { // package type

	E_DRUG_PACKAGE_SMALL, // 0.01g to 0.50g
	E_DRUG_PACKAGE_MEDIUM, // 0.50g to 1.25g
	E_DRUG_PACKAGE_LARGE // 1.25kg to 5kg
}

enum E_DRUG_PACKAGE_DATA {

	E_DRUG_PACKAGE_CONST,
	E_DRUG_PACKAGE_DESC [ 32 ],
	E_DRUG_PACKAGE_TYPE
}

new DrugPackages [ ] [ E_DRUG_PACKAGE_DATA ] = {

	{ E_DRUG_PACKAGE_ZIPLOC_BAG,  		"Ziploc Bag", 		E_DRUG_PACKAGE_SMALL },
	{ E_DRUG_PACKAGE_WRAPPED_FOIL,  	"Wrapped Foil", 	E_DRUG_PACKAGE_SMALL },
	{ E_DRUG_PACKAGE_PILL_BOTTLE,  		"Pill Bottle", 		E_DRUG_PACKAGE_SMALL },
	{ E_DRUG_PACKAGE_PIZZA_BOX,  		"Pizza Box", 		E_DRUG_PACKAGE_MEDIUM },
	{ E_DRUG_PACKAGE_BURGER_CARTON,  	"Burger Carton", 	E_DRUG_PACKAGE_MEDIUM },
	{ E_DRUG_PACKAGE_TAKEAWAY_BAG,  	"Takeaway Bag", 	E_DRUG_PACKAGE_LARGE },
	{ E_DRUG_PACKAGE_MILK_CARTON,  		"Milk Carton", 		E_DRUG_PACKAGE_MEDIUM },
	{ E_DRUG_PACKAGE_PLASTIC_CUP,  		"Plastic Cup", 		E_DRUG_PACKAGE_SMALL },
	{ E_DRUG_PACKAGE_BRICK,				"Wrapped Brick", 	E_DRUG_PACKAGE_LARGE }
} ;

Drugs_GetPackageName(idx, name[], len = sizeof ( name ) ) {

	format(name, len, "Unknown" ) ;


	if ( idx > 0 || idx < sizeof ( DrugPackages ) ) {

		name [ 0 ] = EOS ;

		strcat(name, DrugPackages [ idx ] [ E_DRUG_PACKAGE_DESC ], len ) ;
	}
}

Float: Drugs_GetPackageMaxWeight(idx) {

	new Float: max_weight = 0.01 ;

	switch ( DrugPackages [ idx ] [ E_DRUG_PACKAGE_TYPE ] ) {

		case E_DRUG_PACKAGE_SMALL: 		max_weight = 0.50;
		case E_DRUG_PACKAGE_MEDIUM:  	max_weight = 1.25;
		case E_DRUG_PACKAGE_LARGE:  	max_weight = 5.00;
	}

	return max_weight ;
}