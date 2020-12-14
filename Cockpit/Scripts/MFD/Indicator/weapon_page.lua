-- 基础材质初始化
--local DEBUG_COLOR               = {0,255,0,200}
--local WHITE_COLOR               = {255,255,255,200}
--local GREY_COLOR                = {150,150,150,255}
--local FONT_                     = MakeFont({used_DXUnicodeFontData = "font_cockpit_usa"},DEBUG_COLOR,50,"test_font") --创建字体(这个字体似乎只支持英文（虽然是unicode)

local MFD_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/MFD/"  --定义屏幕贴图路径
local weapon_border_material     = MakeMaterial(MFD_IND_TEX_PATH.."weapon_page_border.tga", {152,195,100,255})

--
local weapon_screen_x_offset = -106 --设置这个来确定中心偏移
local weapon_screen_z_offset = 0  --用来设置屏幕效果，显示层与上层流出空间
local weapon_screen_y_offset = 5

-- 创建一个基础的虚拟对象来控制基础飞行界面的所有显示内容移动（为后续触屏控制准备）
-- 做个simple作为相对定位的基础
-- WEAPON_SCR_ENABLE 为这个界面的统一是否显示控制表
weapon_screen_ctrl                      = CreateElement "ceSimple"
weapon_screen_ctrl.name                 = "weapon_screen_ctrl"
weapon_screen_ctrl.init_pos             = {weapon_screen_x_offset, weapon_screen_y_offset, weapon_screen_z_offset} --为第一个显示区(四分)正中位置
weapon_screen_ctrl.element_params       = {"WEAPON_SCR_ENABLE"}
weapon_screen_ctrl.controllers          = {{"opacity_using_parameter",0}}
weapon_screen_ctrl.collimated	        = true
weapon_screen_ctrl.use_mipfilter        = true
weapon_screen_ctrl.additive_alpha       = true
weapon_screen_ctrl.h_clip_relation      = h_clip_relations.COMPARE
weapon_screen_ctrl.level                = MFD_DEFAULT_NOCLIP_LEVEL
weapon_screen_ctrl.parent_element	    = "main_screen_clip" --父对象为主屏幕裁剪层
weapon_screen_ctrl.isvisible            = false
Add(weapon_screen_ctrl)

-- 这个现在显示在第一个裁剪层中,是一个外框
weapon_border 				            = CreateElement "ceTexPoly"
weapon_border.vertices                  = {{-106,125},{106,125},{106,-143},{-106,-143}}
weapon_border.indices                   = {0,1,2,2,3,0}
weapon_border.tex_coords                = {{0,0},{1,0},{1,1},{0,1}}
weapon_border.material                  = weapon_border_material
weapon_border.name 			            = create_guid_string()
weapon_border.init_pos                  = {0, 0, 0}
weapon_border.init_rot		            = {0, 0, 0}
weapon_border.collimated	            = true
weapon_border.element_params            = {"WEAPON_SCR_ENABLE"} --, "D_GUNSIGHT_VISIBLE"
weapon_border.controllers               = {{"opacity_using_parameter",0},}
weapon_border.use_mipfilter             = true
weapon_border.additive_alpha            = true
weapon_border.h_clip_relation           = h_clip_relations.COMPARE
weapon_border.level                     = MFD_DEFAULT_NOCLIP_LEVEL
weapon_border.parent_element	        = "weapon_screen_ctrl"
Add(weapon_border)

-- 下面是一个输出武器模式, 位于最上层
local weapon_mode_output                = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
weapon_mode_output.name                 = ("weapon_mode_" .. create_guid_string())
weapon_mode_output.material             = "mpcd_font_base" --FONT_             --材质类型（注意上面创建的字体材质）
weapon_mode_output.init_pos             = {-42.5, -29}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
weapon_mode_output.alignment            = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
weapon_mode_output.stringdefs           = {0.75*0.012,0.75*0.75 * 0.012, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
weapon_mode_output.formats              = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
weapon_mode_output.element_params       = {"WEAPON_MODE_DIS", "WEAPON_SCR_ENABLE"} --生成的para控制句柄
weapon_mode_output.controllers          = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
weapon_mode_output.collimated           = true
weapon_mode_output.use_mipfilter        = true
weapon_mode_output.additive_alpha       = true
weapon_mode_output.isvisible		    = true
weapon_mode_output.h_clip_relation 	    = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
weapon_mode_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
weapon_mode_output.parent_element       = "weapon_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(weapon_mode_output)

-- 下面是一个输出武器选中, 位于最上层
local weapon_select_output              = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
weapon_select_output.name               = ("weapon_selected_" .. create_guid_string())
weapon_select_output.material           = "mpcd_font_base" --FONT_             --材质类型（注意上面创建的字体材质）
weapon_select_output.init_pos           = {-42.5, -43}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
weapon_select_output.alignment          = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
weapon_select_output.stringdefs         = {0.75*0.012,0.75*0.75 * 0.012, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
weapon_select_output.formats            = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
weapon_select_output.element_params     = {"WEAPON_SELECT_DIS", "WEAPON_SCR_ENABLE"} --生成的para控制句柄
weapon_select_output.controllers        = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
weapon_select_output.collimated         = true
weapon_select_output.use_mipfilter      = true
weapon_select_output.additive_alpha     = true
weapon_select_output.isvisible		    = true
weapon_select_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
weapon_select_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
weapon_select_output.parent_element     = "weapon_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(weapon_select_output)

-- 下面是一个输出选中武器状态, 位于最上层
local weapon_status_output              = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
weapon_status_output.name               = ("weapon_status_" .. create_guid_string())
weapon_status_output.material           = "mpcd_font_base" --FONT_             --材质类型（注意上面创建的字体材质）
weapon_status_output.init_pos           = {32.5, -29}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
weapon_status_output.alignment          = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
weapon_status_output.stringdefs         = {0.75*0.012,0.75*0.75 * 0.012, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
weapon_status_output.formats            = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
weapon_status_output.element_params     = {"WEAPON_STATUS_DIS", "WEAPON_SCR_ENABLE"} --生成的para控制句柄
weapon_status_output.controllers        = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
weapon_status_output.collimated         = true
weapon_status_output.use_mipfilter      = true
weapon_status_output.additive_alpha     = true
weapon_status_output.isvisible		    = true
weapon_status_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
weapon_status_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
weapon_status_output.parent_element     = "weapon_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(weapon_status_output)

-- 下面是一个输出武器所在舱门, 位于最上层
local weapon_bay_status_output              = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
weapon_bay_status_output.name               = ("weapon_bay_status_" .. create_guid_string())
weapon_bay_status_output.material           = "mpcd_font_base" --FONT_             --材质类型（注意上面创建的字体材质）
weapon_bay_status_output.init_pos           = {32.5, -43}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
weapon_bay_status_output.alignment          = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
weapon_bay_status_output.stringdefs         = {0.75*0.012,0.75*0.75 * 0.012, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
weapon_bay_status_output.formats            = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
weapon_bay_status_output.element_params     = {"WEAPON_BAY_STATUS_DIS", "WEAPON_SCR_ENABLE"} --生成的para控制句柄
weapon_bay_status_output.controllers        = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
weapon_bay_status_output.collimated         = true
weapon_bay_status_output.use_mipfilter      = true
weapon_bay_status_output.additive_alpha     = true
weapon_bay_status_output.isvisible		    = true
weapon_bay_status_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
weapon_bay_status_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
weapon_bay_status_output.parent_element     = "weapon_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(weapon_bay_status_output)