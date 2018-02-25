/*
    IMS_raidTasks.sqf
    Written by Salutesh
    www.reality-gaming.eu
	
    Description: Mission tasks for the fortress mission.  
*/

IMS_Fortress_TaskEvent_1 = {
	IMS_Fortress_Task_1 = player createSimpleTask ["The Fortress - The Mission [Part 1]"];
	IMS_Fortress_Task_1 setSimpleTaskDescription ["<img align='center' image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/><br/><br/><font color='#db3a49'>Situation:</font><br/>Bandits have taken the fortress near Lijnhaven.<br/>There are sensitive technologies, explosives and resources in the area.<br/><br/><font color='#db3a49'>Mission Ojective:</font><br/>The objective is to investigate the fortress area and find a way to stop the bandits from stealing the technologies and explosives.<br/><br/>Go to the fortess area and investigate anything that might be useful to achieve the success of this mission.",
	"The Fortress - The Mission [Part 1]",""];
	IMS_Fortress_Task_1 setSimpleTaskDestination [12156.5,2472.67,0];
	IMS_Fortress_Task_1 setTaskState "Assigned";
	player setCurrentTask IMS_Fortress_Task_1;
};

IMS_Fortress_TaskEvent_1_End = {
	IMS_Fortress_Task_1 setTaskState "Succeeded";
};

IMS_Fortress_TaskEvent_2 = {
	IMS_Fortress_Task_2 = player createSimpleTask ["The Fortress - Big Momma [Part 2]"];
	IMS_Fortress_Task_2 setSimpleTaskDescription ["<img align='center' image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/><br/><br/><font color='#db3a49'>Mission Ojective:</font><br/><t color='#f0ff00' font='PuristaSemiBold'>You found some wired and crosslinked bombs in the area. There must be a transmitter somewhere in the area that controls them. Locate and activate it.</t>",
	"The Fortress - Big Momma [Part 2]",""];
	IMS_Fortress_Task_2 setSimpleTaskDestination [12092.2,2509.69,0];
	//IMS_Fortress_Task_2 setTaskState "Created";
	IMS_Fortress_Task_2 setTaskState "Assigned";
	player setCurrentTask IMS_Fortress_Task_2;
};

IMS_Fortress_TaskEvent_2_End = {
	IMS_Fortress_Task_2 setTaskState "Succeeded";
};

IMS_Fortress_TaskEvent_3 = {
	IMS_Fortress_Task_3 = player createSimpleTask ["The Fortress - Up And Away [Part 3]"];
	IMS_Fortress_Task_3 setSimpleTaskDescription ["<img align='center' image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/><br/><br/><font color='#db3a49'>Mission Ojective:</font><br/><t color='#f0ff00' font='PuristaSemiBold'>You have disabled the security systems and unlocked the central control tower. Examine the tower and see what is in there.</t>",
	"The Fortress - Up And Away [Part 3]",""];
	IMS_Fortress_Task_3 setSimpleTaskDestination [12068.1,2460.89,15.295];
	//IMS_Fortress_Task_2 setTaskState "Created";
	IMS_Fortress_Task_3 setTaskState "Assigned";
	player setCurrentTask IMS_Fortress_Task_3;
};

IMS_Fortress_TaskEvent_3_End = {
	IMS_Fortress_Task_3 setTaskState "Succeeded";
};

IMS_Fortress_TaskEvent_4 = {
	IMS_Fortress_Task_4 = player createSimpleTask ["The Fortress - Life Is Hard [Final]"];
	IMS_Fortress_Task_4 setSimpleTaskDescription ["<img align='center' image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/><br/><br/><font color='#db3a49'>Mission Ojective:</font><br/><t color='#f0ff00' font='PuristaSemiBold'>You have activated the bomb detonators. Save what can be saved and leave the area before the time runs out!</t>",
	"The Fortress - Life Is Hard [Final]",""];
	IMS_Fortress_Task_4 setSimpleTaskDestination [12128.5,2272.22,0];
	//IMS_Fortress_Task_2 setTaskState "Created";
	IMS_Fortress_Task_4 setTaskState "Assigned";
	player setCurrentTask IMS_Fortress_Task_4;
};

IMS_Fortress_TaskEvent_4_End = {
	IMS_Fortress_Task_4 setTaskState "Succeeded";
};


publicVariable "IMS_Fortress_TaskEvent_1";
publicVariable "IMS_Fortress_TaskEvent_1_End";
publicVariable "IMS_Fortress_TaskEvent_2";
publicVariable "IMS_Fortress_TaskEvent_2_End";
publicVariable "IMS_Fortress_TaskEvent_3";
publicVariable "IMS_Fortress_TaskEvent_3_End";
publicVariable "IMS_Fortress_TaskEvent_4";
publicVariable "IMS_Fortress_TaskEvent_4_End";