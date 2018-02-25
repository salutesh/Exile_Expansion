/* FHQ Task Tracker
 * Copyright 2016 by Thomas Frieden (Varanon). All rights reserved. Use of this software
 * is at your own risk. The copyright holder is in no way responsible for damages
 * resulting from the use of this software.
 * Distribution of the software is only allowed within a mission. In addition, no
 * changes are allowed to the software without the permission of the authors.
 * Distribution as a standalone package is prohibited.
 * Attribution (getting a mention in the credits section of your mission) is appreciated, 
 * but not a requirement 
 */

#define INTERNAL_FUNCTION(x)				\
	class x									\
	{										\
		description = "Internal Function";	\
	};

#define EXPORTED_FUNCTION(x,y)				\
	class x									\
	{										\
		description = y;					\
	};

class FHQ {
	class TaskTrackerInternal {
		tag="FHQ";
		file="functions\fhq_tasktracker";

		class ttiInit
		{
			description = "Internal function, called automatically";
			preInit = 1;
		};

		class ttiPostInit
		{
			description = "Internal function, called automatically";
			postInit = 1;
		};

		INTERNAL_FUNCTION(ttifilterUnits)
		INTERNAL_FUNCTION(ttiAddBriefingEntry)
		INTERNAL_FUNCTION(ttiHasBriefingEntry)
		INTERNAL_FUNCTION(ttiUpdateBriefingList)
		INTERNAL_FUNCTION(ttiGetTaskId)
		INTERNAL_FUNCTION(ttiGetTaskDesc)
		INTERNAL_FUNCTION(ttiGetTaskTitle)
		INTERNAL_FUNCTION(ttiGetTaskWp)
		INTERNAL_FUNCTION(ttiGetTaskTarget)
		INTERNAL_FUNCTION(ttiGetTaskState)
		INTERNAL_FUNCTION(ttiGetTaskName)
		INTERNAL_FUNCTION(ttiGetTaskType)
		INTERNAL_FUNCTION(ttiTaskExists)
		INTERNAL_FUNCTION(ttiCreateOrUpdateTask)
		INTERNAL_FUNCTION(ttiUpdateTaskList)
		INTERNAL_FUNCTION(ttiMissionTasks)
		INTERNAL_FUNCTION(ttiMissionBriefing)
		INTERNAL_FUNCTION(ttiUnitTasks)
		INTERNAL_FUNCTION(ttiUnitBriefing)
		INTERNAL_FUNCTION(ttiIsFilter)
		INTERNAL_FUNCTION(ttiIsTaskState)
		INTERNAL_FUNCTION(ttiRespawnTask)
	};

	class TaskTracker {
		tag="FHQ";
		file="functions\fhq_tasktracker";

		EXPORTED_FUNCTION(ttTaskHint, "This function is called for every task hint to be displayed.")
		EXPORTED_FUNCTION(ttAddBriefing, "Adds a briefing to the missing.")
		EXPORTED_FUNCTION(ttAddTasks, "Adds tasks to the mission.")
		EXPORTED_FUNCTION(ttGetTaskState, "Return the state of a task.")
		EXPORTED_FUNCTION(ttSetTaskState, "Set the new state of a task.")
		EXPORTED_FUNCTION(ttIsTaskCompleted, "Check whether a given task is completed")
		EXPORTED_FUNCTION(ttAreTasksCompleted, "Check whether a list of tasks is completed")
		EXPORTED_FUNCTION(ttIsTaskSuccessful, "Check whether a given task is successfully completed")
		EXPORTED_FUNCTION(ttAreTasksSuccessful, "Check whether a list of tasks is successfully completed")
		EXPORTED_FUNCTION(ttGetAllTasksWithState, "Return an array of all tasks with a given state")
		EXPORTED_FUNCTION(ttSetTaskStateAndNext, "Set a task's state, and select the next one")
	};
};
