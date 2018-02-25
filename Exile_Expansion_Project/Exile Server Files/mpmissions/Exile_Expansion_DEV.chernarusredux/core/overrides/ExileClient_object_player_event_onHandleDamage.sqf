/**
 * ExileClient_object_player_event_onHandleDamage
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_unit", "_selectionName", "_amountOfDamage", "_sourceOfDamage", "_typeOfProjectile", "_curDamage", "_newDamage"];
_unit = _this select 0;
_selectionName = _this select 1;
_amountOfDamage = _this select 2;
_sourceOfDamage = _this select 3;
_typeOfProjectile = _this select 4;

// Reduce all incoming damage by 75%, effectively giving the units 4x more HP.
if (_selectionName == "?") exitWith {};

_curDamage = damage _unit;
if (_selectionName != "") then 
{
	_curDamage = _unit getHit _selectionName;
};
_newDamage = _amountOfDamage - _curDamage;

_amountOfDamage - _newDamage * 0.75;