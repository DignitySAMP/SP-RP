enum (<<= 1) {
	STATE_FREE,
	STATE_BOUNCED = 1,
	STATE_SHOT,
	STATE_SKIMMED
} ;

enum (<<= 1) {

	PLAYER_FREE,
	PLAYER_BUSY = 1,
	PLAYER_BOUNCING,
	PLAYER_SPINNING,
	PLAYER_PICKINGUP
} ;

//—————-Court Config
#define MAX_COURTS 256

enum CourtInfo
{
    COURT_NAME[32],
    COURT_HOOPS,
    Float:COURT_FIRST_HOOP_POS[4],
    Float:COURT_SECOND_HOOP_POS[4]  //Kinda unused, may use later
    //Float:COURT_POS[3],           //Unused Court Coords
    //Float:COURT_DIMENSIONS[4]     //Unused Court Dimensions, was intended to be used for detecting playable area
}
new Court[MAX_COURTS][CourtInfo] ;						//Enum data


enum E_COURT_VARIABLES {

	CourtHoop[2], 							//Hoop Objects of Courts (Max 2)
	CourtBasketball, 						//Basketball object, 1 for each Court
	CourtBasketball_BouncerID,          	//Player ID who bounces the basketball
	CourtBasketball_State,              	//State of Basketball
	ShooterAccuracy,                    	//Accuracy is global for each court because there is no other player for that. Depends on the timing of the player who shoots ball
	bool:ShooterAccuracyTurn,           	//If kept pressing MOUSE1, bar decreases this time.
	CourtBasketball_PasserID,           	//The Player ID who passes the ball
	bool:IsBeingShot,                   	//Booleran to delay a timer that calls itself
	bool:IsBeingFailed,                 	//Booleran to delay a timer that calls itself
	Float:CourtBasketball_SlopeDistance,    //The distance basketball travels from source to target
	Float:CourtBasketball_SlopeHeight,      //The height basketball reaches while being thrown to target
	Float:CBasketball_FailSlopeDistance,    //Same as others but in a fail scenerio
	Float:CBasketball_FailSlopeHeight,      //Same as others but in a fail scenerio
	CourtBasketball_Skims,                  //Number of jumps basketball does (don't change its value anywhere in script because conditions are hard-coded)
	Float:CBasketball_PassSlopeDistance,    //Same as others but in a passing scenerio
	Float:CBasketball_PassSlopeHeight,      //Same as others but in a passing scenerio
	Float:BounceHeight,						//Float to determine height of attached ball
	Float:BounceRotationY,					//Float to determine y rotation of attached ball
	Float:BounceRotationZ,					//Float to determine z rotation of attached ball,
	Float:SpinRot,							//Finger spin rotation
	bool:SpinTurn							//Booleran to determine which arm the basketball spins on
} ;

new CourtVars [ MAX_COURTS ] [ E_COURT_VARIABLES ] ;

enum E_BASKET_PLAYER_VARS {
	Editor_Court_ID, 						//Stored .ini File ID and Court ID (numeric), will be replaced with SQL
    Editor_Court_Hoop, 					//Which hoop is being created (1-2)
	ThrottleUpdate,                    	//Throttling fast update rate of callback OnPlayerUpdate (divisors of 2)
	PlayerCourtID,               			//Determinant whether player is playing or not
	//PlayerBar:PlayerAccuracyBar,             	//Bars are personal
	bool:PlayerBlocking,                   //Check if player is doing a block
	PlayerState,                       	//Player states whether busy or not
	bool:PlayerImmunity,					//Player cannot lose the ball for a while

} ;
new BasketPlayerVars [ MAX_PLAYERS ] [ E_BASKET_PLAYER_VARS ] ;

//new Text:TextdrawAccuracy = Text: INVALID_TEXT_DRAW ;                          	//The word "Accuracy" below the bar



new
    Timer_Bounce[MAX_COURTS],
    Timer_BounceDelayedStart[MAX_COURTS],
	Timer_BounceRunDelayedStart[MAX_COURTS],
	Timer_BounceRunBack[MAX_COURTS],
	Timer_BounceBack[MAX_COURTS],
	Timer_Accuracy[MAX_COURTS],
	Timer_Shoot[MAX_COURTS],
	Timer_Fail[MAX_COURTS],
	Timer_Skim[MAX_COURTS],
	Timer_Pass[MAX_COURTS],
	Timer_Airblock[MAX_PLAYERS],
	Timer_Endblock[MAX_PLAYERS],
	Timer_StayBounce[MAX_COURTS],
	Timer_StayBounceBack[MAX_COURTS],
	Timer_RunBounce[MAX_COURTS],
	Timer_RunBounceBack[MAX_COURTS],
	Timer_Spin[MAX_COURTS],
	Timer_KillSpin[MAX_COURTS]
