/*
Function:
	AVS_fnc_fillCanister - Responds to a player's request to fill a canister.
	Handles notifications, money transactions, and having the clients update the canister.

Usage (from the client):
	[sessionID, _vehicle,] remoteExec [AVS_fnc_fillCanister, 2];
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
	diag_log format ["AVS Error: Calling AVS_fnc_fillCanister with invalid parameters: %1",_this];
};

_owner = _sessionID call ExileServer_system_session_getPlayerObject;
_playerMoney = _owner getVariable ["ExileMoney", 0];

_canisterEmptyCost = _vehicle call AVS_fnc_getFillCanCost;

if (_playerMoney < _canisterEmptyCost) exitWith
{
	[_owner, "toastRequest", ["ErrorTitleAndText", ["Fill Canister", "You don't have enough poptabs!"]]] call ExileServer_system_network_send_to;
};

[_vehicle] remoteExec ["AVS_fnc_fillCanisterClient", _vehicle];

_playerMoney = _playerMoney - _canisterEmptyCost;
_owner setVariable ["ExileMoney", _playerMoney, true];
format["setPlayerMoney:%1:%2", _playerMoney, _owner getVariable ["ExileDatabaseID", 0]] call ExileServer_system_database_query_fireAndForget;
//[_playerMoney] remoteExec ["AVS_fnc_setPlayerMoney", _owner];

[_owner, "toastRequest", ["SuccessTitleOnly", ["Fuel canister filled!"]]] call ExileServer_system_network_send_to;

_vehicle call ExileServer_object_player_database_update;