dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev 	    = GetSelf()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local ias_conversion_to_knots = 1.9504132
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_INCH = 3.2808
local rot_degree = sensor_data.getRoll()

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
end

function SetCommand(command,value)

end

function update()
    if (get_elec_primary_ac_ok() and get_elec_primary_dc_ok()) then -- 如果电通着点亮屏幕

    elseif (get_elec_primary_dc_ok()) then -- 如果只有dc电力则进启动模式

    else -- 无电则不操作

    end
end

need_to_be_closed = false