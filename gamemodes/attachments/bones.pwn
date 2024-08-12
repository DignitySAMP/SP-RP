enum {

	E_ATTACH_MAX_BONES = 18,
	E_ATTACH_BONE_SPINE = 1,
	E_ATTACH_BONE_HEAD,
	E_ATTACH_BONE_UPPER_ARM_L,
	E_ATTACH_BONE_UPPER_ARM_R,
	E_ATTACH_BONE_HAND_L,
	E_ATTACH_BONE_HAND_R,
	E_ATTACH_BONE_THIGH_L,
	E_ATTACH_BONE_THIGH_R,
	E_ATTACH_BONE_FOOT_L,
	E_ATTACH_BONE_FOOT_R,
	E_ATTACH_BONE_CALF_R,
	E_ATTACH_BONE_CALF_L,
	E_ATTACH_BONE_FOREARM_L,
	E_ATTACH_BONE_FOREARM_R,
	E_ATTACH_BONE_SHOULDER_L, // clavicle
	E_ATTACH_BONE_SHOULDER_R, // clavicle
	E_ATTACH_BONE_NECK,
	E_ATTACH_BONE_JAW,
}

Attach_ShowBoneList(playerid, modelid, index, fresh=false) {

	new string [ 256 ], name [ 64 ] ;

	inline AttachBoneList(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if ( response ) {

			new bone = listitem + 1 ;

			Attach_GetBoneName ( bone, name, sizeof ( name ) ) ;

			string [ 0 ] = EOS ;

			format ( string, sizeof ( string ), "You have selected bone \"%s\" (id %d). Move your attachment to your desired position.", name, bone ) ;
			SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string ) ;


			// Incase it's a new attachment, we'll need to set the scale properly...
			if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] <= 0.0 ) PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] = 1.0 ;
			if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] <= 0.0 ) PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] = 1.0 ;
			if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ] <= 0.0 ) PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ] = 1.0 ;

			if ( fresh ) {
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ index ] = 0.0 ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ index ] = 0.0 ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ index ] = 0.0 ;

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ index ] = 0.0 ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ index ] = 0.0 ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ index ] = 0.0 ;

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] = 1.0 ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] = 1.0 ;
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ] = 1.0 ;
			}

			SOLS_SetPlayerAttachedObject(playerid, index, modelid, bone, 

				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ index ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ index ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ index ] ,
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ index ],	
				PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ index ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ index ], 
				.save = false
			);

			if ( ! fresh ) {
				SOLS_EditAttachedObject(playerid, index, EDIT_TYPE_EXISTING );
			}

			else SOLS_EditAttachedObject(playerid, index, EDIT_TYPE_NEW );
		}
	}

	for ( new i = 1, j = E_ATTACH_MAX_BONES ; i <= j ; i ++ ) {

		Attach_GetBoneName ( i, name, sizeof ( name ) ) ;
		format ( string, sizeof ( string ), "%s%s\n", string, name ) ;
	}

	Dialog_ShowCallback ( playerid, using inline AttachBoneList, DIALOG_STYLE_LIST, "Attachments: Bones", string, "Select", "Close" );

}

SOLS_EditAttachedObject(playerid, index, type ) {

	PlayerVar [ playerid ] [ E_PLAYER_ATTACH_EDIT_TYPE ] = type ;
	EditAttachedObject(playerid, index);
}

Attach_GetBoneName(constant, name[], len = sizeof ( name ) ) {

	switch ( constant ) {

		case E_ATTACH_BONE_SPINE: 		format ( name, len, "Spine" ) ;
		case E_ATTACH_BONE_HEAD: 		format ( name, len, "Head" ) ;
		case E_ATTACH_BONE_UPPER_ARM_L: format ( name, len, "Left Upper Arm" ) ;
		case E_ATTACH_BONE_UPPER_ARM_R: format ( name, len, "Right Upper Arm" ) ;
		case E_ATTACH_BONE_HAND_L: 		format ( name, len, "Left Hand" ) ;
		case E_ATTACH_BONE_HAND_R: 		format ( name, len, "Right Hand" ) ;
		case E_ATTACH_BONE_THIGH_L: 	format ( name, len, "Left Thigh" ) ;
		case E_ATTACH_BONE_THIGH_R: 	format ( name, len, "Right Thigh" ) ;
		case E_ATTACH_BONE_FOOT_L: 		format ( name, len, "Left Foot" ) ;
		case E_ATTACH_BONE_FOOT_R: 		format ( name, len, "Right Foot" ) ;
		case E_ATTACH_BONE_CALF_R: 		format ( name, len, "Right Calf" ) ;
		case E_ATTACH_BONE_CALF_L: 		format ( name, len, "Left Calf" ) ;
		case E_ATTACH_BONE_FOREARM_L: 	format ( name, len, "Left Forearm" ) ;
		case E_ATTACH_BONE_FOREARM_R: 	format ( name, len, "Right Forearm" ) ;
		case E_ATTACH_BONE_SHOULDER_L: 	format ( name, len, "Left Shoulder" ) ;
		case E_ATTACH_BONE_SHOULDER_R:  format ( name, len, "Right Shoulder" ) ;
		case E_ATTACH_BONE_NECK: 		format ( name, len, "Neck" ) ;
		case E_ATTACH_BONE_JAW: 		format ( name, len, "Jaw" ) ;
		default:						format ( name, len, "Invalid" ) ;
	}
}