
hook OnPlayerSpawn(playerid) {
	
	if(PlayerVar [playerid] [ E_PLAYER_ANIM_PRELOADED ] == 0)
	{
	    LoadPlayerAnims(playerid);
	    PlayerVar [playerid] [ E_PLAYER_ANIM_PRELOADED ] = 1;
	}

	return 1;
}


PreloadAnimLib(playerid, const animlib[])
{
	return ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

LoadPlayerAnims(playerid)
{
    PreloadAnimLib(playerid, "PED");
	PreloadAnimLib(playerid, "CARRY");
	PreloadAnimLib(playerid, "SMOKING");
	PreloadAnimLib(playerid, "GANGS");
	PreloadAnimLib(playerid, "CRACK");
	PreloadAnimLib(playerid, "GHANDS");
	PreloadAnimLib(playerid, "GRAVEYARD");
	PreloadAnimLib(playerid, "MISC");
	PreloadAnimLib(playerid, "BEACH");
	PreloadAnimLib(playerid, "KISSING");
	PreloadAnimLib(playerid, "SWEET");
	PreloadAnimLib(playerid, "STRIP");
	PreloadAnimLib(playerid, "FOOD");
	PreloadAnimLib(playerid, "BOMBER");
	PreloadAnimLib(playerid, "GYMNASIUM");
	PreloadAnimLib(playerid, "ROB_BANK");
	PreloadAnimLib(playerid, "CLOTHES");
	return SecondLoad( playerid );
}

SecondLoad( playerid )
{
	PreloadAnimLib(playerid, "CAR");
	PreloadAnimLib(playerid, "DANCING");
	PreloadAnimLib(playerid, "BAR");
	PreloadAnimLib(playerid, "BD_FIRE");
	PreloadAnimLib(playerid, "BASEBALL");
	PreloadAnimLib(playerid, "CAMERA");
	PreloadAnimLib(playerid, "CASINO");
	PreloadAnimLib(playerid, "GHETTO_DB");
	PreloadAnimLib(playerid, "COP_AMBIENT");
	PreloadAnimLib(playerid, "COLT45");
	PreloadAnimLib(playerid, "FIGHT_B");
	PreloadAnimLib(playerid, "FIGHT_C");
	PreloadAnimLib(playerid, "FIGHT_E");
	PreloadAnimLib(playerid, "FAT");
	PreloadAnimLib(playerid, "ON_LOOKERS");
	PreloadAnimLib(playerid, "POLICE");
	PreloadAnimLib(playerid, "PLAYIDLES");
	PreloadAnimLib(playerid, "PAULNMAC");
	PreloadAnimLib(playerid, "PARK");
	PreloadAnimLib(playerid, "SWORD");
	PreloadAnimLib(playerid, "RIOT");
	PreloadAnimLib(playerid, "RAPPING");
	PreloadAnimLib(playerid, "WEAPONS");
	return ThirdLoad_New(playerid);
}

ThirdLoad_New(playerid) {

	PreloadAnimLib(playerid, "LOWRIDER");
	PreloadAnimLib(playerid, "PLAYIDLES");
	PreloadAnimLib(playerid, "CAR_CHAT");
	PreloadAnimLib(playerid, "BENCHPRESS");
	PreloadAnimLib(playerid, "AIRPORT");
	PreloadAnimLib(playerid, "BOX");
	PreloadAnimLib(playerid, "DEALER");
	PreloadAnimLib(playerid, "WUZI");

	return true ;
}