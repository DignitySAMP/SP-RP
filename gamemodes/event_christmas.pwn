#include <a_samp>
#include <streamer>

#define COLOR_XMAS	(0x469958FF)

#define XMAS_STALL_X 1775.6062
#define XMAS_STALL_Y -1809.9136
#define XMAS_STALL_Z 13.5813


enum E_PLAYER_XMAS_DATA {

	E_XMAS_COLLECTED_HAT,
	Float: E_XMAS_SANTA_POS_X,
	Float: E_XMAS_SANTA_POS_Y,
	Float: E_XMAS_SANTA_POS_Z,

	Float: E_XMAS_SANTA_POS_RX,
	Float: E_XMAS_SANTA_POS_RY,
	Float: E_XMAS_SANTA_POS_RZ,

	Float: E_XMAS_SANTA_POS_SX,
	Float: E_XMAS_SANTA_POS_SY,
	Float: E_XMAS_SANTA_POS_SZ
} ;

new PlayerXmasData [ MAX_PLAYERS ] [ E_PLAYER_XMAS_DATA ] ;
new PlayerXmasAttachingSantahat [ MAX_PLAYERS ] ;

Christmas_LoadEntities() {

	CreateDynamic3DTextLabel("Christmas Stall\n{DEDEDE}Available commands: /christmas", COLOR_XMAS, XMAS_STALL_X, XMAS_STALL_Y, XMAS_STALL_Z, 10.0,  INVALID_PLAYER_ID,  INVALID_VEHICLE_ID, false, 0, 0, -1 ) ;
	CreateDynamicPickup(1276, 1, XMAS_STALL_X, XMAS_STALL_Y, XMAS_STALL_Z);

	CreateDynamicMapIcon(XMAS_STALL_X, XMAS_STALL_Y, XMAS_STALL_Z, 37, COLOR_XMAS);


	LoadUnityTree();

	return true ;
}

