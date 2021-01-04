dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 0.02
make_default_activity(update_time_step) -- enables call to update

local sensor_data = get_base_data()

dev:listen_command(Keys.NoseWheelSteeringOn)
dev:listen_command(Keys.NoseWheelSteeringOff)

IS_STEERING_MODE = 0

local ngear_pos_ind = get_param_handle("NoseWPOS_IND")

function post_initialize()
	dispatch_action(nil, 606, nil)
end

function SetCommand(command, value)
	if command == Keys.NoseWheelSteeringOn then
		IS_STEERING_MODE = 1
		dispatch_action(nil, 562, nil)
	elseif command == Keys.NoseWheelSteeringOff then
		IS_STEERING_MODE = 0
		dispatch_action(nil, 606, nil)
	end
	
end

function update()
	--Test set anim argument

	local ROLL_STATE = sensor_data:getStickPitchPosition() / 100
	set_aircraft_draw_argument_value(11, ROLL_STATE) -- right aileron
    set_aircraft_draw_argument_value(12, -ROLL_STATE) -- left aileron
    --set_aircraft_draw_argument_value(9, ROLL_STATE) -- right slat
	--set_aircraft_draw_argument_value(10, -ROLL_STATE) -- left slat
	

	local PITCH_STATE = sensor_data:getStickRollPosition() / 100
	set_aircraft_draw_argument_value(15, PITCH_STATE) -- right canard
	set_aircraft_draw_argument_value(16, PITCH_STATE) -- left canard

	local RUDDER_STATE = sensor_data:getRudderPosition() / 100
    set_aircraft_draw_argument_value(17, -RUDDER_STATE)
    set_aircraft_draw_argument_value(18, -RUDDER_STATE)
	
	-- add nose wheel steering mode
	local nose_wheel_target = -RUDDER_STATE
	local rudder_step = 0.05
	local rudder_current = get_aircraft_draw_argument_value(2)
	if IS_STEERING_MODE == 1 and ngear_pos_ind:get() >= 0.7 then
		if (get_aircraft_draw_argument_value(0) > 0.7) then
			if math.abs(rudder_current - nose_wheel_target) < rudder_step then
				set_aircraft_draw_argument_value(2, nose_wheel_target)
			else
				if rudder_current < nose_wheel_target then
					set_aircraft_draw_argument_value(2, rudder_current + rudder_step)
				elseif rudder_current > nose_wheel_target then
					set_aircraft_draw_argument_value(2, rudder_current - rudder_step)
				end
			end
		else
			set_aircraft_draw_argument_value(2, 0)
		end
	end
	--print(ROLL_STATE)
	--print(PITCH_STATE)
end

need_to_be_closed = false -- close lua state after initialization