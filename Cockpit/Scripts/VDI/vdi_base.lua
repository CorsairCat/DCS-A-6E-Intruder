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
VDI_base_clip.element_params    = {"VDI_ANALOG_DIS_ENABLE"}              -- 初始化主显示控制
VDI_base_clip.controllers       = {{"opacity_using_parameter",0}}
VDI_base_clip.isvisible		    = SHOW_MASKS
Add(VDI_base_clip)

vdi_cloud_clip 			                = CreateElement "ceMeshPoly" --这是创建一个平面
vdi_cloud_clip.name 			        = "vdi_cloud_clip"
vdi_cloud_clip.vertices 		        = vdi_vert_gen(4000, 1500, "downcenter")
vdi_cloud_clip.indices 		            = {0,1,2,0,3,2,}
vdi_cloud_clip.init_pos		            = { 0 , 0 , 0}
vdi_cloud_clip.init_rot		            = {0, 0, 0}
vdi_cloud_clip.material		            = "DBG_GREEN_V"
vdi_cloud_clip.h_clip_relation          = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
vdi_cloud_clip.level			        = VDI_DEFAULT_LEVEL - 1
vdi_cloud_clip.change_opacity           = false
vdi_cloud_clip.element_params           = {"VDI_CLOUD_DIS_ENABLE"}              -- 初始化主显示控制
vdi_cloud_clip.controllers              = {{"opacity_using_parameter",0}}
vdi_cloud_clip.isvisible		        = SHOW_MASKS
Add(vdi_cloud_clip)

vdi_ground_clip 			                = CreateElement "ceMeshPoly" --这是创建一个平面
vdi_ground_clip.name 			            = "vdi_ground_clip"
vdi_ground_clip.vertices 		            = vdi_vert_gen(4000, 1500, "topcenter")
vdi_ground_clip.indices 		            = {0,1,2,0,3,2,}
vdi_ground_clip.init_pos		            = { 0 , 0 , 0}
vdi_ground_clip.init_rot		            = {0, 0, 0}
vdi_ground_clip.material		            = "DBG_GREY"
vdi_ground_clip.h_clip_relation             = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
vdi_ground_clip.level			            = VDI_DEFAULT_LEVEL - 1
vdi_ground_clip.change_opacity              = false
vdi_ground_clip.element_params              = {"VDI_GROUND_DIS_ENABLE"}              -- 初始化主显示控制
vdi_ground_clip.controllers                 = {{"opacity_using_parameter",0}}
vdi_ground_clip.isvisible		            = SHOW_MASKS
Add(vdi_ground_clip)