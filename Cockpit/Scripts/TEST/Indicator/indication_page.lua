dofile(LockOn_Options.script_path.."TEST/Indicator/def.lua") --所有页面都包含这个描述文件

local debug_y_offset = 40
local DEBUG_COLOR = {0,255,0,200}
local WHITE_COLOR = {255,255,255,200}
local GREY_COLOR = {150,150,150,255}
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_usa"},DEBUG_COLOR,50,"test_font") --创建字体(这个字体似乎只支持英文（虽然是unicode)
local IND_TEX_PATH = LockOn_Options.script_path .. "../Textures/"
local test_ind_material = MakeMaterial("test4.tga", {152,195,100,255})-- "test4.dds" MakeMaterial(IND_TEX_PATH.."test4.dds",DEBUG_COLOR) --IND_TEX_PATH.."test4.dds"Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/M2KC_VTB_Grid_2.tga
local test_ind_material_1 = MakeMaterial("ind_test_1.tga" , WHITE_COLOR) --ind_test_1.tga,"test4.dds"
local center_ind_material_1 = MakeMaterial("ind_center_1.tga" , GREY_COLOR)

-- 注意:父节点的选择会影响显示区域（是否被裁剪）；层级高则内部被裁剪，层级低外部被裁剪
-- 主要类型： 第一裁剪层：REWRITE_LEVEL； 第二裁剪层：increase_IF_LEVEL;显示层：COMPARE
-- 层级一般：DEFAULT_NOCLIP_LEVEL ： 这个是最上面一层；DEFAULT_LEVEL - 1 这个是 第二裁剪层位置；DEFAULT_LEVEL是最内层

-- 这个是最上面的总仪表裁剪层
main_screen 			 	= CreateElement "ceMeshPoly" --这个似乎是一个透明度模式
main_screen.name 			= "main_screen"
main_screen.vertices 		= {{-370,125},{370,125},{370,-143},{-370,-143}} --四个边角
main_screen.indices 		= {0,1,2,0,2,3}
main_screen.init_pos		= {0, 0, 0}
main_screen.init_rot		= {0, 0, 0}
main_screen.material		= "DBG_BLUE"
main_screen.h_clip_relation = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
main_screen.level			= TEST_DEFAULT_NOCLIP_LEVEL
main_screen.isdraw		    = true
main_screen.change_opacity  = false
main_screen.element_params  = {"D_ENABLE"}
main_screen.controllers     = {{"opacity_using_parameter",0}}
main_screen.isvisible		= false
Add(main_screen)

-- 这是第二个姿态仪裁剪层
main_screen_1 			 	 = CreateElement "ceMeshPoly" --这个似乎是一个透明度模式
main_screen_1.name 			 = "main_screen_1"
main_screen_1.vertices 		 = {{-300,90},{-200,90},{-200,-90},{-300,-90}} --四个边角，具体不清楚
main_screen_1.indices 		 = {0,1,2,0,3,2}
main_screen_1.init_pos		 = {0, 0, 0}
main_screen_1.init_rot		 = {0, 0, 0}
main_screen_1.material		 = "DBG_GREEN"
main_screen_1.h_clip_relation= h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
main_screen_1.level			 = TEST_DEFAULT_LEVEL - 1
--main_screen_1.isdraw		     = true
main_screen_1.change_opacity = false
--main_screen_1.element_params  = {"D_ENABLE"}
--main_screen_1.controllers     = {{"opacity_using_parameter",0}}
main_screen_1.isvisible		 = false
Add(main_screen_1)

-- 这个显示在第二个裁剪层中

