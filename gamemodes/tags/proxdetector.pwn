
ProxDetectorEx(playerid, Float:max_range, color, const prefix[], const string[], showid = false, annonated=false, inverted=false, showtagcolor=false, autospacing=true, chat=false) 
{ // Prefix = shit that goes infront of the text. i.e. "** Hades starts his engine." => '** ' is the prefix
	
	new prox[256];
	if(annonated) {
		if(chat) format(prox, sizeof(prox), "%s", string);
		else format(prox, sizeof(prox), "> %s", string);

		// remove "says"
		if(strfind(prox, "says:", true) != -1) {
			strdel(prox, 0, 5);
		}

		SetPlayerChatBubble(playerid, prox, color, 7.5, 3000 + (strlen(string) * 60));
	}

	new Float:pos_x, Float:pos_y, Float:pos_z, Float:range, Float:range_ratio, Float:max_ratio = 1.6, Float:range_with_ratio = (max_range * max_ratio), final_color;
	new clr_r, clr_g, clr_b, Float:color_r = float(color >> 24 & 0xFF), Float:color_g = float(color >> 16 & 0xFF), Float:color_b = float(color >> 8 & 0xFF);

	if(!GetPlayerPos(playerid, pos_x, pos_y, pos_z)) return 0;
 
	foreach(new i: Player) {
		range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);

		if (range > max_range || GetPlayerInterior(i) != GetPlayerInterior(playerid) ||  GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid)) {
			continue ;
		}

		range_ratio = (range_with_ratio - range) / range_with_ratio;
		clr_r = floatround(range_ratio * color_r);
		clr_g = floatround(range_ratio * color_g);
		clr_b = floatround(range_ratio * color_b);
		final_color = (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24);

		if(strlen(prefix) < 1) {
			if(autospacing) {
				if(showid) format(prox, sizeof(prox), "(%d) %s{%06x} %s", playerid, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);
				else format(prox, sizeof(prox), "%s{%06x} %s", ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);

				if(inverted) {
					format(prox, sizeof(prox), "%s (( %s{%06x} ))", string, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8));
				}
			} else {
				if(showid) format(prox, sizeof(prox), "(%d) %s{%06x}%s", playerid, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);
				else format(prox, sizeof(prox), "%s{%06x}%s", ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);

				if(inverted) {
					format(prox, sizeof(prox), "%s (( %s{%06x} ))", string, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8));
				}
			}
		} else {
			if(autospacing) {
				if(showid) format(prox, sizeof(prox), "%s (%d) %s{%06x} %s", prefix, playerid, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);
				else format(prox, sizeof(prox), "%s %s{%06x} %s", prefix, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);

				if(inverted) {
					format(prox, sizeof(prox), "%s %s (( %s{%06x} )) %s", prefix, string, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8));
				}
			} else {
				if(showid) format(prox, sizeof(prox), "%s (%d) %s{%06x}%s", prefix, playerid, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);
				else format(prox, sizeof(prox), "%s %s{%06x}%s", prefix, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8), string);

				if(inverted) {
					format(prox, sizeof(prox), "%s %s (( %s{%06x} ))", prefix, string, ReturnSettingsName(playerid, i, showtagcolor), (final_color >>> 8));
				}
			}
		}

		ZMsg_SendClientMessage(i, final_color, prox);
	}
	return 1;
}

ProxDetectorXYZ(Float: pos_x, Float: pos_y, Float: pos_z, int, world, Float:max_range, color, const string[]) 
{ // If using on a vehicle, set "int" to 0. We don't have GetVehicleInterior (yet).

	new Float:range, Float:range_ratio, Float:max_ratio = 1.6, Float:range_with_ratio = (max_range * max_ratio) ;
	new clr_r, clr_g, clr_b, Float:color_r = float(color >> 24 & 0xFF), Float:color_g = float(color >> 16 & 0xFF), Float:color_b = float(color >> 8 & 0xFF);

	foreach (new i : Player) {

		range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);
		if (range > max_range || int != GetPlayerInterior(i) || world != GetPlayerVirtualWorld(i) ) {
			continue ;
		}

		range_ratio = (range_with_ratio - range) / range_with_ratio;
		clr_r = floatround(range_ratio * color_r);
		clr_g = floatround(range_ratio * color_g);
		clr_b = floatround(range_ratio * color_b);

		ZMsg_SendClientMessage(i, (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24), string);
	}

	return 1;
}
