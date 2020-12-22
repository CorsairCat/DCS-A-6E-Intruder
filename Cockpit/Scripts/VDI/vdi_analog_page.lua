Z_OFFSET_VDI = 0

local VDI_ADI_rot                   = CreateElement "ceSimple"
VDI_ADI_rot.name                    = "VDI_ANA_ADI_rot"
VDI_ADI_rot.init_pos                = {0, Z_OFFSET_VDI, 0}
VDI_ADI_rot.element_params          = {"VDI_ANALOG_ADI_ROLL",}
VDI_ADI_rot.controllers             = {{"rotate_using_parameter",0,1}}
VDI_ADI_rot.collimated	            = true
VDI_ADI_rot.use_mipfilter           = true
VDI_ADI_rot.additive_alpha          = true
VDI_ADI_rot.h_clip_relation         = h_clip_relations.COMPARE
VDI_ADI_rot.level                   = VDI_DEFAULT_NOCLIP_LEVEL
VDI_ADI_rot.parent_element	        = "vdi_base_clip"
VDI_ADI_rot.isvisible               = false
Add(VDI_ADI_rot)

local VDI_ADI_rot                   = CreateElement "ceSimple"
VDI_ADI_rot.name                    = "VDI_ANA_ADI_rot_2"
VDI_ADI_rot.init_pos                = {0, Z_OFFSET_VDI, 0}
VDI_ADI_rot.element_params          = {"VDI_ANALOG_ADI_ROLL",}
VDI_ADI_rot.controllers             = {{"rotate_using_parameter",0,1}}
VDI_ADI_rot.collimated	            = true
VDI_ADI_rot.use_mipfilter           = true
VDI_ADI_rot.additive_alpha          = true
VDI_ADI_rot.h_clip_relation         = h_clip_relations.COMPARE
VDI_ADI_rot.level                   = VDI_DEFAULT_NOCLIP_LEVEL
VDI_ADI_rot.parent_element	        = "vdi_base_clip"
VDI_ADI_rot.isvisible               = false
Add(VDI_ADI_rot)

local vdi_cloud_clip 			        = CreateElement "ceTexPoly"
vdi_cloud_clip.name 			        = "vdi_cloud_clip"
vdi_cloud_clip.vertices 		        = vdi_vert_gen(8000, 3000, "downcenter")
-- vdi_cloud_clip.tex_coords               = tex_coord_gen(1050,30,30,30,2048,2048)
vdi_cloud_clip.indices 		            = {0,1,2,0,3,2,}
vdi_cloud_clip.init_pos		            = { 0 , 0 , 0}
vdi_cloud_clip.init_rot		            = {0, 0, 0}
vdi_cloud_clip.material		            = "BASE_SKY_GREEN"
vdi_cloud_clip.h_clip_relation          = h_clip_relations.COMPARE--COMPARE --REWRITE_LEVEL
vdi_cloud_clip.level			        = VDI_DEFAULT_NOCLIP_LEVEL
vdi_cloud_clip.change_opacity           = false
vdi_cloud_clip.element_params           = {"VDI_ANALOG_DIS_ENABLE", "VDI_BG_PITCH"}              -- 初始化主显示控制
vdi_cloud_clip.controllers              = {{"opacity_using_parameter",0},  {"move_up_down_using_parameter",1, 0.1},}
-- vdi_cloud_clip.isvisible		        = SHOW_MASKS
vdi_cloud_clip.parent_element	        = "VDI_ANA_ADI_rot"
Add(vdi_cloud_clip)

local vdi_ground_clip 			            = CreateElement "ceMeshPoly" --这是创建一个平面
vdi_ground_clip.name 			            = "vdi_ground_clip"
vdi_ground_clip.vertices 		            = vdi_vert_gen(8000, 3000, "topcenter")
vdi_ground_clip.indices 		            = {0,1,2,0,3,2,}
vdi_ground_clip.init_pos		            = { 0 , 0 , 0}
vdi_ground_clip.init_rot		            = {0, 0, 0}
vdi_ground_clip.material		            = "BASE_GROUND_GREEN"
vdi_ground_clip.h_clip_relation             = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
vdi_ground_clip.level			            = VDI_DEFAULT_LEVEL - 1
vdi_ground_clip.change_opacity              = false
vdi_ground_clip.element_params              = {"VDI_ANALOG_DIS_ENABLE", "VDI_BG_PITCH"}              -- 初始化主显示控制
vdi_ground_clip.controllers                 = {{"opacity_using_parameter",0}, {"move_up_down_using_parameter",1, 0.1},}
vdi_ground_clip.isvisible		            = SHOW_MASKS
vdi_ground_clip.parent_element	            = "VDI_ANA_ADI_rot_2"
Add(vdi_ground_clip)

