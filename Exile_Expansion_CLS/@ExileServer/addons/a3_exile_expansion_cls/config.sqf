/*
	CLS Config File
	Written by Salutesh
	www.reality-gaming.eu
*/
	
/* --- Interactive Loot System Settings --- */
	
	/* Enable Debug markers on the map */
	DEBUG = true;

	/* --- Container Class Settings --- */
	/* Add container object class-names here to let them work with the interactive loot system */
	
	// PLP Containers - Trashbin object classes
	TrashBinObjectClasses = ["plp_ct_TrashBinBigBlack", "plp_ct_TrashBinBigBlue", "plp_ct_TrashBinBigGreen", "plp_ct_TrashContGreyBig", "plp_ct_TrashContColGeneric" , "plp_ct_TrashContColGlass", "plp_ct_TrashContColPaper", "plp_ct_TrashContColPlastics", "plp_ct_TrashContColGenericOpen", "plp_ct_PlasticTrashcanBlack", "plp_ct_PlasticTrashcanBlue", "plp_ct_PlasticTrashcanRed", "plp_ct_PlasticTrashcanWhite", "plp_ct_TrashContGreyMediumOpenTrash", "plp_ct_TrashContGreySmallOpenTrash", "plp_ct_TrashCanCityPark", "plp_ct_TrashcanCityPlasticGreen", "plp_ct_TrashcanCityPlasticGreen", "plp_ct_TrashcanHouseBathroom", "plp_ct_TrashcanHouseGeneric", "plp_ct_TrashcanHouseGenericOpen", "plp_ct_TrashcanHouseSmall", "plp_ct_TrashcanIndPurple", "plp_ct_TrashcanIndRed", "plp_ct_RecycleBinBlack", "plp_ct_RecycleBinBlackOpenTrash", "plp_ct_RecycleBinBlue", "plp_ct_RecycleBinBlueOpenTrash", "plp_ct_RecycleBinGreen", "plp_ct_RecycleBinGreenOpenTrash", "plp_ct_RecycleBinYellow", "plp_ct_RecycleBinYellowOpenTrash"];
	// PLS Containers - Carton object classes
	CartonObjectClasses = ["plp_ct_CartonLightBig", "plp_ct_CartonDarkBig", "plp_ct_CartonRottenBig", "plp_ct_CartonDarkMedium", "plp_ct_CartonLightMedium", "plp_ct_CartonRottenMedium", "plp_ct_CartonDarkSmall", "plp_ct_CartonLightSmall", "plp_ct_CartonRottenSmall", "plp_ct_CartonDarkFlat", "plp_ct_CartonLightFlat", "plp_ct_CartonRottenFlat"];
	// PLS Containers - Toolbox object classes
	ToolboxObjectClasses = ["plp_ct_ToolboxBlackClean", "plp_ct_ToolboxBlackDirty", "plp_ct_ToolboxRedClean", "plp_ct_ToolboxRedDirty"];
	// PLS Containers - Box object classes
	BoxObjectClasses = ["plp_ct_WeathCrateBigBrown", "plp_ct_WeathCrateBigWorn", "plp_ct_WeathCrateLongBrown", "plp_ct_WeathCrateLongGreen", "plp_ct_WeathCrateLongWorn", "plp_ct_WeathCrateMediumBrown", "plp_ct_WeathCrateMediumGreen", "plp_ct_WeathCrateMediumWorn", "plp_ct_WeathCrateSmallBrown", "plp_ct_WeathCrateSmallGreen" , "plp_ct_WeathCrateSmallWorn", "plp_ct_WoodBoxLightHuge", "plp_ct_WoodBoxLightBig", "plp_ct_WoodBoxLightMedium", "plp_ct_WoodBoxLightLong", "plp_ct_WoodBoxLightSmall", "plp_ct_WoodBoxLightTiny", "plp_ct_PlasticBoxBlack", "plp_ct_PlasticBoxBlue", "plp_ct_PlasticBoxGrey", "plp_ct_PlasticBoxRed"];
	// PLS Containers - Vending Machine object classes
	VendingMachineObjectClasses = ["plp_ct_VMachineSnacksBeigeOff", "plp_ct_VMachineSnacksBeigeOn", "plp_ct_VMachineSnacksBlackOff", "plp_ct_VMachineSnacksBlackOn"];
	// PLS Containers - Locker object classes
	FootlockerObjectClasses = ["plp_ct_CasketLeatherBlack", "plp_ct_CasketLeatherBrown", "plp_ct_CasketLeatherGreen", "plp_ct_CasketLeatherRed", "plp_ct_FootlockerBrown", "plp_ct_FootlockerGreen", "plp_ct_FootlockerRed", "plp_ct_FootlockerYellow"];
	// PLS Containers - Barrel object classes
	BarrelObjectClasses 	= ["plp_ct_WoodBarrelDark", "plp_ct_WoodBarrelLight"];
	// PLS Containers - Bag object classes
	BagObjectsClasses = ["plp_ct_SuitcaseBigBlack", "plp_ct_SuitcaseBigBlue", "plp_ct_SuitcaseBigGreen", "plp_ct_SuitcaseBigGrey", "plp_ct_SuitcaseBigRed", "plp_ct_TravelBagBlue"];
	// PLS Containers - Suitcase object classes
	SuitcaseObjectsClasses = ["plp_ct_SuitcaseMetalSilverSide", "plp_ct_SuitcaseMetalBlackSide", "SuitcaseFabricRedSide", "SuitcaseFabricGreenSide", "SuitcaseFabricBrownSide", "SuitcaseFabricBlackSide", "plp_ct_SuitcaseFabricBeigeSide"];
	// PLS Containers - Multibox object classes
	MultiboxObjectsClasses = ["plp_ct_MultiboxColOlive", "plp_ct_MultiboxColOrange", "plp_ct_MultiboxColTan", "plp_ct_MultiboxUtilOlive", "plp_ct_MultiboxUtilOrange", "plp_ct_MultiboxUtilTan"];
	// PLS Containers - Securityboxes object classes
	SecurityboxesObjectsClasses = ["plp_ct_HighSecContBlack","plp_ct_HighSecContBlue", "plp_ct_HighSecContGrey", "plp_ct_HighSecContRed", "plp_ct_HighSecContWhite", "plp_ct_HighSecBigBlack", "plp_ct_HighSecBigBlue", "plp_ct_HighSecBigGrey", "plp_ct_HighSecBigRed", "plp_ct_HighSecBigWhite", "plp_ct_HighSecMediumBlack", "plp_ct_HighSecMediumBlue", "plp_ct_HighSecMediumGrey", "plp_ct_HighSecMediumRed", "plp_ct_HighSecMediumWhite", "plp_ct_HighSecSmallBlack", "plp_ct_HighSecSmallBlue", "plp_ct_HighSecSmallGrey", "plp_ct_HighSecSmallRed", "plp_ct_HighSecSmallWhite"];
	// PLS Containers - Weaponcrates object classes
	WeaponcrateObjectsClasses = ["plp_ct_MilBoxBigBlack", "plp_ct_MilBoxBigOlive", "plp_ct_MilBoxLongBlack", "plp_ct_MilBoxLongOlive", "plp_ct_MilBoxMediumBlack", "plp_ct_MilBoxMediumOlive"];
	CursorObjectClasses = ["Land_Kontejner"];
	
	/* --- Container Loottable Settings --- */
	/* You can add different loot table/s to any type of the upper object classes */
	
	TrashBinObjectLootTables 			= ["Trashbin"];
	CartonObjectLootTables 				= ["Carton"];
	ToolboxObjectLootTables				= ["Toolbox"];
	BoxObjectLootTables 				= ["Box"];
	VendingMachineObjectLootTables		= ["VendingMachine"];
	FootlockerObjectLootTables			= ["Footlocker"];
	BarrelObjectLootTables 				= ["Barrel"];
	BagObjectLootTables 				= ["Bag"];
	SuitcaseObjectLootTables 			= ["Suitcase"];
	MultiboxObjectLootTables 			= ["Multibox"];
	SecurityboxesLootTables 			= ["Securitybox"];
	WeaponcrateLootTables 				= ["Weaponcrate"];