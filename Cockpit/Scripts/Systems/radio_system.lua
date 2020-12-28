dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local gettext = require("i_18n")
_ = gettext.translate

local dev 	    = GetSelf()

local update_time_step = 0.02 --update will be called once per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

------Here Strat the general Switch Control

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local uhf_mode_switch = _switch_counter()
local uhf_freq_a = _switch_counter()
local uhf_freq_b = _switch_counter()
local uhf_freq_c = _switch_counter()
local uhf_guard = _switch_counter()
local uhf_volume = _switch_counter()

target_status = {
	{uhf_mode_switch , SWITCH_OFF, get_param_handle("PTN_178"), "PTN_178"},
	{uhf_freq_a , SWITCH_OFF, get_param_handle("PTN_179"), "PTN_179"},
	{uhf_freq_b , SWITCH_OFF, get_param_handle("PTN_180"), "PTN_180"},
	{uhf_freq_c , SWITCH_OFF, get_param_handle("PTN_181"), "PTN_181"},
	{uhf_guard , SWITCH_OFF, get_param_handle("PTN_182"), "PTN_182"},
	{uhf_volume , SWITCH_OFF, get_param_handle("PTN_183"), "PTN_183"},
}

current_status = {
	{uhf_mode_switch , SWITCH_OFF,},
	{uhf_freq_a , SWITCH_OFF,},
	{uhf_freq_b , SWITCH_OFF,},
	{uhf_freq_c , SWITCH_OFF,},
	{uhf_guard , SWITCH_OFF,},
	{uhf_volume , SWITCH_OFF,},
}

local UHF_channel_display = get_param_handle("UHF_DISPLAY")

function post_initialize()

end

UHF_FREQ_TEN = 25
UHF_FREQ_ONE = 6
UHF_FREQ_DIG = 00
UHF_LAST = 0

dev:listen_command(Keys.UHFMode)
dev:listen_command(Keys.UHFVolume)
dev:listen_command(Keys.UHFGuard)
dev:listen_command(Keys.UHFFreqAUP)
dev:listen_command(Keys.UHFFreqADOWN)
dev:listen_command(Keys.UHFFreqBUP)
dev:listen_command(Keys.UHFFreqBDOWN)
dev:listen_command(Keys.UHFFreqCUP)
dev:listen_command(Keys.UHFFreqCDOWN)
dev:listen_command(Keys.UHFFreqASTOP)
dev:listen_command(Keys.UHFFreqBSTOP)
dev:listen_command(Keys.UHFFreqCSTOP)

function SetCommand(command,value)
	if command == Keys.UHFMode then
		if value > 0.5 then
			target_status[uhf_mode_switch][2] = target_status[uhf_mode_switch][2] + 0.5
			if target_status[uhf_mode_switch][2] > 1 then
				target_status[uhf_mode_switch][2] = 1
			end
		else
			target_status[uhf_mode_switch][2] = target_status[uhf_mode_switch][2] - 0.5
			if target_status[uhf_mode_switch][2] < 0 then
				target_status[uhf_mode_switch][2] = 0
			end
		end
	elseif command == Keys.UHFGuard then
		target_status[uhf_guard][2] = 1 - target_status[uhf_guard][2]
		if target_status[uhf_guard][2] == SWITCH_ON then
			UHF_LAST = 5
		else
			UHF_LAST = 0
		end
	elseif command == Keys.UHFVolume then
		if value > 0.5 then
			target_status[uhf_volume][2] = target_status[uhf_volume][2] + 0.05
			if target_status[uhf_volume][2] > 1 then
				target_status[uhf_volume][2] = 1
			end
		else
			target_status[uhf_volume][2] = target_status[uhf_volume][2] - 0.05
			if target_status[uhf_volume][2] < 0 then
				target_status[uhf_volume][2] = 0
			end
		end
	elseif command == Keys.UHFFreqAUP then
		target_status[uhf_freq_a][2] = SWITCH_ON
	elseif command == Keys.UHFFreqADOWN then
		target_status[uhf_freq_a][2] = SWITCH_TEST
	elseif command == Keys.UHFFreqASTOP then
		target_status[uhf_freq_a][2] = SWITCH_OFF
	-- UHF B
	elseif command == Keys.UHFFreqBUP then
		target_status[uhf_freq_b][2] = SWITCH_ON
	elseif command == Keys.UHFFreqBDOWN then
		target_status[uhf_freq_b][2] = SWITCH_TEST
	elseif command == Keys.UHFFreqBSTOP then
		target_status[uhf_freq_b][2] = SWITCH_OFF
	-- UHF C
	elseif command == Keys.UHFFreqCUP then
		target_status[uhf_freq_c][2] = SWITCH_ON
	elseif command == Keys.UHFFreqCDOWN then
		target_status[uhf_freq_c][2] = SWITCH_TEST
	elseif command == Keys.UHFFreqCSTOP then
		target_status[uhf_freq_c][2] = SWITCH_OFF
	end
	-- print_message_to_user("UHF FREQ:"..UHF_FREQ_TEN..UHF_FREQ_ONE.."."..UHF_FREQ_DIG..UHF_LAST)
