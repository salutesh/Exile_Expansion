/*
    IMS_Layout_Tasks.sqf
    Written by Salutesh
    www.reality-gaming.eu
	
    Description: Mission tasks for the mission.  
*/

IMS_Mission_TE_1 = {
	IMS_Mission_Task_1 = player createSimpleTask ["[Quest] - Secret Documents"];
	IMS_Mission_Task_1 setSimpleTaskDescription 
	[
		"<img image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/>
		<br/>
		<br/><font color='#ffb418'>Mission Information:</font>
		<br/>The stranger talked about a badit camp near Lijnhaven.
		<br/>He also talked about some secret documents stolen by the bandits in plundering.
		<br/>He wants to see the bandits dead and have the documents back.
		<br/>
		<br/>
		<br/><font color='#ffb418'>Mission Objective:</font>
		<br/>Your mission objective is to infiltrate the badit camp.
		<br/>Kill the bandits and find the documents to destroy them.
		<br/>Investigate anything that might be useful to achieve the success of this mission.
		<br/>
		<br/><font color='#ffb418'>Mission Reward:</font>
		<br/>2000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#1564ff'>Quest Loot-Crate</font>.
		<br/>
		<br/>",
		"[Quest] - Secret Documents",
		""
	];
	IMS_Mission_Task_1 setSimpleTaskType "attack";
	IMS_Mission_Task_1 setSimpleTaskDestination [12112.3,2486.2,0];
	IMS_Mission_Task_1 setTaskState "Assigned";
	player setCurrentTask IMS_Mission_Task_1;
};

IMS_Mission_TEE_1 = {
	IMS_Mission_Task_1 setTaskState "Succeeded";
};

IMS_Mission_TE_2 = {
	IMS_Mission_Task_2 = player createSimpleTask ["[Quest] - Secret Documents"];
	IMS_Mission_Task_2 setSimpleTaskDescription 
	[
		"<img image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/>
		<br/>
		<br/><font color='#ffb418'>Mission Update:</font>
		<br/>You found the documents!
		<br/>Kill all remaining bandits when there are still some, then go back to the stranger (marked position on your map) and give him the Dokuments.
		<br/>
		<br/><font color='#ffb418'>Mission Reward:</font>
		<br/>2000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#1564ff'>Quest Loot-Crate</font>.
		<br/>
		<br/>",
		"Secret Documents - Capture the base",
		""
	];
	IMS_Mission_Task_2 setSimpleTaskType "talk";
	IMS_Mission_Task_2 setSimpleTaskDestination [11390.6,2289.79,0];
	IMS_Mission_Task_2 setTaskState "Assigned";
	player setCurrentTask IMS_Mission_Task_2;
};

IMS_Mission_TEE_2 = {
	IMS_Mission_Task_2 setTaskState "Succeeded";
};

publicVariable "IMS_Mission_TE_1";
publicVariable "IMS_Mission_TEE_1";
publicVariable "IMS_Mission_TE_2";
publicVariable "IMS_Mission_TEE_2";