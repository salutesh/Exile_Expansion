// 1 Vehicles
private _vehicles = [
["Land_Billboard_04_mars_lyfe_F", [12580.8, 7582.7, 29.5802], [0.845141, -0.534544, 0], [0, 0, 1], true],
["Land_FuelStation_02_roof_F", [12576.7, 7617.09, 26.7508], [-0.523507, 0.851574, 0.0276088], [0.0616249, 0.00552529, 0.998084], true],
["Land_FuelStation_02_pump_F", [12574.9, 7616.01, 25.5532], [-0.518109, 0.85488, 0.0272571], [0.0616249, 0.00552529, 0.998084], true],
["Land_FuelStation_02_pump_F", [12578.2, 7618.04, 25.3407], [-0.518109, 0.85488, 0.0272571], [0.0616249, 0.00552529, 0.998084], true]

];

{
    private _vehicle = (_x select 0) createVehicle (_x select 1);
    _vehicle allowDamage false;
    _vehicle setPosWorld (_x select 1);
    _vehicle setVectorDirAndUp [_x select 2, _x select 3];
    _vehicle enableSimulationGlobal (_x select 4);
    _vehicle setVariable ["ExileIsLocked", -1, true];
	
	if (_vehicle isKindOf "Land_Billboard_04_mars_lyfe_F") then
    {
		private _exileSignImage = getText(missionConfigFile >> "CfgExpansion" >> "CfgTextures" >> "ExpansionBillboardImage");
		_vehicle setObjectTextureGlobal [0,_exileSignImage];
		_vehicle setObjectTextureGlobal [1,_exileSignImage];
    };
}
forEach _vehicles;