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

local power_switch = _switch_counter()
local stab_switch = _switch_counter()
local cmd_switch = _switch_counter()
local althold_switch = _switch_counter()
local machhold_switch = _switch_counter()

local ap_main_mode_param = get_param_handle("ap_mainmode")
local ap_hold_mode_param = get_param_handle("ap_holdmode")

target_status = {
    {power_switch , SWITCH_OFF, get_param_handle("PTN_172"), "PTN_172"},
    {stab_switch , SWITCH_OFF, get_param_handle("PTN_173"), "PTN_173"},
    {cmd_switch , SWITCH_OFF, get_param_handle("PTN_174"), "PTN_174"},
    {althold_switch , SWITCH_OFF, get_param_handle("PTN_175"), "PTN_175"},
    {machhold_switch , SWITCH_OFF, get_param_handle("PTN_177"), "PTN_177"},
}

current_status = {
    {power_switch , SWITCH_OFF, SWITCH_OFF},
    {stab_switch , SWITCH_OFF, SWITCH_OFF},
    {cmd_switch , SWITCH_OFF, SWITCH_OFF},
    {althold_switch , SWITCH_OFF, SWITCH_OFF},
    {machhold_switch , SWITCH_OFF, SWITCH_OFF},
}

function post_initialize()
    ap_main_mode_param:set(0)
    ap_hold_mode_param:set(0)

end

AutopilotSystem:listen_command(Keys.AutoPilotPowerSwitch)
AutopilotSystem:listen_command(Keys.AutoPilotStabSwitch)
AutopilotSystem:listen_command(Keys.AutoPilotCmdSwitch)
AutopilotSystem:listen_command(Keys.AutoPilotAltHoldSwitch)
AutopilotSystem:listen_command(Keys.AutoPilotMachHoldSwitch)

function SetCommand(command, value)
    if (command == Keys.AutoPilotPowerSwitch) then
        target_status[power_switch][2] = 1 - target_status[power_switch][2]
    elseif (command == Keys.AutoPilotCmdSwitch) then
        target_status[cmd_switch][2] = 1 - target_status[cmd_switch][2]
    elseif (command == Keys.AutoPilotStabSwitch) then
        target_status[stab_switch][2] = 1 - target_status[stab_switch][2]
    elseif (command == Keys.AutoPilotAltHoldSwitch) then
        target_status[althold_switch][2] = 1 - target_status[althold_switch][2]
        if target_status[althold_switch][2] == SWITCH_ON and target_status[machhold_switch][2] == SWITCH_ON then
            target_status[machhold_switch][2] = SWITCH_OFF
        end
    elseif (command == Keys.AutoPilotMachHoldSwitch) then
        target_status[machhold_switch][2] = 1 - target_status[machhold_switch][2]
        if target_status[althold_switch][2] == SWITCH_ON and target_status[machhold_switch][2] == SWITCH_ON then
            target_status[althold_switch][2] = SWITCH_OFF
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

function check_ap_mode_status()
    if (current_status[stab_switch][2] >= 0.95) then
        if ap_main_mode_param:get() >= 1 then
            ap_main_mode_param:set(2) -- set to auto
        else
            target_status[stab_switch][2] = SWITCH_OFF
            target_status[machhold_switch][2] = SWITCH_OFF
            target_status[althold_switch][2] = SWITCH_OFF
            ap_main_mode_param:set(1)
            ap_hold_mode_param:set(0)
        end
    elseif (target_status[stab_switch][2] == SWITCH_OFF) then
        target_status[stab_switch][2] = SWITCH_OFF
        target_status[machhold_switch][2] = SWITCH_OFF
        target_status[althold_switch][2] = SWITCH_OFF
        ap_main_mode_param:set(1)
        ap_hold_mode_param:set(0)
    end
    if (current_status[power_switch][2] >= 0.95) then
        if get_elec_primary_ac_ok() then
            if ap_main_mode_param:get() < 1.5 then
                ap_main_mode_param:set(1) -- set to engage mode 
            end
        else
            target_status[power_switch][2] = SWITCH_OFF
            target_status[machhold_switch][2] = SWITCH_OFF
            target_status[althold_switch][2] = SWITCH_OFF
            ap_main_mode_param:set(0)
            ap_hold_mode_param:set(0)
        end
    elseif (target_status[power_switch][2] == SWITCH_OFF) then
        target_status[power_switch][2] = SWITCH_OFF
        target_status[machhold_switch][2] = SWITCH_OFF
        target_status[althold_switch][2] = SWITCH_OFF
        ap_main_mode_param:set(0)
        ap_hold_mode_param:set(0)
    end
    if ap_main_mode_param:get() == 2 then
        if (target_status[althold_switch][2] >= 0.95) then
            -- target_status[machhold_switch][2] = SWITCH_OFF
            ap_hold_mode_param:set(1)
        end
        if (target_status[machhold_switch][2] >= 0.95) then
            -- target_status[althold_switch][2] = SWITCH_OFF
            ap_hold_mode_param:set(2)
        end
    else
        target_status[machhold_switch][2] = SWITCH_OFF
        target_status[althold_switch][2] = SWITCH_OFF
        ap_hold_mode_param:set(0)
    end
end

function update()
    update_switch_status()
    check_ap_mode_status()
end

need_to_be_closed = false