

_this = format ['%1 |::|::| (IMS_Version: "%4" | time: %2 | diag_tickTime: %5 | %3 FPS)',_this,time,diag_fps,IMS_Version,diag_tickTime];
"ARMA_LOG" callExtension format ["ExileExpansionServer_server_debugLog:%1",_this];
diag_log format ["ExileExpansionServer_server_debugLog :: %1",_this];