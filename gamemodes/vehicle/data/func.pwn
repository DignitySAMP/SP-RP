/*
	-> Lets you encode specific lights, tires etc for example front left, front right, etc.
	Example: https://www.youtube.com/watch?v=-nKORw97m4I
	https://pastebin.com/ggcTL5nN

	encode_tires(tire1, tire2, tire3, tire4) return tire1 | (tire2 << 1) | (tire3 << 2) | (tire4 << 3);
	encode_panels(flp, frp, rlp, rrp, windshield, front_bumper, rear_bumper)
	{
	    return flp | (frp << 4) | (rlp << 8) | (rrp << 12) | (windshield << 16) | (front_bumper << 20) | (rear_bumper << 24);
	}
	encode_doors(bonnet, boot, driver_door, passenger_door, behind_driver_door, behind_passenger_door)
	{
	    #pragma unused behind_driver_door
	    #pragma unused behind_passenger_door
	    return bonnet | (boot << 8) | (driver_door << 16) | (passenger_door << 24);
	}
	encode_lights(light1, light2, light3, light4)
	{
	    return light1 | (light2 << 1) | (light3 << 2) | (light4 << 3);
	}
*/
new stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Cruiser", "SFPD Cruiser", "Sheriff Cruiser",
    "Sheriff Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};


IsWindowedVehicle(vehicleid)
{
	static const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aWindowStatus[modelid - 400]);
}

IsEngineVehicle(vehicleid)
{
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}


ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

ReturnVehicleHealth(vehicleid)
{
	if (!IsValidVehicle(vehicleid))
	    return 0;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}


stock GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return 0;
}

GetEngineStatus(vehicleid) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != 1)
		return 0;

	return 1;
}

SetAllVehicleDoorsOpen(vehicleid, newstate, enumid = -1)
{
	if (enumid == -1) enumid = Vehicle_GetEnumID(vehicleid);
	if (enumid == -1) return 0;

	for (new i = 0; i < 4; i ++)
	{
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][i] = newstate;
	}

	SetVehicleParamsCarDoors(vehicleid, 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][0], 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][1], 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][2], 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][3]
	);

	return 1;
}

SetVehicleDoorOpen(vehicleid, seat, newstate, enumid = -1)
{
	if (enumid == -1) enumid = Vehicle_GetEnumID(vehicleid);
	if (enumid == -1) return 0;

	Vehicle[enumid][E_VEHICLE_DOOR_STATE][seat] = newstate;

	SetVehicleParamsCarDoors(vehicleid, 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][0], 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][1], 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][2], 
		Vehicle[enumid][E_VEHICLE_DOOR_STATE][3]
	);

	return 1;
}

IsVehicleDoorOpen(vehicleid, seat, bool:checklocked = false, enumid = -1) 
{
	if (enumid == -1) enumid = Vehicle_GetEnumID(vehicleid);

	if (enumid != -1 && (!checklocked || !GetDoorStatus(vehicleid)))
	{
		if (Vehicle[enumid][E_VEHICLE_DOOR_STATE][seat] == VEHICLE_PARAMS_ON)
		{
			// Door is OPEN
			return 1;
		}

		// Probably don't need this fallback here.
		/*
		new lf, rf, lr, rr;
		GetVehicleParamsCarDoors(vehicleid, lf, rf, lr, rr);

		switch (seat)
		{
			case 0: return lf == VEHICLE_PARAMS_ON;
			case 1: return rf == VEHICLE_PARAMS_ON;
			case 2: return lr == VEHICLE_PARAMS_ON;
			case 3: return rr == VEHICLE_PARAMS_ON;
		}
		*/
	}

	return 0;
}

GetDoorStatus(vehicleid) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (doors != 1)
		return 0;

	return 1;
}

GetHoodStatus(vehicleid) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return 0;

	return 1;
}

GetTrunkStatus(vehicleid) { 
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (boot != 1)
		return 0;

	return 1;
}

