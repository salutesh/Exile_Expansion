/*
	"The Fortess" static IMS Mission for Chernarus Redux
	Created by Steve aka Salutesh
	Last Update: 09.10.2017
*/

private["_pos","_posStart","_posEnd","_missionName","_msgStart","_msgWIN","_msgLOSE","_questgiver","_difficulty","_AICount","_group1Count","_group2Count","_group3Count","_group4Count","_group5Count","_group1Pos","_group2Pos","_group3Pos","_group4Pos","_group5Pos","_group","_group2","_group3","_group4","_group5","_missionAIUnits","_groupReinforcementsInfo","_missionObjs","_questMarkers","_missionMarkers","_missionSuccessParams","_missionSuccessCode","_added","_scriptObjects","_vehicle","_objectName","_scriptName","_missionObjects"];

//ExileExpansionClient_MissionUnits_Fortress = [];

// For logging purposes
private _num = DMS_MissionCount;

// Set mission side
_side = "bandit";

switch (toLower worldName) do
{
	case "chernarus":
    {
		_pos = [6892.32,11437.6,0];
		_posStart = [7816.74, 11556, 0];
		_posEnd = [7816.74, 11556, 0];
	    _missionName = "[Quest] The Fortress";
		_msgStart = ['#FFFF00',"PLACEHOLDER"];
	    _msgWIN = ['#0080FF',"The fortress was cleaned by tough survivors!"];
	    _msgLOSE = ['#FF0000',"All players died within the mission...sad story.."];
		_questgiver = [] remoteExec ["IMSClient_create_Fortress_Questgiver", 0, true];
	};
	case "chernarusredux":
    {
		_pos = [6892.32,11437.6,0];
		_posStart = [7816.74, 11556, 0];
		_posEnd = [7816.74, 11556, 0];
	    _missionName = "[Quest] The Fortress";
		_msgStart = ['#FFFF00',"PLACEHOLDER"];
	    _msgWIN = ['#0080FF',"The fortress was cleaned by tough survivors!"];
	    _msgLOSE = ['#FF0000',"All players died within the mission...sad story.."];
		_questgiver = [] remoteExec ["IMSClient_create_Fortress_Questgiver", 0, true];
	};
	default
	{
	    diag_log format["DMS ERROR :: Attempting to run The Fortress mission with unsupported map: %1",worldName];
	};
};

if (isNil "_pos") exitWith {};

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

diag_log text "[DMS]: Fortress Mission Started";

// Create the script objects
_scriptObjects = 
[
	["Land_Document_01_F", [6908.93, 11429.2, 425.664], [-0.938909, -0.344166, 0], [0, 0, 1], false, "FortressDokuments"],
	["Exile_Construction_WoodGate_Reinforced_Static", [6928.17, 11355.3, 392.586], [0.825535, -0.564351, 0], [0, 0, 1], true, "FortressMaingate"],
	["Exile_Construction_WoodGate_Reinforced_Static", [6863.72, 11443.9, 393.951], [0.995577, 0.0939534, 0], [0, 0, 1], true, "FortressCentergate"],
	["Land_PCSet_01_screen_F", [6852.49, 11396.7, 408.166], [-0.918132, -0.396275, 0], [0, 0, 1], false, "FortressPC"],
	["Loudspeakers_EP1", [6921.82, 11381.5, 397.512], [-0.847145, 0.531361, 0], [0, 0, 1], true, "FortressSpeaker1"],
	["Loudspeakers_EP1", [6882.55, 11427.5, 397.272], [0.409335, -0.912384, 0], [0, 0, 1], true, "FortressSpeaker2"],
	["Loudspeakers_EP1", [6881.16, 11515.7, 395.162], [-0.926281, 0.37587, -0.02693], [-0.0205213, 0.0210444, 0.999568], true, "FortressSpeaker3"]
];

{
	_vehicle = (_x select 0) createVehicle (_x select 1);
	_vehicle allowDamage false;
	_vehicle setPosWorld (_x select 1);
	_vehicle setVectorDirAndUp [_x select 2, _x select 3];
	_vehicle enableSimulationGlobal (_x select 4);
	_vehicle setVariable ["ExileIsLocked", -1, true];
	_objectName = _x select 5;
	_scriptName = format ["IMS_ScriptObject_%1",_objectName];
	missionNamespace setVariable [_scriptName, _vehicle, true];
} forEach _scriptObjects;

