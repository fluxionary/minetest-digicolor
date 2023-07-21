local f = string.format

local S = digicolor.S
local FS = digicolor.FS

local function set_formspec(pos)
	local meta = minetest.get_meta(pos)
	local fs_parts = {
		"formspec_version[6]",
		"size[2,2.5]",
		f("field[0,0.5;2,1;channel;%s;${channel}]", FS("channel")),
		"button_exit[0.5,1.5;1,1;save;save]",
	}
	meta:set_string("formspec", table.concat(fs_parts, ""))
end

minetest.register_node("digicolor:node", {
	description = S("programmable color node"),
	paramtype2 = S("color"),
	palette = "digicolor_palette.png",

	tiles = { "[combine:1x1^[noalpha^[colorize:#FFFFFF" },

	groups = { dig_immediate = 2 },

	on_construct = function(pos)
		set_formspec(pos)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not minetest.is_player(sender) then
			return
		end

		local player_name = sender:get_player_name()

		if minetest.is_protected(pos, player_name) then
			return
		end

		if fields.channel then
			local meta = minetest.get_meta(pos)
			meta:set_string("channel", fields.channel)
		end
	end,
	digiline = {
		receptor = {},
		effector = {
			action = function(pos, node, channel, msg)
				local meta = minetest.get_meta(pos)

				if meta:get("channel") ~= channel then
					return
				end

				if msg == "GET" then
					digilines.receptor_send(pos, digilines.rules.default, channel, node.param2)
				else
					local param2 = tonumber(msg)
					if param2 then
						node.param2 = param2
						minetest.swap_node(pos, node)
					end
				end
			end,
		},
	},
})

minetest.register_lbm({
	name = "digicolor:update_formspec",
	description = S("update node formspec"),
	nodenames = { "digicolor:node" },
	run_at_every_load = false,
	action = function(pos)
		set_formspec(pos)
	end,
})
