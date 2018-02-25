/*
    IMS_Fortress_GlobalVars.sqf
    Written by Salutesh
    www.reality-gaming.eu
	
*/

/*
// DMS Mission Handling
IMS_Layout_DMSCompletionEvent = {
	// End the DMS mission The Fortress after raid event completion.
	// This grabs the array that contains information about the mission.
	// If you want to use this script on a static mission, then replace "DMS_Mission_Arr" with "DMS_StaticMission_Arr".
	private _missionInfo = DMS_StaticMission_Arr select IMS_Layout_SaticMission_Arr;
	{
		_x setDamage 1;				// Kill all units
	} forEach ((_missionInfo select 4) call DMS_fnc_GetAllUnits);
	// AI groups/units are stored in the 3rd index of each mission.
	// The DMS function returns an array of all units, so we can loop over them and kill them.

	// The mission completion info is stored in the 1st index of each mission.
	// This wipes any previous completion info and replaces it with the "external" completion type, which is specifically for cases like this
	// where you want to trigger a mission completion "externally" using a script.
	_missionInfo set [1, [["external",true]]];	
};
//publicVariable "IMS_Layout_DMSCompletionEvent";
*/

IMS_Fortress_Completion_ActionScript = {
	// Define mission player units.
	_position = _this select 0;
	sleep 5;
	// Spawn vehicle loot if option in config is true.
	if (IMS_Fortress_VehicleLoot) then {
		// Create vehicle.
		_pincode = (1000 +(round (random 8999)));
		[IMS_Fortress_VehicleLootClass, _position, _pincode, "Vehicle Loot"] remoteExec ["IMS_fnc_SpawnPersistentVehicle", 0, true];
	};
	sleep 5;
	// Spawn mission loot drop.
	[_position, "B_supplyCrate_F", "IMS_Rare_Container", "Loot"] remoteExec ["IMS_fnc_LootDrop", 0, true];
};