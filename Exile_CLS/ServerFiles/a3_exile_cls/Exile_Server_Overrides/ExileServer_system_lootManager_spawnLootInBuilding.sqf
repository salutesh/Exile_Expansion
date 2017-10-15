/**
 * ExileServer_system_lootManager_spawnLootInBuilding
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Mod Team
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
			_containerChance = getNumber (_lootHolderConfig >> "containerChance");
			if (random 100 < _containerChance) then
			{
				if (isNull _lootHolder) then 
				{
					_lootHolderObject = selectRandom (getArray (_lootHolderConfig >> _lootTableName >> "objects"));
					_lootHolder = createVehicle [_lootHolderObject, _lootPosition, [], 0, "CAN_COLLIDE"];
					_lootHolder setDir (random 360);
					_lootHolder setPosATL _lootPosition;
					_lootHolder setVariable ["ExileSpawnedAt", time];
					_lootWeaponHolderNetIDs pushBack (netId _lootHolder);
					
					_lootHolder setVariable ["ExileIsLocked", -1, true];
										
					[
						_lootHolder,
						_holdActionText,
						_holdActionIdleIcon,
						_holdActionProgressIcon,
						"_this distance _target < 3 && (player getVariable ['CanLootContainer', true])",
						"_caller distance _target < 3",
						{},
						{
							_progressTick = _this select 4;
							if (_progressTick % 2 == 0) exitwith {};
							playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
						},
						{
							_player = _this select 1;
							_lootHolder = (_this select 3) select 0;  // <<-- This gets the first Argument given to the hold action under 10: Arguments
							[_lootHolder, _player] spawn 
							{	
								_lootHolder = _this select 0;
								_player = _this select 1;
								_animationToPlay = ["", ""] call BIS_fnc_selectRandom;
								
								_player setVariable ["CanLootContainer", false];
								
								( ["ExileLootUI"] call BIS_fnc_rscLayer ) cutRsc [ "ExileLootUI", "PLAIN", 1, false ];
								
								if (_animationToPlay != "") then 
								{
									_startAnimTime = time;
									_player playMove _animationToPlay;
									waitUntil {animationState _player != _animationToPlay};
								}
								else
								{
									_player playAction "Crouch";
								};
								
								_searchtime = 3;
								_searchradius = 1.5;
								_searchPos = getPosATL _player;
								_playerInSearchArea = [_player, _searchPos, _searchradius] spawn 
								{
									params["_player", "_searchPos", "_searchradius"]; 
									waitUntil 
									{ 
										_player distanceSqr _searchPos >  ( _searchradius^2 ) 
									} 
								};
								for "_sleep" from _searchtime to 0 step -0.01 do 
								{
									_progress = linearConversion [0, _searchtime, _sleep, 0, 1];
									(uiNamespace getVariable "ExileLootUI" displayCtrl 1000);
									(uiNamespace getVariable "ExileLootUI" displayCtrl 1001) ctrlSetTextColor [1, 0.706, 0.094, _sleep % 1];
									(uiNamespace getVariable "ExileLootUI" displayCtrl 1002) progressSetPosition _progress;
									sleep 0.01;
									if (scriptDone _playerInSearchArea) exitWith {};
								};
								(["ExileLootUI"] call BIS_fnc_rscLayer) cutRsc ["Default", "PLAIN", 1, false];
								if (scriptDone _playerInSearchArea) exitWith 
								{
									_player setVariable ["CanLootContainer", true];
								};
								terminate _playerInSearchArea;
								
								_lootHolder = _this select 0;
								[_lootHolder, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
								_lootHolder setVariable ["ExileIsLocked", 0, true];
								sleep 0.01;
								_player action ["GEAR",_lootHolder];
								_player action ["GEAR",_lootHolder];
								_player setVariable ["CanLootContainer", true];
							};
						},
						{},
						[_lootHolder],
						0.5,
						0,
						false
					] remoteExec ["ExileExpansionClient_gui_holdActionAdd", 0, true];
				};
			}
			else
			{
				if (isNull _lootHolder) then 
				{
					_lootHolder = createVehicle ["LootWeaponHolder", _lootPosition, [], 0, "CAN_COLLIDE"];
					_lootHolder setDir (random 360);
					_lootHolder setPosATL _lootPosition;
					_lootHolder setVariable ["ExileSpawnedAt", time];
					_lootWeaponHolderNetIDs pushBack (netId _lootHolder);											
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
}
forEach _lootPositions;
_building setVariable ["ExileLootWeaponHolderNetIDs", _lootWeaponHolderNetIDs];
ExileServerBuildingNetIdsWithLoot pushBack (netId _building);