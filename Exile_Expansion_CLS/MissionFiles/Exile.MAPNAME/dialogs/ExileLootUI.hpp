
class ExileLootUI
{
	idd = 20000;
	duration = 1e10;
	fadein = 0;
	fadeout = 0;
	onLoad = "uiNamespace setVariable [ 'ExileLootUI', _this select 0 ];";
	
	class Controls
	{
		class Background
		{
			type = 0;
			idc = 1000;
			x = safeZoneX + safeZoneW * 0.43652344;
			y = safeZoneY + safeZoneH * 0.54513889;
			w = safeZoneW * 0.11132813;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = {0.153,0.153,0.176,0.3};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class SearchText
		{
			type = 0;
			idc = 1001;
			x = safeZoneX + safeZoneW * 0.44335938;
			y = safeZoneY + safeZoneH * 0.55555556;
			w = safeZoneW * 0.09765625;
			h = safeZoneH * 0.02256945;
			style = 2;
			text = "Searching";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,0.706,0.094,1};
			font = "PuristaBold";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class ProgressBar
		{
			type = 8;
			idc = 1002;
			x = 0.44326 * safezoneW + safezoneX;
			y = 0.577007 * safezoneH + safezoneY;
			w = 0.0980062 * safezoneW;
			h = 0.011001 * safezoneH;
			style = 0;
			colorBar[] = {0.78,0.149,0.318,1};
			colorFrame[] = {1,1,1,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
		};
	};
};