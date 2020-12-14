--dofile(LockOn_Options.script_path.."MFD/Indicator/def.lua") --所有页面都包含这个描述文件
-- 因为使用dofile模式，所以def描述已经加载过一次

-- 基础材质初始化
local DEBUG_COLOR               = {0,255,0,200}
local WHITE_COLOR               = {255,255,255,200}
local GREY_COLOR                = {150,150,150,255}
local FONT_                     = MakeFont({used_DXUnicodeFontData = "font_cockpit_usa"},DEBUG_COLOR,50,"test_font") --创建字体(这个字体似乎只支持英文（虽然是unicode)
local BASIC_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/MFD/"  --定义屏幕贴图路径
local basic_border_material     = MakeMaterial(BASIC_IND_TEX_PATH.."basic_page_border.tga", {152,195,100,255})-- "test4.dds" MakeMaterial(IND_TEX_PATH.."test4.dds",DEBUG_COLOR) --IND_TEX_PATH.."test4.dds"Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/M2KC_VTB_Grid_2.tga
local basic_ADI_material        = MakeMaterial(BASIC_IND_TEX_PATH.."basic_ADI_background.tga" , WHITE_COLOR) --ind_test_1.tga,"test4.dds"
local basic_ADI_center_material = MakeMaterial(BASIC_IND_TEX_PATH.."basic_ADI_center_signal.tga",GREY_COLOR)

--
local basic_screen_x_offset = -318 --设置这个来确定中心偏移
local basic_screen_z_offset = 0  --用来设置屏幕效果，显示层与上层流出空间
local basic_screen_y_offset = 5

-- 创建一个基础的虚拟对象来控制基础飞行界面的所有显示内容移动（为后续触屏控制准备）
-- 做个simple作为相对定位的基础
-- BASIC_SCR_ENABLE 为这个界面的统一是否显示控制表
basic_screen_ctrl                   = CreateElement "ceSimple"
basic_screen_ctrl.name              = "basic_screen_ctrl"
basic_screen_ctrl.init_pos          = {basic_screen_x_offset, basic_screen_y_offset, basic_screen_z_offset} --为第一个显示区(四分)正中位置
basic_screen_ctrl.element_params    = {"BASIC_SCR_ENABLE"}
basic_screen_ctrl.controllers       = {{"opacity_using_parameter",0}}
basic_screen_ctrl.collimated	    = true
basic_screen_ctrl.use_mipfilter     = true
basic_screen_ctrl.additive_alpha    = true
basic_screen_ctrl.h_clip_relation   = h_clip_relations.COMPARE
basic_screen_ctrl.level             = MFD_DEFAULT_NOCLIP_LEVEL
basic_screen_ctrl.parent_element	= "main_screen_clip" --父对象为主屏幕裁剪层
basic_screen_ctrl.isvisible         = false
Add(basic_screen_ctrl)

-- 这是第二个姿态仪裁剪层
basic_ADI_clip 			            = CreateElement "ceMeshPoly" --这是创建一个平面
basic_ADI_clip.name 			    = "basic_ADI_clip"
basic_ADI_clip.vertices 		    = {{-55,80},{55,80},{55,-80},{-55,-80}} --四个边角
basic_ADI_clip.indices 		        = {0,1,2,0,3,2}
basic_ADI_clip.init_pos		        = {basic_screen_x_offset+15, basic_screen_y_offset, basic_screen_z_offset}
basic_ADI_clip.init_rot		        = {0, 0, 0}
basic_ADI_clip.material		        = "DBG_GREEN"
basic_ADI_clip.h_clip_relation      = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
basic_ADI_clip.level			    = MFD_DEFAULT_LEVEL - 1
--main_screen_1.isdraw		        = true
basic_ADI_clip.change_opacity       = false
--main_screen_1.element_params      = {"D_ENABLE"}
--main_screen_1.controllers         = {{"opacity_using_parameter",0}}
basic_ADI_clip.isvisible		    = false
--basic_ADI_clip.parent_element	= "basic_screen_ctrl" --使用它作为父对象，便于位置控制这里不能用父对象
Add(basic_ADI_clip)

