/**
 * Created with Exile Mod 3DEN Plugin
 * www.exilemod.com
 */

if (!hasInterface || isServer) exitWith {};

// 30 NPCs
private _npcs = [
["Exile_Expansion_Trader_Drones", ["InBaseMoves_SittingRifle1"], "Exile_Expansion_Trader_Drones", "WhiteHead_03", [["arifle_MXM_Black_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],[],["U_C_ConstructionCoverall_Blue_F",[["30Rnd_65x39_caseless_mag",2,30]]],["V_LegStrapBag_black_F",[["30Rnd_65x39_caseless_mag",1,30]]],["C_UAV_06_backpack_F",[]],"H_PASGT_basic_blue_F","G_Respirator_blue_F",[],["","","","","",""]], [12224.8, 12585.9, 158.969], [-0.951127, 0.308801, 0], [0, 0, 1]],
["Exile_Trader_AircraftCustoms", ["HubStandingUC_idle1","HubStandingUC_idle2","HubStandingUC_idle3","HubStandingUC_move1","HubStandingUC_move2"], "Exile_Trader_AircraftCustoms", "WhiteHead_07", [[],[],[],["U_C_ConstructionCoverall_Black_F",[]],["V_LegStrapBag_black_F",[]],["B_Messenger_Black_F",[]],"H_Construction_headset_black_F","G_Respirator_white_F",[],["","","","","",""]], [12155.3, 12610.9, 158.907], [0.699539, 0.714595, 0], [0, 0, 1]],
["Exile_Trader_Aircraft", ["LHD_krajPaluby"], "Exile_Trader_Aircraft", "WhiteHead_12", [["srifle_DMR_03_F","","","optic_Arco_blk_F",["20Rnd_762x51_Mag",20],[],""],[],[],["U_I_C_Soldier_Bandit_3_F",[["20Rnd_762x51_Mag",1,20]]],["V_DeckCrew_red_F",[]],[],"H_HeadSet_red_F","G_Respirator_white_F",[],["","","","","",""]], [12191.6, 12599.8, 168.42], [0.955952, -0.293523, 0], [0, 0, 1]],
["Exile_Guard_01", ["InBaseMoves_patrolling1"], "", "GreekHead_A3_07", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [12215.5, 12598, 159.001], [0.302403, 0.95318, 0], [0, 0, 1]],
["Exile_Guard_02", ["InBaseMoves_patrolling2"], "", "WhiteHead_08", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [12138.5, 12602.6, 159.558], [-0.35145, -0.936207, 0], [0, 0, 1]],
["Exile_Guard_02", ["InBaseMoves_patrolling1"], "", "WhiteHead_06", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [12188.4, 12600.9, 168.432], [-0.927693, 0.373344, 0], [0, 0, 1]],
["Exile_Trader_VehicleCustoms", ["AidlPercMstpSnonWnonDnon_G01","AidlPercMstpSnonWnonDnon_G02","AidlPercMstpSnonWnonDnon_G03","AidlPercMstpSnonWnonDnon_G04","AidlPercMstpSnonWnonDnon_G05","AidlPercMstpSnonWnonDnon_G06"], "Exile_Trader_VehicleCustoms", "WhiteHead_14", [[],[],[],["U_C_ConstructionCoverall_Black_F",[]],["V_Safety_yellow_F",[]],["B_LegStrapBag_black_F",[]],"H_Bandanna_surfer_blk","G_Bandanna_sport",[],["","","","","",""]], [11450.2, 7554.9, 221.8], [0.964341, -0.264664, 0], [0, 0, 1]],
["Exile_Trader_Vehicle", ["InBaseMoves_repairVehicleKnl","InBaseMoves_repairVehiclePne"], "Exile_Trader_Vehicle", "WhiteHead_08", [[],[],[],["U_C_ConstructionCoverall_Red_F",[]],["V_Safety_yellow_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_marshal","G_Respirator_yellow_F",[],["","","","","",""]], [11449.2, 7534.59, 221.001], [-1, 1.19249e-008, 0], [0, 0, 1]],
["Exile_Trader_WasteDump", ["HubStandingUA_move1","HubStandingUA_move2","HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3"], "Exile_Trader_WasteDump", "WhiteHead_01", [[],[],[],["U_C_ConstructionCoverall_Vrana_F",[]],["V_Safety_orange_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_Orange_IDAP_F","G_Respirator_yellow_F",[],["","","","","",""]], [11455.3, 7509.32, 221.001], [0.974944, 0.22245, 0], [0, 0, 1]],
["Exile_Trader_Office", [], "Exile_Trader_Office", "AfricanHead_02", [[],[],[],["U_BG_Guerilla1_2_F",[]],["V_Rangemaster_belt",[]],[],"H_Hat_Safari_olive_F","G_Bandanna_aviator",[],["","","","","",""]], [11448.1, 7495.71, 221.505], [0.999986, -0.00535812, 0], [0, 0, 1]],
["Exile_Trader_SpecialOperations", ["HubStanding_idle1","HubStanding_idle2","HubStanding_idle3"], "Exile_Trader_SpecialOperations", "WhiteHead_03", [["arifle_MX_Black_F","","","optic_Arco_blk_F",[],[],""],[],[],["U_B_CTRG_1",[]],["V_PlateCarrierGL_blk",[]],["B_ViperLightHarness_blk_F",[]],"H_HelmetB_light_black","G_Bandanna_beast",[],["","","","","","NVGoggles_OPFOR"]], [11454.4, 7487.64, 221.487], [0.959589, 0.281404, 0], [0, 0, 1]],
["Exile_Trader_Hardware", ["InBaseMoves_sitHighUp1"], "Exile_Trader_Hardware", "WhiteHead_14", [["arifle_MX_GL_Black_F","","","optic_Arco_blk_F",["30Rnd_65x39_caseless_mag",30],[],""],[],[],["U_C_Driver_3",[["30Rnd_65x39_caseless_mag",1,30]]],["V_Pocketed_black_F",[["30Rnd_65x39_caseless_mag",2,30]]],["C_IDAP_UAV_01_backpack_F",[]],"H_Construction_headset_orange_F","",[],["","","","","",""]], [11467.9, 7475.17, 221.432], [-0.165323, 0.986239, 0], [0, 0, 1]],
["Exile_Trader_Food", ["InBaseMoves_table1"], "Exile_Trader_Food", "GreekHead_A3_07", [[],[],[],["U_C_IDAP_Man_Jeans_F",[]],["V_LegStrapBag_black_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_Black_IDAP_F","G_Respirator_white_F",[],["","","","","",""]], [11479.5, 7481.38, 221.5], [-0.951889, 0.306443, 0], [0, 0, 1]],
["Exile_Trader_Equipment", ["HubStandingUA_move1","HubStandingUA_move2","HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3"], "Exile_Trader_Equipment", "WhiteHead_06", [["arifle_MX_GL_Black_F","","","optic_Arco_blk_F",[],[],""],[],[],["U_BG_Guerrilla_6_1",[]],["V_I_G_resistanceLeader_F",[]],["B_UAV_06_backpack_F",[]],"H_Booniehat_oli","G_Balaclava_TI_G_tna_F",[],["","","","","",""]], [11452.4, 7482.64, 221.452], [0.958601, -0.284752, 0], [0, 0, 1]],
["Exile_Guard_01", ["InBaseMoves_patrolling1"], "", "WhiteHead_10", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [11478.6, 7551.07, 224.132], [-0.47814, 0.878284, 0], [0, 0, 1]],
["Exile_Guard_01", ["InBaseMoves_patrolling2"], "", "WhiteHead_16", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [11473.5, 7489.58, 233.354], [0, 1, 0], [0, 0, 1]],
["Exile_Guard_01", ["InBaseMoves_patrolling1"], "", "GreekHead_A3_09", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [11465.6, 7498.45, 226.123], [0, 1, 0], [0, 0, 1]],
["Exile_Trader_Equipment", ["HubStandingUA_move1","HubStandingUA_move2","HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3"], "Exile_Trader_Equipment", "GreekHead_A3_09", [["arifle_MX_GL_Black_F","","","optic_Arco_blk_F",[],[],""],[],[],["U_BG_Guerrilla_6_1",[]],["V_I_G_resistanceLeader_F",[]],["B_UAV_06_backpack_F",[]],"H_Booniehat_oli","G_Balaclava_TI_G_tna_F",[],["","","","","",""]], [3819.96, 8945.29, 311.053], [-0.383054, -0.923726, 0], [0, 0, 1]],
["Exile_Trader_SpecialOperations", [], "Exile_Trader_SpecialOperations", "WhiteHead_03", [["arifle_MX_Black_F","","","optic_Arco_blk_F",[],[],""],[],[],["U_B_CTRG_1",[]],["V_PlateCarrierGL_blk",[]],["B_ViperLightHarness_blk_F",[]],"H_HelmetB_light_black","G_Bandanna_beast",[],["","","","","","NVGoggles_OPFOR"]], [3815.71, 8937.98, 311.053], [0.550854, 0.834602, 0], [0, 0, 1]],
["Exile_Trader_Office", ["HubStandingUA_move1","HubStandingUA_move2","HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3"], "Exile_Trader_Office", "WhiteHead_11", [[],[],[],["U_BG_Guerilla1_2_F",[]],["V_Rangemaster_belt",[]],[],"H_Hat_Safari_olive_F","G_Bandanna_aviator",[],["","","","","",""]], [3803.36, 8955.42, 311.053], [0.95263, 0.304133, 0], [0, 0, 1]],
["Exile_Trader_Food", ["HubStandingUA_move1","HubStandingUA_move2","HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3"], "Exile_Trader_Food", "WhiteHead_19", [[],[],[],["U_C_IDAP_Man_Jeans_F",[]],["V_LegStrapBag_black_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_Black_IDAP_F","G_Respirator_white_F",[],["","","","","",""]], [3813.74, 8948.13, 311.053], [-0.366826, -0.93029, 0], [0, 0, 1]],
["Exile_Trader_WasteDump", ["HubStandingUA_move1","HubStandingUA_move2","HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3"], "Exile_Trader_WasteDump", "WhiteHead_16", [[],[],[],["U_C_ConstructionCoverall_Vrana_F",[]],["V_Safety_orange_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_Orange_IDAP_F","G_Respirator_yellow_F",[],["","","","","",""]], [3804, 8964.13, 310.983], [0.93889, -0.344217, 0], [0, 0, 1]],
["Exile_Trader_VehicleCustoms", ["AidlPercMstpSnonWnonDnon_G01","AidlPercMstpSnonWnonDnon_G02","AidlPercMstpSnonWnonDnon_G03","AidlPercMstpSnonWnonDnon_G04","AidlPercMstpSnonWnonDnon_G05","AidlPercMstpSnonWnonDnon_G06"], "Exile_Trader_VehicleCustoms", "GreekHead_A3_09", [[],[],[],["U_C_ConstructionCoverall_Black_F",[]],["V_Safety_yellow_F",[]],["B_LegStrapBag_black_F",[]],"H_Bandanna_surfer_blk","G_Bandanna_sport",[],["","","","","",""]], [3798.62, 8954.62, 310.995], [-0.808011, 0.589168, 0], [0, 0, 1]],
["Exile_Trader_Vehicle", ["InBaseMoves_repairVehicleKnl","InBaseMoves_repairVehiclePne"], "Exile_Trader_Vehicle", "WhiteHead_17", [[],[],[],["U_C_ConstructionCoverall_Red_F",[]],["V_Safety_yellow_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_marshal","G_Respirator_yellow_F",[],["","","","","",""]], [3782.15, 8960.08, 311.086], [0.972824, -0.231544, 0], [0, 0, 1]],
["Exile_Trader_Hardware", ["InBaseMoves_sitHighUp1"], "Exile_Trader_Hardware", "GreekHead_A3_08", [["arifle_MX_GL_Black_F","","","optic_Arco_blk_F",["30Rnd_65x39_caseless_mag",30],[],""],[],[],["U_C_Driver_3",[["30Rnd_65x39_caseless_mag",1,30]]],["V_Pocketed_black_F",[["30Rnd_65x39_caseless_mag",2,30]]],["C_IDAP_UAV_01_backpack_F",[]],"H_Construction_headset_orange_F","",[],["","","","","",""]], [3816.52, 8954.03, 310.958], [0, 1, 0], [0, 0, 1]],
["Exile_Trader_Armory", ["InBaseMoves_SittingRifle1"], "Exile_Trader_Armory", "WhiteHead_01", [["srifle_DMR_06_olive_F","","","optic_AMS_khk",[],[],""],[],[],["U_B_CTRG_Soldier_3_F",[]],["V_Pocketed_olive_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_headphones","G_Bandanna_oli",[],["","","","","",""]], [3802.81, 8948.29, 311.129], [0.015409, -0.999881, 0], [0, 0, 1]],
["Exile_Trader_Armory", ["InBaseMoves_SittingRifle1"], "Exile_Trader_Armory", "WhiteHead_03", [["srifle_DMR_06_olive_F","","","optic_AMS_khk",[],[],""],[],[],["U_B_CTRG_Soldier_3_F",[]],["V_Pocketed_olive_F",[]],["B_LegStrapBag_black_F",[]],"H_Cap_headphones","G_Bandanna_oli",[],["","","","","",""]], [11464.4, 7480.44, 221.578], [-0.774592, 0.632462, 0], [0, 0, 1]],
["Exile_Guard_01", ["InBaseMoves_patrolling1"], "", "WhiteHead_10", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [3819.38, 8937.08, 315.741], [0.627922, -0.778276, 0], [0, 0, 1]],
["Exile_Guard_02", ["InBaseMoves_patrolling2"], "", "WhiteHead_17", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [3827.68, 8944.16, 310.991], [0.49876, -0.86674, 0], [0, 0, 1]],
["Exile_Guard_03", ["InBaseMoves_patrolling1"], "", "GreekHead_A3_09", [["arifle_Mk20_GL_F","","acc_flashlight","optic_ERCO_blk_F",[],[],""],[],[],["U_B_T_Soldier_F",[]],["V_PlateCarrierGL_tna_F",[]],["B_LegStrapBag_olive_F",[]],"H_PASGT_basic_olive_F","G_Respirator_white_F",[],["","","","","",""]], [3801.79, 8952.43, 315.741], [-0.991093, 0.133173, 0], [0, 0, 1]]
];

{
    private _logic = "Logic" createVehicleLocal [0, 0, 0];
    private _trader = (_x select 0) createVehicleLocal [0, 0, 0];
    private _animations = _x select 1;
    
    _logic setPosWorld (_x select 5);
    _logic setVectorDirAndUp [_x select 6, _x select 7];
    
    _trader setVariable ["BIS_enableRandomization", false];
    _trader setVariable ["BIS_fnc_animalBehaviour_disable", true];
    _trader setVariable ["ExileAnimations", _animations];
    _trader setVariable ["ExileTraderType", _x select 2];
    _trader disableAI "ANIM";
    _trader disableAI "MOVE";
    _trader disableAI "FSM";
    _trader disableAI "AUTOTARGET";
    _trader disableAI "TARGET";
    _trader disableAI "CHECKVISIBLE";
    _trader allowDamage false;
    _trader setFace (_x select 3);
    _trader setUnitLoadOut (_x select 4);
    _trader setPosWorld (_x select 5);
    _trader setVectorDirAndUp [_x select 6, _x select 7];
    _trader reveal _logic;
    _trader attachTo [_logic, [0, 0, 0]];
    _trader switchMove (_animations select 0);
    _trader addEventHandler ["AnimDone", {_this call ExileClient_object_trader_event_onAnimationDone}];
}
forEach _npcs;