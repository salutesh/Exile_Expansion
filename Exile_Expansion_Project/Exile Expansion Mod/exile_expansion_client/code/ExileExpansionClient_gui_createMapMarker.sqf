/**
 * ExileExpansionClient_gui_createMapMarker
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 *
 *	Usage:
 *	[
 *		_position,				// ARRAY (positionATL or position2d): Where the marker will be spawned (strict)
 *		_markerType,			// STRING: Icon type of the marker. Example: "ExileHeart"
 *		_markerLabel,			// STRING: Label to spawn for the marker.
 *		_markerName,			// STRING: Name to spawn for the marker.
 *		_markerScriptName,		// STRING: Scriptname for the marker.
 *		_deletMarker			// BOOLEAN: Delete marker after 2 minutes? 
 *	] call ExileExpansionClient_gui_createMapMarker;
 *
 *	Returns the created marker object.
*/

private _marker = objNull;

try
{
	if !(params	["_position", "_markerType", "_markerLabel", "_markerName",	"_markerScriptName", "_deleteMarker"]) then
	{
		throw (format ["Invalid parameters: %1", _this]);
	};
	
	_marker = createMarker [_markerName, _position];	
	_marker setMarkerType _markerType;
	_marker setMarkerAlpha 1; 
	_marker setMarkerText format ["[%1] %2", _markerLabel,_markerName];
	
	private _scriptName = format ["ExileExpansionClient_gui_MapMarker_%1",_markerScriptName];
	missionNamespace setVariable [_scriptName, _marker, true];
	publicVariable _scriptName;
	
	if (_deleteMarker) then 
	{	
		[
			120, 
			{
				deleteMarker (_this select 0);
			}, 
			[_marker], 
			false
		] remoteExec ["ExileServer_system_thread_addTask", 0, true];
	};
}
catch
{
	diag_log format ["Exile Expansion ERROR :: Calling ExileExpansionClient_gui_createMapMarker with %1!", _exception];
};

_marker