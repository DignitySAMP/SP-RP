//------------------------------------------------------------------------------
// Custom 0.3.DL Siren Lights for Emergency Vehicle
// Written by Sporky (www.github.com/sporkyspork) for Redwood RP (www.rw-rp.net)
// Updated for Singleplayer Roleplay

#include <YSI_Coding\y_hooks>

#define SIREN_FIRST_MODEL_ID -25250
#define SIREN_MODELS_PATH "sporky/sirens"

#define SIREN_MODEL_BASEID    19797
#define SIREN_MODEL_COPCARLA -25250
#define SIREN_MODEL_COPCARSF -25251
#define SIREN_MODEL_COPCARLV -25252
#define SIREN_MODEL_COPCARRU -25253
#define SIREN_MODEL_FIRETRUK -25254
#define SIREN_MODEL_AMBULAN  -25255
#define SIREN_MODEL_ENFORCER  -25256
#define SIREN_MODEL_CADDY  -25257
#define SIREN_MODEL_CADDY_PERM  -25258
#define SIREN_MODEL_ADMIRAL  -25259
#define SIREN_MODEL_POLMAV  -25260
#define SIREN_MODEL_POLMAV_PERM  -25261

#define SIREN_MODEL_VISOR_OFF    -25262
#define SIREN_MODEL_VISOR_ON     -25263

#define SIREN_MODEL_VISOR_OFF_FD    -25264
#define SIREN_MODEL_VISOR_ON_FD     -25265

#define SIREN_MODEL_MAVERICK_PERM  SIREN_MODEL_POLMAV_PERM

#define SIREN_MODEL_FBIRANCH  -25266
#define SIREN_MODEL_FBIRANCH_FD SIREN_MODEL_FBIRANCH

#define SIREN_MODEL_PREMIER   -25267
#define SIREN_MODEL_PREMIER_FD SIREN_MODEL_PREMIER

#define SIREN_MODEL_CHEETAH         SIREN_MODEL_ADMIRAL
#define SIREN_MODEL_SULTAN          SIREN_MODEL_ADMIRAL
#define SIREN_MODEL_BUFFALO         SIREN_MODEL_ADMIRAL
#define SIREN_MODEL_YOSEMITE        SIREN_MODEL_ADMIRAL
#define SIREN_MODEL_FBIRANCH_DEA    SIREN_MODEL_ADMIRAL

#define SIREN_MODEL_STRATUM         SIREN_MODEL_CADDY
#define SIREN_MODEL_STRATUM_PERM    SIREN_MODEL_CADDY_PERM

#define MAX_SIREN_STAGES        4
#define SIREN_STAGE_OFF         0
#define SIREN_STAGE_FLASHERS    1
#define SIREN_STAGE_LIGHTS      2
#define SIREN_STAGE_FULL        3

#define SIREN_TEXT_Y 131 

static Text:gSirenText = Text: INVALID_TEXT_DRAW;
static PlayerText:pSirenText[MAX_PLAYERS] = { PlayerText: INVALID_TEXT_DRAW, ... };
static pHornVehicle[MAX_PLAYERS];

static enum eSirenModelData
{
    sirenVehicleModel,
    sirenModel,
    sirenModelDff[16],
    sirenModelTxd[16],
    sirenFaction,
    sirenPermModel,
    bool:sirenPermNeedsEngine,
    Float:sirenPos[3],
    Float:sirenRot[3],
    bool:hasVisor,
    Float:visorPos[3],
    Float:visorRot[3],
    bool:hasExtraVisor,
    Float:extraVisorPos[3],
    Float:extraVisorRot[3]
}

