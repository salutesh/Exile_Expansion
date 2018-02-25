// Lock the Fortress center gate.
IMS_ScriptObject_FortressCentergate setVariable ["ExileIsLocked", -1, true];

IMS_HAE_Mission_Fortress_1 = 
{
	// Define mission player units.
	_questUnits = _this select 0;
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Create the first mission task.
		[
			[
				"ExileTask_Chernaurus_Fortress_1",
				format 
				[
					"<img image='exile_expansion_assets\texture\task\Exile_Missions_Logo.paa' width='360' height='360'/>
					<br/>
					<br/><font color='#ffb418'>Mission Information:</font>
					<br/>The strange guy talked about a badit camp in Devil's Castle.
					<br/>He also talked about some secret documents stolen by the bandits in plundering.
					<br/>He wants to see the bandits dead and have the documents back.
					<br/>
					<br/>
					<br/><font color='#ffb418'>Mission Objective:</font>
					<br/>Reach Devil's Castle and check out the situation
					<br/>
					<br/><font color='#ffb418'>Mission Reward:</font>
					<br/>5000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#f1591e'>Quest Loot-Crate</font>.
					<br/>
					<br/>"
				],
				"[Part 1] - The Fortress",
				"[Quest] - The Fortress",
				[6936.12,11349.2,0],
				"assigned",
				"walk"
			]
		] remoteExec ["FHQ_fnc_ttAddTasks", 0, true];
		// Play Music for mission players.
		["LeadTrack04_F_EXP"] remoteExec ["playMusic", _x, true];
		// Display toast notification for mission players.
		[_sessionID, "toastRequest", ["QuestTitleAndText", ["[Quest] The Fortress", "You have recived a quest objective from the strager. Open your map and take a look into the task menu."]]] call ExileServer_system_network_send_to;
	} forEach _questUnits;
	
	// Delete the first map marker of the questgiver directly (IMS Marker).
	deleteMarker ExileExpansionClient_gui_MapMarker_Mission_1_1;
	// Show the second map marker on objective position (DMS Marker).
	ExileExpansionClient_gui_MapMarker_Mission_1_2 setMarkerAlpha 1;
	
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Wait until mission players get near the first objective.
		_objectivePos = [6936.12,11349.2,0];
		waituntil {_x distance _objectivePos < 20};
		// Succeede for first mission task.
		["ExileTask_Chernaurus_Fortress_1", "succeeded"] remoteExec ["FHQ_fnc_ttSetTaskState", 0, true];
		// Create the second mission task.
		[
			[
				"ExileTask_Chernaurus_Fortress_2",
				format 
				[
					"<img image='exile_expansion_assets\texture\task\Exile_Missions_Logo.paa' width='360' height='360'/>
					<br/>
					<br/><font color='#ffb418'>Mission Objective:</font>
					<br/>You have reached Devil's Castle and there are heavily armed bandits in the area.
					<br/>Infiltarte the castle and investigate anything in the area that might be useful to achieve the success of your mission.
					<br/>
					<br/><font color='#ffb418'>Mission Reward:</font>
					<br/>5000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#f1591e'>Quest Loot-Crate</font>.
					<br/>
					<br/>"
				],
				"[Part 2] - The Fortress",
				"[Quest] - The Fortress",
				[6863.15,11443.9,0],
				"assigned",
				"attack"
			]
		] remoteExec ["FHQ_fnc_ttAddTasks", 0, true];
		// Display toast notification after task update.
		[_sessionID, "toastRequest", ["QuestTitleAndText", ["[Quest] The Fortress", "Quest task has been updated. Open your map and take a look into the task menu."]]] call ExileServer_system_network_send_to;
		// Open the Fortress main gate.
		_maingateObj = IMS_ScriptObject_FortressMaingate;
		_maingateObj setVariable ["ExileIsLocked", 0, true];
	} forEach _questUnits;
	
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Wait until mission players get near the first objective.
		_objectivePos = [6863.15,11443.9,0];
		waituntil {_x distance _objectivePos < 5};
		// Play Music for mission players.
		["LeadTrack02_F_EXP"] remoteExec ["playMusic", _x, true];
		// Succeede for first mission task.
		["ExileTask_Chernaurus_Fortress_2", "succeeded"] remoteExec ["FHQ_fnc_ttSetTaskState", 0, true];
		// Create the second mission task.
		[
			[
				"ExileTask_Chernaurus_Fortress_3",
				format 
				[
					"<img image='exile_expansion_assets\texture\task\Exile_Missions_Logo.paa' width='360' height='360'/>
					<br/>
					<br/><font color='#ffb418'>Mission Objective:</font>
					<br/>The center of the castle area is behind this locked door.
					<br/>Find a way to unlock the door and enter the center area.
					<br/>
					<br/><font color='#ffb418'>Mission Reward:</font>
					<br/>5000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#f1591e'>Quest Loot-Crate</font>.
					<br/>
					<br/>"
				],
				"[Part 3] - The Fortress",
				"[Quest] - The Fortress",
				[6854.36,11397.1,15.3576],
				"assigned",
				"search"
			]
		] remoteExec ["FHQ_fnc_ttAddTasks", 0, true];
		// Display toast notification after task update.
		[_sessionID, "toastRequest", ["QuestTitleAndText", ["[Quest] The Fortress", "Quest task has been updated. Open your map and take a look into the task menu."]]] call ExileServer_system_network_send_to;
	} forEach _questUnits;
	
	// Add action to the pc object.
	[
		IMS_ScriptObject_FortressPC,
		"Activate PC",
		"Exile_HA_Icon_PC",
		"Exile_HA_Icon_PC",
		"_this distance _target < 3",
		"_caller distance _target < 3",
		{},
		{
			_progressTick = _this select 4;
			if (_progressTick % 2 == 0) exitwith {};
			playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
		},
		{
			_questUnits = (_this select 3) select 0;
			_pc = (_this select 3) select 1;
			[_questUnits, _pc] remoteExec ["IMS_HAE_Mission_Fortress_2", 0, true];
			{
				player setVariable ["FortressPC", true];
			} forEach _questUnits;
		},
		{},
		[_questUnits, IMS_ScriptObject_FortressPC],
		0.5,
		0,
		true
	] remoteExec ["ExileExpansionClient_gui_holdActionAdd", 0, true];
};

