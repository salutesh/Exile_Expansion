/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_fnc_loadVGAmmo - Loads ammo into a vehicle from the virtual garage database.
Usage:
	_vehicle call AVS_fnc_loadVGAmmo;
Return Value:
	None
*/

private ["_vehicleID", "_data", "_savedMagazines", "_turretPath", "_magData", "_magClass", "_ammoCount"];

_OK = params
[
	["_vehicle", objNull, [objNull]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_loadVGAmmo with invalid parameters: %1",_this];
};

_vehicleID = _vehicle getVariable ["ExileDatabaseID", 0];

_query = format["%1:%2:%3", 0, "AVSDB", format ["getVehicleVGAmmo:%1", _vehicleID]];
_result = call compile ("extDB3" callExtension _query);
_data = (_result select 1) select 0;
_savedMagazines = _data select 0;

_vehicle setVehicleAmmoDef 0;

if (typeName _savedMagazines isEqualTo "ARRAY") then
{
	if (typeName (_savedMagazines select 0) isEqualTo "ARRAY") then
	{
		{
			_turretPath = _x select 0;
	
			for "_i" from (count _x - 1) to 1 step -1 do
			{
				_magData = _x select _i;
				_magClass = _magData select 0;
				_ammoCount = _magData select 1;
	
				_maxMagAmmo = (configFile >> "CfgMagazines" >> _magClass >> "count") call BIS_fnc_getCfgData;
				_numMags = ceil (_ammoCount / _maxMagAmmo);
	
				while {_numMags > 1} do
				{
					_vehicle addMagazineTurret [_magClass, _turretPath];
					_numMags = _numMags - 1;
					_ammoCount = _ammoCount - _maxMagAmmo;
				};
				_vehicle setMagazineTurretAmmo [_magClass, _ammoCount, _turretPath];
			};
		} forEach _savedMagazines;
	};
};