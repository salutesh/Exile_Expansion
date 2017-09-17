/*
	Exile_Expansion_CLS_fnc_ImportInteractionCrates
	Created by Salutesh

	Check out Exile Eden Plugin: http://www.exilemod.com/devblog/exile-3den-plugin

	Usage:
	[
		_file																// [STRING]: The filename (or filepath under the objects folder) that contains the exported Exile Eden Plugin objects
	] call Exile_Expansion_CLS_fnc_ImportInteractionCrates;

	_file call Exile_Expansion_CLS_fnc_ImportInteractionCrates; 							// This also works

	This function will simply create the objects from a file that is included to the addons objects folder.
*/

if !(params
[
	["_file","",[""]]
])
exitWith
{
	diag_log format ["Exile Expansion ERROR :: Calling Exile_Expansion_Server_fnc_ImportInteractionCrates with invalid parameters: %1",_this];
	[]
};

// The next few lines checks to see if the static base has been spawned previously, in order to avoid spawning duplicate objects.
private _varname = format ["Exile_Expansion_StaticBaseSpawned_%1",_file];

if (missionNamespace getVariable [_varname,false]) exitWith
{
	diag_log format ["Exile Expansion ERROR :: Attempting to spawn objects with file ""%1"" after it has already been spawned!",_file];
};

missionNamespace setVariable [_varname,true];


private _export = call compile preprocessFileLineNumbers (format ["a3_exile_expansion_cls\code\objects\%1.sqf", _file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["Taunus ERROR :: Calling Exile_Expansion_Server_fnc_ImportInteractionCrates with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _lootHolderObjects = _export apply
{
	private["_lootTableName","_lootHolderObject","_lootHolderConfig","_lootConfig","_maximumNumberOfItemsPerLootCrate","_spawnedItemClassNames","_lootWeaponHolderNetIDs","_lootPosition","_lootHolder","_numberOfItemsToSpawn","_n","_itemClassName","_cargoType","_magazineClassNames","_magazineClassName","_numberOfMagazines","_holdActionText","_holdActionIdleIcon","_holdActionProgressIcon","_holdAction","_scriptHandler"];

	_lootHolderObject = (_x select 0);
	_lootPosition = (_x select 1);
	_dir = (_x select 2);
	_up = (_x select 3);
	_simulation = (_x select 4);
	_lootHolderConfig = missionConfigFile >> "CfgExileLootContainers" >> "ExileLootFromContainer";
	_lootTableName = getText (_lootHolderConfig >> _lootHolderObject >> "table");
	_holdActionText = getText (_lootHolderConfig >> _lootHolderObject >> "text");
	_holdActionIdleIcon = getText (_lootHolderConfig >> _lootHolderObject >> "icon");
	_holdActionProgressIcon = getText (_lootHolderConfig >> _lootHolderObject >> "icon");
	_maximumNumberOfItemsPerLootCrate = getNumber (_lootHolderConfig >> "maximumNumberOfItemsPerLootCrate");
	_spawnedItemClassNames = [];
	_lootWeaponHolderNetIDs = [];
	
	_lootHolder = objNull;
	_numberOfItemsToSpawn = (floor (random _maximumNumberOfItemsPerLootCrate)) + 1;
	for "_n" from 1 to _numberOfItemsToSpawn do
	{
		_itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
		if !(_itemClassName in _spawnedItemClassNames) then
		{
			if (isNull _lootHolder) then 
			{
				_lootHolder = createVehicle [_lootHolderObject, _lootPosition, [], 0, "CAN_COLLIDE"];
				_lootHolder setPosATL _lootPosition;
				_lootHolder setPosWorld _lootPosition;
				_lootHolder setVectorDirAndUp [_dir, _up];
				_lootHolder setVariable ["ExileSpawnedAt", time];
				_lootHolder setVariable ["ExileIsLocked", -1, true];
				_lootHolder setVariable ["ExileHasLoot", true];
				_lootWeaponHolderNetIDs pushBack (netId _lootHolder);
						
				// Add hold action				
				[
					//--- 0: Target
					_lootHolder,

					//--- 1: Title
					_holdActionText,

					//--- 2: Idle Icon
					_holdActionIdleIcon,

					//--- 3: Progress Icon
					_holdActionProgressIcon,

					//--- 4: Condition Show
					"_this distance _target < 3",

					//--- 5: Condition Progress
					"_caller distance _target < 3",

					//--- 6: Code Start
					{},

					//--- 7: Code Progress
					{
						_progressTick = _this select 4;
						if (_progressTick % 2 == 0) exitwith {};
						playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
					},

					//--- 8: Code Completed
					{
						_lootHolder = (_this select 3) select 0;  // <<-- This gets the first Argument given to the hold action under 10: Arguments
						_scriptHandler = [_lootHolder] spawn {
							_lootHolder = _this select 0;
							[_lootHolder, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
							_lootHolder setVariable ["ExileIsLocked", 0, true];
						};
						waitUntil { scriptDone _scriptHandler };
						player action ["GEAR",_lootHolder];
					},

					//--- 9: Code Interrupted
					{},

					//--- 10: Arguments
					[_lootHolder],

					//--- 11: Duration
					0.5,

					//--- 12: Priority
					0,

					//--- 13: Remove When Completed
					true
				] call Exile_Expansion_CLS_fnc_AddHoldAction;
				
				if Exile_Expansion_CLS_DEBUG then {
					_pos = getPos _lootHolder;
					_marker = createMarker [format ["%1", _pos],_pos];
					_marker setMarkerShape "Icon";
					_marker setMarkerSize [1,1];
					_marker setMarkerType "mil_dot";
					_marker setMarkerBrush "Solid";
					_marker setMarkerAlpha 0.5;
					_marker setMarkerColor "ColorOrange";
					_marker setMarkerText "[DEBUG] Interaction Loot";
				};
			};
			_cargoType = _itemClassName call ExileClient_util_cargo_getType;
			switch (_cargoType) do
			{
				case 1: 	
				{ 
					if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
					{
						_lootHolder addMagazineCargoGlobal [_itemClassName, 2]; 
					}
					else 
					{
						_lootHolder addMagazineCargoGlobal [_itemClassName, 1]; 
					};
				};
				case 3: 	
				{ 
					_lootHolder addBackpackCargoGlobal [_itemClassName, 1]; 
				};
				case 2: 	
				{ 
					_lootHolder addWeaponCargoGlobal [_itemClassName, 1]; 
					if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
					{
						_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
						if (count(_magazineClassNames) > 0) then
						{
							_magazineClassName = selectRandom _magazineClassNames;
							_numberOfMagazines = 2 + floor(random 3); 
							_lootHolder addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
							_spawnedItemClassNames pushBack _magazineClassName;
						};
					};
					_numberOfItemsToSpawn = -1;
				};
				default
				{ 
					_lootHolder addItemCargoGlobal [_itemClassName, 1]; 
				};
			};
			_spawnedItemClassNames pushBack _itemClassName;
		};
	};
};

_lootHolderObjects
