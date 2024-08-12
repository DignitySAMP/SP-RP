#define COLOR_ATM (0x198b3fFF)
enum E_ATM_DATA {

    Float: E_ATM_POS_X,
    Float: E_ATM_POS_Y,
    Float: E_ATM_POS_Z,
    Float: E_ATM_ANGLE
};

new ATM[][E_ATM_DATA] = {
    {2068.87, -1770.56, 13.24, 89.82}, // Idlewood
    {1928.55, -1778.75, 13.22, 89.07}, // Idlewood
    {1871.58, -1700.75, 13.22, 89.71}, // Idlewood
    {2264.81, -1721.90, 13.23, 359.96}, // Ganton
    {2422.90, -1766.91, 13.21, 270.20}, // Ganton  
    {2755.71, -1385.31, 39.06, 271.43}, // East Los Santos
    {2360.49, -1395.65, 23.68, 271.67}, // East Los Santos
    {2383.63, -1548.53, 23.83, 91.05}, // East Los Santos
    {2413.89, -1219.49, 25.21, 0.03}, // East Los Santos
    {2521.40, -1313.05, 34.53, 268.74}, // East Los Santos
    {2098.46, -1359.51, 23.66, 359.40}, // Jefferson
    {2139.65, -1164.42, 23.67, 90.46}, // Jefferson
    {2232.98, -1329.62, 23.66, 274.76}, // Jefferson
    {2725.18, -2018.86, 13.23, 176.63}, // Playa del Seville
    {2389.22, -1981.80, 13.22, 178.51}, // Willowfield
    {2120.25, -1919.04, 13.50, 270.40}, // Willowfield
    {1950.96, -2030.38, 13.22, 90.30}, // El Corona
    {1849.46, -1865.85, 13.25, 179.35} // El Corona
}, DynamicText3D: ATMLabel[sizeof(ATM)], ATMObject[sizeof(ATM)], ATMIcon[sizeof(ATM)];

#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    for(new i, j = sizeof(ATM); i < j; i++) {
        
        SetATMVisuals(i);
    }
    return 1;
}

CMD:createatm(playerid, parms[]) {
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_ADVANCED ) {
		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new Float: x, Float: y, Float: z, Float: angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
    
    new zone [ 64 ] ;
	GetCoords2DZone(x, y, zone, sizeof ( zone ));

    SendClientMessage(playerid, -1, sprintf("Send this to Hades: {%.2f, %.2f, %.2f, %.2f}, // %s", x, y, z - 0.32, angle, zone));

    return 1;
}

CMD:atm(playerid, params[]) {
    
    new index = IsNearATM(playerid);
    if(index == -1) {
        return SendServerMessage(playerid, COLOR_ATM, "ATM", "DEDEDE", "You are not near an ATM!");
    }

    OnPlayerUseATM(playerid);
    return 1;
}

static OnPlayerUseATM(playerid) {
	inline ViewATMMenu(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext
        if(response) {
            switch(listitem) {
                case 0: ShowATMWithdrawList(playerid);
                case 1: ShowATMBalance(playerid);
            }
        }
    }
	Dialog_ShowCallback ( playerid, using inline ViewATMMenu, DIALOG_STYLE_LIST, "Automatic Teller Machine", "Withdraw\nBalance", "Select", "Back" );
}

