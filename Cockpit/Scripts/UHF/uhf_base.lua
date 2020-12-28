dofile(LockOn_Options.script_path.."UHF/uhf_def.lua")

SHOW_MASKS = true

-- 这个操作可以将新建的裁剪块对齐到三个标记
local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect()

-- 这个是最上面的总仪表裁剪层
VDI_base_clip 			 	    = CreateElement "ceMeshPoly" --这是裁剪层
VDI_base_clip.name 			    = "uhf_base_clip"
VDI_base_clip.primitivetype   	= "triangles"
VDI_base_clip.vertices 		    = { {1, aspect}, { 1,-aspect}, { -1,-aspect}, {-1,aspect},} --四个边角
VDI_base_clip.indices 		    = {0,1,2,0,2,3,}
VDI_base_clip.init_pos		    = {0, 0, 0}
VDI_base_clip.init_rot		    = {0, 0, 0}
VDI_base_clip.material		    = "DBG_BLACK"
VDI_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
VDI_base_clip.level			    = UHF_DEFAULT_NOCLIP_LEVEL
VDI_base_clip.isdraw		    = true
VDI_base_clip.change_opacity    = false
VDI_base_clip.element_params    = {"VDI_DIS_ENABLE"}              -- 初始化主显示控制
VDI_base_clip.controllers       = {{"opacity_using_parameter",0}}
VDI_base_clip.isvisible		    = true
Add(VDI_base_clip)

-- 速度显示
local speed_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
speed_dis_text.material          = "uhf_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
speed_dis_text.init_pos          = {-1 , 0 , 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
speed_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
speed_dis_text.stringdefs        = {1*0.010,1 * 0.010, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
speed_dis_text.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
speed_dis_text.element_params    = {"UHF_DISPLAY"}
speed_dis_text.controllers       = {{"text_using_parameter",0},}
speed_dis_text.collimated        = true
speed_dis_text.use_mipfilter     = true
speed_dis_text.additive_alpha    = true
speed_dis_text.isvisible		 = true
speed_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
speed_dis_text.level			 = UHF_DEFAULT_NOCLIP_LEVEL
speed_dis_text.parent_element    = "uhf_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(speed_dis_text)
