
CMD:passpointlink(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	
	new idx ;

	if ( sscanf ( params, "i", idx ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointlink [id] (takes current position)");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	new Float: x, Float: y, Float: z, Float:a;
	GetPlayerPos(playerid, x, y, z );
	GetPlayerFacingAngle(playerid, a);

	Passpoint [ idx ] [ E_PASSPOINT_LINKED_X ] = x ;
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_Y ] = y ;
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_Z ] = z ;
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_A ] = a - 180.0;

	Passpoint [ idx ] [ E_PASSPOINT_LINKED_WORLD ] = GetPlayerVirtualWorld(playerid);
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_INTERIOR ]	= GetPlayerInterior(playerid) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), 
		"UPDATE passpoints SET passpoint_linked_x = '%f', passpoint_linked_y = '%f', passpoint_linked_z = '%f',\
		passpoint_linked_a = '%f', passpoint_linked_world = %d, passpoint_linked_interior = %d WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_LINKED_X ], Passpoint [ idx ] [ E_PASSPOINT_LINKED_Y ], Passpoint [ idx ] [ E_PASSPOINT_LINKED_Z ],
		Passpoint [ idx ] [ E_PASSPOINT_LINKED_A ], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), 
		Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	SendClientMessage(playerid, -1, query);
	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Linked passpoint %d to your current location, world & opposite facing angle.", idx ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	PassPoint_SetupLabel(idx) ;
	return true ;
}

CMD:passpointdelete(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx ;

	if ( sscanf ( params, "i", idx ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointdelete [id]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "DELETE FROM passpoints WHERE passpoint_sqlid = %d", Passpoint [ idx ] [ E_PASSPOINT_SQLID ] ) ;
	mysql_tquery(mysql, query);

	if ( IsValidDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ] ) ) {

		DestroyDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 0 ] ) ;
	}
	if ( IsValidDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ]  [ 1 ]) ) {

		DestroyDynamic3DTextLabel( Passpoint [ idx ] [ E_PASSPOINT_LABEL ] [ 1 ] ) ;
	}


	Passpoint [ idx ] [ E_PASSPOINT_SQLID ] = INVALID_PASSPOINT_ID ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_X ] = 0.0 ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_Y ] = 0.0 ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_Z ] = 0.0 ;

	Passpoint [ idx ] [ E_PASSPOINT_WORLD ] = 99999 ;
	Passpoint [ idx ] [ E_PASSPOINT_INTERIOR ] = 99999 ;

	Passpoint [ idx ] [ E_PASSPOINT_LINKED_X ] = 0.0 ;
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_Y ] = 0.0 ;
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_Z ] = 0.0 ;

	Passpoint [ idx ] [ E_PASSPOINT_LINKED_WORLD ] = 99999 ;
	Passpoint [ idx ] [ E_PASSPOINT_LINKED_INTERIOR ] = 99999 ;

	format ( query, sizeof ( query ), "Deleted passpoint %d from the server.", idx ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	Iter_Remove(Passpoints, idx);

	return true ;
}

