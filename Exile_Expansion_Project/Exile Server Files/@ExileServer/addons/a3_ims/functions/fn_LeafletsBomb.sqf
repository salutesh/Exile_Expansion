/*
    IMS_fnc_LeafletsBomb.sqf
    Written by Salutesh
    www.reality-gaming.eu
*/

private ["_pos","_drone","_droneObj","_droneGrp"];
_pos = _this select 0;
_drone = [[(_pos select 0), (_pos select 1), (_pos select 2)], 10, "I_UAV_06_F", INDEPENDENT] call bis_fnc_spawnvehicle;
_droneObj = _drone select 0;
_droneGrp = _drone select 2;
_droneGrp setSpeedMode "NORMAL";
_droneGrp setBehaviour "CARELESS";
_droneWP1 =_droneGrp addWaypoint [(_pos),1];
_droneWP1 setWaypointType "MOVE";

_droneObj addMagazineGlobal "1Rnd_Leaflets_Guer_F";
_droneObj addWeaponGlobal "Bomb_Leaflets";
_droneObj fire "Bomb_Leaflets";
[_droneObj] spawn 
{
	uisleep 10;
	_droneObj = _this select 0;
	deleteVehicle _droneObj;
};
