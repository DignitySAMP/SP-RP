#include <YSI_Coding\y_hooks>
CMD:spoofattach(playerid, params[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_GENERAL ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	new slot, modelid, bone;

	if ( sscanf ( params, "iii", slot, modelid, bone ) ) {

		SendClientMessage(playerid, -1, "/spoofattach [slot 0 - 9] [modelid] [bone] (model 0 to remove, slot 8 doesn't work)" ) ;
		SendClientMessage(playerid, -1, "Common bones: 1 (Spine), 2 (Head), 5 (L Hand), 6 (R Hand), 7 (R Thigh), 8 (L Thigh), 17 (Neck)" ) ;
		return true;
	}

	if (modelid == 0)
	{
		RemovePlayerAttachedObject(playerid, slot);
		return true;
	}

	SetPlayerAttachedObject(playerid, slot, modelid, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);
	EditAttachedObject(playerid, slot);

	PlayerVar[playerid][E_PLAYER_SPOOFING_ATTACH] = 1;

	return true ;
}

hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float: fOffsetY, Float: fOffsetZ, Float: fRotX, Float: fRotY, Float: fRotZ, Float: fScaleX, Float: fScaleY, Float: fScaleZ )
{
	if (PlayerVar[playerid][E_PLAYER_SPOOFING_ATTACH])
	{
		if (response)
		{
			SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ );
			SendClientMessage(playerid, -1, sprintf("SetPlayerAttachedObject(playerid, %d, %d, %d, %.02f, %.02f, %.02f, %.02f, %.02f, %.02f, %.02f, %.02f, %.02f);", index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ));
		}
		else
		{
			RemovePlayerAttachedObject(playerid, index);
		}

		PlayerVar[playerid][E_PLAYER_SPOOFING_ATTACH] = 0;
		return -2; // stop processing OnPlayerEditAttachedObject and return 1
	}

	return 0;
}
