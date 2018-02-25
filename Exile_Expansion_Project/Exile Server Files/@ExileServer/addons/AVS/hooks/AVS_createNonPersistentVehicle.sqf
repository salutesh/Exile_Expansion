/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_createNonPersistentVehicle hook - Redirects Exile function calls to perform AVS functions.
*/

_vehicle = _this call ExileServer_object_vehicle_createNonPersistentVehicle_ORIGINAL;
_vehicle call AVS_fnc_sanitizeVehicle;
_vehicle