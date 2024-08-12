//------------------------------------------------------------------------------
// Character Attributes/Sheets (with char creation integration)
// By Spooky (www.github.com/sporkyspork) for GTA Chronicles (www.gta-chronicles.com)

#include <YSI_Coding\y_hooks>

static CharAttDlgStr[1024];

enum E_ATTRIBUTE_EDIT_TYPES
{
    E_ATTRIBUTE_EDIT_TYPE_NUMBER,
    E_ATTRIBUTE_EDIT_TYPE_CHOOSE,
    E_ATTRIBUTE_EDIT_TYPE_INPUT
}

enum E_ATTRIBUTE_DATA
{
    E_ATTRIBUTE:E_ATTRIBUTE_INDEX,
    E_ATTRIBUTE_EDIT_TYPES:E_ATTRIBUTE_EDIT_TYPE,
    E_PLAYER_CHARACTER_DATA:E_ATTRIBUTE_PVAR,
    E_ATTRIBUTE_NAME[16],
    E_ATTRIBUTE_SQL_NAME[32],
    E_ATTRIBUTE_INFO[64],
    E_ATTRIBUTE_MIN,
    E_ATTRIBUTE_MAX,
    bool:E_ATTRIBUTE_EDITABLE,
    bool:E_ATTRIBUTE_MASKABLE,
    bool:E_ATTRIBUTE_VIEWABLE,
    bool:E_ATTRIBUTE_OPTIONAL
}

enum E_ATTRIBUTE_VALUE
{
    E_ATTRIBUTE:E_ATTRIBUTE_VALUE_ATTRIBUTE,
    E_ATTRIBUTE_VALUE_INDEX,
    E_ATTRIBUTE_VALUE_NAME[16],
    E_ATTRIBUTE_VALUE_ABBR[4],
    E_ATTRIBUTE_VALUE_COLOR
}

static const AttributeInfo[][E_ATTRIBUTE_DATA] = 
{
    { E_ATTRIBUTE_SEX, E_ATTRIBUTE_EDIT_TYPE_CHOOSE, E_CHARACTER_ATTRIB_SEX, "Sex", "player_attribute_sex", "the biological sex of the character", 0, 0, false, false },
    { E_ATTRIBUTE_AGE, E_ATTRIBUTE_EDIT_TYPE_NUMBER, E_CHARACTER_ATTRIB_AGE, "Age", "player_attribute_age", "the age of the character in years", 16, 80, false, true },
    { E_ATTRIBUTE_RACE, E_ATTRIBUTE_EDIT_TYPE_CHOOSE, E_CHARACTER_ATTRIB_RACE, "Ethnicity", "player_attribute_race", "the racial ethnicity of the character", 0, 0, false, false },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_EDIT_TYPE_CHOOSE, E_CHARACTER_ATTRIB_HAIR, "Hair", "player_attribute_hair", "the character's hair color", 0, 0, true, true },
    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EDIT_TYPE_CHOOSE, E_CHARACTER_ATTRIB_EYES, "Eyes", "player_attribute_eyes", "the character's eye color", 0, 0, true, false },
    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_EDIT_TYPE_CHOOSE, E_CHARACTER_ATTRIB_BODY, "Build", "player_attribute_body", "the character's body build type", 0, 0, true, false },
    { E_ATTRIBUTE_HEIGHT, E_ATTRIBUTE_EDIT_TYPE_NUMBER, E_CHARACTER_ATTRIB_HEIGHT, "Height", "player_attribute_height", "the character's height", 140, 200, false, false },
    { E_ATTRIBUTE_DESC, E_ATTRIBUTE_EDIT_TYPE_INPUT, E_CHARACTER_ATTRIB_DESC, "Description", "player_attribute_desc", "custom descriptive text", 0, 0, true, true, true, true }
};


