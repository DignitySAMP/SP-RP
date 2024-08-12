new DiscordPlayerCMDCD ;
//static DcPlayerStr[1536];

public DCC_OnMessageCreate(DCC_Message:message)
{
    new content[DCC_ID_SIZE], DCC_Channel:channel, DCC_User:user ;
	DCC_GetMessageAuthor(message, user);
    DCC_GetMessageContent(message, content);
    DCC_GetMessageChannel(message, channel);
   
    if(content[0] == DISCORD_COMMAND_PREFIX ) {

		if(!strcmp("players", content[1], false))
		{
			if ( DiscordPlayerCMDCD >= gettime() ) {

				DCC_SendChannelMessage(channel, sprintf("Not so fast! Wait %d seconds before using this command again.", DiscordPlayerCMDCD - gettime()));
				return 1 ;
			}

			DiscordPlayerCMDCD = gettime () + 15 ;
			new DCC_Embed:embed = DCC_CreateEmbed("Live Player Statistics","","","", 0xDE781F," ","","https://i.imgur.com/Ew88BWI.png","");

	   		DCC_AddEmbedField(embed, "Players Online", sprintf("%d/%d", GetConnectedPlayers(), GetMaxPlayers()), true);
	   		DCC_AddEmbedField(embed, "Server IP", "server.singleplayer-roleplay.com:7777", true);
			DCC_SendChannelEmbedMessage(channel, embed);

		}
	}

    return 1;
}

GetConnectedPlayers() {

	new count ;

	foreach(new i: Player ) {

		if ( IsPlayerConnected ( i  )) {

			count ++ ;
		}
	}

	return count ;
}