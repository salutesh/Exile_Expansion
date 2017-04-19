/*
	CLS_fnc_AddHoldAction
	Created by Salutesh

	This function will simply reduce the amount of parameters that are needed to execute the BIS_fnc_holdActionAdd function.
	This function will create a hold action with given parameters to the given target.
	Target can be a object, npc or vehicle (nothing else tested yet).
	
	Usage:
	[
		_object,														// [STRING]: Object target.
		_label, 														// [STRING]: Hold action title.
		_type,															// [STRING]: Hold action type. Currently possible types: data, launcher, pc, crate, charge, connect]. This will change the icon of the hold action that is linked to the given name.
		_active,														// [STRING]: Condition to show.
		_args,															// [STRING]: Arguments.
		_completeCode,													// [CODE]: Code executed on hold action completion.
		_duration,														// [NUMBER]: Time duration in seconds. The hold action circle filled up depending on this value.
		_remove															// [BOOLEAN]: Remove the action on completion. true = yes / false = no
	] call Exile_Taunus_fnc_AddHoldAction;
	
*/
params [["_object", player], ["_label", "Search"], ["_type", "search"], ["_active", "true"], ["_completeCode", {hint 'Nothing found'}], ["_arguments",[],[[]]], ["_duration", 2], ["_remove", "true"]];

// Change icon based on _type input.
_idleIcon = switch (_type) do {
	case "crate": {"exile_expansion_assets\texture\ui\holdaction\holdAction_crate_ca.paa"};
	case "trashbin": {"exile_expansion_assets\texture\ui\holdaction\holdAction_trashbin_ca.paa"};
	case "toolbox": {"exile_expansion_assets\texture\ui\holdaction\holdAction_toolbox_ca.paa"};
	case "box": {"exile_expansion_assets\texture\ui\holdaction\holdAction_box_ca.paa"};
	case "machine": {"exile_expansion_assets\texture\ui\holdaction\holdAction_machine_ca.paa"};
	case "footlocker": {"exile_expansion_assets\texture\ui\holdaction\holdAction_footlocker_ca.paa"};
	case "barrel": {"exile_expansion_assets\texture\ui\holdaction\holdAction_barrel_ca.paa"};
	case "quest": {"exile_expansion_assets\texture\ui\holdaction\holdAction_quest_ca.paa"};
	case "document": {"exile_expansion_assets\texture\ui\holdaction\holdAction_document_ca.paa"};
	case "multibox": {"exile_expansion_assets\texture\ui\holdaction\holdAction_multibox_ca.paa"};
	case "bag": {"exile_expansion_assets\texture\ui\holdaction\holdAction_bag_ca.paa"};
	case "securitybox": {"exile_expansion_assets\texture\ui\holdaction\holdAction_securitybox_ca.paa"};
	default {"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"};		
};

// Create the hold action with given parameters.
[
/* 0 object */							_object,
/* 1 action title */					_label,
/* 2 idle icon */						_idleIcon,
/* 3 progress icon */					_idleIcon,
/* 4 condition to show */				_active,
/* 5 condition for action */			"true",
/* 6 code executed on start */			{},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		_completeCode,
/* 9 code executed on interruption */	{},
/* 10 arguments */						_arguments,
/* 11 action duration */				_duration,
/* 12 priority */						0,
/* 13 remove on completion */			_remove,
/* 14 show unconscious */				false
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];