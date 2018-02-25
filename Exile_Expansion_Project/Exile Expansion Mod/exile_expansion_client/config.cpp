class CfgPatches
{
	class exile_expansion_client
	{
		units[] = {};
		weapons[] = {};
		exile_taunus_client_version = "January 15, 2017";
		requiredVersion = 1.76;
		requiredAddons[] = {"exile_client","exile_assets","exile_expansion_assets"};
	};
};

class CfgMods
{
	class Mod_Base;
	class ExileExpansion: Mod_Base
	{
		picture = "\exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa";
		logo = "\exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa";
		logoOver = "\exile_expansion_assets\texture\mod\Exile_Expansion_Logo.paa";
		tooltipOwned = "Exile Expansion";
		action = "http://www.reality-gaming.eu";
		fieldManualTopicAndHint[] = {"Curator","Curator"};
		dlcColor[] = {0.94,0.28999999,0.98000002,1};
		version = "1.3";
		armaVersion = "170";
		overview = "The Exile Expansion Project aims at customizing and expanding the gameplay content and possibilities of the Exile Mod with various additions.";
		hideName = 1;
		hidePicture = 0;
		name = "Exile Expansion";
		author = "Exile Expansion Mod Team";
		dir = "@ExileExpansion";
	}
};

class CfgFunctions
{
	class ExileExpansionClient
	{
		class Bootstrap
		{
			file="exile_expansion_client\bootstrap";
			class preInit
			{
				preInit=1;
			};
			class postInit
			{
				postInit=1;
			};
		};
	};
};

class CfgExileToasts 
{
	class QuestTitleAndText {
		template = "<img size='25' image='exile_expansion_assets\texture\ui\toast\toast_quest_ca.paa'/><t size='22' font='PuristaMedium'> %1</t><br/><t color='#ffb319' size='19' font='PuristaLight'>%2</t>";
		color[] = {1 ,0.702 ,0.098, 1};
	};
	class ParadropTitleAndText {
		template = "<img size='25' image='exile_expansion_assets\texture\ui\toast\toast_paradrop_ca.paa'/><t size='22' font='PuristaMedium'> %1</t><br/><t color='#ffe400' size='19' font='PuristaLight'>%2</t>";
		color[] = {1, 0.894, 0, 1};
	};
	class VehicleTitleAndText {
		template = "<img size='25' image='exile_expansion_assets\texture\ui\toast\toast_vehicle_ca.paa'/><t size='22' font='PuristaMedium'> %1</t><br/><t color='#ff790c' size='19' font='PuristaLight'>%2</t>";
		color[] = {1, 0.475, 0.047, 1};
	};
	class EventTitleAndText {
		template = "<img size='25' image='exile_expansion_assets\texture\ui\toast\toast_event_ca.paa'/><t size='22' font='PuristaMedium'> %1</t><br/><t color='#ad00ff' size='19' font='PuristaLight'>%2</t>";
		color[] = {0.678, 0, 1, 1};
	};
	class WelcomeTitleAndText {
		template = "<img size='27' image='exile_expansion_assets\texture\ui\toast\toast_welcome_ca.paa'/><t size='22' font='PuristaMedium'> %1</t><br/><t color='#c72651' size='19' font='PuristaLight'>%2</t>";
		color[] = {0.78, 0.149, 0.318, 1};
	};
	class InfosTitleAndText {
		template = "<img size='27' image='exile_expansion_assets\texture\ui\toast\toast_info_ca.paa'/><t size='22' font='PuristaMedium'> %1</t><br/><t color='#3fd4fc' size='19' font='PuristaLight'>%2</t>";
		color[] = {0.247, 0.831, 0.988, 1};
	};
};

class CfgMarkerClasses 
{
	class ExileMarkers {
		displayName = "Exile Markers";
	};
	class ExileExpansionMarkers {
		displayName = "Exile Expansion Markers";
	};
};

