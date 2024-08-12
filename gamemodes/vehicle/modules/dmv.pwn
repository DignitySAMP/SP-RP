// ------------------------------------------------------------------------------
// New quiz-based driving test
// Written by Sporky (www.github.com/sporkyspork) originally for Redwood RP (www.rw-rp.net)
// Adapated for Singleplayer Roleplay (SOLS)

#include <YSI_Coding\y_hooks>

#define TOTAL_DMV_DIALOGS 8

static QuizQuestion[MAX_PLAYERS] = 0;
static QuizScore[MAX_PLAYERS] = -1;
static QuizAnswer[MAX_PLAYERS] = -2;

static QuizDialogStr[1400];

static const QuizQuestions[TOTAL_DMV_DIALOGS][128] =
{
    "{FFEE00}Which of these is not a speeding violation?",
   	"{FFEE00}When are you allowed to drive on the sidewalk?",
	"{FFEE00}When can you use a cellphone while driving?",
	"{FFEE00}What should you do at a stop sign?",
	"{FFEE00}What do you do if an emergency vehicle has sirens on?",
    "{FFEE00}Are you allowed to drive a vehicle while drunk?",
    "{FFEE00}What should you do at a red traffic light?",
	"{FFEE00}What is the law for helmets and seatbelts?"
};

static enum QuizAnswerData
{
    qQuestionId,
    bool:qIsCorrect,
    qAnswerText[128]
}

static const QuizAnswers[TOTAL_DMV_DIALOGS*4][QuizAnswerData] = 
{
    {0, true, "Driving faster after switching from a street to a highway"},
    {0, false, "Driving faster than the limit shown on a traffic sign"},
    {0, false, "Driving too fast for the current weather conditions"},
    {0, false, "Driving at a speed that endangers people or property"},
    {1, true, "To enter or leave a house or property beside it"},
    {1, false, "To park your car to go to a shop"},
    {1, false, "To get to your destination faster"},
    {1, false, "To overtake a slower car"},
    {2, true, "Only in an emergency situation or when parked"},
    {2, false, "When going slower than 30 miles-per-hour"},
    {2, false, "When going faster than 30 miles-per-hour"},
    {2, false, "Only to send and receive text messages"},
    {3, true, "Come to a complete stop and give way to oncoming traffic"},
    {3, false, "Stop if there are no other cars around"},
    {3, false, "Stop if there is a red traffic light"},
    {3, false, "Stop only if there is another car in front of you"},
	{4, true, "Pull over to the side until the vehicle passes you"},
    {4, false, "Stop completely until the vehicle goes around you"},
    {4, false, "Ignore it and continue driving normally"},
    {4, false, "Drive slowly behind it until it moves away"},
	{5, true, "No, you cannot drive or control a vehicle while drunk"},
    {5, false, "Yes, but only if you can see the road properly"},
    {5, false, "Yes, there are no rules about driving drunk"},
    {5, false, "Yes, but only if you have had food too"},
	{6, true, "Stop and wait until the light turns to green"},
    {6, false, "Stop and wait for two seconds and then go"},
    {6, false, "Drive through it like normal without stopping"},
    {6, false, "Stop and wait for six seconds and then go"},
	{7, true, "You must wear a seatbelt in a car and a helmet on a bike"},
    {7, false, "You only need to wear helmets when in cars"},
    {7, false, "You only need to wear seatbelts on bikes"},
    {7, false, "You don't need to wear helmets or seatbelts"}
};

IsDoingDrivingTest(playerid)
{
	return PlayerVar[playerid][E_PLAYER_DOING_DMV_TEST];
}

forward DlgDMVTestFail(playerid, dialogid, response, listitem, string:inputtext[]);
public DlgDMVTestFail(playerid, dialogid, response, listitem, string:inputtext[])
{
	if (response)
	{
		cmd_taketest(playerid);
	}

	return 1;
}

