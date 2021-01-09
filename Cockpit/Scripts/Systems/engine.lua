local Engine = GetSelf()

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

--定义默认SFM模型发动机控制参数
local iCommandEnginesStart=309
local iCommandEnginesStop=310
local iCommandPlaneThrustCommon = 2004
local iCommandPlaneThrustLeft = 2005
local iCommandPlaneThrustRight = 2006

local iCommandLeftEngineStop = 313
local iCommandLeftEngineStart = 311
local iCommandRightEngineStop = 314
local iCommandRightEngineStart = 312

--设置引擎预定义状态
local ENGINE_OFF = 0
local ENGINE_RUNNING = 1
local ENGINE_STARTING = 2
local ENGINE_POST_STARTING = 3

local engine_state_left = ENGINE_OFF
local engine_state_right = ENGINE_OFF

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local LstartButtonFlag = 0
local LstartCounter = 0
local LstartIsDone = 0

local RPM_l = get_param_handle("RPM_L")
local RPM_r = get_param_handle("RPM_R")
local EGT_l = get_param_handle("EGT_L")
local EGT_r = get_param_handle("EGT_R")
local FF_l = get_param_handle("FF_L")
local FF_r = get_param_handle("FF_R")

local left_throttle = get_param_handle("LeftThrottor")
local right_throttle = get_param_handle("RightThrottor")

local left_throttle_efm = get_param_handle("EFM_LEFT_THRUST_A")
local right_throttle_efm = get_param_handle("EFM_RIGHT_THRUST_A")

function set_rpm_display(rpm_in_percent)
    local return_rpm_in_1 = 0
    if rpm_in_percent < 70 then
        return_rpm_in_1 = 0.0023 * rpm_in_percent + 0.25
    else
        return_rpm_in_1 = 0.01457 * (rpm_in_percent - 70) + 0.411
    end
    return return_rpm_in_1
end

function set_temperature_display(temperature_input)
    local return_EGT = 0
    if temperature_input < 300 then
        return_EGT = 0.0023 * temperature_input * 7 / 30 + 0.25
    else
        local temperature_after_turbine = (temperature_input - 300) * 0.5
        return_EGT = 0.01457 * temperature_after_turbine / 10 + 0.411
    end
    return(return_EGT)
end

function update_Engine_Working_Status()
    local left_rpm = sensor_data.getEngineLeftRPM()
    local right_rpm = sensor_data.getEngineRightRPM()
    RPM_l:set(set_rpm_display(left_rpm))
    RPM_r:set(set_rpm_display(right_rpm))
    EGT_l:set(set_temperature_display(sensor_data.getEngineLeftTemperatureBeforeTurbine()))
    EGT_r:set(set_temperature_display(sensor_data.getEngineRightTemperatureBeforeTurbine()))
    FF_l:set(sensor_data.getEngineLeftFuelConsumption() * 3 * 0.75 + 0.24)
    FF_r:set(sensor_data.getEngineRightFuelConsumption() * 3 * 0.75 + 0.24)
end

-- local EngineSwitch = get_param_handle("EngineSwitch")

--监听引擎启动关闭和油门输入

Engine:listen_command(Keys.ThrottleAxisTest)
Engine:listen_command(Keys.LeftThrottleAxis)
Engine:listen_command(Keys.RightThrottleAxis)

Engine:listen_command(Keys.LeftEngineIDLEPOS)
Engine:listen_command(Keys.RightEngineIDLEPOS)

Engine:listen_command(Keys.RightSpeedDriveUP)
Engine:listen_command(Keys.RightSpeedDriveDOWN)
Engine:listen_command(Keys.LeftSpeedDriveUP)
Engine:listen_command(Keys.LeftSpeedDriveDOWN)

Engine:listen_command(Keys.FuelMasterLeft)
Engine:listen_command(Keys.FuelMasterRight)

Engine:listen_command(Keys.LeftEngineCrank)
Engine:listen_command(Keys.LeftEngineCrankUP)
Engine:listen_command(Keys.RightEngineCrank)
Engine:listen_command(Keys.RightEngineCrankUP)

