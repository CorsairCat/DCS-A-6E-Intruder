--初始化座舱模型
shape_name   	   = "cockpit_veryfirst"
is_EDM			   = true
new_model_format   = true
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}

dusk_border					 = 0.4
draw_pilot					 = false

external_model_canopy_arg	 = 38

use_external_views = false

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

TEMP_VAR = {}

function create_cockpit_animation_controller(input_num, set_parameter, _arg_number)
    _input = {-1,1}
    _output = {-1,1}
    TEMP_VAR[input_num] = CreateGauge("parameter")
    TEMP_VAR[input_num].arg_number		    = _arg_number
    TEMP_VAR[input_num].input				= _input
    TEMP_VAR[input_num].output			    = _output
    TEMP_VAR[input_num].parameter_name		= set_parameter
end

counter_rec = 0

local controllers = LoRegisterPanelControls()

function _counter()
    counter_rec = counter_rec + 1
    return(counter_rec)
end

animation_list = {
    {"AOA_IND", 301},
    {"RADAR_ALT_IND", 302},
    {"RPM_L", 303},
    {"RPM_R", 304},
    {"EGT_L", 305},
    {"EGT_R", 306},
    {"FF_L", 307},
    {"FF_R", 308},
    {"PT_L", 309},
    {"PT_R", 310},
    {"OP_L", 311},
    {"OP_R", 312},
    {"AIR_SPEED", 321},
    {"MACH_IND", 322},
    {"G_METER", 323},
    {"GYRO_ROLL", 324},
    {"GYRO_PITCH", 325},
    {"CLOCK_H", 326},
    {"CLOCK_M", 327},
    {"CLOCK_S", 328},
    {"OXY_QUAN", 329},
    {"BARO_ALT", 330},
    {"BARO_x1K", 331},
    {"BARO_x1W", 332},
    {"BARO_x1X", 333},
    {"QNH_x1K", 334},
    {"QNH_x100", 335},
    {"QNH_x10", 336},
    {"QNH_x1", 337},
    {"BARO_POWER", 338},
    {"CLIMB_RATE", 339},
    {"SLIDE_IND", 340},
    {"HSI_COMPASS", 341},
    {"HSI_COURSE", 342},
    {"HSI_CRS_TOF", 343},
    {"HSI_HEADING", 344},
    {"HSI_TACAN", 345},
    {"HSI_ADF", 346},
    {"HSI_T_D_x1k", 347},
    {"HSI_T_D_x100", 348},
    {"HSI_T_D_x10", 349},
    {"HSI_T_D_x1", 350},
    {"HSI_HDG_x100", 351},
    {"HSI_HDG_x10", 352},
    {"HSI_HDG_x1", 353},
    {"FUEL_QUAN_IN", 354},
    {"FUEL_QUAN_SEL", 355},
    {"FUEL_QUAN_A_5", 356},
    {"FUEL_QUAN_A_4", 357},
    {"FUEL_QUAN_A_3", 358},
    {"FUEL_QUAN_A_2", 359},
    {"FUEL_QUAN_A_1", 360},

    {"PTN_053", 53},
    {"PTN_054", 44},

    {"PTN_101", 101},
    {"PTN_102", 102},
    {"PTN_103", 103},
    {"PTN_104", 104},
    {"PTN_105", 105},
    {"PTN_106", 106},
    {"PTN_107", 107},
    
    {"PTN_109", 109},
    {"PTN_110", 110},
    {"PTN_112", 112},
    {"PTN_113", 113},
    {"PTN_114", 114},
    {"PTN_115", 115},
    {"PTN_116", 116},
    {"PTN_117", 117},

    {"PTN_124", 124},
    {"PTN_125", 125},
    {"PTN_128", 128},
    {"PTN_129", 129},
    {"PTN_130", 130},
    {"PTN_131", 131},
    {"PTN_132", 132},
    {"PTN_133", 133},
    {"PTN_134", 134},

    -- VDI DISPLAY
    {"PTN_135", 135},
    {"PTN_136", 136},
    {"PTN_137", 137},
    {"PTN_138", 138},
    {"PTN_139", 139},
    {"PTN_140", 140},

    {"PTN_118", 118},
    {"PTN_145", 145},
    {"PTN_146", 146},
    {"PTN_147", 147},
    {"PTN_148", 148},
    {"PTN_149", 149},

    {"PTN_150", 150},
    {"PTN_151", 151},

    -- auto pilot panel
    {"PTN_172", 172},
    {"PTN_173", 173},
    {"PTN_174", 174},
    {"PTN_175", 175},
    -- {"PTN_176", 176}, currently not functional and not model
    {"PTN_177", 177},

    -- UHF radio
    {"PTN_178", 178},
    {"PTN_179", 179},
    {"PTN_180", 180},
    {"PTN_181", 181},
    {"PTN_182", 182},
    {"PTN_183", 183},
    -- TACAN Panel will combined into Radio System
    {"PTN_184", 184},
    {"PTN_185", 185},
    {"PTN_186", 186},
    {"PTN_187", 187},
    {"PTN_188", 188},
    {"PTN_189", 189},
    -- ATANNA of UHF and tacan
    {"PTN_235", 235},
    {"PTN_236", 236},

    -- ECS
    {"PTN_209", 209},
    {"PTN_210", 210},
    {"PTN_211", 211},
    {"PTN_212", 212},
    {"PTN_213", 213},
    {"PTN_214", 214},
    {"PTN_215", 215},
    {"PTN_216", 216},
    {"PTN_217", 217},


    -- the arg 9xx stand for transfer information
    {"EnvironmentControl", 902},
    {"WindshieldDeice", 903},
    -- following mark drop tank status
    {"pylon_lin", 904},
    {"pylon_lout", 905},
    {"pylon_rout", 906},
    {"pylon_rin", 907},
    {"pylon_ctr", 908},
    {"oil_press", 909},

    -- autopilot mode
    {"ap_mainmode", 910}, -- 0: off; 1: STAB; 2: AUTO;
    {"ap_holdmode", 911}, -- 0: off; 1: ALT; 2: MACH;

    {"tacan_mode", 912}, -- 0:off; 1:REC; 2:T/C
    {"tacan_chann", 913}, 
}

