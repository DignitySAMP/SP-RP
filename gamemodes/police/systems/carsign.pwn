enum vehicle_plate_pos_enum
{
	vpp_veh_model,
	Float:vpp_x,
	Float:vpp_y,
	Float:vpp_z
}
new vehicle_plate_pos[ ][ vehicle_plate_pos_enum ] ={
	{ 400 , -1.03 , -1.83 , -0.46 },	{ 401 , 1.08 , -1.87 , -0.11 },		{ 402 , -0.90 , -2.42 , -0.31 },	{ 404 , -0.92 , -2.45 , -0.15 },
	{ 405 , -0.96 , -2.76 , -0.20 },	{ 409 , -0.90 , -3.57 , -0.31 },	{ 410 , -0.97 , -1.67 , -0.01 },	{ 411 , -0.90 , -2.33 , -0.37 },
	{ 412 , -1.00 , -3.34 , -0.35 },	{ 413 , -0.93 , -2.64 , -0.32 },	{ 414 , -0.80 , -3.26 , -0.28 },	{ 415 , -1.00 , -2.34 , -0.07 },
	{ 418 , 1.16 , -2.08 , -0.49 },		{ 419 , 0.85 , -2.99 , -0.36 },		{ 420 , -0.80 , -2.68 , -0.32 },	{ 421 , -0.93 , -2.93 , -0.29 },
	{ 422 , -0.99 , -2.28 , -0.36 },	{ 423 , 1.00 , -2.21 , -0.62 },		{ 424 , 0.50 , -1.14 , 0.01 },		{ 426 , -0.80 , -2.68 , -0.32 },
	{ 429 , -0.80 , -2.26 , -0.26 },	{ 431 , -1.20 , -5.72 , -0.39 },	{ 433 , -0.66 , -4.30 , -0.05 },	{ 436 , -0.97 , -2.39 , -0.07 },
	{ 437 , -1.26 , -5.36 , -0.44 },	{ 438 , 0.90 , -2.64 , -0.58 },		{ 439 , -0.84 , -2.64 , -0.13 },	{ 440 , 0.93 , -2.64 , -0.63 },
	{ 442 , -1.12 , -3.06 , -0.20 },	{ 445 , -0.90 , -2.64 , -0.34 },	{ 455 , 0.66 , -4.36 , -0.25 },		{ 456 , 0.68 , -4.49 , -0.51 },
	{ 457 , 0.00 , -1.37 , -0.23 },		{ 458 , -0.97 , -2.82 , -0.24 },	{ 459 , -0.93 , -2.64 , -0.32 },	{ 464 , 0.00 , -0.77 , 0.06 },
	{ 466 , -0.90 , -2.86 , -0.31 },	{ 467 , -0.90 , -2.89 , -0.32 },	{ 470 , -0.48 , -2.54 , -0.10 },	{ 474 , 0.90 , -2.70 , -0.40 },
	{ 475 , -0.90 , -2.70 , -0.24 },	{ 477 , -0.98 , -2.74 , -0.08 },	{ 478 , -0.32 , -2.52 , -0.38 },	{ 479 , 1.05 , -2.70 , -0.27 },
	{ 480 , -0.85 , -2.20 , -0.33 },	{ 482 , -0.95 , -2.59 , -0.60 },	{ 483 , 0.89 , -2.63 , -0.72 },		{ 485 , -0.67 , -1.55 , -0.25 },
	{ 489 , -1.07 , -2.71 , -0.34 },	{ 490 , -1.07 , -3.17 , -0.34 },	{ 491 , -0.95 , -2.84 , -0.24 },	{ 492 , 0.85 , -2.90 , -0.29 },
	{ 494 , -0.93 , -2.98 , -0.29 },	{ 495 , 1.04 , -2.14 , -0.43 },		{ 496 , 1.04 , -1.73 , -0.06 },		{ 498 , -1.19 , -3.05 , -0.56 },
	{ 499 , -0.97 , -3.37 , -0.26 },	{ 500 , -0.63 , -1.88 , -0.33 },	{ 502 , -0.93 , -2.65 , -0.10 },	{ 503 , -0.89 , -2.89 , -0.25 },
	{ 504 , -0.90 , -2.86 , -0.31 },	{ 505 , -1.07 , -2.71 , -0.34 },	{ 506 , 1.05 , -2.00 , -0.18 },		{ 507 , -0.95 , -2.71 , -0.41 },
	{ 508 , 0.45 , -3.90 , -0.87 },		{ 516 , -1.02 , -2.78 , -0.17 },	{ 517 , -1.04 , -2.79 , -0.22 },	{ 518 , 0.89 , -2.80 , -0.23 },
	{ 524 , -0.02 , -3.93 , -0.23 },	{ 526 , 0.85 , -2.21 , -0.31 },		{ 527 , -0.98 , -2.30 , -0.08 },	{ 528 , -1.13 , -2.59 , -0.39 },
	{ 529 , -1.11 , -2.10 , -0.03 },	{ 533 , -0.90 , -2.35 , -0.24 },	{ 534 , -0.93 , -2.88 , -0.33 },	{ 535 , -0.90 , -2.89 , -0.37 }, { 536 , -0.90 , -2.89 , -0.37 },
	{ 540 , 1.17 , -2.21 , -0.21 },		{ 541 , 0.80 , -2.07 , -0.24 },		{ 542 , -1.02 , -2.90 , 0.06 },		{ 543 , 0.93 , -2.67 , -0.33 },
	{ 545 , 0.80 , -2.22 , -0.53 },		{ 546 , -1.14 , -2.23 , -0.05 },	{ 547 , -1.00 , -2.61 , -0.07 },	{ 549 , -0.90 , -2.49 , -0.12 },
	{ 550 , 1.15 , -2.49 , -0.29 },		{ 551 , -1.04 , -3.06 , -0.14 },	{ 554 , -0.95 , -2.94 , -0.36 },	{ 556 , 0.00 , -2.96 , 0.27 },
	{ 557 , 0.00 , -2.89 , 0.25 },		{ 558 , -1.07 , -1.76 , 0.04 },		{ 559 , 1.08 , -1.73 , 0.01 },		{ 560 , -1.05 , -1.69 , 0.03 },
	{ 561 , 1.09 , -1.76 , -0.19 },		{ 562 , 1.06 , -1.55 , -0.02 },		{ 565 , -0.94 , -1.67 , -0.06 },	{ 566 , -0.85 , -2.98 , -0.27 },
	{ 567 , -0.90 , -2.83 , -0.45 },	{ 573 , 0.74 , -3.10 , -0.73 },		{ 574 , -0.64 , -1.20 , -0.30 },	{ 575 , -0.90 , -2.69 , -0.21 },
	{ 576 , 0.90 , -3.05 , -0.27 },		{ 579 , -1.04 , -2.73 , -0.18 },	{ 580 , 1.09 , -2.84 , -0.26 },		{ 582 , -1.06 , -3.37 , -0.46 },
	{ 585 , 1.17 , -2.11 , 0.07 },		{ 587 , -1.15 , -2.45 , -0.06 },	{ 588 , -1.36 , -3.85 , -0.56 },	{ 589 , -0.98 , -2.05 , 0.01 },
	{ 596 , -0.80 , -2.68 , -0.32 },	{ 597 , -0.80 , -2.68 , -0.32 },	{ 598 , 0.90 , -2.74 , -0.20 },		{ 599 , -1.07 , -2.71 , -0.34 },
	{ 600 , -0.99 , -2.74 , -0.31 },	{ 602 , -0.90 , -2.31 , -0.36 },	{ 603 , -1.09 , -2.63 , -0.26 },	{ 604 , -0.90 , -2.86 , -0.31 },
	{ 605 , 0.93 , -2.67 , -0.33 },		{ 609 , -1.19 , -3.05 , -0.56 }
};
stock v_GetVhiclePlatePos( veh_model, &Float:X, &Float:Y, &Float:Z) {
	X = 0.0;
	Y = -2.20;
	Z = 0.0;
	new vpp_sizeof = sizeof( vehicle_plate_pos );
	for( new i; i < vpp_sizeof; i++ ) {
		if( veh_model == vehicle_plate_pos[ i ][ vpp_veh_model ] )
		{
			X = vehicle_plate_pos[ i ][ vpp_x ];
			Y = vehicle_plate_pos[ i ][ vpp_y ];
			Z = vehicle_plate_pos[ i ][ vpp_z ];
			break;
		}
	}
	return;
}

