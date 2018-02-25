/**
 * ExileServer_system_lootManager_initialize
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_lootTableName", "_lootTable", "_itemGroupName", "_items"];
ExileServerBuildingNetIdsWithLoot = [];
{
	_lootTableName = configName _x;
	_lootTable = getArray (configFile >> "CfgExileLootServer" >> "LootTables" >> _lootTableName);
	missionNamespace setVariable ["ExileCachedLootTable" + _lootTableName, _lootTable];
}
forEach (configProperties [configFile >> "CfgExileLootServer" >> "LootTables"]);
{
	_itemGroupName = configName _x;
	_items = getArray (configFile >> "CfgExileLootServer" >> "ItemGroups" >> _itemGroupName);
	missionNamespace setVariable ["ExileCachedLootItemGroup" + _itemGroupName, _items];
}
forEach (configProperties [configFile >> "CfgExileLootServer" >> "ItemGroups"]);
true