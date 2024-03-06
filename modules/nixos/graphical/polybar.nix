{ pkgs, config, ...}:
{
home-manager.users.${config.user}.services.polybar = let 
  c0 = "#282828";
  c1 = "#cc241d";
  c2 = "#98971a";
  c3 = "#d7991a";
  c8 = "#928374";
  c15 = "#ebdbb2";
in {
  enable = true;
  package = pkgs.polybar.override {
    i3Support = true;
    alsaSupport = true;
    mpdSupport = true;
  };
  script = ''
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
          MONITOR=$m polybar --reload top &
      done
    else
      polybar --reload top &
    fi
  '';
  config = {
    "bar/top" = {
      fixed-center = "true";
      override-redirect = "true";
      width = "100%:-20";
      height = "40";
      offset-x = "10";
      offset-y = "10";
      background = c0;
      foreground = c8;
      line-size = "2";
      line-color = c1;
      border-bottom-size = "2";
      border-bottom-color = c1;
      padding = "0";
      module-margin-left = "1";
      module-margin-right = "1";
      font-0 = "\"JetBrainsMono NF:style=Regular:size=12\"";
      font-1 = "\"JetBrainsMono NF:style=Regular:size=18;5\"";
      font-2 = "\"JetBrainsMono NF:style=Regular:size=12;4\"";
      font-3 = "\"JetBrainsMono NF:style=Regular:size=6;4\"";
      font-4 = "\"JetBrainsMono NF:style=Regular:size=8;8\"";
      monitor = "\${env:MONITOR:}";
      radius = "0";
      modules-left = "apps workspaces";
      modules-center = "mpd";
      modules-right = "network audio battery date menu";
      separator = "|";
      separator-font = 3;
      dim-value = "1.0";
      tray-position = "none";
      tray-detached = "false";
      tray-maxsize = "16";
      tray-background = c0;
      tray-offset-x = "0";
      tray-offset-y = "0";
      tray-padding = "0";
      tray-scale = "1.0";
      enable-ipc = true;
      click-left = "";
      click-middle = "";
      click-right = "";
      scroll-up = "";
      scroll-down = "";
      double-click-middle = "";
      double-click-left = "";
      double-click-right = "";
      cursor-click = "";
      cursor-scroll = "";
    };
    "module/network" = {
      type = "internal/network";
      interface-type = "wireless";
      format-connected = "<ramp-signal> <label-connected>";
      format-connected-font = 3;
      format-disconnected = "<label-disconnected>";
      format-disconnected-font = 3;
      format-packetloss = "󰤫 <label-packetloss>";
      format-packetloss-font = 3;
      label-packetloss = "%essid%";
      label-connected = "%essid%";
      label-disconnected = "";
      ramp-signal-0 = "󰤯";
      ramp-signal-1 = "󰤟";
      ramp-signal-2 = "󰤢";
      ramp-signal-3 = "󰤥";
      ramp-signal-4 = "󰤨";
    };
    "module/mpd" = {
      type = "internal/mpd";
      format-online = "󰝚 <label-song> <icon-prev> <toggle> <icon-next>";
      format-online-font = 3;
      icon-play = "󰐊";
      icon-pause = "󰏤";
      icon-stop = "";
      icon-next = "󰒬";
      icon-prev = "󰒫";
    };
    "module/date" = {
      type = "internal/date";
      internal = 5;
      date = "%y-%m-%d";
      time = "%H:%M";
      label = "󰥔 %time%";
      label-font = 3;
    };
    "module/keyboard" = {
      type = "custom/text";
      click-left = "${pkgs.onboard}/bin/onboard";
      content = "󰌓";
      content-font = 2;
    };
    "module/workspaces" = {
      format-font = 2;
      type = "internal/xworkspaces";
      icon-0 = "1;";
      icon-1 = "2;󰖟";
      icon-2 = "3;󰽉";
      icon-3 = "4;󰙯";
      icon-4 = "5;󰇞";
      icon-5 = "6;󰇞";
      icon-6 = "7;󰎅";
      icon-7 = "8;󰇞";
      icon-8 = "9;";
      icon-9 = "10;󰎅";
      icon-default = "";
      format-padding = "10px";
      pin-workspaces = "true";

      label-active = "%{T5} %name%.%{T2}%icon% ";
      label-active-overline = c1;
      label-active-foreground = c1;

      label-occupied = "%{T5} %name%.%{T2}%icon% ";

      label-urgent = "%{T5} %name%.%{T2}%icon% ";
      label-urgent-overline = c3;
      label-urgent-foreground = c3;

      label-empty = "%{T5} %name%.%{T2}%icon% ";
    };
    "module/apps" = {
      type = "custom/text";
      click-left = "${pkgs.rofi}/bin/rofi -show drun";
      content-background = c1;
      content-foreground = c15;
      content-padding = "1";
      content = "󰀻";
      content-font = "2";
    };
    "module/menu" = {
      type = "custom/text";
      click-left = "${pkgs.rofi-menugen}/bin/rofi-menugen $(which home-script)";
      content-background = c1;
      content-foreground = c15;
      content-padding = "1";
      content = "󰍜";
      content-font = "2";
    };
    "module/battery" = {
      type = "internal/battery";
      format-charging = "<animation-charging> <label-charging>";
      format-charging-font = 3;
      format-discharging = "<ramp-capacity> <label-discharging>";
      format-discharging-font = 3;
      format-full = "󰁹 <label-full>";
      format-full-font = 3;
      animation-charging-0 = "󰢟";
      animation-charging-1 = "󰢜";
      animation-charging-2 = "󰂆";
      animation-charging-3 = "󰂇";
      animation-charging-4 = "󰂈";
      animation-charging-5 = "󰢝";
      animation-charging-6 = "󰂉";
      animation-charging-7 = "󰢞";
      animation-charging-8 = "󰂊";
      animation-charging-9 = "󰂋";
      animation-charging-10 = "󰂅";
      ramp-capacity-0 = "󰂎";
      ramp-capacity-1 = "󰁺";
      ramp-capacity-2 = "󰁻";
      ramp-capacity-3 = "󰁼";
      ramp-capacity-4 = "󰁽";
      ramp-capacity-5 = "󰁾";
      ramp-capacity-6 = "󰁿";
      ramp-capacity-7 = "󰂀";
      ramp-capacity-8 = "󰂁";
      ramp-capacity-9 = "󰂂";
      ramp-capacity-10 = "󰁹";
    };
    "module/audio" = {
      type = "internal/alsa";
      format-volume = "<ramp-volume> <label-volume>";
      ramp-volume-0 = "󰕿";
      ramp-volume-1 = "󰖀";
      ramp-volume-2 = "󰕾";
      bar-volume-indicator = "󰚉";
      bar-volume-fill = "󰚉";
      bar-volume-empty = "󰚉";
      bar-volume-width = 7;
      bar-volume-gradient = "true";
      bar-volume-foreground-0 = c2;
      bar-volume-foreground-1 = c3;
      bar-volume-foreground-2 = c1;
      format-volume-font = 3;
      format-muted = "󰝟 <label-volume>";
      format-muted-font = 3;
      #click-middle = "CURRENTMENU=audio ${pkgs.rofi-menugen}/bin/rofi-menugen ${home-script}/bin/home-script";
    };
    "settings" = {
      screenchange-reload = "true";
    };
    "module/cpu" = {
      type = "internal/cpu";
      format = " <bar-load>";
      format-font = 3;
      bar-load-gradient = "true";
      bar-load-indicator = "󰚉";
      bar-load-fill = "󰚉";
      bar-load-empty = "󰚉";
      bar-load-foreground-0 = c2;
      bar-load-foreground-1 = c3;
      bar-load-foreground-2 = c1;
      bar-load-width = 7;
    };
    "module/memory" = {
      type = "internal/memory";
      format = " <bar-used>";
      format-font = 3;
      bar-used-indicator = "󱋱";
      bar-used-fill = "󱋱";
      bar-used-empty = "󱋱";
      bar-used-foreground-0 = c1;
      bar-used-width = 20;
    };
  };
};
}
