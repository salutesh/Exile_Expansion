/**
 * ExileExpansionClient_gui_holdActionAdd
 *
 * Exile Expansion Mod
 * www.reality-gaming.eu
 * © 2017 Exile Expansion Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_rscLayer", "_players", "_unit", "_damage", "_hunger", "_thirst", "_bodyTemp", "_ambientTemp", "_poptabs", "_locker", "_respect", "_serverFPS", "_pos", "_dir", "_grid", "_xx", "_yy", "_serverRestartTime", "_hours", "_minutes", "_radiation", "_statusRadiation", "_colourDefault", "_colourPlayers", "_colourDamage", "_colourPoptabs", "_colourLocker", "_colourHunger", "_colourThirst", "_colourFPS", "_colourRespect", "_colourLocation", "_colourRestart", "_colourRadiation", "_colourTemp", "_colourAmbientTemp"];
disableSerialization;
_rscLayer = "RscExileExpansionHUD" call BIS_fnc_rscLayer;
_rscLayer cutRsc["RscExileExpansionHUD","PLAIN"];

[] spawn 
{
	if (!isNil "toggleStatus") exitWith {};
	uiSleep 5;
	_uid = getPlayerUID player;	
	
	while {true} do 
	{
		uiSleep 1;
		if(isNull ((uiNamespace getVariable "RscExileExpansionHUD")displayCtrl -1)) then
		{
			disableSerialization;
			_rscLayer = "RscExileExpansionHUD" call BIS_fnc_rscLayer;
			_rscLayer cutRsc["RscExileExpansionHUD","PLAIN"];			
		};

		//Initialize variables and set values
		_players = count playableUnits;
		_unit = _this select 0;
		_damage = round ((1 - (damage player)) * 100);
		_hunger = round (ExileClientPlayerAttributes select 2);
		_thirst = round (ExileClientPlayerAttributes select 3);
		_bodyTemp = round (ExileClientPlayerAttributes select 5);
		_ambientTemp = [ExileClientEnvironmentTemperature, 1] call ExileClient_util_math_round;
		_poptabs = (player getVariable ["ExileMoney", 0]);
		if (_poptabs > 999) then
		{
			_poptabs = format ["%1k", floor (_poptabs / 1000)];
		};
		
		_locker = (player getVariable ["ExileLocker", 0]);
		if (_locker > 999) then
		{
			_locker = format ["%1k", floor (_locker / 1000)];
		};
		
		_respect = ExileClientPlayerScore;
		if (_respect > 999) then
		{
			_respect = format ["%1k", floor (_respect / 1000)];
		};
	
		_serverFPS = round diag_fps;
		_pos = getPosATL player;
		_dir = round (getDir (vehicle player));
		_grid = mapGridPosition  player; 
		_xx = (format[_grid]) select  [0,3]; 
		_yy = (format[_grid]) select  [3,3];
		_serverRestartTime = getNumber(missionConfigFile >> "CfgStatusbar" >> "statusbarRestartTime");
		_time = (round(_serverRestartTime-(serverTime)/60));
		if(!isNil "timeToNextRestart") then 
		{
			_time = timeToNextRestart;
		};
		_hours = (floor(_time/60));
		_minutes = (_time - (_hours * 60));
		_radiation = 0;
		if (!isNil "ExilePlayerRadiation") then 
		{
			_radiation = ExilePlayerRadiation;
		};
		
	    _statusRadiation = round (_radiation*100);
		
		switch(_minutes) do
		{
			case 9: {_minutes = "09"};
			case 8: {_minutes = "08"};
			case 7: {_minutes = "07"};
			case 6: {_minutes = "06"};
			case 5: {_minutes = "05"};
			case 4: {_minutes = "04"};
			case 3: {_minutes = "03"};
			case 2: {_minutes = "02"};
			case 1: {_minutes = "01"};
			case 0: {_minutes = "00"};
		};
		
		//Colour coding
		//Color Gradient Damage/Hunger/Thirst
		_colourDefault 		= parseText "#ffffff";
		_colour100			= parseText "#00ff36";
		_colour90 			= parseText "#00ff06";
		_colour80 			= parseText "#48ff00";
		_colour70 			= parseText "#7eff00";
		_colour60 			= parseText "#d8ff00";
		_colour50 			= parseText "#f6ff00";
		_colour40 			= parseText "#ffde00"; 
		_colour30 			= parseText "#ffc000";
		_colour20 			= parseText "#ff9c00";
		_colour10 			= parseText "#ff6600";
		_colour0 			= parseText "#ff1200";
		_colourDead 		= parseText "#000000";
		
		//Color Gradient Temerature
		_colourTempDefault 		= parseText "#ffffff";
		_colourTemp100			= parseText "#00ff36";
		_colourTemp90 			= parseText "#00ff06";
		_colourTemp80 			= parseText "#48ff00";
		_colourTemp70 			= parseText "#7eff00";
		_colourTemp60 			= parseText "#d8ff00";
		_colourTemp50 			= parseText "#f6ff00";
		_colourTemp40 			= parseText "#ffde00"; 
		_colourTemp30 			= parseText "#ffc000";
		_colourTemp20 			= parseText "#ff9c00";
		_colourTemp10 			= parseText "#ff6600";
		_colourTemp0 			= parseText "#ff1200";
		_colourMinus 			= parseText "#2efec8";
		
		//Color Gradient Radiation
		_colourRadiationDefault 	= parseText "#ffffff";
		_colourRadiation100			= parseText "#ff6000";
		_colourRadiation90 			= parseText "#ff7800";
		_colourRadiation80 			= parseText "#ff9c00";
		_colourRadiation70 			= parseText "#ffae00";
		_colourRadiation60 			= parseText "#ffc600";
		_colourRadiation50 			= parseText "#ffde00";
		_colourRadiation40 			= parseText "#ffea00"; 
		_colourRadiation30 			= parseText "#fffc00";
		_colourRadiation20 			= parseText "#f0ff00";
		_colourRadiation10 			= parseText "#f8ff82";
		_colourRadiation0 			= parseText "#ff1200";
		
		//Color Gradient for static icons
		_colourPlayers				= parseText "#217630";
		_colourPoptabs				= parseText "#db3b46";
		_colourLocker				= parseText "#db3b46";
		_colourFPS					= parseText "#217630";
		_colourRespect				= parseText "#db3b46";
		_colourLocation				= parseText "#217630";
		_colourRestart				= parseText "#217630";
	
		//Damage
		_colourDamage = _colourDefault;
		if(_damage >= 100) then{_colourDamage = _colour100;};
		if((_damage >= 90) && (_damage < 100)) then {_colourDamage =  _colour90;};
		if((_damage >= 80) && (_damage < 90)) then {_colourDamage =  _colour80;};
		if((_damage >= 70) && (_damage < 80)) then {_colourDamage =  _colour70;};
		if((_damage >= 60) && (_damage < 70)) then {_colourDamage =  _colour60;};
		if((_damage >= 50) && (_damage < 60)) then {_colourDamage =  _colour50;};
		if((_damage >= 40) && (_damage < 50)) then {_colourDamage =  _colour40;};
		if((_damage >= 30) && (_damage < 40)) then {_colourDamage =  _colour30;};
		if((_damage >= 20) && (_damage < 30)) then {_colourDamage =  _colour20;};
		if((_damage >= 10) && (_damage < 20)) then {_colourDamage =  _colour10;};
		if((_damage >= 1) && (_damage < 10)) then {_colourDamage =  _colour0;};
		if(_damage < 1) then{_colourDamage =  _colourDead;};

		//Hunger
		_colourHunger = _colourDefault;
		if(_hunger >= 100) then{_colourHunger = _colour100;};
		if((_hunger >= 90) && (_hunger < 100)) then {_colourHunger =  _colour90;};
		if((_hunger >= 80) && (_hunger < 90)) then {_colourHunger =  _colour80;};
		if((_hunger >= 70) && (_hunger < 80)) then {_colourHunger =  _colour70;};
		if((_hunger >= 60) && (_hunger < 70)) then {_colourHunger =  _colour60;};
		if((_hunger >= 50) && (_hunger < 60)) then {_colourHunger =  _colour50;};
		if((_hunger >= 40) && (_hunger < 50)) then {_colourHunger =  _colour40;};
		if((_hunger >= 30) && (_hunger < 40)) then {_colourHunger =  _colour30;};
		if((_hunger >= 20) && (_hunger < 30)) then {_colourHunger =  _colour20;};
		if((_hunger >= 10) && (_hunger < 20)) then {_colourHunger =  _colour10;};
		if((_hunger >= 1) && (_hunger < 10)) then {_colourHunger =  _colour0;};
		if(_hunger < 1) then{_colourHunger =  _colourDead;};

		//Thirst
		_colourThirst = _colourDefault;
		switch true do
		{
			case(_thirst >= 100) : {_colourThirst = _colour100;};
			case((_thirst >= 90) && (_thirst < 100)) :  {_colourThirst =  _colour90;};
			case((_thirst >= 80) && (_thirst < 90)) :  {_colourThirst =  _colour80;};
			case((_thirst >= 70) && (_thirst < 80)) :  {_colourThirst =  _colour70;};
			case((_thirst >= 60) && (_thirst < 70)) :  {_colourThirst =  _colour60;};
			case((_thirst >= 50) && (_thirst < 60)) :  {_colourThirst =  _colour50;};
			case((_thirst >= 40) && (_thirst < 50)) :  {_colourThirst =  _colour40;};
			case((_thirst >= 30) && (_thirst < 40)) :  {_colourThirst =  _colour30;};
			case((_thirst >= 20) && (_thirst < 30)) :  {_colourThirst =  _colour20;};
			case((_thirst >= 10) && (_thirst < 20)) :  {_colourThirst =  _colour10;};
			case((_thirst >= 1) && (_thirst < 10)) :  {_colourThirst =  _colour0;};
			case(_thirst < 1) : {_colourThirst =  _colourDead;};
		};
			
		//Climate Temperature
		_colourAmbientTemp = _colourTempDefault;
		switch true do
		{
			case(_ambientTemp >= 37) : {_colourAmbientTemp = _colourTempDefault;};
			case((_ambientTemp >= 37) && (_ambientTemp < 38)) :  {_colourAmbientTemp =  _colourTemp90;};
			case((_ambientTemp >= 36) && (_ambientTemp < 37)) :  {_colourAmbientTemp =  _colourTemp80;};
			case((_ambientTemp >= 35) && (_ambientTemp < 36)) :  {_colourAmbientTemp =  _colourTemp70;};
			case((_ambientTemp >= 34) && (_ambientTemp < 35)) :  {_colourAmbientTemp =  _colourTemp60;};
			case((_ambientTemp >= 34) && (_ambientTemp < 35)) :  {_colourAmbientTemp =  _colourTemp50;};
			case((_ambientTemp >= 33) && (_ambientTemp < 34)) :  {_colourAmbientTemp =  _colourTemp40;};
			case((_ambientTemp >= 33) && (_ambientTemp < 34)) :  {_colourAmbientTemp =  _colourTemp30;};
			case((_ambientTemp >= 32) && (_ambientTemp < 33)) :  {_colourAmbientTemp =  _colourTemp20;};
			case((_ambientTemp >= 31) && (_ambientTemp < 32)) :  {_colourAmbientTemp =  _colourTemp10;};
			case((_ambientTemp >= 1) && (_ambientTemp < 10)) :  {_colourAmbientTemp =  _colourTemp0;};
			case(_ambientTemp < 1) : {_colourAmbientTemp =  _colourMinus;};
		};
	
		//Body Temerature
		_colourTemp = _colourTempDefault;
		switch true do
		{
			case(_bodytemp >= 37) : {_colourTemp = _colourTempDefault;};
			case((_bodytemp >= 37) && (_bodytemp < 38)) :  {_colourTemp =  _colourTemp90;};
			case((_bodytemp >= 36) && (_bodytemp < 37)) :  {_colourTemp =  _colourTemp80;};
			case((_bodytemp >= 35) && (_bodytemp < 36)) :  {_colourTemp =  _colourTemp70;};
			case((_bodytemp >= 34) && (_bodytemp < 35)) :  {_colourTemp =  _colourTemp60;};
			case((_bodytemp >= 34) && (_bodytemp < 35)) :  {_colourTemp =  _colourTemp50;};
			case((_bodytemp >= 33) && (_bodytemp < 34)) :  {_colourTemp =  _colourTemp40;};
			case((_bodytemp >= 33) && (_bodytemp < 34)) :  {_colourTemp =  _colourTemp30;};
			case((_bodytemp >= 32) && (_bodytemp < 33)) :  {_colourTemp =  _colourTemp20;};
			case((_bodytemp >= 31) && (_bodytemp < 32)) :  {_colourTemp =  _colourTemp10;};
			case((_bodytemp >= 1) && (_bodytemp < 10)) :  {_colourTemp =  _colourTemp0;};
			case(_bodytemp < 1) : {_colourTemp =  _colourMinus;};
		};
			
		//Radiation
		_colourRadiation = _colourRadiationDefault;
		switch true do
		{
			case(_statusRadiation >= 100) : {_colourRadiation = _colourRadiation100;};
			case((_statusRadiation >= 90) && (_statusRadiation < 100)) :  {_colourRadiation =  _colourRadiation90;};
			case((_statusRadiation >= 90) && (_statusRadiation < 100)) :  {_colourRadiation =  _colourRadiation90;};
			case((_statusRadiation >= 80) && (_statusRadiation < 90)) :  {_colourRadiation =  _colourRadiation80;};
			case((_statusRadiation >= 70) && (_statusRadiation < 80)) :  {_colourRadiation =  _colourRadiation70;};
			case((_statusRadiation >= 60) && (_statusRadiation < 70)) :  {_colourRadiation =  _colourRadiation60;};
			case((_statusRadiation >= 50) && (_statusRadiation < 60)) :  {_colourRadiation =  _colourRadiation50;};
			case((_statusRadiation >= 40) && (_statusRadiation < 50)) :  {_colourRadiation =  _colourRadiation40;};
			case((_statusRadiation >= 30) && (_statusRadiation < 40)) :  {_colourRadiation =  _colourRadiation30;};
			case((_statusRadiation >= 20) && (_statusRadiation < 30)) :  {_colourRadiation =  _colourRadiation20;};
			case((_statusRadiation >= 10) && (_statusRadiation < 20)) :  {_colourRadiation =  _colourRadiation10;};
			case((_statusRadiation >= 1) && (_statusRadiation < 10)) :  {_colourRadiation =  _colourRadiation0;};
			case(_statusRadiation < 1) : {_colourRadiation =  _colourDefault;};
		};
		
		if(_damage < 1) then
		{
			_colourHunger		= _colourDead;
			_colourThirst		= _colourDead;
			_colourAmbientTemp 	= _colourDead;
			_colourTemp			= _colourDead;
			_colourPlayers		= _colourDead;
			_colourPoptabs		= _colourDead;
			_colourLocker		= _colourDead;
			_colourFPS			= _colourDead;
			_colourRespect		= _colourDead;
			_colourLocation		= _colourDead;
			_colourRestart		= _colourDead;
			_colourRadiation    = _colourDead;
		};
		
		// Display the icons and informations 
		((uiNamespace getVariable "RscExileExpansionHUD")displayCtrl 50001)ctrlSetStructuredText parseText 
		format["
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_health_ca.paa' color='%5'/> %4%1</t>
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_temp_ca.paa' color='%28'/> %27°C</t>
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_climate_ca.paa' color='%30'/> %29°C</t>			
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_hunger_ca.paa' color='%11'/> %10%1</t> 
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_thirst_ca.paa' color='%13'/> %12%1</t>
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_radiation_ca.paa' color='%26'/> %25%1</t> 			
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_poptabs_ca.paa' color='%7'/> %6</t>
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_locker_ca.paa' color='%9'/> %8</t> 			
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_respect_ca.paa' color='%17'/> %16</t>			
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_compass_ca.paa' color='%21'/> %19</t>
			<t color='%10'><img size='1.5' image='exile_expansion_assets\texture\ui\statusbar\old\statusbar_players_ca.paa' color='%3'/> %2</t>
			",
		
			"%", 
			_players,
			_colourPlayers,
			_damage,
			_colourDamage,
			_poptabs,
			_colourPoptabs,
			_locker,
			_colourLocker,
			_hunger,
			_colourHunger,
			_thirst, 
			_colourThirst,
			_serverFPS,
			_colourFPS,
			_respect,
			_colourRespect,
			_colourDefault,
			format["%1/%2",_xx,_yy],		
			_dir,
			_colourLocation,
			_hours,
			_minutes,
			_colourRestart,
			_statusRadiation,
			_colourRadiation,
			_bodyTemp,
			_colourTemp,
			_ambientTemp,
			_colourAmbientTemp
		];
	}; 
};
