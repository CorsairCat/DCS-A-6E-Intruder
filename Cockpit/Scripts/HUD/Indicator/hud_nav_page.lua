-- 基础导航指示内容放在这
-- basic_HUD_material

-- 425 145； 75 1900 1260

local fd_move_multi = 0.1

-- ADI指针旋转虚拟体
local HUD_ADI_rot                   = CreateElement "ceSimple"
HUD_ADI_rot.name                    = "HUD_ADI_rot"
HUD_ADI_rot.init_pos                = {0, 0, default_hud_z_offset}
HUD_ADI_rot.element_params          = {"HUD_ADI_ROT","HUD_ADI_MOVX","HUD_FD_Y"}
HUD_ADI_rot.controllers             = {{"rotate_using_parameter",0,1},{"move_left_right_using_parameter",1,fd_move_multi},{"move_up_down_using_parameter",2,fd_move_multi},}
HUD_ADI_rot.collimated	            = true
HUD_ADI_rot.use_mipfilter           = true
HUD_ADI_rot.additive_alpha          = true
HUD_ADI_rot.h_clip_relation         = h_clip_relations.COMPARE
HUD_ADI_rot.level                   = HUD_DEFAULT_NOCLIP_LEVEL
HUD_ADI_rot.parent_element	        = "hud_base_clip"
HUD_ADI_rot.isvisible               = false
Add(HUD_ADI_rot)

-- ADI指针移动虚拟体
local HUD_ADI_mov                   = CreateElement "ceSimple"
HUD_ADI_mov.name                    = "HUD_ADI_mov"
HUD_ADI_mov.init_pos                = {0, 0, 0}
HUD_ADI_mov.element_params          = {"HUD_ADI_MOVY","HUD_ADI_MOVX_2","ADI_LINE_GROUP",}
HUD_ADI_mov.controllers             = {{"move_up_down_using_parameter",0,0.9},{"move_left_right_using_parameter",1,0.1},{"opacity_using_parameter",2},}
HUD_ADI_mov.collimated	            = true
HUD_ADI_mov.use_mipfilter           = true
HUD_ADI_mov.additive_alpha          = true
HUD_ADI_mov.h_clip_relation         = h_clip_relations.COMPARE
HUD_ADI_mov.level                   = HUD_DEFAULT_NOCLIP_LEVEL
HUD_ADI_mov.parent_element	        = "HUD_ADI_rot"
HUD_ADI_mov.isvisible               = false
Add(HUD_ADI_mov)

-- 航行矢量指示
local flight_dire_ind 				     = CreateElement "ceTexPoly"
flight_dire_ind.vertices                 = hud_vert_gen(415,280)
flight_dire_ind.indices                  = {0,1,2,2,3,0}
flight_dire_ind.tex_coords               = tex_coord_gen(385,680,415,280,2000,2000)
flight_dire_ind.material                 = basic_HUD_material
flight_dire_ind.name 			         = create_guid_string()
flight_dire_ind.init_pos                 = {0, 0, default_hud_z_offset}
flight_dire_ind.init_rot		         = {0, 0, 30}
flight_dire_ind.collimated	             = true
flight_dire_ind.element_params           = {"ADI_LINE_GROUP","HUD_ADI_MOVX","HUD_FD_Y"}
flight_dire_ind.controllers              = {{"opacity_using_parameter",0},{"move_left_right_using_parameter",1,fd_move_multi},{"move_up_down_using_parameter",2,fd_move_multi},}
flight_dire_ind.use_mipfilter            = true
flight_dire_ind.additive_alpha           = true
flight_dire_ind.h_clip_relation          = h_clip_relations.COMPARE
flight_dire_ind.level                    = HUD_DEFAULT_NOCLIP_LEVEL
flight_dire_ind.parent_element	         = "hud_base_clip"
Add(flight_dire_ind)

