/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_fnc_getBlacklistedAmmo - Returns a list of blacklsited ammo from the configuration for a vehicleClass
Usage:
	_blacklist = (typeOf _vehicleObject) call AVS_fnc_getAmmoBlacklist;
Return Value:
	Array of blacklisted ammo for the specified vehicleClass.
	["MagazineClassName1", "MagazineClassName2" ...]
*/

private["_blacklist"];
_OK = params
[
	["_vehicleClass", "", ["String"]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_getAmmoBlacklist with invalid parameters: %1",_this];
};

_vehicleClass = toLower _vehicleClass;
_blacklist = AVS_GlobalAmmoBlacklist;
{
	if ((_x select 0) isEqualTo _vehicleClass) exitWith
	{
		_blacklist = _x select 1;
	};
} forEach AVS_VehicleAmmoBlacklist;
_blacklist