
// This command details the entirety of the lowrider challenge system. It's where the magic happens:
CMD:lowrider(playerid, params[]) {
    new option[16], targetid = INVALID_PLAYER_ID;
    if(sscanf(params, "s[64]k<player>", option, targetid)){
        return SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "/lowrider [challenge, accept, cancel]");
    }
    if(!IsPlayerConnected(targetid)) {
        return SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "The player you challenged is not connected.");
    }

    new string[128];
    if(!strcmp(option, "challenge", true)) {
        #warning Make this autoexpire after x minutes

        // Are both players available and proper to do the challenge?
        if(IsChallengeValid(playerid, targetid)) {

            Lowrider[playerid][E_LOWRIDER_OFFER] = true;
            Lowrider[playerid][E_LOWRIDER_RIVAL] = targetid;

            Lowrider[targetid][E_LOWRIDER_OFFER] = true;
            Lowrider[targetid][E_LOWRIDER_RIVAL] = playerid;

            format(string, sizeof(string), "%s{DEDEDE} has challenged you to lowrider duel. To decide type {A3A3A3}/lowrider accept{DEDEDE} or {A3A3A3}/lowrider cancel", ReturnSettingsName(playerid, targetid, true, true));
            SendServerMessage(targetid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", string);
            
            format(string, sizeof(string), "Waiting for response from %s{DEDEDE}. To cancel type {A3A3A3}/lowrider cancel", ReturnSettingsName(targetid, playerid, true, true));
            SendServerMessage(targetid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", string);
        }
        // No need for an error message here - errors are handled by IsChallengeValid.
    }

    else if(!strcmp(option, "accept", true)) {

        new challenger = Lowrider[playerid][E_LOWRIDER_RIVAL];

        if(IsPlayerConnected(challenger)) {

            if(Lowrider[challenger][E_LOWRIDER_OFFER] && Lowrider[playerid][E_LOWRIDER_OFFER]) {

                Lowrider[challenger][E_LOWRIDER_OFFER] = false;
                Lowrider[playerid][E_LOWRIDER_OFFER] = false;

                SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You have accepted the lowrider duel challenge.");
                SendServerMessage(challenger, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "They have accepted the lowrider duel challenge.");
            
                // Active is set to true in the following function, after tds etc are made.
                StartLowriderChallenge(playerid, challenger);
            }
            else return SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Both you and your rival must have an open offer pending.");
        }
        else return SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Your rival has either cancelled the offer or has disconnected.");
    }
    
    else if(!strcmp(option, "cancel", true)) {
        
        new challenger = Lowrider[playerid][E_LOWRIDER_RIVAL];
        if(!IsPlayerConnected(challenger)) {
            Lowrider[playerid][E_LOWRIDER_OFFER] = false;
            Lowrider[playerid][E_LOWRIDER_ACTIVE] = false;
            Lowrider[playerid][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;

            StopLowriderChallenge(playerid, INVALID_PLAYER_ID);

            SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Your rival has disconnected. You have been removed from the challenge.");
            return 1;
        }

        if(Lowrider[playerid][E_LOWRIDER_ACTIVE]) {

            // Resetting player variables
            Lowrider[playerid][E_LOWRIDER_OFFER] = false;
            Lowrider[playerid][E_LOWRIDER_ACTIVE] = false;
            Lowrider[playerid][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;
            SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You have forfeited the lowrider challenge. You lose!");

            // Resetting challenger variables
            Lowrider[challenger][E_LOWRIDER_OFFER] = false;
            Lowrider[challenger][E_LOWRIDER_ACTIVE] = false;
            Lowrider[challenger][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;
            SendServerMessage(challenger, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Your rival has forfeited the lowrider challenge. You win!");

            StopLowriderChallenge(playerid, challenger);
            return 1;
        }
        else {
            // Cancel outstanding offer.
            if(Lowrider[playerid][E_LOWRIDER_OFFER] && Lowrider[playerid][E_LOWRIDER_RIVAL] == challenger) {
                if(Lowrider[challenger][E_LOWRIDER_OFFER] && Lowrider[challenger][E_LOWRIDER_RIVAL] == playerid) {
                    
                    // Resetting challenger variables
                    Lowrider[challenger][E_LOWRIDER_OFFER] = false;
                    Lowrider[challenger][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;
                    SendServerMessage(challenger, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Your lowrider challenge offer has been refused.");

                    // Resetting player variables
                    Lowrider[playerid][E_LOWRIDER_OFFER] = false;
                    Lowrider[playerid][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;
                    SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You have refused the lowrider challenge offer.");
                    
                    return true;
                }
                else {
                    // Challenger doesn't have a valid outstanding offer, just reset the player and inform them.
                    Lowrider[playerid][E_LOWRIDER_OFFER] = false;
                    Lowrider[playerid][E_LOWRIDER_RIVAL] = INVALID_PLAYER_ID;

                    return SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Your rival has either cancelled the offer or has disconnected.");
                }
            }
            else return SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You do not have an active offer to cancel.");
        }

    }
    return 1;
}

IsChallengeValid(playerid, rival) {
    // TODO: Check if player and rival are both in a lowrider compatible vehicle (IsLowriderVehicle)

    // Player checks
    if(Lowrider[playerid][E_LOWRIDER_ACTIVE]) {
        SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You're already in an active game. Use {A3A3A3}/lowrider cancel{DEDEDE}.");
        return false;
    }
    if(Lowrider[playerid][E_LOWRIDER_RIVAL] != INVALID_PLAYER_ID) {
        SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You already have a rival! Use {A3A3A3}/lowrider cancel{DEDEDE}.");
        return false;
    }
    if(Lowrider[playerid][E_LOWRIDER_OFFER]) {
        SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "You already have an offer! Use {A3A3A3}/lowrider accept{DEDEDE} or {A3A3A3}/lowrider cancel{DEDEDE}.");
        return false;
    }

    // Rival checks
    if(Lowrider[rival][E_LOWRIDER_ACTIVE]) {
        SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Player is already in an active game.");
        return false;
    }
    if(Lowrider[rival][E_LOWRIDER_RIVAL] != INVALID_PLAYER_ID) {
        SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Player already has a rival!");
        return false;
    }
    if(Lowrider[rival][E_LOWRIDER_OFFER]) {
        SendServerMessage(playerid, COLOR_LOWRIDER, "Lowrider", "DEDEDE", "Player already has an offer!");
        return false;
    }
    return true;
}