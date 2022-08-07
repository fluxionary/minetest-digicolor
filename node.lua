local S = digicolor.S
local F = minetest.formspec_escape
local FS = digicolor.FS

minetest.register_node("digicolor:node", {
	description = "programmable color node",
	paramtype2 = "color",
	palette = "digicolor_palette.png",

	tiles = {"[combine:1x1^[noalpha^[colorize:#FFFFFF"},

	groups = {dig_immediate = 2},

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ("size[2,2]field[1,1;1,1;channel;%s;${channel}]"):format(FS("channel")))
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