static const AttributeValues[][E_ATTRIBUTE_VALUE] = 
{
    { E_ATTRIBUTE_SEX, E_ATTRIBUTE_SEX_MALE, "Male", "M", 0x81D4FA },
    { E_ATTRIBUTE_SEX, E_ATTRIBUTE_SEX_FEMALE, "Female", "F", 0xF8BBD0 },

    { E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_WHITE, "White", "WHI", 0xfcdcd2 },
    { E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_BLACK, "Black", "BLK", 0xcda184 },
    { E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_LATIN, "Latino", "LAT", 0xdbb288 },
    { E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_ASIAN, "Asian", "ASN", 0xf9dcb2 },

    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_BALD, "None", "BLD", 0xADBEE6 },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_BLACK, "Black", "BLK", 0x5a5a64 },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_BROWN, "Brown", "BRN", 0xBCAAA4 },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_BLONDE, "Blonde", "BLN", 0xffe19d },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_WHITE, "White", "WHI", 0xF5F5F5 },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_GRAY, "Gray", "GRY", 0xE0E0E0 },
    { E_ATTRIBUTE_HAIR, E_ATTRIBUTE_HAIR_RED, "Red", "RED", 0xFFAB91 },

    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EYES_AMBER, "Amber", "AMB",  0xFFE082 },
    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EYES_BLUE, "Blue", "BLU", 0x9FA8DA },
    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EYES_BROWN, "Brown", "BRN", 0xBCAAA4 },
    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EYES_GRAY, "Gray", "GRY", 0xB0BEC5 },
    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EYES_GREEN, "Green", "GRE", 0xB9E6B9 },
    { E_ATTRIBUTE_EYES, E_ATTRIBUTE_EYES_HAZEL, "Hazel", "HAZ", 0xEEC99C },

    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_BODY_SKINNY, "Skinny", "SKI", 0xE3F2FD },
    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_BODY_SLIM, "Slim", "SLI", 0xECEFF1 },
    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_BODY_AVERAGE, "Normal", "NRM",  0xF5F5F5 },
    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_BODY_PLUMP, "Plump", "PLP", 0xFBE9E7 },
    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_BODY_OBESE, "Obese", "OBE", 0xEFEBE9 },
    { E_ATTRIBUTE_BODY, E_ATTRIBUTE_BODY_MUSCULAR, "Muscular", "MSC", 0xFFF8E1 }
};

ReturnAttributeValueStr(playerid, E_ATTRIBUTE:attribute, bool:colored=true)
{
    new attrib_enum_id = GetAttributeEnumImdex(attribute);

    new str[40] = "None";
    new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR];
    new E_ATTRIBUTE_EDIT_TYPES:type = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_EDIT_TYPE];

    // Unset override
    if (type != E_ATTRIBUTE_EDIT_TYPE_INPUT && !Character[playerid][pvar])
    {
        format(str, sizeof(str), "%s", "Select...");
        return str;
    }

    // Mask override.
    if (AttributeInfo[attrib_enum_id][E_ATTRIBUTE_MASKABLE] && PlayerVar[playerid][E_PLAYER_IS_MASKED])
    {
        format(str, sizeof(str), "%s", "{707070}Hidden");
        return str;
    }

    if (type == E_ATTRIBUTE_EDIT_TYPE_CHOOSE)
    {
        for (new i = 0; i < sizeof(AttributeValues); i ++)
        {
            if (AttributeValues[i][E_ATTRIBUTE_VALUE_ATTRIBUTE] == attribute && AttributeValues[i][E_ATTRIBUTE_VALUE_INDEX] == Character[playerid][pvar])
            {
                if (colored && AttributeValues[i][E_ATTRIBUTE_VALUE_COLOR] && attribute != E_ATTRIBUTE_BODY) format(str, sizeof(str), "{%06x}%s", AttributeValues[i][E_ATTRIBUTE_VALUE_COLOR], AttributeValues[i][E_ATTRIBUTE_VALUE_NAME]);
                else if (colored) format(str, sizeof(str), "{FFFFFF}%s", AttributeValues[i][E_ATTRIBUTE_VALUE_NAME]);
                else format(str, sizeof(str), "%s", AttributeValues[i][E_ATTRIBUTE_VALUE_NAME]);
                
                return str;
            }
        }
    }
    else if (type == E_ATTRIBUTE_EDIT_TYPE_INPUT)
    {
        new len = strlen(Character[playerid][pvar]);
        
        if (len)
        {
            if (len < 32) format(str, sizeof(str), "%s", Character[playerid][pvar]);
            else format(str, sizeof(str), "%.28s...", Character[playerid][pvar]);
        }
        else
        {
            format(str, sizeof(str), "%s", "None");
        }

        if (colored) format(str, sizeof(str), "{FFFFFF}%s", str);
        return str;
    }
    else if (type == E_ATTRIBUTE_EDIT_TYPE_NUMBER)
    {
        if (colored) format(str, sizeof(str), "{FFFFFF}%d", Character[playerid][pvar]);
        else format(str, sizeof(str), "%d", Character[playerid][pvar]);

        if (attribute == E_ATTRIBUTE_HEIGHT)
        {
            new cm = Character[playerid][pvar];
            new inches = floatround(cm / 2.54);
            new feet = inches / 12;
            new leftover = inches % 12;

            if (colored) format(str, sizeof(str), "{FFFFFF}%d'%d\" (%dcm)", feet, leftover, cm);
            else format(str, sizeof(str), "%d'%d\" (%dcm)", feet, leftover, cm);
            
        }
        
        return str;
    }

    return str;
}