Engine:listen_command(Keys.CSDSwitch)
Engine:listen_command(Keys.NWWSwitch)
Engine:listen_command(Keys.BleedHoldCover)
Engine:listen_command(Keys.AirCondSwitch)

switch_count = 0

function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local left_spd = _switch_counter()
local right_spd = _switch_counter()
local left_fuel_m = _switch_counter()
local right_fuel_m = _switch_counter()
local left_crank = _switch_counter()
local right_crank = _switch_counter()
local csd_status = _switch_counter()
local nww_status = _switch_counter()
local aircond_status = _switch_counter()
local bleed_hold_status = _switch_counter()

local left_idle_status = SWITCH_OFF
local right_idle_status = SWITCH_OFF
local Externel_Bleed_Status = SWITCH_OFF

target_status = {
    {left_spd , SWITCH_OFF, get_param_handle("PTN_109"), "PTN_109"},
    {right_spd , SWITCH_OFF, get_param_handle("PTN_110"), "PTN_110"},
    {left_fuel_m , SWITCH_OFF, get_param_handle("PTN_112"), "PTN_112"},
    {right_fuel_m , SWITCH_OFF, get_param_handle("PTN_113"), "PTN_113"},
    {left_crank, SWITCH_OFF, get_param_handle("PTN_150"), "PTN_150"},
    {right_crank, SWITCH_OFF, get_param_handle("PTN_151"), "PTN_151"},
    {csd_status, SWITCH_OFF, get_param_handle("PTN_115"), "PTN_115"},
    {nww_status, SWITCH_OFF, get_param_handle("PTN_114"), "PTN_114"},
    {aircond_status, SWITCH_OFF, get_param_handle("PTN_116"), "PTN_116"},
    {bleed_hold_status, SWITCH_OFF, get_param_handle("PTN_117"), "PTN_117"},
}

current_status = {
    {left_spd , SWITCH_OFF, SWITCH_OFF},
    {right_spd , SWITCH_OFF, SWITCH_OFF},
    {left_fuel_m , SWITCH_OFF, SWITCH_OFF},
    {right_fuel_m , SWITCH_OFF, SWITCH_OFF},
    {left_crank, SWITCH_OFF, SWITCH_OFF},
    {right_crank, SWITCH_OFF, SWITCH_OFF},
    {csd_status, SWITCH_OFF, SWITCH_OFF},
    {nww_status, SWITCH_OFF, SWITCH_OFF},
    {aircond_status, SWITCH_OFF, SWITCH_OFF},
    {bleed_hold_status, SWITCH_OFF, SWITCH_OFF},
}

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

-- 初始化函数
function post_initialize()
	
	local dev = GetSelf()
    local sensor_data = get_base_data()
    local throttle = left_throttle_efm:get()

    --初始化不同出生状况下发动机状态参数
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
        engine_state_right = ENGINE_RUNNING
        engine_state_left = ENGINE_RUNNING
    elseif birth=="AIR_HOT" then
        engine_state_right = ENGINE_RUNNING
        engine_state_left = ENGINE_RUNNING
    elseif birth=="GROUND_COLD" then
        engine_state_right = ENGINE_OFF
        engine_state_left = ENGINE_OFF
    end
    if engine_state_left == ENGINE_RUNNING then
        target_status = {
            {left_spd , SWITCH_ON, get_param_handle("PTN_109"), "PTN_109"},
            {right_spd , SWITCH_ON, get_param_handle("PTN_110"), "PTN_110"},
            {left_fuel_m , SWITCH_ON, get_param_handle("PTN_112"), "PTN_112"},
            {right_fuel_m , SWITCH_ON, get_param_handle("PTN_113"), "PTN_113"},
            {left_crank, SWITCH_OFF, get_param_handle("PTN_150"), "PTN_150"},
            {right_crank, SWITCH_OFF, get_param_handle("PTN_151"), "PTN_151"},
            {csd_status, SWITCH_ON, get_param_handle("PTN_115"), "PTN_115"},
            {nww_status, SWITCH_ON, get_param_handle("PTN_114"), "PTN_114"},
            {aircond_status, SWITCH_ON, get_param_handle("PTN_116"), "PTN_116"},
            {bleed_hold_status, SWITCH_ON, get_param_handle("PTN_117"), "PTN_117"},
        }
        
        current_status = {
            {left_spd , SWITCH_ON, SWITCH_OFF},
            {right_spd , SWITCH_ON, SWITCH_OFF},
            {left_fuel_m , SWITCH_ON, SWITCH_OFF},
            {right_fuel_m , SWITCH_ON, SWITCH_OFF},
            {left_crank, SWITCH_OFF, SWITCH_OFF},
            {right_crank, SWITCH_OFF, SWITCH_OFF},
            {csd_status, SWITCH_ON, SWITCH_OFF},
            {nww_status, SWITCH_ON, SWITCH_OFF},
            {aircond_status, SWITCH_ON, SWITCH_OFF},
            {bleed_hold_status, SWITCH_ON, SWITCH_OFF},
        }

        for k,v in pairs(target_status) do
            target_status[k][3]:set(current_status[k][2])
        end

        left_idle_status = SWITCH_ON
        right_idle_status = SWITCH_ON
        Externel_Bleed_Status = SWITCH_OFF

        left_throttle:set(0.2)
        right_throttle:set(0.2)
    else
        for k,v in pairs(target_status) do
            target_status[k][3]:set(current_status[k][2])
        end
    end

    --EngineSwitch:set(1)
