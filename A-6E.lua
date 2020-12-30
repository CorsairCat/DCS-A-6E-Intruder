--dofile(current_mod_path .. "/sensors.lua")
local BD3 = function(clsid)
return {CLSID = clsid, arg_value = 0.15}
end
local MBD = function(clsid)
return {CLSID = clsid, arg_value = 0.25}
end
pl_cat = function(clsid, name)
local res = {}
res.CLSID = clsid
res.Name = name
return res
end

A_6e = {
	Name = "A-6E",
	DisplayName = _("A-6E"),
	ViewSettings        = ViewSettings,
	-- 为所有国家启用A-6E
	Countries = {"Abkhazia","Australia","Austria","Belarus","Belgium","Brazil","Bulgaria","Canada","China","Croatia",
                 "Czech Republic","Denmark","Egypt","Finland","France","Georgia","Germany","Greece","Hungary",
                 "India","Insurgents","Iran","Iraq","Israel","Italy","Japan","Kazakhstan","The Netherlands","North Korea",
                 "Norway","Pakistan","Poland","Romania","Russia","Saudi Arabia","Serbia","Slovakia","South Korea",
                 "South Ossetia","Spain","Sweden","Switzerland","Syria","Turkey","UK","Ukraine","USA","USAF Aggressors"},
	HumanCockpit        = false,
	HumanCockpitPath    = current_mod_path..'/Cockpit/',

	Picture 			= "A-6E.png", 
	Rate 				= 50,
	Shape 				= "A-6E", 

	shape_table_data = {
		{
			file 	= 	"A-6E";
			life 	= 	18; 
			vis 	= 	3;
			desrt 	= 	"A-6E-oblomok"; 
			fire 	= 	{300, 2};
			username= 	"A-6E"; 
			index   =  WSTYPE_PLACEHOLDER;
			classname 	= "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			-- using outer destory model
			name = "A-6E-oblomok";
			file = "A-6E-oblomok";
			fire = {240, 2};
		}

	},
	----外部动画描述
	-- 限制32个动画
	net_animation = {
        0, -- front gear
        3, -- right gear
		5, -- left gear
		8, --wing folding
        9, -- right flap
        10, -- left flap
        11, -- right aileron
        12, -- left aileron
        15, -- right elevator
        16, -- left elevator
        17, -- rudder

		85, -- tow link

        2,  -- nose wheel steering
        21, -- SFM air brake
        13, -- right slat
        14, -- left slat
        25, -- tail hook
        38, -- canopy
        120, -- right spoiler
        123, -- left spoiler
        190, -- left (red) navigation wing-tip light
        191, -- right (green) navigation wing-tip light
        192, -- tail (white) light

		--198, -- anticollision (flashing red) top light
		--85, -- captsual launch bar
        83, -- anticollision (flashing red) bottom light
        51, -- taxi light (white) right main gear door
        402, -- huffer
        500, -- model air brake
        501, -- RAT
        499, -- wheel chocks
	},

	mapclasskey = "P0091000024", 
	attribute = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Fighters", "Refuelable"},
	Categories = {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",}, 

	M_empty 			= 12836, --14500, --空重
	M_nominal 			= 25000, --23000, 
	M_max 				= 29000, --最大重量
	M_fuel_max 			= 7230,  --9400, --最大燃油重量
	H_max 				= 12900, --最大高度
	-------------------------
	length 				= 16.733, --长度（m)
	height 				= 4.938, --高度（m）
	wing_area 			= 49.14,	--机翼面积
	wing_span 			= 16.154, 	--机翼跨度
	wing_tip_pos 		= {-0.983, -0.809, 8.138},  --机翼坐标（前后 上下 左右）
	wing_type 			= 0, 	--机翼类型
	flaps_maneuver 		= 1.0, 	--起飞时最大襟翼(0.5为一级，1.0为两级)(仅AI使用此参数)
	has_speedbrake 		= true, --有空气刹车

	RCS					= 4.0, --正面雷达反射面积（m2）F16的标准截面积为4.0
	IR_emission_coeff	= 1, --红外发射系数（无加力）
	IR_emission_coeff_ab= 1, --红外发射系数（加力）

	stores_number 		= 5, --挂架数量

	CAS_min 			= 58, 
	V_opt 				= 211.944,
 	V_take_off 			= 64, --67, --离地速度AI（m/s)
 	V_land 				= 64, --63, --着陆速度AI（m/s)
 	V_max_sea_level 	= 288.89, --最大海平面速度AI（m/s)
 	V_max_h 			= 205.778, --最大高度速度AI（m/s)
	Vy_max 				= 38.7, 
 	Mach_max 			= 0.92, --最大马赫数AI
 	Ny_min 				= -2.4,--最小过载AI
 	Ny_max 				= 6.5, --最大过载AI
 	Ny_max_e 			= 7,
 	AOA_take_off 		= 0.15, 
	bank_angle_max 		= 45,
	range 				= 5291, --航程AI
	
	thrust_sum_max 				= 7892, --推力最大值（千牛）//注意：此处单位被标记为kg
	has_afteburner 				= false,
	has_differential_stabilizer = false,
	--thrust_sum_ab 				= 7892,
	average_fuel_consumption 	= 0.214, --0.208,
	is_tanker 					= false,
	tanker_type 				= 3,
	air_refuel_receptacle_pos 	= {0, 0, 0},

	nose_gear_pos 			    = { 6.157,  -3.394 - 0.225,   0},--前起落架坐标（前后 上下 左右）
	main_gear_pos 			    = { 0.856,  -3.226 - 0.385,   1.839},--主起落架坐标（前后 上下 左右）
	tand_gear_max 				= 1.963, --前轮最大旋转角度的tan值

	nose_gear_wheel_diameter 	= 0.45,--前机轮直径（m)
	main_gear_wheel_diameter 	= 0.77,--主机轮直径（m）
	brakeshute_name 			= 4, 

	nose_gear_amortizer_direct_stroke			=  3.394 - 3.394,
	nose_gear_amortizer_reversal_stroke			=  3.11 - 3.394,
	nose_gear_amortizer_normal_weight_stroke	=  3.25 - 3.394,	

	main_gear_amortizer_direct_stroke			=  3.226 - 3.226,		
	main_gear_amortizer_reversal_stroke			=  2.791 - 3.226, 		
	main_gear_amortizer_normal_weight_stroke	=  2.885 - 3.226,		

	launch_bar_connected_arg_value = 0.95 ,

	engines_count	=	2,--发动机数量
	engines_nozzles = 
	{
		[1] = 
		{
			pos 		=  {-0.927, -1.159, 1.159}, --右发坐标
			elevation   =  0,  
			diameter	 = 0.5,  --马赫环直径
			exhaust_length_ab   = 2, 
			exhaust_length_ab_K = 0.3, 
			smokiness_level = 0.3,--烟
		}, 
        [2] = 
		{
			pos 		=  {-0.927, -1.159, -1.159}, --左发坐标
			elevation   =  0,  
			diameter	 = 0.5,  --马赫环直径
			exhaust_length_ab   = 2, 
			exhaust_length_ab_K = 0.3, 
			smokiness_level = 0.3,--烟
		}, 
	},

	crew_size	= 2,
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name	= "A-6E_ejectionseat", -- not done
			drop_canopy_name	= "A-6E-fragment-canopy-glass", --not done
			pos					= {4.768, -0.455, -0.5},
			canopy_pos			= {2.677, 2.677, 0},
			g_suit 			    =  6
		}, -- end of [1]

		[2] = 
		{
			ejection_seat_name	= "A-6E_ejectionseat", -- not done
			drop_canopy_name	= "A-6E-fragment-canopy-glass", --not done
			pos					= {4.768, -0.455, 0.5},
			canopy_pos			= {2.677, 2.677, 0},
			g_suit 			    =  6
		}, -- end of [1]
	}, -- end of crew_members
		
	--[[
			mechanimations = {
		LaunchBar = {
			{Transition = {"Retract", "Extend"}, Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "to", 0.881, "in", 4.4}}}}},
			--{Transition = {"Extend", "Retract"}, Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.5}}}}},
			{Transition = {"Retract", "Stage"},  Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "to", 0.815, "in", 4.4}}}}},
			--{Transition = {"Stage", "Retract"},  Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.5}}}}},
			{Transition = {"Any", "Retract"},  Sequence = {{C = {{"ChangeDriveTo", "Hydraulic"}, {"VelType", 2}, {"Arg", 85, "to", 0.000, "in", 4.5}}}}},
			{Transition = {"Extend", "Stage"},   Sequence = {
					{C = {{"ChangeDriveTo", "Mechanical"}, {"Sleep", "for", 0.000}}},
					{C = {{"Arg", 85, "from", 0.881, "to", 0.766, "in", 0.600}}},
					{C = {{"Arg", 85, "from", 0.766, "to", 0.753, "in", 0.200}}},
					{C = {{"Sleep", "for", 0.15}}},
					--{C = {{"Sleep", "for", 0.150}}},
					{C = {{"Arg", 85, "from", 0.753, "to", 0.784, "in", 0.1, "sign", 2}}},
					{C = {{"Arg", 85, "from", 0.784, "to", 0.881, "in", 1.0}}},
					--{C = {{"PosType", 6}, {"Sleep", "for", 3.3}}},
					--{C = {{"Arg", 85, "from", 0.854, "to", 0.815, "in", 1.25}}},
				},
			},
			{Transition = {"Stage", "Pull"},  Sequence = {
					{C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85,"from", 0.881, "to", 0.95, "in", 0.15}}},
					{C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", 0.78, "speed", 0.1}}},
					{C = {{"ChangeDriveTo", "Mechanical"}, {"VelType", 2}, {"Arg", 85, "to", 0.7792, "speed", 0.02}}},
					}
			},
			{Transition = {"Stage", "Extend"},   Sequence = {{C = {{"ChangeDriveTo", "HydraulicGravityAssisted"}, {"VelType", 3}, {"Arg", 85, "from", 0.815, "to", 0.881, "in", 0.2}}}}},
		},
	},
	]]

	LandRWCategories =
    {
        [1] =
        {
            Name = "AircraftCarrier",
        }, -- end of [1]
    }, -- end of LandRWCategories

    TakeOffRWCategories =
    {
        [1] =
        {
            Name = "AircraftCarrier With Catapult",
        }, -- end of [1]
    }, -- end of TakeOffRWCategories
		
	fires_pos = 
	{
		[1] = 	{-3.484, -1.004, -0.149}, 
		[2] = 	{-2.518,  -1.055,  1.216}, 
		[3] = 	{-2.518, -1.055, -1.216}, 
		[4] = 	{-6.250,  -0.525,  0.000}, 
		[5] = 	{-6.750,  -0.525,  0.000}, 
		[6] = 	{-2.346, -1.448,  0.000}, 
		[7] = 	{ 2.346, -1.448,  0.000}, 
	},

	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 192, 
		chaff = {default = 112, increment = 3, chargeSz = 1}, 
		flare = {default = 80, increment = 3, chargeSz = 1},
	}, 
	chaff_flare_dispenser 	= {
		{ dir =  {0, 1, 0}, pos =  {-6.227,  -0.535, -1.60}, }, -- Chaff L
		{ dir =  {0, 1, 0}, pos =  {-6.227,  -0.535,  1.60}, },  -- Chaff R
		{ dir =  {0, 1, 0}, pos =  {-7.062,  -0.373, -1.60}, }, -- Flares L
		{ dir =  {0, 1, 0}, pos =  {-7.062,  -0.373,  1.60}, }, -- Flares R
	},

