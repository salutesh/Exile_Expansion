/*
	CLS Addon Post-Init File
	Written by Salutesh
	www.reality-gaming.eu
*/

#define CALLFILE(FILE) call compileFinal preprocessFileLineNumbers FILE;
private ["_timeStamp"];
_timeStamp = diag_tickTime;

diag_log "----------------------------------------------------------------------------------------------------";
diag_log "------------------------------- Starting CLS Server Addon Post-Init --------------------------------";
diag_log "------------------------------------------ Version 1.0 ---------------------------------------------";
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format['[CLS Server Addon] Loading CLS server files..'];

if (worldName == 'Altis') then {};

if (worldName == 'Stratis') then {};

if (worldName == 'Chernarus') then {};

if (worldName == 'Tanoa') then
{
	["CLS_LootCrates_Tanoa"] call CLS_fnc_ImportFromInteractionLootCrates;
};

if (worldName == 'Napf') then {};

if (worldName == 'xcam_taunus') then {};

diag_log format['[CLS Server Addon] Server files loaded!'];
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format["End of CLS Server Addon Post-Init :: Total Execution Time %1 seconds",(diag_tickTime) - _timeStamp];
diag_log "----------------------------------------------------------------------------------------------------";