// Reassign IMS mission tasks after player respawn (WIP)
waitUntil {alive player};

// Chech if players corpse got some missions..
ExileClientLatestTask = (ExileClientLastDiedPlayerObject getVariable ["FHQ_TTI_ClientTaskList", []]);

// Get a list off all active mission tasks..
ExileClientAssignedTasks = ["assigned"] call FHQ_fnc_ttGetAllTasksWithState;

// If the ExileClientLatestTask array is not empty then (player have some missions)..
if !("ExileClientLatestTask" == "") then 
{	
	// If there are assigned missions in the list next check..
	if !("ExileClientAssignedTasks" == "") then 
	{
		{
			_playerTaskState = (_x select 0);
			_playerTask = (_x select 1);
			_playerTaskName = (_x select 2);
			if (_playerTaskState == "Assigned") then 
			{
				[ExileClientLatestTask] call FHQ_fnc_ttAddTasks;
			};
		} forEach ExileClientLatestTask;
	};
};