static ShowATMWithdrawList(playerid) {

    // Show new namechange menu.
	inline OnATMWithdraw(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, listitem
        if(!response) {
            OnPlayerUseATM(playerid);
            return 1;
        }
        if(response) {
            new amount = strval(inputtext);
            printf("Amount: %d", amount);
            if ( amount <= 0 || amount > Character [ playerid ] [ E_CHARACTER_BANKCASH ] ) {
                OnPlayerUseATM(playerid);
                return SendServerMessage(playerid, COLOR_ATM, "ATM", "DEDEDE", "You don't have that much money!");
            }

            Character [ playerid ] [ E_CHARACTER_BANKCASH ] -= amount ;
            GivePlayerCash ( playerid, amount) ;

            new query [ 256 ] ;
            mysql_format(mysql, query, sizeof(query), "UPDATE characters SET player_bankcash = %d WHERE player_id = %d", 
                Character [ playerid ] [ E_CHARACTER_BANKCASH ], Character [ playerid ] [ E_CHARACTER_ID ] ) ;

            mysql_tquery(mysql, query);

            SendServerMessage(playerid, COLOR_ATM, "ATM", "DEDEDE", sprintf("You have withdrawn %s from your bank account.", IntegerWithDelimiter(amount)));
            OnPlayerUseATM(playerid);

            AddLogEntry(playerid, LOG_TYPE_SCRIPT, sprintf("Withdrew $%s from an ATM (New balance: $%s)", IntegerWithDelimiter(amount), IntegerWithDelimiter(Character [ playerid ] [ E_CHARACTER_BANKCASH ])));

            return 1;

        }
    }
	Dialog_ShowCallback ( playerid, using inline OnATMWithdraw, DIALOG_STYLE_LIST, "Select the amount you wish to withdraw", "150\n250\n500\n750\n1000\n1500\n2500\n5000\n7500\n10000", "Select", "Back" );
    return 1;
}

static ShowATMBalance(playerid) {

    new string[512];

    format(string, sizeof(string), "Bank Account: $%s\nSavings: $%s ($%s per paycheck)", 
        IntegerWithDelimiter(Character[playerid][E_CHARACTER_BANKCASH]), 
        IntegerWithDelimiter(Character[playerid][E_CHARACTER_SAVINGS]), 
        IntegerWithDelimiter((Character[playerid][E_CHARACTER_SAVINGS] / 700) / 2)
    );

    inline ViewATMMenu(pid, dialogid, response, listitem, string:inputtext[]) 
	{
        #pragma unused pid, dialogid, inputtext, listitem
        if(!response || response) {

            OnPlayerUseATM(playerid);
            return 1;
        }
    }
	Dialog_ShowCallback ( playerid, using inline ViewATMMenu, DIALOG_STYLE_MSGBOX, "Your bank balance", string, "Select", "Back" );
    return 1;
}

static ClearATMVisuals(index) {
    if(IsValidDynamicObject(ATMObject[index])) {
        DestroyDynamicObject(ATMObject[index]);
    }
    ATMObject[index] = INVALID_STREAMER_ID;

    if(IsValidDynamic3DTextLabel(ATMLabel[index])) {
        DestroyDynamic3DTextLabel(ATMLabel[index]);
    }
    ATMLabel[index] = DynamicText3D:INVALID_STREAMER_ID;

    if(IsValidDynamicMapIcon(ATMIcon[index])) {
        DestroyDynamicMapIcon(ATMIcon[index]);
    }
    ATMIcon[index] = INVALID_STREAMER_ID;
}

static SetATMVisuals(index) {

    ClearATMVisuals(index); // Clear variables just incase.

    ATMLabel[index] = CreateDynamic3DTextLabel(sprintf("[Automated Teller Machine] {2bb358}[%i]{DEDEDE}\nType {c4a656}/atm {DEDEDE}to access your bank account.",index), 
        0x198b3fFF, ATM[index][E_ATM_POS_X], ATM[index][E_ATM_POS_Y], ATM[index][E_ATM_POS_Z], 6.0
    ); 

    ATMObject[index] = CreateDynamicObject(2942, ATM[index][E_ATM_POS_X], ATM[index][E_ATM_POS_Y], ATM[index][E_ATM_POS_Z], 0.0, 0.0, ATM[index][E_ATM_ANGLE]);
    ATMIcon[index] = CreateDynamicMapIcon(ATM[index][E_ATM_POS_X], ATM[index][E_ATM_POS_Y], ATM[index][E_ATM_POS_Z], 52, 0xFFFFFFFF, .streamdistance = 75.0);
}


static IsNearATM(playerid) {
    for(new i, j = sizeof(ATM); i < j; i++) {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, ATM[i][E_ATM_POS_X], ATM[i][E_ATM_POS_Y], ATM[i][E_ATM_POS_Z])) {
            return i;
        }
    }

    return -1;
}