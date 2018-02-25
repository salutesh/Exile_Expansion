/*
    File: ExileBriefing.sqf
    Written by Salutesh
    www.reality-gaming.eu
	
    Description:
	What should i say... 
*/

Exile_Expansion_MissionBriefing = {
	//uiSleep 10;
	waitUntil {!(isNull (findDisplay 46))};

	player createDiarySubject ["Exile","About Exile"];
	player createDiarySubject ["Project","Exile Expansion"];
	player createDiarySubject ["Rules","Server Rules"];
	player createDiarySubject ["Features","Server Features"];

	player createDiaryRecord ["Exile",
		[
			"Credits",
				"
				<br/>
				<img image='exile_assets\texture\mod\logo.paa' width='360' height='360'/>
				<br/>
				<br/><font color='#e24142'>Arma 3 Exile is a Mod by:</font>
				<br/><br/>Exile Mod Team
				<br/>http://www.exilemod.com
				<br/>
				<br/>Niuva - 3D Art, Finland
				<br/>MrWhite - 2D Art, Germany
				<br/>Grim - Programming, Croatia
				<br/>Vishpala - Programming, USA
				<br/>Eichi - Programming, Germany
				<br/>Psycho - Guns and Vehicles, Russian Federation
				<br/>eraser1 - Programming, USA
				<br/>Happydayz - Programming, Australia
				<br/>WolfkillArcadia - Programming, USA
				<br/>maca134 - Programming, United Kingdom
				<br/>Zigga - 3D Artist, Netherlands
				"
		]
	];

	player createDiaryRecord ["Exile",
		[
			"Version",
				"
				<br/><font color='#ffb418'>Exile Mod Version:</font> 1.0.3
				<br/>
				"
		]
	];

	player createDiaryRecord ["Exile",
		[
			"Controls",
				"
				<br/>
				<br/><font color='#e24142'>Main controls:</font>
				<br/>
				<br/>Use the mouse-weel to use interact with traders or use actions on different objects.
				<br/>
				<br/>[1] Switch to primary weapon.
				<br/>[2] Switch to secondary weapon.
				<br/>[3] Switch to melee weapon.
				<br/>[4] Toggle between put away/holding equiped weapon.
				<br/>[5] Toggle Earplugs.
				<br/>[6] Open XM8 Tablet.
				"
		]
	];

	player createDiaryRecord ["Exile",
		[
			"About the Gamemode",
				"
				<br/>
				<br/><font color='#e24142'>Situation:</font>
				<br/>
				<br/>It is the year 2039. After the resource depleting conflict in Greece,
				<br/>Europe suffers from a new deflation crisis,
				<br/>leading the crime rate to a new peak in history.
				<br/>Members of the North Atlantic Treaty Organization Security Council are forced to react.
				<br/>Being a desperate alternative to overcrowded and prohibitive prisons, offenders are now being sent to EXILE.
				<br/>
				<br/><font color='#e24142'>Gameplay Features:</font>
				<br/>
				<br/>- Presistent Survival Open PvP Enviroment
				<br/>- Farming/Looting
				<br/>- Building/Constructions
				<br/>- Trade/Sell and Buy Items, Weapons and Equipment.
				<br/>- Earn respect for different actions to unlock better gear.
				<br/>and much more!
				"
		]
	];

	player createDiaryRecord ["Project",
		[
			"Credits",
				"
				<br/>
				<img image='exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa' width='360' height='360'/>
				<br/>
				<br/><font color='#e24142'>Arma 3 Exile Expansion is a project by:</font>
				<br/><br/>Reality-Gaming Community Network
				<br/>http://www.reality-gaming.eu
				<br/>
				<br/>Salutesh - Mission Design, Code, Mod and more
				"
		]
	];

	player createDiaryRecord ["Project",
		[
			"Version",
				"
				<br/><font color='#ffb418'>Exile Expansion Version:</font> 0.88 Alpha
				<br/>Latest Changes: 07. September 2017
				<br/>
				<br/>Alpha development environment.
				<br/>
				"
		]
	];

	player createDiaryRecord ["Project",
		[
			"About the Exile Expansion Project",
				"
				<br/>
				<br/><font color='#e24142'>The Exile Expansion Project aims at customizing and expanding the gameplay content and possibilities of the Arma 3 Exile Mod with various additions and customizations.</font>
				<br/>
				"
		]
	];

	player createDiaryRecord ["Rules",
		[
			"[#] General Note",
				"
				<br/>Any behavior deemed to be destructive, offensive, or abusive to the server/players as determined by Admin discretion will be subject to kick and or ban from RG servers. 
				<br/>
				<br/>We will look into all cases and handle them appropriately.
				<br/>
				<br/>If you wish to appeal a ban or have any questions please create a thread on the forums or log on to our TS3 server at reality-gaming.eu and search for an admin.
				<br/>
				<br/>*All rules are subject to admin discretion, and are final.
				"
		]
	];	

	player createDiaryRecord ["Rules",
		[
			"[6] Base Building",
				"
				<br/>No building in high loot areas
				<br/>(High loot areas include but not limited to major military areas).
				<br/>
				<br/>Your base may not block a main roadway (ie. an orange road on the map or any other high traffic roads).
				<br/>No building within 1.5km of any safe zone.
				<br/>No building in indestructible buildings 
				<br/>(ie. to include but not limited to the Rhein-Main Airport).
				<br/>Your territory flag has to be on ground level and interactable! 
				"
		]
	];	
		
	player createDiaryRecord ["Rules",
		[
			"[5] Safe Zone Rules",
				"
				<br/>You are not allowed to steal another players stuff while in a safe zone period.
				<br/>Do not shoot vehicles from outside the safe zone, Destroying vehicles inside the safe zone is not acceptable.
				<br/>
				<br/>No camping Trade/Safe Zone(s) Sitting 500m or within 500m away from the safe zone and waiting for people to leave is not acceptable.
				<br/>
				<br/>No blocking traders from other players by standing too close on purpose (this would be considered trolling).
				<br/>
				<br/>If a mission is to close to the safe zone and you are baiting the AI to shoot vehicles inside the safe zone is onsider trolling, and is subject to kick/ban from server.
				<br/>
				<br/>No parking in safe zones for extended periods of time (if a vehicle is left unattended it will be removed from the safe zone at the owners expense).
				"
		]
	];
		
	player createDiaryRecord ["Rules",
		[
			"[4] Ramming",
				"
				<br/>No ramming vehicles at safe zones.
				<br/>No catapulting vehicles into bases/safe zones 
				<br/>(Catapulting: using sling load to lift and slingshot them to destroy a base or object).
				"
		]
	];
		
	player createDiaryRecord ["Rules",
		[
			"[3] No cheating, hacking, or glitching/exploiting",
				"
				<br/>Cheating of any kind is not allowed and will not be tolerated.
				<br/>Exploiting consists of using any game bugs for an unfair advantage.
				<br/>
				<br/>We will look into all cases and handle them appropriately.
				"
		]
	];
		
	player createDiaryRecord ["Rules",
		[
			"[2] Abuse & Trolling",
				"
				<br/>No VOIP in global/side chat.
				<br/>No excessive vulgar language, racism or homophobic slurs.
				<br/>No music, unnecessary noises, soundboard, or spam over global/side channel.
				<br/>Side chat is for in game related information between groups only,
				<br/>all other in game chat not related to game information should be done in group channels only.
				<br/>
				<br/>If you would like to make any reports please include a screenshot or an audio clip.
				"
		]
	];
		
	player createDiaryRecord ["Rules",
		[
			"[1] No excuse for breaking Rules",
				"
				<br/>A player breaking rules without knowing them is not an excuse.
				<br/>
				<br/>If you find someone breaking the rules please contact an admin
				<br/>on the Reality-Gaming TS3 with an appropriate screenshot
				<br/>or supporting evidence if at all possible.
				<br/>
				"
		]
	];

	player createDiaryRecord ["Features",
		[
			"Much more!",
				"
				<br/>
				<br/>We are working hard on the server environment to expand your gameplay experience.
				<br/>Take a look into our forums at www.reality-gaming.eu for the latest updates and changes!
				<br/>
				"
		]
	];

	player createDiaryRecord ["Features",
		[
			"[WIP] Crashsides / Wrecks",
				"
				<br/>
				<br/>There are some rare loot spots on the map. Sometimes you can find a wreck a wreck that has some loot containers nearby!
				<br/>
				"
		]
	];

	player createDiaryRecord ["Features",
		[
			"[WIP] Dynamic/Interactive Missions",
				"
				<br/>
				<br/>Do missions like a mission should be!
				<br/>Handle task objectives and get dynamic interactions within your missions.
				<br/>
				"
		]
	];

	player createDiaryRecord ["Features",
		[
			"[WIP] Interactive Looting",
				"
				<br/>
				<br/>Loot objects/containers in the open game world.
				<br/>At the moment you can find different types of these objects in the upper north-east of the map.
				<br/>
				<br/>Note: Not every object in the world is lootable we will announce a list of object types soon.
				<br/>The Loot-tables for these objects will also get changed in the future to fit to there type.
				<br/>
				"
		]
	];

	player createDiaryRecord ["Features",
		[
			"[WIP] Logistical Systems",
				"
				<br/>
				<br/>Deploy ropes on your vehicles and load different crates into your vehicle cargo.
				<br/>
				<br/>Note: Not all vehicles can load or lift crates. It depends on the vehicle class.
				<br/>
				"
		]
	];
};