--[[
    animation_list[_counter] = {"RPM_L", 303}
    animation_list[_counter] = {"RPM_R", 304}
    animation_list[_counter] = {"EGT_L", 305}
    animation_list[_counter] = {"EGT_R", 306}
    animation_list[_counter] = {"FF_L", 307}
    animation_list[_counter] = {"FF_R", 308}
    animation_list[_counter] = {"RPM_L", 303}
]]

for k,v in pairs(animation_list) do
    create_cockpit_animation_controller(k,v[1],v[2])
end


--初始化座舱动画

--[[
StickPitch							= CreateGauge()
StickPitch.arg_number				= 71
StickPitch.input					= {-100, 100}
StickPitch.output					= {-1, 1}
StickPitch.controller				= controllers.base_gauge_StickPitchPosition

StickBank							= CreateGauge()
StickBank.arg_number				= 74
StickBank.input						= {-100, 100}
StickBank.output					= {-1, 1}
StickBank.controller				= controllers.base_gauge_StickRollPosition
]]--


ELEC_AC_HANDLE                      = CreateGauge("parameter")
ELEC_AC_HANDLE.arg_number		    = 900
ELEC_AC_HANDLE.input				= {0, 1}
ELEC_AC_HANDLE.output			    = {0, 1}
ELEC_AC_HANDLE.parameter_name		= "ELEC_PRIMARY_AC_OK"

ELEC_DC_HANDLE                      = CreateGauge("parameter")
ELEC_DC_HANDLE.arg_number		    = 901
ELEC_DC_HANDLE.input				= {0, 1}
ELEC_DC_HANDLE.output			    = {0, 1}
ELEC_DC_HANDLE.parameter_name		= "ELEC_PRIMARY_DC_OK"

Air_Break_Ind    					= CreateGauge("parameter")
Air_Break_Ind.arg_number		    = 316
Air_Break_Ind.input				    = {0, 1}
Air_Break_Ind.output			    = {0, 1}
Air_Break_Ind.parameter_name		= "AIRBREAK_IND"

Slat_Pos_Ind    					= CreateGauge("parameter")
Slat_Pos_Ind.arg_number		        = 313
Slat_Pos_Ind.input				    = {0, 1}
Slat_Pos_Ind.output			        = {0, 1}
Slat_Pos_Ind.parameter_name		    = "SLATPOS_IND"

