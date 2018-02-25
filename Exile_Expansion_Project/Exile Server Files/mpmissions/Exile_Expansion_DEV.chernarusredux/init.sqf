/**
 * init
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private ["_timeStamp"];
_timeStamp = diag_tickTime;
diag_log "------------------------------------ Starting Expansion Exile Mission Init ------------------------------------";

enableDynamicSimulationSystem true;

[] execVM "VCOMAI\init.sqf";																	// VCom AI
[] call CompileFinal preprocessFileLineNumbers "core\scripts\ExileWeather.sqf";					// Dynamic Weather
[] execVM "scarCODE\restartWarnings\sqf\initLocal.sqf";											// Restart Notifier
[] execVM "scarCODE\ServerInfoMenu\sqf\initLocal.sqf";											// Server Info Menu
[] call CompileFinal preprocessFileLineNumbers "IMSClient\IMS_init.sqf";						// IMSClient
if (hasInterface && !isServer) then 
{
	systemchat format["[Exile] Loading client for Player %1..",name player];
	
	[] call CompileFinal preprocessFileLineNumbers "core\scripts\ExileBriefing.sqf";			// Rules and Informations
	
	waitUntil {alive vehicle player};	
	waitUntil {typeOF player != "Exile_Unit_GhostPlayer"};
	uiSleep 2;
	[] execVM "core\scripts\ExileWelcomeInfo.sqf";												// Welcome toast Notifications
	[] call Exile_Expansion_MissionBriefing;													// Mission Briefing
	
	systemchat format["[Exile] Client loaded for Player %1.",name player];
};
diag_log format["End of Exile Expansion Mission Init :: Total Execution Time %1 seconds ",(diag_tickTime) - _timeStamp];