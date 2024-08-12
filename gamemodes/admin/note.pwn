
#define MAX_ANOTES 250
#define MAX_MESSAGE_SIZE 32
#define MAX_PLAYER_NOTES 5
#define INVALID_NOTE_ID (-1)

enum E_NOTE_INFO {

	E_NOTE_ID,
	E_NOTE_ACCOUNTID,
	E_NOTE_ADMIN[64],
	E_NOTE_DATE,
	E_NOTE_TEXT[256]

}

new AdminNote [ MAX_ANOTES ] [ E_NOTE_INFO ];

Notes_Load() {

	for ( new i, j = sizeof ( AdminNote ); i < j ; i ++ ) {

		AdminNote [ i ] [ E_NOTE_ID ] = INVALID_NOTE_ID ;

	}

	print(" * [NOTES] Loading admins notes...");

	inline Notes_OnDataLoad() {
		for(new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name_int(i, "note_id", AdminNote [ i ] [ E_NOTE_ID ]);
			cache_get_value_name_int(i, "note_account", AdminNote [ i ] [ E_NOTE_ACCOUNTID ]);
			cache_get_value_name(i, "note_admin", AdminNote [ i ] [ E_NOTE_ADMIN ]);
			cache_get_value_name_int(i, "note_date", AdminNote [ i ] [ E_NOTE_DATE ]);
			cache_get_value_name(i, "note_text", AdminNote [ i ] [ E_NOTE_TEXT ]);
			
		}

		printf(" * [NOTES] Loaded %d notes.", cache_num_rows());
	}

	MySQL_TQueryInline(mysql, using inline Notes_OnDataLoad, "SELECT * FROM admin_notes");

	return true ;
}

Note_GetFreeID() {

	for ( new i, j = sizeof ( AdminNote ); i < j; i ++ ) {

		if ( AdminNote [ i ] [ E_NOTE_ID ] == INVALID_NOTE_ID ) {
			return i ;
		}

		else continue ;
	}

	return false ;
}

Player_GetNoteCount(playerid){

	new count;

	for(new i = 0; i < sizeof(AdminNote); i++){

		if ( AdminNote[i][E_NOTE_ACCOUNTID] == Account[playerid][E_PLAYER_ACCOUNT_ID] ) {
			count++;
		} else continue;
	}

	return count;
}


CMD:setnote(playerid, params[]){
	
	if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		return SendServerMessage ( playerid, COLOR_RED, "Access Denied", "A3A3A3",  "You don't have access to this command.");

	new target, note[256];

	if(sscanf(params, "k<player>s[256]", target, note)) {
		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/setnote [playerid] [note]");
	}

	if(!IsPlayerConnected(target))
		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3",  "Player isn't connected.");

	if ( Player_GetNoteCount(target) >= MAX_PLAYER_NOTES )
		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3",  "This player already has a max of five notes.");

	Note_Create(playerid, target, note);

	return true;
}

CMD:notes(playerid, params[]){

	if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		return SendServerMessage ( playerid, COLOR_RED, "Access Denied", "A3A3A3",  "You don't have access to this command.");

	new target;

	if(sscanf(params, "k<player>", target)) {
		SendServerMessage ( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/notes [playerid]");
		return SendServerMessage ( playerid, COLOR_RED, "Tip", "A3A3A3",  "You can use /onotes to see offline notes.");
	}


	if(!IsPlayerConnected(target))
		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3",  "Player isn't connected.");

	Notes_ShowMenu(playerid, target);

	return true;
}


CMD:onotes(playerid, params[]){

	if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_JUNIOR)
		return SendServerMessage ( playerid, COLOR_RED, "Access Denied", "A3A3A3",  "You don't have access to this command.");

	new accid;

	if(sscanf(params, "d", accid)) 
		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/onotes [account-id] (/getma, /getc)");

	Notes_ShowOfflineMenu(playerid, accid);

	return true;
}

CMD:purgenotes(playerid, params[]){

	if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_ADVANCED)
		return SendServerMessage ( playerid, COLOR_RED, "Access Denied", "A3A3A3",  "You don't have access to this command.");

	new accid;

	if(sscanf(params, "d", accid)) 
		return SendServerMessage ( playerid, COLOR_RED, "Syntax", "A3A3A3",  "/purgenotes [account-id] (/getma, /getc)");

	new query [ 1024 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "DELETE FROM `admin_notes` WHERE `note_account` = %d", accid) ;
	mysql_tquery(mysql, query);

	new count = 0;

	for(new i; i < sizeof(AdminNote); i++){

		if(AdminNote[i][E_NOTE_ACCOUNTID] == accid) {

			count++;

			AdminNote [ i ] [ E_NOTE_ID ] = INVALID_NOTE_ID;
			AdminNote [ i ] [ E_NOTE_ACCOUNTID ] = -1;
			AdminNote [ i ] [ E_NOTE_ADMIN ] [ 0 ] = EOS;
			AdminNote [ i ] [ E_NOTE_TEXT ] [ 0 ] = EOS;

		} else continue;
	}

	SendServerMessage ( playerid, COLOR_SECURITY, "Notes", "A3A3A3",  sprintf("Deleted %d notes from account ID %d.", count, accid));

	return true;

}


