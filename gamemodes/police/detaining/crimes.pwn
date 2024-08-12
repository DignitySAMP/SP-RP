//------------------------------------------------------------------------------
// Dialog based penal code
// Written by Sporky (www.github.com/sporkyspork) for SOLS (www.streetzofls.com)
// Descriptions from Los Santos Roleplay (RIP)

#define PD_MUGSHOT_X -14.5380
#define PD_MUGSHOT_Y -102.4791
#define PD_MUGSHOT_Z 898.5792

static enum E_CRIME_CLASS_INFO
{
	E_CRIME_CLASSES:E_CRIME_CLASS_CLASS,
    E_CRIME_CLASS_NAME[16],
    E_CRIME_CLASS_COLOR
}

static enum E_CRIME_CLASSES
{
	E_CRIME_CLASS_INFRACTION,
    E_CRIME_CLASS_MISDEMEANOR,
    E_CRIME_CLASS_FELONY
}

static const CrimeClass[][E_CRIME_CLASS_INFO] = 
{
	{E_CRIME_CLASS_INFRACTION, "Infraction", 0xE6EE9C},
    {E_CRIME_CLASS_MISDEMEANOR, "Misdemeanor", 0xFFB74D},
    {E_CRIME_CLASS_FELONY, "Felony", 0xEF5350}
};

static enum E_CRIME_COSTS
{
	E_CRIME_COST_FELONY_HIGH, 	// 90 - 180 minutes
	E_CRIME_COST_FELONY_MED,  	// 45 - 120 minutes
	E_CRIME_COST_FELONY_LOW,  	// 30 - 90 minutes
	E_CRIME_COST_MISD_HIGH,   	// 30 - 60 minutes
	E_CRIME_COST_MISD_MED,	  	// 15 - 30 minutes
	E_CRIME_COST_MISD_LOW,    	// 10 - 20 minutes
	E_CRIME_COST_INFRACT_HIGH,	// $450 - $975
	E_CRIME_COST_INFRACT_MED,	// $175 - $450
	E_CRIME_COST_INFRACT_LOW,	// $75 - $200
};

static enum E_CRIME_COST_INFO
{
	E_CRIME_COSTS:E_CRIME_COST_TYPE,
	E_CRIME_COST_MIN,
	E_CRIME_COST_MAX
}

static const CrimeCost[][E_CRIME_COST_INFO] = 
{
	{E_CRIME_COST_FELONY_HIGH, 120, 180},
	{E_CRIME_COST_FELONY_MED, 90, 120},
	{E_CRIME_COST_FELONY_LOW, 45, 90},
	{E_CRIME_COST_MISD_HIGH, 30, 60},
	{E_CRIME_COST_MISD_MED, 15, 30},
	{E_CRIME_COST_MISD_LOW, 10, 20},
	{E_CRIME_COST_INFRACT_HIGH, 450, 975},
	{E_CRIME_COST_INFRACT_MED, 175, 450},
	{E_CRIME_COST_INFRACT_LOW, 75, 200}
};

static enum E_CRIME_TITLES
{
    E_CRIME_TITLE_PERSON,
    E_CRIME_TITLE_PROPERTY,
    E_CRIME_TITLE_DECENCY,
    E_CRIME_TITLE_JUSTICE,
    E_CRIME_TITLE_PEACE,
    E_CRIME_TITLE_HEALTH,
    E_CRIME_TITLE_VEHICLE,
    E_CRIME_TITLE_WEAPON,
	E_CRIME_TITLE_TRAFFIC
};

static enum E_CRIME_TITLE_INFO
{
    E_CRIME_TITLES:E_CRIME_TITLE,
    E_CRIME_TITLE_NAME[32]
}

static const CrimeTitle[][E_CRIME_TITLE_INFO] =
{
	{E_CRIME_TITLE_PERSON, "Crimes against the Person"},
	{E_CRIME_TITLE_PROPERTY, "Crimes against Property"},
	{E_CRIME_TITLE_DECENCY, "Crimes against Public Decency"},
	{E_CRIME_TITLE_JUSTICE, "Crimes against Justice"},
	{E_CRIME_TITLE_PEACE, "Crimes against Public Peace"},
	{E_CRIME_TITLE_HEALTH, "Crimes against Public Health"},
	{E_CRIME_TITLE_VEHICLE, "Vehicluar Offenses"},
	{E_CRIME_TITLE_WEAPON, "Control of Lethal Equipment"},
	{E_CRIME_TITLE_TRAFFIC, "Infractions (Non Arrestable)"}
};

static enum E_CRIME_INFO
{
	E_CRIME_TYPES:E_CRIME_TYPE,
    E_CRIME_NAME[64],
    E_CRIME_TITLES:E_CRIME_TITLE,
    E_CRIME_CLASSES:E_CRIME_CLASS,
	E_CRIME_CODE[7],
	E_CRIME_COSTS:E_CRIME_COST
}

static enum E_CRIME_TYPES
{
	E_CRIME_TYPE_INTIMIDATION,
	E_CRIME_TYPE_ASSAULT,
	E_CRIME_TYPE_ADW,
	E_CRIME_TYPE_MUTUAL_COMBAT,
	E_CRIME_TYPE_BATTERY,
	E_CRIME_TYPE_AGGRAVATED_BATTERY,
	E_CRIME_TYPE_ATTEMPTED_MURDER,
	E_CRIME_TYPE_MANSLAUGHTER,
	E_CRIME_TYPE_MURDER,
	E_CRIME_TYPE_FALSE_IMPRISONMENT,
	E_CRIME_TYPE_KIDNAPPING,
	E_CRIME_TYPE_MAYHEM,
	E_CRIME_TYPE_VEHICULAR_MURDER,

	E_CRIME_TYPE_ARSON,
	E_CRIME_TYPE_TRESPASSING,
	E_CRIME_TYPE_AGG_TRESPASS,
	E_CRIME_TYPE_BURGLARY_TOOLS,
	E_CRIME_TYPE_ROBBERY,
	E_CRIME_TYPE_PETTY_THEFT,
	E_CRIME_TYPE_GRAND_THEFT,
	E_CRIME_TYPE_STOLEN_PROP,
	E_CRIME_TYPE_VANDALISM,

	E_CRIME_TYPE_LEWD_CONDUCT,
	E_CRIME_TYPE_INDECENT_EXPOSURE,
	E_CRIME_TYPE_PROSTITUTION,
	E_CRIME_TYPE_SOLICITING,
	E_CRIME_TYPE_PIMPING,
	E_CRIME_TYPE_SEXUAL_ASSAULT,
	E_CRIME_TYPE_SEXUAL_BATTERY,
	E_CRIME_TYPE_RAPE,
	E_CRIME_TYPE_STALKING,
	E_CRIME_TYPE_GAMING,

	E_CRIME_TYPE_BRIBERY,
	E_CRIME_TYPE_FAILURE_TO_PAY,
	E_CRIME_TYPE_DISSUADE_WITNESS,
	E_CRIME_TYPE_FALSE_INFORMATION,
	E_CRIME_TYPE_FALSE_COMPLAINT,
	E_CRIME_TYPE_FAIL_TO_IDENTIFY,
	E_CRIME_TYPE_IMPERSONATION,
	E_CRIME_TYPE_OBSTRUCT_OFFICER,
	E_CRIME_TYPE_RESIST_OFFICER,
	E_CRIME_TYPE_ESCAPE_CUSTODY,
	E_CRIME_TYPE_PRISONER_BREAKOUT,
	E_CRIME_TYPE_MISSUSE_HOTLINE,
	E_CRIME_TYPE_TAMPER_EVIDENCE,
	E_CRIME_TYPE_CORRUPTION,
	E_CRIME_TYPE_FACIAL_OBSTRUCTION,

	E_CRIME_TYPE_DISTURBING_PEACE,
	E_CRIME_TYPE_UNLAWFUL_ASSEMBLY,
	E_CRIME_TYPE_INCITEMENT_TO_RIOT,
	E_CRIME_TYPE_VIGILANTISM,
	E_CRIME_TYPE_DRUNK_IN_PUBLIC,

	E_CRIME_TYPE_POSESSION,
	E_CRIME_TYPE_POSESSION_SALE,
	E_CRIME_TYPE_PARAPHERNALIA,
	E_CRIME_TYPE_MANUFACTURE,
	E_CRIME_TYPE_SALE_CONTROLLED,
	E_CRIME_TYPE_UNDER_INFLUENCE,

	E_CRIME_TYPE_DRIVING_WITHOUT,
	E_CRIME_TYPE_EVADING,
	E_CRIME_TYPE_RECKLESS_EVADING,
	E_CRIME_TYPE_FLYING_WITHOUT,
	E_CRIME_TYPE_HIT_AND_RUN,
	E_CRIME_TYPE_RECKLESS_FLYING,
	E_CRIME_TYPE_RECKLESS_DRIVING,
	E_CRIME_TYPE_DRIVING_IMPAIRED,
	E_CRIME_TYPE_STREET_RACING,
	E_CRIME_TYPE_POSESS_NITRO,

	E_CRIME_TYPE_POSESS_WEAPON,
	E_CRIME_TYPE_POSESS_UNLICENSED,
	E_CRIME_TYPE_POSESS_ILLEGAL,
	E_CRIME_TYPE_POSESS_ASSAULT,
	E_CRIME_TYPE_DISTRIBUTE,
	E_CRIME_TYPE_POSESS_DESTRUCTIVE,
	E_CRIME_TYPE_POSESS_WEAPON_SALE,
	E_CRIME_TYPE_DESTRUCTIVE_SALE,
	E_CRIME_TYPE_BRANDISH_WEAPON,
	E_CRIME_TYPE_UNLAWFUL_DISCHARGE,
	E_CRIME_TYPE_SHOOT_FROM_VEHICLE,

	E_CRIME_TYPE_SPEEDING,
	E_CRIME_TYPE_U_TURN,
	E_CRIME_TYPE_RED_LIGHT,
	E_CRIME_TYPE_CROSS_DIVIDED,
	E_CRIME_TYPE_UNSAFE_PASSING,
	E_CRIME_TYPE_ILLEGAL_TINT,
	E_CRIME_TYPE_FAIL_SHOW_LICENSE,
	E_CRIME_TYPE_DRINKING_IN_CAR,
	E_CRIME_TYPE_SMOKING_IN_CAR,
	E_CRIME_TYPE_SEAT_BELT,
	E_CRIME_TYPE_HELMET,
	E_CRIME_TYPE_HEADLIGHTS,
	E_CRIME_TYPE_DRIVING_ON_PHONE,
	E_CRIME_TYPE_STOP_SIGN,
	E_CRIME_TYPE_IMPROPER_EQUIP,
	E_CRIME_TYPE_ILLEGAL_PARKING,
	E_CRIME_TYPE_IMPEDING,
	E_CRIME_TYPE_WRONG_SIDE,
	E_CRIME_TYPE_DRIVE_SIDEWALK,
	E_CRIME_TYPE_UNLAWFUL_RIDING,
	E_CRIME_TYPE_FAIL_TO_YIELD,
	E_CRIME_TYPE_JAYWALKING
}