CMD:christmas(playerid, params[]) {

	if ( ! IsPlayerInRangeOfPoint(playerid, 5.0, XMAS_STALL_X, XMAS_STALL_Y, XMAS_STALL_Z)) {
		GPS_MarkLocation ( playerid, "The ~r~christmas tree~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_DEFAULT, XMAS_STALL_X, XMAS_STALL_Y, XMAS_STALL_Z  ) ;
		SendServerMessage(playerid, COLOR_XMAS, "Christmas", "DEDEDE", "Visit the christmas tree at Unity Station in order to do this command. (See minimap)" ) ;

		return true ;
	}

	if ( PlayerXmasData [ playerid ] [ E_XMAS_COLLECTED_HAT ] ) {

		return SendServerMessage(playerid, COLOR_XMAS, "Christmas", "DEDEDE", "You've already collected a santa hat. Use /santahat to put it on." ) ;
	}

	else {

 		PlayerXmasData [ playerid ] [ E_XMAS_COLLECTED_HAT ] = true ;

 		new query [ 128 ] ;

 		mysql_format(mysql, query, sizeof ( query ), "INSERT INTO event_christmas  (account_id, santahat) VALUES (%d, 1)", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
 		mysql_tquery(mysql, query);

 		cmd_santahat(playerid, "0");

 		GivePlayerCash(playerid, 10000);

 		SendServerMessage(playerid, COLOR_XMAS, "Christmas", "DEDEDE", "You've unlocked the /santahat command. You've also been given $10.000 as a bonus. Happy Holidays!" ) ;
	}

	return true ;
}

CMD:santahat(playerid, params[]) {

	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if ( ! PlayerXmasData [ playerid ] [ E_XMAS_COLLECTED_HAT ] ) {

		GPS_MarkLocation ( playerid, "The ~r~christmas tree~w~ has been marked on your ~r~minimap~w~.", E_GPS_COLOR_DEFAULT, XMAS_STALL_X, XMAS_STALL_Y, XMAS_STALL_Z  ) ;
		return SendServerMessage(playerid, COLOR_XMAS, "Christmas", "DEDEDE", "You don't have a santa hat! Visit the christmas tree at Unity Station to get one. (See minimap)" ) ;
	}

	new choice ;

	if ( sscanf ( params, "i", choice ) ) {
		SendServerMessage(playerid, COLOR_XMAS, "Christmas", "DEDEDE", "/santahat [option]" ) ;
		SendClientMessage(playerid, 0xDEDEDEFF, "Options: (0: None) (1: Default Santahat) (2: Merry Xmas) (3: Happy Xmas)");

		return true ;
	}

	new modelid = 0 ;

	switch ( choice ) {

		case 1: modelid = 19064;  // default santahat
		case 2: modelid = 19065 ; // merry xmas
		case 3: modelid = 19066 ; // happy xmas
	}

	if (modelid == 0)
	{
		RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM ) ;
		return true;
	}

	if ( PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ] <= 0.5 || 
		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ] <= 0.5 || 
		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ] <= 0.5 ) {

		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ] = 1.0 ;
		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ] = 1.0 ;
		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ] = 1.0 ;
	}

	PlayerXmasAttachingSantahat [ playerid ] = true ;

	SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM, modelid, E_ATTACH_BONE_HEAD,

		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_X ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Y ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Z ],
		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RX ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RY ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RZ ],
		PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ]

	);

	EditAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM ) ;

	return true ;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ ) {

	if ( PlayerXmasAttachingSantahat [ playerid  ] ) {

		if ( response == EDIT_RESPONSE_CANCEL ) {

			PlayerXmasAttachingSantahat [ playerid ] = false ;
			RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM ) ;
		}

		else if ( response == EDIT_RESPONSE_UPDATE ) {

			SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
		}		

		else if ( response == EDIT_RESPONSE_FINAL ) {

			PlayerXmasAttachingSantahat [ playerid ] = false ;

			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_X ] = fOffsetX ;
			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Y ] = fOffsetY ;
			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Z ] = fOffsetZ ;

			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RX ] = fRotX ;
			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RY ] = fRotY ;
			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RZ ] = fRotZ ;

			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ] = fScaleX ;
			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ] = fScaleY ;
			PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ] = fScaleZ ;

			new query [ 512 ] ;

			mysql_format(mysql, query, sizeof ( query ), 
				"UPDATE event_christmas SET santa_pos_x = '%0.2f', santa_pos_y = '%0.2f', santa_pos_z = '%0.2f', santa_pos_rx = '%0.2f', santa_pos_ry = '%0.2f', santa_pos_rz = '%0.2f', santa_pos_sx = '%0.2f', santa_pos_sy = '%0.2f', santa_pos_sz = '%0.2f' WHERE account_id=%d",

				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_X ] , PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Y ] , PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Z ] ,
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RX ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RY ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RZ ],
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ], PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ],

				Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]
			);

			mysql_tquery(mysql, query);

			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_SYSTEM, modelid, E_ATTACH_BONE_HEAD, PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_X ], 
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Y ] ,
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Z ] ,
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RX ],
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RY ],
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RZ ],
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ],
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ],
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ]
			);

		}
	}

	return true ;
}

Christmas_LoadPlayerEntities(playerid) {
	PlayerXmasAttachingSantahat [ playerid ] = false ;
	PlayerXmasData [ playerid ] [ E_XMAS_COLLECTED_HAT ] = false ;

	SendClientMessage(playerid, 0x2255DCFF, "Happy Holidays!{FFFFFF} It's the annual {539F55}Christmas {A12C2C}Holiday {DEDEDE}Event{FFFFFF}. Visit /christmas to claim your reward.");

	inline ChristmasPlayerData() {

		new rows, fields ;
		cache_get_data ( rows, fields, mysql ) ;

		if ( rows ) {

			for ( new i, j = rows ; i < j ; i ++ ) {

				PlayerXmasData [ playerid ] [ E_XMAS_COLLECTED_HAT ] = cache_get_field_content_int ( i, "santahat", mysql ) ;

				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_X ] = cache_get_field_content_float ( i, "santa_pos_x", mysql ) ;
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Y ] = cache_get_field_content_float ( i, "santa_pos_y", mysql ) ;
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_Z ] = cache_get_field_content_float ( i, "santa_pos_z", mysql ) ;

				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RX ] = cache_get_field_content_float ( i, "santa_pos_rx", mysql ) ;
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RY ] = cache_get_field_content_float ( i, "santa_pos_ry", mysql ) ;
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_RZ ] = cache_get_field_content_float ( i, "santa_pos_rz", mysql ) ;


				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SX ] = cache_get_field_content_float ( i, "santa_pos_sx", mysql ) ;
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SY ] = cache_get_field_content_float ( i, "santa_pos_sy", mysql ) ;
				PlayerXmasData [ playerid ] [ E_XMAS_SANTA_POS_SZ ] = cache_get_field_content_float ( i, "santa_pos_sz", mysql ) ;

			}
		}
	}

	new query [ 256 ] ;
	mysql_format ( mysql, query, sizeof ( query ), "SELECT * FROM event_christmas WHERE account_id = '%d'", Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ] ) ;
	MySQL_TQueryInline(mysql, using inline ChristmasPlayerData, query, "");

	return true ;
}

