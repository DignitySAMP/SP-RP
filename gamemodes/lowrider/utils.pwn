IsLowriderVehicle(vehicleid)
{
    // We don't discriminate between models, we just check if the vehicle has hydraulics. This means they are eligible.
    if(GetVehicleComponentInSlot(vehicleid, CARMODTYPE_HYDRAULICS) != 1087 || GetVehicleComponentInSlot(vehicleid, CARMODTYPE_HYDRAULICS) != 1087) {
        return true;
    }
	return false;
}
