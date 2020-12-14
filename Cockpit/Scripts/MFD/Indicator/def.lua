-- 加载默认的lua文件，可能是某些函数
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

--这个应该是设置弧度单位（？），用来定义屏幕倾斜 1mrad=0.001弧度=0.0573度
-- 此处存疑，A4雷达屏幕用的是FOV
-- 这个似乎是缩放模型
SetScale(MILLYRADIANS) --这里设置了毫弧度

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

-- JF17定义了大量材质的全局描述

-- JF17定义了默认clip层级

--A4定义了两个层级
--数值越小越靠上
MFD_DEFAULT_LEVEL = 4                              -- 二次裁剪显示层
MFD_DEFAULT_NOCLIP_LEVEL  = MFD_DEFAULT_LEVEL - 1 -- 一次裁剪显示层

--A4的定义函数,定义增加一个元素(JF-17的很相似，应该是必须的)
-- level应该是一个显示层级函数（哪个在上不确定)
-- 这个函数暂时不使用
function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= MFD_DEFAULT_LEVEL
    Add(object)
end

--这俩个参数出现在A4的定义中，目前判断是无效数据
--z_offset = 0
--blob_scale=0.08