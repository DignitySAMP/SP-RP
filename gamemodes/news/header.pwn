//------------------------------------------------------------------------------
// Legal RP Project - RP News Faction
// Created by Sporky (www.github.com/sporkyspork) for Singleplayer Roleplay (www.stretzofls.com)

#include "news/broadcast.pwn" // talkshow system
#include "news/breaking.pwn" // breaking news announcement

IsPlayerInNewsFaction(playerid, bool:onduty=false) 
{
	return IsPlayerInFactionType(playerid, FACTION_TYPE_NEWS, onduty);
}

/*
hook OnGameModeInit()
{ // Convert these to new model system...

    static enum 
    {
        E_NEWS_MODEL_MIC = 25200,
        E_NEWS_MODEL_VEST,
        E_NEWS_MODEL_BOOM,
        E_NEWS_MODEL_CAM,
        E_NEWS_MODEL_LIGHT
    }


    AddSimpleModel(-1, 19142, -E_NEWS_MODEL_VEST, "sporky/news/press_vest.dff", "sporky/news/press_stuff.txd");
    AddSimpleModel(-1, 19610, -E_NEWS_MODEL_MIC, "sporky/news/press_mic.dff", "sporky/news/press_stuff.txd");
    AddSimpleModel(-1, 19611, -E_NEWS_MODEL_BOOM, "sporky/news/boom_mic.dff", "sporky/news/press_stuff.txd");
    AddSimpleModel(-1, 19623, -E_NEWS_MODEL_CAM, "sporky/news/filmcamera.dff", "sporky/news/filmcamera.txd");
    AddSimpleModel(-1, 19611, -E_NEWS_MODEL_LIGHT, "sporky/news/filmlight.dff", "sporky/news/filmlight.txd");

    
    return 1;
}*/
