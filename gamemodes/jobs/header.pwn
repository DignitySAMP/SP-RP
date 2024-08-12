/*
AddStaticVehicle(481,2748.7808,-2457.3875,13.1637,168.7422,179,1); // forklift_1
AddStaticVehicle(481,2745.7878,-2457.5078,13.1628,165.0299,179,1); // forklift_2
AddStaticVehicle(481,2742.2478,-2457.0244,13.1629,168.9156,179,1); // forklift_3

*/

#include "jobs/dockworker/header.pwn"
#include "jobs/trucker/header.pwn"
#include "jobs/garbage/header.pwn"
//#include "jobs/newspaper/header.pwn"


Jobs_Init() {

	Job_Dockworker_Init() ;
	Trucker_LoadEntities();
	GarbageJob_LoadEntities();
}

stock SendDebug(msg[])
{
	SendClientMessageToAll(-1, msg);
	return 1;
}