ReturnAttributeAbbrStr(playerid, E_ATTRIBUTE:attribute)
{
    new attrib_enum_id = GetAttributeEnumImdex(attribute);
    new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR];

    new str[4] = "NON";

    for (new i = 0; i < sizeof(AttributeValues); i ++) 
    {
        if (AttributeValues[i][E_ATTRIBUTE_VALUE_ATTRIBUTE] == attribute && AttributeValues[i][E_ATTRIBUTE_VALUE_INDEX] == Character[playerid][pvar])
        {
            format(str, sizeof(str), "%s", AttributeValues[i][E_ATTRIBUTE_VALUE_ABBR]);
            return str;
        }
    }

    return str;
}

static CharAttQueryStr[256];

static GetAttributeEnumImdex(E_ATTRIBUTE:attribute)
{
    /*
    for (new i = 0; i < sizeof(AttributeInfo); i ++)
    {
        if (AttributeInfo[i][E_ATTRIBUTE_INDEX] == attribute)
        {
            return i;
        }
    }
    */

    // They align perfectly atm so no need to do the above loop
    return _:attribute;
}

SOLS_SetPlayerAttribute(playerid, E_ATTRIBUTE:attribute, value)
{
    new attrib_enum_id = GetAttributeEnumImdex(attribute);

    Character[playerid][AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR]] = value;
    mysql_format(mysql, CharAttQueryStr, sizeof(CharAttQueryStr), "UPDATE characters SET %s = %d WHERE player_id = %d", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_SQL_NAME], Character[playerid][AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR]], Character[playerid][E_CHARACTER_ID]);
    mysql_tquery(mysql, CharAttQueryStr, "", "");
    // print(CharAttQueryStr);
}

SOLS_SetPlayerAttributeText(playerid, E_ATTRIBUTE:attribute, const value[], length)
{
    new attrib_enum_id = GetAttributeEnumImdex(attribute);

    format(Character[playerid][AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR]], length, "%s", value);
    mysql_format(mysql, CharAttQueryStr, sizeof(CharAttQueryStr), "UPDATE characters SET %s = '%e' WHERE player_id = %d", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_SQL_NAME], Character[playerid][AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR]], Character[playerid][E_CHARACTER_ID]);
    mysql_tquery(mysql, CharAttQueryStr, "", "");
    // print(CharAttQueryStr);
}

