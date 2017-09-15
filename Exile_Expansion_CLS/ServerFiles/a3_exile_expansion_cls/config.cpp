/*
	Exile Expansion CLS Server Addon Configuration
	Written by Salutesh
	www.reality-gaming.eu
*/

class CfgPatches
{
	class a3_exile_expansion_cls
	{
		units[] = {};
		weapons[] = {};
		exile_expansion_version = "September 15, 2017";
		requiredVersion = 1.66;
		requiredAddons[] = {"exile_client","exile_server_config"};
	};
};

class CfgFunctions
{
	class Expansion
	{	
		tag = "Exile_Expansion_CLS";
		class Master
		{
			file = "a3_exile_expansion_cls";
			class preInit 									{preInit = 1;};
			class postInit 									{postInit = 1;};
		};
		class Functions
		{
			file = "a3_exile_expansion_server\functions";
			class AddHoldAction									{};
			class ImportInteractionCrates						{};
		};
	};
};