GetLightStatus(vehicleid) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != 1)
		return 0;

	return 1;
}

SetEngineStatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}
SetDoorStatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (status)
	{
		// Lock, so close all doors
		SetAllVehicleDoorsOpen(vehicleid, VEHICLE_PARAMS_OFF);
	}

	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, status, bonnet, boot, objective);
}

SetLightStatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

SetTrunkStatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
}

SetHoodStatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}


/*Float:TRP_GetVehicleSpeed(vehicleid)
{
	new
	Float:	speed_x,
	Float:	speed_y,
	Float:	speed_z,
	Float:	temp_speed;

	GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);

	temp_speed = floatsqroot( ( (speed_x * speed_x ) + ( speed_y * speed_y ) ) + ( speed_z * speed_z ) ) * 136.666667;

	return temp_speed;
}*/


TRP_GetVehicleSpeed( vehicleid ) 
{ 
	if ( IsValidVehicle(vehicleid)){

	    new 
	        Float:x, 
	        Float:y, 
	        Float:z, 
	        vel; 
	    GetVehicleVelocity( vehicleid, x, y, z ); 
	    vel = floatround( floatsqroot( x*x + y*y + z*z ) * 90 ); 
	    //printf("VehicleSpeed: %d (altered: %d)", floatround( floatsqroot( x*x + y*y + z*z )), vel ) ;
	    return vel; 
	}

	return 1 ;
} 


IsACar(vehicleid) {

	if ( IsABike(vehicleid)) return 0 ;
	if ( IsABoat(vehicleid)) return 0 ;
	if ( IsAircraft(vehicleid)) return 0 ;

	return 1 ;
}

IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595, 460: return 1;
	}
	return 0;
}

IsABike(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 448, 461..463, 468, 471, 521..523, 581, 586, 481, 509, 510: return 1;
	}
	return 0;
}
IsGovVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 596, 597, 598, 595, 599, 564, 544, 501, 497, 490, 472, 469, 465, 464, 432, 433, 430, 427, 425, 416, 407, 406: return 1;
	}
	return 0;
}


IsAircraft(vehicleid) {

	if (IsAPlane(vehicleid)) {
		return true ;
	}

	if ( IsAHelicopter(vehicleid) ) {

		return true ;
	}

	return false ;
}

IsAPlane(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return 1;
	}
	return 0;
}

IsAHelicopter(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return 1;
	}
	return 0;
}

IsVehicleOccupied(vehicleid)
{
	for(new i;i < GetMaxPlayers();++i)
	{
		if(IsPlayerConnected(i) && GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == 0)
			return true;
	}
	return false;
}

stock GetVehicleRelativePos(vehicleid, &Float:x, &Float:y, &Float:z, Float:xoff=0.0, Float:yoff=0.0, Float:zoff=0.0)
{
    new Float:rot;
    GetVehicleZAngle(vehicleid, rot);
    rot = 360 - rot;    // Making the vehicle rotation compatible with pawns sin/cos
    GetVehiclePos(vehicleid, x, y, z);
    x = floatsin(rot,degrees) * yoff + floatcos(rot,degrees) * xoff + x;
    y = floatcos(rot,degrees) * yoff - floatsin(rot,degrees) * xoff + y;
    z = zoff + z;

    /*
       where xoff/yoff/zoff are the offsets relative to the vehicle
       x/y/z then are the coordinates of the point with the given offset to the vehicle
       xoff = 1.0 would e.g. point to the right side of the vehicle, -1.0 to the left, etc.
    */
}

