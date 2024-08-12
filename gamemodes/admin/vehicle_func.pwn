stock GetClosestVehicle(playerid)
{
        new v = -1;
        new Float:dis = 99999.99;
        for (new i=1;i<MAX_VEHICLES;i++){
            if ( IsValidVehicle ( i ) ) {
                new Float:x,Float:y,Float:z;
                GetVehiclePos(i,x,y,z);
                new Float:dis2 = GetPlayerDistanceFromPoint(playerid,x,y,z);
                if(dis2 < dis && i != GetPlayerVehicleID(playerid) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(i))
                {
                    dis = dis2;
                    v = i;
                }
            }
        }
        return v;
} 
stock GetClosestVehicleEx(playerid, Float: distance = 10.0)
{
    new v = -1;
    new Float:dis = 99999.99;
    for (new i=1;i<MAX_VEHICLES;i++){
        if ( IsValidVehicle ( i ) ) {
            new Float:x,Float:y,Float:z;
            GetVehiclePos(i,x,y,z);
            new Float:dis2 = GetPlayerDistanceFromPoint(playerid,x,y,z);
            if(dis2 < dis && i != GetPlayerVehicleID(playerid) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(i))
            {
                dis = dis2;
                v = i;
            }
        }
    }

    if ( dis > distance ) {
        v = INVALID_VEHICLE_ID ;
    }

    return v;
} 


stock GetVehicleMaxSeats(vehicleid)
{
    new VehicleSeats[] = {
        4,2,2,2,4,4,1,2,2,4,2,2,2,4,2,2,4,2,4,2,4,4,2,2,2,1,4,4,4,2,1,500,1,2,2,0,2,500,4,2,4,1,2,2,2,4,1,2,
        1,0,0,2,1,1,1,2,2,2,4,4,2,2,2,2,1,1,4,4,2,2,4,2,1,1,2,2,1,2,2,4,2,1,4,3,1,1,1,4,2,2,4,2,4,1,2,2,2,4,
        4,2,2,1,2,2,2,2,2,4,2,1,1,2,1,1,2,2,4,2,2,1,1,2,2,2,2,2,2,2,2,4,1,1,1,2,2,2,2,500,500,1,4,2,2,2,2,2,
        4,4,2,2,4,4,2,1,2,2,2,2,2,2,4,4,2,2,1,2,4,4,1,0,0,1,1,2,1,2,2,1,2,4,4,2,4,1,0,4,2,2,2,2,0,0,500,2,2,
        1,4,4,4,2,2,2,2,2,4,2,0,0,0,4,0,0
    };
    
    if ( vehicleid < 0 || vehicleid > sizeof ( VehicleSeats ) ) {

        return 0 ;
    }

  
    return VehicleSeats[(GetVehicleModel(vehicleid) - 400)];
}


stock GetAvailableVehicleSeat(vehicleid) {

    const MAX_SEATS = 500;
    new seatTaken[MAX_SEATS];
    for (new i = 0; i < MAX_SEATS; i++) {
        seatTaken[i] = false;
    }

    new seat ;

    foreach(new i: Player)  {
        if (GetPlayerVehicleID(i) == vehicleid) {
            seat = GetPlayerVehicleSeat(i);
            if (seat != -1) {
                seatTaken[seat] = true;
            }
        }
    }

    for (new i = 0; i < MAX_SEATS; i++) {
        if (!seatTaken[i]) {
            if (i > GetVehicleMaxSeats(vehicleid)-1) return -1; //Car is full
            else return i; //Car has a spare seat at position i
        }
    }
    return -1;//Car is full
}