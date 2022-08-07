local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)
local F = minetest.formspec_escape

digicolor = {
	version = os.time({year = 2022, month = 8, day = 7}),

	modname = modname,
	modpath = modpath,
	S = S,
	FS = function(...) return F(S(...)) end,

	has = {
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

digicolor.dofile("node")