static const SirenModels[][eSirenModelData] = 
{
    { 596, SIREN_MODEL_COPCARLA, "copcar", "sirens", -1 },
    { 597, SIREN_MODEL_COPCARSF, "copcar", "sirens", -1 },
    { 598, SIREN_MODEL_COPCARLV, "copcarlv", "sirens", -1 },
    { 599, SIREN_MODEL_COPCARRU, "copcarru", "sirens", -1 },
    { 407, SIREN_MODEL_FIRETRUK, "firetruk", "sirens", -1 },
    { 416, SIREN_MODEL_AMBULAN,  "ambulan", "sirens", -1 },
    { 427, SIREN_MODEL_ENFORCER,  "enforcer", "sirens", -1 },

    { 497, SIREN_MODEL_POLMAV,  "polmav", "sirens", -1, SIREN_MODEL_POLMAV_PERM, true },
    { 487, 0,  "polmav", "sirens", -1, SIREN_MODEL_MAVERICK_PERM, true },
     { 426, SIREN_MODEL_PREMIER_FD, "premier2", "sirens", 3, 0, false, { 0.0, 0.0, 0.0 }, {0.0, 0.0, 0.0}, true, {0.0, 0.3, 0.67}, {0.0, 0.0, 180.0} }, // FACTION_TYPE_EMS
    { 426, SIREN_MODEL_PREMIER, "premier2", "sirens", 0, 0, false, { 0.0, 0.0, 0.0 }, {0.0, 0.0, 0.0}, true, {0.0, 0.3, 0.67}, {0.0, 0.0, 180.0} },

    { 490, SIREN_MODEL_FBIRANCH_FD, "fbiranch2", "sirens", 3, 0, false, { 0.0, 0.0, 0.0 }, {0.0, 0.0, 0.0}, true, {0.0, 0.87, 0.88}, {0.0, 0.0, 180.0} }, // FACTION_TYPE_EMS
    { 490, SIREN_MODEL_FBIRANCH, "fbiranch2", "sirens", 0, 0, false, { 0.0, 0.0, 0.0 }, {0.0, 0.0, 0.0}, true, {0.0, 0.87, 0.88}, {0.0, 0.0, 180.0} }
};


static enum eSirenVehicleData
{
    sirenIndex,
    headlightStatus, // stores the original headlights status before using sirens
    bool:sirensOn,
	bool:flashersOn,
	sirensStage,
    sirensObject,
    sirensPermObject,
    visorObject,
    extraVisorObject,
    flashersStage,
	bool:hornPressed,
	textdrawString[30] // this is the textdraw string both driver and passenger will see
}

static VehicleSirens[MAX_VEHICLES][eSirenVehicleData];

static panels, doors, lights, tires, engine, alarm, bonnet, boot, objective;
static poolsize;

forward SirensTimer_Tick();
public SirensTimer_Tick()
{
    poolsize = GetVehiclePoolSize();

    for (new i = 1; i <= poolsize; i++)
	{
        if (VehicleSirens[i][sirensOn])
        {
            // Recreating the siren object if it disappears
            // All checks are handled within the function
            CreateVehicleCustomSirens(i);
	    }
        
        if (!VehicleSirens[i][flashersOn]) continue;

        GetVehicleDamageStatus(i, panels, doors, lights, tires);
		switch (VehicleSirens[i][flashersStage])
		{
		    case 0: UpdateVehicleDamageStatus(i, panels, doors, 2, tires);
			case 1: UpdateVehicleDamageStatus(i, panels, doors, 5, tires);
			case 2: UpdateVehicleDamageStatus(i, panels, doors, 2, tires);
			case 3: UpdateVehicleDamageStatus(i, panels, doors, 4, tires);
			case 4: UpdateVehicleDamageStatus(i, panels, doors, 5, tires);
			case 5: UpdateVehicleDamageStatus(i, panels, doors, 4, tires);
		}


        if (VehicleSirens[i][flashersStage] >= 5) VehicleSirens[i][flashersStage] = 0;
		else VehicleSirens[i][flashersStage] ++;
	}

    return 1;
}

static bool:IsDefaultSirenVehicle(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    if (model == 407 || model == 416 || model == 427 || model == 433 || model == 490 || model == 528 || model == 596 || model == 597 || model == 598 || model == 599 || model == 601)
    {
        return true;
    }
    
    return false;
}

