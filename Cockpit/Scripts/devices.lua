local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID----------
devices = {}
devices["ELECTRIC_SYSTEM"]			= counter()
devices["HYDRAULIC_SYSTEM"]         = counter()
devices["ENGINE"]         			= counter()
devices["PRISURFACE"]         		= counter()
devices["CANOPY"]         			= counter()
devices["GEAR_SYSTEM"]         		= counter()
devices["SLAT_SYSTEM"]				= counter()
devices["BREAK_SYSTEM"]				= counter()
devices["WEAPON_SYSTEM"]			= counter()
devices["FLAP_SYSTEM"]				= counter()
devices["UHF_RADIO"]				= counter()
devices["INTERCOM"]					= counter()
devices["RADAR_RAW"]				= counter()
devices["HUD_DCMS"]					= counter()
devices["BASIC_FLIGHT_INS"]			= counter()
devices["CLOCK"]					= counter()
devices["FUEL_SYSTEM"] 				= counter()
devices["VDI_DCMS"]					= counter()
devices["LIGHT_SYSTEM"]				= counter()