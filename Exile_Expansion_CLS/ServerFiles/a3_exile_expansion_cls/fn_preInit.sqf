/*
	Exile Expansion CLS Server Addon Pre-init File
	Written by Salutesh
	www.reality-gaming.eu
*/

#define CALLFILE(FILE) call compile preprocessFileLineNumbers FILE;

// DEBUGING
Exile_Expansion_DEBUG = true;
// Get exile expansion addon version
Exile_Expansion_Version = getText (configFile >> "CfgPatches" >> "exile_expansion" >> "exile_expansion_version");