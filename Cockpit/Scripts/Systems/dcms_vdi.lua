dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev 	    = GetSelf()

local sensor_data = get_base_data()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6 
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_INCH = 3.2808

local vdi_test_enable = get_param_handle("VDI_DIS_ENABLE")
local vdi_analog_enable = get_param_handle("VDI_ANALOG_DIS_ENABLE")
local vdi_cloud_tex_enable = get_param_handle("VDI_CLOUD_DIS_ENABLE")
local vdi_ground_tex_enable = get_param_handle("VDI_ANALOG_GROUND_ENABLE")
local vdi_ground_moving = get_param_handle("VDI_ANALOG_GROUND_MOVING")

local vdi_ana_roll = get_param_handle("VDI_ANALOG_ADI_ROLL")

function post_initialize()
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

function update()
    vdi_ground_tex_enable:set(0.3)
    vdi_analog_enable:set(0.3)
    vdi_cloud_tex_enable:set(0.3)
    vdi_test_enable:set(1)

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
            temp_opac:set(((current_move - 0.3) * 4))
        else
            temp_opac:set(1)
        end
    end

    vdi_ana_roll:set(sensor_data.getRoll() * RAD_TO_DEGREE / 90 / 2)
end

