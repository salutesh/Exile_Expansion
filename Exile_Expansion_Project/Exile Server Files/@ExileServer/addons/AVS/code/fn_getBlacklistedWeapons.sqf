/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_fnc_getBlacklistedWeapons - Returns a list of blacklsited weapons from the AVS configuration for a vehicleClass
Usage:
	_blacklist = (typeOf _vehicleObject) call AVS_fnc_getWeaponBlacklist;
Return Value:
	Array of blacklisted weapons for the specified vehicleClass.
	["WeaponClassName1", "WeaponClassName2" ...]
*/

private["_blacklist"];
_OK = params
[
	["_vehicleClass", "", ["String"]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_getWeaponBlacklist with invalid parameters: %1",_this];
};

_vehicleClass = toLower _vehicleClass;
_blacklist = AVS_GlobalWeaponBlacklist;
{
	if ((_x select 0) isEqualTo _vehicleClass) exitWith
	{
		_blacklist = _x select 1;
	};
} forEach AVS_VehicleWeaponBlacklist;

_blacklist