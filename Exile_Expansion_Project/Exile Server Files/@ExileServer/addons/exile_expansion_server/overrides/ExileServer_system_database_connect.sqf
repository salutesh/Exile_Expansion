/**
 * ExileServer_system_database_connect
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_isConnected","_error","_result"];
_isConnected = false;
_error_locked = false;
ExileServerDatabaseSessionId = "";
ExileServerRconSessionID = "";
try 
{
	_result = "extDB3" callExtension "9:VERSION";
	format ["Installed extDB3 version: %1", _result] call ExileServer_util_log;
	if ((parseNumber _result) < 1.027) then
	{
		throw format ["Error Required extDB3 Version 1.027 or higher: %1", _result]; 
	};
	_result = parseSimpleArray ("extDB3" callExtension "9:ADD_DATABASE:exile");
	if (_result select 0 isEqualTo 0) then
	{
		throw format ["Could not add database: %1", _result]; 
	};
	"Connected to database!" call ExileServer_util_log;
	ExileServerDatabaseSessionId = "SQL"; //str(round(random(999999)));
	_result = parseSimpleArray ("extDB3" callExtension "9:ADD_DATABASE_PROTOCOL:exile:SQL_CUSTOM:SQL:exile.ini");
	if ((_result select 0) isEqualTo 0) then
	{
		throw format ["Failed to initialize database protocol: %1", _result]; 
	};
	ExileServerStartTime = (parseSimpleArray ("extDB3" callExtension "9:LOCAL_TIME")) select 1;
	"Database protocol initialized!" call ExileServer_util_log;
	"extDB3" callExtension "9:ADD_PROTOCOL:LOG:TRADING:Exile_TradingLog";
	"extDB3" callExtension "9:ADD_PROTOCOL:LOG:DEATH:Exile_DeathLog";
	"extDB3" callExtension "9:ADD_PROTOCOL:LOG:TERRITORY:Exile_TerritoryLog";
	"extDB3" callExtension "9:LOCK";
	_isConnected = true;
}
catch
{
	if (!_error_locked) then
	{
		"MySQL connection error!" call ExileServer_util_log;
		"Make sure [Database] in the extdb3-conf.ini is set to [exile] unless you have a different database setup!!!!!" call ExileServer_util_log;
		"Please have a look at @extDB3/logs/ to find out what went wrong." call ExileServer_util_log;
		format ["MySQL Error: %1", _exception]  call ExileServer_util_log;
		"Server will shutdown now :(" call ExileServer_util_log;
		'#shutdown' call ExileServer_system_rcon_event_sendCommand;
		//"extDB3" callExtension "9:SHUTDOWN"; Not implemented in extDB3
	}
	else
	{
		format ["extDB3: %1", _exception] call ExileServer_util_log;
		"Check your server rpt for errors, your mission might be stuck a loop restarting" call ExileServer_util_log;
	};
};
_isConnected
