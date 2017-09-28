/* 

	These configurations are used for the default container loot system to use different container types for each loot table.
	If you want normal loot spawn uncomment the override of the ExileServer_system_lootManager_spawnLootInBuilding function in the CfgExileCustomCode.cpp in your mission file.
	
*/

class CfgExileLootContainers {
	/* 
		Configuration for the CLS loot spawn system:
	*/
	class ExileLootFromContainer {
		
		maximumNumberOfItemsPerLootCrate = 4;	// Max amount of items a container can hold.
		containerChance = 50;					// Chance to spawn loot into container object instead of normal weaponholder. Default is a 50/50 Chance. Increase this value to expand the chance to spawn a loot crate and backwards.
		
		/*
			Object classes configuration.
			Configure container object classes here to let them work with CLS.
		*/
		class plp_ct_CartonDarkMedium { 
			table = "CivillianLowerClass";
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class plp_ct_CartonLightMedium { 
			table = "CivillianLowerClass";
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class plp_ct_CartonRottenMedium { 
			table = "CivillianLowerClass";
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class plp_ct_CartonDarkSmall { 
			table = "CivillianLowerClass";
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class plp_ct_CartonLightSmall { 
			table = "CivillianLowerClass";
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class plp_ct_CartonRottenSmall { 
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
			objects[] = {"plp_ct_CartonDarkMedium", "plp_ct_CartonLightMedium", "plp_ct_CartonRottenMedium", "plp_ct_CartonDarkSmall", "plp_ct_CartonLightSmall", "plp_ct_CartonRottenSmall"};
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class CivillianUpperClass { 
			objects[] = {"plp_ct_CartonDarkMedium", "plp_ct_CartonLightMedium", "plp_ct_CartonRottenMedium", "plp_ct_CartonDarkSmall", "plp_ct_CartonLightSmall", "plp_ct_CartonRottenSmall"};
			icon = "Exile_HA_Icon_Crate";
			text = "Search through crate";
		};
		class Shop {
			objects[] = {"plp_ct_WeathCrateMediumBrown", "plp_ct_WeathCrateMediumGreen", "plp_ct_WeathCrateMediumWorn", "plp_ct_WeathCrateSmallBrown", "plp_ct_WeathCrateSmallGreen", "plp_ct_WeathCrateSmallWorn", "plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue","plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Industrial {
			objects[] = {"plp_ct_WeathCrateMediumBrown", "plp_ct_WeathCrateMediumGreen", "plp_ct_WeathCrateMediumWorn", "plp_ct_WeathCrateSmallBrown", "plp_ct_WeathCrateSmallGreen", "plp_ct_WeathCrateSmallWorn", "plp_ct_WoodBoxLightMedium", "plp_ct_WoodBoxLightSmall", "plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue", "plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Factories {
			objects[] = {"plp_ct_WeathCrateMediumBrown", "plp_ct_WeathCrateMediumGreen", "plp_ct_WeathCrateMediumWorn", "plp_ct_WeathCrateSmallBrown", "plp_ct_WeathCrateSmallGreen", "plp_ct_WeathCrateSmallWorn", "plp_ct_WoodBoxLightMedium", "plp_ct_WoodBoxLightSmall", "plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue", "plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class VehicleService {
			objects[] = {"plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue", "plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Medical {
			objects[] = {"plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue", "plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed", "Land_FirstAidKit_01_closed_F"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Tourist {
			objects[] = {"plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue", "plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed"};
			icon = "Exile_HA_Icon_Box";
			text = "Search through box";
		};
		class Radiation {
			objects[] = {"plp_ct_HighSecMediumBlack", "plp_ct_HighSecMediumBlue", "plp_ct_HighSecMediumGrey", "plp_ct_HighSecMediumRed", "plp_ct_HighSecMediumWhite", "plp_ct_HighSecSmallBlack", "plp_ct_HighSecSmallBlue", "plp_ct_HighSecSmallGrey", "plp_ct_HighSecSmallRed","plp_ct_HighSecSmallWhite"};
			icon = "Exile_HA_Icon_Securitybox";
			text = "Search through securirtybox";
		};
		class Military {
			objects[] = {"plp_ct_MilBoxBigBlack", "plp_ct_MilBoxBigOlive", "plp_ct_MilBoxLongBlack", "plp_ct_MilBoxLongOlive", "plp_ct_MilBoxMediumBlack", "plp_ct_MilBoxMediumOlive"};
			icon = "Exile_HA_Icon_Securitybox";
			text = "Search through military box";
		};
		class Trash
		{
			objects[] = {"plp_ct_PlasticTrashcanBlack", "plp_ct_PlasticTrashcanBlue", "plp_ct_PlasticTrashcanRed", "plp_ct_PlasticTrashcanWhite", "plp_ct_TrashcanHouseSmall", "plp_ct_TrashcanHouseGenericOpen", "plp_ct_TrashcanHouseGeneric", "plp_ct_TrashcanHouseBathroom"};
			icon = "Exile_HA_Icon_Trashbin";
			text = "Search through trashbin";
		};
		class Toolbox
		{
			objects[] = {"plp_ct_ToolboxRedDirty", "plp_ct_ToolboxBlackClean", "plp_ct_ToolboxRedClean", "plp_ct_ToolboxBlackDirty"};
			icon = "Exile_HA_Icon_Toolbox";
			text = "Search through toolbox";
		};
		class Mechanic
		{
			objects[] = {"plp_ct_VMachineSnacksBlackOn", "plp_ct_VMachineSnacksBlackOff", "plp_ct_VMachineSnacksBeigeOn", "plp_ct_VMachineSnacksBeigeOff", "plp_ct_VMachineDrinksBlackOn", "plp_ct_VMachineDrinksBeigeOn", "plp_ct_VMachineDrinksBeigeOff", "plp_ct_VMachineCoffeeBlackOn", "plp_ct_VMachineCoffeeBlackOff"};
			icon = "Exile_HA_Icon_Machine";
			text = "Search through machine";
		};
		class Locker
		{
			objects[] = {"plp_ct_FootlockerYellow", "plp_ct_FootlockerRed", "plp_ct_FootlockerGreen", "plp_ct_FootlockerBrown", "plp_ct_CasketLeatherRed", "plp_ct_CasketLeatherGreen", "plp_ct_CasketLeatherBrown", "plp_ct_CasketLeatherBlack"};
			icon = "Exile_HA_Icon_Footlocker";
			text = "Search through footlocker";
		};
		class Barrel
		{
			objects[] = {"plp_ct_WoodBarrelDark", "plp_ct_WoodBarrelLight", "plp_ctf_BarrelOlive", "plp_ctf_BarrelBlue", "plp_ctf_BarrelBlack", "plp_ctf_BarrelTan", "plp_ctf_BarrelYellow", "plp_ctf_BarrelRusty"};
			icon = "Exile_HA_Icon_Barrel";
			text = "Search through barrel";
		};
		class Multibox
		{
			objects[] = {"plp_ct_MultiboxUtilOlive", "plp_ct_MultiboxUtilOrange", "plp_ct_MultiboxUtilTan"};
			icon = "Exile_HA_Icon_Multibox";
			text = "Search through multibox";
		};
		class Suitcase
		{
			objects[] = {"plp_ct_SuitcaseFabricBeigeSide", "SuitcaseFabricBlackSide", "SuitcaseFabricBrownSide", "SuitcaseFabricGreenSide", "SuitcaseFabricRedSide", "plp_ct_SuitcaseMetalBlackSide", "plp_ct_SuitcaseMetalSilverSide"};
			icon = "Exile_HA_Icon_Suitcase";
			text = "Search through suitcase";
		};
		class Bag
		{
			objects[] = {"plp_ct_TravelBagBlue", "plp_ct_SuitcaseBigRed", "plp_ct_SuitcaseBigGrey", "plp_ct_SuitcaseBigGreen", "plp_ct_SuitcaseBigBlue", "plp_ct_SuitcaseBigBlack"};
			icon = "Exile_HA_Icon_Bag";
			text = "Search through bag";
		};
	};
};