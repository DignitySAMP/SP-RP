OnLoadTextdraws() {
	LoadFaderTextdraw () ;
	TutorialGUI_CreateStatic();
	ClassBrowser_LoadStaticDraws(); 
	mBrowser_LoadStaticDraws();
	GUI_LoadLockpickGUI();
	GUI_LoadHotwireGUI();

    pns_menu = CreateMenu("Pay'n'Spray", 1, 31.0, 180.0, 178.00);
    AddMenuItem(pns_menu, 0, "Respray Exterior");
    AddMenuItem(pns_menu, 0, "Respray Interior");
    AddMenuItem(pns_menu, 0, "Repair Bodywork");
    AddMenuItem(pns_menu, 0, "Repair Engine");
    AddMenuItem(pns_menu, 0, "Change Paintjob");
    AddMenuItem(pns_menu, 0, "Remove Paintjob");

}

OnLoadPlayerTextdraws(playerid) {

	mBrowser_LoadPlayerDraws(playerid);
	TutorialGUI_CreatePlayer(playerid);

	GUI_LoadLockpickPlayerGUI(playerid);
	GUI_LoadHotwirePlayerGUI(playerid);

	LoadMinigameHelpBox(playerid) ;

	GUI_LoadSpectatorPanel(playerid)  ;
	//GUI_LoadDirectionLabels(playerid) ;

	//Vehicle_LoadPlayerGUI(playerid) ;

	ClassBrowser_LoadPlayerDraws(playerid); 
}

OnDestroyPlayerTextdraws(playerid) {

	TutorialGUI_DestroyPlayer(playerid);
	mBrowser_DestroyPlayerDraws(playerid);

	GUI_DestroyLockpickPlayerGUI(playerid) ;
	GUI_DestroyHotwirePlayerGUI(playerid) ;

	DestroyMinigameHelpBox ( playerid ) ;

	GUI_DestroySpectatorPanel ( playerid ) ;
	//GUI_DestroyDirectionLabels(playerid) ;

	//Vehicle_DestroyPlayerOldGUI(playerid) ;	
	ClassBrowser_DestroyPlayerDraws(playerid) ;	

	TextDrawHideForPlayer(playerid, gBlindfoldTD);
	TextDrawHideForPlayer(playerid, E_ADMIN_DUTY_TEXT );
}