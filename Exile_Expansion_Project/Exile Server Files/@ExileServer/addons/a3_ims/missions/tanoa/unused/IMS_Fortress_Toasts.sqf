/*
    IMS_raidToasts.sqf
    Written by Salutesh
    www.reality-gaming.eu
	
    Description: Toast notifications for the fortress mission.  
*/

IMS_Fortress_Toast_Dokuments = {
	["InfosTitleAndText", ["Secret Dokuments", "You found a secret dokument that contains mission instructions."]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_Fortress_Toast_ActiveBomb = {
	["ErrorTitleAndText", ["Active Bomb", "This bomb is still active and crosslinked with something."]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_Fortress_Toast_Toilet = {
	["ErrorTitleAndText", ["What the Fu#%?!", "What do you expect to find in a toilete?"]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_Fortress_Toast_Laptop = {
	["SuccessTitleAndText", ["Security Systems", "Security systems disabled.<br/>The central control tower building is unlocked now."]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_Fortress_Toast_BombActivate = {
	["ErrorTitleAndText", ["Bombs Activated", format ["Bomb detornator activated. You have %1 seconds to leafe the area!", IMS_Fortress_Bomb_Timer]]] call ExileClient_gui_toaster_addTemplateToast;
};

IMS_Fortress_Toast_MissionComplete = {
	["SuccessTitleAndText", ["MISSION COMPLETE", "The bandits were successfully stopped. Raid mission completed!"]] call ExileClient_gui_toaster_addTemplateToast;
};

publicVariable "IMS_Fortress_Toast_Dokuments";
publicVariable "IMS_Fortress_Toast_ActiveBomb";
publicVariable "IMS_Fortress_Toast_Toilet";
publicVariable "IMS_Fortress_Toast_Laptop";
publicVariable "IMS_Fortress_Toast_BombActivate";
publicVariable "IMS_Fortress_Toast_MissionComplete";