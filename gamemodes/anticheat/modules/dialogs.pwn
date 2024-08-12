

CheckInputtextCrash(playerid, inputtext[]) {

	/*
		This is deprecated. Update YSI or find a better dialog include.

		'%' crashes the server on input.

	*/
	if (strfind(inputtext, "%", true) != -1 || strfind(inputtext, "#", true) != -1) 
	{
		format(inputtext, 128, "invalid"); // not sure if this works, but we can try...
		//SendAdminMessage(sprintf("[AntiCheat]: (%d) %s might have used a string buffer overflow exploit.", playerid, ReturnPlayerNameData(playerid)));	
		printf("[EXPLOIT] (%d) %s: (inputtext: %s)", playerid, ReturnPlayerName(playerid), inputtext);

		new acstr[256];
		format(acstr, sizeof(acstr), "[Anticheat]: (%d) %s used a bad symbol in input text", playerid, ReturnMixedName(playerid));
		SendAdminMessage(acstr, COLOR_ANTICHEAT);

		return 0;
	}

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[] ) 
{
	if (listitem == -1) // listitem should be -1 if it's a INPUT dialog
	{
		if (strfind(inputtext, "%", true) != -1 || strfind(inputtext, "#", true) != -1) 
		{
			// Prevent the dialog being processed?
			return 1;
		}

		// printf("OnDialogResponse: pid: %d, id: %d, response: %d, list: %d, text: %s", playerid, dialogid, response, listitem, inputtext);
	}
	
    return 0;
}