static EditCharacterAttribute(playerid, targetid, E_ATTRIBUTE:attribute)
{
    new attrib_enum_id = GetAttributeEnumImdex(attribute);
    new title[64];

    CharAttDlgStr[0] = EOS;
    format(title, sizeof(title), "Editing Character %s", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME]);
    new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR];

    if (playerid == targetid)
    {
        if (!AttributeInfo[attrib_enum_id][E_ATTRIBUTE_EDITABLE] && !PlayerVar[targetid][E_PLAYER_CREATING_CHAR] && !PlayerVar[targetid][E_PLAYER_ATTRIBS_EDITABLE] && Character[targetid][pvar])
        {
            inline DlgNoEditAttribute(pid, dialogid, response, listitem, string: inputtext[]) 
            {
                #pragma unused pid, dialogid, response, listitem, inputtext
                return ShowPlayerAttributesMenu(playerid, targetid);
            }

            format(CharAttDlgStr, sizeof(CharAttDlgStr), "{FF0000}You can't change your character's %s without admin permission.", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME]);
            return Dialog_ShowCallback(playerid, using inline DlgNoEditAttribute, DIALOG_STYLE_MSGBOX, title, CharAttDlgStr, "OK");
        }
    }

    
    new E_ATTRIBUTE_EDIT_TYPES:type = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_EDIT_TYPE];

    if (type == E_ATTRIBUTE_EDIT_TYPE_CHOOSE)
    {
        for (new i = 0; i < sizeof(AttributeValues); i ++)
        {
            if (AttributeValues[i][E_ATTRIBUTE_VALUE_ATTRIBUTE] == attribute)
            {
                format(CharAttDlgStr, sizeof(CharAttDlgStr), "%s%s\n", CharAttDlgStr, AttributeValues[i][E_ATTRIBUTE_VALUE_NAME]);
            }
        }

        inline DlgEditAttributeChoose(pid, dialogid, response, listitem, string: inputtext[]) 
        {
            #pragma unused pid, dialogid, response, listitem, inputtext
            
            if (response)
            {
                SOLS_SetPlayerAttribute(targetid, attribute, listitem + 1);   
            }   
               
            return ShowPlayerAttributesMenu(playerid, targetid);
        }

        format(title, sizeof(title), "Select Character %s", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME]);
        return Dialog_ShowCallback(playerid, using inline DlgEditAttributeChoose, DIALOG_STYLE_LIST, title, CharAttDlgStr, "Select", "Back");
    }
    else if (type == E_ATTRIBUTE_EDIT_TYPE_INPUT)
    {
        inline DlgEditAttributeInput(pid, dialogid, response, listitem, string: inputtext[]) 
        {
            #pragma unused pid, dialogid, response, listitem, inputtext
            
            if (response)
            {
                SOLS_SetPlayerAttributeText(targetid, attribute, inputtext, 128);   
            }   
               
            return ShowPlayerAttributesMenu(playerid, targetid);
        }

        format(title, sizeof(title), "Edit Character %s", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME]);
        return Dialog_ShowCallback(playerid, using inline DlgEditAttributeInput, DIALOG_STYLE_INPUT, title, "You can enter a short line of custom descriptive text here.", "OK", "Back");
    }
    else if (type == E_ATTRIBUTE_EDIT_TYPE_NUMBER)
    {
        new minn = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_MIN];
        new maxx = AttributeInfo[attrib_enum_id][E_ATTRIBUTE_MAX];

        for (new i = minn; i < maxx; i ++)
        {
            if (attribute == E_ATTRIBUTE_HEIGHT)
            {
                new cm = i;
                new inches = floatround(cm / 2.54);
                new feet = inches / 12;
                new leftover = inches % 12;

                format(CharAttDlgStr, sizeof(CharAttDlgStr), "%s%dcm (%d'%d\")\n", CharAttDlgStr, cm, feet, leftover);
            }
            else
            {
                format(CharAttDlgStr, sizeof(CharAttDlgStr), "%s%d\n", CharAttDlgStr, i);
            }
        }

        inline DlgEditAttributeNumber(pid, dialogid, response, listitem, string: inputtext[]) 
        {
            #pragma unused pid, dialogid, response, listitem, inputtext
            
            if (response)
            {
                SOLS_SetPlayerAttribute(targetid, attribute, minn + listitem);   
            }   
               
            return ShowPlayerAttributesMenu(playerid, targetid);
        }

        format(title, sizeof(title), "Select Character %s", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME]);
        return Dialog_ShowCallback(playerid, using inline DlgEditAttributeNumber, DIALOG_STYLE_LIST, title, CharAttDlgStr, "Select", "Back");
    }

    return true;
}

ShowAttributeEditor(playerid, targetid, E_ATTRIBUTE:attribute)
{
    new bool:editing = false; // TODO: Or admin cmd?
    if (playerid == targetid) editing = true;

    if (editing)
    {
        EditCharacterAttribute(playerid, targetid, attribute);
    }
    else
    {
        ViewCharacterAttribute(playerid, targetid, attribute);
    }
    
    return true;
}

