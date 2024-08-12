#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <YSI_Visual\y_dialog>
#include <YSI_Coding\y_inline>
#include <streamer>
#include <strlib>

#if !defined COLOR_ATTACH
	#define COLOR_ATTACH	0x1FDED5FF
#endif

enum {

	E_ATTACH_INDEX_TOY_1 = 0,
	E_ATTACH_INDEX_TOY_2 = 1,
	E_ATTACH_INDEX_TOY_3 = 2,
	E_ATTACH_INDEX_TOY_4 = 3,
	E_ATTACH_INDEX_TOY_5 = 4,
	E_ATTACH_INDEX_TOY_6 = 5,
	E_ATTACH_INDEX_TOY_7 = 6,

	E_ATTACH_INDEX_SYSTEM = 7, // System Items: phone, helmet, ... 
	E_ATTACH_INDEX_MINIGAME = 8, // Minigame slot (pool, poker, ...)
	E_ATTACH_INDEX_MISC = 9, // Temporary Hand Items: food, fuels, ...
}

#include "attachments/player.pwn"
#include "attachments/store/header.pwn"
#include "attachments/models.pwn"
#include "attachments/bones.pwn"
#include "attachments/admin.pwn"

CMD:toy(playerid, params[])
{
	new id = -1;

	if (sscanf(params, "i", id) || id < 0 || id >= MAX_PLAYER_ATTACHMENTS) 
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/toy [slot number]");
	}

	new type = Attach_GetType(PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ id ]);

	if (type == -1)
	{
		return SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", "This slot is unused! You can buy a toy at a clothing store, jewelry store or barbershop!" ) ;
	}

	new name[64], string[144];
	Attach_GetName(type, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ id ], name, sizeof ( name ) ) ;
							
	if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ id ] ) {

		PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ id ] = false ;	
		format ( string, sizeof ( string), "You've taken OFF your \"%s\" in slot %d.", name, id );

		RemovePlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ id ] ) ;
	}

	else if ( ! PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ id ] ) {

		PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ id ] = true ;
		format ( string, sizeof ( string), "You've put ON your \"%s\" in slot %d.", name, id );

		SOLS_SetPlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ id ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ id ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ id ], 

			PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ id ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ id ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ id ] ,
			PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ id ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ id ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ id ],	
			PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ id ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ id ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ id ], 
			.save = false
		);
	}
	
	SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string ) ;

	string[0] = EOS ;

	mysql_format(mysql, string, sizeof ( string ), "UPDATE player_attachments SET player_attach_visible_%d = %d WHERE player_attach_charid = %d", 
		id, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ id ], Character [ playerid ] [ E_CHARACTER_ID ]
	) ;

	mysql_tquery(mysql, string);

	return true;
}

CMD:mytoys(playerid, params[]) {

	return cmd_toys(playerid, params);
}

