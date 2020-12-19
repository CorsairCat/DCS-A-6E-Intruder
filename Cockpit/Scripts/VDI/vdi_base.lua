dofile(LockOn_Options.script_path.."VDI/vdi_def.lua")

SHOW_MASKS = true

-- 这个操作可以将新建的裁剪块对齐到三个标记
local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect()

-- 这个是最上面的总仪表裁剪层
VDI_base_clip 			 	    = CreateElement "ceMeshPoly" --这是裁剪层
VDI_base_clip.name 			    = "vdi_base_clip"
VDI_base_clip.primitivetype   	= "triangles"
VDI_base_clip.vertices 		    = { {1, aspect}, { 1,-aspect}, { -1,-aspect}, {-1,aspect},} --四个边角
VDI_base_clip.indices 		    = {0,1,2,0,2,3,}
VDI_base_clip.init_pos		    = {0, 0, 0}
VDI_base_clip.init_rot		    = {0, 0, 0}
VDI_base_clip.material		    = "DBG_GREY"
VDI_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
VDI_base_clip.level			    = VDI_DEFAULT_NOCLIP_LEVEL
VDI_base_clip.isdraw		    = true
VDI_base_clip.change_opacity    = false
VDI_base_clip.element_params    = {"VDI_DIS_ENABLE"}              -- 初始化主显示控制
VDI_base_clip.controllers       = {{"opacity_using_parameter",0}}
VDI_base_clip.isvisible		    = true
Add(VDI_base_clip)

dofile(LockOn_Options.script_path.."VDI/vdi_analog_page.lua")