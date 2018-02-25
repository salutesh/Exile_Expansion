/*
© 2015 Zenix Gaming Ops
Developed by Vishpala
Co-Developed by Rod-Serling

All rights reserved.

Function:
	AVS_fnc_spawnAllVehicles - Handles spawning AVS configured vehicles.
Usage Example:
	call AVS_fnc_spawnAllVehicles;
Return Value:
	None
*/

private ["_positionReal"];

_getSpawnedVehicleTracker =
{
	diag_log format["getSpawnedVehicleTracker: %1", _this];
	_desiredUID = _this;
	{
		if ((_x select 0) isEqualTo _desiredUID) exitWith
		{
			_x
		};
	} forEach AVS_SpawnedVehicleTracker;
};

// This code is NECESSARY for spawning persistent vehicles. DO NOT REMOVE THIS CODE UNLESS YOU KNOW WHAT YOU ARE DOING
{
	if !(format["isKnownAccount:%1",_x] call ExileServer_system_database_query_selectSingleField) then
	{
		format["createAccount:%1:%1",_x] call ExileServer_system_database_query_fireAndForget;
	};
} forEach AVS_UIDs;

_blacklistedPositions = [];
if (AVS_useSpawnedPersistentVehiclesLocation) then
{
	{
		diag_log format ["Spawning %1", _x];
		_uid = _x select 0;
		_classNames = _x select 1;
		_damage = _x select 2;
		_numToSpawn = _x select 3;
		_positions = _x select 4;

		_spawnedVehicleTracker = _uid call _getSpawnedVehicleTracker;

		while {(_spawnedVehicleTracker select 1) < _numToSpawn} do
		{
		
			_position = _positions select (floor (random (count _positions)));
			if (AVS_LocationSearchRadius isEqualTo 0) then
			{
				_positionReal = _position;
			}
			else
			{
				_positionReal = [_position, 0, AVS_LocationSearchRadius, 5, 0 , 1 , 0 , _blacklistedPositions] call BIS_fnc_findSafePos;
			};

			[_uid, _classNames, _damage, _positionReal] call AVS_fnc_spawnPersistentVehicle;

			_spawnedVehicleTracker set [1, (_spawnedVehicleTracker select 1) + 1];
			_blacklistedPositions append _positionReal;
		};
	} forEach AVS_spawnedPersistentVehiclesLocation;
};

if (AVS_useSpawnedPersistentVehiclesRoadside) then
{
	{
		_uid = _x select 0;
		_classNames = _x select 1;
		_damage = _x select 2;
		_numToSpawn = _x select 3;

		_spawnedVehicleTracker = _uid call _getSpawnedVehicleTracker;

		while {(_spawnedVehicleTracker select 1) < _numToSpawn} do
		{
			_position = [AVS_WorldCenter, AVS_WorldRadius] call ExileServer_util_position_findRoadPosition;
			_positionReal = [_position, 25, AVS_RoadSearchRadius, 5, 0 , 1 , 0 , _blacklistedPositions] call BIS_fnc_findSafePos;

			[_uid, _classNames, _damage, _positionReal] call AVS_fnc_spawnPersistentVehicle;

			_spawnedVehicleTracker set [1, (_spawnedVehicleTracker select 1) + 1];
			_blacklistedPositions append _positionReal;
		};
	} forEach AVS_spawnedPersistentVehiclesRoadside;
};

if (AVS_useSpawnedPersistentVehiclesRandom) then
{
	{
		_uid = _x select 0;
		_classNames = _x select 1;
		_damage = _x select 2;
		_numToSpawn = _x select 3;

		_spawnedVehicleTracker = _uid call _getSpawnedVehicleTracker;

		while {(_spawnedVehicleTracker select 1) < _numToSpawn} do
		{
			_positionReal = [AVS_WorldCenter, 25, AVS_WorldRadius, 5, 0 , 1 , 0 , _blacklistedPositions] call BIS_fnc_findSafePos;

			[_uid, _classNames, _damage, _positionReal] call AVS_fnc_spawnPersistentVehicle;

			_spawnedVehicleTracker set [1, (_spawnedVehicleTracker select 1) + 1];
			_blacklistedPositions append _positionReal;
		};
	} forEach AVS_spawnedPersistentVehiclesRandom;
};

format ["Dynamic persistent vehicles spawned."] call ExileServer_util_log;
true
