dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

--设置位数保留参数
local fmt = '%.2f'

-- 设置状态和目标实现平滑过度
local slat_pos
local SLATS_STATE = 0
local SLATS_TARGET = 0

--暂时没有监听和初始化(因为是自动的)
local slat_system = GetSelf()

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
end

--读取飞行器当前表速和读取缝翼位置
function getIASKnots()
    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    --print_message_to_user("ISA:")
    --print_message_to_user(ias_knots)
    --print_message_to_user("SLAT_POS:")
    slat_pos = sensor_data.getFlapsPos()
    SLATS_STATE = tonumber(string.format(fmt,slat_pos))
    --print_message_to_user(slat_pos)
end

function SetCommand(command,value)
end

--刷新缝翼位置
function update()
    getIASKnots()
    --根据表速设置缝翼目标
    if (ias_knots < 240 and ias_knots > 160) then
        SLATS_TARGET = 1 - (ias_knots - 160)/80
        SLATS_TARGET = tonumber(string.format(fmt, SLATS_TARGET))
    elseif (ias_knots > 40 and ias_knots <= 160) then
        SLATS_TARGET = 1
    else
        SLATS_TARGET = 0
    end

    --判断缝翼位置与目标偏差，进行动画微调
    if (SLATS_TARGET == SLATS_STATE) then
        --什么都不做，已经在位置上了
    elseif (SLATS_STATE > SLATS_TARGET) then
        --缝翼状态比目标大，线性减
        SLATS_STATE = SLATS_STATE - 0.01
    elseif (SLATS_TARGET > SLATS_STATE) then
        SLATS_STATE = SLATS_STATE + 0.01
    end
end

--该lua初始化后不关闭
need_to_be_closed = false