Note_Create(playerid, targetid, const note[256]){

	new note_enum_id = Note_GetFreeID();

	if(note_enum_id == INVALID_NOTE_ID){
		SendClientMessage(playerid, -1, "Failed to create note, contact a dev.");
		return false;
	}

	if ( Player_GetNoteCount(targetid) > MAX_PLAYER_NOTES )
		return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3",  "This player already has a max of five notes. They need to be purged.");

	AdminNote [ note_enum_id ] [ E_NOTE_ACCOUNTID ] = Account [ targetid ] [ E_PLAYER_ACCOUNT_ID ];
	format(AdminNote [ note_enum_id ] [ E_NOTE_ADMIN ], 64, "%s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
	AdminNote [ note_enum_id ] [ E_NOTE_DATE ] = gettime();
	AdminNote [ note_enum_id ] [ E_NOTE_TEXT ] = note;

	new query [ 1024 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO admin_notes (note_account, note_admin, note_date, note_text) VALUES (%d, '%s', %d, '%s')",
		AdminNote [ note_enum_id ] [ E_NOTE_ACCOUNTID ], AdminNote [ note_enum_id ] [ E_NOTE_ADMIN ], AdminNote [ note_enum_id ] [ E_NOTE_DATE ], AdminNote [ note_enum_id ] [ E_NOTE_TEXT ] ) ;

	inline Note_OnDatabaseInsert() {

		AdminNote [ note_enum_id ] [ E_NOTE_ID ] = cache_insert_id ();

		printf(" * [NOTE] Created note (%d) with ID %d.", 
			note_enum_id, AdminNote [ note_enum_id ] [ E_NOTE_ID ] ) ;
	}

	MySQL_TQueryInline(mysql, using inline Note_OnDatabaseInsert, query, "");

	SendServerMessage ( playerid, COLOR_SECURITY, "Notes", "A3A3A3",  sprintf("You have added a note to %s.", ReturnMixedName(targetid)));

	return true;
}

Note_OfflineCreate(playerid, accid, const note[256]){

	new note_enum_id = Note_GetFreeID();

	if(note_enum_id == INVALID_NOTE_ID){
		SendClientMessage(playerid, -1, "Failed to create note, contact a dev.");
		return false;
	}

	AdminNote [ note_enum_id ] [ E_NOTE_ACCOUNTID ] = accid;
	format(AdminNote [ note_enum_id ] [ E_NOTE_ADMIN ], 64, "%s", Account[playerid][E_PLAYER_ACCOUNT_NAME]);
	AdminNote [ note_enum_id ] [ E_NOTE_DATE ] = gettime();
	AdminNote [ note_enum_id ] [ E_NOTE_TEXT ] = note;

	new query [ 1024 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "INSERT INTO admin_notes (note_account, note_admin, note_date, note_text) VALUES (%d, '%s', %d, '%s')",
		AdminNote [ note_enum_id ] [ E_NOTE_ACCOUNTID ], AdminNote [ note_enum_id ] [ E_NOTE_ADMIN ], AdminNote [ note_enum_id ] [ E_NOTE_DATE ], AdminNote [ note_enum_id ] [ E_NOTE_TEXT ] ) ;

	inline Note_OnDatabaseInsert() {

		AdminNote [ note_enum_id ] [ E_NOTE_ID ] = cache_insert_id ();

		printf(" * [NOTE] Created note (%d) with ID %d.", 
			note_enum_id, AdminNote [ note_enum_id ] [ E_NOTE_ID ] ) ;
	}

	MySQL_TQueryInline(mysql, using inline Note_OnDatabaseInsert, query, "");

	SendServerMessage ( playerid, COLOR_SECURITY, "Notes", "A3A3A3",  sprintf("You have added a note to account id %d.", accid));

	return true;
}

Note_Delete(note_enum_id) {

	new query [ 1024 ] ; 

	mysql_format ( mysql, query, sizeof ( query ), "DELETE FROM `admin_notes` WHERE `note_id` = %d", AdminNote[note_enum_id][E_NOTE_ID]) ;
	mysql_tquery(mysql, query);

	AdminNote [ note_enum_id ] [ E_NOTE_ID ] = INVALID_NOTE_ID;
	AdminNote [ note_enum_id ] [ E_NOTE_ACCOUNTID ] = -1;
	AdminNote [ note_enum_id ] [ E_NOTE_ADMIN ] [ 0 ] = EOS;
	AdminNote [ note_enum_id ] [ E_NOTE_TEXT ] [ 0 ] = EOS;

	return true;
}


Notes_ShowMenu(playerid, targetid) {

	new string[512], noteinfo[512], notedlmap[10], count, noteholder[256], title[64], CreateDlgStr[256], chosen;

	format(string, sizeof(string), "Note\tAdmin\n");

	for(new i; i < sizeof(AdminNote); i++) {

		if ( AdminNote[i][E_NOTE_ACCOUNTID] == Account[targetid][E_PLAYER_ACCOUNT_ID] ) {

			noteholder[0] = EOS;
			strcat(noteholder, AdminNote[i][E_NOTE_TEXT]);

			// keep messages to max 32 chars on this screen.
			if(strlen(AdminNote[i][E_NOTE_TEXT]) > MAX_MESSAGE_SIZE){

				strdel(noteholder, MAX_MESSAGE_SIZE, 256);
				strcat(noteholder, "...");

			}

			format(string, sizeof(string), "%s{DEDEDE}%s\t{DEDEDE}%s\n", string, noteholder, AdminNote[i][E_NOTE_ADMIN]);

			notedlmap[count] = i;
			count++;

		} else continue;

	}

	if(count <= 0){
		format(string, sizeof(string), "%sThis player has no admin notes.\n", string);
	}

	format(string, sizeof(string), "%s\n{ffc170}(+) ADD A NOTE\n", string);

	inline NoteCreateDlg(pid, dialogid, response, listitem, string:inputtext[]){
		#pragma unused pid, dialogid, listitem

		if (!response) { 
			return Notes_ShowMenu(playerid, targetid);
		}

		if(response){
			
			noteholder[0] = EOS;
			strcat(noteholder, inputtext);

			Note_Create(playerid, targetid, noteholder);
			return Notes_ShowMenu(playerid, targetid);
		}
	} 

	inline NoteInfoDlg(pid, dialogid, response, listitem, string:inputtext[]){
		#pragma unused pid, dialogid, inputtext, listitem

		if (!response) { 
			return Notes_ShowMenu(playerid, targetid);
		}

		if(response){

			if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_ADVANCED || strcmp(AdminNote[chosen][E_NOTE_ADMIN], Account[playerid][E_PLAYER_ACCOUNT_NAME]))
				return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3",  "You do not have permission to delete this note.");

			SendServerMessage ( playerid, COLOR_SECURITY, "Notes", "A3A3A3",  sprintf("You have deleted %s's note. (ID %d)", ReturnMixedName(targetid), AdminNote[chosen][E_NOTE_ID]));
			Note_Delete(chosen);

		 	return Notes_ShowMenu(playerid, targetid);
		}
	} 

	inline NotesDlg(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if (!response) {
			return true;
		} 

		else if ( response ) {

			if(listitem >= count){

				format(CreateDlgStr, sizeof(CreateDlgStr), "{DEDEDE}Write your {ffc170}note{DEDEDE} below. Keep it short, concise, and to the point.\nKeep in mind notes are automatically deleted after {ffc170}30{DEDEDE} days.\n");
				
				return Dialog_ShowCallback ( playerid, using inline NoteCreateDlg, DIALOG_STYLE_INPUT, "Create A Note", CreateDlgStr, "Create", "Back" );
			}

			chosen = notedlmap[listitem];

			format(noteinfo, sizeof(noteinfo), "{ffc170}Noted By: {DEDEDE}%s\n", AdminNote[chosen][E_NOTE_ADMIN]);

			new year, month, day, hour, minute, second;
			stamp2datetime(AdminNote[chosen][E_NOTE_DATE], year, month, day, hour, minute, second, 1 ) ;
			
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Noted On:{DEDEDE} %02d/%02d/%d\n", noteinfo, day, month, year);
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Note Time:{DEDEDE} %d:%d:%d\n", noteinfo, hour, minute, second);
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Note ID:{DEDEDE} %d\n\n", noteinfo, AdminNote[chosen][E_NOTE_ID]);
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Full Note:\n", noteinfo);
			format(noteinfo, sizeof(noteinfo), "%s{DEDEDE}%s\n", noteinfo, AdminNote[chosen][E_NOTE_TEXT]);

			format(title, sizeof(title), "Admin Note - %s", ReturnMixedName(targetid));

			return Dialog_ShowCallback ( playerid, using inline NoteInfoDlg, DIALOG_STYLE_MSGBOX, title, noteinfo, "{ff4564}Delete", "{DEDEDE}Back" );
		}
	}

	format(title, sizeof(title), "Admin Notes - %s", ReturnMixedName(targetid));

   	Dialog_ShowCallback ( playerid, using inline NotesDlg, DIALOG_STYLE_TABLIST_HEADERS, title, string, "View", "Close" );

   	return true;

}

