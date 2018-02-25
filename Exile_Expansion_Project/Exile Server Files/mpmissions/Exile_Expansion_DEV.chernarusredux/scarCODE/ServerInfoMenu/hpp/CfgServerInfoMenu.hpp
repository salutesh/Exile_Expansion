class CfgServerInfoMenu
{
   addAction = 0; // Enable/disable action menu item | use 0 to disable | default: 1 (enabled)
   antiHACK = "InfiStar + BattlEye + Admins";
   hostedBy = "Reality-Gaming.EU";
   ipPort = "89.163.145.115:2302";
   openKey = "User7"; // https://community.bistudio.com/wiki/inputAction/actions
   openAtLogin = no;
   restart = 3; // Amount of hours before server automatically restarts
   serverName = "DE#001 Exile Expansion Project";
   class menuItems
   {
      // title AND content accept formatted text ( since update Oct5.2016 )
      class first
      {
         menuName = "Server Info";
         title = "<t color='#ffffff'>SERVER INFORMATION</t>";
         content[] = {"<t size='1.25'>COMMING SOON"};
      };
      class second
      {
         menuName = "Server Rules";
         title = "SERVER RULES";
         content[] = {
			"<t size='1' color='#a0df3b'>[1] No excuse for breaking Rules</t><br/>A player breaking rules without knowing them is not an excuse.<br/><br/>If you find someone breaking the rules please contact an admin<br/>on the Reality-Gaming TS3 with an appropriate screenshot<br/>or supporting evidence if at all possible.<br/>",
			"<br />",
			"<t size='1' color='#a0df3b'>[2] Abuse and Trolling</t><br/>No VOIP in global/side chat.<br/>No excessive vulgar language, racism or homophobic slurs.<br/>No music, unnecessary noises, soundboard, or spam over global/side channel.<br/>Side chat is for in game related information between groups only,<br/>all other in game chat not related to game information should be done in group channels only.<br/><br/>If you would like to make any reports please include a screenshot or an audio clip.<br/>",
			"<br />",
			"<t size='1' color='#a0df3b'>[3] No cheating, hacking, or glitching/exploiting</t><br/>Cheating of any kind is not allowed and will not be tolerated.<br/>Exploiting consists of using any game bugs for an unfair advantage.<br/><br/>We will look into all cases and handle them appropriately.<br/>",
			"<br />",
			"<t size='1' color='#a0df3b'>[4] Ramming</t><br/>No ramming vehicles at safe zones.<br/>No catapulting vehicles into bases/safe zones<br/>(Catapulting: using sling load to lift and slingshot them to destroy a base or object).<br/>",
			"<br />",
			"<t size='1' color='#a0df3b'>[5] Safe Zone Rules</t><br/>You are not allowed to steal another players stuff while in a safe zone period.<br/>Do not shoot vehicles from outside the safe zone, Destroying vehicles inside the safe zone is not acceptable.<br/><br/>No camping Trade/Safe Zone(s) Sitting 500m or within 500m away from the safe zone and waiting for people to leave is not acceptable.<br/><br/>No blocking traders from other players by standing too close on purpose (this would be considered trolling).<br/><br/>If a mission is to close to the safe zone and you are baiting the AI to shoot vehicles inside the safe zone is onsider trolling, and is subject to kick/ban from server.<br/><br/>No parking in safe zones for extended periods of time (if a vehicle is left unattended it will be removed from the safe zone at the owners expense).<br/>",
			"<br />",
			"<t size='1' color='#a0df3b'>[6] Base Building</t><br/>No building in high loot areas<br/>(High loot areas include but not limited to major military areas).<br/><br/>Your base may not block a main roadway (ie. an orange road on the map or any other high traffic roads).<br/>No building within 1.5km of any safe zone.<br/>No building in indestructible buildings<br/>(ie. to include but not limited to the Rhein-Main Airport).<br/>Your territory flag has to be on ground level and interactable!<br/>",
			"<br />",
			"<t size='1' color='#a0df3b'>[#] General Note</t><br/>Any behavior deemed to be destructive, offensive, or abusive to the server/players as determined by Admin discretion will be subject to kick and or ban from RG servers.<br/><br/>We will look into all cases and handle them appropriately.<br/><br/>If you wish to appeal a ban or have any questions please create a thread on the forums or log on to our TS3 server at reality-gaming.eu and search for an admin.<br/><br/>*All rules are subject to admin discretion, and are final.<br/>",
			"<br />"
         };
      };
      class third
      {
         menuName = "Controls";
         title = "GAME CONTROLS";
         content[] = {"<t size='1.25'>COMMING SOON"};
      };
      class fourth
      {
         menuName = "Features";
         title = "SERVER FEATURES";
         content[] = {"<t size='1.25'>COMMING SOON"};
      };
      class fifth
      {
         menuName = "Gameplay";
         title = "GAMEPLAY POSSIBILITIES";
         content[] = {"<t size='1.25'>COMMING SOON"};
      };
      class sixth
      {
         menuName = "Community";
         title = "COMMUNITY AND PARTNERS";
         content[] = {
			"<t size='1.25' color='#e24142'>REALITY-GAMING COMMUNITY NETWORK</t>",
			"<br />",
            "<t size='1'>TeamSpeak:</t> reality-gaming.eu<br />",
            "<t size='1'>Website:</t> http://www.reality-gaming.eu<br />"
         };
      };
      class seventh
      {
         menuName = "Credits";
         title = "CREDITS";
         content[] = {
            "<t size='1.25' color='#e24142'>[RG] Salutesh:</t>",
			"<br />",
			"Creator of the Project, Exile Expansion Mod and Server Addons.",
			"<br />",
			"<br />",
            "<t size='1.25' color='#e24142'>Exile Mod-Team:</t>",
			"<br />",
			"Creators of the Exile Mod.",
			"<br />",
			"<br />"
         };
      };
   };
};