// Set general mission difficulty
_difficulty = "hardcore";

// Create AI
_AICount 		= 25;
_group1Count 	= ceil(_AICount/5);
_group2Count 	= ceil(_AICount/5);
_group3Count 	= ceil(_AICount/5);
_group4Count 	= ceil(_AICount/5);
_group5Count 	= ceil(_AICount/5);

_group1Pos		= [6910.27,11369.2,0];
_group2Pos		= [6887.8,11496.9,0];
_group3Pos		= [6867.67,11403.4,0];
_group4Pos		= [6891.44,11447.7,0];
_group5Pos		= [6937.96,11348.1,0];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get AI to defend the position
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group = [_group1Pos, _group1Count, _difficulty, "ims", _side] call DMS_fnc_SpawnAIGroup;
[_group, _group1Pos, _difficulty, "SAFE"] call DMS_fnc_SetGroupBehavior;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group2 = [_group2Pos, _group2Count, _difficulty, "ims", _side] call DMS_fnc_SpawnAIGroup;
[_group2, _group2Pos, _difficulty, "SAFE"] call DMS_fnc_SetGroupBehavior;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group3 = [_group3Pos, _group3Count, _difficulty, "ims", _side] call DMS_fnc_SpawnAIGroup;
[_group3, _group3Pos, _difficulty, "SAFE"] call DMS_fnc_SetGroupBehavior;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group4 = [_group4Pos, _group4Count, _difficulty, "ims", _side] call DMS_fnc_SpawnAIGroup;
[_group4, _group4Pos, _difficulty, "SAFE"] call DMS_fnc_SetGroupBehavior;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_group5 = [_group5Pos, _group5Count, _difficulty, "ims", _side] call DMS_fnc_SpawnAIGroup;
[_group5, _group5Pos, _difficulty, "SAFE"] call DMS_fnc_SetGroupBehavior;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Get the AI to shut the fuck up :)
enableSentences false;
enableRadio false;

// Define mission-spawned AI Units
_missionAIUnits =
[
	[_group,_group2,_group3,_group4,_group5]
];

// Define the group reinforcements
_groupReinforcementsInfo = [];

// Define mission-spawned objects and ai units
// Note: We don't add the base itself because we don't want to delete it and respawn it if the mission respawns.
// We just do that for scripted objects, they must be deleted and re-placed to restore their functionality within the mission.
_missionObjs =
[
	[_missionAIUnits],					// Ai Units and script objects
	[],									// No DMS vehicles, we spawn the mission reward with IMS. 
	[]									// No DMS mission create, we spawn the mission reward with IMS.
];

// Create IMS Quest Marker
_questMarkers = 
[
	_posStart,							// ARRAY (positionATL or position2d): Where the marker will be spawned (strict)
	"ExileExpansionQuestIcon",			// STRING: Icon type of the marker. Example: "ExileHeart"
	"Quest",							// NUMBER: Label to spawn for the marker.
	"The Stranger",						// STRING: Name to spawn for the marker.
	"Mission_1_1",						// STRING: Script Name for the Marker.
	false
] call ExileExpansionClient_gui_createMapMarker;

// Create DMS Mission Marker
_missionMarkers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

(_missionMarkers select 1) setMarkerSize [500,500];

ExileExpansionClient_gui_MapMarker_Mission_1_2 = (_missionMarkers select 0);
publicVariable "ExileExpansionClient_gui_MapMarker_Mission_1_2";
// Hide the mission marker
ExileExpansionClient_gui_MapMarker_Mission_1_2 setMarkerAlpha 0;

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Mission Success Events
_missionSuccessParams = _posEnd;
_missionSuccessCode = 
{
	_eventpos = _x select 0;
	_questUnits = (_eventpos nearEntities ["Exile_Unit_Player", 30]);
	[] remoteExec ["IMS_AE_Toast_4", _questUnits, true];
	[_eventpos] remoteExec ["IMS_Fortress_Completion_ActionScript", 0, true];
	
	// Delete the ims script objects
	_missionObjects = [ExileExpansion_object_interactionUnit_FortressQuestgiver, IMS_ScriptObject_FortressMaingate, IMS_ScriptObject_FortressCentergate, IMS_ScriptObject_FortressDokuments];
	{deleteVehicle _x} forEach _missionObjects;
};

