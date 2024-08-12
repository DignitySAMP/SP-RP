#define MAX_TIMESTAMP_FORMAT_LENGTH 128

//AbyssMorgan - Crayder https://github.com/Crayder/Time-Conversion/blob/master/timestamp.inc
//%d:%02d:%02d:%02d (day hour minute second) 
#define SecToTimeDay(%0)            ((%0) / 86400),(((%0) % 86400) / 3600),((((%0) % 86400) % 3600) / 60),((((%0) % 86400) % 3600) % 60) 
#define MSToTimeDay(%0)                SecToTimeDay((%0)/1000) 

//%02d:%02d:%02d (hour minute second) 
#define SecToTime(%0)                ((%0) / 3600),(((%0) % 3600) / 60),(((%0) % 3600) % 60) 
#define MSToTime(%0)                SecToTime((%0)/1000) 

//%02d:%02d (minute second) 
#define SecToTimeMini(%0)            ((%0) / 60),((%0) % 60) 
#define MSToTimeMini(%0)            SecToTimeMini((%0)/1000)  

static stock const
	SECONDS_PER_MINUTE		= 60,
	SECONDS_PER_HOUR		= 3600,
	SECONDS_PER_DAY			= 86400,
	SECONDS_PER_MONTH 		= 2592000,
	SECONDS_PER_YEAR		= 31556952,	// based on 365.2425 days per year
	monthdays[12]			= {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

stock stamp2datetime(sec1970, &year, &month, &day, &hour, &minute, &second, gmh = 0, gmm = 0) {
	new days, seconds;

	for(year = 1970; ; year += 1) {
		days = (365 + (!(year & 0x03) ? 1 : 0)); // Will fail for 2100
		seconds = days * SECONDS_PER_DAY;
		if(seconds > sec1970)
			break;
		sec1970 -= seconds;
	}

	for(month = 1; ; month += 1) {
		if ( month > 12 ) {
			month = 11 ;
		}
		days = monthdays[month - 1];
		seconds = days * SECONDS_PER_DAY;
		if(seconds > sec1970)
			break;
		sec1970 -= seconds;
	}

	for(day = 1; sec1970 >= SECONDS_PER_DAY; day += 1)
		sec1970 -= SECONDS_PER_DAY;

	for(hour = gmh; sec1970 >= SECONDS_PER_HOUR; hour += 1)
		sec1970 -= SECONDS_PER_HOUR;

	for(minute = gmm; sec1970 >= SECONDS_PER_MINUTE; minute += 1)
		sec1970 -= SECONDS_PER_MINUTE;

	second = sec1970;
}

stock datetime2stamp(&sec1970, year, month, day, hour, minute, second, gmh = 0, gmm = 0) {
	for(new y = 1970; y < year; y++)
        day += (365 + (!(y & 0x03) ? 1 : 0));

	for(new m = 1; m < month; m++)
		day += monthdays[m - 1];

    if(!(year & 0x03) && month > 2)
        day += 1;
    day -= 1;
	
    sec1970 += (day * SECONDS_PER_DAY);
    sec1970 += ((hour + gmh) * SECONDS_PER_HOUR);
    sec1970 += ((minute + gmm) * SECONDS_PER_MINUTE);
    sec1970 += second;

    return sec1970;
}

stock weekday(day, month, year) {
    if (month <= 2) {
        month += 12;
		--year;
	}
    new j = year % 100;
    new e = year / 100;
    return ((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7);
}

stock SecondsInTime(&sec1970, year, month, day, hour, minute, second) {
    sec1970 += (year * SECONDS_PER_YEAR);
    sec1970 += (month * SECONDS_PER_DAY * 30);
    sec1970 += (day * SECONDS_PER_DAY);
    sec1970 += (hour * SECONDS_PER_HOUR);
    sec1970 += (minute * SECONDS_PER_MINUTE);
    sec1970 += second;
	
    //sec1970 += (y * 31556952) + (m * 2592000) + (d * 86400) + (h * 3600) + (i * 60) + s;
}

stock TimeInSeconds(sec1970, &year, &month, &day, &hour, &minute, &second) {
	#define MINUTES_IN_HOUR 60
	#define HOURS_IN_DAY 24
	#define DAYS_IN_WEEK 7
	#define DAYS_IN_MONTH 30
	#define DAYS_IN_YEAR 365.2425

	second = sec1970 % SECONDS_PER_MINUTE;
	sec1970 /= SECONDS_PER_MINUTE;
	minute = sec1970 % MINUTES_IN_HOUR;
	sec1970 /= MINUTES_IN_HOUR;
	hour = sec1970 % HOURS_IN_DAY;
	sec1970 /= HOURS_IN_DAY;
	day = sec1970 % DAYS_IN_WEEK;
	sec1970 /= DAYS_IN_WEEK;
	//week = sec1970 & WEEKS_IN_MONTH;
	month = sec1970 / WEEKS_IN_MONTH;
	year = floatround(sec1970 / DAYS_IN_YEAR, floatround_floor);
	
	/*seconds = sec1970 % SECONDS_PER_MINUTE;
	minutes = sec1970 / SECONDS_PER_MINUTE % MINUTES_IN_HOUR;
	hours = sec1970 / SECONDS_PER_MINUTE / MINUTES_IN_HOUR % HOURS_IN_DAY;
	days = sec1970 / SECONDS_PER_MINUTE / MINUTES_IN_HOUR / HOURS_IN_DAY;*/
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

// From Medieval RP :)

#define MAX_MONTH_NAME          ( 10 )
enum monthData {
	month_name [ MAX_MONTH_NAME ],
	month_days
} ;

new monthArray [] [monthData] = {
	{ "January", 31 } ,
	{ "February", 28 } ,
	{ "March", 31 } ,
	{ "April", 30 } ,
	{ "May", 31 } ,
	{ "June", 30 } ,
	{ "July", 31 } ,
	{ "August", 31 } ,
	{ "September", 30 } ,
	{ "October", 31 } ,
	{ "November", 30 } ,
	{ "December", 31 }
} ;

enum {
	MONTH_JANUARY, MONTH_FEBRUARY, MONTH_MARCH,
	MONTH_APRIL, MONTH_MAY, MONTH_JUNE, MONTH_JULY,
	MONTH_AUGUST, MONTH_SEPTEMBER, MONTH_OCTOBER,
	MONTH_NOVEMBER, MONTH_DECEMBER
} ;

stock date_getMonth ( monthid ) {

	new monthName [ MAX_MONTH_NAME ] ;

	if ( monthid == 0 ) {
		monthid = 1 ;
	}

	format ( monthName, MAX_MONTH_NAME, "%s",
	monthArray [ monthid - 1 ] [ month_name ] );

	return monthName ;
}

enum {
	SEASON_SPRING,
	SEASON_SUMMER,
	SEASON_AUTUMN,
	SEASON_WINTER
} ;

stock date_getSeasonID ( monthid ) {
	switch ( monthid ) {
	    case MONTH_MARCH, MONTH_APRIL, MONTH_MAY: {
	        return SEASON_SPRING ;
	    }
	
	    case MONTH_JUNE, MONTH_JULY, MONTH_AUGUST: {
	        return SEASON_SUMMER ;
	    }
	
	    case MONTH_SEPTEMBER, MONTH_OCTOBER, MONTH_NOVEMBER: {
	        return SEASON_AUTUMN ;
	    }
	
	    case MONTH_DECEMBER, MONTH_JANUARY, MONTH_FEBRUARY : {
	        return SEASON_WINTER ;
	    }
	}

	return SEASON_SPRING ;
}

#define MAX_SEASON_NAME     ( 7 )
stock date_getSeason ( monthid ) {

	new seasonid = date_getSeasonID ( monthid ) ,
	seasonName [ MAX_SEASON_NAME ];

	switch ( seasonid ) {
	    case SEASON_SPRING: {
			format ( seasonName, MAX_SEASON_NAME, "Spring" ) ;
	    }
	    
	    case SEASON_SUMMER: {
			format ( seasonName, MAX_SEASON_NAME, "Summer" ) ;
	    }
	    
	    case SEASON_AUTUMN: {
			format ( seasonName, MAX_SEASON_NAME, "Autumn" ) ;
	    }
	    
	    case SEASON_WINTER: {
			format ( seasonName, MAX_SEASON_NAME, "Winter" ) ;
	    }
	}

	return seasonName ;
}

stock date_dayName ( day, month, year ) {
	new weekday_str[10], j, e;

	j = year % 100;
	e = year / 100;

	switch ((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7) {
		case 0: weekday_str = "Saturday";
		case 1: weekday_str = "Sunday";
		case 2: weekday_str = "Monday";
		case 3: weekday_str = "Tuesday";
		case 4: weekday_str = "Wednesday";
		case 5: weekday_str = "Thursday";
		case 6: weekday_str = "Friday";
	}
	
	return weekday_str;
}

stock date_dayOrdinal ( number ) {
	number = number < 0 ? -number : number;
	new _ordinal[][] = { "th", "st", "nd", "rd" };
	return _ordinal[(3 < number % 100 < 21)?(0):((number % 10 > 3)?(0):(number % 10))];
}

GetDuration(time) { 
    new  str[32]; 

    if (time < 0 || time == gettime()) { 

        format(str, sizeof(str), "Never"); 
        return str; 
    } 

    else if (time < 60) format(str, sizeof(str), "%d seconds", time); 
    else if (time >= 0 && time < 60) format(str, sizeof(str), "%d seconds", time); 
    else if (time >= 60 && time < 3600) format(str, sizeof(str), (time >= 120) ? ("%d minutes") : ("%d minute"), time / 60); 
    else if (time >= 3600 && time < 86400) format(str, sizeof(str), (time >= 7200) ? ("%d hours") : ("%d hour"), time / 3600); 
    else if (time >= 86400 && time < 2592000) format(str, sizeof(str), (time >= 172800) ? ("%d days") : ("%d day"), time / 86400); 
    else if (time >= 2592000 && time < 31536000) format(str, sizeof(str), (time >= 5184000) ? ("%d months") : ("%d month"), time / 2592000); 
    else if (time >= 31536000) format(str, sizeof(str), (time >= 63072000) ? ("%d years") : ("%d year"), time / 31536000); 

    strcat(str, " ago"); 

    return str; 
} 

stock GetCountdown(startTimestamp, endTimestamp) {

    new string[MAX_TIMESTAMP_FORMAT_LENGTH];

	new seconds = endTimestamp - startTimestamp;
	if(startTimestamp > endTimestamp) { // sloppiest fix of my life, im going to hell... this fixes the -12378237384 seconds left... right?
		seconds = startTimestamp - endTimestamp;
	}

	if (seconds == 1)
		format(string, sizeof(string), "a second");
	else if (seconds < SECONDS_PER_MINUTE)
		format(string, sizeof(string), "%i seconds", seconds);
	else if (seconds < (2 * SECONDS_PER_MINUTE))
		format(string, sizeof(string), "a minute");
	else if (seconds < (45 * SECONDS_PER_MINUTE))
		format(string, sizeof(string), "%i minutes", (seconds / SECONDS_PER_MINUTE));
	else if (seconds < (90 * SECONDS_PER_MINUTE))
		format(string, sizeof(string), "an hour");
	else if (seconds < (24 * SECONDS_PER_HOUR))
		format(string, sizeof(string), "%i hours", (seconds / SECONDS_PER_HOUR));
	else if (seconds < (48 * SECONDS_PER_HOUR))
		format(string, sizeof(string), "a day");
	else if (seconds < (30 * SECONDS_PER_DAY))
		format(string, sizeof(string), "%i days", (seconds / SECONDS_PER_DAY));
	else if (seconds < (12 * SECONDS_PER_MONTH)) {
		new months = floatround(seconds / SECONDS_PER_DAY / 30);
      	if (months <= 1)
			format(string, sizeof(string), "a month");
      	else
			format(string, sizeof(string), "%i months", months);
	}
    else {
      	new years = floatround(seconds / SECONDS_PER_DAY / 365);
      	if (years <= 1)
			format(string, sizeof(string), "a year");
      	else
			format(string, sizeof(string), "%i years", years);
	}

	return string;
}

stock ConvertFromSeconds(TimeUnit:type, seconds) {
	switch (type) {
		case Year:
			return seconds / SECONDS_PER_YEAR;
		case Month:
		    return seconds / (SECONDS_PER_DAY * 31);
		case Day:
		    return seconds / SECONDS_PER_DAY;
		case Hour:
		    return seconds / SECONDS_PER_HOUR;
		case Minute:
		    return seconds / SECONDS_PER_MINUTE;
	}

	return 0;
}

stock ConvertToSeconds(TimeUnit:type, value) {

	switch (type) {
		case Year:
			return SECONDS_PER_YEAR * value;
		case Month:
		    return SECONDS_PER_DAY * (31 * value);
		case Day:
		    return SECONDS_PER_DAY * value;
		case Hour:
		    return SECONDS_PER_HOUR * value;
		case Minute:
		    return SECONDS_PER_MINUTE * value;
	}

	return 0;
}


///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
