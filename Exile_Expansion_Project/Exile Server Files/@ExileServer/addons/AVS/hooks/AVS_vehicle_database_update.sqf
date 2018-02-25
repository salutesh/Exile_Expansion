/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling
Co-Developed by Vishpala

All rights reserved.

Function:
	AVS_vehicle_database_update hook - Redirects Exile function calls to perform AVS functions.
*/
_retVal = _this call ExileServer_object_vehicle_database_update_ORIGINAL;
_this call AVS_fnc_saveAmmo;
_retVal