static bool:DoesVehicleHaveSirens(vehicleid)
{
    // Eventually expand this to include non default siren cars
    if (IsDefaultSirenVehicle(vehicleid))
    {
        return true;
    }

    new model = GetVehicleModel(vehicleid);
    for (new i = 0; i < sizeof(SirenModels); i ++)
    {
        if (SirenModels[i][sirenVehicleModel] != model) continue;
        if (SirenModels[i][sirenFaction] != -1 && GetVehicleFactionType(vehicleid) != SirenModels[i][sirenFaction]) continue;

        return true;
    }

    return false;
}

stock DoesVehicleHaveCustomSirens(vehicleid)
{
    // Eventually expand this to include non default siren cars
    return GetCustomSirenIndexForVehicle(vehicleid) != -1;
}

static GetCustomSirenIndexForVehicle(vehicleid)
{
	new model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	{
		for (new i = 0; i < sizeof(SirenModels); i ++)
        {
            if (SirenModels[i][sirenVehicleModel] != model) continue;
            if (SirenModels[i][sirenFaction] != -1 && GetVehicleFactionType(vehicleid) != SirenModels[i][sirenFaction]) continue;

            return i;
        }
	}
	
	return -1;
}

static CreateVehicleCustomSirens(vehicle)
{
    // Don't create if already exists
    if (VehicleSirens[vehicle][sirensObject] != INVALID_OBJECT_ID && IsValidDynamicObject(VehicleSirens[vehicle][sirensObject])) return;
    
    new index = VehicleSirens[vehicle][sirenIndex];
    // if (index == -1) VehicleSirens[vehicle][sirenIndex] = GetCustomSirenIndexForVehicle(vehicle);

    if (index != -1)
    {
        VehicleSirens[vehicle][sirensObject] = CreateDynamicObject(SirenModels[index][sirenModel], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, -1, 300.0, 300.0, -1, 1);
        AttachDynamicObjectToVehicle(VehicleSirens[vehicle][sirensObject], vehicle, SirenModels[index][sirenPos][0], SirenModels[index][sirenPos][1], SirenModels[index][sirenPos][2], SirenModels[index][sirenRot][0], SirenModels[index][sirenRot][1], SirenModels[index][sirenRot][2]);
        
        new Float:x, Float:y, Float:z;
        GetVehiclePos(vehicle, x, y, z);
        
        foreach(new i: Player)
        {
            if (IsPlayerInRangeOfPoint(i, 25.0, x, y, z))
            {
                Streamer_Update(i, STREAMER_TYPE_OBJECT);
            }
        }
    
        // printf("CreateDynamicObject(%d, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, -1, 200.0, 200.0, -1, 1)", SirenModels[i][sirenModel]);
    }
}

static DestroyVehicleCustomSirens(vehicle)
{
	if (IsValidDynamicObject(VehicleSirens[vehicle][sirensObject]))
	{
	    DestroyDynamicObject(VehicleSirens[vehicle][sirensObject]);
	}

    VehicleSirens[vehicle][sirensObject] = INVALID_OBJECT_ID;
}

SOLS_ResetVehicleSirens(vehicleid)
{
    RemoveVehicleTurnSignals(vehicleid, EI_TURN_SIGNAL_BOTH);
    ResetVehicleCustomSirens(vehicleid);
}

SOLS_UpdateVehiclePermSirens(vehicleid)
{
    new index = GetCustomSirenIndexForVehicle(vehicleid);
    UpdatePermSiren(vehicleid, index);
}

static DestroyVisorSiren(vehicleid)
{
    if (IsValidDynamicObject(VehicleSirens[vehicleid][visorObject]))
    {
        DestroyDynamicObject(VehicleSirens[vehicleid][visorObject]);
    }

    VehicleSirens[vehicleid][visorObject] = INVALID_OBJECT_ID;

    if (IsValidDynamicObject(VehicleSirens[vehicleid][extraVisorObject]))
    {
        DestroyDynamicObject(VehicleSirens[vehicleid][extraVisorObject]);
    }

    VehicleSirens[vehicleid][extraVisorObject] = INVALID_OBJECT_ID;
}

