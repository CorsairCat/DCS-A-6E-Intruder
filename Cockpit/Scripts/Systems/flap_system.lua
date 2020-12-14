local FlapSys = GetSelf()
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local flap_level = get_param_handle("FlapLevel")

-- set indicator
local flap_pos_ind = get_param_handle("FLAPPOS_IND")

flap_current_state = 0
flap_level_state = 0
flap_target_pos = 0
flap_level_target = 0

FlapSys:listen_command(Keys.FlapUp)
FlapSys:listen_command(Keys.FlapDown)

last_target = 0

function SetCommand(command,value)
    if (command == Keys.FlapUp) then
        print_message_to_user("flapup")
        if (flap_level_target < 0.8) and (flap_level_target > 0.6) then
            print_message_to_user("up1")
            last_target = flap_target_pos
            flap_target_pos = -0.1
            flap_level_target = -0.1
        elseif (flap_level_target > 0.8) then
            print_message_to_user("up2")
            last_target = flap_target_pos
            flap_level_target = 0.7
            flap_target_pos = 0.7
        end
    elseif (command == Keys.FlapDown) then
        print_message_to_user("flapdown")
        if (flap_level_target < 0.1) then
            print_message_to_user("down1")
            last_target = flap_target_pos
            flap_target_pos = 0.7
            flap_level_target = 0.7
        elseif (flap_level_target < 0.8) and (flap_level_target > 0.6) then
            print_message_to_user("down2")
            last_target = flap_target_pos
            flap_level_target = 1.1
            flap_target_pos = 1.1
        end
    end
end

function update()
    -- takes 10 seconds to fully extend
    -- todo: apply need to have power to proceed this step

    local flap_level_click_ref = get_clickable_element_reference("FLAP_LEVEL")

    local flap_move_speed = 0.002
    if (flap_current_state < flap_target_pos) and (flap_target_pos >= 1)then
        flap_current_state = flap_current_state + flap_move_speed
    elseif (flap_current_state > flap_target_pos) and (flap_target_pos <= 0)then
        flap_current_state = flap_current_state - flap_move_speed
    end

    -- move handle more quicker
    local flap_level_move_speed = 0.05
    if (flap_level_state < flap_level_target) and (flap_target_pos >= 1) then
        flap_level_state = flap_level_state + flap_level_move_speed
        flap_level_click_ref:update()
    elseif (flap_level_state > flap_level_target) and (flap_target_pos <= 0) then
        flap_level_state = flap_level_state - flap_level_move_speed
        flap_level_click_ref:update()
    end

    if (flap_target_pos < 0.8) and (flap_target_pos > 0.6) then
        if (last_target <= 0.1) then
            if (flap_current_state < flap_target_pos) then
                flap_current_state = flap_current_state + flap_move_speed
            end
            if (flap_level_state < flap_level_target) then
                flap_level_state = flap_level_state + flap_level_move_speed
                flap_level_click_ref:update()
            end
        elseif (last_target >= 0.9) then
            if (flap_current_state > flap_target_pos) then
                flap_current_state = flap_current_state - flap_move_speed
            end
            if (flap_level_state > flap_level_target) then
                flap_level_state = flap_level_state - flap_level_move_speed
                flap_level_click_ref:update()
            end
        end
    end

    set_aircraft_draw_argument_value(9,flap_current_state)
    set_aircraft_draw_argument_value(10,flap_current_state)
    set_aircraft_draw_argument_value(13,flap_current_state)
    set_aircraft_draw_argument_value(14,flap_current_state)

    flap_pos_ind:set(flap_current_state)

    flap_level:set(flap_level_state)
end

--该lua初始化后不关闭
need_to_be_closed = false