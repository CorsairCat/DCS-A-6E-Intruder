dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua") -- 加载材质

-- set panel
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

creators  = {}

creators[devices.ELECTRIC_SYSTEM] ={"avSimpleElectricSystem",LockOn_Options.script_path.."Systems/electric_system.lua"}
creators[devices.HYDRAULIC_SYSTEM]={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/hydraulic_system.lua"}
creators[devices.ENGINE]          ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/engine.lua"}
creators[devices.PRISURFACE]      ={"avLuaDevice"           ,LockOn_Options.script_path.."priControlSurface.lua"}
creators[devices.CANOPY]          ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/canopy.lua"}
creators[devices.GEAR_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/gear_system.lua"}
creators[devices.SLAT_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/slat_system.lua"}
creators[devices.BREAK_SYSTEM]    ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/break_system.lua"}
creators[devices.WEAPON_SYSTEM]	  ={"avSimpleWeaponSystem"  ,LockOn_Options.script_path.."Systems/weapon_system.lua"}
creators[devices.FLAP_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/flap_system.lua"}
creators[devices.INTERCOM]        ={"avIntercom"            ,LockOn_Options.script_path.."Intercom.lua", {devices.UHF_RADIO} }
creators[devices.UHF_RADIO]       ={"avUHF_ARC_164"         ,LockOn_Options.script_path.."uhf_radio.lua", {devices.INTERCOM, devices.ELECTRIC_SYSTEM} }
creators[devices.RADAR_RAW]		  ={"avSimpleRadar"			,LockOn_Options.script_path.."avRadar/Device/Radar_init.lua"}
creators[devices.HUD_DCMS]        ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/dcms_hud.lua"}
creators[devices.BASIC_FLIGHT_INS]={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/basic_flight_instru.lua"}
creators[devices.CLOCK]           ={"avLuaDevice"           ,LockOn_Options.script_path.."aviation_clock.lua"}
creators[devices.FUEL_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/fuel_system.lua"}
creators[devices.VDI_DCMS]        ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/dcms_vdi.lua"}
creators[devices.LIGHT_SYSTEM]    ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/light_system.lua"}

-- Indicators
indicators = {}
-- indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."TEST/Indicator/init.lua",nil,{{"main_screen_center","main_screen_down","main_screen_right"}}} --测试屏幕
-- MFD
-- indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD/Indicator/init.lua",nil,{{"main_screen_center","main_screen_down","main_screen_right"}}} --MFD
-- MFCD
-- indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFCD/Indicator/mfcd_init.lua",nil,{{"main_screen_center","main_screen_down","main_screen_right"}}}
-- HUD
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HUD/Indicator/hud_init.lua",nil,{{"HUD_center","HUD_down","HUD_right"}}}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."VDI/vdi_init.lua",nil,{{"VDI_center","VDI_down","VDI_right"}}}
-- RADAR RAW DISPLAY
-- indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."avRadar/indicator/init.lua",nil,{{},{sz_l = 0.0,sx_l = -0.50, sy_l = -0.1},1}}		
--RADAROFF indicators[#indicators + 1] = {"ccIndicator",LockOn_Options.script_path.."RADAR/Indicator/init.lua",--init script 初始化脚本
--RADAROFF   nil,--id of parent device  --父设备从属
--RADAROFF   {
--RADAROFF 	{}, -- initial geometry anchor , triple of connector names 初始化三个连接器
--RADAROFF 	{sx_l =  0,  -- center position correction in meters (forward , backward)1
--RADAROFF 	 sy_l =  0,  -- center position correction in meters (up , down)
--RADAROFF 	 sz_l =  0.3,  -- center position correction in meters (left , right)
--RADAROFF 	 sh   =  0,  -- half height correction
--RADAROFF 	 sw   =  0,  -- half width correction
--RADAROFF 	 rz_l =  0,  -- rotation corrections
--RADAROFF 	 rx_l =  0,
--RADAROFF 	 ry_l =  0}
--RADAROFF   } -- 这些是屏幕矫正数据
--RADAROFF } --RADAR