/*
    File: ExileWelcomeInfo.sqf
    Written by Salutesh
    www.reality-gaming.eu
    
    Description:
	Displays given toast notifications.
*/

waitUntil{!isNull (findDisplay 46)};  

if ( alive player ) then {
  	sleep 10;
	["WelcomeTitleAndText", [format["Welcome %1", name player],"Welcome to the Exile Expansion community project server by Reality-Gaming.EU"]] call ExileClient_gui_toaster_addTemplateToast; 
	sleep 10;
	["WelcomeTitleAndText", ["Server Feautures", "Our developers are working hard to expand your gameplay experience. For the latest changes visit our forums at <t color='#fbfcfe'>www.reality-gaming.eu</t>"]] call ExileClient_gui_toaster_addTemplateToast;
	sleep 10;
	["WelcomeTitleAndText", ["Server Updates", "We often add updates for extensions or problem fixes. However, this usually sneaks during a server reboot."]] call ExileClient_gui_toaster_addTemplateToast;
	sleep 10;
	["WelcomeTitleAndText", ["Server Infos", "Please take a look into the XM8 Server Info Menu App for the server rules and our support contact informations."]] call ExileClient_gui_toaster_addTemplateToast;
};
