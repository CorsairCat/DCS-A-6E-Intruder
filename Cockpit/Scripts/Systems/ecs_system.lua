local ECSSystem = GetSelf()

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

-- get transfer parameter

------Here Strat the general Switch Control

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local aircond_master_switch = _switch_counter()
local aircond_cockpit_switch = _switch_counter()
local aircond_mode_switch = _switch_counter()
local aircond_emer_cool = _switch_counter()
local aircond_defog = _switch_counter()
local aircond_temp = _switch_counter()
local deice_engine = _switch_counter()
local deice_windshield = _switch_counter()
local deice_pitot = _switch_counter()

target_status = {
    -- {strobe_light_switch , SWITCH_OFF, get_param_handle("PTN_124"), "PTN_124"},
    {aircond_master_switch , SWITCH_OFF, get_param_handle("PTN_212"), "PTN_212"},
    {aircond_cockpit_switch , SWITCH_OFF, get_param_handle("PTN_209"), "PTN_209"},
    {aircond_mode_switch , SWITCH_OFF, get_param_handle("PTN_210"), "PTN_210"},
    {aircond_emer_cool , SWITCH_OFF, get_param_handle("PTN_214"), "PTN_214"},
    {aircond_defog , SWITCH_OFF, get_param_handle("PTN_213"), "PTN_213"},
    {aircond_temp , SWITCH_OFF, get_param_handle("PTN_211"), "PTN_211"},
    {deice_engine , SWITCH_OFF, get_param_handle("PTN_215"), "PTN_215"},
    {deice_windshield , SWITCH_OFF, get_param_handle("PTN_216"), "PTN_216"},
    {deice_pitot , SWITCH_OFF, get_param_handle("PTN_217"), "PTN_217"},
}

current_status = {
    -- {strobe_light_switch , SWITCH_OFF, SWITCH_OFF},
    {aircond_master_switch , SWITCH_OFF,},
    {aircond_cockpit_switch , SWITCH_OFF,},
    {aircond_mode_switch , SWITCH_OFF, },
    {aircond_emer_cool , SWITCH_OFF, },
    {aircond_defog , SWITCH_OFF, },
    {aircond_temp , SWITCH_OFF,},
    {deice_engine , SWITCH_OFF,},
    {deice_windshield , SWITCH_OFF,},
    {deice_pitot , SWITCH_OFF,},
}

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        target_status = {
            -- {strobe_light_switch , SWITCH_OFF, get_param_handle("PTN_124"), "PTN_124"},
            {aircond_master_switch , SWITCH_ON, get_param_handle("PTN_212"), "PTN_212"},
            {aircond_cockpit_switch , SWITCH_ON, get_param_handle("PTN_209"), "PTN_209"},
            {aircond_mode_switch , SWITCH_ON, get_param_handle("PTN_210"), "PTN_210"},
            {aircond_emer_cool , SWITCH_OFF, get_param_handle("PTN_214"), "PTN_214"},
            {aircond_defog , 0.5, get_param_handle("PTN_213"), "PTN_213"},
            {aircond_temp , 0.5, get_param_handle("PTN_211"), "PTN_211"},
            {deice_engine , SWITCH_ON, get_param_handle("PTN_215"), "PTN_215"},
            {deice_windshield , SWITCH_OFF, get_param_handle("PTN_216"), "PTN_216"},
            {deice_pitot , SWITCH_ON, get_param_handle("PTN_217"), "PTN_217"},
        }
    end
    for k,v in pairs(target_status) do
        target_status[k][3]:set(target_status[k][2])
        current_status[k][2] = target_status[k][2]
    end
end

