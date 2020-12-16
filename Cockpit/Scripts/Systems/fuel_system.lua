local FuelSystem = GetSelf()

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

local main_tank_dis = _switch_counter()
local wing_tank_dis = _switch_counter()
local ctr_tank_dis = _switch_counter()
local lout_tank_dis = _switch_counter()
local lin_tank_dis = _switch_counter()
local rin_tank_dis = _switch_counter()
local rout_tank_dis = _switch_counter()

target_status = {
    {main_tank_dis , SWITCH_OFF, get_param_handle("PTN_101"), "PTN_101"},
    {wing_tank_dis , SWITCH_ON, get_param_handle("PTN_102"), "PTN_102"},
    {ctr_tank_dis , SWITCH_OFF, get_param_handle("PTN_103"), "PTN_103"},
    {lout_tank_dis , SWITCH_OFF, get_param_handle("PTN_104"), "PTN_104"},
    {lin_tank_dis , SWITCH_OFF, get_param_handle("PTN_105"), "PTN_105"},
    {rin_tank_dis , SWITCH_OFF, get_param_handle("PTN_106"), "PTN_106"},
    {rout_tank_dis , SWITCH_OFF, get_param_handle("PTN_107"), "PTN_107"},
}

current_status = {
    {main_tank_dis , SWITCH_OFF, SWITCH_OFF},
    {wing_tank_dis , SWITCH_ON, SWITCH_OFF},
    {ctr_tank_dis , SWITCH_OFF, SWITCH_OFF},
    {lout_tank_dis , SWITCH_OFF, SWITCH_OFF},
    {lin_tank_dis , SWITCH_OFF, SWITCH_OFF},
    {rin_tank_dis , SWITCH_OFF, SWITCH_OFF},
    {rout_tank_dis , SWITCH_OFF, SWITCH_OFF},
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

FuelSystem:listen_command(Keys.FuelDisMain)
FuelSystem:listen_command(Keys.FuelDisWing)
FuelSystem:listen_command(Keys.FuelDisCtr)
FuelSystem:listen_command(Keys.FuelDisLin)
FuelSystem:listen_command(Keys.FuelDisLout)
FuelSystem:listen_command(Keys.FuelDisRin)
FuelSystem:listen_command(Keys.FuelDisRout)

FuelSystem:listen_event("WeaponRearmComplete")

-----Switch default position update control off

function post_initialize()
    for k,v in pairs(target_status) do
        target_status[k][3]:set(current_status[k][2])
    end
end

DISPLAY_TANK = wing_tank_dis

function setDisplayStatus(new_selection)
    target_status[DISPLAY_TANK][2] = SWITCH_OFF
    local temp_switch_ref = get_clickable_element_reference(target_status[DISPLAY_TANK][4])
    temp_switch_ref:hide(false)
    target_status[new_selection][2] = SWITCH_ON
    DISPLAY_TANK = new_selection
    temp_switch_ref = get_clickable_element_reference(target_status[DISPLAY_TANK][4])
    temp_switch_ref:hide(true)
end

fuel_main_ind = get_param_handle("FUEL_QUAN_IN")
fuel_sel_ind = get_param_handle("FUEL_QUAN_SEL")
fuel_quanW_dis = get_param_handle("FUEL_QUAN_A_5")
fuel_quanK_dis = get_param_handle("FUEL_QUAN_A_4")
fuel_quan3_dis = get_param_handle("FUEL_QUAN_A_3")
fuel_quan2_dis = get_param_handle("FUEL_QUAN_A_2")
fuel_quan1_dis = get_param_handle("FUEL_QUAN_A_1")

fuel_ind_is_startup = 1

local pylon_is_tank = {
    {get_param_handle("pylon_ctr"), 0},
    {get_param_handle("pylon_lout"), 0},
    {get_param_handle("pylon_lin"), 0},
    {get_param_handle("pylon_rin"), 0},
    {get_param_handle("pylon_rout"), 0},
}

local fuel_in_tank = {
    {main_tank_dis , 0, 9016},
    {wing_tank_dis , 0, 6923},
    {ctr_tank_dis , 0, 2040},
    {lout_tank_dis , 0, 2040},
    {lin_tank_dis , 0, 2040},
    {rin_tank_dis , 0, 2040},
    {rout_tank_dis , 0, 2040},
}

fuel_drop_tank_init = 1
EXTERNEL_FUEL = 0
INNER_FUEL = 0
EXTERNEL_TANK_AMOUNT = 0
LAST_TOTAL_FUEL = 0

function CockpitEvent(event,val)
    -- set all externel power together
    if event == "WeaponRearmComplete" then
        print_message_to_user("ReCalculate Fuel")
        fuel_drop_tank_init = 1
    end
end

function update_current_fuel_in_tank()
    local fuel_total = sensor_data.getTotalFuelWeight() * 2.205
    local dFuel = 0
    if fuel_drop_tank_init == 1 then
        for i = 1, 5, 1 do
            if pylon_is_tank[i][1]:get() == 1 then
                fuel_in_tank[i+2][2] = 2040 -- assign full fuel into tank JP-5 6.8 lbs/gal
                EXTERNEL_FUEL = EXTERNEL_FUEL + 2040
                pylon_is_tank[i][2] = 1
                EXTERNEL_TANK_AMOUNT = EXTERNEL_TANK_AMOUNT + 1
            else
                fuel_in_tank[i+2][2] = 0 -- assign full fuel into tank JP-5 6.8 lbs/gal
                pylon_is_tank[i][2] = 0
            end
        end
        fuel_drop_tank_init = 0
    else
        if EXTERNEL_FUEL > 0 then
            dFuel =  LAST_TOTAL_FUEL - fuel_total
            if dFuel < EXTERNEL_FUEL and dFuel >= 0 then
                EXTERNEL_FUEL = EXTERNEL_FUEL - dFuel
            else
                EXTERNEL_FUEL = 0
            end
        end
        for i = 1, 5, 1 do
            -- test if is jettsion fuel tanks
            if pylon_is_tank[i][1]:get() == 0 and pylon_is_tank[i][2] == 1 then
                EXTERNEL_TANK_AMOUNT = EXTERNEL_TANK_AMOUNT - 1
                fuel_in_tank[i + 2][2] = 0
            end
        end
        for i = 1, 5, 1 do
            -- calculate fuel in each fuel tank
            if pylon_is_tank[i][1]:get() == 1 and pylon_is_tank[i][2] == 1 then
                fuel_in_tank[i + 2][2] = EXTERNEL_FUEL / EXTERNEL_TANK_AMOUNT
            end
        end
    end

    LAST_TOTAL_FUEL = fuel_total
    INNER_FUEL = fuel_total - EXTERNEL_FUEL
    -- print_message_to_user(EXTERNEL_FUEL)
    -- inner: mian 9016, wing 6923, 15939 in total
    fuel_in_tank[main_tank_dis][2] = INNER_FUEL * 9016 / 15939
    fuel_in_tank[wing_tank_dis][2] = INNER_FUEL * 6923 / 15939
end

FUEL_G_COUNTER = 0

fuel_quanw_num_c = 0
fuel_quank_num_c = 0
fuel_quan3_num_c = 0
fuel_quan2_num_c = 0
fuel_quan1_num_c = 0

function updateFuelGaugeDisplay()
    local fuel_main = 0
    local fuel_sel = 0
    local fuel_total = 0
    local fuel_externel = 0
    local fuel_gauge_step = 0.1
    if get_elec_primary_ac_ok() then
        fuel_total = sensor_data.getTotalFuelWeight() * 2.205 -- kg to lbs
        if fuel_ind_is_startup == 1 then
            FUEL_G_COUNTER = FUEL_G_COUNTER + 1
        end
        fuel_main = fuel_in_tank[main_tank_dis][2] / fuel_in_tank[main_tank_dis][3]
        fuel_sel = fuel_in_tank[DISPLAY_TANK][2] / fuel_in_tank[DISPLAY_TANK][3]
    else
        FUEL_G_COUNTER = 0
        fuel_ind_is_startup = 1
    end

    if FUEL_G_COUNTER >= 20 then
        fuel_ind_is_startup = 0
        FUEL_G_COUNTER = 0
    end

    -- display total fuel

    local fuel_quanw_num = math.modf(fuel_total/10000) / 10
    fuel_total = math.fmod(fuel_total, 10000)
    local fuel_quank_num = math.modf(fuel_total/1000) / 10
    fuel_total = math.fmod(fuel_total, 1000)
    local fuel_quan3_num = math.modf(fuel_total/100) / 10
    fuel_total = math.fmod(fuel_total, 100)
    local fuel_quan2_num = math.modf(fuel_total/10) / 10
    fuel_total = math.fmod(fuel_total, 10)
    local fuel_quan1_num = fuel_total / 10

    fuel_quan1_dis:set(fuel_quan1_num)

    if fuel_quanw_num_c < fuel_quanw_num then
        fuel_quanw_num_c = fuel_quanw_num_c + 0.002
        fuel_quanW_dis:set(fuel_quanw_num)
    elseif fuel_quanw_num_c > fuel_quanw_num then
        fuel_quanw_num_c = fuel_quanw_num_c - 0.002
        fuel_quanW_dis:set(fuel_quanw_num)
    end

    if fuel_quank_num_c < fuel_quank_num then
        fuel_quank_num_c = fuel_quank_num_c + 0.002
        fuel_quanK_dis:set(fuel_quank_num_c)
    elseif fuel_quank_num_c > fuel_quank_num then
        fuel_quank_num_c = fuel_quank_num_c - 0.002
        fuel_quanK_dis:set(fuel_quank_num_c)
    end

    if fuel_quan3_num_c < fuel_quan3_num then
        fuel_quan3_num_c = fuel_quan3_num_c + 0.002
        fuel_quan3_dis:set(fuel_quan3_num_c)
    elseif fuel_quan3_num_c > fuel_quan3_num then
        fuel_quan3_num_c = fuel_quan3_num_c - 0.002
        fuel_quan3_dis:set(fuel_quan3_num_c)
    end

    if fuel_quan2_num_c < fuel_quan2_num then
        fuel_quan2_num_c = fuel_quan2_num_c + 0.002
        fuel_quan2_dis:set(fuel_quan2_num_c)
    elseif fuel_quan2_num_c > fuel_quan2_num then
        fuel_quan2_num_c = fuel_quan2_num_c - 0.002
        fuel_quan2_dis:set(fuel_quan2_num_c)
    end

    fuel_main_ind:set(fuel_main)
    fuel_sel_ind:set(fuel_sel)
end

function SetCommand(command, value)
    if command == Keys.FuelDisMain then
        setDisplayStatus(main_tank_dis)
    elseif command == Keys.FuelDisWing then
        setDisplayStatus(wing_tank_dis)
    elseif command == Keys.FuelDisCtr then
        setDisplayStatus(ctr_tank_dis)
    elseif command == Keys.FuelDisLout then
        setDisplayStatus(lout_tank_dis)
    elseif command == Keys.FuelDisLin then
        setDisplayStatus(lin_tank_dis)
    elseif command == Keys.FuelDisRin then
        setDisplayStatus(rin_tank_dis)
    elseif command == Keys.FuelDisRout then
        setDisplayStatus(rout_tank_dis)
    end
    print_message_to_user(fuel_in_tank[DISPLAY_TANK][2])
end

function update()
    update_switch_status()
    update_current_fuel_in_tank()
    updateFuelGaugeDisplay()
end

--不关闭该lua
need_to_be_closed = false
