/*
	IMS Server Addon Configuration
	Written by Salutesh
	www.reality-gaming.eu
*/

class CfgPatches
{
	class a3_ims
	{
		units[] = {};
		weapons[] = {};
		a3_IMS_version = "August 13, 2017";
		requiredVersion = 1.68;
		requiredAddons[] = {"exile_client","exile_server_config","a3_dms"};
	};
};

class CfgFunctions
{
	class IMS
	{	
		tag = "IMS";
		class Master
		{
			file = "a3_ims";
			class IMS_postInit 									{postInit = 1;};
		};
		class Functions
		{
			file = "a3_ims\functions";
			class DebugLog										{};
			class HideTerrainObject								{};
			class ImportFromExileEdenPlugin 					{};
			class ImportFromExileEdenPluginSimple 				{};
			class ImportFromExileEdenPluginScripted				{};
			class LootDrop 										{};
			class LeafletsBomb									{};
			class SpawnNonPersistentVehicle						{};
			class SpawnPersistentVehicle						{};
		};
	};
};
