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

fuel_main_dis = get_param_handle("FUEL_QUAN_IN")
fuel_sel_dis = get_param_handle("FUEL_QUAN_SEL")
fuel_quanW_dis = get_param_handle("FUEL_QUAN_A_x1W")
fuel_quanK_dis = get_param_handle("FUEL_QUAN_A_x1K")
fuel_quan3_dis = get_param_handle("FUEL_QUAN_A_x100")
fuel_quan2_dis = get_param_handle("FUEL_QUAN_A_x10")
fuel_quan1_dis = get_param_handle("FUEL_QUAN_A_x1")


function updateFuelGaugeDisplay()
    local fuel_main = 0
    local fuel_wing = 0
    local fuel_total = 0
    local fuel_externel = 0
    local fuel_gauge_step = 0.1
    if get_elec_primary_ac_ok() then
        fuel_total = sensor_data.getTotalFuelWeight()
    else
        
    end
    fuel_main_dis:set()
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
end

function update()
    update_switch_status()
    updateFuelGaugeDisplay()
end

--不关闭该lua
need_to_be_closed = false