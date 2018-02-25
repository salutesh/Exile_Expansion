/*
© 2015 Zenix Gaming Ops
Developed by Vishpala
Co-Developed by Rod-Serling

All rights reserved.

Function:
	AVS_fnc_spawnPersistentVehicle - Handles creating a single persistent vehicle.
Usage:
	[["VehicleClass1", "VehicleClass2"], .5, [4000,4000,0]] call AVS_fnc_spawnPersistentVehicle;
	Spawns either a "VehicleClass1" or "VehicleClass2" class vehicle with 50% damage at position [4000, 4000, 0]
Return Value:
	None
*/

_uid = _this select 0;
_classNames = _this select 1;
_damage = _this select 2;
_position = _this select 3;

// Sanitize position
if(count _position isEqualTo 2) then
{
	_position pushback 0;
};
if(surfaceIsWater _position)exitWith{};

// Randomly select the vehicle type.
_vehicleClassName =	_classNames select (floor (random (count _classNames)));

// Create the vehicle
_vehicle = [_vehicleClassName, _position, (random 360), true, AVS_PersistentVehiclesPinCode] call ExileServer_object_vehicle_createPersistentVehicle;
_vehicle setVariable ["ExileOwnerUID",_uid];
_vehicle setVariable ["ExileIsLocked",0];
_vehicle lock 0;

// Set damage
_hitpoints = _vehicleClassName call ExileClient_util_vehicle_getHitPoints;

{
	if (typeName _damage isEqualTo "ARRAY") then
	{
		_damageMin = (_damage select 0);
		_damageMax = (_damage select 1);
		_damageDiff = _damageMin - _damageMax;
		_damageChance = random _damageDiff;
		_damage = _damageChance + _damageMin;
		_vehicle setHitPointDamage [_x, _damage];
	}
	else
	{
		_damage = _damage;
		_vehicle setHitPointDamage [_x, _damage];
	};
} forEach _hitpoints;

_vehicle setVehicleAmmoDef (AVS_PersistentVehiclesAmmoPercent / 100);
_vehicle setFuel (AVS_PersistentVehiclesFuelPercent / 100);

// Add vehicle to database.
_vehicle call ExileServer_object_vehicle_database_insert;
_vehicle call ExileServer_object_vehicle_database_update;

// Add a debug marker
if (AVS_DebugMarkers) then
{
	AVS_PersistentLocationCount = AVS_PersistentLocationCount + 1;
	_debugMarker = createMarker ["vehicleMarker#"+str AVS_PersistentLocationCount, _positionReal];
	_debugMarker setMarkerColor "ColorOrange";
	_debugMarker setMarkerType "mil_dot_noShadow";
};