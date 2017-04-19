![ArmA 1.68](https://img.shields.io/badge/Arma-1.68-blue.svg) ![Exile 1.0.2 Kohlrabi](https://img.shields.io/badge/Exile-1.0.2%20Kohlrabi-C72651.svg) ![Exile Expansion Version](https://img.shields.io/badge/Exile%20Expansion-0.86%20Alpha-orange.svg) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)

# General Information:
#### Please feel free to give feedback and suggestions to this work.

# What is Exile Expansion CLS:
The Exile Expansion Container Loot-System or CLS is a new and additional way to create static loot spawns on your server.
This gives server owners the possibility to create special loot areas with a kind of new feeling.

# Requirements:
Exile Mod 1.0.2: 
http://www.exilemod.com/downloads/

Exile Expansion Mod:
http://steamcommunity.com/sharedfiles/filedetails/?id=832000537

PLP Containers:
http://steamcommunity.com/sharedfiles/filedetails/?id=504690333&searchtext=PLP+Containers

PLP Containers is a gread mod by Poolpank and this Addon will add dozens of Containers, both in static and useable Versions.
See a list of the available assets in the classnames.xls , that should be included in the mod.
The mod is used for the default and the interactive container loot systems within the Exile Expansion Mod.

# Configuration:
Take a look into the Exile_Expansion_CLS\@ExileServer\addons\a3_exile_expansion_cls\config.sqf file for configuration options.

# Installation:

1.) Place the containers:

Use the Exile Eden Plugin within the Eden Editor to make your life easy: http://www.exilemod.com/download-all-the-files/Exile3DEN-1.0.0.zip

All what you have to do is to place the static plp containers in the Eden Editor where you want them and get the arrays from the Exile Eden Plugin within the Editor from the initServer.sqf export.
For example, the code of an object array looks like this:
```
	[
		"plp_ct_TrashContColGeneric",			STRING: Classname of container object.
		[18249.7, 19737.9, 400.402],			ARRAY: Position of the container object.
		[0.628189, 0.778061, 0],				ARRAY: Vector direction of the container object.
		[0, 0, 1], 								ARRAY: Vector Up of the container object.
		true									BOOLEAN: Simulation enabled false/true.
	]
```

2.) Export the Objects:

Locate the file or create one in Exile_Expansion_CLS\@ExileServer\addons\a3_exile_expansion_cls\code\CLS_LootCrates_YOUR_MAP_NAME_OR_WHAT_EVER.sqf.
Open that file and put your container object arrays into this file like this:
```
[
	["plp_ct_TrashContColGeneric", [11723.6, 2998.87, 5.48856], [-0.79136, 0.61135, 0], [0, 0, 1], true],
	["plp_ct_FootlockerRed", [11740.3, 2989.05, 5.11904], [0.794187, -0.607673, -0.000419619], [0, -0.000690534, 1], true],
	["plp_ct_RecycleBinGreenOpenTrash", [11724.9, 2999.94, 5.60208], [0.478139, -0.878284, 0], [0, 0, 1], true]
]
```
Always remember! No comma on the last line or it will not work!
Save that file!

3.) Prepare the server addon:

Go to Exile_Expansion\Exile_Expansion_CLS\@ExileServer\addons\a3_exile_expansion_cls and open up the fn_postInit.sqf.
Add the name of your created object file to the fn_postInit.sqf, for example on a Server with the Tanoa Map:
```
/*
	CLS Addon Post-Init File
	Written by Salutesh
	www.reality-gaming.eu
*/

#define CALLFILE(FILE) call compileFinal preprocessFileLineNumbers FILE;
private ["_timeStamp"];
_timeStamp = diag_tickTime;

diag_log "----------------------------------------------------------------------------------------------------";
diag_log "------------------------------- Starting CLS Server Addon Post-Init --------------------------------";
diag_log "------------------------------------------ Version 1.0 ---------------------------------------------";
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format['[CLS Server Addon] Loading CLS server files..'];

if (worldName == 'Altis') then {};

if (worldName == 'Stratis') then {};

if (worldName == 'Chernarus') then {};

if (worldName == 'Tanoa') then
{
	["CLS_LootCrates_YOUR_MAP_NAME_OR_WHAT_EVER"] call CLS_fnc_ImportFromInteractionLootCrates;
};

if (worldName == 'Napf') then {};

if (worldName == 'xcam_taunus') then {};

diag_log format['[CLS Server Addon] Server files loaded!'];
diag_log "----------------------------------------------------------------------------------------------------";
diag_log format["End of CLS Server Addon Post-Init :: Total Execution Time %1 seconds",(diag_tickTime) - _timeStamp];
diag_log "----------------------------------------------------------------------------------------------------";
```
Save the file!

After that you can pack the Exile_Expansion\Exile_Expansion_CLS\@ExileServer\addons\a3_exile_expansion_cls directory
with your favorite PBO Manager and place the pbo on your servers @ExileServer/addons directory.

Run the Server and enjoy the new loot system! :)


# Licence:
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

# Thanks:
To the awesome Exile Mod Team for there great support in making this project possible!