/*

	About: Multi-line message system
	Author: ziggi
	Removed hooks on 25/11/20 by Dignity 

*/

#if !defined _samp_included
	#error Please include a_samp before zmessage
#endif

#if defined _zmsg_included
	#endinput
#endif

#define _zmsg_included

/*
	Defines
*/

#if !defined ZMSG_MAX_CHAT_LENGTH
	#define ZMSG_MAX_CHAT_LENGTH MAX_CHATBUBBLE_LENGTH
#endif

#if !defined ZMSG_MAX_PLAYER_CHAT_LENGTH
	#define ZMSG_MAX_PLAYER_CHAT_LENGTH (MAX_CHATBUBBLE_LENGTH / 2)
#endif

#if !defined ZMSG_SEPARATORS_LIST
	#define ZMSG_SEPARATORS_LIST ' '
#endif

#if !defined ZMSG_HYPHEN_END
	#define ZMSG_HYPHEN_END   " ..."
#endif

#if !defined ZMSG_HYPHEN_START
	#define ZMSG_HYPHEN_START "... "
#endif

/*
	Vars
*/

static const
	g_zmsg_HyphenEnd[] = ZMSG_HYPHEN_END,
	g_zmsg_HyphenEndLength = sizeof(g_zmsg_HyphenEnd) - 1,
	g_zmsg_HyphenStart[] = ZMSG_HYPHEN_START,
	g_zmsg_HyphenStartLength = sizeof(g_zmsg_HyphenStart) - 1;

/*
	Functions
*/

stock ZMsg_GetMessages(message[], array[][], const lines = sizeof(array), const line_size = sizeof(array[]))
{
	new length = strlen(message);

	// shouldn't be shifted
	if (length <= line_size) {
		array[0][0] = '\0';
		strcat(array[0], message, line_size);
		return 1;
	}

	new
		bool:is_packed,
		last_color = -1,
		start_pos,
		end_pos,
		line;

	is_packed = message{0} != 0;

	while (end_pos < length && line < lines) {
		Zmsg_MakeString(array[line], line_size, message, is_packed, last_color, length, line,
		                start_pos, end_pos, g_zmsg_HyphenStart, g_zmsg_HyphenStartLength,
		                g_zmsg_HyphenEnd, g_zmsg_HyphenEndLength);
		line++;
	}
	return line;
}

static stock Zmsg_ShiftStartPos(const message[], const pos, const bool:is_packed, const size = sizeof(message))
{
	new result_pos = pos;

	if (is_packed) {
		while (result_pos < size) {
			switch (message{result_pos}) {
				case ZMSG_SEPARATORS_LIST: {
					result_pos++;
				}
				default: {
					break;
				}
			}
		}
	} else {
		while (result_pos < size) {
			switch (message[result_pos]) {
				case ZMSG_SEPARATORS_LIST: {
					result_pos++;
				}
				default: {
					break;
				}
			}
		}
	}
	return result_pos == size ? pos : result_pos;
}

static stock Zmsg_ShiftEndPos(const message[], const pos, const bool:is_packed)
{
	new result_pos = pos;

	if (is_packed) {
		while (result_pos > 0) {
			switch (message{result_pos}) {
				case ZMSG_SEPARATORS_LIST: {
					break;
				}
				default: {
					result_pos--;
				}
			}
		}
	} else {
		while (result_pos > 0) {
			switch (message[result_pos]) {
				case ZMSG_SEPARATORS_LIST: {
					break;
				}
				default: {
					result_pos--;
				}
			}
		}
	}
	return result_pos == 0 ? pos : result_pos;
}

static stock Zmsg_MakeString(dest[], const size = sizeof(dest), const src[],
	const bool:is_packed, &last_color, const length, const line, &spos, &epos,
	const prefix[], const prefix_length, const postfix[], const postfix_length)
{
	static
		temp[ZMSG_MAX_CHAT_LENGTH + 1];

	dest[0] = '\0';

	// get pos
	spos = Zmsg_ShiftStartPos(src, epos, is_packed, length);
	epos = spos + size - postfix_length - (last_color != -1 ? 8 : 0);

	if (line != 0) {
		epos -= prefix_length;
	}

	if (epos >= length) {
		epos = length;
	} else {
		new shift_epos = Zmsg_ShiftEndPos(src, epos, is_packed);
		if (shift_epos > spos) {
			epos = shift_epos;
		}
	}

	// prefix and color
	if (line != 0) {
		// find and copy color
		for (new i = spos; i != last_color; i--) {
			if (src[i] == '}' && i - 7 >= 0 && src[i - 7] == '{') {
				strmid(dest, src, i - 7, i + 1, size);
				last_color = i - 1;
				break;
			}
		}

		// copy prefix
		strcat(dest, prefix, size);
	}

	// source
	strmid(temp, src, spos, epos);
	if (is_packed) {
		temp{epos - spos} = '\0';
	}
	strcat(dest, temp, size);

	// postfix
	if (epos != length) {
		strcat(dest, postfix, size);
	}
}

