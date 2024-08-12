#define MAX_CH_MEMBERS 	6
#define MAX_CHANNELS	8

static enum E_RADIO_CHANNEL
{
	E_RADIO_CH_NAME[64],
	E_RADIO_CH_TAG[10],
	bool:E_RADIO_CH_REPEATED,
	bool:E_RADIO_CH_ENCRYPTED,
	E_RADIO_CH_MEMBERS[MAX_CH_MEMBERS],
	E_RADIO_CH_SQUAD,
	bool:E_RADIO_CH_HIDDEN
}

#define CH_LSPD	10
//#define CH_LSFD	25
//#define CH_GOV 	33

static const RadioChannels[MAX_CHANNELS][E_RADIO_CHANNEL] = 
{
    { "LSPD Central Bureau Dispatch", "CENTRAL", true, false, { CH_LSPD } },
    { "LSPD Citywide TAC #1", "CW-TAC1", false, false, { CH_LSPD } },
    { "LSPD Citywide TAC #2", "CW-TAC2", false, false, { CH_LSPD } },
    { "LSPD Citywide TAC #3", "CW-TAC3", false, false, { CH_LSPD } },

    { "LSPD Central Traffic Dispatch", "24-CTD", true, false, { CH_LSPD }, FACTION_SQUAD_TRAFF },
    { "LSPD Detective Bureau Dispatch", "53-DBU", true, false, { CH_LSPD }, FACTION_SQUAD_CRASH },
    { "LSPD CRASH Unit Dispatch", "54-CRASH", false, true, { CH_LSPD }, FACTION_SQUAD_CRASH },
    { "LSPD Metropolitan Dispatch", "65-METRO", true, false, { CH_LSPD }, FACTION_SQUAD_SWAT }
};

// Sets players radio channel either to invalid or the first one found for their faction (used on login)
Radio_InitializePlayer(playerid)
{
	new fid = Character[playerid][E_CHARACTER_FACTIONID];
	PlayerVar[playerid][E_PLAYER_PD_RADIO_CHANNEL] = -1;

	if (fid)
	{
		for (new i = 0; i < MAX_CHANNELS; i ++)
		{
			if (RadioChannels[i][E_RADIO_CH_MEMBERS] && RadioChannels[i][E_RADIO_CH_MEMBERS][0] == fid)
			{
				PlayerVar[playerid][E_PLAYER_PD_RADIO_CHANNEL] = i;
				break;
			}
		}
	}
}

hook SOLS_OnLoadCharacter(playerid, character_id)
{
	Radio_InitializePlayer(playerid);
	new ch = PlayerVar[playerid][E_PLAYER_PD_RADIO_CHANNEL];
	
	if (ch != -1 && PlayerVar[playerid][E_PLAYER_FACTION_DUTY])
	{
		SendServerMessage(playerid, COLOR_FACTION, "Radio", "A3A3A3", sprintf("Your radio was automatically tuned to Channel %d \"%s\".", ch, RadioChannels[ch][E_RADIO_CH_TAG]));
	}

	return 1;
}

static bool:ArrayContains(const array[], size, value)
{
    for (new i = 0; i < size; i ++)
    {
        if (array[i] == value) return true;
    }

    return false;
}

bool:IsRadioChannelMember(channel, factionid)
{
	if (!RadioChannels[channel][E_RADIO_CH_MEMBERS]) return true;
	return ArrayContains(RadioChannels[channel][E_RADIO_CH_MEMBERS], MAX_CH_MEMBERS, factionid);
}

bool:IsRadioChannelPlayer(channel, playerid)
{
	return Character[playerid][E_CHARACTER_FACTIONID] && IsRadioChannelMember(channel, Character[playerid][E_CHARACTER_FACTIONID]) 
		&& (!RadioChannels[channel][E_RADIO_CH_SQUAD] || (Character[playerid][E_CHARACTER_FACTION_SQUAD] == RadioChannels[channel][E_RADIO_CH_SQUAD]
		|| Character[playerid][E_CHARACTER_FACTION_SQUAD2] == RadioChannels[channel][E_RADIO_CH_SQUAD]
		|| Character[playerid][E_CHARACTER_FACTION_SQUAD3] == RadioChannels[channel][E_RADIO_CH_SQUAD]));
}

