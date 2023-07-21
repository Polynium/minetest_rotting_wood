dofile(minetest.get_modpath("rotting_wood") .. "/nodes.lua")

local conversion_table = {
	["default:tree"]        = "rotting_wood:rotten_tree",
	["default:wood"]        = "rotting_wood:rotten_wood",
	["default:aspen_tree"]  = "rotting_wood:rotten_aspen_tree",
	["default:aspen_wood"]  = "rotting_wood:rotten_aspen_wood",
	["default:pine_tree"]   = "rotting_wood:rotten_pine_tree",
	["default:pine_wood"]   = "rotting_wood:rotten_pine_wood",
	["default:acacia_tree"] = "rotting_wood:rotten_acacia_tree",
	["default:acacia_wood"] = "rotting_wood:rotten_acacia_wood",
	["default:jungletree"]  = "rotting_wood:rotten_jungletree",
	["default:junglewood"]  = "rotting_wood:rotten_junglewood"
}

local function abm_action(pos)
	local meta = minetest.get_meta(pos)
	local rotting = meta:get_int("rotting")
	rotting = rotting + 5
	if rotting >= 300 then
		rotten_node = conversion_table[minetest.get_node(pos).name]
		minetest.set_node(pos, {name = rotten_node})
	else
		meta:set_int("rotting", rotting)
	end
end

local function lbm_action(pos)
	local meta = minetest.get_meta(pos)
	meta:set_int("rotting", 0)
end

minetest.register_lbm({
	label = "Set rotting metadata",
	name = "rotting_wood:set_rotting_metadata",
	nodenames = {
		"default:tree",
		"default:wood",
		"default:aspen_tree",
		"default:aspen_wood",
		"default:pine_tree",
		"default:pine_wood",
		"default:acacia_tree",
		"default:acacia_wood",
		"default:jungletree",
		"default:junglewood",
	},
	action = lbm_action
})

minetest.register_abm({
	label = "Wood rotting",
	nodenames = {
		"default:tree",
		"default:wood",
		"default:aspen_tree",
		"default:aspen_wood",
		"default:pine_tree",
		"default:pine_wood",
		"default:acacia_tree",
		"default:acacia_wood",
		"default:jungletree",
		"default:junglewood",
	},
	neighbors = {
		"default:water_source",
		"default:river_water_source"
	},
	interval = 5,
	chance = 1,
	action = abm_action
})