static const Crime[][E_CRIME_INFO] = 
{
    {E_CRIME_TYPE_INTIMIDATION, "Intimidation", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_MISDEMEANOR, "422", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_ASSAULT, "Assault", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_MISDEMEANOR, "240", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_ADW, "Assault with a Deadly Weapon", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "245", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_MUTUAL_COMBAT, "Mutual Combat", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_MISDEMEANOR, "415(1)", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_BATTERY, "Battery", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_MISDEMEANOR, "242", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_AGGRAVATED_BATTERY, "Aggravated Battery", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "243(d)", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_ATTEMPTED_MURDER, "Attempted Murder", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "217", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_MANSLAUGHTER, "Manslaughter", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "192", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_MURDER, "Murder", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "187", E_CRIME_COST_FELONY_HIGH},
	{E_CRIME_TYPE_FALSE_IMPRISONMENT, "False Imprisonment", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_MISDEMEANOR, "236", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_KIDNAPPING, "Kidnapping", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "207", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_MAYHEM, "Mayhem", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "205", E_CRIME_COST_FELONY_HIGH},
	{E_CRIME_TYPE_VEHICULAR_MURDER, "Vehicular Murder", E_CRIME_TITLE_PERSON, E_CRIME_CLASS_FELONY, "191.5", E_CRIME_COST_FELONY_LOW},

	{E_CRIME_TYPE_ARSON, "Arson", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_FELONY, "451", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_TRESPASSING, "Trespassing", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_MISDEMEANOR, "602", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_AGG_TRESPASS, "Aggravated Trespass", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_FELONY, "601", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_BURGLARY_TOOLS, "Possession Of Burglary Tools", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_MISDEMEANOR, "466", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_ROBBERY, "Robbery", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_FELONY, "211", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_PETTY_THEFT, "Petty Theft", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_MISDEMEANOR, "484", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_GRAND_THEFT, "Grand Theft", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_FELONY, "487", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_STOLEN_PROP, "Receiving Stolen Property", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_MISDEMEANOR, "496", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_VANDALISM, "Vandalism", E_CRIME_TITLE_PROPERTY, E_CRIME_CLASS_MISDEMEANOR, "594", E_CRIME_COST_MISD_MED},

	{E_CRIME_TYPE_LEWD_CONDUCT, "Lewd Conduct", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_MISDEMEANOR, "647", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_INDECENT_EXPOSURE, "Indecent Exposure", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_MISDEMEANOR, "314", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_PROSTITUTION, "Prostitution", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_MISDEMEANOR, "647(b)", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_SOLICITING, "Soliciting Prostitution", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_MISDEMEANOR, "653(f)", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_PIMPING, "Pimping", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_FELONY, "655.23", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_SEXUAL_ASSAULT, "Sexual Assault", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_MISDEMEANOR, "241(e)", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_SEXUAL_BATTERY, "Sexual Battery", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_FELONY, "243(e)", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_RAPE, "Rape", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_FELONY, "261", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_STALKING, "Stalking", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_FELONY, "646", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_GAMING, "Gaming", E_CRIME_TITLE_DECENCY, E_CRIME_CLASS_MISDEMEANOR, "330", E_CRIME_COST_MISD_LOW},

	{E_CRIME_TYPE_BRIBERY, "Bribery", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "67", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_FAILURE_TO_PAY, "Failure to Pay a Fine", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "1320", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_DISSUADE_WITNESS, "Dissuading a Witness", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_FELONY, "136.1", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_FALSE_INFORMATION, "False Information to State Employee", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "148.9", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_FALSE_COMPLAINT, "Filing a False Complaint", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "148.5", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_FAIL_TO_IDENTIFY, "Failure to Identify", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "166", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_IMPERSONATION, "Impersonation of State Employee", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_FELONY, "538(d)", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_OBSTRUCT_OFFICER, "Obstruction of State Officer", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "69", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_RESIST_OFFICER, "Resisting a Police Officer", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "148", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_ESCAPE_CUSTODY, "Escape From Custody", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_FELONY, "4532", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_PRISONER_BREAKOUT, "Rescuing a Prisoner", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_FELONY, "4550", E_CRIME_COST_FELONY_LOW},
	{E_CRIME_TYPE_MISSUSE_HOTLINE, "Missuse of State Hotline", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "148.3", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_TAMPER_EVIDENCE, "Tampering With Evidence", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_FELONY, "141", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_CORRUPTION, "Corruption of Public Duty", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_FELONY, "424", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_FACIAL_OBSTRUCTION, "Masked Or Disguised To Evade Police", E_CRIME_TITLE_JUSTICE, E_CRIME_CLASS_MISDEMEANOR, "185", E_CRIME_COST_MISD_MED},

	{E_CRIME_TYPE_DISTURBING_PEACE, "Disturbing The Peace", E_CRIME_TITLE_PEACE, E_CRIME_CLASS_MISDEMEANOR, "415", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_UNLAWFUL_ASSEMBLY, "Unlawful Assembly", E_CRIME_TITLE_PEACE, E_CRIME_CLASS_MISDEMEANOR, "408", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_INCITEMENT_TO_RIOT, "Incitement to Riot", E_CRIME_TITLE_PEACE, E_CRIME_CLASS_FELONY, "404", E_CRIME_COST_MISD_HIGH},
	//{E_CRIME_TYPE_VIGILANTISM, "Vigilantism", E_CRIME_TITLE_PEACE, E_CRIME_CLASS_FELONY},
	{E_CRIME_TYPE_DRUNK_IN_PUBLIC, "Public Intoxication", E_CRIME_TITLE_PEACE, E_CRIME_CLASS_MISDEMEANOR, "647(f)", E_CRIME_COST_MISD_LOW},

	{E_CRIME_TYPE_POSESSION, "Posession of a Controlled Substance", E_CRIME_TITLE_HEALTH, E_CRIME_CLASS_MISDEMEANOR, "11350", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_POSESSION_SALE, "Posess. Controlled Substance for Sale", E_CRIME_TITLE_HEALTH, E_CRIME_CLASS_FELONY, "11351", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_PARAPHERNALIA, "Posession of Drug Paraphernalia", E_CRIME_TITLE_HEALTH, E_CRIME_CLASS_MISDEMEANOR, "11364", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_MANUFACTURE, "Manufacture of a Controlled Substance", E_CRIME_TITLE_HEALTH, E_CRIME_CLASS_FELONY, "11379", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_SALE_CONTROLLED, "Sale of a Controlled Substance", E_CRIME_TITLE_HEALTH, E_CRIME_CLASS_FELONY, "11352", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_UNDER_INFLUENCE, "Under Influence of a Controlled Substance", E_CRIME_TITLE_HEALTH, E_CRIME_CLASS_MISDEMEANOR, "11550", E_CRIME_COST_MISD_LOW},

	{E_CRIME_TYPE_DRIVING_WITHOUT, "Driving Without a Valid License", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "500", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_EVADING, "Evading a Police Officer", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "2800.1", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_RECKLESS_EVADING, "Felony Reckless Evading", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_FELONY, "2800.2", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_FLYING_WITHOUT, "Flying Without a License", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "500(b)", E_CRIME_COST_MISD_MED},
	{E_CRIME_TYPE_HIT_AND_RUN, "Hit And Run", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_FELONY, "480", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_RECKLESS_FLYING, "Reckless Operation of an Aircraft", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_FELONY, "505(b)", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_RECKLESS_DRIVING, "Reckless Operation of a Vehicle", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "505", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_DRIVING_IMPAIRED, "Driving While Impaired", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "502", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_STREET_RACING, "Street Racing", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "510", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_POSESS_NITRO, "Possession of Nitrous Oxide", E_CRIME_TITLE_VEHICLE, E_CRIME_CLASS_MISDEMEANOR, "510(n)", E_CRIME_COST_MISD_LOW},

	{E_CRIME_TYPE_POSESS_WEAPON, "Possession of a Prohibited Weapon", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_MISDEMEANOR, "16470", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_POSESS_UNLICENSED, "Possession of an Unlicensed Firearm", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_MISDEMEANOR, "25850", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_POSESS_ILLEGAL, "Possession of an Illegal Firearm", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "30510", E_CRIME_COST_MISD_HIGH},
	{E_CRIME_TYPE_POSESS_ASSAULT, "Possession of an Assault Weapon", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "30605", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_DISTRIBUTE, "Unlicensed Distribution of a Weapon", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "26500", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_POSESS_DESTRUCTIVE, "Possessing Destructive Devices", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "18710", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_POSESS_WEAPON_SALE, "Posess. Weaponry w/ Intent to Sell", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "30600", E_CRIME_COST_FELONY_MED},
	{E_CRIME_TYPE_DESTRUCTIVE_SALE, "Posess. Destructive Devices w/ Intent to Sell", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "18730", E_CRIME_COST_FELONY_HIGH},
	{E_CRIME_TYPE_BRANDISH_WEAPON, "Brandishing a Firearm", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_MISDEMEANOR, "417", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_UNLAWFUL_DISCHARGE, "Unlawful Discharge of a Firearm", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_MISDEMEANOR, "246", E_CRIME_COST_MISD_LOW},
	{E_CRIME_TYPE_SHOOT_FROM_VEHICLE, "Discharging a Firearm from a Vehicle", E_CRIME_TITLE_WEAPON, E_CRIME_CLASS_FELONY, "26100", E_CRIME_COST_FELONY_MED},

	{E_CRIME_TYPE_FAIL_SHOW_LICENSE, "Failure to Present a Driver's License", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "12951", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_RED_LIGHT, "Red Light Violation", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21453", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_WRONG_SIDE, "Driving on the Wrong Side of the Road", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21651", E_CRIME_COST_INFRACT_MED},
	{E_CRIME_TYPE_DRIVE_SIDEWALK, "Driving on the Sidewalk", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21663", E_CRIME_COST_INFRACT_HIGH},
	{E_CRIME_TYPE_UNLAWFUL_RIDING, "Unlawful Riding in a Vehicle", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21712", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_UNSAFE_PASSING,"Unsafe Passing", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21750", E_CRIME_COST_INFRACT_HIGH},
	{E_CRIME_TYPE_FAIL_TO_YIELD, "Failure to Yield", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21800", E_CRIME_COST_INFRACT_HIGH},
	{E_CRIME_TYPE_JAYWALKING, "Jaywalking", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "21955", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_U_TURN, "Illegal U-Turn", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "22100", E_CRIME_COST_INFRACT_MED},
	{E_CRIME_TYPE_SPEEDING, "Speeding", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "22350", E_CRIME_COST_INFRACT_MED},
	{E_CRIME_TYPE_IMPEDING, "Driving too Slowly", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "22400", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_ILLEGAL_PARKING, "Improper Parking, Stopping or Standing", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "22500", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_DRIVING_ON_PHONE, "Cell Phone Violation", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "23123", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_DRINKING_IN_CAR, "Drinking or Smoking in a Motor Vehicle", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "23221", E_CRIME_COST_INFRACT_MED},
	{E_CRIME_TYPE_IMPROPER_EQUIP, "Operating an Unsafe or Unlawfully Equipped Vehicle", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "24002", E_CRIME_COST_INFRACT_MED},
	{E_CRIME_TYPE_HEADLIGHTS, "Driving in Darkness Without Headlights", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "24250", E_CRIME_COST_INFRACT_MED},
	{E_CRIME_TYPE_ILLEGAL_TINT, "Window Tinting", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "26708", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_SEAT_BELT, "Seat Belt Violation", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "27315", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_HELMET, "Riding a Motorcycle Without a Helmet", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "27803", E_CRIME_COST_INFRACT_LOW},
	{E_CRIME_TYPE_STOP_SIGN, "Disobeying a Sign, Signal or Traffic Control Device", E_CRIME_TITLE_TRAFFIC, E_CRIME_CLASS_INFRACTION, "38300", E_CRIME_COST_INFRACT_MED}
};

static enum E_CRIME_DESC_INFO
{
    E_CRIME_TYPES:E_CRIME_DESC_CRIME_TYPE,
    E_CRIME_DESC_TEXT[200]
}

static const CrimeDesc[][E_CRIME_DESC_INFO] = 
{
    {E_CRIME_TYPE_INTIMIDATION,"A person who communicates to another that they will physically harm them, placing such other in a reasonable state of fear for their own safety."},
	{E_CRIME_TYPE_INTIMIDATION,"A person who communicates that they will physically harm another person's close friends or relatives."},
	{E_CRIME_TYPE_ASSAULT,"A person who intentionally puts another in the reasonable belief of imminent physical harm or offensive contact."},
	{E_CRIME_TYPE_ADW,"A person who attempts to cause or threaten harm to another while using a weapon or other dangerous item to communicate that threat."},
	{E_CRIME_TYPE_MUTUAL_COMBAT,"A person who engages in mutual combat with another in a public area, or in public view, regardless of consent."},
	{E_CRIME_TYPE_BATTERY,"A person who uses intentional and unlawful force or violence to cause physical harm to another person."},
	{E_CRIME_TYPE_AGGRAVATED_BATTERY,"A person who uses great or continued force or violence against another person and causes severe harm."},
	{E_CRIME_TYPE_AGGRAVATED_BATTERY,"A person that uses a weapon, tool or other dangerous item to cause severe harm to a person(s)."},
	{E_CRIME_TYPE_AGGRAVATED_BATTERY,"{FFFF00}This charge cannot stack with Battery"},
	{E_CRIME_TYPE_ATTEMPTED_MURDER,"A person who deliberately and intentionally attempts to kill or cause life threatening harm to another person through premeditated actions."},
	{E_CRIME_TYPE_ATTEMPTED_MURDER,"A person who, by criminal accident, negligence, or in the heat of passion, causes severe or life threatening bodily harm to another person."},
	{E_CRIME_TYPE_MANSLAUGHTER,"A person who unintentionally kills another, with or without a quarrel or heat of passion."},
	{E_CRIME_TYPE_MANSLAUGHTER,"A person who, through a criminal accident or negligence, causes someone's death."},
	{E_CRIME_TYPE_MURDER,"A person who unlawfully kills another with malice aforethought"},
	{E_CRIME_TYPE_MURDER,"A person who commits murder while engaging in a felony offense that has been proven to be a premeditated act."},
	{E_CRIME_TYPE_FALSE_IMPRISONMENT,"A person who detains or arrests another without their consent without premeditated intent or ransom for less than one hour."},
	{E_CRIME_TYPE_FALSE_IMPRISONMENT,"A person who performs an unlawful citizen's arrest."},
	{E_CRIME_TYPE_FALSE_IMPRISONMENT,"{FFFF00}This charge cannot stack with Kidnapping"},
	{E_CRIME_TYPE_KIDNAPPING,"A person who detains or arrests another without their consent with the premeditated intent to do so."},
	{E_CRIME_TYPE_KIDNAPPING,"A person who detains or arrests another without their consent for more than one hour."},
	{E_CRIME_TYPE_KIDNAPPING,"A person who detains or arrests another without their consent with the intent or decision to hold that individual for ransom of any kind."},
	{E_CRIME_TYPE_KIDNAPPING,"{FFFF00}This charge cannot stack with False Imprisonment"},
	{E_CRIME_TYPE_MAYHEM,"A person who intentionally causes extreme pain and suffering to a person, with or without permanent damage to the body."},
	{E_CRIME_TYPE_MAYHEM,"A person who causes pain and suffering for the purpose of revenge, extortion, persuasion, or for any sadistic purpose."},
	{E_CRIME_TYPE_MAYHEM,"A person who intentionally disfigures, disables, or aggressively destroys or damages a body part or area of a body or person's body."},
	{E_CRIME_TYPE_VEHICULAR_MURDER,"A person who, while operating a motor vehicle in a severely reckless and deliberate manner, causes someone's death."},
	{E_CRIME_TYPE_VEHICULAR_MURDER,"A person who while Evading Peace Officers in a motor vehicle, directly or indirectly causes someone's death."},

	{E_CRIME_TYPE_ARSON,"A person who intentionally and maliciously sets fire to or burns any structure, forest land, or property without prior authorization."},
	{E_CRIME_TYPE_ARSON,"A person who intentionally aids, counsels, or helps facilitate the burning of any structure, forest land, or property without proper authorization."},
	{E_CRIME_TYPE_ARSON,"A person who, through criminal accident or negligence, causes a fire to burn any structure, forest land, or property."},
	{E_CRIME_TYPE_TRESPASSING,"A person who enters another's property while it is closed or not in operation without the expressed or written permission to do so."},
	{E_CRIME_TYPE_TRESPASSING,"A person who enters the restricted area of an open facility or property as defined and clearly marked by the owner without permission."},
	{E_CRIME_TYPE_TRESPASSING,"{FFFF00}This cannot stack with Aggravated Trespass or Burglary."},
	{E_CRIME_TYPE_AGG_TRESPASS,"A person who, without proper authorization, enters any government facility or restricted section within one."},
	{E_CRIME_TYPE_AGG_TRESPASS,"{FFFF00}This charge cannot stack with Trespassing"},
	{E_CRIME_TYPE_BURGLARY_TOOLS,"A person who has in their possession the tools necessary to commit burglary like a screwdriver or other appropriate items."},
	{E_CRIME_TYPE_BURGLARY_TOOLS,"{FFFF00}This charge requires reasonable suspicion that the item is to be used for burglary."},
	{E_CRIME_TYPE_ROBBERY,"A person who takes property from the possession of another against their will, by means of force or fear."},
	{E_CRIME_TYPE_ROBBERY,"A person who takes property from the possession of another against their will, by means of a weapon."},
	{E_CRIME_TYPE_ROBBERY,"{FFFF00}This charge cannot stack with Theft."},

	{E_CRIME_TYPE_PETTY_THEFT,"A person who steals or takes the personal property of another worth less than $5,000."},
	{E_CRIME_TYPE_PETTY_THEFT,"{FFFF00}This charge cannot stack with Robbery."},
	{E_CRIME_TYPE_GRAND_THEFT,"A person who steals or takes the personal property of another worth $5,000 or more."},
	{E_CRIME_TYPE_GRAND_THEFT,"A person who steals or takes without consent the vehicle of another regardless of its market value."},
	{E_CRIME_TYPE_GRAND_THEFT,"A person who commits theft of any firearm, no matter the value or whether it is registered."},
	{E_CRIME_TYPE_GRAND_THEFT,"{FFFF00}This charge cannot stack with Robbery."},
	{E_CRIME_TYPE_STOLEN_PROP,"A person who knowingly buys or receives any property that has been stolen or that has been obtained in any manner constituting theft or extortion."},
	{E_CRIME_TYPE_VANDALISM,"A person that defaces, damages, or destroys property which belongs to another."},

	{E_CRIME_TYPE_LEWD_CONDUCT,"A person who solicits anyone to engage in sexual or suggestive conduct in any public place or any place exposed to public view."},
	{E_CRIME_TYPE_LEWD_CONDUCT,"A person who engages in inappropriate sexual or sexually suggestive conduct in any public place or in any place exposed to public view."},
	{E_CRIME_TYPE_LEWD_CONDUCT,"A person who solicits sexual activity in a public place or any place open to public view."},
	{E_CRIME_TYPE_INDECENT_EXPOSURE,"A person who intentionally exposes their naked body or genitalia on public property or in the public area of a privately owned business."},
	{E_CRIME_TYPE_INDECENT_EXPOSURE,"A person who intentionally exposes their naked body or genitalia on private property without permission of the property owner."},
	{E_CRIME_TYPE_INDECENT_EXPOSURE,"A person who engages in sex or other sexual activity in plain view of a minor."},
	{E_CRIME_TYPE_PROSTITUTION,"A person who knowingly engages in a sexual act in return for payment, goods, services or other items of value."},
	{E_CRIME_TYPE_SOLICITING,"A person who offers payment, goods, services or other items of value to an individual in exchange for sexual acts."},
	{E_CRIME_TYPE_SOLICITING,"A person who solicits or advertises, aids or provides transport or supervises persons involved in prostitution and retains some or all of the money earned."},
	{E_CRIME_TYPE_SEXUAL_ASSAULT,"A person who commits verbal abuse for the purpose of sexual arousal, gratification, or abuse."},
	{E_CRIME_TYPE_SEXUAL_ASSAULT,"A person who threatens imminent harm or nonconsensual sexual contact or puts another under the belief of imminent harm or nonconsensual sexual contact."},
	{E_CRIME_TYPE_SEXUAL_BATTERY,"A person who commits unwanted touching or sexual contact."},
	{E_CRIME_TYPE_SEXUAL_BATTERY,"A person who causes battery or similar aggressive physical contact for the purpose of sexual arousal, gratification, or abuse."},
	{E_CRIME_TYPE_RAPE,"A person who forces another to engage in sexual intercourse."},
	{E_CRIME_TYPE_RAPE,"A person who performs non consensual sexual intercourse with another."},
	{E_CRIME_TYPE_RAPE,"A person who performs sexual intercourse with another who is incapacitated, disabled, or unable to give consent."},
	{E_CRIME_TYPE_STALKING,"A person who intentionally and maliciously follows or harasses another person who has made it known that they do not consent to such following or harassment."},
	{E_CRIME_TYPE_STALKING,"A person who violates an official restraining order issued by a court."},
	{E_CRIME_TYPE_GAMING,"A person who deals, conducts, or causes to be played any game for money or other representative of value."},
	{E_CRIME_TYPE_GAMING,"Or, any person who played or bet at or against any such game."},
	{E_CRIME_TYPE_GAMING,"Where the game is a banking game played against a banker or dealer with cards, dice or any other device."},
	{E_CRIME_TYPE_GAMING,"Or where the banker or dealer of the game collects a percentage or \"rake\" of the stakes bet."},
	{E_CRIME_TYPE_GAMING, "{FFFF00}Unless the game, dealer and venue are regulated, licensed and approved by a proper state authority."},
	{E_CRIME_TYPE_GAMING,"{FFFF00}This charge does not apply to social poker games if there is no \"rake\" taken from a percentage of the bets placed."},

	{E_CRIME_TYPE_BRIBERY,"A person who offers or gives a monetary gift, gratuity, valuable goods, or other reward to a public official in an attempt to influence their duties or actions."},
	{E_CRIME_TYPE_BRIBERY,"A person who gives services or nonmaterial, but valuable actions to a public official in an attempt to influence their duties or actions."},
	{E_CRIME_TYPE_FAILURE_TO_PAY,"A person who fails to pay a fine or court-ordered fee within clearly stated and allotted time period."},
	{E_CRIME_TYPE_DISSUADE_WITNESS,"A person who knowingly and maliciously prevents or encourages any witness or victim from assisting an investigation."},
	{E_CRIME_TYPE_DISSUADE_WITNESS,"A person who prevents the distribution, completion, answering, or due process of an affidavit or other legal statement."},
	{E_CRIME_TYPE_FALSE_INFORMATION,"A person who provides false information or details to a peace officer during the course of a criminal investigation or lawful detainment."},
	{E_CRIME_TYPE_FALSE_INFORMATION,"A person who provides false information or details to a government employee during the course of an investigation."},
	{E_CRIME_TYPE_FALSE_INFORMATION,"A person who provides false information or details against another person(s) in a police report or other legal document."},
	{E_CRIME_TYPE_FALSE_COMPLAINT,"A person who knowingly files a false complaint or statement for the purpose of initiating false administrative or enforcement action against that person."},
	{E_CRIME_TYPE_FAIL_TO_IDENTIFY,"A person who, while being detained, fails to provide an officer their name as it appears on an I.D. card or other identifiable information for MDC purposes."},
	{E_CRIME_TYPE_IMPERSONATION,"A person who pretends or implies the role of a government worker, such as a peace officer, paramedic, tax collector, federal investigator, or other official."},
	{E_CRIME_TYPE_IMPERSONATION,"A person who wears, without authority, an official or realistic government employee uniform with an official or realistic badge or identification tag."},
	{E_CRIME_TYPE_IMPERSONATION,"A person who claims to be a government worker in order to deceive or take advantage of another individual or organization."},
	{E_CRIME_TYPE_OBSTRUCT_OFFICER,"A person who shows a clear and motivated attempt to prevent a government employee from conducting their duties."},
	{E_CRIME_TYPE_OBSTRUCT_OFFICER,"A person who fails to comply with an officer's lawful orders."},
	{E_CRIME_TYPE_OBSTRUCT_OFFICER,"A person who, after being issued a ticket, citation, or infraction, continues to violate such law and ignore an officer's orders."},
	{E_CRIME_TYPE_OBSTRUCT_OFFICER,"A person who enters a crime scene after being told to stop and turn away by a Peace Officer."},
	{E_CRIME_TYPE_RESIST_OFFICER,"A person who avoids apprehension from an officer by non-vehicular means or resists apprehension by any physical means."},
	{E_CRIME_TYPE_RESIST_OFFICER,"{FFFF00}This charge does not include the attempt to flee and evade by vehicular means, which is Evading a Peace Officer."},
	{E_CRIME_TYPE_ESCAPE_CUSTODY,"A person who has been physically detained by a peace officer and escapes from said Peace Officer's personal custody."},
	{E_CRIME_TYPE_ESCAPE_CUSTODY,"Any person arrested, booked, charged, or convicted of any crime who thereafter escapes from a police station, jail or prison."},
	{E_CRIME_TYPE_PRISONER_BREAKOUT,"A person who directly aids or assists an inmate with escaping from the law, including the lawful custody of a peace officer or incarceration."},
	{E_CRIME_TYPE_PRISONER_BREAKOUT,"A person who provides information or insights that subsequently assist an inmate with escaping from the law."},
	{E_CRIME_TYPE_MISSUSE_HOTLINE,"A person who uses an emergency government hotline for any purpose other than an emergency situation."},
	{E_CRIME_TYPE_MISSUSE_HOTLINE,"A person who uses any non-emergency or public hotline for purposes irrelevant to that particular government office, department, or agency."},
	{E_CRIME_TYPE_MISSUSE_HOTLINE,"A person who performs prank calls, fake calls, or tries to incite mayhem through public government lines."},
	{E_CRIME_TYPE_TAMPER_EVIDENCE,"A person who destroys or attempts to destroy, conceal, or alter any evidence that can later potentially be used in a criminal investigation or court proceeding."},
	{E_CRIME_TYPE_CORRUPTION,"A government employee who acts outside the interests of the public good or public justice."},
	{E_CRIME_TYPE_CORRUPTION,"A government employee who demonstrates criminal negligence in their duties."},

	{E_CRIME_TYPE_DISTURBING_PEACE,"A person who creates a dangerous or intimidating situation in a public place or in the public area of private property."},
	{E_CRIME_TYPE_DISTURBING_PEACE,"A person who attempts to provoke, incite, or promote harm to another person through gestures, language, claims, actions, or other methods."},
	{E_CRIME_TYPE_DISTURBING_PEACE,"A person whose profanity, language, voice, or noise reasonably disturbs nearby civilians or intends to incite violence."},
	{E_CRIME_TYPE_UNLAWFUL_ASSEMBLY,"A person who refuses to leave public property after being ordered to do so by its state agency property manager or a peace officer."},
	{E_CRIME_TYPE_UNLAWFUL_ASSEMBLY,"A person who refuses to leave the scene of a crime or other area after being ordered to so whose presence could hinder police operations."},
	{E_CRIME_TYPE_UNLAWFUL_ASSEMBLY,"A group that fails to protest or demonstrate peacefully in a designated 'free speech zone' or without proper permits or authorization from the city."},
	{E_CRIME_TYPE_UNLAWFUL_ASSEMBLY,"A person who refuses to leave private property they were invited to access after being instructed to do so by the property owner or manager."},
	{E_CRIME_TYPE_UNLAWFUL_ASSEMBLY,"{FFFF00}This charge cannot stack with Trespassing of any kind."},
	{E_CRIME_TYPE_INCITEMENT_TO_RIOT,"A person whose actions agitate a group of people organized or located peacefully in a public or private area in order to promote acts of violence or civil unrest."},
	{E_CRIME_TYPE_INCITEMENT_TO_RIOT,"Gang members whose actions in a public area intend to incite violence, encourage mayhem, or promote civil unrest."},
	{E_CRIME_TYPE_VIGILANTISM,"An unauthorized person attempting to enforce the law."},
	{E_CRIME_TYPE_FACIAL_OBSTRUCTION,"A person who wears any mask, hood, or facial obstruction in any public place that refuses to remove the obstruction upon order of a peace officer."},
	{E_CRIME_TYPE_FACIAL_OBSTRUCTION,"A person who wears any mask, hood, or facial obstruction while committing a crime, regardless of the purpose of the obstruction."},
	{E_CRIME_TYPE_DRUNK_IN_PUBLIC,"A person in any public place under the influence of intoxicating liquor to the extent they can no longer care for themselves or others."},
	{E_CRIME_TYPE_DRUNK_IN_PUBLIC,"A person described as above that interferes with, obstructs or prevents the free use of any public street, sidewalk or roadway."},
	{E_CRIME_TYPE_DRUNK_IN_PUBLIC,"{FFFF00}This charge cannot stack with Under Influence of Controlled Substance."},

	{E_CRIME_TYPE_POSESSION,"A person who possesses any controlled substance, except when the substance has been lawfully prescribed to them."},
	{E_CRIME_TYPE_POSESSION,"{FFFF00}This charge cannot stack with Posession of a Controlled Substance - Intent to Sell."},
	{E_CRIME_TYPE_POSESSION_SALE,"A person in possession of a controlled substance or multiple controlled substances (combined) in an amount of over 10.0 grams."},
	{E_CRIME_TYPE_POSESSION_SALE,"{FFFF00}This charge cannot stack with Posession of a Controlled Substance."},
	{E_CRIME_TYPE_PARAPHERNALIA,"A person who willingly possesses a device or mechanism used exclusively for the processing or consumption of a controlled substance."},
	{E_CRIME_TYPE_MANUFACTURE,"A person who manufactures, compounds, converts, produces, or prepares, either directly or indirectly, any controlled substance."},
	{E_CRIME_TYPE_SALE_CONTROLLED,"A person who sells, or offers to sell, a controlled substance to another person, regardless of whether or not they possess it."},
	{E_CRIME_TYPE_UNDER_INFLUENCE,"A person who uses or is under the influence of a controlled substance without the proper permits to use such a substance."},
	{E_CRIME_TYPE_UNDER_INFLUENCE,"{FFFF00}This charge cannot stack with Posession of a Controlled Substance of any kind."},

	{E_CRIME_TYPE_DRIVING_WITHOUT,"A person who drives a vehicle, whether on land, sea, or in air, without a license."},
	{E_CRIME_TYPE_DRIVING_WITHOUT,"A person who drives a vehicle, whether on land, sea, or in air, while having a suspended license or authorization."},
	{E_CRIME_TYPE_EVADING,"A person who, while operating a vehicle or bicycle wilfully flees or otherwise attempts to evade a pursuing peace officer."},
	{E_CRIME_TYPE_EVADING,"Note that the person must have been given reasonable time and audible + visual warnings to stop."},
	{E_CRIME_TYPE_EVADING,"{FFFF00}This charge does not include an attempt to flee or evade by foot, which is Resisting a Police Officer."},
	{E_CRIME_TYPE_EVADING,"{FFFF00}This charge does not apply if the person was only a passenger who never operated a vehicle for the purpose of fleeing."},
	{E_CRIME_TYPE_RECKLESS_EVADING,"A person who, while Evading a Police Officer, does so with dangerous disregard for the safety of persons or property."},
	{E_CRIME_TYPE_RECKLESS_EVADING,"{FFFF00}This charge can not stack with Evading a Police Officer or with Reckless Driving."},
	{E_CRIME_TYPE_RECKLESS_EVADING,"{FFFF00}This charge does not apply if the person was only a passenger who never operated a vehicle for the purpose of fleeing."},
	{E_CRIME_TYPE_FLYING_WITHOUT,"A person operating an aircraft without a proper license or authorization."},
	{E_CRIME_TYPE_HIT_AND_RUN,"A person who hits another person or occupied vehicle and leaves the scene of the accident."},
	{E_CRIME_TYPE_HIT_AND_RUN,"A person involved in the accident who after being requested to, fails to disclose their identity or provides false and misleading information."},
	{E_CRIME_TYPE_RECKLESS_FLYING,"A person who demonstrates careless or general disregard for the safety of themselves or others while operating an aircraft."},
	{E_CRIME_TYPE_RECKLESS_FLYING,"A person who performs stunts or dangerous aeronautical maneuvers while over populated areas or while dangerously close to other aircraft."},
	{E_CRIME_TYPE_RECKLESS_FLYING,"A person who fails to give appropriate distance or clearance to another aircraft in operation."},
	{E_CRIME_TYPE_RECKLESS_DRIVING,"A person who demonstrates deliberate disregard for the safety of themselves or others while operating a vehicle."},
	{E_CRIME_TYPE_RECKLESS_DRIVING,"{FFFF00}This cannot stack with Vehicular Endangerment."},
	{E_CRIME_TYPE_DRIVING_IMPAIRED,"A person who drives a vehicle or operates heavy machinery while under the influence and impairment of alcohol."},
	{E_CRIME_TYPE_STREET_RACING,"Performing an unlicensed or unauthorized vehicle race, performance, or competition on public property or roads."},
	{E_CRIME_TYPE_STREET_RACING,"Performing a vehicle race on a hazardous private course."},
	{E_CRIME_TYPE_STREET_RACING,"Organizing, facilitating, or promoting a street race or other unlicensed or organized vehicle race or competition on public property or roads."},
	{E_CRIME_TYPE_POSESS_NITRO,"A person who drives a vehicle that contains, possesses, or shows characteristics of nitrous oxide equipment use while not on a official speedway or race track."},

	{E_CRIME_TYPE_POSESS_WEAPON,"A civilian who possesses a nightstick, brass knuckles, or any bladed melee weapon."},
	{E_CRIME_TYPE_POSESS_UNLICENSED,"A civilian who carries a legal, but unlicensed weapon on their person, in their vehicle, place of business, or other facility without proper permits."},
	{E_CRIME_TYPE_POSESS_UNLICENSED,"A person who knowingly and willingly allows another person to carry a weapon on their person, in their vehicle, place of business, or other facility without proper permits."},
	{E_CRIME_TYPE_POSESS_ILLEGAL,"A civilian who possesses any firearm that is illegal in possession or not considered part of any legal weapon type."},
	{E_CRIME_TYPE_POSESS_ILLEGAL,"A person who possesses a firearm that contains illegal modifications in its design including, but not limited to, fully automatic firearms, magazine extensions, and silencers."},
	{E_CRIME_TYPE_POSESS_ILLEGAL,"{FFFF00}This includes Silenced Pistols, TEC-9s, MP5s, Uzis and Sawed-off Shotguns."},
	{E_CRIME_TYPE_POSESS_ASSAULT,"A civilian who possesses an illegal firearm which uses high-velocity, high-caliber, or specialized ammunition."},
	{E_CRIME_TYPE_POSESS_ASSAULT,"{FFFF00}This includes an M4, AK-47, Sniper Rifle or Combat Shotgun."},
	{E_CRIME_TYPE_DISTRIBUTE,"A person who participates in the illegal distribution of any weapon without proper permits or authorization."},
	{E_CRIME_TYPE_DISTRIBUTE,"A person who offers to sell any weapon without proper permits or authorization."},
	{E_CRIME_TYPE_POSESS_DESTRUCTIVE,"A civilian who possesses any manufactured or improvised device or equipment which is made from explosive and/or highly flammable liquid, gas or solid materials."},
	{E_CRIME_TYPE_POSESS_WEAPON_SALE,"A person who is in possession of more than three full weapons."},
	{E_CRIME_TYPE_POSESS_WEAPON_SALE,"A person who is in possession of weapon components or materials in any amount."},
	{E_CRIME_TYPE_DESTRUCTIVE_SALE,"A person who is in possession of more than 1 explosive devices or explosive device materials in any combination with the intent to distribute, deliver, or sell."},
	{E_CRIME_TYPE_BRANDISH_WEAPON,"A person who is pointing, holding, or brandishing a firearm, or object that appears like a firearm in an attempt to elicit fear or hysteria."},
	{E_CRIME_TYPE_BRANDISH_WEAPON,"A person holding an object in a manner similar to a firearm who attempts to elicit the same fear or response as brandishing an actual firearm."},
	{E_CRIME_TYPE_UNLAWFUL_DISCHARGE,"A person who fires a firearm without due cause or justifiable motive regardless of registration status or legality."},
	{E_CRIME_TYPE_UNLAWFUL_DISCHARGE,"A person committing this offense from a vehicle, whether land, sea, or in air, shall instead be charged with Discharging a Firearm From A Vehicle"},
	{E_CRIME_TYPE_SHOOT_FROM_VEHICLE,"A person who drives a vehicle and has a passenger who they knowingly and willingly let discharge a firearm from within the vehicle."},
	{E_CRIME_TYPE_SHOOT_FROM_VEHICLE,"A person who exits a vehicle only to immediately discharge a firearm afterward."},
	{E_CRIME_TYPE_SHOOT_FROM_VEHICLE,"A person who discharges a weapon in a vehicle, whether on land, sea, or in air, and is not an on-duty peace officer with proper authorization."},

	{E_CRIME_TYPE_FAIL_SHOW_LICENSE, "A person driving a vehicle who fails to present their license upon demand by a Police Officer acting with probable cause."},
	{E_CRIME_TYPE_RED_LIGHT, "A person driving a vehicle who does not bring their vehicle to a complete stop at a red traffic light."},
	{E_CRIME_TYPE_WRONG_SIDE, "Driving to the left of a barrier or central dividing marking is driving on the left side of the road."},
	{E_CRIME_TYPE_WRONG_SIDE, "A motorist is driving on the wrong side of the road if he or she does this."},
	{E_CRIME_TYPE_WRONG_SIDE, "{FFFF00}Unless the the vehicle was temporarily driven on the wrong side for a legitimate emergency purpose."},
	{E_CRIME_TYPE_DRIVE_SIDEWALK, "A person who operates or moves a motor vehicle upon a pedestrian sidewalk."},
	{E_CRIME_TYPE_DRIVE_SIDEWALK, "{FFFF00}Except as may be necessary to enter or leave adjacent property."},
	{E_CRIME_TYPE_UNLAWFUL_RIDING, "Allowing a passenger to ride in vehicles or parts of vehicles that are not intended for passengers."},
	{E_CRIME_TYPE_UNLAWFUL_RIDING, "Allowing a person to ride in the trunk of a vehicle."},
	{E_CRIME_TYPE_UNLAWFUL_RIDING, "Allowing passengers to ride in vehicles that the driver is towing (boats, campers, trailers, etc.)"},
	{E_CRIME_TYPE_UNLAWFUL_RIDING, "A motorcycle rider violates this section if he or she shares the same seat with a person."},
	{E_CRIME_TYPE_UNSAFE_PASSING,"A driver of a vehicle overtaking another vehicle who does so by passing to the right."},
	{E_CRIME_TYPE_UNSAFE_PASSING,"Overtaking another vehicle when the left side is not clearly visible and free of oncoming traffic for a sufficient distance."},
	{E_CRIME_TYPE_UNSAFE_PASSING,"Overtaking another vehicle within 100 feet of an intersection, bridge, viaduct, tunnel, crossing or other hazard."},
	{E_CRIME_TYPE_FAIL_TO_YIELD, "A driver of a vehicle approaching an intersection who does not yield the right-of-way to any vehicle which has entered the intersection."},
	{E_CRIME_TYPE_FAIL_TO_YIELD, "A driver of a vehicle approaching an intersection who does not proceed with caution in regards to other vehicles."},
	{E_CRIME_TYPE_FAIL_TO_YIELD, "A person who does not move their vehicle to the right, clear of any intersection, so that an emergency vehicle with lights and sirens can pass."},
	{E_CRIME_TYPE_JAYWALKING, "A pedestrian who crosses a roadway controlled by a traffic signal device at any place except at a crosswalk."},
	{E_CRIME_TYPE_JAYWALKING, "A pedestrian who crosses any other roadway without yielding the right of way to any oncoming vehicles."},
	{E_CRIME_TYPE_U_TURN, "A driver who turns right and does not do so as close as possible to the right-hand curb, or the right edge of the road."},
	{E_CRIME_TYPE_U_TURN, "A driver who turns left and does not do so as close as possible to the left-hand curb, or the left edge of the road."},
	{E_CRIME_TYPE_U_TURN, "A driver who makes a U-turn at an intersection controlled by official traffic signals."},
	{E_CRIME_TYPE_U_TURN, "A driver who, where U-turns are permissible, does not make them from the far left-hand lane."},
	{E_CRIME_TYPE_SPEEDING, "A person who drives a vehicle on a roadway at a speed greater than is greater than that posted on an official sign."},
	{E_CRIME_TYPE_SPEEDING, "Anyone who drives a vehicle at a speed greater than is prudent having due regard for weather, visibility, traffic, and the surface of the road."},
	{E_CRIME_TYPE_SPEEDING, "Anyone who drives a vehicle on a public roadway at a speed which which endangers the safety of persons or property."},
	{E_CRIME_TYPE_IMPEDING, "A person who drives upon a roadway at such a slow speed as to impede or block the normal movement of traffic."},
	{E_CRIME_TYPE_IMPEDING, "A person who brings a vehicle to a complete stop upon a roadway so as to impede or block the normal movement of traffic."},
	{E_CRIME_TYPE_IMPEDING, "{FFFF00}Unless the reduced speed or complete stop is necessary for safe operation, or in compliance with the law"},
	{E_CRIME_TYPE_ILLEGAL_PARKING, "A person who stops, parks, or leaves standing any vehicle whether attended or unattended, and does so:"},
	{E_CRIME_TYPE_ILLEGAL_PARKING, "Within an intersection, on a crosswalk, between a safety zone and the adjacent right-hand curb,"},
	{E_CRIME_TYPE_ILLEGAL_PARKING, "Or within 15 feet of the driveway entrance to a fire station."},
	{E_CRIME_TYPE_ILLEGAL_PARKING, "{FFFF00}Except when necessary for safe operation or in compliance with the directions of police or an official traffic device."},
	{E_CRIME_TYPE_DRIVING_ON_PHONE, "A person who drives a motor vehicle on a public roadway while using a wireless telephone."},
	{E_CRIME_TYPE_DRIVING_ON_PHONE, "{FFFF00}Unless the person is using the telephone for a reasonable emergency purpose, such as calling 9-1-1."},
	{E_CRIME_TYPE_DRINKING_IN_CAR, "Any occupant of a vehicle on any public roadway who drinks any alcoholic beverage or smokes or ingests marijuana."},
	{E_CRIME_TYPE_DRINKING_IN_CAR, "{FFFF00}Unless the person is a passenger in a vehicle carrying them for hire such as a taxi or rented limousine."},
	{E_CRIME_TYPE_IMPROPER_EQUIP, "A person who operates any vehicle which is in an unsafe condition, or is not safely loaded, and which presents an immediate safety hazard."},
	{E_CRIME_TYPE_IMPROPER_EQUIP, "Operating any vehicle or combination of vehicles on a public roadway which is not properly equipped and maintained to do so."},
	{E_CRIME_TYPE_HEADLIGHTS, "A person who, during darkness, operates a vehicle not equipped with lighted lighting equipment."},
	{E_CRIME_TYPE_HEADLIGHTS, "A driver who does not use headlights when the visibility is poor, and objects are not clearly seen."},
	{E_CRIME_TYPE_ILLEGAL_TINT, "A person who operates a vehicle with an object or material directly in the windshield of a car, or its side or rear window; or"},
	{E_CRIME_TYPE_ILLEGAL_TINT, "Anywhere else in the car if it obstructs the driver's view through the windshield or side windows."},
	{E_CRIME_TYPE_SEAT_BELT, "Any occupant of any motor vehicle on any public roadway who is not properly restrained by a safety belt."},
	{E_CRIME_TYPE_SEAT_BELT, "{FFFF00}Unless the vehicle is a motorcycle, or if there was an emergency or medical condition that prevented them from doing so."},
	{E_CRIME_TYPE_HELMET, "Any person who operates a motorcycle, motor-driven cycle, or motorized bicycle if the driver or any passenger is not wearing a safety helmet."},
	{E_CRIME_TYPE_HELMET, "Aany person who rides as a passenger on such a vehicle if the driver or any passenger is not wearing a safety helmet."},
	{E_CRIME_TYPE_HELMET, "{FFFF00}Unless there was an emergency that prevented the person from wearing a helmet, or the motorcycle was not actually being operated."},
	{E_CRIME_TYPE_STOP_SIGN, "A person who drives a motor vehicle through a stop sign or red light."},
	{E_CRIME_TYPE_STOP_SIGN, "Making a right turn at an intersection where a sign is posted that prohibits such a turn."},
	{E_CRIME_TYPE_STOP_SIGN, "Operating an off-highway vehicle on a section of road when done contrary to proper traffic signage."},
	{E_CRIME_TYPE_STOP_SIGN, "Disobeying as the driver of any vehicle any official sign, signal, or traffic control device placed by proper authorities."},
	{E_CRIME_TYPE_STOP_SIGN, "{FFFF00}Unless it was necessary for safe operation for the person to do so, or in compliance with police directions."}
};

GetCrimeFullName(crime, bool:colored=false, bool:withcode=false, bool:codeinverted=false)
{
 	new crimestr[110];
	new crimeIndex;

	for (new i = 0; i < sizeof(Crime); i ++)
	{
		if (Crime[i][E_CRIME_TITLE] != Crime[crime][E_CRIME_TITLE]) continue;
		if (i == crime) break;
		crimeIndex ++;
	}

	if (colored) format(crimestr, sizeof(crimestr), "{%06x}", CrimeClass[_:Crime[crime][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR]);
	if (withcode && strlen(Crime[crime][E_CRIME_CODE]))
	{
		if (codeinverted) format(crimestr, sizeof(crimestr), "%s%s: \"%s\"", crimestr, GetCrimeCode(crime), Crime[crime][E_CRIME_NAME]);
		else format(crimestr, sizeof(crimestr), "%s%s (%s)", crimestr, Crime[crime][E_CRIME_NAME], GetCrimeCode(crime));
		
	}
	else
	{
		format(crimestr, sizeof(crimestr), "%s(%d) %02d. %s", crimestr, _:Crime[crime][E_CRIME_TITLE]+1, crimeIndex+1, Crime[crime][E_CRIME_NAME]);
	}  

	return crimestr;
}

GetCrimeByTypeEnum(crime_type)
{
	for (new i = 0; i < sizeof(Crime); i ++)
	{
		if (_:Crime[i][E_CRIME_TYPE] == crime_type)
		{
			return i;
		}
	}

	return -1;
}

E_CRIME_TYPES:GetCrimeType(crime)
{
	return Crime[crime][E_CRIME_TYPE];
}

GetCrimeCode(crime, bool:colored=false)
{
	new codestr[24];

	if (strlen(Crime[crime][E_CRIME_CODE]))
	{
		if (Crime[crime][E_CRIME_TITLE] == E_CRIME_TITLE_HEALTH) format(codestr, sizeof(codestr), "%s HSC", Crime[crime][E_CRIME_CODE]);
		else if (Crime[crime][E_CRIME_TITLE] == E_CRIME_TITLE_TRAFFIC) format(codestr, sizeof(codestr), "%s VC", Crime[crime][E_CRIME_CODE]);
		else format(codestr, sizeof(codestr), "%s PC", Crime[crime][E_CRIME_CODE]);

		strins(codestr, "� ", 0);
		if (colored) format(codestr, sizeof(codestr), "{%06x}%s", CrimeClass[_:Crime[crime][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR], codestr);
	}	
	
	return codestr;
}

GetCrimeClass(crime, bool:colored=false, bool:prefixed=false, bool:forums=false)
{
	new classstr[32];
	format(classstr, sizeof(classstr), "%s", CrimeClass[_:Crime[crime][E_CRIME_CLASS]][E_CRIME_CLASS_NAME]);
	if (forums) format(classstr, sizeof(classstr), "[COLOR=#%06x]%s[/COLOR]", CrimeClass[_:Crime[crime][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR], classstr);
	else if (colored) format(classstr, sizeof(classstr), "{%06x}%s", CrimeClass[_:Crime[crime][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR], classstr);

	if (prefixed && Crime[crime][E_CRIME_CLASS] == E_CRIME_CLASS_INFRACTION) strins(classstr, "an ", 0);
	else if (prefixed) strins(classstr, "a ", 0);
	
	return classstr;
}

GetCrimeMinMaxCost(crime, &min_cost, &max_cost)
{
	for (new i = 0; i < sizeof(CrimeCost); i ++)
	{
		if (CrimeCost[i][E_CRIME_COST_TYPE] == Crime[crime][E_CRIME_COST])
		{
			min_cost = CrimeCost[i][E_CRIME_COST_MIN];
			max_cost = CrimeCost[i][E_CRIME_COST_MAX];

			return 1;
		}
	}

	return 0;
}

stock GetCrimeMinCost(crime)
{
	for (new i = 0; i < sizeof(CrimeCost); i ++)
	{
		if (CrimeCost[i][E_CRIME_COST_TYPE] == Crime[i][E_CRIME_COST])
		{
			return CrimeCost[i][E_CRIME_COST_MIN];
		}
	}

	return 0;
}

stock GetCrimeMaxCost(crime)
{
	for (new i = 0; i < sizeof(CrimeCost); i ++)
	{
		if (CrimeCost[i][E_CRIME_COST_TYPE] == Crime[i][E_CRIME_COST])
		{
			return CrimeCost[i][E_CRIME_COST_MAX];
		}
	}

	return 0;
}


static CrimeDlgStr[4096];

ShowCrimeTitles(playerid, targetid = INVALID_PLAYER_ID)
{
    format(CrimeDlgStr, sizeof(CrimeDlgStr), "Title\tDescription\n");

    for (new i = 0; i < sizeof(CrimeTitle); i ++)
    {
        format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s%d\t%s\n", CrimeDlgStr, _:CrimeTitle[i][E_CRIME_TITLE] + 1, CrimeTitle[i][E_CRIME_TITLE_NAME]);
    }

    inline DlgCrimeTitles(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem
        
        if (response)
        {
            ShowCrimeTitle(pid, E_CRIME_TITLES:listitem, targetid);
        }
    }

    Dialog_ShowCallback ( playerid, using inline DlgCrimeTitles, DIALOG_STYLE_TABLIST_HEADERS, "State Penal Code", CrimeDlgStr, "Select", "Close" );
	return true;
}

ShowCrimeTitle(playerid, E_CRIME_TITLES:title, targetid = INVALID_PLAYER_ID)
{
    format(CrimeDlgStr, sizeof(CrimeDlgStr), "Title\tCrime\tClassification\tCode\n");
    new index = 0, color;

    for (new i = 0; i < sizeof(Crime); i ++)
    {
        if (Crime[i][E_CRIME_TITLE] != title) continue;
        color = CrimeClass[_:Crime[i][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR];
        format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s{%06x}(%d) %02d.\t{%06x}%s\t{%06x}%s\t{%06x}%s\n", CrimeDlgStr, color, _:title+1, index+1, color, Crime[i][E_CRIME_NAME], color, CrimeClass[_:Crime[i][E_CRIME_CLASS]][E_CRIME_CLASS_NAME], color, GetCrimeCode(i));
        index++;
    }

    inline DlgCrimeTitle(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem
        
        if (!response)
        {
			if (PlayerVar[pid][E_PLAYER_WRITING_TICKET])
			{
				PlayerVar[pid][E_PLAYER_WRITING_TICKET] = false;
				//return ShowPlayerFooter(pid, "~r~You cancelled writing the ticket.", 3000);
				return true;
			} 

            return ShowCrimeTitles(pid, targetid);
        }

        for (new x = 0; x < sizeof(Crime); x ++)
        {
            if (Crime[x][E_CRIME_TITLE] == title)
            {
                ShowCrimeDetails(pid, x + listitem, targetid);
                break;
            }
        }

        // ...

        return true;
    }

    Dialog_ShowCallback ( playerid, using inline DlgCrimeTitle, DIALOG_STYLE_TABLIST_HEADERS, CrimeTitle[_:title][E_CRIME_TITLE_NAME], CrimeDlgStr, "Select", "Back" );
	return true;
}

ShowCrimeDetails(playerid, crime, targetid = INVALID_PLAYER_ID)
{
    new descIndex = 0;
    new charging = IsPlayerConnected(targetid);
	new ticketing = PlayerVar[playerid][E_PLAYER_WRITING_TICKET];

	if (charging && Crime[crime][E_CRIME_CLASS] == E_CRIME_CLASS_INFRACTION)
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't charge people with non-arrestable crimes, use /ticket instead.");  // Temp switch here as you can't give tickets through /charge yet
	}

	if (ticketing)
	{
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You are about to write a ticket for:\n- %s\n", GetCrimeFullName(crime, true, true, true));
	}
	else if (charging)
	{
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You are about to charge {90CAF9}%s (%d) {FFFFFF}with:\n{ADBEE6}- %s\n", ReturnSettingsName(targetid, playerid), targetid, GetCrimeFullName(crime, true, true, true));
	}
	else
	{
		//format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}Viewing description of:\n- %s: \"%s\"\n", GetCrimeCode(crime, true), Crime[crime][E_CRIME_NAME]);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}Information for %s\n", GetCrimeFullName(crime, true, true, true));
	}

    // Show the description if it has one
    for (new i = 0; i < sizeof(CrimeDesc); i ++)
    {
        if (CrimeDesc[i][E_CRIME_DESC_CRIME_TYPE] != Crime[crime][E_CRIME_TYPE]) continue;
        descIndex ++;
        format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}%d. %s", CrimeDlgStr, descIndex, CrimeDesc[i][E_CRIME_DESC_TEXT]);
    }

	new min_cost, max_cost;
	GetCrimeMinMaxCost(crime, min_cost, max_cost);

	if (min_cost && max_cost)
	{
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}%s is %s{FFFFFF} punishable by:\n", CrimeDlgStr, GetCrimeCode(crime), GetCrimeClass(crime, true, true));

		if (Crime[crime][E_CRIME_CLASS] == E_CRIME_CLASS_INFRACTION)
		{
			format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}1. A minimum fine of {A5D6A7}$%s", CrimeDlgStr, IntegerWithDelimiter(min_cost));
			format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}2. A maximum fine of {EF9A9A}$%s", CrimeDlgStr, IntegerWithDelimiter(max_cost));
		}
		else
		{
			format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}1. Imprisonment for a minimum of {A5D6A7}%d minutes", CrimeDlgStr, min_cost);
			format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}2. Imprisonment for a maximum of {EF9A9A}%d minutes", CrimeDlgStr, max_cost);
		}
	}

    inline DlgCrimeDetails(pid, dialogid, response, listitem, string:inputtext[]) 
    {
        #pragma unused pid, dialogid, inputtext, listitem
        
        if (!response)
        {
            return ShowCrimeTitle(pid, Crime[crime][E_CRIME_TITLE], targetid);
        }

		if (PlayerVar[pid][E_PLAYER_WRITING_TICKET])
		{
			new amount = strval(inputtext);
			if (amount < min_cost) return SendServerMessage(pid, COLOR_ERROR, "Error", "A3A3A3", sprintf("The minimum fine for this ticket is $%s.", IntegerWithDelimiter(min_cost)));
			else if (amount > max_cost) return SendServerMessage(pid, COLOR_ERROR, "Error", "A3A3A3", sprintf("The maximum fine for this ticket is $%s.", IntegerWithDelimiter(min_cost)));
			else if (amount % 5 != 0) return SendServerMessage(pid, COLOR_ERROR, "Error", "A3A3A3", "The fine amount must be a multiple of five.");

			AddTicket(pid, crime, amount);
		}
        else if (charging)
        {
            AddCrime(pid, targetid, crime);
        }

        // ...

        return true;
    }

	if (ticketing)
	{
		strcat(CrimeDlgStr, "\n\n{FFFFFF}If this is correct, enter the cost of the ticket below.\n{ADBEE6}{FF0000}Note that giving incorrect tickets is against the server rules.");
		Dialog_ShowCallback ( playerid, using inline DlgCrimeDetails, DIALOG_STYLE_INPUT, "Ticket Information", CrimeDlgStr, "Confirm", "Back" );
	}
	else
	{
		if (charging) strcat(CrimeDlgStr, "\n\n{FFFFFF}If this is correct, press Confirm.\n{ADBEE6}{FF0000}Giving incorrect charges is against the server rules.");
		Dialog_ShowCallback ( playerid, using inline DlgCrimeDetails, DIALOG_STYLE_MSGBOX, "Crime Information", CrimeDlgStr, charging ? "Confirm" : "OK", "Back" );
	}
    
    
	return true;
}

