#define MAX_VEHICLE_ATTACHED_OBJECTS	10
#define CAR_ALARM_OBJECT    			18646
#define ALARM_SLOT		1
#define SIREN_BURRITO  	482
#define SIREN_PREMIER   426
#define SIREN_TAHOMA    566
#define SIREN_HUNTLEY   579
#define SIREN_CHEETAH   415
#define SIREN_BULLET    541
#define SIREN_BUFFALO   402
#define SIREN_SULTAN    560
#define SIREN_ELEGANT   507
#define SIREN_SENTINEL  405
#define SIREN_TOWTRUCK  525
enum veh_att_obj_enum
{
	vao_inuse,
	vao_object_id,
	vao_object_model_id,
	Float:vao_x,
	Float:vao_y,
	Float:vao_z,
	Float:vao_rx,
	Float:vao_ry,
	Float:vao_rz
}
new Vehicle_Object_Attachments[ MAX_VEHICLES ][ MAX_VEHICLE_ATTACHED_OBJECTS ][ veh_att_obj_enum ];
forward AttachObjectModelToVehicle	( modelid, vehicleid, attch_idx, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ);
forward IsObjectInVehicleSlot		( vehicleid, attch_idx );
forward RemoveObjectFromVehicleSlot	( vehicleid, attch_idx );
forward RemoveObjectFromVehicle		( vehicleid );
forward GetObjectModelInVehicleSlot ( vehicleid, attch_idx );
public AttachObjectModelToVehicle( modelid, vehicleid, attch_idx, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	RemoveObjectFromVehicleSlot( vehicleid, attch_idx );
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_object_id ] 		= CreateDynamicObject(modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_object_model_id ] = modelid;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_x ] 				= fOffsetX;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_y ] 				= fOffsetY;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_z ] 				= fOffsetZ;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_rx ] 				= fRotX;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_ry ] 				= fRotY;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_rz ] 				= fRotZ;
	Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_inuse ] 			= 1;
	AttachDynamicObjectToVehicle(Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_object_id ], vehicleid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
	return 1;
}
public IsObjectInVehicleSlot( vehicleid, attch_idx )
{
	return Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_inuse ];
}
public RemoveObjectFromVehicleSlot( vehicleid, attch_idx )
{
	if( Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_inuse ] )
	{
		SOLS_DestroyObject(Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_object_id ], "Siren/RemoveObjectFromVehicleSlot", true ) ;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_object_id ]		= 0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_object_model_id ] = 0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_x ] 				= 0.0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_y ] 				= 0.0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_z ] 				= 0.0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_rx ] 				= 0.0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_ry ] 				= 0.0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_rz ] 				= 0.0;
		Vehicle_Object_Attachments[ vehicleid ][ attch_idx ][ vao_inuse ] 			= 0;
		return 1;
	}
	return 0;
}
public RemoveObjectFromVehicle( vehicleid )
{
	for( new i; i < MAX_VEHICLE_ATTACHED_OBJECTS; i++ )
	{
		RemoveObjectFromVehicleSlot( vehicleid, i );
	}
	return 1;
}