Notes_ShowOfflineMenu(playerid, accid) {

	new string[512], noteinfo[512], notedlmap[10], count, noteholder[256], title[64], CreateDlgStr[256], chosen;

	format(string, sizeof(string), "Note\tAdmin\n");

	for(new i; i < sizeof(AdminNote); i++) {

		if ( AdminNote[i][E_NOTE_ACCOUNTID] == accid ) {

			noteholder[0] = EOS;
			strcat(noteholder, AdminNote[i][E_NOTE_TEXT]);

			// keep messages to max 32 chars on this screen.
			if(strlen(AdminNote[i][E_NOTE_TEXT]) > MAX_MESSAGE_SIZE){

				strdel(noteholder, MAX_MESSAGE_SIZE, 256);
				strcat(noteholder, "...");

			}

			format(string, sizeof(string), "%s{DEDEDE}%s\t{DEDEDE}%s\n", string, noteholder, AdminNote[i][E_NOTE_ADMIN]);

			notedlmap[count] = i;
			count++;

		} else continue;

	}

	format(string, sizeof(string), "%s\n{ffc170}(+) ADD A NOTE\n", string);

	inline NoteCreateDlg(pid, dialogid, response, listitem, string:inputtext[]){
		#pragma unused pid, dialogid, listitem

		if (!response) { 
			return Notes_ShowOfflineMenu(playerid, accid);
		}

		if(response){
			
			noteholder[0] = EOS;
			strcat(noteholder, inputtext);

			Note_OfflineCreate(playerid, accid, noteholder);
			return Notes_ShowOfflineMenu(playerid, accid);
		}
	} 

	inline NoteInfoDlg(pid, dialogid, response, listitem, string:inputtext[]){
		#pragma unused pid, dialogid, inputtext, listitem

		if (!response) { 
			return Notes_ShowOfflineMenu(playerid, accid);
		}

		if(response){

			if(GetPlayerAdminLevel(playerid) < ADMIN_LVL_ADVANCED || strcmp(AdminNote[chosen][E_NOTE_ADMIN], Account[playerid][E_PLAYER_ACCOUNT_NAME]))
				return SendServerMessage ( playerid, COLOR_RED, "Error", "A3A3A3",  "You do not have permission to delete this note.");

			SendServerMessage ( playerid, COLOR_SECURITY, "Notes", "A3A3A3",  sprintf("You have deleted account ID %d's note.", accid));
			Note_Delete(chosen);

		 	return Notes_ShowOfflineMenu(playerid, accid);
		}
	} 

	inline NotesDlg(pid, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if (!response) {
			return true;
		} 

		else if ( response ) {

			if(listitem >= count){

				format(CreateDlgStr, sizeof(CreateDlgStr), "{DEDEDE}Write your {ffc170}note{DEDEDE} below. Keep it short, concise, and to the point.\nKeep in mind notes are automatically deleted after {ffc170}30{DEDEDE} days.\n");
				
				return Dialog_ShowCallback ( playerid, using inline NoteCreateDlg, DIALOG_STYLE_INPUT, "Create A Note", CreateDlgStr, "Create", "Back" );
			}

			chosen = notedlmap[listitem];

			format(noteinfo, sizeof(noteinfo), "{ffc170}Noted By: {DEDEDE}%s\n", AdminNote[chosen][E_NOTE_ADMIN]);

			new year, month, day, hour, minute, second;
			stamp2datetime(AdminNote[chosen][E_NOTE_DATE], year, month, day, hour, minute, second, 1 ) ;
			
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Noted On:{DEDEDE} %02d/%02d/%d\n", noteinfo, day, month, year);
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Note Time:{DEDEDE} %d:%d:%d\n", noteinfo, hour, minute, second);
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Note ID:{DEDEDE} %d\n\n", noteinfo, AdminNote[chosen][E_NOTE_ID]);
			format(noteinfo, sizeof(noteinfo), "%s{ffc170}Full Note:\n", noteinfo);
			format(noteinfo, sizeof(noteinfo), "%s{DEDEDE}%s\n", noteinfo, AdminNote[chosen][E_NOTE_TEXT]);

			format(title, sizeof(title), "Admin Note - %d", accid);

			return Dialog_ShowCallback ( playerid, using inline NoteInfoDlg, DIALOG_STYLE_MSGBOX, title, noteinfo, "{ff4564}Delete", "{DEDEDE}Back" );
		}
	}

	format(title, sizeof(title), "Admin Notes - %d", accid);

   	Dialog_ShowCallback ( playerid, using inline NotesDlg, DIALOG_STYLE_TABLIST_HEADERS, title, string, "View", "Close" );

   	return true;

}