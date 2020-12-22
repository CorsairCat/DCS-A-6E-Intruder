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
VDI_base_clip.material		    = "DBG_BLACK"
VDI_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
VDI_base_clip.level			    = VDI_DEFAULT_NOCLIP_LEVEL
VDI_base_clip.isdraw		    = true
VDI_base_clip.change_opacity    = false
VDI_base_clip.element_params    = {"VDI_DIS_ENABLE"}              -- 初始化主显示控制
VDI_base_clip.controllers       = {{"opacity_using_parameter",0}}
VDI_base_clip.isvisible		    = true
Add(VDI_base_clip)

-- basic_vdi_material_BR

local vdi_always_show				     = CreateElement "ceTexPoly"
vdi_always_show.vertices                 = vdi_vert_gen(700 ,60)
vdi_always_show.indices                  = {0,1,2,2,3,0}
vdi_always_show.tex_coords               = tex_coord_gen(465,90,180,20,2048,2048)
vdi_always_show.material                 = basic_vdi_material_BR
vdi_always_show.name 			         = create_guid_string()
vdi_always_show.init_pos                 = {1700/2000 , 0, 0}
vdi_always_show.init_rot		         = {0, 0, 0}
vdi_always_show.collimated	             = true
vdi_always_show.use_mipfilter            = true
vdi_always_show.additive_alpha           = true
vdi_always_show.element_params         = {"VDI_SIM_DIS_ENABLE", "VDI_TRIM_MOVE_PARAM"}
vdi_always_show.controllers            = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, 0.1}}
vdi_always_show.h_clip_relation          = h_clip_relations.COMPARE
vdi_always_show.level                    = VDI_DEFAULT_NOCLIP_LEVEL
vdi_always_show.parent_element           = "vdi_base_clip"
Add(vdi_always_show)

local vdi_always_show				     = CreateElement "ceTexPoly"
vdi_always_show.vertices                 = vdi_vert_gen(700 ,60)
vdi_always_show.indices                  = {0,1,2,2,3,0}
vdi_always_show.tex_coords               = tex_coord_gen(465,90,180,20,2048,2048)
vdi_always_show.material                 = basic_vdi_material_BR
vdi_always_show.name 			         = create_guid_string()
vdi_always_show.init_pos                 = {-1700/2000 , 0, 0}
vdi_always_show.init_rot		         = {0, 0, 0}
vdi_always_show.collimated	             = true
vdi_always_show.use_mipfilter            = true
vdi_always_show.additive_alpha           = true
vdi_always_show.element_params         = {"VDI_SIM_DIS_ENABLE", "VDI_TRIM_MOVE_PARAM"}
vdi_always_show.controllers            = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, 0.1}}
vdi_always_show.h_clip_relation          = h_clip_relations.COMPARE
vdi_always_show.level                    = VDI_DEFAULT_NOCLIP_LEVEL
vdi_always_show.parent_element           = "vdi_base_clip"
Add(vdi_always_show)

local VDI_ADI_rot                   = CreateElement "ceSimple"
VDI_ADI_rot.name                    = "VDI_SIM_BANK_rot"
VDI_ADI_rot.init_pos                = {0, 0, 0}
VDI_ADI_rot.element_params          = {"VDI_BANK"}
VDI_ADI_rot.controllers             = {{"rotate_using_parameter",0,1}}
VDI_ADI_rot.collimated	            = true
VDI_ADI_rot.use_mipfilter           = true
VDI_ADI_rot.additive_alpha          = true
VDI_ADI_rot.h_clip_relation         = h_clip_relations.COMPARE
VDI_ADI_rot.level                   = VDI_DEFAULT_NOCLIP_LEVEL
VDI_ADI_rot.parent_element	        = "vdi_base_clip"
VDI_ADI_rot.isvisible               = false
Add(VDI_ADI_rot)

local vdi_always_show				     = CreateElement "ceTexPoly"
vdi_always_show.vertices                 = vdi_vert_gen(60 , 500)
vdi_always_show.indices                  = {0,1,2,2,3,0}
vdi_always_show.tex_coords               = tex_coord_gen(465,90,180,20,2048,2048)
vdi_always_show.material                 = basic_vdi_material_BR
vdi_always_show.name 			         = create_guid_string()
vdi_always_show.init_pos                 = {0, 1300/1500, 0}
vdi_always_show.init_rot		         = {0, 0, 0}
vdi_always_show.collimated	             = true
vdi_always_show.use_mipfilter            = true
vdi_always_show.additive_alpha           = true
vdi_always_show.element_params         = {"VDI_SIM_DIS_ENABLE", "VDI_BANK_MOVE_PARAM"}
vdi_always_show.controllers            = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, 0.1}}
vdi_always_show.h_clip_relation          = h_clip_relations.COMPARE
vdi_always_show.level                    = VDI_DEFAULT_NOCLIP_LEVEL
vdi_always_show.parent_element           = "VDI_SIM_BANK_rot"
Add(vdi_always_show)

local vdi_always_show				     = CreateElement "ceTexPoly"
vdi_always_show.vertices                 = vdi_vert_gen(130 , 130)
vdi_always_show.indices                  = {0,1,2,2,3,0}
vdi_always_show.tex_coords               = tex_coord_gen(110, 580, 80, 80,2048,2048)
vdi_always_show.material                 = basic_vdi_material_BR
vdi_always_show.name 			         = create_guid_string()
vdi_always_show.init_pos                 = {0, 0, 0}
vdi_always_show.init_rot		         = {0, 0, 0}
vdi_always_show.collimated	             = true
vdi_always_show.use_mipfilter            = true
vdi_always_show.additive_alpha           = true
vdi_always_show.element_params         = {"VDI_SIM_DIS_ENABLE", "VDI_PITCH_MOVE", "VDI_YAW_MOVE"}
vdi_always_show.controllers            = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, 0.1}, {"move_left_right_using_parameter",2, 0.1}}
vdi_always_show.h_clip_relation          = h_clip_relations.COMPARE
vdi_always_show.level                    = VDI_DEFAULT_NOCLIP_LEVEL
vdi_always_show.parent_element           = "vdi_base_clip"
Add(vdi_always_show)




dofile(LockOn_Options.script_path.."VDI/vdi_analog_page.lua")