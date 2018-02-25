class CfgExileCustomCode 
{
	/*
		You can overwrite every single file of our code without touching it.
		To do that, add the function name you want to overwrite plus the 
		path to your custom file here. If you wonder how this works, have a
		look at our bootstrap/fn_preInit.sqf function.

		Simply add the following scheme here:

		<Function Name of Exile> = "<New File Name>";

		Example:

		ExileClient_util_fusRoDah = "myaddon\myfunction.sqf";
	*/

	// Player init changes / search loot changes
	ExileClient_object_player_initialize = "core\overrides\ExileClient_object_player_initialize.sqf";
	
	// Chernarus Redux Lootspawn fix
	ExileClient_system_lootManager_thread_spawn = "core\overrides\ExileClient_system_lootManager_thread_spawn.sqf";
	
	// Bambi state file changes
	ExileClient_object_player_bambiStateBegin = "core\overrides\ExileClient_object_player_bambiStateBegin.sqf";
	
	// Custom respect level changes
	ExileClient_gui_itemDetails_show = "core\overrides\ExileClient_gui_itemDetails_show.sqf";
	ExileClient_gui_traderDialog_updateInventoryListBox = "core\overrides\ExileClient_gui_traderDialog_updateInventoryListBox.sqf";
	ExileClient_gui_traderDialog_updateStoreListBox = "core\overrides\ExileClient_gui_traderDialog_updateStoreListBox.sqf";
	ExileClient_gui_inventory_updateItemColors = "core\overrides\ExileClient_gui_inventory_updateItemColors.sqf";
	ExileClient_gui_vehicleTraderDialog_updateVehicleListBox = "core\overrides\ExileClient_gui_vehicleTraderDialog_updateVehicleListBox.sqf";
	
	// Toast display fadeout change
	ExileClient_gui_toaster_addToast = "core\overrides\ExileClient_gui_toaster_addToast.sqf";
	
	// ExAd XM8
	ExileClient_gui_xm8_slide = "ExAdClient\XM8\CustomCode\ExileClient_gui_xm8_slide.sqf";
	ExileClient_gui_xm8_show = "ExAdClient\XM8\CustomCode\ExileClient_gui_xm8_show.sqf"; 
	
	// Custom Damage Event Handler
	ExileClient_object_player_event_onHandleDamage = "core\overrides\ExileClient_object_player_event_onHandleDamage.sqf";
	
	// ExAd Virtual Garage System
	ExileServer_system_territory_database_load = "ExAdClient\VirtualGarage\CustomCode\ExileServer_system_territory_database_load.sqf";  
	
	// Exile default container lootdrop changes
	ExileServer_system_lootManager_spawnLootInBuilding = "\exile_expansion_server\overrides\ExileServer_system_lootManager_spawnLootInBuilding.sqf";
	
	// Airdrop event changes
	ExileServer_system_event_supplyBox_start = "\exile_expansion_server\overrides\ExileServer_system_event_supplyBox_start.sqf";

	// Vehicle Weapon fix
	ExileServer_object_vehicle_carefulCreateVehicle = "\exile_expansion_server\overrides\ExileServer_object_vehicle_carefulCreateVehicle.sqf";
	
	// ExtDB3 changes
	ExileServer_system_database_connect = "\exile_expansion_server\overrides\ExileServer_system_database_connect.sqf";
	ExileServer_system_process_noobFilter = "\exile_expansion_server\overrides\ExileServer_system_process_noobFilter.sqf";
	ExileServer_world_initialize = "\exile_expansion_server\overrides\ExileServer_world_initialize.sqf";
	ExileServer_util_time_uptime = "\exile_expansion_server\overrides\ExileServer_util_time_uptime.sqf";
	ExileServer_util_time_currentTime = "\exile_expansion_server\overrides\ExileServer_util_time_currentTime.sqf";
	ExileServer_util_time_addTime = "\exile_expansion_server\overrides\ExileServer_util_time_addTime.sqf";
	ExileServer_system_trading_network_wasteDumpRequest = "\exile_expansion_server\overrides\ExileServer_system_trading_network_wasteDumpRequest.sqf";
	ExileServer_system_trading_network_sellItemRequest = "\exile_expansion_server\overrides\ExileServer_system_trading_network_sellItemRequest.sqf";
	ExileServer_system_trading_network_purchaseVehicleSkinRequest = "\exile_expansion_server\overrides\ExileServer_system_trading_network_purchaseVehicleSkinRequest.sqf";
	ExileServer_system_trading_network_purchaseVehicleRequest = "\exile_expansion_server\overrides\ExileServer_system_trading_network_purchaseVehicleRequest.sqf";									// Custom vehicle purchase and spawn changes
	ExileServer_system_trading_network_purchaseItemRequest = "\exile_expansion_server\overrides\ExileServer_system_trading_network_purchaseItemRequest.sqf";
	ExileServer_system_territory_network_territoryUpgradeRequest = "\exile_expansion_server\overrides\ExileServer_system_territory_network_territoryUpgradeRequest.sqf";
	ExileServer_system_territory_network_restoreFlagRequest = "\exile_expansion_server\overrides\ExileServer_system_territory_network_restoreFlagRequest.sqf";
	ExileServer_system_territory_network_purchaseTerritory = "\exile_expansion_server\overrides\ExileServer_system_territory_network_purchaseTerritory.sqf";
	ExileServer_system_territory_network_payTerritoryProtectionMoneyRequest = "\exile_expansion_server\overrides\ExileServer_system_territory_network_payTerritoryProtectionMoneyRequest.sqf";
	ExileServer_system_territory_network_payFlagRansomRequest = "\exile_expansion_server\overrides\ExileServer_system_territory_network_payFlagRansomRequest.sqf";
	ExileServer_system_territory_network_flagStolenRequest = "\exile_expansion_server\overrides\ExileServer_system_territory_network_flagStolenRequest.sqf";
	ExileServer_system_territory_maintenance_recalculateDueDate = "\exile_expansion_server\overrides\ExileServer_system_territory_maintenance_recalculateDueDate.sqf";
	ExileServer_system_territory_database_insert = "\exile_expansion_server\overrides\ExileServer_system_territory_database_insert.sqf";
	ExileServer_system_database_query_selectSingleField = "\exile_expansion_server\overrides\ExileServer_system_database_query_selectSingleField.sqf";
	ExileServer_system_database_query_selectSingle = "\exile_expansion_server\overrides\ExileServer_system_database_query_selectSingle.sqf";
	ExileServer_system_database_query_selectFull = "\exile_expansion_server\overrides\ExileServer_system_database_query_selectFull.sqf";
	ExileServer_system_database_query_insertSingle = "\exile_expansion_server\overrides\ExileServer_system_database_query_insertSingle.sqf";
	ExileServer_system_database_query_fireAndForget = "\exile_expansion_server\overrides\ExileServer_system_database_query_fireAndForget.sqf";
	ExileServer_system_database_handleBig = "\exile_expansion_server\overrides\ExileServer_system_database_handleBig.sqf";
	ExileServer_object_vehicle_database_load = "\exile_expansion_server\overrides\ExileServer_object_vehicle_database_load.sqf";
	//ExileServer_object_vehicle_database_update = "\exile_expansion_server\overrides\ExileServer_object_vehicle_database_update.sqf";
	//ExileServer_object_vehicle_createPersistentVehicle = "\exile_expansion_server\overrides\ExileServer_object_vehicle_createPersistentVehicle.sqf";
	//ExileServer_object_vehicle_createNonPersistentVehicle = "\exile_expansion_server\overrides\ExileServer_object_vehicle_createNonPersistentVehicle.sqf";
	ExileServer_object_player_event_onMpKilled = "\exile_expansion_server\overrides\ExileServer_object_player_event_onMpKilled.sqf";
	ExileServer_object_player_database_load = "\exile_expansion_server\overrides\ExileServer_object_player_database_load.sqf";
	ExileServer_object_player_createBambi = "\exile_expansion_server\overrides\ExileServer_object_player_createBambi.sqf";
	ExileServer_object_container_database_update = "\exile_expansion_server\overrides\ExileServer_object_container_database_update.sqf";
	ExileServer_object_container_database_load = "\exile_expansion_server\overrides\ExileServer_object_container_database_load.sqf";
	ExileServer_object_container_database_insert = "\exile_expansion_server\overrides\ExileServer_object_container_database_insert.sqf";
	ExileServer_object_container_createContainer = "\exile_expansion_server\overrides\ExileServer_object_container_createContainer.sqf";
	ExileServer_object_construction_database_insert = "\exile_expansion_server\overrides\ExileServer_object_construction_database_insert.sqf";
	ExileServer_object_construction_database_load = "\exile_expansion_server\overrides\ExileServer_object_construction_database_load.sqf";
};