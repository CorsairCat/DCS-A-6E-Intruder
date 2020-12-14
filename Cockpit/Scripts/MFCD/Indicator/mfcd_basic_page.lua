function generateBasicPageControl(inputtable)
	-- local current_enable_parameter = "ADI_PAGE_ENABLE" --用通用前缀生成当前的页面控制
    table.insert(inputtable,1,{"opacity_using_parameter",0})
	return inputtable
end

function generateBasicPageParams(inputtable)
    local current_enable_parameter = "ADI_PAGE_ENABLE" --用通用前缀生成当前的页面控制
	table.insert(inputtable, 1, current_enable_parameter)
	return inputtable
end

function addBasicPageElement(object)
    if object.element_params == nil then
        local temp_params = {}
    else
        local temp_params = object.element_params
    end
    if object.controllers == nil then
        local temp_control = {}
    else
        local temp_control = object.controllers
    end
    object.element_params = generateBasicPageParams(temp_params)
    object.controllers = generateBasicPageControl(temp_control)
    if object.isvisible == nil then
        object.isvisible	= true
    end
    object.isdraw		    = true
    object.use_mipfilter	= true
    object.additive_alpha	= true
    object.collimated		= false
    Add(object)
end

-- 105 870
-- 680 720

-- ADI框
local ADI_ball_cell 				    = CreateElement "ceTexPoly"
ADI_ball_cell.vertices                  = hud_vert_gen(1500,1588)
ADI_ball_cell.indices                   = {0,1,2,2,3,0}
ADI_ball_cell.tex_coords                = tex_coord_gen(105,870,680,720,2000,2000)
ADI_ball_cell.material                  = white_MFCD_material
ADI_ball_cell.name 			            = create_guid_string()
ADI_ball_cell.init_pos                  = { - 2000 / default_mfcd_x, 200 / default_mfcd_y, 0}
ADI_ball_cell.init_rot		            = {0, 0, 0}
ADI_ball_cell.collimated	            = true
ADI_ball_cell.use_mipfilter             = true
ADI_ball_cell.additive_alpha            = true
ADI_ball_cell.h_clip_relation           = h_clip_relations.COMPARE
ADI_ball_cell.level                     = MFCD_DEFAULT_NOCLIP_LEVEL
ADI_ball_cell.parent_element	        = "mfcd_base_clip"
addBasicPageElement(ADI_ball_cell)

local border 				     = CreateElement "ceTexPoly"
border.vertices                  = hud_vert_gen(10, 3000)
border.indices                   = {0,1,2,2,3,0}
border.tex_coords                = tex_coord_gen(35,982,2,2,2000,2000)
border.material                  = white_MFCD_material
border.name 			         = create_guid_string()
border.init_pos                  = {-1000 / default_mfcd_x, 0, 0}
border.init_rot		             = {0, 0, 0}
border.collimated	             = true
border.use_mipfilter             = true
border.additive_alpha            = true
border.h_clip_relation           = h_clip_relations.COMPARE
border.level                     = MFCD_DEFAULT_NOCLIP_LEVEL
border.parent_element	         = "mfcd_base_clip"
addBasicPageElement(border)

local border 				     = CreateElement "ceTexPoly"
border.vertices                  = hud_vert_gen(10, 3000)
border.indices                   = {0,1,2,2,3,0}
border.tex_coords                = tex_coord_gen(35,982,2,2,2000,2000)
border.material                  = white_MFCD_material
border.name 			         = create_guid_string()
border.init_pos                  = {-3000 / default_mfcd_x, 0, 0}
border.init_rot		             = {0, 0, 0}
border.collimated	             = true
border.use_mipfilter             = true
border.additive_alpha            = true
border.h_clip_relation           = h_clip_relations.COMPARE
border.level                     = MFCD_DEFAULT_NOCLIP_LEVEL
border.parent_element	         = "mfcd_base_clip"
addBasicPageElement(border)