local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Hyprland = astal.require("AstalHyprland")
local bind = astal.bind

local function map(arr, func)
	local new_arr = {}
	for i, v in ipairs(arr) do
		new_arr[i] = func(v, i)
	end
	return new_arr
end
return function()
	local hypr = Hyprland.get_default()

	return Widget.Box({
		class_name = "Workspaces",
		bind(hypr, "workspaces"):as(function(wss)
			table.sort(wss, function(a, b)
				return a.id < b.id;
			end)
			return map(wss, function(ws)
				return Widget.Button({
					class_name = bind(hypr, "focused-workspace"):as(function(fw)
						return (fw == ws and "focused " or "")..(#ws.clients > 0 and "has-clients" or "")
					end);
					on_clicked = function()
						ws:focus()
					end,
					label = bind(ws, "name"):as(function(v)
						return v == "special:launcher" and "S" or v
					end),
				})
			end)
		end),
	})
end
