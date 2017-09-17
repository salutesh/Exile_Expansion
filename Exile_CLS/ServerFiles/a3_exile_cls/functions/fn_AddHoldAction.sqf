/*
	Exile_Expansion_CLS_fnc_AddHoldAction
	Created by Salutesh

	This function will create a hold action with given parameters to the given target and select a icon texture depending on the selection.
	Target can be a object, npc or vehicle (nothing else tested yet).

	- Example:
	
	[
		//--- 0: Target
		_object,
		//--- 1: Title
		_label,
		//--- 2: Idle Icon
		_idleIconSelection,
		//--- 3: Progress Icon
		_progressIconSelection,
		//--- 4: Condition Show
		_conditionShow,
		//--- 5: Condition Progress
		_conditionAction,
		//--- 6: Code Start
		_startCode,
		//--- 7: Code Progress
		_tickCode,
		//--- 8: Code Completed
		_completeCode,
		//--- 9: Code Interrupted
		_interruptCode,
		//--- 10: Arguments
		_arguments,
		//--- 11: Duration
		_duration,
		//--- 12: Priority
		_priority,
		//--- 13: Remove When Completed
		_remove
	] call Exile_Expansion_CLS_fnc_AddHoldAction;
*/
params [
	["_object", player],
	["_label", "Search"],
	["_idleIcon", "default"],
	["_progressIcon", "default"],
	["_conditionShow", "nil"],
	["_conditionAction", "nil"],
	["_startCode", {}],
	["_tickCode", {}], 
	["_completeCode", {}],
	["_interruptCode", {}],
	["_arguments",[],[[]]],
	["_duration", 0.5],
	["_priority", 0],
	["_remove", true]
];

private _holdActionConfig = missionConfigFile >> "CfgExileHoldActions";
private _idleIconSelection = getText (_holdActionConfig >> _idleIcon >> "icon");
private _progressIconSelection = getText (_holdActionConfig >> _progressIcon >> "icon");

// Create the hold action with given parameters.
private _holdAction = [
	_object,
	_label,
	_idleIconSelection,
	_progressIconSelection,
	_conditionShow,
	_conditionAction,
	_startCode,
	_tickCode,
	_completeCode,
	_interruptCode,
	_arguments,
	_duration,
	_priority,
	_remove,
	false
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];