-- 这个显示在第二个裁剪层中

-- 下面是一个输出空速, 位于最上层
local basic_ias_output              = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_ias_output.name               = ("basic_ias_" .. create_guid_string())
basic_ias_output.material           = "mpcd_font_base" --FONT_             --材质类型（注意上面创建的字体材质）
basic_ias_output.init_pos           = {12.5,122}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_ias_output.alignment          = "RightTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_ias_output.stringdefs         = {0.75*0.011,0.75*0.75 * 0.011, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_ias_output.formats            = {"%4.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_ias_output.element_params     = {"BASIC_IAS_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_ias_output.controllers        = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_ias_output.collimated         = true
basic_ias_output.use_mipfilter      = true
basic_ias_output.additive_alpha     = true
basic_ias_output.isvisible		    = true
basic_ias_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_ias_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_ias_output.parent_element     = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_ias_output)

-- 最上层用于显示雷达高度
local basic_ralt_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_ralt_output.name              = ("basic_ralt_" .. create_guid_string())
basic_ralt_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_ralt_output.init_pos          = {62,122}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_ralt_output.alignment         = "RightTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_ralt_output.stringdefs        = {0.75*0.011,0.75*0.75 * 0.011, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_ralt_output.formats           = {"%5.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_ralt_output.element_params    = {"BASIC_RALT_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_ralt_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_ralt_output.collimated        = true
basic_ralt_output.use_mipfilter     = true
basic_ralt_output.additive_alpha    = true
basic_ralt_output.isvisible		    = true
basic_ralt_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_ralt_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_ralt_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_ralt_output)

