/**
 * ExileServer_system_trading_network_purchaseVehicleRequest
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 *
 * Changes by Xine (Untriel) idea from krwtt and posted by BetterDeadThanZed
 */
 
private["_sessionID","_parameters","_vehicleClass","_pinCode","_playerObject","_useInventory","_salesPrice","_playerMoney","_position","_vehicleObject","_logging","_traderLog","_responseCode"];
_sessionID = _this select 0;
_parameters = _this select 1;
_vehicleClass = _parameters select 0;
_pinCode = _parameters select 1;
_useInventory = _parameters select 2;
try 
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _playerObject) then
	{
		throw 1;
	};
	if !(alive _playerObject) then
	{
		throw 2;
	};
	if (_playerObject getVariable ["ExileMutex",false]) then
	{
		throw 12;
	};
	_playerObject setVariable ["ExileMutex", true];
	if !(isClass (missionConfigFile >> "CfgExileArsenal" >> _vehicleClass) ) then
	{
		throw 3;
	};
	_salesPrice = getNumber (missionConfigFile >> "CfgExileArsenal" >> _vehicleClass >> "price");
	if (_salesPrice <= 0) then
	{
		throw 4;
	};
	_playerMoney = _playerObject getVariable ["ExileMoney", 0];
	if (_playerMoney < _salesPrice) then
	{
		throw 5;
	};
	if !((count _pinCode) isEqualTo 4) then
	{
		throw 11;
	};
	
	if (_useInventory) then
	{
		_check = [ExileTraderInventory,[_vehicleClass, false]] call ExileClient_util_dictionary_get;
		if (_check isEqualType false) then
		{
			throw 15;
		};
		if ((_check - 1) < 0) then
		{
			throw 16;
		};
		if ((_check - 1) < 1) then
		{
			ExileTraderInventory =
			[ExileTraderInventory,[_vehicleClass]] call ExileClient_util_dictionary_remove;
		}
		else
		{
			ExileTraderInventory =
			[ExileTraderInventory,[_vehicleClass, _check - 1]] call ExileClient_util_dictionary_set;
		};
		["updateTraderInventoryResponse",[ExileTraderInventory]] call ExileServer_system_network_send_broadcast;
		format["updateItemStock:%1:%2",-1, _vehicleClass] call ExileServer_system_database_query_fireAndForget;
	};

	_spawnObject 	= "Land_HelipadEmpty_F"; // the object you want to use for spawning, can't be a simple object
	_safeRadius 	= 5; // radius around the spawn object where it looks for room, must be 5 or higher
	_disableCheck	= 0; // set to 1 if you don't want to check if there is a vehicle near the spawn object
	_disableRadius 	= 0; // set to 1 if you want vehicles to only spawn at the exact coords of your spawn object, not recommended better to reduce _safeRadius
	_dirShip		= (random 360); // set rotation of ship vehicle spawning, default = random
	_dirAir			= (random 360); // set rotation of air vehicle spawning, default = random
	_dirOther		= (random 360); // set rotation of all other vehicles spawning, default = random
	_errorMessage 	= "There is no room to safely spawn this vehicle!"; // (toast)message to player when there is no room to spawn

	_nObject = nearestObject [(getPosATL _playerObject), _spawnObject];
	_throwError = 0;

	if (isNull _nObject) then
	{
		if (_vehicleClass isKindOf "Ship") then
		{
			_position = [(getPosATL _playerObject), 80, 10] call ExileClient_util_world_findWaterPosition;
			if (_position isEqualTo []) then 
			{
				throw 13;
			};
			_vehicleObject = [_vehicleClass, _position, (random 360), false, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
		}
		else
		{
			_position = (getPos _playerObject) findEmptyPosition [10, 175, _vehicleClass];
			if (_position isEqualTo []) then 
			{
				throw 13;
			};
			_vehicleObject = [_vehicleClass, _position, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
		};
	}
	else
	{
		_position = getPos _nObject;

		if (_position isEqualTo []) then 
		{
			[_sessionID, "toastRequest", ["ErrorTitleAndText", ["Error: Unable to get the position of the Spawn Object."]]] call ExileServer_system_network_send_to;
			_throwError = 1;
		};

		if (_disableCheck isEqualTo 1) then
		{
			switch (true) do {
				case (_vehicleClass isKindOf "Ship"): {
					_vehicleObject = [_vehicleClass, _position, _dirShip, false, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
				};
				case (_vehicleClass isKindOf "Air"): {
					_vehicleObject = [_vehicleClass, _position, _dirAir, true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
				};
				default {
					_vehicleObject = [_vehicleClass, _position, _dirOther, true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
				};
			};
		}
		else 
		{
			_findEmpty = _position findEmptyPosition [0, _safeRadius, _vehicleClass];
			if (_findEmpty isEqualTo []) then
			{
				[_sessionID, "toastRequest", ["ErrorTitleAndText", [_errorMessage]]] call ExileServer_system_network_send_to;
				_throwError = 1;
			}
			else
			{
				_isEmpty = _findEmpty isFlatEmpty [-1, -1, -1, -1, -1, false, _nObject];
				if (_isEmpty isEqualTo []) then
				{
					[_sessionID, "toastRequest", ["ErrorTitleAndText", [_errorMessage]]] call ExileServer_system_network_send_to;
					_throwError = 1;
				}
				else
				{
					switch (true) do {
						case (_vehicleClass isKindOf "Ship"): {
							if (_disableRadius isEqualTo 1) then
							{
								_vehicleObject = [_vehicleClass, _position, _dirShip, false, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
							}
							else
							{
								_vehicleObject = [_vehicleClass, _findEmpty, _dirShip, false, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
							};
						};
						case (_vehicleClass isKindOf "Air"): {
							if (_disableRadius isEqualTo 1) then
							{
								_vehicleObject = [_vehicleClass, _position, _dirAir, true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
							}
							else
							{
								_vehicleObject = [_vehicleClass, _findEmpty, _dirAir, true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
							};
						};
						default {
							if (_disableRadius isEqualTo 1) then
							{
								_vehicleObject = [_vehicleClass, _position, _dirOther, true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
							}
							else
							{
								_vehicleObject = [_vehicleClass, _findEmpty, _dirOther, true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
							};
						};
					};
				};
			};
		};
	};

	if (_throwError isEqualTo 0) then
	{
		_vehicleObject setVariable ["ExileOwnerUID", (getPlayerUID _playerObject)];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_playerMoney = _playerMoney - _salesPrice;
		_playerObject setVariable ["ExileMoney", _playerMoney, true];
		format["setPlayerMoney:%1:%2", _playerMoney, _playerObject getVariable ["ExileDatabaseID", 0]] call ExileServer_system_database_query_fireAndForget;
		//[_sessionID, "purchaseVehicleResponse", [0, netId _vehicleObject, _salesPrice]] call ExileServer_system_network_send_to;
		[_sessionID, "purchaseVehicleResponse", [0, netId _vehicleObject, _salesPrice]] call ExileServer_system_network_send_to;
		[_sessionID, "toastRequest", ["VehicleTitleAndText", ["Vehicle Spawn Zone", "Please remove your vehicle from the spawn zone now to prevent damage and death."]]] call ExileServer_system_network_send_to;
		_logging = getNumber(configFile >> "CfgSettings" >> "Logging" >> "traderLogging");
		if (_logging isEqualTo 1) then
		{
			_traderLog = format ["PLAYER: ( %1 ) %2 PURCHASED VEHICLE %3 FOR %4 POPTABS | PLAYER TOTAL MONEY: %5",getPlayerUID _playerObject,_playerObject,_vehicleClass,_salesPrice,_playerMoney];
			"extDB3" callExtension format["1:TRADING:%1",_traderLog];
		};
	};
}
catch 
{
	_responseCode = _exception;
	[_sessionID, "purchaseVehicleResponse", [_responseCode, "", 0]] call ExileServer_system_network_send_to;
};
if !(isNull _playerObject) then 
{
	_playerObject setVariable ["ExileMutex", false];
};
true