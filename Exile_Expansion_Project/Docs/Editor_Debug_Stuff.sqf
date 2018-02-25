// Display Classname of coursor target in Editor:
typeof (nearestobjects [screenToWorld getMousePosition,[],10] select {typeof _x != ""} select 0);

// Get Array of object positions for special object class
_pos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");   
_blds=nearestobjects [_pos,["Land_GarbagePallet_F"], 20000];  
_ary=[];   
{_ary=_ary+[getpos _x]} foreach _blds;   
hint str _ary;   
copyToClipboard str _ary;




//Simple use: play single animation
soldierName switchMove "animationName";
//alternatively
soldierName playMove "animationName";
//alternatively
soldierName playMoveNow "animationName";
//some animations may only work with one of these commands.


soldier1 playMove "acts_A_M01_briefing";


//possible fix for some animations - disableAI
soldierName disableAI "category";
soldierName enableAI "category";

soldier1 disableAI "MOVE";

//possible values:
"MOVE" - the ability to move around.
"TARGET" - watch and target an assigned unit/vehicle.
"AUTOTARGET" - looking out for potential enemies and attacking them automatically.
"ANIM" - ability to change animations automatically.
"TEAMSWITCH" - ability to team switch.
"FSM" - executing FSM scripts.
"AIMINGERROR" - remove all distractions and errors while aiming
"SUPPRESSION" - possibility of being suppressed
"CHECKVISIBLE" - disables visibility raycasts
"COVER" - use of cover
"AUTOCOMBAT" - automatic switch to and from combat behaviour
//don't forget to enable the AI again, otherwise the unit may not be usable for the rest of the mission.


//Ambient animations - function AmbientAnim
[mySoldier, "STAND"] call BIS_fnc_AmbientAnim;
//see the function in-game to get all possible animation values.
//the function can automatically use objects and surroundings for animations.


//loop script - ver. 1
while {alive player} do {                                 //condition can be changed to any other
player switchMove "animationName";                           //or playmove / playMoveNow
waitUntil {animationState player != "animationName"};       //use the same animation name
};

//call the script
0 = [] execVM "script.sqf";


//second version - for animations that get stuck at the end (mostly cinematic anims, or those that are divided in parts)
//for ex. animation that has part1 at the end, (and part2 exists), may not work properly.

while {alive player} do {
player switchMove "animationName"; 		//or playMove / playMoveNow
sleep 35;                             //the time it takes to play the animation (in seconds)
};

//call the script - applies the above ^


//first method, extended. Uses 2 parameters
_unit = _this select 0;
_animation = _this select 1;
while {alive _unit} do {
_unit switchMove _animation;
waitUntil {animationState _unit != _animation};
};
//can be used multiple times. Each unit can get a different animation assigned with just this one script.

//call the script
0 = [mySoldier, "animationName"] execVM "script.sqf";



//first loop script, used in a trigger
0 = [] spawn {while {alive player} do {
player switchMove "animationName";
waitUntil {animationState player != "animationName"};
};};
//If you aren't very familiar with the code, it's actually a better idea
//to use scripts instead of triggers, they are much easier to read.
//second method can be tricky to use in a trigger. Generally it's much easier to use scripts.

//See the video description for a mission with 3 additional examples of animations
//soldiers idling
//officer waving, reloading, leaving the area
//soldier fixing a car