AddTicket(playerid, crime, amount)
{
    new query[512];
	new desc[128];

	format(desc, sizeof(desc), "%s", GetCrimeFullName(crime, false, true));

	mysql_format(mysql, query, sizeof(query), "INSERT INTO `criminalfines` (`fine_giver_id`, `fine_giver_name`, `fine_giver_rank`, `fine_reason`, `fine_reason_id`, `fine_amount`) VALUES ('%d', '%e', '%e', '%e', '%d', '%d')",
		Character[playerid][E_CHARACTER_ID], Character[playerid][E_CHARACTER_NAME], Character[playerid][E_CHARACTER_FACTIONRANK], desc, _:Crime[crime][E_CRIME_TYPE], amount);

	inline Ticket_OnInsert() 
	{
		new ticketid = cache_insert_id();
		if (ticketid)
		{
			ProxDetectorEx(playerid, 20.0, COLOR_ACTION, "*", sprintf("fills out a $%s ticket for \"%s\".", IntegerWithDelimiter(amount), Crime[crime][E_CRIME_NAME]), true, true);
			SendClientMessage(playerid, COLOR_INFO, sprintf("The ticket's number is: %d.  Use /giveticket [player] [%d] to give this ticket to somebody.", ticketid, ticketid));
		}
	}

	PlayerVar[playerid][E_PLAYER_WRITING_TICKET] = false;
	MySQL_TQueryInline(mysql, using inline Ticket_OnInsert, query, "");

	return true;
}

