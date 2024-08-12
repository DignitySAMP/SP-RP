
OnPlayerBuyFood(playerid, type, constant) 
{
	switch ( constant ) 
	{
		case CLUCKINBELL_MENU_LOW, CLUCKINBELL_MENU_MED, CLUCKINBELL_MENU_HIGH, PIZZASTACK_MENU_HEALTHY, CLUCKINBELL_MENU_HEALTHY, BURGERSHOT_MENU_HEALTHY:
		{  
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, 2769, 6, 0.02, 0.04, 0.01, 86.50, -0.60, -111.30, 1.00, 1.00, 1.00);
			ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, false, 0, 0, 0, 0, 1);
		}
		case PIZZASTACK_MENU_LOW, PIZZASTACK_MENU_MED, PIZZASTACK_MENU_HIGH:
		{
			SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, 2702, 6, 0.03, 0.10, 0.00, 0.00, 0.00, 0.00, 1.00, 1.00, 1.00);
			ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, 0, 0, 0, 0, 1);
		}
		case BURGERSHOT_MENU_LOW, BURGERSHOT_MENU_MED, BURGERSHOT_MENU_HIGH:
		{
			SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,2703,6,0.093999,0.037999,0.015999,0.000000,0.000000,53.400005,1.000000,0.654999,1.000000);
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, 0, 0, 0, 0, 1);
		}
		case DONUTS_MENU_LOW, DONUTS_MENU_MED, DONUTS_MENU_HIGH: 
		{
			SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC, 11740, 6, 0.07, 0.07, 0.00, -6.69, 84.39, 0.00, 0.54, 0.50, 0.74);
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, false, 0, 0, 0, 0, 1);
		}

		case E_PROP_WHITE_BOX_CLOSED: 	SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,1544,6,0.085999,0.032000,-0.164000,0.000000,0.000000,0.000000,0.878999,0.880999,0.766999);
		case E_PROP_WHITE_BOX_OPEN: 	SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,1484,6,0.019999,0.004999,-0.005000,0.000000,37.199981,0.000000,1.000000,1.000000,1.000000);
		case E_PROP_GREEN_BOX_CLOSED:	SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,1486,6,0.094999,0.028000,-0.063999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000); 
		case E_PROP_GREEN_BOX_OPEN: 	SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,1950,6,0.077999,0.035999,-0.015000,0.000000,9.899999,2.499994,0.636000,0.596000,0.656000);
		case E_PROP_RED_BOX_CLOSED: 	SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,19823,6,0.081999,0.041000,-0.287999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
		case E_PROP_RED_BOX_OPEN: 		SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,1543,6,0.076999,0.034000,-0.176000,0.000000,0.000000,0.000000,1.000000,1.000000,0.882999);
		case E_PROP_BLUE_BOX_CLOSED:	SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,19822,6,0.094999,0.035000,-0.404999,0.000000,0.000000,0.000000,0.838999,0.810999,0.948000);
		case E_PROP_BLUE_BOX_OPEN: 		SetPlayerAttachedObject(playerid,E_ATTACH_INDEX_MISC,19821,6,0.096999,0.035000,-0.285000,0.000000,0.000000,0.000000,0.763000,0.611000,0.631999);
	}

	new propidx = -1;
	new Float: heal_amount = 5.0;

	if (type == E_INTERACT_TYPE_DRINK)
	{
		if (IsPlayerMale(playerid))
		{
			ApplyAnim(playerid, "GANGS", "drnkbr_prtl", 4.1, true, 0, 0, 1, 1, 1);
		}
		else
		{
			ApplyAnim(playerid, "GANGS", "drnkbr_prtl_F", 4.1, true, 0, 0, 1, 1, 1);
		}

		for (new i = 0; i < sizeof(PropItem); i ++)
		{
			if (PropItem[i][E_PROP_ITEM_CONST] == constant)
			{
				propidx = i;
				break;
			}
		}

		if (propidx >= 0)
		{
			if (PropItem[propidx][E_PROP_ITEM_MODELID] == E_VENDING_CAN_ECOLA_SMALL || PropItem[propidx][E_PROP_ITEM_MODELID] == E_VENDING_CAN_SPRUNK_SMALL)
			{
				SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, PropItem[propidx][E_PROP_ITEM_MODELID], 6, 0.01, 0.05, 0.00, 0.00, 177.50, -157.90, 1.00, 1.00, 1.00);
			}
			else
			{
				SetPlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC, PropItem[propidx][E_PROP_ITEM_MODELID], 6, 0.01, 0.07, 0.01, 0.00, 0.00, 0.00, 1.00, 1.00, 1.00);
			}			
		}

		Gym_AppendPlayerNeeds(playerid, E_GYM_STAT_THIRST, 3+random(4));
	}
	else if (type == E_INTERACT_TYPE_FOOD)
	{
		switch ( constant ) 
		{
			case CLUCKINBELL_MENU_HEALTHY, PIZZASTACK_MENU_HEALTHY, BURGERSHOT_MENU_HEALTHY: {
				
				Gym_AppendPlayerNeeds ( playerid, E_GYM_STAT_HUNGER, 1+random(3));
				heal_amount = 25.0 ;
			}
			case CLUCKINBELL_MENU_LOW, PIZZASTACK_MENU_LOW , BURGERSHOT_MENU_LOW, DONUTS_MENU_LOW: {
				
				Gym_AppendPlayerNeeds ( playerid, E_GYM_STAT_HUNGER, 2+random(3));
				heal_amount = 35.0 ;
			}
			case CLUCKINBELL_MENU_MED, PIZZASTACK_MENU_MED, BURGERSHOT_MENU_MED, DONUTS_MENU_MED: {
				
				Gym_AppendPlayerNeeds ( playerid, E_GYM_STAT_HUNGER, 3+random(4));
				heal_amount = 50.0 ;
			}
			case CLUCKINBELL_MENU_HIGH, PIZZASTACK_MENU_HIGH, BURGERSHOT_MENU_HIGH, DONUTS_MENU_HIGH: {
				
				Gym_AppendPlayerNeeds ( playerid, E_GYM_STAT_HUNGER, 4+random(5));
				heal_amount = 75.0 ;
			}
		}
	}
	
	new Float: heal = GetCharacterHealth ( playerid ) ;

	heal += heal_amount ;

	if ( heal > 100.0 ) 
	{
		// SendClientMessage(playerid, COLOR_YELLOW, "You have healed to full health." ) ;
		heal = 100.0 ;
	}

	SetCharacterHealth ( playerid, heal ) ;
	defer PropUse_ClearUseAnim(playerid);

	return true ;
}

timer PropUse_ClearUseAnim[3500](playerid ) {
	
	cmd_stopanim(playerid, "");
	RemovePlayerAttachedObject(playerid, E_ATTACH_INDEX_MISC ) ;

	return true ;
}