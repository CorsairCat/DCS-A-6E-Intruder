dofile(LockOn_Options.script_path.."TEST/Indicator/def.lua") --所有页面都包含这个描述文件

--全部包含的参数，似乎是定义一个遮罩
local SHOW_MASKS = true

-- 下面这个total_field_of_view为全包含的内容，但是关于是否显示有区别

total_field_of_view 				= CreateElement "ceMeshPoly"
-- 名称(似乎是视口)
total_field_of_view.name 			= "total_field_of_view"
-- 长方形
total_field_of_view.primitivetype 	= "triangles"
-- 顶点？似乎符合，为四个键，对应四个角（似乎:第二象限->第一->第四->第三，顺时针）
total_field_of_view.vertices 		=  {{-1,1},{1,1},{1,-1},{-1,-1}}
-- index？主键？
total_field_of_view.indices			=  {0,1,2,0,2,3}
-- 初始化位置？结构{0,0,0}?相对center的位置？
total_field_of_view.init_pos		= {0, 0, z_offset}
-- 定义材质，稍后确定
-- materials["RADAR_FOV"] 	= {17,80,7,20}
total_field_of_view.material		= "TEST_MATERIAL"
-- 层级
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
-- 定义层级
total_field_of_view.level			= TEST_DEFAULT_LEVEL
-- 这两个均一致，被设置为否
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= false
-- 这个是否可见两者有区别：a4可见，jf17默认不可见
total_field_of_view.isvisible		= SHOW_MASKS
-- 添加元素
Add(total_field_of_view)