/*
    File: ExileTime.sqf
    Written by Salutesh
    www.reality-gaming.eu
    
    Description:
	Creates a day / night fast-time cyrcle.
	Current setup is 2h day / 1 h night.
*/

// Time Setup for 2H day / 1H night cycle. 
while {true} do 
{
	if (daytime >= 20 || daytime < 8) then 	// After 8pm and before 8am time multiplier changes.
	{
		setTimeMultiplier 10 				// Adjust this value for slower or faster night cycle (10 hours in game will take 1 hour).
	}
	else
	{
		setTimeMultiplier 6 				// Adjust this value for slower or faster day cycle (6 hours in game will take 1 hour).
	};
	uiSleep 60;
};