ShowTickets(playerid, forplayername[MAX_PLAYER_NAME], bool:viewing=false)
{
	new query[512], player_name[MAX_PLAYER_NAME], player_name_display[MAX_PLAYER_NAME];
	format(player_name, sizeof(player_name), "%s", forplayername);
	mysql_format(mysql, query, sizeof(query), "SELECT `fine_id`, DATE(fine_date) AS 'date', UNIX_TIMESTAMP(`fine_date`) AS `timestamp`, `fine_player_name`, `fine_amount`, `fine_reason`, `fine_status` FROM `criminalfines` WHERE `fine_player_name` LIKE '%e' ORDER BY `fine_status`, `fine_date` DESC LIMIT 50", forplayername);

	new days = 259200; // 3 days to seconds // if you change this, change it in arrest/searchdata too

	inline Tickets_OnList() 
	{
		if (!cache_num_rows())
		{
			if (viewing) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("No tickets were found on file for \"%s\"", player_name)) ;
			else return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have any tickets.") ;
		}

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "Date\tCost\tStatus\tTicket");
		new now = gettime(); // current time

		new ticketid, ticket_reason[128], ticket_amount, status, date[16], map[50], count = 0, timestamp;
		for (new i = 0, r = cache_num_rows(); i < r; ++i)
		{
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "fine_amount", ticket_amount);
			cache_get_value_name_int(i, "fine_id", ticketid);
			cache_get_value_name_int(i, "fine_status", status);
			cache_get_value_name_int(i, "timestamp", timestamp);
			cache_get_value_name(i, "fine_reason", ticket_reason);
			new due = days - (now - timestamp);

			new fee = (due > 0) ? 0 : ticket_amount * 2;
			new actual_cost = ticket_amount + fee;
			
			map[count] = ticketid;
			count ++;

			//cache_get_field_content(i, "fine_giver_name", ticket_giver_name);
			//cache_get_field_content(i, "fine_giver_rank", ticket_giver_name);
			//ticket_giver = cache_get_field_content_int(i, "fine_giver_id");
			//crime_type = cache_get_field_content_int(i, "fine_reason_id");

			if (status == 2) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t$%s\t{BDBDBD}%s\t%s", CrimeDlgStr, date, IntegerWithDelimiter(actual_cost), "Revoked", ticket_reason);
			else if (status == 1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t$%s\t{C5E1A5}%s\t%s", CrimeDlgStr, date, IntegerWithDelimiter(actual_cost), "Paid", ticket_reason);
			else if (due > 0) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t$%s\t{FFD54F}%s\t%s", CrimeDlgStr, date, IntegerWithDelimiter(actual_cost), "Unpaid", ticket_reason);
			else format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t$%s\t{EF5350}%s\t%s", CrimeDlgStr, date, IntegerWithDelimiter(actual_cost), "Expired", ticket_reason);
		}

		cache_get_value_name(0, "fine_player_name", player_name_display);
		strreplace(player_name_display, "_", " ");

		inline DlgTicketList(pid, dialogid, response, listitem, string:inputtext[]) 
    	{
			#pragma unused pid, dialogid, inputtext, listitem
			
			if (response && listitem < sizeof(map))
			{
				// show the view ticket thing
				ShowTicket(pid, map[listitem], viewing);
			}
		}

		Dialog_ShowCallback(playerid, using inline DlgTicketList, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Tickets given to %s", player_name_display), CrimeDlgStr, "View", "Back");
	}

	MySQL_TQueryInline(mysql, using inline Tickets_OnList, query, "");
	return 1;
}