Flap_Pos_Ind    					= CreateGauge("parameter")
Flap_Pos_Ind.arg_number		        = 315
Flap_Pos_Ind.input				    = {0, 1}
Flap_Pos_Ind.output			        = {0, 1}
Flap_Pos_Ind.parameter_name		    = "FLAPPOS_IND"

Stab_Pos_Ind    					= CreateGauge("parameter")
Stab_Pos_Ind.arg_number		        = 314
Stab_Pos_Ind.input				    = {0, 1}
Stab_Pos_Ind.output			        = {0, 1}
Stab_Pos_Ind.parameter_name		    = "STABPOS_IND"

NoseW_Pos_Ind    					= CreateGauge("parameter")
NoseW_Pos_Ind.arg_number		    = 318
NoseW_Pos_Ind.input				    = {0, 1}
NoseW_Pos_Ind.output			    = {0, 1}
NoseW_Pos_Ind.parameter_name		= "NoseWPOS_IND"

MainLW_Pos_Ind    					= CreateGauge("parameter")
MainLW_Pos_Ind.arg_number		    = 319
MainLW_Pos_Ind.input				= {0, 1}
MainLW_Pos_Ind.output			    = {0, 1}
MainLW_Pos_Ind.parameter_name		= "MainLWPOS_IND"

MainRW_Pos_Ind    					= CreateGauge("parameter")
MainRW_Pos_Ind.arg_number		    = 320
MainRW_Pos_Ind.input				= {0, 1}
MainRW_Pos_Ind.output			    = {0, 1}
MainRW_Pos_Ind.parameter_name		= "MainRWPOS_IND"

RightThrottor    					= CreateGauge("parameter")
RightThrottor.arg_number		    = 42
RightThrottor.input				    = {0, 1}
RightThrottor.output			    = {0, 1}
RightThrottor.parameter_name		= "RightThrottor"

LeftThrottor    					= CreateGauge("parameter")
LeftThrottor.arg_number		        = 41
LeftThrottor.input				    = {0, 1}
LeftThrottor.output			        = {0, 1}
LeftThrottor.parameter_name	        = "LeftThrottor"

FlapLevel    					    = CreateGauge("parameter")
FlapLevel.arg_number		        = 43
FlapLevel.input				        = {0, 1}
FlapLevel.output			        = {0, 1}
FlapLevel.parameter_name		    = "FlapLevel"

Landinggearhandle					= CreateGauge("parameter")
Landinggearhandle.arg_number		= 50
Landinggearhandle.input				= {0, 1}
Landinggearhandle.output			= {0, 1}
Landinggearhandle.parameter_name	= "LandingGearLevel"

TowLinkHookhandle					= CreateGauge("parameter")
TowLinkHookhandle.arg_number		= 44
TowLinkHookhandle.input				= {0, 1}
TowLinkHookhandle.output			= {0, 1}
TowLinkHookhandle.parameter_name	= "TowLinkHookLevel"

CanopyInside					    = CreateGauge("parameter")
CanopyInside.arg_number		        = 38
CanopyInside.input				    = {0, 1}
CanopyInside.output			        = {0, 1}
CanopyInside.parameter_name	        = "CanopyInsideView"

GenLeftSwitch					    = CreateGauge("parameter")
GenLeftSwitch.arg_number		    = 108
GenLeftSwitch.input				    = {-1, 1}
GenLeftSwitch.output			    = {-1, 1}
GenLeftSwitch.parameter_name	    = "GenLeftSwitch"

GenRightSwitch					    = CreateGauge("parameter")
GenRightSwitch.arg_number		    = 111
GenRightSwitch.input				= {-1, 1}
GenRightSwitch.output			    = {-1, 1}
GenRightSwitch.parameter_name	    = "GenRightSwitch"

EngineSwitch					    = CreateGauge("parameter")
EngineSwitch.arg_number		        = 123
EngineSwitch.input				    = {0, 1}
EngineSwitch.output			        = {-1, 1}
EngineSwitch.parameter_name	        = "EngineSwitch"

ParkingBrake                        = CreateGauge("parameter")
ParkingBrake.arg_number             = 52
ParkingBrake.input                  = {0, 1}
ParkingBrake.output                 = {0, 1}
ParkingBrake.parameter_name         = "PARKINGBREAK_HANDLE"

need_to_be_closed = false