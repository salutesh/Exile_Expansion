class CfgRemoteExec 
{
    class Functions 
    {
        mode = 2;
        jip = 0;
		class fnc_AdminReq 											{ allowedTargets=2; };
		class ExileServer_system_network_dispatchIncomingMessage 	{ allowedTargets=2; };
		class BIS_fnc_holdActionAdd									{ allowedTargets=0; };
		class BIS_fnc_holdActionRemove								{ allowedTargets=0; };
		class FHQ_fnc_ttifilterUnits								{ allowedTargets=2; };
		class FHQ_fnc_ttiAddBriefingEntry							{ allowedTargets=2; };
		class FHQ_fnc_ttiUpdateBriefingList							{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskId									{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskDesc								{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskTitle								{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskWp									{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskTarget								{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskState								{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskName								{ allowedTargets=2; };
		class FHQ_fnc_ttiGetTaskType								{ allowedTargets=2; };
		class FHQ_fnc_ttiTaskExists									{ allowedTargets=2; };
		class FHQ_fnc_ttiCreateOrUpdateTask							{ allowedTargets=2; };
		class FHQ_fnc_ttiUpdateTaskList								{ allowedTargets=2; };
		class FHQ_fnc_ttiMissionTasks								{ allowedTargets=2; };
		class FHQ_fnc_ttiMissionBriefing							{ allowedTargets=2; };
		class FHQ_fnc_ttiUnitTasks									{ allowedTargets=2; };
		class FHQ_fnc_ttiUnitBriefing								{ allowedTargets=2; };
		class FHQ_fnc_ttiRespawnTask								{ allowedTargets=2; };
		class FHQ_fnc_ttiIsFilter									{ allowedTargets=2; };
		class FHQ_fnc_ttiIsTaskState								{ allowedTargets=2; };
		class FHQ_fnc_ttTaskHint									{ allowedTargets=2; };
		class FHQ_fnc_ttAddBriefing									{ allowedTargets=2; };
		class FHQ_fnc_ttAddTasks									{ allowedTargets=2; };
		class FHQ_fnc_ttGetTaskState								{ allowedTargets=2; };
		class FHQ_fnc_ttSetTaskState								{ allowedTargets=2; };
		class FHQ_fnc_ttIsTaskCompleted								{ allowedTargets=2; };
		class FHQ_fnc_ttAreTasksCompleted							{ allowedTargets=2; };
		class FHQ_fnc_ttIsTaskSuccessful							{ allowedTargets=2; };
		class FHQ_fnc_ttAreTasksSuccessful							{ allowedTargets=2; };
		class FHQ_fnc_ttGetAllTasksWithState						{ allowedTargets=2; };
		class FHQ_fnc_ttSetTaskStateAndNext							{ allowedTargets=2; };
    };
    class Commands
    {
		mode=0;
		jip=0;
    };
};