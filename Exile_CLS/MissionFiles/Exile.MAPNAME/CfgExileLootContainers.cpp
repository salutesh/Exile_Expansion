/* 

	These configurations are used for the default container loot system to use different container types for each loot table.
	If you want normal loot spawn uncomment the override of the ExileServer_system_lootManager_spawnLootInBuilding function in the CfgExileCustomCode.cpp in your mission file.
	
*/

class CfgExileLootContainers {
	/* 
		Configuration for the CLS loot spawn system:
	*/
	class ExileLootFromContainer {
		/*
			Max amount of items a container can hold.
		*/
		maximumNumberOfItemsPerLootCrate = 4;
		
		/*
			Object classes configuration.
			Configure container object classes here to let them work with CLS.
		*/
		class Box_T_East_Ammo_F { 
			table = "CivillianLowerClass";
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
	};
	
	/* 
		Default Exile loot spawn expansion configuration:
	*/
	class ExileContainerFromTable {
		/*
			Max amount of items a container can hold.
		*/
		maximumNumberOfItemsPerLootCrate = 4;
		
		/* 
			Table classes for the default exile loot spawn system.
			If you override the ExileServer_system_lootManager_spawnLootInBuilding provided in the server addon, it will use this configurations
			to setup the loot into containers.
		*/
		class CivillianLowerClass { 
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class CivillianUpperClass { 
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class Shop {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Industrial {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Factories {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class VehicleService {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Medical {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Tourist {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Radiation {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Securitybox";
			text = "Search through securirtybox";
		};
		class Military {
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Securitybox";
			text = "Search through military box";
		};
		class Trash
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Trashbin";
			text = "Search through trashbin";
		};
		class Toolbox
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Toolbox";
			text = "Search through toolbox";
		};
		class Mechanic
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Machine";
			text = "Search through machine";
		};
		class Locker
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Footlocker";
			text = "Search through footlocker";
		};
		class Barrel
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Barrel";
			text = "Search through barrel";
		};
		class Multibox
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Multibox";
			text = "Search through multibox";
		};
		class Suitcase
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Suitcase";
			text = "Search through suitcase";
		};
		class Bag
		{
			objects[] = {"Box_T_East_Ammo_F", "Box_Syndicate_Ammo_F", "Box_T_East_Wps_F", "Box_T_NATO_Wps_F", "Box_Syndicate_Wps_F"};
			icon = "Exile_HA_Icon_Bag";
			text = "Search through bag";
		};
	};
};