static UpdateVisorSiren(vehicleid, index)
{
    if (index == -1 || (!SirenModels[index][hasVisor] && !SirenModels[index][hasExtraVisor]))
    {
        DestroyVisorSiren(vehicleid);
        return;
    }

    new model = VehicleSirens[vehicleid][sirensOn] ? SIREN_MODEL_VISOR_ON : SIREN_MODEL_VISOR_OFF;
    if (GetVehicleFactionType(vehicleid) == FACTION_TYPE_EMS) model = VehicleSirens[vehicleid][sirensOn] ? SIREN_MODEL_VISOR_ON_FD : SIREN_MODEL_VISOR_OFF_FD;

    DestroyVisorSiren(vehicleid);

    if (SirenModels[index][hasVisor])
    {
        if (!VehicleSirens[vehicleid][visorObject] || !IsValidDynamicObject(VehicleSirens[vehicleid][visorObject]))
        {
            VehicleSirens[vehicleid][visorObject] = CreateDynamicObject(model, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, -1, 300.0, 300.0, -1, 1);
            AttachDynamicObjectToVehicle(VehicleSirens[vehicleid][visorObject], vehicleid, SirenModels[index][visorPos][0], SirenModels[index][visorPos][1], SirenModels[index][visorPos][2], SirenModels[index][visorRot][0], SirenModels[index][visorRot][1], SirenModels[index][visorRot][2]);
        }
    }

    if (SirenModels[index][hasExtraVisor])
    {
        if (!VehicleSirens[vehicleid][extraVisorObject] || !IsValidDynamicObject(VehicleSirens[vehicleid][extraVisorObject]))
        {
            VehicleSirens[vehicleid][extraVisorObject] = CreateDynamicObject(model, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, -1, 300.0, 300.0, -1, 1);
            AttachDynamicObjectToVehicle(VehicleSirens[vehicleid][extraVisorObject], vehicleid, SirenModels[index][extraVisorPos][0], SirenModels[index][extraVisorPos][1], SirenModels[index][extraVisorPos][2], SirenModels[index][extraVisorRot][0], SirenModels[index][extraVisorRot][1], SirenModels[index][extraVisorRot][2]);
        }
    }
}

static UpdatePermSiren(vehicleid, index)
{
    UpdateVisorSiren(vehicleid, index);

    if (index == -1 || !SirenModels[index][sirenPermModel] || (SirenModels[index][sirenPermModel] && SirenModels[index][sirenPermNeedsEngine] && !GetEngineStatus(vehicleid)))
    {
        if (IsValidDynamicObject(VehicleSirens[vehicleid][sirensPermObject]))
        {
            DestroyDynamicObject(VehicleSirens[vehicleid][sirensPermObject]);
        }

        VehicleSirens[vehicleid][sirensPermObject] = INVALID_OBJECT_ID;
        return;
    }

    if (!VehicleSirens[vehicleid][sirensPermObject] || !IsValidDynamicObject(VehicleSirens[vehicleid][sirensPermObject]))
    {
        VehicleSirens[vehicleid][sirensPermObject] = CreateDynamicObject(SirenModels[index][sirenPermModel], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, -1, 300.0, 300.0, -1, 1);
        AttachDynamicObjectToVehicle(VehicleSirens[vehicleid][sirensPermObject], vehicleid, SirenModels[index][sirenPos][0], SirenModels[index][sirenPos][1], SirenModels[index][sirenPos][2], SirenModels[index][sirenRot][0], SirenModels[index][sirenRot][1], SirenModels[index][sirenRot][2]);
    }
}

