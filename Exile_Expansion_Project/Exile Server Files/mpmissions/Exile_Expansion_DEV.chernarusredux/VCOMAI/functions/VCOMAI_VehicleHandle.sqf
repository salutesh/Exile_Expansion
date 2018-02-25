//Created on ???
// Modified on : 8/19/14 - 8/3/15 - 9/1/15 - 9/9/2017

private _Driver = _this select 0;
private _myNearestEnemy = _this select 1;
if (isNil "_myNearestEnemy" || {_myNearestEnemy isEqualTo []}) exitWith {};

private _UnitGroup = group _Driver;
private _Vehicle = (vehicle _Driver);

	private _CargoCount = 0;
	{private _index = _Vehicle getCargoIndex _x;if !(_index isEqualTo -1) then {_CargoCount = _CargoCount + 1;};} foreach crew _vehicle;
	if ((_myNearestEnemy distance _Driver) < 600 && {_CargoCount > 0}) then 
	{
			if ((getPos _Vehicle select 2) < 3) then 
			{
				_Driver disableAI "AUTOTARGET";
				_Driver disableAI "TARGET";
				_Driver disableAI "SUPPRESSION";
				_Driver disableAI "COVER";
				_Driver disableAI "AUTOCOMBAT";
				_Vehicle land "GET OUT";
				_Vehicle land "GET OUT";
				waitUntil {(speed _Vehicle) < 6;};
				{
					private _index = _Vehicle getCargoIndex _x;
					if !(_index isEqualTo -1) then {moveOut _x;doGetOut _x;_x leaveVehicle _Vehicle;unassignVehicle _x;};
					sleep 1;
					[_x,false,false,false,false] spawn VCOMAI_MoveToCover;
					if (VCOM_AIDEBUG isEqualTo 1) then
					{
						[_x,"Disembark! Scatter!",30,20000] remoteExec ["3DText",0];
					};					
					if ((leader _x) isEqualTo _x) then 
					{
							_waypoint2 = (group _x) addwaypoint[_myNearestEnemy,15,150];
							_waypoint2 setwaypointtype "MOVE";
							_waypoint2 setWaypointSpeed "NORMAL";
							_waypoint2 setWaypointBehaviour "AWARE";
					};							
				} foreach crew _Vehicle;				
				_Driver enableAI "AUTOTARGET";
				_Driver enableAI "TARGET";
				_Driver enableAI "SUPPRESSION";
				_Driver enableAI "COVER";
				_Driver enableAI "AUTOCOMBAT";
			}
			else
			{
				_Driver disableAI "AUTOTARGET";
				_Driver disableAI "TARGET";
				_Driver disableAI "SUPPRESSION";
				_Driver disableAI "COVER";
				_Driver disableAI "AUTOCOMBAT";		
				_Vehicle land "GET OUT";
				_Vehicle land "GET OUT";
				waitUntil {(getPos _Vehicle select 2) < 2.5;};
				waitUntil {(speed _Vehicle) < 6;};
				{
					private _index = _Vehicle getCargoIndex _x;
					if !(_index isEqualTo -1) then {moveOut _x;doGetOut _x;_x leaveVehicle _Vehicle;unassignVehicle _x;};
					sleep 1;
					[_x,false,false,false,false] spawn VCOMAI_MoveToCover;
					if (VCOM_AIDEBUG isEqualTo 1) then
					{
						[_x,"Disembark! Scatter!",30,20000] remoteExec ["3DText",0];
					};							
					if ((leader _x) isEqualTo _x) then 
					{
							_waypoint2 = (group _x) addwaypoint[_myNearestEnemy,15,150];
							_waypoint2 setwaypointtype "MOVE";
							_waypoint2 setWaypointSpeed "NORMAL";
							_waypoint2 setWaypointBehaviour "AWARE";
					};							
				} foreach crew _Vehicle;						
				_Driver enableAI "AUTOTARGET";
				_Driver enableAI "TARGET";
				_Driver enableAI "SUPPRESSION";
				_Driver enableAI "COVER";
				_Driver enableAI "AUTOCOMBAT";	
		
			};
	};



	
	
		if ((count (units _UnitGroup)) > 1) then
		{
				[_Driver,false,false,(_Driver getvariable ["VCOMAI_StartedInside",false]),false] spawn VCOMAI_FlankManeuver;
				
			
			_GroupLeader = leader _Driver;
			
			if (_GroupLeader isEqualTo _Driver) then
			{
			
				_index = currentWaypoint _UnitGroup;
				_WPPosition = getWPPos [_UnitGroup,_index];
				_Driver doMove _WPPosition;
			
			
			
			}
			else
			{
			
				_Driver doFollow _GroupLeader;
			
			
			};
		};
	
	if ((count (waypoints _UnitGroup)) < 2) then
	{		
		
				_index = currentWaypoint _UnitGroup;
				_WPPosition = getWPPos [_UnitGroup,_index];
				_Driver doMove _WPPosition;

	};
	