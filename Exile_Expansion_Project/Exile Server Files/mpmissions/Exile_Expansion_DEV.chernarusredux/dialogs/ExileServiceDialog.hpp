class RscExileVehicleServiceDialog
{
	idd=24008;
	onLoad="uiNamespace setVariable ['RscExileVehicleCustomsDialog', _this select 0]";
	onUnload="call ExileClient_gui_vehicleCustomsDialog_event_onUnload; uiNamespace setVariable ['RscExileVehicleCustomsDialog', displayNull]";
	class controlsBackground
	{
		class DialogBackground: RscText
		{
			idc=1000;
			x="0.5 * safezoneW / 40 + safezoneX";
			y="0.5 * safezoneH / 25 + safezoneY";
			w="8 * safezoneW / 40";
			h="11.5 * safezoneH / 25";
			colorBackground[]={0.050000001,0.050000001,0.050000001,0.69999999};
		};
		class DialogTitle: RscText
		{
			idc=1001;
			text="Purchase Paintjob";
			x="1 * safezoneW / 40 + safezoneX";
			y="1 * safezoneH / 25 + safezoneY";
			w="7 * safezoneW / 40";
			h="1 * safezoneH / 25";
			sizeEx="1 * safezoneH / 25";
		};
		class CancelBackground: RscText
		{
			idc=1002;
			x="0.5 * safezoneW / 40 + safezoneX";
			y="23 * safezoneH / 25 + safezoneY";
			w="8 * safezoneW / 40";
			h="1.5 * safezoneH / 25";
			colorBackground[]={0.050000001,0.050000001,0.050000001,0.69999999};
		};
	};
	class controls
	{
		class VehicleDropDown: RscCombo
		{
			idc=4000;
			x="1 * safezoneW / 40 + safezoneX";
			y="2.1 * safezoneH / 25 + safezoneY";
			w="7 * safezoneW / 40";
			h="0.7 * safezoneH / 25";
			onLBSelChanged="_this call ExileClient_gui_vehicleCustomsDialog_event_onVehicleDropDownSelectionChanged";
		};
		class SkinsListBox: RscExileItemListBox
		{
			idc=4001;
			x="1 * safezoneW / 40 + safezoneX";
			y="2.9 * safezoneH / 25 + safezoneY";
			w="7 * safezoneW / 40";
			h="7 * safezoneH / 25";
			onLBSelChanged="_this call ExileClient_gui_vehicleCustomsDialog_event_onSkinListBoxSelectionChanged";
		};
		class ButtonPurchase: RscButtonMenuOK
		{
			idc=4002;
			text="Purchase now";
			x="1 * safezoneW / 40 + safezoneX";
			y="10.5 * safezoneH / 25 + safezoneY";
			w="7 * safezoneW / 40";
			h="1 * safezoneH / 25";
			sizeEx="0.75 * safezoneH / 25";
			onMouseButtonClick="_this call ExileClient_gui_vehicleCustomsDialog_event_onPurchaseButtonClick";
			class Attributes: Attributes
			{
				align="center";
				valign="middle";
			};
		};
		class CancelButton: RscButtonMenuCancel
		{
			idc=4003;
			x="1 * safezoneW / 40 + safezoneX";
			y="23.5 * safezoneH / 25 + safezoneY";
			w="7 * safezoneW / 40";
			h="0.5 * safezoneH / 25";
			action="closeDialog 0";
			class Attributes: Attributes
			{
				align="center";
			};
		};
	};
};