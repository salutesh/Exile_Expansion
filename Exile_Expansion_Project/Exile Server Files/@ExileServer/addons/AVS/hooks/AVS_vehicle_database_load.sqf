/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_vehicle_database_load hook - Redirects Exile function calls to perform AVS functions.
*/
private ["_vehicle", "_ownerUID"];

_vehicle = _this call ExileServer_object_vehicle_database_load_ORIGINAL;
_ownerUID = _vehicle getVariable ["ExileOwnerUID", ""],

{
	if (_x select 0 isEqualTo _ownerUID) exitWith
	{
		_x set [1, (_x select 1) + 1];
	};
} forEach AVS_SpawnedVehicleTracker;

_vehicle call AVS_fnc_loadAmmo;
_vehicle