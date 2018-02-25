/*
	IMS_fnc_ImportFromExileEdenPluginSimple
	Created by Salutesh

	Check out Exile Eden Plugin: http://www.exilemod.com/devblog/exile-3den-plugin/

	Usage:
	[
		_file																	// String: The filename (or filepath under the objects folder) that contains the exported Exile Eden Plugin simple objects.
	] call IMS_fnc_ImportFromExileEdenPluginSimple;

	_file call IMS_fnc_ImportFromExileEdenPluginSimple; 						// This also works

	This function will simply create the objects from a file that is included to the addons objects folder.
*/

if !(params
[
	["_file","",[""]]
])
exitWith
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_ImportFromExileEdenPluginSimple with invalid parameters: %1",_this];
	[]
};

// The next few lines checks to see if the static base has been spawned previously, in order to avoid spawning duplicate objects.
private _varname = format ["IMS_StaticBaseSpawned_%1",_file];

if (missionNamespace getVariable [_varname,false]) exitWith
{
	diag_log format ["IMS ERROR :: Attempting to spawn simple objects with file ""%1"" after it has already been spawned!",_file];
};

missionNamespace setVariable [_varname,true];


private _export = call compile preprocessFileLineNumbers (format ["a3_ims\objects\%1.sqf",_file]);

if ((isNil "_export") || {!(_export isEqualType [])}) exitWith
{
	diag_log format ["IMS ERROR :: Calling IMS_fnc_ImportFromExileEdenPluginSimple with invalid file/filepath: %1 | _export: %2",_file,_export];
	[]
};

private _objs = _export apply
{
	private _invisibleSelections = ["zasleh", "zasleh2", "box_nato_grenades_sign_f", "box_nato_ammoord_sign_f", "box_nato_support_sign_f"];
	private _simpleObject = createSimpleObject [_x select 0, _x select 1];
	_simpleObject setVectorDirAndUp [_x select 2, _x select 3];
	{
		if ((toLower _x) in _invisibleSelections) then 
		{
			_simpleObject hideSelection [_x, true];
		};
	}
	forEach (selectionNames _simpleObject);
};


_objs