bool:IsRadioMessageReceiver(senderid, targetid)
{
	new channel = PlayerVar[senderid][E_PLAYER_PD_RADIO_CHANNEL];

	if (RadioChannels[channel][E_RADIO_CH_REPEATED] && Character[senderid][E_CHARACTER_FACTIONID] == Character[targetid][E_CHARACTER_FACTIONID])
	{
		// If this is a repeated channel and they are in the same faction + squad, always return true
		if (!RadioChannels[channel][E_RADIO_CH_SQUAD] || RadioChannels[channel][E_RADIO_CH_SQUAD] == Character[targetid][E_CHARACTER_FACTION_SQUAD])
		{
			return true;
		}
	}
	else if (RadioChannels[channel][E_RADIO_CH_MEMBERS] && (RadioChannels[channel][E_RADIO_CH_REPEATED] || PlayerVar[targetid][E_PLAYER_PD_RADIO_CHANNEL] == PlayerVar[senderid][E_PLAYER_PD_RADIO_CHANNEL]))
	{
		if (!RadioChannels[channel][E_RADIO_CH_SQUAD] || RadioChannels[channel][E_RADIO_CH_SQUAD] == Character[targetid][E_CHARACTER_FACTION_SQUAD])
		{
			// Otherwise, if they are in a member faction of the channel and either:
			// 1. it's a repeated channel, or
			// 2. they are tuned to the channel
			return ArrayContains(RadioChannels[channel][E_RADIO_CH_MEMBERS], MAX_CH_MEMBERS, Character[targetid][E_CHARACTER_FACTIONID]);
		}
	} 

	return false;
}

bool:IsRadioFaction(fac_enumid)
{
	new ftype = Faction_GetType(fac_enumid);
	return ftype == FACTION_TYPE_POLICE || ftype == FACTION_TYPE_EMS || ftype == FACTION_TYPE_GOV;
}

bool:IsInRadioFaction(playerid)
{
	new factionid = Character[playerid][E_CHARACTER_FACTIONID];

	if (factionid)
	{
		return IsRadioFaction(Faction_GetEnumID(factionid));
	}

	return false;
}

static ChannelDlgStr[2048];

ShowRadioChannelDlg(playerid, channel)
{
	inline DlgChannel(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

        if (response)
		{
			cmd_channel(playerid, sprintf("%d", channel));
		}
		else
		{
			cmd_channels(playerid);
		}
    }

	format(ChannelDlgStr, sizeof(ChannelDlgStr), "{FFFFFF}You're viewing the {AA3333}\"%s\"{FFFFFF} radio channel.", RadioChannels[channel][E_RADIO_CH_NAME]);

	strcat(ChannelDlgStr, "\n\n{FFFFFF}Channel Members:{ADBEE6}");
	for (new i = 0; i < MAX_FACTIONS; i ++)
	{
		if (IsRadioChannelMember(channel, Faction[i][E_FACTION_ID]))
		{
			strcat(ChannelDlgStr, sprintf("\n- %s (%s)", Faction[i][E_FACTION_NAME], Faction[i][E_FACTION_ABBREV]));
		}
	}

	strcat(ChannelDlgStr, "\n\n{FFFFFF}Channel Attributes:{ADBEE6}");
	if (RadioChannels[channel][E_RADIO_CH_REPEATED]) strcat(ChannelDlgStr, "\n- This channel is repeated to members across all frequencies.");
	else strcat(ChannelDlgStr, "\n- This channel is only broadcast to tuned listeners.");
	if (RadioChannels[channel][E_RADIO_CH_SQUAD]) strcat(ChannelDlgStr, sprintf("\n- Access to this channel is restricted to Squad %d.", RadioChannels[channel][E_RADIO_CH_SQUAD]));
	else strcat(ChannelDlgStr, sprintf("\n- Any member can access this channel."));
	if (RadioChannels[channel][E_RADIO_CH_ENCRYPTED]) strcat(ChannelDlgStr, "\n- Radio traffic on this channel is protected by encryption.");
	else strcat(ChannelDlgStr, "\n- Radio traffic on this channel is broadcasted without encryption.");

	strcat(ChannelDlgStr, "\n\n{FFFFFF}Press {AA3333}Tune{FFFFFF} to set your radio to this channel.");
	Dialog_ShowCallback ( playerid, using inline DlgChannel, DIALOG_STYLE_MSGBOX, sprintf("%s (%s)", RadioChannels[channel][E_RADIO_CH_NAME], RadioChannels[channel][E_RADIO_CH_TAG]), ChannelDlgStr, "Tune", "Back" );
}

