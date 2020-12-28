start_custom_command   = 6000
local __count_custom = start_custom_command-1
local function __custom_counter()
	__count_custom = __count_custom + 1
	return __count_custom
end


Keys =
{
	PlanePickleOn	= 350,
	PlanePickleOff	= 351,
    PlaneChgWeapon  = 101,
    PlaneChgTargetNext = 102,    -- iCommandPlaneChangeTarget
    PlaneModeNAV    = 105,
    PlaneModeBVR    = 106,
    PlaneModeVS     = 107,
    PlaneModeBore   = 108,
    PlaneModeGround = 111,

	Canopy = 71,
	
	PlaneAirBrake = 73,		
	PlaneAirBrakeOn = 147,
	PlaneAirBrakeOff = 148,	
	
	PlaneFlaps = 72,
	PlaneFlapsOn = 145, -- Fully down
	PlaneFlapsOff = 146, -- Fully up
    	
	PlaneGear = 68,						-- Шасси
	PlaneGearUp	= 430,
	PlaneGearDown = 431,
    
	--LeftEngineStart = 311,			
	--RightEngineStart = 312,			
	--LeftEngineStop = 313,			
	--RightEngineStop = 314,			

	PowerOnOff = 315,

    --[[   -- Do not use the built-in altimeter adjustments, they have internal SSM affects on the altimeter that we cannot limit
    AltimeterPressureIncrease = 316,  
    AltimeterPressureDecrease = 317,
    AltimeterPressureStop = 318,        ]]--

    PlaneLightsOnOff = 175,
    PlaneHeadlightOnOff = 328,

    PowerGeneratorLeft = 711,
    PowerGeneratorRight = 712,

    BatteryPower = 1073,        -- iCommandBatteryPower

    PlaneChgTargetPrev = 1315,   -- iCommandPlaneUFC_STEER_DOWN

    -- 自定义按键从这里开始，可以自动从10000开始增加，避免冲突 --
    ThrottleAxisTest = __custom_counter(),  --油门位置
    EnginesStart = __custom_counter(), --自定义引擎启动输入
    EnginesStop = __custom_counter(), --自定义引擎关闭输入
    EnginesStartStop = __custom_counter(), --自定义引擎开关按下
    EnginesStartStopUp = __custom_counter(), --自定义引擎开关松开

    BrakesOn = __custom_counter(), --自定义刹车
    BrakesOff = __custom_counter(), --自定义刹车关闭

    DragParachute = __custom_counter(), --自定义减速伞释放

    --PlaneFlapsStop = __custom_counter(),      --目前屏蔽手动缝翼
    --PlaneFlapsUpHotas = __custom_counter(),   --
    --PlaneFlapsDownHotas = __custom_counter(), --
    
    SpoilersArmToggle = __custom_counter(),
    SpoilersArmOn = __custom_counter(),
    SpoilersArmOff = __custom_counter(),
    PlaneFireOn		= __custom_counter(), -- replaces iCommandPlaneFire
    PlaneFireOff	= __custom_counter(), -- replaces iCommandPlaneFireOff
    PickleOn = __custom_counter(),  -- replaces iCommandPlanePickleOn
    PickleOff = __custom_counter(), -- replaces iCommandPlanePickleOff

    -- 武器测试用按键
    WeaponSelectNext = __custom_counter(),
    WeaponLaunch = __custom_counter(),

    -- 襟翼动作
    FlapUp = __custom_counter(),
    FlapDown = __custom_counter(),

    ParkingBrakesOn = __custom_counter(),
    ParkingBrakesOff = __custom_counter(),
    ParkingBrakes = __custom_counter(),

    LeftThrottleAxis = __custom_counter(),
    RightThrottleAxis = __custom_counter(),

    LeftEngineCrank = __custom_counter(),
    RightEngineCrank = __custom_counter(),

    LeftEngineCrankUP = __custom_counter(),
    RightEngineCrankUP = __custom_counter(),

    LeftSpeedDriveUP = __custom_counter(),
    RightSpeedDriveUP = __custom_counter(),

    LeftSpeedDriveDOWN = __custom_counter(),
    RightSpeedDriveDOWN = __custom_counter(),

    NWWSwitch = __custom_counter(),
    CSDSwitch = __custom_counter(),
    AirCondSwitch = __custom_counter(),
    BleedHoldCover = __custom_counter(),

    FuelMasterLeft = __custom_counter(),
    FuelMasterRight = __custom_counter(),

    PowerGeneratorLeftUP = __custom_counter(),
    PowerGeneratorLeftDOWN = __custom_counter(),

    PowerGeneratorRightUP = __custom_counter(),
    PowerGeneratorRightDOWN = __custom_counter(),

    LeftEngineIDLEPOS = __custom_counter(),
    RightEngineIDLEPOS = __custom_counter(),

    -- LeftEngineOFF = __custom_counter(),
    -- RightEngineOFF = __custom_counter(),

    FuelDisMain = __custom_counter(),
    FuelDisWing = __custom_counter(),
    FuelDisCtr = __custom_counter(),
    FuelDisLout = __custom_counter(),
    FuelDisLin = __custom_counter(),
    FuelDisRin = __custom_counter(),
    FuelDisRout = __custom_counter(),

    FuelTankPressUP = __custom_counter(),
    WingDropTankTransUP = __custom_counter(),
    FuelTankPressDOWN = __custom_counter(),
    WingDropTankTransDOWN = __custom_counter(),
    WingTankDump = __custom_counter(),
    FuseTankDump = __custom_counter(),
    FuelReadyUP = __custom_counter(),
    BoostPumpTestUP = __custom_counter(),
    FuelReadyDOWN = __custom_counter(),
    BoostPumpTestDOWN = __custom_counter(),

    LightStrobe = __custom_counter(),
    LightTaxi = __custom_counter(),
    LightNaviWingUP = __custom_counter(),
    LightNaviWingDOWN = __custom_counter(),
    LightNaviTailUP = __custom_counter(),
    LightNaviTailDOWN = __custom_counter(),
    LightFormationUP = __custom_counter(),
    LightFormationDOWN = __custom_counter(),
    LightFloodUP = __custom_counter(),
    LightFloodDOWN = __custom_counter(),

    LightConsoleBRT = __custom_counter(),
    LightInstruBRT = __custom_counter(),
    LightApproIndexBRT = __custom_counter(),

    AutoPilotPowerSwitch = __custom_counter(),
    AutoPilotStabSwitch = __custom_counter(),
    AutoPilotCmdSwitch = __custom_counter(),
    AutoPilotAltHoldSwitch = __custom_counter(),
    AutoPilotMachHoldSwitch = __custom_counter(),

    -- ECS aircondition
    AircondMasterSwitch = __custom_counter(),
    AircondAutoManSwitch = __custom_counter(),
    AircondCockpitSwitchUP = __custom_counter(),
    AircondCockpitSwitchDOWN = __custom_counter(),
    AircondCMPTREmerUP = __custom_counter(),
    AircondCMPTREmerDOWN = __custom_counter(),
    DeiceEngine = __custom_counter(),
    DeiceWindShieldUP = __custom_counter(),
    DeiceWindShieldDOWN = __custom_counter(),
    DeicePitot = __custom_counter(),
    AircondTemp = __custom_counter(),
    AircondDefog = __custom_counter(),

    -- UHF radio
    UHFMode = __custom_counter(),
    UHFFreqAUP = __custom_counter(),
    UHFFreqADOWN = __custom_counter(),
    UHFFreqBDOWN = __custom_counter(),
    UHFFreqBUP = __custom_counter(),
    UHFFreqCDOWN = __custom_counter(),
    UHFFreqCUP = __custom_counter(),
    UHFFreqASTOP = __custom_counter(),
    UHFFreqBSTOP = __custom_counter(),
    UHFFreqCSTOP = __custom_counter(),
    UHFGuard = __custom_counter(),
    UHFVolume = __custom_counter(),
}

--从5000开始递增点击指令
start_command   = 5000
local __count_click = start_command-1
local function __click_counter()
	__count_click = __count_click + 1
	return __count_click
end


click_cmd =
{
    GearLevel = __click_counter(), --起落架手柄
}