end

start_count_time = 0
start_count_flag_l = 0
start_count_flag_r = 0

L_IDLE_RESTART = 0
R_IDLE_RESTART = 0

--监听函数
function SetCommand(command, value)
    if (get_elec_primary_dc_ok() or get_elec_primary_ac_ok()) then
        if (command == Keys.ThrottleAxisTest) then 
            -- local throttle = value * 0.85 + 0.15
            if (left_idle_status == SWITCH_ON) then
                -- dispatch_action(nil, iCommandPlaneThrustCommon, value)
                dispatch_action(nil, Keys.LeftThrottleAxis, value)
                -- left_throttle:set(throttle)
            end
            if (right_idle_status == SWITCH_ON) then
                -- dispatch_action(nil, iCommandPlaneThrustCommon, value)
                dispatch_action(nil, Keys.RightThrottleAxis, value)
                -- right_throttle:set(throttle)
            end
        elseif (command == Keys.LeftThrottleAxis) and (engine_state_left == ENGINE_RUNNING) then 
            local throttle = value * 0.85 + 0.15
            if (left_idle_status == SWITCH_ON) then
                dispatch_action(nil, iCommandPlaneThrustLeft, value)
                -- left_throttle:set(throttle)
            end
        elseif (command == Keys.RightThrottleAxis) and (engine_state_right == ENGINE_RUNNING) then 
            local throttle = value * 0.85 + 0.15
            if (right_idle_status == SWITCH_ON) then
                dispatch_action(nil, iCommandPlaneThrustRight, value)
                -- right_throttle:set(throttle)
            end
        elseif (command == Keys.RightSpeedDriveUP) then
            if (target_status[right_spd][2] < 0.5) then
                current_status[right_spd][3] = current_status[right_spd][2]
                target_status[right_spd][2] = target_status[right_spd][2] + 1
            end
        elseif (command == Keys.RightSpeedDriveDOWN) then
            if (target_status[right_spd][2] > -0.5) then
                current_status[right_spd][3] = current_status[right_spd][2]
                target_status[right_spd][2] = target_status[right_spd][2] - 1
            end
        elseif (command == Keys.LeftSpeedDriveUP) then
            -- print_message_to_user(1)
            if (target_status[left_spd][2] < 0.5) then
                -- print_message_to_user(2)
                current_status[left_spd][3] = current_status[left_spd][2]
                target_status[left_spd][2] = target_status[left_spd][2] + 1
            end
        elseif (command == Keys.LeftSpeedDriveDOWN) then
            -- print_message_to_user(3)
            if (target_status[left_spd][2] > -0.5) then
                -- print_message_to_user(4)
                current_status[left_spd][3] = current_status[left_spd][2]
                target_status[left_spd][2] = target_status[left_spd][2] - 1
            end
        elseif (command == Keys.FuelMasterLeft) then
            current_status[left_fuel_m][3] = current_status[left_fuel_m][2]
            target_status[left_fuel_m][2] = 1 - target_status[left_fuel_m][2]
        elseif (command == Keys.FuelMasterRight) then
            current_status[right_fuel_m][3] = current_status[right_fuel_m][2]
            target_status[right_fuel_m][2] = 1 - target_status[right_fuel_m][2]
        elseif (command == Keys.LeftEngineCrank) then
            current_status[left_crank][3] = current_status[left_crank][2]
            target_status[left_crank][2] = SWITCH_ON
            start_count_flag_l = 1
            start_count_time = 0
        elseif (command == Keys.RightEngineCrank) then
            --print_message_to_user("1")
            current_status[right_crank][3] = current_status[right_crank][2]
            target_status[right_crank][2] = SWITCH_ON
            start_count_flag_r = 1
            start_count_time = 0
        elseif (command == Keys.LeftEngineCrankUP) then
            current_status[left_crank][3] = current_status[left_crank][2]
            target_status[left_crank][2] = SWITCH_OFF
            start_count_flag_l = 0
            start_count_time = 0
        elseif (command == Keys.RightEngineCrankUP) then
            --print_message_to_user("end")
            current_status[right_crank][3] = current_status[right_crank][2]
            target_status[right_crank][2] = SWITCH_OFF
            start_count_flag_r = 0
            start_count_time = 0
        elseif (command == Keys.LeftEngineIDLEPOS) then
            print_message_to_user(left_throttle:get())
            if (left_idle_status == SWITCH_ON and left_throttle:get() < 0.17) then
                left_idle_status = SWITCH_OFF
                left_throttle:set(left_idle_status)
                dispatch_action(nil, iCommandLeftEngineStop)
                print_message_to_user("dispatch_action")
                -- engine_state_left = ENGINE_OFF
                L_IDLE_RESTART = 1
            elseif engine_state_left == ENGINE_STARTING or (engine_state_left == ENGINE_RUNNING and L_IDLE_RESTART == 1) then
                dispatch_action(nil, iCommandLeftEngineStart, nil)
                engine_state_left = ENGINE_RUNNING
                -- Externel_Bleed_Status = SWITCH_OFF
                left_idle_status = SWITCH_ON
                left_throttle:set(0.15)
                L_IDLE_RESTART = 0
            end
        elseif (command == Keys.RightEngineIDLEPOS) then
            if (right_idle_status == SWITCH_ON and right_throttle:get() < 0.17) then
                right_idle_status = SWITCH_OFF
                right_throttle:set(right_idle_status)
                -- engine_state_right = ENGINE_OFF
                dispatch_action(nil, iCommandRightEngineStop)
                print_message_to_user("dispatch_action")
                R_IDLE_RESTART = 1
            elseif engine_state_right == ENGINE_STARTING or (engine_state_right == ENGINE_RUNNING and R_IDLE_RESTART == 1) then
                dispatch_action(nil, iCommandRightEngineStart, nil)
                engine_state_right = ENGINE_RUNNING
                -- Externel_Bleed_Status = SWITCH_OFF
                right_idle_status = SWITCH_ON
                right_throttle:set(0.15)
                R_IDLE_RESTART = 0
            end
        elseif (command == Keys.CSDSwitch) then
            if target_status[bleed_hold_status][2] == SWITCH_ON then
                current_status[csd_status][3] = current_status[csd_status][2]
                target_status[csd_status][2] = 1 - target_status[csd_status][2]
            end
        elseif (command == Keys.NWWSwitch) then
            if target_status[bleed_hold_status][2] == SWITCH_ON then
                current_status[nww_status][3] = current_status[nww_status][2]
                target_status[nww_status][2] = 1 - target_status[nww_status][2]
            end
        elseif (command == Keys.AirCondSwitch) then
            if target_status[bleed_hold_status][2] == SWITCH_ON then
                current_status[aircond_status][3] = current_status[aircond_status][2]
                target_status[aircond_status][2] = 1 - target_status[aircond_status][2]
            end
        elseif (command == Keys.BleedHoldCover) then
            current_status[bleed_hold_status][3] = current_status[bleed_hold_status][2]
            target_status[bleed_hold_status][2] = 1 - target_status[bleed_hold_status][2]
            if target_status[bleed_hold_status][2] == SWITCH_OFF then
                current_status[csd_status][3] = current_status[csd_status][2]
                current_status[nww_status][3] = current_status[nww_status][2]
                current_status[aircond_status][3] = current_status[aircond_status][2]
                target_status[csd_status][2] = SWITCH_OFF
                target_status[nww_status][2] = SWITCH_OFF
                target_status[aircond_status][2] = SWITCH_OFF
            end
        end
    end