class CfgMarkers 
{
	class ExileExpansionMissionIcon
	{
		scope = 2;
		name = "Exile Expansion Mission Icon";
		icon = "exile_expansion_assets\texture\marker\mission_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionQuestIcon
	{
		scope = 2;
		name = "Exile Expansion Quest Icon";
		icon = "exile_expansion_assets\texture\marker\quest_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionLootIcon
	{
		scope = 2;
		name = "Exile Expansion Interactive Loot Icon";
		icon = "exile_expansion_assets\texture\marker\loot_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionBattleZoneIcon
	{
		scope = 2;
		name = "Exile Expansion Battle-Zone Icon";
		icon = "exile_expansion_assets\texture\marker\battlezone_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionEventIcon
	{
		scope = 2;
		name = "Exile Expansion Event Icon";
		icon = "exile_expansion_assets\texture\marker\event_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionWinIcon
	{
		scope = 2;
		name = "Exile Expansion Win Icon";
		icon = "exile_expansion_assets\texture\marker\win_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionLoseIcon
	{
		scope = 2;
		name = "Exile Expansion Lose Icon";
		icon = "exile_expansion_assets\texture\marker\lose_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionTargetIcon
	{
		scope = 2;
		name = "Exile Expansion Target Icon";
		icon = "exile_expansion_assets\texture\marker\target_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionWaterIcon
	{
		scope = 1;
		name = "Exile Expansion Water-Source Icon";
		icon = "exile_expansion_assets\texture\marker\water_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 25;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionTraderIcon
	{
		scope = 1;
		name = "Exile Expansion Water-Source Icon";
		icon = "exile_expansion_assets\texture\marker\trader_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 35;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionAirdropIcon
	{
		scope = 2;
		name = "Exile Expansion Airdrop Event Icon";
		icon = "exile_expansion_assets\texture\marker\airdrop_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
	class ExileExpansionServiceIcon
	{
		scope = 1;
		name = "Exile Expansion Vehicle Service Station Icon";
		icon = "exile_expansion_assets\texture\marker\service_marker_ca.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = false;
		markerClass = "ExileExpansionMarkers";
		showEditorMarkerColor = 0;
	};
};

class CfgFlagsNative 
{
	class RG 
	{
		name = "Reality Gaming";
		texture = "exile_expansion_assets\texture\flag\flag_misc_rg_co.paa";
		uids[] = {};
	};
	class ExileExpansion
	{
		name = "Exile Expansion";
		texture = "exile_expansion_assets\texture\flag\flag_misc_expansion_co.paa";
		uids[] = {};
	};
	class Xcam 
	{
		name = "X-Cam";
		texture = "exile_expansion_assets\texture\flag\flag_misc_xcam_co.paa";
		uids[] = {};
	};
};

class CfgVehicles
{
	// Sign Objects
	class SignAd_Sponsor_F;
	class SignAd_SponsorS_F;
	class Land_Billboard_F;
	class Exile_Expansion_Sign_TraderCity: Land_Billboard_F
	{
		scope=2;
		author="Exile Expansion Mod Team";
		displayName="Exile Expansion Sign (Trader City)";
		hiddenSelectionsTextures[]=
		{
			"exile_expansion_assets\texture\model\Exile_Sign_Expansion.paa"
		};
	};
	// Drones Trader sign
	class Exile_Expansion_Sign_Drones: SignAd_Sponsor_F
	{
		author="Exile Expansion Mod Team";
		displayName="Exile Sign (Drones)";
		hiddenSelectionsTextures[]=
		{
			"exile_expansion_assets\texture\model\Exile_Sign_Drones_co.paa"
		};
	};
	class Exile_Expansion_Sign_Drones_Small: SignAd_SponsorS_F
	{
		author="Exile Expansion Mod Team";
		displayName="Exile Sign (Drones, small)";
		hiddenSelectionsTextures[]=
		{
			"exile_expansion_assets\texture\model\Exile_Sign_Drones_Small_co.paa"
		};
	};
	// Locker sign
	class Exile_Expansion_Sign_Locker_Small: SignAd_SponsorS_F
	{
		author="Exile Expansion Mod Team";
		displayName="Exile Sign (Locker, small)";
		hiddenSelectionsTextures[]=
		{
			"exile_expansion_assets\texture\model\Exile_Sign_Locker_Small_co.paa"
		};
	};
	// Keypad
	class Land_InfoStand_V2_F;
	class Exile_Expansion_Keypad: Land_InfoStand_V2_F
	{
		scope=2;
		author="Exile Expansion Mod Team";
		displayName="Exile Expansion Keypad";
		hiddenSelectionsTextures[]=
		{
			"exile_expansion_assets\texture\model\Exile_Sign_Keypad.paa"
		};
	};
	// Trader Units
	class Exile_Trader_Abstract;
	// Drones Trader
	class Exile_Expansion_Trader_Drones: Exile_Trader_Abstract
	{
		displayName="Exile Drones Trader";
		uniformClass="U_C_IDAP_Man_cargo_F";
		linkedItems[]=
		{
			"V_LegStrapBag_black_F",
			"H_PASGT_basic_white_F",
			"G_EyeProtectors_F",
			"C_IDAP_UAV_06_antimine_backpack_F"
		};
		weapons[]=
		{
			"arifle_CTAR_GL_blk_F"
		};
		class UserActions
		{
			class trade
			{
				displayName="<img image='\a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa' size='1' shadow='false' /> Purchase Drone";
				position="ohniste";
				radius=3;
				priority=6;
				onlyForPlayer=1;
				condition="true";
				statement="this call ExileClient_gui_vehicleTraderDialog_show";
			};
		};
	};
};

class Attributes {};
class RscTitles 
{
	class RscExileExpansionHUD
	{
		idd = -1;
		onLoad = "uiNamespace setVariable ['RscExileExpansionHUD', _this select 0]";
		fadein = 0;
		fadeout = 0;
		duration = 10e10;
		movingEnable = 0;
		objects[] = {};
		class controlsBackground
		{
			class statusBarImage
			{
				idc = 50000;
				type = 0;
				style = 48;
				x = safezoneX + safezoneW - 1.883;
				y = safezoneY + safezoneH - 0.095;
				w = 1.35;
				h = 0.1;
				colorText[] = {1, 1, 1, 1};
				colorBackground[]={0,0,0,0.2};
				sizeEx = 0.4;
				font = "PuristaLight";
				text = "exile_expansion_assets\texture\ui\statusbar\old\statusbar_background_ca.paa";
			};
		};
		class controls 
		{
			class statusBarText 
			{
				idc = 50001;
				x = safezoneX + safezoneW - 1.88;
				y = safezoneY + safezoneH - 0.055;
				w = 1.35;
				h = 0.06;
				shadow = 1;
				colorBackground[] = {0,0,0,0};
				font = "PuristaSemibold";
				size = 0.032;
				type = 13;
				style = 2;
				text="";
				class Attributes 
				{
					align="center";
					color = "#fbfcfe";
					font = "PuristaLight";
				};
			};
		};
	};
};

#include "cfg\CfgExileHoldActions.cpp"