IMS_HAE_Mission_Fortress_2 = 
{
	_questUnits = _this select 0;
	_pc = _this select 1;

	// Start screen display
	_pc setObjectTextureGlobal [0, "exile_expansion_assets\texture\model\Exile_XM8OS_Screen1_co.paa"];
	uiSleep 5;
	_pc setObjectTextureGlobal [0, "exile_expansion_assets\texture\model\Exile_XM8OS_Screen2_co.paa"];
	uiSleep 3;
	_pc setObjectTextureGlobal [0, "exile_expansion_assets\texture\model\Exile_XM8OS_Screen3_co.paa"];
	uiSleep 2;
	_pc setObjectTextureGlobal [0, "exile_expansion_assets\texture\model\Exile_XM8OS_Screen4_co.paa"];
	uiSleep 5;
	_pc setObjectTextureGlobal [0, "exile_expansion_assets\texture\model\Exile_XM8OS_Screen5_co.paa"];
	uiSleep 4;
	_pc setObjectTextureGlobal [0, "exile_expansion_assets\texture\model\Exile_XM8OS_Screen6_co.paa"];
	uiSleep 2;
	// Unlock the center gate.
	IMS_ScriptObject_FortressCentergate setVariable ["ExileIsLocked", 0, true];
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Succeede for first mission task.
		["ExileTask_Chernaurus_Fortress_3", "succeeded"] remoteExec ["FHQ_fnc_ttSetTaskState", 0, true];
		// Create the second mission task.
		[
			[
				"ExileTask_Chernaurus_Fortress_4",
				format 
				[
					"<img image='exile_expansion_assets\texture\task\Exile_Missions_Logo.paa' width='360' height='360'/>
					<br/>
					<br/><font color='#ffb418'>Mission Objective:</font>
					<br/>You found a way to unlock the gate.
					<br/>Now infiltrate the center area and find the dokuments!
					<br/>
					<br/><font color='#ffb418'>Mission Reward:</font>
					<br/>5000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#f1591e'>Quest Loot-Crate</font>.
					<br/>
					<br/>"
				],
				"[Part 4] - The Fortress",
				"[Quest] - The Fortress",
				[6909.67,11428.7,30],
				"assigned",
				"search"
			]
		] remoteExec ["FHQ_fnc_ttAddTasks", 0, true];
		// Display toast notification after task update.
		[_sessionID, "toastRequest", ["QuestTitleAndText", ["[Quest] The Fortress", "Quest task has been updated. Open your map and take a look into the task menu."]]] call ExileServer_system_network_send_to;
	} forEach _questUnits;
	
	// Add action to dokument object.
	[
		IMS_ScriptObject_FortressDokuments,
		"Take Dokuments",
		"Exile_HA_Icon_Document",
		"Exile_HA_Icon_Document",
		"_this distance _target < 3",
		"_caller distance _target < 3",
		{},
		{
			private _progressTick = _this select 4;
			if (_progressTick % 2 == 0) exitwith {};
			playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
		},
		{
			private _questUnits = (_this select 3) select 0;
			private _questgiver = (_this select 3) select 1;
			private _dokuments = (_this select 3) select 2;
			[_questUnits, _questgiver] remoteExec ["IMS_HAE_Mission_Fortress_3", 0, true];
			[_questUnits] remoteExec ["IMS_HAE_Mission_Fortress_Lootcrate", 0, true];
			{
				player setVariable ["FortressDokuments", true];
			} forEach _questUnits;
			// Remove the hold action after action completion.
			[_dokuments, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
			deleteVehicle _dokuments;
		},
		{},
		[_questUnits, ExileExpansion_object_interactionUnit_FortressQuestgiver, IMS_ScriptObject_FortressDokuments],
		0.5,
		0,
		true
	] remoteExec ["ExileExpansionClient_gui_holdActionAdd", 0, true];
};