ShowTicket(playerid, ticketid, bool:viewing=false)
{
	new query[512];
	new days = 259200; // 3 days to seconds // if you change this, change it in arrest/searchdata too

	mysql_format(mysql, query, sizeof(query), "SELECT *, UNIX_TIMESTAMP(`fine_date`) AS `timestamp`, DATE_ADD(`fine_date`, INTERVAL %d second) AS `due_by` FROM `criminalfines` WHERE `fine_id` = %d", days, ticketid);

	inline Ticket_OnView() 
	{
		if (!cache_num_rows())
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid ticket ID." ) ;
		}

		new ticket_reason[128], ticket_amount, status, timestamp, date[32], ticket_due[32], giver_name[32], revoker_name[32], giver_rank[32], player_name[MAX_PLAYER_NAME], player_display_name[MAX_PLAYER_NAME];
		cache_get_value_name(0, "fine_date", date);
		cache_get_value_name_int(0, "fine_amount", ticket_amount);
		cache_get_value_name_int(0, "fine_status", status);
		cache_get_value_name_int(0, "timestamp", timestamp);
		cache_get_value_name(0, "fine_reason", ticket_reason);
		cache_get_value_name(0, "fine_giver_name", giver_name);
		cache_get_value_name(0, "fine_giver_rank", giver_rank);
		cache_get_value_name(0, "fine_player_name", player_name);
		cache_get_value_name(0, "fine_player_name", player_display_name);
		cache_get_value_name(0, "fine_revoker", revoker_name);
		cache_get_value_name(0, "due_by", ticket_due);

		strreplace(giver_name, "_", " ");
		strreplace(player_display_name, "_", " ");
		strreplace(revoker_name, "_", " ");

		new now = gettime(); // current time
		new due = days - (now - timestamp);
		new fee = (due > 0) ? 0 : ticket_amount * 2;
		new actual_cost = ticket_amount + fee;

		if (viewing) format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}%s was given a ticket by {ADBEE6}%s %s {FFFFFF}for:", player_display_name, giver_rank, giver_name);
		else format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You were given a ticket by {ADBEE6}%s %s {FFFFFF}for:", giver_rank, giver_name);
		
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}- {E6EE9C}%s", CrimeDlgStr, ticket_reason);

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{0099FF}Ticket Number: {ADBEE6}#%03d", CrimeDlgStr, ticketid);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Ticket Date: {ADBEE6}%s", CrimeDlgStr, date);
		if (due > 0) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Ticket Cost: {ADBEE6}$%s", CrimeDlgStr, IntegerWithDelimiter(actual_cost));
		else format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Ticket Cost: {ADBEE6}$%s (Ticket: $%s, Late Fee: $%s)", CrimeDlgStr, IntegerWithDelimiter(actual_cost), IntegerWithDelimiter(ticket_amount), IntegerWithDelimiter(fee));
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Payment Due By: {ADBEE6}%s", CrimeDlgStr, ticket_due);
		
		if (viewing)
		{
			if (status == 2) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}This ticket was revoked by {ADBEE6}%s.", CrimeDlgStr, revoker_name);
			else if (status == 1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}They have already paid this ticket.", CrimeDlgStr);
			else if (due > 3600) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}They have %d hours left to pay this ticket.", CrimeDlgStr, due / 3600);
			else if (due > 60) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFF00}They have %d minutes left to pay this ticket.", CrimeDlgStr, due / 60);
			else if (due > 0) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFF00}They have %d seconds left to pay this ticket.", CrimeDlgStr, due);
			else 
			{
				format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFF00}This ticket was not paid on time, they can still pay it but will be charged extra.", CrimeDlgStr);
				format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{FF0000}Note that they can be arrested instead for failing to pay the ticket on time.", CrimeDlgStr);
				format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}Any unpaid tickets will be automatically cancelled if they are arrested.", CrimeDlgStr);
			}
		}
		else
		{
			if (status == 2) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}This ticket was revoked by {ADBEE6}%s.", CrimeDlgStr, revoker_name);
			else if (status == 1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}You have already paid this ticket.", CrimeDlgStr);
			else if (due > 3600) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}You have %d hours left to pay this ticket or you may be arrested.", CrimeDlgStr, due / 3600);
			else if (due > 60) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFF00}You have %d minutes left to pay this ticket or you may be arrested.", CrimeDlgStr, due / 60);
			else if (due > 0) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFF00}You have %d seconds left to pay this ticket or you may be arrested.", CrimeDlgStr, due);
			else 
			{
				format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFF00}This ticket was not paid on time, you can still pay it but you will be charged extra.", CrimeDlgStr);
				format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{FF0000}Note that you can be arrested if the police catch you with an unpaid ticket.", CrimeDlgStr);
				format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}Any unpaid tickets will be automatically cancelled if you are arrested.", CrimeDlgStr);
			}
		}
		
		inline DlgTicketView(pid, dialogid, response, listitem, string:inputtext[]) 
    	{
			#pragma unused pid, dialogid, inputtext, listitem

			if (response && !status)
			{
				// Revoke or pay the ticket
				if (viewing) RevokeTicket(pid, ticketid);
				else PayTicket(pid, ticketid, actual_cost);
			}
			else
			{
				// go back
				ShowTickets(pid, player_name, viewing);
			}
		}

		if (status) Dialog_ShowCallback ( playerid, using inline DlgTicketView, DIALOG_STYLE_MSGBOX, sprintf("Viewing Ticket #%03d", ticketid), CrimeDlgStr, "Back", "" );
		else if (viewing) Dialog_ShowCallback ( playerid, using inline DlgTicketView, DIALOG_STYLE_MSGBOX, sprintf("Viewing Ticket #%03d", ticketid), CrimeDlgStr, "Revoke", "Back" );
		else Dialog_ShowCallback ( playerid, using inline DlgTicketView, DIALOG_STYLE_MSGBOX, sprintf("Viewing Ticket #%03d", ticketid), CrimeDlgStr, "Pay", "Back" );
	}

	MySQL_TQueryInline(mysql, using inline Ticket_OnView, query, "");
	return 1;
}