// Mission Fail Events
_missionFailParams = [];
_missionFailCode = 
{
	// Mission failed so set all mission tasks also to failed..
	_missionTasks = 
	[
		["ExileTask_Chernaurus_Fortress_1", "Failed"],
		["ExileTask_Chernaurus_Fortress_2", "Failed"],
		["ExileTask_Chernaurus_Fortress_3", "Failed"],
		["ExileTask_Chernaurus_Fortress_4", "Failed"],
		["ExileTask_Chernaurus_Fortress_5", "Failed"]
	];
	{
		_questName = _x select 0;
		_questState = _x select 1;
		[_questName, _questState] remoteExec ["FHQ_fnc_ttSetTaskState", 0, true];
	} forEach _missionTasks;
	
	// Delete the ims script objects
	_missionObjects = [ExileExpansion_object_interactionUnit_FortressQuestgiver, IMS_ScriptObject_FortressMaingate, IMS_ScriptObject_FortressCentergate, IMS_ScriptObject_FortressDokuments];
	{deleteVehicle _x} forEach _missionObjects;
};

// Mission Fail condition
_missionConditions = 
{
	// Only include the stuff below if you also use the "_onMonitorEnd" parameter for this.
	// and if your parameters are different.
	DMS_ResetMissionTimeoutOnKill_original = DMS_ResetMissionTimeoutOnKill;
	DMS_MissionTimeoutResetFrequency_original = DMS_MissionTimeoutResetFrequency;
	DMS_ResetMissionTimeoutOnKill = false;
	DMS_MissionTimeoutResetFrequency = 0;
	
	// Triger only if the mission has players in -> ExileExpansionClient_MissionUnits_Fortress
	if !(isNil "ExileExpansionClient_MissionUnits_Fortress") then 
	{
		// Trigers
		// If all mission players die within the mission execute mission failure - (Trigger)
		if (({(alive _x) and (side _x == independent)}count ExileExpansionClient_MissionUnits_Fortress) < 1) then
		{
			_failTime = 0;
			_completionInfo = [["external",false,true]]; // This ensures that the mission doesn't attain the "success" state.
		};
	};
};

_onMonitorEnds = 
{
    DMS_ResetMissionTimeoutOnKill = DMS_ResetMissionTimeoutOnKill_original;
    DMS_MissionTimeoutResetFrequency = DMS_MissionTimeoutResetFrequency_original;
};

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			[_group,_group2,_group3,_group4,_group5]
		],
		[
			"playerNear",
			[_posEnd,DMS_playerNearRadius]
		],
		[
			"external",
			false
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_missionMarkers,
	_side,
	_difficulty,
	[],
	[
		[
			[											// _onSuccessScripts (OPTIONAL): Array of code or string to be executed on mission completion (in addition to regular code). Each element should be an array in the form [_params, _code].
				_missionSuccessParams, 
				_missionSuccessCode
			]
		],
		[
			[
				_missionFailParams, 					// _onFailScripts (OPTIONAL): Array of code or string to be executed on mission failure (in addition to regular code). Each element should be an array in the form [_params, _code].
				_missionFailCode
			]
		], 
		_missionConditions,								// _onMonitorStart (OPTIONAL): Code to run when the monitor starts to check the mission status. The passed parameter (_this) is the mission data array itself.
		_onMonitorEnds									// _onMonitorEnd (OPTIONAL): Code to run when the monitor is done with checking the mission status. The passed parameter (_this) is the mission data array itself.
	]
] call DMS_fnc_AddMissionToMonitor_Static;

// Set puplic var for quest activity tracking
IM_Fortress_QuestActive = false;
publicVariable "IM_Fortress_QuestActive";

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	// Add IMS script objects to the cleanup
	_cleanup pushBack (_missionObjs select 1);

	_cleanup call DMS_fnc_CleanUp;

	// Delete the markers directly
	{deleteMarker _x;} forEach _missionMarkers;
	{deleteMarker _x;} forEach _questMarkers;
	
	// Delete the ims script objects
	_missionObjects = [ExileExpansion_object_interactionUnit_FortressQuestgiver, IMS_ScriptObject_FortressMaingate, IMS_ScriptObject_FortressCentergate, IMS_ScriptObject_FortressDokuments];
	{deleteVehicle _x} forEach _missionObjects;
	
	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};

// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;

if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};