static ResetVehicleCustomSirens(vehicleid)
{
    new index = GetCustomSirenIndexForVehicle(vehicleid);
    UpdatePermSiren(vehicleid, index);

    if (VehicleSirens[vehicleid][sirensOn])
    {
        // Destroy the custom sirens
        DestroyVehicleCustomSirens(vehicleid);
    }

    if (VehicleSirens[vehicleid][flashersOn])
    {
        // Disable the flashers/restore original headlight status
        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
        SetVehicleParamsEx(vehicleid, engine, VehicleSirens[vehicleid][headlightStatus], alarm, doors, bonnet, boot, objective);
    }

    // Reset vars
    VehicleSirens[vehicleid][sirensOn] = false;
    VehicleSirens[vehicleid][sirensStage] = 0;
    VehicleSirens[vehicleid][flashersOn] = false;
    VehicleSirens[vehicleid][flashersStage] = 0;

    // Reset textdraw
    UpdateTextdrawForVeh(vehicleid);
}

static SetVehicleCustomSirens(vehicleid, stage)
{
    switch (stage)
    {
        case SIREN_STAGE_FLASHERS:
        {
            // Store the original headlights status
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            VehicleSirens[vehicleid][headlightStatus] = (lights == VEHICLE_PARAMS_ON) ? VEHICLE_PARAMS_ON : VEHICLE_PARAMS_OFF;

            // Force the headlights and taillights on
            SetVehicleParamsEx(vehicleid, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);

            // And do flashing headlights WITHOUT custom sirens
            DestroyVehicleCustomSirens(vehicleid);
            VehicleSirens[vehicleid][sirensOn] = false;
            VehicleSirens[vehicleid][flashersStage] = 0;
            VehicleSirens[vehicleid][flashersOn] = true;
        }
        case SIREN_STAGE_LIGHTS:
        {
            // Force headlights and taillights on
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(vehicleid, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);

            // Restore original headlight status but keep taillights on
            GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
            
            if (VehicleSirens[vehicleid][headlightStatus] == VEHICLE_PARAMS_ON)
            {
                // printf("lights dmg: %d", 0);
                UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
            }
            else
            {
                // printf("lights dmg: %d", 5);
                UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
            }

            // And do custom sirens WITHOUT flashing headlights
            CreateVehicleCustomSirens(vehicleid);
            VehicleSirens[vehicleid][sirensOn] = true;
            VehicleSirens[vehicleid][flashersStage] = 0;
            VehicleSirens[vehicleid][flashersOn] = false;
        }
        case SIREN_STAGE_FULL:
        {
            // Force the headlights and taillights on
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(vehicleid, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);

            // And do custom sirens WITH flashing headlights
            CreateVehicleCustomSirens(vehicleid);
            VehicleSirens[vehicleid][sirensOn] = true;
            VehicleSirens[vehicleid][flashersStage] = 0;
            VehicleSirens[vehicleid][flashersOn] = true;
        }
        default:
        {
            // Turn off + reset vars in one func here
		    ResetVehicleCustomSirens(vehicleid);
        }
    }

    VehicleSirens[vehicleid][sirensStage] = stage;

    new index = GetCustomSirenIndexForVehicle(vehicleid);
    UpdateVisorSiren(vehicleid, index);
}

static GetVehicleDriverAndPassenger(vehicleid, &driver, &passenger)
{
	foreach(new i: Player)
	{
	    if (!IsPlayerInVehicle(i, vehicleid)) continue;

		if (GetPlayerVehicleSeat(i) == 0)
		{
			driver = i;
		}
		else if (GetPlayerVehicleSeat(i) == 1)
		{
			passenger = i;
		}

		if (driver != INVALID_PLAYER_ID && passenger != INVALID_PLAYER_ID) break;
	}
}

static OnVehicleTextdrawChanged(vehicleid)
{
	new driver = INVALID_PLAYER_ID, passenger = INVALID_PLAYER_ID;
	GetVehicleDriverAndPassenger(vehicleid, driver, passenger);

	if (driver != INVALID_PLAYER_ID) UpdateTextdrawForPlayer(driver);
    if (passenger != INVALID_PLAYER_ID) UpdateTextdrawForPlayer(passenger);
}