CMD:channels(playerid)
{
	format(ChannelDlgStr, sizeof(ChannelDlgStr), "Channel\tTag\tDescription\tRepeated");

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ], faction_enum_id;
	new map[MAX_CHANNELS], count;

	if (factionid)
	{
		faction_enum_id = Faction_GetEnumID(factionid);
		if (!IsPlayerInAnyGovFaction(playerid)) factionid = 0;
	}

	for (new i = 0; i < MAX_CHANNELS; i ++)
	{
		if (RadioChannels[i][E_RADIO_CH_HIDDEN] && !IsRadioChannelPlayer(i, playerid)) continue;

		if (RadioChannels[i][E_RADIO_CH_MEMBERS] || !factionid)
		{
			format(ChannelDlgStr, sizeof(ChannelDlgStr), "%s\n%d\t%s\t%s\t%s", ChannelDlgStr, i, RadioChannels[i][E_RADIO_CH_TAG], RadioChannels[i][E_RADIO_CH_NAME], RadioChannels[i][E_RADIO_CH_REPEATED] ? "Yes" : "No");
		}
		else
		{
			format(ChannelDlgStr, sizeof(ChannelDlgStr), "%s\n%d\t%s\t%s %s\t%s", ChannelDlgStr, i, RadioChannels[i][E_RADIO_CH_TAG], Faction[faction_enum_id][E_FACTION_ABBREV], RadioChannels[i][E_RADIO_CH_NAME], RadioChannels[i][E_RADIO_CH_REPEATED] ? "Yes" : "No");
		}

		map[count] = i;
		count ++;
	}

    inline DlgChannels(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem

        if (response && listitem < MAX_CHANNELS && listitem >= 0)
		{
			ShowRadioChannelDlg(playerid, map[listitem]);
		}
    }

    Dialog_ShowCallback ( playerid, using inline DlgChannels, DIALOG_STYLE_TABLIST_HEADERS, "Radio Channels", ChannelDlgStr, "Select", "Back" );
	return true;
}

CMD:chs(playerid)
{
	return cmd_channels(playerid);
}

CMD:channel(playerid, params[]) 
{
	if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	if (!IsInRadioFaction(playerid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction that can switch radio channels.");
	}

	// new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	// new faction_enum_id = Faction_GetEnumID( factionid ); 

	new option, current = PlayerVar[playerid][E_PLAYER_PD_RADIO_CHANNEL];

	if (sscanf(params, "d", option) || option < 0 || option >= MAX_CHANNELS) 
	{
		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/ch(annel) [number]" ) ;

		if (current >= 0 && current < MAX_CHANNELS)
		{	
			SendClientMessage(playerid, 0xDEDEDEFF, sprintf("Type /channels to view a full list. Your current channel is (%d) \"%s\".", current, RadioChannels[current][E_RADIO_CH_TAG]));
		}
		else
		{
			SendClientMessage(playerid, 0xDEDEDEFF, sprintf("Type /channels to view a full list. Your current channel is %d (Invalid).", current));
		}

		return true;
	}

	if (!IsRadioChannelPlayer(option, playerid))
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have access to this radio channel.");
	}

	PlayerVar [ playerid ] [ E_PLAYER_PD_RADIO_CHANNEL ] = option;
	SendServerMessage ( playerid, COLOR_FACTION, "Radio", "A3A3A3", sprintf("Channel changed to \"%s\" (%s).", RadioChannels[option][E_RADIO_CH_NAME], RadioChannels[option][E_RADIO_CH_TAG]) );

	return true ;
}

