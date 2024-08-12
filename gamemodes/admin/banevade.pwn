BanEvaderCheck ( playerid ) {
	inline GetBanData() {
		new banned_ip[ 16 ];
		for (new i = 0, r = cache_num_rows(); i < r; ++i) {
			cache_get_value_name(i, "account_ip", banned_ip);
			if (IpMatch(banned_ip, ReturnIP(playerid))) {
				SendAdminMessage(sprintf("[BAN EVADING] ID %d may be ban evading!  Do a GEO location check!", playerid));
				SendAdminMessage(sprintf("Their IP (%s) matches netblock of banned IP (%s) and (%d total matches!)", ReturnIP(playerid), banned_ip, cache_num_rows()));
				break;
			}
		}
	}

	MySQL_TQueryInline(mysql, using inline GetBanData, "SELECT account_ip FROM bans");

	return true ;
}

GetIPVal ( const ip[] ) {

  	new len = strlen(ip);

	if (!(len > 0 && len < 17))
    	return 0;

	new count, pos, dest[3], val[4];
	for (new i; i < len; i++) {

		if (ip[i] == '.' || i == len) {
			strmid(dest, ip, pos, i);
			pos = (i + 1);
		
		    val[count] = strval(dest);
		    if (!(1 <= val[count] <= 255))
		        return 0;
		        
			count++;
			if (count > 3)
				return 0;
		}
	}
	
	if (count != 3)
	    return 0;

	return ((val[0] * 16777216) + (val[1] * 65536) + (val[2] * 256) + (val[3]));
}

IpMatch(const ip1[], const ip2[], rangetype = 26) {
   	new ip = GetIPVal(ip1);
    new subnet = GetIPVal(ip2);

    new mask = -1 << (32 - rangetype);
    subnet &= mask;

    return bool:((ip & mask) == subnet);
}