/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_player_createBambi hook - Redirects Exile function calls to perform AVS functions.
*/

_bambiPlayer = _this select 3;
_bambiPlayer addEventHandler ["WeaponAssembled", {(_this select 1) call AVS_fnc_sanitizeVehicle;}];
_this call ExileServer_object_player_createBambi_ORIGINAL