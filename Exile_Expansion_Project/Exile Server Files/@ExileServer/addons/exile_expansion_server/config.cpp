class CfgPatches
{
	class exile_expansion_server
	{
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"exile_client",
			"exile_assets",
			"exile_server_config",
			"exile_expansion_client",
			"exile_expansion_assets"
		};
		units[]={};
		weapons[]={};
		magazines[]={};
		ammo[]={};
	};
};
class CfgFunctions
{
	class ExileExpansionServer
	{
		class Bootstrap
		{
			file="exile_server\bootstrap";
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
