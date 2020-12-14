dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev 	    = GetSelf()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local main_glass_enable = get_param_handle("MAIN_DIS_GLASS_ENABLE")
local main_screen_enable = get_param_handle("MAIN_DIS_ENABLE")
local weapon_screen_enable = get_param_handle("WEAPON_SCR_ENABLE")
local basic_screen_enable=get_param_handle("BASIC_SCR_ENABLE")
local basic_ias = get_param_handle("BASIC_IAS_DIS")
local basic_pitch = get_param_handle("BASIC_IND_PITCH")
local basic_roll = get_param_handle("BASIC_IND_ROT")
local basic_ralt_dis = get_param_handle("BASIC_RALT_DIS")
local basic_alt_dis = get_param_handle("BASIC_ALT_DIS")
local basic_mode_dis = get_param_handle("BASIC_MODE_DIS")
local basic_g_dis = get_param_handle("BASIC_G_DIS")
local basic_mach_dis = get_param_handle("BASIC_MACH_DIS")
local basic_gmode_dis = get_param_handle("BASIC_GMODE_DIS")
local basic_gs_dis = get_param_handle("BASIC_GS_DIS")
local basic_navmode_dis = get_param_handle("BASIC_NAVMODE_DIS")

basic_ias:set(0)
basic_pitch:set(0)
basic_roll:set(0)
basic_ralt_dis:set(0)
basic_alt_dis:set(0)
basic_mode_dis:set("TEST")
basic_navmode_dis:set("GPS")
basic_gmode_dis:set("OFF")
basic_g_dis:set(1)
basic_mach_dis:set(0)
basic_gs_dis:set(0)

main_glass_enable:set(0)
main_screen_enable:set(0)
basic_screen_enable:set(0)
weapon_screen_enable:set(0)

local sensor_data = get_base_data()

local ias_conversion_to_knots = 1.9504132
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_INCH = 3.2808
local rot_degree = sensor_data.getRoll()
local test_temp = 0

function update()
    rot_degree = sensor_data.getRoll()
    basic_ralt_dis:set(sensor_data.getRadarAltitude()*METER_TO_INCH)
    basic_alt_dis:set(sensor_data.getBarometricAltitude()*METER_TO_INCH)
    basic_g_dis:set(sensor_data.getVerticalAcceleration()/9.8)
    basic_mach_dis:set(sensor_data.getMachNumber())
    -- basic_gs_dis:set(0) -- 地速暂时不显示
    -- print_message_to_user(sensor_data.getPitch())
    basic_ias:set(sensor_data.getIndicatedAirSpeed()*ias_conversion_to_knots)
    basic_roll:set(rot_degree)
    basic_pitch:set((-sensor_data.getPitch()*0.75))
    
    if (get_elec_primary_ac_ok() and get_elec_primary_dc_ok()) then -- 如果电通着点亮屏幕
        main_glass_enable:set(0)
        main_screen_enable:set(0.7)
        basic_screen_enable:set(0.7)
        weapon_screen_enable:set(0.7)
    elseif (get_elec_primary_dc_ok()) then
        main_glass_enable:set(0)
        main_screen_enable:set(0.4)
        basic_screen_enable:set(0.4)
        weapon_screen_enable:set(0.4)
    else
        main_glass_enable:set(0)
        main_screen_enable:set(0)
        basic_screen_enable:set(0)
        weapon_screen_enable:set(0)
    end
    
end

need_to_be_closed = false