CMD:carsign(playerid, params[]) {

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID ( vehicleid );

	if (!IsEngineVehicle(vehicleid)) {
		return SendClientMessage(playerid, COLOR_ERROR, "You are not in any vehicle.");
	}

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) {
	    return SendClientMessage(playerid, COLOR_ERROR, "You can't do this as you're not the driver.");
	}

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] != 0 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a police faction.");
	}

	new input [ 75 ];

	if ( sscanf ( params, "s[75]", input ) ) {
		if ( IsValidDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ) {

			DestroyDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
			return SendServerMessage ( playerid, COLOR_BLUE, "Carsign", "A3A3A3", "Carsign removed!");
		}

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/carsign [input] - no input to remove");
	}

	if ( strlen ( input ) < 0 || strlen ( input ) > 75 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "String length can't be less than 0 or more than 75.");
	}

	new veh_model = GetVehicleModel( vehicleid ),Float: r_x, Float: r_y, Float: r_z;
	v_GetVhiclePlatePos( veh_model, r_x, r_y, r_z );

	if ( IsValidDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ) {

		DestroyDynamic3DTextLabel( Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] ) ;
	}

	Vehicle [ veh_enum_id ] [ E_VEHICLE_LABEL ] = CreateDynamic3DTextLabel(input, 0xDEDEDEFF, r_x, r_y, r_z, 20.0, INVALID_PLAYER_ID, vehicleid, 0, -1, -1, -1, 200.0);
	Streamer_Update(playerid, STREAMER_TYPE_3D_TEXT_LABEL ) ;

	Faction_SendMessage(factionid, sprintf("{ [%s] %s has set their unit to \"%s\" }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], ReturnMixedName ( playerid ), input
	), faction_enum_id, false ) ;

	return true ;
}