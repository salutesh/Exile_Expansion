/*
	CLS Server Addon Configuration
	Written by Salutesh
	www.reality-gaming.eu
*/

class CfgPatches
{
	class a3_exile_expansion_cls
	{
		units[] = {};
		weapons[] = {};
		exile_expansion_cls_version = "Mai 13, 2017";
		requiredVersion = 1.68;
		requiredAddons[] = {"exile_server_config"};
	};
};

class CfgFunctions
{
	class CLS
	{	
		tag = "CLS";
		class Master
		{
			file = "a3_exile_expansion_cls";
			class preInit 									{preInit = 1;};
			class postInit 									{postInit = 1;};
		};
		class Functions
		{
			file = "a3_exile_expansion_cls\functions";
			class AddHoldAction 								{};
			class DebugLog										{};
			class ImportFromInteractionLootCrates				{};
			class ImportFromXCamInteractionLootCrates			{};
		};
	};
};
