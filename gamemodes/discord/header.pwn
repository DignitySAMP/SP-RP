#include <a_samp>
#include <discord-connector>

#define DISCORD_COMMAND_PREFIX '-'


#include "discord/players.pwn"

DCC_SendAdvertisementMessage(type, msg[]) {

	new title[64], color ;

	new DCC_Channel: channel = DCC_FindChannelById("943160056369774622");

	switch ( type ) {

		case 0: format ( title, sizeof ( title ), "Advertisement" ), color = 0x3dfc03 ; // /ad
		case 1: format ( title, sizeof ( title ), "Business" ), color = 0x03a5fc ; // /badvert
	}

	new DCC_Embed:embed = DCC_CreateEmbed(title, msg,"","", color," ","","https://i.imgur.com/Ew88BWI.png","");

	DCC_SendChannelEmbedMessage(channel, embed);
}

DCC_SendAdminLogMessage(msg[]) {

	new DCC_Channel: channel = DCC_FindChannelById("943163256699232337");
	new DCC_Embed:embed = DCC_CreateEmbed("Admin Log", msg,"","", 0xfce703," ","","https://i.imgur.com/Ew88BWI.png","");
	DCC_SendChannelEmbedMessage(channel, embed);
	
}

DCC_SendAntiCheatMessage(title[], msg[]) {

	new DCC_Channel: channel = DCC_FindChannelById("957013198484156467");
	new DCC_Embed:embed = DCC_CreateEmbed(title, msg,"","", 0xFFAB00," ","","https://i.imgur.com/lus6z7e.png","");
	DCC_SendChannelEmbedMessage(channel, embed);
}

DCC_SendCharityLogMessage(msg[]) {

	new DCC_Channel: channel = DCC_FindChannelById("696709569946320936");
	new DCC_Embed:embed = DCC_CreateEmbed("Charity Log", msg,"","", 0xfce703," ","","https://i.imgur.com/Ew88BWI.png","");
	DCC_SendChannelEmbedMessage(channel, embed);
}

DCC_SendAdminPunishmentMessage(msg[]) {

	new DCC_Channel: channel = DCC_FindChannelById("797912644811096074");
	new DCC_Embed:embed = DCC_CreateEmbed("Admin Log", msg,"","", 0xfce703," ","","https://i.imgur.com/Ew88BWI.png","");
	DCC_SendChannelEmbedMessage(channel, embed);

	return true ;
}