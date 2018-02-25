/**
 * Created with Exile Mod 3DEN Plugin
 * www.exilemod.com
 */

ExileRouletteChairs = [];
ExileRouletteChairPositions = [];

// 85 Vehicles
private _vehicles = [
["Exile_Sign_Vehicles", [3779.97, 8961.9, 312.123], [-0.897497, 0.44102, 0], [0, 0, 1], false],
["Exile_Expansion_Sign_TraderCity", [3799.16, 8948.23, 317.483], [0.918722, -0.394904, 0], [0, 0, 1], false],
["Exile_Sign_WasteDump", [3802.79, 8964.73, 312.023], [-0.918329, 0.395818, 0], [0, 0, 1], false],
["Exile_Sign_Office", [3807.03, 8952.71, 312.097], [0.91976, -0.392482, 0], [0, 0, 1], false],
["Exile_Sign_VehicleCustoms", [3800.93, 8954.42, 312.035], [0.921904, -0.387419, 0], [0, 0, 1], false],
["Exile_Sign_Armory", [3798.11, 8949.37, 311.055], [-0.918888, 0.394519, 0], [0, 0, 1], false],
["Land_Trophy_01_bronze_F", [3803.41, 8949.21, 311.643], [0.956122, 0.292967, 0], [0, 0, 1], false],
["MapBoard_stratis_F", [3819, 8936.45, 312.022], [0.181515, -0.983388, 0], [0, 0, 1], false],
["Exile_Sign_SpecialOperations_Small", [3816.15, 8937.05, 312.181], [-0.397308, -0.917685, 0], [0, 0, 1], false],
["Land_CampingTable_F", [3817.13, 8937.08, 311.464], [-0.411832, -0.91126, 0], [0, 0, 1], false],
["Land_Laptop_device_F", [3816.91, 8937.27, 312.023], [0.390654, 0.920538, 0], [0, 0, 1], false],
["Intel_Photos_F", [3816.5, 8937.49, 311.868], [-0.49063, -0.871368, 0], [0, 0, 1], false],
["Exile_Expansion_Sign_TraderCity", [3823.84, 8945.67, 317.691], [-0.918004, 0.396571, 0], [0, 0, 1], false],
["Exile_Sign_Equipment", [3820.44, 8946.49, 312.093], [0.390157, 0.920748, 0], [0, 0, 1], false],
["Exile_Sign_Hardware", [3815.64, 8952.43, 311.027], [-0.4019, -0.915684, 0], [0, 0, 1], false],
["Exile_Sign_Food", [3814.25, 8949.11, 312.093], [0.394471, 0.918908, 0], [0, 0, 1], false],
["Land_WaterCooler_01_new_F", [3821.4, 8941.28, 311.784], [0.909838, -0.414963, 0], [0, 0, 1], false],
["Sign_1L_Firstaid", [3819.05, 8947.06, 311.722], [0.399064, 0.916923, 0], [0, 0, 1], false],
["Exile_Expansion_Sign_Locker_Small", [3822.1, 8949.78, 311.584], [0.919554, -0.392963, 0], [0, 0, 1], false],
["Exile_Locker", [3824.21, 8947.96, 311.052], [0.92313, -0.384489, 0], [0, 0, 1], true],
["Exile_Locker", [3821.78, 8946.42, 311.051], [-0.378916, -0.925431, 0], [0, 0, 1], true],
["Exile_Expansion_Sign_TraderCity", [11466.3, 7491.56, 235.162], [-0.29979, -0.954005, 0], [0, 0, 1], false],
["Exile_Expansion_Sign_TraderCity", [11494.9, 7541.93, 222.454], [-0.927184, -0.374607, 0], [0, 0, 1], false],
["Exile_Sign_Armory", [11466.2, 7480.81, 222.623], [0.95874, -0.284283, 0], [0, 0, 1], false],
["Exile_Sign_Armory_Small", [11467.7, 7467.71, 222.141], [0.299074, 0.95423, 0], [0, 0, 1], false],
["Exile_Sign_Equipment", [11451.2, 7482.88, 222.498], [-0.952937, 0.303168, 0], [0, 0, 1], false],
["Exile_Sign_Equipment_Small", [11459.6, 7489.02, 222.434], [-0.299091, -0.954225, 0], [0, 0, 1], false],
["Exile_Sign_SpecialOperations", [11452.8, 7488.19, 222.542], [-0.953932, 0.300023, 0], [0, 0, 1], false],
["Exile_Sign_SpecialOperations_Small", [11459.6, 7489.02, 221.668], [-0.299091, -0.954225, 0], [0, 0, 1], false],
["Exile_Sign_Office", [11446.8, 7492.9, 222.565], [-0.293373, -0.955998, 0], [0, 0, 1], false],
["Exile_Sign_Office_Small", [11451.8, 7493.23, 222.681], [-0.953963, 0.299923, 0], [0, 0, 1], false],
["Exile_Sign_Hardware", [11467.3, 7473.64, 221.49], [-0.298774, -0.954324, 0], [0, 0, 1], false],
["Exile_Sign_Hardware_Small", [11469.3, 7467.2, 222.141], [0.299074, 0.95423, 0], [0, 0, 1], false],
["Exile_Sign_Food", [11481.7, 7479.05, 221.464], [0.951868, -0.306509, 0], [0, 0, 1], false],
["Exile_Sign_Food_Small", [11473.4, 7465.92, 222.141], [0.299074, 0.95423, 0], [0, 0, 1], false],
["Exile_Sign_Food_Small", [11469.4, 7489.21, 222.61], [0.95423, -0.299074, 0], [0, 0, 1], false],
["Exile_Sign_Vehicles", [11451.4, 7530.91, 222.041], [-0.927911, -0.372803, 0], [0, 0, 1], false],
["Exile_Sign_VehicleCustoms", [11448.9, 7554.49, 222.841], [-0.998392, 0.0566799, 0], [0, 0, 1], false],
["Exile_Sign_WasteDump", [11455.5, 7511.17, 222.041], [-0.962758, 0.270365, 0], [0, 0, 1], false],
["Land_WaterCooler_01_new_F", [11472.7, 7478.76, 222.251], [-0.941182, 0.3379, 0], [0, 0, 1], false],
["Land_Trophy_01_silver_F", [11465.5, 7482.83, 222.127], [0.643696, -0.765281, 0.000444494], [-0.000690534, 0, 1], false],
["Land_CampingChair_V2_F", [11464.6, 7480.34, 221.997], [0.817544, -0.575772, 0.0104715], [-0.0103521, 0.00348683, 0.99994], false],
["MapBoard_seismic_F", [11451.8, 7496.88, 222.476], [0.863057, 0.505106, 0], [0, 0, 1], false],
["MapBoard_altis_F", [11454.3, 7489.87, 222.476], [-0.604585, 0.79654, 0], [0, 0, 1], false],
["OfficeTable_01_old_F", [11449.9, 7498, 221.911], [0.277623, 0.96069, 0], [0, 0, 1], false],
["Land_Laptop_unfolded_F", [11452.9, 7486.12, 222.505], [0.517037, 0.855963, 0], [0, 0, 1], false],
["Intel_Photos_F", [11453.1, 7485.59, 222.348], [0, 1, 0], [0, 0, 1], false],
["Land_File1_F", [11447.1, 7496.85, 222.325], [-0.898548, 0.438875, 0], [0, 0, 1], false],
["Exile_Locker", [11470.4, 7489.54, 221.656], [-0.962918, 0.269794, 0], [0, 0, 1], true],
["Exile_Locker", [11474.1, 7487.48, 221.603], [0.965238, -0.261373, 0], [0, 0, 1], true],
["Exile_Expansion_Sign_Locker_Small", [11471.1, 7485.24, 221.803], [0.297142, 0.954833, 0], [0, 0, 1], false],
["Exile_Expansion_Sign_Locker_Small", [11469.5, 7489.22, 221.821], [0.954566, -0.297999, 0], [0, 0, 1], true],
["Exile_Expansion_Sign_TraderCity", [12139.4, 12605.2, 161.104], [0.382309, 0.924035, 0], [0, 0, 1], false],
["Exile_Sign_Aircraft", [12190.3, 12601.6, 169.43], [-0.918428, 0.395588, 0], [0, 0, 1], false],
["Exile_Sign_AircraftCustoms", [12155.8, 12609.4, 159.969], [-0.374315, -0.927302, 0], [0, 0, 1], false],
["Land_CampingTable_white_F", [12219.5, 12586.4, 159.369], [0.953304, -0.30199, 0.00368641], [-0.00625302, -0.00753268, 0.999952], false],
["Land_CampingTable_white_F", [12220.1, 12588.3, 159.395], [0.953278, -0.302036, 0.00589795], [-0.00964885, -0.0109282, 0.999894], false],
["Exile_Expansion_Sign_Drones", [12222.4, 12594.8, 159.594], [-0.358531, -0.933518, 0], [0, 0, 1], false],
["Land_AirConditioner_03_F", [12229, 12593.3, 159.507], [0.330449, 0.943824, 0], [0, 0, 1], true],
["Land_PaperBox_01_small_closed_white_IDAP_F", [12220.4, 12589.5, 159.203], [-0.552464, -0.83348, -0.00975459], [-0.00965152, -0.00530532, 0.999939], false],
["Box_C_UAV_06_F", [12219.4, 12586, 159.868], [-0.996106, -0.0878891, -0.00689104], [-0.00625302, -0.00753268, 0.999952], false],
["Box_C_UAV_06_Swifd_F", [12219.5, 12586.3, 159.871], [-0.991256, -0.131756, -0.00718737], [-0.00624824, -0.00753983, 0.999952], false],
["Box_C_IDAP_UAV_06_F", [12219.4, 12586.2, 160.074], [0.614354, 0.78903, 0], [0, 0, 1], false],
["Land_MedicalTent_01_floor_dark_F", [12222.9, 12588.6, 158.998], [-0.317705, -0.948133, -0.0103625], [0, -0.0109287, 0.99994], true],
["Land_MedicalTent_01_white_generic_open_F", [12223, 12588.7, 160.374], [-0.318629, -0.947823, -0.0103564], [0, -0.0109259, 0.99994], false],
["Exile_Sign_AircraftCustoms_Small", [12158.5, 12602.8, 159.53], [0.366956, 0.930238, 0], [0, 0, 1], false],
["Exile_Sign_Aircraft_Small", [12197.7, 12595.5, 160.587], [-0.922875, 0.385101, 0], [0, 0, 1], false],
["Exile_Expansion_Sign_TraderCity", [12214.6, 12595.6, 160.74], [-0.378793, -0.925481, 0], [0, 0, 1], false],
["Land_Stretcher_01_olive_F", [12224.8, 12585.5, 159.206], [0.339641, 0.940499, 0.0102764], [0, -0.0109259, 0.99994], false],
["Land_MedicalTent_01_floor_light_F", [11446.3, 7534.23, 221], [-0.0877132, 0.996146, 0], [0, 0, 1], true],
["ClutterCutter", [11446.3, 7534.24, 221], [0, 1, 0], [0, 0, 1], true],
["Exile_Sign_Food", [11481.2, 7480.9, 222.525], [0.948804, -0.315864, 0], [0, 0, 1], false],
["Exile_Sign_Hardware", [11467.5, 7474.68, 222.538], [-0.29639, -0.955067, 0], [0, 0, 1], true],
["ClutterCutter", [3788.99, 8958.86, 310.988], [0.419027, 0.907973, -0.00117298], [0, 0.00129187, 0.999999], true],
["Exile_Sign_Hardware", [3816, 8953.33, 312.026], [-0.394054, -0.919087, 0], [0, 0, 1], false],
["Land_CampingChair_V2_white_F", [3802.79, 8948.49, 311.538], [0, 1, -0.000698132], [0, 0.000698132, 1], false],
["CamoNet_INDP_big_F", [11422.9, 7541.37, 222.788], [0.892611, -0.450745, 0.00870111], [-0.0178633, -0.0160765, 0.999711], false],
["Land_LampShabby_F", [11414.3, 7551.38, 226.549], [-0.991698, 0.128586, 0], [0, 0, 1], true],
["Land_CampingTable_F", [11425.9, 7538.23, 221.127], [-0.573834, 0.818966, 0.00291635], [-0.0178633, -0.0160765, 0.999711], false],
["Land_CampingTable_F", [11427.2, 7545.94, 221.253], [-0.642171, -0.765711, -0.0361101], [-0.0309512, -0.0211682, 0.999297], false],
["Land_CampingTable_F", [11426.2, 7537.7, 221.125], [0.562832, -0.826565, -0.00323513], [-0.0178633, -0.0160765, 0.999711], false],
["CamoNet_INDP_big_F", [11424.2, 7560.04, 223.635], [0.990454, 0.134523, -0.0300694], [0.0384601, -0.0602162, 0.997444], false],
["RoadBarrier_F", [11428.9, 7558.69, 221.756], [-0.790675, -0.611342, 0.0330758], [0.0601204, -0.0237658, 0.997908], false],
["RoadBarrier_F", [11428.5, 7560.16, 221.818], [-0.380105, -0.924679, -0.0221284], [0.0601204, -0.0485729, 0.997009], false],
["RoadBarrier_F", [11400.4, 7543.08, 220.911], [0.292408, 0.955743, 0.0324541], [0.0122457, -0.0376768, 0.999215], false]
];

