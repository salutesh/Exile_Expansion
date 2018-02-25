/**
 * Pre-Initialization
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private ['_code', '_function', '_file', '_fileContent'];

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;
    _isLocked = _x select 2;

    if (_isLocked isEqualTo false) then
    {
        if (isText (missionConfigFile >> 'CfgExileCustomCode' >> _function)) then
        {
            _file = getText (missionConfigFile >> 'CfgExileCustomCode' >> _function);
        };
    };

    _fileContent = preprocessFileLineNumbers _file;

    if (_fileContent isEqualTo '') then
    {
        diag_log (format ['ERROR: Override of %1 in CfgExileCustomCode points to a non-existent file: %2. Defaulting to vanilla Exile code!', _function, _file]);
   
        _fileContent = preprocessFileLineNumbers (_x select 1);
    };

    _code = compileFinal _fileContent;                    

    missionNamespace setVariable [_function, _code];
}
forEach 
[
	//['ExileExpansionServer_object_vehicle_garage_database_save', 'exile_expansion_server\code\ExileExpansionServer_object_vehicle_garage_database_save.sqf', false],
	//['ExileExpansionServer_object_vehicle_getLoadout', 'exile_expansion_server\code\ExileExpansionServer_object_vehicle_getLoadout.sqf', false],
	//['ExileExpansionServer_server_log', 'exile_expansion_server\code\ExileExpansionServer_server_log.sqf', false],
	//['ExileExpansionServer_system_process_postInit', 'exile_expansion_server\code\ExileExpansionServer_system_process_postInit.sqf', true],
	//['ExileExpansionServer_system_process_preInit', 'exile_expansion_server\code\ExileExpansionServer_system_process_preInit.sqf', true],
	['ExileExpansionServer_world_spawn_crashSides', 'exile_expansion_server\code\ExileExpansionServer_world_spawn_crashSides.sqf', false]
];

call ExileExpansionServer_system_process_preInit;

true