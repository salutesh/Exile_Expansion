/*  
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

private ["_objVehNetId","_vehObj","_flagNetId","_flag","_owner","_objVehId","_flagId","_position","_vectorDirection","_vectorUp","_availableHitpoints","_vehicleHitpoints","_lockstatus","_data","_extDB3Message","_vehList"];

_objVehNetId = [_this,0,"",[""]] call BIS_fnc_param;
_vehObj = objectFromNetId _objVehNetId;
_flagNetId = [_this,1,"",[""]] call BIS_fnc_param;
_flag = objectFromNetId _flagNetId;
_owner = owner _vehObj;
_player = {
	if(owner _x == _owner)exitWith{_x}
} forEach playableUnits;

if!(_vehObj getVariable ["ExileIsPersistent", false])exitWith{[_owner, "toastRequest", ["ErrorTitleAndText", ["ExAd - Virtual Garage", STR_ExAd_VG_NOTI_NOT_PERSISTENT]]] call ExileServer_system_network_send_to;false};

if!(_vehObj setOwner 2)exitWith{format["Get out of the vehicle before storing it."] remoteExec ["hint", _owner]; false};

if!(isNil "ExAd_VG_CLEAN_ON_STORE") then
{
	if(ExAd_VG_CLEAN_ON_STORE)then
	{
		clearBackpackCargoGlobal _vehObj;
		clearItemCargoGlobal _vehObj;
		clearMagazineCargoGlobal _vehObj;
		clearWeaponCargoGlobal _vehObj;
		_vehObj setVariable ["ExileMoney", 0, true];
	}
};

_vehObj call ExileServer_object_vehicle_database_update;

_objVehId = _vehObj getVariable ["ExileDatabaseID",-1];
_flagId = _flag getVariable ["ExileDatabaseID", -1];


if(_objVehId > -1 && _flagId > -1) then
{
	["VirtualGarage", format["Store: Player - %1(%2)|Vehicle - %3(%4)|Reset gear - %5",name _player, getPlayerUID _player, typeOf _vehObj, _objVehId, str ExAd_VG_CLEAN_ON_STORE]] call ExAdServer_fnc_log;
	_position = getPosATL _vehObj;
	_vectorDirection = vectorDir _vehObj;
	_vectorUp = vectorUp _vehObj;
	_availableHitpoints = getAllHitPointsDamage _vehObj;
	_vehicleHitpoints = [];
	if!(_availableHitpoints isEqualTo [])then
	{
		{
			_vehicleHitpoints pushBack [_x ,_vehObj getHitPointDamage _x];
		}
		forEach (_availableHitpoints select 0);
	};
	if (locked _vehObj== 2) then{
		_lockstatus = 1;
	} else {
		_lockstatus = -1;	
	};
	
	_currentLoadout = _vehObj call ExileExpansionServer_object_vehicle_getLoadout;
	
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
		_flagId,
		_objVehId,
		_vehicleHitpoints,
		fuel _vehObj,
		format["%1", getObjectTextures _vehObj],
		_currentLoadout,
		_vehObj getVariable ["ExileMoney", 0],
		_vehObj call ExileServer_util_getItemCargo,
		magazinesAmmoCargo _vehObj,
		weaponsItemsCargo _vehObj,
		_vehObj call ExileServer_util_getObjectContainerCargo
	];

	_extDB3Message = ["insertVGVehicle", _data] call ExileServer_util_extDB2_createMessage;
	_extDB3Message call ExileServer_system_database_query_fireAndForget;

	_vehObj call ExileServer_system_vehicleSaveQueue_removeVehicle;
	_vehObj call ExileServer_system_simulationMonitor_removeVehicle;
	deleteVehicle _vehObj;
	
	format ["deleteVehicle:%1", _objVehId] call ExileServer_system_database_query_fireAndForget;
	_vehList = _flag getVariable ["ExAdVGVeh", []];
	_vehList pushBack [_objVehId, typeOf _vehObj];
	_flag setVariable ["ExAdVGVeh", _vehList, true];
	
	_vehicleClass = typeOf _vehObj;
	_displayName = getText(ConfigFile >> "CfgVehicles" >> _vehicleClass >> "displayName");
	if(ExAd_VG_SHOW_ADVHINT) then
	{
		//[["advancedHint", ["VGStore",[]]], _owner] call ExAdServer_fnc_clientDispatch;
		[_player, "toastRequest", ["VehicleTitleAndText", ["Virtual Garage", format ["%1 was stored in the virtual garage.", _displayName]]]] call ExileServer_system_network_send_to;
	};
};

true