CMD:reloadtoys(playerid) {
	if (PlayerVar [ playerid ] [ E_PLAYER_TOY_RELOAD_CD ]  >= gettime ()) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You need to wait %d seconds before reloading toys again (cooldown)!", PlayerVar [ playerid ] [ E_PLAYER_TOY_RELOAD_CD] - gettime ()));
	}

	PlayerVar [ playerid ] [ E_PLAYER_TOY_RELOAD_CD ] = gettime () + 60 ;

	defer Attach_LoadDelayedEntities(playerid);

	return true ;
}
CMD:toys(playerid, params[]) {
	new string [ 512 ], name[64], bone [ 32 ], visible [ 32 ], type ;

	inline PlayerToyList(pid, dialogid, response, listitem, string:inputtext[]) {

		#pragma unused pid, dialogid, inputtext, listitem
		if ( response ) {

			if ( Attach_GetType( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitem ] ) == -1 ) {

				return SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", "This slot is unused! You can buy a toy at a clothing store, jewelry store or barbershop!" ) ;
			}

			inline PlayerToyList_Menu(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
				#pragma unused pidx, dialogidx, inputtextx, listitemx

				if ( responsex ) {

					switch ( listitemx ) {

						case 0: {

							string[0]=EOS;

							type = Attach_GetType(PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitem ]);
							Attach_GetName(type, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitem ], name, sizeof ( name ) ) ;
							
							if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ listitem ] ) {

								PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ listitem ] = false ;	
								format ( string, sizeof ( string), "You've taken OFF your \"%s\" in slot %d.", name, listitem );

								RemovePlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ listitem ] ) ;
							}

							else if ( ! PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ listitem ] ) {

 							 	PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ listitem ] = true ;
								format ( string, sizeof ( string), "You've put ON your \"%s\" in slot %d.", name, listitem );

 							 	SOLS_SetPlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ listitem ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitem ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ listitem ], 

									PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_X ] [ listitem ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Y ] [ listitem ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_OFFSET_Z ] [ listitem ] ,
									PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_X ] [ listitem ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Y ] [ listitem ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_ROT_Z ] [ listitem ],	
									PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_X ] [ listitem ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Y ] [ listitem ] , PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_SCALE_Z ] [ listitem ], 
									.save = false
								);
							}
							
							SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string ) ;

							string[0] = EOS ;
							mysql_format(mysql, string, sizeof ( string ), "UPDATE player_attachments SET player_attach_visible_%d = %d WHERE player_attach_charid = %d", 
								listitem, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ listitem ], Character [ playerid ] [ E_CHARACTER_ID ]
							) ;

							mysql_tquery(mysql, string);
						}

						case 1: {

							Attach_GetBoneName ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ listitem ], bone, sizeof ( bone ) ) ;
							format ( string, sizeof ( string ), "Select the bone you would like your toy to replace. Old bone: %s (id %d).", bone, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ listitem ] ) ;
							SendServerMessage ( playerid, COLOR_ATTACH, "Attach", "DEDEDE", string);
							Attach_ShowBoneList(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitem ], PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ listitem ] ) ;
						}
						case 2: {

							PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ listitem ] = 0 ;
							PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ listitem ] = 0 ;
							PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ listitem ] = 0 ;

							RemovePlayerAttachedObject(playerid, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_INDEX ] [ listitem ] ) ;

							string[0] = EOS ;
							mysql_format(mysql, string, sizeof ( string ), "UPDATE player_attachments SET player_attach_model_%d = 0, player_attach_bone_%d = 0, player_attach_visible_%d = 0 WHERE player_attach_charid = %d", 
								listitem, listitem, listitem, Character [ playerid ] [ E_CHARACTER_ID ]
							) ;

							mysql_tquery(mysql, string);
						}
					}
				}
			}

			Dialog_ShowCallback ( playerid, using inline PlayerToyList_Menu, DIALOG_STYLE_LIST, "Attachments: Manage", "(Un)equip Attachment\nEdit Attachment\nDiscard Slot", "Select", "Close" );

		}

	}


	format ( string, sizeof ( string ), "Slot \t Name \t Bone \t Visible\n" ) ;

	for ( new i = 0, j = MAX_PLAYER_ATTACHMENTS; i < j ; i ++ ) {

		type = Attach_GetType(PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ i ]);

		Attach_GetBoneName ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_BONE ] [ i ], bone, sizeof ( bone ) ) ;
		Attach_GetName(type, PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_MODEL ] [ i ], name, sizeof ( name ) ) ;
		
		if ( PlayerAttachments [ playerid ] [ E_PLAYER_ATTACH_VISIBLE ] [ i ] ) {
			format ( visible, sizeof ( visible), "Yes" ) ;
		}

		else format ( visible, sizeof ( visible), "No" ) ;

		format ( string, sizeof ( string ), "%s%d \t %s \t %s \t %s\n", string, i, name, bone, visible ) ;
	}

	Dialog_ShowCallback ( playerid, using inline PlayerToyList, DIALOG_STYLE_TABLIST_HEADERS, "Attachments: Owned", string, "Select", "Close" );


	return true ;
}


Attachments_LoadEntities() {

	Attachments_LoadCustomModels() ;
	AttachPoint_LoadEntities();

	return true ;
}

Attachments_CountBone(playerid, bone)
{
	new count = 0;

	for ( new i = 0, j = MAX_PLAYER_ATTACHMENTS; i < j ; i ++ ) 
	{
		if (PlayerAttachments[playerid][E_PLAYER_ATTACH_VISIBLE][i] && PlayerAttachments[playerid][E_PLAYER_ATTACH_BONE][i] == bone)
		{
			count ++;
		}
	}

	return count;
}

Attachments_CountMask(playerid)
{
	new count = 0, bone = 0;

	for ( new i = 0, j = MAX_PLAYER_ATTACHMENTS; i < j ; i ++ ) 
	{
		bone = PlayerAttachments[playerid][E_PLAYER_ATTACH_BONE][i];

		if (PlayerAttachments[playerid][E_PLAYER_ATTACH_VISIBLE][i] && (bone == 2 || bone == 17 || bone == 18))
		{
			count ++;
		}
	}

	return count;
}