static FinishEditingAttributes(playerid, targetid)
{
    #pragma unused targetid
    new count;

    // Either a confirmation dialog or a warning dialog
    for (new i = 0; i < sizeof(AttributeInfo); i ++)
    {
        //new E_ATTRIBUTE:attribute = AttributeInfo[i][E_ATTRIBUTE_INDEX];
        new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[i][E_ATTRIBUTE_PVAR];

        if (!AttributeInfo[i][E_ATTRIBUTE_OPTIONAL] && !Character[playerid][pvar])
        {
            count ++;
        }
    }

    if (count)
    {
        inline DlgAttributesWarn(pid, dialogid, response, listitem, string:inputtext[]) 
        { 
		    #pragma unused pid, dialogid, response, listitem, inputtext
            SOLS_ShowPlayerAttributes(playerid, playerid); // back to editor
        }

        CharAttDlgStr[0] = EOS;

        strcat(CharAttDlgStr, sprintf("{FFFFFF}Sorry, there was a problem saving the character profile of {5DB6E5}%s{FFFFFF}.", ReturnMixedName(playerid)));
        
        if (count == 1) strcat(CharAttDlgStr, sprintf("\n\n{FFFFFF}%d required field wasn't completed:{ADBEE6}", count));
        else strcat(CharAttDlgStr, sprintf("\n\n{FFFFFF}%d required fields weren't completed:{ADBEE6}", count));
        
        for (new x = 0; x < sizeof(AttributeInfo); x ++)
        {
            new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[x][E_ATTRIBUTE_PVAR];

            if (!AttributeInfo[x][E_ATTRIBUTE_OPTIONAL] && !Character[playerid][pvar])
            {
                strcat(CharAttDlgStr, sprintf("\n- %s", AttributeInfo[x][E_ATTRIBUTE_NAME]));
            }
        }

        strcat(CharAttDlgStr, "\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to go back to the editor and complete the profile.");
        Dialog_ShowCallback ( playerid, using inline DlgAttributesWarn, DIALOG_STYLE_MSGBOX, "Confirm Character Profile", CharAttDlgStr, "OK");
    }
    else
    {
        if (!PlayerVar[playerid][E_PLAYER_CREATING_CHAR] && !PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE])
        {
            CallLocalFunction("SOLS_OnEditAttributes", "d", playerid);
            return true;
        }

        // Only show the dialog confirmation if they are doing it for the first time
        inline DlgAttributesConfirm(pid, dialogid, response, listitem, string:inputtext[]) 
        { 
		    #pragma unused pid, dialogid, response, listitem, inputtext

            if (response)
            {
                // Then fire this
                CallLocalFunction("SOLS_OnEditAttributes", "d", playerid);
            } 
            else
            {
                SOLS_ShowPlayerAttributes(playerid, playerid); // back to editor
            }  
        }

        CharAttDlgStr[0] = EOS;
        strcat(CharAttDlgStr, sprintf("{FFFFFF}You are about to save the character profile of {5DB6E5}%s{FFFFFF}.", ReturnMixedName(playerid)));

        strcat(CharAttDlgStr, "\n\n{FFFFFF}Please confirm the following is correct:");

        for (new x = 0; x < sizeof(AttributeInfo); x ++)
        {
            new E_ATTRIBUTE:attribute = AttributeInfo[x][E_ATTRIBUTE_INDEX];
            //new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[x][E_ATTRIBUTE_PVAR];

            if (AttributeInfo[x][E_ATTRIBUTE_EDITABLE]) strcat(CharAttDlgStr, sprintf("\n{ADBEE6}- %s: %s", AttributeInfo[x][E_ATTRIBUTE_NAME], ReturnAttributeValueStr(playerid, attribute)));
            else strcat(CharAttDlgStr, sprintf("\n{ADBEE6}- %s: %s {EF9A9A}*", AttributeInfo[x][E_ATTRIBUTE_NAME], ReturnAttributeValueStr(playerid, attribute)));
        }

        strcat(CharAttDlgStr, "\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to continue or {AA3333}Back{FFFFFF} to go back to the editor.");
        strcat(CharAttDlgStr, "\n{EF9A9A}* {ADBEE6}Cannot be changed later without a character reset.");
        
        Dialog_ShowCallback ( playerid, using inline DlgAttributesConfirm, DIALOG_STYLE_MSGBOX, "Confirm Character Profile", CharAttDlgStr, "OK", "Back" );
    }

    return true;
}