new Float:gVehicleSirenOffsets[][3] = {
	{ 0.5,0.75,0.3},{ 0.5,0.7,0.4},{ -0.5,-0.5,0.81},{ 0.6,2.2,0.77},{ -0.5,-0.1,1.0},{ -0.4,-0.1,0.8},{ -0.5,3.0,1.1},{0.0,3.2,1.35},{ -0.6,2.75,1.05},{ -0.5,0.8,0.87},
	{ -0.4,-0.15,0.94},{ -0.45,0.0,0.75},{ -0.55,0.0,0.74},{ -0.55,0.7,1.16},{0.0,1.65,0.65},{ -0.4,-0.1,0.64},{0.0,0.9,1.25},{0.0, 0.0, 0.0},{ -0.5,0.5,1.05},{ -0.6,-0.15,0.74},
	{ -0.5,-0.1,0.9},{ -0.4,0.0,0.73},{ -0.6,0.15,0.85},{ -0.7,1.2,1.55},{0.0,0.6,0.5},{0.0, 0.0, 0.0},{ -0.6,-0.1,0.88},{0.0,1.1,1.3},{ -0.95,0.7,1.4},{ 0.55,0.65,0.35},
	{0.0, 0.0, 0.0},{ 0.9,5.7,1.0},{ -0.4,2.8,0.88},{ -0.6,1.3,1.7},{ -0.5,-0.3,0.83},{0.0, 0.0, 0.0},{ -0.48,-0.19,0.88},{ -1.0,5.0,2.1},{ -0.55,0.4,0.85},{ -0.43,-0.5,0.77},
	{ 0.5,1.5,0.4},{0.0, 0.0, 0.0},{ -0.5,0.15,0.95},{ 0.6,3.7,0.8},{ -0.6,0.4,1.73},{ -0.5,-0.05,0.88},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},{ -0.4,-0.4,0.62},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.6,1.3,1.73},{ 0.5,2.1,0.65},{ -0.3,0.3,1.37},{ -0.6,0.0,0.77},{ -0.5,0.8,1.15},
	{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.62,0.35,0.9},{ -0.55,0.2,0.87},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},
	{ -0.8,0.1,1.15},{0.0,0.2,0.7},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.4,-0.2,0.87},{ -0.5,-0.2,0.78},{0.0, 0.0, 0.0},{ -0.5,-0.3,0.75},{ -0.6,0.0,0.92},{ -0.6,0.1,1.01},
	{ 0.3,0.35,0.36},{0.0, 0.0, 0.0},{ -0.5,0.7,0.98},{ -0.48,1.4,1.08},{0.0, 0.0, 0.0},{0.0,0.7,0.8},{0.0,-1.5,1.45},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.62,0.1,1.15},
	{ -0.7,0.5,1.1},{ -0.4,-0.2,0.75},{ -0.5,0.0,0.92},{0.0, 0.0, 0.0},{ -0.4,-0.25,0.8},{ -0.7,0.3,1.03},{ -0.62,-0.1,0.85},{0.0, 0.0, 0.0},{ 0.9,2.3,0.9},{ 0.7,0.9,0.45},
	{ 0.3,0.5,0.45},{0.0, 0.0, 0.0},{ -0.4,-0.25,0.8},{ -0.4,-0.25,0.85},{ -0.4,0.15,0.95},{ -0.75,-0.1,1.14},{ -0.5,-0.4,0.65},{ -0.55,-0.15,0.85},{0.0,2.1,0.3},{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.5,1.4,1.4},{ 0.8,2.2,0.6},{ -0.5,-0.1,0.9},{ -0.62,0.1,0.86},{ -0.54,0.0,0.76},{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.6,1.4,0.93},{0.0,-0.5,1.4},{ -0.4,-0.2,0.7},{ -0.4,-0.2,0.9},{ -0.5,0.3,1.1},{ -0.5,-0.1,0.95},
	{ -0.3,-1.0,1.93},{0.0,0.5,0.5},{ -1.0,3.75,2.2},{ 0.5,0.65,0.3},{ -0.5,0.0,0.7},{ -0.6,-0.1,0.86},{ 0.5,0.7,0.2},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0,1.1,0.6},
	{ -0.5,-0.1,0.75},{ -0.45,-0.2,0.68},{ -0.5,-0.2,0.86},{ -0.6,0.13,0.94},{0.0,2.5,1.5},{ -0.4,-0.2,0.82},{ -0.6,-0.1,0.87},{ -0.62,0.1,0.92},{0.0, 0.0, 0.0},{ -0.5,0.15,0.75},
	{ -0.56,0.1,0.75},{ -0.45,-0.05,0.92},{ -0.6,0.7,1.36},{0.0, 0.0, 0.0},{ -0.5,0.0,1.1},{ 0.45,0.4,0.25},{ -0.7,0.3,1.7},{ -0.7,0.2,1.7},{ -0.4,0.0,0.9},{ -0.5,0.0,0.78},
	{ -0.5,0.3,0.85},{ -0.4,0.1,0.85},{ -0.5,-0.2,0.8},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.5,-0.2,0.73},{ -0.7,0.1,0.9},{0.0,1.15,0.2},{0.0,-0.95,0.4},{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},{0.0,0.2,0.0},{0.0,0.5,0.5},{ -0.7,2.0,1.6},{0.0,0.45,1.3},{ 0.5,0.8,0.6},{ -0.6,0.0,0.92},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.7,-0.1,1.3},
	{ 0.75,0.75,0.6},{0.0, 0.0, 0.0},{ -0.6,0.6,1.2},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{ -0.65,0.0,1.05},{0.0, 0.0, 0.0},{ -0.5,-0.3,0.79},{0.0, 0.0, 0.0},{ -0.55,-0.1,1.1},
	{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0,-0.4,0.91},{0.0,-0.4,0.91},{0.0,-0.35,0.97},{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},{0.0, 0.0, 0.0},{0.0, 0.0, 0.0}
};

stock DoesVehicleHaveNativeSiren(id, needs_convert = true) {
	new model = id;
	if(needs_convert) {
		model = GetVehicleModel(id);
	}
	
	if(model == 523 || model == 427 || model == 490 || model == 528 || model == 407 || (model >= 596 && model <= 599) || model == 601) {
		return 1;
	}
	
	return 0;
}

stock AddSiren(vehicleid, playerid = INVALID_PLAYER_ID) {
	new model = GetVehicleModel(vehicleid);
	if(!model) {
		SendClientMessage(playerid, COLOR_ERROR, "You're not in a vehicle!");
		return -1;
	}
	
	model -= 400;
	
	if(gVehicleSirenOffsets[model][0] == 0.0 && gVehicleSirenOffsets[model][1] == 0.0 && gVehicleSirenOffsets[model][2] == 0.0) {
		SendClientMessage(playerid, COLOR_ERROR, "This vehicle doesn't support a siren!");
		return 0;
	}
	
	AttachObjectModelToVehicle(CAR_ALARM_OBJECT, vehicleid, ALARM_SLOT, gVehicleSirenOffsets[model][0], gVehicleSirenOffsets[model][1], gVehicleSirenOffsets[model][2], 0.0, 0.0, 0.0);
	
	return 1;
}

CMD:siren(playerid, params[]) {

    if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}
	
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}


	if ( Faction [ faction_enum_id ] [ E_FACTION_TYPE ] != 0 && Faction [ faction_enum_id ] [ E_FACTION_TYPE ] != 3 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a government faction.");
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(vehicleid == 0) {
		return SendClientMessage(playerid, COLOR_ERROR, "You're not in a vehicle!");
	}

	if (DoesVehicleHaveCustomSirens(vehicleid))
	{
		return SendClientMessage(playerid, COLOR_ERROR, "Press 2 instead to cycle siren stages on this vehicle.");
	}
	
	if(IsObjectInVehicleSlot(vehicleid, ALARM_SLOT)) {
		RemoveObjectFromVehicleSlot(vehicleid, ALARM_SLOT);
		GameTextForPlayer(playerid, "~r~Siren turned off!", 3000, 4);
	}else{
		if(AddSiren(vehicleid, playerid)) {
			GameTextForPlayer(playerid, "~g~Siren turned on!", 3000, 4);		
		}
	}
	
	return 1;
}