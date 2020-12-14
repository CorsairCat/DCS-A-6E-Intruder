-- 基础材质初始化
--local DEBUG_COLOR               = {0,255,0,200}
--local WHITE_COLOR               = {255,255,255,200}
--local GREY_COLOR                = {150,150,150,255}
--local FONT_                     = MakeFont({used_DXUnicodeFontData = "font_cockpit_usa"},DEBUG_COLOR,50,"test_font") --创建字体(这个字体似乎只支持英文（虽然是unicode)

local MFD_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/MFD/"  --定义屏幕贴图路径
local public_border_material     = MakeMaterial(MFD_IND_TEX_PATH.."public_page_border.tga", {152,195,100,255})

--
local engine_screen_x_offset = 106 --设置这个来确定中心偏移
local engine_screen_z_offset = 0  --用来设置屏幕效果，显示层与上层流出空间
local engine_screen_y_offset = 5

-- 创建一个基础的虚拟对象来控制基础飞行界面的所有显示内容移动（为后续触屏控制准备）
-- 做个simple作为相对定位的基础
-- WEAPON_SCR_ENABLE 为这个界面的统一是否显示控制表
engine_screen_ctrl                      = CreateElement "ceSimple"
engine_screen_ctrl.name                 = "engine_screen_ctrl"
engine_screen_ctrl.init_pos             = {engine_screen_x_offset, engine_screen_y_offset, engine_screen_z_offset} --为第一个显示区(四分)正中位置
engine_screen_ctrl.element_params       = {"ENGINE_SCR_ENABLE"}
engine_screen_ctrl.controllers          = {{"opacity_using_parameter",0}}
engine_screen_ctrl.collimated	        = true
engine_screen_ctrl.use_mipfilter        = true
engine_screen_ctrl.additive_alpha       = true
engine_screen_ctrl.h_clip_relation      = h_clip_relations.COMPARE
engine_screen_ctrl.level                = MFD_DEFAULT_NOCLIP_LEVEL
engine_screen_ctrl.parent_element	    = "main_screen_clip" --父对象为主屏幕裁剪层
engine_screen_ctrl.isvisible            = false
Add(engine_screen_ctrl)

-- 这个现在显示在第一个裁剪层中,是一个外框
engine_border 				            = CreateElement "ceTexPoly"
engine_border.vertices                  = {{-106,125},{106,125},{106,-143},{-106,-143}}
engine_border.indices                   = {0,1,2,2,3,0}
engine_border.tex_coords                = {{0,0},{1,0},{1,1},{0,1}}
engine_border.material                  = engine_border_material
engine_border.name 			            = create_guid_string()
engine_border.init_pos                  = {0, 0, 0}
engine_border.init_rot		            = {0, 0, 0}
engine_border.collimated	            = true
engine_border.element_params            = {"ENGINE_SCR_ENABLE"} --, "D_GUNSIGHT_VISIBLE"
engine_border.controllers               = {{"opacity_using_parameter",0},}
engine_border.use_mipfilter             = true
engine_border.additive_alpha            = true
engine_border.h_clip_relation           = h_clip_relations.COMPARE
engine_border.level                     = MFD_DEFAULT_NOCLIP_LEVEL
engine_border.parent_element	        = "engine_screen_ctrl"
Add(engine_border)