end

function update_switch_status()
  local switch_moving_step = 0.25
  for k,v in pairs(target_status) do
      if math.abs(target_status[k][2] - current_status[k][2]) < switch_moving_step then
          current_status[k][2] = target_status[k][2]
      elseif target_status[k][2] > current_status[k][2] then
          current_status[k][2] = current_status[k][2] + switch_moving_step
      elseif target_status[k][2] < current_status[k][2] then
          current_status[k][2] = current_status[k][2] - switch_moving_step
      end
      target_status[k][3]:set(current_status[k][2])
      local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
      temp_switch_ref:update()
      -- print_message_to_user(k)
  end
end

ACOUNTER = 0
BCOUNTER = 0
CCOUNTER = 0

function update_UHF_channel()
	if target_status[uhf_freq_a][2] == SWITCH_ON then
		ACOUNTER = ACOUNTER + 1
		if ACOUNTER == 5 then
			if UHF_FREQ_TEN < 40 then
				UHF_FREQ_TEN = UHF_FREQ_TEN + 1
			end
			ACOUNTER = 0
		end
	elseif target_status[uhf_freq_a][2] == SWITCH_OFF then
		ACOUNTER = 0
	elseif target_status[uhf_freq_a][2] == SWITCH_TEST then
		ACOUNTER = ACOUNTER + 1
		if ACOUNTER == 5 then
			if UHF_FREQ_TEN > 20 then
				UHF_FREQ_TEN = UHF_FREQ_TEN - 1
			end
			ACOUNTER = 0
		end
	end

	if target_status[uhf_freq_b][2] == SWITCH_ON then
		BCOUNTER = BCOUNTER + 1
		if BCOUNTER == 5 then
			if UHF_FREQ_ONE < 9 then
				UHF_FREQ_ONE = UHF_FREQ_ONE + 1
			end
			BCOUNTER = 0
		end
	elseif target_status[uhf_freq_b][2] == SWITCH_OFF then
		BCOUNTER = 0
	elseif target_status[uhf_freq_b][2] == SWITCH_TEST then
		BCOUNTER = BCOUNTER + 1
		if BCOUNTER == 5 then
			if UHF_FREQ_ONE > 0 then
				UHF_FREQ_ONE = UHF_FREQ_ONE - 1
			end
			BCOUNTER = 0
		end
	end

	if target_status[uhf_freq_c][2] == SWITCH_ON then
		CCOUNTER = CCOUNTER + 1
		if CCOUNTER == 5 then
			if UHF_FREQ_DIG < 99 then
				UHF_FREQ_DIG = UHF_FREQ_DIG + 1
			end
			CCOUNTER = 0
		end
	elseif target_status[uhf_freq_c][2] == SWITCH_OFF then
		CCOUNTER = 0
	elseif target_status[uhf_freq_c][2] == SWITCH_TEST then
		CCOUNTER = CCOUNTER + 1
		if CCOUNTER == 5 then
			if UHF_FREQ_DIG > 0 then
				UHF_FREQ_DIG = UHF_FREQ_DIG - 1
			end
			CCOUNTER = 0
		end
	end
end

function update()
	
	update_switch_status()
	update_UHF_channel()
	UHF_channel_display:set(string.format("UHF FREQ: %02d%d.%02d%d",UHF_FREQ_TEN,UHF_FREQ_ONE,UHF_FREQ_DIG,UHF_LAST))
end

need_to_be_closed = false -- close lua state after initialization