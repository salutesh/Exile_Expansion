/*
	IMS_fnc_HideTerrainObject
	Created by Salutesh

	Usage:
	[
		_vehicleClass,			// STRING: Vehicle classname to hide.
		_position,				// ARRAY: (positionATL or position2d): Where the vehicle/object is located.
		_radius					// NUMBER: Radius to scan for the _vehiclClass objects.
	] call IMS_fnc_HideTerrainObject;

	Hides the given terrain object.
*/

private _terrainObj = objNull;

try
{
	if !(params
	[
		"_vehicleClass",
		"_position",
		"_radius"
	])
	then
	{
		throw (format ["Invalid parameters: %1",_this]);
	};

	if !(isClass (configFile >> "CfgVehicles" >> _vehicleClass)) then
	{
		throw (format ["non-existent vehicle className: %1",_vehicleClass]);
	};


	if ((count _position) isEqualTo 2) then
	{
		_position set [2,0];
	};

	// Hide the object
	_terrainObj = ((nearestobjects [_position, [_vehicleClass], _radius]) select 0);
	hideObjectGlobal _terrainObj;
	
}
catch
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_HideTerrainObject with %1!",_exception];
};

if (IMS_DEBUG) then
{
	(format ["HideTerrainObject :: Created %1 with calling parameters: %2",_terrainObj,_this]) call IMS_fnc_DebugLog;
};

_terrainObj
