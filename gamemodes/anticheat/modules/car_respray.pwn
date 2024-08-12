
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//* Rudimentary car respray hack detection

new vehicleColors[MAX_VEHICLES][2];

// This gets called every second, see Anticheat_Tick
CheckVehicleColorMatches(vehicleid) {

    new veh_enum_id = Vehicle_GetEnumID(vehicleid);
    if (veh_enum_id == -1) return 0;

    // No need to warn, just fix it silently.
    if(vehicleColors[vehicleid][0] != Vehicle[veh_enum_id][E_VEHICLE_COLOR_A] || vehicleColors[vehicleid][1] != Vehicle[veh_enum_id][E_VEHICLE_COLOR_B]) {
        ChangeVehicleColor(vehicleid, Vehicle[veh_enum_id][E_VEHICLE_COLOR_A], Vehicle[veh_enum_id][E_VEHICLE_COLOR_B]);
    }

    return 1;
}

ChangeVehicleColorEx(vehicleid, colorA, colorB) {
    vehicleColors[vehicleid][0] = colorA;
    vehicleColors[vehicleid][1] = colorB;
    ChangeVehicleColor(vehicleid, colorA, colorB);
}