end

function update_bleed_status()
    --[[
        The structure of bleed system is something like following: 
                                                                |----Wind Sield De-Ice  |- air
            Engine L -|                 |---- NWW VALVE --------|---- Wind Heat         |- wash
        CSD-----+     AIR COND VALVE----|                       
            Engine_R -|                 |---- Environment control system


    ]]--
    local bleed_aircond_status = target_status[aircond_status][2]
    local bleed_nww_status = target_status[nww_status][2]
    local ecs_trans_parameter = get_param_handle("EnvironmentControl")
    local nww_bleed = get_param_handle("WindshieldDeice")
    if sensor_data.getEngineLeftRPM() > 50 or sensor_data.getEngineRightRPM() > 50 then
        ecs_trans_parameter:set(bleed_aircond_status)
        nww_bleed:set(bleed_nww_status)
    else
        ecs_trans_parameter:set(0)
        nww_bleed:set(0)
    end
end

FUEL_MASTER_STOP_FLAG_L = 0
FUEL_MASTER_STOP_FLAG_R = 0

function update_Engine_Status()
    print_message_to_user(right_throttle_efm:get())
    if sensor_data.getEngineLeftRPM() <= 10 then
        engine_state_left = ENGINE_POST_STARTING
        FUEL_MASTER_STOP_FLAG_L = 0
        L_IDLE_RESTART = 0
    elseif sensor_data.getEngineLeftRPM() < 45 then
            engine_state_left = ENGINE_STARTING
    elseif sensor_data.getEngineLeftRPM() >= 45 then
        engine_state_left = ENGINE_RUNNING
    elseif (left_idle_status == SWITCH_OFF and sensor_data.getEngineLeftRPM() >= 20) then
        dispatch_action(nil, iCommandLeftEngineStop)
    else
        engine_state_left = ENGINE_OFF
    end
    if sensor_data.getEngineRightRPM() <= 10 then
        engine_state_right = ENGINE_POST_STARTING
        FUEL_MASTER_STOP_FLAG_R = 0
        R_IDLE_RESTART = 0
    elseif sensor_data.getEngineRightRPM() < 45 then
        engine_state_right = ENGINE_STARTING
    elseif sensor_data.getEngineRightRPM() >= 45 then
        engine_state_right = ENGINE_RUNNING
    elseif (right_idle_status == SWITCH_OFF and sensor_data.getEngineRightRPM() >= 20) then
        dispatch_action(nil, iCommandRightEngineStop)
    else
        engine_state_right = ENGINE_OFF
    end

    if left_idle_status == SWITCH_ON then
        left_throttle:set(left_throttle_efm:get() * 0.85 + 0.15) 
    end
    if right_idle_status == SWITCH_ON then
        right_throttle:set(right_throttle_efm:get() * 0.85 + 0.15)
    end

    if target_status[left_fuel_m][2] == SWITCH_OFF and (engine_state_left == ENGINE_RUNNING or engine_state_left == ENGINE_STARTING) then
        dispatch_action(nil, iCommandLeftEngineStop, nil)
        FUEL_MASTER_STOP_FLAG_L = 1
    elseif target_status[left_fuel_m][2] == SWITCH_ON and (engine_state_left == ENGINE_STARTING or engine_state_left == ENGINE_RUNNING) and (FUEL_MASTER_STOP_FLAG_L == 1 and left_idle_status == SWITCH_ON) then
        print_message_to_user("restart")
        dispatch_action(nil, iCommandLeftEngineStart, nil)
        FUEL_MASTER_STOP_FLAG_L = 0
    end

    if target_status[right_fuel_m][2] == SWITCH_OFF and (engine_state_right == ENGINE_RUNNING or engine_state_right == ENGINE_STARTING) then
        dispatch_action(nil, iCommandRightEngineStop, nil)
        FUEL_MASTER_STOP_FLAG_R = 1
    elseif target_status[right_fuel_m][2] == SWITCH_ON and (engine_state_right == ENGINE_STARTING or engine_state_right == ENGINE_RUNNING) and (right_idle_status == SWITCH_ON and FUEL_MASTER_STOP_FLAG_R == 1) then
        print_message_to_user("restart")
        dispatch_action(nil, iCommandRightEngineStart, nil)
        FUEL_MASTER_STOP_FLAG_R = 0
    end
    -- print_message_to_user("EngineState:"..sensor_data.getEngineRightRPM()..","..engine_state_right..";")
    
    local lthro_click_ref = get_clickable_element_reference("PTN_LTHRO")
    local rthro_click_ref = get_clickable_element_reference("PTN_RTHRO")

    if left_idle_status == SWITCH_ON then
        lthro_click_ref:set_hint("Move Left Throttle to OFF")
        if left_throttle_efm:get() < 0.05 then
            lthro_click_ref:hide(false)
            lthro_click_ref:update()
        else
            lthro_click_ref:hide(true)
        end
    else
        lthro_click_ref:set_hint("Move Left Throttle to IDLE")
        lthro_click_ref:hide(false)
        lthro_click_ref:update()
    end

    if right_idle_status == SWITCH_ON then
        rthro_click_ref:set_hint("Move Left Throttle to OFF")
        if right_throttle_efm:get() < 0.05 then
            rthro_click_ref:hide(false)
            rthro_click_ref:update()
        else
            rthro_click_ref:hide(true)
        end
    else
        rthro_click_ref:set_hint("Move Left Throttle to IDLE")
        rthro_click_ref:hide(false)
        rthro_click_ref:update()
    end
