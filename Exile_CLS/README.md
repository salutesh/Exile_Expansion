![ArmA 1.74](https://img.shields.io/badge/Arma-1.74-blue.svg) ![Exile 1.0.3](https://img.shields.io/badge/Exile-1.0.3-C72651.svg) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)

# General Information:
Please note that this is project is at its development stage and there might be some bugs.
Feel free to give feedback and suggestions to this work.


# Requirements:
Exile Mod 1.0.3: http://www.exilemod.com/downloads/

> ## Installation:
> 
> 1.	Add the CfgExileHoldActions.cpp, CfgDialogs.cpp and CfgExileExtendetLootspawn.cpp and the texture folder to your Exile mission root folder.
> 2.	Merge the content of the provided description.ext with your Exile missions description.ext.
>
> So it looks like this for example:
>
>	  #include "config.cpp"
>	  #include "CfgDialogs.cpp"
>	  #include "CfgExileHoldActions.cpp"
>	  #include "CfgExileExtendetLootspawn.cpp"
>
>
> 3.	Merge the content of the provided CfgRemoteExec.cpp with your Exile missions description.ext CfgRemoteExec class: 
>
> So it looks like this for example:
>
>	  class CfgRemoteExec 
>	  {
>	  	class Functions 
>	  	{
>	  		mode = 2;
>        	jip = 0;
>			class ExileServer_system_network_dispatchIncomingMessage 	{ allowedTargets=2; };
>			class BIS_fnc_holdActionAdd									{ allowedTargets=0; };
>			class BIS_fnc_holdActionRemove								{ allowedTargets=0; };
>    	};
>	  	class Commands
>	  	{
>	  		mode=0;
>	  		jip=0;
>	  	};
>	  };
>
>
> 4.	Merge the content of the provided CfgDialogs.cpp with your Exile missions description.ext RscTitles class if you have already one: 
>
> So it looks like this for example:
>
>	  class RscTitles
>	  {
>	  	class Default 
>	  	{
>	  		idd = -1;
>			fadein = 0;
>			fadeout = 0;
>			duration = 0;
>	  	};
>		// Loot system
>		#include "dialogs\ExileLootUI.hpp"
>	  };
>
> Drop the dialogs folder into your missions root folder.
>
> 5.	(Optional) Merge the content of the provided CfgExileCustomCode.cpp with your Exile missions config.cpp CfgExileCustomCode class.
>
> So it looks like this for example:
>
>	  class CfgExileCustomCode 
>	  {
>		  /*
>			  You can overwrite every single file of our code without touching it.
>			  To do that, add the function name you want to overwrite plus the 
>			  path to your custom file here. If you wonder how this works, have a
>			  look at our bootstrap/fn_preInit.sqf function.
>
>			  Simply add the following scheme here:
>
>			  <Function Name of Exile> = "<New File Name>";
>
>			  Example:
>
>			  ExileClient_util_fusRoDah = "myaddon\myfunction.sqf";
>		  */
>		
>		  ////////////////////////////////////
>		  //	Exile Client Overrides
>		  ///////////////////////////////////
>		  ExileClient_system_lootManager_thread_spawn = "Exile_Client_Overrides\ExileClient_system_lootManager_thread_spawn.sqf";
>	
>		  ////////////////////////////////////
>		  //	Exile Server Overrides
>		  ///////////////////////////////////
>		  ExileServer_system_lootManager_spawnLootInBuilding = "Exile_Server_Overrides\ExileServer_system_lootManager_spawnLootInBuilding.sqf";
>	  };
>
> 6.	Pack the a3_exile_cls directory with your favourite PBO pack tool and place it inside your servers @ExileServer/addons folder.
>

# Licence:
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

# Thanks:
To the awesome Exile Mod Team for there great support in making this project possible!