stock GetVehicleClosestSeatToPlayer(veh, playerid)
{
    new Float:fx, Float:fy, Float:fz;
	new Float:rx, Float:ry, Float:rz;

	new model = GetVehicleModel(veh);
	GetVehicleModelInfo(model, VEHICLE_MODEL_INFO_FRONTSEAT, fx, fy, fz); // Front seat pos (middle)
	GetVehicleModelInfo(model, VEHICLE_MODEL_INFO_REARSEAT, rx, ry, rz); // Back seat pos (middle)

	new Float:vrx, Float:vry, Float:vrz;
	new Float:vlx, Float:vly, Float:vlz;
	GetVehicleRelativePos(veh, vrx, vry, vrz, 1.0, 0.0, 0.0);  // Left vehicle pos
	GetVehicleRelativePos(veh, vlx, vly, vlz, -1.0, 0.0, 0.0); // Right vehicle pos

	new right = 0;
	new back = 0;

	// Left/Right
	right = GetPlayerDistanceFromPoint(playerid, vrx, vry, vrz) < GetPlayerDistanceFromPoint(playerid, vlx, vly, vlz);

	// Front/Back
	if (rx != 0 && ry != 0 && rz != 0)
	{
		new Float:backx, Float:backy, Float:backz, Float:frontx, Float:fronty, Float:frontz;
        GetVehicleRelativePos(veh, frontx, fronty, frontz, fx, fy, fz);
		GetVehicleRelativePos(veh, backx, backy, backz, rx, ry, rz);

		back = GetPlayerDistanceFromPoint(playerid, backx, backy, backz) < GetPlayerDistanceFromPoint(playerid, frontx, fronty, frontz);
	}

	return right ? (back ? 3 : 1) : (back ? 2: 0);
}

stock GetPosBehindVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5)
{
    new Float:vehicleSize[3], Float:vehiclePos[3];
    GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
    GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
    x = vehiclePos[0];
    y = vehiclePos[1];
    z = vehiclePos[2];
    return 1;
}

stock GetPosInfrontVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5)
{
    new Float:vehicleSize[3], Float:vehiclePos[3];
    GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
    GetXYInFrontOfVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
    x = vehiclePos[0];
    y = vehiclePos[1];
    z = vehiclePos[2];
    return 1;
}

GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance)
{
    new Float:a;
    GetVehiclePos(vehicleid, q, w, a);
    GetVehicleZAngle(vehicleid, a);
    q += (distance * -floatsin(-a, degrees));
    w += (distance * -floatcos(-a, degrees));
}
GetXYInFrontOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetVehiclePos(vehicleid, x, y, a);
    GetVehicleZAngle(vehicleid, a);
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

GetVehicleDriver(vehicleid) {
	foreach (new i : Player) {
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}


// Forces car door state to closed when a player enters or exits a car (needed for /cardoor and for cuffs)
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
		// Close the door if they leave.
		if (!IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = PlayerVar[playerid][E_PLAYER_LAST_VEHICLE];
			new seat = PlayerVar[playerid][E_PLAYER_LAST_VEHICLE_SEAT];

			if (vehicleid != -1 && seat < 4)
			{
				if (IsValidVehicle(vehicleid))
				{
					SetVehicleDoorOpen(vehicleid, seat, VEHICLE_PARAMS_OFF);
				}
			}

			PlayerVar[playerid][E_PLAYER_LAST_VEHICLE] = 0;
			PlayerVar[playerid][E_PLAYER_LAST_VEHICLE_SEAT] = -1;

			new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;
			if ( veh_enum_id != -1 ) {
				VehicleVar[veh_enum_id][E_VEHICLE_LAST_USED] = gettime() + 90; // 90 seconds timer
			}
		}
	}

	if (newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER)
    {
		// Close the door after they enter.
		new vehicleid = GetPlayerVehicleID(playerid);

		if (vehicleid && IsValidVehicle(vehicleid))
		{
			new seat = GetPlayerVehicleSeat(playerid);
			PlayerVar[playerid][E_PLAYER_LAST_VEHICLE] = vehicleid;
			PlayerVar[playerid][E_PLAYER_LAST_VEHICLE_SEAT] = seat;

			if (seat < 4)
			{
				SetVehicleDoorOpen(vehicleid, seat, VEHICLE_PARAMS_OFF);
			}
		}
	}

	return 1;
}