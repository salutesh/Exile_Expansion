//missionNamespace setVariable ["ExileExpansionClient_MissionUnits_Fortress", [], true];
//publicVariable "ExileExpansionClient_MissionUnits_Fortress";

//missionNamespace setVariable ["ExileExpansion_object_interactionUnit_FortressQuestgiver", [], true];
//publicVariable "ExileExpansion_object_interactionUnit_FortressQuestgiver";

IMSClient_create_Fortress_Questgiver = 
{
	_unitClassName = "C_Journalist_01_War_F";
	_unitAnimations = ["Acts_CivilListening_2"];
	_unitFace = "Default";
	_unitLoadout = [[],[],[],["U_C_Journalist",[]],["V_Press_F",[]],[],"H_PASGT_basic_blue_press_F","G_Spectacles",[],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]];
	_unitPosition = [7816.74, 11556, 263.67];
	_unitVectorDir = [0.511338, -0.85938, 0];
	_unitVectorUp = [0, 0, 1];
	_holdActionText = "Talk to Stranger";
	_holdActionIdleIcon = "Exile_HA_Icon_Quest";
	_holdActionProgressIcon = "Exile_HA_Icon_Quest";
	_holdActionCodeCompleted = 
	{
		_questGiver = (_this select 0);
		_posStart = [7817.27, 11554.6, 0];
		_playerUnits = (_posStart nearEntities ["Exile_Unit_Player", 30]);
		missionNamespace setVariable ["ExileExpansionClient_MissionUnits_Fortress", _playerUnits, true];
		[_playerUnits, _questGiver] remoteExec ["IMS_HAE_Mission_Fortress_1", 0, true];
		[_questGiver, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
		IM_Fortress_QuestActive = true;
		publicVariable "IM_Fortress_QuestActive";
	};
	_holdActionCondition = "_this distance _target < 3 && !IM_Fortress_QuestActive";
	_scriptName = "FortressQuestgiver";
	[_unitClassName, _unitAnimations, _unitFace, _unitLoadout, _unitPosition, _unitVectorDir, _unitVectorUp, _holdActionText, _holdActionIdleIcon, _holdActionProgressIcon, _holdActionCodeCompleted, _holdActionCondition, _scriptName] call ExileExpansionClient_object_interactionUnit_create;
};

IMSClient_holdAction_Fortress_Questgiver = 
{
	_questUnits = (_this select 0);
	// Add action to the questgiver
	[
		ExileExpansion_object_interactionUnit_FortressQuestgiver,
		"Give dokuments",
		"Exile_HA_Icon_Document",
		"Exile_HA_Icon_Document",
		"_this distance _target < 3 && (player getVariable ['FortressDokument', true])",
		"_caller distance _target < 3",
		{},
		{
			private _progressTick = _this select 4;
			if (_progressTick % 2 == 0) exitwith {};
			playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
		},
		{
			private _questUnits = (_this select 3) select 0;
			private _questGiver = (_this select 3) select 1;
			[_questUnits] remoteExec ["IMS_HAE_Mission_Fortress_4", 0, true];
			[_questGiver, 0] remoteExec ["bis_fnc_holdActionRemove", 0, true];
		},
		{},
		[_questUnits, ExileExpansion_object_interactionUnit_FortressQuestgiver],
		0.5,
		0,
		true
	] call ExileExpansionClient_gui_holdActionAdd;
};