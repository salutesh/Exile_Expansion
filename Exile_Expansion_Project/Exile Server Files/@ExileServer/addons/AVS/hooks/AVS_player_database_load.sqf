/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_player_database_load hook - Redirects Exile function calls to perform AVS functions.
*/

_retVal = _this call ExileServer_object_player_database_load_ORIGINAL;
_sessionID = _this select 3;
_player = _sessionID call ExileServer_system_session_getPlayerObject;
_player addEventHandler ["WeaponAssembled", {(_this select 1) call AVS_fnc_sanitizeVehicle;}];
_retVal