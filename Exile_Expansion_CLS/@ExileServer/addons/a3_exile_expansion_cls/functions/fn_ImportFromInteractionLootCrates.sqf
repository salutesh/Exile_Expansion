/*
	CLS_fnc_ImportInteractionCrates
	Created by Salutesh

	Check out Exile Eden Plugin: http://www.exilemod.com/devblog/exile-3den-plugin/

	Usage:
	[
		_file																// String: The filename (or filepath under the objects folder) that contains the exported Exile Eden Plugin objects
	] call CLS_fnc_ImportInteractionCrates;

	_file call CLS_fnc_ImportInteractionCrates; 							// This also works

	This function will simply create the objects from a file that is included to the addons objects folder and makes them to interactable loot containers with configured loot tables.
*/

if !(params
[
	["_file","",[""]]
])
exitWith
{
	diag_log format ["CLS ERROR :: Calling CLS_fnc_ImportInteractionCrates with invalid parameters: %1",_this];
	[]
};

// The next few lines checks to see if the static base has been spawned previously, in order to avoid spawning duplicate objects.
private _varname = format ["CLS_LootCrateSpawned_%1",_file];

if (missionNamespace getVariable [_varname,false]) exitWith
{
	diag_log format ["CLS ERROR :: Attempting to spawn supply crate objects with file ""%1"" after it has already been spawned!",_file];
};

missionNamespace setVariable [_varname,true];

private _export = call compile preprocessFileLineNumbers (format ["a3_exile_expansion_cls\code\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["CLS ERROR :: Calling CLS_fnc_ImportInteractionCrates with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _interactionObjects = _export apply
{
	// Create the objects.
	private _interactionObject = (_x select 0) createVehicle (_x select 1);
	_interactionObject allowDamage false;
	_interactionObject setPosWorld (_x select 1);
	_interactionObject setVectorDirAndUp [_x select 2, _x select 3];
	_interactionObject enableSimulationGlobal (_x select 4);
	private _spawnedItemClassNames = [];
	
	if ((typeOf _interactionObject) in TrashBinObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
		// Add needed variables
		//_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
	
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through trashbin", "trashbin", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in CartonObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through carton", "crate", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in ToolboxObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through toolbox", "toolbox", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in BoxObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through box", "box", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in VendingMachineObjectClasses) then 
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through machine", "machine", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in FootlockerObjectClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through locker", "footlocker", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in BarrelObjectClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through barrel", "barrel", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in BagObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through bag", "bag", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in SuitcaseObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through suitcase", "suitcase", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in MultiboxObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through multibox", "multibox", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in SecurityboxesObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through security-box", "securitybox", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	
	if ((typeOf _interactionObject) in WeaponcrateObjectsClasses) then
	{
		// Remove crate content if there is one.
		clearWeaponCargoGlobal _interactionObject;
		clearMagazineCargoGlobal _interactionObject;
		clearBackpackCargoGlobal _interactionObject;
		clearItemCargoGlobal _interactionObject;
	
		// Add needed variables
		_interactionObject setVariable ["ExileIsPersistent", true];
		_interactionObject setVariable ["permaLoot", true];
		_interactionObject setVariable ["ExileIsLocked", -1,true];
		_interactionObject call ExileServer_system_simulationMonitor_addVehicle;
		
		// Add hold action depending on object class/type.
		private _holdAction = [_interactionObject, "Search through weapon-crate", "multibox", "_this distance _target < 3", 
		{
			private _interactionObject = _this select 3 select 0;
			private _scriptHandler = [_interactionObject] spawn {
				private _interactionObject = _this select 0;
				[_interactionObject, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
				_interactionObject setVariable ["ExileIsLocked", 0, true];
			};
			waitUntil { scriptDone _scriptHandler };
			player action ["GEAR",_interactionObject];
		}, [_interactionObject], 2, true] call CLS_fnc_AddHoldAction;
		
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
							_interactionObject addMagazineCargoGlobal [_itemClassName, 2]; 
						}
						else 
						{
							_interactionObject addMagazineCargoGlobal [_itemClassName, 1]; 
						};
					};
					case 3: 	
					{ 
						_interactionObject addBackpackCargoGlobal [_itemClassName, 1]; 
					};
					case 2: 	
					{ 
						_interactionObject addWeaponCargoGlobal [_itemClassName, 1]; 
						if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
						{
							_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
							if (count(_magazineClassNames) > 0) then
							{
								_magazineClassName = selectRandom _magazineClassNames;
								_numberOfMagazines = 2 + floor(random 3); 
								_interactionObject addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
								_spawnedItemClassNames pushBack _magazineClassName;
							};
						};
						_numberOfItemsToSpawn = -1;
					};
					default
					{ 
						_interactionObject addItemCargoGlobal [_itemClassName, 1]; 
					};
				};
				_spawnedItemClassNames pushBack _itemClassName;
			};
		};
	};
	if DEBUG then {
		_pos = getPos _interactionObject;
		_marker = createMarker [format ["%1", _pos],_pos];
		_marker setMarkerShape "Icon";
		_marker setMarkerSize [1,1];
		_marker setMarkerType "mil_dot";
		_marker setMarkerBrush "Solid";
		_marker setMarkerAlpha 0.5;
		_marker setMarkerColor "ColorOrange";
		_marker setMarkerText "[DEBUG] Interaction Loot";
	};
	_interactionObject
};

_interactionObjects
