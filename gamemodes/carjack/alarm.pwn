StartVehicleAlarm(vehicleid) {

	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	if ( veh_enum_id == -1 ) {

		return true ;
	}

	if ( GetAlarmStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]) || GetObjectiveStatus(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]) ) {

		return true ;
	}

	SetAlarmStatus ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], true ) ;
	SetObjectivetatus ( Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ], true ) ;
	Alarm_SendPoliceAlert(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ]);


	defer StopVehicleAlarm(vehicleid) ;

	return true ;
}

timer StopVehicleAlarm[180000](vehicleid) {

	new veh_enum_id = Vehicle_GetEnumID(vehicleid) ;

	if ( veh_enum_id == -1 ) {

		return true ;
	}

	if ( IsValidVehicle(Vehicle [ veh_enum_id ] [ E_VEHICLE_ID ] ) ) {

		ClearAlarmData ( vehicleid ) ;
	}

	return true ;
}

ClearAlarmData ( vehicleid ) {
	SetAlarmStatus ( vehicleid, false ) ;
	SetObjectivetatus ( vehicleid, false ) ;
}

stock GetAlarmStatus(vehicleid) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (alarm != 1)
		return 0;

	return 1;
}
stock SetAlarmStatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, status, doors, bonnet, boot, objective);
}

stock GetObjectiveStatus(vehicleid) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (objective != 1)
		return 0;

	return 1;
}
stock SetObjectivetatus(vehicleid, status) {
	static engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, status);
}