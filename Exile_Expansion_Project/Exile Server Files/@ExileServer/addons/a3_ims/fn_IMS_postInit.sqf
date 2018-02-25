/*
	IMS Server Addon Post-Init File
	Written by Salutesh
	www.reality-gaming.eu
*/

private ["_timeStamp","_missionArrayConfig","_missionConfig","_spawnedMissions","_activeMissions","_mission","_missionFile","_staticMissionObjects","_simpleMissionObjects","_scriptObjects"];
_timeStamp = diag_tickTime;

if !(isServer) exitWith
{
	for "_i" from 0 to 99 do
	{
		diag_log "[IMS Server Addon] IMS is for the SERVER ONLY! It will NOT work for any form of client! IMS launch cancelled.";
	};
};

diag_log "----------------------------------------------------------------------------------------------------";
diag_log "---------------- Starting Exile Interactive Mission System Server Addon Post-Init ------------------";
diag_log "------------------------------------------ Version 1.0 ---------------------------------------------";
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format['[IMS Server Addon] Load Interactive Mission Systems'];

// chernarusredux
if (worldName == 'chernarusredux') then
{
	_missionArrayConfig = missionConfigFile >> "CfgExileMissions" >> "Missions";
	_activeMissions = getArray (_missionArrayConfig >> "Chernarusredux" >> "activeMissions");
	{
		_missionConfig = missionConfigFile >> "CfgExileMissions" >> "Missions";
		_missionArray = _x;
		_staticMissionObjects = getArray (_missionConfig >> "Chernarusredux" >> _missionArray >> "staticObjectsFile");
		_simpleMissionObjects = getArray (_missionConfig >> "Chernarusredux" >> _missionArray >> "simpleObjectsFile");
		{
			[_x] call IMS_fnc_ImportFromExileEdenPlugin;				// Spawn all of the static objects that are supposed to be spawned on server startup.
		} forEach _staticMissionObjects;
		{
			[_x] call IMS_fnc_ImportFromExileEdenPluginSimple;			// Spawn all of the static objects that are supposed to be spawned on server startup.
		} forEach _simpleMissionObjects;
		
		_missionFile = getText (_missionConfig >> "Chernarusredux" >> _missionArray >> "missionFile");
		[] call compile preprocessFileLineNumbers (format["a3_ims\missions\chernarusredux\%1.sqf", _missionFile]);
	} forEach _activeMissions;
};

// This code is NECESSARY for spawning persistent vehicles.
if !("isKnownAccount:IMS_PersistentVehicle" call ExileServer_system_database_query_selectSingleField) then
{
	"createAccount:IMS_PersistentVehicle:IMS_PersistentVehicle" call ExileServer_system_database_query_fireAndForget;
};

diag_log format['[IMS Server Addon] Interactive Mission Systems loaded!'];
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format["End of Exile Interactive Mission System Server Addon Post-Init :: Total Execution Time %1 seconds",(diag_tickTime) - _timeStamp];
diag_log "----------------------------------------------------------------------------------------------------";