-- 这一个文件是全部警告标志

-- 危险文字提示
danger_sign 				        = CreateElement "ceTexPoly"
danger_sign.vertices                = hud_vert_gen(800,400)-- {{-106,125},{106,125},{106,-143},{-106,-143}}
danger_sign.indices                 = {0,1,2,2,3,0}
danger_sign.tex_coords              = tex_coord_gen(455,1050,320,160,2000,2000)
danger_sign.material                = basic_HUD_material
danger_sign.name 			        = create_guid_string()
danger_sign.init_pos                = {0, -0.4, default_hud_z_offset}
danger_sign.init_rot		        = {0, 0, default_hud_rot_offset}
danger_sign.collimated	            = true
danger_sign.element_params          = {"DANGER_FLASH"} --, "D_GUNSIGHT_VISIBLE"
danger_sign.controllers             = {{"opacity_using_parameter",0},}
danger_sign.use_mipfilter           = true
danger_sign.additive_alpha          = true
danger_sign.h_clip_relation         = h_clip_relations.COMPARE
danger_sign.level                   = HUD_DEFAULT_NOCLIP_LEVEL
danger_sign.parent_element	        = "hud_base_clip"
Add(danger_sign)

-- 注意文字提示
warning_sign 				        = CreateElement "ceTexPoly"
warning_sign.vertices               = hud_vert_gen(800,400)-- {{-106,125},{106,125},{106,-143},{-106,-143}}
warning_sign.indices                = {0,1,2,2,3,0}
warning_sign.tex_coords             = tex_coord_gen(455,1260,320,160,2000,2000)
warning_sign.material               = basic_HUD_material
warning_sign.name 			        = create_guid_string()
warning_sign.init_pos               = {0, -0.4, default_hud_z_offset}
warning_sign.init_rot		        = {0, 0, default_hud_rot_offset}
warning_sign.collimated	            = true
warning_sign.element_params         = {"WARNING_FLASH"} --, "D_GUNSIGHT_VISIBLE"
warning_sign.controllers            = {{"opacity_using_parameter",0},}
warning_sign.use_mipfilter          = true
warning_sign.additive_alpha         = true
warning_sign.h_clip_relation        = h_clip_relations.COMPARE
warning_sign.level                  = HUD_DEFAULT_NOCLIP_LEVEL
warning_sign.parent_element	        = "hud_base_clip"
Add(warning_sign)

-- X形状提示
no_permission_sign 				            = CreateElement "ceTexPoly"
no_permission_sign.vertices                 = hud_vert_gen(2400,2400)-- {{-106,125},{106,125},{106,-143},{-106,-143}}
no_permission_sign.indices                  = {0,1,2,2,3,0}
no_permission_sign.tex_coords               = tex_coord_gen(1290,1020,445,445,2000,2000)
no_permission_sign.material                 = basic_HUD_material
no_permission_sign.name 			        = create_guid_string()
no_permission_sign.init_pos                 = {0, 0, default_hud_z_offset}
no_permission_sign.init_rot		            = {0, 0, default_hud_rot_offset}
no_permission_sign.collimated	            = true
no_permission_sign.element_params           = {"PULLUP_FLASH"} --, "D_GUNSIGHT_VISIBLE"
no_permission_sign.controllers              = {{"opacity_using_parameter",0},}
no_permission_sign.use_mipfilter            = true
no_permission_sign.additive_alpha           = true
no_permission_sign.h_clip_relation          = h_clip_relations.COMPARE
no_permission_sign.level                    = HUD_DEFAULT_NOCLIP_LEVEL
no_permission_sign.parent_element	        = "hud_base_clip"
Add(no_permission_sign)