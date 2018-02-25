/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_fnc_saveAmmo - Saves ammo from a vehicle to the database.
Usage:
	_vehicle call AVS_fnc_loadAmmo;
Return Value:
	None
*/

private ["_currentLoadout", "_vehicleID", "_extDB2Message"];

_OK = params
[
	["_vehicle", objNull, [objNull]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_saveAmmo with invalid parameters: %1",_this];
};

_currentLoadout = _vehicle call AVS_fnc_getVehicleLoadout;


_vehicleID = _vehicle getVariable ["ExileDatabaseID", -1];

if (_vehicleID > -1) then
{
	_extDB3Message = ["setVehicleAmmo", [_currentLoadout, _vehicleID]] call ExileServer_util_extDB2_createMessage;

	_query = format["%1:%2:%3", 1, "AVSDB", _extDB3Message];
	"extDB3" callExtension _query;
};