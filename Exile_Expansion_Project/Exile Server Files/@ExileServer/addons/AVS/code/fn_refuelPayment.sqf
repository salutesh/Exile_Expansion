/*
Add by Vandest.

Function:
	AVS_fnc_refuelPayment - Responds to the refuel fonction request to pay fuel.
	Handles notifications, money transactions.

Usage (from the client):
	[sessionID, _vehicle, _fuelAdding] remoteExecCall ["AVS_fnc_refuelPayment", 2];
Return Value:
	None
*/

private ["_owner", "_playerMoney", "_refuelCost"];

_OK = params
[
	["_sessionID", "", [""]],
	["_vehicle", objNull, [objNull]],
	["_fuelAddedInliters", 0, [0]],
	["_overClientAccount", false, [false]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_refuelVehicle with invalid parameters: %1",_this];
};

_owner = _sessionID call ExileServer_system_session_getPlayerObject;
_playerMoney = _owner getVariable ["ExileMoney", 0];

_refuelCost = [_vehicle, _fuelAddedInliters] call AVS_fnc_getRefuelCost;
diag_log format ["_refuelCost: %1",_refuelCost];

diag_log format ["_overClientAccount: %1",_overClientAccount];
if (_overClientAccount) then
{
	[_owner, "toastRequest", ["ErrorTitleAndText", ["Refuel","You don't have enough poptabs! You can't refuel anymore"]]] call ExileServer_system_network_send_to;
	diag_log "Client don't have enough poptabs!";
}
else
{
	{
	[_x, "toastRequest", ["SuccessTitleOnly", ["Vehicle refueled!"]]] call ExileServer_system_network_send_to;
	}
	forEach crew _vehicle;
	diag_log "Client Vehicle refueled!";
};

// Bill on client account

if (_refuelCost > 0) then 
{
	_playerMoney = _playerMoney - _refuelCost;
	_owner setVariable ["ExileMoney", _playerMoney, true];
	format["setPlayerMoney:%1:%2", _playerMoney, _owner getVariable ["ExileDatabaseID", 0]] call ExileServer_system_database_query_fireAndForget;

	_titlenotification = format["-%1", _refuelCost];
	[_owner, "toastRequest", ["SuccessTitleAndText", ["Refuel", _titlenotification]]] call ExileServer_system_network_send_to;
	diag_log format["Client refuelCost: %1", _titlenotification];
};

_vehicle call ExileServer_object_vehicle_database_update;