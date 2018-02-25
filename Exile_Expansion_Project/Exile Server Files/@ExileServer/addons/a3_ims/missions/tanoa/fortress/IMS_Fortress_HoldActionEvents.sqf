/*
    IMS_Fortress_HoldActionEvents.sqf
    Written by Salutesh
    www.reality-gaming.eu
    
    Description: 
	Event scripts executed by different hold actions within the mission progress. 

*/

// Quest NPC Hold Action Event - 1
IMS_HAE_Mission_Fortress_1 = {
	// Define mission player units.
	private _questUnits = _this select 0;
	// Notify player with toast.
	[] remoteExec ["IMS_AE_Toast_1", _questUnits, true];
	
	// Create the first mission task.
	[] remoteExec ["IMS_Mission_TE_1", _questUnits, true];
	
	// Notify player with toast.
	[] remoteExec ["IMS_Toast_NewTask", _questUnits, true];
	
	// Delete the first marker directly.
	deleteMarker IMS_EventMarker_Mission_1_1;
	
	// Show the second marker
	IMS_EventMarker_Mission_1_2 setMarkerAlpha 1;
	
	// Create hold-action config for dokument object.
	// Hold action lable
	private _holdActionText = "Take documents";
	// Hold action icons
	private _holdActionIdleIcon = "Exile_HA_Icon_Document";
	private _holdActionProgressIcon = "Exile_HA_Icon_Document";
	// Hold action script executed after action is completed
	private _holdActionCodeCompleted = {
		private _questUnits = (_this select 3) select 0;
		private _questgiver = (_this select 3) select 1;
		private _dokuments = (_this select 3) select 2;
		[_questUnits, _questgiver] remoteExec ["IMS_HAE_Mission_Fortress_2", 0, true];
		[_questUnits] remoteExec ["IMS_HAE_Mission_Fortress_Lootcrate", 0, true];
		{
			player setVariable ["FortressDokument", true];
		} forEach _questUnits;
		[_dokuments, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
	};
	// Hold action show condition
	private _holdActionCondition = "_this distance _target < 3";
	// Define Npc questgiver
	private _questgiver = IMS_InteractionUnit_FortressQuestgiver;
	// Define object 
	private _dokuments = IMS_ScriptObject_FortressDokuments;
	// Hold action arguments
	private _holdActionArguments = [_questUnits, _questgiver, _dokuments];
	
	// Create the hold action
	[
		//--- 0: Target
		_dokuments,

		//--- 1: Title
		_holdActionText,

		//--- 2: Idle Icon
		_holdActionIdleIcon,

		//--- 3: Progress Icon
		_holdActionProgressIcon,

		//--- 4: Condition Show
		_holdActionCondition,

		//--- 5: Condition Progress
		"_caller distance _target < 3",

		//--- 6: Code Start
		{},

		//--- 7: Code Progress
		{
			private _progressTick = _this select 4;
			if (_progressTick % 2 == 0) exitwith {};
			playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
		},

		//--- 8: Code Completed
		_holdActionCodeCompleted,

		//--- 9: Code Interrupted
		{},

		//--- 10: Arguments
		_holdActionArguments,

		//--- 11: Duration
		0.5,

		//--- 12: Priority
		0,

		//--- 13: Remove When Completed
		true
	] call ExileMissions_fnc_AddHoldAction;
};

// Dokument Hold Action Event - 2
IMS_HAE_Mission_Fortress_2 = {
	// Define mission player units.
	private _questUnits = _this select 0;
	
	deleteVehicle IMS_ScriptObject_FortressDokuments;
	
	// Notify player with toast.
	[] remoteExec ["IMS_AE_Toast_2", _questUnits, true];
	
	// Finish the first and create the second mission task.
	[] remoteExec ["IMS_Mission_TEE_1", _questUnits, true];
	[] remoteExec ["IMS_Mission_TE_2", _questUnits, true];
	
	// Notify player with toast.
	[] remoteExec ["IMS_Toast_TaskUpdate", _questUnits, true];
	[_questUnits] remoteExec ["IM_Fortress_QuestAction", 0, true];
};

// Quest NPC Hold Action Event - 3
IMS_HAE_Mission_Fortress_3 = {
	private _questUnits = _this select 0;
	// Toast notification about mission competion
	[] remoteExec ["IMS_Mission_TEE_2", _questUnits, true];
	
	{
		player setVariable ["FortressDokument", false];
	} forEach _questUnits;
	
	// This grabs the array that contains information about the mission.
	// If you want to use this script on a static mission, then replace "DMS_Mission_Arr" with "DMS_StaticMission_Arr".
	private _missionInfo = DMS_StaticMission_Arr select IMS_Fortress_SaticMission_Index;
	private _missionUnitsArray = (_missionInfo select 4);
	private _missionUnits = _missionUnitsArray call DMS_fnc_GetAllUnits;
	{
		_x setDamage 1;
	} forEach _missionUnits;
	// AI groups/units are stored in the 3rd index of each mission.
	// The DMS function returns an array of all units, so we can loop over them and kill them.

	// The mission completion info is stored in the 1st index of each mission.
	// This wipes any previous completion info and replaces it with the "external" completion type, which is specifically for cases like this
	// where you want to trigger a mission completion "externally" using a script.
	_missionInfo set [1, [["external", true]]];
};