CMD:passpointgoto(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx ;

	if ( sscanf ( params, "i", idx ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointgoto [id]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	SetPlayerInterior(playerid, Passpoint [ idx ] [ E_PASSPOINT_INTERIOR]);
	SetPlayerVirtualWorld(playerid, Passpoint [ idx ] [ E_PASSPOINT_WORLD]);
	SOLS_SetPlayerPos(playerid, Passpoint [ idx ] [ E_PASSPOINT_POS_X], Passpoint [ idx ] [ E_PASSPOINT_POS_Y], Passpoint [ idx ] [ E_PASSPOINT_POS_Z], false);
	SetPlayerFacingAngle(playerid, Passpoint [ idx ] [ E_PASSPOINT_POS_A ]);
	

	new query [ 256 ] ;
	format ( query, sizeof ( query ), "Teleported you to passpoint %d.", idx ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	return true ;
}

CMD:passpointfaction(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new idx, faction ;

	if ( sscanf ( params, "ii", idx, faction ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointfaction [id] [faction_sql: 0 to disable]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	Passpoint [ idx ] [ E_PASSPOINT_FACTION ] = faction ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_faction = %d WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_FACTION ], Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Changed passpoint %d faction to SQL %d.", idx, Passpoint [ idx ] [ E_PASSPOINT_FACTION ] ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	return true ;
}
CMD:passpointtype(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}
	new idx, type ;

	if ( sscanf ( params, "ii", idx, type ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointtype [id] [type (0: player, 1: vehicle)]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	Passpoint [ idx ] [ E_PASSPOINT_TYPE ] = type ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_type = %d WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_TYPE ], Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Changed passpoint %d's type to SQL %d.", idx, Passpoint [ idx ] [ E_PASSPOINT_TYPE ] ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );
	
	return true ;
}

CMD:passpointmoveint(playerid, params[]) 
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, interior;
	if ( sscanf ( params, "dd", id, interior ) ) 
	{
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/passpointmoveint [passpoint id] [interior world id]") ;
		return SendClientMessage(playerid, 0xDEDEDEFF, "This sets only the interior ID of the ORIGINAL point.");
	}

	if ( Passpoint [ id ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID || id < 0 ) 
	{
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	Passpoint [ id ] [ E_PASSPOINT_INTERIOR ] = interior;
	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_pos_interior = %d WHERE passpoint_sqlid = %d",
		Passpoint [ id ] [ E_PASSPOINT_INTERIOR ],
		Passpoint [ id ] [ E_PASSPOINT_SQLID ]
	);

	mysql_tquery(mysql, query);
	SendClientMessage(playerid, COLOR_GRAD1, sprintf("You changed the interior ID of the original point of passpoint %d to %d.", id, interior));

	return true;
}

CMD:passmoveint(playerid, params[]) 
{
	return cmd_passpointmoveint(playerid, params);
}

CMD:passpointlinkint(playerid, params[]) 
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new id, interior;
	if ( sscanf ( params, "dd", id, interior ) ) 
	{
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "DEDEDE", "/passpointlinkint [passpoint id] [interior world id]") ;
		return SendClientMessage(playerid, 0xDEDEDEFF, "This sets only the interior ID of the LINKED point.");
	}

	if ( Passpoint [ id ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID || id < 0 ) 
	{
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	Passpoint [ id ] [ E_PASSPOINT_LINKED_INTERIOR ] = interior;
	new query [ 128 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_linked_interior = %d WHERE passpoint_sqlid = %d",
		Passpoint [ id ] [ E_PASSPOINT_LINKED_INTERIOR ],
		Passpoint [ id ] [ E_PASSPOINT_SQLID ]
	);

	mysql_tquery(mysql, query);
	SendClientMessage(playerid, COLOR_GRAD1, sprintf("You changed the interior ID of the linked point of passpoint %d to %d.", id, interior));

	return true;
}

CMD:passlinkint(playerid, params[]) {

	return cmd_passpointlinkint(playerid, params);
}

CMD:passpointmove(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx ;

	if ( sscanf ( params, "i", idx ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointmove [id] (takes current position)");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	new Float: x, Float: y, Float: z, Float:a ;
	GetPlayerPos(playerid, x, y, z );
	GetPlayerFacingAngle(playerid, a);

	Passpoint [ idx ] [ E_PASSPOINT_POS_X ] = x ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_Y ] = y ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_Z ] = z ;
	Passpoint [ idx ] [ E_PASSPOINT_POS_A ] = a - 180.0;
	

	Passpoint [ idx ] [ E_PASSPOINT_WORLD ] = GetPlayerVirtualWorld(playerid);
	Passpoint [ idx ] [ E_PASSPOINT_INTERIOR ]	= GetPlayerInterior(playerid) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), 
		"UPDATE passpoints SET passpoint_pos_x = '%f', passpoint_pos_y = '%f', passpoint_pos_z = '%f',\
		passpoint_pos_a = '%f', passpoint_pos_world = %d, passpoint_pos_interior = %d WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_POS_X ], Passpoint [ idx ] [ E_PASSPOINT_POS_Y ], Passpoint [ idx ] [ E_PASSPOINT_POS_Z ],
		Passpoint [ idx ] [ E_PASSPOINT_POS_A ], Passpoint [ idx ] [ E_PASSPOINT_WORLD ], Passpoint [ idx ] [ E_PASSPOINT_INTERIOR ], 
		Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Moved passpoint %d to your current location, world & opposite facing angle.", idx ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	PassPoint_SetupLabel(idx) ;
	return true ;
}
CMD:passpointname(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx, name[64] ;

	if ( sscanf ( params, "is[64]", idx, name ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointname [id] [name]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	if ( strlen ( name ) <= 0 || strlen ( name ) >= sizeof ( name ) ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "String size must be more than 0 but less than 64.");
	}

	format ( Passpoint [ idx ] [ E_PASSPOINT_DESC ], 64, "%s", name ) ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_desc = '%e' WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_DESC ], Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Renamed passpoint %d to %s", idx, Passpoint [ idx ] [ E_PASSPOINT_DESC ] ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	PassPoint_SetupLabel(idx) ;

	return true ;
}

CMD:passpointcolor(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx, hex_color ;

	if ( sscanf ( params, "ih", idx, hex_color ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointcolor [id] [HEX: colorpicker.com, i.e. 0x______FF (0xDEDEDEFF)]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	Passpoint [ idx ] [ E_PASSPOINT_COLOR ] = hex_color ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_color = %d WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_COLOR ], Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Changed passpoint %d color to (decimal): %d.", idx, Passpoint [ idx ] [ E_PASSPOINT_COLOR ] ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	PassPoint_SetupLabel(idx) ;

	return true ;
}


CMD:passpointradius(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new idx, Float: radius ;

	if ( sscanf ( params, "if", idx, radius ) ) {

		return  SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/passpointradius [id] [radius: default 7.5]");
	}

	if ( Passpoint [ idx ] [ E_PASSPOINT_SQLID ] == INVALID_PASSPOINT_ID ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Passpoint isn't set up!");
	}

	if ( radius < 0 || radius > 10 ) {
		return  SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Can't be less than 0.10 or more than 10.");
	}

	Passpoint [ idx ] [ E_PASSPOINT_RADIUS ] = radius ;

	new query [ 256 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE passpoints SET passpoint_radius = '%f' WHERE passpoint_sqlid = %d", 

		Passpoint [ idx ] [ E_PASSPOINT_RADIUS ], Passpoint [ idx ] [ E_PASSPOINT_SQLID ]
	) ;

	mysql_tquery(mysql, query);

	format ( query, sizeof ( query ), "Changed passpoint %d radius to %f.", idx, Passpoint [ idx ] [ E_PASSPOINT_RADIUS ] ) ;
	SendServerMessage ( playerid, COLOR_BLUE, "Passpoint", "A3A3A3", query );

	PassPoint_SetupLabel(idx) ;

	return true ;
}