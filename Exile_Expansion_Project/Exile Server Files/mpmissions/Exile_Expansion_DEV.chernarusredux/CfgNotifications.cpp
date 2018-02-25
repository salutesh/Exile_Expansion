/**
 * CfgNotifications
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
class CfgNotifications
{
	class TaskAssigned
	{
		title = "Quest Assigned";
		iconPicture = "\exile_expansion_assets\texture\marker\quest_marker_ca.paa";
		description = "%2";
		priority = 5;
		sound = "taskAssigned";
	};
	
	class TaskCreated: TaskAssigned
	{
		title = "Quest Created";
		iconPicture = "\exile_expansion_assets\texture\marker\quest_marker_ca.paa";
		priority = 5;
		sound = "taskCreated";
	};
	
	class TaskSucceeded: TaskAssigned
	{
		title = "Quest Objective Completed";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
		priority = 6;
		color[] = {0.7,1.0,0.3,1.0};
		sound = "taskSucceeded";
	};
	
	class TaskFailed: TaskAssigned
	{
		title = "Quest Failed";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
		priority = 6;
		color[] = {1.0,0.3,0.2,1.0};
		sound = "taskFailed";
	};
	
	class TaskCanceled: TaskAssigned
	{
		title = "Quest Canceled";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_ca.paa";
		priority = 6;
		color[] = {0.7,0.7,0.7,1.0};
		sound = "taskCanceled";
	};
	
	class TaskUpdated: TaskAssigned
	{
		title = "Quest Objective Updated";
		priority = 4;
		sound = "taskUpdated";
	};
};

