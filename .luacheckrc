std = "lua51+luajit+minetest+digicolor"
unused_args = false
max_line_length = 120

stds.minetest = {
	read_globals = {
		"DIR_DELIM",
		"minetest",
		"core",
		"dump",
		"vector",
		"nodeupdate",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		"default",
		"table",
		"math",
		"string",
	}
}

stds.digicolor = {
	globals = {
		"digicolor",
	},
	read_globals = {
		"minetest",
		"digilines",
	},
}
