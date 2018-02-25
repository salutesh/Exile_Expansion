/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_fnc_rearmVehicle - Responds to a player's request to rearm a vehicle.
	Handles notifications, money transactions, and having the clients update their ammo state.

Usage (from the client):
	[sessionID, _vehicle,] remoteExec [AVS_fnc_rearmVehicle, 2];
Return Value:
	None
*/

private ["_owner", "_playerMoney", "_rearmCost"];

_OK = params
[
	["_sessionID", "", [""]],
	["_vehicle", objNull, [objNull]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_rearmVehicle with invalid parameters: %1",_this];
};

_owner = _sessionID call ExileServer_system_session_getPlayerObject;
_playerMoney = _owner getVariable ["ExileMoney", 0];

_rearmCost = _vehicle call AVS_fnc_getRearmCost;

if (_playerMoney < _rearmCost) exitWith
{
	//[_owner, "notificationRequest", ["Whoops", ["You don't have enough poptabs!"]]] call ExileServer_system_network_send_to;
	[_owner, "toastRequest", ["ErrorTitleAndText", ["Rearm","You don't have enough poptabs!"]]] call ExileServer_system_network_send_to;
};

{
	[_vehicle] remoteExec ["AVS_fnc_rearmTurret", _x];
} forEach crew _vehicle;

_playerMoney = _playerMoney - _rearmCost;
_owner setVariable ["ExileMoney", _playerMoney, true];
format["setPlayerMoney:%1:%2", _playerMoney, _owner getVariable ["ExileDatabaseID", 0]] call ExileServer_system_database_query_fireAndForget;
//[_playerMoney] remoteExec ["AVS_fnc_setPlayerMoney", _owner];

{
	//[_x, "notificationRequest", ["Success", ["Vehicle rearmed!"]]] call ExileServer_system_network_send_to;
	[_x, "toastRequest", ["SuccessTitleOnly", ["Vehicle rearmed!"]]] call ExileServer_system_network_send_to;
}
forEach crew _vehicle;

_vehicle call ExileServer_object_vehicle_database_update;