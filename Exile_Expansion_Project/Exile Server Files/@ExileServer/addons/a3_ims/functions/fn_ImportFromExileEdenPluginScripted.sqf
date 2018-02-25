/*
	IMS_fnc_ImportFromExileEdenPluginScripted
	Created by Salutesh

	Check out Exile Eden Plugin: http://www.exilemod.com/devblog/exile-3den-plugin/
	
	Usage:
	[
		_file																// String: The filename (or filepath under the objects folder) that contains the exported Exile Eden Plugin objects
	] call IMS_fnc_ImportFromExileEdenPluginScripted;

	_file call IMS_fnc_ImportFromExileEdenPluginScripted; 					// This also works

	This function will simply create the objects from a file that is included to the addons objects folder.
*/

if !(params
[
	["_file","",[""]]
])
exitWith
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_ImportFromExileEdenPluginScripted with invalid parameters: %1",_this];
	[]
};

private _export = call compile preprocessFileLineNumbers (format ["a3_ims\objects\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_ImportFromExileEdenPluginScripted with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	private _vehicle = (_x select 0) createVehicle (_x select 1);
	_vehicle allowDamage false;
	_vehicle setPosWorld (_x select 1);
	_vehicle setVectorDirAndUp [_x select 2, _x select 3];
	_vehicle enableSimulationGlobal (_x select 4);
	_vehicle setVariable ["ExileIsLocked", -1, true];
	private _objectName = _x select 5;
	private _scriptName = format ["IMS_ScriptObject_%1",_objectName];
	
	missionNamespace setVariable [_scriptName, _vehicle, true];
	
	if ((typeOf _vehicle) isKindOf "Land_DataTerminal_01_F") then
	{
		[_vehicle,"red","orange","blue"] call BIS_fnc_DataTerminalColor;
		[_vehicle, 3] call BIS_fnc_dataTerminalAnimate;
	};
	
	_vehicle;
};

_objs