static ViewCharacterAttribute(playerid, targetid, E_ATTRIBUTE:attribute)
{
    new attrib_enum_id = GetAttributeEnumImdex(attribute);

    if (!AttributeInfo[attrib_enum_id][E_ATTRIBUTE_VIEWABLE])
    {
        // Just go back.
        return ShowPlayerAttributesMenu(playerid, targetid);
    }

    new title[64];
    format(title, sizeof(title), "%s of %s", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME], ReturnMixedName(targetid));

    if (AttributeInfo[attrib_enum_id][E_ATTRIBUTE_EDIT_TYPE] == E_ATTRIBUTE_EDIT_TYPE_INPUT)
    {
        format(CharAttDlgStr, sizeof(CharAttDlgStr), "%s", Character[targetid][AttributeInfo[attrib_enum_id][E_ATTRIBUTE_PVAR]]);
    }
    else
    {
        format(CharAttDlgStr, sizeof(CharAttDlgStr), "%s", ReturnAttributeValueStr(targetid, attribute, true));
    }

    inline DlgViewAttribute(pid, dialogid, response, listitem, string: inputtext[]) 
    {
        #pragma unused pid, dialogid, response, listitem, inputtext

        if (!response || PlayerVar[targetid][E_PLAYER_IS_MASKED])
        {
            return ShowPlayerAttributesMenu(playerid, targetid);
        }
    }
    
    if (AttributeInfo[attrib_enum_id][E_ATTRIBUTE_MASKABLE] && PlayerVar[targetid][E_PLAYER_IS_MASKED])
    {
        // Special mask behavior
        format(CharAttDlgStr, sizeof(CharAttDlgStr), "You cannot view the %s of %s because they are masked.", AttributeInfo[attrib_enum_id][E_ATTRIBUTE_NAME], ReturnMixedName(targetid));
        return Dialog_ShowCallback(playerid, using inline DlgViewAttribute, DIALOG_STYLE_MSGBOX, title, CharAttDlgStr, "OK");
    }

    return Dialog_ShowCallback(playerid, using inline DlgViewAttribute, DIALOG_STYLE_MSGBOX, title, CharAttDlgStr, "OK", "Back");
}

static ShowPlayerAttributesMenu(playerid, targetid)
{
    format(CharAttDlgStr, sizeof(CharAttDlgStr), "Attribute\tValue");
    new title[128];

    for (new i = 0; i < sizeof(AttributeInfo); i ++)
    {
        format(CharAttDlgStr, sizeof(CharAttDlgStr), "%s\n%s\t%s", CharAttDlgStr, AttributeInfo[i][E_ATTRIBUTE_NAME], ReturnAttributeValueStr(targetid, AttributeInfo[i][E_ATTRIBUTE_INDEX]));
    }

    inline DlgEditAttributes(pid, dialogid, response, listitem, string: inputtext[]) 
    {
 		#pragma unused pid, dialogid, response, listitem, inputtext

        if (!response)
        {
            // Canceled
            if (playerid == targetid && (PlayerVar[targetid][E_PLAYER_CREATING_CHAR] || PlayerVar[targetid][E_PLAYER_ATTRIBS_EDITABLE]))
            {
                FinishEditingAttributes(playerid, targetid);
            }
            
            return true;
        }
        
 		if (response && listitem >= 0 && listitem < _:E_ATTRIBUTE) 
        {
            ShowAttributeEditor(playerid, targetid, E_ATTRIBUTE:listitem);
 			return true;
 		}

        return false;
    }

    format(title, sizeof(title), "%s", ReturnMixedName(targetid));

    Dialog_ShowCallback(playerid, using inline DlgEditAttributes, DIALOG_STYLE_TABLIST_HEADERS, title, CharAttDlgStr, targetid == playerid ? "Edit" : "View", (PlayerVar[playerid][E_PLAYER_CREATING_CHAR] || PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE]) ? "Finish" : "Back" );
    return true;
}

CMD:myattributes(playerid, params[])
{
    if (!IsPlayerPlaying(playerid)) return true;

    ShowPlayerAttributesMenu(playerid, playerid);
    return true;
}

CMD:myappearance(playerid, params[])
{
    return cmd_myattributes(playerid, params);
}

CMD:myprofile(playerid, params[])
{
    return cmd_myattributes(playerid, params);
}

CMD:attributes(playerid, params[])
{
    if (!IsPlayerPlaying(playerid)) return true;
    new targetid;

    if (sscanf(params, "k<player>", targetid) || !IsPlayerConnected(targetid) || !IsPlayerPlaying(targetid))
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/attributes [player]");
    }

    if (!IsPlayerNearPlayer(playerid, targetid, 7.5))
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "You are not near this player.");
    }

    if (playerid != targetid)
    {
        new count = 0;

        for (new i = 0; i < sizeof(AttributeInfo); i ++)
        {
            if (!AttributeInfo[i][E_ATTRIBUTE_OPTIONAL] && !Character[targetid][AttributeInfo[i][E_ATTRIBUTE_PVAR]])
            {
                count ++;
            }
        }

        if (count || PlayerVar[targetid][E_PLAYER_ATTRIBS_EDITABLE])
        {
            return SendServerMessage(playerid, COLOR_ERROR, "Error", "DEDEDE", "This player has not completed their character profile.");
        }
    }

    ShowPlayerAttributesMenu(playerid, targetid);
    return true;
}