RevokeTicket(playerid, ticketid)
{
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovRecords(playerid, true)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be on duty as a police officer to do this.");
	else if (Character[playerid][E_CHARACTER_FACTIONTIER] >= 3) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Ask a supervisor (Tier 2) to revoke the ticket instead.");

	new query[512];
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `criminalfines` WHERE `fine_id` = %d", ticketid);

	inline Ticket_OnRevokeGet() 
	{
		if (!cache_num_rows())
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid ticket ID." ) ;
		}

		new status, ticket_reason[128], ticket_amount, date[32], giver_name[32], giver_rank[32], player_name[MAX_PLAYER_NAME], player_display_name[MAX_PLAYER_NAME];
		cache_get_value_name(0, "fine_date", date);
		cache_get_value_name_int(0, "fine_amount", ticket_amount);
		cache_get_value_name_int(0, "fine_status", status);
		cache_get_value_name(0, "fine_reason", ticket_reason);
		cache_get_value_name(0, "fine_giver_name", giver_name);
		cache_get_value_name(0, "fine_giver_rank", giver_rank);
		cache_get_value_name(0, "fine_player_name", player_name);
		cache_get_value_name(0, "fine_player_name", player_display_name);

		if (status) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can't revoke this ticket as it has already been paid or revoked." );

		strreplace(giver_name, "_", " ");
		strreplace(player_display_name, "_", " ");

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You are about to revoke a {ADBEE6}$%s{FFFFFF} ticket given to {ADBEE6}%s{FFFFFF} for:", IntegerWithDelimiter(ticket_amount), player_display_name);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}- {E6EE9C}%s", CrimeDlgStr, ticket_reason);

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{0099FF}Ticket Number: {ADBEE6}#%03d", CrimeDlgStr, ticketid);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Ticket Date: {ADBEE6}%s", CrimeDlgStr, date);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Ticket Issued By: {ADBEE6}%s %s", CrimeDlgStr, giver_rank, giver_name);

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to revoke the ticket.", CrimeDlgStr);
		
		inline DlgTicketRevoke(pid, dialogid, response, listitem, string:inputtext[]) 
    	{
			#pragma unused pid, dialogid, inputtext, listitem

			if (response)
			{
				// Do the revokation
				mysql_format(mysql, query, sizeof(query), "UPDATE `criminalfines` SET `fine_status` = 2, `fine_revoker` = '%e' WHERE `fine_id` = %d", Character[pid][E_CHARACTER_NAME], ticketid);

				inline Ticket_OnRevoke() 
				{
					if (!cache_affected_rows()) return SendServerMessage(pid, COLOR_ERROR, "Error", "A3A3A3", "There was an error revoking this ticket (it might already be paid)");

					new factionid = Character [ pid ] [ E_CHARACTER_FACTIONID ] ;
					new faction_enum_id = Faction_GetEnumID( factionid ); 

					Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has revoked Ticket #%03d given to %s by %s. }", 
						Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], pid, ReturnMixedName ( pid ), ticketid, player_display_name, giver_name
					), faction_enum_id, false ) ;
				}

				MySQL_TQueryInline(mysql, using inline Ticket_OnRevoke, query, "");
			}
			else
			{
				// go back
				ShowTickets(pid, player_name, true);
			}
		}

		Dialog_ShowCallback ( playerid, using inline DlgTicketRevoke, DIALOG_STYLE_MSGBOX, sprintf("Revoking Ticket #%03d", ticketid), CrimeDlgStr, "OK", "Back" );
	}

	MySQL_TQueryInline(mysql, using inline Ticket_OnRevokeGet, query, "");
	return 1;	
}

