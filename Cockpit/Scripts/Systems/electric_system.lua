dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."utils.lua")

startup_print("electric_system: load")

local electric_system = GetSelf()
local dev = electric_system

local update_time_step = 0.02 --每秒50次调用update()函数
make_default_activity(update_time_step)

local sensor_data = get_base_data()

electric_system:listen_command(Keys.PowerGeneratorLeft)
electric_system:listen_command(Keys.PowerGeneratorRight)
-- electric_system:listen_command(Keys.BatteryPower)

electric_system:DC_Battery_on(true)

electric_system:listen_event("GroundPowerOn")
electric_system:listen_event("GroundPowerOff")

local genLeftSwitch = get_param_handle("GenLeftSwitch")
local genRightSwitch = get_param_handle("GenRightSwitch")
-- local BatterySwitch = get_param_handle("BatterySwitch") no battery switch, default open

switch_count = 0

function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local left_gen = _switch_counter()
local right_gen = _switch_counter()

target_status = {
    {left_spd , SWITCH_OFF, genLeftSwitch, "GenLeftSwitch"},
    {right_spd , SWITCH_OFF, genRightSwitch, "GenRightSwitch"},
}

current_status = {
    {left_spd , SWITCH_OFF, SWITCH_OFF},
    {right_spd , SWITCH_OFF, SWITCH_OFF},
}

function CockpitEvent(event,val)
    -- set all externel power together
    if event == "GroundPowerOn" then
        print_message_to_user("Ground_Power_is_on")
        Externel_Power_Units_Status = 1
    elseif event == "GroundPowerOff" then
        print_message_to_user("Ground_Power_is_off")
        Externel_Power_Units_Status = 0
    end
end

function update_externel_power_unit()
    if Externel_Power_Units_Status == 1 then
        set_aircraft_draw_argument_value(124, 1)
    else
        set_aircraft_draw_argument_value(124, 0)
    end
end

function update_elec_state() --更新电力总线状态
    if (electric_system:get_AC_Bus_1_voltage() > 0 or electric_system:get_AC_Bus_2_voltage() > 0 or Externel_Power_Units_Status == 1) then
        -- 主发电机状态正常（双备份
        elec_primary_ac_ok:set(1)
    else
        elec_primary_ac_ok:set(0)
    end

    if electric_system:get_DC_Bus_1_voltage() > 0 and batteryStatus == 1 then 
        elec_primary_dc_ok:set(1)
    else
        elec_primary_dc_ok:set(0)
    end
end

function post_initialize() --默认初始化函数
    startup_print("electric_system: postinit start")
    set_aircraft_draw_argument_value(114, 1) -- clear the default outer cockpit

    local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
        electric_system:AC_Generator_1_on(true)
        electric_system:AC_Generator_2_on(true) -- A-6E have 2 engine, so two generator
        electric_system:DC_Battery_on(true) -- A-6 have a battery
        target_status = {
            {left_spd , SWITCH_ON, genLeftSwitch, "GenLeftSwitch"},
            {right_spd , SWITCH_ON, genRightSwitch, "GenRightSwitch"},
        }
        
        current_status = {
            {left_spd , SWITCH_ON, SWITCH_OFF},
            {right_spd , SWITCH_ON, SWITCH_OFF},
        }
    elseif birth=="GROUND_COLD" then
        electric_system:AC_Generator_1_on(false) 
        electric_system:AC_Generator_2_on(false) -- A-6A have 2 engine, so two generator
        electric_system:DC_Battery_on(true) -- A-6 have a battery but default open
        target_status = {
            {left_spd , SWITCH_OFF, genLeftSwitch, "GenLeftSwitch"},
            {right_spd , SWITCH_OFF, genRightSwitch, "GenRightSwitch"},
        }
        
        current_status = {
            {left_spd , SWITCH_OFF, SWITCH_OFF},
            {right_spd , SWITCH_OFF, SWITCH_OFF},
        }
    end

    for k,v in pairs(target_status) do
        target_status[k][3]:set(current_status[k][2])
    end

    update_elec_state()
    startup_print("electric_system: postinit end")
end

