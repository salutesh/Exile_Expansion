/*
	IMS_fnc_LootDrop
	Created by Salutesh

	Usage:
	[
		_position,				// ARRAY (positionATL or position2d): Where the crate will be spawned (strict)
		_box,					// STRING or NUMBER: String has to be 4 digits. Number has to be between 0-9999, and will be automatically formatted.
	] call IMS_fnc_LootDrop;

	Returns the created loot crate object.
*/

 _lootCrate = objNull;

try
{
	if !(params
	[
		"_position",
		"_box",
		"_lootType",
		"_markerName"
	])
	exitWith
	{
		diag_log format ["IMS ERROR :: Calling IMS_fnc_LootDrop with invalid parameters: %1",_this];
		objNull
	};

	_position = _this select 0;
	_box = _this select 1;
	_lootType = _this select 2;
	_markerName = _this select 3;
	
	// Get player units nearby position.
	_playerUnits = (_position nearEntities ["Exile_Unit_Player", 250]);
	
	// Allow ownly mission units to loot the crate.
	{
		player setVariable ["CanLootCrate", true];
	} forEach _playerUnits;
	
	// Crate loot setup.
	_lootTypeConfig = missionConfigFile >> "CfgExileMissions" >> "LootContainers";
	_lootWeaponItemsArray = getArray (_lootTypeConfig >> _lootType >> "weapons");
	_lootMedicalItemsArray = getArray (_lootTypeConfig >> _lootType >> "medicals");
	_lootGearItemsArray = getArray (_lootTypeConfig >> _lootType >> "gear");
	_lootPoptabs = getNumber (_lootTypeConfig >> _lootType >> "poptabs");
	_weapon = selectRandom _lootWeaponItemsArray;
	_weapon2 = selectRandom _lootWeaponItemsArray;
	_medecine = selectRandom _lootMedicalItemsArray;
	_magazine = selectRandom (getArray (configFile >> "CfgWeapons" >> _weaponLoot >> "magazines"));
	_magazine2 = selectRandom (getArray (configFile >> "CfgWeapons" >> _weaponLoot2 >> "magazines"));

	// Create crate and paracute.
	_parachute = createVehicle ["NonSteerable_Parachute_F", [_position select 0, _position select 1, (_position select 2) + 150], [], 0, "CAN_COLLIDE"];
	_lootCrate = createVehicle [_box, [_position select 0, _position select 1, (_position select 2) + 150], [], 0, ""];
	_lootCrate allowDamage false;
	_parachute setDir getDir _obj;
	_parachute setPos getPos _obj;
	_lootCrate attachTo [_parachute, [0, 0, -1.2]];
	clearMagazineCargoGlobal _lootCrate; 
	clearWeaponCargoGlobal _lootCrate;
	clearItemCargoGlobal _lootCrate;
	clearBackpackCargoGlobal _lootCrate;
	
	// Lock the crate.
	_lootCrate setVariable ["ExileIsLocked", -1, true];
	
	// Add hold action.		
	[
		_lootCrate,
		getText (_lootTypeConfig >> _lootType >> "text"),
		getText (_lootTypeConfig >> _lootType >> "icon"),
		getText (_lootTypeConfig >> _lootType >> "icon"),
		"_this distance _target < 3 && (player getVariable ['CanLootCrate', true])",
		"_caller distance _target < 3",
		{},
		{},
		{
			_lootCrate = (_this select 3) select 0;  // <<-- This gets the first Argument given to the hold action under 10: Arguments
			_scriptHandler = [_lootCrate] spawn
			{
				_lootCrate = _this select 0;
				[_lootCrate, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_lootCrate setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_lootCrate];
		},
		{},
		[_lootCrate],
		0.5,
		0,
		true
	] remoteExec ["ExileExpansionClient_gui_holdActionAdd", 0, true];
	
	// Adding loot to crate.
	{
		_lootCrate addWeaponCargoGlobal [_x, 2];
	} forEach [_weapon, _weapon2];
	{
		_lootCrate addMagazineCargoGlobal [_x, 4];
	} forEach [_magazine, _magazine2];
	_lootCrate addItemCargoGlobal [_medecineLoot, (3 + floor(random 1))];
	{
		_lootCrate addItemCargoGlobal [_x, 2];
	} forEach _lootGearItemsArray;
	_lootCrate setVariable ["ExileMoney", _lootPoptabs, true];
	
	// Create chemlight.
	_chemlight = "Chemlight_blue" createVehicle (position _lootCrate);
	_chemlight setDir getDir _lootCrate;
	_chemlight setPos getPos _lootCrate;
	_chemlight attachto [_lootCrate, [0,0,0]];
	
	// Create the smokeshell.
	_smoke = "SmokeShellGreen" createVehicle (position _lootCrate);
	_smoke setDir getDir _lootCrate;
	_smoke setPos getPos _lootCrate;
	_smoke attachto [_lootCrate, [0,0,0]];
	
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Display toast notification for mission players.
		[_sessionID, "toastRequest", ["ParadropTitleAndText", ["Loot Drop", "A loot container has been droped!"]]] call ExileServer_system_network_send_to;
	} forEach _playerUnits;
	
	// Check when crate hits the ground.
	_boxheight = getpos _lootCrate select 2;
	while {getPos _lootCrate select 2 < 0} do
	{
		sleep 0.1;
	};
	while {getPos _lootCrate select 2 > 1} do
	{
		sleep 0.1;
	};
	
	detach _lootCrate;
	sleep 0.1;
	deleteVehicle _parachute;
	_oldPos = getPos _lootCrate;
	sleep 0.1;
	
	// Find a save position minimum 1m from from old position but not further than 20m, not closer than 3m to any other object, not in the water, maximum gradient of 20, not on the shoreline
	_savePos = [_oldPos, 1, 20, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_lootCrate setPos _savePos;
	
	[
		position _lootCrate,
		"ExileExpansionAirdropIcon",
		"Reward",							// STRING: Label to spawn for the marker.
		_markerName,						// STRING: Name to spawn for the marker.
		"ContainerLoot",					// STRING: Scriptname for the marker.
		true								// BOOLEAN: Delete marker after 2 minutes? 
	] remoteExec ["ExileExpansionClient_gui_createMapMarker", 0, true];
	
	_lootCrate
}
catch
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_LootDrop with %1!",_exception];
};