forward DlgDMVTestPass(playerid, dialogid, response, listitem, string:inputtext[]);
public DlgDMVTestPass(playerid, dialogid, response, listitem, string:inputtext[])
{
	new query [ 256 ] ;

	mysql_format ( mysql, query, sizeof ( query ), "UPDATE characters SET player_driverslicense = 1 WHERE player_id = %d", Character [ playerid ] [ E_CHARACTER_ID ] ) ;
	mysql_tquery ( mysql, query ) ;

	Character [ playerid ] [ E_CHARACTER_DRIVERSLICENSE ] = 1 ;

	return SendServerMessage ( playerid, COLOR_BLUE, "DMV", "A3A3A3", "Congratulations! You've passed your test and been given a driver's license." ) ;
}

forward DlgDMVTest(playerid, dialogid, response, listitem, string:inputtext[]);
public DlgDMVTest(playerid, dialogid, response, listitem, string:inputtext[])
{
	if (!response)
	{
		// Show them it again
		ShowQuizQuestion(playerid, QuizQuestion[playerid]);
		return 1;
	}

	if (QuizAnswer[playerid] == listitem)
	{
		// Correct answer
		QuizScore[playerid] ++;
	}
	
	if ((QuizQuestion[playerid] + 1) >= TOTAL_DMV_DIALOGS)
	{
		// Finished the quiz
		if (QuizScore[playerid] == TOTAL_DMV_DIALOGS)
		{
			// They passed
			Dialog_ShowCallback(playerid, using public DlgDMVTestPass<iiiis>, DIALOG_STYLE_MSGBOX, "Driving Test Result", sprintf("You passed the driving test with %d/%d correct answers.\n{FFFFFF}Press 'OK' to be issued with your driver's license.", QuizScore[playerid], TOTAL_DMV_DIALOGS), "OK");
		}
		else
		{
			// They failed
			Dialog_ShowCallback(playerid, using public DlgDMVTestFail<iiiis>, DIALOG_STYLE_MSGBOX, "Driving Test Result", sprintf("You failed the driving test with %d/%d correct answers.\n{FFFFFF}Press 'Retry' to take the test again.", QuizScore[playerid], TOTAL_DMV_DIALOGS), "Retry", "Back");
		}

        PlayerVar[playerid][E_PLAYER_DOING_DMV_TEST] = false;

		return 1;
	}

	ShowQuizQuestion(playerid, QuizQuestion[playerid] + 1);

    return 1;
}

stock bool:IsInAnswersArray(const array[4], value)
{
    for (new i = 0; i < sizeof(array); i++)
    {
        if (array[i] == value)
        {
            return true;
        }
    }

    return false;
}

stock ShowQuizQuestion(playerid, questionid)
{
    new count = 0;
    format(QuizDialogStr, sizeof(QuizDialogStr), "%s", "");

    // Arrays to store answers in
    new possibleAnswers[4];
    new shuffledAnswers[4];
    new answers[4] = {-1, ...};

    answers[0] = -1;
    answers[1] = -1;
    answers[2] = -1;
    answers[3] = -1;

    // Get all possible answers
    for (new i = 0; i < sizeof(QuizAnswers); i++)
    {
        if (QuizAnswers[i][qQuestionId] != questionid) continue;
        possibleAnswers[count] = i;
        count ++;
    }

    // Shuffle the possible answers
    for (new i = 0; i < sizeof(answers); i++)
    {
        new answer = random(4);

        while (IsInAnswersArray(answers, answer))
        {
            answer = random(4);
        }
        
        shuffledAnswers[i] = possibleAnswers[answer];
        answers[i] = answer;
    }

    // Compose the shuffled list
    count = 0;
    for (new i = 0; i < sizeof(shuffledAnswers); i++)
    {
        if (QuizAnswers[shuffledAnswers[i]][qIsCorrect])
        {
            QuizAnswer[playerid] = i;
        } 

        strcat(QuizDialogStr, QuizAnswers[shuffledAnswers[i]][qAnswerText]);

        count ++;
        if (count < 4) strcat(QuizDialogStr, "\n");
    }

    QuizQuestion[playerid] = questionid;
    if (questionid == 0) QuizScore[playerid] = 0;

    // Show the question
	Dialog_ShowCallback(playerid, using public DlgDMVTest<iiiis>, DIALOG_STYLE_LIST, QuizQuestions[questionid], QuizDialogStr, "Select");
}