-- 
local vdi_analog_ground 				   = CreateElement "ceTexPoly"
vdi_analog_ground.vertices                 = vdi_vert_gen(4500 ,4000)
vdi_analog_ground.indices                  = {0,1,2,2,3,0}
vdi_analog_ground.tex_coords               = tex_coord_gen(0,1024,1024,1024,2048,2048)
vdi_analog_ground.material                 = basic_vdi_material_dark
vdi_analog_ground.name 			           = create_guid_string()
vdi_analog_ground.init_pos                 = {0, 0, 0}
vdi_analog_ground.init_rot		           = {0, 0, 0}
vdi_analog_ground.collimated	           = true
vdi_analog_ground.element_params           = {"VDI_ANALOG_GROUND_ENABLE","VDI_ANALOG_GROUND_MOVING"}
vdi_analog_ground.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, 0.1},}
vdi_analog_ground.use_mipfilter            = true
vdi_analog_ground.additive_alpha           = true
vdi_analog_ground.h_clip_relation          = h_clip_relations.COMPARE
vdi_analog_ground.level                    = VDI_DEFAULT_LEVEL
vdi_analog_ground.parent_element	       = "vdi_ground_clip"
Add(vdi_analog_ground)

local vdi_analog_ground 				   = CreateElement "ceTexPoly"
vdi_analog_ground.vertices                 = vdi_vert_gen(4500 ,4000)
vdi_analog_ground.indices                  = {0,1,2,2,3,0}
vdi_analog_ground.tex_coords               = tex_coord_gen(0,1024,1024,1024,2048,2048)
vdi_analog_ground.material                 = basic_vdi_material_dark
vdi_analog_ground.name 			           = create_guid_string()
vdi_analog_ground.init_pos                 = {0, - 4000 / 1500, 0}
vdi_analog_ground.init_rot		           = {0, 0, 0}
vdi_analog_ground.collimated	           = true
vdi_analog_ground.element_params           = {"VDI_ANALOG_GROUND_ENABLE","VDI_ANALOG_GROUND_MOVING"}
vdi_analog_ground.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, 0.1},}
vdi_analog_ground.use_mipfilter            = true
vdi_analog_ground.additive_alpha           = true
vdi_analog_ground.h_clip_relation          = h_clip_relations.COMPARE
vdi_analog_ground.level                    = VDI_DEFAULT_LEVEL
vdi_analog_ground.parent_element	       = "vdi_ground_clip"
Add(vdi_analog_ground)

for i = 1, 12, 1 do
    local x_index
    local y_index = 1
    if i < 4 or i == 12 then
        x_index = - 1
    elseif i < 6 or i == 9 or i == 10 then
        x_index = 0
    else
        x_index = 1
    end
    if i == 3 or i == 6 or i == 11 or i == 12 then
        x_index = x_index * 0.17
        y_index = y_index * 0.03
    elseif i == 4 or i == 5 or i == 9 or i == 10 then
        y_index = y_index * 0.1
    else
        x_index = x_index * 0.133
        y_index = y_index * 0.1
    end
    local vdi_analog_ground                    = CreateElement "ceTexPoly"
    vdi_analog_ground.vertices                 = vdi_vert_gen(1000 , 600, "downcenter")
    vdi_analog_ground.indices                  = {0,1,2,2,3,0}
    vdi_analog_ground.tex_coords               = tex_coord_gen(10,10,300,200,2048,2048)
    vdi_analog_ground.material                 = basic_vdi_material
    vdi_analog_ground.name 			           = create_guid_string()
    vdi_analog_ground.init_pos                 = {0 + x_index / 1.5, 0 - y_index, 0}
    vdi_analog_ground.init_rot		           = {0, 0, 0}
    vdi_analog_ground.collimated	           = true
    vdi_analog_ground.element_params           = {"VDI_ANALOG_GROUND_ENABLE","VDI_ANALOG_CLOUD_MOVING_"..i,"VDI_ANALOG_CLOUD_MOVING_"..i, "VDI_ANALOG_CLOUD_OPAC_"..i}
    vdi_analog_ground.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1, y_index},{"move_left_right_using_parameter",2, x_index}, {"opacity_using_parameter",3}}
    vdi_analog_ground.use_mipfilter            = true
    vdi_analog_ground.additive_alpha           = true
    vdi_analog_ground.h_clip_relation          = h_clip_relations.COMPARE
    vdi_analog_ground.level                    = VDI_DEFAULT_NOCLIP_LEVEL
    vdi_analog_ground.parent_element	       = "vdi_cloud_clip"
Add(vdi_analog_ground)

end 