PayTicket(playerid, ticketid, cost)
{
	if (GetPlayerCash(playerid) < cost)
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("You can't afford to pay this ticket, you need $%s in cash.", IntegerWithDelimiter(cost)));
	}

	if (!IsAtCopFrontDesk(playerid) && !IsAtGovFrontDesk(playerid))
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only pay tickets at the front desk of a police station or City Hall. ");
	}

	new query[128];
	mysql_format(mysql, query, sizeof(query), "UPDATE `criminalfines` SET `fine_status` = 1 WHERE `fine_id` = %d", ticketid);

	inline Ticket_OnPay() 
	{
		if (!cache_affected_rows()) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "There was an error paying this ticket (it might already be paid)");
		SendClientMessage(playerid, COLOR_INFO, sprintf("You paid off Ticket #%03d for $%s.", ticketid, IntegerWithDelimiter(cost)));

		mysql_format(mysql, query, sizeof(query), "UPDATE `server` SET `police_fines_total` = `police_fines_total` + %d", cost);
		mysql_tquery(mysql, query);

		TakePlayerCash(playerid, cost);
	}

	MySQL_TQueryInline(mysql, using inline Ticket_OnPay, query, "");
	return 1;
}

AddCrime(playerid, targetid, crime)
{
    new query[512];
    new desc[128];

    format(desc, sizeof(desc), "%s", GetCrimeFullName(crime, false, true));

	mysql_format(mysql, query, sizeof(query), "INSERT INTO criminalrecords(record_desc, record_crime_type, record_date, record_holder, record_officer, record_officer_rank) VALUES ('%e', %d, %d, '%e', '%e', '%e')",
		desc, _:GetCrimeType(crime), gettime(), Character [ targetid ] [ E_CHARACTER_NAME ], Character [ playerid ] [ E_CHARACTER_NAME ], Character[playerid][E_CHARACTER_FACTIONRANK] );

	mysql_tquery(mysql, query);

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has charged (%d) %s with %s }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid ), targetid, ReturnMixedName ( targetid ), GetCrimeFullName(crime, false, true, true)
	), faction_enum_id, false ) ;

	if (IsPlayerNearPlayer(playerid, targetid, 25.0))
	{
		SendClientMessage(targetid, COLOR_INFO, sprintf("(%d) %s %s charged you with: %s", playerid, Character[playerid][E_CHARACTER_FACTIONRANK], ReturnSettingsName(playerid, targetid), GetCrimeFullName(crime, true, true, true)));
	}

	return true;
}

RevokeCrime(playerid, recordid)
{
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovJudge(playerid, true) && !IsPlayerGovCop(playerid, true)) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be on duty as a police officer to do this.");
	else if (Character[playerid][E_CHARACTER_FACTIONTIER] >= 3) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Ask a supervisor (Tier 2) to revoke the charge instead.");

	new query[256];
	mysql_format(mysql, query, sizeof(query), "SELECT *, FROM_UNIXTIME(record_date) AS 'date' FROM `criminalrecords` WHERE `record_id` = %d", recordid);

	inline Crime_OnRevokeGet() 
	{
		if (!cache_num_rows())
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid criminal charge ID." ) ;
		}

		new status, crime_desc[128], crime_type, date[32], giver_name[32], giver_rank[32], player_name[MAX_PLAYER_NAME], player_display_name[MAX_PLAYER_NAME];
		cache_get_value_name(0, "date", date);
		cache_get_value_name_int(0, "record_crime_type", crime_type);
		cache_get_value_name_int(0, "record_status", status);
		cache_get_value_name(0, "record_desc", crime_desc);
		cache_get_value_name(0, "record_officer", giver_name);
		cache_get_value_name(0, "record_officer_rank", giver_rank);
		cache_get_value_name(0, "record_holder", player_name);
		cache_get_value_name(0, "record_holder", player_display_name);

		if (status) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "This charge has already been revoked." );
		strreplace(giver_name, "_", " ");
		strreplace(player_display_name, "_", " ");

		new crime = -1;
		if (crime_type != -1) crime = GetCrimeByTypeEnum(crime_type);
		
		if (crime != -1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You are about to revoke %s{FFFFFF} charge against {ADBEE6}%s{FFFFFF} for:", GetCrimeClass(crime, true, true), player_display_name);
		else format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You are about to revoke a charge against {ADBEE6}%s{FFFFFF} for:", player_display_name);

		if (crime != -1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}- {FFFFFF}%s", CrimeDlgStr, GetCrimeFullName(crime, true, true));
		else format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}- {FFFFFF}%s", CrimeDlgStr, crime_desc);	

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{0099FF}Record Number: {ADBEE6}#%05d", CrimeDlgStr, recordid);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Record Date: {ADBEE6}%s", CrimeDlgStr, date);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Issued By (Name): {ADBEE6}%s", CrimeDlgStr, giver_name);
		if (strlen(giver_rank)) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Issued By (Title): {ADBEE6}%s", CrimeDlgStr, giver_rank);

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}Press {AA3333}OK{FFFFFF} to revoke the charge.", CrimeDlgStr);
		
		inline DlgCrimeRevoke(pid, dialogid, response, listitem, string:inputtext[]) 
    	{
			#pragma unused pid, dialogid, inputtext, listitem

			if (response)
			{
				// Do the revokation
				mysql_format(mysql, query, sizeof(query), "UPDATE `criminalrecords` SET `record_status` = 2, `record_revoker` = '%e' WHERE `record_id` = %d", Character[pid][E_CHARACTER_NAME], recordid);

				inline Crime_OnRevoke() 
				{
					if (!cache_affected_rows()) return SendServerMessage(pid, COLOR_ERROR, "Error", "A3A3A3", "There was an error revoking this charge (it might already be revoked)");

					new factionid = Character [ pid ] [ E_CHARACTER_FACTIONID ] ;
					new faction_enum_id = Faction_GetEnumID( factionid ); 

					if (crime != -1)
					{
						Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has revoked Charge #%05d (%s) given to %s by %s. }", 
							Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], pid, ReturnMixedName ( pid ), recordid, GetCrimeCode(crime), player_display_name, giver_name
						), faction_enum_id, false ) ;
					}
					else
					{
						Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has revoked Charge #%05d given to %s by %s. }", 
							Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], pid, ReturnMixedName ( pid ), recordid, player_display_name, giver_name
						), faction_enum_id, false ) ;
					}
				}

				MySQL_TQueryInline(mysql, using inline Crime_OnRevoke, query, "");
			}
			else
			{
				// go back
				ShowCrime(playerid, recordid, true);
			}
		}

		Dialog_ShowCallback ( playerid, using inline DlgCrimeRevoke, DIALOG_STYLE_MSGBOX, sprintf("Revoking Charge #%05d", recordid), CrimeDlgStr, "OK", "Back" );
	}

	MySQL_TQueryInline(mysql, using inline Crime_OnRevokeGet, query, "");
	return 1;	
}


CMD:laws(playerid)
{
    if (!IsAtCopFrontDesk(playerid) && !IsAtGovFrontDesk(playerid) && !GetPlayerAdminLevel(playerid) && !IsPlayerInPoliceFaction(playerid))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only view the /laws inside City Hall." ) ;
	}

    ShowCrimeTitles(playerid);
    return true;
}

CMD:customcharge(playerid, params[])
{
    if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	if (Character[playerid][E_CHARACTER_FACTIONTIER] >= 3)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You must be a higher tier to do this." ) ;
	}

	new targetid, desc[64];

	if ( sscanf ( params, "k<player>s[64]", targetid, desc ) || !IsPlayerConnected(targetid) ) 
    {
		return SendClientMessage(playerid, -1, "/customcharge [player] [crime name]" ) ;
	}

	if ( strlen ( desc ) <= 0 || strlen ( desc ) > 64 ) {

		return SendClientMessage(playerid, -1, "Criminal record description can't be empty or longer than 128 characters." ) ;
	}

	new query [ 512 ] ;

	mysql_format(mysql, query, sizeof(query), "INSERT INTO criminalrecords(record_desc, record_date, record_holder, record_officer, record_officer_rank) VALUES ('%e', %d, '%e', '%e', '%e')",
		desc, gettime(), Character [ targetid ] [ E_CHARACTER_NAME ], Character [ playerid ] [ E_CHARACTER_NAME ], Character[playerid][E_CHARACTER_FACTIONRANK] );

	mysql_tquery(mysql, query) ;

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s has charged (%d) %s with \"%s\" }",

		Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid ), targetid, ReturnMixedName ( targetid ), desc
	), faction_enum_id, false ) ;

	if (IsPlayerNearPlayer(playerid, targetid, 25.0))
	{
		SendClientMessage(targetid, COLOR_INFO, sprintf("(%d) %s %s charged you with: %s.", playerid, Character[playerid][E_CHARACTER_FACTIONRANK], ReturnSettingsName(playerid, targetid), desc));
	}

 	return true ;
}


CMD:charge(playerid, params[])
{
    if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovCop(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty in a faction that can do this." ) ;
	}

	if (Character[playerid][E_CHARACTER_FACTIONTIER] > 3)
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You're not a high enough tier of employee to do this.");
	}

	new targetid;

	if ( sscanf ( params, "k<player>", targetid ) || !IsPlayerConnected(targetid) ) 
    {
		return SendClientMessage(playerid, -1, "/charge [player]" ) ;
	}

    if (!IsPlayerNearPlayer(playerid, targetid, 25.0) && Character[playerid][E_CHARACTER_FACTIONTIER] >= 3)
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You must be near this player to charge them with a crime (or get a higher tier to do it)." ) ;
	}

	if (!IsPlayerAtMugshotPos(playerid) || IsPlayerInFactionSquad(playerid, FACTION_SQUAD_GOV_DAO, FACTION_TYPE_GOV, true))
	{
		return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You can only charge players with a crime at the booking/mugshot area." ) ;
	}
	
    ShowCrimeTitles(playerid, targetid);
 	return true ;
}

IsPlayerAtMugshotPos(playerid)
{
    return IsPlayerInRangeOfPoint(playerid, 7.5, PD_MUGSHOT_X, PD_MUGSHOT_Y, PD_MUGSHOT_Z);
}

CMD:cradd(playerid, params[]) 
{
    return cmd_charge(playerid, params);
}

CMD:writeticket(playerid)
{
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	PlayerVar[playerid][E_PLAYER_WRITING_TICKET] = true;
	ShowCrimeTitle(playerid, E_CRIME_TITLE_TRAFFIC);

	return 1;
}

CMD:ticket(playerid)
{
	return cmd_writeticket(playerid);
}

CMD:giveticket(playerid, params[])
{
    if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new targetid, ticketid;

	if ( sscanf ( params, "k<player>d", targetid, ticketid ) || !IsPlayerConnected(targetid) || ticketid < 1 ) 
    {
		return SendServerMessage ( playerid, COLOR_ERROR, "Usage", "A3A3A3", "/giveticket [player] [ticket number]" ) ;
	}

    if (!IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "You must be near this player to give them a ticket." ) ;
	}

	new query[128];

	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `criminalfines` WHERE `fine_id` = %d AND `fine_giver_id` = %d AND `fine_player_id` = 0", ticketid, Character[playerid][E_CHARACTER_ID]);

	inline Ticket_OnGive() 
	{
		new ticket_giver, ticket_reason[128], ticket_amount, ticket_giver_name[32], ticket_giver_rank[32], crime_type;
		if (cache_num_rows())
		{
			cache_get_value_name(0, "fine_reason", ticket_reason);
			cache_get_value_name(0, "fine_giver_name", ticket_giver_name);
			cache_get_value_name(0, "fine_giver_rank", ticket_giver_rank);
			cache_get_value_name_int(0, "fine_giver_id", ticket_giver);
			cache_get_value_name_int(0, "fine_amount", ticket_amount);
			cache_get_value_name_int(0, "fine_reason_id", crime_type);
		}

		if (!cache_num_rows() || !ticket_giver) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid ticket number." ) ;

		new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
		new faction_enum_id = Faction_GetEnumID( factionid ); 
		new crime = GetCrimeByTypeEnum(crime_type);

		if (crime == -1) return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid ticket reason." ) ;

		Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s gave (%d) %s a $%s ticket for %s }",
			Faction [ faction_enum_id ] [ E_FACTION_ABBREV ], playerid, ReturnMixedName ( playerid ), targetid, ReturnMixedName ( targetid ), IntegerWithDelimiter(ticket_amount), GetCrimeCode(crime)
		), faction_enum_id, false ) ;

		SendClientMessage(targetid, COLOR_WARNING, sprintf("(%d) %s gave you a $%s ticket for %s", playerid, ReturnSettingsName(playerid, targetid), IntegerWithDelimiter(ticket_amount), GetCrimeFullName(crime, true, true, true)));
		SendClientMessage(targetid, COLOR_SERVER, "[TIP]{36D191} Use /mytickets to view and pay your tickets.");

		mysql_format(mysql, query, sizeof(query), "UPDATE `criminalfines` SET `fine_player_id` = %d, `fine_player_name` = '%e' WHERE `fine_id` = %d", Character[targetid][E_CHARACTER_ID], Character[targetid][E_CHARACTER_NAME], ticketid);
		mysql_tquery(mysql, query);
	}

	MySQL_TQueryInline(mysql, using inline Ticket_OnGive, query, "");

 	return true ;
}

