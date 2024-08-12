#define PROPERTY_INACTIVE_DAYS	21
#define PROPERTY_INACTIVE_SECONDS (PROPERTY_INACTIVE_DAYS * 86400)



// NEW
AutoSellProperty(prop_enum_id)
{
	new query[512], reason[128];
	new address[64], zone[64];

	GetCoords2DZone(Property [ prop_enum_id ] [ E_PROPERTY_EXT_X ], Property [ prop_enum_id ] [ E_PROPERTY_EXT_Y ], zone, sizeof ( zone ));
	GetPlayerAddress(Property [ prop_enum_id ] [ E_PROPERTY_EXT_X ], Property [ prop_enum_id ] [ E_PROPERTY_EXT_Y ], address );

	if (Property[prop_enum_id][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_HOUSE) format(reason, sizeof(reason), "Inactive House ID %d Sold (%d %s, %s)", Property [ prop_enum_id ] [ E_PROPERTY_ID ], prop_enum_id, address, zone);
	else if (Property[prop_enum_id][E_PROPERTY_TYPE] == E_PROPERTY_TYPE_BIZ) format(reason, sizeof(reason), "Inactive Business ID %d Sold (%d %s, %s)", Property [ prop_enum_id ] [ E_PROPERTY_ID ], prop_enum_id, address, zone);
	else format(reason, sizeof(reason), "Inactive Property ID %d Sold (%d %s, %s)", Property [ prop_enum_id ] [ E_PROPERTY_ID ], prop_enum_id, address, zone);

	inline OnAutoRefundProperty() 
	{
		if (cache_affected_rows())
		{
			new weapons = 0, drugs = 0;
			for (new x = 0; x < 10; x ++)
			{
				if (Property [ prop_enum_id ] [ E_PROPERTY_GUN ] [ x ] && Property [ prop_enum_id ] [ E_PROPERTY_AMMO ] [ x ])
				{
					// Create a refund each gun
					format(reason, sizeof(reason), "Was in Gun Slot %d of Inactive Property ID %d", x + 1, Property [ prop_enum_id ] [ E_PROPERTY_ID ]);
					mysql_format(mysql, query, sizeof(query), "INSERT INTO `refunds` (`refund_player_id`, `refund_type`, `refund_itemtype`, `refund_amount`, `refund_reason`) VALUES (%d, %d, %d, %d, '%e')", 
						Property [ prop_enum_id ] [ E_PROPERTY_OWNER ], 1, Property [ prop_enum_id ] [ E_PROPERTY_GUN ] [ x ], Property [ prop_enum_id ] [ E_PROPERTY_AMMO ] [ x ], reason);
					mysql_pquery(mysql, query);

					print(query);

					// 1 = REFUND_TYPE_WEAPON

					// Track how many were found
					weapons ++;
				}

				// Clear it out
				Property [ prop_enum_id ] [ E_PROPERTY_GUN ] [ x ] = 0;
				Property [ prop_enum_id ] [ E_PROPERTY_AMMO ] [ x ] = 0;
			}

			for (new x = 0; x < 10; x ++)
			{
				if (Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ x ] && Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ x ] > 0)
				{
					// Create a refund for each drug
					format(reason, sizeof(reason), "Was in Drug Slot %d of Inactive Property ID %d", x + 1, Property [ prop_enum_id ] [ E_PROPERTY_ID ]);
					mysql_format(mysql, query, sizeof(query), "INSERT INTO `refunds` (`refund_player_id`, `refund_type`, `refund_itemtype`, `refund_subtype`, `refund_infratype`, `refund_amount`, `refund_reason`) VALUES (%d, %d, %d, %d, %d, %f, '%e')", 
						Property [ prop_enum_id ] [ E_PROPERTY_OWNER ], 2, Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ x ], Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ x ], Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ x ], Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ x ], reason);
					mysql_pquery(mysql, query);

					// 2 = REFUND_TYPE_DRUG

					// Track how many were found
					drugs ++;
				}

				// Clear it out
				Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_TYPE ] [ x ] = 0 ;
				Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_PARAM ] [ x ] = 0;
				Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_CONTAINER ] [ x ]  = 0 ;
				Property [ prop_enum_id ] [ E_PROPERTY_DRUGS_AMOUNT ] [ x ] = 0.0 ;
			}

			// Reset the owner now that the refund is complete.
			Property [ prop_enum_id ] [ E_PROPERTY_OWNER ] = INVALID_PROPERTY_OWNER;
			mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_owner = %d WHERE property_id = %d", Property [ prop_enum_id ] [ E_PROPERTY_OWNER ], Property [ prop_enum_id ] [ E_PROPERTY_ID ]);
			mysql_pquery(mysql, query);

			// And clear out any guns/drugs in the database too
			for (new x = 0; x < 10; x ++)
			{
				mysql_format(mysql, query, sizeof(query), "UPDATE properties SET property_gun_%d = 0, property_ammo_%d = 0, property_drugs_type_%d = 0, property_drugs_param_%d = 0, property_drugs_container_%d = 0, property_drugs_amount_%d = 0 WHERE property_id = %d", x, x, x, x, x, x, Property [ prop_enum_id ] [ E_PROPERTY_ID ]);
				mysql_pquery(mysql, query);
			}

			printf("Successfully auto sold and refunded Property %d (SQL: %d) (Also refunded %d drugs and %d weapons)", prop_enum_id, Property [ prop_enum_id ] [ E_PROPERTY_ID ], drugs, weapons);
		}
	}

	// Refund the owner and wait before doing anything else.
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `refunds` (`refund_player_id`, `refund_amount`, `refund_reason`) VALUES (%d, %d, '%e')", Property [ prop_enum_id ] [ E_PROPERTY_OWNER ], Property [ prop_enum_id ] [ E_PROPERTY_PRICE ], reason);
	MySQL_TQueryInline(mysql, using inline OnAutoRefundProperty, query);
}

CheckInactiveProperties() {

	new query [ 96 ], owner_activity, count ;

	foreach(new i: Properties) {

		if ( Property [ i ] [ E_PROPERTY_ID ] != INVALID_PROPERTY_ID && Property [ i ] [ E_PROPERTY_OWNER ] > 0 ) {

			inline ReturnAccountLastLogin() {
				if ( cache_num_rows()) {

					cache_get_value_name_int(0, "player_logindate", owner_activity);

					if ( gettime() - owner_activity > PROPERTY_INACTIVE_SECONDS ) // 50 days
					{
						AutoSellProperty(i);

						count ++ ;
					}
				}
			}

			mysql_format ( mysql, query, sizeof ( query ), "SELECT player_logindate FROM characters WHERE player_id = %d", Property [ i ] [ E_PROPERTY_OWNER ] ) ;
			MySQL_TQueryInline(mysql, using inline ReturnAccountLastLogin, query, "");
		}

		else continue ;
	}
}