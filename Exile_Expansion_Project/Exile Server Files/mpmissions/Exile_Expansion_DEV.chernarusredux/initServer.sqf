/*
    File: initServer.sqf
    Author: Salutesh
    
    Description:
	Main mission Server initialzation file.
    
*/
private ["_timeStamp"];
_timeStamp = diag_tickTime;

diag_log "------------------------------------ Starting Exile Mission Server Init ------------------------------------";

[] call CompileFinal preprocessFileLineNumbers "core\objects\ExileServerObjects.sqf";							// Exile Server Objects
[] call CompileFinal preprocessFileLineNumbers "core\scripts\ExileTime.sqf";											// Fasttime code

diag_log format["End of Exile Mission Server Init :: Total Execution Time %1 seconds ",(diag_tickTime) - _timeStamp];