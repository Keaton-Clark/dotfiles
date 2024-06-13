{pkgs, config, lib, ...}: {
config = lib.mkIf pkgs.stdenv.isLinux {
  services.xserver.windowManager = {
    i3 = { enable = config.services.xserver.enable; };
  };
  home-manager.users.${config.user}.xsession = let
    c0 = "#282828";
    c1 = "#cc241d";
    c2 = "#98971a";
    c3 = "#d7991a";
    c8 = "#928374";
    c15 = "#ebdbb2";
  in {
    enable = true;
    initExtra = ''
      systemctl --user import-environment
    '';
    windowManager.i3 = {
      enable = true;
      config = {
        startup = [
          { command = "systemctl --user import-environment"; }
          { command = "${pkgs.feh}/bin/feh --bg-scale ~/Wallpapers/Tranquility.png"; always = true; notification = false; }
          #{ command = "systemctl --user restart polybar"; always = true; notification = false; }
          #{ command = "${home-script}/bin/home-script screen_rotation"; always = false; notification = false; }
        ];
        terminal = "kitty";
        workspaceAutoBackAndForth = true;
        window = {
          titlebar = false;
        };
        bars = [];
        assigns = {
        };
        colors = {
          focused = {
            background = c2;
            border = c2;
            childBorder = c2;
            indicator = c0;
            text = c0;
          };
          unfocused = {
            background = c0;
            border = c0;
            childBorder = c0;
            indicator = c0;
            text = c15;
          };
          focusedInactive = {
            background = c0;
            border = c0;
            childBorder = c0;
            indicator = c0;
            text = c15;
          };
          urgent = {
            background = c1;
            border = c1;
            childBorder = c1;
            indicator = c0;
            text = c0;
          };
        };
        gaps = {
          #inner = 10;
          #smartBorders = "on";
        };
        keybindings = let
          modifier = config.home-manager.users.${config.user}.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+1" = "workspace 一";
          "${modifier}+2" = "workspace 二";
          "${modifier}+3" = "workspace 三";
          "${modifier}+4" = "workspace 四";
          "${modifier}+5" = "workspace 五";
          "${modifier}+6" = "workspace 六";
          "${modifier}+7" = "workspace 七";
          "${modifier}+8" = "workspace 八";
          "${modifier}+9" = "workspace 九";
          "${modifier}+0" = "workspace 十";

          "${modifier}+Shift+1" = "move container to workspace 一";
          "${modifier}+Shift+2" = "move container to workspace 二";
          "${modifier}+Shift+3" = "move container to workspace 三";
          "${modifier}+Shift+4" = "move container to workspace 四";
          "${modifier}+Shift+5" = "move container to workspace 五";
          "${modifier}+Shift+6" = "move container to workspace 六";
          "${modifier}+Shift+7" = "move container to workspace 七";
          "${modifier}+Shift+8" = "move container to workspace 八";
          "${modifier}+Shift+9" = "move container to workspace 九";
          "${modifier}+Shift+0" = "move container to workspace 十";

          "${modifier}+Return"  =   "exec ${pkgs.kitty}/bin/kitty";
          "${modifier}+f"   =   "exec ${pkgs.kitty}/bin/kitty -e ${pkgs.lf}/bin/lf";
          "${modifier}+x"   = "kill";
          "${modifier}+p"   = "exec ${pkgs.rofi-menugen}/bin/rofi-menugen $(which home-script)";
        };
      };
    };
  };
};}
