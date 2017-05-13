/*
	CLS_fnc_ImportFromXCamInteractionCrates
	Created by Salutesh

	Usage:
	[
		_file																// String: The filename (or filepath under the objects folder) that contains the exported Exile Eden Plugin objects
	] call CLS_fnc_ImportFromXCamInteractionCrates;

	_file call CLS_fnc_ImportFromXCamInteractionCrates; 							// This also works

	This function will simply create the objects from a file that is included to the addons objects folder and makes them to interactable loot containers with configured loot tables.
*/

if !(params
[
	["_file","",[""]]
])
exitWith
{
	diag_log format ["CLS ERROR :: Calling CLS_fnc_ImportFromXCamInteractionCrates with invalid parameters: %1",_this];
	[]
};

// The next few lines checks to see if the static base has been spawned previously, in order to avoid spawning duplicate objects.
private _varname = format ["CLS_XCamLootCrateSpawned_%1",_file];

if (missionNamespace getVariable [_varname,false]) exitWith
{
	diag_log format ["CLS ERROR :: Attempting to spawn supply crate objects with file ""%1"" after it has already been spawned!",_file];
};

missionNamespace setVariable [_varname,true];


private _export = call compile preprocessFileLineNumbers (format ["a3_exile_expansion_cls\code\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["CLS ERROR :: Calling CLS_fnc_ImportFromXCamInteractionCrates with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	private _obj = objNull;
	private _adString = "CAN_COLLIDE";
	private _dat = [(_x select 0),(_x select 1),(_x select 2),(_x select 3),(_x select 4),(_x select 5),(_x select 6),(_x select 7),(_x select 8)];

	// Create the object
	_obj = createVehicle [(_dat select 0), [0,0,0], [], 0, _adString];
	if((_dat select 4) == 0) then {_obj enableSimulation false};
	if((_dat select 8) == 0) then {_obj allowDamage false};
	_obj setdir (_dat select 2);
	if((_dat select 3) == -100) then
	{
		_obj setposATL (call compile (_dat select 1));
		if((_dat select 5) == 0) then {_obj setVectorUp [0,0,1]} else {_obj setVectorUp (surfacenormal (getPosATL _obj))};
	}
	else
	{
		_obj setposworld [((call compile (_dat select 1)) select 0),((call compile (_dat select 1)) select 1),(_dat select 3)];
		[_obj,((_dat select 7) select 0),((_dat select 7) select 1)] call BIS_fnc_setPitchBank;
	};
	if(count (_dat select 6) > 0) then {{call _x} foreach (_dat select 6)};
	
	private _spawnedItemClassNames = [];
	
	if ((typeOf _obj) in TrashBinObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through trashbin", "trashbin", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom TrashBinObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in CartonObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through carton", "crate", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom CartonObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in ToolboxObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through toolbox", "toolbox", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom ToolboxObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in BoxObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through box", "box", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom BoxObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in VendingMachineObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through machine", "machine", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom VendingMachineObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in FootlockerObjectClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through locker", "footlocker", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom FootlockerObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in BarrelObjectClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through barrel", "barrel", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom BarrelObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in BagObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through bag", "bag", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom BagObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in SuitcaseObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through suitcase", "suitcase", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom SuitcaseObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in MultiboxObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through multibox", "multibox", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom MultiboxObjectLootTables;		// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in SecurityboxesObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through security-box", "securitybox", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom SecurityboxesLootTables;			// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _obj) in WeaponcrateObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	
		// Add needed variables
		_obj setVariable ["ExileIsPersistent", true];
		_obj setVariable ["permaLoot", true];
		_obj setVariable ["ExileIsLocked", -1,true];
		_obj call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_obj, "Search through weapon-crate", "multibox", "_this distance _target < 3", 
		{
			private _obj = _this select 3 select 0;
			private _scriptHandler = [_obj] spawn {
				private _obj = _this select 0;
				[_obj, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_obj setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_obj];
		}, [_obj], 2, true] call CLS_fnc_AddHoldAction;
		
		// Add items to crate depending on object class/type.
		private _numberOfItemsToSpawn = (floor (random 4)) + 1;						// MAX AMOUNT OF ITEMS FOR CONTAINER
		for "_n" from 1 to _numberOfItemsToSpawn do
		{
			private _lootTableName = selectRandom WeaponcrateLootTables;			// LOOT TABLE FOR OBJECT CLASS!
			private _itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
			if !(_itemClassName in _spawnedItemClassNames) then
			{
				private _cargoType = _itemClassName call ExileClient_util_cargo_getType;
				switch (_cargoType) do
				{
					case 1: 	
					{ 
						if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
						{
							_obj addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_obj addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_obj addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_obj addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_obj addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_obj addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if DEBUG then {
		_pos = getPos _obj;
		_marker = createMarker [format ["%1", _pos],_pos];
		_marker setMarkerShape "Icon";
		_marker setMarkerSize [1,1];
		_marker setMarkerType "mil_dot";
		_marker setMarkerBrush "Solid";
		_marker setMarkerAlpha 0.5;
		_marker setMarkerColor "ColorOrange";
		_marker setMarkerText "[DEBUG] Interaction Loot";
	};
	_obj
};

_objs
