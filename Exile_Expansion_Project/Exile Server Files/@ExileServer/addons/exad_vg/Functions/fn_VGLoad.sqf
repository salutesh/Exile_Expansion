/*  
	fn_VGLoad.sqf
	
	Copyright 2016 Jan Babor

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

private ["_objId","_vehObj","_flagNetId","_playerNetId","_flag","_player","_requestFrom","_proceed","_territoryID","_objVehId","_flagId","_position","_vectorDirection","_vectorUp","_availableHitpoints","_vehicleHitpoints","_extDB3Message","_vehList","_vehicleID","_lockstatus","_data","_extDB3Message","_currentLoadout","_flagName"];

_objId = [_this,0,"",[""]] call BIS_fnc_param;
_flagNetId = [_this,1,"",[""]] call BIS_fnc_param;
_playerNetId = [_this,2,"",[""]] call BIS_fnc_param;
_flag = objectFromNetId _flagNetId;
_territoryID = _flag getVariable ["ExileDatabaseID", ""];
_player = objectFromNetId _playerNetId;
_requestFrom = owner _player;

_proceed = false;
_vehList = _flag getVariable ["ExAdVGVeh", []];

{
	if((format["%1",_x select 0]) isEqualTo _objId)exitWith{
		_vehList deleteAt _forEachIndex;
		_proceed = true;
	}
}forEach _vehList;

if(!_proceed)exitWith{[_owner, "toastRequest", ["ErrorTitleAndText", ["ExAd - Virtual Garage", STR_ExAd_VG_NOTI_NOT_AVAILABLE]]] call ExileServer_system_network_send_to};

_flag setVariable ["ExAdVGVeh", _vehList, true];
_vehObj = (parseNumber _objId) call ExileExpansionServer_object_vehicle_garage_database_save;

_availableHitpoints = getAllHitPointsDamage _vehObj;
_vehicleHitpoints = [];

if!(_availableHitpoints isEqualTo []) then
{
	{
		_vehicleHitpoints pushBack [_x ,_vehObj getHitPointDamage _x];
	}
	forEach (_availableHitpoints select 0);
};

_position = getPosATL _vehObj;
_vectorDirection = vectorDir _vehObj;
_vectorUp = vectorUp _vehObj;
	
if ((locked _vehObj) == 2) then 
{
	_lockstatus = -1;
}
else 
{
	_lockstatus = 0;	
};

// Get ammo data
_currentLoadout = _vehObj call ExileExpansionServer_object_vehicle_getLoadout;
_money = _vehObj getVariable ["ExileMoney", 0];

_data =
[
	typeOf _vehObj,
	_vehObj getVariable ["ExileOwnerUID", ""],
	_lockstatus,
	_position select 0,
	_position select 1,
	_position select 2,
	_vectorDirection select 0, 
	_vectorDirection select 1,
	_vectorDirection select 2,
	_vectorUp select 0,
	_vectorUp select 1,
	_vectorUp select 2,
	_vehObj getVariable ["ExileAccessCode",""],
	_objId,
	_vehicleHitpoints,
	fuel _vehObj,
	format["%1",getObjectTextures _vehObj],
	_currentLoadout,
	_money
];
	
_extDB3Message = ["insertVGVehicleExile", _data] call ExileServer_util_extDB2_createMessage;
_extDB3Message call ExileServer_system_database_query_fireAndForget;

_vehicleClass = typeOf _vehObj;
_displayName = getText(ConfigFile >> "CfgVehicles" >> _vehicleClass >> "displayName");
if(ExAd_VG_SHOW_ADVHINT) then
{
	//[["advancedHint", ["VGLoad",[_vehObj getVariable["ExileAccessCode",""]]]], _requestFrom] call ExAdServer_fnc_clientDispatch;
	[_player, "toastRequest", ["VehicleTitleAndText", ["Virtual Garage", format ["%1 was fetched from the virtual garage.", _displayName]]]] call ExileServer_system_network_send_to;
};

_pos = getPosATL _vehObj;
_pos set [2, (_pos select 2) + 0.1];
_vehObj setPosATL _pos;

_flagName = _flag getVariable 'exileterritoryname';

["VirtualGarage", format["Spawned: Player - %1(%2)|Vehicle - %3(%4)|",name _player, getPlayerUID _player, typeOf _vehObj, _objId]] call ExAdServer_fnc_log;

true