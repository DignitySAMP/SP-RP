//------------------------------------------------------------------------------
// Noclip camera mode for admins
// Original code by h02, adapted for SOLS by Sporks

//-------------------------------------------------
//
// This is an example of using the AttachCameraToObject function
// to create a no-clip flying camera.
//
// h02 2012
//
// SA-MP 0.3e and above
//
//-------------------------------------------------

#include <YSI_Coding\y_hooks>

// Players Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

// Enumeration for storing data about the player
enum noclipenum
{
	cameramode,
	flyobject,
	flymode,
	lrold,
	udold,
	lastmove,
	Float:accelmul,
	Float:oldpos[4],
	oldworld,
	oldinterior,
	bool:respawn
}
new noclipdata[MAX_PLAYERS][noclipenum];

// -- adaptations for SOLS

static bool:IsFreecamAdmin(playerid)
{
	return GetPlayerAdminLevel(playerid) >= ADMIN_LVL_GENERAL;
}

static SendFreecamAdminMsg(const msg[])
{
	SendAdminMessage(msg);
	return 1;
}

static SendFreecamErrorMsg(playerid, const msg[])
{
	return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", msg);
}

static SendFreecamSyntaxMsg(playerid, const msg[])
{
	return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", msg);
}

//--------------------------------------------------

/*
hook OnGameModeInit()
{
	// If any players are still in edit mode, boot them out before the filterscript unloads
	for(new x; x<MAX_PLAYERS; x++)
	{
		if(noclipdata[x][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(x);
	}
	return 1;
}
*/

//--------------------------------------------------

hook OnPlayerConnect(playerid)
{
	// Reset the data belonging to this player slot
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][flymode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
	noclipdata[playerid][respawn]   	= false;
	return 1;
}

//--------------------------------------------------

CMD:noclip(playerid)
{
    // Place the player in and out of edit mode
    if (GetPVarType(playerid, "FlyMode"))
	{
		if (!IsFreecamAdmin(playerid))
		{
			new string[144];
			format(string, sizeof(string), "[NOCLIP] %s (%d) exited freecam mode.", ReturnMixedName(playerid), playerid);
			SendFreecamAdminMsg(string);
			CancelFlyMode(playerid);
		}
		else CancelFlyMode(playerid, .teleport = true);

	} 

	else if (!IsFreecamAdmin(playerid)) return SendFreecamErrorMsg(playerid, "You don't have permission to use this command.");
	else if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return SendFreecamErrorMsg(playerid, "You can't do this while spectating.");
    else FlyMode(playerid);
    return 1;
}

CMD:freecam(playerid)
{
	return cmd_noclip(playerid);
}

CMD:togglenoclip(playerid, params[])
{
    if (!IsFreecamAdmin(playerid)) return SendFreecamErrorMsg(playerid, "You don't have permission to use this command.");

	new giveplayerid;

	if (sscanf(params, "r", giveplayerid))
        return SendFreecamSyntaxMsg(playerid, "/togglenoclip [player]");

    // Place the player in and out of edit mode
    if (GetPVarType(giveplayerid, "FlyMode")) CancelFlyMode(giveplayerid);
    else
	{
		FlyMode(giveplayerid);

		new string[144];
		format(string, sizeof(string), "[NOCLIP] %s (%d) has activated freecam for %s (%d)", ReturnMixedName(playerid), playerid, ReturnMixedName(giveplayerid), giveplayerid);
		SendFreecamAdminMsg(string);

		format(string, sizeof(string), "Admin %s (%d) activated free camera mode for you.  Type /noclip to exit.", ReturnMixedName(playerid), playerid);
		SendClientMessage(giveplayerid, -1, string);
	} 
	return 1;
}

CMD:togglefreecam(playerid, params[])
{
	return cmd_togglenoclip(playerid, params);
}

//--------------------------------------------------

hook OnPlayerUpdate(playerid)
{
	if (noclipdata[playerid][respawn])
	{
		// Reset them when they respawn
		SetPlayerVirtualWorld(playerid, noclipdata[playerid][oldworld]);
		SetPlayerInterior(playerid, noclipdata[playerid][oldinterior]);
		SetPlayerFacingAngle(playerid, noclipdata[playerid][oldpos][3]);
		SOLS_SetPosWithFade(playerid, noclipdata[playerid][oldpos][0], noclipdata[playerid][oldpos][1], noclipdata[playerid][oldpos][2]);
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
		Spectate_RefundAdminGuns(playerid);
		noclipdata[playerid][respawn] = false;
	}

	if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][flymode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][flymode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][flymode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}
	return 1;
}

