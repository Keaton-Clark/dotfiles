local App = require("astal.gtk3.app")
local Bar = require("widget.Bar")
local astal = require("astal")

local scss = "./style/Bar.scss";
local css = "/tmp/Bar.css";

astal.exec(string.format("sass %s %s", scss, css))

local app = {
    main = function()
        Bar(0)
    end,
    css = css
}



App:start(app);
