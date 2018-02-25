/*
    Master UI Resource File
*/

// Base Defines
#include "dialogs\baseDefines.hpp"
#include "VCOMAI\defines.hpp"
#include "VCOMAI\DialogDefines.hpp"
#include "VCOMAI\dialogs.hpp"

// ScarCode Stuff
#include "scarCODE\restartWarnings\config.cpp"
#include "scarCODE\ServerInfoMenu\hpp\CfgServerInfoMenu.hpp"
#include "scarCODE\ServerInfoMenu\hpp\RscDisplayServerInfoMenu.hpp"

class RscTitles
{	
	class Default
	{
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};
	// Restart Warnings
	#include "scarCODE\restartWarnings\hpp\RscDisplayRestartWarnings.hpp"
	// Loot system
	#include "dialogs\ExileLootUI.hpp"
};