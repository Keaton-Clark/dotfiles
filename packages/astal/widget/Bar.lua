local Widget = require("astal.gtk3.widget")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local astal = require("astal")
local Gdk = astal.require("Gdk", "3.0")
local GLib = astal.require("GLib")
local Variable = astal.Variable
local bind = astal.bind
local Workspaces = require("widget.Workspaces")
local BatteryLevel = require("widget.Battery")
local Network = require("widget.Network")



local Left = Widget.Box({
	halign = "START",
	hexpand = true,
	class_name = "Left",
	Widget.Box({
	})
})
local Center = Widget.Box({
	halign = "CENTER",
	Workspaces(),
})

local function Time(format)
	local time = Variable(""):poll(1000, function()
		return GLib.DateTime.new_now_local():format(format)
	end)

	return Widget.Box({
		class_name = "Time",
		Widget.Label({
			on_destroy = function()
				time:drop()
			end,
			label = time(),
		})
	})
end

local Right = Widget.CenterBox({
	halign = "END",
	hexpand = true,
	class_name = "Right",
	Widget.Box({
		BatteryLevel(),
		Network(),
		Time("%H:%M"),
	})
})


return function(monitor)
	return Widget.Window({
		monitor = monitor,
		anchor = Anchor.TOP,
		exclusivity = "EXCLUSIVE",
		Widget.CenterBox({
			class_name = "Bar",
			Left,
			Center,
			Right,
		})
	})
end
