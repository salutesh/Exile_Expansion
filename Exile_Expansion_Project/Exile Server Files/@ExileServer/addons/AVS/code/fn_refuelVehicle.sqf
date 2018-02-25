/*
Function:
	AVS_fnc_refuelVehicle - Responds to a player's request to refuel a vehicle.
	Handles notifications.

Usage (from the client):
	[_vehicle,] remoteExec [AVS_fnc_refuelVehicle, 2];
Return Value:
	None
*/

_OK = params
[
	["_vehicle", objNull, [objNull]]
];

if (!_OK) exitWith
{
	diag_log format ["AVS Error: Calling AVS_fnc_refuelVehicle with invalid parameters: %1",_this];
};

[_vehicle] remoteExec ["AVS_fnc_refuelVehicleClient", _vehicle];


{
	[_x, "toastRequest", ["InfoTitleAndText", ["Refuel", "Vehicle refueling is started!"]]] call ExileServer_system_network_send_to;
}
forEach crew _vehicle;

