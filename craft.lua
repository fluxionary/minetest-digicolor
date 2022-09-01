minetest.register_craft({
	output = "digicolor:node",
	recipe = {
		{"group:color_white", "digilines:lcd", "group:color_black"},
		{"group:color_red", "group:color_green", "group:color_blue"},
		{"group:color_yellow", "group:color_cyan", "group:color_magenta"},
	}
})
