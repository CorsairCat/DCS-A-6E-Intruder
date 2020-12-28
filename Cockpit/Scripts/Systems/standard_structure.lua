local AutopilotSystem = GetSelf()

--初始化加载要用lua文件
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

--设置循环次数
local update_rate = 0.05 -- 20次每秒
make_default_activity(update_rate)

--初始化DCS读取API
local sensor_data = get_base_data()

------Here Strat the general Switch Control

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local strobe_light_switch = _switch_counter()

target_status = {
    {strobe_light_switch , SWITCH_OFF, get_param_handle("PTN_124"), "PTN_124"},
}

current_status = {
    {strobe_light_switch , SWITCH_OFF, SWITCH_OFF},
}

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" then

    elseif birth == "GROUND_COLD" then

    elseif birth == "AIR_HOT" then
        
    end
end

AutopilotSystem:listen_command()

function SetCommand(command, value)

end

function update()
    
end

need_to_be_closed = false