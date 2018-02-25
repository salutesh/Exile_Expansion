/**
 * Created with Exile Mod 3DEN Plugin
 * www.exilemod.com
 */

if (!hasInterface || isServer) exitWith {};

[] call CompileFinal preprocessFileLineNumbers "core\npcs\ExileTraders.sqf";					// Load local client Exile Npcs