-- 速度指示框
local speed_dis_box 				    = CreateElement "ceTexPoly"
speed_dis_box.vertices                  = hud_vert_gen(670,220)
speed_dis_box.indices                   = {0,1,2,2,3,0}
speed_dis_box.tex_coords                = tex_coord_gen(395,495,425,145,2000,2000)
speed_dis_box.material                  = basic_HUD_material
speed_dis_box.name 			            = create_guid_string()
speed_dis_box.init_pos                  = {-1 , 0.2 , default_hud_z_offset}
speed_dis_box.init_rot		            = {0, 0, default_hud_rot_offset}
speed_dis_box.collimated	            = true
speed_dis_box.use_mipfilter             = true
speed_dis_box.additive_alpha            = true
speed_dis_box.h_clip_relation           = h_clip_relations.COMPARE
speed_dis_box.level                     = HUD_DEFAULT_NOCLIP_LEVEL
speed_dis_box.parent_element	        = "hud_base_clip"
Add(speed_dis_box)

-- 速度显示
local speed_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
speed_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
speed_dis_text.init_pos          = {-1 + 320 / 2000 , 0.2 , default_hud_z_offset}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
speed_dis_text.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
speed_dis_text.stringdefs        = {1.2*0.010,1.2 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
speed_dis_text.formats           = {"%.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
speed_dis_text.element_params    = {"HUD_SPEED_DIS"}
speed_dis_text.controllers       = {{"text_using_parameter",0},}
speed_dis_text.collimated        = true
speed_dis_text.use_mipfilter     = true
speed_dis_text.additive_alpha    = true
speed_dis_text.isvisible		 = true
speed_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
speed_dis_text.level			 = HUD_DEFAULT_NOCLIP_LEVEL
speed_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(speed_dis_text)

-- 速度条移动虚拟体
local HUD_speed_bar_ctrl                   = CreateElement "ceSimple"
HUD_speed_bar_ctrl.name                    = "HUD_speed_bar_ctrl"
HUD_speed_bar_ctrl.init_pos                = {0, 0, 0}
HUD_speed_bar_ctrl.element_params          = {"HUD_SPEED_DIS"} -- {"HUD_SPEED_BAR_Y"}
HUD_speed_bar_ctrl.controllers             = {{"move_up_down_using_parameter",0,-0.00083871},}
HUD_speed_bar_ctrl.collimated	           = true
HUD_speed_bar_ctrl.use_mipfilter           = true
HUD_speed_bar_ctrl.additive_alpha          = true
HUD_speed_bar_ctrl.h_clip_relation         = h_clip_relations.COMPARE
HUD_speed_bar_ctrl.level                   = HUD_DEFAULT_LEVEL
HUD_speed_bar_ctrl.parent_element	       = "speed_move_clip"
HUD_speed_bar_ctrl.isvisible               = false
Add(HUD_speed_bar_ctrl)

local default_speed_bar_length = 3250
local count_i

for count_i = 1,12 do
    -- 速度指示条
    local HUD_speed_bar 				   = CreateElement "ceTexPoly"
    HUD_speed_bar.vertices                 = hud_vert_gen(150,default_speed_bar_length)
    HUD_speed_bar.indices                  = {0,1,2,2,3,0}
    HUD_speed_bar.tex_coords               = mirror_tex_coord_gen(0,10,75,1260,2000,2000)
    HUD_speed_bar.material                 = basic_HUD_material
    HUD_speed_bar.name 			           = create_guid_string()
    HUD_speed_bar.init_pos                 = {91/2000, (default_speed_bar_length / 2 + default_speed_bar_length * (count_i - 1)) / 2000, 0}
    HUD_speed_bar.init_rot		           = {0, 0, 0}
    HUD_speed_bar.collimated	           = true
    --HUD_speed_bar.element_params           = {"HUD_SPEED_BAR_GROUP",}
    --HUD_speed_bar.controllers              = {{"opacity_using_parameter",0},}
    HUD_speed_bar.use_mipfilter            = true
    HUD_speed_bar.additive_alpha           = true
    HUD_speed_bar.h_clip_relation          = h_clip_relations.COMPARE
    HUD_speed_bar.level                    = HUD_DEFAULT_LEVEL
    HUD_speed_bar.parent_element	       = "HUD_speed_bar_ctrl"
    Add(HUD_speed_bar)
end

for count_i = 0,60 do
    -- 速度条刻度显示
    local speed_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    speed_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    speed_dis_text.init_pos          = {- 38/2000, count_i * 812.5 / 2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    speed_dis_text.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    speed_dis_text.stringdefs        = {1 * 0.010,1 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    speed_dis_text.formats           = {tostring(count_i * 5),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    speed_dis_text.element_params    = {"HUD_DIS_ENABLE"}
    speed_dis_text.controllers       = {{"text_using_parameter",0},}
    speed_dis_text.collimated        = true
    speed_dis_text.use_mipfilter     = true
    speed_dis_text.additive_alpha    = true
    speed_dis_text.isvisible		 = true
    speed_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    speed_dis_text.level			 = HUD_DEFAULT_LEVEL
    speed_dis_text.parent_element    = "HUD_speed_bar_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
    Add(speed_dis_text)
end

-- 高度条移动虚拟体
local HUD_altitude_bar_ctrl                   = CreateElement "ceSimple"
HUD_altitude_bar_ctrl.name                    = "HUD_altitude_bar_ctrl"
HUD_altitude_bar_ctrl.init_pos                = {0, 0, 0}
HUD_altitude_bar_ctrl.element_params          = {"HUD_ALT_DIS"} -- {"HUD_SPEED_BAR_Y"}
HUD_altitude_bar_ctrl.controllers             = {{"move_up_down_using_parameter",0,-0.000083871},}
HUD_altitude_bar_ctrl.collimated	           = true
HUD_altitude_bar_ctrl.use_mipfilter           = true
HUD_altitude_bar_ctrl.additive_alpha          = true
HUD_altitude_bar_ctrl.h_clip_relation         = h_clip_relations.COMPARE
HUD_altitude_bar_ctrl.level                   = HUD_DEFAULT_LEVEL
HUD_altitude_bar_ctrl.parent_element	       = "altitude_move_clip"
HUD_altitude_bar_ctrl.isvisible               = false
Add(HUD_altitude_bar_ctrl)

local default_speed_bar_length = 3250
local count_i

for count_i = 1,24 do
    -- 高度指示条
    local HUD_altitude_bar 				   = CreateElement "ceTexPoly"
    HUD_altitude_bar.vertices                 = hud_vert_gen(150,default_speed_bar_length)
    HUD_altitude_bar.indices                  = {0,1,2,2,3,0}
    HUD_altitude_bar.tex_coords               = tex_coord_gen(0,10,75,1260,2000,2000)
    HUD_altitude_bar.material                 = basic_HUD_material
    HUD_altitude_bar.name 			           = create_guid_string()
    HUD_altitude_bar.init_pos                 = {-91/2000, (default_speed_bar_length / 2 + default_speed_bar_length * (count_i - 1)) / 2000, 0}
    HUD_altitude_bar.init_rot		           = {0, 0, 0}
    HUD_altitude_bar.collimated	           = true
    --HUD_altitude_bar.element_params           = {"HUD_ALT_BAR_GROUP",}
    --HUD_altitude_bar.controllers              = {{"opacity_using_parameter",0},}
    HUD_altitude_bar.use_mipfilter            = true
    HUD_altitude_bar.additive_alpha           = true
    HUD_altitude_bar.h_clip_relation          = h_clip_relations.COMPARE
    HUD_altitude_bar.level                    = HUD_DEFAULT_LEVEL
    HUD_altitude_bar.parent_element	       = "HUD_altitude_bar_ctrl"
    Add(HUD_altitude_bar)
end

for count_i = 0,120 do
    -- 高度条刻度显示
    local altitude_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    altitude_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    altitude_dis_text.init_pos          = { 38/2000, count_i * 812.5 / 2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    altitude_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    altitude_dis_text.stringdefs        = {1 * 0.010,1 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    altitude_dis_text.formats           = {tostring(count_i * 5),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    altitude_dis_text.element_params    = {"HUD_DIS_ENABLE"}
    altitude_dis_text.controllers       = {{"text_using_parameter",0},}
    altitude_dis_text.collimated        = true
    altitude_dis_text.use_mipfilter     = true
    altitude_dis_text.additive_alpha    = true
    altitude_dis_text.isvisible		 = true
    altitude_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    altitude_dis_text.level			 = HUD_DEFAULT_LEVEL
    altitude_dis_text.parent_element    = "HUD_altitude_bar_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
    Add(altitude_dis_text)
end

-- 高度指示框
local alt_dis_box 				    = CreateElement "ceTexPoly"
alt_dis_box.vertices                  = hud_vert_gen(790,220)
alt_dis_box.indices                   = {0,1,2,2,3,0}
alt_dis_box.tex_coords                = tex_coord_gen(1145,495,500,145,2000,2000)
alt_dis_box.material                  = basic_HUD_material
alt_dis_box.name 			            = create_guid_string()
alt_dis_box.init_pos                  = {1 , 0.2 , default_hud_z_offset}
alt_dis_box.init_rot		            = {0, 0, default_hud_rot_offset}
alt_dis_box.collimated	            = true
alt_dis_box.use_mipfilter             = true
alt_dis_box.additive_alpha            = true
alt_dis_box.h_clip_relation           = h_clip_relations.COMPARE
alt_dis_box.level                     = HUD_DEFAULT_NOCLIP_LEVEL
alt_dis_box.parent_element	        = "hud_base_clip"
Add(alt_dis_box)

-- 280,760
-- 航向指示条
local heading_tag 				        = CreateElement "ceTexPoly"
heading_tag.vertices                    = hud_vert_gen(20,100)
heading_tag.indices                     = {0,1,2,2,3,0}
heading_tag.tex_coords                  = tex_coord_gen(280,760,8,70,2000,2000)
heading_tag.material                    = basic_HUD_material
heading_tag.name 			            = create_guid_string()
heading_tag.init_pos                    = {0 , 1845/2000 , default_hud_z_offset}
heading_tag.init_rot		            = {0, 0, default_hud_rot_offset}
heading_tag.collimated	                = true
heading_tag.use_mipfilter               = true
heading_tag.additive_alpha              = true
heading_tag.h_clip_relation             = h_clip_relations.COMPARE
heading_tag.level                       = HUD_DEFAULT_NOCLIP_LEVEL
heading_tag.parent_element	            = "hud_base_clip"
Add(heading_tag)

-- 高度显示
local alt_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
alt_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
alt_dis_text.init_pos          = {1 - 375 / 2000 , 0.2 , default_hud_z_offset}--{-370/2000, 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
alt_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
alt_dis_text.stringdefs        = {1.2*0.010,1.2 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
alt_dis_text.formats           = {"%.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
alt_dis_text.element_params    = {"HUD_ALT_DIS"}
alt_dis_text.controllers       = {{"text_using_parameter",0},}
alt_dis_text.collimated        = true
alt_dis_text.use_mipfilter     = true
alt_dis_text.additive_alpha    = true
alt_dis_text.isvisible		 = true
alt_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
alt_dis_text.level			 = HUD_DEFAULT_NOCLIP_LEVEL
alt_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(alt_dis_text)

-- G值显示
local G_level_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
G_level_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
G_level_dis_box.init_pos          = {-1800/2000, 2140/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
G_level_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
G_level_dis_box.stringdefs        = {0.9*0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
G_level_dis_box.formats           = {"G %.1f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
G_level_dis_box.element_params    = {"HUD_G_DIS"}
G_level_dis_box.controllers       = {{"text_using_parameter",0},}
G_level_dis_box.collimated        = true
G_level_dis_box.use_mipfilter     = true
G_level_dis_box.additive_alpha    = true
G_level_dis_box.isvisible		 = true
G_level_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
G_level_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
G_level_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(G_level_dis_box)

-- AOA显示
local AOA_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
AOA_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
AOA_dis_box.init_pos          = {-1800/2000, 2000/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
AOA_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
AOA_dis_box.stringdefs        = {0.9*0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
AOA_dis_box.formats           = {"\24  %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
AOA_dis_box.element_params    = {"HUD_AOA_DIS"}
AOA_dis_box.controllers       = {{"text_using_parameter",0},}
AOA_dis_box.collimated        = true
AOA_dis_box.use_mipfilter     = true
AOA_dis_box.additive_alpha    = true
AOA_dis_box.isvisible		 = true
AOA_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
AOA_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
AOA_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(AOA_dis_box)

-- 磁航向显示
local magnitude_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
magnitude_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
magnitude_dis_text.init_pos          = {0, 2500/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
magnitude_dis_text.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
magnitude_dis_text.stringdefs        = {1*0.010,1 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
magnitude_dis_text.formats           = {"%.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
magnitude_dis_text.element_params    = {"HUD_HDG_DIS"}
magnitude_dis_text.controllers       = {{"text_using_parameter",0},}
magnitude_dis_text.collimated        = true
magnitude_dis_text.use_mipfilter     = true
magnitude_dis_text.additive_alpha    = true
magnitude_dis_text.isvisible		 = true
magnitude_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
magnitude_dis_text.level			 = HUD_DEFAULT_NOCLIP_LEVEL
magnitude_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(magnitude_dis_text)

local default_heading_bar_length = 8500

-- 航向条移动虚拟体
local HUD_heading_bar_ctrl                   = CreateElement "ceSimple"
HUD_heading_bar_ctrl.name                    = "HUD_heading_bar_ctrl"
HUD_heading_bar_ctrl.init_pos                = {0, 0, 0}
HUD_heading_bar_ctrl.element_params          = {"HUD_HDG_MOV"} -- {"HUD_SPEED_BAR_Y"}
HUD_heading_bar_ctrl.controllers             = {{"move_left_right_using_parameter",0,0.06377 * default_heading_bar_length / 5000},}
HUD_heading_bar_ctrl.collimated	             = true
HUD_heading_bar_ctrl.use_mipfilter           = true
HUD_heading_bar_ctrl.additive_alpha          = true
HUD_heading_bar_ctrl.h_clip_relation         = h_clip_relations.COMPARE
HUD_heading_bar_ctrl.level                   = HUD_DEFAULT_LEVEL
HUD_heading_bar_ctrl.parent_element	         = "heading_move_clip"
HUD_heading_bar_ctrl.isvisible               = false
Add(HUD_heading_bar_ctrl)

-- 0， 1930
for count_i = 1,11 do
    -- 航向指示条
    local HUD_heading_bar 				     = CreateElement "ceTexPoly"
    HUD_heading_bar.vertices                 = hud_vert_gen(default_heading_bar_length,150)
    HUD_heading_bar.indices                  = {0,1,2,2,3,0}
    HUD_heading_bar.tex_coords               = tex_coord_gen(0,1930,1260,70,2000,2000)
    HUD_heading_bar.material                 = basic_HUD_material
    HUD_heading_bar.name 			         = create_guid_string()
    HUD_heading_bar.init_pos                 = {(default_heading_bar_length * (count_i - 6)) / 2000, -75 / 2000 , 0}
    HUD_heading_bar.init_rot		         = {0, 0, 0}
    HUD_heading_bar.collimated	             = true
    --HUD_heading_bar.element_params           = {"HUD_ALT_BAR_GROUP",}
    --HUD_heading_bar.controllers              = {{"opacity_using_parameter",0},}
    HUD_heading_bar.use_mipfilter            = true
    HUD_heading_bar.additive_alpha           = true
    HUD_heading_bar.h_clip_relation          = h_clip_relations.COMPARE
    HUD_heading_bar.level                    = HUD_DEFAULT_LEVEL
    HUD_heading_bar.parent_element	         = "HUD_heading_bar_ctrl"
    Add(HUD_heading_bar)
end

local heading_temp

for count_i = -22,22 do
    if  count_i < 0 then
        heading_temp = 36 + count_i
    elseif count_i >= 0 then
        heading_temp = count_i
    end
    -- 航向条刻度显示
    local heading_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    heading_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    heading_dis_text.init_pos          = { count_i * default_heading_bar_length / 4 / 2000 , 20/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    heading_dis_text.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    heading_dis_text.stringdefs        = {1 * 0.010,1 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    heading_dis_text.formats           = {tostring(heading_temp),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    heading_dis_text.element_params    = {"HUD_DIS_ENABLE"}
    heading_dis_text.controllers       = {{"text_using_parameter",0},}
    heading_dis_text.collimated        = true
    heading_dis_text.use_mipfilter     = true
    heading_dis_text.additive_alpha    = true
    heading_dis_text.isvisible		   = true
    heading_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    heading_dis_text.level			   = HUD_DEFAULT_LEVEL
    heading_dis_text.parent_element    = "HUD_heading_bar_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
    Add(heading_dis_text)
end

-- 马赫数显示
local Mach_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
Mach_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
Mach_dis_box.init_pos          = {-2000/2000, -900/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
Mach_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
Mach_dis_box.stringdefs        = {0.85*0.010,0.85 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
Mach_dis_box.formats           = {"M %.2f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
Mach_dis_box.element_params    = {"HUD_MACH_DIS"}
Mach_dis_box.controllers       = {{"text_using_parameter",0},}
Mach_dis_box.collimated        = true
Mach_dis_box.use_mipfilter     = true
Mach_dis_box.additive_alpha    = true
Mach_dis_box.isvisible		 = true
Mach_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
Mach_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
Mach_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(Mach_dis_box)

-- 雷达高度显示
local Ralt_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
Ralt_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
Ralt_dis_box.init_pos          = {1500/2000, -900/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
Ralt_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
Ralt_dis_box.stringdefs        = {0.85*0.010,0.85 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
Ralt_dis_box.formats           = {"RA %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
Ralt_dis_box.element_params    = {"HUD_RALT_DIS"}
Ralt_dis_box.controllers       = {{"text_using_parameter",0},}
Ralt_dis_box.collimated        = true
Ralt_dis_box.use_mipfilter     = true
Ralt_dis_box.additive_alpha    = true
Ralt_dis_box.isvisible		 = true
Ralt_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
Ralt_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
Ralt_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(Ralt_dis_box)

-- 左发动机N2转速显示
local LN2_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
LN2_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
LN2_dis_box.init_pos          = {-2000/2000, -1500/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
LN2_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
LN2_dis_box.stringdefs        = {0.8*0.010,0.8 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
LN2_dis_box.formats           = {"LN2 %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
LN2_dis_box.element_params    = {"HUD_LN2_DIS"}
LN2_dis_box.controllers       = {{"text_using_parameter",0},}
LN2_dis_box.collimated        = true
LN2_dis_box.use_mipfilter     = true
LN2_dis_box.additive_alpha    = true
LN2_dis_box.isvisible		 = true
LN2_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
LN2_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
LN2_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(LN2_dis_box)

-- 右发动机N2转速显示
local RN2_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
RN2_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
RN2_dis_box.init_pos          = {-2000/2000, -1640/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
RN2_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
RN2_dis_box.stringdefs        = {0.8*0.010,0.8 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
RN2_dis_box.formats           = {"RN2 %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
RN2_dis_box.element_params    = {"HUD_RN2_DIS"}
RN2_dis_box.controllers       = {{"text_using_parameter",0},}
RN2_dis_box.collimated        = true
RN2_dis_box.use_mipfilter     = true
RN2_dis_box.additive_alpha    = true
RN2_dis_box.isvisible		 = true
RN2_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
RN2_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
RN2_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(RN2_dis_box)

-- 全程最大过载显示
local GM_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
GM_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
GM_dis_box.init_pos          = {-2000/2000, -1780/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
GM_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
GM_dis_box.stringdefs        = {0.8*0.010,0.8 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
GM_dis_box.formats           = {"GM %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
GM_dis_box.element_params    = {"HUD_GM_DIS"}
GM_dis_box.controllers       = {{"text_using_parameter",0},}
GM_dis_box.collimated        = true
GM_dis_box.use_mipfilter     = true
GM_dis_box.additive_alpha    = true
GM_dis_box.isvisible		 = true
GM_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
GM_dis_box.level			 = HUD_DEFAULT_NOCLIP_LEVEL
GM_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(GM_dis_box)

-- 右下航点显示第一行
local nav_line1_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
nav_line1_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
nav_line1_dis_text.init_pos          = {1400/2000, -1500/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
nav_line1_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
nav_line1_dis_text.stringdefs        = {0.7*0.010,0.7 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
nav_line1_dis_text.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
nav_line1_dis_text.element_params    = {"HUD_NAV_DATA_1_DIS"}
nav_line1_dis_text.controllers       = {{"text_using_parameter",0},}
nav_line1_dis_text.collimated        = true
nav_line1_dis_text.use_mipfilter     = true
nav_line1_dis_text.additive_alpha    = true
nav_line1_dis_text.isvisible		 = true
nav_line1_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
nav_line1_dis_text.level			 = HUD_DEFAULT_NOCLIP_LEVEL
nav_line1_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(nav_line1_dis_text)

--右下航点显示第二行
local nav_line2_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
nav_line2_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
nav_line2_dis_text.init_pos          = {1400/2000, -1640/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
nav_line2_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
nav_line2_dis_text.stringdefs        = {0.7*0.010,0.7 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
nav_line2_dis_text.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
nav_line2_dis_text.element_params    = {"HUD_NAV_DATA_2_DIS"}
nav_line2_dis_text.controllers       = {{"text_using_parameter",0},}
nav_line2_dis_text.collimated        = true
nav_line2_dis_text.use_mipfilter     = true
nav_line2_dis_text.additive_alpha    = true
nav_line2_dis_text.isvisible		 = true
nav_line2_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
nav_line2_dis_text.level			 = HUD_DEFAULT_NOCLIP_LEVEL
nav_line2_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(nav_line2_dis_text)

-- 右下航点显示第三行
local nav_line3_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
nav_line3_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
nav_line3_dis_text.init_pos          = {1400/2000, -1780/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
nav_line3_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
nav_line3_dis_text.stringdefs        = {0.7*0.010,0.7 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
nav_line3_dis_text.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
nav_line3_dis_text.element_params    = {"HUD_NAV_DATA_3_DIS"}
nav_line3_dis_text.controllers       = {{"text_using_parameter",0},}
nav_line3_dis_text.collimated        = true
nav_line3_dis_text.use_mipfilter     = true
nav_line3_dis_text.additive_alpha    = true
nav_line3_dis_text.isvisible		 = true
nav_line3_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
nav_line3_dis_text.level			 = HUD_DEFAULT_NOCLIP_LEVEL
nav_line3_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(nav_line3_dis_text)

-- 水平线(0位置)指示
local level_line 				    = CreateElement "ceTexPoly"
level_line.vertices                 = hud_vert_gen(3000,150)
level_line.indices                  = {0,1,2,2,3,0}
level_line.tex_coords               = tex_coord_gen(385,370,1280,90,2000,2000)
level_line.material                 = basic_HUD_material
level_line.name 			        = create_guid_string()
level_line.init_pos                 = {0, 0, 0}
level_line.init_rot		            = {0, 0, 30}
level_line.collimated	            = true
level_line.element_params           = {"ADI_LINE_GROUP"}
level_line.controllers              = {{"opacity_using_parameter",0},}
level_line.use_mipfilter            = true
level_line.additive_alpha           = true
level_line.h_clip_relation          = h_clip_relations.COMPARE
level_line.level                    = HUD_DEFAULT_NOCLIP_LEVEL
level_line.parent_element	        = "HUD_ADI_mov"
Add(level_line)

-- 
local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
left_0_line_sign.init_pos          = {0.74, 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
left_0_line_sign.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
left_0_line_sign.stringdefs        = {0.9*0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
left_0_line_sign.formats           = {"0","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
left_0_line_sign.collimated        = true
left_0_line_sign.use_mipfilter     = true
left_0_line_sign.additive_alpha    = true
left_0_line_sign.isvisible		   = true
left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
left_0_line_sign.level			   = HUD_DEFAULT_NOCLIP_LEVEL
left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
Add(left_0_line_sign)

-- 
local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
left_0_line_sign.init_pos          = {-0.73, 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
left_0_line_sign.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
left_0_line_sign.stringdefs        = {0.9*0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
left_0_line_sign.formats           = {"0","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
left_0_line_sign.collimated        = true
left_0_line_sign.use_mipfilter     = true
left_0_line_sign.additive_alpha    = true
left_0_line_sign.isvisible		   = true
left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
left_0_line_sign.level			   = HUD_DEFAULT_NOCLIP_LEVEL
left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
Add(left_0_line_sign)

local i 
local sign_number
local vertical_distance

-- 循环生成ADI上半水平线
for i = 1,18 do
    sign_number = i * 5
    vertical_distance = i * 0.8
    -- 水平线指示
    local level_line 				    = CreateElement "ceTexPoly"
    level_line.vertices                 = hud_vert_gen(2000,130)
    level_line.indices                  = {0,1,2,2,3,0}
    level_line.tex_coords               = tex_coord_gen(560,120,935,65,2000,2000)
    level_line.material                 = basic_HUD_material
    level_line.name 			        = create_guid_string()
    level_line.init_pos                 = {0, vertical_distance, 0}
    level_line.init_rot		            = {0, 0, 30}
    level_line.collimated	            = true
    level_line.element_params           = {"ADI_LINE_GROUP"}
    level_line.controllers              = {{"opacity_using_parameter",0},}
    level_line.use_mipfilter            = true
    level_line.additive_alpha           = true
    level_line.h_clip_relation          = h_clip_relations.COMPARE
    level_line.level                    = HUD_DEFAULT_NOCLIP_LEVEL
    level_line.parent_element	        = "HUD_ADI_mov"
    Add(level_line)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = {0.9*0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_DEFAULT_NOCLIP_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {-0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = {0.9 * 0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_DEFAULT_NOCLIP_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)
end

-- 循环生成ADI下半水平线
for i = 1,18 do
    sign_number = - i * 5
    vertical_distance = - i * 0.8
    -- 水平线指示
    local level_line 				    = CreateElement "ceTexPoly"
    level_line.vertices                 = hud_vert_gen(2000,130)
    level_line.indices                  = {0,1,2,2,3,0}
    level_line.tex_coords               = tex_coord_gen(560,245,935,65,2000,2000)
    level_line.material                 = basic_HUD_material
    level_line.name 			        = create_guid_string()
    level_line.init_pos                 = {0, vertical_distance, 0}
    level_line.init_rot		            = {0, 0, 30}
    level_line.collimated	            = true
    level_line.element_params           = {"ADI_LINE_GROUP"}
    level_line.controllers              = {{"opacity_using_parameter",0},}
    level_line.use_mipfilter            = true
    level_line.additive_alpha           = true
    level_line.h_clip_relation          = h_clip_relations.COMPARE
    level_line.level                    = HUD_DEFAULT_NOCLIP_LEVEL
    level_line.parent_element	        = "HUD_ADI_mov"
    Add(level_line)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = {0.9*0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_DEFAULT_NOCLIP_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {-0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = {0.9 * 0.010,0.9 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_DEFAULT_NOCLIP_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)
end