;

stock LoadCourts()
{
	new count = 0;
    for(new i = 0; i < MAX_COURTS; i++)
	{
	    new file[64];
	    format(file,64,"Courts/%d.ini",i);
	    if(fexist(file))
	    {
		    format(Court[i][COURT_NAME],32,dini_Get(file, "Name"));
		    Court[i][COURT_HOOPS] = dini_Int(file, "Hoops");
			Court[i][COURT_FIRST_HOOP_POS][0] = dini_Float(file, "Hoop_1_Pos_0");
		    Court[i][COURT_FIRST_HOOP_POS][1] = dini_Float(file, "Hoop_1_Pos_1");
		    Court[i][COURT_FIRST_HOOP_POS][2] = dini_Float(file, "Hoop_1_Pos_2");
		    Court[i][COURT_FIRST_HOOP_POS][3] = dini_Float(file, "Hoop_1_Pos_3");
		    if(Court[i][COURT_HOOPS] == 2)
		    {
			    Court[i][COURT_SECOND_HOOP_POS][0] = dini_Float(file, "Hoop_2_Pos_0");
			    Court[i][COURT_SECOND_HOOP_POS][1] = dini_Float(file, "Hoop_2_Pos_1");
			    Court[i][COURT_SECOND_HOOP_POS][2] = dini_Float(file, "Hoop_2_Pos_2");
			    Court[i][COURT_SECOND_HOOP_POS][3] = dini_Float(file, "Hoop_2_Pos_3");
		    }

            CourtVars[i][CourtHoop][0] = CA_CreateObject_SC(946, Court[i][COURT_FIRST_HOOP_POS][0], Court[i][COURT_FIRST_HOOP_POS][1], Court[i][COURT_FIRST_HOOP_POS][2], 0.0, 0.0, Court[i][COURT_FIRST_HOOP_POS][3]);

		    new Float:bX, Float:bY;
			GetXYInFrontOfObject(CourtVars[i][CourtHoop][0], bX, bY, 2.0);
			CourtVars[i][CourtBasketball] = CA_CreateObject_SC(2114, bX, bY, Court[i][COURT_FIRST_HOOP_POS][2]-2.0, 0.0, 0.0, 0.0);

            if(Court[i][COURT_HOOPS] == 2)
			{
			     CourtVars[i][CourtHoop][1] = CA_CreateObject_SC(946, Court[i][COURT_SECOND_HOOP_POS][0], Court[i][COURT_SECOND_HOOP_POS][1], Court[i][COURT_SECOND_HOOP_POS][2], 0.0, 0.0, Court[i][COURT_SECOND_HOOP_POS][3]);
			}

			CourtVars[i][CourtBasketball_BouncerID] = INVALID_PLAYER_ID;
			CourtVars[i][CourtBasketball_State] = STATE_FREE;

		    count++;
	    }
	}
	printf("Loaded %d courts.",count);
}

stock GetAvailablecourtid() //Will be edited according to SQL
{
    new ID = -1;
    for(new i = 0; i < MAX_COURTS; i++)
    {
        new file[64];
        format(file,64,"Courts/%d.ini",i);
        if(!fexist(file))
        {
            ID = i;
            break;
        }
    }
    return ID;
}