-- 下面是一个输出空速, 位于最上层
local ias_output = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
ias_output.name             = ("ias_" .. create_guid_string())
ias_output.material         = "mpcd_font_base" --FONT_             --材质类型（注意上面创建的字体材质）
ias_output.init_pos         = {-205,105}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
ias_output.alignment        = "RightTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
ias_output.stringdefs       = {0.75*0.01,0.75*0.75 * 0.01, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
ias_output.formats          = {"IAS %3.0f KNOTS","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
ias_output.element_params   = {"D_IAS", "D_ENABLE"} --生成的para控制句柄
ias_output.controllers      = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
ias_output.collimated       = true
ias_output.use_mipfilter    = true
ias_output.additive_alpha   = true
ias_output.isvisible		= true
ias_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
ias_output.level			= TEST_DEFAULT_NOCLIP_LEVEL
ias_output.parent_element   = "main_screen"  --父节点名字 --可以绑定不在同一层的父节点
Add(ias_output)

-- 最上层用于显示仰角（测试用）
local pitch_output = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
pitch_output.name             = ("pitch_" .. create_guid_string())
pitch_output.material         = "mpcd_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
pitch_output.init_pos         = {-205,115}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
pitch_output.alignment        = "RightTop"       --对齐方式设置：Left/Right/Center; Top/Down/Center
pitch_output.stringdefs       = {0.75*0.010,0.75*0.75 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
pitch_output.formats          = {"PITCH %3.0f DEG","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
pitch_output.element_params   = {"D_PITCHDEG", "D_ENABLE"} --生成的para控制句柄
pitch_output.controllers      = {{"text_using_parameter",0,0},{"opacity_using_parameter",1}}   --输入控制模型
pitch_output.collimated       = true
pitch_output.use_mipfilter    = true
pitch_output.additive_alpha   = true
pitch_output.isvisible		= true
pitch_output.h_clip_relation 	= h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
pitch_output.level			= TEST_DEFAULT_NOCLIP_LEVEL
pitch_output.parent_element   = "main_screen"  --父节点名字 --可以绑定不在同一层的父节点
Add(pitch_output)

-- 这个现在显示在第一个裁剪层中,是一个外框
main_border_1 				    = CreateElement "ceTexPoly"
main_border_1.vertices          = {{-370,125},{-185,125},{-185,-143},{ -370,-143}}
main_border_1 .indices          = {0,1,2,2,3,0}
main_border_1 .tex_coords       = {{0,0},{1,0},{1,1},{0,1}}
main_border_1.material          = test_ind_material
main_border_1.name 			    = create_guid_string()
main_border_1.init_pos          = {0, 0, 0}
main_border_1.init_rot		    = {0, 0, 0}
main_border_1.collimated	    = true
main_border_1.element_params    = {"D_ENABLE"} --, "D_GUNSIGHT_VISIBLE"
main_border_1.controllers       = {{"opacity_using_parameter",0},}
main_border_1.use_mipfilter     = true
main_border_1.additive_alpha    = true
main_border_1.h_clip_relation   = h_clip_relations.COMPARE
main_border_1.level             = TEST_DEFAULT_NOCLIP_LEVEL
main_border_1.parent_element	= "main_screen"
Add(main_border_1)

-- 这是一个用来旋转的虚拟对象，用来防止主pitch向上或向下移动时候导致的异常
main_ind_1_rot              = CreateElement "ceSimple"
main_ind_1_rot.name         = "main_ind_1_rot"
main_ind_1_rot.init_pos     = {-250, 0, 0}
main_ind_1_rot.element_params   = {"D_ROT"}
main_ind_1_rot.controllers      = {{"rotate_using_parameter",0,1}}
main_ind_1_rot.collimated	    = true
main_ind_1_rot.use_mipfilter    = true
main_ind_1_rot.additive_alpha   = true
main_ind_1_rot.h_clip_relation  = h_clip_relations.COMPARE
main_ind_1_rot.level            = TEST_DEFAULT_LEVEL
main_ind_1_rot.parent_element	= "main_screen_1"
main_ind_1_rot.isvisible        = false
Add(main_ind_1_rot)

-- 这个现在显示在第二个裁剪层中,是水平仪
main_ind_1 				    = CreateElement "ceTexPoly"
main_ind_1.vertices          = {{-145,240},{145,240},{145,-240},{ -145,-240}} -- {{-400,400},{400,400},{400,-400},{-400,-400}}-- {{-422.5,180},{-132.5,180},{-132.5,-180},{ -422.5,-180}}
main_ind_1 .indices          = {0,1,2,2,3,0}
main_ind_1 .tex_coords       = {{0,0},{1,0},{1,1},{0,1}}
main_ind_1.material          = test_ind_material_1
main_ind_1.name 			    = create_guid_string()
main_ind_1.init_pos          = {0, 0, 0}
main_ind_1.init_rot		    = {0, 0, 0}
main_ind_1.collimated	    = true
main_ind_1.element_params    = {"D_ENABLE", "D_PITCH"}
main_ind_1.controllers       = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1,0.1},}
main_ind_1.use_mipfilter     = true
main_ind_1.additive_alpha    = true
main_ind_1.h_clip_relation   = h_clip_relations.COMPARE
main_ind_1.level             = TEST_DEFAULT_LEVEL
main_ind_1.parent_element	= "main_ind_1_rot"
Add(main_ind_1)

-- 这是水平仪表的指针
main_ind_center_1 				    = CreateElement "ceTexPoly"
main_ind_center_1.vertices          = {{-30,7.5},{30,7.5},{30,-7.5},{-30,-7.5}}
main_ind_center_1.indices          = {0,1,2,2,3,0}
main_ind_center_1.tex_coords       = {{0,0},{1,0},{1,1},{0,1}}
main_ind_center_1.material          = center_ind_material_1
main_ind_center_1.name 			    = create_guid_string()
main_ind_center_1.init_pos          = {-250, -7.5, 0}
main_ind_center_1.init_rot		    = {0, 0, 0}
main_ind_center_1.collimated	    = true
main_ind_center_1.element_params    = {"D_ENABLE"}
main_ind_center_1.controllers       = {{"opacity_using_parameter",0},}
main_ind_center_1.use_mipfilter     = true
main_ind_center_1.additive_alpha    = true
main_ind_center_1.h_clip_relation   = h_clip_relations.COMPARE
main_ind_center_1.level             = TEST_DEFAULT_NOCLIP_LEVEL
main_ind_center_1.parent_element	= "main_screen"
Add(main_ind_center_1)