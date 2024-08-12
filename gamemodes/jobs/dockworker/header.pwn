
#define INVALID_DOCKWORKER_TASK_ID	-1 

#include "jobs/dockworker/data.pwn"
#include "jobs/dockworker/cmds.pwn"


Dockworker_SetPlayerVariables ( playerid ) {
	PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_STORE ] = INVALID_DOCKWORKER_TASK_ID ;
	PlayerJobVars [ playerid ] [ E_DOCK_JOB_NEXT_TASK_COLLECT ] = INVALID_DOCKWORKER_TASK_ID ;
	PlayerJobVars [ playerid ] [ E_DOCK_JOB_CURRENT_CARGO ] = INVALID_DOCKWORKER_TASK_ID ;
}