CMD:claimprize(playerid) {

	if ( ! Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You don't have any prize money pending." ) ;
	}

	if ( Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_CLAIMED ] ) {

		return SendClientMessage(playerid, COLOR_ERROR, "You've already claimed this prize on one of your characters." ) ;
	}

	// return SendClientMessage(playerid, COLOR_ERROR, "Sorry, this feature has now been disabled." ) ;

	new query [ 1024 ] ;

	inline PrizeHandler() 
	{
		if (!cache_num_rows())
		{
			SendClientMessage(playerid, COLOR_ERROR, "You don't have any prizes to claim, or have already done so." ) ;
			return true;
		}
		else
		{
			// Inline dialog asking if they want to submit it on this character!
			inline PrizeCollectConfirm(pid, dialogid, response, listitem, string:inputtext[]) {
			    #pragma unused pid, dialogid, listitem, inputtext

				if ( ! response ) {

			    	return false ;
				}

				query[0]=EOS;
				format ( query, sizeof ( query ), "You have been awarded $%s for being a loyal member of the server. On December 9th, the server", IntegerWithDelimiter ( Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ] ) );
				SendClientMessage(playerid, COLOR_BLUE, query ) ;
				SendClientMessage(playerid, COLOR_BLUE, "reached 150 players for the first time in the history of its existance. To give a thank you for being");
				SendClientMessage(playerid, COLOR_BLUE, "a part of this amazing journey we have gifted you this money. We hope you stick around for more!");

				query[0]=EOS;
				//format ( query, sizeof ( query ), "[PRIZE COLLECT] (%d) %s has just collected %s (/claimprize). Check for abuse.", playerid, ReturnPlayerNameData ( playerid ), IntegerWithDelimiter ( Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ] ) );
				//SendAdminMessage ( query ) ;

				GivePlayerCash ( playerid,  Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ] ) ;
				Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ] = 0 ;

				format( Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_IP ], 64, "%s", ReturnIP(playerid));
				Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_CLAIMED ] = Character [ playerid ] [ E_CHARACTER_ID ] ;


				query [ 0 ] = EOS ;
				mysql_format(mysql, query, sizeof ( query ), "UPDATE accounts SET account_reward_amount = %d, account_reward_claimed = %d, account_reward_ipaddress = '%e' WHERE account_id = %d", 
					Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ],
					Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_CLAIMED ],
					Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_IP ],
					Account [ playerid ] [ E_PLAYER_ACCOUNT_ID ]
				);

				mysql_tquery(mysql, query);

				return true ;
			}

			query[0]=EOS;
			format ( query, sizeof ( query ), 

				"{C23030}READ THIS BEFORE PRESSING CONTINUE.{DEDEDE}\n\n\
				You're about to collect {C23030}%s{DEDEDE} from your prize pool.\n\n\
				You can only collect it on {C23030}one character{DEDEDE}, choose wisely!\n\n\
				Only press OK if you're certain."

			, IntegerWithDelimiter ( Account [ playerid ] [ E_PLAYER_ACCOUNT_REWARD_AMOUNT ] )  ) ;

			Dialog_ShowCallback ( playerid, using inline PrizeCollectConfirm, DIALOG_STYLE_MSGBOX, "Prize Collection", query, "OK", "Back" );


			return true ;
		}

		/*
	    else if ( rows ) {
	    	// Make it so people can't log onto their alts and claim extra money to prevent inflation!
		
			SendClientMessage(playerid, COLOR_ERROR, "This prize has already been claimed on your IP address. Please don't dupe it." ) ;
			SendAdminMessage(sprintf("[PRIZE DUPE] (%d) %s has tried to collect /claimprize money on an alt! IP duplicate detected!", playerid, ReturnPlayerNameData ( playerid ))) ;	

			return true ;
		}
		*/
	}

	MySQL_TQueryInline(mysql, using inline PrizeHandler, "SELECT * FROM `accounts` WHERE `account_reward_claimed` = 0 AND `account_reward_amount` > 0");

	return true ;
}