/**
 * ExileExpansionClient_system_process_postInit
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_shift", "_spawnInterval"];
if (hasInterface) then
{
	onMapSingleClick {_shift};
	[] call ExileExpansionClient_gui_playerHUD;
	if( isServer ) then
	{
		if( !isMultiplayer ) then
		{
			"Expansion Editor PostInit..." call ExileClient_util_log;
		};		
	};
	if (!isServer) then 
	{
		"Expansion Client PostInit..." call ExileClient_util_log;
	};
};

true