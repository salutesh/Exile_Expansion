/*
    IMS_raidToasts.sqf
    Written by Salutesh
    www.reality-gaming.eu
	
    Description: Toast notifications for the fortress mission.  
*/

IMS_AE_Toast_1 = {
	["QuestTitleAndText", ["[Quest] Secret Plans", "You have recived a quest objective from the strager. Open your map and take a look into the task menu!"]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_AE_Toast_2 = {
	["QuestTitleAndText", ["[Quest] Secret Plans", "You have picked up the dokuments. Go and take them back to the Stranger!"]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_AE_Toast_3 = {
	["QuestTitleAndText", ["[Quest] Secret Plans", "Quest completed!"]] call ExileClient_gui_toaster_addTemplateToast;
};

publicVariable "IMS_AE_Toast_1";
publicVariable "IMS_AE_Toast_2";
publicVariable "IMS_AE_Toast_3";