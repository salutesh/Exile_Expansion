/*
    File: ExileWeather.sqf
    Written by Salutesh
    www.reality-gaming.eu

	Original script by code34
	https://github.com/code34/real_weather_mission.Altis/blob/master/real_weather.sqf
	
*/

	private ["_lastrain", "_rain", "_fog", "_mintime", "_maxtime", "_overcast", "_realtime", "_random","_startingdate", "_startingweather", "_timeforecast", "_timeratio", "_timesync", "_wind"];
	
	// Real time vs fast time
	// true: Real time is more realistic weather conditions change slowly (ideal for persistent game)
	// false: fast time give more different weather conditions (ideal for non persistent game) 
	_realtime = false;

	// Random time before new forecast
	// true: forecast happens bewteen mintime and maxtime
	// false: forecast happens at mintime
	_random = true;

	// Min time seconds (real time) before a new weather forecast
	_mintime = 900;

	// Max time seconds (real time) before a new weather forecast
	_maxtime = 1800;

	// If Fastime is on
	// Ratio 1 real time second for x game time seconds
	// Default: 1 real second = 6 second in game
	_timeratio = 6;

	// send sync data across the network each xxx seconds
	// 60 real seconds by default is a good value
	// shortest time do not improve weather sync
	_timesync = 60;

	// Mission starting date is 25/09/2013 at 12:00
	_startingdate = [2017, 04, 16, 6+floor (random 13), 00];

	// Mission starting weather "CLEAR|CLOUDY|RAIN";
	_startingweather = ["CLEAR","CLOUDY","RAIN"] call BIS_fnc_selectRandom; // Selects a random weather setting on reset.

	/////////////////////////////////////////////////////////////////
	// Do not edit below
	/////////////////////////////////////////////////////////////////
	
	if(_mintime > _maxtime) exitwith {hint format["Real weather: Max time: %1 can no be higher than Min time: %2", _maxtime, _mintime];};
	_timeforecast = _mintime;

	setdate _startingdate;
	switch(toUpper(_startingweather)) do {
		case "CLEAR": {
			wcweather = [0.0,[0,0,0],0, [random 3, random 3, true], date];
		};
		
		case "CLOUDY": {
			wcweather = [0.3,[0.3,0,0],0.5, [random 3, random 3, true], date];
		};
		
		case "RAIN": {
			wcweather = [0.3,[0.5,0.01,15],1, [random 3, random 3, true], date];
		};

		default {
			// clear
			wcweather = [0, 0, 0, [random 3, random 3, true], date];
			diag_log "Real weather: wrong starting weather";
		};
	};

	// add handler
	if (local player) then {
		wcweatherstart = true;
		"wcweather" addPublicVariableEventHandler {
			// first JIP synchronization
			if(wcweatherstart) then {
				wcweatherstart = false;
				skipTime -24;
				86400 setRain (wcweather select 0);
				86400 setfog (wcweather select 1);
				86400 setOvercast (wcweather select 2);
				skipTime 24;
				simulweatherSync;
				setwind (wcweather select 3);
				setdate (wcweather select 4);
			}else{
				wcweather = _this select 1;
				//60 setRain (wcweather select 0);
				60 setfog (wcweather select 1);
				60 setOvercast (wcweather select 2);
				setwind (wcweather select 3);
				setdate (wcweather select 4);
			};
		};
	};

	// SERVER SIDE SCRIPT
	if (!isServer) exitWith{};

	if(!_realtime) then { setTimeMultiplier _timeratio; };

	// apply weather
	skipTime -24;
	86400 setRain (wcweather select 0);
	86400 setfog (wcweather select 1);
	86400 setOvercast (wcweather select 2);
	skipTime 24;
	simulweatherSync;
	setwind (wcweather select 3);
	setdate (wcweather select 4);

	// sync server & client weather & time
	[_timesync] spawn {
		private["_timesync"];
		_timesync = _this select 0;

		while { true } do {
			wcweather set [4, date];
			publicvariable "wcweather";
			uiSleep _timesync;
		};
	};

	_lastrain = 0;
	_rain = 0;
	_overcast = 0;
	_fogValue = 0;
	_fogDecay = 0;
	_fogHight =0;

	while {true} do {

		_overcast = random 1;
		if(_overcast > 0.5) then { 
			_rain = random 0.5;
		} else { 
			_rain = 0;
		};
		
		if((date select 3 > 5) and (date select 3 <10)) then { 
			_fogValue = 0.2 + (random 0.8);
			_fogDecay = 0.2;
			_fogHight = random 20;
		} else { 
			if((_lastrain > 0.6) and (_rain < 0.2)) then {
				_fogValue = random 0.4;
				_fogDecay = 0;
				_fogHight = 0;
			} else {
				_fogValue = 0;
				_fogDecay = 0;
				_fogHight = 0;
			};
		};
		
		if(random 1 > 0.5) then { "wind case 1";
			_wind = [random 7, random 7, true];
		} else { 
			_wind = [random 3, random 3, true];
		};
		_lastrain = _rain;

		wcweather = [_rain, [_fogValue,_fogDecay,_fogHight], _overcast, _wind, date];
		60 setRain (wcweather select 0);
		60 setfog (wcweather select 1);
		60 setOvercast (wcweather select 2);
		setwind (wcweather select 3);
		if(_random) then {
			_timeforecast = _mintime + (random (_maxtime - _mintime));
		};
		uiSleep _timeforecast;
	};