{
    private _vehicle = (_x select 0) createVehicle (_x select 1);
    _vehicle allowDamage false;
    _vehicle setPosWorld (_x select 1);
    _vehicle setVectorDirAndUp [_x select 2, _x select 3];
    _vehicle enableSimulationGlobal (_x select 4);
    _vehicle setVariable ["ExileIsLocked", -1, true];
    
    if (_vehicle isKindOf "Exile_RussianRouletteChair") then
    {
        ExileRouletteChairs pushBack _vehicle;
        ExileRouletteChairPositions pushBack [_x select 1, getDir _vehicle];
    };
}
forEach _vehicles;

// 199 Simple Objects
private _invisibleSelections = ["zasleh", "zasleh2", "box_nato_grenades_sign_f", "box_nato_ammoord_sign_f", "box_nato_support_sign_f"];
private _simpleObjects = [
["ca\weapons\ammoboxes\usspecialweapons.p3d", [3802.43, 8946.23, 312.412], [0.956122, 0.292967, 0], [0, 0, 1]],
["ca\misc_e\misc_tyreheap_ep1.p3d", [3804.7, 8966.37, 311.248], [0.953545, 0.30125, 0], [0, 0, 1]],
["a3\static_f_gamma\hmg_01\hmg_01_f.p3d", [3802.48, 8951.25, 312.25], [-0.828168, 0.56048, 0], [0, 0, 1]],
["a3\structures_f_epb\civ\garbage\garbagecontainer_closed_f.p3d", [3809.77, 8964.76, 311.766], [-0.423773, -0.905769, 0], [0, 0, 1]],
["a3\supplies_f_heli\cargonets\cargonet_01_barrels_f.p3d", [3801.1, 8956.65, 311.519], [0.918605, -0.395177, 0], [0, 0, 1]],
["a3\structures_f\civ\market\sacks_heap_f.p3d", [3808.68, 8945.17, 311.451], [-0.39261, -0.919705, 0], [0, 0, 1]],
["a3\structures_f\furniture\tabledesk_f.p3d", [3803.07, 8957.26, 311.459], [0.92416, -0.382006, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\weldingtrolley_01_f.p3d", [3781.47, 8963.85, 311.784], [-0.381345, 0.924433, 0], [0, 0, 1]],
["ca\weapons\ammoboxes\usbasicammo.p3d", [3803.6, 8949.16, 311.282], [-0.0629648, -0.998016, 0], [0, 0, 1]],
["ca\misc_acr\targets\target_figure_static_acr.p3d", [3804.01, 8950.16, 311.054], [0.270406, 0.962747, 0], [0, 0, 1]],
["exile_assets\model\exile_container_safe.p3d", [3808.03, 8955.82, 311.056], [0.400264, 0.9164, 0], [0, 0, 1]],
["ca\misc_e\map_for_briefing.p3d", [3802.59, 8957.46, 312.547], [-0.918833, 0.394647, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\tooltrolley_01_f.p3d", [3783.72, 8965.07, 311.58], [0.788225, 0.615388, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\tooltrolley_01_f.p3d", [3799, 8952.65, 311.488], [-0.962066, -0.272818, 0], [0, 0, 1]],
["ca\buildings\furniture\armchair.p3d", [3802.03, 8953.47, 311.057], [-0.970114, -0.24265, 0], [0, 0, 1]],
["ca\structures\furniture\kitchen\fridge\fridge.p3d", [3808.86, 8951.18, 311.056], [-0.41196, -0.911202, 0], [0, 0, 1]],
["ca\misc\barel1.p3d", [3801.65, 8957.86, 311.567], [-0.962066, -0.272818, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\gastank_02_f.p3d", [3781.95, 8965.14, 311.953], [0.230865, -0.972986, 0], [0, 0, 1]],
["ca\misc\terc_postava.p3d", [3804.93, 8950.63, 311.686], [-0.341282, -0.939961, 0], [0, 0, 1]],
["a3\structures_f\civ\market\cratesplastic_f.p3d", [3807.68, 8951.57, 311.288], [0.392568, 0.919723, 0], [0, 0, 1]],
["a3\structures_f\furniture\chairwood_f.p3d", [3803.53, 8956.98, 311.051], [0.956122, 0.292967, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_interier\canister_ep1.p3d", [3800.56, 8954.48, 311.362], [-0.387483, -0.921877, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_interier\canister_ep1.p3d", [3800.71, 8955.05, 311.361], [0.916788, -0.399373, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\gastank_01_yellow_f.p3d", [3781.45, 8964.85, 311.419], [0.230865, -0.972986, 0], [0, 0, 1]],
["a3\structures_f_epb\items\military\magazine_rifle_f.p3d", [3803.85, 8949.08, 311.511], [0.235285, 0.971927, 0], [0, 0, 1]],
["a3\structures_f_epb\items\military\magazine_rifle_f.p3d", [3803.81, 8949.19, 311.511], [0.956122, 0.292967, 0], [0, 0, 1]],
["a3\drones_f\air_f_gamma\uav_01\uav_01_f.p3d", [3817.54, 8936.92, 312.016], [-0.408617, -0.912706, 0], [0, 0, 1]],
["ca\misc3\satelitephone\satellitephone.p3d", [3817.55, 8936.93, 311.24], [-0.433439, -0.901183, 0], [0, 0, 1]],
["a3\structures_f\items\documents\file1_f.p3d", [3816.38, 8937.18, 311.877], [0.956122, 0.292967, 0], [0, 0, 1]],
["a3\structures_f\mil\bagfence\bagfence_round_f.p3d", [3827.82, 8943.01, 311.412], [-0.34366, 0.939094, 0], [0, 0, 1]],
["a3\structures_f\mil\bagfence\bagfence_round_f.p3d", [3828.72, 8945.32, 311.409], [-0.876685, -0.481065, 0], [0, 0, 1]],
["a3\structures_f_epa\mil\scrapyard\pallet_milboxes_f.p3d", [3821.37, 8943.02, 311.502], [-0.904567, 0.426332, 0], [0, 0, 1]],
["a3\structures_f_epa\mil\scrapyard\paperbox_open_full_f.p3d", [3822.34, 8944.76, 311.66], [-0.366095, -0.930577, 0], [0, 0, 1]],
["a3\supplies_f_heli\cargonets\cargonet_01_box_f.p3d", [3814.18, 8955.03, 311.664], [-0.417217, -0.908807, 0], [0, 0, 1]],
["a3\structures_f\civ\market\sacks_goods_f.p3d", [3813.45, 8942.93, 311.55], [0.999917, 0.0128872, 0], [0, 0, 1]],
["a3\structures_f\civ\market\sacks_heap_f.p3d", [3811.22, 8943.94, 311.446], [-0.917123, 0.398605, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_market\crates_stack_ep1.p3d", [3817.84, 8946.91, 311.812], [-0.913467, 0.406912, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_market\crates_stack_ep1.p3d", [3818.17, 8952.96, 311.792], [-0.89316, 0.44974, 0], [0, 0, 1]],
["a3\structures_f_epb\items\luggage\luggageheap_02_f.p3d", [3821.12, 8945.6, 311.359], [0.956122, 0.292967, 0], [0, 0, 1]],
["a3\structures_f\civ\market\cratesplastic_f.p3d", [3815.71, 8946.38, 311.286], [-0.926331, 0.376709, 0], [0, 0, 1]],
["ca\structures\furniture\cases\metalcrate\metalcrate.p3d", [3819.39, 8946.32, 311.052], [0.341922, 0.939728, 0], [0, 0, 1]],
["ca\structures\furniture\cases\metalcrate_02\metalcrate_02.p3d", [3819.25, 8952.5, 311.353], [-0.999503, 0.0315152, 0], [0, 0, 1]],
["ca\structures\furniture\cases\metalcrate_02\metalcrate_02.p3d", [3818.77, 8946.56, 311.372], [0.404308, 0.914623, 0], [0, 0, 1]],
["a3\structures_f_epa\mil\scrapyard\paperbox_open_full_f.p3d", [11451.2, 7480.71, 222.057], [-0.286257, -0.958153, 0], [0, 0, 1]],
["exile_assets\model\exile_container_storagecrate.p3d", [11458.7, 7477.97, 221.516], [0.956707, -0.291053, 0], [0, 0, 1]],
["exile_assets\model\exile_container_storagecrate.p3d", [11459.8, 7477.66, 221.528], [-0.297125, -0.954839, 0], [0, 0, 1]],
["a3\structures_f_heli\items\food\tableware_01_cup_f.p3d", [11454, 7483.54, 222.383], [0, 1, 0], [0, 0, 1]],
["a3\structures_f_epa\mil\scrapyard\paperbox_open_full_f.p3d", [11468, 7481.1, 222.188], [-0.632192, -0.774812, 0], [0, 0, 1]],
["ca\misc2\gunrack1.p3d", [11462.8, 7476.56, 222.038], [0.949566, -0.313565, -0.0014873], [-0.00215619, -0.0112725, 0.999934]],
["ca\weapons\ammoboxes\uslaunchers.p3d", [11465.5, 7486.11, 222.561], [-0.908974, -0.416852, 0], [0, 0, 1]],
["ca\weapons\ammoboxes\usbasicweapons.p3d", [11461.8, 7481.86, 222.826], [-0.959986, 0.280047, 0], [0, 0, 1]],
["ca\weapons\ammoboxes\usspecialweapons.p3d", [11461.9, 7482.74, 222.884], [0.955931, -0.29359, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_market\crates_ep1.p3d", [11461.8, 7487.19, 222.191], [0.369195, 0.929352, 0], [0, 0, 1]],
["ca\misc2\gunrack2.p3d", [11461.9, 7476.08, 221.891], [0.94732, -0.320285, -0.0015679], [-0.00215619, -0.0112725, 0.999934]],
["ca\weapons\ammoboxes\usbasicammo.p3d", [11465.4, 7482.78, 221.766], [0.967648, -0.252306, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_interier\shelf_ep1.p3d", [11464.1, 7486.55, 221.999], [0.957752, -0.287594, 0], [0, 0, 1]],
["a3\structures_f\items\luggage\suitcase_f.p3d", [11464.4, 7479.74, 221.814], [-0.00232107, 0.999997, 0], [0, 0, 1]],
["exile_assets\model\exile_container_storagecrate.p3d", [11467.2, 7485.74, 221.509], [0.94167, -0.336537, 0], [0, 0, 1]],
["a3\structures_f_epb\items\military\magazine_rifle_f.p3d", [11465.2, 7482.6, 221.995], [4.98972e-005, 1, 3.44557e-008], [-0.000690534, 0, 1]],
["a3\structures_f_epb\items\military\magazine_rifle_f.p3d", [11465.2, 7482.48, 221.995], [0.964888, -0.262661, 0.000666288], [-0.000690534, 0, 1]],
["a3\structures_f_heli\items\food\tableware_01_cup_f.p3d", [11465.3, 7482.98, 222.033], [-0.00155336, 0.999999, -1.07265e-006], [-0.000690534, 0, 1]],
["ca\buildings\furniture\kitchen_table_a.p3d", [11477.1, 7474.26, 221.454], [-0.32215, -0.946689, 0], [0, 0, 1]],
["a3\structures_f\furniture\chairplastic_f.p3d", [11477.5, 7475.47, 221.939], [0.781161, -0.62433, 0], [0, 0, 1]],
["a3\structures_f\furniture\chairplastic_f.p3d", [11476.7, 7473.16, 221.934], [-0.946818, 0.32177, 0], [0, 0, 1]],
["a3\structures_f\civ\market\cratesplastic_f.p3d", [11471.6, 7474.12, 221.695], [0, 1, 0], [0, 0, 1]],
["a3\structures_f\civ\market\cratesshabby_f.p3d", [11476, 7483.03, 220.935], [-0.330926, -0.943657, 0], [0, 0, 1]],
["a3\structures_f\civ\market\sacks_heap_f.p3d", [11474.5, 7483.46, 221.95], [0.257237, 0.966348, 0], [0, 0, 1]],
["a3\structures_f_epa\mil\scrapyard\pallet_milboxes_f.p3d", [11455.2, 7480.27, 221.922], [0.944589, -0.328257, 0], [0, 0, 1]],
["a3\structures_f_epa\civ\camping\woodentable_large_f.p3d", [11452.8, 7485.34, 221.911], [-0.292372, -0.956305, 0], [0, 0, 1]],
["a3\structures_f\furniture\tabledesk_f.p3d", [11446.8, 7496.26, 221.901], [0.958397, -0.285437, 0], [0, 0, 1]],
["a3\structures_f_epb\items\luggage\luggageheap_02_f.p3d", [11454.9, 7483.54, 221.764], [-0.935666, -0.352887, 0], [0, 0, 1]],
["a3\structures_f_epb\items\luggage\luggageheap_01_f.p3d", [11452.6, 7484.68, 222.853], [-0.940822, 0.338902, 0], [0, 0, 1]],
["ca\structures\furniture\chairs\office_chair\office_chair.p3d", [11446.9, 7494.51, 221.906], [-0.967166, -0.254147, 0], [0, 0, 1]],
["ca\misc3\satelitephone\satellitephone.p3d", [11456.6, 7489.25, 221.672], [0.340165, 0.940366, 0], [0, 0, 1]],
["a3\structures_f\items\documents\file2_f.p3d", [11452.7, 7485.67, 222.352], [-0.257099, -0.966385, 0], [0, 0, 1]],
["ca\misc\barels.p3d", [11445.8, 7542.35, 221.702], [0.892413, 0.45122, 0], [0, 0, 1]],
["a3\supplies_f_heli\cargonets\cargonet_01_barrels_f.p3d", [11450, 7557.54, 222.328], [0.999018, 0.044299, 0.000912594], [-0.00091349, 0, 1]],
["a3\structures_f\items\vessels\metalbarrel_f.p3d", [11446.6, 7541.16, 221.423], [0, 1, 0], [0, 0, 1]],
["a3\structures_f_epb\items\vessels\barrelsand_grey_f.p3d", [11451.4, 7531.62, 221.405], [0, 1, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_interier\canister_ep1.p3d", [11449.3, 7554.23, 222.167], [-0.0391594, -0.999233, -3.57717e-005], [-0.00091349, 0, 1]],
["ca\structures_e\misc\misc_interier\canister_ep1.p3d", [11449.4, 7554.96, 222.168], [0.0190623, 0.999818, 1.74132e-005], [-0.00091349, 0, 1]],
["a3\structures_f\items\vessels\bucket_painted_f.p3d", [11449.3, 7553.61, 221.937], [0.0190623, 0.999818, 1.74132e-005], [-0.00091349, 0, 1]],
["a3\structures_f_heli\civ\constructions\gastank_02_f.p3d", [11447.3, 7543.26, 221.865], [0, 1, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\weldingtrolley_01_f.p3d", [11449, 7537.71, 221.696], [-0.754687, 0.656085, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\gastank_01_yellow_f.p3d", [11448, 7543.37, 221.339], [0, 1, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\tooltrolley_01_f.p3d", [11450, 7530.51, 221.492], [-0.104758, -0.994498, 0], [0, 0, 1]],
["a3\structures_f_epa\items\tools\fireextinguisher_f.p3d", [11450.6, 7531.89, 221.385], [0, 1, 0], [0, 0, 1]],
["a3\drones_f\air_f_gamma\uav_01\uav_01_f.p3d", [11455.7, 7489.46, 221.654], [0.152336, 0.988329, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\weldingtrolley_01_f.p3d", [11418.8, 7545.02, 221.468], [-0.934138, -0.356578, -0.0154457], [0.000488281, -0.0445525, 0.999007]],
["a3\supplies_f_heli\cargonets\cargonet_01_barrels_f.p3d", [12161.4, 12608.2, 159.462], [-0.343528, -0.939142, 0], [0, 0, 1]],
["a3\structures_f_heli\civ\constructions\tooltrolley_01_f.p3d", [12159.5, 12608.6, 159.424], [-0.94147, 0.337095, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_interier\canister_ep1.p3d", [12157.2, 12609.3, 159.298], [-0.911324, 0.411689, 0], [0, 0, 1]],
["ca\structures_e\misc\misc_interier\canister_ep1.p3d", [12156.5, 12609.5, 159.295], [0, 1, 0], [0, 0, 1]],
["ca\misc\barel1.p3d", [12154.6, 12610.4, 159.491], [0, 1, 0], [0, 0, 1]],
["ca\misc3\fort_bagfence_round.p3d", [12138, 12601.7, 159.95], [-0.365884, -0.925143, 0.101189], [0.037733, 0.0938919, 0.994867]],
["a3\structures_f\wrecks\wreck_heli_attack_02_f.p3d", [12172.3, 12589.7, 161.759], [0, 1, 0], [0, 0, 1]],
["a3\structures_f\mil\helipads\helipadcircle_f.p3d", [12168.4, 12638, 158.993], [-0.365836, -0.930679, 0], [0, 0, 1]],
["a3\structures_f\mil\helipads\helipadsquare_f.p3d", [12205, 12625.7, 158.995], [-0.379289, -0.925278, 0], [0, 0, 1]],
["a3\structures_f_epa\civ\camping\woodentable_small_f.p3d", [12226.7, 12591.2, 159.432], [-0.259325, -0.96579, 0], [0, 0, 1]],
["a3\structures_f\items\tools\screwdriver_v2_f.p3d", [12226.5, 12591.1, 159.867], [1, -4.37114e-008, 0], [0, 0, 1]],
["plp_containers\stctoolboxes\plp_cts_toolboxreddirty.p3d", [12226.6, 12591.5, 160.028], [0.995144, 0.098434, 0], [0, 0, 1]],
["a3\data_f\particleeffects\craterlong\craterlong.p3d", [12173, 12585.3, 159.12], [0, 0.999606, -0.0280787], [0.0265956, 0.0280687, 0.999252]],
["ca\misc3\fort_bagfence_round.p3d", [12215.9, 12598.8, 159.294], [0.377297, 0.926092, 0], [0, 0, 1]],
["a3\air_f_orange\uav_06\uav_06_f.p3d", [12220, 12587.8, 160.045], [0, 1, 0], [0, 0, 1]],
["a3\drones_f\weapons_f_gamma\items\uav_controller_civ_f.p3d", [12220.3, 12588.5, 159.844], [0.0307584, -0.0124136, 0.99945], [-0.923113, 0.383095, 0.0331674]],
["plp_containers\stccontainers\plp_cts_contplaintan.p3d", [12229.7, 12585.7, 160.093], [0.223488, 0.974648, 0.0106495], [0, -0.0109259, 0.99994]],
["a3\props_f_orange\humanitarian\supplies\paperbox_01_small_stacked_f.p3d", [12221.8, 12592.7, 159.72], [0.63122, 0.775604, 0], [0, 0, 1]],
["a3\structures_f\wrecks\wreck_van_f.p3d", [11446.8, 7534.96, 222.009], [0.0792419, -0.996855, 0], [0, 0, 1]],
["a3\structures_f_heli\furniture\workbench_01_f.p3d", [11467.7, 7475.27, 222.001], [-0.305047, -0.952337, 0], [0, 0, 1]],
["plp_containers\stctoolboxes\plp_cts_toolboxblackdirty.p3d", [11468.5, 7474.79, 222.484], [0.402283, -0.915515, 0], [0, 0, 1]],
["a3\structures_f\furniture\cashdesk_f.p3d", [11478.9, 7481.8, 221.308], [0.95103, -0.308919, -0.0105039], [0.00742888, -0.0111287, 0.99991]],
["a3\structures_f_heli\items\food\ketchup_01_f.p3d", [11478.8, 7482.07, 222.426], [0, 1, 0], [0, 0, 1]],
["a3\structures_f_heli\items\food\mustard_01_f.p3d", [11478.8, 7482.12, 222.425], [-0.3848, 0.923, 0], [0, 0, 1]],
["a3\structures_f\furniture\icebox_f.p3d", [11480.7, 7481.08, 222.111], [0.951819, -0.306533, -0.00883773], [0.00585917, -0.0106358, 0.999926]],
["a3\structures_f_heli\items\electronics\microwave_01_f.p3d", [11479.2, 7482.39, 222.411], [0.303318, 0.952889, 0], [0, 0, 1]],
["a3\props_f_orange\humanitarian\supplies\waterbottle_01_pack_f.p3d", [11480.6, 7480.41, 222.212], [0, 1, 0], [0, 0, 1]],
["a3\props_f_orange\humanitarian\supplies\waterbottle_01_pack_f.p3d", [11480.6, 7480.66, 222.195], [0.911109, 0.412166, 0], [0, 0, 1]],
["a3\structures_f_orange\humanitarian\camps\medicaltent_01_floor_light_f.p3d", [3786.65, 8959.4, 310.987], [-0.433423, -0.90119, 0.00116393], [0, 0.00129154, 0.999999]],
["a3\structures_f\wrecks\wreck_cardismantled_f.p3d", [3784.16, 8959.63, 311.871], [0.175248, 0.984523, -0.00127188], [0, 0.00129187, 0.999999]],
["a3\props_f_orange\civilian\constructions\cinderblock_01_f.p3d", [3783.66, 8961.66, 311.092], [-0.170974, 0.985275, -0.00127285], [0, 0.00129187, 0.999999]],
["a3\soft_f_orange\van_02\van_02_transport_tire_f.p3d", [3782.64, 8958.24, 311.137], [0, 0.999999, -0.00129187], [0, 0.00129187, 0.999999]],
["a3\structures_f_heli\furniture\workbench_01_f.p3d", [3816.36, 8954.08, 311.527], [-0.410544, -0.911841, 0], [0, 0, 1]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11428.1, 7535.26, 221.976], [0.609259, -0.792836, 0.0146674], [-0.05874, -0.0266777, 0.997917]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11427.3, 7548.04, 222.1], [0.6071, 0.794408, 0.0186041], [-0.0188154, -0.00903464, 0.999782]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11420.5, 7532.83, 221.555], [-0.12849, -0.991014, -0.0371808], [-0.0385052, -0.0324779, 0.99873]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11419, 7550.8, 222.321], [-0.128576, -0.990016, -0.0577644], [0.012084, -0.0598076, 0.998137]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11414.9, 7536.06, 221.51], [-0.922496, -0.38215, -0.0544251], [-0.0370226, -0.0527507, 0.997921]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11426.8, 7552.73, 222.253], [0.38449, -0.922118, -0.0431873], [0.00182659, -0.0460235, 0.998939]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11430.9, 7542.07, 222.14], [0.990865, 0.132403, 0.0256291], [-0.0255243, -0.00248858, 0.999671]],
["a3\structures_f\civ\garbage\garbage_square5_f.p3d", [11416.9, 7553.27, 221.252], [-0.610313, 0.79038, 0.0530874], [-0.000845728, -0.0676661, 0.997708]],
["a3\structures_f\mil\bagfence\bagfence_round_f.p3d", [11408.9, 7540.16, 220.732], [0.991361, -0.129715, 0.019412], [-0.026074, -0.0498594, 0.998416]],
["a3\structures_f\mil\bagfence\bagfence_round_f.p3d", [11410, 7538.11, 220.662], [0.380779, 0.923243, 0.0512867], [-0.0224277, -0.0462273, 0.998679]],
["a3\structures_f_epb\civ\garbage\garbagecontainer_open_f.p3d", [11419.2, 7552.48, 221.926], [0.128554, 0.989875, 0.0601773], [0.0227439, -0.0636077, 0.997716]],
["a3\structures_f_epa\mil\scrapyard\paperbox_open_full_f.p3d", [11423.7, 7553.74, 221.804], [0.607116, 0.793839, 0.0350646], [0.0173897, -0.0573908, 0.9982]],
["a3\structures_f_epa\mil\scrapyard\paperbox_open_empty_f.p3d", [11416.7, 7536.93, 221.017], [-0.60996, 0.792129, 0.0219235], [-0.0339894, -0.0537934, 0.997973]],
["a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d", [11423.4, 7535.08, 221.186], [-0.793785, 0.608115, -0.010068], [-0.0436873, -0.0404993, 0.998224]],
["a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d", [11425.7, 7554.55, 221.785], [-0.132411, 0.989962, 0.0494295], [0.0288035, -0.0460045, 0.998526]],
["a3\structures_f_epa\civ\constructions\pallets_stack_f.p3d", [11413.2, 7540.86, 220.908], [0.384286, -0.922722, -0.030125], [-0.0338665, -0.046698, 0.998335]],
["a3\structures_f\walls\cncbarrier_f.p3d", [11428.6, 7542.18, 221.249], [0.791695, 0.610145, 0.0307036], [-0.0342774, -0.00581474, 0.999395]],
["a3\structures_f\walls\cncbarrier_f.p3d", [11427.8, 7540.15, 221.208], [-0.380651, -0.924515, -0.0193992], [-0.0342756, -0.0068579, 0.999389]],
["a3\structures_f\walls\cncbarrier_stripes_f.p3d", [11428, 7541.2, 221.221], [-0.606851, -0.794381, -0.0262641], [-0.0342756, -0.0068579, 0.999389]],
["a3\structures_f\mil\bagfence\bagfence_short_f.p3d", [11412, 7538.23, 220.722], [-0.384227, 0.92269, 0.0318251], [-0.0370226, -0.0498421, 0.998071]],
["a3\structures_f\civ\constructions\pallet_vertical_f.p3d", [11415.6, 7549.67, 221.719], [-0.1286, -0.989476, -0.066327], [-0.0070251, -0.0659717, 0.997797]],
["a3\structures_f\civ\constructions\pallet_vertical_f.p3d", [11421.5, 7534.29, 221.175], [-0.00442756, -0.998531, -0.0539929], [-0.0385037, -0.0537831, 0.99781]],
["a3\structures_f_heli\civ\market\pallettrolley_01_khaki_f.p3d", [11423.3, 7554.05, 221.857], [0.634017, 0.772598, 0.0333747], [0.0173897, -0.0573908, 0.9982]],
["a3\structures_f\furniture\metal_rack_tall_f.p3d", [11429.2, 7544.34, 220.884], [-0.922626, -0.384563, -0.0295257], [-0.0309492, -0.0024882, 0.999518]],
["a3\structures_f\civ\market\sack_f.p3d", [11414.3, 7551.92, 221.512], [0.610288, -0.790795, -0.0468068], [-0.00895691, -0.0659707, 0.997781]],
["a3\structures_f\items\electronics\portable_generator_f.p3d", [11421.9, 7552.88, 221.517], [-0.991437, 0.126925, 0.0306927], [0.0227439, -0.0636077, 0.997716]],
["a3\structures_f\mil\bagfence\bagfence_end_f.p3d", [11409.7, 7541.56, 220.813], [-0.610106, 0.791942, 0.0244831], [-0.0260717, -0.05095, 0.998361]],
["a3\structures_f\civ\camping\campingchair_v1_f.p3d", [11426.5, 7545.85, 221.326], [-0.922633, -0.383928, -0.0367095], [-0.0309512, -0.0211682, 0.999297]],
["a3\structures_f\civ\camping\campingchair_v1_f.p3d", [11426, 7537.11, 221.202], [0.384287, -0.92312, -0.0131873], [-0.0298777, -0.0267119, 0.999197]],
["a3\structures_f\civ\camping\campingchair_v1_f.p3d", [11424.6, 7537.48, 221.171], [-0.791647, -0.609615, -0.040808], [-0.0298777, -0.028085, 0.999159]],
["a3\structures_f\civ\camping\campingchair_v1_f.p3d", [11425.8, 7539.33, 221.239], [-0.132648, 0.99107, 0.0135673], [-0.0178633, -0.0160765, 0.999711]],
["a3\structures_f\civ\camping\campingchair_v1_f.p3d", [11427.6, 7538.47, 221.29], [0.990229, 0.131912, 0.0452202], [-0.0434769, -0.0160676, 0.998925]],
["a3\structures_f\items\vessels\metalbarrel_f.p3d", [11413.3, 7550.74, 221.451], [-0.991155, -0.13154, -0.0175945], [-0.00895691, -0.0659707, 0.997781]],
["a3\structures_f\items\vessels\metalbarrel_f.p3d", [11413.8, 7550.15, 221.416], [0.791993, 0.608691, 0.0473546], [-0.00895691, -0.0659707, 0.997781]],
["a3\structures_f\items\vessels\metalbarrel_f.p3d", [11414.1, 7550.73, 221.457], [-0.128719, -0.989444, -0.0665749], [-0.00895691, -0.0659707, 0.997781]],
["a3\structures_f_epb\items\vessels\barreltrash_grey_f.p3d", [11417.8, 7552.24, 221.584], [-0.610313, 0.790773, 0.0468662], [-0.000845728, -0.0598129, 0.998209]],
["a3\structures_f\civ\camping\campingchair_v1_folded_f.p3d", [11424.5, 7547.97, 220.936], [-0.132465, 0.990954, 0.0215442], [0.00417166, -0.0211782, 0.999767]],
["a3\structures_f\civ\camping\campingchair_v1_folded_f.p3d", [11424.9, 7547.33, 220.921], [-0.610308, 0.791929, 0.0193221], [0.00417166, -0.0211782, 0.999767]],
["a3\structures_f\items\luggage\suitcase_f.p3d", [11426.5, 7555.65, 221.414], [-0.828508, -0.559452, -0.0242603], [0.00182659, -0.0460235, 0.998939]],
["a3\structures_f_epa\items\vessels\tincontainer_f.p3d", [11426, 7555.49, 221.256], [-0.136867, -0.989713, -0.0416505], [0.0288035, -0.0460045, 0.998526]],
["a3\structures_f_epa\items\vessels\tincontainer_f.p3d", [11426.6, 7538.85, 220.851], [0.78835, -0.614742, 0.0244238], [-0.0434769, -0.0160676, 0.998925]],
["a3\structures_f_epa\items\food\bottleplastic_v2_f.p3d", [11424.9, 7538.19, 220.824], [-0.443857, 0.896018, 0.0119133], [-0.0298777, -0.028085, 0.999159]],
["a3\structures_f_epa\items\food\bottleplastic_v2_f.p3d", [11424.9, 7538.09, 220.82], [-0.382582, 0.923807, 0.0145267], [-0.0298777, -0.028085, 0.999159]],
["a3\structures_f\items\food\bottleplastic_v1_f.p3d", [11425.8, 7555.75, 221.272], [0.583697, 0.811711, 0.0205602], [0.0288035, -0.0460045, 0.998526]],
["a3\structures_f\walls\cncbarriermedium4_f.p3d", [11418.1, 7566.66, 222.953], [-0.610313, 0.79216, 0], [0, 0, 1]],
["a3\structures_f\walls\cncbarriermedium_f.p3d", [11411.4, 7561.02, 222.586], [-0.794544, 0.607207, 0], [0, 0, 1]],
["a3\structures_f\walls\cncbarriermedium_f.p3d", [11412.7, 7562.36, 222.694], [-0.610313, 0.79216, 0], [0, 0, 1]],
["a3\structures_f\civ\market\sacks_heap_f.p3d", [11413.3, 7561.4, 222.168], [0.384488, -0.920487, -0.0698066], [-0.00365396, -0.0771364, 0.997014]],
["a3\structures_f\walls\cncbarrier_f.p3d", [11414, 7554.36, 221.666], [0.610303, -0.790578, -0.0501611], [-0.00565224, -0.0676655, 0.997692]],
["a3\structures_f\walls\cncbarrier_f.p3d", [11411.8, 7551.36, 221.438], [-0.991606, 0.129219, -0.00439814], [-0.0136235, -0.0705965, 0.997412]],
["a3\structures_f\walls\cncshelter_f.p3d", [11414.3, 7563.71, 223.111], [-0.610312, 0.79004, 0.0579268], [0.00172597, -0.0717987, 0.997418]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11431, 7563.16, 222.394], [0.98906, 0.132466, -0.0649147], [0.0654918, 0, 0.997853]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11431.6, 7557.64, 222.289], [0.991479, -0.128053, -0.023904], [0.021023, -0.0238037, 0.999496]],
["a3\structures_f\civ\market\crateswooden_f.p3d", [11428.9, 7563.77, 222.091], [-0.987358, -0.13599, 0.0814299], [0.0878182, -0.0416476, 0.995266]],
["a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d", [11429.4, 7556.3, 221.741], [0.128534, 0.99036, 0.0516243], [0.0282353, -0.0556896, 0.998049]],
["a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d", [11427.4, 7555.39, 221.798], [-0.922761, -0.384928, 0.0185015], [0.0282353, -0.0196502, 0.999408]],
["a3\structures_f_epa\items\food\bottleplastic_v2_f.p3d", [11428.7, 7557, 221.288], [0.554093, 0.831887, 0.0307424], [0.0282353, -0.0556896, 0.998049]],
["a3\structures_f_epa\items\food\bottleplastic_v2_f.p3d", [11428.6, 7557, 221.29], [0.6092, 0.792557, 0.0269889], [0.0282353, -0.0556896, 0.998049]],
["a3\structures_f\mil\fortification\hbarrier_big_f.p3d", [11425.2, 7567.73, 223.183], [0.380104, 0.924489, 0.0290135], [0.0635913, -0.0574135, 0.996323]],
["a3\structures_f\ind\windpowerplant\powergenerator_f.p3d", [11426.8, 7565.29, 222.459], [-0.921055, 0.377147, 0.0970521], [0.0878182, -0.0416476, 0.995266]],
["a3\structures_f_heli\civ\constructions\tooltrolley_01_f.p3d", [11424.3, 7564.65, 222.29], [-0.997882, 0.0387447, 0.0522596], [0.0500787, -0.0552696, 0.997215]],
["a3\structures_f\items\tools\gloves_f.p3d", [11424.2, 7564.79, 222.221], [-0.380875, -0.924627, 0], [0, 0, 1]],
["a3\structures_f\items\tools\gloves_f.p3d", [11424.3, 7564.75, 222.213], [0.538949, -0.842338, 0], [0, 0, 1]],
["a3\structures_f\items\tools\multimeter_f.p3d", [11423.9, 7564.81, 222.228], [-0.363379, -0.931641, 0], [0, 0, 1]],
["a3\structures_f\civ\market\cratesshabby_f.p3d", [11424, 7566.37, 222.79], [0.922755, -0.378083, -0.0746708], [0.0635913, -0.0417245, 0.997103]],
["ca\roads\ces10 100.p3d", [11433.5, 7599.6, 226.475], [0.697794, 0.703579, 0.134391], [-0.0128258, -0.175315, 0.984429]],
["ca\roads\ces6konec.p3d", [11442.5, 7606.83, 228.204], [-0.801705, -0.564806, -0.19561], [-0.0965359, -0.200613, 0.974903]],
["ca\roads\ces10 100.p3d", [11421.5, 7587.25, 224.69], [0.552729, 0.833361, 0], [0, 0, 1]],
["ca\roads\ces10 100.p3d", [11411.8, 7572.84, 223.378], [0.401818, 0.91572, 0], [0, 0, 1]],
["ca\roads\ces6konec.p3d", [11401.1, 7545.67, 220.452], [0.239875, 0.970068, 0.0377973], [0.00557784, -0.0403106, 0.999172]],
["ca\roads\ces6konec.p3d", [11414.6, 7557.94, 221.53], [0.964043, 0.264839, 0.0219294], [-0.00365396, -0.0693021, 0.997589]],
["ca\roads\ces6konec.p3d", [11420.6, 7559.48, 221.562], [-0.966875, -0.254902, 0.0133545], [0.0309912, -0.0652996, 0.997384]],
["ca\roads\ces6konec.p3d", [11412.4, 7545.93, 220.712], [0.860364, -0.509521, -0.0127186], [-0.0218871, -0.0618661, 0.997844]],
["ca\roads\ces6konec.p3d", [11417.8, 7542.73, 220.692], [-0.866843, 0.498582, 0.000316137], [-0.0161608, -0.0287311, 0.999457]],
["ca\roads\ces10 100.p3d", [11404.8, 7557.01, 221.809], [0.237314, 0.971433, 0], [0, 0, 1]],
["ca\data\library\roadbarrier_light.p3d", [11399.3, 7544.46, 221.064], [-0.695185, -0.718682, -0.0146199], [0.0179365, -0.037675, 0.999129]],
["a3\structures_f\wrecks\wreck_truck_dropside_f.p3d", [11414.3, 7544.44, 221.846], [0.916548, -0.399907, 0.00371745], [-0.0218847, -0.0408717, 0.998925]]
];

{
    private _simpleObject = createSimpleObject [_x select 0, _x select 1];
    _simpleObject setVectorDirAndUp [_x select 2, _x select 3];
    
    {
        if ((toLower _x) in _invisibleSelections) then 
        {
            _simpleObject hideSelection [_x, true];
        };
    }
    forEach (selectionNames _simpleObject);
}
forEach _simpleObjects;