CMD:examine(playerid, params[])
{
    return cmd_attributes(playerid, params);
}

CMD:profile(playerid, params[])
{
    return cmd_attributes(playerid, params);
}

CMD:appearance(playerid, params[])
{
    return cmd_attributes(playerid, params);
}

CMD:viewattributes(playerid, params[])
{
    return cmd_attributes(playerid, params);
}

CMD:viewappearance(playerid, params[])
{
    return cmd_attributes(playerid, params);
}

SOLS_ResetPlayerAttributes(playerid)
{
    for (new i = 0; i < sizeof(AttributeInfo); i ++)
    {
        //new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[i][E_ATTRIBUTE_PVAR];
        new E_ATTRIBUTE:attribute = AttributeInfo[i][E_ATTRIBUTE_INDEX];

        if (AttributeInfo[i][E_ATTRIBUTE_EDIT_TYPE] == E_ATTRIBUTE_EDIT_TYPE_INPUT)
        {
            SOLS_SetPlayerAttributeText(playerid, attribute, "None", 128);
        }
        else
        {
            SOLS_SetPlayerAttribute(playerid, attribute, 0);
        }
    }
}

CMD:resetattributes(playerid, params[])
{
    if (GetPlayerAdminLevel ( playerid ) < 1 && Account [ playerid ] [ E_PLAYER_ACCOUNT_SUPPORTER ] < 2) 
    {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new targetid;

    if (sscanf(params, "k<player>", targetid) || !IsPlayerConnected(targetid) || !IsPlayerPlaying(targetid))
    {
        return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/resetattributes [player]");
    }

    PlayerVar[targetid][E_PLAYER_ATTRIBS_EDITABLE] = true;
    SOLS_ResetPlayerAttributes(targetid);

    SendServerMessage(targetid, COLOR_INFO, "Attributes", "A3A3A3", sprintf("Your character attributes were reset by %s. Type {FFFFFF}/myattributes{A3A3A3} to edit them again.", ReturnSettingsName(playerid, targetid, false)));
	SendAdminMessage(sprintf("[!!!][AdmWarn] Admin %s has reset the character attributes of (%d) %s.", Account[playerid][E_PLAYER_ACCOUNT_NAME], targetid, ReturnMixedName(targetid)));
    AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Reset the character attributes of %s", ReturnSettingsName(targetid, playerid, false)));
    AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("Had their character attributes reset by %s", ReturnSettingsName(playerid, targetid, false)));

    return true;
}