end

function update_externel_pneumatic_status()
    local temp_status = get_aircraft_draw_argument_value(124)
    if temp_status > 0.7 then
        Externel_Bleed_Status = SWITCH_ON
    else
        Externel_Bleed_Status = SWITCH_OFF
    end
end

function check_if_engine_starting()
    -- print_message_to_user((Externel_Bleed_Status))--  == SWITCH_ON or (target_status[csd_status][2] == SWITCH_ON and sensor_data.getEngineRightRPM() >= 40)))
    if (target_status[left_spd][2] == SWITCH_ON and target_status[left_fuel_m][2] == SWITCH_ON and (Externel_Bleed_Status == SWITCH_ON or (target_status[csd_status][2] == SWITCH_ON and sensor_data.getEngineRightRPM() >= 40))) then
        -- print_message_to_user("l_engine_crank")
        if start_count_flag_l == 1 then
            start_count_time = start_count_time + 1
            if start_count_time > 75 then
                print_message_to_user("l_engine_start")
                dispatch_action(nil, iCommandLeftEngineStart, nil)
                start_count_flag_l = 0
            end
        end
    end
    if (target_status[right_spd][2] == SWITCH_ON and target_status[right_fuel_m][2] == SWITCH_ON and (Externel_Bleed_Status == SWITCH_ON or (target_status[csd_status][2] == SWITCH_ON and sensor_data.getEngineLeftRPM() >= 40))) then
        if start_count_flag_r == 1 then
            --print_message_to_user("r_crank_count")
            start_count_time = start_count_time + 1
            if start_count_time > 75 then
                print_message_to_user("r_engine_start")
                dispatch_action(nil, iCommandRightEngineStart, nil)
                start_count_flag_r = 0
            end
        end
    end
end

function update()
    -- update engine working status
    update_externel_pneumatic_status()
    check_if_engine_starting()
    update_Engine_Status()
    update_switch_status()
    update_Engine_Working_Status()
    update_bleed_status()
end

--不关闭该lua
need_to_be_closed = false