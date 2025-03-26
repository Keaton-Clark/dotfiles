local Widget = require("astal.gtk3.widget")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local Battery = require("lgi").require("AstalBattery")
local astal = require("astal")
local Gdk = astal.require("Gdk", "3.0")
local GLib = astal.require("GLib")
local Variable = astal.Variable
local bind = astal.bind
local Workspaces = require("widget.Workspaces")



local Left = Widget.Box({
	halign = "START",
	Workspaces(),
})
local Center = Widget.Box({
	halign = "CENTER",
	Widget.Label({
	})
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

local function BatteryLevel()
	local bat = Battery.get_default()

	return Widget.Box({
		class_name = "Battery",
		visible = bind(bat, "is-present"),
		Widget.Icon({
			icon = bind(bat, "battery-icon-name"),
		}),
		Widget.Label({
			label = bind(bat, "percentage"):as(function(p)
				return tostring(math.floor(p * 100)) .. "%"
			end),
		}),
	})
end

local Right = Widget.CenterBox({
	halign = "END",
	hexpand = true,
	class_name = "Right",
	BatteryLevel(),
	Time("%H:%M")
})


return function(monitor)
	return Widget.Window({
		monitor = monitor,
		anchor = Anchor.TOP + Anchor.LEFT + Anchor.RIGHT,
		exclusivity = "EXCLUSIVE",
		Widget.CenterBox({
			class_name = "Bar",
			Left,
			Center,
			Right,
		})
	})
end
