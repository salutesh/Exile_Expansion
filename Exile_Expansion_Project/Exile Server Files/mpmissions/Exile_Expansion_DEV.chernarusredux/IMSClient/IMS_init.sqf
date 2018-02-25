/**
 * IMS_init
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
// Chernarusredux
if (worldName == 'chernarusredux') then
{
	_missionArrayConfig = missionConfigFile >> "CfgExileMissions" >> "Missions";
	_activeMissions = getArray (_missionArrayConfig >> "Chernarusredux" >> "activeMissions");
	{
		_missionConfig = missionConfigFile >> "CfgExileMissions" >> "Missions";
		_missionArray = _x;
		_missionFile = getText (_missionConfig >> "Chernarusredux" >> _missionArray >> "missionFile");
		[] call compile preprocessFileLineNumbers (format["IMSClient\chernarusredux\%1.sqf", _missionFile]);
	} forEach _activeMissions;
};