dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev 	    = GetSelf()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local vdi_test_enable = get_param_handle("VDI_ANALOG_DIS_ENABLE")
local vdi_cloud_clip_enable = get_param_handle("VDI_CLOUD_DIS_ENABLE")
local vdi_ground_clip_enable = get_param_handle("VDI_GROUND_DIS_ENABLE")

function update()
    vdi_ground_clip_enable:set(1)
    vdi_cloud_clip_enable:set(1)
    vdi_test_enable:set(1)
end

