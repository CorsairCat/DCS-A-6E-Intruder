dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local gear_system = GetSelf()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--local iCommandPlaneGear
local gear_switch = 68  --定义起落架按键
local gear_up = 430
local gear_down = 431

local nose_gear_status = 1   --起落架状态 0 收起, 1 放下
local l_main_gear_status = 1
local r_main_gear_status = 1

local nose_gear_broken = 0   --起落架状况 0 正常, 1 故障
local l_main_gear_broken = 0
local r_main_gear_broken = 0

local gear_level_init = 0 --起落架手柄默认未设置状态

-- init base for hook, launch bar
local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local landing_hook_handle = _switch_counter()
local launch_bar_handle = _switch_counter()

target_status = {
    {landing_hook_handle , SWITCH_OFF, get_param_handle("PTN_053"), "PTN_053"},
    {launch_bar_handle, SWITCH_OFF, get_param_handle("PTN_054"), "PTN_054"},
}

current_status = {
    {landing_hook_handle , SWITCH_OFF, SWITCH_OFF},
    {launch_bar_handle, SWITCH_OFF,},
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

local gear_level = get_param_handle("LandingGearLevel")

-- set indicator
local ngear_pos_ind = get_param_handle("NoseWPOS_IND")
local mlgear_pos_ind = get_param_handle("MainLWPOS_IND")
local mrgear_pos_ind = get_param_handle("MainRWPOS_IND")

gear_system:listen_command(gear_switch)
gear_system:listen_command(gear_up)
gear_system:listen_command(gear_down)
gear_system:listen_command(click_cmd.GearLevel)
gear_system:listen_command(120)
gear_system:listen_command(Keys.HookHandle)
gear_system:listen_command(Keys.LaunchBarHandle)

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
        nose_gear_status = 1   --起落架状态 0 收起, 1 放下
        l_main_gear_status = 1
        r_main_gear_status = 1
    elseif birth=="AIR_HOT" then
        nose_gear_status = 0   --起落架状态 0 收起, 1 放下
        l_main_gear_status = 0
        r_main_gear_status = 0
    elseif birth=="GROUND_COLD" then
        nose_gear_status = 1   --起落架状态 0 收起, 1 放下
        l_main_gear_status = 1
        r_main_gear_status = 1
    end

    if (gear_level_init == 0) then
        --gear_system:performClickableAction(click_cmd.GearLevel, 1, false)
    end

    set_aircraft_draw_argument_value(0, nose_gear_status)
    set_aircraft_draw_argument_value(3, r_main_gear_status)
    set_aircraft_draw_argument_value(5, l_main_gear_status)
    gear_level:set(1 - nose_gear_status)
end

HOOK_TARGET_STATUS = 0
HOOK_CURR_STATUS = 0
LAUNCH_BAR_TARGET_STATUS = 0
LAUNCH_BAR_CURR_STATUS = 0


function SetCommand(command,value)
    if (command == click_cmd.GearLevel) then
        dispatch_action(nil, 68) --重设指令到默认起落架命令
    elseif (command == gear_switch) then
        nose_gear_status = 1 - nose_gear_status
        l_main_gear_status = 1 - l_main_gear_status
        r_main_gear_status = 1 - r_main_gear_status
        if (nose_gear_status == 1) then
            print_message_to_user("Gear Down")
        else
            print_message_to_user("Gear Up")
        end
    elseif (command == gear_down) then
        nose_gear_status = 1
        l_main_gear_status = 1
        r_main_gear_status = 1
    elseif (command == gear_up) then
        nose_gear_status = 0
        l_main_gear_status = 0
        r_main_gear_status = 0       
    elseif (command == 120) then
        dispatch_action(nil, THROTTLEAXIS, -1)
    elseif (command == Keys.LaunchBarHandle) then
        target_status[launch_bar_handle][2] = 1 - target_status[launch_bar_handle][2]
        LAUNCH_BAR_TARGET_STATUS = target_status[launch_bar_handle][2]
        print_message_to_user(LAUNCH_BAR_TARGET_STATUS)
    elseif (command == Keys.HookHandle) then
        target_status[landing_hook_handle][2] = 1 - target_status[landing_hook_handle][2]
        HOOK_TARGET_STATUS = target_status[landing_hook_handle][2]
    end
end

IS_LOCKED_TO_CATAPULT_STATUS = get_param_handle("is_locked_to_catapult")

function update_hook_and_bar()
    local time_increse_step = 0.005
    --HOOK_CURR_STATUS = get_aircraft_draw_argument_value(25)
    --LAUNCH_BAR_CURR_STATUS = get_aircraft_draw_argument_value(85)
    if math.abs(HOOK_CURR_STATUS - HOOK_TARGET_STATUS) < 0.01 then
       HOOK_CURR_STATUS = HOOK_TARGET_STATUS
    else
        if HOOK_CURR_STATUS < HOOK_TARGET_STATUS then
            HOOK_CURR_STATUS = HOOK_CURR_STATUS + 0.01
        elseif HOOK_CURR_STATUS > HOOK_TARGET_STATUS then
            HOOK_CURR_STATUS = HOOK_CURR_STATUS - time_increse_step
        end
    end

    if IS_LOCKED_TO_CATAPULT_STATUS ~= 1 then
        if math.abs(LAUNCH_BAR_CURR_STATUS - LAUNCH_BAR_TARGET_STATUS) < 0.05 then
            LAUNCH_BAR_CURR_STATUS = LAUNCH_BAR_TARGET_STATUS
        else
            if LAUNCH_BAR_CURR_STATUS < LAUNCH_BAR_TARGET_STATUS then
                LAUNCH_BAR_CURR_STATUS = LAUNCH_BAR_CURR_STATUS + time_increse_step
            elseif LAUNCH_BAR_CURR_STATUS > LAUNCH_BAR_TARGET_STATUS then
                LAUNCH_BAR_CURR_STATUS = LAUNCH_BAR_CURR_STATUS - time_increse_step
            end
        end
    else
        -- do noting? / or set to another value
        LAUNCH_BAR_CURR_STATUS = 0.9
    end
    
    set_aircraft_draw_argument_value(25, HOOK_CURR_STATUS)
    -- print_message_to_user(HOOK_CURR_STATUS)
end

local gear_level_pos = gear_level:get()

function update()
    update_switch_status()
    update_hook_and_bar()

    local gear_handle_click_ref = get_clickable_element_reference("PNT_083")

    local n_gear_status = get_aircraft_draw_argument_value(0)
    local l_gear_status = get_aircraft_draw_argument_value(5)
    local r_gear_status = get_aircraft_draw_argument_value(3)

    if nose_gear_status == 1 then
        set_aircraft_draw_argument_value(85, LAUNCH_BAR_CURR_STATUS)
    else
        set_aircraft_draw_argument_value(85, n_gear_status)
    end

        --takes 7 seconds to full extended
        -- set globle time count
        local time_increse_step = 0.02 / 7

        if (nose_gear_status == 0 and n_gear_status > 0) then
            -- in increments of time_increse_step (50x per second)
            n_gear_status = n_gear_status - time_increse_step
            set_aircraft_draw_argument_value(0, n_gear_status)
        elseif (nose_gear_status == 1 and n_gear_status < 1) then
            -- in increments of time_increse_step (50x per second)
            n_gear_status = n_gear_status + time_increse_step
            set_aircraft_draw_argument_value(0, n_gear_status)
        end

        if (nose_gear_status == 0 and n_gear_status <= 0) then
            nose_gear_status = 0
        elseif (nose_gear_status == 1 and n_gear_status >= 1)then
            nose_gear_status = 1
        end

        if (l_main_gear_status == 0 and l_gear_status > 0) then
            l_gear_status = l_gear_status - time_increse_step
            set_aircraft_draw_argument_value(5, l_gear_status)
        elseif (l_main_gear_status == 1 and l_gear_status < 1) then
            l_gear_status = l_gear_status + time_increse_step
            set_aircraft_draw_argument_value(5, l_gear_status)
        end

        if (r_main_gear_status == 0 and r_gear_status > 0) then
            -- lower canopy in increments of time_increse_step (50x per second)
            r_gear_status = r_gear_status - time_increse_step
            set_aircraft_draw_argument_value(3, r_gear_status)
        elseif (r_main_gear_status == 1 and r_gear_status < 1) then
            -- lower canopy in increments of time_increse_step (50x per second)
            r_gear_status = r_gear_status + time_increse_step
            set_aircraft_draw_argument_value(3, r_gear_status)
        end
        
        -- level step slower
        if (nose_gear_status == 0 and gear_level_pos < 1) then
            -- lower canopy in increments of time_increse_step (50x per second)
            gear_level_pos = gear_level_pos + 0.1
            gear_level:set(gear_level_pos)
            gear_handle_click_ref:update()
        elseif (nose_gear_status == 1 and gear_level_pos > 0) then
            -- lower canopy in increments of time_increse_step (50x per second)
            gear_level_pos = gear_level_pos - 0.1
            gear_level:set(gear_level_pos)
            gear_handle_click_ref:update()
        end

        ngear_pos_ind:set(n_gear_status)
        mlgear_pos_ind:set(l_gear_status)
        mrgear_pos_ind:set(r_gear_status)
        
end

need_to_be_closed = false