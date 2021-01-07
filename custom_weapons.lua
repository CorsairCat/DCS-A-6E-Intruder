dofile("Scripts/Database/Weapons/warheads.lua")
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

-- currently using a4
    -- Mk 11 mod 5 gun used in Mk 4 mod 0 gun pod
    function Mk11mod0(tbl)
        tbl.category = CAT_GUN_MOUNT
        tbl.name      = "Mk11mod0"
        tbl.supply      =
        {
            shells = {"20x110mm HE-I", "20x110mm AP-I", "20x110mm AP-T"},
            mixes  = {{1,2,1,3}},   -- 50% HE-i, 25% AP-I, 25% AP-T
            count  = 750,
        }
        if tbl.mixes then
           tbl.supply.mixes = tbl.mixes
           tbl.mixes        = nil
        end
        tbl.gun =
        {
            max_burst_length    = 2,
            rates               = {4200},
            recoil_coeff        = 0.7*1.3,
            barrels_count       = 2,
        }
        if tbl.rates then
           tbl.gun.rates        =  tbl.rates
           tbl.rates            = nil
        end
        tbl.ejector_pos             = tbl.ejector_pos or {0, 0, 0}
        tbl.ejector_pos_connector   = tbl.ejector_pos_connector     or  "Gun_point"
        tbl.ejector_dir             = {-1, -6, 0} -- left/right; back/front;?/?
        tbl.supply_position         = tbl.supply_position   or {0,  0.3, -0.3}
        tbl.aft_gun_mount           = false
        tbl.effective_fire_distance = 1500
        tbl.drop_cartridge          = 204
        tbl.muzzle_pos              = tbl.muzzle_pos            or  {2.5,-0.4,0}     -- all position from connector
        tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
        tbl.azimuth_initial         = tbl.azimuth_initial       or  0
        tbl.elevation_initial       = tbl.elevation_initial     or  0
        if  tbl.effects == nil then
            tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
                           { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
                           { name = "SmokeEffect"}}
        end
        return declare_weapon(tbl)
    end

TestA6Gun = {
    category        = CAT_PODS,
    CLSID           = "{ac94375e-aa45-491e-858b-a8b93ee8b959}",
    attribute       = {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Shell,wsType_Shell,WSTYPE_PLACEHOLDER},
    Picture         = "SPPU22.png",
    displayName     = _("Test Gun pod"),
    Weight          = 312.35,
    Cx_pil          = 0.001220703125,
    Elements        = {{ShapeName = "SPPU-22"}},
    kind_of_shipping = 2,   -- SOLID_MUNITION
    gun_mounts      = {
        Mk11mod0({
            muzzle_pos = {0.189,-0.315,0.0} ,
            rates = {4200}, mixes = {{1,2,1,3}},
            effect_arg_number = 1050,
            azimuth_initial = 0,
            elevation_initial = 0,
            supply_position = {2, -0.3, -0.4}})
    },
    shape_table_data = {{file = 'test_gun_pod'; username = 'SPPU-22'; index = WSTYPE_PLACEHOLDER;}}
}

declare_loadout(TestA6Gun)