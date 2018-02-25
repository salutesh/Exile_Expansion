/*
© 2015 Zenix Gaming Ops
Developed by Rod-Serling and Vishpala

All rights reserved.

Function:
	config - Defines the configuration for AVS.
*/

#define _ARMA_

class CfgPatches
{
	class AVS
	{
		units[] = {};
		weapons[] = {};
		AVS_Version = "1.4.4";
	};
};

class CfgFunctions
{
	class AVS
	{
		class Bootstrap
		{
			file = "AVS\bootstrap";
			class preInit
			{
				preInit = 1;
			};
		};

		class compiles
		{
			file = "AVS\code";
			class fillCanister					{};
			class getBlacklistedAmmo			{};
			class getBlacklistedWeapons			{};
			class loadAmmo						{};
			class loadVGAmmo					{};
			class rearmVehicle					{};
			class refuelPayment					{};
			class refuelVehicle					{};
			class sanitizeVehicle				{};
			class saveAmmo						{};
			class spawnAllVehicles				{};
			class spawnPersistentVehicle		{};
		};
	};
};
