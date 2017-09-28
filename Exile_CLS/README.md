![ArmA 1.74](https://img.shields.io/badge/Arma-1.74-blue.svg) ![Exile 1.0.3](https://img.shields.io/badge/Exile-1.0.3-C72651.svg) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)

# General Information:
Please note that this is project is at its development stage and there might be some bugs.
Feel free to give feedback and suggestions to this work.


# Requirements:
Exile Mod 1.0.3: http://www.exilemod.com/downloads/

> ## Installation:
> 
> 1.	Add the CfgExileHoldActions.cpp and the CfgExileLootContainers.cpp and the texture folder to your Exile mission root folder.
> 2.	Merge the content of the provided description.ext with your Exile missions description.ext.
>
> So it looks like this for example:
>
>	  #include "config.cpp"
>	  #include "CfgExileLootContainers.cpp"
>	  #include "CfgExileHoldActions.cpp"
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
>		  // Exile default container lootdrop changes
>		  ExileServer_system_lootManager_spawnLootInBuilding = "\a3_exile_expansion_cls\Exile_Server_Overrides\ExileServer_system_lootManager_spawnLootInBuilding.sqf";
>	  };
>
> 6.	Pack the a3_exile_cls directory with your favourite PBO pack tool and place it inside your servers @ExileServer/addons folder.
>


> ## How to use CLS:
> 
> To let CLS spawn container objects we have to place them on our map where we want to have them later on the server in the Eden Editor.
> For this we use the Exile Eden Plugin (http://www.exilemod.com/download-all-the-files/Exile3DEN-1.0.0.zip) and add the arrays of the objects after the placement from the plugin into the CLS server addon file:
> a3_exile_cls\code\objects\CrateObjects.sqf
> There is a example code for the Tanoa map in there already, just place the object arrays in there not the complet code from the plugin!
>


> ## CLS Configuration:
> 
> To let a container object work with CLS we need to add some informations about the object into the CfgExileLootContainers.cpp.
> Inside the file there is a class called ExileLootFromContainer.
> We need to add our objects as a new class inside the ExileLootFromContainer class:
>
>	  class plp_ct_CartonDarkMedium {    	// [STRING] The class has to be the container object classname.
>	  	table = "CivillianLowerClass";		// [STRING] Table is the exile Loot Table name used for the object.	
>		icon = "Exile_HA_Icon_Crate";		// [STRING] Icon is the hold action classname used for the object you can take a look into the CfgExileHoldActions for all configured hold action classnames.
>		text = "Search through crate";		// [STRING] Text for the hold action used for the object.
>	  };
>

# Licence:
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

# Thanks:
To the awesome Exile Mod Team for there great support in making this project possible!