dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local VDIControlSystem 	    = GetSelf()

local sensor_data = get_base_data()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6 
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_INCH = 3.2808

local vdi_base_enable = get_param_handle("VDI_DIS_ENABLE")
local vdi_simbol_enable = get_param_handle("VDI_SIM_DIS_ENABLE")
local vdi_analog_enable = get_param_handle("VDI_ANALOG_DIS_ENABLE")
local vdi_cloud_tex_enable = get_param_handle("VDI_CLOUD_DIS_ENABLE")
local vdi_ground_tex_enable = get_param_handle("VDI_ANALOG_GROUND_ENABLE")
local vdi_ground_moving = get_param_handle("VDI_ANALOG_GROUND_MOVING")
local vdi_bank_angle = get_param_handle("VDI_BANK")
local vdi_ana_roll = get_param_handle("VDI_ANALOG_ADI_ROLL")
local vdi_bank_up = get_param_handle("VDI_BANK_MOVE_PARAM")
local vdi_bg_pitch = get_param_handle("VDI_BG_PITCH")
local vdi_impact_pitch = get_param_handle("VDI_PITCH_MOVE")
local vdi_impact_yaw = get_param_handle("VDI_YAW_MOVE")

local test_uhf = get_param_handle("UHF_DISPLAY")

------Here Strat the general Switch Control

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

CURRENT_DISPLAY = 1
CURRENT_LIGHTNESS = 0.3

local vdi_control_off = _switch_counter()  -- 1
local vdi_control_stby = _switch_counter() -- 2
local vdi_control_tc = _switch_counter() -- 3
local vdi_control_tc_C = _switch_counter() -- 4
local vdi_control_analog = _switch_counter() -- 5

target_status = {
    {vdi_control_off , SWITCH_ON, get_param_handle("PTN_135"), "PTN_135"},
    {vdi_control_stby , SWITCH_OFF, get_param_handle("PTN_136"), "PTN_136"},
    {vdi_control_tc , SWITCH_OFF, get_param_handle("PTN_137"), "PTN_137"},
    {vdi_control_tc_C , SWITCH_OFF, get_param_handle("PTN_138"), "PTN_138"},
    {vdi_control_analog , SWITCH_OFF, get_param_handle("PTN_139"), "PTN_139"},
}

current_status = {
    {vdi_control_off , SWITCH_OFF,},
    {vdi_control_stby , SWITCH_OFF,},
    {vdi_control_tc , SWITCH_OFF,},
    {vdi_control_tc_C , SWITCH_OFF,},
    {vdi_control_analog , SWITCH_OFF,},
}

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

function init_analog()
    for i = 1, 12, 1 do
        temp_control = get_param_handle("VDI_ANALOG_CLOUD_MOVING_"..i)
        if i == 11 or i == 12 then
            temp_control:set(1.1)
        elseif i == 2 then
            temp_control:set(0.65)
        elseif i == 7  then
            temp_control:set(0.7)
        elseif i == 3 then
            temp_control:set(0.3)
        elseif i == 6 then
            temp_control:set(0.2)
        elseif i == 4 then
            temp_control:set(0.4)
        elseif i == 5 then
            temp_control:set(0.825)
        elseif i == 9 then
            temp_control:set(1.25)
        elseif i == 8 then
            temp_control:set(1.5)
        elseif i == 1 then
            temp_control:set(1.55)
        elseif i == 10 then
            temp_control:set(1.675)
        end
    end
end

function post_initialize()
    -- test_uhf:set("DEFAULT UHF CHANNEL TEST")
    for k,v in pairs(target_status) do
        current_status[k][2] = target_status[k][2]
        target_status[k][3]:set(current_status[k][2])
    end
end

VDIControlSystem:listen_command(Keys.VDIControlOff)
VDIControlSystem:listen_command(Keys.VDIControlSTBY)
VDIControlSystem:listen_command(Keys.VDIControlTC)
VDIControlSystem:listen_command(Keys.VDIControlTCCal)
VDIControlSystem:listen_command(Keys.VDIControlAnalog)

function SetCommand(command, value)
    if command == Keys.VDIControlOff then
        target_status[CURRENT_DISPLAY][2] = SWITCH_OFF
        target_status[vdi_control_off][2] = SWITCH_ON
        CURRENT_DISPLAY = vdi_control_off
    elseif command == Keys.VDIControlSTBY then
        target_status[CURRENT_DISPLAY][2] = SWITCH_OFF
        target_status[vdi_control_stby][2] = SWITCH_ON
        CURRENT_DISPLAY = vdi_control_stby
    elseif command == Keys.VDIControlTC then
        target_status[CURRENT_DISPLAY][2] = SWITCH_OFF
        target_status[vdi_control_tc][2] = SWITCH_ON
        CURRENT_DISPLAY = vdi_control_tc
    elseif command == Keys.VDIControlTCCal then
        target_status[CURRENT_DISPLAY][2] = SWITCH_OFF
        target_status[vdi_control_tc_C][2] = SWITCH_ON
        CURRENT_DISPLAY = vdi_control_tc_C
    elseif command == Keys.VDIControlAnalog then
        target_status[CURRENT_DISPLAY][2] = SWITCH_OFF
        target_status[vdi_control_analog][2] = SWITCH_ON
        CURRENT_DISPLAY = vdi_control_analog
        init_analog()
    end
end

function update_AnalogPage(is_display)
    local current_opac = CURRENT_LIGHTNESS * is_display
    vdi_ground_tex_enable:set(current_opac)
    vdi_analog_enable:set(current_opac)
    vdi_cloud_tex_enable:set(current_opac)
    -- vdi_base_enable:set(1)
    vdi_simbol_enable:set(current_opac * 2)

    local moving_step = 0.005
    local current_move = vdi_ground_moving:get()
    if current_move > - 0.7 then
        vdi_ground_moving:set(current_move - moving_step)
    else
        vdi_ground_moving:set(current_move + 1 - moving_step)
    end
    local temp_control 
    local temp_opac
    local moving_step = 0.005
    for i = 1, 12, 1 do
        temp_control = get_param_handle("VDI_ANALOG_CLOUD_MOVING_"..i)
        temp_opac = get_param_handle("VDI_ANALOG_CLOUD_OPAC_"..i)
        current_move = temp_control:get()
        if current_move > 2 then
            temp_control:set(0.3)
            current_move = 0.3
        else
            temp_control:set(current_move + moving_step)
        end
        if current_move < 0.4 then
            temp_opac:set(((current_move - 0.3) * 4) * current_opac)
        else
            temp_opac:set(1 * current_opac)
        end
    end

    vdi_ana_roll:set(sensor_data.getRoll())
    vdi_bg_pitch:set(- sensor_data.getPitch() * 0.5)

    vdi_impact_pitch:set(- sensor_data.getAngleOfAttack() * 0.5)
    vdi_impact_yaw:set(- sensor_data.getAngleOfSlide() * 0.5)

    vdi_bank_angle:set(- sensor_data.getRoll() * 0.5)
    vdi_bank_up:set(math.abs(sensor_data.getRoll() * 0.05))
end

function update()
    update_switch_status()
    if CURRENT_DISPLAY > 1.2 then
        vdi_base_enable:set(1)
    else
        vdi_base_enable:set(0)
    end
    if CURRENT_DISPLAY == vdi_control_analog then
        update_AnalogPage(1)
    else
        update_AnalogPage(0)
    end
end