//--------------------------------------------------

stock GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;
	
    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if(ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if(lr > 0) 	// Right pressed
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if(ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if(ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if(ud > 0) 	direction = MOVE_BACK;		// Down key pressed
	
	return direction;
}

//--------------------------------------------------

stock MoveCamera(playerid)
{
	new Float:FV[3], Float:CP[3];
	GetPlayerCameraPos(playerid, CP[0], CP[1], CP[2]);          // 	Cameras position in space
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);  //  Where the camera is looking at

	// Increases the acceleration multiplier the longer the key is held
	if(noclipdata[playerid][accelmul] <= 1) noclipdata[playerid][accelmul] += ACCEL_RATE;

	// Determine the speed to move the camera based on the acceleration multiplier
	new Float:speed = MOVE_SPEED * noclipdata[playerid][accelmul];

	// Calculate the cameras next position based on their current position and the direction their camera is facing
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(noclipdata[playerid][flymode], CP, FV, X, Y, Z);
	MovePlayerObject(playerid, noclipdata[playerid][flyobject], X, Y, Z, speed);

	// Store the last time the camera was moved as now
	noclipdata[playerid][lastmove] = GetTickCount();
	return 1;
}

//--------------------------------------------------

stock GetNextCameraPosition(move_mode, const Float:CP[3], const Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    // Calculate the cameras next position based on their current position and the direction their camera is facing
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = CP[0]+OFFSET_X;
			Y = CP[1]+OFFSET_Y;
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = CP[0]-OFFSET_X;
			Y = CP[1]-OFFSET_Y;
			Z = CP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = CP[0]-OFFSET_Y;
			Y = CP[1]+OFFSET_X;
			Z = CP[2];
		}
		case MOVE_RIGHT:
		{
			X = CP[0]+OFFSET_Y;
			Y = CP[1]-OFFSET_X;
			Z = CP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = CP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = CP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = CP[0]+(OFFSET_X  - OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  + OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = CP[0]+(OFFSET_X  + OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  - OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
	}
}
//--------------------------------------------------

stock CancelFlyMode(playerid, teleport=false)
{
	if (noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		// Set this to get processed on player update
		if(teleport) {
			GetPlayerObjectPos(playerid, noclipdata[playerid][flyobject], noclipdata[playerid][oldpos][0], noclipdata[playerid][oldpos][1], noclipdata[playerid][oldpos][2]);
		}
		noclipdata[playerid][respawn] = true;
	}

	DeletePVar(playerid, "FlyMode");
	CancelEdit(playerid);
	TogglePlayerSpectating(playerid, false);

	DestroyPlayerObject(playerid, noclipdata[playerid][flyobject]);
	noclipdata[playerid][cameramode] = CAMERA_MODE_NONE;

	return 1;
}

//--------------------------------------------------

stock FlyMode(playerid)
{
	// Create an invisible object for the players camera to be attached to
	GetPlayerPos(playerid, noclipdata[playerid][oldpos][0], noclipdata[playerid][oldpos][1], noclipdata[playerid][oldpos][2]);
	noclipdata[playerid][flyobject] = CreatePlayerObject(playerid, 19300, noclipdata[playerid][oldpos][0], noclipdata[playerid][oldpos][1], noclipdata[playerid][oldpos][2], 0.0, 0.0, 0.0);
	
	// Store other shit for when they respawn
	Spectate_SaveAdminGuns(playerid);
	GetPlayerFacingAngle(playerid, noclipdata[playerid][oldpos][3]);
	noclipdata[playerid][oldinterior] = GetPlayerInterior(playerid);
	noclipdata[playerid][oldworld] = GetPlayerVirtualWorld(playerid);
	noclipdata[playerid][respawn] = false;

	// Place the player in spectating mode so objects will be streamed based on camera location
	TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachCameraToPlayerObject(playerid, noclipdata[playerid][flyobject]);

	SetPVarInt(playerid, "FlyMode", 1);
	noclipdata[playerid][cameramode] = CAMERA_MODE_FLY;
	return 1;
}

//--------------------------------------------------