static UpdateTextdrawForVeh(vehicleid)
{
	new bool:sirensound = (GetVehicleParamsSirenState(vehicleid) == 1);

	if (VehicleSirens[vehicleid][sirensOn] || VehicleSirens[vehicleid][flashersOn])
	{
	    // Using custom sirens stuff
	    if (VehicleSirens[vehicleid][hornPressed]) format(VehicleSirens[vehicleid][textdrawString], 30, "~r~STG%d", VehicleSirens[vehicleid][sirensStage]);
        else if (sirensound) format(VehicleSirens[vehicleid][textdrawString], 30, "~y~STG%d", VehicleSirens[vehicleid][sirensStage]);
        else format(VehicleSirens[vehicleid][textdrawString], 30, "STG%d", VehicleSirens[vehicleid][sirensStage]);
	}
	else
	{
        // Using default sirens, or off
        if (VehicleSirens[vehicleid][hornPressed]) format(VehicleSirens[vehicleid][textdrawString], 30, "~r~ON");
        else if (sirensound) format(VehicleSirens[vehicleid][textdrawString], 30, "~y~ON");
        else format(VehicleSirens[vehicleid][textdrawString], 30, "OFF");
	}

	OnVehicleTextdrawChanged(vehicleid);
}

static IsHudEnabledForPlayer(playerid)
{
    return Character[playerid][E_CHARACTER_HUD_VEHICLE];
}

static UpdateTextdrawForPlayer(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid), seat = GetPlayerVehicleSeat(playerid);
	if (vehicle && seat <= 1 && DoesVehicleHaveSirens(vehicle) && IsHudEnabledForPlayer(playerid))
	{
        TextDrawShowForPlayer(playerid, gSirenText);
	    PlayerTextDrawSetString(playerid, pSirenText[playerid], VehicleSirens[vehicle][textdrawString]);
		PlayerTextDrawShow(playerid, pSirenText[playerid]);
		return;
	}

    TextDrawHideForPlayer(playerid, gSirenText);
    PlayerTextDrawHide(playerid, pSirenText[playerid]);
    return;
}