/*
	SendClientMessage
*/

stock ZMsg_SendClientMessage(playerid, color, const message[]) {

	new length = strlen(message);

	// shouldn't be shifted
	if (length <= ZMSG_MAX_CHAT_LENGTH) {
		return SendClientMessage(playerid, color, message);
	}

	new
		bool:is_packed,
		last_color = -1,
		result,
		temp[ZMSG_MAX_CHAT_LENGTH + 1],
		start_pos,
		end_pos,
		line;

	is_packed = message{0} != 0;

	while (end_pos < length) {
		Zmsg_MakeString(temp, sizeof(temp), message, is_packed, last_color, length, line,
		                start_pos, end_pos, g_zmsg_HyphenStart, g_zmsg_HyphenStartLength,
		                g_zmsg_HyphenEnd, g_zmsg_HyphenEndLength);
		result = SendClientMessage(playerid, color, temp);
		line++;
	}
	return result;
}
/*
	SendClientMessageToAll
*/

stock ZMsg_SendClientMessageToAll(color, const message[])
{
	new length = strlen(message);

	// shouldn't be shifted
	if (length <= ZMSG_MAX_CHAT_LENGTH) {
		return SendClientMessageToAll(color, message);
	}

	new
		bool:is_packed,
		last_color = -1,
		result,
		temp[ZMSG_MAX_CHAT_LENGTH + 1],
		start_pos,
		end_pos,
		line;

	is_packed = message{0} != 0;

	while (end_pos < length) {
		Zmsg_MakeString(temp, sizeof(temp), message, is_packed, last_color, length, line,
		                start_pos, end_pos, g_zmsg_HyphenStart, g_zmsg_HyphenStartLength,
		                g_zmsg_HyphenEnd, g_zmsg_HyphenEndLength);
		result = SendClientMessageToAll(color, temp);
		line++;
	}
	return result;
}

/*
	SendPlayerMessageToPlayer
*/

stock ZMsg_SendPlayerMessageToPlayer(playerid, senderid, const message[])
{
	new length = strlen(message);

	// shouldn't be shifted
	if (length <= ZMSG_MAX_PLAYER_CHAT_LENGTH) {
		return SendPlayerMessageToPlayer(playerid, senderid, message);
	}

	new
		bool:is_packed,
		last_color = -1,
		result,
		temp[ZMSG_MAX_CHAT_LENGTH + 1],
		start_pos,
		end_pos,
		line;

	is_packed = message{0} != 0;

	while (end_pos < length) {
		Zmsg_MakeString(temp, sizeof(temp), message, is_packed, last_color, length, line,
		                start_pos, end_pos, g_zmsg_HyphenStart, g_zmsg_HyphenStartLength,
		                g_zmsg_HyphenEnd, g_zmsg_HyphenEndLength);
		if (line == 0) {
			result = SendPlayerMessageToPlayer(playerid, senderid, temp);
		} else {
			SendClientMessage(playerid, -1, temp);
		}
		line++;
	}
	return result;
}

/*
	SendPlayerMessageToAll
*/

stock ZMsg_SendPlayerMessageToAll(senderid, const message[])
{
	new length = strlen(message);

	// shouldn't be shifted
	if (length <= ZMSG_MAX_PLAYER_CHAT_LENGTH) {
		return SendPlayerMessageToAll(senderid, message);
	}

	new
		bool:is_packed,
		last_color = -1,
		result,
		temp[ZMSG_MAX_CHAT_LENGTH + 1],
		start_pos,
		end_pos,
		line;

	is_packed = message{0} != 0;

	while (end_pos < length) {
		Zmsg_MakeString(temp, sizeof(temp), message, is_packed, last_color, length, line,
		                start_pos, end_pos, g_zmsg_HyphenStart, g_zmsg_HyphenStartLength,
		                g_zmsg_HyphenEnd, g_zmsg_HyphenEndLength);
		if (line == 0) {
			result = SendPlayerMessageToAll(senderid, temp);
		} else {
			SendClientMessageToAll(-1, temp);
		}
		line++;
	}
	return result;
}