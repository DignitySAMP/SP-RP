

CMD:flip(playerid){
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");


	ClearAnimations(playerid); 
	ApplyAnimation(playerid,"ped", "KD_right", 4.0, 0, 0, 0, 1, 0);

	return true ;
}

CMD:facepalm( playerid, cmdtext[] )
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "MISC", "plyr_shkhead", 4.1, 0, 0, 0, 0, 0, 1);

	return 1;
}


CMD:stop ( playerid, params [] ) {

    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);

	return true ;
}


CMD:getup ( playerid, params [] ) {

    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "PED", "getup", 4.1, 0, 0, 0, 0, 0, 1);

	return true ;
}


CMD:gkick ( playerid, params [] ) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "FIGHT_D", "FightD_1", 4.1, 0, 0, 0, 0, 0, 1);

	return true ;
}

CMD:handsup(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:camcrouch ( playerid, params [] ) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");


	AnimationLoop(playerid, "CAMERA", "camcrch_idleloop", 4.1, 1, 0, 0, 0, 0, 1);

	return true ;
}

CMD:riflehold ( playerid, params [] ) {

    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "PED", "Gun_2_IDLE", 4.1, 0, 1, 1, 1, 1, 1); 

	return true ;
}


CMD:carryidle ( playerid, params [] ) {

	if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY ) ;

	return true ;
}


CMD:wash(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:bomb(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:jump(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "DODGE", "Crush_Jump", 4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}


CMD:goggles(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "goggles", "goggles_put_on", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:throw(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:swipe(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:cpr(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:slapass( playerid, params [] ) {

	if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

 	return AnimationLoop(playerid, "SWEET", "sweet_ass_slap", 4.1, 0, 0, 0, 0, 0, 1); // Ass Slapping
}


CMD:taichi(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "PARK", "Tai_Chi_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}


CMD:cover(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "PED", "cower", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:drunk(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "PED", "WALK_drunk", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}


CMD:fucku(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "PED", "fucku", 4.1, 0, 0, 0, 0, 0);
	return 1;
}



CMD:skate(playerid, params[]) {
	if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "SKATE", "skate_idle", 4.1, 1, 0, 0, 0, 0, 1);

	return 1;
}


CMD:plunger(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "MISC", "PLUNGER_01", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:slide(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "AIRPORT", "THRW_BARL_THRW", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}



CMD:driverko(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "BIKELEAP", "STRUGGLE_DRIVER", 4.1, 1, 0, 0, 0, 0, 1);	
	return 1;
}


CMD:gunhold(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "BUDDY", "BUDDY_RELOAD", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:cmon(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "CAMERA", "CAMCRCH_CMON", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:squat(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "CAMERA", "CAMCRCH_TO_CAMSTND", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:flagdrop(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "CAR", "FLAG_DROP", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:liftdown(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}


CMD:press(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "CRIB", "CRIB_USE_SWITCH",  4.1, 0, 0, 0, 0, 0, 1);

	return 1;
}


CMD:handstand(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "DAM_JUMP", "DAM_DIVE_LOOP",  4.1, 0, 0, 0, 1, 0, 1);

	return 1;
}


CMD:gethit(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "DILDO", "DILDO_HIT_1",  4.1, 0, 0, 0, 0, 0, 1);

	return 1;
}
CMD:knifehold(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "DILDO", "DILDO_IDLE",  4.1, 1, 0, 0, 0, 0, 1);

	return 1;
}


CMD:pointgun(playerid, params[])
{
    if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	AnimationLoop(playerid, "FAT", "FATIDLE_ROCKET",  4.1, 1, 0, 0, 0, 0, 1);

	return 1;
}
CMD:pistolwhip(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "FLOWERS", "FLOWER_ATTACK_M",  4.1, 0, 0, 0, 0, 0, 1);

	return 1;
}


CMD:laugh(playerid, params[]) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnim(playerid, "RAPPING", "Laugh_01", 4.1, false, 0, 0, 0, 0, 1);

	return true ;
}
CMD:cry(playerid, params[]) {
    if (!AnimationCheck(playerid))
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnim(playerid,  "GRAVEYARD", "mrnF_loop", 4.1, true, 0, 0, 0, 0, 1);

	return true ;
}


CMD:angry(playerid, params[]){

	if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnim(playerid, "RIOT", "RIOT_ANGRY", 4.1, true, false, false, false, 0, false); // dj 1

	return true;
}

CMD:patdown(playerid)
{
	if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 0, 0, 0, 2000, 1);
	return true;
}


static ForcedLoopingAnim(playerid, const animlib[], const animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    for (new i = 0; i < 10; i++)
    {
		AnimationLoop(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp, 1);
	}
}

CMD:jogging(playerid)
{
	if (!AnimationCheck(playerid, true)) // don't allow while cuffed
	    return SendServerMessage( playerid, COLOR_RED, "Animation", "DEDEDE", "You can't perform animations at the moment.");

	if (IsPlayerMale(playerid))
	{
		ForcedLoopingAnim(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 100);
	}
	else
	{
		ForcedLoopingAnim(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 100);
	}

	return true;
}

CMD:jog(playerid) return cmd_jogging(playerid);