ShowCrimes(playerid, forplayername[MAX_PLAYER_NAME], bool:viewing=false)
{
	new query[512], player_name[MAX_PLAYER_NAME], player_name_display[MAX_PLAYER_NAME];
	format(player_name, sizeof(player_name), "%s", forplayername);
	mysql_format(mysql, query, sizeof(query), "SELECT `record_id`, DATE(FROM_UNIXTIME(record_date)) AS 'date', `record_holder`, `record_desc`, `record_crime_type`, `record_status` FROM `criminalrecords` WHERE `record_holder` LIKE '%e' ORDER BY `record_status`, `record_date` DESC LIMIT 100", forplayername);


	inline Records_OnList() 
	{
		if (!cache_num_rows())
		{
			if (viewing) return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", sprintf("No criminal record was found on file for \"%s\"", player_name)) ;
			else return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You don't have a criminal record.") ;
		}

		format(CrimeDlgStr, sizeof(CrimeDlgStr), "Date\tCrime");

		new recordid, record_desc[128], crime_type, status, date[16], map[100], count = 0;
		for (new i = 0, r = cache_num_rows(); i < r; ++i)
		{
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "record_crime_type", crime_type);
			cache_get_value_name_int(i, "record_id", recordid);
			cache_get_value_name_int(i, "record_status", status);
			cache_get_value_name(i, "record_desc", record_desc);
			
			map[count] = recordid;
			count ++;

			new crime = -1;
			if (crime_type != -1) crime = GetCrimeByTypeEnum(crime_type);

			if (status == 2) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t{9E9E9E}%s", CrimeDlgStr, date, record_desc);
			else if (crime != -1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t%s", CrimeDlgStr, date, GetCrimeFullName(crime, true, true));
			else format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n%s\t%s", CrimeDlgStr, date, record_desc);
		}

		cache_get_value_name(0, "record_holder", player_name_display);
		strreplace(player_name_display, "_", " ");

		inline DlgRecordList(pid, dialogid, response, listitem, string:inputtext[]) 
    	{
			#pragma unused pid, dialogid, inputtext, listitem
			
			if (response && listitem < sizeof(map))
			{
				// show the view crime thing
				ShowCrime(pid, map[listitem], viewing);
			}
		}

		Dialog_ShowCallback(playerid, using inline DlgRecordList, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Criminal Record of %s", player_name_display), CrimeDlgStr, "View", "Back");
	}

	MySQL_TQueryInline(mysql, using inline Records_OnList, query, "");
	return 1;
}

ShowCrime(playerid, recordid, bool:viewing=false)
{
	new query[256];
	mysql_format(mysql, query, sizeof(query), "SELECT *, FROM_UNIXTIME(record_date) AS 'date' FROM `criminalrecords` WHERE `record_id` = %d", recordid);

	inline Record_OnView() 
	{
		new record_desc[128], crime_type, status, date[32], giver_name[32], revoker_name[32], giver_rank[32], player_name[MAX_PLAYER_NAME], player_display_name[MAX_PLAYER_NAME];
		if (!cache_num_rows())
		{
			return SendServerMessage ( playerid, COLOR_ERROR, "Error", "A3A3A3", "Invalid ticket ID." ) ;
		}

		cache_get_value_name(0, "date", date);
		cache_get_value_name_int(0, "record_crime_type", crime_type);
		cache_get_value_name_int(0, "record_status", status);
		cache_get_value_name(0, "record_desc", record_desc);
		cache_get_value_name(0, "record_officer", giver_name);
		cache_get_value_name(0, "record_officer_rank", giver_rank);
		cache_get_value_name(0, "record_holder", player_name);
		cache_get_value_name(0, "record_holder", player_display_name);
		cache_get_value_name(0, "record_revoker", revoker_name);

		strreplace(giver_name, "_", " ");
		strreplace(player_display_name, "_", " ");
		strreplace(revoker_name, "_", " ");

		new crime = GetCrimeByTypeEnum(crime_type);

		if (viewing)
		{
			if (strlen(giver_rank)) format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}%s was charged by {ADBEE6}%s %s {FFFFFF}for:", player_display_name, giver_rank, giver_name);
			else format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}%s was charged by {ADBEE6} %s {FFFFFF}for:", player_display_name, giver_name);
		}
		else
		{
			if (strlen(giver_rank)) format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You were charged by {ADBEE6}%s %s {FFFFFF}for:", giver_rank, giver_name);
			else format(CrimeDlgStr, sizeof(CrimeDlgStr), "{FFFFFF}You were charged by {ADBEE6}%s {FFFFFF}for:", giver_name);
		}	

		if (crime != -1)
		{
			format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}- %s", CrimeDlgStr, GetCrimeFullName(crime, true, true));
		}
		else
		{
			format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{ADBEE6}- {FFFFFF}%s", CrimeDlgStr, record_desc);
		}


		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{0099FF}Record Number: {ADBEE6}#%05d", CrimeDlgStr, recordid);
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Record Date: {ADBEE6}%s", CrimeDlgStr, date);
		if (crime != -1) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Record Type: {ADBEE6}%s", CrimeDlgStr, GetCrimeClass(crime));
		
		format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Issued By (Name): {ADBEE6}%s", CrimeDlgStr, giver_name);
		if (strlen(giver_rank)) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n{0099FF}Issued By (Title): {ADBEE6}%s", CrimeDlgStr, giver_rank);

		if (status == 2) format(CrimeDlgStr, sizeof(CrimeDlgStr), "%s\n\n{FFFFFF}This charge was revoked by {ADBEE6}%s.", CrimeDlgStr, revoker_name);
		
		inline DlgRecordView(pid, dialogid, response, listitem, string:inputtext[]) 
    	{
			#pragma unused pid, dialogid, inputtext, listitem

			if (response && viewing && status != 2)
			{
				// Revoke the charge
				RevokeCrime(pid, recordid);
			}
			else
			{
				// go back
				ShowCrimes(pid, player_name, viewing);
			}
		}

		if (viewing && status != 2) Dialog_ShowCallback ( playerid, using inline DlgRecordView, DIALOG_STYLE_MSGBOX, sprintf("Viewing Charge #%05d", recordid), CrimeDlgStr, "Revoke", "Back" );
		else Dialog_ShowCallback ( playerid, using inline DlgRecordView, DIALOG_STYLE_MSGBOX, sprintf("Viewing Charge #%05d", recordid), CrimeDlgStr, "Back", "" );
	}

	MySQL_TQueryInline(mysql, using inline Record_OnView, query, "");
	return 1;
}


CMD:mytickets(playerid)
{
    if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new rpname[MAX_PLAYER_NAME];
	format(rpname, sizeof(rpname), "%s", Character[playerid][E_CHARACTER_NAME]);
    ShowTickets(playerid, rpname);
    return true;
}

CMD:payfine(playerid)
{
	if (!IsAtCopFrontDesk(playerid) && !IsAtGovFrontDesk(playerid))
	{
		return SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "You can only pay tickets at the front desk of a police station or City Hall.");
	}

	return cmd_mytickets(playerid);
}

CMD:payticket(playerid)
{
	return cmd_payfine(playerid);
}


CMD:viewtickets(playerid, params[]) {
    
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovRecords(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new rpname[MAX_PLAYER_NAME] ;

	if ( sscanf ( params, "s[24]", rpname ) ) {

		return SendClientMessage(playerid, -1, "/viewtickets [firstname_lastname]" ) ;
	}

	if ( strlen ( rpname ) <= 0 || strlen ( rpname ) > MAX_PLAYER_NAME ) {

		return SendClientMessage(playerid, -1, "Ticket record holder name can't be empty or longer than 24 characters." ) ;
	}

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	new query[128];
	inline ReturnCharid() 
	{
		if (cache_num_rows())
		{
			new name[32];
			cache_get_value_name(0, "player_name", name);
			strreplace(name, "_", " ");

			Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s ran a tickets check on \"%s\" }", Faction[faction_enum_id][E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), name), faction_enum_id, false);
			ShowTickets(playerid, rpname, true);
		}
		else
		{
			SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Database didn't return any data. Did you type the name correctly?");
		}
	}

	mysql_format( mysql, query, sizeof ( query ), "SELECT `player_name` FROM `characters` WHERE `player_name` LIKE '%e'", rpname);
	MySQL_TQueryInline(mysql, using inline ReturnCharid, query, "");

	return true ;
}

CMD:viewcrimes(playerid, params[]) {
    
	if ( IsPlayerIncapacitated(playerid, false) ) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }
    
	if (!IsPlayerInPoliceFaction(playerid, true) && !IsPlayerGovRecords(playerid, true))
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Abuse", "A3A3A3", "You're not on duty as a police officer." ) ;
	}

	new rpname[MAX_PLAYER_NAME] ;

	if ( sscanf ( params, "s[24]", rpname ) ) {

		return SendClientMessage(playerid, -1, "/viewcrimes [firstname_lastname]" ) ;
	}

	if ( strlen ( rpname ) <= 0 || strlen ( rpname ) > MAX_PLAYER_NAME ) {

		return SendClientMessage(playerid, -1, "Crime record holder name can't be empty or longer than 24 characters." ) ;
	}

	new factionid = Character [ playerid ] [ E_CHARACTER_FACTIONID ] ;
	new faction_enum_id = Faction_GetEnumID( factionid ); 

	new query[128];
	inline ReturnCharid() 
	{
		if (cache_num_rows())
		{
			new name[32];
			cache_get_value_name(0, "player_name", name);
			strreplace(name, "_", " ");

			Faction_SendMessage(factionid, sprintf("{ [%s] (%d) %s ran a records check on \"%s\" }", Faction[faction_enum_id][E_FACTION_ABBREV], playerid, ReturnMixedName(playerid), name), faction_enum_id, false);
			ShowCrimes(playerid, rpname, true);
		}
		else
		{
			SendServerMessage(playerid, COLOR_ERROR, "Error", "A3A3A3", "Database didn't return any data. Did you type the name correctly?");
		}
	}

	mysql_format( mysql, query, sizeof ( query ), "SELECT `player_name` FROM `characters` WHERE `player_name` LIKE '%e'", rpname);
	MySQL_TQueryInline(mysql, using inline ReturnCharid, query, "");

	return true ;
}

CMD:criminalrecordview(playerid, params[]) {

	return cmd_viewcrimes(playerid, params);
}

CMD:viewrecord(playerid, params[]) {

	return cmd_viewcrimes(playerid, params);
}

CMD:viewcharges(playerid, params[]) {

	return cmd_viewcrimes(playerid, params);
}

CMD:crview(playerid, params[]) {

	return cmd_viewcrimes(playerid, params);
}

CMD:mycrimes(playerid)
{
    if (IsPlayerIncapacitated(playerid, false)) 
	{
        return SendServerMessage ( playerid, COLOR_ERROR, "Incapacitated", "A3A3A3", "You're currently incapacitated and can't do this." ) ;
    }

	new rpname[MAX_PLAYER_NAME];
	format(rpname, sizeof(rpname), "%s", Character[playerid][E_CHARACTER_NAME]);
    ShowCrimes(playerid, rpname);
    return true;
}

#include <YSI_Coding\y_hooks>
PrintCrimes()
{
	#pragma unused PrintCrimes

	for (new x = 0; x < sizeof(CrimeTitle); x ++)
    {
		printf("[SIZE=5]TITLE %d. %s[/SIZE]", x + 1, CrimeTitle[x][E_CRIME_TITLE_NAME]);
		printf(" ");

		for (new i = 0; i < sizeof(Crime); i ++)
		{
			if (Crime[i][E_CRIME_TITLE] != CrimeTitle[x][E_CRIME_TITLE]) continue;
			printf("[SIZE=4](%d) %02d. [B]%s:[/B] \"%s\"[/SIZE]", x + 1, i + 1, GetCrimeCode(i), Crime[i][E_CRIME_NAME]);
			print(" ");

			new descIndex = 0;
			print("[LIST=1]");
			for (new y = 0; y < sizeof(CrimeDesc); y ++)
			{
				if (CrimeDesc[y][E_CRIME_DESC_CRIME_TYPE] != Crime[i][E_CRIME_TYPE]) continue;
				descIndex ++;
				printf("[*][COLOR=#ADBEE6]%s[/COLOR]", CrimeDesc[y][E_CRIME_DESC_TEXT]);
			}
			print("[/LIST]");

			new min_cost, max_cost;
			GetCrimeMinMaxCost(i, min_cost, max_cost);		

			if (min_cost && max_cost)
			{
				print(" ");

				if (Crime[i][E_CRIME_CLASS] == E_CRIME_CLASS_INFRACTION)
				{
					printf("[B]%s:[/B] \"%s\" is an [B][COLOR=#%06x]%s[/COLOR][/B] punishable by:", GetCrimeCode(i), Crime[i][E_CRIME_NAME], CrimeClass[_:Crime[i][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR], CrimeClass[_:Crime[i][E_CRIME_CLASS]][E_CRIME_CLASS_NAME]);
					printf("[LIST=1][*][COLOR=#ADBEE6]A minimum fine of [COLOR=#A5D6A7]$%s[/COLOR].[/COLOR]", IntegerWithDelimiter(min_cost));
					printf("[*][COLOR=#ADBEE6]A maximum fine of [COLOR=#EF9A9A]$%s[/COLOR].[/COLOR][/LIST]", IntegerWithDelimiter(max_cost));
				}
				else
				{
					printf("[B]%s:[/B] \"%s\" is a [B][COLOR=#%06x]%s[/COLOR][/B] punishable by:", GetCrimeCode(i), Crime[i][E_CRIME_NAME], CrimeClass[_:Crime[i][E_CRIME_CLASS]][E_CRIME_CLASS_COLOR], CrimeClass[_:Crime[i][E_CRIME_CLASS]][E_CRIME_CLASS_NAME]);
					printf("[LIST=1][*][COLOR=#ADBEE6]Imprisonment for a minimum of [COLOR=#A5D6A7]%d[/COLOR] minutes.[/COLOR]", min_cost);
					printf("[*][COLOR=#ADBEE6]Imprisonment for a maximum of [COLOR=#EF9A9A]%d[/COLOR] minutes.[/COLOR][/LIST]", max_cost);
				}
			}

			print(" ");
		}
    }
}

hook OnGameModeInit()
{
	//PrintCrimes();
	return 1;
}