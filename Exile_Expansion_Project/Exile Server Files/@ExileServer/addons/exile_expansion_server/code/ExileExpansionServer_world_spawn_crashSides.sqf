private ["_crashNum","_crateNum","_spawnCenter","_min","_max","_mindist","_water","_shoremode","_crashSidePosition","_wreckClasses","_wreckSelection","_weckVehicle","_fireVehicle","_crateClasses","_crateSelection","_crate0","_crate1","_crate2","_crateOperations","_holdAction","_scriptHandler","_numberOfItemsToSpawn","_lootTableName","_spawnedItemClassNames","_itemClassName","_magazineClassNames","_numberOfMagazines","_cargoType"];

// Number of Crash-sides
_crashNum = 7;

_spawnCenter = Exile_Expansion_MapCenter; //Center of your map.
_min = 0; // minimum distance from the center position (Number) in meters
_max = 10000; // maximum distance from the center position (Number) in meters
_mindist = 10; // minimum distance from the nearest object (Number) in meters, ie. spawn at least this distance away from anything within x meters..
//Low _mindist means helicrashes could spawn near towns or in forests.. higher the number it would be spawning in an open field etc
_water = 0; // water mode 0: cannot be in water , 1: can either be in water or not , 2: must be in water
_shoremode = 0; // 0: does not have to be at a shore , 1: must be at a shore

Exile_Crashsides = 
{
	for "_j" from 1 to _crashNum do 
	{
		// Find a random location on the map.
		_crashSidePosition = [_spawnCenter,_min,_max,_mindist,_water,20,_shoremode] call BIS_fnc_findSafePos;
		// Wreck object classes.
		_wreckClasses = 
		[
			"Land_Wreck_HMMWV_F",
			"Land_Wreck_Hunter_F",
			"Mi8Wreck",
			"Land_Wreck_Ural_F",
			"Land_Wreck_Heli_Attack_02_F",
			"Land_UWreck_Heli_Attack_02_F"
		];
		_wreckSelection = _wreckClasses call BIS_fnc_SelectRandom;
		// Create the wreck.
		_weckVehicle = _wreckSelection createVehicle [0,0,0];
		// Set wreck on fire!
		_fireVehicle = "test_EmptyObjectForFireBig" createVehicle (position _weckVehicle);
		_fireVehicle attachto [_weckVehicle, [0,0,-1]];
		// Set wreck position.
		_weckVehicle setposATL [(_crashSidePosition) select 0,(_crashSidePosition) select 1,0];
		_weckVehicle setVariable ["LAST_CHECK", (diag_tickTime + 14400)];
		_crateNum = 1;
		for "_i" from 1 to _crateNum do {
			_crateClasses = ["plp_ct_HighSecSmallBlack", "plp_ct_HighSecSmallBlue", "plp_ct_HighSecSmallGrey", "plp_ct_HighSecSmallRed", "plp_ct_HighSecSmallWhite"];
			// Crate object classes.
			_crateSelection = _crateClasses call BIS_fnc_SelectRandom;
			_crate0 = createVehicle [_crateSelection, _weckVehicle modelToWorld [(random 10) - 3, (random 10) - 4, 0], [], 0, "CAN_COLLIDE"];
			_crate1 = createVehicle [_crateSelection, _weckVehicle modelToWorld [(random 10) - 3, (random 10) - 4, 0], [], 0, "CAN_COLLIDE"];
			_crate2 = createVehicle [_crateSelection, _weckVehicle modelToWorld [(random 10) - 3, (random 10) - 4, 0], [], 0, "CAN_COLLIDE"];
			
			_crateOperations = 
			{
				// Remove crate content if there is one.
				clearWeaponCargoGlobal _x;
				clearMagazineCargoGlobal _x;
				clearBackpackCargoGlobal _x;
				clearItemCargoGlobal _x;
			
				// Add needed variables
				//_x setVariable ["ExileIsPersistent", true];
				_x setVariable ["permaLoot", true];
				_x setVariable ["ExileIsLocked", -1,true];
				
				// Add hold action depending on object class/type.
				_holdAction = [_x, "Search through security-box", "securitybox", "_this distance _target < 3", {
					_x = _this select 3 select 0;
					_scriptHandler = [_x] spawn {
						_x = _this select 0;
						[_x, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
						_x setVariable ["ExileIsLocked", 0, true];
					};
					waitUntil { scriptDone _scriptHandler };
					player action ["GEAR",_x];
				}, [_x], 2, true] call CLS_fnc_AddHoldAction;
				
				// Add items to crate depending on object class/type.
				_numberOfItemsToSpawn = (floor (random 4)) + 2;						// MAX AMOUNT OF ITEMS FOR CONTAINER
				for "_n" from 1 to _numberOfItemsToSpawn do {
					_spawnedItemClassNames = [];
					_lootTableName = "Crashside";				// LOOT TABLE FOR THE CRATE!
					_itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
					if !(_itemClassName in _spawnedItemClassNames) then {
						_cargoType = _itemClassName call ExileClient_util_cargo_getType;
						switch (_cargoType) do
						{
							case 1: 	
							{ 
								if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
								{
									_x addMagazineCargoGlobal [_itemClassName, 2]; 
								}
								else 
								{
									_x addMagazineCargoGlobal [_itemClassName, 1]; 
								};
							};
							case 3: 	
							{ 
								_x addBackpackCargoGlobal [_itemClassName, 1]; 
							};
							case 2: 	
							{ 
								_x addWeaponCargoGlobal [_itemClassName, 1]; 
								if !(_itemClassName isKindOf ["Exile_Melee_Abstract", configFile >> "CfgWeapons"]) then
								{
									_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
									if (count(_magazineClassNames) > 0) then
									{
										_magazineClassName = selectRandom _magazineClassNames;
										_numberOfMagazines = 2 + floor(random 3); 
										_x addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
										_spawnedItemClassNames pushBack _magazineClassName;
									};
								};
								_numberOfItemsToSpawn = -1;
							};
							default
							{ 
								_x addItemCargoGlobal [_itemClassName, 1]; 
							};
						};
						_spawnedItemClassNames pushBack _itemClassName;
					};
				};
			} forEach [_crate0, _crate1, _crate2];
			
			_crate0 setPos [(getPos _crate0 select 0) +5, (getPos _crate0 select 1), 0];
			_crate1 setPos [(getPos _crate1 select 0) -10, (getPos _crate1 select 1), 0];
			_crate2 setPos [(getPos _crate2 select 0) -5, (getPos _crate2 select 1), 0];
			_cutter0 = "Land_ClutterCutter_medium_F" createVehicle (getpos _crate0);
			_cutter1 = "Land_ClutterCutter_medium_F" createVehicle (getpos _crate1);
			_cutter2 = "Land_ClutterCutter_medium_F" createVehicle (getpos _crate2);
			
			if DEBUG then {
				_pos = getPos _weckVehicle;
				_marker = createMarker [format ["%1", _pos],_pos];
				_marker setMarkerShape "Icon";
				_marker setMarkerSize [1,1];
				_marker setMarkerType "mil_dot";
				_marker setMarkerBrush "Solid";
				_marker setMarkerAlpha 0.5;
				_marker setMarkerColor "ColorRed";
				_marker setMarkerText "[DEBUG] Helicrash";
			};
		};
	};
};

call Exile_Crashsides;