CMD:ch(playerid, params[])
{
	return cmd_channel(playerid, params);
}

CMD:scanner(playerid, params[])
{
	if (!IsPlayerInNewsFaction(playerid)) return false;

	if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new veh_enum_id = Vehicle_GetEnumID(vehicleid);
	
	if (!IsPlayerInAnyVehicle(playerid) || !vehicleid || veh_enum_id == -1)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be in a vehicle equipped with a radio scanner." ) ;
	}

	new channel, channelstr[5];
    sscanf(params, "s[5]", channelstr); 

	if (strlen(channelstr))
	{
		if (!strcmp(channelstr, "off", true))
		{
			SendClientMessage(playerid, COLOR_FACTION, "You turned the radio scanner off.");
			VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL] = 0;
			return true;
		}

		channel = strval(channelstr);
		if (IsNumeric(channelstr) && channel >= 0 && channel < MAX_CHANNELS)
		{
			if (RadioChannels[channel][E_RADIO_CH_ENCRYPTED])
			{
				return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "This channel is encrypted.");
			}

			VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL] = channel + 1;
			SendClientMessage(playerid, COLOR_FACTION, sprintf("You tuned the scanner to the \"%s\" channel. It's now playing in the car.", RadioChannels[channel][E_RADIO_CH_NAME]));
			return true;
		}
	}

	// Otherwise show the syntax
	SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/scanner [channel number] (or \"off\" to disable)");
	SendClientMessage(playerid, 0xDEDEDEFF, "Type /channels to view a full list of radio channels.");
	return true;
}

CMD:radio(playerid, params[]) 
{
	if (IsPlayerIncapacitated(playerid, false)) return SendServerMessage(playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this.");
	
	new factionid = Character[playerid][E_CHARACTER_FACTIONID];
	new faction_enum_id = Faction_GetEnumID(factionid); 
	
	if (!factionid || faction_enum_id == INVALID_FACTION_ID || !IsInRadioFaction(playerid)) 
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction with a radio.");
	}

	new text[144], string[256];
	new channel = PlayerVar[playerid][E_PLAYER_PD_RADIO_CHANNEL];

	if (channel < 0 || channel >= MAX_CHANNELS)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Radio", "A3A3A3", "Your radio channel isn't set properly, type /channel to change it.");
	}

	if (!PlayerVar[playerid][E_PLAYER_FACTION_DUTY])
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Radio", "A3A3A3", "You must be on duty to use your faction radio.");
	}

	if (sscanf (params, "s[144]", text))
	{
		SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/r(adio) [message]" ) ;
		return true ;
	}

	format(string, sizeof(string), "** [CH %d: %s] %s #%05d: %s", channel, RadioChannels[channel][E_RADIO_CH_TAG], ReturnMixedName(playerid), Character[playerid][E_CHARACTER_FACTION_BADGE], text);
	
	new vehicleid;

	foreach(new targetid: Player) 
	{
		if (!IsPlayerPlaying(targetid)) continue;

		if (IsPlayerInAnyVehicle(targetid))
		{
			vehicleid = GetPlayerVehicleID(targetid);
			if (vehicleid && VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL])
			{
				if (VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL] == (channel + 1))
				{
					ZMsg_SendClientMessage(targetid, COLOR_POLICE, string);
				}
			}
		}

		if (!Character[targetid][E_CHARACTER_FACTIONID] || !PlayerVar[targetid][E_PLAYER_FACTION_DUTY]) continue;
		else if (!IsRadioMessageReceiver(playerid, targetid)) continue;

		if (PlayerVar[targetid][E_PLAYER_PD_RADIO_CHANNEL] == channel) 
		{
			// Brighter if on same channel
			ZMsg_SendClientMessage(targetid, 0xFFEC8BFF, string);
		} 
		else
		{
			ZMsg_SendClientMessage(targetid, 0xDFD6A6FF, string);
		}
	}

	format(string, sizeof(string), "[CH: %s] %s", RadioChannels[channel][E_RADIO_CH_TAG], text);
	SetPlayerChatBubble(playerid, string, 0xFFEC8BFF, 15.0, (strlen(text) * 50) + 2500);

	// NEW LOGGING: Log this as a LOG_TYPE_RADIO for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_RADIO, string);

	return true;
}

