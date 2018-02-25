/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_world_initialize hook - Redirects Exile function calls to perform AVS functions.
*/

_retVal = call ExileServer_world_initialize_ORIGINAL;
call AVS_fnc_spawnAllVehicles;
_retVal