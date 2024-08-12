#include <a_samp>
#include <a_mysql>
#include <YSI_Extra\y_inline_mysql>

new MySQL:mysql;
MySQL_Init()
{
	mysql = mysql_connect_file();

    if(mysql_errno(mysql) != 0) return print(" * [SQL] Could not connect to database!\n");
	return print(" * [SQL] Connected to database ");
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	new string[256];
	format(string, sizeof(string), "[SEND TO DEV TEAM]: SQL ERROR (%s): %s at %s", error, query, callback);

	SendAdminMessage("-----", 0x1e00ffFF, false);
	SendAdminMessage(string, 0xff00bdFF, true);
	SendAdminMessage("-----", 0x1e00ffFF, false);

	switch(errorid)
	{
		case CR_SERVER_GONE_ERROR:
		{
			printf(" * [SQL] Lost connection to server, trying reconnect...");
		}
		case ER_SYNTAX_ERROR:
		{
			printf(" * [SQL] Something is wrong in your syntax, query: %s",query);
		}
	}
	return 1;
}