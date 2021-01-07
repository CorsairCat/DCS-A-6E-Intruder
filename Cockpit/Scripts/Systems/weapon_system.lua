local WeaponSystem     = GetSelf()
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
--dofile(LockOn_Options.script_path.."Systems/stores_config.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
-- load wstype database to identify the weapon
dofile(LockOn_Options.common_script_path.."../../../Database/wsTypes.lua")

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local iCommandPlaneWingtipSmokeOnOff = 78
local iCommandPlaneJettisonWeapons = 82
local iCommandPlaneFire = 84
local iCommandPlaneFireOff = 85
local iCommandPlaneChangeWeapon = 101
local iCommandActiveJamming = 136
local iCommandPlaneJettisonFuelTanks = 178
local iCommandPlanePickleOn = 350
local iCommandPlanePickleOff = 351
--local iCommandPlaneDropFlareOnce = 357
--local iCommandPlaneDropChaffOnce = 358

-- local pylonSelected = -1

-- 获取锁定状态
-- 是否锁定
local ir_missile_lock_param = get_param_handle("WS_IR_MISSILE_LOCK")
-- 锁定的目标的高程和方向
local ir_missile_az_param = get_param_handle("WS_IR_MISSILE_TARGET_AZIMUTH")
local ir_missile_el_param = get_param_handle("WS_IR_MISSILE_TARGET_ELEVATION")

-- 似乎是设置预设锁定方向？
-- 方位角
local ir_missile_des_az_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH")
-- 高程
local ir_missile_des_el_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION")

WeaponSystem:listen_command(Keys.WeaponLaunch)
WeaponSystem:listen_command(Keys.WeaponLaunchOff)
WeaponSystem:listen_command(Keys.MasterArmamentUP)
WeaponSystem:listen_command(Keys.MasterArmamentDOWN)
WeaponSystem:listen_command(Keys.Pylon1SelUP)
WeaponSystem:listen_command(Keys.Pylon1SelDOWN)
WeaponSystem:listen_command(Keys.Pylon2SelUP)
WeaponSystem:listen_command(Keys.Pylon2SelDOWN)
WeaponSystem:listen_command(Keys.Pylon3SelUP)
WeaponSystem:listen_command(Keys.Pylon3SelDOWN)
WeaponSystem:listen_command(Keys.Pylon4SelUP)
WeaponSystem:listen_command(Keys.Pylon4SelDOWN)
WeaponSystem:listen_command(Keys.Pylon5SelUP)
WeaponSystem:listen_command(Keys.Pylon5SelDOWN)
WeaponSystem:listen_command(Keys.QuantityTumbWheel10)
WeaponSystem:listen_command(Keys.QuantityTumbWheel)
WeaponSystem:listen_command(Keys.IntervalTumbWheel100)
WeaponSystem:listen_command(Keys.IntervalTumbWheel10)
WeaponSystem:listen_command(Keys.IntervalTumbWheel)
WeaponSystem:listen_command(Keys.TimeTumbWheel100)
WeaponSystem:listen_command(Keys.TimeTumbWheel10)
WeaponSystem:listen_command(Keys.TimeTumbWheel)
WeaponSystem:listen_command(Keys.ReleaseJettison)
WeaponSystem:listen_command(Keys.ReleaseGun)
WeaponSystem:listen_command(Keys.ReleaseMissile)
WeaponSystem:listen_command(Keys.ReleaseRocketSalvo)
WeaponSystem:listen_command(Keys.ReleaseRocketTrain)
WeaponSystem:listen_command(Keys.ReleaseBombSalve)
WeaponSystem:listen_command(Keys.ReleaseBombTrain)
WeaponSystem:listen_command(Keys.ReleaseStep)
WeaponSystem:listen_command(Keys.AttackGCB)
WeaponSystem:listen_command(Keys.AttackDelay)
WeaponSystem:listen_command(Keys.AttackLabTGT)
WeaponSystem:listen_command(Keys.AttackLabIP)
WeaponSystem:listen_command(Keys.AttackRocket)
WeaponSystem:listen_command(Keys.AttackHILoft)
WeaponSystem:listen_command(Keys.AttackStraight)
WeaponSystem:listen_command(Keys.AttackGeneral)

----rest are for pylon drop tank checking and will send to parameters

local LAUNCH_MODE = -1 -- STEP:0; BOMBS: 1; ROCKETS: 2; GUN: 3; MISSILES: 4; SEL JET: 5; -1: unselected
local LAST_LAUNCH_BUTTON = -1
local ATTACK_MODE = -1 -- DELAY: 0; LAB IP: 1; LAB TGT: 2; GCB: 3; ROCKET: 4; HI LOFT: 5; STRAIGHT PATH: 6; GENERAL: 7; -1 : unselected
local LAST_ATTACK_BUTTON = -1
local IS_TRAINING = 0 -- TRAINING: 1;
local RESELECT_LIGHT_STATUS = 0
local COMPLETE_LIGHT_STATUS = 0
local RESELECT_LIGHT = get_param_handle("PTN_562")
local COMPLETE_LIGHT = get_param_handle("PTN_563")
local TOTAL_LAUNCH_NUM = 0
local INTERVAL_SET = 0
local TIME_SET = 0
local QUANTITY_SET = 0
local MANUAL_RELEASE_SIGNAL = 0
local DataFreeze = 0
local STEP_SIGNAL = 0

local SELECTED_LIST = {
    -- {is_launch, pylon launch number, select_light}
    {0, 0, get_param_handle("PTN_501")},
    {0, 0, get_param_handle("PTN_502")},
    {0, 0, get_param_handle("PTN_503")},
    {0, 0, get_param_handle("PTN_504")},
    {0, 0, get_param_handle("PTN_505")},
}

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1


switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local master_arm_switch = _switch_counter()
local pylon1_select_switch = _switch_counter()
local pylon2_select_switch = _switch_counter()
local pylon3_select_switch = _switch_counter()
local pylon4_select_switch = _switch_counter()
local pylon5_select_switch = _switch_counter()

local attack_interval_A = _switch_counter()
local attack_interval_B = _switch_counter()
local attack_interval_C = _switch_counter()
local attack_quantity_B = _switch_counter()
local attack_quantity_C = _switch_counter()
local attack_time_A = _switch_counter()
local attack_time_B = _switch_counter()
local attack_time_C = _switch_counter()

local release_step = _switch_counter()
local release_bomb_train = _switch_counter()
local release_bomb_salvo = _switch_counter()
local release_rocket_train = _switch_counter()
local release_rocket_salvo = _switch_counter()
local release_missiles = _switch_counter()
local release_guns = _switch_counter()
local release_sel_jet = _switch_counter()

local attack_gcb_mode = _switch_counter()
local attack_delay_mode = _switch_counter()
local attack_labtgt_mode = _switch_counter()
local attack_labip_mode = _switch_counter()
local attack_rocket_mode = _switch_counter()
local attack_hiloft_mode = _switch_counter()
local attack_straight_mode = _switch_counter()
local attack_general_mode = _switch_counter()

target_status = {
    {master_arm_switch , SWITCH_OFF, get_param_handle("PTN_521"), "PTN_521"},
    {pylon1_select_switch, SWITCH_OFF, get_param_handle("PTN_516"), "PTN_516"},
    {pylon2_select_switch, SWITCH_OFF, get_param_handle("PTN_517"), "PTN_517"},
    {pylon3_select_switch, SWITCH_OFF, get_param_handle("PTN_518"), "PTN_518"},
    {pylon4_select_switch, SWITCH_OFF, get_param_handle("PTN_519"), "PTN_519"},
    {pylon5_select_switch, SWITCH_OFF, get_param_handle("PTN_520"), "PTN_520"},
    {attack_interval_A, SWITCH_OFF, get_param_handle("PTN_550"), "PTN_550"},
    {attack_interval_B, SWITCH_OFF, get_param_handle("PTN_551"), "PTN_551"},
    {attack_interval_C, SWITCH_OFF, get_param_handle("PTN_552"), "PTN_552"},
    {attack_quantity_B, SWITCH_OFF, get_param_handle("PTN_553"), "PTN_553"},
    {attack_quantity_C, SWITCH_OFF, get_param_handle("PTN_554"), "PTN_554"},
    {attack_time_A, SWITCH_OFF, get_param_handle("PTN_555"), "PTN_555"},
    {attack_time_B, SWITCH_OFF, get_param_handle("PTN_556"), "PTN_556"},
    {attack_time_C, SWITCH_OFF, get_param_handle("PTN_557"), "PTN_557"},
    {release_step, SWITCH_OFF, get_param_handle("PTN_538"), "PTN_538"},
    {release_bomb_train, SWITCH_OFF, get_param_handle("PTN_537"), "PTN_537"},
    {release_bomb_salvo, SWITCH_OFF, get_param_handle("PTN_536"), "PTN_536"},
    {release_rocket_train, SWITCH_OFF, get_param_handle("PTN_535"), "PTN_535"},
    {release_rocket_salvo, SWITCH_OFF, get_param_handle("PTN_534"), "PTN_534"},
    {release_missiles, SWITCH_OFF, get_param_handle("PTN_533"), "PTN_533"},
    {release_guns, SWITCH_OFF, get_param_handle("PTN_532"), "PTN_532"},
    {release_sel_jet, SWITCH_OFF, get_param_handle("PTN_531"), "PTN_531"},
    {attack_gcb_mode, SWITCH_OFF, get_param_handle("PTN_539"), "PTN_539"},
    {attack_delay_mode, SWITCH_OFF, get_param_handle("PTN_540"), "PTN_540"},
    {attack_labtgt_mode, SWITCH_OFF, get_param_handle("PTN_541"), "PTN_541"},
    {attack_labip_mode, SWITCH_OFF, get_param_handle("PTN_542"), "PTN_542"},
    {attack_rocket_mode, SWITCH_OFF, get_param_handle("PTN_543"), "PTN_543"},
    {attack_hiloft_mode, SWITCH_OFF, get_param_handle("PTN_544"), "PTN_544"},
    {attack_straight_mode, SWITCH_OFF, get_param_handle("PTN_545"), "PTN_545"},
    {attack_general_mode, SWITCH_OFF, get_param_handle("PTN_546"), "PTN_546"},
}

current_status = {
    {master_arm_switch , SWITCH_OFF, SWITCH_OFF},
    {pylon1_select_switch, SWITCH_OFF, SWITCH_OFF},
    {pylon2_select_switch, SWITCH_OFF, SWITCH_OFF},
    {pylon3_select_switch, SWITCH_OFF, SWITCH_OFF},
    {pylon4_select_switch, SWITCH_OFF, SWITCH_OFF},
    {pylon5_select_switch, SWITCH_OFF, SWITCH_OFF},
    {attack_interval_A, SWITCH_OFF, },
    {attack_interval_B, SWITCH_OFF, },
    {attack_interval_C, SWITCH_OFF, },
    {attack_quantity_B, SWITCH_OFF, },
    {attack_quantity_C, SWITCH_OFF, },
    {attack_time_A, SWITCH_OFF, },
    {attack_time_B, SWITCH_OFF, },
    {attack_time_C, SWITCH_OFF, },
    {release_step, SWITCH_OFF, },
    {release_bomb_train, SWITCH_OFF,},
    {release_bomb_salvo, SWITCH_OFF, },
    {release_rocket_train, SWITCH_OFF, },
    {release_rocket_salvo, SWITCH_OFF, },
    {release_missiles, SWITCH_OFF, },
    {release_guns, SWITCH_OFF, },
    {release_sel_jet, SWITCH_OFF, },
    {attack_gcb_mode, SWITCH_OFF, },
    {attack_delay_mode, SWITCH_OFF, },
    {attack_labtgt_mode, SWITCH_OFF, },
    {attack_labip_mode, SWITCH_OFF, },
    {attack_rocket_mode, SWITCH_OFF, },
    {attack_hiloft_mode, SWITCH_OFF, },
    {attack_straight_mode, SWITCH_OFF, },
    {attack_general_mode, SWITCH_OFF, },
}

local PYLON_INFO_LIST = {}

local pylon_is_tank = {
    get_param_handle("pylon_rout"),
    get_param_handle("pylon_rin"),
    get_param_handle("pylon_ctr"),
    get_param_handle("pylon_lin"),
    get_param_handle("pylon_lout"),
}

function check_externel_tank_status()
    local pylonSelection
    for pylonSelection = 0, 4, 1 do
        local station = WeaponSystem:get_station_info(pylonSelection)
        if (station.CLSID == "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}") then
            pylon_is_tank[pylonSelection + 1]:set(1)
        end
    end
    if RESELECT_LIGHT_STATUS == 1 then
        RESELECT_LIGHT:set(1)
    else
        RESELECT_LIGHT:set(0)
    end
    if COMPLETE_LIGHT_STATUS == 1 then
        COMPLETE_LIGHT:set(1)
    else
        COMPLETE_LIGHT:set(0)
    end
end

function update_display_light()
    for k, v in pairs(SELECTED_LIST) do
        SELECTED_LIST[k][3]:set(SELECTED_LIST[k][1])
    end
end
----end of transfer pylon tank status

function update_Pylon_list()
    local pylonSelection
    for pylonSelection = 0, 4, 1 do
        local station_data = WeaponSystem:get_station_info(pylonSelection)
        PYLON_INFO_LIST[pylonSelection + 1] = {station_data.weapon.level2, station_data.weapon.level3, station_data.count}
    end
end

function post_initialize()
    update_Pylon_list()
    check_externel_tank_status()
end


function getPylonInfo()

end

function SetCommand(command,value)
    if (command == Keys.WeaponLaunch) then
        MANUAL_RELEASE_SIGNAL = 1
    elseif (command == Keys.WeaponLaunchOff) then
        MANUAL_RELEASE_SIGNAL = 0
        STEP_SIGNAL = 0
    elseif (command == Keys.MasterArmamentUP) then
        if target_status[master_arm_switch][2] < 0.5 then
            target_status[master_arm_switch][2] = target_status[master_arm_switch][2] + 1
        end
    elseif (command == Keys.MasterArmamentDOWN) then
        if target_status[master_arm_switch][2] > -0.5 then
            target_status[master_arm_switch][2] = target_status[master_arm_switch][2] - 1
        end
    -- pylon selection
    elseif (command == Keys.Pylon1SelUP) then
        if target_status[pylon1_select_switch][2] < 0.5 then
            target_status[pylon1_select_switch][2] = target_status[pylon1_select_switch][2] + 1
        end
    elseif (command == Keys.Pylon1SelDOWN) then
        if target_status[pylon1_select_switch][2] > -0.5 then
            target_status[pylon1_select_switch][2] = target_status[pylon1_select_switch][2] - 1
        end
        --2
    elseif (command == Keys.Pylon2SelUP) then
        if target_status[pylon2_select_switch][2] < 0.5 then
            target_status[pylon2_select_switch][2] = target_status[pylon2_select_switch][2] + 1
        end
    elseif (command == Keys.Pylon2SelDOWN) then
        if target_status[pylon2_select_switch][2] > -0.5 then
            target_status[pylon2_select_switch][2] = target_status[pylon2_select_switch][2] - 1
        end
        -- 3
    elseif (command == Keys.Pylon3SelUP) then
        if target_status[pylon3_select_switch][2] < 0.5 then
            target_status[pylon3_select_switch][2] = target_status[pylon3_select_switch][2] + 1
        end
    elseif (command == Keys.Pylon3SelDOWN) then
        if target_status[pylon3_select_switch][2] > -0.5 then
            target_status[pylon3_select_switch][2] = target_status[pylon3_select_switch][2] - 1
        end
        -- 4 
    elseif (command == Keys.Pylon4SelUP) then
        if target_status[pylon4_select_switch][2] < 0.5 then
            target_status[pylon4_select_switch][2] = target_status[pylon4_select_switch][2] + 1
        end
    elseif (command == Keys.Pylon4SelDOWN) then
        if target_status[pylon4_select_switch][2] > -0.5 then
            target_status[pylon4_select_switch][2] = target_status[pylon4_select_switch][2] - 1
        end
        -- 5
    elseif (command == Keys.Pylon5SelUP) then
        if target_status[pylon5_select_switch][2] < 0.5 then
            target_status[pylon5_select_switch][2] = target_status[pylon5_select_switch][2] + 1
        end
    elseif (command == Keys.Pylon5SelDOWN) then
        if target_status[pylon5_select_switch][2] > -0.5 then
            target_status[pylon5_select_switch][2] = target_status[pylon5_select_switch][2] - 1
        end
    -- tumb wheel
    elseif command == Keys.IntervalTumbWheel100 then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_interval_A][2] <= 1 and target_status[attack_interval_A][2] >= 0 then
            target_status[attack_interval_A][2] = target_status[attack_interval_A][2] + new_value
        elseif target_status[attack_interval_A][2] < 0 then
            target_status[attack_interval_A][2] = 0
        elseif target_status[attack_interval_A][2] > 1 then
            target_status[attack_interval_A][2] = 1
        end
    elseif command == Keys.IntervalTumbWheel10 then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_interval_B][2] <= 1 and target_status[attack_interval_B][2] >= 0 then
            target_status[attack_interval_B][2] = target_status[attack_interval_B][2] + new_value
        elseif target_status[attack_interval_B][2] < 0 then
            target_status[attack_interval_B][2] = 0
        elseif target_status[attack_interval_B][2] > 1 then
            target_status[attack_interval_B][2] = 1
        end
    elseif command == Keys.IntervalTumbWheel then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_interval_C][2] <= 1 and target_status[attack_interval_C][2] >= 0 then
            target_status[attack_interval_C][2] = target_status[attack_interval_C][2] + new_value
        elseif target_status[attack_interval_C][2] < 0 then
            target_status[attack_interval_C][2] = 1
        elseif target_status[attack_interval_C][2] > 1 then
            target_status[attack_interval_C][2] = 0
        end
    elseif command == Keys.QuantityTumbWheel10 then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_quantity_B][2] <= 1 and target_status[attack_quantity_B][2] >= 0 then
            target_status[attack_quantity_B][2] = target_status[attack_quantity_B][2] + new_value
        elseif target_status[attack_quantity_B][2] < 0 then
            target_status[attack_quantity_B][2] = 1
        elseif target_status[attack_quantity_B][2] > 1 then
            target_status[attack_quantity_B][2] = 0
        end
    elseif command == Keys.QuantityTumbWheel then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_quantity_C][2] <= 1 and target_status[attack_quantity_C][2] >= 0 then
            target_status[attack_quantity_C][2] = target_status[attack_quantity_C][2] + new_value
        elseif target_status[attack_quantity_C][2] < 0 then
            target_status[attack_quantity_C][2] = 1
        elseif target_status[attack_quantity_C][2] > 1 then
            target_status[attack_quantity_C][2] = 0
        end
    elseif command == Keys.TimeTumbWheel100 then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_time_A][2] <= 1 and target_status[attack_time_A][2] >= 0 then
            target_status[attack_time_A][2] = target_status[attack_time_A][2] + new_value
        elseif target_status[attack_time_A][2] < 0 then
            target_status[attack_time_A][2] = 1
        elseif target_status[attack_time_A][2] > 1 then
            target_status[attack_time_A][2] = 0
        end
    elseif command == Keys.TimeTumbWheel10 then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_time_B][2] <= 1 and target_status[attack_time_B][2] >= 0 then
            target_status[attack_time_B][2] = target_status[attack_time_B][2] + new_value
        elseif target_status[attack_time_B][2] < 0 then
            target_status[attack_time_B][2] = 1
        elseif target_status[attack_time_B][2] > 1 then
            target_status[attack_time_B][2] = 0
        end
    elseif command == Keys.TimeTumbWheel then
        if value < 0.5 then
            new_value = - 0.1
        else
            new_value = 0.1
        end
        if target_status[attack_time_C][2] <= 1 and target_status[attack_time_C][2] >= 0 then
            target_status[attack_time_C][2] = target_status[attack_time_C][2] + new_value
        elseif target_status[attack_time_C][2] < 0 then
            target_status[attack_time_C][2] = 1
        elseif target_status[attack_time_C][2] > 1 then
            target_status[attack_time_C][2] = 0
        end
    elseif command == Keys.ReleaseStep then
        if target_status[release_step][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_step
            LAUNCH_MODE = 0
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
        end
        IS_TRAINING = 0
    elseif command == Keys.ReleaseJettison then
        if target_status[release_sel_jet][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_sel_jet
            LAUNCH_MODE = 5
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
        end
        IS_TRAINING = 0
    elseif command == Keys.ReleaseGun then
        if target_status[release_guns][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_guns
            LAUNCH_MODE = 3
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
        end
        IS_TRAINING = 0
    elseif command == Keys.ReleaseMissile then
        if target_status[release_missiles][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_missiles
            LAUNCH_MODE = 4
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
        end
        IS_TRAINING = 0
    elseif command == Keys.ReleaseBombSalve then
        if target_status[release_bomb_salvo][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_bomb_salvo
            LAUNCH_MODE = 1
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
        end
        IS_TRAINING = 0
    elseif command == Keys.ReleaseBombTrain then
        if target_status[release_bomb_train][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_bomb_train
            LAUNCH_MODE = 1
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
            IS_TRAINING = 1
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
            IS_TRAINING = 0
        end
    elseif command == Keys.ReleaseRocketSalve then
        if target_status[release_rocket_salvo][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_rocket_salvo
            LAUNCH_MODE = 2
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
        end
        IS_TRAINING = 0
    elseif command == Keys.ReleaseRocketTrain then
        if target_status[release_rocket_train][2] == SWITCH_OFF then
            if LAST_LAUNCH_BUTTON ~= -1 then
                target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            end
            LAST_LAUNCH_BUTTON = release_rocket_train
            LAUNCH_MODE = 1
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_ON
            IS_TRAINING = 1
        else
            target_status[LAST_LAUNCH_BUTTON][2] = SWITCH_OFF
            LAST_LAUNCH_BUTTON = -1
            LAUNCH_MODE = -1
            IS_TRAINING = 0
        end
    end

    if target_status[master_arm_switch][2] == SWITCH_OFF then
        --reset all warning
        RESELECT_LIGHT_STATUS = 0
        COMPLETE_LIGHT_STATUS = 0
        local SELECTED_LIST = {
            -- {is_launch, pylon launch number, select_light}
            {0, 0, get_param_handle("PTN_501")},
            {0, 0, get_param_handle("PTN_502")},
            {0, 0, get_param_handle("PTN_503")},
            {0, 0, get_param_handle("PTN_504")},
            {0, 0, get_param_handle("PTN_505")},
        }        
    end
end

function update_ir_missile_seeker()
        -- 刷新IR导弹状态
    if (ir_missile_lock_param:get() == 1) then
    elseif (ir_missile_lock_param:get() == 0) then
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

function get_tumb_wheel_set()
    INTERVAL_SET = target_status[attack_interval_A][2] * 1000 + target_status[attack_interval_B][2] * 100 + target_status[attack_interval_C][2] * 10
    TIME_SET = target_status[attack_time_A][2] * 1000 + target_status[attack_time_B][2] * 100 + target_status[attack_time_C][2] * 10
    QUANTITY_SET = target_status[attack_quantity_B][2] * 100 + target_status[attack_quantity_C][2] * 10
end

function update_launch_selection()
    local selected_station_num = 0
    local max_bomb_num_on_one_pylon = 500
    local reselect_signal = 0
    local same_type_selected = 1
    local last_kind_weapon = -1
    if target_status[master_arm_switch][2] ~= SWITCH_OFF then
        for i = 2, 6, 1 do
            if target_status[i][2] ~= SWITCH_OFF then
                SELECTED_LIST[i - 1][1] = 1
                selected_station_num = selected_station_num + 1
                -- print_message_to_user(PYLON_INFO_LIST[i-1][3])
                if max_bomb_num_on_one_pylon > PYLON_INFO_LIST[i-1][3] then
                    max_bomb_num_on_one_pylon = PYLON_INFO_LIST[i-1][3]
                end
                if (PYLON_INFO_LIST[i-1][1] ~= wsType_Missile and PYLON_INFO_LIST[i-1][2] ~= wsType_Rocket) and target_status[i][2] == SWITCH_TEST then
                    reselect_signal = 1
                end
                if last_kind_weapon ~= PYLON_INFO_LIST[i-1][1] and last_kind_weapon ~= -1 then
                    same_type_selected = 0
                end
                last_kind_weapon = PYLON_INFO_LIST[i-1][1];
                if LAUNCH_MODE ~= 5 then
                    if target_status[i][2] == SWITCH_ON and (PYLON_INFO_LIST[i-1][1] ~= wsType_Shell and PYLON_INFO_LIST[i-1][1] ~= wsType_Bomb) then
                        reselect_signal = 1                        
                    end
                end
                -- check if is gun and missile for gun and missile mode
                if LAUNCH_MODE == 3 then
                    -- print_message_to_user(PYLON_INFO_LIST[i-1][1].."XX"..PYLON_INFO_LIST[i-1][2])
                    if PYLON_INFO_LIST[i-1][1] ~= wsType_Shell then
                        reselect_signal = 1
                    end
                elseif LAUNCH_MODE == 4 then
                    if PYLON_INFO_LIST[i-1][1] ~= wsType_Missile or target_status[i][2] == SWITCH_ON then
                        reselect_signal = 1
                    end
                end
            else
                SELECTED_LIST[i - 1][1] = 0
            end
        end
        -- get max available for one launch
        TOTAL_LAUNCH_NUM = max_bomb_num_on_one_pylon * selected_station_num
        if TOTAL_LAUNCH_NUM > QUANTITY_SET then
            local temp_num = math.fmod(QUANTITY_SET, selected_station_num)
            TOTAL_LAUNCH_NUM = QUANTITY_SET - temp_num
        end
        if TOTAL_LAUNCH_NUM < 0 then
            TOTAL_LAUNCH_NUM = 0
            reselect_signal = 1
        else
            for i = 1, 4, 1 do
                if SELECTED_LIST[i][1] == 1 then
                    SELECTED_LIST[i][2] = TOTAL_LAUNCH_NUM / selected_station_num
                end
            end
        end
        if same_type_selected == 0 and LAUNCH_MODE ~= 5 then
            reselect_signal = 1
        end
        -- if reselect_signal is triggered then reset list
        if reselect_signal == 1 then
            RESELECT_LIGHT_STATUS = 1
            SELECTED_LIST = {
                -- {is_launch, pylon launch number, select_light}
                {0, 0, get_param_handle("PTN_501")},
                {0, 0, get_param_handle("PTN_502")},
                {0, 0, get_param_handle("PTN_503")},
                {0, 0, get_param_handle("PTN_504")},
                {0, 0, get_param_handle("PTN_505")},
            }
        else
            RESELECT_LIGHT_STATUS = 0
        end
    end
end

function step_mode_manual_launch()
    if STEP_SIGNAL == 0 and MANUAL_RELEASE_SIGNAL == 1 then
        for i = 1, 5, 1 do
            if SELECTED_LIST[i][1] == 1 and PYLON_INFO_LIST[i][1] ~= wsType_Shell and PYLON_INFO_LIST[i][1] ~= wsType_Missile then
                WeaponSystem:launch_station(i-1)
            end
        end
        STEP_SIGNAL = 1
    end
end

function seletion_jettsion()
    if STEP_SIGNAL == 0 and MANUAL_RELEASE_SIGNAL == 1 then
        for i = 1, 5, 1 do
            if SELECTED_LIST[i][1] == 1 then
                WeaponSystem:emergency_jettison(i-1)
            end
        end
        STEP_SIGNAL = 1
    end
end

function gun_mode_firing()
    if MANUAL_RELEASE_SIGNAL == 1 then
        if STEP_SIGNAL == 0 then
            for i = 1, 5, 1 do
                if SELECTED_LIST[i][1] == 1 then
                    WeaponSystem:launch_station(i-1) -- this mode will always fire at blust max length
                end
            end
            STEP_SIGNAL = 1
        elseif STEP_SIGNAL <= 5 then
            STEP_SIGNAL = STEP_SIGNAL + 1
        elseif STEP_SIGNAL > 5 then
            STEP_SIGNAL = 0
        end
    end
end

function update()
    -- WeaponSystem:emergency_jettison(i-1)
    -- WeaponSystem:launch_station(pylonSelected - 1)
    update_Pylon_list()
    update_switch_status()
    check_externel_tank_status()
    get_tumb_wheel_set()
    if DataFreeze == 0 then
        update_launch_selection()
    end
    update_display_light()
    if ATTACK_MODE == -1 then
        if LAUNCH_MODE == 0 then
            step_mode_manual_launch()
        elseif LAUNCH_MODE == 5 then
            seletion_jettsion()
        elseif LAUNCH_MODE == 3 then
            gun_mode_firing()
        end
    end
end

need_to_be_closed = false

--[[
    GetDevice(devices.WEAPON_SYSTEM) metatable:
    weapons meta["__index"] = {}
    weapons meta["__index"]["get_station_info"] = function: 00000000CCCC5780
    weapons meta["__index"]["listen_event"] = function: 00000000CCC8E000
    weapons meta["__index"]["drop_flare"] = function: 000000003C14E208
    weapons meta["__index"]["set_ECM_status"] = function: 00000000CCCC76E0
    weapons meta["__index"]["performClickableAction"] = function: 00000000CCE957B0
    weapons meta["__index"]["get_ECM_status"] = function: 00000000CCE37BC0
    weapons meta["__index"]["launch_station"] = function: 00000000CCC36A30
    weapons meta["__index"]["SetCommand"] = function: 00000000CCE52820
    weapons meta["__index"]["get_chaff_count"] = function: 00000000CCBDD650
    weapons meta["__index"]["emergency_jettison"] = function: 00000000CCC26810
    weapons meta["__index"]["set_target_range"] = function: 000000003AB0FDD0
    weapons meta["__index"]["set_target_span"] = function: 0000000027E4E970
    weapons meta["__index"]["get_flare_count"] = function: 00000000CCCC57D0
    weapons meta["__index"]["get_target_range"] = function: 00000000CCC26710
    weapons meta["__index"]["get_target_span"] = function: 00000000CCCC7410
    weapons meta["__index"]["SetDamage"] = function: 00000000CCC384B0
    weapons meta["__index"]["drop_chaff"] = function: 00000000CCE37AA0
    weapons meta["__index"]["select_station"] = function: 00000000CC5C26F0
    weapons meta["__index"]["listen_command"] = function: 0000000038088060
    weapons meta["__index"]["emergency_jettison_rack"] = function: 00000000720F15F0
]]