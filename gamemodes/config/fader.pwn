new Text: td_fade = Text: INVALID_TEXT_DRAW ;


new IsFadeActive[MAX_PLAYERS] ;
new FadingStatus[MAX_PLAYERS] ;

#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid) {

    IsFadeActive[playerid] = 0;
    FadingStatus[playerid] = 0;
    return 1;
}


LoadFaderTextdraw () {
	td_fade = TextDrawCreate( -20.000000, 0.000000, "_" ); 
 	TextDrawUseBox( td_fade, 1 );
 	TextDrawBoxColor( td_fade, 0x000000FF );
 	TextDrawAlignment( td_fade, 0 );
 	TextDrawBackgroundColor( td_fade, 0x000000FF );
 	TextDrawFont( td_fade, 3 );
 	TextDrawLetterSize( td_fade, 1.000000, 52.200000 );
 	TextDrawColor( td_fade, 0x000000FF );
}

FadeIn ( playerid, freeze=true, delay=1000 ) 
{
	if ( ! IsFadeActive[playerid] ) 
	{
		FadingStatus[playerid] = 10;
		IsFadeActive[playerid] = true;

		if (freeze) TogglePlayerControllable(playerid, false);
		if (delay) defer FadeTimer[delay](playerid, freeze);
		else FadeTimer(playerid, freeze);
		
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	}
}

timer FadeTimer[100](playerid, freeze) 
{
	if (!IsFadeActive[playerid]) return false;

	FadingStatus[playerid] --;

	if (FadingStatus[playerid] > 0)
	{
		TextDrawHideForPlayer(playerid, td_fade);
		TextDrawBoxColor(td_fade, (0 << 24) | ((0 & 0xFF) << 16) | ((0 & 0xFF) << 8) | (FadingStatus[playerid] * (255 / 10)) & 0xFF);
		TextDrawShowForPlayer(playerid, td_fade);

		defer FadeTimer(playerid, freeze);
	}
	else
	{
		TextDrawHideForPlayer(playerid, td_fade );

		if ( freeze ) 
		{
			TogglePlayerControllable(playerid, true);
		}

		FadingStatus[playerid] = 0;
		IsFadeActive[playerid] = false;
	}
	
	return true ;
}

IsPlayerFading(playerid) 
{
    return IsFadeActive[playerid];
}

BlackScreen(playerid) 
{	
	IsFadeActive[playerid] = false;
	TextDrawHideForPlayer(playerid, td_fade);
	TextDrawBoxColor(td_fade, 0x000000FF);
	TextDrawShowForPlayer(playerid, td_fade);
	return true;
}
