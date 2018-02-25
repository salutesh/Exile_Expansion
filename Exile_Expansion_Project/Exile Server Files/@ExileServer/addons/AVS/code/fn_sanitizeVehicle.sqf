/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_fnc_sanitizeVehicle - Applys AVS configuration restrictions to a vehicle.
	Handles removing weapons, ammo, thermal, and nightvision.
Usage:
	_vehicle call AVS_fnc_sanitizeVehicle;
Return Value:
	None
*/
private ["_vehicleClass", "_vehicleLoadout", "_vehicleWeaponBlacklist", "_vehicleAmmoBlacklist", "_seat", "_seatWeapons", "_seatMagazines", "_weaponMagazines"];

_OK = params
[
	["_vehicle", objNull, [objNull]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_sanitizeVehicle with invalid parameters: %1",_this];
};

_vehicleClass = typeOf _vehicle;
_vehicleLoadout = _vehicleClass call AVS_fnc_getConfigLoadout;
_vehicleWeaponBlacklist = _vehicleClass call AVS_fnc_getBlacklistedWeapons;
_vehicleAmmoBlacklist = _vehicleClass call AVS_fnc_getBlacklistedAmmo;

{
	_seat = _x select 0;
	_seatWeapons = _x select 1;
	_seatMagazines = _x select 2;

	// Sanitize Weapons
	{
		if (toLower _x in _vehicleWeaponBlacklist) then
		{
			_weaponMagazines = (configFile >> "CfgWeapons" >> _x >> "magazines") call BIS_fnc_GetCfgData;
			_vehicle removeWeaponTurret [_x, _seat];
			{
				_vehicle removeMagazinesTurret [_x, _seat];
			} forEach _weaponMagazines;
		};
	} forEach _seatWeapons;

	// Sanitize Ammo
	{
		if (toLower _x in _vehicleAmmoBlacklist) then
		{
			_vehicle removeMagazinesTurret [_x, _seat];
		}
	} forEach _seatMagazines;
} forEach _vehicleLoadout;

// Sanitize Thermal
if (AVS_DisableVehicleThermalGlobal || {(toLower _vehicleClass) in AVS_DisableVehicleThermal}) then
{
	_vehicle disableTIEquipment true;
};
// Sanitize NVGs
if (AVS_DisableVehicleNVGsGlobal || {(toLower _vehicleClass) in AVS_DisableVehicleNVG}) then
{
	_vehicle disableNVGEquipment true;
};

// Disable stock rearm system
if (AVS_DisableStockRearm) then
{
	_vehicle setAmmoCargo 0;
};

// Disable stock refuel system
if (AVS_DisableStockRefuel) then
{
	_vehicle setFuelCargo 0;
};