CMD:setattribute(playerid, params[])
{
    if (GetPlayerAdminLevel(playerid) < 2) 
    {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new targetid = INVALID_PLAYER_ID, option[16], value = -1;
    sscanf(params, "rs[16]d", targetid, option, value);

    // Find out what specific attribute they want
	new attribute = -1;

    if (IsPlayerConnected(targetid) && IsPlayerPlaying(targetid) && value >= 0 && strlen(option))
    {
        for ( new i, j = sizeof ( AttributeInfo ); i < j ; i ++ ) 
        {
            if (strlen(AttributeInfo[i][E_ATTRIBUTE_NAME]) && !strcmp(AttributeInfo[i][E_ATTRIBUTE_NAME], option, true)) 
            {
                attribute = i;
                break;
            }
        }
    }

	if (attribute >= 0 && attribute < sizeof(AttributeInfo))
	{
		SOLS_SetPlayerAttribute(targetid, AttributeInfo[attribute][E_ATTRIBUTE_INDEX], value);

        AddLogEntry(playerid, LOG_TYPE_ADMIN, sprintf("Set the %s of %s to %d", AttributeInfo[attribute][E_ATTRIBUTE_NAME], ReturnSettingsName(targetid, playerid, false), value));
        AddLogEntry(targetid, LOG_TYPE_ADMIN, sprintf("Had their %s set to %d by %s", AttributeInfo[attribute][E_ATTRIBUTE_NAME], value, ReturnSettingsName(playerid, targetid, false)));

        SendServerMessage(targetid, COLOR_INFO, "Attributes", "A3A3A3", sprintf("Your character's %s attribute was changed by (%d) %s.", AttributeInfo[attribute][E_ATTRIBUTE_NAME], playerid, ReturnSettingsName(playerid, targetid, false)));
	    SendAdminMessage(sprintf("[!!!][AdmWarn] Admin %s has set the %s of (%d) %s to %d.", Account[playerid][E_PLAYER_ACCOUNT_NAME], AttributeInfo[attribute][E_ATTRIBUTE_NAME], targetid, ReturnMixedName(targetid), value));

        return true;
	}

    // Otherwise show help text

    new helpstr[128];
	format(helpstr, sizeof(helpstr), "Available Attributes: ");
	new index = 0;

	for ( new i, j = sizeof ( AttributeInfo ); i < j ; i ++ ) 
	{
		if (AttributeInfo[i][E_ATTRIBUTE_EDIT_TYPE] != E_ATTRIBUTE_EDIT_TYPE_INPUT)
		{
			if (index) strcat(helpstr, ", ");
			format(helpstr, sizeof(helpstr), "%s\"%s\"", helpstr, AttributeInfo[i][E_ATTRIBUTE_NAME]);
			index ++;
		}
	}

	SendServerMessage ( playerid, COLOR_ERROR, "Syntax", "A3A3A3", helpstr ) ;
    return SendServerMessage(playerid, COLOR_ERROR, "Syntax", "A3A3A3", "/setattribute [Player ID] [attribute] [value]");
}


forward SOLS_OnEditAttributes(playerid);
public SOLS_OnEditAttributes(playerid)
{
    // This is hookable, called when a player closes their own attributes box (regardless of whether they changed it or not)
    // It's mainly used for char creation

    // Prevents them from changing normally non-editable fields
    PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE] = false;
    return 1;
}
    

// Public func
SOLS_ShowPlayerAttributes(playerid, targetid)
{
    ShowPlayerAttributesMenu(playerid, targetid);
}

hook SOLS_OnCharacterSpawn(playerid, isrespawn)
{
    if (isrespawn) return 1;

    new count = 0, skin = GetPlayerSkin(playerid);

    for (new i = 0; i < sizeof(AttributeInfo); i ++)
    {
        new E_PLAYER_CHARACTER_DATA:pvar = AttributeInfo[i][E_ATTRIBUTE_PVAR];
        new E_ATTRIBUTE:attribute = AttributeInfo[i][E_ATTRIBUTE_INDEX];

        if (!Character[playerid][pvar])
        {
            if (attribute == E_ATTRIBUTE_SEX)
            {
                // Set this from the skin.
                SOLS_SetPlayerAttribute(playerid, E_ATTRIBUTE_SEX, GetSkinGender(skin) == SKIN_GENDER_FEMALE ? E_ATTRIBUTE_SEX_FEMALE : E_ATTRIBUTE_SEX_MALE);
                continue;
            }

            if (attribute == E_ATTRIBUTE_RACE)
            {
                // Also set this from the skin.
                new race = GetSkinRace(skin);

                if (race == SKIN_RACE_BLACK) SOLS_SetPlayerAttribute(playerid, E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_BLACK);
                else if (race == SKIN_RACE_LATIN) SOLS_SetPlayerAttribute(playerid, E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_LATIN);
                else if (race == SKIN_RACE_ASIAN) SOLS_SetPlayerAttribute(playerid, E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_ASIAN);
                else SOLS_SetPlayerAttribute(playerid, E_ATTRIBUTE_RACE, E_ATTRIBUTE_RACE_WHITE);

                continue;
            }

            if (!AttributeInfo[i][E_ATTRIBUTE_OPTIONAL])
            {
                count ++;
            }
        }
    }

    // Nag them to complete their attributes
    if (count == 1) SendServerMessage(playerid, COLOR_INFO, "Attributes", "A3A3A3", sprintf("You have %d unset Character Attribute, type {FFFFFF}/myattributes{A3A3A3} to edit it.", count));
    else if (count) SendServerMessage(playerid, COLOR_INFO, "Attributes", "A3A3A3", sprintf("You have %d unset Character Attributes, type {FFFFFF}/myattributes{A3A3A3} to edit them.", count));

    if (count)
    {
        // Allows them to change normally non-editable fields
        PlayerVar[playerid][E_PLAYER_ATTRIBS_EDITABLE] = true;
    }

    return 1;
}