CMD:r(playerid, params[])
{
	return cmd_radio(playerid, params);
}	


CMD:department(playerid, params[]) 
{
	if ( IsPlayerIncapacitated(playerid, false) ) {
    
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	new text [ 144 ] ;

	if ( sscanf ( params, "s[144]", text ) ) {

		SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/dep(artment) [text]" ) ;
		return true ;
	}
	
	new string [ 256 ] ;
	new vehicleid;


	if ( IsPlayerInAnyGovFaction(playerid, true) ) {
		format ( string, sizeof ( string ),  "** [DEP] %s: %s", ReturnMixedName(playerid), text ) ;
	}
	else {
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a government faction.");
	}

	foreach(new targetid: Player) 
	{
		if ( IsPlayerInAnyGovFaction(targetid, true)) 
		{
			ZMsg_SendClientMessage(targetid, 0x88D0C5FF, string);
		}
		else
		{
			if (IsPlayerInAnyVehicle(playerid))
			{
				vehicleid = GetPlayerVehicleID(targetid);
				if (vehicleid && VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL])
				{
					if (VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL])
					{
						ZMsg_SendClientMessage(targetid, COLOR_POLICE, string);
					}
				}
			}
		}
	}

	// string [ 0 ] = EOS ;

	//format ( string, sizeof ( string ), "%s says (radio) %s", ReturnPlayerNameData ( playerid ), text ) ;
	//ProxDetector ( playerid,10.0, 0xA3A3A3FF, string) ;

	SetPlayerChatBubble(playerid, sprintf("[CH: DEP] %s", text), 0x88D0C5FF, 15.0, (strlen(text) * 50) + 2500) ;
	
	// NEW LOGGING: Log this as a LOG_TYPE_RADIO for sender (playerid)
	AddLogEntry(playerid, LOG_TYPE_RADIO, sprintf("[DEP/%s] %s", Faction[faction_enum_id][E_FACTION_ABBREV], text));

	return true ;
}

CMD:dep(playerid, params[]) return cmd_department(playerid, params);
CMD:d(playerid, params[]) return cmd_department(playerid, params);


CMD:hq(playerid, params[]) {
	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;

	if ( ! factionid ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not in a faction!");
	}

	if (!IsPlayerInDutyFaction(playerid)) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not on duty in a government faction.");

	new faction_enum_id = Faction_GetEnumID(factionid ); 

	if ( faction_enum_id == INVALID_FACTION_ID ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Error fetching faction enumerator ID! Contact a DEV.");
	}

	if ( Character [ playerid ] [ E_CHARACTER_FACTIONTIER ] > 2 ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have the correct privileges to perform this action.");
	}

	new input [ 144 ] ;

	if ( sscanf ( params, "s[144]", input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/hq [text]");
	}

	if ( strlen ( input ) > sizeof ( input ) ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("Your text can't be longer than %d characters.", sizeof ( input )));
	}

	new string [ 256 ] ;

	format ( string, sizeof ( string ), "{[ [%s/HQ] [ID %d] %s %s: %s ]}",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, Character [ playerid ] [ E_CHARACTER_FACTIONRANK ], ReturnSettingsName(playerid, playerid), input
	);

	Faction_SendMessage(factionid, string, faction_enum_id, true, true, .color=0xE86C00FF);

	return true ;
}

Scanner_Reset(vehicleid)
{
	VehicleVar[vehicleid][E_VEHICLE_SCANNER_CHANNEL] = 0;
}