// Add these to PLAYER_VARS enum
#include "visuals/models.pwn"
#include "visuals/objects.pwn"
#include "visuals/remove.pwn"
#include "visuals/commands.pwn"

#include "visuals/maps/header.pwn"

#include <YSI_Coding\y_hooks>

new bool: IsPlayerFinishedDownloading [ MAX_PLAYERS ] ;

/*

	Player skins use ranges: 20000 to 30000 (10000 slots)
	Objects use negative IDs: -1000 to -30000 (29000 slots)

	native AddCharModel(baseid, newid, dffname[], txdname[]);
	native AddSimpleModel(virtualworld, baseid, newid, dffname[], txdname[]);
*/

/*

new bool: IsPlayerFinishedDownloading [ MAX_PLAYERS ] ;
new baseurl[] = "http://files.streetzofls.com";

static localfiles[][] = 
{
    "attachments/lsfd/lifepak.dff",
    "attachments/lsfd/lifepak.txd",
    "sporky/news/filmcamera.dff",
    "sporky/news/filmcamera.txd",
    "sporky/news/filmlight.dff",
    "sporky/news/filmlight.txd",
    "sporky/sols/int/lsfd/mafcasdoor.dff",
    "sporky/sols/int/lsfd/mafcasdoor.txd",
    "faction_skins/san/mskin4.dff",
    "faction_skins/san/mskin4.txd"
};

public OnPlayerRequestDownload ( playerid, type, crc ) 
{
    new dlfilename [ 64 + 1 ], foundfilename = 0, requesturl[128];
    
    if ( !IsPlayerConnected ( playerid ) ) return 0;
    
    switch ( type ) {

    	case DOWNLOAD_REQUEST_TEXTURE_FILE: foundfilename = FindTextureFileNameFromCRC ( crc, dlfilename, sizeof ( dlfilename ) ) ;
    	case DOWNLOAD_REQUEST_MODEL_FILE: 	foundfilename = FindModelFileNameFromCRC ( crc, dlfilename, sizeof ( dlfilename ) ) ;
    }

    if ( foundfilename ) 
    {
        for (new i = 0; i < sizeof(localfiles); i ++)
        {
            if (!strcmp(dlfilename, localfiles[i]))
            {
                // printf("serving file: %s (%x) locally", dlfilename, crc);
                return 1;
            }
        }

        format(requesturl, 128, "%s/%s", baseurl, dlfilename);
        // printf("redirecting file: %s (%x) to %s", dlfilename, crc, requesturl);
        RedirectDownload ( playerid, requesturl );
    }
    
    return 0;
}

*/

hook OnGameModeInit()
{
    // Does the above in a filterscript now
    // SendRconCommand("loadfs sols_dl_redirect");
    return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld) {

    IsPlayerFinishedDownloading [ playerid ] = true ;

    return 1;
}

CMD:drawdistance( playerid, params[ ] )
{
    new string [ 75 ] ;

    if ( strmatch( params, "low" ) ) {
        Streamer_SetVisibleItems( STREAMER_TYPE_OBJECT, 250, playerid );
        SendClientMessage( playerid, 0x84aa63ff, "-> Draw distance of objects now set to LOW (250 objs)." );
    } else if ( strmatch( params, "medium" ) ) {
        Streamer_SetVisibleItems( STREAMER_TYPE_OBJECT, 500, playerid );
        SendClientMessage( playerid, 0x84aa63ff, "-> Draw distance of objects now set to MEDIUM (500 objs)." );
    } else if ( strmatch( params, "high" ) ) {
        Streamer_SetVisibleItems( STREAMER_TYPE_OBJECT, 750, playerid );
        SendClientMessage( playerid, 0x84aa63ff, "-> Draw distance of objects now set to HIGH (750 objs)." );
    } else if ( strmatch( params, "ultra" ) ) {
        Streamer_SetVisibleItems( STREAMER_TYPE_OBJECT, 1250, playerid );
        SendClientMessage( playerid, 0x84aa63ff, "-> Draw distance of objects now set to ULTRA (1250 objs)." );
    }
    else if ( strmatch( params, "dev" ) ) {
        Streamer_SetVisibleItems( STREAMER_TYPE_OBJECT, 2000, playerid );
        SendClientMessage( playerid, 0x84aa63ff, "-> Draw distance of objects now set to DEV (2000 objs)." );
    } else if ( strmatch( params, "info" ) ) {
        format ( string, sizeof ( string ), "-> You have currently %d objects streamed towards your client.", Streamer_GetVisibleItems( STREAMER_TYPE_OBJECT, playerid ) );
        SendClientMessage( playerid, 0x84aa63ff, string );
    }
    else {
        SendClientMessage( playerid, 0xa9c4e4ff, "-> /drawdistance [LOW/MEDIUM/HIGH/ULTRA//DEV/INFO]" );
    }
    return 1;
}
