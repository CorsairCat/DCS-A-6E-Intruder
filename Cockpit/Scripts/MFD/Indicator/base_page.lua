dofile(LockOn_Options.script_path.."MFD/Indicator/def.lua") --所有页面都包含这个描述文件

local MAIN_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/MFD/"  --定义屏幕贴图路径
local main_glass_material       = MakeMaterial(MAIN_IND_TEX_PATH.."MFD_glass.dds", {0,100,0,100})

-- 这个是最上面的总仪表裁剪层
main_screen_clip 			 	= CreateElement "ceMeshPoly" --这个似乎是一个透明度模式
main_screen_clip.name 			= "main_screen_clip"
main_screen_clip.vertices 		= {{-428,132},{420,132},{420,-137},{-428,-137}} --四个边角
main_screen_clip.indices 		= {0,1,2,0,2,3}
main_screen_clip.init_pos		= {0, 0, 0}
main_screen_clip.init_rot		= {0, 0, 0}
main_screen_clip.material		= "DBG_GREY"
main_screen_clip.h_clip_relation= h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
main_screen_clip.level			= MFD_DEFAULT_NOCLIP_LEVEL
main_screen_clip.isdraw		    = true
main_screen_clip.change_opacity = false
main_screen_clip.element_params = {"MAIN_DIS_ENABLE"}              -- 初始化主显示控制
main_screen_clip.controllers    = {{"opacity_using_parameter",0}}
main_screen_clip.isvisible		= true
Add(main_screen_clip)

-- 这里似乎分页加载有一定的问题，所以放在同一个页面集里管理（用dofile的模式）
-- 这个dofile主要是为了方便代码管理，一个模块用一个脚本处理
-- 加载基础页面
dofile(LockOn_Options.script_path.."MFD/Indicator/basic_page.lua")
-- 加载武器挂载和选择页面
dofile(LockOn_Options.script_path.."MFD/Indicator/weapon_page.lua")