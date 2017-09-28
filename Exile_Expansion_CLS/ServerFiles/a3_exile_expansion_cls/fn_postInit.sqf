/*
	Exile Expansion CLS Server Addon Post-Init File
	Written by Salutesh
	www.reality-gaming.eu
*/

#define CALLFILE(FILE) call compileFinal preprocessFileLineNumbers FILE;
private ["_timeStamp"];
_timeStamp = diag_tickTime;

diag_log "----------------------------------------------------------------------------------------------------";
diag_log "----------------------- Starting Exile Expansion CLS Server Addon Post-Init ------------------------";
diag_log "------------------------------------------ Version 1.0 ---------------------------------------------";
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format['[Exile Expansion CLS Server Addon] Loading server files..'];

//["CrateObjects"] call Exile_Expansion_CLS_fnc_ImportInteractionCrates;

diag_log format['[Exile Expansion CLS Server Addon] Server files loaded!'];
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format["End of Exile Expansion CLS Server Addon Post-Init :: Total Execution Time %1 seconds",(diag_tickTime) - _timeStamp];
diag_log "----------------------------------------------------------------------------------------------------";

