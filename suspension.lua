suspension_data = 
{
	{
		mass  			  = 200,
		pos   			  = { 6.157,  -3.394 - 0.225,   0},
		moment_of_inertia = {1000,1000,1000},
		
		
		damage_element	    = 83,
		-- (deg?) Speed threshold of jamming during impact of rotation limiter
		damage_omega	    = 30.0, 
		-- (deg?) Designed angle of retracted gear with horizontal axis
		state_angle_0	    =  6.13, 
		-- (deg?) Designed angle of extended gear with verrtical axis
		state_angle_1	    = - 3, 
		-- (m) attachment point to fuselage along x-axis
		mount_pivot_x	    = - 0.274,
		-- (m) attachment point to fuselage along y axis
		mount_pivot_y	    = - 0.118,
		-- (m) distance from strut-axis to attachment point of piston to gear stand
		mount_post_radius   = 0.657,
		-- (m) length of angle brace in retracted position
		mount_length	   	= 0.604555117,
		-- (deg?) length of position vector from attachment point
		mount_angle_1	   	= -3.138548523,
		-- (m) distance from rotation-axis of strut to wheel-axis
		post_length	   		= 1.748,
		-- (m) displacement of wheel relative to strut
		wheel_axle_offset 	= 0.05,
		-- Gear is self oriented
		self_attitude	    = true,
		yaw_limit		    = math.rad(89.0),
		damper_coeff	    = 30.0,
		

		amortizer_min_length					= 0.0,
		amortizer_max_length					= 3.11 - 3.394,
		amortizer_basic_length					= 3.25 - 3.394,
		amortizer_spring_force_factor			= 1.6e+13,
		amortizer_spring_force_factor_rate		= 20.0,
		amortizer_static_force					= 80000.0,
		amortizer_reduce_length					= 3.11 - 3.394,
		amortizer_direct_damper_force_factor	= 45000.0,
		amortizer_back_damper_force_factor		= 15000.0,


		wheel_radius				  = 0.45,
		wheel_static_friction_factor  = 0.65 , --Static friction when wheel is not moving (fully braked)
		wheel_side_friction_factor    = 0.65 ,
		wheel_roll_friction_factor    = 0.025, -- Rolling friction factor when wheel moving
		wheel_glide_friction_factor   = 0.28 , -- Sliding aircraft
		wheel_damage_force_factor     = 250.0, -- Tire is explosing due to hard landing
		wheel_damage_speed			  = 150.0, -- Tire burst due to excessive speed


		wheel_moment_of_inertia   = 3.6, --wheel moi as rotation body

		wheel_brake_moment_max = 15000.0, -- maximum value of braking moment  , N*m 
		
		--[[
		args_post	  = {0,3,5};
		args_amortizer = {1,4,6};
		args_wheel	  = {76,77,77};
		args_wheel_yaw = {2,-1,-1};
		--]]

		arg_post             = 0,
		arg_amortizer        = 1,
		arg_wheel_rotation   = 76,
		arg_wheel_yaw        = 2,
		collision_shell_name = "WHEEL_F",
	},
	{
		mass  			  = 200,
		pos   			  = { 0.856,  -3.226 - 0.385,  -1.839},
		moment_of_inertia = {1000,1000,1000},
		
		
		damage_element	    = 83,
		damage_omega	    = 30.0,
		state_angle_0	    =  6.131341662,
		state_angle_1	    = -2.995164152,
		mount_pivot_x	    =  0.865,
		mount_pivot_y	    = -0.118,
		mount_post_radius   = 0.657,
		mount_length	   	= 0.604555117,
		mount_angle_1	   	= -3.138548523,
		post_length	   		= 1.748,
		wheel_axle_offset 	= 0.05,
		self_attitude	    = false,
		yaw_limit		    = math.rad(89.0),
		damper_coeff	    = 30.0,
		

		amortizer_min_length					= 0.0,
		amortizer_max_length					= 2.791 - 3.226,
		amortizer_basic_length					= 2.885 - 3.226,
		amortizer_spring_force_factor			= 1.6e+13,
		amortizer_spring_force_factor_rate		= 17.0,
		amortizer_static_force					= 25000.0,
		amortizer_reduce_length					= 2.791 - 3.226,
		amortizer_direct_damper_force_factor	= 65000.0,
		amortizer_back_damper_force_factor		= 10000.0,


		wheel_radius				  = 0.77 ,
		wheel_static_friction_factor  = 0.65 ,
		wheel_side_friction_factor    = 0.65 ,
		wheel_roll_friction_factor    = 0.025,
		wheel_glide_friction_factor   = 0.28 ,
		wheel_damage_force_factor     = 650.0,
		wheel_damage_speed			  = 150.0,
		wheel_moment_of_inertia   = 3.6, --wheel moi as rotation body

		wheel_brake_moment_max = 15000.0, -- maximum value of braking moment  , N*m 
		
		--[[
		args_post	  = {0,3,5};
		args_amortizer = {1,4,6};
		args_wheel	  = {76,77,77};
		args_wheel_yaw = {2,-1,-1};
		--]]

		arg_post             = 3,
		arg_amortizer        = 4,
		arg_wheel_rotation   = 77,
		arg_wheel_yaw        = -1,
		collision_shell_name = "WHEEL_L",
	},
	{
		mass  			  = 200,
		pos   			  = { 0.856,  -3.226 - 0.385,   1.839},
		moment_of_inertia = {1000,1000,1000},
		
		
		damage_element	    = 83,
		damage_omega	    = 30.0,
		state_angle_0	    =  6.131341662,
		state_angle_1	    = -2.995164152,
		mount_pivot_x	    =  0.865,
		mount_pivot_y	    = -0.118,
		mount_post_radius   = 0.657,
		mount_length	   	= 0.604555117,
		mount_angle_1	   	= -3.138548523,
		post_length	   		= 1.748,
		wheel_axle_offset 	= 0.05,
		self_attitude	    = false,
		yaw_limit		    = math.rad(89.0),
		damper_coeff	    = 30.0,
		

		amortizer_min_length					= 0.0,
		amortizer_max_length					= 2.791 - 3.226,
		amortizer_basic_length					= 2.885 - 3.226,
		amortizer_spring_force_factor			= 1.6e+13,
		amortizer_spring_force_factor_rate		= 17.0,
		amortizer_static_force					= 25000.0,
		amortizer_reduce_length					= 2.791 - 3.226,
		amortizer_direct_damper_force_factor	= 65000.0,
		amortizer_back_damper_force_factor		= 10000.0,


		wheel_radius				  = 0.77 ,
		wheel_static_friction_factor  = 0.65 ,
		wheel_side_friction_factor    = 0.65 ,
		wheel_roll_friction_factor    = 0.025,
		wheel_glide_friction_factor   = 0.28 ,
		wheel_damage_force_factor     = 650.0,
		wheel_damage_speed			   = 150.0,
		 wheel_moment_of_inertia   = 3.6, --wheel moi as rotation body

		 wheel_brake_moment_max = 15000.0, -- maximum value of braking moment  , N*m 
		
		--[[
		args_post	  = {0,3,5};
		args_amortizer = {1,4,6};
		args_wheel	  = {101,102,103};
		args_wheel_yaw = {2,-1,-1};
		--]]

		arg_post             = 5,
		arg_amortizer        = 6,
		arg_wheel_rotation   = 77,
		arg_wheel_yaw        = -1,
		collision_shell_name = "WHEEL_R",
	},
}