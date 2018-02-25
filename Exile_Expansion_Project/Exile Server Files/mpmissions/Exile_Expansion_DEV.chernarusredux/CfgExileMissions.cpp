/**
 * CfgExileMissions
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
class CfgExileMissions
{
	class Logging
	{
		missionLogging = 1;
	};
	
	// MISSION CONFIG
	
	class Missions
	{
		class Chernarusredux						// Map name.
		{
			
			activeMissions[] = {"fortress"};			// Active missions classes array for current map. Define mission classes below and add them here if you want them active.
			
			class fortress									// Mission class name
			{
				missionIndex = 0;													// Mission index for the DMS mission, if the mission is the first one that gets loaded by DMS then index is 0.
				missionFile = "fortress";											// Mission init file name. This file gets loaded by ims to get the mission events/scripts. The file always has to be located at "a3_ims\missions\MAPNAME\FILENAME"
				staticObjectsFile[] = {"chernarusredux_fortress_Objects"};			// Array of static objects file names.
				simpleObjectsFile[] = {"chernarusredux_fortress_SimpleObjects"};	// Array of simple objects file names.
				scriptObjectsFile[] = {"chernarusredux_fortress_ScriptObjects"};	// Array of script objects file names.
				loot_class = "IMS_Legendary_Container"; 							// Loot Container class from LootContainers settings (see blow).
				dropvehicle = 1;													// Drop vehicle on mission competion? 0 = no vehicle drop / 1 = vehicle drop.
				vehicle_class = "Exile_Car_Ifrit";									// Vehicle class name for the vehicle loot drop.
			};	
		};
	};
	
	// MISSION LOOT CONFIG
	
	class LootContainers
	{
		class IMS_Rare_Container
		{
			weapons[] = {"srifle_GM6_ghex_F", "srifle_DMR_07_hex_F", "srifle_LRR_tna_F", "SMG_05_F", "arifle_MX_SW_khk_F", "LMG_03_F", "arifle_ARX_ghex_F", "arifle_MXC_khk_F"};
			medicals[] = {"Exile_Item_InstaDoc", "Exile_Item_Bandage"};
			gear[] = {"U_B_FullGhillie_ard", "V_PlateCarrierSpec_mtp"};
			poptabs = 5000;
			icon = "Exile_HA_Icon_RareBox";
			text = "Open Rare Box";
		};
		class IMS_Epic_Container
		{
			weapons[] = {"srifle_GM6_ghex_F", "srifle_DMR_07_hex_F", "srifle_LRR_tna_F", "SMG_05_F", "arifle_MX_SW_khk_F", "LMG_03_F", "arifle_ARX_ghex_F", "arifle_MXC_khk_F"};
			medicals[] = {"Exile_Item_InstaDoc", "Exile_Item_Bandage"};
			gear[] = {"U_B_FullGhillie_ard", "V_PlateCarrierSpec_mtp"};
			poptabs = 5000;
			icon = "Exile_HA_Icon_EpicBox";
			text = "Open Epic Box";
		};
		class IMS_Legendary_Container
		{
			weapons[] = {"srifle_GM6_ghex_F", "srifle_DMR_07_hex_F", "srifle_LRR_tna_F", "SMG_05_F", "arifle_MX_SW_khk_F", "LMG_03_F", "arifle_ARX_ghex_F", "arifle_MXC_khk_F"};
			medicals[] = {"Exile_Item_InstaDoc", "Exile_Item_Bandage"};
			gear[] = {"U_B_FullGhillie_ard", "V_PlateCarrierSpec_mtp"};
			poptabs = 5000;
			icon = "Exile_HA_Icon_LegendaryBox";
			text = "Open Legendary Box";
		};
	};
};