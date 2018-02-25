/**
 * ExileExpansionClient_object_interactionUnit_create
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private ["_logic","_unit","_animations","_holdActionText","_holdActionIdleIcon","_holdActionProgressIcon","_holdActionCodeCompleted","_holdActionCondition","_holdActionArguments","_progressTick","_unitName","_scriptName"];

_logic = "Logic" createVehicleLocal [0, 0, 0];
_unit = (_this select 0) createVehicleLocal [0, 0, 0];
_animations = _this select 1;
    
_logic setPosWorld (_this select 4);
_logic setVectorDirAndUp [_this select 5, _this select 6];
    
_unit setVariable ["BIS_enableRandomization", false];
_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
_unit setVariable ["ExileAnimations", _animations];
_unit disableAI "ANIM";
_unit disableAI "MOVE";
_unit disableAI "FSM";
_unit disableAI "AUTOTARGET";
_unit disableAI "TARGET";
_unit disableAI "CHECKVISIBLE";
_unit allowDamage false;
_unit setFace (_this select 2);
_unit setUnitLoadOut (_this select 3);
_unit setPosWorld (_this select 4);
_unit setVectorDirAndUp [_this select 5, _this select 6];
_unit reveal _logic;
_unit attachTo [_logic, [0, 0, 0]];
_unit switchMove (_animations select 0);
_unit addEventHandler ["AnimDone", {_this call ExileClient_object_trader_event_onAnimationDone}];

_holdActionText = (_this select 7);
_holdActionIdleIcon = (_this select 8);
_holdActionProgressIcon = (_this select 9);
_holdActionCodeCompleted = (_this select 10);
_holdActionCondition = (_this select 11);
_holdActionArguments = [_unit];

[
	_unit,
	_holdActionText,
	_holdActionIdleIcon,
	_holdActionProgressIcon,
	_holdActionCondition,
	"_caller distance _target < 3",
	{},
	{
		_progressTick = _this select 4;
		if (_progressTick % 2 == 0) exitwith {};
		playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
	},
	_holdActionCodeCompleted,
	{},
	_holdActionArguments,
	0.5,
	0,
	true
] call ExileExpansionClient_gui_holdActionAdd;

_unitName = (_this select 12);
_scriptName = format ["ExileExpansion_object_interactionUnit_%1",_unitName];

missionNamespace setVariable [_scriptName, _unit, true];
publicVariable _scriptName;

_unit