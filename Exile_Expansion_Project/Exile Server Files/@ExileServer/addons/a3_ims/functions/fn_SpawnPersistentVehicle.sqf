/*
	IMS_fnc_SpawnPersistentVehicle
	Created by eraser1 and modified by Salutesh

	Usage:
	[
		_vehicleClass,			// STRING: Vehicle classname to spawn.
		_position,				// ARRAY (positionATL or position2d): Where the vehicle will be spawned (strict)
		_pinCode,				// STRING or NUMBER: String has to be 4 digits. Number has to be between 0-9999, and will be automatically formatted.
		_markerName,			// STRING: Marker name to spawn for the vehicle.
	] call IMS_fnc_SpawnPersistentVehicle;

	Returns the created vehicle object.
*/

private _vehObj = objNull;

try
{
	if !(params
	[
		"_vehicleClass",
		"_position",
		"_pinCode",
		"_markerName"
	])
	then
	{
		throw (format ["invalid parameters: %1",_this]);
	};

	if !(isClass (configFile >> "CfgVehicles" >> _vehicleClass)) then
	{
		throw (format ["non-existent vehicle className: %1",_vehicleClass]);
	};


	if ((count _position) isEqualTo 2) then
	{
		_position set [2,0];
	};


	if (_pinCode isEqualType 0) then
	{
		if (_pinCode<0 || {_pinCode>9999}) then
		{
			throw (format ["Invalid SCALAR _pinCode value (must be between 0 and 9999): %1",_pinCode]);
		};

		switch (true) do
		{
			case (_pinCode<10):
			{
				_pinCode = format ["000%1",_pinCode];
			};

			case (_pinCode<100):
			{
				_pinCode = format ["00%1",_pinCode];
			};

			case (_pinCode<1000):
			{
				_pinCode = format ["0%1",_pinCode];
			};

			default
			{
				_pinCode = str _pinCode;
			};
		};
	};

	if ((count _pinCode)!=4) then
	{
		throw (format ["Invalid STRING _pinCode value (must be 4 digits): %1",_pinCode]);
	};

	// Create and set the vehicle
	_vehObj = [_vehicleClass, _position] call IMS_fnc_SpawnNonPersistentVehicle;
	
	// Get position nearby players.
	_playerUnits = (_position nearEntities ["Exile_Unit_Player", 250]);
	
	// Announce the loot drop.
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Display toast notification for mission players.
		[_sessionID, "toastRequest", ["ParadropTitleAndText", format ["Vehicle drop incoming! The Pin-Code for the Vehicle is: %1", _pinCode]]] call ExileServer_system_network_send_to;
	} forEach _playerUnits;
	
	// Create Marker on vehicle position
	_positionNew = getPos _vehObj;
	[
		_positionNew,
		"ExileExpansionAirdropIcon",
		"Reward",							// STRING: Label to spawn for the marker.
		_markerName,						// STRING: Name to spawn for the marker.
		"VehicleLoot",						// STRING: Scriptname for the marker.
		true								// BOOLEAN: Delete marker after 2 minutes? 
	] remoteExec ["ExileExpansionClient_gui_createMapMarker", 0, true];

	// Give vehicle needed Eventhandlers vehicle on exit.
	_vehObj addEventHandler ["GetOut", {_this call ExileServer_object_vehicle_event_onGetOut}];
	_vehObj call ExileServer_system_simulationMonitor_addVehicle;

	// Set up vars
	_vehObj setVariable ["ExileIsPersistent", true];
	_vehObj setVariable ["ExileAccessCode", _pinCode];
	_vehObj setVariable ["ExileOwnerUID", "IMS_PersistentVehicle"];		// Don't change this unless you know what you're doing.
	_vehObj allowDamage true;
	_vehObj enableRopeAttach true;
	_vehObj enableSimulationGlobal true;
	
	// Save vehicle
	_vehObj call ExileServer_object_vehicle_database_insert;
	_vehObj call ExileServer_object_vehicle_database_update;
}
catch
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_SpawnPersistentVehicle with %1!",_exception];
};

if (IMS_DEBUG) then
{
	(format ["SpawnPersistentVehicle :: Created %1 with calling parameters: %2",_vehObj,_this]) call IMS_fnc_DebugLog;
};

_vehObj
