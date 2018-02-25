class CfgPatches
{
	class exile_server
	{
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"exile_client",
			"exile_assets",
			"exile_server_config"
		};
		units[]={};
		weapons[]={};
		magazines[]={};
		ammo[]={};
	};
};
class CfgFunctions
{
	class ExileServer
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
		class FiniteStateMachine
		{
			file="exile_server\fsm";
			class main
			{
				ext=".fsm";
			};
		};
	};
};
