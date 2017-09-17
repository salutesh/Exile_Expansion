/**
 * ExileServer_system_lootManager_spawnLootInBuilding
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_building","_buildingConfig","_lootTableName","_localPositions","_lootHolderObject","_lootHolderConfig","_lootConfig","_maximumNumberOfLootPositions","_maximumPositionCoverage","_maximumNumberOfItemsPerLootCrate","_numberOfPositionsToUse","_lootPositions","_spawnedItemClassNames","_lootWeaponHolderNetIDs","_lootPosition","_lootHolder","_numberOfItemsToSpawn","_n","_itemClassName","_cargoType","_magazineClassNames","_magazineClassName","_numberOfMagazines","_holdActionText","_holdActionIdleIcon","_holdActionProgressIcon","_holdAction","_scriptHandler"];
_building = _this;
_building setVariable ["ExileLootSpawnedAt", time];
_building setVariable ["ExileHasLoot", true];
_buildingConfig = configFile >> "CfgBuildings" >> typeOf _building;
_lootTableName = getText (_buildingConfig >> "table");
_localPositions = getArray (_buildingConfig >> "positions");
if ((getPosATL _building) call ExileClient_util_world_isInRadiatedZone) then 
{
	_lootTableName = "Radiation";
};
_lootConfig = missionConfigFile >> "CfgExileLootSettings";
_lootHolderConfig = missionConfigFile >> "CfgExileLootContainers" >> "ExileContainerFromTable";
_holdActionText = getText (_lootHolderConfig >> _lootTableName >> "text");
_holdActionIdleIcon = getText (_lootHolderConfig >> _lootTableName >> "icon");
_holdActionProgressIcon = getText (_lootHolderConfig >> _lootTableName >> "icon");
_maximumNumberOfLootPositions = getNumber (_lootConfig >> "maximumNumberOfLootSpotsPerBuilding");
_maximumPositionCoverage = getNumber (_lootConfig >> "maximumPositionCoverage");
_maximumNumberOfItemsPerLootCrate = getNumber (_lootHolderConfig >> "maximumNumberOfItemsPerLootCrate");
_numberOfPositionsToUse = 1 max (((count _localPositions) * _maximumPositionCoverage / 100) min _maximumNumberOfLootPositions);
_localPositions = _localPositions call ExileClient_util_array_shuffle;
_lootPositions = _localPositions select [0, _numberOfPositionsToUse];
_spawnedItemClassNames = [];
_lootWeaponHolderNetIDs = [];
_lootHolderObject = [];

{
	_lootPosition = ASLToATL (AGLToASL (_building modelToWorld _x));
	if (_lootPosition select 2 < 0.05) then
	{
		_lootPosition set [2, 0.05];
	};
	_lootHolder = objNull;
	_numberOfItemsToSpawn = (floor (random _maximumNumberOfItemsPerLootCrate)) + 1;
	for "_n" from 1 to _numberOfItemsToSpawn do
	{
		_itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
		if !(_itemClassName in _spawnedItemClassNames) then
		{
			if (isNull _lootHolder) then 
			{
				_lootHolderObject = selectRandom (getArray (_lootHolderConfig >> _lootTableName >> "objects"));
				_lootHolder = createVehicle [_lootHolderObject, _lootPosition, [], 0, "CAN_COLLIDE"];
				_lootHolder setDir (random 360);
				_lootHolder setPosATL _lootPosition;
				_lootHolder setVariable ["ExileSpawnedAt", time];
				_lootWeaponHolderNetIDs pushBack (netId _lootHolder);
				_lootHolder setVariable ["ExileIsLocked", -1,true];
						
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
				] call Exile_CLS_fnc_AddHoldAction;
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
}
forEach _lootPositions;
_building setVariable ["ExileLootWeaponHolderNetIDs", _lootWeaponHolderNetIDs];
ExileServerBuildingNetIdsWithLoot pushBack (netId _building);