/*
    IMS_raidHoldActionScripts.sqf
    Written by Salutesh
    www.reality-gaming.eu
    
    Description: 
	Event scripts for the hold actions. 

*/

IMS_Fortress_Completion_ActionScript = {
	private _position = _x select 0;
	// Define mission player units.
	private _playerUnits = (_position nearEntities ["Exile_Unit_Player", 30]);
	// Notifiy player with toast.
	[] remoteExec ["IMS_Fortress_Toast_MissionComplete", _playerUnits, true];
	sleep 3;
	// Spawn vehicle loot if option in config is true.
	if (IMS_Fortress_VehicleLoot) then {
		// Create vehicle.
		private _pincode = (1000 +(round (random 8999)));
		[IMS_Fortress_VehicleLootClass, _position, 150, _pincode, "Fortress Vehicle"] remoteExec ["IMS_fnc_SpawnPersistentVehicle", 0, true];
	};
	// Spawn mission loot drop.
	[_position, "B_supplyCrate_F", "Fortress Loot"] remoteExec ["IMS_fnc_LootDrop", 0, true];
};

IMS_Fortress_Terminal_ActionScript = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Close terminal and remove action.
	[IMS_InteractionObject_FortressTerminal, 0] remoteExec ["BIS_fnc_dataTerminalAnimate", -2, true];
	[IMS_InteractionObject_FortressTerminal, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Play ambient music.
	["LeadTrack01_F_EXP", 0] remoteExec ["BIS_fnc_playMusic", _playerUnits, true];
	// Succsess for third task
	[] remoteExec ["IMS_Fortress_TaskEvent_3_End", _playerUnits, true];
	// Create the forth mission task.
	[] remoteExec ["IMS_Fortress_TaskEvent_4", _playerUnits, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_TaskUpdate", _playerUnits, true];
	sleep 3;
	[] remoteExec ["IMS_Fortress_Toast_BombActivate", _playerUnits, true];
	sleep 3;
	// Start timer
	[IMS_Fortress_Bomb_Timer] remoteExec ["IMS_fnc_EndTimer", _playerUnits, true];
	[] remoteExec ["IMS_Fortress_AlarmEvent", -2, true];
	sleep IMS_Fortress_Bomb_Timer;
	// Start end events.
	[] remoteExec ["IMS_Fortress_BombEvent", 0, true];
	sleep 20;
	// Succsess for fourth task.
	[] remoteExec ["IMS_Fortress_TaskEvent_4_End", _playerUnits, true];
};

IMS_Fortress_Laptop_ActionScript = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_InteractionObject_FortressLaptop, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Open central gate
	IMS_ScriptObject_FortressGate setVariable ["ExileIsLocked", 0, true];
	// Open cetral tower doors
	((nearestobjects [[12103.6,2491.62,0], ["Land_Cargo_Tower_V1_No1_F"], 150]) select 0) setVariable ['bis_disabled_Door_1',0,true];
	((nearestobjects [[12103.6,2491.62,0], ["Land_Cargo_Tower_V1_No1_F"], 150]) select 0) setVariable ['bis_disabled_Door_2',0,true];
	((nearestobjects [[12103.6,2491.62,0], ["Land_Cargo_Tower_V1_No1_F"], 150]) select 0) setVariable ['bis_disabled_Door_3',0,true];
	// Notifiy player with toast
	[] remoteExec ["IMS_Fortress_Toast_Laptop", _playerUnits, true];
	sleep 3;
	// Succsess for second task
	[] remoteExec ["IMS_Fortress_TaskEvent_2_End", _playerUnits, true];
	// Create the third mission task.
	[] remoteExec ["IMS_Fortress_TaskEvent_3", _playerUnits, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_TaskUpdate", _playerUnits, true];
};

IMS_Fortress_SupplyBox_ActionScript_1 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_CrateObject_FortressSupplyBox_1, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Unlock the crate.
	IMS_CrateObject_FortressSupplyBox_1 setVariable ["ExileIsLocked", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_Supply", _playerUnits, true];
};

IMS_Fortress_SupplyBox_ActionScript_2 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_CrateObject_FortressSupplyBox_2, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Unlock the crate.
	IMS_CrateObject_FortressSupplyBox_2 setVariable ["ExileIsLocked", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_Supply", _playerUnits, true];
};

IMS_Fortress_SupplyBox_ActionScript_3 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_CrateObject_FortressSupplyBox_3, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Unlock the crate.
	IMS_CrateObject_FortressSupplyBox_3 setVariable ["ExileIsLocked", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_Supply", _playerUnits, true];
};

IMS_Fortress_SupplyBox_ActionScript_4 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_CrateObject_FortressSupplyBox_4, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Unlock the crate.
	IMS_CrateObject_FortressSupplyBox_4 setVariable ["ExileIsLocked", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_Supply", _playerUnits, true];
};

IMS_Fortress_SupplyBox_ActionScript_5 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_CrateObject_FortressSupplyBox_5, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Unlock the crate.
	IMS_CrateObject_FortressSupplyBox_5 setVariable ["ExileIsLocked", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_Supply", _playerUnits, true];
};

IMS_Fortress_Toilet_ActionScript_1 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_InteractionObject_FortressToilet_1, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Fortress_Toast_Toilet", _playerUnits, true];
};

IMS_Fortress_Toilet_ActionScript_2 = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action.
	[IMS_InteractionObject_FortressToilet_2, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Fortress_Toast_Toilet", _playerUnits, true];
};

IMS_Fortress_Dokument_ActionScript = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Remove action for all clients after use.
	[IMS_InteractionObject_FortressDokument, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	// Play ambient music for players in mission area.
	["AmbientTrack01_F_EXP", 0] remoteExec ["BIS_fnc_playMusic", _playerUnits];
	// Notifiy toast for players in mission area.
	[] remoteExec ["IMS_Fortress_Toast_Dokuments", _playerUnits, true];
	// Create the first mission task for players in mission area.
	[] remoteExec ["IMS_Fortress_TaskEvent_1", _playerUnits, true];
	// Wait 3 seconds
	sleep 3;
	// Notifiy toast for players in mission area.
	[] remoteExec ["IMS_Toast_NewTask", _playerUnits, true];
};

IMS_Fortress_Bomb_ActionScript = {
	// Define mission player units.
	_playerUnits = ([12103.6,2491.62,0] nearEntities ["Exile_Unit_Player", 250]);
	// Notifiy player with toast.
	[] remoteExec ["IMS_Fortress_Toast_ActiveBomb", _playerUnits, true];
	// Wait 3 seconds.
	sleep 3;
	// Succsess for first task
	[] remoteExec ["IMS_Fortress_TaskEvent_1_End", _playerUnits, true];
	// Create the second mission task.
	[] remoteExec ["IMS_Fortress_TaskEvent_2", _playerUnits, true];
	// Notifiy player with toast.
	[] remoteExec ["IMS_Toast_TaskUpdate", _playerUnits, true];
	// Remove the bomb hold actions.
	[IMS_InteractionObject_FortressBomb_1, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	[IMS_InteractionObject_FortressBomb_2, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	[IMS_InteractionObject_FortressBomb_3, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	[IMS_InteractionObject_FortressBomb_4, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	[IMS_InteractionObject_FortressBomb_5, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	[IMS_InteractionObject_FortressBomb_6, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	[IMS_InteractionObject_FortressBomb_7, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
};