enum {
	E_TYPE_AIRPLANES,
	E_TYPE_HELICOPTERS,
	E_TYPE_BIKES,
	E_TYPE_CONVERTIBLES,
	E_TYPE_INDUSTRIAL,
	E_TYPE_LOWRIDERS,
	E_TYPE_OFF_ROAD,
	E_TYPE_PUBLIC_SERVICE,
	E_TYPE_SALOONS,
	E_TYPE_SPORT,
	E_TYPE_STATION_WAGONS,
	E_TYPE_BOATS,
	E_TYPE_TRAILERS,
	E_TYPE_UNIQUE,
	E_TYPE_RC
};

Vehicle_GetTypeByModel(modelid) {
	new type ;

	switch ( modelid ) {
		case 400: type = E_TYPE_OFF_ROAD ;
		case 401: type = E_TYPE_SALOONS ;
		case 402: type = E_TYPE_SPORT ;
		case 403: type = E_TYPE_INDUSTRIAL ;
		case 404: type = E_TYPE_STATION_WAGONS ;
		case 405: type = E_TYPE_SALOONS ;
		case 406: type = E_TYPE_UNIQUE ;
		case 407: type = E_TYPE_PUBLIC_SERVICE ;
		case 408: type = E_TYPE_INDUSTRIAL ;
		case 409: type = E_TYPE_UNIQUE ;
		case 410: type = E_TYPE_SALOONS ;
		case 411: type = E_TYPE_SPORT ;
		case 412: type = E_TYPE_LOWRIDERS ;
		case 413: type = E_TYPE_INDUSTRIAL ;
		case 414: type = E_TYPE_INDUSTRIAL ;
		case 415: type = E_TYPE_SPORT ;
		case 416: type = E_TYPE_PUBLIC_SERVICE ;
		case 417: type = E_TYPE_HELICOPTERS ;
		case 418: type = E_TYPE_STATION_WAGONS ;
		case 419: type = E_TYPE_SALOONS ;
		case 420: type = E_TYPE_PUBLIC_SERVICE ;
		case 421: type = E_TYPE_SALOONS ;
		case 422: type = E_TYPE_INDUSTRIAL ;
		case 423: type = E_TYPE_UNIQUE ;
		case 424: type = E_TYPE_OFF_ROAD ;
		case 425: type = E_TYPE_HELICOPTERS ;
		case 426: type = E_TYPE_SALOONS ;
		case 427: type = E_TYPE_PUBLIC_SERVICE ;
		case 428: type = E_TYPE_UNIQUE ;
		case 429: type = E_TYPE_SPORT ;
		case 430: type = E_TYPE_BOATS ;
		case 431: type = E_TYPE_PUBLIC_SERVICE ;
		case 432: type = E_TYPE_PUBLIC_SERVICE ;
		case 433: type = E_TYPE_PUBLIC_SERVICE ;
		case 434: type = E_TYPE_UNIQUE ;
		case 435: type = E_TYPE_TRAILERS ;
		case 436: type = E_TYPE_SALOONS ;
		case 437: type = E_TYPE_PUBLIC_SERVICE ;
		case 438: type = E_TYPE_PUBLIC_SERVICE ;
		case 439: type = E_TYPE_CONVERTIBLES ;
		case 440: type = E_TYPE_INDUSTRIAL ;
		case 441: type = E_TYPE_RC ;
		case 442: type = E_TYPE_UNIQUE ;
		case 443: type = E_TYPE_INDUSTRIAL ;
		case 444: type = E_TYPE_OFF_ROAD ;
		case 445: type = E_TYPE_SALOONS ;
		case 446: type = E_TYPE_BOATS ;
		case 447: type = E_TYPE_HELICOPTERS ;
		case 448: type = E_TYPE_BIKES ;
		case 449: type = E_TYPE_UNIQUE ;
		case 450: type = E_TYPE_TRAILERS ;
		case 451: type = E_TYPE_SPORT ;
		case 452: type = E_TYPE_BOATS ;
		case 453: type = E_TYPE_BOATS ;
		case 454: type = E_TYPE_BOATS ;
		case 455: type = E_TYPE_INDUSTRIAL ;
		case 456: type = E_TYPE_INDUSTRIAL ;
		case 457: type = E_TYPE_UNIQUE ;
		case 458: type = E_TYPE_STATION_WAGONS ;
		case 459: type = E_TYPE_INDUSTRIAL ;
		case 460: type = E_TYPE_AIRPLANES ;
		case 461: type = E_TYPE_BIKES ;
		case 462: type = E_TYPE_BIKES ;
		case 463: type = E_TYPE_BIKES ;
		case 464: type = E_TYPE_RC ;
		case 465: type = E_TYPE_RC ;
		case 466: type = E_TYPE_SALOONS ;
		case 467: type = E_TYPE_SALOONS ;
		case 468: type = E_TYPE_BIKES ;
		case 469: type = E_TYPE_HELICOPTERS ;
		case 470: type = E_TYPE_OFF_ROAD ;
		case 471: type = E_TYPE_BIKES ;
		case 472: type = E_TYPE_BOATS ;
		case 473: type = E_TYPE_BOATS ;
		case 474: type = E_TYPE_SALOONS ;
		case 475: type = E_TYPE_SPORT ;
		case 476: type = E_TYPE_AIRPLANES ;
		case 477: type = E_TYPE_SPORT ;
		case 478: type = E_TYPE_INDUSTRIAL ;
		case 479: type = E_TYPE_STATION_WAGONS ;
		case 480: type = E_TYPE_CONVERTIBLES ;
		case 481: type = E_TYPE_BIKES ;
		case 482: type = E_TYPE_INDUSTRIAL ;
		case 483: type = E_TYPE_UNIQUE ;
		case 484: type = E_TYPE_BOATS ;
		case 485: type = E_TYPE_UNIQUE ;
		case 486: type = E_TYPE_UNIQUE ;
		case 487: type = E_TYPE_HELICOPTERS ;
		case 488: type = E_TYPE_HELICOPTERS ;
		case 489: type = E_TYPE_OFF_ROAD ;
		case 490: type = E_TYPE_PUBLIC_SERVICE ;
		case 491: type = E_TYPE_SALOONS ;
		case 492: type = E_TYPE_SALOONS ;
		case 493: type = E_TYPE_BOATS ;
		case 494: type = E_TYPE_SPORT ;
		case 495: type = E_TYPE_OFF_ROAD ;
		case 496: type = E_TYPE_SPORT ;
		case 497: type = E_TYPE_HELICOPTERS ;
		case 498: type = E_TYPE_INDUSTRIAL ;
		case 499: type = E_TYPE_INDUSTRIAL ;
		case 500: type = E_TYPE_OFF_ROAD ;
		case 501: type = E_TYPE_RC ;
		case 502: type = E_TYPE_SPORT ;
		case 503: type = E_TYPE_SPORT ;
		case 504: type = E_TYPE_SALOONS ;
		case 505: type = E_TYPE_OFF_ROAD ;
		case 506: type = E_TYPE_SPORT ;
		case 507: type = E_TYPE_SALOONS ;
		case 508: type = E_TYPE_UNIQUE ;
		case 509: type = E_TYPE_BIKES ;
		case 510: type = E_TYPE_BIKES ;
		case 511: type = E_TYPE_AIRPLANES ;
		case 512: type = E_TYPE_AIRPLANES ;
		case 513: type = E_TYPE_AIRPLANES ;
		case 514: type = E_TYPE_INDUSTRIAL ;
		case 515: type = E_TYPE_INDUSTRIAL ;
		case 516: type = E_TYPE_SALOONS ;
		case 517: type = E_TYPE_SALOONS ;
		case 518: type = E_TYPE_SALOONS ;
		case 519: type = E_TYPE_AIRPLANES ;
		case 520: type = E_TYPE_AIRPLANES ;
		case 521: type = E_TYPE_BIKES ;
		case 522: type = E_TYPE_BIKES ;
		case 523: type = E_TYPE_PUBLIC_SERVICE ;
		case 524: type = E_TYPE_INDUSTRIAL ;
		case 525: type = E_TYPE_UNIQUE ;
		case 526: type = E_TYPE_SALOONS ;
		case 527: type = E_TYPE_SALOONS ;
		case 528: type = E_TYPE_PUBLIC_SERVICE ;
		case 529: type = E_TYPE_SALOONS ;
		case 530: type = E_TYPE_UNIQUE ;
		case 531: type = E_TYPE_INDUSTRIAL ;
		case 532: type = E_TYPE_UNIQUE ;
		case 533: type = E_TYPE_CONVERTIBLES ;
		case 534: type = E_TYPE_LOWRIDERS ;
		case 535: type = E_TYPE_LOWRIDERS ;
		case 536: type = E_TYPE_LOWRIDERS ;
		case 537: type = E_TYPE_UNIQUE ;
		case 538: type = E_TYPE_UNIQUE ;
		case 539: type = E_TYPE_UNIQUE ;
		case 540: type = E_TYPE_SALOONS ;
		case 541: type = E_TYPE_SPORT ;
		case 542: type = E_TYPE_SALOONS ;
		case 543: type = E_TYPE_INDUSTRIAL ;
		case 544: type = E_TYPE_PUBLIC_SERVICE ;
		case 545: type = E_TYPE_UNIQUE ;
		case 546: type = E_TYPE_SALOONS ;
		case 547: type = E_TYPE_SALOONS ;
		case 548: type = E_TYPE_HELICOPTERS ;
		case 549: type = E_TYPE_SALOONS ;
		case 550: type = E_TYPE_SALOONS ;
		case 551: type = E_TYPE_SALOONS ;
		case 552: type = E_TYPE_INDUSTRIAL ;
		case 553: type = E_TYPE_AIRPLANES ;
		case 554: type = E_TYPE_INDUSTRIAL ;
		case 555: type = E_TYPE_CONVERTIBLES ;
		case 556: type = E_TYPE_OFF_ROAD ;
		case 557: type = E_TYPE_OFF_ROAD ;
		case 558: type = E_TYPE_SPORT ;
		case 559: type = E_TYPE_SPORT ;
		case 560: type = E_TYPE_SALOONS ;
		case 561: type = E_TYPE_STATION_WAGONS ;
		case 562: type = E_TYPE_SALOONS ;
		case 563: type = E_TYPE_HELICOPTERS ;
		case 564: type = E_TYPE_RC ;
		case 565: type = E_TYPE_SPORT ;
		case 566: type = E_TYPE_LOWRIDERS ;
		case 567: type = E_TYPE_LOWRIDERS ;
		case 568: type = E_TYPE_OFF_ROAD ;
		case 569: type = E_TYPE_TRAILERS ;
		case 570: type = E_TYPE_TRAILERS ;
		case 571: type = E_TYPE_UNIQUE ;
		case 572: type = E_TYPE_UNIQUE ;
		case 573: type = E_TYPE_OFF_ROAD ;
		case 574: type = E_TYPE_UNIQUE ;
		case 575: type = E_TYPE_LOWRIDERS ;
		case 576: type = E_TYPE_LOWRIDERS ;
		case 577: type = E_TYPE_AIRPLANES ;
		case 578: type = E_TYPE_INDUSTRIAL ;
		case 579: type = E_TYPE_OFF_ROAD ;
		case 580: type = E_TYPE_SALOONS ;
		case 581: type = E_TYPE_BIKES ;
		case 582: type = E_TYPE_INDUSTRIAL ;
		case 583: type = E_TYPE_UNIQUE ;
		case 584: type = E_TYPE_TRAILERS ;
		case 585: type = E_TYPE_SALOONS ;
		case 586: type = E_TYPE_BIKES ;
		case 587: type = E_TYPE_SPORT ;
		case 588: type = E_TYPE_UNIQUE ;
		case 589: type = E_TYPE_SPORT ;
		case 590: type = E_TYPE_TRAILERS ;
		case 591: type = E_TYPE_TRAILERS ;
		case 592: type = E_TYPE_AIRPLANES ;
		case 593: type = E_TYPE_AIRPLANES ;
		case 594: type = E_TYPE_RC ;
		case 595: type = E_TYPE_BOATS ;
		case 596: type = E_TYPE_PUBLIC_SERVICE ;
		case 597: type = E_TYPE_PUBLIC_SERVICE ;
		case 598: type = E_TYPE_PUBLIC_SERVICE ;
		case 599: type = E_TYPE_PUBLIC_SERVICE ;
		case 600: type = E_TYPE_INDUSTRIAL ;
		case 601: type = E_TYPE_PUBLIC_SERVICE ;
		case 602: type = E_TYPE_SPORT ;
		case 603: type = E_TYPE_SPORT ;
		case 604: type = E_TYPE_SALOONS ;
		case 605: type = E_TYPE_INDUSTRIAL ;
		case 606: type = E_TYPE_TRAILERS ;
		case 607: type = E_TYPE_TRAILERS ;
		case 608: type = E_TYPE_TRAILERS ;
		case 609: type = E_TYPE_INDUSTRIAL ;
		case 610: type = E_TYPE_TRAILERS ;
		case 611: type = E_TYPE_TRAILERS ;
	}

	return type ;
}

