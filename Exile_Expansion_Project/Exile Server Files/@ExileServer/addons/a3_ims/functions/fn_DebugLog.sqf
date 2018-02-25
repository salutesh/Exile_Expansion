/*
	IMS_fnc_DebugLog
	Created by eraser1 and 
	Modified by Salutesh
	
	Usage:
	_anyValue call IMS_fnc_DebugLog;

	This function will write the passed parameter as well as server updtime and FPS to RPT.
	If you have infiSTAR's DLLs, then it will also utilize the "ARMA_LOG" dll to write debug info.
*/

_this = format ['%1 |::|::| (IMS_Version: "%4" | time: %2 | diag_tickTime: %5 | %3 FPS)',_this,time,diag_fps,IMS_Version,diag_tickTime];
"ARMA_LOG" callExtension format ["IMS_DEBUG:%1",_this];
diag_log format ["IMS_DEBUG :: %1",_this];