public OnGameModeInit()
{
    new dff[64], txd[64];
    
    for (new i = 0; i < sizeof(SirenModels); i ++)
    {
        if (strlen(SirenModels[i][sirenModel]))
        {
            format(dff, sizeof(dff), "%s/%s.dff", SIREN_MODELS_PATH, SirenModels[i][sirenModelDff]);
            format(txd, sizeof(txd), "%s/%s.txd", SIREN_MODELS_PATH, SirenModels[i][sirenModelTxd]);
            AddSimpleModel(-1, SIREN_MODEL_BASEID, SirenModels[i][sirenModel], dff, txd);
            printf("Added custom siren model: %d (%s, %s)", SirenModels[i][sirenModel], dff, txd);

            if (SirenModels[i][sirenPermModel])
            {
                format(dff, sizeof(dff), "%s/%s_perm.dff", SIREN_MODELS_PATH, SirenModels[i][sirenModelDff]);
                format(txd, sizeof(txd), "%s/%s.txd", SIREN_MODELS_PATH, SirenModels[i][sirenModelTxd]);
                AddSimpleModel(-1, SIREN_MODEL_BASEID, SirenModels[i][sirenPermModel], dff, txd);
                printf("Added custom siren model: %d (%s, %s)", SirenModels[i][sirenPermModel], dff, txd);
            }
        }
    }

    AddSimpleModel(-1, SIREN_MODEL_BASEID, SIREN_MODEL_VISOR_OFF, sprintf("%s/visoroff.dff", SIREN_MODELS_PATH), sprintf("%s/visor.txd", SIREN_MODELS_PATH));
    AddSimpleModel(-1, SIREN_MODEL_BASEID, SIREN_MODEL_VISOR_ON, sprintf("%s/visoron.dff", SIREN_MODELS_PATH), sprintf("%s/visor.txd", SIREN_MODELS_PATH));
    AddSimpleModel(-1, SIREN_MODEL_BASEID, SIREN_MODEL_VISOR_OFF_FD, sprintf("%s/visoroff_fd.dff", SIREN_MODELS_PATH), sprintf("%s/visor_fd.txd", SIREN_MODELS_PATH));
    AddSimpleModel(-1, SIREN_MODEL_BASEID, SIREN_MODEL_VISOR_ON_FD, sprintf("%s/visoron_fd.dff", SIREN_MODELS_PATH), sprintf("%s/visor_fd.txd", SIREN_MODELS_PATH));

    // Create global siren vehicle hud text
    gSirenText = TextDrawCreate(499.0000, SIREN_TEXT_Y, "Siren");
    TextDrawFont(gSirenText, 2);
    TextDrawLetterSize(gSirenText, 0.3000, 1.0000);
    TextDrawColor(gSirenText, -1613958913);
    TextDrawSetShadow(gSirenText, 0);
    TextDrawSetOutline(gSirenText, 1);
    TextDrawBackgroundColor(gSirenText, 255);
    TextDrawSetProportional(gSirenText, 1);
    TextDrawTextSize(gSirenText, 0.0000, 0.0000);

    for (new i = 1; i < MAX_VEHICLES; i ++)
	{
        // Initialize VehicleSirens defaults
        VehicleSirens[i][sirensObject] = INVALID_OBJECT_ID;
        VehicleSirens[i][sirenIndex] = -1;  

	    format(VehicleSirens[i][textdrawString], 30, "OFF");
	    UpdateTextdrawForVeh(i);
	}

    SetTimer("SirensTimer_Tick", 166, true);

    #if defined sirens_OnGameModeInit
        return sirens_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#define OnGameModeInit sirens_OnGameModeInit
#if defined sirens_OnGameModeInit
    forward sirens_OnGameModeInit();
#endif

// HOLDING(keys)
#if !defined HOLDING
    #define HOLDING(%0) \
        ((newkeys & (%0)) == (%0))
#endif

static tempveh;
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    tempveh = GetPlayerVehicleID(playerid);
    new bool:updatetext = false;

	if (GetPlayerVehicleSeat(playerid) == 0 && HOLDING(KEY_CROUCH))
	{
	    if (tempveh && GetVehicleParamsSirenState(tempveh) == 1)
	    {
			if (!pHornVehicle[playerid])
			{
			    VehicleSirens[tempveh][hornPressed] = true;
			    pHornVehicle[playerid] = tempveh;
                updatetext = true;
			}
		}
	}
	else if (pHornVehicle[playerid])
	{
    	VehicleSirens[pHornVehicle[playerid]][hornPressed] = false;
		pHornVehicle[playerid] = 0;
        updatetext = true;
	}

    if ((newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION))
	{
	    tempveh = GetPlayerVehicleID(playerid);
		if (tempveh && GetPlayerVehicleSeat(playerid) == 0)
        {
            // Get the siren index
            new sirenindex = GetCustomSirenIndexForVehicle(tempveh);
            if (sirenindex == -1) return 1;

            VehicleSirens[tempveh][sirenIndex] = sirenindex;
            new stage = VehicleSirens[tempveh][sirensStage];
            stage += 1;

            if (stage >= MAX_SIREN_STAGES) stage = SIREN_STAGE_OFF;
			SetVehicleCustomSirens(tempveh, stage);
		 	updatetext = true;
        }
	}

    if (updatetext) UpdateTextdrawForVeh(tempveh);

    #if defined sirens_OnPlayerKeyStateChange
        return sirens_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

//if ( Character [ playerid ] [ E_CHARACTER_HUD_VEHICLE] ) {

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange sirens_OnPlayerKeyStateChange
#if defined sirens_OnPlayerKeyStateChange
    forward sirens_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnVehicleSpawn(vehicleid)
{
    // Just call this for all vehicles, the function will only do what is necessary
    ResetVehicleCustomSirens(vehicleid);

    #if defined sirens_OnVehicleSpawn
        return sirens_OnVehicleSpawn(vehicleid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnVehicleSpawn
    #undef OnVehicleSpawn
#else
    #define _ALS_OnVehicleSpawn
#endif

#define OnVehicleSpawn sirens_OnVehicleSpawn
#if defined sirens_OnVehicleSpawn
    forward sirens_OnVehicleSpawn(vehicleid);
#endif

public OnVehicleDeath(vehicleid, killerid)
{
    // Just call this for all vehicles, the function will only do what is necessary
    ResetVehicleCustomSirens(vehicleid);

    #if defined sirens_OnVehicleDeath
        return sirens_OnVehicleDeath(vehicleid, killerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnVehicleDeath
    #undef OnVehicleDeath
#else
    #define _ALS_OnVehicleDeath
#endif

#define OnVehicleDeath sirens_OnVehicleDeath
#if defined sirens_OnVehicleDeath
    forward sirens_OnVehicleDeath(vehicleid, killerid);
#endif

public OnPlayerConnect(playerid)
{
    // Create per-player siren text
    pSirenText[playerid] = CreatePlayerTextDraw(playerid, 609.0000, SIREN_TEXT_Y, "OFF");
    PlayerTextDrawFont(playerid, pSirenText[playerid], 2);
    PlayerTextDrawLetterSize(playerid, pSirenText[playerid], 0.3000, 1.0000);
    PlayerTextDrawAlignment(playerid, pSirenText[playerid], 3);
    PlayerTextDrawColor(playerid, pSirenText[playerid], -1613958913);
    PlayerTextDrawSetShadow(playerid, pSirenText[playerid], 0);
    PlayerTextDrawSetOutline(playerid, pSirenText[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, pSirenText[playerid], 255);
    PlayerTextDrawSetProportional(playerid, pSirenText[playerid], 1);
    PlayerTextDrawTextSize(playerid, pSirenText[playerid], 0.0000, 0.0000);

    // Reset holding horn
    pHornVehicle[playerid] = 0;

    #if defined sirens_OnPlayerConnect
        return sirens_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect sirens_OnPlayerConnect
#if defined sirens_OnPlayerConnect
    forward sirens_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason) 
{
	PlayerTextDrawDestroy(playerid, pSirenText[playerid]);

	#if defined sirens_OnPlayerDisconnect
		return sirens_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect sirens_OnPlayerDisconnect
#if defined sirens_OnPlayerDisconnect
	forward sirens_OnPlayerDisconnect(playerid, reason);
#endif


public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
	    UpdateTextdrawForPlayer(playerid);
	}

	#if defined sirens_OnPlayerStateChange
		return sirens_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange sirens_OnPlayerStateChange
#if defined sirens_OnPlayerStateChange
	forward sirens_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
    UpdateTextdrawForVeh(vehicleid);

	#if defined srns_OnVehicleSirenStateChange
		return srns_OnVehicleSirenStateChange(playerid, vehicleid, newstate);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnVehicleSirenStateChange
	#undef OnVehicleSirenStateChange
#else
	#define _ALS_OnVehicleSirenStateChange
#endif

#define OnVehicleSirenStateChange srns_OnVehicleSirenStateChange
#if defined srns_OnVehicleSirenStateChange
	forward srns_OnVehicleSirenStateChange(playerid, vehicleid, newstate);
#endif

hook SOLS_OnSettingChanged(playerid, E_PLAYER_CHARACTER_DATA:setting, newvalue)
{
    if (setting == E_PLAYER_CHARACTER_DATA:E_CHARACTER_HUD_VEHICLE)
        UpdateTextdrawForPlayer(playerid);
}