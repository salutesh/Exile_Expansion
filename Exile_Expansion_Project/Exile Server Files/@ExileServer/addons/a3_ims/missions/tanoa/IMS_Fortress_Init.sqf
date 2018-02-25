private ["_missionID"];
_missionID = _this select 0;
IMS_Fortress_MissionID = _missionID;
publicVariable "IMS_Fortress_MissionID";

[] call compileFinal preprocessFileLineNumbers ("a3_ims\missions\tanoa\fortress\IMS_Fortress_GlobalVars.sqf");
[] call compileFinal preprocessFileLineNumbers ("a3_ims\missions\tanoa\fortress\IMS_Fortress_Tasks.sqf");
[] call compileFinal preprocessFileLineNumbers ("a3_ims\missions\tanoa\fortress\IMS_Fortress_Toasts.sqf");
[] call compileFinal preprocessFileLineNumbers ("a3_ims\missions\tanoa\fortress\IMS_Fortress_HoldActionEvents.sqf");
diag_log format['[IMS Server Addon] [Tanoa] Fortress mission scripts loaded!'];