function SetCommand(command,value)
    -- 最基础的航电功能监听
    if command == Keys.PowerGeneratorLeftUP then
        if target_status[left_gen] < 0.5 then
            target_status[left_gen] = target_status[left_gen] + 1
        end
        if (target_status[left_gen] >= 0.5) then
            electric_system:AC_Generator_1_on(true)
        else
            electric_system:AC_Generator_1_on(false)
        end
    elseif command == Keys.PowerGeneratorLeftDOWN then
        if target_status[left_gen] > -0.5 then
            target_status[left_gen] = target_status[left_gen] - 1
        end
        if (target_status[left_gen] >= 0.5) then
            electric_system:AC_Generator_1_on(true)
        else
            electric_system:AC_Generator_1_on(false)
        end
    elseif command == Keys.PowerGeneratorRightUP then
        if target_status[right_gen] < 0.5 then
            target_status[right_gen] = target_status[right_gen] + 1
        end
        if (target_status[right_gen] >= 0.5) then
            electric_system:AC_Generator_2_on(true)
        else
            electric_system:AC_Generator_2_on(false)
        end
    elseif command == Keys.PowerGeneratorRightDOWN then
        if target_status[right_gen] > -0.5 then
            target_status[right_gen] = target_status[right_gen] - 1
        end
        if (target_status[right_gen] >= 0.5) then
            electric_system:AC_Generator_2_on(true)
        else
            electric_system:AC_Generator_2_on(false)
        end
    end
end

function update_switch_status()
    for k,v in pairs(target_status) do
        if target_status[k][2] > current_status[k][2] and target_status[k][2] == SWITCH_ON then
            if current_status[k][3] < SWITCH_ON then
                current_status[k][2] = current_status[k][2] + 0.25
            else
                current_status[k][2] = target_status[k][2]
            end
            -- target_status[k][3]:set(current_status[k][2])
        elseif target_status[k][2] < current_status[k][2] and target_status[k][2] == SWITCH_TEST then
            if current_status[k][3] > SWITCH_TEST then
                current_status[k][2] = current_status[k][2] - 0.25
            else
                current_status[k][2] = target_status[k][2]
            end
            -- target_status[k][3]:set(current_status[k][2])
        elseif target_status[k][2] < current_status[k][2] and target_status[k][2] == SWITCH_OFF then
            if current_status[k][3] > SWITCH_OFF then
                current_status[k][2] = current_status[k][2] - 0.25
            else
                current_status[k][2] = target_status[k][2]
            end
            -- target_status[k][3]:set(current_status[k][2])
        elseif target_status[k][2] > current_status[k][2] and target_status[k][2] == SWITCH_OFF then
            if current_status[k][3] < SWITCH_OFF then
                current_status[k][2] = current_status[k][2] + 0.25
            else
                current_status[k][2] = target_status[k][2]
            end
            -- target_status[k][3]:set(current_status[k][2])
        end
        target_status[k][3]:set(current_status[k][2])
        local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
        temp_switch_ref:update()
        -- print_message_to_user(k)
    end
end

function update() --刷新状态

    update_elec_state()
    update_externel_power_unit()
    update_switch_status()

end

--[[
From DLL exports inspection, these are the methods support by avSimpleElectricSystem:
AC_Generator_1_on   <- pass true or false to this to enable or disable
AC_Generator_2_on   <- pass true or false to this to enable or disable
DC_Battery_on       <- pass true or false to this to enable or disable
get_AC_Bus_1_voltage  <- returns 115 if enabled (and left engine running), otherwise 0
get_AC_Bus_2_voltage  <- returns 115 if enabled (and right engine running), otherwise 0
get_DC_Bus_1_voltage  <- returns 28 if either AC bus has 115V, otherwise 0
get_DC_Bus_2_voltage  <- returns 28 if battery enabled, otherwise 0


potentially relevant standard base input commands:
iCommandPowerOnOff	315   -- the command dispatched by rshift-L in FC modules

iCommandGroundPowerDC	704
iCommandGroundPowerDC_Cover	705
iCommandPowerBattery1	706
iCommandPowerBattery1_Cover	707
iCommandPowerBattery2	708
iCommandPowerBattery2_Cover	709
iCommandGroundPowerAC	710
iCommandPowerGeneratorLeft	711
iCommandPowerGeneratorRight	712
iCommandElectricalPowerInverter	713

iCommandAPUGeneratorPower	1071
iCommandBatteryPower	1073
iCommandElectricalPowerInverterSTBY	1074
iCommandElectricalPowerInverterOFF	1075
iCommandElectricalPowerInverterTEST	1076
--]]
need_to_be_closed = false 