/*
CMD:quiz(playerid, params[])
{
	new questionid;
	if(sscanf(params, "d", questionid)) return SendClientMessage(playerid, -1, "{00BFFF}Usage:{FFFFFF} /quiz [question id]");
	ShowQuizQuestion(playerid, questionid);
    return 1;
}
*/

DMV_Init() 
{
	CreateDynamicPickup(1581, 1, SERVER_DMV_X, SERVER_DMV_Y, SERVER_DMV_Z );
	CreateDynamic3DTextLabel(sprintf("%s\n{DEDEDE}Available commands: /taketest", "Department of Motor Vehicles"), COLOR_VEHICLE, SERVER_DMV_X, SERVER_DMV_Y, SERVER_DMV_Z, 15.0 );
}

CMD:taketest(playerid) 
{
	if (IsDoingDrivingTest(playerid))
	    return SendServerMessage ( playerid, COLOR_BLUE, "DMV", "A3A3A3", "You're are already taking the test." ) ;

	if ( GetPlayerCash ( playerid ) < SERVER_DMV_FEE ) 
	{
		return SendServerMessage ( playerid, COLOR_BLUE, "DMV", "A3A3A3", sprintf("You don't have enough money to take the test. You need at least $%s.", IntegerWithDelimiter ( SERVER_DMV_FEE ) )) ;
	}

	if ( ! IsPlayerInRangeOfPoint ( playerid, 5.0, SERVER_DMV_X, SERVER_DMV_Y, SERVER_DMV_Z ) ) {

		return SendServerMessage ( playerid, COLOR_BLUE, "DMV", "A3A3A3", "You're not near the DMV! Use /gps." ) ;
	}

	if ( Character [ playerid ] [ E_CHARACTER_DRIVERSLICENSE ] ) {

		return SendServerMessage ( playerid, COLOR_BLUE, "DMV", "A3A3A3", "You already have a license." ) ;
	}

	format(QuizDialogStr, sizeof(QuizDialogStr), "{FFFFFF}You are about to take the driving test.");
	strcat(QuizDialogStr, "\n{ADBEE6}You will be asked eight questions about the traffic laws, read the information below.\n\n");

	strcat(QuizDialogStr, "{FFFFFF}Driving Test Instructions:{ADBEE6}");
	strcat(QuizDialogStr, "\n- View the traffic laws by typing {8D8DFF}/laws{ADBEE6} and choosing {8D8DFF}Infractions{ADBEE6}.");
	strcat(QuizDialogStr, "\n- If you are new to Los Santos, it is recommended that you do this before taking the test.");
	strcat(QuizDialogStr, "\n- You must answer all eight questions correctly to pass the test.\n\n");

	strcat(QuizDialogStr, "{FFFFFF}Other Helpful Notes:{ADBEE6}");
	strcat(QuizDialogStr, "\n- You cannot drive or control a vehicle after taking drugs or alcohol.");
	strcat(QuizDialogStr, "\n- You must wear a helmet on a motorcycle and a seatbelt in a car.");
	strcat(QuizDialogStr, "\n- You must pull over for emergency vehicles with lights/sirens on.");
	strcat(QuizDialogStr, "\n- You should always follow the speed limit posted on any traffic sign.\n\n");

	format(QuizDialogStr, sizeof(QuizDialogStr), "%s{FFFFFF}Press {AA3333}OK{FFFFFF} to pay {AA3333}$%s{FFFFFF} and take the driving test.\n", QuizDialogStr, IntegerWithDelimiter(SERVER_DMV_FEE));
	strcat(QuizDialogStr, "{ADBEE6}Please only start the test if you have read the above information.");

    inline DlgDMVTestStart(pid, dialogid, response, listitem, string:inputtext[]) {

        #pragma unused pid, dialogid, inputtext, listitem
        if (response)
        {
            // Start the test and pay the fee
			TakePlayerCash(playerid, SERVER_DMV_FEE);
            PlayerVar[playerid][E_PLAYER_DOING_DMV_TEST] = true;

			QuizQuestion[playerid] = 0;
			ShowQuizQuestion(playerid, QuizQuestion[playerid]);
        }
    }

    Dialog_ShowCallback ( playerid, using inline DlgDMVTestStart, DIALOG_STYLE_MSGBOX, "Driving Test Information", QuizDialogStr, "OK", "Back" );
    return true;
}