LoadUnityTree() {

	new g_DynamicObject[85];
	//g_DynamicObject[0] = CreateDynamicObject(-1167, 1777.4183, -1782.2741, 12.6260, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //reyo/unityst.dff
	g_DynamicObject[1] = CreateDynamicObject(654, 1778.0219, -1806.9497, 11.2280, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //pinetree08
	g_DynamicObject[2] = CreateDynamicObject(19281, 1781.4893, -1805.0706, 19.6176, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[3] = CreateDynamicObject(854, 1778.1010, -1807.1560, 12.8001, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //CJ_urb_rub_3b
	SetDynamicObjectMaterial(g_DynamicObject[3], 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFFFFFFF);
	g_DynamicObject[4] = CreateDynamicObject(19281, 1778.9182, -1805.0706, 17.2276, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[5] = CreateDynamicObject(19281, 1776.4873, -1805.0706, 25.0576, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[6] = CreateDynamicObject(19281, 1783.2070, -1806.0404, 22.7575, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[7] = CreateDynamicObject(19281, 1780.5869, -1808.7105, 25.3975, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[8] = CreateDynamicObject(19281, 1780.3067, -1808.8315, 17.4075, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[9] = CreateDynamicObject(19281, 1776.2264, -1810.6932, 21.6975, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[10] = CreateDynamicObject(19281, 1775.2561, -1808.0926, 27.9975, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[11] = CreateDynamicObject(19281, 1775.2561, -1808.2226, 24.0875, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[12] = CreateDynamicObject(19281, 1775.2561, -1805.9912, 19.3975, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight1
	g_DynamicObject[13] = CreateDynamicObject(19283, 1774.7093, -1805.9769, 21.7879, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[14] = CreateDynamicObject(19283, 1776.2596, -1809.2478, 19.3679, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[15] = CreateDynamicObject(19283, 1776.2596, -1809.2478, 25.3779, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[16] = CreateDynamicObject(19283, 1776.2596, -1806.7979, 27.3779, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[17] = CreateDynamicObject(19283, 1780.1594, -1803.6452, 21.5978, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[18] = CreateDynamicObject(19283, 1780.1594, -1806.1175, 28.6278, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[19] = CreateDynamicObject(19283, 1782.2102, -1808.4378, 19.6278, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[20] = CreateDynamicObject(19283, 1778.4996, -1809.4477, 22.1778, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight3
	g_DynamicObject[21] = CreateDynamicObject(19282, 1778.7728, -1806.3795, 24.1236, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[22] = CreateDynamicObject(19282, 1776.2127, -1804.9298, 17.1236, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[23] = CreateDynamicObject(19282, 1780.9235, -1806.9910, 16.7536, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[24] = CreateDynamicObject(19282, 1780.9235, -1807.0909, 20.0135, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[25] = CreateDynamicObject(19282, 1779.0728, -1808.2719, 27.7336, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[26] = CreateDynamicObject(19282, 1778.0325, -1808.1915, 17.7535, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[27] = CreateDynamicObject(19282, 1778.0325, -1808.1915, 23.5935, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[28] = CreateDynamicObject(19282, 1774.1007, -1807.7911, 19.0035, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[29] = CreateDynamicObject(19282, 1776.6315, -1806.1604, 28.7335, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight2
	g_DynamicObject[30] = CreateDynamicObject(19284, 1775.5675, -1808.3754, 26.0554, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[31] = CreateDynamicObject(19284, 1775.0970, -1805.6462, 25.1354, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[32] = CreateDynamicObject(19284, 1777.0163, -1803.6253, 19.6454, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[33] = CreateDynamicObject(19284, 1780.4171, -1806.1778, 23.6753, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[34] = CreateDynamicObject(19284, 1780.4171, -1808.2098, 20.2254, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[35] = CreateDynamicObject(19284, 1779.3662, -1805.5490, 26.7054, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[36] = CreateDynamicObject(19284, 1778.5554, -1810.1206, 25.0253, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[37] = CreateDynamicObject(19284, 1778.5554, -1809.0595, 19.4353, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[38] = CreateDynamicObject(19284, 1774.3051, -1808.1687, 22.4353, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //PointLight4
	g_DynamicObject[39] = CreateDynamicObject(1247, 1778.0083, -1807.0676, 32.3274, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //bribe
	g_DynamicObject[40] = CreateDynamicObject(1277, 1779.3402, -1804.5462, 20.0229, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[41] = CreateDynamicObject(1277, 1776.9294, -1803.9656, 23.2029, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[42] = CreateDynamicObject(1277, 1778.8006, -1806.3480, 28.3029, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[43] = CreateDynamicObject(1277, 1781.7103, -1804.3322, 22.0229, 0.0000, 0.0000, -55.3000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[44] = CreateDynamicObject(1277, 1779.7495, -1807.3420, 26.1029, 0.0000, 0.0000, -100.9999, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[45] = CreateDynamicObject(1277, 1782.4609, -1806.8118, 19.4429, 0.0000, 0.0000, -100.9999, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[46] = CreateDynamicObject(1277, 1780.4943, -1810.3422, 19.5429, 0.0000, 0.0000, -158.5999, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[47] = CreateDynamicObject(1277, 1777.4718, -1810.1307, 22.0429, 0.0000, 0.0000, 176.0000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[48] = CreateDynamicObject(1277, 1777.5416, -1809.1331, 28.5230, 0.0000, 0.0000, 176.0000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[49] = CreateDynamicObject(1277, 1775.0385, -1808.9587, 19.4830, 0.0000, 0.0000, 131.5000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[50] = CreateDynamicObject(1277, 1774.3626, -1805.6864, 20.4130, 0.0000, 0.0000, 83.2000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[51] = CreateDynamicObject(1277, 1775.9558, -1807.0249, 22.8030, 0.0000, 0.0000, 83.2000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[52] = CreateDynamicObject(1277, 1775.9558, -1807.0249, 28.7730, 0.0000, 0.0000, 83.2000, -1, -1, -1, 500.0, 550.0); //pickupsave
	g_DynamicObject[53] = CreateDynamicObject(1240, 1781.8400, -1808.6439, 21.7221, 0.0000, 0.0000, 102.7000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[54] = CreateDynamicObject(1240, 1781.8640, -1806.3195, 25.1521, 0.0000, 0.0000, 85.7000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[55] = CreateDynamicObject(1240, 1781.0244, -1808.4217, 16.8621, 0.0000, 0.0000, 85.7000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[56] = CreateDynamicObject(1240, 1776.3897, -1809.1210, 17.5521, 0.0000, 0.0000, 169.8000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[57] = CreateDynamicObject(1240, 1779.7460, -1809.7260, 19.5021, 0.0000, 0.0000, -153.5999, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[58] = CreateDynamicObject(1240, 1776.8901, -1808.0751, 25.6120, 0.0000, 0.0000, 172.8000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[59] = CreateDynamicObject(1240, 1774.1154, -1807.0161, 19.9820, 0.0000, 0.0000, 69.1000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[60] = CreateDynamicObject(1240, 1776.2495, -1806.2685, 26.3620, 0.0000, 0.0000, 109.2999, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[61] = CreateDynamicObject(1240, 1776.5073, -1803.5908, 22.3220, 0.0000, 0.0000, -5.5000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[62] = CreateDynamicObject(1240, 1779.1882, -1804.5552, 25.2920, 0.0000, 0.0000, -19.8000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[63] = CreateDynamicObject(1458, 1772.7194, -1807.1429, 12.6604, 26.4999, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //DYN_CART
	g_DynamicObject[64] = CreateDynamicObject(1240, 1777.7741, -1805.7994, 29.1220, 0.0000, 0.0000, -19.8000, -1, -1, -1, 500.0, 550.0); //health
	g_DynamicObject[65] = CreateDynamicObject(19054, 1772.5452, -1807.0754, 13.9305, 0.0000, 0.0000, 18.3999, -1, -1, -1, 500.0, 550.0); //XmasBox1
	g_DynamicObject[66] = CreateDynamicObject(19055, 1772.9190, -1804.4824, 13.3441, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //XmasBox2
	g_DynamicObject[67] = CreateDynamicObject(19056, 1772.5858, -1805.7429, 13.9630, 0.0000, 0.0000, -11.4000, -1, -1, -1, 500.0, 550.0); //XmasBox3
	g_DynamicObject[68] = CreateDynamicObject(19475, 1774.3364, -1811.4672, 12.8732, 0.0000, 0.0000, -90.0000, -1, -1, -1, 500.0, 550.0); //Plane001
	SetDynamicObjectMaterialText(g_DynamicObject[68],  0,"naughty list", 90, "Arial", 32, 1, 0xFFFFFFFF, 0x0, 0);
	g_DynamicObject[69] = CreateDynamicObject(19057, 1774.1011, -1805.6353, 13.2935, 0.0000, 7.8999, 0.0000, -1, -1, -1, 500.0, 550.0); //XmasBox4
	g_DynamicObject[70] = CreateDynamicObject(19058, 1774.4774, -1807.7186, 13.2721, 11.8000, 0.0000, 54.2000, -1, -1, -1, 500.0, 550.0); //XmasBox5
	g_DynamicObject[71] = CreateDynamicObject(854, 1773.8603, -1807.2078, 12.8001, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //CJ_urb_rub_3b
	SetDynamicObjectMaterial(g_DynamicObject[71], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	g_DynamicObject[72] = CreateDynamicObject(854, 1773.8603, -1804.3352, 12.8001, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //CJ_urb_rub_3b
	SetDynamicObjectMaterial(g_DynamicObject[72], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	g_DynamicObject[73] = CreateDynamicObject(854, 1771.9686, -1807.2078, 12.9601, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //CJ_urb_rub_3b
	SetDynamicObjectMaterial(g_DynamicObject[73], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	g_DynamicObject[74] = CreateDynamicObject(854, 1772.4190, -1803.9163, 12.9601, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //CJ_urb_rub_3b
	SetDynamicObjectMaterial(g_DynamicObject[74], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	g_DynamicObject[75] = CreateDynamicObject(854, 1772.4190, -1805.4860, 12.9601, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //CJ_urb_rub_3b
	SetDynamicObjectMaterial(g_DynamicObject[75], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	g_DynamicObject[76] = CreateDynamicObject(19064, 1775.8773, -1810.7739, 13.6047, 0.0000, 28.2999, 73.1000, -1, -1, -1, 500.0, 550.0); //SantaHat1
	g_DynamicObject[77] = CreateDynamicObject(3039, 1775.3422, -1810.8707, 12.5437, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //ct_stall1
	SetDynamicObjectMaterial(g_DynamicObject[77], 0, 642, "canopy", "wood02", 0xFFFFFFFF);
	SetDynamicObjectMaterial(g_DynamicObject[77], 1, 19058, "xmasboxes", "wrappingpaper4-2", 0xFFFFFFFF);
	g_DynamicObject[78] = CreateDynamicObject(19065, 1774.9620, -1810.8187, 13.5983, 0.0000, 27.3999, 71.4999, -1, -1, -1, 500.0, 550.0); //SantaHat2
	g_DynamicObject[79] = CreateDynamicObject(19066, 1776.3681, -1810.6839, 13.6148, 0.0000, 33.7000, 96.6000, -1, -1, -1, 500.0, 550.0); //SantaHat3
	g_DynamicObject[80] = CreateDynamicObject(19824, 1774.3750, -1810.4653, 13.6070, 0.0000, 0.0000, 0.0000, -1, -1, -1, 500.0, 550.0); //AlcoholBottle5
	g_DynamicObject[81] = CreateDynamicObject(19475, 1774.3764, -1811.4672, 12.8032, 0.0000, 0.0000, -90.0000, -1, -1, -1, 500.0, 550.0); //Plane001
	SetDynamicObjectMaterialText(g_DynamicObject[81], 0, "dizzle", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
	g_DynamicObject[82] = CreateDynamicObject(19475, 1774.3464, -1811.4672, 12.7532, 0.0000, 0.0000, -90.0000, -1, -1, -1, 500.0, 550.0); //Plane001
	SetDynamicObjectMaterialText(g_DynamicObject[82], 0, "theviking", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
	g_DynamicObject[83] = CreateDynamicObject(19475, 1774.4265, -1811.4672, 12.6932, 0.0000, 0.0000, -90.0000, -1, -1, -1, 500.0, 550.0); //Plane001
	SetDynamicObjectMaterialText(g_DynamicObject[83], 0, "ouday", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
	g_DynamicObject[84] = CreateDynamicObject(19475, 1774.3564, -1811.4672, 12.6432, 0.0000, 0.0000, -90.0000, -1, -1, -1, 500.0, 550.0); //Plane001
	SetDynamicObjectMaterialText(g_DynamicObject[84], 0, "[gsf]ice", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);

	return true ;
}