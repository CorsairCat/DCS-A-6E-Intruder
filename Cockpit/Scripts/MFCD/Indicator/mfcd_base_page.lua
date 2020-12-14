dofile(LockOn_Options.script_path.."MFCD/Indicator/mfcd_def.lua")

SHOW_MASKS = false

-- 这个操作可以将新建的裁剪块对齐到三个标记
local aspect       = GetAspect()

-- 这个是最上面的总仪表裁剪层
MFCD_base_clip 			 	        = CreateElement "ceMeshPoly" --这是裁剪层
MFCD_base_clip.name 			    = "MFCD_base_clip"
MFCD_base_clip.primitivetype   	    = "triangles"
MFCD_base_clip.vertices 		    = { {1, aspect}, { 1,-aspect}, { -1,-aspect}, {-1,aspect},} --四个边角
MFCD_base_clip.indices 		        = {0,1,2,0,2,3}
MFCD_base_clip.init_pos		        = {0, 0, 0}
MFCD_base_clip.init_rot		        = {0, 0, 0}
MFCD_base_clip.material		        = "DBG_GREY"
MFCD_base_clip.h_clip_relation      = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
MFCD_base_clip.level			    = MFCD_DEFAULT_NOCLIP_LEVEL
MFCD_base_clip.isdraw		        = true
MFCD_base_clip.change_opacity       = false
MFCD_base_clip.element_params       = {"MFCD_DIS_ENABLE"}              -- 初始化主显示控制
MFCD_base_clip.controllers          = {{"opacity_using_parameter",0}}
MFCD_base_clip.isvisible		    = SHOW_MASKS
Add(MFCD_base_clip)

local border 				    = CreateElement "ceTexPoly"
border.vertices                  = hud_vert_gen(6000, 10)
border.indices                   = {0,1,2,2,3,0}
border.tex_coords                = tex_coord_gen(35,982,2,2,2000,2000)
border.material                  = white_MFCD_material
border.name 			            = create_guid_string()
border.init_pos                  = {0,  aspect, 0}
border.init_rot		            = {0, 0, 0}
border.collimated	            = true
border.use_mipfilter             = true
border.additive_alpha            = true
border.h_clip_relation           = h_clip_relations.COMPARE
border.level                     = MFCD_DEFAULT_NOCLIP_LEVEL
border.parent_element	        = "mfcd_base_clip"
Add(border)

local border 				    = CreateElement "ceTexPoly"
border.vertices                  = hud_vert_gen(6000, 10)
border.indices                   = {0,1,2,2,3,0}
border.tex_coords                = tex_coord_gen(105,870,680,720,2000,2000)
border.material                  = white_MFCD_material
border.name 			            = create_guid_string()
border.init_pos                  = {0,  -aspect, 0}
border.init_rot		            = {0, 0, 0}
border.collimated	            = true
border.use_mipfilter             = true
border.additive_alpha            = true
border.h_clip_relation           = h_clip_relations.COMPARE
border.level                     = MFCD_DEFAULT_NOCLIP_LEVEL
border.parent_element	        = "mfcd_base_clip"
Add(border)

-- 加载基础页面
dofile(LockOn_Options.script_path.."MFCD/Indicator/mfcd_basic_page.lua")