// Dokuments Hold Action Event - 2
IMS_HAE_Mission_Fortress_3 = 
{
	// Define mission player units.
	 _questUnits = _this select 0;
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Succeede for first mission task.
		["ExileTask_Chernaurus_Fortress_4", "succeeded"] remoteExec ["FHQ_fnc_ttSetTaskState", 0, true];
		// Create the second mission task.
		[
			[
				"ExileTask_Chernaurus_Fortress_5",
				format 
				[
					"<img image='exile_expansion_assets\texture\task\Exile_Missions_Logo.paa' width='360' height='360'/>
					<br/>
					<br/><font color='#ffb418'>Mission Objective:</font>
					<br/>You found the dokuments for the stranger!
					<br/>Now get back to the stranger and give him the dokuments to recive your reward.
					<br/>
					<br/><font color='#ffb418'>Mission Reward:</font>
					<br/>5000 <img image='exile_assets\texture\ui\poptab_ca.paa' width='15' height='15'/> and a <font underline='true' color='#f1591e'>Quest Loot-Crate</font>.
					<br/>
					<br/>"
				],
				"[Part 5] - The Fortress",
				"[Quest] - The Fortress",
				[7816.85,11555.8,0],
				"assigned",
				"talk"
			]
		] remoteExec ["FHQ_fnc_ttAddTasks", 0, true];
		// Display toast notification after task update.
		[_sessionID, "toastRequest", ["QuestTitleAndText", ["[Quest] The Fortress", "Quest task has been updated. Open your map and take a look into the task menu."]]] call ExileServer_system_network_send_to;
	} forEach _questUnits;
	// Add action to the questgiver
	[_questUnits] remoteExec ["IMSClient_holdAction_Fortress_Questgiver", 0, true];
};

// Quest NPC Hold Action Event - 3
IMS_HAE_Mission_Fortress_4 = 
{
	_questUnits = _this select 0;
	{
		// Get mission players SessionID.
		_sessionID = _x getVariable ["ExileSessionID",""];
		// Complete the last mission task.
		["ExileTask_Chernaurus_Fortress_5", "succeeded"] remoteExec ["FHQ_fnc_ttSetTaskState", 0, true];
		// Toast notification about mission competion.
		[_sessionID, "toastRequest", ["QuestTitleAndText", ["[Quest] The Fortress", "Quest completed!"]]] call ExileServer_system_network_send_to;
		player setVariable ["FortressDokuments", false];
		// Play Music for mission players.
		["EventTrack02_F_Orange"] remoteExec ["playMusic", _x, true];
	} forEach _questUnits;
	
	// This grabs the array that contains information about the mission.
	// If you want to use this script on a static mission, then replace "DMS_Mission_Arr" with "DMS_StaticMission_Arr".
	_missionIndex = getNumber (missionConfigFile >> "CfgExileMissions" >> "Missions" >> "Chernarusredux" >> "fortress" >> "missionIndex");
	_missionInfo = DMS_StaticMission_Arr select _missionIndex;
	_missionUnitsArray = (_missionInfo select 4);
	_missionUnits = _missionUnitsArray call DMS_fnc_GetAllUnits;
	{
		_x setDamage 1;
	} forEach _missionUnits;
	// AI groups/units are stored in the 3rd index of each mission.
	// The DMS function returns an array of all units, so we can loop over them and kill them.

	// The mission completion info is stored in the 1st index of each mission.
	// This wipes any previous completion info and replaces it with the "external" completion type, which is specifically for cases like this
	// where you want to trigger a mission completion "externally" using a script.
	_missionInfo set [1, [["external", true]]];
};

IMS_Fortress_Completion_ActionScript = 
{
	_position = _this select 0;
	_missionConfig = missionConfigFile >> "CfgExileMissions" >> "Missions" >> "Chernarusredux" >> "fortress";
	_vehicleDrop = getNumber (_missionConfig >> "dropvehicle");
	_vehicleClass = getText (_missionConfig >> "vehicle_class");
	_lootClass = getText (_missionConfig >> "loot_class");
	uiSleep 5;
	// Spawn vehicle loot if option in config is true.
	if (_vehicleDrop > 0) then 
	{
		// Create vehicle.
		 _pincode = (1000 +(round (random 8999)));
		[_vehicleClass, _position, _pincode, "Vehicle Loot"] remoteExec ["IMS_fnc_SpawnPersistentVehicle", 0, true];
	};
	sleep 5;
	// Spawn mission loot drop.
	[_position, "B_supplyCrate_F", _lootClass, "Loot"] remoteExec ["IMS_fnc_LootDrop", 0, true];
	// Spawn leaflets :D
	[_position] remoteExec ["IMS_fnc_LeafletsBomb", 0, true];
};