enum { // storage type

	E_VEHICLE_STORAGE_TYPE_NONE = 0 ,
	E_VEHICLE_STORAGE_TYPE_CAR,
	E_VEHICLE_STORAGE_TYPE_SUV,
	E_VEHICLE_STORAGE_TYPE_TRUCK,
	E_VEHICLE_STORAGE_TYPE_BIKE,
	E_VEHICLE_STORAGE_TYPE_AIR,
	E_VEHICLE_STORAGE_TYPE_BOAT
} ;

Vehicle_GetSOLSTypeByModel(type_default) {

	new type = E_VEHICLE_STORAGE_TYPE_NONE ;

	switch ( type_default ) {

		case E_TYPE_AIRPLANES, E_TYPE_HELICOPTERS : 
			type = E_VEHICLE_STORAGE_TYPE_AIR ;

		case E_TYPE_BOATS: 
			type = E_VEHICLE_STORAGE_TYPE_BOAT ;

		case E_TYPE_PUBLIC_SERVICE, E_TYPE_TRAILERS, E_TYPE_UNIQUE, E_TYPE_RC: 
			type = E_VEHICLE_STORAGE_TYPE_NONE ;

		case E_TYPE_BIKES: 
			type = E_VEHICLE_STORAGE_TYPE_BIKE ;

		case E_TYPE_CONVERTIBLES, E_TYPE_STATION_WAGONS: 
			type = E_VEHICLE_STORAGE_TYPE_SUV ;

		case E_TYPE_INDUSTRIAL, E_TYPE_OFF_ROAD: 
			type = E_VEHICLE_STORAGE_TYPE_TRUCK ;

		case E_TYPE_LOWRIDERS, E_TYPE_SALOONS, E_TYPE_SPORT: 
			type = E_VEHICLE_STORAGE_TYPE_CAR ;
	}

	return type ;
}

Vehicle_GetMaxSlotsPerType(type) {

	new max_slots  = 0 ;

	switch ( type ) {
		case E_VEHICLE_STORAGE_TYPE_CAR: max_slots = 3 ;
		case E_VEHICLE_STORAGE_TYPE_SUV: max_slots = 5 ;
		case E_VEHICLE_STORAGE_TYPE_TRUCK: max_slots = 9 ;
		case E_VEHICLE_STORAGE_TYPE_BIKE: max_slots = 1 ;
		case E_VEHICLE_STORAGE_TYPE_AIR: max_slots = 5 ;
		case E_VEHICLE_STORAGE_TYPE_BOAT: max_slots = 5 ;
		case E_VEHICLE_STORAGE_TYPE_NONE: max_slots = 0 ;
	}

	return max_slots ;
}