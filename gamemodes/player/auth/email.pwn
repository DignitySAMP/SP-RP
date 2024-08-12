

// To avoid stack size stuff
static EmailDlgStr[1024];
static EmailQueryStr[256];

GetPlayerEmail(playerid){

	inline GetEmail(pid, dialogid, response, listitem, string:inputtext[]) 
	{
	    #pragma unused pid, dialogid, listitem

		if ( ! response ) {
			SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "For safety reasons, you MUST set an email address.");
			return GetPlayerEmail(playerid);
		}

		if ( response ) {

			if(!IsValidEmail(inputtext)){
				SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Please enter a valid email!");
				return GetPlayerEmail(playerid);
			}
 	
 			new query [ 512 ] ;

			mysql_format(mysql, query, sizeof ( query ),  "SELECT account_email FROM accounts WHERE account_email='%s'", inputtext ) ;

			inline CheckEmailValidity() {
				if ( cache_num_rows() ) {

					SendServerMessage( playerid, COLOR_ERROR, "Security", "A3A3A3", "This email is already used by someone else! Enter a new one, or visit our UCP to reset it!");
					return GetPlayerEmail(playerid);
				}
				else {

					format(EmailQueryStr, sizeof(EmailQueryStr), "UPDATE accounts SET account_email = '%s' WHERE account_id = %d", inputtext, Account[playerid][E_PLAYER_ACCOUNT_ID]);
					mysql_tquery(mysql, EmailQueryStr);
					
					Account [ playerid ] [ E_PLAYER_ACCOUNT_EMAIL ] [ 0 ] = EOS ;
					strcat(Account [ playerid ] [ E_PLAYER_ACCOUNT_EMAIL ], inputtext);

					SendServerMessage( playerid, COLOR_SECURITY, "Security", "A3A3A3", sprintf("You have set your email to {adadad}%s{dedede}.", Account[playerid][E_PLAYER_ACCOUNT_EMAIL]));
					SendServerMessage( playerid, COLOR_SECURITY, "Security", "A3A3A3", "If you have entered the wrong email, contact a staff member to reset it."); // REMOVE / EDIT ON UCP!!
					return true ;
				}
			} 

			MySQL_TQueryInline(mysql, using inline CheckEmailValidity, query, "");
		}

		return true ;
	}

	format(EmailDlgStr, sizeof(EmailDlgStr), "{FFFFFF}We need you to {AA3333}enter an e-mail address{FFFFFF} before continuing.");

	strcat(EmailDlgStr, "\n\n{FFFFFF}Why do you need to do this?{ADBEE6}");
	strcat(EmailDlgStr, "\n- To let you reset your password incase you forget it.");
	strcat(EmailDlgStr, "\n- To let you know when you have refunds waiting.");
	strcat(EmailDlgStr, "\n- To let you know of unauthorized attempts to access your account.");

	strcat(EmailDlgStr, "{FFFFFF}Please enter your e-mail address below and press {AA3333}Confirm{FFFFFF} to continue.");
	strcat(EmailDlgStr, "\n{ADBEE6}Note that your e-mail address will never be visible to other players or moderators.");

	Dialog_ShowCallback ( playerid, using inline GetEmail, DIALOG_STYLE_INPUT, "Enter an Email Address", EmailDlgStr, "Continue" );
	return true;
}

stock IsValidEmail(const email[])
{
  static Regex:regex;
  if (!regex) regex = Regex_New("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");

  return Regex_Check(email, regex);
}