--
	detection_range_max 		= 450, 
	radar_can_see_ground		= true,
	--CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	CanopyGeometry = {
        azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
        elevation = {-50.0, 90.0} -- pilot view vertical (AI)
    },
	Sensors = {
		RWR = "Abstract RWR", 
		RADAR = "N-019", -- Radar type
		OPTIC = {"TADS DTV", "TADS DVO", "TADS FLIR", "GD-20"}, 
		IRST = "HW-20"
	}, 
	Countermeasures = {
		ECM = "AN/ALQ-148"
	},

	HumanRadio = {
		frequency = 127.5, 
		modulation = MODULATION_AM
	}, 

	WorldID = WSTYPE_PLACEHOLDER,
	--mech_timing = {{0, 0.074, 0.11, 0.14}, {0, 0.18, 0.89, 0.074}}, 

	
	--pylons_enumeration = {10, 1, 9, 2, 3, 8, 4, 7, 6, 5}, 
	-- pylons_enumeration = {2, 1,3}, 

	stores_number = 5, 

	Pylons = {
		pylon(1, 1,  -0.000000, -0.000000, -0.00000,
			{
				use_full_connector_position = true, connector = "Pylon1", arg = 501, arg_value = 1,
			},
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --aim 9M
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --Aim 9X
				{ CLSID = "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}" }, -- AERO-1D 300-GAL Fuel Tank
            }
        ),
		pylon(2, 1,  -0.000000, -0.00000, -0.00000,
			{
				use_full_connector_position = true, connector = "Pylon2", arg = 502, arg_value = 0,
			},
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --aim 9M
                { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --Aim 9X
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM_120C
				{ CLSID = "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}" }, -- AERO-1D 300-GAL Fuel Tank
            }
        ),
		pylon(3, 1, -0.000000, -0.00000, -0.00000,
			{
				use_full_connector_position = true, connector = "Pylon3", arg = 503, arg_value = 0,
			},
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --aim 9M
                { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --Aim 9X
				-- { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM_120C
				{ CLSID = "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}" }, -- AERO-1D 300-GAL Fuel Tank
            }
        ),
		pylon(4, 1, -0.000000, -0.000000, -0.00000,
			{
				use_full_connector_position = true, connector = "Pylon4", arg = 504, arg_value = 0,
			},
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --aim 9M
                { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --Aim 9X
				-- { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM_120C
				{ CLSID = "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}" }, -- AERO-1D 300-GAL Fuel Tank
            }
        ),
		pylon(5, 1, 0.000000, 0.00000, 0.00000,
			{
				use_full_connector_position = true, connector = "Pylon5", arg = 505, arg_value = 0,
			},
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --aim 9M
                { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --Aim 9X
				-- { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM_120C
				{ CLSID = "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}" }, -- AERO-1D 300-GAL Fuel Tank
            }
        ),
	},
	


-------------------------------------------------------------------------------------------
	Tasks = {
		aircraft_task(CAP),
		aircraft_task(Intercept), 
		aircraft_task(Escort), 
		aircraft_task(FighterSweep), 
		aircraft_task(CAS), 
		aircraft_task(GroundAttack), 
		aircraft_task(AntishipStrike),
		aircraft_task(PinpointStrike)
	},
 	DefaultTask = aircraft_task(CAP), 
 
	SFM_Data = {
	aerodynamics = 
		{
			Cy0			=	0.0144,
			Mzalfa		=	2.2,
			Mzalfadt	=	1.2,
			kjx 		= 	1.3,
			kjz 		= 	1.2,
			Czbe 		= 	-0.2,
			cx_gear 	= 	0.0252,
			cx_flap 	= 	0.15,
			cy_flap 	= 	0.45,
			cx_brk 		= 	0.08,
			table_data 	=
			{
			--      M	 Cx0		 Cya		 B		     B4	      Omxmax	Aldop	Cymax
				{0.0,	0.0117,		0.085,		0,		0.032,		0.65,	30.0,	1.257	},
				{0.2,	0.0124,		0.085,		0,		0.032,		2.95,	24.0,	1.447	},
				{0.4,	0.0131,		0.085,		0,	   	0.032,		3.25,	24.0,	1.533	},
				{0.6,	0.0139,		0.087,		0,		0.043,		2.55,	20.0,	1.612	},
				{0.7,	0.0145,		0.087,		0,		0.045,		1.75,	15.0,	1.314	},
				{0.8,	0.0154,		0.087,		0,		0.048,		1.55,	8.0,	1.217 	},
				{0.9,	0.0183,		0.091,		0,		0.050,		1.55,	3.0,	1.101 	},
				{1.0,	0.0321,		0.094,		0,		0.1,		3.55,	1.0,	1.401 	},
				{1.1,	0.0432,		0.094,	   	0,		0.1,		2.10,	0.0,	1.5		},
				{1.2,	0.0435,		0.091,	   	0,		0.1,		2.19,	0.0,	1.5		},		
				{1.3,	0.0437,		0.085,	   	0,		0.096,		2.28,	0.0,	1.5		},					
				{1.5,	0.0433,		0.078,	   	0,		0.09,		1.95,	0.0,	1.5		},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine = 
		{
			Nmg	    =	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			typeng	=	0,
			hMaxEng	=	20,
			dcx_eng	=	0.037, -- 0.0124,
			cemax	=	0.037,
			cefor	=	1.2,
			dpdh_m	=	2250,
			dpdh_f	=	4000,

			table_data = {
					{0.0,	78920},
					{0.2,	76020},
					{0.4,	173480},
					{0.6,	74620},
					{0.7,	76430},
					{0.8,	77900},
					{0.9,	78920},
					{1.0,	79260},
					{1.3,	78260},
				}                 
		}, -- end of engine
	},
 
	Damage = {
		-- NOSE, COCKPIT & AVIONICS
		[0]	 = {critical_damage =  3, args = {82}},		
		[1]	 = {critical_damage =  8, args = {150}},	
		[2]	 = {critical_damage =  8, args = {149}},	
		[3]	 = {critical_damage =  2, args = {65}},		
		[4]	 = {critical_damage =  8, args = {298}},	
		[5]	 = {critical_damage =  8, args = {299}},	
		[90] = {critical_damage =  5},					
		[86] = {critical_damage =  8, args = {300}},	
		[87] = {critical_damage =  8, args = {301}},	
		[88] = {critical_damage =  8, args = {302}},	

		-- CONTROL SURFACES
		[53] = {critical_damage =  5, args = {248}},	
		[25] = {critical_damage =  5, args = {226}},	
		[51] = {critical_damage =  5, args = {240}},	
		[52] = {critical_damage =  5, args = {238}},	
		[26] = {critical_damage =  5, args = {216}},	
		[21] = {critical_damage =  5, args = {232}},	
		[33] = {critical_damage =  5, args = {230}},	
		[22] = {critical_damage =  5, args = {222}},	
		[34] = {critical_damage =  5, args = {220}},	
		[19] = {critical_damage =  5, args = {183}},	
		[20] = {critical_damage =  5, args = {185}},	

		-- ENGINE & FUEL TANKS
		[11] = {critical_damage = 10, args = {271}},	
		[61] = {critical_damage = 10, args = {224}},	
		[62] = {critical_damage = 10, args = {214}},	
		[65] = {critical_damage = 10, args = {155}},	

		-- FUSELAGE & WINGS
		[39] = {critical_damage = 10, args = {244}},								
		[41] = {critical_damage = 10, args = {245}, deps_cells = {39,53}},			
		[43] = {critical_damage = 10, args = {246}, deps_cells = {41,88}},			
		[23] = {critical_damage = 8,  args = {223}, deps_cells = {21}},				
		[29] = {critical_damage = 9,  args = {224}, deps_cells = {19,23,84}},	    
		[35] = {critical_damage = 10, args = {225}, deps_cells = {23,21,29,33,61,84}},	
		[36] = {critical_damage = 10, args = {215}, deps_cells = {24,22,30,34,62,85}},	
		[30] = {critical_damage = 9,  args = {214}, deps_cells = {20,24,85}},	    
		[24] = {critical_damage = 8,  args = {213}, deps_cells = {22}},				
		[9]	 = {critical_damage = 10, args = {154}},								
		[82] = {critical_damage = 10, args = {152}},								
		[10] = {critical_damage = 10, args = {153}},								
		[55] = {critical_damage = 10, args = {159}},								
		[56] = {critical_damage = 10, args = {158}},								
		[57] = {critical_damage = 10, args = {157}},								
		[58] = {critical_damage = 10, args = {156}},								

		-- LANDING GEAR
		[8]  = {critical_damage = 8, args = {265}, deps_cells = {83}},	
		[15] = {critical_damage = 8, args = {267}, deps_cells = {84}},	
		[16] = {critical_damage = 8, args = {266}, deps_cells = {85}},	
		[83] = {critical_damage = 3, args = {134}},						
		[84] = {critical_damage = 3, args = {135}},						
		[85] = {critical_damage = 3, args = {136}},						

		-- WEAPONS
		[7]  = {critical_damage = 5, args = {296}},						
	},

	DamageParts =
	{
	},

	effects_presets = {
		{effect = "APU_STARTUP_BLAST", preset = "F18", ttl = 3.0},
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/A-6E_overwingVapor.lua"},
	},
	
	lights_data = {
		typename = "collection",
		lights = {
			[WOLALIGHT_TAXI_LIGHTS] = { typename = "collection", -- form lights aft
				lights = {
					{typename = "argumentlight",argument = 51, value = 0.5}, -- form front
					-- {typename = "spotlight",argument = 209, dir_correction = {elevation = math.rad(-1)}}, -- form aft
					{typename = "argumentlight",argument = 83,period = 2.0,phase_shift = 0.0},
					-- {typename = "natostrobelight",connector = "BOTTOM_BEACON",argument_1 = 802,period = 2.0,color = {1.0, 0.0, 0.0},phase_shift = 0.0},
				},
			},
			[3] = { typename = "collection", -- left nav light
				lights = {
					{typename = "argumentlight",argument = 190}, -- wing nav light
					-- {typename = "omnilight",argument = 191}, -- tail nav light white
					{typename = "argumentlight",argument = 192}, -- tail nav light 
				},
			},
			[WOLALIGHT_SPOTS] = { typename = "collection", -- form lights aft
				lights = {
					{typename = "argumentlight",argument = 51}, -- form front
					-- {typename = "spotlight",argument = 209, dir_correction = {elevation = math.rad(-1)}}, -- form aft
					-- {typename = "argumentlight",argument = 83,period = 2.0,phase_shift = 0.0},
					-- {typename = "natostrobelight",connector = "BOTTOM_BEACON",argument_1 = 802,period = 2.0,color = {1.0, 0.0, 0.0},phase_shift = 0.0},
				},
			},
			--[4] = { typename = "collection", -- tail nav light
			--	lights = {
			--		-- {typename = "argumentlight",argument = 200}, -- FORMATION LIGHTS
			--		-- {typename = "argumentlight",argument = 201}, -- FORMATION LIGHTS
			--	},
			--},
		}
	}, -- end lights_data
}

add_aircraft(A_6e)


---- set self defined weapons

-- AERO 1D 300 Gal fuel tanks
local function Aero_1d_fuel_tank(clsid)
	local data = {
		category	= CAT_FUEL_TANKS,
		CLSID		= clsid,
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "AERO-1D.png",
		displayName	= _("AERO-1D Fuel Tank 300 gallons"),
		Weight_Empty	= 88,			-- empty weight with 1 fin(use for A-6): 193.5 lb
		Weight			= 1013,			-- 300 gallons, 6.8 lb/gal  use JP-5 fuel full weight = 2233.5 lb
		Cx_pil			= 0.0016,		
		shape_table_data = 
		{
			{
				name	= "AERO_1D";
				file	= "AERO_1D";
				life	= 1;
				fire	= { 0, 1};
				username	= "AERO_1D";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "AERO_1D",
			}, 
		}, 
	}
	declare_loadout(data)
end

Aero_1d_fuel_tank("{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}") -- assign a uuid for it to prevent problem