-- 最上层用于显示气压高度
local basic_alt_output              = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_alt_output.name               = ("basic_alt_" .. create_guid_string())
basic_alt_output.material           = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_alt_output.init_pos           = {88,0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_alt_output.alignment          = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_alt_output.stringdefs         = {0.75*0.011,0.75*0.75 * 0.011, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_alt_output.formats            = {"%5.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_alt_output.element_params     = {"BASIC_ALT_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_alt_output.controllers        = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_alt_output.collimated         = true
basic_alt_output.use_mipfilter      = true
basic_alt_output.additive_alpha     = true
basic_alt_output.isvisible		    = true
basic_alt_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_alt_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_alt_output.parent_element     = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_alt_output)

-- 最上层用于显示模式
local basic_mode_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_mode_output.name              = ("basic_mode_" .. create_guid_string())
basic_mode_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_mode_output.init_pos          = {-58,122}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_mode_output.alignment         = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_mode_output.stringdefs        = {0.75*0.011,0.75*0.75 * 0.011, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_mode_output.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_mode_output.element_params    = {"BASIC_MODE_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_mode_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_mode_output.collimated        = true
basic_mode_output.use_mipfilter     = true
basic_mode_output.additive_alpha    = true
basic_mode_output.isvisible		    = true
basic_mode_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_mode_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_mode_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_mode_output)

-- 最上层用于显示g值
local basic_g_output                = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_g_output.name                 = ("basic_g_" .. create_guid_string())
basic_g_output.material             = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_g_output.init_pos             = {40,108}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_g_output.alignment            = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_g_output.stringdefs           = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_g_output.formats              = {"%2.2f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_g_output.element_params       = {"BASIC_G_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_g_output.controllers          = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_g_output.collimated           = true
basic_g_output.use_mipfilter        = true
basic_g_output.additive_alpha       = true
basic_g_output.isvisible		    = true
basic_g_output.h_clip_relation 	    = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_g_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_g_output.parent_element       = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_g_output)

-- 最上层用于显示mach值
local basic_mach_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_mach_output.name              = ("basic_mach_" .. create_guid_string())
basic_mach_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_mach_output.init_pos          = {-75,56}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_mach_output.alignment         = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_mach_output.stringdefs        = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_mach_output.formats           = {"%2.2f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_mach_output.element_params    = {"BASIC_MACH_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_mach_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_mach_output.collimated        = true
basic_mach_output.use_mipfilter     = true
basic_mach_output.additive_alpha    = true
basic_mach_output.isvisible		    = true
basic_mach_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_mach_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_mach_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_mach_output)

-- 最上层用于显示g模式值
local basic_glimite_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_glimite_output.name              = ("basic_glimite_" .. create_guid_string())
basic_glimite_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_glimite_output.init_pos          = {-75,35}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_glimite_output.alignment         = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_glimite_output.stringdefs        = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_glimite_output.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_glimite_output.element_params    = {"BASIC_GMODE_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_glimite_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_glimite_output.collimated        = true
basic_glimite_output.use_mipfilter     = true
basic_glimite_output.additive_alpha    = true
basic_glimite_output.isvisible		    = true
basic_glimite_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_glimite_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_glimite_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_glimite_output)

-- 最上层用于显示地速
local basic_gs_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_gs_output.name              = ("basic_gs_" .. create_guid_string())
basic_gs_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_gs_output.init_pos          = {-75,16}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_gs_output.alignment         = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_gs_output.stringdefs        = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_gs_output.formats           = {"%4.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_gs_output.element_params    = {"BASIC_GS_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_gs_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_gs_output.collimated        = true
basic_gs_output.use_mipfilter     = true
basic_gs_output.additive_alpha    = true
basic_gs_output.isvisible		  = true
basic_gs_output.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_gs_output.level			  = MFD_DEFAULT_NOCLIP_LEVEL
basic_gs_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_gs_output)

-- 最上层用于显示导航模式值
local basic_navmode_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_navmode_output.name              = ("basic_navmode_" .. create_guid_string())
basic_navmode_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_navmode_output.init_pos          = {-75,-4}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_navmode_output.alignment         = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_navmode_output.stringdefs        = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_navmode_output.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_navmode_output.element_params    = {"BASIC_NAVMODE_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_navmode_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_navmode_output.collimated        = true
basic_navmode_output.use_mipfilter     = true
basic_navmode_output.additive_alpha    = true
basic_navmode_output.isvisible		    = true
basic_navmode_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_navmode_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_navmode_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_navmode_output)

-- 最上层用于显示导航模式值
local basic_gear_output             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
basic_gear_output.name              = ("basic_gear_" .. create_guid_string())
basic_gear_output.material          = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
basic_gear_output.init_pos          = {-75,-44}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
basic_gear_output.alignment         = "LeftTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
basic_gear_output.stringdefs        = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
basic_gear_output.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
basic_gear_output.element_params    = {"BASIC_GEAR_DIS", "BASIC_SCR_ENABLE"} --生成的para控制句柄
basic_gear_output.controllers       = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
basic_gear_output.collimated        = true
basic_gear_output.use_mipfilter     = true
basic_gear_output.additive_alpha    = true
basic_gear_output.isvisible		    = true
basic_gear_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
basic_gear_output.level			    = MFD_DEFAULT_NOCLIP_LEVEL
basic_gear_output.parent_element    = "basic_screen_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
Add(basic_gear_output)

-- 这个现在显示在第一个裁剪层中,是一个外框
basic_border 				        = CreateElement "ceTexPoly"
basic_border.vertices               = {{-106,125},{106,125},{106,-143},{-106,-143}}
basic_border.indices                = {0,1,2,2,3,0}
basic_border.tex_coords             = {{0,0},{1,0},{1,1},{0,1}}
basic_border.material               = basic_border_material
basic_border.name 			        = create_guid_string()
basic_border.init_pos               = {0, 0, 0}
basic_border.init_rot		        = {0, 0, 0}
basic_border.collimated	            = true
basic_border.element_params         = {"BASIC_SCR_ENABLE"} --, "D_GUNSIGHT_VISIBLE"
basic_border.controllers            = {{"opacity_using_parameter",0},}
basic_border.use_mipfilter          = true
basic_border.additive_alpha         = true
basic_border.h_clip_relation        = h_clip_relations.COMPARE
basic_border.level                  = MFD_DEFAULT_NOCLIP_LEVEL
basic_border.parent_element	        = "basic_screen_ctrl"
Add(basic_border)

-- 这是一个用来旋转的虚拟对象，用来防止主pitch向上或向下移动时候导致的异常
basic_ADI_rot                       = CreateElement "ceSimple"
basic_ADI_rot.name                  = "basic_ADI_rot"
basic_ADI_rot.init_pos              = {0, 0, 0}
basic_ADI_rot.element_params        = {"BASIC_IND_ROT"}
basic_ADI_rot.controllers           = {{"rotate_using_parameter",0,1}}
basic_ADI_rot.collimated	        = true
basic_ADI_rot.use_mipfilter         = true
basic_ADI_rot.additive_alpha        = true
basic_ADI_rot.h_clip_relation       = h_clip_relations.COMPARE
basic_ADI_rot.level                 = MFD_DEFAULT_LEVEL
basic_ADI_rot.parent_element	    = "basic_ADI_clip"
basic_ADI_rot.isvisible             = false
Add(basic_ADI_rot)

-- 这个现在显示在第二个裁剪层中,是水平仪
basic_ADI_background                = CreateElement "ceTexPoly"
basic_ADI_background.vertices       = {{-145,240},{145,240},{145,-240},{ -145,-240}} -- {{-400,400},{400,400},{400,-400},{-400,-400}}-- {{-422.5,180},{-132.5,180},{-132.5,-180},{ -422.5,-180}}
basic_ADI_background.indices        = {0,1,2,2,3,0}
basic_ADI_background.tex_coords     = {{0,0},{1,0},{1,1},{0,1}}
basic_ADI_background.material       = basic_ADI_material
basic_ADI_background.name 			= create_guid_string()
basic_ADI_background.init_pos       = {0, 0, 0}
basic_ADI_background.init_rot		= {0, 0, 0}
basic_ADI_background.collimated	    = true
basic_ADI_background.element_params = {"BASIC_SCR_ENABLE", "BASIC_IND_PITCH"}
basic_ADI_background.controllers    = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1,0.1},}
basic_ADI_background.use_mipfilter  = true
basic_ADI_background.additive_alpha = true
basic_ADI_background.h_clip_relation= h_clip_relations.COMPARE
basic_ADI_background.level          = MFD_DEFAULT_LEVEL
basic_ADI_background.parent_element	= "basic_ADI_rot"
Add(basic_ADI_background)

-- 这是水平仪表的指针
basic_ADI_center 				    = CreateElement "ceTexPoly"
basic_ADI_center.vertices           = {{-30,7.5},{30,7.5},{30,-7.5},{-30,-7.5}}
basic_ADI_center.indices            = {0,1,2,2,3,0}
basic_ADI_center.tex_coords         = {{0,0},{1,0},{1,1},{0,1}}
basic_ADI_center.material           = basic_ADI_center_material
basic_ADI_center.name 			    = create_guid_string()
basic_ADI_center.init_pos           = {15, -7.5, 0}
basic_ADI_center.init_rot		    = {0, 0, 0}
basic_ADI_center.collimated	        = true
basic_ADI_center.element_params     = {"BASIC_SCR_ENABLE"}
basic_ADI_center.controllers        = {{"opacity_using_parameter",0},}
basic_ADI_center.use_mipfilter      = true
basic_ADI_center.additive_alpha     = true
basic_ADI_center.h_clip_relation    = h_clip_relations.COMPARE
basic_ADI_center.level              = MFD_DEFAULT_NOCLIP_LEVEL
basic_ADI_center.parent_element	    = "basic_screen_ctrl"
Add(basic_ADI_center)