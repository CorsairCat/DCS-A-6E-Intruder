## local sensor_data = get_base_data()

elements["PNT-10"]			
= { 
    class = {class_type.BTN},
    hint = "",
    device = devices.AVIONICS,
    action = {device_commands.Button_10},
    stop_action = {device_commands.Button_19},
    arg = {25},
    arg_value = {1.0}, 
    arg_lim = {{0.0, 1.0}}, 
    use_release_message = {true} }

getAngleOfAttack
getAngleOfSlide
getBarometricAltitude
getCanopyPos
getCanopyState
getEngineLeftFuelConsumption
getEngineLeftRPM
getEngineLeftTemperatureBeforeTurbine
getEngineRightFuelConsumption
getEngineRightRPM
getEngineRightTemperatureBeforeTurbine
getFlapsPos
getFlapsRetracted
getHeading
getHelicopterCollective
getHelicopterCorrection
getHorizontalAcceleration
getIndicatedAirSpeed
getLandingGearHandlePos
getLateralAcceleration
getLeftMainLandingGearDown
getLeftMainLandingGearUp
getMachNumber
getMagneticHeading
getNoseLandingGearDown
getNoseLandingGearUp
getPitch
getRadarAltitude
getRateOfPitch
getRateOfRoll
getRateOfYaw
getRightMainLandingGearDown
getRightMainLandingGearUp
getRoll
getRudderPosition
getSpeedBrakePos
getStickPitchPosition
getStickRollPosition
getThrottleLeftPosition
getThrottleRightPosition
getTotalFuelWeight
getTrueAirSpeed
getVerticalAcceleration
getVerticalVelocity
getWOW_LeftMainLandingGear
getWOW_NoseLandingGear
getWOW_RightMainLandingGear

Data_Raw = get_base_data()
local self_loc_x , own_alt, self_loc_y = Data_Raw.getSelfCoordinates()

WS_GUN_PIPER_SPAN:0.015000
WS_DLZ_MAX:-1.000000
WS_IR_MISSILE_TARGET_ELEVATION:0.000000
WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION:0.00000
 WS_GUN_PIPER_AVAILABLE:0.000000
 WS_GUN_PIPER_AZIMUTH:0.000000
 WS_GUN_PIPER_ELEVATION:0.000000
 WS_TARGET_RANGE:1000.000000
 WS_TARGET_SPAN:15.000000
 WS_ROCKET_PIPER_AVAILABLE:0.000000
 WS_ROCKET_PIPER_AZIMUTH:0.000000
 WS_ROCKET_PIPER_ELEVATION:0.000000
 WS_DLZ_MIN:-1.000000
 WS_IR_MISSILE_LOCK:0.000000
 WS_IR_MISSILE_TARGET_AZIMUTH:0.000000
 WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH:0.000000