ECSSystem:listen_command(Keys.AircondDefog)
ECSSystem:listen_command(Keys.AircondMasterSwitch)
ECSSystem:listen_command(Keys.AircondAutoManSwitch)
ECSSystem:listen_command(Keys.AircondCMPTREmerUP)
ECSSystem:listen_command(Keys.AircondCMPTREmerDOWN)
ECSSystem:listen_command(Keys.AircondCockpitSwitchUP)
ECSSystem:listen_command(Keys.AircondCockpitSwitchDOWN)
ECSSystem:listen_command(Keys.AircondTemp)
ECSSystem:listen_command(Keys.DeiceWindShieldUP)
ECSSystem:listen_command(Keys.DeiceWindShieldDOWN)
ECSSystem:listen_command(Keys.DeiceEngine)
ECSSystem:listen_command(Keys.DeicePitot)


function SetCommand(command, value)
    if command == Keys.AircondTemp then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[aircond_temp][2] <= 1 and target_status[aircond_temp][2] >= 0 then
            target_status[aircond_temp][2] = target_status[aircond_temp][2] + new_value
        elseif target_status[aircond_temp][2] < 0 then
            target_status[aircond_temp][2] = 0.01
        elseif target_status[aircond_temp][2] > 1 then
            target_status[aircond_temp][2] = 0.99
        end
    elseif command == Keys.AircondDefog then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[aircond_defog][2] <= 1 and target_status[aircond_defog][2] >= 0 then
            target_status[aircond_defog][2] = target_status[aircond_defog][2] + new_value
        elseif target_status[aircond_defog][2] < 0 then
            target_status[aircond_defog][2] = 0.01
        elseif target_status[aircond_defog][2] > 1 then
            target_status[aircond_defog][2] = 0.99
        end
    elseif command == Keys.AircondMasterSwitch then
        target_status[aircond_master_switch][2] = 1 - target_status[aircond_master_switch][2]
    elseif command == Keys.AircondAutoManSwitch then
        target_status[aircond_mode_switch][2] = 1 - target_status[aircond_mode_switch][2]
    elseif command == Keys.DeicePitot then
        target_status[deice_pitot][2] = 1 - target_status[deice_pitot][2]
    elseif command == Keys.DeiceEngine then
        target_status[deice_engine][2] = 1 - target_status[deice_engine][2]
    elseif command == Keys.DeiceWindShieldUP then
        if target_status[deice_windshield][2] < 0.5 then
            target_status[deice_windshield][2] = target_status[deice_windshield][2] + 1
        end
    elseif command == Keys.DeiceWindShieldDOWN then
        if target_status[deice_windshield][2] > -0.5 then
            target_status[deice_windshield][2] = target_status[deice_windshield][2] - 1
        end
    elseif command == Keys.AircondCMPTREmerUP then
        if target_status[aircond_emer_cool][2] < 0.5 then
            target_status[aircond_emer_cool][2] = target_status[aircond_emer_cool][2] + 1
        end
    elseif command == Keys.AircondCMPTREmerDOWN then
        if target_status[aircond_emer_cool][2] > -0.5 then
            target_status[aircond_emer_cool][2] = target_status[aircond_emer_cool][2] - 1
        end
    elseif command == Keys.AircondCockpitSwitchUP then
        if target_status[aircond_cockpit_switch][2] < 0.5 then
            target_status[aircond_cockpit_switch][2] = target_status[aircond_cockpit_switch][2] + 1
        end
    elseif command == Keys.AircondCockpitSwitchDOWN then
        if target_status[aircond_cockpit_switch][2] > -0.5 then
            target_status[aircond_cockpit_switch][2] = target_status[aircond_cockpit_switch][2] - 1
        end
    end
end

function update_switch_status()
    local switch_moving_step = 0.25
    for k,v in pairs(target_status) do
        if math.abs(target_status[k][2] - current_status[k][2]) < switch_moving_step then
            current_status[k][2] = target_status[k][2]
        elseif target_status[k][2] > current_status[k][2] then
            current_status[k][2] = current_status[k][2] + switch_moving_step
        elseif target_status[k][2] < current_status[k][2] then
            current_status[k][2] = current_status[k][2] - switch_moving_step
        end
        target_status[k][3]:set(current_status[k][2])
        local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
        temp_switch_ref:update()
        -- print_message_to_user(k)
    end
end


function update()
    update_switch_status()
end

need_to_be_closed = false