/**
 * ExileServer_object_vehicle_carefulCreateVehicle
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_vehicleClassName","_position","_direction","_usePositionATL","_temporaryPositionInOuterSpace","_vehicleObject","_dronesConfig","_dronesArray"];
_vehicleClassName = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_usePositionATL = _this select 3;
_temporaryPositionInOuterSpace = 
[
	(_position select 0) - 250 + (random 500),
	(_position select 1) - 250 + (random 500),
	1000 + (random 1000)
];
_vehicleObject = createVehicle [_vehicleClassName, _temporaryPositionInOuterSpace, [], 0, "CAN_COLLIDE"];
_vehicleObject allowDamage false;
_vehicleObject removeAllEventHandlers "HandleDamage";
_vehicleObject addEventHandler["HandleDamage", {false}];
_vehicleObject setVelocity [0, 0, 0];
if ((typeName _direction) isEqualTo "ARRAY") then 
{
	_vehicleObject setVectorDirAndUp _direction;
}
else 
{
	_vehicleObject setDir _direction;
};
if (_usePositionATL) then
{
	_vehicleObject setPosATL _position;
}
else 
{
	_vehicleObject setPosASL _position;
};
_vehicleObject setVelocity [0, 0, 0];
_vehicleObject allowDamage true;
_vehicleObject removeAllEventHandlers "HandleDamage";
_vehicleObject setDamage 0;
clearBackpackCargoGlobal _vehicleObject;
clearItemCargoGlobal _vehicleObject;
clearMagazineCargoGlobal _vehicleObject;
clearWeaponCargoGlobal _vehicleObject;

_dronesConfig = missionConfigFile >> "CfgExpansion" >> "CfgExileTraderDrones";
_dronesArray = getArray (_dronesConfig >> "drones");
if (_vehicleClassName in _dronesArray) then 
{
	createVehicleCrew _vehicleObject;
};

if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "nightVision") isEqualTo 0) then 
{
	_vehicleObject disableNVGEquipment true;
};
if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "thermalVision") isEqualTo 0) then 
{
	_vehicleObject disableTIEquipment true;
};
if(_vehicleClassName == "B_Heli_Attack_01_F") then
{
    _vehicleObject removeWeaponTurret  ["gatling_20mm",[0]];
    _vehicleObject removeWeaponTurret  ["missiles_DAGR",[0]];
    _vehicleObject removeWeaponTurret  ["missiles_ASRAAM",[0]];
    _vehicleObject addWeaponTurret     ["M134_minigun",[0]];
    //_vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[0]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
};
if(_vehicleClassName == "B_Heli_Light_01_armed_F") then
{
    _vehicleObject removeWeaponTurret      ["missiles_DAR",[-1]];      
    _vehicleObject removeMagazinesTurret   ["24Rnd_missiles",[-1]];
    _vehicleObject addWeaponTurret         ["M134_minigun",[0]];
    //_vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    //_vehicleObject addWeaponTurret         ["CMFlareLauncher",[0]];
    //_vehicleObject addWeaponTurret         ["CMFlareLauncher",[-1]];
    //_vehicleObject addMagazineTurret       ["60Rnd_CMFlare_Chaff_Magazine",[0]];
    //_vehicleObject addMagazineTurret       ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
};
if(_vehicleClassName == "O_T_VTOL_02_vehicle_F") then
{
    _vehicleObject removeWeaponTurret      ["gatling_30mm_VTOL_02",[0]];
    _vehicleObject removeWeaponTurret      ["missiles_SCALPEL",[0]];
    _vehicleObject removeWeaponTurret      ["rockets_Skyfire",[0]];
    _vehicleObject removeWeaponTurret      ["Laserdesignator_mounted",[0]];
    _vehicleObject removeMagazinesTurret   ["8Rnd_LG_scalpel",[0]];
    _vehicleObject removeMagazinesTurret   ["38Rnd_80mm_rockets",[0]];
    _vehicleObject removeMagazinesTurret   ["250Rnd_30mm_HE_shells_Tracer_Green",[0]];
    _vehicleObject removeMagazinesTurret   ["250Rnd_30mm_APDS_shells_Tracer_Green",[0]];
    _vehicleObject addWeaponTurret         ["M134_minigun",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
};
if(_vehicleClassName == "O_T_VTOL_02_infantry_F") then
{
    _vehicleObject removeWeaponTurret      ["gatling_30mm_VTOL_02",[0]];
    _vehicleObject removeWeaponTurret      ["missiles_SCALPEL",[0]];
    _vehicleObject removeWeaponTurret      ["rockets_Skyfire",[0]];
    _vehicleObject removeWeaponTurret      ["Laserdesignator_mounted",[0]];
    _vehicleObject removeMagazinesTurret   ["8Rnd_LG_scalpel",[0]];
    _vehicleObject removeMagazinesTurret   ["38Rnd_80mm_rockets",[0]];
    _vehicleObject removeMagazinesTurret   ["250Rnd_30mm_HE_shells_Tracer_Green",[0]];
    _vehicleObject removeMagazinesTurret   ["250Rnd_30mm_APDS_shells_Tracer_Green",[0]];
    _vehicleObject addWeaponTurret         ["M134_minigun",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
};
if(_vehicleClassName == "O_Heli_Attack_02_F") then
{
    _vehicleObject removeWeaponTurret ["missiles_SCALPEL",[0]];
    _vehicleObject removeWeaponTurret ["rockets_Skyfire",[0]];
    _vehicleObject removeWeaponTurret  ["gatling_30mm",[0]];
    _vehicleObject addWeaponTurret     ["LMG_coax",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt_T_Red",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt_T_Red",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt_T_Red",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt_T_Red",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt_T_Red",[0]];
};
if(_vehicleClassName == "O_APC_Wheeled_02_rcws_F") then
{
    _vehicleObject removeMagazinesTurret   ["96Rnd_40mm_G_belt",[0]];
    _vehicleObject addMagazineTurret       ["32Rnd_40mm_G_belt",[0]];
};
if(_vehicleClassName == "I_APC_Wheeled_03_cannon_F") then
{
    _vehicleObject removeWeaponTurret      ["autocannon_30mm_CTWS",[-1]];
    _vehicleObject removeWeaponTurret      ["autocannon_30mm_CTWS",[0]];
    _vehicleObject removeWeaponTurret      ["autocannon_30mm_CTWS",[1]];
 
    _vehicleObject removeWeaponTurret      ["missiles_titan",[-1]];
    _vehicleObject removeWeaponTurret      ["missiles_titan",[0]];
    _vehicleObject removeWeaponTurret      ["missiles_titan",[1]];
 
    _vehicleObject removeMagazinesTurret   ["2Rnd_GAT_missiles",[-1]];
    _vehicleObject removeMagazinesTurret   ["2Rnd_GAT_missiles",[0]];
    _vehicleObject removeMagazinesTurret   ["2Rnd_GAT_missiles",[1]];
 
    _vehicleObject addWeaponTurret     ["missiles_ASRAAM",[0]];
    _vehicleObject addMagazineTurret   ["2Rnd_AAA_missiles",[0]];
    _vehicleObject addMagazineTurret   ["2Rnd_AAA_missiles",[0]];
    _vehicleObject addMagazineTurret   ["2Rnd_AAA_missiles",[0]];
    _vehicleObject addMagazineTurret   ["2Rnd_AAA_missiles",[0]];
 
    _vehicleObject removeMagazinesTurret   ["140Rnd_30mm_MP_shells_Tracer_Yellow",[-1]];
    _vehicleObject removeMagazinesTurret   ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow",[-1]];
    _vehicleObject removeMagazinesTurret   ["140Rnd_30mm_MP_shells_Tracer_Yellow",[0]];
    _vehicleObject removeMagazinesTurret   ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow",[0]];
    _vehicleObject removeMagazinesTurret   ["140Rnd_30mm_MP_shells_Tracer_Yellow",[1]];
    _vehicleObject removeMagazinesTurret   ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow",[1]];
};
if(_vehicleClassName == "O_Heli_Light_02_F") then
{
    _vehicleObject removeWeaponTurret  ["missiles_DAGR",[-1]];
    _vehicleObject removeWeaponTurret  ["missiles_DAGR",[0]];
    _vehicleObject removeWeaponTurret  ["missiles_DAGR",[1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[0]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[1]];
};
if(_vehicleClassName == "I_Plane_Fighter_04_F") then
{
    _vehicleObject removeWeaponTurret  ["weapon_Fighter_Gun20mm_AA",[-1]];
    _vehicleObject removeWeaponTurret  ["Laserdesignator_pilotCamera",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_BIM9xLauncher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_AGM_65Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_AMRAAMLauncher",[-1]];
    _vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
};
if(_vehicleClassName == "B_Plane_Fighter_01_Stealth_F") then
{
    _vehicleObject removeWeaponTurret  ["weapon_Fighter_Gun20mm_AA",[-1]];
    _vehicleObject removeWeaponTurret  ["Laserdesignator_pilotCamera",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_BIM9xLauncher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_GBU12Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_AMRAAMLauncher",[-1]];
    _vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
};
if(_vehicleClassName == "B_Plane_Fighter_01_F") then
{
    _vehicleObject removeWeaponTurret  ["weapon_Fighter_Gun20mm_AA",[-1]];
    _vehicleObject removeWeaponTurret  ["Laserdesignator_pilotCamera",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_BIM9xLauncher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_GBU12Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_AMRAAMLauncher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_AGM_65Launcher",[-1]];
    _vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
};
if(_vehicleClassName == "O_Plane_Fighter_02_F") then
{
    _vehicleObject removeWeaponTurret  ["weapon_Fighter_Gun_30mm",[-1]];
    _vehicleObject removeWeaponTurret  ["Laserdesignator_pilotCamera",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_R73Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_R77Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_KAB250Launcher",[-1]];
    _vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
};
if(_vehicleClassName == "O_Plane_Fighter_02_Stealth_F") then
{
    _vehicleObject removeWeaponTurret  ["weapon_Fighter_Gun_30mm",[-1]];
    _vehicleObject removeWeaponTurret  ["Laserdesignator_pilotCamera",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_R73Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_R77Launcher",[-1]];
    _vehicleObject removeWeaponTurret  ["weapon_KAB250Launcher",[-1]];
    _vehicleObject addWeaponTurret     ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret   ["2000Rnd_762x51_Belt",[-1]];
};
if(_vehicleClassName == "CUP_B_AH1Z_NoWeapons") then
{
    _vehicleObject removeWeaponTurret  ["CUP_Vacannon_M197_veh",[0]];
    _vehicleObject addWeaponTurret     ["HMG_127",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
};
if(_vehicleClassName == "CUP_B_AH64D_NO_USA") then
{
    _vehicleObject removeWeaponTurret  ["CUP_Vacannon_M230_veh",[0]];
    _vehicleObject addWeaponTurret     ["HMG_127",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Red",[0]];
};
if(_vehicleClassName == "CUP_B_AW159_Unarmed_RN_Blackcat") then
{
    _vehicleObject addWeaponTurret     ["HMG_127",[-1]];  
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Yellow",[-1]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Yellow",[-1]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Yellow",[-1]];
    _vehicleObject addMagazineTurret   ["500Rnd_127x99_mag_Tracer_Yellow",[-1]];
};
if(_vehicleClassName == "I_Heli_light_03_dynamicLoadout_F") then
{
    _vehicleObject removeWeaponTurret      ["missiles_DAR",[0]];
    _vehicleObject removeMagazinesTurret   ["24Rnd_missiles",[0]];
    _vehicleObject removeWeaponTurret      ["missiles_DAR",[-1]];
    _vehicleObject removeMagazinesTurret   ["24Rnd_missiles",[-1]];
    _vehicleObject addWeaponTurret         ["M134_minigun",[0]];
    _vehicleObject addWeaponTurret         ["M134_minigun",[-1]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[-1]];
    _vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[-1]];
};
_vehicleObject