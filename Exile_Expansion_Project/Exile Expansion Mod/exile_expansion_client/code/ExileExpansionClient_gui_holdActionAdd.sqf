/**
 * ExileExpansionClient_gui_holdActionAdd
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private _holdAction = objNull;

try
{
	if !(params [["_object", player], ["_label", "Search"], ["_idleIcon", "default"], ["_progressIcon", "default"], ["_conditionShow", "nil"], ["_conditionAction", "nil"], ["_startCode", {}], ["_tickCode", {}], ["_completeCode", {}], ["_interruptCode", {}], ["_arguments",[],[[]]], ["_duration", 0.5], ["_priority", 0], ["_remove", true]]) then
	{
		throw (format ["Invalid parameters: %1", _this]);
	};
	
	_holdActionConfig = configFile >> "CfgExileHoldActions";
	_idleIconSelection = getText (_holdActionConfig >> _idleIcon >> "icon");
	_progressIconSelection = getText (_holdActionConfig >> _progressIcon >> "icon");
	_holdAction = [_object,	_label,	_idleIconSelection,	_progressIconSelection,	_conditionShow,	_conditionAction, _startCode, _tickCode, _completeCode, _interruptCode,	_arguments,	_duration, _priority, _remove, false] call BIS_fnc_holdActionAdd;
}
catch
{
	diag_log format ["Exile Expansion ERROR :: Calling ExileExpansionClient_gui_holdActionAdd with %1!", _exception];
};

_holdAction