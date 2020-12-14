dofile(LockOn_Options.common_script_path.."elements_defs.lua")

MFCD_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/MFCD/"  --定义屏幕贴图路径

--这个应该是设置弧度单位（？），用来定义屏幕倾斜 1mrad=0.001弧度=0.0573度
-- 设置FOV可以让整个屏幕按虚拟体的框来大小是2 * 2 * aspect()
-- 此处存疑，A4雷达屏幕用的是FOV 
-- 这个似乎是缩放模型
SetScale(FOV)--MILLYRADIANS) --这里设置了毫弧度

-- JF-17的hud在这里定义了hud一半的宽度和高度
--[[
    HUD_HALF_WIDTH  = math.rad(10.0) * 1000
    HUD_HALF_HEIGHT = math.rad(10.0) * 1000
]]

-- 一些预定义角度/弧度换算(均为全局变量)
DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD  = 0.0174532925199433
RAD_TO_DEGREE  = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

-- 全局宽度数据
MFCD_ASPECT_HEIGHT = GetAspect()

-- JF17定义了大量材质的全局描述

-- JF17定义了默认clip层级

--A4定义了两个层级
--数值越小越靠上
MFCD_DEFAULT_LEVEL = 4                              -- 二次裁剪显示层
MFCD_DEFAULT_NOCLIP_LEVEL  = MFCD_DEFAULT_LEVEL - 1 -- 一次裁剪显示层

-- 默认hud单色吧
-- 排错颜色（大雾）
DEBUG_COLOR                 = {0,255,0,200}
-- 白天模式mfcd的颜色
MFCD_WHITE_COLOR               = {255,255,255,255}
MFCD_BLUE_COLOR               = {106,214,208,255}

-- 白色显示
white_MFCD_material = MakeMaterial(MFCD_IND_TEX_PATH.."MFCD_ind_sign.dds", MFCD_WHITE_COLOR)
-- 蓝色显示
blue_MFCD_material = MakeMaterial(MFCD_IND_TEX_PATH.."MFCD_ind_sign.dds", MFCD_BLUE_COLOR)
-- ADI滚动球
ADI_base_material = MakeMaterial(MFCD_IND_TEX_PATH.."basic_ADI_background.tga", MFCD_WHITE_COLOR)

-- 定义hud默认长宽
default_mfcd_x = 6000
default_mfcd_y = 6000

function mfcd_vert_gen(width, height)
    return {{(0 - width) / 2 / default_mfcd_x , (0 + height) / 2 / default_mfcd_y},
    {(0 + width) / 2 / default_mfcd_x , (0 + height) / 2 / default_mfcd_y},
    {(0 + width) / 2 / default_mfcd_x , (0 - height) / 2 / default_mfcd_y},
    {(0 - width) / 2 / default_mfcd_x , (0 - height) / 2 / default_mfcd_y},}
end

function mfcd_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_mfcd_x , (0 + total_height) / 2 / default_mfcd_y},
        {(0 + width) / 2 / default_mfcd_x , (0 + total_height) / 2 / default_mfcd_y},
        {(0 + width) / 2 / default_mfcd_x , (0 + not_include_height) / 2 / default_mfcd_y},
        {(0 - width) / 2 / default_mfcd_x , (0 + not_include_height) / 2 / default_mfcd_y},
        {(0 + width) / 2 / default_mfcd_x , (0 - not_include_height) / 2 / default_mfcd_y},
        {(0 - width) / 2 / default_mfcd_x , (0 - not_include_height) / 2 / default_mfcd_y},
        {(0 + width) / 2 / default_mfcd_x , (0 - total_height) / 2 / default_mfcd_y},
        {(0 - width) / 2 / default_mfcd_x , (0 - total_height) / 2 / default_mfcd_y},
    }
end

-- 自动算贴图位置
function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end

-- 反向贴图生成
function mirror_tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{(x_dis + width) / size_X , y_dis / size_Y},
			{x_dis / size_X , y_dis / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},}
end

-- 计算圆形裁剪
function calculateCircle(object, radius, init_x, init_y, point_num)
	local verts = {}
    multiplier = math.rad(360.0/point_num)
    verts[1] = {init_x / default_mfcd_x, init_y / default_mfcd_y}
	for i = 2, point_num do
	  verts[i] = {(init_x + radius * math.cos(i * multiplier)) / default_mfcd_x, (init_y + radius * math.sin(i * multiplier)) / default_mfcd_y}
    end
    -- 从圆心到每两个相邻节点
    local indices = {}
	for i = 0, point_num - 3 do
	  indices[i * 3 + 1] = 0
	  indices[i * 3 + 2] = i + 1
	  indices[i * 3 + 3] = i + 2
    end
    indices[(point_num - 2) * 3 + 1] = 0
    indices[(point_num - 2) * 3 + 2] = 1
    indices[(point_num - 2) * 3 + 3] = point_num - 1
	object.vertices = verts
	object.indices  = indices
end