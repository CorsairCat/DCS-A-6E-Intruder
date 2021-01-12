local FM_dll=nil
-- Test Collision only
local FM_dll= "A-6E_Intruder_FM.dll"
--模组入口
local self_ID = "A-6E" --定义模组名称，全局使用

declare_plugin(self_ID,
{
--基础定义区
installed 	  = true,
displayName   = _("A-6E Intruder"), --模组显示名称
developerName = _("Indigo Simulation"),	--开发组名称
dirName	  	  = current_mod_path,

fileMenuName  = _("A-6E"),
update_id     = "A-6E",
version		  = "0.1.0", --当前迭代版本号   
state		  = "installed",
info		  = _("A-6E is a WIP mod of DCS"), --描述信息
encyclopedia_path = current_mod_path..'/Encyclopedia',
binaries   =
{
    FM_dll
},

Skins	=
	{
		{
			name	= _("A-6E"),
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name	= _("A-6E"),
			dir		= "Missions",
		},
	},
LogBook =
	{
		{
			name	= _("A-6E"),
			type	= "A-6E",
		},
	},
InputProfiles =
	{
		["A-6E"]    = current_mod_path .. '/Input',
	},

})
--------------------------------------------------------------------------------
-- 挂载 3d 模型目录和 贴图 文件目录
mount_vfs_texture_path  (current_mod_path.."/Cockpit/Resources/Model/Textures")
mount_vfs_texture_path  (current_mod_path.."/Cockpit/Textures/CPT_TEX")
-- 挂载 模型
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_model_path	(current_mod_path.."/Shapes/Loads") -- add weapon, pod and tanks

mount_vfs_liveries_path (current_mod_path.."/Liveries")
-- mount_vfs_liveries_path (current_mod_path.."/Theme/ME")
mount_vfs_texture_path  (current_mod_path.."/Theme/ME")
mount_vfs_texture_path  (current_mod_path.."/Textures")
mount_vfs_texture_path  (current_mod_path.."/Textures/A-6E")
mount_vfs_texture_path  (current_mod_path.."/Textures/A-6E-CPT")
mount_vfs_texture_path  (current_mod_path.."/Textures/A-6E-WEAPON")
         
 
---------------------------------------------------------------------------------------
-- Option Cockpit operationnel, HUD partiel
test_susp = {
	{
		wheel_radius         = 0.45,
		
			arg_post             = 0,
			arg_amortizer        = 1,
			arg_wheel_rotation   = 76,
			arg_wheel_yaw        = 2,
			collision_shell_name = "WHEEL_F",
		},
		{
			wheel_radius         = 0.77,
	
			arg_post             = 3,
			arg_amortizer        = 4,
			arg_wheel_rotation   = 77,
			arg_wheel_yaw        = -1,
			collision_shell_name = "WHEEL_L",
		},
		{
			wheel_radius         = 0.77,
	
			arg_post             = 5,
			arg_amortizer        = 6,
			arg_wheel_rotation   = 77,
			arg_wheel_yaw        = -1,
			collision_shell_name = "WHEEL_R",
		},
}

local FM

dofile(current_mod_path.."/suspension.lua")

if FM_dll then
	FM=
	{
		[1] = self_ID,
		[2] = FM_dll,
		center_of_mass = {0, 0, 0},--{5.8784 - 4.572, -0.7883, 0},
		moment_of_inertia = {7000.0, 50000.0, 55000.0, 800},
		suspension = suspension_data,--suspension_data,
	}
else
    FM=nil
end

make_flyable('A-6E', current_mod_path..'/Cockpit/Scripts/', FM, current_mod_path..'/comm.lua')

-- 加载额外lua文件
dofile(current_mod_path.."/A-6E.lua")
--dofile(current_mod_path.."/smoke.lua")

-- 加载视角
dofile(current_mod_path.."/Views.lua")
make_view_settings('A-6E', ViewSettings, SnapViews)


make_aircraft_carrier_capable('A-6E',{"AircraftCarrier","AircraftCarrier With Tramplin","AircraftCarrier With Catapult"})

plugin_done()
