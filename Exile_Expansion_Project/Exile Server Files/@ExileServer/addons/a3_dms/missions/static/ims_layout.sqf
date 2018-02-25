/*
	"Mission Layout" v0.1 for DMS
	Map: Taunus
	
	Created by Salutesh
	www.reality-gaming.eu
	
*/
private ["_num", "_side", "_pos", "_group", "_AISoldierSpawnLocations", "_AICount", "_difficulty", "_questgiver", "_missionAIUnits", "_missionObjs", "_msgStart", "_msgWIN", "_msgLOSE", "_missionName", "_markers", "_time", "_added", "_cleanup", "_missionEvents", "_onSuccessScripts", "_onFailScripts", "_onMonitorStart", "_onMonitorEnd", "_missionSuccessParams" ,"_missionSuccessCode", "_endpos"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";
_pos = [12112.3, 2486.11, 0];
_endpos = [11390, 2288.33, 3.80383];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Set general mission difficulty
_difficulty = "moderate";

// Spawn IMS stuff
_questgiver = [] remoteExec ["IM_Fortress_Questgiver", 0, true];
_baseObjs = ["tanoa\fortress\Objects"] call IMS_fnc_ImportFromExileEdenPlugin;
_scriptObjs = ["tanoa\fortress\ScriptObjects"] call IMS_fnc_ImportFromExileEdenPluginScripted;
_simpleObjs = ["tanoa\fortress\SimpleObjects"] call IMS_fnc_ImportFromExileEdenPluginSimple;

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[12140.8,2488.08,0],
	[12131.8,2482.06,0],
	[12134.4,2487.58,0]
];

// Create AI
_AICount = 3;

_group =
[
	_AISoldierSpawnLocations,			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,
	_difficulty,
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;

// Define mission-spawned AI Units
_missionAIUnits =
[
	_group
];

// Define the group reinforcements
_groupReinforcementsInfo = [];

// Define mission-spawned objects and loot values
_missionObjs =
[
	[_baseObjs, _scriptObjs, _simpleObjs],		// Spawned objects.
	[],
	[]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A strange visitor hit a camp near Lijnhaven. Go and talk to him!"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully eleminated the badits near Riedelbach!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like no one wants to talk to the stranger..he left the camp near Lijnhaven."];

// Define mission name (for map marker and logging)
_missionName = "[Quest] The Stranger";

// Create Quest Marker
_questMarkers = [
	[11390, 2288.33, 3.80383],			// ARRAY (positionATL or position2d): Where the marker will be spawned (strict)
	"quest",							// STRING: Icon type of the marker. Example: "ExileHeart"
	"Quest",							// NUMBER: Label to spawn for the marker.
	"The Stranger",						// STRING: Name to spawn for the marker.
	"Mission_1_1",						// STRING: Script Name for the Marker.
	false
] call IMS_fnc_CreateMarker;

// Create Mission Marker
_missionMarkers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

IMS_EventMarker_Mission_1_2 = (_missionMarkers select 0);
publicVariable "IMS_EventMarker_Mission_1_2";

// Hide the mission marker
IMS_EventMarker_Mission_1_2 setMarkerAlpha 0;

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Mission Success Event
_missionSuccessParams = _endpos;
_missionSuccessCode = {
	_eventpos = _x select 0;
	_questUnits = (_eventpos nearEntities ["Exile_Unit_Player", 30]);
	[] remoteExec ["IMS_AE_Toast_3", _questUnits, true];
	[_eventpos] remoteExec ["IMS_Fortress_Completion_ActionScript", 0, true];
};

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		["kill", _group],
		["external", true]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	[_missionAIUnits, _questgiver],
	_missionObjs,
	[
		_missionName,
		_msgWIN,
		_msgLose
	],
	_missionMarkers,
	_side,
	_difficulty,
	[],
	[
		[[_missionSuccessParams, _missionSuccessCode]], // _onSuccessScripts (OPTIONAL): Array of code or string to be executed on mission completion (in addition to regular code). Each element should be an array in the form [_params, _code].
		[], 											// _onFailScripts (OPTIONAL): Array of code or string to be executed on mission failure (in addition to regular code). Each element should be an array in the form [_params, _code].
		{},												// _onMonitorStart (OPTIONAL): Code to run when the monitor starts to check the mission status. The passed parameter (_this) is the mission data array itself.
		{}												// _onMonitorEnd (OPTIONAL): Code to run when the monitor is done with checking the mission status. The passed parameter (_this) is the mission data array itself.
	]
] call DMS_fnc_AddMissionToMonitor_Static;


// Add the index array to the mission to call a mission comlpetion after player has succesfully complete the mission.
// Just needed if players dont kill all AI.
DMS_Mission_1_Index = (count DMS_StaticMission_Arr) - 1;

// Set puplic var for quest activity tracking
IM_Fortress_QuestActive = false;
publicVariable "IM_Fortress_QuestActive";
IMS_Fortress_IsQuestOwner = false;
publicVariable "IM_Fortress_QuestActive";

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_AddMissionToMonitor! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	// Delete AI units and the crate. I could do it in one line but I just made a little function that should work for every mission (provided you defined everything correctly)
	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;
	
	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));

	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;

	
	// Delete the markers directly
	{deleteMarker _x;} forEach _missionMarkers;
	

	// Delete objects
	{deleteVehicle _x;} forEach _baseObjs;	
	{deleteVehicle _x;} forEach _scriptObjs;
	{deleteVehicle _x;} forEach _simpleObjs;
	
	// Detele the questgiver directly
	deleteVehicle IMS_InteractionUnit_FortressQuestgiver;
	
	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};

// Notify players
[_missionName, _msgStart] call DMS_fnc_BroadcastMissionStatus;

if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 difficulty at time %5",_missionName,_num,_pos,_difficulty,_time]) call DMS_fnc_DebugLog;
};