CMD:basketcreate(playerid) //Initially everyone's cmd but we may have perspective changes depending on user/admin
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_SENIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

	inline e_basketball_menu(pid, dialogid, response, listitem, string:inputtext[]) {
	    #pragma unused pid, dialogid, inputtext

		if ( response ) {
			if(listitem == 0) { //Create a court
            
                BasketPlayerVars [ playerid ] [ Editor_Court_ID ] = GetAvailablecourtid(); //Find next available court ID

                if(BasketPlayerVars [ playerid ] [ Editor_Court_ID ] < 0) {
                	return SendClientMessage(playerid, -1, "No more courts can be created!");
                }
 
			 	inline e_basketball_menu_name(pidx, dialogidx, responsex, listitemx, string:inputtextx[]) {
				    #pragma unused pidx, dialogidx, listitemx

			        if(!responsex) {
			        	return cmd_basketcreate(playerid);
			        }
			        else if(responsex)
			        {
			            if( strlen(inputtextx) > 48) {

			            	SendClientMessage(playerid, -1, "The name you entered is too long. It has been shortened to 32 characters.");
			            }
		                new str[128];
		                format(Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_NAME], 32, "%s", inputtextx);
		                format(str, sizeof(str), "You've named the court as \"%s\"", Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_NAME]);
		                SendClientMessage(playerid, -1, str);

				 		inline e_basketball_menu_hoop(pidy, dialogidy, responsey, listitemy, string:inputtexty[]) {
						    #pragma unused pidy, dialogidy, inputtexty

					        if(!responsey)
					        {
					         
				        		return cmd_basketcreate(playerid);
				       		}
					        else if(responsey)
					        {
					            new Float:pos[3];
					            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
					            if(listitemy == 0 || listitemy == 1){ //1-Hoop
					            
					            	if ( listitemy == 1 ) {

					            		SendClientMessage(playerid, -1, "2-hoop courts are not possible in this version. Setting to 1-hoop." ) ;
					            	}

					                Court[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][COURT_HOOPS] = 1;
					                SendClientMessage(playerid, -1, "You've set 1-Hoop.");
					                SendClientMessage(playerid, -1, "Please adjust the hoop and click save button.");
					                BasketPlayerVars[playerid][Editor_Court_Hoop] = 1;
					                GetXYInFrontOfPlayer(playerid, pos[0], pos[1], 2.5);
					                CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtHoop][0] = CA_CreateObject_SC(946, pos[0], pos[1], pos[2]+1.15, 0.0, 0.0, 0.0);
					                EditObject(playerid, CourtVars[BasketPlayerVars [ playerid ] [ Editor_Court_ID ]][CourtHoop][0]);
					            }
					        }
					    }

						Dialog_ShowCallback ( playerid, using inline e_basketball_menu_hoop, DIALOG_STYLE_LIST, "Select field type", "1-Hoop\n2-Hoop","Confirm","Back" );
			        }
			    }

				Dialog_ShowCallback ( playerid, using inline e_basketball_menu_name, DIALOG_STYLE_INPUT, "Name the court", "Input a name below", "Confirm", "No way" );

            }

            else if(listitem == 1) //Delete a court
            {
                //Nothing is here yet
            }
            else if(listitem == 2) //Teleport to a court
            {
                //Nothing is here yet
            }
        }
	}

	Dialog_ShowCallback ( playerid, using inline e_basketball_menu, DIALOG_STYLE_LIST, "Basketball Editor", "Create a court\nDelete a court\nTeleport to court", "Confirm", "No way" );

	return 1;
}

CMD:basketrefresh(playerid)
{
	if ( GetPlayerAdminLevel ( playerid ) < ADMIN_LVL_JUNIOR ) {

		return SendServerMessage ( playerid, COLOR_ERROR, "Access Denied", "A3A3A3", "You don't have access to this command.") ;
	}

    new courtid = GetNearestHoop(playerid);
	if(courtid == -1) return SendClientMessage(playerid, -1, "You are not near to any basketball hoop!");

	RefreshBasketballCourt(courtid ) ;

	return 1;
}

RefreshBasketballCourt(courtid) {

	if ( courtid == -1 ) {

		return true ;
	}

	KillAllTimers(courtid);
	SOLS_DestroyObject(CourtVars[courtid][CourtBasketball], "Basketball/RefreshBasketballCourt", false);
	CourtVars[courtid][CourtBasketball_BouncerID] = INVALID_PLAYER_ID ;
	new Float:pos[3];
	pos[0] = Court[courtid][COURT_FIRST_HOOP_POS][0];
	pos[1] = Court[courtid][COURT_FIRST_HOOP_POS][1];
	pos[2] = Court[courtid][COURT_FIRST_HOOP_POS][2];
	GetXYInFrontOfObject(CourtVars[courtid][CourtHoop][0], pos[0], pos[1], 2.0);
	CourtVars[courtid][CourtBasketball] = CA_CreateObject_SC(2114, pos[0], pos[1], pos[2]-2.0, 0.0, 0.0, 0.0);

	CourtVars[courtid][CourtBasketball_BouncerID] = INVALID_PLAYER_ID ;
	CourtVars[courtid][CourtBasketball_State] = STATE_FREE ;

	return true ;
}